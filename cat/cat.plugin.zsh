#!/bin/zsh
# require tspin https://github.com/bensadeh/tailspin
cat() {
  if [ $# -ne 1 ]; then
    echo "Usage: cat file"
    exit 1
  fi
  /bin/cat "$1" | tspin
}
