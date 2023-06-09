#!/bin/bash

helm upgrade --install -n kube-system --kubeconfig ./hack/kubeconfig cilium ./charts/cilium-stack
