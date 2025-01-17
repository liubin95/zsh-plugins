#!/bin/zsh

ksw(){
  local valid_envs=("dev" "prd" "minikube" "heytea" "banu")
  readonly env=${1:?"The env must be specified."}
  if [[ ! "${valid_envs[@]}" =~ "${env}" ]]; then
    echo "错误: 无效的环境 $1. 有效选项为: ${valid_envs[*]}"
    return 1
  fi
  case "$env" in
    prd)
        tc red
        tt prd@k8s
        ;;
    heytea)
        tc red
        tt heytea@k8s
        ;;
    dev)
        tc green
        tt dev@k8s
        ;;
    minikube)
        tc yellow
        tt minikube@k8s
        ;;
  esac
  export KUBECONFIG=~/.kube/admin.conf-"${env}".yaml
}
