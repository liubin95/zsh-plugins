#!/bin/zsh

docker-clean-all() {
  # 判断时docker还是podman
  if command -v podman &>/dev/null; then
    DOCKER=podman
  elif command -v docker &>/dev/null; then
    DOCKER=docker
  else
    echo "No docker or podman installed."
    return 1
  fi
  # 删除所有停止的容器
  if [ "$($DOCKER ps -a -q)" ]; then
    $DOCKER rm $($DOCKER ps -a -q)
  else
    echo "No containers to remove."
  fi

  # 清理未使用的卷
  $DOCKER volume prune -f

  # 清理未使用的镜像
  $DOCKER image prune -a -f

  # 清理未使用的系统资源，包括网络和卷
  $DOCKER system prune --volumes -f

  # 清理构建缓存
  $DOCKER builder prune -a -f
}
