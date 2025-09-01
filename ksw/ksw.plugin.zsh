#!/bin/zsh

ksw() {
  local valid_envs=(${(s: :)KSW_ENVIRONMENTS})
  readonly env=${1:?"The env must be specified."}
  if [[ ! "${valid_envs[@]}" =~ "${env}" ]]; then
    echo "错误: 无效的环境 $1. 有效选项为: ${valid_envs[*]}"
    return 1
  fi

  local prd_envs=(${(s: :)KSW_ENVIRONMENTS_PRD})
  if [[ "${prd_envs[@]}" =~ "${env}" ]]; then
    tt "🔴 ${env}@k8s"
  else
    tt "🟢 ${env}@k8s"
  fi

  export KUBECONFIG=~/.kube/admin.conf-"${env}".yaml
}
