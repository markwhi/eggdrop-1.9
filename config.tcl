#! /path/to/executable/eggdrop -ptclscript
# ^- This should contain a fully qualified path to your Eggdrop executable.
#  Make sure you preload a config parser using the -p<name> parameter.
#
# $Id: config.tcl,v 1.3 2003/02/15 05:04:57 wcc Exp $
#
# This is a sample Eggdrop configuration file which includes all possible
# settings that can be used to configure your bot.
#
# The pound signs (#) that you see at the beginning of some lines mean that
# the remainder of that line is a comment, or just for your information. By
# adding or deleting pound signs, you can comment or uncomment a setting,
# respectively.
#
# Arguments for a command or setting may be inclosed in <>'s or []'s in the
# example/description. Arguments in <>'s are required, while [] means optional.
#
# More detailed descriptions of all these settings can be found in
# doc/settings/.


##### BASIC SETTINGS #####

# This is used to identify the bot. You MUST set this.
set myname "LamestBot"

# This setting defines the username the bot uses on IRC. This setting has
# no effect if an ident daemon is running on your bot's machine.
set username "lamest"

# This setting defines which contact person should be shown in .status,
# /msg help, and other places. You really should include this information.
set admin "Lamer <email: lamer@lamest.lame.org>"

# This setting is used only for info to share with others on your botnet.
# Set this to the IRC network your bot is connected to.
set network "I.didnt.edit.my.config.file.net"

# These characters at the beginning of text signify a command on the partyline.
set dcc_command_chars "./"

# This setting defines the timezone is your bot in. It's used for internal
# routines as well as for logfile timestamping and scripting purposes.
# The timezone string specifies the name of the timezone and must be three
# or more alphabetic characters. For example, Central European Time(UTC+1)
# should be "CET".
set timezone "EST"

# The offset setting specifies the time value to be added to the local
# time to get Coordinated Universal Time (UTC aka GMT). The offset is
# positive if the local timezone is west of the Prime Meridian and
# negative if it is east. The value (in hours) must be between -23 and
# 23. For example, if the timezone is UTC+1, the offset is -1.
set offset "5"

# If you don't want to use the timezone setting for scripting purposes only,
# but instead everywhere possible, un-comment the following line.
#set env(TZ) "$timezone $offset"

# If you're using virtual hosting (your machine has more than 1 IP), you
# may want to specify the particular IP to bind to. my_ip will be used for
# IPv4 hosts, and my_ip6 will be used for IPv6 hosts.
#set my_ip "99.99.0.0"
#set my_ip6 "3ffe:1337::1"

##### LOG FILES #####

# Eggdrop is capable of logging various things, from channel chatter to
# commands people use on the bot and file transfers. Logfiles are normally
# kept for 24 hours. Afterwards, they will be renamed to "(logfile).yesterday".
# After 48 hours, they will be overwritten by the logfile of the next day.
#
# Events are logged by certain categories. This way, you can specify
# exactly what kind of events you want sent to various logfiles.
#
# Logfile flags:
#   b - information about bot linking and userfile sharing
#   c - commands
#   d - misc debug information
#   j - joins, parts, quits, and netsplits on the channel
#   k - kicks, bans, and mode changes on the channel
#   m - private msgs, notices and ctcps to the bot
#   o - misc info, errors, etc (IMPORTANT STUFF)
#   p - public text on the channel
#   r - raw incoming server traffic
#   s - server connects, disconnects, and notices
#   v - raw outgoing server traffic
#   w - wallops (make sure the bot sets +w in init-server)
#   x - file transfers and file-area commands
#
# Note that modes d, h, r, t, and v can fill disk quotas quickly. There are
# also eight user-defined levels (1-8) which can be used by Tcl scripts.
#
# Each logfile belongs to a certain channel. Events of type 'k', 'j', and 'p'
# are logged to whatever channel they happened on. Most other events are
# currently logged to every channel. You can make a logfile belong to all
# channels by assigning it to channel "*".

# This is the maximum size of your logfiles. Set it to 0 to disable.
# This value is in kilobytes, so '550' would mean cycle logs when it
# reaches the size of 550 kilobytes. Note that this only works if you
# have keep-all-logs 0 (OFF).
set max_logsize 0

