#!/usr/bin/env bash


the_val=`sqlite3 dayi4.db <<EOF
SELECT val
FROM ime
WHERE attr="valid_input_chars"
EOF`

echo $the_val

echo

exp_val=`cat expect-valid_input_chars.txt`

echo $exp_val

echo

if [ "$the_val" = "$exp_val" ]; then
	echo 'Yes'
else
	echo 'No'
fi
