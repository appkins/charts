#charts/%: pkg/%.zip
#	helm package -d $@ $<

KUBECONFIG := $(shell pwd)/.data/kubeconfig

CHARTS := $(patsubst %/,%,$(dir $(wildcard charts/*/Chart.yaml)))

dep/update: ${CHARTS}
	helm dependency update $<

dep/build: ${CHARTS}
	helm dependency build $<

dep: ${CHARTS}
	helm dependency update $<

lint: ${CHARTS}
	helm lint $<

template: ${CHARTS}
	helm template $(notdir $<) $< -n kube-system | tee $(patsubst charts/%,.data/%.yaml,$<)

deploy: ${CHARTS}
	helm upgrade --install \
							 -n kube-system \
							 --set cilium.k8sServiceHost=192.168.1.198 \
							 --kubeconfig ${KUBECONFIG} \
							 $(notdir $<) $<
