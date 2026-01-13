

sudo yum install -y oracle-database-preinstall-19c  
#sudo yum install -y oracleasm-support oracle-database-preinstall-19c-1.0-1.el9.x86_6
sudo yum install -y dnsmasq*

# Install Desktop Tools
#sudo yum install -y open-vm-tools-desktop  curl wget git vim nano bash-completion

sudo groupadd -g 54327 asmdba
sudo groupadd -g 54328 asmoper
sudo groupadd -g 54329 asmadmin
sudo usermod -g oinstall -G dba,oper,backupdba,dgdba,kmdba,asmdba,asmoper,asmadmin,racdba oracle
sudo useradd -g oinstall -G asmadmin,asmdba,asmoper,dba,racdba grid

sudo echo "oracle:oracle" | sudo chpasswd
sudo echo "grid:oracle" | sudo chpasswd

sudo sh -c 'cat /etc/security/limits.d/oracle-database-preinstall-19c.conf | sed '\''s/oracle /grid /g'\'' > /etc/security/limits.d/oracle-grid-user-preinstall-19c.conf'
#sudo sh -c "sed 's/oracle /grid /g' /etc/security/limits.d/oracle-database-preinstall-19c.conf > /etc/security/limits.d/oracle-grid-user-preinstall-19c.conf"

sudo mkdir -p /u01/app/19.3.0/grid
sudo mkdir -p /u01/app/grid
sudo mkdir -p /u01/app/oracle
sudo chown -R grid:oinstall /u01
sudo chown oracle:oinstall /u01/app/oracle
#chown -R oracle:oinstall
sudo chmod -R 775 /u01

sudo sh -c 'echo "192.168.1.2 host01" >> /etc/hosts'
sudo sh -c 'echo "192.168.1.3 host02" >> /etc/hosts'
sudo sh -c 'echo "192.168.1.4 host03" >> /etc/hosts'

#sudo sh -c 'echo "192.168.1.102 host01-vip" >> /etc/hosts'
#sudo sh -c 'echo "192.168.1.103 host02-vip" >> /etc/hosts'
#sudo sh -c 'echo "192.168.1.104 host03-vip" >> /etc/hosts'

#sudo sh -c 'echo "192.168.1.202 cluster01-scan" >> /etc/hosts'
#sudo sh -c 'echo "192.168.1.203 cluster01-scan" >> /etc/hosts'
#sudo sh -c 'echo "192.168.1.204 cluster01-scan" >> /etc/hosts'

sudo sh -c 'echo "KERNEL==\"sdb\", SYMLINK+=\"DISK01\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"" > /etc/udev/rules.d/99-oracle-asmdevices.rules'
sudo sh -c 'echo "KERNEL==\"sdc\", SYMLINK+=\"DISK02\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"" >> /etc/udev/rules.d/99-oracle-asmdevices.rules'
sudo sh -c 'echo "KERNEL==\"sdd\", SYMLINK+=\"DISK03\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"" >> /etc/udev/rules.d/99-oracle-asmdevices.rules'
sudo sh -c 'echo "KERNEL==\"sde\", SYMLINK+=\"DISK04\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"" >> /etc/udev/rules.d/99-oracle-asmdevices.rules'
sudo sh -c 'echo "KERNEL==\"sdf\", SYMLINK+=\"DISK05\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"" >> /etc/udev/rules.d/99-oracle-asmdevices.rules'
sudo sh -c 'echo "KERNEL==\"sdg\", SYMLINK+=\"DISK06\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"" >> /etc/udev/rules.d/99-oracle-asmdevices.rules'

sudo sh -c 'udevadm control --reload-rules && udevadm trigger'

sudo systemctl enable chronyd
sudo systemctl restart chronyd

#--execute how user grid--
#sudo -u grid unzip -qd /u01/app/19.3.0/grid /software/LINUX.X64_193000_grid_home.zip
#export CV_ASSUME_DISTID=OEL7.8
#cd /u01/app/19.3.0/grid/bin
#chmod 6751 oracle
#cd ..
#./gridSetup.sh
#rpm -Uvh cvuqdisk-1.0.10-1.rpm

#--execute how user oracle --
#mkdir -p /u01/app/oracle/product/19.3.0/dbhome_1
#cp /software/LINUX.X64_193000_db_home.zip /u01/app/oracle/product/19.3.0/dbhome_1/
#chown -R oracle:oinstall /u01/app/oracle/product/19.3.0/dbhome_1
#chmod -R 775 /u01/app
#unzip /u01/app/oracle/product/19.3.0/dbhome_1/LINUX.X64_193000_db_home.zip 
#export CV_ASSUME_DISTID=OEL7.8
#./runInstaller

#export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
#export PATH=$PATH:$ORACLE_HOME/bin
#dbca

#mkdir -p /u02/oradata
#chown -R oracle:oinstall  /u02
#chmod -R 775 /u02
#unzip /software/LINUX.X64_193000_db_home.zip -d /u01/app/oracle/product/19.0.0/dbhome_1/
