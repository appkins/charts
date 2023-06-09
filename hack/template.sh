#!/bin/bash

helm template cilium ./charts/cilium-stack -n kube-system | tee test.yaml
