# Link of jenkins lab
## Ubunto Servers
https://docs.google.com/spreadsheets/d/1gEC6K71ti4ZJCUX1XRYHGUphyPwUVkcoG1rHvfRYR3c/edit?gid=0#gid=0

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


