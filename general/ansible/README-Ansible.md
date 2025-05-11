## Ansible - How to connect

- Connect via CMD cli to IP's ( Master and worker )
- Go to the worker and type the below command, in order to get the **pub ip**
- Connect via ssh to the masetr and than to the worker
- Change the hostname of master and worker

```
curl ifconfig.me
sela@master:~$ ssh sela@34.38.112.12
sudo hostnamectl set-hostname master
sudo hostnamectl set-hostname worker
```


# Modules

```
ansible all -m user -a "name=<You Should type the correct uset !!! > state=present"
ansible all -m user -a "name=testuser state=present"
ansible all -m shell -a "echo $HOME"
ansible all -m file -a "path=/tmp/ state=directory"
ansible all -m shell -a "hostname"
ansible all -m shell -a "uname"
ansible all -m shell -a "cat /etc/os-release"
ansible all -m shell -a "apt install -y ncdu"
ansible demoservers -m shell -a "sudo service apache2 status"
```
