Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8DA1A08C4
	for <xenomai@lists.linux.dev>; Mon, 24 Jun 2024 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261249; cv=none; b=k2R5YeTSwMBeWnoFg0PuHzIBKrp6Fgu8n1OW26DyazF0x5pt8Q20rCWzEM3j4K27l72S3EATzRnZF8jywBtrdFzT3CM24aekisx4TwTTGTC9dyl7D4M28Z0O7gtTKyaH1pWcCELzzWQ+YEIfYEL2oVOed7sLYch2UZgB8wmrX78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261249; c=relaxed/simple;
	bh=BKGZPvLJOiGBbUpmxSl5WgY5ut6HVN7pCFfwG1wOKrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YCWs6X0v64tWKUujimB4SB9+GvQ00ZZIwisfyMtuf3f4+Oq3yEXE+t14Qt1DJs2LLi3pOyidJAsw3U9eqlDT2GOrc5MPaOflaJNeDNZQxo/lZeDRE/iGobXsmAFLk4N3mQFusZTTTPwRorv5WDAp/hsl8KyIGAjjBwsUq+mMwXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2B4966195FD3;
	Mon, 24 Jun 2024 22:33:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id FfrqK8S1ZTsu; Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id AA5076450959;
	Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LN06MzDFD6-I; Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 6C7C56195FD3;
	Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 14/14] prepare-kernel.sh: Remove kernel version check
Date: Mon, 24 Jun 2024 22:33:41 +0200
Message-Id: <20240624203341.6263-15-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240624203341.6263-1-richard@nod.at>
References: <20240624203341.6263-1-richard@nod.at>
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
 scripts/prepare-kernel.sh | 95 ++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 56 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 276273a96..20c384f13 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -250,15 +250,8 @@ if [ ! -z $foo ] ; then
 fi
 unset foo
=20
-eval linux_`grep '^EXTRAVERSION =3D' $linux_tree/Makefile | sed -e 's, ,=
,g'`
-eval linux_`grep '^PATCHLEVEL =3D' $linux_tree/Makefile | sed -e 's, ,,g=
'`
-eval linux_`grep '^SUBLEVEL =3D' $linux_tree/Makefile | sed -e 's, ,,g'`
-eval linux_`grep '^VERSION =3D' $linux_tree/Makefile | sed -e 's, ,,g'`
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
@@ -297,58 +290,48 @@ if test x$verbose =3D x1; then
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
 		patch_append init/Kconfig
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
-esac
+if ! grep -q CONFIG_XENOMAI $linux_tree/drivers/Makefile; then
+	p=3D"obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
+	( echo ; echo $p ) | patch_append drivers/Makefile
+elif test x$reverse =3D x1; then
+	patch_reverse drivers/Makefile
+fi
+
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

