---
![1_Wu-YcRkS4CQUFQcY_rcdtw](https://github.com/amaitou/Inception/assets/49293816/5f0c3aab-72e9-4f4c-8d0f-db81d31a32b2)

---

# Inception

This project aims to broaden your knowledge of system administration by using Docker. You will virtualize several Docker images, creating them in your new personal virtual machine.

---

# What is Docker?

![Untitled](https://github.com/amaitou/Inception/assets/49293816/b775e5de-c6de-4b22-a57c-16eb46e6cdb8)

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

	delete or forcibly the image
	```sh
	# delete the image if the container if not running
	docker image rm <image name>
	# delete the image if the container running
	docker image rm -f <image name>
	```

	list images
	```sh
	docker image ls -a
	```

	---

- ### Container

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
	docker container start <container name>
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

![0_UwEFPqwwpht9ULT4](https://github.com/amaitou/Inception/assets/49293816/96cc9948-522b-4f59-bb55-98020c514a07)


Docker has two options for containers to store files on the host machine, so that the files are persisted even after the container stops: volumes, and bind mounts. Docker also supports containers storing files in memory on the host machine. Such files do not persist.

- ### Volumes

	![g-drive](https://github.com/amaitou/Inception/assets/49293816/d79468d4-b61f-42e9-abee-6e7b050515f5)


	Docker volumes are a way to persistently store and manage data outside of the container's writable layer. Volumes are Docker-managed directories or file systems that are mounted into containers. They are separate from the container's file system, making them ideal for storing data that needs to survive container life cycles.

	Let's create a volume in docker and attach it to the container

	```sh
	# You can create a Docker volume using the `docker volume create` 
	docker volume create <volume name>
	# Use the -v or --volume flag with the docker run command to attach a volume to a container.
	docker run -v <volume name>:<path in container> <image name>
	```

- ### Mount

  	![docker-bind-mounts](https://github.com/amaitou/Inception/assets/49293816/643ab919-7b6a-459a-8333-58ee7541835b)


	Mounts, on the other hand, are a way to bind a file or directory from the host system into a container. Mounts can be used to provide containers with access to specific files or directories on the host. This approach allows containers to interact with files from the host system in real time.

	```sh
	# Use the -v or --volume flag with the docker run command to mount a host directory into a container.
	docker run -v <path on host>:<path in container> <image name>
	```

- ### The Difference between Volume and Mount

	The primary distinction between volumes and mounts in Docker lies in their purpose and how they interact with containers:

- ### Data Persistence:

	Volumes are primarily used for data persistence. They are managed by Docker and are designed to outlive the containers they are associated with. This makes volumes suitable for storing important data like databases, application logs, and configurations that need to persist beyond container instances.

- ### Real-time Interaction:

	Mounts, on the other hand, are meant for real-time interaction between the host and containers. They allow containers to access files and directories on the host, which is valuable for development, debugging, or sharing resources without the need for copying data into the container.

> Volumes are designed for data persistence and are ideal for storing critical data, while mounts facilitate real-time interaction between containers and the host system.

# Docker Network

![1200px-network-monitoring-for-docker](https://github.com/amaitou/Inception/assets/49293816/4bb1c21b-c01c-4ac0-add9-92f46be68dff)


A Docker network is a communication bridge between different containers and between containers and the host system. It enables isolated containers to communicate with each other while providing a level of security and abstraction.

- ### Type of Docker Networks

	- ##### Bridge Network

	![bridge2](https://github.com/amaitou/Inception/assets/49293816/0a1a3c7b-650a-46d0-b494-abf0d1955919)


	Default network created when Docker is installed. It allows containers on the same host to communicate.
	ex ->  Running a web server container and a database container that need to interact with each other.
		
	```sh
	# Create your user-defined bridge network
	docker network create my-bridge-network
	# Attach the network with a container using --network
	docker run --network=my-bridge-network -d web-server
	```
	---

	- #### Host Network
	Containers share the host network stack, meaning they can directly access ports on the host.
	ex -> Suitable for high-performance scenarios where networking isolation is not a concern.
	
	```sh
	docker run --network=host -d web-server
	```

	> There are other several types of docker networks but I'm not going to cover them over here since these are the only two types of networks you need to know so far.

	When you create a bridge network in Docker, it essentially acts as a software switch, allowing containers to communicate with each other and with the host system. This bridge network provides a layer of abstraction, isolating the containers from each other while still enabling communication.

	**IP Address Assignment** <br />
	The Docker daemon, responsible for managing containers, assigns an IP address to the container from the bridge network's subnet.

	let's give an example right?

	first, of all let's create our `user-defined network` using `docker network create` and give it a particular name which is in our case "my_network"

	```sh
	docker network create my_network
	```

	once you do this this network will be added to the list of networks within docker you can check all of them by typing

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

	> Check your address within your host you will see your interfaces but there will be more interfaces one docker is called `docker0`, this last is created by docker and whenever you create a container it is given an IP Address within the subnet of `docker0` the same goes for a network that you may create and link containers with it.
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
