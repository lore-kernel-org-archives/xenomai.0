From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] Xenomai patch packaging concerns
Date: Fri, 24 Feb 2006 20:56:15 +0900
References: <200602231224.38519.rlenglet@domain.hid>
	<43FDD2E7.9080705@domain.hid>
In-Reply-To: <43FDD2E7.9080705@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fRv/DwR99KI8XL4"
Message-Id: <200602242056.15814.rlenglet@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

--Boundary-00=_fRv/DwR99KI8XL4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Philippe,

I figured out where to link/copy every file. There was no need to 
modify any file in ksrc/...

Here is my patch. The new option to prepare-kernel.sh is:
--outpatch=<patchfiletocreate> <tempdir>

For instance you can run:

> mkdir /tmp/temptree
> ./scripts/prepare-kernel.sh 
--outpatch=/tmp/patch.diff /tmp/temptree

I tested that at least I get the same result as before without 
using the new option.
I have only tested with the Linux 2.6.15 source tree, not with 
Linux 2.4. But as you can see, my modifications are simple and 
conservative, so it should work.


Regards,

-- 
Romain LENGLET

--Boundary-00=_fRv/DwR99KI8XL4
Content-Type: text/x-diff; charset="iso-8859-1";
	name="diffgen_2006-02-24.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diffgen_2006-02-24.patch"

--- xenomai/ChangeLog	2006-02-24 20:39:57.302874592 +0900
+++ xenomai-new/ChangeLog	2006-02-24 20:43:46.811983904 +0900
@@ -1,3 +1,10 @@
+2006-02-24  Romain Lenglet <rlenglet@domain.hid>
+
+	* scripts/prepare-kernel.sh: Added option to generate a diff file
+	instead of actually modifying the Linux source tree. Cleanup to not
+	link / copy files for other architectures than the built architecture,
+	and to not link / copy some files twice.
+
 2006-02-22  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
 
 	* include/nucleus/timer.h: Use binary heaps for the aperiodic
--- xenomai/CREDITS	2006-02-22 10:28:53.229253976 +0900
+++ xenomai-new/CREDITS	2006-02-24 20:39:16.378096104 +0900
@@ -80,7 +80,7 @@
 
 N: Romain Lenglet
 E: <rlenglet@domain.hid>
-D: Man pages.
+D: Man pages, and patch generation script changes.
 
 N: Heikki Lindholm
 E: holindho@domain.hid
--- xenomai/scripts/prepare-kernel.sh	2006-02-24 19:48:17.038186464 +0900
+++ xenomai-new/scripts/prepare-kernel.sh	2006-02-24 20:38:32.647744128 +0900
@@ -1,37 +1,105 @@
 #! /bin/bash
 set -e
 
