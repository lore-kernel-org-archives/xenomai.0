Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4686250E3
	for <xenomai@lists.linux.dev>; Fri, 15 Dec 2023 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="PdqAkJE4"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2023121511433052cff6a5d112ab009b
        for <xenomai@lists.linux.dev>;
        Fri, 15 Dec 2023 12:43:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=TS/AQ9ll6bHrQnhVcKkGHMNvJGBCnyBpSuPL7U4no54=;
 b=PdqAkJE4qPd9yV++RndC4sLZNAWm/5R9elisbhJZs8Qghwfp0XSY3W1liebUJZ+Cqa5/r3
 u4/W1qfadLZySPUFHEVY16Vpf9B6wZpq81MHdv+VRqOCPusY3IcAqheS3BoGIZjd0Bg54bN4
 bgK9fHdTBrRpQPAAq/zWgy+7dOAjY=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [libevl][PATCH v1] build: Add debian multiarch support
Date: Fri, 15 Dec 2023 12:42:52 +0100
Message-Id: <20231215114252.2913765-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

In view of introducing the possibility to generate evl images with
xenomai-images, multiarch support for Debian is added to libevl.

The multi-arch variable can be specified in xenomai-images in the 
debian rules file, e.g.:

override_dh_auto_configure:
        dh_auto_configure -- \
                -Ddeb_host_multiarch=$(shell dpkg-architecture -q \
                DEB_HOST_MULTIARCH)

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 include/meson.build | 2 ++
 meson/setup-uapi.sh | 3 ++-
 meson_options.txt   | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/meson.build b/include/meson.build
index c7c4860..0019ae5 100644
--- a/include/meson.build
+++ b/include/meson.build
@@ -1,10 +1,12 @@
 # SPDX-License-Identifier: MIT
 
 uapi_opt = get_option('uapi')
+deb_host_multiarch_opt = get_option('deb_host_multiarch')
 o_dir = meson.current_build_dir()
 uapi_env = environment()
 uapi_env.set('ARCH', libevl_arch)
 uapi_env.set('UAPI', uapi_opt)
+uapi_env.set('DEB_HOST_MULTIARCH', deb_host_multiarch_opt)
 uapi_env.set('OUTPUT_DIR', o_dir)
 run_command(libevl_scripts / 'setup-uapi.sh',
     check : true,
diff --git a/meson/setup-uapi.sh b/meson/setup-uapi.sh
index f2d0774..fe37469 100644
--- a/meson/setup-uapi.sh
+++ b/meson/setup-uapi.sh
@@ -2,6 +2,7 @@
 
 # Expand anything in the UAPI path meson did not (e.g. ~).
 UAPI=$(eval echo $UAPI)
+DEB_HOST_MULTIARCH=$(eval echo $DEB_HOST_MULTIARCH)
 
 link_dir() {
     if test \! -d $1; then
@@ -18,6 +19,6 @@ if test -r $UAPI/Kbuild; then
     link_dir $UAPI/include/uapi/asm-generic .
 else
     link_dir $UAPI/evl .
-    link_dir $UAPI/asm/evl asm
+    link_dir $UAPI/$DEB_HOST_MULTIARCH/asm/evl asm
     link_dir $UAPI/asm-generic .
 fi
diff --git a/meson_options.txt b/meson_options.txt
index b4d43eb..4075a31 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -1 +1,2 @@
 option('uapi', type : 'string', value : '/usr/include', description : 'path to kernel UAPI headers')
+option('deb_host_multiarch', type : 'string', value : '', description : 'Debian multiarch path')
-- 
2.39.2

