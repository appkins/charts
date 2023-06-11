#!/bin/bash

helm upgrade --install -n kube-system \
             --set cilium.k8sServiceHost="192.168.1.198" \
             --kubeconfig ./hack/kubeconfig cilium ./charts/cilium-stack
