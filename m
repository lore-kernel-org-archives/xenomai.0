Message-ID: <43E87C56.8040100@domain.hid>
Date: Tue, 07 Feb 2006 03:54:14 -0700
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060007060009080500000105"
Subject: [Xenomai-core] [patch] tweak scripts/prepare-kernel.sh to work with
	O=../linux-output
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

This is a multi-part message in MIME format.
--------------060007060009080500000105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

hi folks,

with this patch, you can run prepare-kernel.sh on a kernel output tree,
at least once that tree contains the Makefile that the script looks for.




--------------060007060009080500000105
Content-Type: text/plain;
 name="patch-output"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-output"

Index: scripts/prepare-kernel.sh
===================================================================
--- scripts/prepare-kernel.sh	(revision 550)
+++ scripts/prepare-kernel.sh	(working copy)
@@ -74,13 +74,14 @@
 done
 
 linux_tree=`cd $linux_tree && pwd`
+linux_out=$linux_tree
 
 if test \! -r $linux_tree/Makefile; then
    echo "$me: $linux_tree is not a valid Linux kernel tree"
    exit 2
 fi
 
-# Infere the default architecture if unspecified.
+# Infer the default architecture if unspecified.
 
 if test x$linux_arch = x; then
    build_arch=`$xenomai_root/config/config.guess`
@@ -144,6 +145,12 @@
    linux_arch=blackfin
 fi
 
+foo=`grep '^KERNELSRC    := ' $linux_tree/Makefile | cut -d= -f2`
+if [ ! -z $foo ] ; then
+    linux_tree=$foo
+fi
+unset foo
+
 eval linux_`grep '^EXTRAVERSION =' $linux_tree/Makefile | sed -e 's, ,,g'`
 eval linux_`grep '^PATCHLEVEL =' $linux_tree/Makefile | sed -e 's, ,,g'`
 eval linux_`grep '^SUBLEVEL =' $linux_tree/Makefile | sed -e 's, ,,g'`

--------------060007060009080500000105--

