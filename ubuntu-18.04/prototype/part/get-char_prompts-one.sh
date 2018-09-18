#!/usr/bin/env bash

sqlite3 dayi4.db <<EOF
SELECT val
FROM ime
WHERE attr="char_prompts"
EOF
