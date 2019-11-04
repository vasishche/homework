# py task
# local version: Python 3.6.8
# 1. task
# 1.1 Create variable list1, which contains int numbers from 1 to 9
list1 = list(range(1,10))

# 1.2 Create variable list2 assigning list1 to it
list2 = list1

# 1.3 Add 10 to list2
# list2[len(list2):] = [10]
# list2 += [10]
list2.append(10)

# list2 = list2 + [10] # create an independent copy, list2 != list1

# 1.4 Remove first element from list2
# list2[0:1] = []
del(list2[0])

# 1.5 Print content of list{1,2} variables
print(list1, list2)
# [2, 3, 4, 5, 6, 7, 8, 9, 10] [2, 3, 4, 5, 6, 7, 8, 9, 10]

# 1.6 Create variable list3 assigning list1[:] to it;
# list3 = list1.copy() # copy.deepcopy() for nested lists
list3 = list1[:]

# 1.7 Add string ‘full copy magic’ to list3
list3.append('full copy magic')

# 1.8 Print content of list{1,3} variables
print(list1, list2, list3)
# [2, 3, 4, 5, 6, 7, 8, 9, 10] [2, 3, 4, 5, 6, 7, 8, 9, 10] [2, 3, 4, 5, 6, 7, 8, 9, 10, 'full copy magic']

# 2. task
# 2.1 Create function that greets user. It must return message: ‘Hello, Username!’. Also, function must correct username to title if given username is printed in lower or upper case, e.g. username / USERNAME.
def greet(user = 'nameless'):
    user='nameless' if user == '' else user
    print('Hello, '+user.title()+'!')

# 2.2 Call function multiple time for different names.
greet()
# Hello, Nameless!
greet('')
# Hello, Nameless!
greet('woRld')
# Hello, World!
greet('wor1d')
# Hello, Wor1D!
greet('world wide web')
# Hello, World Wide Web!

# 3. task
# 3.1 Create class Dog which has method bark. This method accepts number of times dog barks. Default value is 1 and when called method must return message ‘BARK!!!’ given number of times, separated with space.
class Dog:
    def bark(self, n=1):
        print (' '.join(['BARK!!!']*n))

# 3.2 Inherit class SmartDog from Dog class, add new method givepaw to it. Method must return message ‘Paw pat’.
class SmartDog(Dog):
    def givepaw(self):
        print ('Paw pat.')

# 3.3 Create dogs, check that only smart dog can give a paw, and both dogs can bark
dog1 = Dog()
dog1.bark()
# BARK!!!
dog1.bark(3)
# BARK!!! BARK!!! BARK!!!
dog1.givepaw()
# AttributeError: 'Dog' object has no attribute 'givepaw'

dog2 = SmartDog()
dog2.givepaw()
# Paw pat.
dog2.bark(2)
# BARK!!! BARK!!!

# 3.4** Inherit class NoizyDog from Dog class, modify bark method so then it called dog bark continually and each bark must be printed from new line.
class NoizyDog(Dog):
    def bark(self,n=1): # n - for backward compability - NoizyDog ignore it and barks infinitely.
        while True:
            print ('BARK!!!')

dog3 = NoizyDog()
dog3.bark(2)
# BARK!!!
# BARK!!!
# ...

# 4. task
# For this task you need to have docker daemon installed and running.
# The task is to create a python script, that has following functions:
#   1.	connects to docker API and print a warning message if there are dead or stopped containers with their ID and name.
#   2.	containers list, similar to docker ps -a
#   3.	image list, similar to docker image ls
#   4.	container information, like docker inspect
# Connection function must accept connection string for example 'http://192.168.56.101:2376' and connect to it or use string from environment if no connection string is given.

# necessary preconfiguration: ./task4.sh
# connect to docker daemon and start example containers
import docker
import json
client = docker.from_env()

# docker run --name nginx -p 8080:80 -d myfirstnginx
nginx_cont = client.containers.run('nginx:latest', detach=True, ports={8080:80}, name='myfirstnginx')

# docker stop myfirstnginx # get container by name
client.containers.get('myfirstnginx').stop()

# docker run --name nginx -p 8080:80 -d mylongnamefornginx
nginx_cont = client.containers.run('nginx:latest', detach=True, ports={8080:80}, name='mysecondnginx')

# 4.1 connects to docker API and print a warning message if there are dead or stopped containers with their ID and name
# Connection function must accept connection string for example 'http://192.168.56.101:2376' and connect to it or use string from environment if no connection string is given.
def stop_dead_check(con_str=None):
    client=docker.from_env() if con_str==None else docker.DockerClient(base_url=con_str)
    dead_stop=client.containers.list(all=True,filters={'status':'exited'})+client.containers.list(all=True,filters={'status':'dead'})
    print ('Warning! Stoped or Dead containers found:')
    print ('CONTAINER ID','   ','STATUS','    ','NAME')
    for container in dead_stop:
        print (container.short_id,'    ',container.status,'    ',container.name)

stop_dead_check()
stop_dead_check('unix:///var/run/docker.sock')
stop_dead_check('http://localhost:2376')
# Warning! Stoped or Dead containers found:
# CONTAINER ID     STATUS      NAME
# 08c6c2f042      exited      myfirstnginx
# 5b180194b7      exited      gitlab

# 4.2 docker ps -a
def dcls(client, isAll=False):
    row=['CONTAINER ID','IMAGE','PORTS','STATUS','NAME']
    row_format ="{:>12}{:>30}{:>20}{:>10}{:>20}"
    print(row_format.format(*row))
    for container in client.containers.list(all=isAll):
        row=[container.short_id,container.image.tags[0],':'.join(container.ports.keys()),container.status,container.name]
        print(row_format.format(*row))

dcls (client, True)
# CONTAINER ID                         IMAGE               PORTS    STATUS                NAME
#   ea0e0516e2                  nginx:latest     80/tcp:8080/tcp   running       mysecondnginx
#   08c6c2f042                  nginx:latest                        exited        myfirstnginx
#   5b180194b7       gitlab/gitlab-ce:latest                        exited              gitlab

# 4.3 docker image ls
def dils(client, isAll=False):
    row=['IMAGE ID','REPO','TAG','SIZE']
    row_format ="{:>20}" * (len(row))
    print(row_format.format(*row))
    for image in client.images.list(all=isAll):
        row=[image.short_id]+image.tags[0].split(':')+[image.attrs['Size']]
        print(row_format.format(*row))

dils (client, True)
#             IMAGE ID                REPO                 TAG                SIZE
#    sha256:6d75d1ad2f    gitlab/gitlab-ce              latest          1796294804
#    sha256:540a289bab               nginx              latest           126215561
#    sha256:f94d6dd9b5               nginx         1.10-alpine            54042627

# 4.4 container information, like docker inspect
# inspect image by id or name, e.g. 'nginx'
print(json.dumps(client.images.get('nginx').attrs, indent=4))

# inspect container by id or name, e.g. 'mysecondnginx'
print(json.dumps(client.containers.get('mysecondnginx').attrs, indent=4))

# stop and remove example containers and image
# docker rm myfirstnginx # get container by id
client.containers.get('myfirstnginx').remove()

# stop and remove by variable
client.containers.get(nginx_cont.id).stop()
nginx_cont.remove()

# docker rmi nginx
client.images.remove(image='nginx')

