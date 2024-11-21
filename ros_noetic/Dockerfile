# Use a imagem base do ROS Noetic com GUI completa
FROM osrf/ros:noetic-desktop-full

# Argumentos para definir variáveis de ambiente e usuário
ARG USER=user
ARG DEBIAN_FRONTEND=noninteractive

# Atualizar pacotes e instalar dependências ROS e do sistema
RUN apt-get update && \
    apt-get install -y \
        ros-noetic-moveit \
        ros-noetic-ros-controllers \
        ros-noetic-gazebo-ros-control \
        ros-noetic-rosserial \
        ros-noetic-rosserial-arduino \
        ros-noetic-roboticsgroup-upatras-gazebo-plugins \
        ros-noetic-actionlib-tools \
        ros-noetic-gazebo-ros \
        ros-noetic-gazebo-plugins \
        gazebo11 \
        terminator \
        nano \
        python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Instalar dependências Python
RUN pip install --no-cache-dir \
    flask \
    flask-ask-sdk \
    ask-sdk

# Instalar dependências para execução do gazebo
RUN apt update && apt install -y mesa-utils libgl1-mesa-glx

# Criar o usuário e o diretório home
RUN groupadd -r ${USER} && useradd -m -r -g ${USER} ${USER} && \
    mkdir -p /home/${USER} && chown ${USER}:${USER} /home/${USER}

# Garantir que o comando source seja executado automaticamente
RUN echo "source /opt/ros/noetic/setup.bash" >> /home/${USER}/.bashrc

# Definir o diretório de trabalho padrão
WORKDIR /home/${USER}

# Alterar para o usuário desejado
USER ${USER}