# This could be good if you have had problem with the logfile filling
# your quota/hard disk or if you log +p and publish it to the web and
# need more up-to-date info. Note that this setting might increase the
# CPU usage of your bot (on the other hand it will decrease your mem usage).
set quick_logs 0

# This setting allows you the logging of raw incoming server traffic via
# console/log flag 'r', and raw outgoing server traffic via console/log mode
# 'v'. These flags can create a large security hole, allowing people to see
# user passwords. This is now restricted to +n users only. Please choose your
# owners with care.
set raw_log 0

# This creates a logfile named eggdrop.log containing private msgs/ctcps,
# commands, errors, and misc. info from any channel.
logfile mco * "logs/eggdrop.log"

# This creates a logfile named lamest.log containing joins, parts,
# netsplits, kicks, bans, mode changes, and public chat on the
# channel #lamest.
logfile jpk #lamest "logs/lamest.log"

# If you want to keep your logfiles forever, turn this setting on. All
# logfiles will get suffix ".[day, 2 digits][month, 3 letters][year, 4 digits]".
# Note that your quota/hard-disk might be filled by this, so check your logfiles
# often and download them.
set keep_all_logs 0

# If keep-all-logs is 1, this setting will define the suffix of the logfiles.
# The default will result in a suffix like "04May2000". "%Y%m%d" will produce
# the often used yyyymmdd format. Read the strftime manpages for more options.
# NOTE: On systems which don't support strftime, the default format will
# be used _always_.
set logfile_suffix ".%d%b%Y"

# You can specify when Eggdrop should switch logfiles and start fresh. You
# must use military time for this setting. 300 is the default, and describes
# 03:00 (AM).
set switch_logfiles_at 300


##### CONSOLE #####

# This is the default console mode. It uses the same event flags as the log
# files do. The console channel is automatically set to your "primary" channel,
# which is set in the modules section of the config file. Masters can change
# their console channel and modes with the '.console' command.

set console "mkcobxs"


##### FILES AND DIRECTORIES #####

# Specify here the filename your userfile should be saved as.
set userfile "LamestBot.user"

# Specify here the filename Eggdrop will save its pid to. If no pidfile is
# specified, pid.(myname) will be used.
#set pidfile "pid.LamestBot"

# Specify here where Eggdrop should look for help files. Don't modify this
# setting unless you know what you're doing!
set help_path "help/"

# Specify here where Eggdrop should look for text files. This is used for
# certain Tcl and DCC commands.
set text_path "text/"

# Set here a place to store temporary files.
set temp_path "/tmp"

# The MOTD (Message Of The day) is displayed when people dcc chat or telnet
# to the bot. Look at doc/text-substitutions.doc for options.
set motd "text/motd"

# This banner will be displayed on telnet connections. Look at
# doc/text-substitutions.doc for options.
set telnet_banner "text/banner"

# This specifies what permissions the user, channel, and notes files should
# be set to. The octal values are the same as for the chmod system command.
#
# To remind you:
#
#          u  g  o           u  g  o           u  g  o
#    0600  rw-------   0400  r--------   0200  -w-------    u - user
#    0660  rw-rw----   0440  r--r-----   0220  -w--w----    g - group
#    0666  rw-rw-rw-   0444  r--r--r--   0222  -w--w--w-    o - others
#
# Note that the default 0600 is the most secure one and should only be changed
# if you need your files for shell scripting or other external applications.
set userfile_perm 0600

##### DCC/TELNET #####

# This opens a telnet port by which you and other bots can
# interact with the Eggdrop by telneting in.
#
# There are more options for the listen command in doc/tcl-commands.doc.
# Note, if you are running more than one bot on the same machine, you will
# want to space the telnet ports at LEAST 5 apart. 10 is even better.
#
# Valid ports are typically anything between 1025 and 65535 assuming the
# port is not already in use.
#

# If you would like the bot to listen for users and bots in separate ports,
# use the following format.
#
# listen 3333 bots
# listen 4444 users
#
# If you wish to use only one port, use this format:
listen 3333 all

# This setting will drop telnet connections not matching a known host. It
# greatly improves protection from IRCops, but makes it impossible to add
# hosts on limbo (NOIRC) bots or have NEW as a valid login.
set protect_telnet 0

