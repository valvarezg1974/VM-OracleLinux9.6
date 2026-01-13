sudo yum -y install ocfs2-tools

sudo systemctl enable --now o2cb

#sudo echo '192.168.2.101  host01' > /etc/hosts
#sudo echo '192.168.2.102  host02' >> /etc/hosts
#sudo echo '192.168.2.103  host03' >> /etc/hosts
#sudo echo 'kernel.panic_on_oops = 1' >> /etc/sysctl.d/99-sysctl.conf
#sudo echo 'kernel.panic = 30' >> /etc/sysctl.d/99-sysctl.conf

sudo firewall-cmd --permanent --zone=public --add-port=7777/tcp --add-port=7777/udp
sudo firewall-cmd --reload
#systemctl restart firewalld


#In node01 only:
#--------------------------------------------
sudo o2cb add-cluster mycluster
sudo o2cb list-cluster mycluster
#sudo o2cb remove-node mycluster host01

sudo o2cb add-node mycluster host01 --ip 192.168.2.101
sudo o2cb add-node mycluster host02 --ip 192.168.2.102
#sudo o2cb add-node mycluster host03 --ip 192.168.2.103
sudo o2cb list-cluster mycluster

#o2cb list-cluster mycluster --oneline

#ssh root@host02
#mkdir -p /etc/ocfs2
#exit
#ssh root@host03
#mkdir -p /etc/ocfs2
#exit
#scp /etc/ocfs2/cluster.conf host02:/etc/ocfs2/cluster.conf
#scp /etc/ocfs2/cluster.conf host03:/etc/ocfs2/cluster.conf


#sudo /sbin/o2cb.init configure
#y
#ENTER
#mycluster
#ENTER
#ENTER
#ENTER
#ENTER

sudo /sbin/o2cb.init status
sudo systemctl enable o2cb
sudo systemctl enable ocfs2


#In host02:
#/sbin/o2cb.init configure
#y
#ENTER
#mycluster
#ENTER
#ENTER
#ENTER
#ENTER

#/sbin/o2cb.init status
#systemctl enable o2cb
#systemctl enable ocfs2

#In host03:
#/sbin/o2cb.init configure
#y
#ENTER
#mycluster
#ENTER
#ENTER
#ENTER
#ENTER

#/sbin/o2cb.init status
systemctl enable o2cb
systemctl enable ocfs2


#In host01:
#------------------------------------------------------------
#fdisk /dev/xvdf --> primary partition with all default (10 GB)

sudo  parted -s /dev/sdb mklabel gpt
sudo  parted -s /dev/sdb mkpart primary ext4 1MiB 100%

sudo mkfs.ocfs2 -T datafiles /dev/sdb1
#y

#mkfs.ocfs2 /dev/xvdf1

#mkfs.ocfs2 -T mail /dev/xvdf1
#y

#mkfs.ocfs2 -T datafiles /dev/xvdf1
#y

#mkfs.ocfs2 -T vmstore /dev/xvdf1
#y

#mkfs.ocfs2 -L "myvolume" /dev/xvdf1 -F

#mkdir /u01
#mount -L myvolume /u03

#/sbin/o2cb.init status

#cp /boot/vmlinuz* /u01
#ls -l /u01


#In host02:
#-------------------------------------
#mkdir /u01
#mount -L myvolume /u01

#cat /proc/partitions

#partprobe /dev/xvdf

#cat /proc/partitions

#mount -L myvolume /u01

#/sbin/o2cb.init status

#ls -l /u01


#In host03:
#----------------------------------

#mkdir /u01
#mount -L myvolume /u01

#cat /proc/partitions

#partprobe /dev/xvdf

#cat /proc/partitions

#mount -L myvolume /u01

#/sbin/o2cb.init status

#ls -l /u01


#vi /u01/host03test
#This is a test from host03


sudo firewall-cmd --permanent --zone=public --remove-port=7777/tcp --remove-port=7777/udp
