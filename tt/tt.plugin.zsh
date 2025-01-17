#!/bin/zsh

tt() {
  readonly name=${1:?"The name must be specified."}
  wezterm cli set-tab-title "$name"
}

tc() {
  readonly color=${1:?"The color must be specified."}
  local valids=("red" "green" "yellow" "clean")
  # shellcheck disable=SC2199
  if [[ ! "${valids[@]}" =~ "${color}" ]]; then
    echo "错误: 无效的环境 $1. 有效选项为: ${valids[*]}"
    return 1
  fi
  case "$color" in
    red)
      printf "\033]6;1;bg;red;brightness;255\a"
      printf "\033]6;1;bg;green;brightness;85\a"
      printf "\033]6;1;bg;blue;brightness;85\a"
      ;;
    green)
      printf "\033]6;1;bg;red;brightness;80\a"
      printf "\033]6;1;bg;green;brightness;250\a"
      printf "\033]6;1;bg;blue;brightness;113\a"
      ;;
    yellow)
      printf "\033]6;1;bg;red;brightness;241\a"
      printf "\033]6;1;bg;green;brightness;250\a"
      printf "\033]6;1;bg;blue;brightness;140\a"
      ;;
    clean)
      printf "\033]6;1;bg;*;default\a"
      ;;
  esac
}

# sleep 5 && tmsg
tmsg() {
  local previous_command=$(fc -ln -1)
  local exit_status=$?
  printf "\e]9;%s\e\\" "$previous_command finished with $exit_status"
}
