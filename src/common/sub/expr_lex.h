/*
 *      cook - file construction tool
 *      Copyright (C) 1997, 2006, 2007 Peter Miller;
 *      All rights reserved.
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

#ifndef COMMON_SUB_EXPR_LEX_H
#define COMMON_SUB_EXPR_LEX_H

#include <common/main.h>

struct string_ty; /* forward */

void sub_expr_lex_open(struct string_ty *);
void sub_expr_lex_close(void);
int sub_expr_gram_lex(void);

#endif /* COMMON_SUB_EXPR_LEX_H */
