From: Paul <paul_c@domain.hid>
Date: Wed, 14 Nov 2007 22:14:17 +0000
References: <4739E07B.1000608@domain.hid> <200711141056.06083.lepalom@domain.hid>
	<200711141637.30166.paul_c@domain.hid>
In-Reply-To: <200711141637.30166.paul_c@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5M3OHbMI/ZTu9uS"
Message-Id: <200711142214.17651.paul_c@domain.hid>
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
To: xenomai@xenomai.org
Cc: Leopold Palomo-Avellaneda <lepalom@domain.hid>

--Boundary-00=_5M3OHbMI/ZTu9uS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 14 November 2007 16:37, Paul wrote:
> I'm right in the middle of looking at the packaging scripts, so expect a
> patch within the next few days.

Attached, one patch for the Debian rules. The debian/changelog version will 
need to be bumped up to 2.4.0-1 once we get out of the -rc phase. I'll submit 
a trivial patch at that point and build a set of i386 & amd64 packages.

Regards, Paul.





--Boundary-00=_5M3OHbMI/ZTu9uS
Content-Type: text/x-diff;
  charset="us-ascii";
  name="debian_rules.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="debian_rules.diff"

Index: debian/changelog
===================================================================
--- debian/changelog	(revision 3182)
+++ debian/changelog	(working copy)
@@ -1,3 +1,11 @@
+xenomai (2.4.0-0+rc6) unstable; urgency=low
+
+  * Update prepare-patch.sh to use combined x86/i386 Xenomai tree.
+  * Split patch generation out of build-stamp so that it only gets
+    called once along with the configure.
+
+ -- Paul Corner <paul_c@domain.hid>  Wed, 14 Nov 2007 21:48:27 +0000
+
 xenomai (2.3.50-05+r2299) unstable; urgency=low
 
   * Add top level ChangeLog and CREDITS to each package.
Index: debian/prepare-patch.sh
===================================================================
--- debian/prepare-patch.sh	(revision 3182)
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
Index: debian/rules
===================================================================
--- debian/rules	(revision 3182)
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

--Boundary-00=_5M3OHbMI/ZTu9uS--

