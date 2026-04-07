#!/bin/zsh

tt() {
  local name=${1:?"The name must be specified."}
  printf "\033]2;%s\033\\" "$name"
}
