# 以最新的Ubuntu镜像为模板
FROM ubuntu:22.04

# 将本目录下的sources.list作为容器的一个文件
#ADD sources.list /root/sources.list
# 使用阿里Ubuntu源，更新快
#RUN cp /root/sources.list /etc/apt/sources.list.d/aliyun.list

RUN apt-get update
RUN apt-get install -y openssh-server && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y net-tools && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y neovim && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y tshark && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y iproute2 && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y iputils-ping && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y tshark && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y htop && apt-get clean && rm -rf /var/lib/apt/lists/* && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y fish && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y nmap && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y curl && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get install  -y build-essential && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd
RUN mkdir -p mkdir/root/.ssh/

# 修改root密码，便于远程登录
# 将key生成在指定文件内
RUN  rm -rf  /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -P '' -N ''
# 配置ssh可以使用root登陆
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin prohibit-password/#PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
RUN echo ' PermitRootLogin yes    '  >>  /etc/ssh/sshd_config
RUN echo ' PasswordAuthentication yes   '  >>  /etc/ssh/sshd_config


# 开放22端口
EXPOSE 22


# ENTRYPOINT [ "/bin/bash", "-c","/usr/sbin/sshd  -D  &"  ]  
# ENTRYPOINT [ "/bin/bash", "-c","/usr/sbin/sshd  -D  &"  ]  
# ENTRYPOINT [ "/usr/sbin/sshd", "-D"]  
CMD ["/bin/bash", "-c", "while true; do sleep 1000; done"]

#  docker run -itd -p 2222:22  --restart always   --net host --name ubuntu_docer_desktop_host ubuntu_docer_desktop_host
#  docker run -itd   --restart always   --net host --name ubuntu_docer_desktop_host ubuntu_docer_desktop_host
# docker exec -it ubuntu_with_ssh /bin/bash


# CMD [ "/usr/sbin/sshd  -D &"  ]

#  docker build  -t ubuntu_with_ssh  . &&  docker rm -f ubuntu_with_ssh &&  docker run -d -p 2222:22  --net host --name ubuntu_with_ssh  ubuntu_with_ssh



# RUN apt-get update && apt-get install -y tshark && apt-get clean && rm -rf /var/lib/apt/lists/*
# RUN apt-get update && apt-get install -y iproute2 && apt-get clean && rm -rf /var/lib/apt/lists/*
# RUN apt-get update && apt-get install -y iputils-ping && apt-get clean && rm -rf /var/lib/apt/lists/*
# RUN apt-get update && apt-get install -y htop && apt-get clean && rm -rf /var/lib/apt/lists/*
# RUN apt-get update && apt-get install -y fish && apt-get clean && rm -rf /var/lib/apt/lists/*
# RUN apt-get update && apt-get install -y nmap && apt-get clean && rm -rf /var/lib/apt/lists/*

# RUN mkdir -p /var/run/sshd
# RUN mkdir -p /root/.ssh/

# # 修改root密码，便于远程登录
# RUN echo "root:'" | chpasswd 
# # 将key生成在指定文件内
# RUN rm -rf /etc/ssh/ssh_host_rsa_key
# RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -P '' -N ''
# # 配置ssh可以使用root登陆
# RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

