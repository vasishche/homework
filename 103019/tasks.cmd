# ansible tasks
# 1. have >=3 vm's
vm1='192.168.56.117'
vm2='192.168.56.118'
vm3='192.168.56.119'

# ansible.cfg
echo -e '[defaults]\ninventory = hosts.ini\nhost_key_checking = false' > ansible.cfg

# hosts.ini
echo -e echo -e '[hw]' '\n'$vm{1..3} '\n\n[head]\n'$vm1 > hosts.ini
# [hw] 
# 192.168.56.117 
# 192.168.56.118 
# 192.168.56.119
#
# [head]
# 192.168.56.117

# 2. install ansible and create user, e.g. anteus
sudo yum -y install ansible
# newuser='anteus'
# newpass='pass'

# user input:
read -p "Enter your new username: " newuser
echo 
# echo $newuser
read -s -p "Enter your password: " newpass
echo 
# echo $newpass

# create user
sudo useradd $newuser -p $(openssl passwd -1 $newpass)
# sudo nopasswd
echo -e "$newuser\tALL=(ALL)\tNOPASSWD:\tALL" | sudo tee "/etc/sudoers.d/$newuser"

# switch user and create ssh key-pair
sudo -i -u $newuser
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
exit

# copy task files
cp * /home/$newuser/

# 3. using ansible ad-hoc create the same user on the rest of machines, setup ssh keys and sudo for that user
ansible hw -u root -k -m user -a "name=$newuser password=$(openssl passwd -1 $newpass) update_password=on_create"
ansible hw -u root -k -m authorized_key -a "key=$(echo \'$(sudo cat /home/anteus/.ssh/id_rsa.pub)\') user=$newuser"
sudo ansible hw -u root -k -m copy -a "src=/etc/sudoers.d/$newuser dest=/etc/sudoers.d/$newuser"

# 4. & 5.
# add http service to check out task No4
sudo firewall-cmd --zone=public --permanent --add-service=http

# switch user and play task No4
sudo -i -u $newuser
ansible-playbook hw4.yml
ansible-playbook hw4.yml
exit 

# Output after 2nd execution:
# PLAY RECAP ********************************************************************************************************************
# 192.168.56.117             : ok=15   changed=0    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0   
# 192.168.56.118             : ok=15   changed=0    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0   
# 192.168.56.119             : ok=15   changed=0    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0   

# play task No5
sudo ansible-playbook hw5.yml

# Output:
# PLAY RECAP ********************************************************************************************************************
# 192.168.56.117             : ok=6    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
# 192.168.56.118             : ok=5    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0   
# 192.168.56.119             : ok=5    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0   

