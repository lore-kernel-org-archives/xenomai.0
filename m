From: gernot.hillier@siemens.com
Date: Fri,  8 Nov 2013 10:34:17 +0100
Message-Id: <1383903263-10441-2-git-send-email-gernot.hillier@siemens.com>
In-Reply-To: <1383903263-10441-1-git-send-email-gernot.hillier@siemens.com>
References: <1383903263-10441-1-git-send-email-gernot.hillier@siemens.com>
Subject: [Xenomai] [Xenomai-forge PATCH 1/7] Updated debian/* (cherry picked
	from commit 2a229690dffa48bf6eea995280815ac828c0f126)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Roland Stigge <stigge@antcom.de>

---
 debian/changelog                         |  6 ++++++
 debian/compat                            |  2 +-
 debian/control                           |  6 +++---
 debian/linux-patch-xenomai.README.Debian |  4 +++-
 debian/linux-patch-xenomai.kpatches.in   |  3 ---
 debian/rules                             | 33 ++++++++++++++++----------------
 debian/xenomai-runtime.install           |  1 -
 7 files changed, 30 insertions(+), 25 deletions(-)
 delete mode 100644 debian/linux-patch-xenomai.kpatches.in

diff --git a/debian/changelog b/debian/changelog
index c69851e..a0c158d 100644
--- a/debian/changelog
+++ b/debian/changelog
@@ -1,3 +1,9 @@
+xenomai (2.6.1) unstable; urgency=low
+
+  * New release, integrated with debian/ subdir
+
+ -- Roland Stigge <stigge@antcom.de>  Fri, 03 Aug 2012 14:49:57 +0200
+
 xenomai (2.5.3) unstable; urgency=low
 
   * Switch to dpkg-source 3.0 (native) format
diff --git a/debian/compat b/debian/compat
index 7f8f011..45a4fb7 100644
--- a/debian/compat
+++ b/debian/compat
@@ -1 +1 @@
-7
+8
diff --git a/debian/control b/debian/control
index 3c744ca..3bbc2fb 100644
--- a/debian/control
+++ b/debian/control
@@ -2,8 +2,8 @@ Source: xenomai
 Section: devel
 Priority: extra
 Maintainer: Roland Stigge <stigge@antcom.de>
-Build-Depends: debhelper (>= 7), dh-kpatches, findutils (>= 4.2.28)
-Standards-Version: 3.9.1
+Build-Depends: debhelper (>= 8), findutils (>= 4.2.28), autotools-dev, autoconf, automake, libtool
+Standards-Version: 3.9.3
 Homepage: http://www.xenomai.org/
 
 Package: xenomai-runtime
@@ -27,7 +27,7 @@ Description: Xenomai runtime utilities
 Package: linux-patch-xenomai
 Section: kernel
 Architecture: all
-Depends: ${kpatch:Depends}, ${misc:Depends}
+Depends: ${misc:Depends}
 Suggests: xenomai, linux-source-2.6, kernel-package
 Description: Linux kernel patches for Xenomai
  Xenomai is a real-time development framework cooperating with the Linux
diff --git a/debian/linux-patch-xenomai.README.Debian b/debian/linux-patch-xenomai.README.Debian
index 3304bf5..6a60085 100644
--- a/debian/linux-patch-xenomai.README.Debian
+++ b/debian/linux-patch-xenomai.README.Debian
@@ -5,10 +5,12 @@ With this package, you can patch and build kernels suitable for usage with
 Xenomai. This can be done with, e.g.:
 
 # cd /usr/src/linux-source-2.6.32
-# /usr/src/kernel-patches/i386/apply/xenomai
+# gunzip -c /usr/src/kernel-patches/diffs/xenomai/adeos-ipipe-2.6.37-x86-2.9-00.patch.gz | patch -p1
 # make config
 # make-kpkg --rootcmd fakeroot --initrd kernel_image
 
+(Replace the above patch file with the current appropriate filename.)
+
 This is intended for vanilla and Debian kernel sources.
 
 NOTE: In the kernel config, PARAVIRT should be turned off for Xenomai kernels
diff --git a/debian/linux-patch-xenomai.kpatches.in b/debian/linux-patch-xenomai.kpatches.in
deleted file mode 100644
index 7348a5a..0000000
--- a/debian/linux-patch-xenomai.kpatches.in
+++ /dev/null
@@ -1,3 +0,0 @@
-Patch-name: Xenomai realtime kernel patches
-Patch-id: xenomai
-Architecture: all
diff --git a/debian/rules b/debian/rules
index de5827f..f6569f6 100755
--- a/debian/rules
+++ b/debian/rules
@@ -46,10 +46,13 @@ else
 	CONFIG_OPTS += --build $(DEB_BUILD_GNU_TYPE)
 endif
 
+# necessary from GCC 4.6 on
+CFLAGS += -fno-omit-frame-pointer
+
 build: build-arch build-indep
 
 build-arch: build-arch-stamp
-build-arch-stamp: config.status patch-stamp
+build-arch-stamp: config.status xenomai-patch-stamp
 	dh_testdir
 	$(MAKE)
 	touch build-arch-stamp
@@ -59,31 +62,31 @@ build-indep-stamp: config.status
 	dh_testdir
 	touch build-indep-stamp
 
-patch-stamp:
+xenomai-patch-stamp:
 	dh_testdir
-	cp debian/linux-patch-xenomai.kpatches.in debian/linux-patch-xenomai.kpatches
 	for i in arm i386 powerpc x86_64 x86 ; do \
 		bash $(CURDIR)/scripts/prepare-patch.sh $$i ; \
 	done
-	touch patch-stamp
+	touch xenomai-patch-stamp
 
 config.status: configure-stamp
 configure-stamp:
 	dh_testdir
-	./configure $(CONFIG_OPTS)
+	autoreconf -fi
+	./configure $(CONFIG_OPTS) --with-testdir=/usr/lib/xenomai/testsuite
 	touch configure-stamp
 
 clean:
 	dh_testdir
 	dh_testroot
-	rm -f *-stamp
-	dh_clean
-	if test -f Makefile ; then \
+	rm -f configure-stamp xenomai-patch-stamp build-indep-stamp build-arch-stamp
+	-if test -f Makefile ; then \
 	    $(MAKE) distclean ; \
 	fi
+	dh_clean
 	rm -fR $(CURDIR)/tmp
 	rm -f $(CURDIR)/*.patch
-	rm -f $(CURDIR)/debian/*.kpatches
+	-rm -f configure
 
 install: build
 	dh_testdir
@@ -92,6 +95,8 @@ install: build
 	dh_installdirs
 	$(MAKE) install DESTDIR=$(CURDIR)/debian/tmp/
 	dh_install --sourcedir=$(CURDIR)/debian/tmp
+	# Patch collection:
+	cp adeos-ipipe-*.patch $(CURDIR)/debian/linux-patch-xenomai/usr/src/kernel-patches/diffs/xenomai
 	# xeno-config should be only in libxenomai-dev
 	rm -f $(CURDIR)/debian/xenomai-runtime/usr/bin/xeno-config
 	rm -f $(CURDIR)/debian/xenomai-runtime/usr/share/man/man1/xeno-config.1
@@ -103,7 +108,8 @@ install: build
 	rm -rf $(CURDIR)/debian/xenomai-doc/usr/share/doc/xenomai-doc/ps
 	cp debian/libxenomai1.lintian $(CURDIR)/debian/libxenomai1/usr/share/lintian/overrides/libxenomai1
 	cp debian/libxenomai-dev.lintian $(CURDIR)/debian/libxenomai-dev/usr/share/lintian/overrides/libxenomai-dev
-	dh_installkpatches
+	# remove *.la files
+	rm $(CURDIR)/debian/libxenomai-dev/usr/lib/*.la
 
 # Build architecture-independent files here.
 binary-indep: build install
@@ -113,17 +119,12 @@ binary-indep: build install
 	dh_link -i
 	dh_installchangelogs -i
 	dh_strip -i
-	dh_compress -i -X.pdf
+	dh_compress -i -X.pdf $(CURDIR)/debian/linux-patch-xenomai/usr/src/kernel-patches/diffs/xenomai/*
 	dh_fixperms -i
 	dh_makeshlibs -i
 	dh_installdeb -i
 	dh_shlibdeps -i
 	dh_gencontrol -i
-#	 Here follows a little hackery to insert the patch list        
-#	 into the control file for linux-patch-xenomai
-	cat $(CURDIR)/debian/linux-patch-xenomai.kpatches | \
-	    sed -e 's/^$$/./;s/^/ /' >> \
-	        $(CURDIR)/debian/linux-patch-xenomai/DEBIAN/control
 	dh_md5sums -i
 	dh_builddeb -i
 
diff --git a/debian/xenomai-runtime.install b/debian/xenomai-runtime.install
index d1dbe13..e5f1cd6 100644
--- a/debian/xenomai-runtime.install
+++ b/debian/xenomai-runtime.install
@@ -1,5 +1,4 @@
 usr/bin
 usr/sbin
 usr/share/man
-usr/share/xenomai
 usr/lib/xenomai
-- 
1.8.1.2


