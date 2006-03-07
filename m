From: Romain Lenglet <rlenglet@domain.hid>
Date: Tue, 7 Mar 2006 21:10:14 +0900
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mgXDEzfG1NOUo2U"
Message-Id: <200603072110.14791.rlenglet@domain.hid>
Subject: [Xenomai-core] prepare-kernel.sh patch to factorize generated
	patches
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

--Boundary-00=_mgXDEzfG1NOUo2U
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I have added two new command-line options to prepare-kernel.sh to 
filter the changes to record in the generated patch files.
The patch to prepare-kernel.sh is attached.

I have observed that most of the changes (95% in size) are not 
specific to the kernel version or the architecture, so it is a 
waste of space to include those changes in every patch for every 
kernel version / architecture combination (every patch file 
would be about 2Mo!).

With the new options, we can generate four distinct patch files 
(figures are for 2.6.15 / i386):
- kernel-specific and arch-specific: 24 lines / 617 bytes
- kernel-specific and arch-NON-specific: 16 lines / 572 bytes
- kernel-NON-specific and arch-specific: 3116 lines / 95633 bytes
- kernel-NON-specific and arch-NON-specific: 77661 lines / 
2095346 bytes

total: 80817 lines / 2192168 bytes

Xenomai supports 6 architectures. Say that we want to generate 
patches for 10 Linux versions, all patch files now take only 
about:
2095346 + 6*95633 + 10*572 + 6*10*617 = 2711884 bytes

-- 
Romain LENGLET

--Boundary-00=_mgXDEzfG1NOUo2U
Content-Type: text/x-diff; charset="us-ascii";
	name="patchfilter_2006-03-07.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patchfilter_2006-03-07.patch"

--- xenomai/ChangeLog	2006-03-07 12:34:36.621119888 +0900
+++ xenomai-scriptmod/ChangeLog	2006-03-07 20:54:47.705741544 +0900
@@ -1,3 +1,11 @@
+2006-02-27  Romain Lenglet <rlenglet@domain.hid>
+
+	* scripts/prepare-kernel.sh: Added options to select changes to ignore
+	and to not include in the output patch file when the --outpatch option
+	is used: --filterkvers=y|n and --filterarch=y|n.
+	The ksrc/nucleus/udev/ directory is no more copied into the Linux
+	tree.
+
 2006-03-06  Jan Kiszka  <jan.kiszka@domain.hid>
 
 	* src/skins/{native,posix,rtdm}/Makefile.am: Suppress warnings
--- xenomai/scripts/prepare-kernel.sh	2006-02-28 12:11:09.817490880 +0900
+++ xenomai-scriptmod/scripts/prepare-kernel.sh	2006-03-07 20:54:14.832739000 +0900
@@ -1,6 +1,29 @@
 #! /bin/bash
 set -e
 
+# At all time, this variable must be set to either:
+# "y" if the changes to the Linux tree are specific to the kernel version;
+# "n" otherwise.
+patch_kernelversion_specific="n"
+
+# At all time, this variable must be set to either:
+# "y" if the changes to the Linux tree are specific to the architecture;
+# "n" otherwise.
+patch_architecture_specific="n"
+
+# At all time, this variable must be set to either:
+# "y": ignore kernel-version-specific changes;
+# "n": ignore non-kernel-version-specific changes;
+# "b": don't filter according to the kernel version.
+patch_kernelversion_filter="b"
+
+# At all time, this variable must be set to either:
+# "y": ignore architecture-specific changes;
+# "n": ignore non-architecture-specific changes;
+# "b": don't filter according to the architecture.
+patch_architecture_filter="b"
+
+
 patch_copytempfile() {
     file="$1"
     if ! test -f "$temp_tree/$file"; then
@@ -10,26 +33,40 @@
     fi
 }
 
+check_filter() {
+    if test "$patch_kernelversion_specific" != "$patch_kernelversion_filter" \
+        -a "$patch_architecture_specific" != "$patch_architecture_filter"; then
+        echo ok
+    elif test -e "$temp_tree/$1"; then
+        echo "$me: inconsistent multiple changes to $1 in Linux kernel tree" >&2
+	echo error
+    else
+        echo ignore
+    fi
+}
+
 patch_append() {
     file="$1"
     if test "x$output_patch" = "x"; then
-        realfile="$linux_tree/$file"
+        cat >> "$linux_tree/$file"
     else
-        patch_copytempfile "$file"
-        realfile="$temp_tree/$file"
+        if test `check_filter $file` = "ok"; then
+            patch_copytempfile "$file"
+            cat >> "$temp_tree/$file"
+        fi
     fi
-    cat >> "$realfile"
 }
 
 patch_ed() {
     file="$1"
     if test "x$output_patch" = "x"; then
-        realfile="$linux_tree/$file"
+        ed -s "$linux_tree/$file" > /dev/null
     else
-        patch_copytempfile "$file"
-        realfile="$temp_tree/$file"
+        if test `check_filter $file` = "ok"; then
+            patch_copytempfile "$file"
+            ed -s "$temp_tree/$file" > /dev/null
+        fi
     fi
-    ed -s "$realfile" > /dev/null
 }
 
 patch_link() {
@@ -73,8 +110,10 @@
                     ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
                 fi
             else
-                mkdir -p $temp_tree/$link_dir/$d
-                cp $xenomai_root/$target_dir/$f $temp_tree/$link_dir/$f
+                if test `check_filter $link_dir/$f` = "ok"; then
+                    mkdir -p $temp_tree/$link_dir/$d
+                    cp $xenomai_root/$target_dir/$f $temp_tree/$link_dir/$f
+                fi
             fi
         done
     )
