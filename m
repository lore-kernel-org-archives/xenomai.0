Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C1B3F9E8
	for <xenomai@lists.linux.dev>; Sat, 25 May 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638323; cv=none; b=BbP3EpVNTKcFlopbIIqohJC/KGOwvDmzXUzoKBW2LXsZtCJf92UMxeqpWcAmTtiRi2NuIgbdV9nv4XsRk5izImhv6crqk31quD9LyO5yAJRsPThZBAOB6s/mTBx19OW2VxDuV7bPME8uNXMGuZ7hxfElxl0pGDWkxBcysucjZoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638323; c=relaxed/simple;
	bh=tz3SXBp6ZPTLYRGIrXHTtWxCtLoEgwnstVFiypMnhxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rtk3i1PQM1EWelFG5VGbAzQVT39eR8rva366pbN4bTJbx0Y8ZuaT4sE/A8Mim40S3ryeGMIbncBSFqbfVIKyJBDpykAj0AA3RTSf2sJEUwLA07h6djVc1tlbTIV9MUN0lQdXdU5OiB9pkweXjjyeNsqlxJBVYDhZPfvqN6INOAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 65AFD6410403;
	Sat, 25 May 2024 13:58:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id jEFONf20qVpA; Sat, 25 May 2024 13:58:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D58C5644CE83;
	Sat, 25 May 2024 13:58:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BIAIQ5ujfLmK; Sat, 25 May 2024 13:58:29 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 88B756195FFB;
	Sat, 25 May 2024 13:58:29 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 09/16] prepare-kernel.sh: Remove --filterkvers= and --filterarch=
Date: Sat, 25 May 2024 13:57:59 +0200
Message-Id: <20240525115806.12101-10-richard@nod.at>
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

These days (not) applying kernel version or architecture specific changes
is no longer needed for development.
Let's simplify the code and remove this feature.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 65 ++++++---------------------------------
 1 file changed, 9 insertions(+), 56 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index f7aca804f..53ff89abd 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -3,28 +3,6 @@ set -e
=20
 unset CDPATH
=20
-# At all time, this variable must be set to either:
-# "y" if the changes to the Linux tree are specific to the kernel versio=
n;
-# "n" otherwise.
-patch_kernelversion_specific=3D"n"
-
-# At all time, this variable must be set to either:
-# "y" if the changes to the Linux tree are specific to the architecture;
-# "n" otherwise.
-patch_architecture_specific=3D"n"
-
-# At all time, this variable must be set to either:
-# "y": ignore kernel-version-specific changes;
-# "n": ignore non-kernel-version-specific changes;
-# "b": don't filter according to the kernel version.
-patch_kernelversion_filter=3D"b"
-
-# At all time, this variable must be set to either:
-# "y": ignore architecture-specific changes;
-# "n": ignore non-architecture-specific changes;
-# "b": don't filter according to the architecture.
-patch_architecture_filter=3D"b"
-
 # Default path to kernel tree
 linux_tree=3D.
=20
@@ -37,18 +15,6 @@ patch_copytempfile() {
 	fi
 }
