/*
 *      cook - file construction tool
 *      Copyright (C) 2000, 2001, 2006-2008 Peter Miller
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

#ifndef COOK_GRAPH_EDGE_TYPE_H
#define COOK_GRAPH_EDGE_TYPE_H

#include <common/str.h>

enum edge_type_ty
{
    edge_type_default = 0,
    edge_type_strict  = 1,
    edge_type_weak    = 2,
    edge_type_exists  = 4
};
typedef enum edge_type_ty edge_type_ty;

void edge_type_extract(string_ty *, string_ty **, edge_type_ty *);
const char *edge_type_name(edge_type_ty);

#endif /* COOK_GRAPH_EDGE_TYPE_H */
