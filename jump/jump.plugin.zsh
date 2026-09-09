#!/bin/zsh
# sshpass is from https://github.com/dora38/sshpass
# ssh with password and otp

jump() {
  local otp attempt

  for attempt in 1 2 3; do
    if otp=$(op item get "jump" --vault "Private" --otp) \
      && [[ -n "$otp" ]]; then
      sshpass -o "$otp" -O '[OTP Code]:' \
        ssh -p 2222 security@172.16.70.91
      return $?
    fi

    if (( attempt < 3 )); then
      printf 'op read 失败（%s/3），2 秒后重试\n' "$attempt" >&2
      sleep 2
    fi
  done

  printf '获取 OTP 失败，取消 SSH 连接\n' >&2
  return 1
}
