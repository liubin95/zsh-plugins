#!/bin/zsh

# proxy
proxy() {
  export https_proxy=http://127.0.0.1:$PROXY_PORT
  export http_proxy=http://127.0.0.1:$PROXY_PORT
  export all_proxy=socks5://127.0.0.1:$PROXY_PORT
  git config --global http.proxy http://127.0.0.1:$PROXY_PORT
  git config --global https.proxy https://127.0.0.1:$PROXY_PORT
  if [ "$1" != "silent" ]; then
    echo "All Proxy on"
  fi
}

# where unproxy
unproxy () {
  unset https_proxy
  unset http_proxy
  unset all_proxy
  git config --global --unset http.proxy
  git config --global --unset https.proxy
  echo "All Proxy off"
}
