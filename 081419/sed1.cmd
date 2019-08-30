#!/bin/bash
# change U-A to "lynx" I noticed that -E works too (like in grep), so -r == -E
sed -i -r "s/(\").*(\" \".*\"$)/\1lynx\2/g" access.log
# It works too. Don't know which way is the best for compatibility.
sed -i "s/\(\"\).*\(\" \".*\"$\)/\1lynx\2/g" access.log
