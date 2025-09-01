#!/bin/zsh

tt() {
  readonly name=${1:?"The name must be specified."}
  echo -e "\e]0;$name\a"
}
