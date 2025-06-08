# **GitHub Action push into Docker Hub**
  - Git checkout
  - Login to Docker
  - Docker build and create image
  - Push the image into Docker hub
  - Logout from Docker

## Build local image and test it
```
docker build -t app-node .
docker run -d -p 3300:3000 app-node
docker ps
```
- Or pull and run it
```
docker run -d -p 3300:3000 dinghy123/app-node:latest
``` 
- Go to browser http://localhost:3300/
  - Output **Hello, World!**
## Tag and push the image into the Docker Hub
```
docker images
docker tag app-node dinghy123/app-node:latest
docker login
docker push dinghy123/app-node:latest
```
- Go to https://hub.docker.com/ login with your account and make sure the image is pushed
## Integrate Docker Hub with GitHub via token
- **Generate token** Go to Docker Hub - > Under Account Setting -> Settings - > Personal access tokens
GitHub
  - Keep the Username of Docker hub and token
- Go to GitHub Repository ->  Settings -> Secrets and variables -> Actions -> New repository secret
- Type DOCKERHUB_USERNAME - add the password of github account in order to update the token integrated
- Type DOCKERHUB_TOKEN
- Type DOCKERHUB_USERNAME
- Docker DOCKERHUB_TOKEN
- Click "Add secret".

## Update GitHub Actions Workflow
- Create folder **.github** Repository or create it automaticlly under **Action Tab**
- Create the yaml workflow for example ./github/build-image.yaml
- For Example **Hello World based on app-js **
```
name: Docker Build and Push
on:
  push:
    branches:
      - dev-01  # Replace with your branch name
jobs:
  build-and-push:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v1
      - name: Login to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}
      - name: Build and push Docker image
        uses: docker/build-push-action@v2
        with:
          context: ./lesson-cicd/practice-04  # Path to the Dockerfile and build context
          push: true
          tags: |
            dinghy123/app-node:${{ github.sha }}
      - name: Logout from Docker Hub
        run: docker logout
```
## Create new dev-01 branch
- Go to main branch -> view all branches -> Create new branch -> dev-01

### Test Workflow
- Switch to dev-01 branch and change the msg in app.js file to **Hello, World test-01!**
- Go to GitHub Action and make sure that workflow is an execute automatically
- Go to the Docker Hub and make sure that new image created

### Test CD via Docker Desktop

- Cleanup Docker container and image of app-node

```
docker images
docker ps
docker rm -f 2fe636786bde
docker rmi -f 41b91ab4f612
docker images
docker ps
docker ps -a
```
- Docker Pull the new image

```
docker pull dinghy123/app-node:66c3b6f8e01090562913da81e918be9e06f1e045
docker images
docker ps
docker run -d -p 3300:3000  dinghy123/app-node:66c3b6f8e01090562913da81e918be9e06f1e045
docker ps
```
- Go to browser http://localhost:3300/
  - Output **Hello, World test-01!** 

  

