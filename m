From: gernot.hillier@siemens.com
Date: Fri,  8 Nov 2013 10:34:22 +0100
Message-Id: <1383903263-10441-7-git-send-email-gernot.hillier@siemens.com>
In-Reply-To: <1383903263-10441-1-git-send-email-gernot.hillier@siemens.com>
References: <1383903263-10441-1-git-send-email-gernot.hillier@siemens.com>
Subject: [Xenomai] [Xenomai-forge PATCH 6/7] debian: rework
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Replace the linux-patch-xenomai package containing xenomai
kernel-space support sources as a patch with the xenomai-kernel-source
package containing the sources themselves with the prepare-kernel.sh script.
This allows removing the regularly broken prepare-patch.sh script.
(cherry picked from commit cba30bf0ba893c8b2f652763d488192818907ac6)
---
 debian/changelog                           |  6 ++++++
 debian/control                             | 26 +++++++++++++-------------
 debian/linux-patch-xenomai.README.Debian   | 19 -------------------
 debian/rules                               | 22 +++++++---------------
 debian/xenomai-kernel-source.README.Debian | 20 ++++++++++++++++++++
 scripts/bootstrap                          |  2 +-
 scripts/wrap-link.sh                       |  4 ++++
 7 files changed, 51 insertions(+), 48 deletions(-)
 delete mode 100644 debian/linux-patch-xenomai.README.Debian
 create mode 100644 debian/xenomai-kernel-source.README.Debian

diff --git a/debian/changelog b/debian/changelog
index a0c158d..e12e856 100644
--- a/debian/changelog
+++ b/debian/changelog
@@ -1,3 +1,9 @@
+xenomai (2.6.3) UNRELEASED; urgency=low
+
+  * New release
+
+ -- Xenomai <xenomai@xenomai.org>  Fri, 30 Aug 2013 22:34:50 +0200
+
 xenomai (2.6.1) unstable; urgency=low
 
   * New release, integrated with debian/ subdir
diff --git a/debian/control b/debian/control
index 3bbc2fb..1da7238 100644
--- a/debian/control
+++ b/debian/control
@@ -1,7 +1,7 @@
 Source: xenomai
 Section: devel
 Priority: extra
-Maintainer: Roland Stigge <stigge@antcom.de>
+Maintainer: Xenomai <xenomai@xenomai.org>
 Build-Depends: debhelper (>= 8), findutils (>= 4.2.28), autotools-dev, autoconf, automake, libtool
 Standards-Version: 3.9.3
 Homepage: http://www.xenomai.org/
@@ -10,7 +10,7 @@ Package: xenomai-runtime
 Section: devel
 Architecture: amd64 arm armeb armel i386 powerpc
 Depends: ${shlibs:Depends}, ${misc:Depends}
-Suggests: linux-patch-xenomai, xenomai-doc
+Suggests: xenomai-kernel-source, xenomai-doc
 Replaces: xenomai
 Conflicts: xenomai
 Description: Xenomai runtime utilities
@@ -24,12 +24,12 @@ Description: Xenomai runtime utilities
  This package contains the runtime programs and the testsuite for the Xenomai
  realtime system.
 
-Package: linux-patch-xenomai
+Package: xenomai-kernel-source
 Section: kernel
 Architecture: all
 Depends: ${misc:Depends}
-Suggests: xenomai, linux-source-2.6, kernel-package
-Description: Linux kernel patches for Xenomai
+Suggests: xenomai, linux-source, kernel-package
+Description: Source for Xenomai kernel-space support
  Xenomai is a real-time development framework cooperating with the Linux
  kernel in order to provide a pervasive, interface-agnostic, hard real-time
  support to user-space applications, seamlessly integrated into the GNU/Linux
@@ -37,19 +37,19 @@ Description: Linux kernel patches for Xenomai
  make migration from other RTOS easier. Examples are: pSOS+, VxWorks, VRTX,
  uiTRON, POSIX.
  .
- This package contains patches for 2.6 series kernels - These are intended for
- use with kernel-package and a virgin Linux source tree. Note: These patches
- include the base adeos-ipipe patch along with all the additional material
- normally added by the prepare-kernel.sh script.
- .
- This package contains the following patches:
+ This package contains sources for Xenomai kernel-space support - 
+ These are intended for use with kernel-package and a virgin Linux
+ source tree. 
  .
