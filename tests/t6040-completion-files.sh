#!/usr/bin/env bash

test_description='Bash todo file completion functionality

This test checks todo_completion of files in TODO_DIR.
'
. ./test-lib.sh

> dummy.txt
readonly FILES='done.txt dummy.txt report.txt todo.txt'
test_todo_completion 'all files after addto' 'todo.sh addto ' "$FILES"
test_todo_completion 'files beginning with d after addto' 'todo.sh addto d' 'done.txt dummy.txt'
test_todo_completion 'all files after listfile' 'todo.sh listfile ' "$FILES"
test_todo_completion 'all files after lf' 'todo.sh -v lf ' "$FILES"
test_todo_completion 'nothing after move' 'todo.sh move ' ''
test_todo_completion 'all files after move NR' 'todo.sh move 1 ' "$FILES"
test_todo_completion 'all files after mv NR' 'todo.sh mv 1 ' "$FILES"
test_todo_completion 'all files after move NR DEST' 'todo.sh move 1 todo.sh ' "$FILES"

test_done
