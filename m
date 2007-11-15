From: Paul <paul_c@domain.hid>
Date: Thu, 15 Nov 2007 22:02:11 +0000
References: <4739E07B.1000608@domain.hid>
	<200711142214.17651.paul_c@domain.hid>
	<200711150013.51123.lepalom@domain.hid>
In-Reply-To: <200711150013.51123.lepalom@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jHMPHQHZpujCH4P"
Message-Id: <200711152202.11279.paul_c@domain.hid>
Subject: Re: [Xenomai-core] [Xenomai-help] Xenomai v2.4-rc6
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: lepalom@domain.hid
Cc: xenomai@xenomai.org, xenomai@xenomai.org

--Boundary-00=_jHMPHQHZpujCH4P
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 14 November 2007 23:13, Leopold Palomo Avellaneda wrote:
> A Dimecres 14 Novembre 2007, Paul va escriure:
> > On Wednesday 14 November 2007 16:37, Paul wrote:
> > > I'm right in the middle of looking at the packaging scripts, so expect
> > > a patch within the next few days.
> >
> > Attached, one patch for the Debian rules. The debian/changelog version
> > will need to be bumped up to 2.4.0-1 once we get out of the -rc phase.
> > I'll submit a trivial patch at that point and build a set of i386 & amd64
> > packages.
>
> Thank's,
>
> the patch has worked well for me (amd64), however I should say that the
> packages are not lintian free. I can mention:
>
> package xenomai-dev
> ---------------------------------------------------------------------------
>---- W: xenomai-dev: symlink-is-self-recursive
> usr/include/xenomai/asm-sim/xenomai .
> N:
> N:   The symbolic link is recursive to a higher directory of the symlink
> N:   itself. This means, that you can infinitely chdir with this symlink.
> N:   This is usually not okay, but sometimes wanted behaviour.
> N:
> W: xenomai-dev: symlink-is-self-recursive usr/include/xenomai/asm-sim/asm .
> W: xenomai-dev: symlink-is-self-recursive
> usr/include/xenomai/asm-x86/xenomai .
> W: xenomai-dev: symlink-is-self-recursive usr/include/xenomai/xenomai .
> W: xenomai-dev: symlink-is-self-recursive
> usr/include/xenomai/asm-generic/xenomai .

I'm aware of the recursion - Removing the symlinks in question could be 
tackled in automake, but may well break for other people.

> package xenomai
> ---------------------------------------------------------------------------
>---- E: xenomai: shell-script-fails-syntax-check ./usr/bin/xeno-test
> W: xenomai:
> executable-not-elf-or-script ./usr/share/xenomai/testsuite/cyclic/run
> W: xenomai:
> executable-not-elf-or-script ./usr/share/xenomai/testsuite/irqbench/run
> W: xenomai:
> executable-not-elf-or-script ./usr/share/xenomai/testsuite/switchtest/run
> W: xenomai:
> executable-not-elf-or-script ./usr/share/xenomai/testsuite/latency/run
> W: xenomai:
> executable-not-elf-or-script ./usr/share/xenomai/testsuite/clocktest/run
> W: xenomai:
> executable-not-elf-or-script ./usr/share/xenomai/testsuite/switchbench/run
> W: xenomai: non-dev-pkg-with-shlib-symlink usr/lib/libpsos.so.0.0.0
> usr/lib/libpsos.so
> W: xenomai: non-dev-pkg-with-shlib-symlink usr/lib/librtai.so.0.0.0
> usr/lib/librtai.so
> W: xenomai: non-dev-pkg-with-shlib-symlink usr/lib/libnative.so.1.0.0
> usr/lib/libnative.so
> W: xenomai: non-dev-pkg-with-shlib-symlink usr/lib/libuitron.so.0.0.0
> usr/lib/libuitron.so
> W: xenomai: non-dev-pkg-with-shlib-symlink usr/lib/librtdm.so.1.0.0
> usr/lib/librtdm.so
> W: xenomai: non-dev-pkg-with-shlib-symlink usr/lib/libpthread_rt.so.1.0.0
> usr/lib/libpthread_rt.so
> W: xenomai: non-dev-pkg-with-shlib-symlink usr/lib/libvxworks.so.1.0.0
> usr/lib/libvxworks.so
> W: xenomai: non-dev-pkg-with-shlib-symlink usr/lib/librtdk.so.0.0.0
> usr/lib/librtdk.so
> W: xenomai: non-dev-pkg-with-shlib-symlink usr/lib/libvrtx.so.0.0.0
> usr/lib/libvrtx.so

