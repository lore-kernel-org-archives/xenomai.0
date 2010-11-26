Message-ID: <4CEFA1A4.1040901@domain.hid>
Date: Fri, 26 Nov 2010 13:01:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] prepare-kernel: Use auto-generated temp
	directory for --outpatch
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Asking the user to provide a temp directory for --outpatch and not
cleaning it up after completion is error-prone. Instead, generate such a
directory automatically and also remove it again when done.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 scripts/prepare-kernel.sh |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index ab9d1c1..8d41e94 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -168,7 +168,7 @@ generate_patch() {
 }
 
 
-usage='usage: prepare-kernel --linux=<linux-tree> --adeos=<adeos-patch> [--arch=<arch>] [--outpatch=<file> <tempdir> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink] [--default] [--verbose]'
+usage='usage: prepare-kernel --linux=<linux-tree> --adeos=<adeos-patch> [--arch=<arch>] [--outpatch=<file> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink] [--default] [--verbose]'
 me=`basename $0`
 
 while test $# -gt 0; do
@@ -186,8 +186,6 @@ while test $# -gt 0; do
 	;;
     --outpatch=*)
 	output_patch=`echo $1|sed -e 's,^--outpatch=\\(.*\\)$,\\1,g'`
-	shift
-	temp_tree=`echo $1|sed -e 's,^--tempdir=\\(.*\\)$,\\1,g'`
 	;;
     --filterkvers=*)
         patch_kernelversion_filter=`echo $1|sed -e 's,^--filterkvers=\\(.*\\)$,\\1,g'`
@@ -257,13 +255,8 @@ fi
 # Create an empty output patch file, and initialize the temporary tree.
 if test "x$output_patch" != "x"; then
 
-    # The directory must exist, but should be empty. To lower the risks of data
-    # loss, the script does not deletes files itself.
-    if test ! -d $temp_tree; then
-        echo "$me: $temp_tree (temporary tree) is not an existing directory" >&2
-        exit 2
-    fi
-    temp_tree=`cd $temp_tree && pwd`
+    temp_tree=$TMPDIR/prepare-kernel-$$
+    mkdir $temp_tree
 
     patchdir=`dirname $output_patch`
     patchdir=`cd $patchdir && pwd`
@@ -592,6 +585,7 @@ if test "x$output_patch" != "x"; then
     echo 'Generating patch.'
     fi
     generate_patch > "$output_patch"
+    rm -rf $temp_tree
 fi
 
 if test x$verbose = x1; then
-- 
1.7.1

