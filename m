Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E672C2EE616
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210976; cv=none; b=menOi1Pm31m6YQU6vN2BlQLMqVU9K3A+FH4cUxie1Zd5jii+YeIMm2/zBze42quxMBw0vd449oKU88+EBWNZ71NTImMEJ0HW/bJc7amVre7JC0koDVVz0v6NW10cvOCDKGfkLlFrdLPIxGjA2uOMuSChUjh2CwcTmzvMiG5qDeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210976; c=relaxed/simple;
	bh=WMu0xVdZxVIDGcbT01LpS3wgn6OrAQZl0GLlhk+qMUc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jopslnR0Tlr0zQxzd9M7dUs8zSZhYYJUiuyDMb12lfFrfdUb2EOXtIXfd4WUkDVH4iwEjwAqhkUxRM2EkmQwNHb2Sqjz8OLf+YXYY8i/Sn0x7ZBZ4Uima4PzE/h7TDVUjlKIU7TgKws06wxeEHBf8fo/AAYVYbXbPcUE4cRg5qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=gOy1VUgV; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="gOy1VUgV"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2025091815561184723ff1ea00020744
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 17:56:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=4r1aywit0bj1Ad2plkYhjB4a+FTuaPAAPje13zP/mMU=;
 b=gOy1VUgVL22Qs3/0Naabi9Wi/ZVXenJZsun0UfesBmjRbvjO4Mryg6HhtXCARkyn5ZZbFg
 qEvv6Ox6gKQawQr347Knex5hdpFgZ0IMqh+if14I0C+i7hFHGXOmY6KF2MDHKA3lZr0z/hvt
 96CxHop+1FtnKfTnKq0eiRIjOndfolabWYB+FyP93EFREheaq9L5EBppVKWFTbnpU/ecIhvW
 VHPCALdWrdx0uQvr2ssh7JQ6O2Yu9bH9hf5j1iwFs7+JQhGYjXo5Sgqp+JrM7q7cpvh0H5ei
 nG9D041iQeTygVyvZJIx5Ue8inAOThyO7olAFWnYhZXhGbCvRyFoaeUA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 05/13] Update isar revision
Date: Thu, 18 Sep 2025 17:55:47 +0200
Message-ID: <91f80fd207c8b717c02205ddfa6f9e40663191f5.1758210955.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1758210955.git.jan.kiszka@siemens.com>
References: <cover.1758210955.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Required to move to trixie later on. The two fixes are awaiting upstream
merge.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...tom-support-to-add-linux-libc-dev-pa.patch | 132 ++++++++++++++++++
 ...-missing-Multi-Arch-foreign-to-linux.patch |  45 ++++++
 kas.yml                                       |   9 +-
 3 files changed, 185 insertions(+), 1 deletion(-)
 create mode 100644 isar-patches/0001-Revert-linux-custom-support-to-add-linux-libc-dev-pa.patch
 create mode 100644 isar-patches/0002-linux-custom-Add-missing-Multi-Arch-foreign-to-linux.patch

