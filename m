From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Thu, 21 Dec 2006 22:59:05 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pOwiFTjB9m36/jG"
Message-Id: <200612212259.06016.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Patches: README.install & examples/common for
	cross-compiling
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
To: xenomai@xenomai.org

--Boundary-00=_pOwiFTjB9m36/jG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

After switching my development environment to a MacMini and using the ELDK 4.0 
I discovered that my examples for building using a cross-compiler for my 
PPC405 target were not correct. (Maybe a few of my previous problems were 
caused by not correctly specifying the target ARCH.)

Also I would like to adapt and document the examples/common/Makefile to the 
needs for cross-compiling (KSRC/XENOCONFIG/DESTDIR useage). Also I added a 
target "install" to copy the generated application to $(DESTDIR)/usr/xenomai.

Could someone please commit these (or a improved version of it) patches?

Thanks in advance

-- 
Niklaus Giger

--Boundary-00=_pOwiFTjB9m36/jG
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="common.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="common.patch"

Index: examples/common/Makefile
===================================================================
--- examples/common/Makefile	(Revision 1970)
+++ examples/common/Makefile	(Arbeitskopie)
@@ -3,9 +3,9 @@
 ### List of applications to be build
 APPLICATIONS = hw_direct_io
 
-### Note: to override the search path for the xeno-config script, use "make XENO=..."
+### Note: to override the search path for the xeno-config script, use "make XENOCONFIG=..."
+### Note: if you installed it into a non standard place add DESTDIR=/path/to/installed/xenomai"
 
-
 ### List of modules to be build
 MODULES =
 
@@ -24,7 +24,9 @@
 ### Sanity check
 ifeq ($(XENOCONFIG),)
 all::
-	@echo ">>> Invoke make like this: \"make XENO=/path/to/xeno-config\" <<<"
+	@echo ">>> Invoke make like this: \"make XENOCONFIG=/path/to/xeno-config\" <<<"
+	@echo ">>> add KSRC=.. to override the default kernel source at /lib/modules/$(shell uname -r)/build <<<"
+	@echo ">>> add DESTDIR=/path/to/installed/xenomai if you installed it into a non standard place <<<"
 	@echo
 endif
 
@@ -40,6 +42,9 @@
 clean::
 	$(RM) $(APPLICATIONS) *.o
 
+install:   $(APPLICATIONS)
+	cp $(APPLICATIONS) $(DESTDIR)/usr/xenomai/bin
+
 endif
 
 
@@ -80,3 +85,4 @@
 	$(RM) -R .tmp*
 
 endif
+

--Boundary-00=_pOwiFTjB9m36/jG
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="readme.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="readme.patch"

Index: README.INSTALL
===================================================================
--- README.INSTALL	(Revision 1957)
+++ README.INSTALL	(Arbeitskopie)
@@ -276,19 +276,20 @@
 -----------------------------------------
 
 A typical cross-compilation setup, in order to build Xenomai for a
-PowerPC-405-based system:
+PowerPC-405-based system (assuming an ELDK cross-compiler and a 2.6.14 kernel)
 
 $ $xenomai_root/scripts/prepare-kernel.sh --arch=powerpc \
   --adeos=$xenomai_root/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14-ppc-X.Y-ZZ.patch \
   --linux=$linux_tree
 $ cd $linux_tree
-$ mkdir ../build-powerpc-405-2.6.14
-$ make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- O=../build-powerpc-405-2.6.14 xconfig/gconfig/menuconfig 
+$ build_root /path/to/build-powerpc-405-2.6.14
+$ mkdir $build_root
+$ make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- O=$build_root xconfig/gconfig/menuconfig 
 # select the kernel and Xenomai options
-$ make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- O=../build-powerpc-405-2.6.14 bzImage modules 
+$ make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- O=$build_root bzImage modules 
 # then install as needed
-$ mkdir $build_root && cd $build_root
-$ $xenomai_root/configure --build=i686-linux --host=powerpc-405-linux-gnu
+$ cd $build_root
+$ $xenomai_root/configure --build=i686-linux --host=powerpc-405-linux-gnu CC=ppc_4xx-gcc CXX=ppc_4xx-g++ LD=ppc_4xx-ld
 $ make install
 
 2.3 Building for the IPF

--Boundary-00=_pOwiFTjB9m36/jG--

