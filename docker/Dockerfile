# 使用 ROS2 Humble 官方桌面版镜像作为基础
# 已经包含：
# - ROS2
# - rviz2
# - colcon
# - 常用GUI库
FROM osrf/ros:humble-desktop


# 防止 apt 安装时出现交互界面卡住
ENV DEBIAN_FRONTEND=noninteractive


# 定义 ROS2 工作空间路径变量
# 后面统一使用，方便修改
ENV WS=/mine_ws
ENV ROS_DOMAIN_ID=
ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

# 设置容器内工作目录
# 后续所有操作默认在这个目录执行
WORKDIR $WS


# 安装 colcon 和基础工具
# colcon 是 ROS2 编译工具，必须安装
RUN apt-get update && apt-get install -y \
    python3-colcon-common-extensions \
    python3-pip \
    git \
    ros-humble-rmw-cyclonedds-cpp \
    ros-humble-std-msgs \
    && rm -rf /var/lib/apt/lists/*


# 把本地 src 文件夹复制进镜像
# 作用：
#
# 云端 AWS：
#    没有 volumes
#    使用这里的 src
#
# 本地开发：
#    会被 volumes 覆盖
#
COPY src $WS/src

# 安装依赖（可选，根据 package.xml）
RUN . /opt/ros/humble/setup.bash && \
    apt-get update && apt-get install -y python3-colcon-common-extensions && \
    rm -rf /var/lib/apt/lists/*

# 编译工作空间
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && colcon build"


# 设置 bash 自动加载 ROS2 环境
# 否则 ros2 命令无法使用
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc
RUN echo "source /mine_ws/install/setup.bash" >> /root/.bashrc

# 默认启动 bash
# 实际运行逻辑由 docker-compose command 覆盖
# CMD ["/bin/bash"]

CMD ["/bin/bash", "-c", "source /opt/ros/humble/setup.bash && source /mine_ws/install/setup.bash && ros2 run cpp_test talker"]