diff --git a/isar-patches/0001-Revert-linux-custom-support-to-add-linux-libc-dev-pa.patch b/isar-patches/0001-Revert-linux-custom-support-to-add-linux-libc-dev-pa.patch
new file mode 100644
index 0000000..8bf4bc7
--- /dev/null
+++ b/isar-patches/0001-Revert-linux-custom-support-to-add-linux-libc-dev-pa.patch
@@ -0,0 +1,132 @@
+From 76b9022a69ab493e3770432b433ad1aa2363c1eb Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Wed, 10 Sep 2025 17:50:53 +0200
+Subject: [PATCH 1/2] Revert "linux-custom: support to add linux-libc-dev
+ package with kernel name"
+
+This reverts commit 6cf35fc33d11f7d3feb0472a40e79dbd3ee3d759.
+
+Besides having multiple implementations flaws, the general approach
+turned out to be incompatible with Debian's dependency management: We
+cannot replace a package A with a package B which only provides A. The
+resolver will continue to prefer package A when it is requested,
+explicitly or implicitly.
+
+If a build enables multiple kernels, it is recommended to ensure at
+recipe-level that only one kernel build enables KERNEL_LIBC_DEV_DEPLOY.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ RECIPE-API-CHANGELOG.md                                |  7 +++++++
+ doc/custom_kernel.md                                   |  4 ++--
+ meta/recipes-kernel/linux/files/debian/control.tmpl    | 10 +++-------
+ .../recipes-kernel/linux/files/debian/isar/common.tmpl |  2 +-
+ .../linux/files/debian/isar/install.tmpl               |  2 +-
+ meta/recipes-kernel/linux/linux-custom.inc             |  2 --
+ 6 files changed, 14 insertions(+), 13 deletions(-)
+
+diff --git a/RECIPE-API-CHANGELOG.md b/RECIPE-API-CHANGELOG.md
+index 8468717d..6579f2e9 100644
+--- a/RECIPE-API-CHANGELOG.md
++++ b/RECIPE-API-CHANGELOG.md
+@@ -727,3 +727,10 @@ Changes in next
+ 
+ This was never documented and never had practical relevance. `oci-archive` is
+ the useful OCI image format that can be imported, e.g., by podman.
++
++### Revert enabling of linux-libc-dev package with KERNEL_NAME
++
++The change "Enable linux-libc-dev package with KERNEL_NAME" turned out to be
++incompatible with how Debian selects dependencies. It is therefore necessary
++to only enable `KERNEL_LIBC_DEV_DEPLOY` for a single kernel in case multiples
++are configured via `KERNEL_NAMES`.
+diff --git a/doc/custom_kernel.md b/doc/custom_kernel.md
+index 2dca577c..ce5f1bf7 100644
+--- a/doc/custom_kernel.md
++++ b/doc/custom_kernel.md
+@@ -51,9 +51,9 @@ The linux-custom recipe provides support for:
+ 
+     Only the `host` specific package is built automatically at cross builds.
+ 
+- 10. Produce a `linux-libc-dev-${KERNEL_NAME}` package to support user-land builds
++ 10. Produce a `linux-libc-dev` package to support user-land builds
+ 
+- 11. Only build/ship the `linux-libc-dev-${KERNEL_NAME}` package if instructed to
++ 11. Only build/ship the `linux-libc-dev` package if instructed to
+      (`KERNEL_LIBC_DEV_DEPLOY` equals to `"1"`)
+ 
+  12. Support both native and cross compiles (`ISAR_CROSS_COMPILE`)
+diff --git a/meta/recipes-kernel/linux/files/debian/control.tmpl b/meta/recipes-kernel/linux/files/debian/control.tmpl
+index a79b86c4..ec0da1ab 100644
+--- a/meta/recipes-kernel/linux/files/debian/control.tmpl
++++ b/meta/recipes-kernel/linux/files/debian/control.tmpl
+@@ -22,23 +22,19 @@ Description: ${KERNEL_NAME_PROVIDED} Linux kernel headers for @KR@
+  .
+  This is useful for people who need to build external modules
+ 
+-Package: linux-libc-dev-${KERNEL_NAME_PROVIDED}
++Package: linux-libc-dev
+ Build-Profiles: <!nolibcdev kernel>
+ Section: devel
+-Conflicts: linux-libc-dev
+-Provides: linux-libc-dev
+-Replaces: linux-libc-dev
++Provides: linux-kernel-headers
+ Architecture: ${KERNEL_LIBC_DEV_ARCH}
+ Description: Linux support headers for userspace development
+  This package provides userspaces headers from the Linux kernel. These headers
+  are used by the installed headers for GNU glibc and other system libraries.
+ 
+-Package: linux-libc-dev-${DISTRO_ARCH}-cross-${KERNEL_NAME_PROVIDED}
++Package: linux-libc-dev-${DISTRO_ARCH}-cross
+ Build-Profiles: <!nolibcdev cross !kbuild>
+ Section: devel
+-Conflicts: linux-kernel-headers-${DISTRO_ARCH}-cross
+ Provides: linux-kernel-headers-${DISTRO_ARCH}-cross
+-Replaces: linux-kernel-headers-${DISTRO_ARCH}-cross
+ Architecture: all
+ Description: Linux Kernel Headers for development (for cross-compiling)
+  This package provides headers from the Linux kernel.  These headers
+diff --git a/meta/recipes-kernel/linux/files/debian/isar/common.tmpl b/meta/recipes-kernel/linux/files/debian/isar/common.tmpl
+index b004214f..f9cc2f02 100644
+--- a/meta/recipes-kernel/linux/files/debian/isar/common.tmpl
++++ b/meta/recipes-kernel/linux/files/debian/isar/common.tmpl
+@@ -8,7 +8,7 @@ set -e
+ ARCH=${KERNEL_ARCH}
+ KERNEL_PKG_IMAGE=linux-image-${KERNEL_NAME_PROVIDED}
+ KERNEL_PKG_KERN_HEADERS=linux-headers-${KERNEL_NAME_PROVIDED}
+-KERNEL_PKG_LIBC_HEADERS=linux-libc-dev-${KERNEL_NAME_PROVIDED}
++KERNEL_PKG_LIBC_HEADERS=linux-libc-dev
+ KERNEL_PKG_LIBC_HEADERS_CROSS=linux-libc-dev-${DISTRO_ARCH}-cross
+ KERNEL_PKG_KERN_KBUILD=linux-kbuild-${KERNEL_NAME_PROVIDED}
+ KERNEL_PKG_KERN_KBUILD_CROSS=${KERNEL_PKG_KERN_KBUILD}-${DISTRO_ARCH}-cross
+diff --git a/meta/recipes-kernel/linux/files/debian/isar/install.tmpl b/meta/recipes-kernel/linux/files/debian/isar/install.tmpl
+index d7e711ef..fe0bd810 100644
+--- a/meta/recipes-kernel/linux/files/debian/isar/install.tmpl
++++ b/meta/recipes-kernel/linux/files/debian/isar/install.tmpl
+@@ -240,7 +240,7 @@ install_headers() {
+     if dpkg --compare-versions "${krel}" "lt" "5.4.24"; then
+         headers_check
+     fi
+-    [ -z ${kern_pkgs["linux-libc-dev-${KERNEL_NAME_PROVIDED}"]} ] || libc_headers
++    [ -z ${kern_pkgs["linux-libc-dev"]} ] || libc_headers
+     kernel_headers
+ }
+ 
+diff --git a/meta/recipes-kernel/linux/linux-custom.inc b/meta/recipes-kernel/linux/linux-custom.inc
+index 01e9bff7..07e49ce7 100644
+--- a/meta/recipes-kernel/linux/linux-custom.inc
++++ b/meta/recipes-kernel/linux/linux-custom.inc
+@@ -155,9 +155,7 @@ RECIPE_PROVIDES = " \
+     linux-image-${KERNEL_NAME_PROVIDED} \
+     linux-headers-${KERNEL_NAME_PROVIDED} \
+     linux-libc-dev \
+-    linux-libc-dev-${KERNEL_NAME_PROVIDED} \
+     linux-libc-dev-${DISTRO_ARCH}-cross \
+-    linux-libc-dev-${DISTRO_ARCH}-cross-${KERNEL_NAME_PROVIDED} \
+     linux-image-${KERNEL_NAME_PROVIDED}-dbg \
+     linux-kbuild-${KERNEL_NAME_PROVIDED} \
+     ${BPN}-pseudo-native \
+-- 
+2.51.0
+
diff --git a/isar-patches/0002-linux-custom-Add-missing-Multi-Arch-foreign-to-linux.patch b/isar-patches/0002-linux-custom-Add-missing-Multi-Arch-foreign-to-linux.patch
new file mode 100644
index 0000000..80d8331
--- /dev/null
+++ b/isar-patches/0002-linux-custom-Add-missing-Multi-Arch-foreign-to-linux.patch
@@ -0,0 +1,45 @@
+From 175a8d4917308b6654376e1095dbfd254f52d58e Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Thu, 11 Sep 2025 21:47:20 +0200
+Subject: [PATCH 2/2] linux-custom: Add missing Multi-Arch foreign to
+ linux-libc-dev*
+
+This ensures that we create true drop-in replacements of the
+respective upstream packages.
+
+Fixes: 90aa31273278 ("linux-custom: generate linux-libc-dev for "all" vs "any" like trixie")
+Fixes: 13103ab84d5d ("linux-custom: Generate cross linux-libc-dev package")
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ meta/recipes-kernel/linux/files/debian/control.tmpl | 1 +
+ meta/recipes-kernel/linux/linux-custom.inc          | 2 +-
+ 2 files changed, 2 insertions(+), 1 deletion(-)
+
+diff --git a/meta/recipes-kernel/linux/files/debian/control.tmpl b/meta/recipes-kernel/linux/files/debian/control.tmpl
+index ec0da1ab..e2a878a9 100644
+--- a/meta/recipes-kernel/linux/files/debian/control.tmpl
++++ b/meta/recipes-kernel/linux/files/debian/control.tmpl
+@@ -36,6 +36,7 @@ Build-Profiles: <!nolibcdev cross !kbuild>
+ Section: devel
+ Provides: linux-kernel-headers-${DISTRO_ARCH}-cross
+ Architecture: all
++Multi-Arch: foreign
+ Description: Linux Kernel Headers for development (for cross-compiling)
+  This package provides headers from the Linux kernel.  These headers
+  are used by the installed headers for GNU glibc and other system
+diff --git a/meta/recipes-kernel/linux/linux-custom.inc b/meta/recipes-kernel/linux/linux-custom.inc
+index 07e49ce7..995279d2 100644
+--- a/meta/recipes-kernel/linux/linux-custom.inc
++++ b/meta/recipes-kernel/linux/linux-custom.inc
+@@ -224,7 +224,7 @@ def get_additional_build_profiles(d):
+         profiles += ' libcdev-arch-all'
+     return profiles
+ 
+-KERNEL_LIBC_DEV_ARCH = "${@ bb.utils.contains('DEB_BUILD_PROFILES', 'libcdev-arch-all', 'all', 'any', d) }"
++KERNEL_LIBC_DEV_ARCH = "${@ bb.utils.contains('DEB_BUILD_PROFILES', 'libcdev-arch-all', 'all\nMulti-Arch: foreign', 'any', d) }"
+ DEB_BUILD_PROFILES += "${@get_additional_build_profiles(d)}"
+ 
+ do_prepare_build:prepend() {
+-- 
+2.51.0
+
diff --git a/kas.yml b/kas.yml
index 2020ed7..5d66228 100644
--- a/kas.yml
+++ b/kas.yml
@@ -22,9 +22,16 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 483093e11cd722f0c88dc2fcbed1e937fc0abb60
+    commit: 48a7eb4e0e9846e7e5bb44e52730d0bf59549a67
     layers:
       meta:
+    patches:
+      p1:
+        path: isar-patches/0001-Revert-linux-custom-support-to-add-linux-libc-dev-pa.patch
+        repo: xenomai
+      p2:
+        path: isar-patches/0002-linux-custom-Add-missing-Multi-Arch-foreign-to-linux.patch
+        repo: xenomai
 
 bblayers_conf_header:
   standard: |
-- 
2.51.0

