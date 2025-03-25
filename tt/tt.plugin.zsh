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
  printf "\033]1337;SetUserVar=tab_color=%s\007" $(echo -n "$color" | base64)

}

# sleep 5 && tmsg
tmsg() {
  printf "\033]9;%s\007" "job finished"
}
