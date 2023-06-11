#!/bin/bash

helm dependency update ./charts/cilium-stack
helm dependency build ./charts/cilium-stack
