#!/usr/bin/env bash

echo "LIMPANDO VOLUMES DOCKER"
docker rm -f "$(docker ps -qa)"
docker volume rm "$(docker volume ls -q)"


sleep 2

echo "DESMONTANDO OS PONTOS DE MONTAGEM"

for mount in $(mount | grep tmpfs | grep '/var/lib/kubelet' | awk '{ print $3 }') /var/lib/kubelet /var/lib/rancher; do umount "$mount"; done

sleep 2

echo "EXCLUINDO DIRETORIOS"

rm -rf /etc/ceph \
/etc/cni \
/etc/kubernetes \
/opt/cni \
/opt/rke \
/run/secrets/kubernetes.io \
/run/calico \
/run/flannel \
/var/lib/calico \
/var/lib/etcd \
/var/lib/cni \
/var/lib/kubelet \
/var/lib/rancher/rke/log \
/var/log/containers \
/var/log/kube-audit \
/var/log/pods \
/var/run/calico

sleep 2


echo "LIMPANDO A IPTABLES"

iptables -F



echo "O NODE FOI LIMPO"