
#sudo echo "Servidor Web creado con PACKER" > /var/www/html/index.html
#sudo usermod -G vboxsf vagrant


sudo yum install -y oracle-database-preinstall-19c  #oracle-database-preinstall-19c-1.0-1.el9.x86_6
sudo yum install -y oracleasm-support
sudo yum install -y dnsmasq*

# Install Desktop Tools
#sudo yum install -y open-vm-tools-desktop  curl wget git vim nano bash-completion

mkdir -p /u01/app/19c/grid
mkdir -p /u01/app/oracle/product/19.0.0/dbhome_1
mkdir -p /u01/oraInstall
chown -R oracle:oinstall /u01
chmod -R 775 /u01

groupadd -g 54327 asmdba
groupadd -g 54328 asmoper
groupadd -g 54329 asmadmin
usermod -g oinstall -G dba,oper,backupdba,dgdba,kmdba,asmdba,asmoper,asmadmin,racdba oracle

echo 'host01' >> /etc/hosts

oracleasm configure
oracleasm init

oracleasm createdisk DATA /dev/sdb1
oracleasm createdisk RECO /dev/sdc1
oracleasm scandisks
oracleasm listdisks

systemctl enable chronyd
systemctl restart chronyd

unzip /software/LINUX.X64.193000_grid_home.zip -d /u01/app/19c/grid
rpm -Uvh cvuqdisk-1.0.10-1.rpm
