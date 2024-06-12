FROM jenkins/jenkins:jdk17

COPY docker-resources /docker-resources

# Using user root to avoid erro:
# E: List directory /var/lib/apt/lists/partial is missing. - Acquire (13:
# Permission denied)
USER root
RUN cd /docker-resources && ./build.sh && rm -rf /docker-resources
USER jenkins