-do_links() {
-    ( if test -x $2; then
-      cd $2 &&
-      find . \( -name Makefile -o -name $config_file -o -name '*.[chS]' \) |
-      while read f; do
-        if test ! -e $1/$f; then rm -f $f; fi
-      done; else true; fi &&
-      cd $1 &&
-      find . \( -name Makefile -o -name $config_file -o -name '*.[chS]' \) |
-      while read f; do
-        f=`echo $f | cut -d/ -f2-`
-        d=`dirname $f`
-	mkdir -p $2/$d && ln -sf $1/$f $2/$f
-      done )
+patch_copytempfile() {
+    file="$1"
+    if ! test -f "$temp_tree/$file"; then
+        subdir=`dirname "$file"`
+        mkdir -p "$temp_tree/$subdir"
+        cp "$linux_tree/$file" "$temp_tree/$file"
+    fi
 }
 
-usage='usage: prepare-kernel --linux=<linux-tree> --adeos=<adeos-patch> [--arch=<arch>]'
+patch_append() {
+    file="$1"
+    if test "x$output_patch" = "x"; then
+        realfile="$linux_tree/$file"
+    else
+        patch_copytempfile "$file"
+        realfile="$temp_tree/$file"
+    fi
+    cat >> "$realfile"
+}
+
+patch_ed() {
+    file="$1"
+    if test "x$output_patch" = "x"; then
+        realfile="$linux_tree/$file"
+    else
+        patch_copytempfile "$file"
+        realfile="$temp_tree/$file"
+    fi
+    ed -s "$realfile" > /dev/null
+}
+
+patch_link() {
+    recursive="$1"              # "r" or "n"
+    link_makefiles="$2"         # "m" or "n"
+    target_dir="$3"
+    link_dir="$4"
+
+    (
+        recursive_opt=""
+        if test x$recursive != xr; then
+            recursive_opt="-maxdepth 1"
+        fi
+        link_makefiles_opt=""
+        if test x$link_makefiles = xm; then
+            link_makefiles_opt="-name Makefile -o"
+        fi
+
+        cd $xenomai_root/$target_dir &&
+        find . $recursive_opt \
+            \( $link_makefiles_opt -name $config_file -o -name '*.[chS]' \) |
+        while read f; do
+            f=`echo $f | cut -d/ -f2-`
+            d=`dirname $f`
+            if test "x$output_patch" = "x"; then
+                mkdir -p $linux_tree/$link_dir/$d && \
+                    rm -f $linux_tree/$link_dir/$f && \
+                    ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
+            else
+                mkdir -p $temp_tree/$link_dir/$d
+                cp $xenomai_root/$target_dir/$f $temp_tree/$link_dir/$f
+            fi
+        done
+    )
+
+}
+
+generate_patch() {
+    (
+    cd "$temp_tree"
+    find . -type f |
+    while read f; do
+        diff -Naurd "$linux_tree/$f" "$f" |
+        sed -e "s,^--- ${linux_tree}/\.\(/.*\)$,--- linux\1," \
+            -e "s,^+++ \.\(/.*\)$,+++ linux-patched\1,"
+    done
+    )
+}
+
+
+usage='usage: prepare-kernel --linux=<linux-tree> --adeos=<adeos-patch> [--arch=<arch>] [--outpatch=<file> <tempdir>]'
 me=`basename $0`
 
 while test $# -gt 0; do
     case "$1" in
     --linux=*)
-	linux_tree=`echo $1|sed -e 's,--linux=\\(.*\\)$,\\1,g'`;
+	linux_tree=`echo $1|sed -e 's,^--linux=\\(.*\\)$,\\1,g'`;
 	linux_tree=`eval "echo $linux_tree"`
 	;;
     --adeos=*)
-	adeos_patch=`echo $1|sed -e 's,--adeos=\\(.*\\)$,\\1,g'`;
+	adeos_patch=`echo $1|sed -e 's,^--adeos=\\(.*\\)$,\\1,g'`;
 	adeos_patch=`eval "echo $adeos_patch"`
 	;;
     --arch=*)
-	linux_arch=`echo $1|sed -e 's,--arch=\\(.*\\)$,\\1,g'`;
+	linux_arch=`echo $1|sed -e 's,^--arch=\\(.*\\)$,\\1,g'`;
+	;;
+    --outpatch=*)
+	output_patch=`echo $1|sed -e 's,^--outpatch=\\(.*\\)$,\\1,g'`;
+	shift
+	temp_tree=`echo $1|sed -e 's,^--tempdir=\\(.*\\)$,\\1,g'`;
 	;;
     --verbose)
 	verbose=1
@@ -41,8 +109,8 @@
 	exit 0
 	;;
     *)
-	echo "$me: unknown flag: $1"
-	echo "$usage"
+	echo "$me: unknown flag: $1" >&2
+	echo "$usage" >&2
 	exit 1
 	;;
     esac
@@ -82,6 +150,22 @@
    exit 2
 fi
 
+# Create an empty output patch file, and initialize the temporary tree.
+if test "x$output_patch" != "x"; then
+
+    if test ! -d $temp_tree; then
+        echo "$me: $temp_tree (temporary tree) is not an existing directory"
+        exit 2
+    fi
+    temp_tree=`cd $temp_tree && pwd`
+
+    patchdir=`dirname $output_patch`
+    patchdir=`cd $patchdir && pwd`
+    output_patch=$patchdir/`basename $output_patch`
+    echo > "$output_patch"
+
+fi
+
 # Infer the default architecture if unspecified.
 
 if test x$linux_arch = x; then
