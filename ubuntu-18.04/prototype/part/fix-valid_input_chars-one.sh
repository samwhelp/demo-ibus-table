#!/usr/bin/env bash


sqlite3 -line dayi4.db <<EOF
UPDATE ime
SET val='1234567890-abcdefghijklmnopqrstuvwxyz,./;''[]\\\`-~!@#$%^&*()_+{}|:"<>?='
WHERE attr='valid_input_chars'
EOF
