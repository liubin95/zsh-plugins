#!/bin/zsh
# require tspin https://github.com/bensadeh/tailspin
bat() {
  if [ $# -ne 1 ]; then
    echo "Usage: bat file"
    exit 1
  fi
  cat "$1" | tspin
}