# This settings defines a time in seconds that the bot should wait before
# a dcc chat, telnet, or relay connection times out.
set ident_timeout 5

# This settings defines a time in seconds that the bot should wait before
# a dcc chat, telnet, or relay connection times out.
set connect_timeout 15

# Specify here the number of lines to accept from a user on the partyline
# within 10 seconds before they are considered to be flooding and therefore
# get booted.
set dcc_flood_thr 3

# Define here how many telnet connection attempts in how many seconds from
# the same host constitute a flood. The correct format is Attempts:Seconds.
set telnet_flood 5:60

# If you want telnet-flood to apply even to +f users, set this setting to 1.
set paranoid_telnet_flood 1

# Set here the amount of seconds before giving up on hostname/address
# lookup (you might want to increase this if you are on a slow network).
set resolve_timeout 15


##### MORE ADVANCED SETTINGS #####

# Set this to your socks host if your Eggdrop sits behind a firewall. If
# you use a Sun "telnet passthru" firewall, prefix the host with a '!'.
#set firewall "!sun-barr.ebay:3666"

# If you have a NAT firewall (you box has an IP in one of the following
# ranges: 192.168.0.0-192.168.255.255, 172.16.0.0-172.31.255.255,
# 10.0.0.0-10.255.255.255 and your firewall transparently changes your
# address to a unique address for your box) or you have IP masquerading
# between you and the rest of the world, and /dcc chat, /ctcp chat or
# userfile sharing aren't working, enter your outside IP here. Do not
# enter anything for my_ip if you use this setting.
#set nat_ip "127.0.0.1"

# If you want all dcc file transfers to use a particular portrange either
# because you're behind a firewall, or for other security reasons, set it
# here.
#set reserved_portrange 2010:2020

# Set the time in minutes that temporary ignores should last.
set ignore_time 15

# Define here what Eggdrop considers 'hourly'. All calls to it, including such
# things as note notifying or userfile saving, are affected by this.
# For example:
#
#   set hourly_updates 15
#
# The bot will save its userfile 15 minutes past every hour.
set hourly_updates 00

# Un-comment the next line and set the list of owners of the bot.
# You NEED to change this setting.
#set owner "MrLame, MrsLame"

# Who should a note be sent to when new users are learned?
set notify_newusers "$owner"

# Enter the flags that all new users should get by default. See '.help whois'
# on the partyline for a list of flags and their descriptions.
set default_flags "hp"

# Enter all user-defined fields that should be displayed in a '.whois'.
# This will only be shown if the user has one of these extra fields.
# You might prefer to comment this out and use the userinfo1.0.tcl script
# which provides commands for changing all of these.
set whois_fields "url birthday"

# Enable this setting if you want your Eggdrop to die upon receiving a SIGHUP
# kill signal. Otherwise, the Eggdrop will just save its userfile and rehash.
set die_on_sighup 0

# Enable this setting if you want your Eggdrop to die upon receiving a SIGTERM
# kill signal. Otherwise, the Eggdrop will just save its userfile and rehash.
set die_on_sigterm 1

# Comment these two lines if you wish to enable the .tcl and .set commands.
# If you select your owners wisely, you should be okay enabling these.
#unbind dcc n tcl *dcc:tcl
#unbind dcc n set *dcc:set

# Comment out this line to add the 'simul' partyline command (owners can
# manipulate other people on the party line). Please select owners wisely
# and use this command ethically!
#unbind dcc n simul *dcc:simul

# Set here the maximum number of dcc connections you will allow. You can
# increase this later, but never decrease it.
set max_dcc 50

# If your Eggdrop rejects bots that actually have already disconnected from
# another hub, but the disconnect information has not yet spread over the
# botnet due to lag, use this setting. The bot will wait dupwait_timeout
# seconds before it checks again and then finally reject the bot.
set dupwait_timeout 5


########## MODULES ##########

# Below are various settings for the modules included with Eggdrop.
# PLEASE READ AND EDIT THEM CAREFULLY, even if you're an old hand at
# Eggdrop, things change.

# This path specifies the path were Eggdrop should look for its modules.
# If you run the bot from the compilation directory, you will want to set
# this to "". If you use 'make install' (like all good kiddies do ;), this
# is a fine default. Otherwise, use your head :)
set mod_path "modules/"


