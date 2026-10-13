#!/bin/bash
if [[ "file1.txt" -ot  "file2.txt" ]]; then
echo "le file1 est plus ancien"
fi
