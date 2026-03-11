FROM jenkins/jenkins:lts-jdk17

USER root

# Install lsb-release
RUN apt-get update && apt-get install -y lsb-release curl gnupg2

# Tambahkan Docker GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | tee /usr/share/keyrings/docker-archive-keyring.asc > /dev/null

# Tambahkan repository Docker
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] https://download.docker.com/linux/debian>
    | tee /etc/apt/sources.list.d/docker.list

# Install Docker CLI
RUN apt-get update && apt-get install -y --no-install-recommends docker-ce-cli

USER jenkins

# Install Jenkins plugins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"
