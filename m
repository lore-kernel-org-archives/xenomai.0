Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4581A3C68C
	for <xenomai@lists.linux.dev>; Sat, 25 May 2024 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638325; cv=none; b=PpC/hfdnD07FwE5VCTL6F8+cGdD9z1kntC5daTAv/FHNyalydhK9yORufaLXytoRrJujhD5V62hDnPOYZCNX7q5ncRLVKO3S3QLCfd2JtzHRTNSbqNSmYGbNBAUaFyme7lepEv0s2Lv0RDTuWJrY7H7IqTR6n4ZOEt/+NCaq2nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638325; c=relaxed/simple;
	bh=5o/Encxi+RwUCW5//mzC/CY6/lkbGP7ZQrwULoYyD/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eOcNTxNT6uzwakd6vo91ddAjJV0Sh7nqv3CjzMxxIFJietjv/yOAYTcEEU57/jywaNkiViAXytmj+6pw8B7ezPtICrVi5fqnUzhM3V9IJzEjB9THBaPAB/QVs3FANQxAKJje6SuwzPh8UH4JYnrKB93TGU0sB53tPFF/5rNiSo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C5DAA6340E1A;
	Sat, 25 May 2024 13:58:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id tlMJsdj0O5Hi; Sat, 25 May 2024 13:58:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4C701644CE8C;
	Sat, 25 May 2024 13:58:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dErIYy7rwGO9; Sat, 25 May 2024 13:58:31 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 1A6936340E1A;
	Sat, 25 May 2024 13:58:31 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 16/16] prepare-kernel.sh: Remove kernel version check
Date: Sat, 25 May 2024 13:58:06 +0200
Message-Id: <20240525115806.12101-17-richard@nod.at>
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

The kernel version is only used to test whether the kernel is extremely o=
ld
and verbose logging.
IMHO it's worth the complexity of reading it from the kernel tree.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 98 ++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 59 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index f6eedc1a0..b5644a4a9 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -250,15 +250,8 @@ if [ ! -z $foo ] ; then
 fi
 unset foo
=20
-linux_EXTRAVERSION=3D`awk -F=3D '/^EXTRAVERSION =3D/{ gsub(/ /, "", $2);=
 print $2}' $linux_tree/Makefile`
-linux_PATCHLEVEL=3D`awk -F=3D '/^PATCHLEVEL =3D/{ gsub(/ /, "", $2); pri=
nt $2}' $linux_tree/Makefile`
-linux_SUBLEVEL=3D`awk -F=3D '/^SUBLEVEL =3D/{ gsub(/ /, "", $2); print $=
2}' $linux_tree/Makefile`
-linux_VERSION=3D`awk -F=3D '/^VERSION =3D/{ gsub(/ /, "", $2); print $2}=
' $linux_tree/Makefile`
-
-linux_version=3D"$linux_VERSION.$linux_PATCHLEVEL.$linux_SUBLEVEL"
-
 if test x$verbose =3D x1; then
-	echo "Preparing kernel $linux_version$linux_EXTRAVERSION in $linux_tree=
..."
+	echo "Preparing kernel $linux_tree..."
 fi
=20
 if test -r $linux_tree/include/linux/dovetail.h; then
