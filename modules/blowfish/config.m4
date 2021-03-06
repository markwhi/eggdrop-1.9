dnl config.m4
dnl
dnl Copyright (C) 2004 Eggheads Development Team
dnl
dnl This program is free software; you can redistribute it and/or
dnl modify it under the terms of the GNU General Public License
dnl as published by the Free Software Foundation; either version 2
dnl of the License, or (at your option) any later version.
dnl
dnl This program is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl GNU General Public License for more details.
dnl
dnl You should have received a copy of the GNU General Public License
dnl along with this program; if not, write to the Free Software
dnl Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
dnl
dnl $Id: config.m4,v 1.2 2004/06/16 06:33:44 wcc Exp $
dnl

EGG_MODULE_START(blowfish, [blowfish encryption], "yes")

# add blowfish to list of preloaded shared objects
LIBEGGDROP_PRELOAD="$LIBEGGDROP_PRELOAD -dlopen ../modules/blowfish/blowfish.la"

EGG_MODULE_END()
