#!/bin/sh
#
#       cook - file construction tool
#       Copyright (C) 1994, 1995, 1997, 1998, 2007, 2008 Peter Miller
#
#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 3 of the License, or
#       (at your option) any later version.
#
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#
#       You should have received a copy of the GNU General Public License
#       along with this program. If not, see
#       <http://www.gnu.org/licenses/>.
#
work=${COOK_TMP:-/tmp}/$$
PAGER=cat
export PAGER
umask 022
unset COOK
here=`pwd`
if test $? -ne 0 ; then exit 1; fi

bin="$here/${1-.}/bin"

fail()
{
        set +x
        echo 'FAILED test of the search_list fingerprint' 1>&2
        cd $here
        rm -rf $work
        exit 1
}
pass()
{
        set +x
        cd $here
        rm -rf $work
        exit 0
}
trap \"fail\" 1 2 3 15

mkdir $work $work/lib
if test $? -ne 0 ; then exit 1; fi
cd $work
if test $? -ne 0 ; then fail; fi

#
# Use the default error messages.  There is no other way to get
# predictable test behaviour on the unknown systems we will be tested on.
#
COOK_MESSAGE_LIBRARY=$work/no-such-dir
export COOK_MESSAGE_LIBRARY
unset LANG

#
# the recipes
#
cat > Howto.cook << 'fubar'
set silent;
set fingerprint;
set update;

foo: bar
{
        echo This should never happen
                set silent;
        fail;
}
fubar
if test $? -ne 0 ; then fail; fi

mkdir one;
if test $? -ne 0 ; then fail; fi

mkdir two;
if test $? -ne 0 ; then fail; fi

cd ./one
if test $? -ne 0 ; then fail; fi

echo > bar;
if test $? -ne 0 ; then fail; fi

sleep 2;
if test $? -ne 0 ; then fail; fi

echo > foo;
if test $? -ne 0 ; then fail; fi

$bin/cook -nl -b ../Howto.cook foo > /dev/null 2>&1
if test $? -ne 0 ; then fail; fi

if test ! -r .cook.fp ; then fail; fi

cd ../two
if test $? -ne 0 ; then fail; fi

sleep 2;
if test $? -ne 0 ; then fail; fi

echo > bar;
if test $? -ne 0 ; then fail; fi

$bin/cook -nl -b ../Howto.cook search_list=../one foo > /dev/null 2>&1
if test $? -ne 0 ; then fail; fi

#
# Only definite negatives are possible.
# The functionality exercised by this test appears to work,
# no other guarantees are made.
#
pass
