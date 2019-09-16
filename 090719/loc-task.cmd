#!/bin/bash
# copy db file
sudo cp /var/lib/mlocate/mlocate.db /tmp

# show stats
sudo locate -S -d /tmp/mlocate.db 

# update and show stats again
sudo updatedb -o /tmp/mlocate.db 
sudo locate -S -d /tmp/mlocate.db 
# create a new file
touch ~/mytmpfile
# update db and show updated stats
sudo updatedb -o /tmp/mlocate.db 
sudo locate -S -d /tmp/mlocate.db 

# cleaning
sudo rm /tmp/mlocate.db ~/mytmpfile

# usefull
# number of files:
# numFiles = $( locate -S | sed -rn "s/^[[:space:]]*([0-9]*),*([0-9]*) files/\1\2/p" )
# we can find created or deleted files comparing old and new mlocate.db files:
# diff <(locate -d mlocate.old.db -r.) <(locate -d mlocate.new.db -r.)