=20
-check_filter() {
-	if test "$patch_kernelversion_specific" !=3D "$patch_kernelversion_filt=
er" \
-		-a "$patch_architecture_specific" !=3D "$patch_architecture_filter"; t=
hen
-		echo ok
-	elif test -e "$temp_tree/$1"; then
-		echo "$me: inconsistent multiple changes to $1 in Linux kernel tree" >=
&2
-		echo error
-	else
-		echo ignore
-	fi
-}
-
 patch_append() {
 	file=3D"$1"
 	if test "x$output_patch" =3D "x"; then
@@ -61,10 +27,8 @@ patch_append() {
 		chmod +w "$linux_tree/$file"
 		cat >> "$linux_tree/$file"
 	else
-		if test "`check_filter $file`" =3D "ok"; then
-			patch_copytempfile "$file"
-			cat >> "$temp_tree/$file"
-		fi
+		patch_copytempfile "$file"
+		cat >> "$temp_tree/$file"
 	fi
 }
=20
@@ -123,13 +87,11 @@ patch_link() {
 				fi
 			fi
 		else
-			if test "`check_filter $link_dir/$f`" =3D "ok"; then
-                    		if test -e $linux_tree/$link_dir/$f; then
-                        		echo "$me: warning: $link_dir/$f already prese=
nt in Linux kernel tree, output patch might be defective" >&2
-                    		fi
-				mkdir -p $temp_tree/$link_dir/$d
-				cp $xenomai_root/$target_dir/$f $temp_tree/$link_dir/$f
+			if test -e $linux_tree/$link_dir/$f; then
+				echo "$me: warning: $link_dir/$f already present in Linux kernel tre=
e, output patch might be defective" >&2
 			fi
+			mkdir -p $temp_tree/$link_dir/$d
+			cp $xenomai_root/$target_dir/$f $temp_tree/$link_dir/$f
 		fi
 	done
=20
@@ -155,7 +117,7 @@ generate_patch() {
 }
=20
=20
-usage=3D'usage: prepare-kernel --linux=3D<linux-tree> [--dovetail=3D<dov=
etail-patch>] [--arch=3D<arch>] [--outpatch=3D<file> [--filterkvers=3Dy|n=
] [--filterarch=3Dy|n]] [--forcelink] [--default] [--verbose] [--reverse]=
'
+usage=3D'usage: prepare-kernel --linux=3D<linux-tree> [--dovetail=3D<dov=
etail-patch>] [--arch=3D<arch>] [--outpatch=3D<file> [--forcelink] [--def=
ault] [--verbose] [--reverse]'
 me=3D`basename $0`
=20
 while test $# -gt 0; do
@@ -177,10 +139,10 @@ while test $# -gt 0; do
 		output_patch=3D`echo $1|sed -e 's,^--outpatch=3D\\(.*\\)$,\\1,g'`
 	;;
 	--filterkvers=3D*)
-		patch_kernelversion_filter=3D`echo $1|sed -e 's,^--filterkvers=3D\\(.*=
\\)$,\\1,g'`
+		echo "$me: warning: --filterkvers=3D is deprecated and now a no-op" >&=
2
 		;;
 	--filterarch=3D*)
-		patch_architecture_filter=3D`echo $1|sed -e 's,^--filterarch=3D\\(.*\\=
)$,\\1,g'`
+		echo "$me: warning: --filterarch=3D is deprecated and now a no-op" >&2
 		;;
 	--forcelink)
 		forcelink=3D1
@@ -351,8 +313,6 @@ if test x$verbose =3D x1; then
 	echo "IRQ pipeline installed."
 fi
=20
-patch_kernelversion_specific=3D"y"
-
 case $linux_VERSION.$linux_PATCHLEVEL in
=20
 	2.*)
@@ -363,8 +323,6 @@ case $linux_VERSION.$linux_PATCHLEVEL in
=20
 	*)
=20
-	patch_architecture_specific=3D"y"
-
 	if ! grep -q XENOMAI $linux_tree/init/Kconfig; then
 		version_stamp=3D`cat $xenomai_root/config/version-code`
 		version_major=3D`expr $version_stamp : '\([[0-9]]*\)' || true`
@@ -396,8 +354,6 @@ test "x$CONFIG_XENO_REVISION_LEVEL" =3D "x" && CONFIG=
_XENO_REVISION_LEVEL=3D0
 		fi
 	done
=20
-	patch_architecture_specific=3D"n"
-
 	if ! grep -q CONFIG_XENOMAI $linux_tree/drivers/Makefile; then
 		p=3D"obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
 		( echo ; echo $p ) | patch_append drivers/Makefile
@@ -422,13 +378,10 @@ esac
 # Keep link dirs (4th parameter) descending, otherwise --reverse
 # is not able to cleanup these directories!
=20
-patch_kernelversion_specific=3D"n"
-patch_architecture_specific=3D"y"
 for a in $target_linux_archs; do
 	patch_link r m kernel/cobalt/arch/$a arch/$a/xenomai
 	patch_link n n kernel/cobalt/include/dovetail arch/$a/include/dovetail
 done
-patch_architecture_specific=3D"n"
 patch_link n cobalt-core.h kernel/cobalt/trace include/trace/events
 patch_link n cobalt-rtdm.h kernel/cobalt/trace include/trace/events
 patch_link n cobalt-posix.h kernel/cobalt/trace include/trace/events
--=20
2.35.3

