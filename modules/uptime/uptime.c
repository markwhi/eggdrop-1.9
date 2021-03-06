/* 
 * uptime.c --
 *
 *	This module reports uptime information about your bot to
 * 	http://uptime.eggheads.org. The purpose for this is to see how
 *	your bot rates against many others (including EnergyMechs and
 *	Eggdrops) -- It is a fun little project, jointly run by Eggheads.org
 *	and EnergyMech.net.
 *
 *	If you don't like being a part of it, simply don't load this module.
 *
 *	Also for bot developers feel free to modify this code to make it a
 *	part of your bot and e-mail webmaster@eggheads.org for more
 *	information on registering your bot type. See how your bot's
 *	stability rates against ours and ours against yours <g>.
 */
/*
 * Copyright (C) 2001 proton
 * Copyright (C) 2001, 2002, 2003, 2004 Eggheads Development Team
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

#ifndef lint
static const char rcsid[] = "$Id: uptime.c,v 1.14 2003/12/11 00:49:11 wcc Exp $";
#endif

#define MODULE_NAME "uptime"
#define MAKING_UPTIME
#include "uptime.h" 
#include "lib/eggdrop/module.h"
#include "modules/server/server.h"
#include <netdb.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>

#define start uptime_LTX_start

typedef struct PackUp
{
        int     regnr;
        int     pid;
        int     type;
        unsigned long   cookie;
        unsigned long   uptime;
        unsigned long   ontime;
        unsigned long   now2;
        unsigned long   sysup;
        char    string[3];

} PackUp;

PackUp upPack;

static Function *server_funcs = NULL;
static eggdrop_t *egg = NULL;

char *uptime_host = NULL;
int uptimeport = 9969;
int hours=0;
int uptimesock;
int uptimecount;
unsigned long uptimeip;
unsigned long uptimecookie;
time_t uptimelast;
char uptime_version[50]="";

static void uptime_report(int idx, int details)
{
}
	

unsigned long get_ip()
{
  struct hostent *hp;
  IP ip;  
  struct in_addr *in;
    
  /* could be pre-defined */
  if (uptime_host[0]) {
    if ((uptime_host[strlen(uptime_host) - 1] >= '0') && (uptime_host[strlen(uptime_host) - 1] <= '9'))
      return (IP) inet_addr(uptime_host);    
  }  
  hp = gethostbyname(uptime_host);
  if (hp == NULL)
    return -1;
  in = (struct in_addr *) (hp->h_addr_list[0]);
  ip = (IP) (in->s_addr);
  return ip;
}       

int init_uptime(void)
{
	struct  sockaddr_in sai;
	char temp[50]="";
	upPack.regnr = 0;
	upPack.pid = htonl(getpid());
	upPack.type = htonl(UPTIME_EGGDROP);
	upPack.cookie = 0;
	upPack.uptime = htonl(online_since);
	uptimecookie = rand();
	uptimecount = 0;
	uptimelast = 0;
	uptimeip = -1;


	strcpy(temp,ver);
	splitc(uptime_version,temp,' ');
	strcpy(uptime_version,temp);

	if ((uptimesock = socket(AF_INET,SOCK_DGRAM,0)) < 0) {
		putlog(LOG_DEBUG, "*", "init_uptime socket returned <0 %d",uptimesock);
		return((uptimesock = -1));
	}
	memset(&sai,0,sizeof(sai));
	sai.sin_addr.s_addr = INADDR_ANY;
	sai.sin_family = AF_INET;
	if (bind(uptimesock,(struct sockaddr*)&sai,sizeof(sai)) < 0) {
		close(uptimesock);
		return((uptimesock = -1));
	}
	fcntl(uptimesock,F_SETFL,O_NONBLOCK | fcntl(uptimesock,F_GETFL));
	return(0);
}


int send_uptime(void)
{
	struct  sockaddr_in sai;
	struct  stat st;
	PackUp  *mem;
	int     len;
	
	uptimecookie = (uptimecookie + 1) * 18457;
	upPack.cookie = htonl(uptimecookie);
	upPack.now2 = htonl(time(NULL));
	if (stat("/proc",&st) < 0)
		upPack.sysup = 0;
	else
		upPack.sysup = htonl(st.st_ctime);
	upPack.uptime = htonl(online_since);
	upPack.ontime = htonl(server_online);
	uptimecount++;
	if (((uptimecount & 0x7) == 0) || (uptimeip == -1)) {
		uptimeip = get_ip();
		if (uptimeip == -1)
			return -2;
	}
	len = sizeof(upPack) + strlen(myname) + strlen(dcc[servidx].host) + strlen(uptime_version);
	mem = (PackUp*)malloc(len);
	memcpy(mem,&upPack,sizeof(upPack));
	sprintf(mem->string,"%s %s %s",myname,dcc[servidx].host,uptime_version);
	memset(&sai,0,sizeof(sai));
	sai.sin_family = AF_INET;
	sai.sin_addr.s_addr = uptimeip;
	sai.sin_port = htons(uptimeport);
	len = sendto(uptimesock,(void*)mem,len,0,(struct sockaddr*)&sai,sizeof(sai));
	free(mem);
	return len;
}

void check_hourly() {
	hours++;
	if (hours==6) {
		send_uptime();
		hours=0;
	}
}

static int uptime_set_send(struct userrec *u, int idx, char *par)
{
	dprintf(idx,"Nick %s Ontime %lu Version %s Result %d\n", myname, online_since,
	        uptime_version, send_uptime()); 
	return 1;
}

static cmd_t mydcc[] =
    {
        {"usetsend", "", uptime_set_send, NULL},
        {0, 0, 0, 0}
    };

static tcl_strings mystrings[] =
    {
        {0, 0, 0, 0}
    };

static tcl_ints myints[] =
    {
        {0, 0}
    };

static char *uptime_close()
{
	rem_tcl_strings(mystrings);
	rem_tcl_ints(myints);
	rem_builtins("dcc", mydcc);
	free(uptime_host);
	close(uptimesock);
	del_hook(HOOK_HOURLY, (Function) check_hourly);
	module_undepend(MODULE_NAME);
	return NULL;
}

EXPORT_SCOPE char *start();

static Function uptime_table[] =
    {
        (Function) start,
        (Function) uptime_close,
        (Function) 0,
        (Function) uptime_report,
    };

char *start(eggdrop_t *eggdrop)
{
	egg = eggdrop;

	if (!module_depend(MODULE_NAME, "eggdrop", 107, 0)) {
		module_undepend(MODULE_NAME);
		return _("This module requires eggdrop1.7.0 or later");
	}              
	if (!(server_funcs = module_depend(MODULE_NAME, "server", 1, 0)))
		return _("You need the server module to use the uptime module.");
	module_register(MODULE_NAME, uptime_table, 1, 1);
	add_tcl_strings(mystrings);
	add_tcl_ints(myints);
	add_builtins("dcc", mydcc);
	add_hook(HOOK_HOURLY, (Function) check_hourly);
	uptime_host = strdup(UPTIME_HOST);
	init_uptime();
	return NULL;
}
