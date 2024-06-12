set -e
docker pull jenkins/jenkins:jdk17
docker build -t local-tribus-jenkins-image .

