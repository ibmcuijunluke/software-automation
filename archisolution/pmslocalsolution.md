#############PMS_CLoud_Local本地部署Solution Ready##################

USB->CentOS HostOS ->KVM Configuration ->execute jw_hostos.sh  shell script. Init HostOS +KVM Environment (Network, IP  ,DNS, useful software etc) .
USB > execute jw_mount.sh,> execute jw_import.sh  ,import KVM qemu Images, and Start all KVM VM and all jw pms service .->  execute jw_healthcheck.sh , and check all jwpms service is ok.
具体实施步骤
PC Machine RAID 5

1.PC Machine Ready
2.USB verification
3.VM pms local architecture
4.HOSTOS,KVM,PmsService HA
5.Monitor and Ops PMS service
6.Saltstack healthcheck Scripts and check all pms service
7.log file crontab del and DB Master -Master sychnized
8.Deployer and Customer Training
9. Database Restore
10. HostOS Restore, customer need purchase our engineer service.

POC Demo
Image IOS and USB Device Make
Goto Customer
