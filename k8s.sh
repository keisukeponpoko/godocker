#!/bin/bash

docker build -t eks/ruby:latest ruby
docker build -t eks/go:latest go

kubectl apply -f .kube/k8s-ruby.yaml --prune -l app=ruby
kubectl apply -f .kube/k8s-go.yaml --prune -l app=go
