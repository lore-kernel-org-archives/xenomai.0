From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Patches: README.install
Date: Sat, 23 Dec 2006 23:51:32 +0100
References: <20061221224004.13E75353C25@domain.hid>
In-Reply-To: <20061221224004.13E75353C25@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1LbjFJ+Wzu/qv+e"
Message-Id: <200612232351.33192.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Denk <wd@domain.hid>
Cc: xenomai@xenomai.org

--Boundary-00=_1LbjFJ+Wzu/qv+e
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Am Donnerstag, 21. Dezember 2006 23:40 schrieb Wolfgang Denk:
> Dear Niklaus,
>
Dear Wolfgang

Thanks your for spotting my errors. I should have rechecked this patch before 
submitting it, as it was based on a outdated script. Please review the 
attached patch again which is based on a script which actually ran and 
produced a running kernel.

I would also thanks you for providing the ELDK. It was really a lot easier
to setup the ELDK once I switched from my PPC PowerBook to a MacMini. I can 
really recommend it.

The only addition to the ELDK I made to run xeno-test was to copy my 
Debian /usr/bin/which to the rootfs.

<..>

Best regards

-- 
Niklaus Giger

--Boundary-00=_1LbjFJ+Wzu/qv+e
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="readme.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="readme.patch"

Index: README.INSTALL
===================================================================
--- README.INSTALL	(Revision 1980)
+++ README.INSTALL	(Arbeitskopie)
@@ -192,6 +192,12 @@
 from the cross-compilation tools prefix, you will have to manually
 pass the name of all compilation tools on configure command line. 
 
+If you want to avoid to build your own cross compiler, you might if find
+easier to use ELDK (see http://www.denx.de/wiki/DULG/ELDK). It includes
+the GNU cross development tools, such as the compilers, binutils, gdb, 
+etc., and a number of pre-built target tools and libraries necessary
+to provide some functionality on the target system.
+
 See sections 2.2, 2.3 and 2.4 for examples.
 
 1.4 Building the Linux kernel in the user-space support build tree
@@ -276,19 +282,22 @@
 -----------------------------------------
 
 A typical cross-compilation setup, in order to build Xenomai for a
-PowerPC-405-based system:
+PowerPC-405-based system. Here we use an ELDK cross-compiler and a
+2.6.14 kernel.
 
-$ $xenomai_root/scripts/prepare-kernel.sh --arch=powerpc \
-  --adeos=$xenomai_root/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14-ppc-X.Y-ZZ.patch \
+$ $xenomai_root/scripts/prepare-kernel.sh --arch=ppc \
+  --adeos=$xenomai_root/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14-ppc-1.5-*.patch \
   --linux=$linux_tree
 $ cd $linux_tree
-$ mkdir ../build-powerpc-405-2.6.14
-$ make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- O=../build-powerpc-405-2.6.14 xconfig/gconfig/menuconfig 
+$ build_root /path/to/eldk
+$ mkdir $build_root
+$ make ARCH=ppc CROSS_COMPILE=ppc_4xx- O=$build_root xconfig/gconfig/menuconfig
 # select the kernel and Xenomai options
-$ make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- O=../build-powerpc-405-2.6.14 bzImage modules 
-# then install as needed
-$ mkdir $build_root && cd $build_root
-$ $xenomai_root/configure --build=i686-linux --host=powerpc-405-linux-gnu
+$ make ARCH=ppc CROSS_COMPILE=ppc_4xx- O=$build_root bzImage modules \
+  modules_install
+$ cd $build_root
+$ $xenomai_root/configure --build=i686-linux --host=ppc CC=ppc_4xx-gcc \
+  CXX=ppc_4xx-g++ LD=ppc_4xx-ld
 $ make install
 
 2.3 Building for the IPF

--Boundary-00=_1LbjFJ+Wzu/qv+e--

