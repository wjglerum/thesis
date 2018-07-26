$ git clone https://github.com/dcos/dcos-vagrant
$ cd dcos-vagrant
$ cp VagrantConfig-1m-1a-1p.yaml VagrantConfig.yaml
$ vagrant up
$ dcos cluster setup m1.dcos
$ dcos package install etcd --yes --options=etcd.json
$ dcos package install calico --yes
$ dcos package install kubernetes --yes \
    --package-version=1.0.3-1.9.7 \
    --options=kubernetes.json
$ dcos kubernetes kubeconfig
// Move the generated kube config from your local machine to the DC/OS agent
$ dcos marathon app add custom-controller.json
