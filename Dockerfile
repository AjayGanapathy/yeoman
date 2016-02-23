# Yeoman on ubuntu with pre-requisites
FROM ubuntu:latest
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>
RUN apt-get -yq update && apt-get -yq upgrade
# Install pre-requisites
RUN apt-get -yq install python-software-properties \
  software-properties-common \
  python \
  g++ \
  make \
  git \
  ruby-compass \
  libfreetype6
# Install node.js, then npm install yo and the generators
RUN apt-get install -yq curl \
  && curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash - \
  && apt-get -yq install nodejs \
  && apt-get -yq update \
  && npm install -g yo \
  generator-angular2-webpack-starter \
  bower \
  && npm update
# Add a yeoman user because yeoman doesn't like being root
RUN adduser --disabled-password --gecos "" --shell /bin/bash yeoman; \
  echo "yeoman ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ENV HOME /home/yeoman
RUN mkdir /home/yeoman/src \
  && chmod -R 777 /home/yeoman/src \
  # the following line is a security vulnerability and should be fixed. It is there because npm insists on installing globals to /usr, even when it has a prefix inside yeoman's home directory
  && chmod -R 777 /usr
WORKDIR /home/yeoman/src
VOLUME /home/yeoman/src
USER yeoman
EXPOSE 3000
# drop the yeoman user into a bash shell
CMD ["/bin/bash"]
