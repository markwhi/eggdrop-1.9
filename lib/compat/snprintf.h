/*
 * snprintf.h --
 *
 *	prototypes for snprintf.c
 */
/*
 * Copyright (C) 2000, 2001, 2002, 2003 Eggheads Development Team
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
 * $Id: snprintf.h,v 1.8 2003/03/04 22:02:27 wcc Exp $
 */

#ifndef _EGG_SNPRINTF_H
#define _EGG_SNPRINTF_H

#ifdef HAVE_CONFIG_H
# include "config.h"
#endif

#include <stdio.h>
#include <stdarg.h>		/* FIXME: possible varargs.h conflicts */

/* Check for broken/non-C99-compliant snprintf functions */
#ifndef HAVE_C99_VSNPRINTF
#  ifdef HAVE_VSNPRINTF
#    undef HAVE_VSNPRINTF
#  endif
#  ifdef HAVE_SNPRINTF
#    undef HAVE_SNPRINTF
#  endif
#endif

#ifndef HAVE_VSNPRINTF
int vsnprintf(char *str, size_t count, const char *fmt, va_list args);
#endif

#ifndef HAVE_SNPRINTF
int snprintf(char *str, size_t count, const char *fmt, ...);
#endif

#ifndef HAVE_VASPRINTF
int vasprintf(char **ptr, const char *format, va_list ap);
#endif

#ifndef HAVE_ASPRINTF
int asprintf(char **ptr, const char *format, ...);
#endif

#endif				/* !_EGG_SNPRINTF_H */
