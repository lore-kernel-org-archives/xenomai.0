Message-ID: <483AA731.8050404@domain.hid>
Date: Mon, 26 May 2008 14:04:01 +0200
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
References: <480A4AF3.9010502@domain.hid>	<18489.35854.502315.832894@domain.hid>	<4839907C.4000102@domain.hid>
	<18489.37401.679912.195018@domain.hid>
In-Reply-To: <18489.37401.679912.195018@domain.hid>
Content-Type: multipart/mixed; boundary="------------030400020706090005030702"
Subject: Re: [Xenomai-core] Debian package xenomai-2.4.3-4 available
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------030400020706090005030702
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Gilles Chanteperdrix wrote:
>  > So feel free to do a 2.4.4 (or whatever) release soon. :-)
>  > 
>  > (For integrating the Debian changes in addition to the respective
>  > upstream changes, just remove the man pages in debian/,
>  > debian/xenomai-runtime.manpages and the /bin/bash patch.)
> 
> I would have felt more comfortable if you could have done it (and more
> importantly test it). Besides, the 2.4.4 release is coming, and I would
> have liked to release it with all the changes that you made.

I'm attaching a patch that I would apply to branches/v2.4.x if it would
be considered as 2.4.4.

Please note that on integrating Xenomai 2.4.4 (or whatever) upstream in
Debian, I will strip debian/* from the original tarball to separate the
Debian part from "upstream". For the same reason, please consider to
remove it from the tarball. (It can stay in SVN, though.)

bye,
  Roland

--------------030400020706090005030702
Content-Type: text/x-diff;
 name="xenomai.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai.patch"

diff -ruN xenomai-2.4.x/configure.in debian/xenomai-2.4.4/configure.in
--- xenomai-2.4.x/configure.in	2008-05-26 13:23:26.000000000 +0200
+++ debian/xenomai-2.4.4/configure.in	2008-05-26 11:55:24.000000000 +0200
@@ -799,6 +799,17 @@
 	doc/Makefile \
 	doc/txt/Makefile \
 	doc/man/Makefile \
+	doc/man/clocktest.man \
+	doc/man/cyclictest.man \
+	doc/man/irqbench.man \
+	doc/man/irqloop.man \
+	doc/man/klatency.man \
+	doc/man/latency.man \
+	doc/man/rtcanconfig.man \
+	doc/man/rtcanrecv.man \
+	doc/man/rtcansend.man \
+	doc/man/switchbench.man \
+	doc/man/switchtest.man \
 	doc/man/runinfo.man \
 	doc/man/xeno-config.man \
 	doc/man/xeno-info.man \
diff -ruN xenomai-2.4.x/debian/changelog debian/xenomai-2.4.4/debian/changelog
--- xenomai-2.4.x/debian/changelog	2008-05-26 10:52:55.000000000 +0200
+++ debian/xenomai-2.4.4/debian/changelog	2008-05-26 12:32:42.000000000 +0200
@@ -1,3 +1,63 @@
+xenomai (2.4.4-1) unstable; urgency=low
+
+  * New upstream release
+
+ -- Roland Stigge <stigge@domain.hid>  Mon, 26 May 2008 11:58:30 +0200
+
+xenomai (2.4.3-7) unstable; urgency=low
+
+  * Included patch from Riku Voipio to fix ARM compile issues
+    (Closes: #477720)
+
+ -- Roland Stigge <stigge@domain.hid>  Thu, 24 Apr 2008 23:18:01 +0200
+
+xenomai (2.4.3-6) unstable; urgency=low
+
+  * Added lintian override for recursive include directories (necessary
+    according to upstream)
+  * Added missing man pages (can be removed when integrated upstream)
+  * debian/rules: Fixed klatency/run script to be proper shell script
+
+ -- Roland Stigge <stigge@domain.hid>  Tue, 22 Apr 2008 12:23:22 +0200
+
+xenomai (2.4.3-5) unstable; urgency=low
+
+  * Install xeno-config into libxenomai-dev where the executable is
+
+ -- Roland Stigge <stigge@domain.hid>  Sat, 19 Apr 2008 22:15:07 +0200
+
+xenomai (2.4.3-4) unstable; urgency=low
+
+  * Move /usr/lib/xenomai to original upstream /usr/share/xenomai
+
+ -- Roland Stigge <stigge@domain.hid>  Fri, 18 Apr 2008 19:51:49 +0200
+
+xenomai (2.4.3-3) unstable; urgency=low
+
+  * debian/rules: Separated prepare-patch.sh calls for individual
+    architectures (Closes: #473098)
+
+ -- Roland Stigge <stigge@domain.hid>  Thu, 10 Apr 2008 10:01:33 +0200
+
+xenomai (2.4.3-2) unstable; urgency=low
+
+  * Enable x86 patches for both i386 and amd64 (Closes: #473098)
+
+ -- Roland Stigge <stigge@domain.hid>  Tue, 01 Apr 2008 10:04:51 +0200
+
+xenomai (2.4.3-1) unstable; urgency=low
+
+  * New upstream release
+  * Added debian/watch
+
+ -- Roland Stigge <stigge@domain.hid>  Tue, 25 Mar 2008 14:13:50 +0100
+
+xenomai (2.4.2-3) unstable; urgency=low
+
+  * Fixed bashisms by using "#!/bin/bash" (Closes: #471871)
+
+ -- Roland Stigge <stigge@domain.hid>  Sat, 22 Mar 2008 17:01:11 +0100
+
 xenomai (2.4.2-2) unstable; urgency=low
 
   * debian/copyright: Refined Copyrights
diff -ruN xenomai-2.4.x/debian/control debian/xenomai-2.4.4/debian/control
--- xenomai-2.4.x/debian/control	2008-05-26 10:52:55.000000000 +0200
+++ debian/xenomai-2.4.4/debian/control	2008-05-26 11:58:29.000000000 +0200
@@ -8,7 +8,7 @@
 
 Package: xenomai-runtime
 Section: devel
-Architecture: amd64 arm i386 ia64 powerpc
+Architecture: amd64 arm armeb armel i386 ia64 powerpc
 Depends: ${shlibs:Depends}
 Suggests: linux-patch-xenomai, xenomai-doc
 Replaces: xenomai
@@ -47,7 +47,7 @@
 
 Package: libxenomai1
 Section: libs
-Architecture: amd64 arm i386 ia64 powerpc
+Architecture: amd64 arm armeb armel i386 ia64 powerpc
 Depends: ${shlibs:Depends}
 Suggests: linux-patch-xenomai, xenomai-doc
 Replaces: xenomai
@@ -64,7 +64,7 @@
 
 Package: libxenomai-dev
 Section: libdevel
-Architecture: amd64 arm i386 ia64 powerpc
+Architecture: amd64 arm armeb armel i386 ia64 powerpc
 Depends: libxenomai1 (= ${binary:Version})
 Suggests: linux-patch-xenomai, xenomai-doc
 Replaces: xenomai
diff -ruN xenomai-2.4.x/debian/libxenomai1.lintian debian/xenomai-2.4.4/debian/libxenomai1.lintian
--- xenomai-2.4.x/debian/libxenomai1.lintian	2008-05-26 10:52:55.000000000 +0200
+++ debian/xenomai-2.4.4/debian/libxenomai1.lintian	2008-05-26 11:58:29.000000000 +0200
@@ -1 +1,2 @@
+# no contained shared library names refer to "xenomai", therefore own name
 libxenomai1: package-name-doesnt-match-sonames libnative1 libpsos0 libpthread-rt1 librtai0 librtdk0 librtdm1 libuitron0 libvrtx0 libvxworks1
diff -ruN xenomai-2.4.x/debian/libxenomai-dev.dirs debian/xenomai-2.4.4/debian/libxenomai-dev.dirs
--- xenomai-2.4.x/debian/libxenomai-dev.dirs	1970-01-01 01:00:00.000000000 +0100
+++ debian/xenomai-2.4.4/debian/libxenomai-dev.dirs	2008-05-26 11:58:29.000000000 +0200
@@ -0,0 +1 @@
+usr/share/lintian/overrides
diff -ruN xenomai-2.4.x/debian/libxenomai-dev.install debian/xenomai-2.4.4/debian/libxenomai-dev.install
--- xenomai-2.4.x/debian/libxenomai-dev.install	2008-05-26 10:52:55.000000000 +0200
+++ debian/xenomai-2.4.4/debian/libxenomai-dev.install	2008-05-26 11:58:29.000000000 +0200
@@ -4,6 +4,7 @@
 usr/lib/*.a
 usr/lib/*.so
 usr/lib/posix.wrappers
+usr/share/man/man1/xeno-config.1
 ../../examples usr/share/libxenomai-dev
 ../../ksrc/skins/vxworks/demos usr/share/libxenomai-dev/examples/kernel/skins/vxworks
 ../../ksrc/skins/native/demos usr/share/libxenomai-dev/examples/kernel/skins/native
diff -ruN xenomai-2.4.x/debian/libxenomai-dev.lintian debian/xenomai-2.4.4/debian/libxenomai-dev.lintian
--- xenomai-2.4.x/debian/libxenomai-dev.lintian	1970-01-01 01:00:00.000000000 +0100
+++ debian/xenomai-2.4.4/debian/libxenomai-dev.lintian	2008-05-26 11:58:29.000000000 +0200
@@ -0,0 +1,7 @@
+# Upstream author insists that those recursive directories exist for
+# compatibility reasons of compiles applications
+libxenomai-dev: symlink-is-self-recursive usr/include/xenomai/asm-generic/xenomai .
+libxenomai-dev: symlink-is-self-recursive usr/include/xenomai/asm-sim/asm .
+libxenomai-dev: symlink-is-self-recursive usr/include/xenomai/asm-sim/xenomai .
+libxenomai-dev: symlink-is-self-recursive usr/include/xenomai/asm-x86/xenomai .
+libxenomai-dev: symlink-is-self-recursive usr/include/xenomai/xenomai .
diff -ruN xenomai-2.4.x/debian/linux-patch-xenomai.kpatches.in debian/xenomai-2.4.4/debian/linux-patch-xenomai.kpatches.in
--- xenomai-2.4.x/debian/linux-patch-xenomai.kpatches.in	1970-01-01 01:00:00.000000000 +0100
+++ debian/xenomai-2.4.4/debian/linux-patch-xenomai.kpatches.in	2008-05-26 11:58:29.000000000 +0200
@@ -0,0 +1,3 @@
+Patch-name: Xenomai realtime kernel patches
+Patch-id: xenomai
+Architecture: all
diff -ruN xenomai-2.4.x/debian/linux-patch-xenomai.README.Debian debian/xenomai-2.4.4/debian/linux-patch-xenomai.README.Debian
--- xenomai-2.4.x/debian/linux-patch-xenomai.README.Debian	1970-01-01 01:00:00.000000000 +0100
+++ debian/xenomai-2.4.4/debian/linux-patch-xenomai.README.Debian	2008-05-26 11:58:29.000000000 +0200
@@ -0,0 +1,15 @@
+Xenomai kernel patches in Debian
+================================
+
+With this package, you can patch and build kernels suitable for usage with
+Xenomai. This can be done with, e.g.:
+
+# cd /usr/src/linux-source-2.6.24
+# fakeroot make-kpkg --initrd --added-patches xenomai kernel_image
+
+This is intended for vanilla and Debian kernel sources.
+
+NOTE: In the kernel config, PARAVIRT should be turned off for Xenomai kernels
+      to compile successfully.
+
+ -- Roland Stigge <stigge@domain.hid>, Fri, 11 Apr 2008 09:02:28 +0200
diff -ruN xenomai-2.4.x/debian/prepare-patch.sh debian/xenomai-2.4.4/debian/prepare-patch.sh
--- xenomai-2.4.x/debian/prepare-patch.sh	2008-05-26 10:52:55.000000000 +0200
+++ debian/xenomai-2.4.4/debian/prepare-patch.sh	2008-05-26 11:58:29.000000000 +0200
@@ -104,6 +104,9 @@
         x86_64)
             base_arch=x86
             ;;
+        x86)
+            base_arch=x86
+            ;;
         *)
             base_arch=$linux_arch
             ;;
@@ -146,11 +149,11 @@
 
 cd $xenomai_root
 
-echo "Patch-name: Xenomai realtime kernel patches" > $xenomai_root/debian/linux-patch-xenomai.kpatches
-echo "Patch-id: xenomai" >> $xenomai_root/debian/linux-patch-xenomai.kpatches
-echo "Architecture: all" >> $xenomai_root/debian/linux-patch-xenomai.kpatches
+#echo "Patch-name: Xenomai realtime kernel patches" > $xenomai_root/debian/linux-patch-xenomai.kpatches
+#echo "Patch-id: xenomai" >> $xenomai_root/debian/linux-patch-xenomai.kpatches
+#echo "Architecture: all" >> $xenomai_root/debian/linux-patch-xenomai.kpatches
 
-find $xenomai_root/ksrc/ -name "adeos-ipipe-2.6.*.patch" |
+find $xenomai_root/ksrc/ -name "adeos-ipipe-2.6.*-$supported_arch-*.patch" |
 while read f ; do
 
     file=`basename $f`
@@ -173,6 +176,9 @@
         x86_64)
             march=amd64
         ;;
+	x86)
+	    march=i386
+	;;
     esac
 
     # Only one patch per arch/kver - Having a common plus kver/arch patch
@@ -183,6 +189,13 @@
     echo "Kernel-version: $kver" >> $xenomai_root/debian/linux-patch-xenomai.kpatches
     echo "Architecture: $march" >> $xenomai_root/debian/linux-patch-xenomai.kpatches
 
+    if [ "$arch" = "x86" ] ; then
+	echo "" >> $xenomai_root/debian/linux-patch-xenomai.kpatches
+	echo "Patch-file: $file" >> $xenomai_root/debian/linux-patch-xenomai.kpatches
+	echo "Kernel-version: $kver" >> $xenomai_root/debian/linux-patch-xenomai.kpatches
+	echo "Architecture: amd64" >> $xenomai_root/debian/linux-patch-xenomai.kpatches
+    fi
+
     cp $f $xenomai_root/$file
     cat $xenomai_root/$patch_file >> $xenomai_root/$file
 
diff -ruN xenomai-2.4.x/debian/rules debian/xenomai-2.4.4/debian/rules
--- xenomai-2.4.x/debian/rules	2008-05-26 10:52:55.000000000 +0200
+++ debian/xenomai-2.4.4/debian/rules	2008-05-26 12:03:17.000000000 +0200
@@ -6,26 +6,32 @@
 
 #export DH_VERBOSE=1
 
-DEB_BUILD_GNU_CPU ?= $(shell dpkg-architecture -qDEB_BUILD_GNU_CPU)
-DEB_BUILD_ARCH ?= $(shell dpkg-architecture -qDEB_BUILD_ARCH)
+DEB_HOST_GNU_CPU ?= $(shell dpkg-architecture -qDEB_HOST_GNU_CPU)
+DEB_HOST_ARCH ?= $(shell dpkg-architecture -qDEB_HOST_ARCH)
 
-ifeq ($(DEB_BUILD_ARCH), i386)
+ifeq ($(DEB_HOST_ARCH), i386)
 # Note: Would like to use --includedir=/usr/include/xenomai, but
 # there appears to be a `make install` problem.
 	CONFIG_OPTS = \
 	            --enable-x86-tsc
 endif
-ifeq ($(DEB_BUILD_ARCH), amd64)
+ifeq ($(DEB_HOST_ARCH), amd64)
 	CONFIG_OPTS = \
 	            --enable-smp \
 	            --enable-x86-tsc \
 	            --enable-x86-sep
 endif
-ifeq ($(DEB_BUILD_ARCH), powerpc)
+ifeq ($(DEB_HOST_ARCH), powerpc)
 	CONFIG_OPTS =
 endif
-ifeq ($(DEB_BUILD_ARCH), arm)
-	CONFIG_OPTS =
+ifeq ($(DEB_HOST_ARCH), armeb)
+	CONFIG_OPTS = --enable-arm-mach=imx --enable-arm-tsc --enable-arm-eabi
+endif
+ifeq ($(DEB_HOST_ARCH), armel)
+	CONFIG_OPTS = --enable-arm-mach=imx --enable-arm-tsc --enable-arm-eabi
+endif
+ifeq ($(DEB_HOST_ARCH), arm)
+	CONFIG_OPTS = --enable-arm-mach=imx --enable-arm-tsc
 endif
 	CONFIG_OPTS += --prefix=/usr \
 	            --includedir=/usr/include/xenomai \
@@ -46,9 +52,10 @@
 
 patch-stamp:
 	dh_testdir
-#	The kernel patches get generated next - Need to revisit again
-#	when 2.6.24 ipipe patch is released.
-	bash $(CURDIR)/debian/prepare-patch.sh arm i386 powerpc x86_64
+	cp debian/linux-patch-xenomai.kpatches.in debian/linux-patch-xenomai.kpatches
+	for i in arm i386 powerpc x86_64 x86 ; do \
+		bash $(CURDIR)/debian/prepare-patch.sh $$i ; \
+	done
 	touch patch-stamp
 
 config.status: configure-stamp
@@ -78,12 +85,14 @@
 	dh_install --sourcedir=$(CURDIR)/debian/tmp
 	# xeno-config should be only in libxenomai-dev
 	rm -f $(CURDIR)/debian/xenomai-runtime/usr/bin/xeno-config
+	rm -f $(CURDIR)/debian/xenomai-runtime/usr/share/man/man1/xeno-config.1
 	for f in $(CURDIR)/ksrc/nucleus/udev/*.rules ; do \
 	    cat $$f >> $(CURDIR)/debian/libxenomai1/etc/udev/xenomai.rules ; \
 	done
 	# remove empty directory
 	rm -rf $(CURDIR)/debian/xenomai-doc/usr/share/doc/xenomai-doc/ps
 	cp debian/libxenomai1.lintian $(CURDIR)/debian/libxenomai1/usr/share/lintian/overrides/libxenomai1
+	cp debian/libxenomai-dev.lintian $(CURDIR)/debian/libxenomai-dev/usr/share/lintian/overrides/libxenomai-dev
 	dh_installkpatches
 
 # Build architecture-independent files here.
@@ -112,6 +121,7 @@
 binary-arch: build install
 	dh_testdir -s
 	dh_testroot -s
+	dh_installman -s
 	dh_installdocs -s -A CREDITS README.INSTALL TROUBLESHOOTING
 	dh_installchangelogs -s ChangeLog
 	dh_link -s
diff -ruN xenomai-2.4.x/debian/watch debian/xenomai-2.4.4/debian/watch
--- xenomai-2.4.x/debian/watch	1970-01-01 01:00:00.000000000 +0100
+++ debian/xenomai-2.4.4/debian/watch	2008-05-26 11:58:29.000000000 +0200
@@ -0,0 +1,2 @@
+version=3
+http://download.gna.org/xenomai/stable/xenomai-(.*)\.tar\.bz2
diff -ruN xenomai-2.4.x/debian/xenomai-doc.install debian/xenomai-2.4.4/debian/xenomai-doc.install
--- xenomai-2.4.x/debian/xenomai-doc.install	2008-05-26 10:52:55.000000000 +0200
+++ debian/xenomai-2.4.4/debian/xenomai-doc.install	2008-05-26 11:58:29.000000000 +0200
@@ -1 +1 @@
-usr/share/doc/xenomai-2.4.*/* usr/share/doc/xenomai-doc
+usr/share/doc/xenomai/* usr/share/doc/xenomai-doc
diff -ruN xenomai-2.4.x/debian/xenomai-runtime.install debian/xenomai-2.4.4/debian/xenomai-runtime.install
--- xenomai-2.4.x/debian/xenomai-runtime.install	2008-05-26 10:52:55.000000000 +0200
+++ debian/xenomai-2.4.4/debian/xenomai-runtime.install	2008-05-26 11:58:29.000000000 +0200
@@ -1,4 +1,4 @@
 usr/bin
 usr/sbin
 usr/share/man
-usr/share/xenomai usr/lib
+usr/share/xenomai
diff -ruN xenomai-2.4.x/doc/man/Makefile.am debian/xenomai-2.4.4/doc/man/Makefile.am
--- xenomai-2.4.x/doc/man/Makefile.am	2008-05-26 13:23:26.000000000 +0200
+++ debian/xenomai-2.4.4/doc/man/Makefile.am	2008-05-26 11:41:19.000000000 +0200
@@ -1,7 +1,7 @@
 man1_MANS = xeno-config.man xeno-info.man xeno-load.man xeno-test.man \
-	    clocktest.man.in cyclictest.man.in irqbench.man.in irqloop.man.in \
-	    klatency.man.in latency.man.in rtcanconfig.man.in \
-	    rtcanrecv.man.in rtcansend.man.in switchbench.man.in \
-	    switchtest.man.in
+	    clocktest.man cyclictest.man irqbench.man irqloop.man \
+	    klatency.man latency.man rtcanconfig.man \
+	    rtcanrecv.man rtcansend.man switchbench.man \
+	    switchtest.man
 
 man5_MANS = runinfo.man
diff -ruN xenomai-2.4.x/scripts/xeno-test.in debian/xenomai-2.4.4/scripts/xeno-test.in
--- xenomai-2.4.x/scripts/xeno-test.in	2008-05-26 10:53:08.000000000 +0200
+++ debian/xenomai-2.4.4/scripts/xeno-test.in	2008-05-26 12:14:19.000000000 +0200
@@ -441,18 +441,18 @@
 #
 #2. Much more testing.  Heres a weak start. You migth be better off
 #using and improving test/test-xeno-test.rb.
-
-#!/bin/bash
-PATH=.:$PATH
-xeno-test -L
-xeno-test -N foo -T 18 -l 6 -s
-xeno-test -L -N foo1-
-xeno-test -m
-xeno-test -T 1 -M $USER@localhost
-xeno-test -N foo0 -w0 -l 5 -T 30 -h
-xeno-test -L -N foo4- -w4
-xeno-test -L -N foo4W- -w4 -W 'dd if=/dev/hda1 of=/dev/null'
-
-3. Repeat the same tests under the BusyBox.
-
-4. Check for border cases like missing awk, curl, mail, script, /proc/config.gz
+#
+##!/bin/bash
+#PATH=.:$PATH
+#xeno-test -L
+#xeno-test -N foo -T 18 -l 6 -s
+#xeno-test -L -N foo1-
+#xeno-test -m
+#xeno-test -T 1 -M $USER@localhost
+#xeno-test -N foo0 -w0 -l 5 -T 30 -h
+#xeno-test -L -N foo4- -w4
+#xeno-test -L -N foo4W- -w4 -W 'dd if=/dev/hda1 of=/dev/null'
+#
+#3. Repeat the same tests under the BusyBox.
+#
+#4. Check for border cases like missing awk, curl, mail, script, /proc/config.gz

--------------030400020706090005030702--

