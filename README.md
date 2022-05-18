# Concepts

## Docker image

It's an environment that you can take from a library of already published oness, or you can define yourself through a `Dockerfile`.

Example:
`python` image, which contains an installation of python with all the required dependencies 

To build a custom image you can use this command (together with the Dockerfile provided)

```bash

# Build a docker image
# -t TAG-NAME is used to give the image a name
docker build . -t docker-example
```

The image is ready to use, but has not been instantiated.

## Docker container

A container is a running instance of an image. You can have multiple instances of the same image.

When you create a container from an image, there are several parameters that can be used to configure it. Usually these parameters are used to set up the links between the container and your local machine, e.g. shared folders (volumes), ports to be forwarded to the container, ...

If we want to run a container based on our image `docker-example`, we can execute:

```bash
# -it means interactive (if we want to be able to run commands inside manually)
# --name NAME gives a name to the docker container
# the last parameter is the name of the image we created before
docker run -it --name docker-example-container-1 docker-example
```

And after this command, we see the prompt inside the container, something like `root@0c1422807df7:/app#`.
We are in the `/app` folder, and if we run `ls` we see that there's only the requirements.txt file that was copied in the definition of the image.

You can exit from the container with CTRL+D or typing exit. The container will be stopped. Instead to keep it running but only detaching the terminal, you can use CTRL+P, CTRL+Q (one after the other).

To see running containers, you can use `docker ps`. To see all containers (also stopped), use `docker ps -a`.

To delete this container, use `docker rm docker-example-container-1`.

To start/stop containers use `docker start docker-example-container-1` and `docker stop docker-example-container-1`.

## Volumes

A volume is a storage unity, that can be attached to containers and can also be seen from the outside. It is useful to make files available inside the container and to save results outside of the container.

If we create a folder here named `shared_folder`, we can use it as a shared folder.

Let's use this shared folder.

```bash
# let's run a container with the same image but with different parameters.
# -v EXTERNAL_PATH:INTERNAL_PATH
# EXTERNAL_PATH is in this case the folder shared_folder inside the current folder (pwd)
# INTERNAL_PATH instead is the location inside the container where we want this folder to be mapped. In this case it's inside the /app folder
docker run -it --name docker-example-container-2 -v `pwd`/shared_folder:/app/shared_folder docker-example
```

If we now do a `ls` in this container, we see that both `requirements.txt` and `shared_folder` are there.
But one comes from the definition of the image, and the other from a volume:
- if you now modify requirements.txt inside the container, this modification will disappear as soon as you shut down the container. If you modify requirements.txt outside the container, the container still has the same old version, so you need to recreate the image again.
- if instead you create or modify or delete files from the shared folder, the changes will also exist outside the container and will remain modified. That's why you need to use volumes for folders that you plan to modify (from the inside or from the outside).

