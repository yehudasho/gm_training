# Link of jenkins lab
## Ubunto Servers
https://docs.google.com/spreadsheets/d/1gEC6K71ti4ZJCUX1XRYHGUphyPwUVkcoG1rHvfRYR3c/edit?gid=0#gid=0


- Cleanup if needed

```
docker rm -f $(docker ps -a -q)
docker rmi -f $(docker images -q)
```

- Jenkins installation via docker
- Enables Jenkins to use the host's Docker engine by mounting the Docker socket
  - **Docker socket** is Mounting the  in a container means giving the container direct access to the host's Docker engine       this allows the container to run Docker commands
     its how the Docker CLI (docker ps, docker run, etc.) communicates with the Docker daemon
    
```
docker run -d \
  --name jenkins \
  -u root \
  -p 8080:8080 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --group-add $(getent group docker | cut -d: -f3) \
  jenkins/jenkins:lts
```

- Go to the Browser and type the password via user jenkins

```
sudo docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword bash
```

- Install plugins of docker and stage view
- Install docker into docker and grant permission to jenkins user 
```
docker exec -u 0 -it jenkins bash
apt update && apt install -y docker.io
usermod -aG docker jenkins
docker restart jenkins
```

- Create Declarative Pipeline job and run it
  -  pipeline-check-docker and then pipline-Run-Python files

### Lab-01
https://gitlab.com/ez-mentor/ez-cooperations/ez-mentor-sela/sela-modern-cI-cd-course-labs/-/blob/master/setup/jenkins-docker-setup.md?ref_type=heads



### Freestyle job
A Jenkins Freestyle job is a basic project type in Jenkins that allows you to run simple build, test, and deploy tasks. It is a good starting point for beginners to understand Jenkins automation



#### Lab - Freestyle job

- Go to the **New Item** and choose **Freestyle project**
  Go to Build Steps -> Execute shell -> and type
```
echo "My first Freestyle job"
```
- Run the job
For more options:
- Build Triggers
    -  Example: check "Poll SCM" and enter H/5 * * * * to poll every 5 minutes

- Build Environment
    - Choose Delete workspace before build starts


