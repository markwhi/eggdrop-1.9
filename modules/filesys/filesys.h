/*
 * filesys.h --
 *
 *	header file for the filesys2 eggdrop module
 */
/*
 * Copyright (C) 1997 Robey Pointer
 * Copyright (C) 1999, 2000, 2001, 2002, 2003 Eggheads Development Team
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
/*
 * $Id: filesys.h,v 1.8 2003/02/15 09:24:57 wcc Exp $
 */

#ifndef _EGG_MOD_FILESYS_FILESYS_H
#define _EGG_MOD_FILESYS_FILESYS_H

#ifdef MAKING_FILESYS
static int too_many_filers();
static int welcome_to_files(int);
static void add_file(char *, char *, char *);
static void incr_file_gots(char *);
static FILE *filedb_open(char *, int);
static void filedb_close(FILE *);
static void filedb_add(FILE *, char *, char *);
static void filedb_ls(FILE *, int, char *, int);
static void filedb_getowner(char *, char *, char **);
static void filedb_setowner(char *, char *, char *);
static void filedb_getdesc(char *, char *, char **);
static void filedb_setdesc(char *, char *, char *);
static int filedb_getgots(char *, char *);
static void filedb_getfiles(Tcl_Interp *, char *);
static void filedb_getdirs(Tcl_Interp *, char *);
static void filedb_change(char *, char *);
static void my_tell_file_stats(int, char *);
static int do_dcc_send(int, char *, char *, char *, int);
static int files_reget(int, char *, char *, int);
static void files_setpwd(int, char *);
static int resolve_dir(char *, char *, char **, int);
static int fstat_unpack(struct userrec *, struct user_entry *);
static int fstat_pack(struct userrec *, struct user_entry *);
static int fstat_write_userfile(FILE *, struct userrec *, struct user_entry *);
static int fstat_set(struct userrec *, struct user_entry *, void *);
static int fstat_tcl_get(Tcl_Interp *, struct userrec *, struct user_entry *,
                         int, char **);
static int fstat_kill(struct user_entry *);
static void fstat_display(int, struct user_entry *);
static int fstat_gotshare(struct userrec *, struct user_entry *, char *, int);
static int fstat_dupuser(struct userrec *, struct userrec *,
                         struct user_entry *);
static void stats_add_dnload(struct userrec *, unsigned long);
static void stats_add_upload(struct userrec *, unsigned long);
static int fstat_tcl_set(Tcl_Interp *, struct userrec *, struct user_entry *,
                         int, char **);
static int is_valid();
static void eof_dcc_files(int);
static void dcc_files(int, char *, int);
static void disp_dcc_files(int, char *);
static void kill_dcc_files(int, void *);
static void out_dcc_files(int, char *, void *);
static char *mktempfile(char *);
static void wipe_tmp_filename(char *, int);

#else
#define H_fil (*(p_tcl_hash_list *)(filesys_funcs[8]))
#endif				/* MAKING_FILESYS */

#endif				/* !_EGG_MOD_FILESYS_FILESYS_H */