@@ -279,7 +272,7 @@ else
 	curdir=3D$PWD
 	cd $linux_tree && patch --dry-run -p1 -f < $pipeline_patch || {
 		cd $curdir;
-		echo "$me: Unable to patch kernel $linux_version$linux_EXTRAVERSION wi=
th `basename $pipeline_patch`." >&2
+		echo "$me: Unable to patch kernel $linux_tree with `basename $pipeline=
_patch`." >&2
 		exit 2;
 	}
 	patch -p1 -f -s < $pipeline_patch
@@ -297,61 +290,48 @@ if test x$verbose =3D x1; then
 	echo "IRQ pipeline installed."
 fi
=20
-case $linux_VERSION.$linux_PATCHLEVEL in
-
-	2.*)
-
-	echo "$me: Unsupported kernel version $linux_VERSION.$linux_PATCHLEVEL.=
x" >&2
-	exit 2
-	;;
-
-	*)
-
-	if ! grep -q XENOMAI $linux_tree/init/Kconfig; then
-		version_stamp=3D`cat $xenomai_root/config/version-code`
-		version_major=3D`expr $version_stamp : '\([[0-9]]*\)' || true`
-		version_minor=3D`expr $version_stamp : '[[0-9]]*\.\([[0-9]*]*\)' || tr=
ue`
-		revision_level=3D`expr $version_stamp : '[[0-9]]*\.[[0-9]*]*\.\([[0-9]=
*]*\)' || true`
-	if [ -z "$revision_level" ]; then
-		revision_level=3D0
-	fi
-	version_string=3D`cat $xenomai_root/config/version-label`
-	sed -e "s,@VERSION_MAJOR@,$version_major,g" \
-		-e "s,@VERSION_MINOR@,$version_minor,g" \
-		-e "s,@REVISION_LEVEL@,$revision_level,g" \
-		-e "s,@VERSION_STRING@,$version_string,g" \
-		$xenomai_root/scripts/Kconfig.frag |
-			patch_append init/Kconfig
-	elif test x$reverse =3D x1; then
-		patch_reverse init/Kconfig
-	fi
-
-	for a in $target_linux_archs; do
-		if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$a/Makefile; then
-			p1=3D"KBUILD_CFLAGS +=3D -I\$(srctree)/arch/\$(SRCARCH)/xenomai/inclu=
de -I\$(srctree)/include/xenomai"
-			p2=3D"core-\$(CONFIG_XENOMAI)	+=3D arch/$a/xenomai/"
-			(echo; echo $p1; echo $p2) | patch_append arch/$a/Makefile
-		elif test x$reverse =3D x1; then
-			patch_reverse arch/$a/Makefile
-		fi
-	done
+if ! grep -q XENOMAI $linux_tree/init/Kconfig; then
+	version_stamp=3D`cat $xenomai_root/config/version-code`
+	version_major=3D`expr $version_stamp : '\([[0-9]]*\)' || true`
+	version_minor=3D`expr $version_stamp : '[[0-9]]*\.\([[0-9]*]*\)' || tru=
e`
+	revision_level=3D`expr $version_stamp : '[[0-9]]*\.[[0-9]*]*\.\([[0-9]*=
]*\)' || true`
+if [ -z "$revision_level" ]; then
+	revision_level=3D0
+fi
+version_string=3D`cat $xenomai_root/config/version-label`
+sed -e "s,@VERSION_MAJOR@,$version_major,g" \
+	-e "s,@VERSION_MINOR@,$version_minor,g" \
+	-e "s,@REVISION_LEVEL@,$revision_level,g" \
+	-e "s,@VERSION_STRING@,$version_string,g" \
+	$xenomai_root/scripts/Kconfig.frag |
+		patch_append init/Kconfig
+elif test x$reverse =3D x1; then
+	patch_reverse init/Kconfig
+fi
=20
-	if ! grep -q CONFIG_XENOMAI $linux_tree/drivers/Makefile; then
-		p=3D"obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
-		( echo ; echo $p ) | patch_append drivers/Makefile
+for a in $target_linux_archs; do
+	if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$a/Makefile; then
+		p1=3D"KBUILD_CFLAGS +=3D -I\$(srctree)/arch/\$(SRCARCH)/xenomai/includ=
e -I\$(srctree)/include/xenomai"
+		p2=3D"core-\$(CONFIG_XENOMAI)	+=3D arch/$a/xenomai/"
+		(echo; echo $p1; echo $p2) | patch_append arch/$a/Makefile
 	elif test x$reverse =3D x1; then
-		patch_reverse drivers/Makefile
+		patch_reverse arch/$a/Makefile
 	fi
+done
=20
-	if ! grep -q CONFIG_XENOMAI $linux_tree/kernel/Makefile; then
-		p=3D"obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
-		( echo ; echo $p ) | patch_append kernel/Makefile
-	elif test x$reverse =3D x1; then
-		patch_reverse kernel/Makefile
-	fi
-	;;
+if ! grep -q CONFIG_XENOMAI $linux_tree/drivers/Makefile; then
+	p=3D"obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
+	( echo ; echo $p ) | patch_append drivers/Makefile
+elif test x$reverse =3D x1; then
+	patch_reverse drivers/Makefile
+fi
=20
-esac
+if ! grep -q CONFIG_XENOMAI $linux_tree/kernel/Makefile; then
+	p=3D"obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
+	( echo ; echo $p ) | patch_append kernel/Makefile
+elif test x$reverse =3D x1; then
+	patch_reverse kernel/Makefile
+fi
=20
 # Create local directories then symlink to the source files from
 # there, so that we don't pollute the Xenomai source tree with
--=20
2.35.3

