# compat.tcl
#   This script just quickly maps old tcl functions to the new ones,
#   use this is you are to lazy to get of your butt and update your scripts :D
#   by the way it binds some old command to the new ones
#
# guppy     12Aug2001: added matchchanattr
# Wiktor    31Mar2000: added binds and chnick proc
# Tothwolf  25May1999: cleanup
# Tothwolf  06Oct1999: optimized
# rtc       10Oct1999: added [set|get][dn|up]loads functions
#
# $Id: compat.tcl,v 1.10 2003/02/10 00:09:08 wcc Exp $

proc gethosts {hand} {
  getuser $hand HOSTS
}

proc addhost {hand host} {
  setuser $hand HOSTS $host
}

proc chpass {hand pass} {
  setuser $hand PASS $pass
}


proc chnick {oldnick newnick} {
  chhandle $oldnick $newnick
}

# setxtra is no longer relevant

proc getxtra {hand} {
  getuser $hand XTRA
}

proc setinfo {hand info} {
  setuser $hand INFO $info
}

proc getinfo {hand} {
  getuser $hand INFO
}

proc getaddr {hand} {
  getuser $hand BOTADDR
}

proc setaddr {hand addr} {
  setuser $hand BOTADDR $addr
}

proc getdccdir {hand} {
  getuser $hand DCCDIR
}

proc setdccdir {hand dccdir} {
  setuser $hand DCCDIR $dccdir
}

proc getcomment {hand} {
  getuser $hand COMMENT
}

proc setcomment {hand comment} {
  setuser $hand COMMENT $comment
}

proc getemail {hand} {
  getuser $hand XTRA email
}

proc setemail {hand email} {
  setuser $hand XTRA EMAIL $email
}

proc getchanlaston {hand} {
  lindex [getuser $hand LASTON] 1
}

proc time {} {
  strftime "%H:%M"
}

proc date {} {
  strftime "%d %b %Y"
}

proc setdnloads {hand {c 0} {k 0}} {
  setuser $hand FSTAT d $c $k
}

proc getdnloads {hand} {
  getuser $hand FSTAT d
}

proc setuploads {hand {c 0} {k 0}} {
  setuser $hand FSTAT u $c $k
}

proc getuploads {hand} {
  getuser $hand FSTAT u
}

proc matchchanattr {hand flags chan} {
  matchattr $hand |$flags $chan
}

proc puthelp {text {next ""}} {
	if {[string length $next]} {
		putserv -help -next $text
	} else {
		putserv -help $text
	}
}

proc putquick {text {next ""}} {
	if {[string length $next]} {
		putserv -quick -next $text
	} else {
		putserv -quick $text
	}
}

