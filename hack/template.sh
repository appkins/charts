#!/bin/bash
mkdir -p ./data
helm template cilium ./charts/cilium-stack -n kube-system | tee ./data/test.yaml
