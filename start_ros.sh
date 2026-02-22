# 正常构建+启动
docker-compose -f docker/docker-compose.yml up --build  -d
#--force-recreate

# # 删除所有旧容器（即使停止或异常）
# docker rm -f $(docker ps -aq)
# # 重新 build 并启动容器
# docker-compose -f docker/docker-compose.yml up --build --force-recreate -d