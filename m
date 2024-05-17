Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEDC56B70
	for <xenomai@lists.linux.dev>; Fri, 17 May 2024 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715952995; cv=none; b=uS6nT+YwVo9d4JzfZJb6Tug/6WhV68tymmFpHiVX07iqgBYQFM3L8K6VdbQud+SVPY5r1ajyF1pe8P/EMdGKDA3qo0//lviZ5OlGHKwqCAIJR9REY/JQD2iVbwq7CpQNQDS8ns9S4YMcVJDAAQplD+LsDH3VlA5cyvpm/zDHlRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715952995; c=relaxed/simple;
	bh=FpPyYiyNGWwxpw5CQCAtuClfVa6e8VVGuSI2lKReZXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OqQRXd/bhlyoyEQAwzewqPVnvGCEnrj00LDkrAWLKfXt8NbkpfJ8WVTPTEWrsnufwi7/kHsUNw2NteAhaNRwHx/sj6JlHdPR9wux5qv3+/gOvrLPGgHFCJuIlOLtcCBjR8phxWxYbQgXtfOZjDvDzCilUPhb/hqk89pKuEHRdZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C82BF63D93BE
	for <xenomai@lists.linux.dev>; Fri, 17 May 2024 15:36:23 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id loq7nKwjhbHv; Fri, 17 May 2024 15:36:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4EADA63D93A4;
	Fri, 17 May 2024 15:36:23 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vz_wxNPULn_e; Fri, 17 May 2024 15:36:23 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 1AE15647A824;
	Fri, 17 May 2024 15:36:23 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>
Subject: [PATCH] [RFC] prepare-kernel.sh: Emit architecture agnostic changes
Date: Fri, 17 May 2024 15:36:03 +0200
Message-Id: <20240517133603.17554-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If --arch=3D is not passed, emit changes that work on all architectures
supported by Xenomai, currently arm, arm64 and x86.
This is especially useful with --outpatch=3D, the resulting patch can be
used for any architecture later and makes maintaining and building
a Xenomai enabled kernel easier.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/Kconfig.frag      |  2 +-
 scripts/prepare-kernel.sh | 56 +++++++++++++++++----------------------
 2 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/scripts/Kconfig.frag b/scripts/Kconfig.frag
index b76d25e53..3c9ad2b9f 100644
--- a/scripts/Kconfig.frag
+++ b/scripts/Kconfig.frag
@@ -16,7 +16,7 @@ menuconfig XENOMAI
 	  Please visit http://xenomai.org for more information.
=20
 if XENOMAI
-source "arch/@SRCARCH@/xenomai/Kconfig"
+source "arch/$(SRCARCH)/xenomai/Kconfig"
 endif
=20
 if MIGRATION
diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index c9aeeb4fa..25f3b4a7c 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -249,37 +249,24 @@ if test "x$output_patch" !=3D "x"; then
=20
 fi
=20
-# Infer the default architecture if unspecified.
-
-if test x$linux_arch =3D x; then
-   build_arch=3D`$xenomai_root/config/config.guess`
-   default_linux_arch=3D`echo $build_arch|cut -f1 -d-`
-fi
-
 while : ; do
    if test x$linux_arch =3D x; then
-      if test x$usedefault =3D x; then
-         echo -n "Target architecture [default $default_linux_arch]: "
-         read linux_arch
-      fi
-      if test "x$linux_arch" =3D x; then
-         linux_arch=3D$default_linux_arch
-      fi
+      target_linux_archs=3D(x86 arm arm64)
+      break
    fi
    case "$linux_arch" in
    x86*|i*86|amd*)
-      linux_arch=3Dx86
+      target_linux_archs=3D(x86)
       ;;
    arm)
-      linux_arch=3Darm
+      target_linux_archs=3D(arm)
       ;;
    arm64|aarch64)
-      linux_arch=3Darm64
+      target_linux_archs=3D(arm64)
       ;;
    *)
       echo "$me: unsupported architecture: $linux_arch" >&2
-      linux_arch=3D
-      usedefault=3D
+      exit 1
       ;;
    esac
    if test \! x$linux_arch =3D x; then
@@ -333,10 +320,12 @@ else
    cd $curdir
 fi
=20
-if test \! -r $linux_tree/arch/$linux_arch/$arch_probe_header; then
-   echo "$me: $linux_tree has no IRQ pipeline support for $linux_arch" >=
&2
-   exit 2
-fi
+for a in ${target_linux_archs[@]}; do
+   if test \! -r $linux_tree/arch/$a/$arch_probe_header; then
+      echo "$me: $linux_tree has no IRQ pipeline support for $a" >&2
+      exit 2
+   fi
+done
=20
 if test x$verbose =3D x1; then
    echo "IRQ pipeline installed."
@@ -369,19 +358,20 @@ case $linux_VERSION.$linux_PATCHLEVEL in
 	    -e "s,@VERSION_MINOR@,$version_minor,g" \
 	    -e "s,@REVISION_LEVEL@,$revision_level,g" \
 	    -e "s,@VERSION_STRING@,$version_string,g" \
-	    -e "s,@SRCARCH@,$linux_arch,g" \
 	    $xenomai_root/scripts/Kconfig.frag |
             patch_append init/Kconfig
     fi
=20
 test "x$CONFIG_XENO_REVISION_LEVEL" =3D "x" && CONFIG_XENO_REVISION_LEVE=
L=3D0
=20
-    if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; t=
hen
-	p=3D"KBUILD_CFLAGS +=3D -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include =
-I\$(srctree)/include/xenomai"
-	(echo; echo $p) | patch_append arch/$linux_arch/Makefile
-	p=3D"core-\$(CONFIG_XENOMAI)	+=3D arch/$linux_arch/xenomai/"
-	echo $p | patch_append arch/$linux_arch/Makefile
-    fi
+    for a in ${target_linux_archs[@]}; do
+        if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$a/Makefile; then
+	    p=3D"KBUILD_CFLAGS +=3D -I\$(srctree)/arch/\$(SRCARCH)/xenomai/incl=
ude -I\$(srctree)/include/xenomai"
+	    (echo; echo $p) | patch_append arch/$a/Makefile
+	    p=3D"core-\$(CONFIG_XENOMAI)	+=3D arch/\$(SRCARCH)/xenomai/"
+	    echo $p | patch_append arch/$a/Makefile
+        fi
+    done
=20
     patch_architecture_specific=3D"n"
=20
@@ -404,8 +394,10 @@ esac
=20
 patch_kernelversion_specific=3D"n"
 patch_architecture_specific=3D"y"
-patch_link r m kernel/cobalt/arch/$linux_arch arch/$linux_arch/xenomai
-patch_link n n kernel/cobalt/include/dovetail arch/$linux_arch/include/d=
ovetail
+for a in ${target_linux_archs[@]}; do
+    patch_link r m kernel/cobalt/arch/$a arch/$a/xenomai
+    patch_link n n kernel/cobalt/include/dovetail arch/$a/include/doveta=
il
+done
 patch_architecture_specific=3D"n"
 patch_link n m kernel/cobalt kernel/xenomai
 patch_link n cobalt-core.h kernel/cobalt/trace include/trace/events
--=20
2.35.3

