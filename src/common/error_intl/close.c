/*
 *      cook - file construction tool
 *      Copyright (C) 1999, 2006-2008 Peter Miller
 *
 *      This program is free software; you can redistribute it and/or modify
 *      it under the terms of the GNU General Public License as published by
 *      the Free Software Foundation; either version 3 of the License, or
 *      (at your option) any later version.
 *
 *      This program is distributed in the hope that it will be useful,
 *      but WITHOUT ANY WARRANTY; without even the implied warranty of
 *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *      GNU General Public License for more details.
 *
 *      You should have received a copy of the GNU General Public License
 *      along with this program. If not, see
 *      <http://www.gnu.org/licenses/>.
 */

#include <common/ac/stdio.h>

#include <common/error_intl.h>
#include <common/sub.h>


void
error_intl_close(const char *fn)
{
    sub_context_ty  *scp;

    scp = sub_context_new();
    sub_errno_set(scp);
    sub_var_set(scp, "File_Name", "%s", fn);
    error_intl(scp, i18n("close $filename: $errno"));
    sub_context_delete(scp);
}


void
fatal_intl_close(const char *fn)
{
    sub_context_ty  *scp;

    scp = sub_context_new();
    sub_errno_set(scp);
    sub_var_set(scp, "File_Name", "%s", fn);
    fatal_intl(scp, i18n("close $filename: $errno"));
    /* NOTREACHED */
}


void
fclose_and_check(FILE *fp, const char *fn)
{
    if (fclose(fp))
    {
        fatal_intl_close(fn);
        /* NOTREACHED */
    }
}