+ Note: These sources are included with the prepare-kernel.sh script
+ which should be run to patch the Linux kernel sources with Xenomai
+ kernel-space support.
 
 Package: libxenomai1
 Section: libs
 Architecture: amd64 arm armeb armel i386 powerpc
 Depends: ${shlibs:Depends}, ${misc:Depends}
-Suggests: linux-patch-xenomai, xenomai-doc
+Suggests: xenomai-kernel-source, xenomai-doc
 Replaces: xenomai
 Conflicts: xenomai
 Description: Shared libraries for Xenomai
@@ -66,7 +66,7 @@ Package: libxenomai-dev
 Section: libdevel
 Architecture: amd64 arm armeb armel i386 powerpc
 Depends: libxenomai1 (= ${binary:Version}), ${misc:Depends}
-Suggests: linux-patch-xenomai, xenomai-doc
+Suggests: xenomai-kernel-source, xenomai-doc
 Replaces: xenomai
 Conflicts: xenomai
 Description: Headers and static libs for Xenomai
diff --git a/debian/linux-patch-xenomai.README.Debian b/debian/linux-patch-xenomai.README.Debian
deleted file mode 100644
index 6a60085..0000000
--- a/debian/linux-patch-xenomai.README.Debian
+++ /dev/null
@@ -1,19 +0,0 @@
-Xenomai kernel patches in Debian
-================================
-
-With this package, you can patch and build kernels suitable for usage with
-Xenomai. This can be done with, e.g.:
-
-# cd /usr/src/linux-source-2.6.32
-# gunzip -c /usr/src/kernel-patches/diffs/xenomai/adeos-ipipe-2.6.37-x86-2.9-00.patch.gz | patch -p1
-# make config
-# make-kpkg --rootcmd fakeroot --initrd kernel_image
-
-(Replace the above patch file with the current appropriate filename.)
-
-This is intended for vanilla and Debian kernel sources.
-
-NOTE: In the kernel config, PARAVIRT should be turned off for Xenomai kernels
-      to compile successfully.
-
- -- Roland Stigge <stigge@antcom.de>, Sun, 14 Feb 2010 15:14:40 +0100
diff --git a/debian/rules b/debian/rules
index 7e5223a..5e3c9df 100755
--- a/debian/rules
+++ b/debian/rules
@@ -6,6 +6,8 @@
 
 #export DH_VERBOSE=1
 
+export DEB_BUILD_HARDENING=1
+
 DEB_HOST_GNU_CPU ?= $(shell dpkg-architecture -qDEB_HOST_GNU_CPU)
 DEB_HOST_ARCH ?= $(shell dpkg-architecture -qDEB_HOST_ARCH)
 DEB_HOST_GNU_TYPE=$(shell dpkg-architecture -qDEB_HOST_GNU_TYPE)
@@ -25,7 +27,7 @@ endif
 build: build-arch build-indep
 
 build-arch: build-arch-stamp
-build-arch-stamp: config.status xenomai-patch-stamp
+build-arch-stamp: config.status
 	dh_testdir
 	$(MAKE)
 	touch build-arch-stamp
@@ -35,13 +37,6 @@ build-indep-stamp: config.status
 	dh_testdir
 	touch build-indep-stamp
 
-xenomai-patch-stamp:
-	dh_testdir
-	for i in arm i386 powerpc x86_64 x86 ; do \
-		bash $(CURDIR)/scripts/prepare-patch.sh $$i ; \
-	done
-	touch xenomai-patch-stamp
-
 config.status: configure-stamp
 configure-stamp:
 	dh_testdir
@@ -52,7 +47,7 @@ configure-stamp:
 clean:
 	dh_testdir
 	dh_testroot
-	rm -f configure-stamp xenomai-patch-stamp build-indep-stamp build-arch-stamp
+	rm -f configure-stamp build-indep-stamp build-arch-stamp
 	-if test -f Makefile ; then \
 	    $(MAKE) distclean ; \
 	fi
