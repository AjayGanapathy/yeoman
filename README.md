# Dockerized-Yeoman
This dockerfile builds a container with [yeoman](http://yeoman.io), [generator-gulp-angular](https://github.com/swiip/generator-gulp-angular#readme). I wrote this dockerfile because yeoman does not run as the root, and default docker containers run executables as root. This means that if you spin up a docker container and then try to run yeoman, [it will fail](https://github.com/yeoman/yeoman.github.io/issues/282).
### Installation
1. [Set up Docker on Mac OS X.](https://docs.docker.com/mac/ "Docker for Mac Quick Start")
2. Open the Docker CLI from within Kitematic ![Cursor pressing the ‘docker CLI’ button in the lower-left-hand corner of the kitematic window](https://i.imgur.com/quKAxcG.gif) 
3. Then change the directory to the `yeoman-docker` folder in this project's root:
```shell
cd ~/my-repository/yeoman-docker
```
Replace `my-repository` with project's root. This folder should contain a file named `dockerfile`.

4. Build the docker image with the following command:
  ```shell
  docker build .
  ```
  The output of this command should look like [this](https://asciinema.org/a/36633).
5. Once the docker image has built, run it:
  ```shell
  docker run -dit my-image-hash
  ```
  Replace `my-image-hash` with the unique identifier that docker gave to your image after building it e.g. [`fa817ac6674d`](https://asciinema.org/a/36633?t=10&autoplay=0).

### Usage

1. Sync your project's root folder to the docker container's shared volume with Kitematic ![Cursor switching to the docker container’s ‘settings’ tab, then selecting the ‘volumes’ sub-tab, and finally pressing the ‘change’ button next to the volume to connect](https://i.imgur.com/tdJd9qV.gif)
2. Map the docker container ports to the docker host. In this docker container, ports `3000` and `3001` are exposed. Port `3000` is where browser sync serves the site, and port `3001` is where it serves its own control panel. To keep things simple, you might want to map the port on the docker container to the same port number in Kitematic, *i.e.* port `3000` on the docker container maps to the IP address and port `192.168.99.100:3000` in Kitematic, and port `3001` maps to `192.168.99.100:3001`. However, if those ports are already mapped to another application, such as a MongoDB server or docker container, you can map them to whatever available ports you have.![Cursor selecting docker container, then ‘settings’ tab, then ‘ports’ sub-tab, then entering port numbers 3000 and 3001 in the text input fields underneath the ‘MAC IP:PORT’ header](https://i.imgur.com/r2cv7zE.gif)
3. Shell into the docker container. ![Cursor pressing the ‘exec’ button in kitematic](https://i.imgur.com/krIbsQg.gif)
3. serve the site with the following command: 
```shell
gulp serve
```
4. Find the IP Address to which the site is being served in kitematic, and enter it into your browser’s URL bar to navigate to the running site. ![`gulp serve` command entered into the docker container shell, followed by cursor switching to the ‘settings’ tab and ‘ports’ sub-tab before hovering over the IP address listed under ‘configure ports’ ](https://i.imgur.com/uT14x81.gif)

### Roadmap
This is not a full-fledged project with semantic versioning. However, I might add the following features later if it is convenient for me:
- bash completions
- automatically run `npm install && bower install` on container startup as yeoman user, before dropping to a shell.

> If you take the time to add these features, just send me a PR and I’ll merge them in!