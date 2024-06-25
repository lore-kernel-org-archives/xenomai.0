Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EE517C9F5
	for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719352214; cv=none; b=UgdYX4TjQSwETGbifKum1dRewJvVD/9xJ40XF8gk24CUwIO9NzU4/YzLWkSQwUqMXuH8y+ZTS1CLoIL4CHvREz+JniENTCqDm8mXeGLk1IEbpFR9Tz+7qolAh6AS7wOpawIVDscRPNVB5w+peWO3iP2RILjdhKYvk8GvMPZPKmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719352214; c=relaxed/simple;
	bh=TTYodd5tOZ3BCtV/vnrfAN/2GJZJBE2sJX/zA3t3aeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c5+N3K6av9qJ5XYd2012TEOMv/xX/SX2v2p1Li+SBKTIaiBKjpeYi7CtGRQR9R3XWSuyDuO2BX9xHSUVTV+ak8oWOBQGtgIWXDjVdEOG/W4ZeWmecSh4/9bBo7mOHJJ0WMjYkDzysjn6e6YdWbFfOnTlv+/qpEBCGZqXuai31WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id AC94061966A9;
	Tue, 25 Jun 2024 23:50:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id PmlEwI5f6jRc; Tue, 25 Jun 2024 23:50:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id F0D5C6195FFE;
	Tue, 25 Jun 2024 23:50:06 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 80xAhR_sRkKP; Tue, 25 Jun 2024 23:50:06 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 602A06195FE9;
	Tue, 25 Jun 2024 23:50:06 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 03/15] prepare-kernel.sh: Add reverse mode
Date: Tue, 25 Jun 2024 23:49:50 +0200
Message-Id: <20240625214950.22728-2-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240625214950.22728-1-richard@nod.at>
References: <20240625214950.22728-1-richard@nod.at>
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
[Jan: add missing init/Kconfig reversion, fix indention]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/prepare-kernel.sh | 75 +++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 15 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 7a1c4d923..c9a02583b 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -55,6 +55,8 @@ patch_append() {
 		if test -L "$linux_tree/$file" ; then
 			mv "$linux_tree/$file" "$linux_tree/$file.orig"
 			cp "$linux_tree/$file.orig" "$linux_tree/$file"
+		else
+			cp "$linux_tree/$file" "$linux_tree/$file.orig"
 		fi
 		chmod +w "$linux_tree/$file"
 		cat >> "$linux_tree/$file"
@@ -66,6 +68,16 @@ patch_append() {
 	fi
 }
=20
+patch_reverse() {
+	file=3D"$1"
+	if test "x$output_patch" =3D "x"; then
+		if test -L "$linux_tree/$file" ; then
+			rm "$linux_tree/$file"
+		fi
+		mv "$linux_tree/$file.orig" "$linux_tree/$file"
+	fi
+}
+
 patch_link() {
 	recursive=3D"$1"		   # "r" or "n"
 	link_file=3D"$2"		   # "m", "n" or some file (basename) from $target_di=
r
@@ -90,7 +102,7 @@ patch_link() {
 		find_link_opt=3D"$recursive_opt \( $link_makefiles_opt -name Kconfig -=
o -name '*.[chS]' -o -name '*.sh' \)"
 	fi
=20
-	if test "x$output_patch" =3D "x" -a -e $linux_tree/$link_dir; then
+	if test "x$output_patch" =3D "x" -a "x$reverse" =3D "x0" -a -e $linux_t=
ree/$link_dir; then
 		cd $linux_tree/$link_dir && eval find . $find_clean_opt | while read f=
; do
 			if test -L $f -a ! -e $f; then rm -f $f; fi
 		done
@@ -102,11 +114,15 @@ patch_link() {
 		f=3D`echo $f | cut -d/ -f2-`
 		d=3D`dirname $f`
 		if test "x$output_patch" =3D "x"; then
-			mkdir -p $linux_tree/$link_dir/$d
-			if test x$forcelink =3D x1 -o \
-				! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
-			then
-				ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
+			if test x$reverse =3D x1; then
+				rm -f $linux_tree/$link_dir/$f
+			else
+				mkdir -p $linux_tree/$link_dir/$d
+				if test x$forcelink =3D x1 -o \
+					! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
+				then
+					ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
+				fi
 			fi
 		else
 			if test `check_filter $link_dir/$f` =3D "ok"; then
@@ -118,6 +134,11 @@ patch_link() {
 			fi
 		fi
 	done
+	if test x$reverse =3D x1; then
+		if ! find $linux_tree/$link_dir -not -type d | grep -q . ; then
+			rm -rf $linux_tree/$link_dir
+		fi
+	fi
 	)
 }
=20
@@ -133,8 +154,7 @@ generate_patch() {
 	)
 }
=20
-
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
@@ -170,6 +190,9 @@ while test $# -gt 0; do
 	--verbose)
 		verbose=3D1
 		;;
