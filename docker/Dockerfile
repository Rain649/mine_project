# 1. 指定基础镜像
FROM osrf/ros:humble-desktop

# 2. 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# 3. 换源并安装基础工具
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
# ... 前面的内容保持不变 ...

# 4. 改用 rosdepc (国内加速版)
# 安装 python3-pip 以便安装 rosdepc
RUN apt-get update && apt-get install -y python3-pip && \
    pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple rosdepc && \
    rosdepc init && \
    rosdepc update

# 5. 设置工作目录
# 设置workspace名称
ENV WS=/home/dev/mine_ws
# 创建workspace
RUN mkdir -p $WS/src
# 设置工作目录
WORKDIR $WS

# 6. 自动安装依赖
# 先拷贝 src 目录
COPY ./src ./src
# 使用 rosdepc 扫描依赖并安装
# 这里加上 --rosdistro humble 确保环境正确
RUN apt-get update && \
    rosdepc install --from-paths src --ignore-src -y --rosdistro humble && \
    rm -rf /var/lib/apt/lists/*

# 7. 环境配置
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc

# 优化 GUI 变量
ENV QT_X11_NO_MITSHM=1

# 默认指令
CMD ["bash"]