##### CHANNELS MODULE #####

# This module provides channel related support for the bot. Without it,
# you won't be able to make the bot join a channel or save channel
# specific userfile information.
#loadmodule channels

# Enter here the filename where dynamic channel settings are stored.
set chanfile "LamestBot.chan"

# Set this setting to 1 if you want your bot to expire bans/exempts/invites set
# by other opped bots on the channel.
set force_expire 0

# Set this setting to 1 if you want to allow users to store an info line.
set use_info 1

# The following settings are used as default values when you .+chan #chan or .tcl
# channel add #chan. Look in the section below for explanation of every option.
set global_aop_delay 5:30
set global_chanmode "nt"
set global_ban_time 120
set global_exempt_time 60
set global_invite_time 60

set global-chanset {
  -autoop       -autovoice       +cycle      +dontkickops
  +dynamicbans  +dynamicexempts  +greet      +honor-global-invites
  -inactive     +dynamicinvites  -secret     +honor-global-exempts
  +statuslog    -enforcebans     -nodesynch  +honor-global-bans
}

# Add each static channel you want your bot to sit in using the following
# command. There are many different possible settings you can insert into
# this command, which are explained below.
#
#    channel add #lamest {
#      chanmode "+nt-likm"
#      ban_time 120
#      exempt_time 60
#      invite_time 60
#      aop_delay 5:30
#    }
#
# chanmode +/-<modes>
#    This setting makes the bot enforce channel modes. It will always add
#    the +<modes> and remove the -<modes> modes.
#
# ban_time 120
#   Set here how long temporary bans will last (in minutes). If you
#   set this setting to 0, the bot will never remove them.
#
# exempt_time 60
#   Set here how long temporary exempts will last (in minutes). If you
#   set this setting to 0, the bot will never remove them. The bot will
#   check the exempts every X minutes, but will not remove the exempt if
#   a ban is set on the channel that matches that exempt. Once the ban is
#   removed, then the exempt will be removed the next time the bot checks.
#   Please note that this is an IRCnet feature.
#
# invite_time 60
#   Set here how long temporary invites will last (in minutes). If you
#   set this setting to 0, the bot will never remove them. The bot will
#   check the invites every X minutes, but will not remove the invite if
#   a channel is set to +i. Once the channel is -i then the invite will be
#   removed the next time the bot checks. Please note that this is an IRCnet
#   feature.
#
# aop_delay (minimum:maximum)
# This is used for autoop, autohalfop, autovoice. If an op or voice joins a
# channel while another op or voice is pending, the bot will attempt to put
# both modes on one line.
#   aop_delay 0   No delay is used.
#   aop_delay X   An X second delay is used.
#   aop_delay X:Y A random delay between X and Y is used.
#
# There are many different options for channels which you can
# define. They can be enabled or disabled using the channel set command by a
# plus or minus in front of them.
#
#   channel set #lamest +enforcebans +dynamicbans +dynamicexempts -autoop
#   channel set #lamest +statuslog +dontkickops +autovoice +honor-global-bans
#   channel set #lamest +honor-global-exempts +greet +honor-global-invites
#   channel set #lamest +dynamicinvites -secret +cycle
#
# A complete list of all available channel settings:
#
# enforcebans
#    When a ban is set, kick people who are on the channel and match
#    the ban?
#
# dynamicbans
#    Only activate bans on the channel when necessary? This keeps
#    the channel's ban list from getting excessively long. The bot
#    still remembers every ban, but it only activates a ban on the
#    channel when it sees someone join who matches that ban.
#
# dynamicexempts
#    Only activate exempts on the channel when necessary? This keeps
#    the channel's exempt list from getting excessively long. The bot
#    still remembers every exempt, but it only activates a exempt on
#    the channel when it sees a ban set that matches the exempt. The
#    exempt remains active on the channel for as long as the ban is
#    still active.
#
# dynamicinvites
#    Only activate invites on the channel when necessary? This keeps
#    the channel's invite list from getting excessively long. The bot
#    still remembers every invite, but the invites are only activated
#    when the channel is set to invite only and a user joins after
#    requesting an invite. Once set, the invite remains until the
#    channel goes to -i.
#
# autoop
#    Op users with the +o flag as soon as they join the channel?
#    This is insecure and not recommended.
#
# greet
#    Say a user's info line when they join the channel?
#
# statuslog
#    Log the channel status line every 5 minutes? This shows the bot's
#    status on the channel (op, voice, etc.), The channel's modes, and
#    the number of +m/+o/+v/+n/+b/+e/+I users on the channel. A sample
#    status line follows:
#
#      [01:40] @#lamest (+istn) : [m/1 o/1 v/4 n/7 b/1 e/5 I/7]
#
# autovoice
#    Voice users with the +v flag when they join the channel?
#
# secret
#    Prevent this channel from being listed on the botnet?
#
# cycle
#    Cycle the channel when it has no ops?
#
# dontkickops
#    Do you want the bot not to be able to kick users who have the +o
#    flag, letting them kick-flood for instance to protect the channel
#    against clone attacks.
#
# inactive
#    This prevents the bot from joining the channel (or makes it leave
#    the channel if it is already there). It can be useful to make the
#    bot leave a channel without losing its settings, channel-specific
#    user flags, channel bans, and without affecting sharing.
#
# nodesynch
#    Allow non-ops to perform channel modes? This can stop the bot from
#    fighting with services such as ChanServ, or from kicking IRCops when
#    setting channel modes without having ops.
#
# honor-global-bans
#    Should global bans apply to this channel?
#
# honor-global-exempts
#    Should global exempts apply to this channel?
#
# honor-global-invites
#    Should global invites apply to this channel?
#
# Here is a shorter example:
#
#   channel add #botcentral {
#     chanmode "+mntisl 1"
#   }
#   channel set #botcentral +enforcebans -greet


