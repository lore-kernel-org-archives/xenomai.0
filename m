Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7759F3D3B9
	for <xenomai@lists.linux.dev>; Sat, 25 May 2024 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638320; cv=none; b=fJRk597M972JPeWnuYjyimvJQioGne1c7sANnsmB9mbXss7GOzcq1PhWp6aqYkZ380RemV1PohIEYtLwGnTHDwbMgUq6t1W18yIv6pot8rlA0TJEB1VhCWyvsxL+ho1SUsCny/V25rN2EndWNVIkHpfK+NUcSuK8o/EzN1z8/RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638320; c=relaxed/simple;
	bh=ahQBeWRmeUENIiSD+JgnQk3OpStcZqp/CFEYoKbtT0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tt0tjkov0uUyFbMuvpTuop1vdVqor2AqsSBFQa71Uhn33oh9W53g/0Y4fRB1m1kTfUkcY6xFwfNS1uVwwGH123P3NgeLknP7+80OXw+/J6doDWKDo1sqQCOCF5B6zA8k86MSS0bRZ8bIZtUe/kpQcYGwDP5RAFGFlY3S+5MJWfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8C82D6195FDC;
	Sat, 25 May 2024 13:58:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id xVy1jXLe3-tD; Sat, 25 May 2024 13:58:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C922E62348A5;
	Sat, 25 May 2024 13:58:27 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZvovSCrEKOr6; Sat, 25 May 2024 13:58:27 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 98ED36195FDC;
	Sat, 25 May 2024 13:58:27 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 01/16] prepare-kernel.sh: Add reverse mode
Date: Sat, 25 May 2024 13:57:51 +0200
Message-Id: <20240525115806.12101-2-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240525115806.12101-1-richard@nod.at>
References: <20240525115806.12101-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is currently no way to undo preparing of a kernel, except using
--outpatch and reverting the resulting patch later.
But in link mode the kernel tree needs manual cleaning,
which can be tedious if a git clean -f -d -x is not possible.

The new --reverse flag offers this feature, it removes all previously
created symlinks and directories.
To be able to undo effects by patch_append(), keep a .orig file link
as the script already does for symlinks in the linux tree.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 73 +++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index faf3e7235..f0f81471f 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -55,7 +55,9 @@ patch_append() {
 	if test -L "$linux_tree/$file" ; then
 	    mv "$linux_tree/$file" "$linux_tree/$file.orig"
 	    cp "$linux_tree/$file.orig" "$linux_tree/$file"
-	fi
+        else
+            cp "$linux_tree/$file" "$linux_tree/$file.orig"
+        fi
 	chmod +w "$linux_tree/$file"
         cat >> "$linux_tree/$file"
     else
@@ -66,6 +68,16 @@ patch_append() {
     fi
 }
=20
+patch_reverse() {
+    file=3D"$1"
+    if test "x$output_patch" =3D "x"; then
+        if test -L "$linux_tree/$file" ; then
+            rm "$linux_tree/$file"
+        fi
+        mv "$linux_tree/$file.orig" "$linux_tree/$file"
+    fi
+}
+
 patch_link() {
     recursive=3D"$1"         # "r" or "n"
     link_file=3D"$2"         # "m", "n" or some file (basename) from $ta=
rget_dir
@@ -106,11 +118,15 @@ patch_link() {
             f=3D`echo $f | cut -d/ -f2-`
             d=3D`dirname $f`
             if test "x$output_patch" =3D "x"; then
-                mkdir -p $linux_tree/$link_dir/$d
-                if test x$forcelink =3D x1 -o \
-		   ! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
-		then
-                    ln -sf $xenomai_root/$target_dir/$f $linux_tree/$lin=
k_dir/$f
+                if test x$reverse =3D x1; then
+                    rm -f $linux_tree/$link_dir/$f
+                else
+                    mkdir -p $linux_tree/$link_dir/$d
+                    if test x$forcelink =3D x1 -o \
+		       ! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
+		    then
+                        ln -sf $xenomai_root/$target_dir/$f $linux_tree/=
$link_dir/$f
+                    fi
                 fi
             else
                 if test `check_filter $link_dir/$f` =3D "ok"; then
@@ -122,6 +138,11 @@ patch_link() {
                 fi
             fi
         done
+        if test x$reverse =3D x1; then
+            if ! find $linux_tree/$link_dir -not -type d | grep -q . ; t=
hen
+                rm -rf $linux_tree/$link_dir
+            fi
+        fi
     )
 }
=20
@@ -138,7 +159,7 @@ generate_patch() {
 }
=20
=20
-usage=3D'usage: prepare-kernel --linux=3D<linux-tree> [--dovetail=3D<dov=
etail-patch>] [--arch=3D<arch>] [--outpatch=3D<file> [--filterkvers=3Dy|n=
] [--filterarch=3Dy|n]] [--forcelink] [--default] [--verbose]'
+usage=3D'usage: prepare-kernel --linux=3D<linux-tree> [--dovetail=3D<dov=
etail-patch>] [--arch=3D<arch>] [--outpatch=3D<file> [--filterkvers=3Dy|n=
] [--filterarch=3Dy|n]] [--forcelink] [--default] [--verbose] [--reverse]=
'
 me=3D`basename $0`
=20
 while test $# -gt 0; do
@@ -174,6 +195,9 @@ while test $# -gt 0; do
     --verbose)
 	verbose=3D1
 	;;
