FROM debian:buster


RUN apt update -y
RUN apt install -y procps vim wget
RUN wget https://github.com/google/cadvisor/releases/download/v0.37.0/cadvisor \
	&& chmod +x cadvisor \
	&& cp cadvisor /usr/local/bin


CMD ["/usr/local/bin/cadvisor"]
