Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FC626A1B5
	for <xenomai@lists.linux.dev>; Fri, 19 Dec 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766163126; cv=none; b=nCuGgl/g9AaWhbbRjguyQyqdETu289Uut+yG34m1FhluHv/gh6tLTLZuP7nGGAOBjP9Oy0uK0gGwVJIJCpAXbXyXXqAgB/JOl5jkwRASnJmqiKtZsHcaeL8fpz0kR9Muj8Hl9/6aymOzXGC+7ITEgMM+QpBnRUh3D0Q+r4gljXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766163126; c=relaxed/simple;
	bh=xl5TpOwQsDeMlBmfyqTugCuC2II9y5/jGlQ0APLOkPE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lx0vKBP7SepsZUz7McuPJZDmxm+I6nV+sWq+zaV2a+wv0c8+ZKT4gEFEjdQeY60hjvDdBKGJXsI56DjCBhYn3k2yJvS5yV5iBFBpLPUASKVouKR+FdNSWZUA+5QZL+aHwpXtSQTaDWU1MgibtKoeq5YuXG1hhkqecYMvFvgiFMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=csOEM23K; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="csOEM23K"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20251219165155e56b3de59300020796
        for <xenomai@lists.linux.dev>;
        Fri, 19 Dec 2025 17:51:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=bGIMVOK8RNnxkIyankV6KmafA/MaeMpCoMToZw99abw=;
 b=csOEM23KnvAmrPUCJ4YDnPoJq0askBkD7Aq7Tanxxa4AtANyiCQosSqQksttLsXDBOB3k0
 5EX9CC+u6pQuA9HSfWzhMqBSVTeX+XOgbiPMp4wN7PEub4Th8lhvhP8oZsmsEyho8vyG7+So
 qEnFRp/3Cs5+7FNX+6dpKgl3NU7EnCOzfqFLRBDEk+y9XyYIr8L/wBcw0898iTvJFf3o/tfA
 kxyxGXhjJfVXGUBOtC/Dp2hRLF7xzfcUnVECHtO+qMyON0oBbKHpwfOZhPEUwyz+14rILAc4
 qUCPV9CB3ajYC4GEio3r+HWg8lLMDrbYL9xrxIMDXPhSHQ7B2YVZcaoA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 4/5] Update Isar revision
Date: Fri, 19 Dec 2025 17:51:53 +0100
Message-ID: <6481e6a0510de6aa0b5756873522cad040ef8701.1766163114.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1766163114.git.jan.kiszka@siemens.com>
References: <cover.1766163114.git.jan.kiszka@siemens.com>
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

We can now drop our two patches. But we need to add a new one again.

New Isar also comes with a new SBOM generator by default. We are not
building images intended for redistribution, and the feature requires
extra build time. So, disable it for now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...tom-support-to-add-linux-libc-dev-pa.patch | 132 ------------------
 ...-building-of-linux-libc-dev-cross-pa.patch |  35 +++++
 ...-missing-Multi-Arch-foreign-to-linux.patch |  45 ------
 kas.yaml                                      |   7 +-
 recipes-core/images/demo-image.bb             |   3 +
 recipes-kernel/linux/linux-xenomai.inc        |   4 +-
 6 files changed, 42 insertions(+), 184 deletions(-)
 delete mode 100644 isar-patches/0001-Revert-linux-custom-support-to-add-linux-libc-dev-pa.patch
 create mode 100644 isar-patches/0001-linux-kernel-Fix-building-of-linux-libc-dev-cross-pa.patch
 delete mode 100644 isar-patches/0002-linux-custom-Add-missing-Multi-Arch-foreign-to-linux.patch

