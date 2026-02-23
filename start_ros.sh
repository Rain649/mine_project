# # 正常构建+启动
# docker-compose -f docker/docker-compose.yml up --build  -d
# #--force-recreate

# 删除所有旧容器（即使停止或异常）
docker rm -f $(docker ps -aq)
# 重新 build 并启动容器
docker-compose -f docker/docker-compose.yml up --build --force-recreate -d

# 删除所有旧镜像（即使被容器使用）
docker images -aq  # 列出所有镜像 ID
docker rmi -f $(docker images -aq)