FROM python

# add requirements.txt from this folder, to the /app folder (we are going to use this folder in the container to contain everything we need)
ADD requirements.txt /app/requirements.txt
# set as working directory "/app" so that when we enter/execute in the docker container, we are in the right folder
WORKDIR /app

# install dependencies to the image.
# If you don't install a package now and you install it in the container,
# when you reboot the container this will be lost.
# Rebooting a container is like resetting a git repository from the master.
# Things not written in the dockerfile are not committed, so they will be lost.
# Unless they are files in a volume, so we will be using a volume to contain the data and scripts.
RUN pip install -r requirements.txt

# Set a default command to run when the container is started, if not customised otherwise.
# In this case, just run bash to have an interactive shell.
CMD ["bash"]