# Yeoman with some generators and prerequisites
FROM ubuntu:latest
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>
RUN apt-get -yq update && apt-get -yq upgrade
# Install pre-requisites
RUN apt-get -yq install python-software-properties software-properties-common \
                      python g++ make git ruby-compass libfreetype6
# Install node.js, then npm install yo and the generators
RUN apt-get install -yq curl \
  && curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash - \
  && apt-get -yq install nodejs \
  && apt-get -yq update \
  && npm install yo -g \
  && npm install -g generator-mcfly-ng2 \
  && npm install bower \
  && npm update
# Add a yeoman user because grunt doesn't like being root
# RUN apt-get -yq install bash
RUN adduser --disabled-password --gecos "" --shell /bin/bash yeoman; \
  echo "yeoman ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ENV HOME /home/yeoman
RUN mkdir /home/yeoman/src && chmod -R 777 /home/yeoman/src
WORKDIR /home/yeoman/src
VOLUME /home/yeoman/src
USER yeoman
# Expose the port
EXPOSE 5000
# Always run as the yeoman user
CMD ["/bin/bash"]