The exec status & symlinks, I feel are outside my remit, as is the libtool 
versioning..

> E: xenomai: postinst-must-call-ldconfig usr/lib/librtdk.so.0.0.0
> W: xenomai: postrm-should-call-ldconfig usr/lib/librtdk.so.0.0.0

Fixed with the new patch.

> E: xenomai: description-starts-with-package-name
> W: xenomai: description-synopsis-might-not-be-phrased-properly

Is it really a problem - I don't feel it is.

> W: xenomai: package-name-doesnt-match-sonames libpsos0 librtdm1 libvxworks1
> libuitron0 librtdk0 librtai0 libnative1 libvrtx0 libpthread-rt1

Current Debian policy appears to be moving towards individual packages for 
each library - Could follow suit, maybe if/when Xenomai is accepted into 
Debian.

> lintian linux-patch-xenomai_2.4.0-0+rc6_all.deb
> internal error: syntax error in section 1 after the tag description:
> Patch-file: adeos-ipipe-2.6.15-arm-1.5-08.patch

Yup, that one has me stumped - If you have any suggestions on eradicating the 
error, I'll use it.
Should point out that the patch generation is *very* rough'n'ready in the 
absence of a kernel source tree.


Regards, Paul.



--Boundary-00=_jHMPHQHZpujCH4P
Content-Type: text/x-diff;
  charset="us-ascii";
  name="debian_rules-rev2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="debian_rules-rev2.diff"

Index: debian/control
===================================================================
--- debian/control	(revision 3185)
+++ debian/control	(working copy)
@@ -14,9 +14,9 @@ Description: Linux kernel patches for Xe
  Xenomai kernel patches - See www.xenomai.org
  .
  Patches for 2.6 series kernels - These are intended for use with kernel-package
- and a virgin linux source tree. Note: These patches include the base adeos-ipipe
- patch along with all the additional material normally added by the prepare-kernel.sh
- script.
+ and a virgin linux source tree. Note: These patches include the base
+ adeos-ipipe patch along with all the additional material normally added by the 
+ prepare-kernel.sh script.
  .
  This package contains the following patches:
  .
Index: debian/xenomai.postinst
===================================================================
--- debian/xenomai.postinst	(revision 3185)
+++ debian/xenomai.postinst	(working copy)
@@ -3,4 +3,8 @@
 rm -f /etc/udev/rules.d/xenomai.rules
 ln -sf ../xenomai.rules /etc/udev/rules.d/xenomai.rules
 
+if [ "$1" = "configure" ]; then
+	ldconfig
+fi
+
 #DEBHELPER#
Index: debian/xenomai.postrm
===================================================================
--- debian/xenomai.postrm	(revision 3185)
+++ debian/xenomai.postrm	(working copy)
@@ -1,8 +1,9 @@
 #!/bin/sh
 
 case "$1" in
-  purge)
+  purge | remove)
   [ ! -L /etc/udev/rules.d/xenomai.rules ] || rm /etc/udev/rules.d/xenomai.rules
+  ldconfig
   ;;
 esac
 
Index: debian/prepare-patch.sh
===================================================================
--- debian/prepare-patch.sh	(revision 3185)
+++ debian/prepare-patch.sh	(working copy)
@@ -54,7 +54,6 @@ patch_link() {
             if test ! -d  $temp_tree/$link_dir/$d ; then
                 mkdir -p $temp_tree/$link_dir/$d
             fi
-echo " cp $xenomai_root/$target_dir/$f $temp_tree/$link_dir/$f"
             cp $xenomai_root/$target_dir/$f $temp_tree/$link_dir/$f
         done
     )
