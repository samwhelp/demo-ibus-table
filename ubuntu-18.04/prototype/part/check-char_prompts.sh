#!/usr/bin/env bash


the_val=`sqlite3 dayi4.db <<EOF
SELECT val
FROM ime
WHERE attr="char_prompts"
EOF`

echo $the_val

echo

exp_val=`cat expect-char_prompts.txt`

echo $exp_val


if [ "$the_val" = "$exp_val" ]; then
	echo 'Yes'
else
	echo 'No'
fi
