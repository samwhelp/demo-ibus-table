#!/usr/bin/env bash

sqlite3 dayi4.db <<EOF
SELECT val
FROM ime
WHERE attr="valid_input_chars"
EOF
