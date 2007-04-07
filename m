Message-ID: <46180AB8.3000905@domain.hid>
Date: Sat, 07 Apr 2007 23:18:48 +0200
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Xenomai Live CD
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all,

I've managed to create a Xenomai Live CD based on the Ubuntu Dapper
desktop install CD. Many webpages tell you how to do it (for instance
https://help.ubuntu.com/community/LiveCDCustomization/6.06) but the
important thing is to have squashfs and unionfs support in the kernel.
The following is what I did.

I hope someone can pick it up from here as I have very little time to
do it.

TODO:
   - Remove Ubuntu Installer stuff from CD
   - Remove unnecessary packages from the squashfs file system.
   - Change isolinux/isolinux.cfg etc.


Here it goes (I think/hope I haven't forgotten any steps):


Retrieve kernel 2.6.17[.14] sources and unpack into $KERNEL_DIR.
Retrieve xenomai 2.3.0 sources and unpack into $XENOMAI_DIR.
Retrieve squashfs3.2-r2 (http://squashfs.sourceforge.net/) into $SQUASHFS_DIR.
Also compile and installl the mksquashfs tool.
Retrieve unionfs-1.3 (http://www.filesystems.org/project-unionfs.html)
into $UNIONFS_DIR.

Apply xenomai patches:
   cd $XENOMAI_DIR
   ./scripts/prepare-kernel.sh --linux=$KERNEL_DIR --arch=i386
	--adeos=ksrc/arch/i386/patches/adeos-ipipe-2.6.17-i386-1.5-02.patch

Apply squashfs patches:
   cd $KERNEL_DIR
   patch -p1 < $SQUASHFS_DIR/kernel-patches/linux-2.6.17/squashfs3.2-patch

Apply unionfs patches:
   cd $UNIONFS_DIR
   ./patch-kernel.sh $KERNEL_DIR


Configure kernel:
   CONFIG_BLK_DEV_LOOP=m
   CONFIG_BLK_DEV_RAM=y
   CONFIG_BLK_DEV_RAM_COUNT=16
   CONFIG_BLK_DEV_RAM_SIZE=4096
   CONFIG_BLK_DEV_INITRD=y
   CONFIG_SQUASHFS=m
   CONFIG_UNION_FS=m

Compile and install kernel. On my particular system this yields (v20 being
my local version number):
   /boot/vmlinuz-2.6.17.14-xenomai-v20
   /lib/modules/2.6.17.14-xenomai-v20/

Compile and install xenomai. On my system this yields:
   /usr/xenomai-2.3.0-v20/
   /usr/rt (symlink to xenomai-2.3.0-v20)

Make sure this kernel boots OK. Also check realtime behaviour.



Retrieve ubuntu-6.06.1-desktop-i386.iso (http://www.ubuntu.com/) and
let $ISOIMG refer to it.

Set some convenience symbols:
   XENOMAI_VER=xenomai-2.3.0-v20
   export KERNEL_VER=2.6.17.14-xenomai-v20

Loop-mount the ISO image and the squashfs file system contained in it.
   mkdir -p mnt/iso mnt/squashfs
   mount -o loop $ISOIMG mnt/iso
   mount -t squashfs -o loop mnt/iso/casper/filesystem.squashfs mnt/squashfs

Copy contents of the ISO image and the squashfs file system.
   mkdir iso squashfs
   rsync --exclude=/casper/filesystem.squashfs -a mnt/iso/ iso
   cp -a mnt/squashfs/* squashfs

Remove unwanted stuff from ISO image.
   rm -rf iso/programs

Unmount the squashfs file system and the ISO image.
   umount mnt/squashfs mnt/iso
   rm -rf mnt

Modify squashfs contents; install custom kernel and modules.
   cd squashfs
   rm -f boot/vmlinuz* boot/initrd* boot/System* boot/config* boot/abi*
   rm -f initrd.img vmlinuz
   rm -rf lib/modules/*
   rm -rf usr/$XENOMAI_VER
   rm -f usr/rt
   cp /boot/*$KERNEL_VER boot
   cp -a /lib/modules/$KERNEL_VER lib/modules
   cp -a /usr/$XENOMAI_VER usr
   ln -s $XENOMAI_VER usr/rt
   ln -s boot/vmlinuz-$KERNEL_VER vmlinuz
   ln -s boot/initrd.img-$KERNEL_VER initrd.img
   cd ..

Build initrd.gz
   chroot squashfs
   mkinitramfs -o /initrd.gz $KERNEL_VER
   exit

Put custom kernel and initrd in iso/casper/.
   mv squashfs/initrd.gz squashfs/boot/initrd.img-$KERNEL_VER
   cp squashfs/boot/vmlinuz-$KERNEL_VER iso/casper/vmlinuz
   cp squashfs/boot/initrd.img-$KERNEL_VER iso/casper/initrd.gz

Create new iso/casper/filesystem.manifest* files.
   rm iso/casper/filesystem.*
   chroot squashfs dpkg-query -W --showformat='${Package} ${Version}\n' > 
iso/casper/filesystem.manifest
   cp iso/casper/filesystem.manifest iso/casper/filesystem.manifest-desktop
   sed -i -e '/ubiquity/d' iso/casper/filesystem.manifest-desktop

Create squashfs file system file in iso/casper/.
   mksquashfs squashfs iso/casper/filesystem.squashfs
   chmod 444 iso/casper/filesystem.squashfs

Recreate md5sum.txt.
   cd iso
   rm -f md5sum.txt
   find . -type f -exec md5sum {} \; > ../md5sum.txt
   cd ..
   mv md5sum.txt iso

Create ISO image.
   cd iso
   mkisofs -V "Xenomai Ubuntu 6.06 CD" \
         -o xenomai-ubuntu-6.06.1-desktop-i386.iso \
         -b isolinux/isolinux.bin -c isolinux/boot.cat \
         -no-emul-boot -boot-load-size 4 -boot-info-table \
         -l -R -r .
   cd ..

Burn the ISO image onto a CD and boot from it (choose first option from menu).
Once everything is up, open a terminal and in /usr/rt/bin run sudo ./latency

Good luck!

Theo