#### SERVER MODULE ####

# This module provides the core server support. You have to load this
# if you want your bot to come on IRC. Not loading this is equivalent
# to the old NO_IRC define.
loadmodule server

# Uncomment and edit one of the folowing files for network specific
# features.
source nettype/custom.server.conf
#source nettype/dalnet.server.conf
#source nettype/efnet.server.conf
#source nettype/hybridefnet.server.conf
#source nettype/ircnet.server.conf
#source nettype/undernet.server.conf

# Set the nick the bot uses on IRC.
set nick "Lamestbot"

# Set the alternative nick which the bot uses on IRC if the nick specified
# by 'set nick' is unavailable. All '?' characters will be replaced by random
# numbers.
set altnick "Llamab?t"

# Set what should be displayed in the real-name field for the bot on IRC.
set realname "/msg LamestBot hello"

# This is a Tcl script to be run when connecting to a server.
bind event - init-server event:init_server

proc event:init_server {type} {
  global botnick
  putserv -quick "MODE $botnick +i-ws"
}

# Set the default port which should be used if none is specified with
# '.jump' or in 'set servers'.
set default_port 6667

# This is the bot's server list. The bot will start at the first server listed,
# and cycle through them whenever it gets disconnected. You need to change these
# servers to YOUR network's servers.
#
# Format:
#   server_add <host> [port] [pass]
#
# Both the port and password fields are optional; however, if you want to set a
# password you must also set a port. If a port isn't specified it will default to
# your default_port setting.

server_add "hostname.without.port"
server_add "hostname.with.port" 6668
server_add "hostname.with.port.and.pass" 6669 "somepass"
server_add "IPv6:server:with:port:and:pass" 6667 "mypass"
server_add "1.2.3.4" 6660

# This setting makes the bot try to get his original nickname back if its
# primary nickname is already in use.
set keep_nick 1

# Set this to 1 if you don't want your the bot to strip a leading '~' on
# user@hosts.
set strict_host 0

# This setting makes the bot squelch the error message when rejecting a DCC
# CHAT, SEND or message command. Normally, Eggdrop notifies the user that the
# command has been rejected because they don't have access. Note that sometimes
# IRC server operators detect bots that way.
set quiet_reject 1

# Set how many ctcps should be answered at once.
set answer_ctcp 3

# Set here how many msgs in how many seconds from one host constitutes
# a flood. If you set this to 0:0, msg flood protection will be disabled.
set flood_msg 5:60

# Set here how many ctcps in how many seconds from one host constitutes
# a flood. If you set this to 0:0, ctcp flood protection will be disabled.
set flood_ctcp 3:60

