From: Younes CHALABI <y.chalabi@sinters.fr>
Date: Mon, 17 Jun 2013 14:13:53 +0000
Message-ID: <A46EF8CF1BBB8E4B8A27B73E177C4664F477B4@MAIL-SINTERS-01.sinters-int.fr>
Content-Language: fr-FR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Xenomai-2.6.2.1 with a kernel-3.0.15 Freescale Release on
 i.MX6Q Sabre Lite Booting problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I'm trying to install xenomai-2.6.2.1 on the i.MX6Q Sabre Lite.

Using U-boot-mx6q-sabrelite.bin and the rootfs.ext2 from the L3.0.35_4.0.0_=
130424_images_MX6 directory.

The kernel used is rel_imx_3.0.15_12.03.00, and after patching it with xeno=
mai-2.6.2.1 following these steps :

 1- Applying xenomai-2.6.2.1/ksrc/arch/arm/patches/mxc/adeos-ipipe-3.0.36-a=
rm-1.18-11-pre.patch
 2- Applying xenomai-2.6.2.1/ksrc/arch/arm/patches/adeos-ipipe-3.0.36-arm-1=
.18-11.patch
 3- Applying xenomai-2.6.2.1/ksrc/arch/arm/patches/mxc/adeos-ipipe-3.0.36-a=
rm-1.18-11-post.patch
 4- xenomai-2.6.2.1/scripts/prepare-kernel.sh --arch=3Darm --adeos=3D$xenom=
ai_root/ksrc/arch/arm/patches/adeos-ipipe-3.0.36-arm-1.18-11.patch --linux=
=3Drel_imx_3.0.15_12.03.00
 5- make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi- O=3D$build_root=
/linux imx6_defconfig
 6- make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi- O=3D$build_root=
/linux bzImage modules
 7- xenomai-2.6.2.1/configure CFLAGS=3D"-march=3Darmv7-a -mfpu=3Dvfp3" FDFL=
AGS=3D"-march=3Darmv7-a -mfpu=3Dvfp3" --build=3Di686-pc-linux-gnu --host=3D=
arm-none-linux-gnueabi
 8- make DESTDIR=3D$staging_dir install

Then putting the build_root/linux/arch/arm/boot/uImage | System.map | modul=
es.builtin |   modules.order |  Module.symvers      =3D=3D> to /media/boot

But when booting the target the kernel doesn't start and have this display =
:
=20
 mmc1 is current device

 MMC read: dev # 1, block # 2048, count 8192 ... 8192 blocks read: OK
 ## Booting kernel from Legacy Image at 10800000 ...
   Image Name:   Linux-$ (3.0.15_12.03.00)
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3813344 Bytes =3D  3.6 MB
   Load Address: 10800000
   Entry Point:  10800000
   Verifying Checksum ... OK
   XIP Kernel Image ... OK
 OK

 Starting kernel ...

"Stops here"

Any help or idea is welcome=

