#!/bin/zsh

clean-cache() {
  echo "🧹 开始清理系统缓存..."
  echo ""

  # docker
  if command -v docker &>/dev/null; then
    echo "🐳 清理 Docker 缓存..."
    docker system prune -a -f --volumes
    echo "✅ Docker 缓存已清理"
  else
    echo "❌ Docker 未安装"
  fi
  echo ""

  # podman
  if command -v podman &>/dev/null; then
    echo "📦 清理 Podman 缓存..."
    podman system prune -a -f --volumes
    echo "✅ Podman 缓存已清理"
  else
    echo "❌ Podman 未安装"
  fi
  echo ""

  # Homebrew
  if command -v brew &>/dev/null; then
    echo "🍺 清理 Homebrew 缓存..."
    brew cleanup --prune=all 2>/dev/null \
      && echo "  ✅ Homebrew 缓存已清理"
    brew autoremove 2>/dev/null \
      && echo "  ✅ Homebrew 孤立依赖已移除"
    echo "✅ Homebrew 缓存清理完成"
  else
    echo "❌ Homebrew 未安装"
  fi
  echo ""

  # uv - Python package manager
  if command -v uv &>/dev/null; then
    echo "🐍 清理 Python/uv 缓存..."

    # Clean uv cache
    uv cache clean 2>/dev/null \
      && echo "  ✅ uv 缓存已清理"

    # Clean pip cache if available
    if command -v pip &>/dev/null; then
      pip cache purge 2>/dev/null \
        && echo "  ✅ pip 缓存已清理"
    fi

    echo "✅ Python/uv 缓存清理完成"
  else
    echo "❌ uv 未安装"
  fi
  echo ""

  # Go
  if command -v go &>/dev/null; then
    echo "🔵 清理 Go 缓存..."
    go clean -cache 2>/dev/null \
      && echo "  ✅ Go 构建缓存已清理"
    go clean -modcache 2>/dev/null \
      && echo "  ✅ Go 模块缓存已清理"
    go clean -testcache 2>/dev/null \
      && echo "  ✅ Go 测试缓存已清理"
    echo "✅ Go 缓存清理完成"
  else
    echo "❌ Go 未安装"
  fi
  echo ""

  # nvm - 检查是否安装并可用
  if [[ -n "$NVM_DIR" ]] \
    && [[ -s "$NVM_DIR/nvm.sh" ]]; then
    # 确保 nvm 已加载
    source "$NVM_DIR/nvm.sh"

    if type nvm &>/dev/null; then
      echo "🟢 清理 Node.js 缓存..."

      # 获取已安装的 Node.js 版本
      nvm ls --no-colors --no-alias 2>/dev/null \
        | \
        grep -oE "v[0-9]+\.[0-9]+\.[0-9]+" \
        | \
        while read -r version; do
          echo "  📦 清理 Node.js $version 缓存"

          # npm cache clean
          if nvm exec "$version" npm --version &>/dev/null; then
            nvm exec "$version" npm cache clean --force 2>/dev/null \
              && \
              echo "    ✅ npm 缓存已清理 ($version)"
          fi

          # npx cache clean (如果支持)
          if nvm exec "$version" npx --version &>/dev/null; then
            nvm exec "$version" npx cache clean --force 2>/dev/null \
              && \
              echo "    ✅ npx 缓存已清理 ($version)" \
              || \
              echo "    ⚠️  npx 缓存清理不支持 ($version)"
          fi

          # yarn cache clean
          if nvm exec "$version" yarn --version &>/dev/null; then
            nvm exec "$version" yarn cache clean 2>/dev/null \
              && \
              echo "    ✅ yarn 缓存已清理 ($version)"
          fi

          # pnpm store prune
          if nvm exec "$version" pnpm --version &>/dev/null; then
            nvm exec "$version" pnpm store prune 2>/dev/null \
              && \
              echo "    ✅ pnpm 存储已清理 ($version)"
          fi
        done

      echo "✅ Node.js 缓存清理完成"
    else
      echo "❌ nvm 已安装但加载异常"
    fi
  else
    echo "❌ nvm 未安装或 NVM_DIR 未设置"
  fi
  echo ""
  echo "🎉 系统缓存清理完成！"
}

function main() {
  clean-cache
}

main "$@"