@@ -68,9 +63,6 @@ install: build
 	dh_installdirs
 	$(MAKE) install DESTDIR=$(CURDIR)/debian/tmp/
 	dh_install --sourcedir=$(CURDIR)/debian/tmp
-	# Patch collection:
-	mkdir -p $(CURDIR)/debian/linux-patch-xenomai/usr/src/kernel-patches/diffs/xenomai
-	cp *ipipe-*.patch $(CURDIR)/debian/linux-patch-xenomai/usr/src/kernel-patches/diffs/xenomai
 	# xeno-config should be only in libxenomai-dev
 	rm -f $(CURDIR)/debian/xenomai-runtime/usr/bin/xeno-config
 	rm -f $(CURDIR)/debian/xenomai-runtime/usr/share/man/man1/xeno-config.1
@@ -82,8 +74,8 @@ install: build
 	rm -rf $(CURDIR)/debian/xenomai-doc/usr/share/doc/xenomai-doc/ps
 	cp debian/libxenomai1.lintian $(CURDIR)/debian/libxenomai1/usr/share/lintian/overrides/libxenomai1
 	cp debian/libxenomai-dev.lintian $(CURDIR)/debian/libxenomai-dev/usr/share/lintian/overrides/libxenomai-dev
-	# remove *.la files
-	rm $(CURDIR)/debian/libxenomai-dev/usr/lib/*.la
+	mkdir -p $(CURDIR)/debian/xenomai-kernel-source/usr/src/xenomai-kernel-source $(CURDIR)/debian/xenomai-kernel-source/usr/share/doc/xenomai-kernel-source
+	cp -a ksrc include scripts $(CURDIR)/debian/xenomai-kernel-source/usr/src/xenomai-kernel-source
 
 # Build architecture-independent files here.
 binary-indep: build install
@@ -93,7 +85,7 @@ binary-indep: build install
 	dh_link -i
 	dh_installchangelogs -i
 	dh_strip -i
-	dh_compress -i -X.pdf $(CURDIR)/debian/linux-patch-xenomai/usr/src/kernel-patches/diffs/xenomai/*
+	dh_compress -i -X.pdf
 	dh_fixperms -i
 	dh_makeshlibs -i
 	dh_installdeb -i
diff --git a/debian/xenomai-kernel-source.README.Debian b/debian/xenomai-kernel-source.README.Debian
new file mode 100644
index 0000000..e82fade
--- /dev/null
+++ b/debian/xenomai-kernel-source.README.Debian
@@ -0,0 +1,20 @@
+Xenomai kernel sources in Debian
+================================
+
+With this package, you can patch and build kernels suitable for usage with
+Xenomai. This can be done with, e.g.:
+
+# cd /usr/src/linux-3.8.13
+# /usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh --linux=.
+# make config
+# make-kpkg --rootcmd fakeroot --initrd kernel_image
+
+For help about preparing and installing a Xenomai-enabled kernel see:
+http://www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/#prepare-kernel
+
+For help about configuring a Linux kernel for use with Xenomai and in
+particular about the options which should not be enabled see:
+http://www.xenomai.org/index.php/Configuring_x86_kernels
+
+You can also get help on the Xenomai mailing list. Subscribe here:
+http://www.xenomai.org/mailman/listinfo/xenomai
diff --git a/scripts/bootstrap b/scripts/bootstrap
index c7c49b6..e7b8536 100755
--- a/scripts/bootstrap
+++ b/scripts/bootstrap
@@ -1,3 +1,3 @@
 #!/bin/sh
 
-autoreconf --force -i
+autoreconf -fi
diff --git a/scripts/wrap-link.sh b/scripts/wrap-link.sh
index 9bd2434..a16f2da 100755
--- a/scripts/wrap-link.sh
+++ b/scripts/wrap-link.sh
@@ -180,6 +180,10 @@ while test $# -gt 0; do
 	    stage1_args="$stage1_args $arg"
 	    ;;
 
+	-pie)
+	    stage2_args="$stage2_args $arg"
+	    ;;
+
 	*) 
 	    if test -e "$arg"; then
 		add_linker_obj $arg
-- 
1.8.1.2


