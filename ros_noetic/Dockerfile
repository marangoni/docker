FROM osrf/ros:noetic-desktop-full

# Argumentos para definir variáveis de ambiente e usuário
ARG USER=user
ARG DEBIAN_FRONTEND=noninteractive

# Atualizar pacotes e instalar dependências ROS e do sistema, incluindo tightvncserver
RUN apt-get update && apt-get install -y --no-install-recommends \
    tightvncserver \
    xfce4 \
    xfce4-goodies \
    xterm \
    sudo \
    ros-noetic-joy \
    ros-noetic-teleop-twist-joy \
    ros-noetic-teleop-twist-keyboard \
    ros-noetic-laser-proc \
    ros-noetic-rgbd-launch \
    ros-noetic-rosserial-arduino \
    ros-noetic-rosserial-python \
    ros-noetic-rosserial-client \
    ros-noetic-rosserial-msgs \
    ros-noetic-amcl \
    ros-noetic-map-server \
    ros-noetic-move-base \
    ros-noetic-urdf \
    ros-noetic-xacro \
    ros-noetic-dynamixel-sdk \
    ros-noetic-turtlebot3-msgs \
    ros-noetic-turtlebot3 \
    ros-noetic-compressed-image-transport \
    ros-noetic-rqt* \
    ros-noetic-rviz \
    ros-noetic-gmapping \
    ros-noetic-navigation \
    ros-noetic-interactive-markers \
    ros-noetic-moveit \
    ros-noetic-ros-controllers \
    ros-noetic-gazebo-ros-control \
    ros-noetic-roboticsgroup-upatras-gazebo-plugins \
    ros-noetic-actionlib-tools \
    ros-noetic-gazebo-ros \
    ros-noetic-gazebo-plugins \
    gazebo11 \
    terminator \
    nano \
    net-tools \
    python3-pip \
    xfonts-base \
    xauth \
    && rm -rf /var/lib/apt/lists/*

# Instalar dependências Python
RUN pip install --no-cache-dir \
    flask \
    flask-ask-sdk \
    ask-sdk

# Instalar dependências para execução do gazebo
RUN apt-get update && apt-get install -y --no-install-recommends \
    mesa-utils \
    libgl1-mesa-glx && \
    rm -rf /var/lib/apt/lists/*

# Instalar o noVNC
RUN apt-get update && apt-get install -y --no-install-recommends \
    novnc websockify && \
    rm -rf /var/lib/apt/lists/*

# Criar o usuário e adicionar permissões de sudo
RUN groupadd -r ${USER} && useradd -m -r -g ${USER} ${USER} && \
    usermod -aG sudo ${USER} && \
    echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    mkdir -p /home/${USER} && chown ${USER}:${USER} /home/${USER}

# Configurar a senha do VNC automaticamente
RUN mkdir -p /root/.vnc && \
    echo "password" > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

# Adicionar o script xstartup para iniciar XFCE com Terminator
RUN mkdir -p /root/.vnc && \
    echo "#!/bin/bash\n" \
         "xrdb $HOME/.Xresources\n" \
         "startxfce4 &\n" \
         "terminator &" > /root/.vnc/xstartup && \
    chmod +x /root/.vnc/xstartup

# Garantir que o comando source seja executado automaticamente
RUN echo "source /opt/ros/noetic/setup.bash" >> /home/${USER}/.bashrc

# Copiar a pasta Dev para o contêiner
COPY Dev /home/${USER}/Dev

# Definir o diretório de trabalho padrão
WORKDIR /home/${USER}

# Alterar para o usuário desejado
USER ${USER}

# Definir o ambiente USER
ENV USER=user

# CMD para iniciar o tightvncserver, o websockify, e o terminator
# CMD ["sh", "-c", "tightvncserver :1 -geometry 1280x1024 -depth 24 && websockify --web=/usr/share/novnc 6080 localhost:5901 & terminator && tail -f /dev/null"]
# CMD para iniciar o tightvncserver, o websockify, e o terminator
CMD ["sh", "-c", "tightvncserver :1 -geometry 1280x1024 -depth 24 && websockify --web=/usr/share/novnc 6080 localhost:5901 & terminator && tail -f /dev/null"]