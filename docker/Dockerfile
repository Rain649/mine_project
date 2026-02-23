FROM osrf/ros:humble-desktop

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV WS=/mine_ws

# 基础工具安装
RUN sed -i 's/archive.ubuntu.com/mirrors.huaweicloud.com/g' /etc/apt/sources.list && \
    apt-get update && apt-get install -y \
    ros-humble-foxglove-bridge \
    build-essential \
    cmake \
    python3-pip \
    python3-colcon-common-extensions \
    git \
    nano \
    && rm -rf /var/lib/apt/lists/*

# rosdepc 安装
RUN pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple rosdepc && \
    rosdepc init && rosdepc update

# 创建 workspace
RUN mkdir -p $WS/src
WORKDIR $WS

# 拷贝 src 前先安装依赖
# COPY ./src/package.xml ./src/
# RUN rosdepc install --from-paths src --ignore-src -y --rosdistro humble
COPY ./src ./src
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc

# 环境变量
ENV QT_X11_NO_MITSHM=1

# 容器启动直接运行 talker
CMD ["/bin/bash"]