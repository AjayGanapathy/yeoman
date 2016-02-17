# Yeoman with some generators and prerequisites
FROM ubuntu:saucy
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>
RUN apt-get -yq update && apt-get -yq upgrade
# Install pre-requisites
RUN apt-get -yq install python-software-properties software-properties-common \
                      python g++ make git ruby-compass libfreetype6
# Install node.js, then npm install yo and the generators
RUN add-apt-repository ppa:chris-lea/node.js -y \
  && apt-get -yq update \
  && apt-get -yq install nodejs \
  && npm install yo -g \
  && npm install -g generator-mcfly-ng2 \
  && npm install gulp \
  && npm install bower
# Add a yeoman user because grunt doesn't like being root
RUN adduser --disabled-password --gecos "" yeoman; \
  echo "yeoman ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ENV HOME /home/yeoman
USER yeoman
WORKDIR /home/yeoman
# Expose the port
EXPOSE 3000
# Always run as the yeoman user
CMD ['/bin/bash']