@@ -94,7 +133,7 @@
 }
 
 
-usage='usage: prepare-kernel --linux=<linux-tree> --adeos=<adeos-patch> [--arch=<arch>] [--outpatch=<file> <tempdir>] [--forcelink]'
+usage='usage: prepare-kernel --linux=<linux-tree> --adeos=<adeos-patch> [--arch=<arch>] [--outpatch=<file> <tempdir> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink]'
 me=`basename $0`
 
 while test $# -gt 0; do
@@ -115,6 +154,12 @@
 	shift
 	temp_tree=`echo $1|sed -e 's,^--tempdir=\\(.*\\)$,\\1,g'`
 	;;
+    --filterkvers=*)
+        patch_kernelversion_filter=`echo $1|sed -e 's,^--filterkvers=\\(.*\\)$,\\1,g'`
+        ;;
+    --filterarch=*)
+        patch_architecture_filter=`echo $1|sed -e 's,^--filterarch=\\(.*\\)$,\\1,g'`
+        ;;
     --forcelink)
         forcelink=1
         ;;
@@ -163,13 +208,15 @@
 linux_out=$linux_tree
 
 if test \! -r $linux_tree/Makefile; then
-   echo "$me: $linux_tree is not a valid Linux kernel tree"
+   echo "$me: $linux_tree is not a valid Linux kernel tree" >&2
    exit 2
 fi
 
 # Create an empty output patch file, and initialize the temporary tree.
 if test "x$output_patch" != "x"; then
 
+    # The directory must exist, but should be empty. To lower the risks of data
+    # loss, the script does not deletes files itself.
     if test ! -d $temp_tree; then
         echo "$me: $temp_tree (temporary tree) is not an existing directory" >&2
         exit 2
@@ -314,6 +361,8 @@
    exit 2
 fi
 
+patch_kernelversion_specific="y"
+
 case $linux_VERSION.$linux_PATCHLEVEL in
 
     #
@@ -324,6 +373,8 @@
 
     config_file=Kconfig
 
+    patch_architecture_specific="y"
+
     if ! grep -q XENOMAI $linux_tree/init/Kconfig; then
 	sed -e "s,@LINUX_ARCH@,$linux_arch,g" $xenomai_root/scripts/Kconfig.frag |
             patch_append init/Kconfig
@@ -334,6 +385,8 @@
 	( echo ; echo $p ) | patch_append arch/$linux_arch/Makefile
     fi
 
+    patch_architecture_specific="n"
+
     if ! grep -q CONFIG_XENOMAI $linux_tree/drivers/Makefile; then
 	p="obj-\$(CONFIG_XENOMAI)		+= xenomai/"
 	( echo ; echo $p ) | patch_append drivers/Makefile
@@ -354,6 +407,7 @@
     export linux_arch
     config_file=Config.in
 
+    patch_architecture_specific="n"
     if ! grep -q CONFIG_XENO $linux_tree/Makefile; then
 	patch_ed Makefile <<EOF
 /DRIVERS := \$(DRIVERS-y)
@@ -363,6 +417,7 @@
 wq
 EOF
     fi
+    patch_architecture_specific="y"
     for defconfig_file in .config arch/$linux_arch/defconfig; do
        if test -w $linux_tree/$defconfig_file; then
           if ! grep -q CONFIG_XENO $linux_tree/$defconfig_file; then
@@ -388,6 +443,7 @@
 wq
 EOF
     fi
+    patch_architecture_specific="n"
     if ! grep -q CONFIG_XENO $linux_tree/drivers/Makefile; then
 	patch_ed drivers/Makefile <<EOF
 /include \$(TOPDIR)\/Rules.make
@@ -411,6 +467,7 @@
 wq
 EOF
     fi
+    patch_architecture_specific="y"
     if ! grep -iq xenomai $linux_tree/arch/$linux_arch/config.in; then
 	patch_ed arch/$linux_arch/config.in <<EOF
 $
@@ -439,14 +496,19 @@
 # there, so that we don't pollute the Xenomai source tree with
 # compilation files.
 
+patch_kernelversion_specific="n"
+patch_architecture_specific="y"
 patch_link r m ksrc/arch/$xenomai_arch arch/$linux_arch/xenomai
+patch_architecture_specific="n"
 patch_link n m ksrc/ kernel/xenomai
 patch_link n m ksrc/arch kernel/xenomai/arch
 patch_link r m ksrc/arch/generic kernel/xenomai/arch/generic
-patch_link r m ksrc/nucleus kernel/xenomai/nucleus
+patch_link n m ksrc/nucleus kernel/xenomai/nucleus
 patch_link r m ksrc/skins kernel/xenomai/skins
 patch_link r m ksrc/drivers drivers/xenomai
+patch_architecture_specific="y"
 patch_link r n include/asm-$xenomai_arch include/asm-$linux_arch/xenomai
+patch_architecture_specific="n"
 patch_link r n include/asm-generic include/asm-generic/xenomai
 patch_link n n include include/xenomai
 patch_link n n include/asm-uvm include/xenomai/asm-uvm

--Boundary-00=_mgXDEzfG1NOUo2U--

