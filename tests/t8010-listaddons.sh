#!/bin/bash

test_description='listaddons functionality

This test checks listing of custom actions.
'
. ./actions-test-lib.sh
. ./test-lib.sh

test_todo_session 'no custom actions' <<EOF
>>> todo.sh listaddons
EOF

make_action "foo"
test_todo_session 'one custom action' <<EOF
>>> todo.sh listaddons
foo
EOF

make_action "bar"
make_action "ls"
make_action "quux"
test_todo_session 'multiple custom actions' <<EOF
>>> todo.sh listaddons
bar
foo
ls
quux
EOF

invalidate_action .todo.actions.d/foo t8010.4
test_todo_session 'nonexecutable action' <<EOF
>>> todo.sh listaddons
bar
ls
quux
EOF

make_action_in_folder "chuck"
# Add a bit of cruft in the action folders in order to ensure that we only
# care about the executables with the same name as the folder in which they
# reside.
touch .todo.actions.d/chuck/mc_hammer     # can't touch this
chmod u+x .todo.actions.d/chuck/mc_hammer # better run, better run run
touch .todo.actions.d/chuck/README

make_action_in_folder "norris"

test_todo_session 'custom actions in subfolders' <<EOF
>>> test -f .todo.actions.d/chuck/README
=== 0

>>> test -x .todo.actions.d/chuck/mc_hammer
=== 0

>>> todo.sh listaddons
bar
chuck
ls
norris
quux
EOF

invalidate_action .todo.actions.d/norris/norris t8010.8
test_todo_session 'nonexecutable action in subfolder' <<EOF
>>> todo.sh listaddons
bar
chuck
ls
quux
EOF

test_done
