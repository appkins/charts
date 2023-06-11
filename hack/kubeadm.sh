sudo kubeadm init --control-plane-endpoint="192.168.1.198" \
             --apiserver-advertise-address="192.168.1.198" \
             --apiserver-cert-extra-sans="192.168.1.198,192.168.1.199,k8s.appkins.net" \
             --service-cidr="10.96.0.0/12" \
             --skip-phases="addon/kube-proxy" \
             --kubernetes-version="v1.27.0" \
             --cri-socket="unix:///var/run/crio/crio.sock" \
             --pod-network-cidr="10.217.0.0/16" && \
sudo mkdir -p "$HOME"/.kube && \
sudo cp -rf /etc/kubernetes/admin.conf "$HOME"/.kube/config && \
sudo kubectl taint nodes --all node-role.kubernetes.io/control-plane-
