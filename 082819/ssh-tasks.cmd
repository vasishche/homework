#!/bin/bash
# 1.1
ssh vshch@35.232.177.221 eval "echo "{5..1}"; sleep 1;"
# we just run a command and go back, otherwise we can logout with "exit" command

# 1.2 generate key-pair
ssh-keygen -q -C "Vasilii Shcherbina" -N "" -f ~/.ssh/hw-5

# 1.3 copy public key to remotehost
ssh-copy-id -i ~/.ssh/hw-5.pub vshch@35.232.177.221

# 1.4
ssh vshch@35.232.177.221 "eval 'echo '{5..1}'; sleep 1;'"

# 1.5 create config file and set 644 permitions
mv ~/.ssh/config{,vbackup}
echo -e "Host remotehost\nHostName 35.232.177.221\nUser vshch\nIdentityFile ~/.ssh/hw-5" > ~/.ssh/config
chmod 644 ~/.ssh/config

# 1.6 
# we can use smth like this
ssh remotehost "curl -Is 10.128.0.4:8080 | head -1; eval 'echo '{5..1}'; sleep 1;'"
# HTTP/1.1 200 OK

# but if we get smth like 301 (google.ru), so we can add -L and to check final http_code after redirect
# if [[ $( curl -sLI -w "%{http_code}\n" google.ru | tail -1 ) == 200 ]]; then echo "Available"; fi
# this will print only http_code like:
# 200

# 1.7
# find free port
read freePort maxPort < /proc/sys/net/ipv4/ip_local_port_range
while ( ss -tan | awk '{print gensub(/(.+):(.+)/,"\\2","g",$4)}' | sort -u | grep "^$freePort$" > /dev/null ); do ((freePort++)); done
if (( $freePort > $maxPort )); then echo "No port available"; fi
ssh remotehost -L "*:$freePort:10.128.0.4:8080" -N -f

# 1.8
curl -Is "127.0.0.1:$freePort" | head -1
# HTTP/1.1 200 OK

# 1.9 screenshot - 1.9.png, echo just print free port number, so we can use it in the browser
echo "freePort = $freePort"

# I paste such lines before every subtask not to harm remoteserver if something goes wrong
read -p "Clean (y/n): " -n 1; if ! [[ $REPLY =~ ^[Yy]$ ]]; then echo; exit; fi; echo 

# restore original config and terminating port forwarding ssh
kill $( ps aux | grep -E "[s]sh remotehost" | awk '{print $2}' )
mv ~/.ssh/config{vbackup,}
