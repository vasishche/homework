#!/bin/bash
# one of this two commands
grep -oE "[a-zA-Z]{6,}" fir.txt 
grep -o -e"[a-zA-Z]\{6,\}" fir.txt 