# This setting defines how long Eggdrop should wait before moving from one
# server to another on disconnect. If you set 0 here, Eggdrop will not wait
# at all and will connect instantly. Setting this too low could result in
# your bot being K:Lined.
set server_cycle_wait 60

# Set here how long Eggdrop should wait for a response when connecting to a
# server before giving up and moving on to next server.
set server_timeout 60

# Set this to 1 if Eggdrop should check for stoned servers? (where the server
# connection has died, but Eggdrop hasn't been notified yet).
set check_stoned 1

# Set here the maximum number of lines to queue to the server. If you're
# going to dump large chunks of text to people over IRC, you will probably
# want to raise this. 300 is fine for most people though.
set max_queue_msg 300

# If you want Eggdrop to trigger binds for ignored users, set this to 1.
set trigger_on_ignore 0

# This optimizes the kick queue. It also traces nick changes and parts in
# the channel and changes the kick queue accordingly. There are three
# different options for this setting:
#   0 = Turn it off.
#   1 = Optimize the kick queue by summarizing kicks.
#   2 = Trace nick changes and parts on the channel and change the queue
#       accordingly. For example, bot will not try to kick users who have
#       already parted the channel.
# ATTENTION: Setting 2 is very CPU intensive.
set optimize_kicks 1

# If your network supports more recipients per command then 1, you can
# change this behavior here. Set this to the number of recipients per
# command, or set this to 0 for unlimited.
set stack_limit 4


#### CTCP MODULE ####

# This module provides the normal ctcp replies that you'd expect.
# Without it loaded, CTCP CHAT will not work. The server module
# is required for this module to function.
#loadmodule ctcp

# Set here how the ctcp module should answer ctcps. There are 3 possible
# operating modes:
#   0: Normal behavior is used.
#   1: The bot ignores all ctcps, except for CHAT and PING requests
#      by users with the +o flag.
#   2: Normal behavior is used, however the bot will not answer more
#      than X ctcps in Y seconds (defined by 'set flood_ctcp').
set ctcp_mode 0


##### IRC MODULE #####

# This module provides basic IRC support for your bot. You have to
# load this if you want your bot to come on IRC. The server and channels
# modules must be loaded for this module to function.
#loadmodule irc

# Uncomment and edit one of the folowing files for network specific
# features.
source nettype/custom.irc.conf
#source nettype/dalnet.irc.conf
#source nettype/efnet.irc.conf
#source nettype/hybridefnet.irc.conf
#source nettype/ircnet.irc.conf
#source nettype/undernet.irc.conf

# Set this to 1 if you want to bounce all server bans.
set bounce_bans 1

# Set this to 1 if you want to bounce all server modes.
set bounce_modes 0

# If you want people to be able to add themselves to the bot's userlist
# with the default userflags (defined above in the config file) via the
# 'hello' msg command, set this to 1.
set learn_users 0

# Set here the time (in seconds) to wait for someone to return from a netsplit
# (i.e. wasop will expire afterwards). Set this to 1500 on IRCnet since its
# nick delay stops after 30 minutes.
set wait_split 600

# Set here the time (in seconds) that someone must have been off-channel
# before re-displaying their info line.
set wait_info 180

# Set this to the maximum number of bytes to send in the arguments
# of modes sent to the server. Most servers default this to 200.
set mode_buf_length 200

# Many IRCops find bots by seeing if they reply to 'hello' in a msg.
# You can change this to another word by un-commenting the following
# two lines and changing "myword" to the word wish to use instead of
# 'hello'. It must be a single word.
#unbind msg - hello *msg:hello
#bind msg - myword *msg:hello

# Many takeover attempts occur due to lame users blindly /msg ident'ing to
# the bot and attempting to guess passwords. We now unbind this command by
# default to discourage them. You can enable this commands by commenting the
# following line.
unbind msg - ident *msg:ident

# If you are so lame you want the bot to display peoples info lines, even
# when you are too lazy to add their chanrecs to a channel, set this to 1.
# *NOTE* This means *every* user with an info line will have their info
# line displayed on EVERY channel they join (provided they have been gone
# longer than wait_info).
set no_chanrec_info 0


#### COMPRESS MODULE ####

