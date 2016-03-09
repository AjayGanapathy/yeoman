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
2. Shell into the docker container. ![Cursor pressing the ‘exec’ button in kitematic](https://i.imgur.com/krIbsQg.gif)
3. Install a generator of your choice with the following command: 
```shell  
npm install generator-of-my-choice
```
Replace `generator-of-my-choice` with one of the many available [Yeoman generators](http://yeoman.io/generators/). 
>**Note:** not every yeoman generator works inside a docker container. For example, some generators rely on node-native modules that only work on OS X. These generators will break if you try to run them in a debian-linux-based docker container.

4. Uncomment **line 39** in `Dockerfile` to expose the ports that your generator serves webpages on. Then, change the port numbers from `3000-3001` to whatever ports your generator uses. For example, if you use [generator-angular-fullstack](https://github.com/angular-fullstack/generator-angular-fullstack) you would change the port number to `9000`, since that’s the port that the generator’s express server listens on.
5. Map the ports you just exposed in the docker machine to the ports that you want to use to access your web site.![Cursor selecting docker container, then ‘settings’ tab, then ‘ports’ sub-tab, then entering port numbers 3000 and 3001 in the text input fields underneath the ‘MAC IP:PORT’ header](https://i.imgur.com/r2cv7zE.gif)

### Roadmap
This isn’t a full-fledged project with semantic versioning. However, there are two additions I might make in the future: 
- Bash completions
- automatic run of `npm install` on container startup  

>If you go ahead and add this functionality in, send me a PR and I’ll merge it!