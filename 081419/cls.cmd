#!/bin/bash
# Clear directory, remove temporary files, except *.cmd and *.res task files
rm -r !("*.cmd"|"*.res")