# This module provides provides support for file compression. This allows the
# bot to transfer compressed user files and therefore save a significant amount
# of bandwidth. Un-comment the following line to the compress module.
#loadmodule compress

# This is the default compression level used.
#set compress_level 9


#### FILESYSTEM MODULE ####

# This module provides an area within the bot where users can store
# files. With this module, the bot is usable as a file server. The
# transfer module is required for this module to function. Un-comment
# the following line to load the filesys module.
#loadmodule filesys

# Set here the 'root' directory for the file system.
set files_path "/home/mydir/filesys"

# If you want to allow uploads, set this to the directory uploads
# should be put into. Set this to "" if you don't want people to
# upload files to your bot.
set incoming_path "/home/mydir/filesys/incoming"

# If you don't want to have a central incoming directory, but instead
# want uploads to go to the current directory that a user is in, set
# this setting to 1.
set upload_to_pwd 0

# Eggdrop creates a '.filedb' file in each subdirectory of your file area
# to keep track of its own file system information. If you can't do that (for
# example, if the dcc path isn't owned by you, or you just don't want it to do
# that) specify a path here where you'd like all of the database files to be
# stored instead.
set filedb_path ""

# Set here the maximum number of people that can be in the file area at once.
# Setting this to 0 makes it effectively infinite.
set max_file_users 20

# Set here the maximum allowable file size that will be received (in kb).
# Setting this to 0 makes it effectively infinite.
set max_filesize 1024


#### NOTES MODULE ####

# This module provides support for storing of notes for users from each other.
# Note sending between currently online users is supported in the core, this is
# only for storing the notes for later retrieval.
#loadmodule notes

# Set here the filename where private notes between users are stored.
set notefile "LamestBot.notes"

# Set here the maximum number of notes to allow to be stored for each user
# (to prevent flooding).
set max_notes 50

# Set here how long (in days) to store notes before expiring them.
set note_life 60

# Set this to 1 if you want to allow users to specify a forwarding address
# for forwarding notes to another account on another bot.
set allow_fwd 0

# Set this to 1 if you want the bot to let people know hourly if they have
# any notes.
set notify_users 1

# Set this to 1 if you want the bot to let people know on join if they have
# any notes.
set notify_onjoin 1


#### CONSOLE MODULE ####

# This module provides storage of console settings when you exit the bot or
# type .store on the partyline.
#loadmodule console

# Save users console settings automatically? Otherwise, they have to use the
# .store command.
set console_autosave 1

# If a user doesn't have any console settings saved, which channel do you want
# them automatically put on?
set force_channel 0

# Enable this setting if a user's global info line should be displayed when
# they join a botnet channel.
set info_party 0


#### BLOWFISH MODULE ####

# IF YOU DON'T READ THIS YOU MAY RENDER YOUR USERFILE USELESS LATER
# Eggdrop encrypts its userfile, so users can have secure passwords.
# Please note that when you change your encryption method later (i.e.
# using other modules like a md5 module), you can't use your current
# userfile anymore. Eggdrop will not start without an encryption module.
#loadmodule blowfish


#### UPTIME MODULE ####

# This module reports uptime statistics to http://uptime.eggheads.org.
# Go look and see what your uptime is! It takes about 9 hours to show up,
# so if your bot isn't listed, try again later. The server module must be
# loaded for this module to function.
#
# Information sent to the server includes the bot's uptime, name, server,
# version, and IP address. This information is stored in a temporary logfile
# for debugging purposes only. The only publicly available information will
# be the bot's name, version and uptime. If you do not wish for this
# information to be sent, comment out the following line.
#loadmodule uptime


##### SCRIPTS #####

# This is a good place to load scripts to use with your bot.

# This line loads script.tcl from the scripts directory inside your Eggdrop's
# directory. All scripts should be put there, although you can place them where
# you like as long as you can supply a fully qualified path to them.
#
# source scripts/script.tcl

#source scripts/alltools.tcl
#source scripts/action.fix.tcl

# Use this script for Tcl and Eggdrop downwards compatibility.
# NOTE: This can also cause problems with some newer scripts.
#source scripts/compat.tcl

# This script provides many useful informational functions, like setting
# users' URLs, e-mail address, ICQ numbers, etc. You can modify it to add
# extra entries.
#source scripts/userinfo.tcl
loadhelp userinfo.help