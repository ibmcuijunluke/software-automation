操作系统：Ubuntu 16.04

安装KVM

Kernel-based Virtual Machine的简称，是一个开源的系统虚拟化模块，自Linux 2.6.20之后集成在Linux的各个主要发行版本中。它使用Linux自身的调度器进行管理，所以相对于Xen，其核心源码很少。KVM目前已成为学术界的主流VMM之一。KVM的虚拟化需要硬件支持（如Intel VT技术或者AMD V技术)。是基于硬件的完全虚拟化。而Xen早期则是基于软件模拟的Para-Virtualization，新版本则是基于硬件支持的完全虚拟化。但Xen本身有自己的进程调度器，存储管理模块等，所以代码较为庞大。广为流传的商业系统虚拟化软件VMware ESX系列是基于软件模拟的Full-Virtualization。

下面是小编为你精选的Openstack相关知识，看看是否有你喜欢的：

在Ubuntu 12.10 上安装部署Openstack http://www.linuxidc.com/Linux/2013-08/88184.htm

Ubuntu 12.04 OpenStack Swift单节点部署手册 http://www.linuxidc.com/Linux/2013-08/88182.htm

OpenStack云计算快速入门教程 http://www.linuxidc.com/Linux/2013-08/88186.htm

企业部署OpenStack：该做与不该做的事 http://www.linuxidc.com/Linux/2013-09/90428.htm

CentOS 6.5 x64bit 快速安装OpenStack http://www.linuxidc.com/Linux/2014-06/103775.htm

基于Ubuntu Server 12.04 的OpenStack F版搭建步骤  http://www.linuxidc.com/Linux/2016-05/131498.htm
1 ，查看CPU是否支持虚拟化

root@cy-computer:~# grep -E "vmx|svm" /proc/cpuinfo

输出如下：

flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer xsave avx lahf_lm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid xsaveopt

2 ，安装kvm

root@cy-computer:~# apt-get install qemu-kvm ubuntu-vm-builder bridge-utils

3 ，启用kvm模块

root@cy-computer:~# modprobe kvm
root@cy-computer:~# modprobe kvm_intel
root@cy-computer:~# modprobe kvm_amd

4 ，检查kvm是否成功安装：

root@cy-computer:~# kvm-ok
INFO: /dev/kvm exists
KVM acceleration can be used


5 ，添加root到kvm组

root@cy-computer:~# adduser root kvm
Adding user `root' to group `kvm' ...
Adding user root to group kvm
Done.


6 ，安装libvirt

其旨在为包括Xen在内的各种虚拟化工具提供一套方便、可靠的编程接口，支持与C,C++,Ruby,Python,Java等多种主流开发语言的绑定。当前主流Linux平台上默认的虚拟化管理工具virt-manager(图形化),virt-install（命令行模式）等均基于libvirt开发而成。Libvirt 库是一种实现 Linux 虚拟化功能的 Linux® API，它支持各种虚拟机监控程序，包括 Xen 和 KVM，以及 QEMU 和用于其他操作系统的一些虚拟产品。

libvirt 比较和用例模型
      libvirt 比较和用例模型

一些原理介绍方面的：http://www.linuxidc.com/Linux/2010-02/24533.htm
root@cy-computer:~# apt-get install libvirt-bin qemu virt-manager


7 ，检查libvirt是否成功安装

root@cy-computer:~# service libvirt-bin start  #启动libvirt
root@cy-computer:~# virsh list --all                  #如下输出表示正常
 Id    Name                          State
----------------------------------------------------


8 ，管理界面

root@cy-computer:~# virt-manager
