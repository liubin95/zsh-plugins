#!/bin/zsh

# proxy
proxy() {
  local url=http://127.0.0.1:$PROXY_PORT
  export http_proxy=$url https_proxy=$url all_proxy=socks5://127.0.0.1:$PROXY_PORT
  [[ $1 == silent ]] || echo "All Proxy on"
}

# where unproxy
unproxy() {
  unset http_proxy https_proxy all_proxy
  echo "All Proxy off"
}
