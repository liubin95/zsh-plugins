#!/bin/zsh

podman-clean-all() {
  # 删除所有停止的容器
  if [ "$(podman ps -a -q)" ]; then
    podman rm $(podman ps -a -q)
  else
    echo "No containers to remove."
  fi

  # 清理未使用的卷
  podman volume prune -f

  # 清理未使用的镜像
  podman image prune -a -f

  # 清理未使用的系统资源，包括网络和卷
  podman system prune --volumes -f

  # 清理构建缓存
  podman builder prune -a -f
}