+    --reverse)
+	reverse=3D1
+	;;
     --help)
 	echo "$usage"
 	exit 0
@@ -223,8 +247,19 @@ if test \! -r $linux_tree/Makefile; then
    exit 2
 fi
=20
+if test x$reverse =3D x1; then
+    if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; t=
hen
+        echo "$me: $linux_tree is not prepared with Xenomai" >&2
+	exit 2
+    fi
+fi
+
 # Create an empty output patch file, and initialize the temporary tree.
 if test "x$output_patch" !=3D "x"; then
+    if test x$reverse =3D x1; then
+	echo "$me: --reverse and --outpatch are not compatible"
+	exit 1
+    fi
=20
     temp_tree=3D`mktemp -d prepare-kernel-XXX --tmpdir`
     if [ $? -ne 0 ]; then
@@ -362,15 +397,18 @@ case $linux_VERSION.$linux_PATCHLEVEL in
 	    -e "s,@SRCARCH@,$linux_arch,g" \
 	    $xenomai_root/scripts/Kconfig.frag |
             patch_append init/Kconfig
+    elif test x$reverse =3D x1; then
+        patch_reverse init/Kconfig
     fi
=20
 test "x$CONFIG_XENO_REVISION_LEVEL" =3D "x" && CONFIG_XENO_REVISION_LEVE=
L=3D0
=20
     if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; t=
hen
-	p=3D"KBUILD_CFLAGS +=3D -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include =
-I\$(srctree)/include/xenomai"
-	(echo; echo $p) | patch_append arch/$linux_arch/Makefile
-	p=3D"core-\$(CONFIG_XENOMAI)	+=3D arch/$linux_arch/xenomai/"
-	echo $p | patch_append arch/$linux_arch/Makefile
+	p1=3D"KBUILD_CFLAGS +=3D -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include=
 -I\$(srctree)/include/xenomai"
+	p2=3D"core-\$(CONFIG_XENOMAI)	+=3D arch/$linux_arch/xenomai/"
+	(echo; echo $p1; echo $p2) | patch_append arch/$linux_arch/Makefile
+    elif test x$reverse =3D x1; then
+        patch_reverse arch/$linux_arch/Makefile
     fi
=20
     patch_architecture_specific=3D"n"
@@ -378,11 +416,15 @@ test "x$CONFIG_XENO_REVISION_LEVEL" =3D "x" && CONF=
IG_XENO_REVISION_LEVEL=3D0
     if ! grep -q CONFIG_XENOMAI $linux_tree/drivers/Makefile; then
 	p=3D"obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
 	( echo ; echo $p ) | patch_append drivers/Makefile
+    elif test x$reverse =3D x1; then
+        patch_reverse drivers/Makefile
     fi
=20
     if ! grep -q CONFIG_XENOMAI $linux_tree/kernel/Makefile; then
 	p=3D"obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
 	( echo ; echo $p ) | patch_append kernel/Makefile
+    elif test x$reverse =3D x1; then
+        patch_reverse kernel/Makefile
     fi
     ;;
=20
@@ -391,13 +433,15 @@ esac
 # Create local directories then symlink to the source files from
 # there, so that we don't pollute the Xenomai source tree with
 # compilation files.
+#
+# Keep link dirs (4th parameter) descending, otherwise --reverse
+# is not able to cleanup these directories!
=20
 patch_kernelversion_specific=3D"n"
 patch_architecture_specific=3D"y"
 patch_link r m kernel/cobalt/arch/$linux_arch arch/$linux_arch/xenomai
 patch_link n n kernel/cobalt/include/dovetail arch/$linux_arch/include/d=
ovetail
 patch_architecture_specific=3D"n"
-patch_link n m kernel/cobalt kernel/xenomai
 patch_link n cobalt-core.h kernel/cobalt/trace include/trace/events
 patch_link n cobalt-rtdm.h kernel/cobalt/trace include/trace/events
 patch_link n cobalt-posix.h kernel/cobalt/trace include/trace/events
@@ -405,14 +449,15 @@ patch_link r n kernel/cobalt/include/asm-generic/xe=
nomai include/asm-generic/xen
 patch_link n m kernel/cobalt/posix kernel/xenomai/posix
 patch_link n m kernel/cobalt/rtdm kernel/xenomai/rtdm
 patch_link n m kernel/cobalt/dovetail kernel/xenomai/pipeline
+patch_link n m kernel/cobalt kernel/xenomai
 patch_link r m kernel/drivers drivers/xenomai
 patch_link n n include/cobalt/kernel include/xenomai/cobalt/kernel
-patch_link r n include/cobalt/kernel/rtdm include/xenomai/rtdm
 patch_link r n include/cobalt/kernel/dovetail/pipeline include/xenomai/p=
ipeline
 patch_link r n include/cobalt/uapi include/xenomai/cobalt/uapi
 patch_link r n include/rtdm/uapi include/xenomai/rtdm/uapi
-patch_link n version.h include/xenomai include/xenomai
+patch_link r n include/cobalt/kernel/rtdm include/xenomai/rtdm
 patch_link n stdarg.h kernel/cobalt/include/linux include/xenomai/linux
+patch_link n version.h include/xenomai include/xenomai
=20
 if test "x$output_patch" !=3D "x"; then
     if test x$verbose =3D x1; then
--=20
2.35.3

