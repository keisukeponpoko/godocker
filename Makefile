PROJECT = eks_test

.PHONY: start
start:
	docker-compose -p $(PROJECT) up -d --build

.PHONY: restart
restart:
	docker-compose -p $(PROJECT) kill && \
	docker-compose -p $(PROJECT) rm -f && \
	docker-compose -p $(PROJECT) up -d --build

.PHONY: down
down:
	docker-compose -p $(PROJECT) down

.PHONY: build
build:
	docker build -t eks/ruby:latest ruby
	docker build -t eks/grpc-ruby:latest ruby_grpc
	docker build -t eks/go:latest go

.PHONY: apply
apply:
	kubectl create configmap envoy-config --from-file=.kube/envoy-config
	kubectl apply -f .kube/front-envoy.yaml
	kubectl apply -f .kube/front-envoy-service.yaml
	kubectl apply -f .kube/go.yaml
	kubectl apply -f .kube/go-service.yaml
	# kubectl apply -f .kube/go-ruby.yaml
	# kubectl apply -f .kube/go-ruby-service.yaml
	# kubectl apply -f .kube/grpc-ruby.yaml
	# kubectl apply -f .kube/grpc-ruby-service.yaml

.PHONY: destroy
destroy:
	kubectl delete configmap envoy-config
	kubectl delete deployment front-envoy
	kubectl delete service front-envoy-service
	kubectl delete deployment go
	kubectl delete service go-service
	# kubectl delete deployment go-ruby
	# kubectl delete service go-ruby-service
	# kubectl delete deployment grpc-ruby
	# kubectl delete service grpc-ruby-service
