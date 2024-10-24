---
![1_Wu-YcRkS4CQUFQcY_rcdtw](https://github.com/amaitou/Inception/assets/49293816/4826f89d-4754-47e8-b027-0ad4d47c34a0)

---

# Table of contents:

- [Inception](https://github.com/amaitou/Inception?tab=readme-ov-file#inception)
- [What is Docker?](https://github.com/amaitou/Inception?tab=readme-ov-file#what-is-docker)
- [Commands](https://github.com/amaitou/Inception?tab=readme-ov-file#commands)
	- [image](https://github.com/amaitou/Inception?tab=readme-ov-file#image)
	- [container](https://github.com/amaitou/Inception?tab=readme-ov-file#container)
- [Data Persistence](https://github.com/amaitou/Inception?tab=readme-ov-file#data-persistence)
	- [Volumes](https://github.com/amaitou/Inception?tab=readme-ov-file#volumes)
	- [Mount](https://github.com/amaitou/Inception?tab=readme-ov-file#mount)
	- [The Difference between Volume and Mount](https://github.com/amaitou/Inception?tab=readme-ov-file#the-difference-between-volume-and-mount)
		- [Data Persistence](https://github.com/amaitou/Inception?tab=readme-ov-file#data-persistence-1)
		- [Real-time Interaction](https://github.com/amaitou/Inception?tab=readme-ov-file#real-time-interaction)
- [Docker Network](https://github.com/amaitou/Inception?tab=readme-ov-file#docker-network)
	- [Type of Docker Networks](https://github.com/amaitou/Inception?tab=readme-ov-file#type-of-docker-networks)
		- [Bridge Network](https://github.com/amaitou/Inception?tab=readme-ov-file#bridge-network)
		- [Host Network](https://github.com/amaitou/Inception?tab=readme-ov-file#host-network)
	- [IP Address Assignment](https://github.com/amaitou/Inception?tab=readme-ov-file#ip-address-assignment-)
- [Docker-Compose](https://github.com/amaitou/Inception?tab=readme-ov-file#docker-compose)
- [Docker-Compose Commands](https://github.com/amaitou/Inception?tab=readme-ov-file#docker-compose-commands)
- [PID 1 (Process ID 1)](https://github.com/amaitou/Inception?tab=readme-ov-file#pid-1-process-id-1)

---

# Inception

This project aims to broaden your knowledge of system administration by using Docker. You will virtualize several Docker images, creating them in your new personal virtual machine.

---

# What is Docker?

Docker is a platform and tool designed to help developers, system administrators, and DevOps engineers create, deploy, and run applications in containers. Containers are lightweight and portable units that can package an application and its dependencies, including libraries and runtime, into a single image. Docker provides a way to automate the deployment of applications in a consistent and predictable manner, regardless of the environment they are running in.

Here are Docker's key components:

- `Docker Engine`: This is the kernel of docker, it is responsible for building running, and managing containers.
- `Docker Image`: A snapshot of a filesystem that includes all things we need to run an application, including the code, runtime environments, parent images, libs ...etc
- `Docker Container`: An instance of a Docker image that can be run, started, stopped, moved, and deleted. Containers are isolated from each other and the host system.
- `Dockerfile`: A text file that contains a set of instructions for building a Docker image. It defines the base image, adds application code, sets environment variables, and configures the container's behavior.
- `Docker Hub`: A public cloud-based registry where Docker images can be stored, shared, and distributed. Docker Hub provides a vast repository of public images that can be used as a base for your containers.
- `Docker Compose`: A tool for defining and running multi-container applications using a simple YAML file. It allows you to define the services, networks, and volumes for your application stack.
- `Docker Daemon`: listens for Docker API requests and manages Docker objects such as images, containers, networks, and volumes
- `Docker namespaces`: Docker uses a technology called namespaces to provide an isolated workspace called a container. when you run a container, Docker creates a set of namespaces for that container. These namespaces provide a layer of isolation namespace and its access is limited to that namespaces.



---

# Commands

Running a container or creating an image typically involves using containerization platforms like Docker, and Podman, or container orchestrators like Kubernetes.

But in this article, we will be using the `docker` (u can use either the docker CLI or GUI)

---

- ### Image

	![image](https://github.com/amaitou/Inception/assets/49293816/36006ea3-f2d1-4828-b176-45a6bbb857e8)

	if you want to create an image for a container to run an app, you must what's called a Dockerfile, this is like the file that contains to set up the Docker image for you

	```dockerfile
	# Use an official Node.js runtime as the base image
	FROM node:14

	# Set the working directory inside the container
	WORKDIR /app

	# Copy package.json and package-lock.json to the container
	COPY package*.json ./

	# Install project dependencies
	RUN npm install

	# Copy the rest of the application code
	COPY . .

	# Expose a port (if your application requires it)
	EXPOSE 8080

	# Define the command to run your application
	CMD [ "node", "app.js" ]
	```

	This is the command for creating your image based on your dockerfile

	```sh
	docker image build --tag <image name>:<tag>
	```

	`<image name>:<tag>` -> This command will allow you to name your created image

	delete or forcibly delete the image
	```sh
	# delete the image if the container is not running
	docker image rm <image name>
	# delete the image if the container is running
	docker image rm -f <image name>
	```

	list all images
	```sh
	docker image ls -a
	```

	---

- ### Container

	![container](https://github.com/amaitou/Inception/assets/49293816/27293798-14e9-4d08-81ab-93180a5f93b7)


	after creating your image, a container must be created right now to run the app properly, when running a container you can run it simply by typing

	```sh
	docker container run --name <container name> -p <host_port>:<container_port> <image name>
	```

	- `--name` -> This command allows you to name your created container
	- `-p` -> This option maps a port on your host machine to a port inside the container.

	start or stop a container
	```sh
	# start a container
	docker container start <container name>
	# stop a container
	docker container stop <container name>
	```

	delete or force the deletion of the container
	```sh
	# delete the container if the container is not running
	docker container rm <container name>
	# delete forcibly the container if the container is running
	docker container rm --force <container name>
	```

	list containers
	```sh
	# List all running and active container
	docker container ls
	#list all containers including running and stopped ones
	docker container ls -a
	```

---

# Data Persistence

![data_persistent](https://github.com/amaitou/Inception/assets/49293816/5ee74e81-c8c0-410f-a5f2-d00ac17f8b81)


Docker has two options for containers to store files on the host machine, so that the files are persisted even after the container stops: volumes, and bind mounts. Docker also supports containers storing files in memory on the host machine. Such files do not persist.

- ### Volumes

	![volume](https://github.com/amaitou/Inception/assets/49293816/7b8c7284-fa46-44f5-975f-c57243f0a4dd)


	Docker volumes are a way to persistently store and manage data outside of the container's writable layer. Volumes are Docker-managed directories or file systems that are mounted into containers. They are separate from the container's file system, making them ideal for storing data that needs to survive container life cycles.

	Let's create a volume in docker and attach it to the container

	```sh
	# You can create a Docker volume using the `docker volume create` 
	docker volume create <volume name>
	# Use the -v or --volume flag with the docker run command to attach a volume to a container.
	docker run -v <volume name>:<path in container> <image name>
	```
	---

- ### Mount

	![mount](https://github.com/amaitou/Inception/assets/49293816/587b2d4f-b833-445e-a6a3-b9ec1aba1df7)


	Mounts, on the other hand, are a way to bind a file or directory from the host system into a container. Mounts can be used to provide containers with access to specific files or directories on the host. This approach allows containers to interact with files from the host system in real time.

	```sh
	# Use the -v or --volume flag with the docker run command to mount a host directory into a container.
	docker run -v <path on host>:<path in container> <image name>
	```
	---

### The Difference between Volume and Mount

The primary distinction between volumes and mounts in Docker lies in their purpose and how they interact with containers:

- ### Data Persistence:

	Volumes are primarily used for data persistence. They are managed by Docker and are designed to outlive the containers they are associated with. This makes volumes suitable for storing important data like databases, application logs, and configurations that need to persist beyond container instances.

	---

- ### Real-time Interaction:

	Mounts, on the other hand, are meant for real-time interaction between the host and containers. They allow containers to access files and directories on the host, which is valuable for development, debugging, or sharing resources without the need for copying data into the container.

	---

> Volumes are designed for data persistence and are ideal for storing critical data, while mounts facilitate real-time interaction between containers and the host system.

---

# Docker Network

![net](https://github.com/amaitou/Inception/assets/49293816/32496f5c-a432-438e-ba44-8b0d74a76f26)


A Docker network is a communication bridge between different containers and between containers and the host system. It enables isolated containers to communicate with each other while providing a level of security and abstraction.

- ### Type of Docker Networks

	- ##### Bridge Network

	Default network created when Docker is installed. It allows containers on the same host to communicate. <br />
	ex ->  Running a web server container and a database container that need to interact with each other.
		
	```sh
	# Create your user-defined bridge network
	docker network create my-bridge-network
	# Attach the network with a container using --network
	docker run --network=my-bridge-network -d web-server
	```
	---

	- #### Host Network
	Containers share the host network stack, meaning they can directly access ports on the host. <br />
	ex -> Suitable for high-performance scenarios where networking isolation is not a concern.
	
	```sh
	docker run --network=host -d web-server
	```

	> There are other several types of docker networks but I'm not going to cover them over here since these are the only two types of networks you need to know so far.

	When you create a bridge network in Docker, it essentially acts as a software switch, allowing containers to communicate with each other and with the host system. This bridge network provides a layer of abstraction, isolating the containers from each other while still enabling communication.

	---

	### **IP Address Assignment** <br />
	The Docker daemon, responsible for managing containers, assigns an IP address to the container from the bridge network's subnet.

	let's give an example right?

	first of all, let's create our `user-defined network` using `docker network create` and give it a particular name which is in our case "my_network"

	```sh
	docker network create my_network
	```

	once you do this, the network will be added to the list of networks within docker. <br /> 
	you can check all of them by typing:

	```sh
	docker network ls
	```

	once you press enter you will see your created network among the other networks two of which are :

	```sql
	NETWORK ID     NAME      DRIVER    SCOPE
	abcdef123456   bridge    bridge    local
	ghijkl789012   host      host      local
	```

	-> bridge: this is the bridge network that is used by docker in the default mode <br />
	-> host: this is the host network if you want to link your containers directly with the host machine (lack of isolation)

	> Check your address within your host, you will see your interfaces but there will be more interfaces. one for docker and called `docker0`, this last is created by docker and whenever you create a container it is given an IP Address within the subnet of `docker0` the same goes for a network that you may create and link containers with it.
	the default IP range of `docker0` is `172.17.0.1/16`

	**Checking docker0**

	```sh
	# first way
	ifconfig docker0
	# second way
	ip address | grep docker0
	```
	you must see something similar to this output:

	```
	3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
	```

	again, the same goes for your created network it has the same features as the docker0 but a different IP range.

	to check the containers that are linked with your created network just type:

	```sh
	docker network inspect <network name>
	```

	in the output look for a key called `containers`, and then you will see the ID of each container you have linked with your network besides the IP address.

---

# Docker-Compose

![compose](https://github.com/amaitou/Inception/assets/49293816/c7cf2fd8-a473-43c5-b660-753148be9ffd)


Docker Compose is a tool for defining and running multi-container Docker applications. It allows you to define an entire application stack, including services, networks, and volumes, in a single file called docker-compose.yml. This file provides a way to configure and link multiple containers together, specifying how they should interact.

In the docker-compose.yml file, you define the services, networks, and volumes for your application. Each service represents a container, and you can specify various settings for each service, such as the Docker image to use, environment variables, ports to expose, and more.

when it comes to docker-compose, once you build the image, the docker-compose reads the instructions from the docker-compose.yaml then creates the volumes, networks, builds images, and runs containers as well so it is much easier than building and running each container alone.

Here is an example of how a docker-compose.yaml should be (this example was taken from my project):

```yaml

version: '3'

networks:
    inception:
        name: $NETWORK_NAME
        driver: bridge

volumes:
    mariadb:
        driver_opts:
            type: none
            o: bind
            device: $MARIADB_VOLUME_PATH
        name: $MARIADB_VOLUME_NAME

services:
    nginx:
        expose:
            - $NGINX_PORT
        container_name: $NGINX_NAME
        image: $NGINX_IMAGE
        build:
            context: ./requirements/nginx/.
        stdin_open: true
        tty: true
        ports:
            - $NGINX_PORT:$NGINX_PORT
        restart: on-failure
        networks:
            - $NETWORK_NAME
        depends_on:
            - $WORDPRESS_NAME
        env_file:
            - .env
        volumes:
            - wordpress:/var/www/html/wordpress   
```

in this example, we have four services:

- MariaDB, which is the database
- Nginx, which is the proxy and web server
- Admirer, which visualizes our MariaDB database
- WordPress, which is our official website

each service contains several keys, let's dive into and explain each one of them:

> container_name -> This is the name that you wanna name your container

---

> image -> This is the base that you wanna create (it might be a pulled image from the docker hub)

---

> stdin_open -> is used to open the standard input (stdin) of the container.

---

> tty -> allocates a pseudo-TTY (terminal) for the container, which is often used in conjunction with stdin_open to allow interactive command-line sessions.

---

> restart -> This key tells the docker-compose the restarting mode of our container, we can restart it always or on failure ...etc

---

> networks -> the specified network for this container

---

> build -> the exact location of our dockerfile

---

> depends_on -> Do not start the current until you start the service we are depending on

---

> volumes -> the volumes attached with the container for data persistent

---

> env_file -> Let's docker-compose expands the environment variables from this path file which is in our case .env

---

> ports -> allow us to match a host machine port with the container port

---

In recent versions of Dockerfile, EXPOSE doesn't have any operational impact anymore, it is just informative. meanwhile, ports, property defines the ports that we want to expose from the container. But unlike with the expose configuration, these ports will be accessible internally and published on the host machine.

---
# Docker-Compose Commands

![image-16](https://github.com/amaitou/Inception/assets/49293816/b2a949ae-0e48-4d7f-9741-2ba68590c67c)


with docker-compose you can manage your docker containers however you want, the way you want since that last provides flexible control, here are some common docker-compose commands:

- `up`      -> create and start containers
- `down`    -> stops and removes containers, networks, volumes, and other services
- `build`   -> build images
- `exec`    -> run a command in a running container
- `stop`    -> stop running containers
- `start`   -> start existing containers
- `ps`      -> lists all running containers
- `restart` -> restart a running containers
- `config`  -> validates and shows the configuration of your docker-compose.yml file.

----

# PID 1 (Process ID 1)

![id](https://github.com/amaitou/Inception/assets/49293816/aa8519bf-589c-4fb9-835f-3b1d1cdfd045)


If we want what is PID 1 in docker, we must first know what is PID 1 itself and what its relation with Linux.

In a Unix-like operating system, Process ID 1, often referred to as PID 1, is a special process known as the init process. The init process is the first process started by the kernel during the system boot process, and it has a PID of 1.

The init process has a crucial role in the system. It is responsible for initializing the system and starting other processes. In modern Linux systems, init has been replaced by more advanced init systems such as systemd.

after we have covered what's PID in Linux we can say the same idea goes over here in our dockerfile, In Docker, the PID 1 inside a container is typically the main process that is specified in the container's entry point or command. Docker containers are designed to run a single main process, and when that process exits, the container is considered to have completed its task and will be stopped. <br />

In the example of the MariaDB container, the `mysqld` becomes the main process, and Docker will run it as PID 1 inside the container. 

---

⚠️ I have explained all you need to start using docker, but I'm not gonna explain the projects because it doesn't make any sense. people should learn by practicing, solving the problems they face as well trying to be creative on their way.

---

### **Contact Me**

* [Twitter][_1]

[_1]: https://twitter.com/amait0u
