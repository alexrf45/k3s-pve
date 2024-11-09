#!/bin/bash

#ansible-playbook -i inventory/hosts.yaml -e @secrets.yaml --ask-vault-password -K playbooks/k3s.yaml

scp fr3d@10.3.3.40:/etc/rancher/k3s/k3s.yaml $HOME/.kube/config

sed -ie s/127.0.0.1/10.3.3.40/g $HOME/.kube/config

kubectl create namespace cert-manager

kubectl create namespace external-secrets

kubectl create namespace pihole-system

kubectl create namespace argo-cd

kubectl create namespace nginx-system

kubectl create \
  -n external-secrets secret generic awssm-secret \
  --from-file=./access-key --from-file=./secret-access-key

kubectl create secret generic pihole-password \
  --from-literal password=Hypnosis6-Wreath6-Subdivide1-Epic4-Reason2 \
  -n pihole-system

kubectl create secret generic cloudflare-token-secret \
  --from-literal cloudflare-token=$1 \
  -n kube-system
