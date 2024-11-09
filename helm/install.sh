#!/bin/bash

helmfile init

helmfile apply

kubectl apply -f ../manifests/required_configs.yaml

#kubectl apply -f ../manifests/cert-manager.yaml

#kubectl apply -f ../manifests/external-secrets.yaml

#kubectl apply ../manifests/
