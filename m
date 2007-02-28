From: Paul <paul_c@domain.hid>
Date: Wed, 28 Feb 2007 12:17:36 +0000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gLX5FjpYYXvNyin"
Message-Id: <200702281217.36362.paul_c@domain.hid>
Subject: [Xenomai-core] prepare-kernel options
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

--Boundary-00=_gLX5FjpYYXvNyin
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


A little background - On Debian installations, a set of tools have been 
provided to allow kernel packages to be quickly & simply generated. It is 
something I do quite regularly with the following steps:
 * Extract kernel sources in /tmp
 * Apply patches
 * Copy an existing .config over - Run `make oldconfig`
 * make-kpkg binary-arch (produces kernel-image and kernel-header packages)
 * Install/reboot

It may sound a long winded method, but it does allow me to use the generated 
packages to install on any number of other machines.

The problem - prepare-kernel.sh creates symlinks to assorted files in the 
Xenomai source tree. Not a problem if the same tree exists in the same 
location on the target machine. As yet, there is no xenomai Debian package, 
and the build location may not be the same as the install location - This 
results in a large number of dangling symlinks which thwarts attempts to 
compile out of tree modules using the kernel-headers package. I suspect the 
same issues would exist for RPM packages and NFS mounted targets.

A solution - Instead of creating symlinks, the files need to be copied in to 
the kernel source tree. Most people will use symlinks as it simplifies the 
`svn up`/make process and avoids having to run prepare-kernel each time. I 
propose a trivial patch that retains the original behaviour and provides an 
option to turn off symlinks (patch attached).


Regards, Paul.


--Boundary-00=_gLX5FjpYYXvNyin
Content-Type: text/x-diff;
  charset="us-ascii";
  name="symlink_opt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="symlink_opt.patch"

Index: scripts/prepare-kernel.sh
===================================================================
--- scripts/prepare-kernel.sh	(revision 2265)
+++ scripts/prepare-kernel.sh	(working copy)
@@ -95,6 +95,11 @@ patch_link() {
         if test x$link_makefiles = xm; then
             link_makefiles_opt="-name Makefile -o"
         fi
+        if test x$no_symlinks = x1; then
+            link_command="cp -f"
+        else
+            link_command="cp -sf"
+        fi
 
         if test "x$output_patch" = "x" -a -e $linux_tree/$link_dir; then
             cd $linux_tree/$link_dir &&
@@ -116,7 +121,7 @@ patch_link() {
                 if test x$forcelink = x1 -o \
 		   ! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
 		then
-                    ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
+                    $link_command $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
                 fi
             else
                 if test `check_filter $link_dir/$f` = "ok"; then
@@ -168,7 +173,7 @@ generate_patch() {
 }
 
 
-usage='usage: prepare-kernel --linux=<linux-tree> --adeos=<adeos-patch> [--arch=<arch>] [--outpatch=<file> <tempdir> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink]'
+usage='usage: prepare-kernel --linux=<linux-tree> --adeos=<adeos-patch> [--arch=<arch>] [--outpatch=<file> <tempdir> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink] [--nosymlink]'
 me=`basename $0`
 
 while test $# -gt 0; do
@@ -198,6 +203,9 @@ while test $# -gt 0; do
     --forcelink)
         forcelink=1
         ;;
+    --nosymlink)
+        no_symlinks=1
+        ;;
     --verbose)
 	verbose=1
 	;;

--Boundary-00=_gLX5FjpYYXvNyin--

