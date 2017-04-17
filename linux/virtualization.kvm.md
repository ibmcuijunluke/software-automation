yum -y install qemu-kvm qemu-img libvirt virt-install bridge-utils

lsmod | grep kvm

systemctl start libvirtd
systemctl enable libvirtd