@@ -159,13 +243,17 @@
 
 linux_version="$linux_VERSION.$linux_PATCHLEVEL.$linux_SUBLEVEL$linux_EXTRAVERSION"
 
+if test x$verbose = x1; then
 echo "Preparing kernel $linux_version in $linux_tree..."
+fi
 
 if test -r $linux_tree/include/linux/ipipe.h; then
+    if test x$verbose = x1; then
     echo "Adeos found - bypassing patch."
+    fi
 elif test -r $linux_tree/include/linux/adeos.h; then
-   echo "$me: Deprecated Adeos (oldgen) support found in $linux_tree;"
-   echo "Upgrade required to Adeos/I-pipe (newgen)."
+   echo "$me: Deprecated Adeos (oldgen) support found in $linux_tree;" >&2
+   echo "Upgrade required to Adeos/I-pipe (newgen)." >&2
    exit 2
 else
    if test x$adeos_patch = x; then
@@ -191,7 +279,7 @@
    curdir=$PWD
    cd $linux_tree && patch --dry-run -p1 -f < $adeos_patch || { 
         cd $curdir;
-        echo "$me: Unable to patch kernel $linux_version with `basename $adeos_patch`."
+        echo "$me: Unable to patch kernel $linux_version with `basename $adeos_patch`." >&2
         exit 2;
    }
    patch -p1 -f -s < $adeos_patch
@@ -201,9 +289,11 @@
 adeos_version=`grep '^#define.*IPIPE_ARCH_STRING.*"' $linux_tree/include/asm-$linux_arch/ipipe.h|sed -e 's,.*"\(.*\)"$,\1,'`
 
 if test \! x$adeos_version = x; then
+   if test x$verbose = x1; then
    echo "Adeos/$linux_arch $adeos_version installed."
+   fi
 else
-   echo "$me: $linux_tree has no Adeos support for $linux_arch"
+   echo "$me: $linux_tree has no Adeos support for $linux_arch" >&2
    exit 2
 fi
 
@@ -218,22 +308,23 @@
     config_file=Kconfig
 
     if ! grep -q XENOMAI $linux_tree/init/Kconfig; then
-	sed -e "s,@LINUX_ARCH@,$linux_arch,g" $xenomai_root/scripts/Kconfig.frag >> $linux_tree/init/Kconfig
+	sed -e "s,@LINUX_ARCH@,$linux_arch,g" $xenomai_root/scripts/Kconfig.frag |
+            patch_append init/Kconfig
     fi
 
     if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; then
 	p="drivers-\$(CONFIG_XENOMAI)		+= arch/$linux_arch/xenomai/"
-	( echo ; echo $p ) >> $linux_tree/arch/$linux_arch/Makefile
+	( echo ; echo $p ) | patch_append arch/$linux_arch/Makefile
     fi
 
     if ! grep -q CONFIG_XENOMAI $linux_tree/drivers/Makefile; then
 	p="obj-\$(CONFIG_XENOMAI)		+= xenomai/"
-	( echo ; echo $p ) >> $linux_tree/drivers/Makefile
+	( echo ; echo $p ) | patch_append drivers/Makefile
     fi
 
     if ! grep -q CONFIG_XENOMAI $linux_tree/kernel/Makefile; then
 	p="obj-\$(CONFIG_XENOMAI)		+= xenomai/"
-	( echo ; echo $p ) >> $linux_tree/kernel/Makefile
+	( echo ; echo $p ) | patch_append kernel/Makefile
     fi
     ;;
 
@@ -247,7 +338,7 @@
     config_file=Config.in
 
     if ! grep -q CONFIG_XENO $linux_tree/Makefile; then
-	ed -s $linux_tree/Makefile > /dev/null <<EOF
+	patch_ed Makefile <<EOF
 /DRIVERS := \$(DRIVERS-y)
 ^r $xenomai_root/scripts/Modules.frag
 
@@ -255,10 +346,10 @@
 wq
 EOF
     fi
