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
