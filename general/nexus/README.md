# Nexus
```
docker pull sonatype/nexus:latest
docker run -d -p 8080:8081 --name nexus sonatype/nexus
Browes to http://localhost:8081
Login to nexus dashboard
User: admin
Via WSL
password: docker exec -it nexus cat /nexus-data/admin.password
Login as admin and upload the jar file
docker inspect nexus | grep -i vol
```
