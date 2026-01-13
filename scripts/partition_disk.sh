#sudo dd if=/dev/zero of=/EMPTY bs=100M status=progress
#sudo rm -f /EMPTY

#DISKS="/dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf"
FS=ext4


for DISK in /dev/sd[b-g]; do
  echo "Formatting $DISK"

  # Create partition table
#sudo  parted -s $DISK mklabel msdos
sudo  parted -s $DISK mklabel gpt

  # Create single partition
#sudo  parted -s $DISK mkpart primary $FS 1MiB 100%

  # Wait for kernel to recognize partition
sudo  partprobe $DISK
sudo  sleep 2

  # Format partition
#sudo  mkfs.$FS ${DISK}1

done

echo "All disks formatted successfully"

  