-    for defconfig_file in .config $linux_tree/arch/$linux_arch/defconfig; do
-       if test -w $defconfig_file; then
-          if ! grep -q CONFIG_XENO $defconfig_file; then
-	      ed -s $defconfig_file > /dev/null <<EOF
+    for defconfig_file in .config arch/$linux_arch/defconfig; do
+       if test -w $linux_tree/$defconfig_file; then
+          if ! grep -q CONFIG_XENO $linux_tree/$defconfig_file; then
+	      patch_ed $defconfig_file <<EOF
 $
 r $xenomai_root/scripts/defconfig.frag
 .
@@ -268,7 +359,7 @@
        fi
     done
     if ! grep -q CONFIG_XENO $linux_tree/arch/$linux_arch/Makefile; then
-	ed -s $linux_tree/arch/$linux_arch/Makefile > /dev/null <<EOF
+	patch_ed arch/$linux_arch/Makefile <<EOF
 $
 a
 
@@ -281,7 +372,7 @@
 EOF
     fi
     if ! grep -q CONFIG_XENO $linux_tree/drivers/Makefile; then
-	ed -s $linux_tree/drivers/Makefile > /dev/null <<EOF
+	patch_ed drivers/Makefile <<EOF
 /include \$(TOPDIR)\/Rules.make
 i
 mod-subdirs := xenomai
@@ -292,7 +383,7 @@
 EOF
     fi
     if ! grep -q CONFIG_XENO $linux_tree/kernel/Makefile; then
-	ed -s $linux_tree/kernel/Makefile > /dev/null <<EOF
+	patch_ed kernel/Makefile <<EOF
 /include \$(TOPDIR)\/Rules.make
 i
 mod-subdirs := xenomai
@@ -304,7 +395,7 @@
 EOF
     fi
     if ! grep -iq xenomai $linux_tree/arch/$linux_arch/config.in; then
-	ed -s $linux_tree/arch/$linux_arch/config.in > /dev/null <<EOF
+	patch_ed arch/$linux_arch/config.in <<EOF
 $
 a
 
@@ -321,7 +412,7 @@
 
     *)
 
-    echo "$me: Unsupported kernel version $linux_VERSION.$linux_PATCHLEVEL.x"
+    echo "$me: Unsupported kernel version $linux_VERSION.$linux_PATCHLEVEL.x" >&2
     exit 2
     ;;
 
@@ -331,15 +422,34 @@
 # there, so that we don't pollute the Xenomai source tree with
 # compilation files.
 
-do_links $xenomai_root/ksrc/arch/$xenomai_arch $linux_tree/arch/$linux_arch/xenomai
-do_links $xenomai_root/ksrc $linux_tree/kernel/xenomai
-do_links $xenomai_root/ksrc/drivers $linux_tree/drivers/xenomai
-do_links $xenomai_root/include/asm-$xenomai_arch $linux_tree/include/asm-$linux_arch/xenomai
-do_links $xenomai_root/include/asm-generic $linux_tree/include/asm-generic/xenomai
-do_links $xenomai_root/include $linux_tree/include/xenomai
+patch_link r m ksrc/arch/$xenomai_arch arch/$linux_arch/xenomai
+patch_link n m ksrc/ kernel/xenomai
+patch_link n m ksrc/arch kernel/xenomai/arch
+patch_link r m ksrc/arch/generic kernel/xenomai/arch/generic
+patch_link r m ksrc/nucleus kernel/xenomai/nucleus
+patch_link r m ksrc/skins kernel/xenomai/skins
+patch_link r m ksrc/drivers drivers/xenomai
+patch_link r n include/asm-$xenomai_arch include/asm-$linux_arch/xenomai
+patch_link r n include/asm-generic include/asm-generic/xenomai
+patch_link n n include include/xenomai
+for d in include/* ; do
+    if test -d $d -a -z "`echo $d | grep '^include/asm-'`"; then
+        destdir=`echo $d | sed -e 's,^\(include\)\(/.*\)$,\1/xenomai\2,'`
+        patch_link r n $d $destdir
+    fi
+done
 
-echo 'Links installed.'
+if test "x$output_patch" != "x"; then
+    if test x$verbose = x1; then
+    echo 'Generating patch.'
+    fi
+    generate_patch > "$output_patch"
+fi
 
+if test x$verbose = x1; then
+echo 'Links installed.'
 echo 'Build system ready.'
+fi
 
 exit 0
+

--Boundary-00=_fRv/DwR99KI8XL4--

