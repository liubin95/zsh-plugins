#!/bin/zsh

# zshfast
zshfast() {
  zmodload zsh/zprof
  # shellcheck disable=SC1090
  source ~/.zshrc
  zprof
}
