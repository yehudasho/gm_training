# Ansible - How to connect

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


## Modules

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


## Ansible Roles

- Run flask app python without roles
- Run flask app with python roles

### Run flask app python  without roles

- Create the playbook flaskapp-without-role-playbook.yml file
- Execute the playbook
- Browse to the flask app
  - **Note** -  app_dir var is it inside the playbook and not as global variable

```
tee flaskapp-without-role-playbook.yml > /dev/null <<EOF
---
- name: Deploy Flask Hello World App
  hosts: demoservers
  become: yes
  remote_user: sela
  vars:
    app_dir: /home/sela/playbooks/flaskapp
    ansible_python_interpreter: /usr/bin/python3

  tasks:
    - name: Ensure Python3 and pip are installed
      apt:
        name:
          - python3
          - python3-pip
        update_cache: yes
        state: present

    - name: Install Flask using pip3
      pip:
        name: flask
        executable: pip3

    - name: Create application directory
      file:
        path: "{{ app_dir }}"
        state: directory
        owner: sela
        group: sela
        mode: '0755'

    - name: Copy Flask App is running without role 
      copy:
        dest: "{{ app_dir }}/app.py"
        content: |
          from flask import Flask
          app = Flask(__name__)

          @app.route('/')
          def hello():
              return "Flask App is running without role !!!"

          if __name__ == "__main__":
              app.run(host='0.0.0.0', port=5010)
        owner: sela
        group: sela
        mode: '0755'

    - name: Run the Flask app in the background
      shell: nohup python3 {{ app_dir }}/app.py &> {{ app_dir }}/flask.log &
      args:
        chdir: "{{ app_dir }}"
      async: 0
      poll: 0
EOF
```

  - Execute the playbook
```
ansible-playbook flaskapp-without-role-playbook.yml --syntax-check
ansible-playbook flaskapp-without-role-playbook.yml
```

- Browse to the flask app with the correct port
  - http://(IP-WORKER):5010
 

## Run flask app python  with roles



```
ansible-galaxy init flaskapp-with-role
```
  - output of three
```
flaskapp-with-role/
├── defaults/
├── files/
├── handlers/
├── meta/
├── tasks/
│   └── main.yml         # ← This is where your content goes
├── templates/
├── tests/
└── vars/
```

  - Create flask app python with diffrent port in playbooks ->flaskapp-with-role -> tasks -> main.yml
```
tee playbooks/flaskapp-with-role/tasks/main.yml > /dev/null <<EOF
---
- name: Ensure Python3 and pip are installed
  apt:
    name:
      - python3
      - python3-pip
    update_cache: yes
    state: present

- name: Install Flask using pip3
  pip:
    name: flask
    executable: pip3

- name: Create application directory
  file:
    path: "{{ app_dir }}"
    state: directory
    owner: test
    group: test
    mode: '0755'

- name: Copy Hello World app
  copy:
    dest: "{{ app_dir }}/app.py"
    content: |
      from flask import Flask
      app = Flask(__name__)

      @app.route('/')
      def hello():
          return "Hello World from Flask with the roles!!!"

      if __name__ == "__main__":
          app.run(host='0.0.0.0', port=5011)
    owner: test
    group: test
    mode: '0755'

- name: Run the Flask app in the background
  shell: nohup python3 {{ app_dir }}/app.py &> {{ app_dir }}/flask.log &
  args:
    chdir: "{{ app_dir }}"
  async: 0
  poll: 0
EOF
```

  - Create Variable in playbooks ->flaskapp-with-role -> defaults -> main.yml

```
tee playbooks/flaskapp-with-role/defaults/main.yml > /dev/null <<EOF
---
app_dir: /home/test/playbooks/flaskapp-with-role
EOF
```


- Create the playbook flaskapp-role-playbook.yml file
- Execute the playbook
- Browse to the flask app
  - **Note** -  app_dir var is as global variable

```
  - Create playbook flaskapp-with-role  
---
- name: Deploy Flask App
  hosts: demoservers
  become: yes
  remote_user: test
  vars:
    ansible_python_interpreter: /usr/bin/python3
  roles:
    - flaskapp-with-role
```


  - Execute the playbook
```
ansible-playbook flaskapp-role-playbook.yml --syntax-check
ansible-playbook flaskapp-role-playbook.yml
```

- Browse to the flask app with the correct port
  - http://(IP-WORKER):5011
    
```
# run it in order to get the Public IP of worker and add it to the browser
# for example  http://<output curl ifconfig.me>:5011/
curl ifconfig.me
```

### Cleanup - kill the py process

```
ansible worker -m shell -a "pkill -f py" -b
```

