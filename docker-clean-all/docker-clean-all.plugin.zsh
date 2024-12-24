#!/bin/zsh

docker-clean-all() {
  # 删除所有停止的容器
  if [ "$(docker ps -a -q)" ]; then
    docker rm $(docker ps -a -q)
  else
    echo "No containers to remove."
  fi

  # 清理未使用的卷
  docker volume prune -f

  # 清理未使用的镜像
  docker image prune -a -f

  # 清理未使用的系统资源，包括网络和卷
  docker system prune --volumes -f

  # 清理构建缓存
  docker builder prune -a -f
}
