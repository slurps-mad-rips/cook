#!/bin/sh
#
#       cook - file construction tool
#       Copyright (C) 1997, 1998, 2001, 2007 Peter Miller;
#       All rights reserved.
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
if test $? -ne 0 ; then exit 2; fi
SHELL=/bin/sh
export SHELL

bin="$here/${1-.}/bin"

pass()
{
        set +x
        cd $here
        rm -rf $work
        exit 0
}
fail()
{
        set +x
        echo 'FAILED test of the function call pattern functionality' 1>&2
        cd $here
        rm -rf $work
        exit 1
}
no_result()
{
        set +x
       echo 'NO RESULT for test of the function call pattern functionality' 1>&2
        cd $here
        rm -rf $work
        exit 2
}
trap \"no_result\" 1 2 3 15

mkdir $work $work/lib
if test $? -ne 0 ; then no_result; fi
cd $work
if test $? -ne 0 ; then no_result; fi

#
# Use the default error messages.  There is no other way to get
# predictable test behaviour on the unknown systems we will be tested on.
#
COOK_MESSAGE_LIBRARY=$work/no-such-dir

#
# test the function call pattern functionality
#
cat > Howto.cook << 'fubar'
function im-a-test =
{
        return [fromto % a_%_a [arg]];
};

%.o: %.c
{
        echo [im-a-test [need]] > [target];
}

test: fred.o;
fubar
if test $? -ne 0 ; then no_result; fi

echo date > fred.c;
if test $? -ne 0 ; then no_result; fi

echo a_fred.c_a > test.ok
if test $? -ne 0 ; then no_result; fi

$bin/cook -nl > LOG 2>&1
if test $? -ne 0 ; then cat LOG; fail; fi

diff test.ok fred.o
if test $? -ne 0 ; then fail; fi

#
# Only definite negatives are possible.
# The functionality exercised by this test appears to work,
# no other guarantees are made.
#
pass