+	--reverse)
+		reverse=3D1
+		;;
 	--help)
 		echo "$usage"
 		exit 0
@@ -219,6 +242,13 @@ if test \! -r $linux_tree/Makefile; then
 	exit 2
 fi
=20
+if test x$reverse =3D x1; then
+	if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; then
+		echo "$me: $linux_tree is not prepared with Xenomai" >&2
+		exit 2
+	fi
+fi
+
 # Create an empty output patch file, and initialize the temporary tree.
 if test "x$output_patch" !=3D "x"; then
 	temp_tree=3D`mktemp -d prepare-kernel-XXX --tmpdir`
@@ -227,6 +257,11 @@ if test "x$output_patch" !=3D "x"; then
 		exit 1
 	fi
=20
+	if test x$reverse =3D x1; then
+		echo "$me: --reverse and --outpatch are not compatible"
+		exit 1
+	fi
+
 	patchdir=3D`dirname $output_patch`
 	patchdir=3D`cd $patchdir && pwd`
 	output_patch=3D$patchdir/`basename $output_patch`
@@ -353,15 +388,18 @@ case $linux_VERSION.$linux_PATCHLEVEL in
 			-e "s,@SRCARCH@,$linux_arch,g" \
 			$xenomai_root/scripts/Kconfig.frag |
 			patch_append init/Kconfig
+	elif test x$reverse =3D x1; then
+		patch_reverse init/Kconfig
 	fi
=20
 	test "x$CONFIG_XENO_REVISION_LEVEL" =3D "x" && CONFIG_XENO_REVISION_LEV=
EL=3D0
=20
 	if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; then
-		p=3D"KBUILD_CFLAGS +=3D -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include=
 -I\$(srctree)/include/xenomai"
-		(echo; echo $p) | patch_append arch/$linux_arch/Makefile
-		p=3D"core-\$(CONFIG_XENOMAI)	+=3D arch/$linux_arch/xenomai/"
-		echo $p | patch_append arch/$linux_arch/Makefile
+		p1=3D"KBUILD_CFLAGS +=3D -I\$(srctree)/arch/\$(SRCARCH)/xenomai/includ=
e -I\$(srctree)/include/xenomai"
+		p2=3D"core-\$(CONFIG_XENOMAI)	+=3D arch/$linux_arch/xenomai/"
+		(echo; echo $p1; echo $p2) | patch_append arch/$linux_arch/Makefile
+	elif test x$reverse =3D x1; then
+		patch_reverse arch/$linux_arch/Makefile
 	fi
=20
 	patch_architecture_specific=3D"n"
@@ -369,11 +407,15 @@ case $linux_VERSION.$linux_PATCHLEVEL in
 	if ! grep -q CONFIG_XENOMAI $linux_tree/drivers/Makefile; then
 		p=3D"obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
 		( echo ; echo $p ) | patch_append drivers/Makefile
+	elif test x$reverse =3D x1; then
+		patch_reverse drivers/Makefile
 	fi
=20
 	if ! grep -q CONFIG_XENOMAI $linux_tree/kernel/Makefile; then
 		p=3D"obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
 		( echo ; echo $p ) | patch_append kernel/Makefile
+	elif test x$reverse =3D x1; then
+		patch_reverse kernel/Makefile
 	fi
 	;;
 esac
@@ -381,13 +423,15 @@ esac
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
@@ -395,14 +439,15 @@ patch_link r n kernel/cobalt/include/asm-generic/xe=
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