@@ -77,7 +76,6 @@ generate_patch() {
 diff_addons() {
     lines=`(echo ; echo ; cat $xenomai_root/scripts/Kconfig.frag) | wc -l`
 
-#    echo "diff -u1wbr orig/arch/$linux_arch/Kconfig new/arch/$linux_arch/Kconfig" >> $patch_file
     echo "--- linux/arch/$linux_arch/Kconfig	1970-01-01 01:00:00.000000000 +0100" >> $patch_file
     echo "+++ linux-patched/arch/$linux_arch/Kconfig	2007-03-06 17:55:58.000000000 +0000" >> $patch_file
     echo "@@ -40,2 +40,$lines @@" >> $patch_file
@@ -97,9 +95,22 @@ mkdir -p $xenomai_root/tmp/linux.new
 linux_tree="$xenomai_root/tmp/linux"
 temp_tree="$xenomai_root/tmp/linux.new"
 
+
 for linux_arch in $supported_arch ; do
-    patch_link r m ksrc/arch/$linux_arch arch/$linux_arch/xenomai
-    patch_link r n include/asm-$linux_arch include/asm-$linux_arch/xenomai
+    case $linux_arch in
+        i386)
+            base_arch=x86
+            ;;
+        x86_64)
+            base_arch=x86
+            ;;
+        *)
+            base_arch=$linux_arch
+            ;;
+    esac
+
+    patch_link r m ksrc/arch/$base_arch arch/$linux_arch/xenomai
+    patch_link r n include/asm-$base_arch include/asm-$linux_arch/xenomai
 
     p="+drivers-\$(CONFIG_XENOMAI)		+= arch/$linux_arch/xenomai/"
     echo $p | patch_append arch/$linux_arch/Makefile
@@ -115,7 +126,6 @@ echo $p | patch_append kernel/Makefile
 # Create local directories then symlink to the source files from
 # there, so that we don't pollute the Xenomai source tree with
 # compilation files.
-
 patch_link n m ksrc/ kernel/xenomai
 patch_link n m ksrc/arch kernel/xenomai/arch
 patch_link r m ksrc/arch/generic kernel/xenomai/arch/generic
Index: debian/changelog
===================================================================
--- debian/changelog	(revision 3185)
+++ debian/changelog	(working copy)
@@ -1,3 +1,15 @@
+xenomai (2.4.0-0+rc6) unstable; urgency=low
+
+  * Update prepare-patch.sh to use combined x86/i386 Xenomai tree.
+  * Split patch generation out of build-stamp so that it only gets
+    called once along with the configure.
+  * In pursuit of silencing lintian:
+    * Rename top level ChangeLog to changelog when installed.
+    * Add ldconfig to post install/remove scripts.
+    * Compress changelogs.
+
+ -- Paul Corner <paul_c@domain.hid>  Wed, 14 Nov 2007 21:48:27 +0000
+
 xenomai (2.3.50-05+r2299) unstable; urgency=low
 
   * Add top level ChangeLog and CREDITS to each package.
Index: debian/rules
===================================================================
--- debian/rules	(revision 3185)
+++ debian/rules	(working copy)
@@ -34,21 +34,25 @@ endif
 	            --includedir=/usr/include/xenomai \
 	            --mandir=/usr/share/man
 
-build: build-stamp
-	./configure $(CONFIG_OPTS)
+build: build-stamp patch-stamp
 	$(MAKE)
-#	The kernel patches get generated next - Likely to involve some
-#	additional scripting..
+
+patch-stamp:
+	dh_testdir
+	touch patch-stamp
+#	The kernel patches get generated next - Need to revisit again
+#	when 2.6.24 ipipe patch is released.
 	$(CURDIR)/debian/prepare-patch.sh arm i386 powerpc x86_64
 
 build-stamp:
 	dh_testdir
 	touch build-stamp
+	./configure $(CONFIG_OPTS)
 
 clean:
 	dh_testdir
 	dh_testroot
-	rm -f build-stamp
+	rm -f *-stamp
 	dh_clean
 	if test -f Makefile ; then \
 	    $(MAKE) distclean 2>/dev/null ; \
@@ -109,9 +113,10 @@ install: build
 #	Add CREDITS, ChangeLog, and READMEs to all packages.
 	for p in linux-patch-xenomai xenomai xenomai-dev xenomai-docs ; do \
 	    mkdir -p $(CURDIR)/debian/$$p/usr/share/doc/$$p ; \
-	    for f in CREDITS ChangeLog README.INSTALL TROUBLESHOOTING ; do \
+	    for f in CREDITS README.INSTALL TROUBLESHOOTING ; do \
 	        install -m 0644 $$f $(CURDIR)/debian/$$p/usr/share/doc/$$p/ ; \
 	    done ; \
+	    install -m 0644 -T ChangeLog $(CURDIR)/debian/$$p/usr/share/doc/$$p/changelog ; \
 	done
 
 # Build architecture-independent files here.
@@ -122,7 +127,7 @@ binary-indep: install
 	dh_installchangelogs
 	dh_link
 	dh_strip
-#	dh_compress
+	dh_compress
 	dh_fixperms
 	dh_installdeb
 	dh_makeshlibs

--Boundary-00=_jHMPHQHZpujCH4P--

