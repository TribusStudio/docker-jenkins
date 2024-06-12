[![CircleCI](https://circleci.com/gh/TribusStudio/docker-jenkins.svg?style=svg)](https://circleci.com/gh/TribusStudio/docker-jenkins)

Latest Jenkins with Python 3 and [doctl](https://docs.digitalocean.com/reference/doctl/), updated weekly.

Use anywhere you would use the [jenkins/jenkins](https://hub.docker.com/r/jenkins/jenkins) latest jdk11 image, if you need python and doctl with it.

Python is included because it is useful for scripting; and doctl is included because we can use it to spin up [DigitalOcean](https://www.digitalocean.com) "droplets" or virtual machines (VMs), run operations within Docker, then destroy the VMs.

* [This image on the Docker hub](http://hub.tribus.studio/TribusStudio/jenkins)
* [This image on GitHub](https://github.com/TribusStudio/docker-jenkins)
