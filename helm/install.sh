#!/bin/bash

helmfile init

helmfile apply

kubectl apply -f ../manifests/cilium.yaml

kubectl apply -f ../manifests/cilium-policy.yaml

kubectl apply -f ../manifests/required_configs.yaml