diff --git a/isar-patches/0001-Revert-linux-custom-support-to-add-linux-libc-dev-pa.patch b/isar-patches/0001-Revert-linux-custom-support-to-add-linux-libc-dev-pa.patch
deleted file mode 100644
index 8bf4bc7..0000000
--- a/isar-patches/0001-Revert-linux-custom-support-to-add-linux-libc-dev-pa.patch
+++ /dev/null
@@ -1,132 +0,0 @@
-From 76b9022a69ab493e3770432b433ad1aa2363c1eb Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Wed, 10 Sep 2025 17:50:53 +0200
-Subject: [PATCH 1/2] Revert "linux-custom: support to add linux-libc-dev
- package with kernel name"
-
-This reverts commit 6cf35fc33d11f7d3feb0472a40e79dbd3ee3d759.
-
-Besides having multiple implementations flaws, the general approach
-turned out to be incompatible with Debian's dependency management: We
-cannot replace a package A with a package B which only provides A. The
-resolver will continue to prefer package A when it is requested,
-explicitly or implicitly.
-
-If a build enables multiple kernels, it is recommended to ensure at
-recipe-level that only one kernel build enables KERNEL_LIBC_DEV_DEPLOY.
-
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- RECIPE-API-CHANGELOG.md                                |  7 +++++++
- doc/custom_kernel.md                                   |  4 ++--
- meta/recipes-kernel/linux/files/debian/control.tmpl    | 10 +++-------
- .../recipes-kernel/linux/files/debian/isar/common.tmpl |  2 +-
- .../linux/files/debian/isar/install.tmpl               |  2 +-
- meta/recipes-kernel/linux/linux-custom.inc             |  2 --
- 6 files changed, 14 insertions(+), 13 deletions(-)
-
-diff --git a/RECIPE-API-CHANGELOG.md b/RECIPE-API-CHANGELOG.md
-index 8468717d..6579f2e9 100644
---- a/RECIPE-API-CHANGELOG.md
-+++ b/RECIPE-API-CHANGELOG.md
-@@ -727,3 +727,10 @@ Changes in next
- 
- This was never documented and never had practical relevance. `oci-archive` is
- the useful OCI image format that can be imported, e.g., by podman.
-+
-+### Revert enabling of linux-libc-dev package with KERNEL_NAME
-+
-+The change "Enable linux-libc-dev package with KERNEL_NAME" turned out to be
-+incompatible with how Debian selects dependencies. It is therefore necessary
-+to only enable `KERNEL_LIBC_DEV_DEPLOY` for a single kernel in case multiples
-+are configured via `KERNEL_NAMES`.
-diff --git a/doc/custom_kernel.md b/doc/custom_kernel.md
-index 2dca577c..ce5f1bf7 100644
---- a/doc/custom_kernel.md
-+++ b/doc/custom_kernel.md
-@@ -51,9 +51,9 @@ The linux-custom recipe provides support for:
- 
-     Only the `host` specific package is built automatically at cross builds.
- 
-- 10. Produce a `linux-libc-dev-${KERNEL_NAME}` package to support user-land builds
-+ 10. Produce a `linux-libc-dev` package to support user-land builds
- 
-- 11. Only build/ship the `linux-libc-dev-${KERNEL_NAME}` package if instructed to
-+ 11. Only build/ship the `linux-libc-dev` package if instructed to
-      (`KERNEL_LIBC_DEV_DEPLOY` equals to `"1"`)
- 
-  12. Support both native and cross compiles (`ISAR_CROSS_COMPILE`)
-diff --git a/meta/recipes-kernel/linux/files/debian/control.tmpl b/meta/recipes-kernel/linux/files/debian/control.tmpl
-index a79b86c4..ec0da1ab 100644
---- a/meta/recipes-kernel/linux/files/debian/control.tmpl
-+++ b/meta/recipes-kernel/linux/files/debian/control.tmpl
-@@ -22,23 +22,19 @@ Description: ${KERNEL_NAME_PROVIDED} Linux kernel headers for @KR@
-  .
-  This is useful for people who need to build external modules
- 
--Package: linux-libc-dev-${KERNEL_NAME_PROVIDED}
-+Package: linux-libc-dev
- Build-Profiles: <!nolibcdev kernel>
- Section: devel
--Conflicts: linux-libc-dev
--Provides: linux-libc-dev
--Replaces: linux-libc-dev
-+Provides: linux-kernel-headers
- Architecture: ${KERNEL_LIBC_DEV_ARCH}
- Description: Linux support headers for userspace development
-  This package provides userspaces headers from the Linux kernel. These headers
-  are used by the installed headers for GNU glibc and other system libraries.
- 
--Package: linux-libc-dev-${DISTRO_ARCH}-cross-${KERNEL_NAME_PROVIDED}
-+Package: linux-libc-dev-${DISTRO_ARCH}-cross
- Build-Profiles: <!nolibcdev cross !kbuild>
- Section: devel
--Conflicts: linux-kernel-headers-${DISTRO_ARCH}-cross
- Provides: linux-kernel-headers-${DISTRO_ARCH}-cross
--Replaces: linux-kernel-headers-${DISTRO_ARCH}-cross
- Architecture: all
- Description: Linux Kernel Headers for development (for cross-compiling)
-  This package provides headers from the Linux kernel.  These headers
-diff --git a/meta/recipes-kernel/linux/files/debian/isar/common.tmpl b/meta/recipes-kernel/linux/files/debian/isar/common.tmpl
-index b004214f..f9cc2f02 100644
---- a/meta/recipes-kernel/linux/files/debian/isar/common.tmpl
-+++ b/meta/recipes-kernel/linux/files/debian/isar/common.tmpl
-@@ -8,7 +8,7 @@ set -e
- ARCH=${KERNEL_ARCH}
- KERNEL_PKG_IMAGE=linux-image-${KERNEL_NAME_PROVIDED}
- KERNEL_PKG_KERN_HEADERS=linux-headers-${KERNEL_NAME_PROVIDED}
--KERNEL_PKG_LIBC_HEADERS=linux-libc-dev-${KERNEL_NAME_PROVIDED}
-+KERNEL_PKG_LIBC_HEADERS=linux-libc-dev
- KERNEL_PKG_LIBC_HEADERS_CROSS=linux-libc-dev-${DISTRO_ARCH}-cross
- KERNEL_PKG_KERN_KBUILD=linux-kbuild-${KERNEL_NAME_PROVIDED}
- KERNEL_PKG_KERN_KBUILD_CROSS=${KERNEL_PKG_KERN_KBUILD}-${DISTRO_ARCH}-cross
-diff --git a/meta/recipes-kernel/linux/files/debian/isar/install.tmpl b/meta/recipes-kernel/linux/files/debian/isar/install.tmpl
-index d7e711ef..fe0bd810 100644
---- a/meta/recipes-kernel/linux/files/debian/isar/install.tmpl
-+++ b/meta/recipes-kernel/linux/files/debian/isar/install.tmpl
-@@ -240,7 +240,7 @@ install_headers() {
-     if dpkg --compare-versions "${krel}" "lt" "5.4.24"; then
-         headers_check
-     fi
--    [ -z ${kern_pkgs["linux-libc-dev-${KERNEL_NAME_PROVIDED}"]} ] || libc_headers
-+    [ -z ${kern_pkgs["linux-libc-dev"]} ] || libc_headers
-     kernel_headers
- }
- 
-diff --git a/meta/recipes-kernel/linux/linux-custom.inc b/meta/recipes-kernel/linux/linux-custom.inc
-index 01e9bff7..07e49ce7 100644
---- a/meta/recipes-kernel/linux/linux-custom.inc
-+++ b/meta/recipes-kernel/linux/linux-custom.inc
-@@ -155,9 +155,7 @@ RECIPE_PROVIDES = " \
-     linux-image-${KERNEL_NAME_PROVIDED} \
-     linux-headers-${KERNEL_NAME_PROVIDED} \
-     linux-libc-dev \
--    linux-libc-dev-${KERNEL_NAME_PROVIDED} \
-     linux-libc-dev-${DISTRO_ARCH}-cross \
--    linux-libc-dev-${DISTRO_ARCH}-cross-${KERNEL_NAME_PROVIDED} \
-     linux-image-${KERNEL_NAME_PROVIDED}-dbg \
-     linux-kbuild-${KERNEL_NAME_PROVIDED} \
-     ${BPN}-pseudo-native \
--- 
-2.51.0
-
diff --git a/isar-patches/0001-linux-kernel-Fix-building-of-linux-libc-dev-cross-pa.patch b/isar-patches/0001-linux-kernel-Fix-building-of-linux-libc-dev-cross-pa.patch
new file mode 100644
index 0000000..e1d6f76
--- /dev/null
+++ b/isar-patches/0001-linux-kernel-Fix-building-of-linux-libc-dev-cross-pa.patch
@@ -0,0 +1,35 @@
+From 4e46a398718df47e7efa0256c1ac62d1262ee47c Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Thu, 18 Dec 2025 16:43:07 +0100
+Subject: [PATCH 1/3] linux-kernel: Fix building of linux-libc-dev-*-cross
+ packages
+
+The cross variant of linux-libc-dev is always built along with the
+kernel, just like the native variant. Ensure this by additionally
+enabling pkg.${BPN}.cross when :cross-profile is active.
+
+Fixes: afba99fe6aeb ("linux-custom: fix name collision on cross profile")
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ meta/classes-recipe/linux-kernel.bbclass | 5 +++--
+ 1 file changed, 3 insertions(+), 2 deletions(-)
+
+diff --git a/meta/classes-recipe/linux-kernel.bbclass b/meta/classes-recipe/linux-kernel.bbclass
+index 8f38a617..e129527e 100644
+--- a/meta/classes-recipe/linux-kernel.bbclass
++++ b/meta/classes-recipe/linux-kernel.bbclass
+@@ -125,8 +125,9 @@ BUILD_PROFILES = "pkg.${BPN}.kernel pkg.${BPN}.kbuild"
+ BBCLASSEXTEND:append:cross-profile = " kbuildtarget"
+ 
+ # When cross-profile is active:
+-# build only kernel (including config) with the default variant of the recipe
+-BUILD_PROFILES:cross-profile = "pkg.${BPN}.kernel"
++# Build kernel (including config) cross packages (linux-libc-dev-*-cross)
++# with the default variant of the recipe
++BUILD_PROFILES:cross-profile = "pkg.${BPN}.kernel pkg.${BPN}.cross"
+ 
+ # -native: kbuild package for host
+ BUILD_PROFILES:class-native = "pkg.${BPN}.kbuild"
+-- 
+2.51.0
+
diff --git a/isar-patches/0002-linux-custom-Add-missing-Multi-Arch-foreign-to-linux.patch b/isar-patches/0002-linux-custom-Add-missing-Multi-Arch-foreign-to-linux.patch
deleted file mode 100644
index 80d8331..0000000
--- a/isar-patches/0002-linux-custom-Add-missing-Multi-Arch-foreign-to-linux.patch
+++ /dev/null
@@ -1,45 +0,0 @@
-From 175a8d4917308b6654376e1095dbfd254f52d58e Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Thu, 11 Sep 2025 21:47:20 +0200
-Subject: [PATCH 2/2] linux-custom: Add missing Multi-Arch foreign to
- linux-libc-dev*
-
-This ensures that we create true drop-in replacements of the
-respective upstream packages.
-
-Fixes: 90aa31273278 ("linux-custom: generate linux-libc-dev for "all" vs "any" like trixie")
-Fixes: 13103ab84d5d ("linux-custom: Generate cross linux-libc-dev package")
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- meta/recipes-kernel/linux/files/debian/control.tmpl | 1 +
- meta/recipes-kernel/linux/linux-custom.inc          | 2 +-
- 2 files changed, 2 insertions(+), 1 deletion(-)
-
-diff --git a/meta/recipes-kernel/linux/files/debian/control.tmpl b/meta/recipes-kernel/linux/files/debian/control.tmpl
-index ec0da1ab..e2a878a9 100644
---- a/meta/recipes-kernel/linux/files/debian/control.tmpl
-+++ b/meta/recipes-kernel/linux/files/debian/control.tmpl
-@@ -36,6 +36,7 @@ Build-Profiles: <!nolibcdev cross !kbuild>
- Section: devel
- Provides: linux-kernel-headers-${DISTRO_ARCH}-cross
- Architecture: all
-+Multi-Arch: foreign
- Description: Linux Kernel Headers for development (for cross-compiling)
-  This package provides headers from the Linux kernel.  These headers
-  are used by the installed headers for GNU glibc and other system
-diff --git a/meta/recipes-kernel/linux/linux-custom.inc b/meta/recipes-kernel/linux/linux-custom.inc
-index 07e49ce7..995279d2 100644
---- a/meta/recipes-kernel/linux/linux-custom.inc
-+++ b/meta/recipes-kernel/linux/linux-custom.inc
-@@ -224,7 +224,7 @@ def get_additional_build_profiles(d):
-         profiles += ' libcdev-arch-all'
-     return profiles
- 
--KERNEL_LIBC_DEV_ARCH = "${@ bb.utils.contains('DEB_BUILD_PROFILES', 'libcdev-arch-all', 'all', 'any', d) }"
-+KERNEL_LIBC_DEV_ARCH = "${@ bb.utils.contains('DEB_BUILD_PROFILES', 'libcdev-arch-all', 'all\nMulti-Arch: foreign', 'any', d) }"
- DEB_BUILD_PROFILES += "${@get_additional_build_profiles(d)}"
- 
- do_prepare_build:prepend() {
--- 
-2.51.0
-
diff --git a/kas.yaml b/kas.yaml
index 5d66228..7aa5a83 100644
--- a/kas.yaml
+++ b/kas.yaml
@@ -22,15 +22,12 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 48a7eb4e0e9846e7e5bb44e52730d0bf59549a67
+    commit: d887bcef5084660a03776bd13028dd3fb58ce569
     layers:
       meta:
     patches:
       p1:
-        path: isar-patches/0001-Revert-linux-custom-support-to-add-linux-libc-dev-pa.patch
-        repo: xenomai
-      p2:
-        path: isar-patches/0002-linux-custom-Add-missing-Multi-Arch-foreign-to-linux.patch
+        path: isar-patches/0001-linux-kernel-Fix-building-of-linux-libc-dev-cross-pa.patch
         repo: xenomai
 
 bblayers_conf_header:
diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
index fbc4ed4..d0a1f42 100644
--- a/recipes-core/images/demo-image.bb
+++ b/recipes-core/images/demo-image.bb
@@ -51,3 +51,6 @@ IMAGE_INSTALL:append:xenomai3 = " ${@get_package_names(d)}"
 IMAGE_INSTALL:append:xenomai4 = " libevl"
 
 IMAGE_INSTALL += "customizations sshd-regen-keys expand-on-first-boot"
+
+# just a demo/test image, no need for an SBOM (which takes some extra time)
+ROOTFS_FEATURES:remove = "generate-sbom"
diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index 8c7df40..0980662 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2023
+# Copyright (c) Siemens AG, 2018-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-kernel/linux/linux-custom.inc
+inherit linux-kernel
 inherit print-revision
 
 FILESPATH =. "${LAYERDIR_xenomai}/recipes-kernel/linux/files:"
-- 
2.51.0

