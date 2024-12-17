#!/bin/zsh
# sshpass is from https://github.com/dora38/sshpass
# ssh with password and otp

jump() {
  readonly otp=$(op read "op://Private/jump/Section_drs677xgvca4do6l2wlb7c6ooi/TOTP_fqixp4kdxxsfwsivwnih37gcmu?attribute=otp")
  sshpass -p$(op read "op://Private/jump/password" -n) -o $otp -O '[OTP Code]:' ssh $(op read "op://Private/jump/username" -n)
}
