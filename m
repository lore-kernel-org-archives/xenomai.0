Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B1D3FB1E
	for <xenomai@lists.linux.dev>; Thu, 28 Sep 2023 15:32:58 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230928153249abb3f9e8ae3706e014
        for <xenomai@lists.linux.dev>;
        Thu, 28 Sep 2023 17:32:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Ei/zpymntZm5Onok3iIReXETNULM+dQ5PcO7K+4CfLw=;
 b=O/K3abHLtv8Eam6ykhQPU3u7hagCxV+Wefipq+5m8vpiuus+siuityidy5u3Esa3Gj9Vqe
 tYMdS/IupF3bcR5S5btaN3LMDXsxFoJnYIlW6IdGFGUCp57y7mgdQUyD9mbLKFa7NcJyUa2D
 tcVlxWsVQclZ5etFfJCNXELDP+Nik=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 4/4] Update Isar revision
Date: Thu, 28 Sep 2023 17:32:48 +0200
Message-Id: <3f1040095513514d822a8db109d7bde87df48d75.1695915167.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1695915167.git.jan.kiszka@siemens.com>
References: <cover.1695915167.git.jan.kiszka@siemens.com>
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

No adjustments needed on our side, just one Isar fix for an upstream
regression.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...es-Fix-image-tarball-by-removing-fir.patch | 51 +++++++++++++++++++
 kas.yml                                       |  6 ++-
 2 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 isar-patches/0001-classes-imagetypes-Fix-image-tarball-by-removing-fir.patch

diff --git a/isar-patches/0001-classes-imagetypes-Fix-image-tarball-by-removing-fir.patch b/isar-patches/0001-classes-imagetypes-Fix-image-tarball-by-removing-fir.patch
new file mode 100644
index 0000000..c1e0782
--- /dev/null
+++ b/isar-patches/0001-classes-imagetypes-Fix-image-tarball-by-removing-fir.patch
@@ -0,0 +1,51 @@
+From d8969e01e6be7d933f2e259a9e5bbe521636d623 Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Tue, 26 Sep 2023 18:21:54 +0200
+Subject: [PATCH] classes/imagetypes: Fix image tarball by removing first level
+ directory
+
+Commit be7f0f('meta/classes/sdk.bbclass: add --transform in TAR_OPTIONS')
+broke the usage of rootfs tarballs directly, e.g. as NFS root in LAVA,
+by adding rootfs as the first level directory.
+
+The patch adds the variable TAR_TRANSFORM to adjust the tarball structure
+as necessary. The default replaces `rootfs` with `.` which restores the old
+layout in the tarball.
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ meta/classes/imagetypes.bbclass | 4 ++--
+ meta/classes/sdk.bbclass        | 2 +-
+ 2 files changed, 3 insertions(+), 3 deletions(-)
+
+diff --git a/meta/classes/imagetypes.bbclass b/meta/classes/imagetypes.bbclass
+index 6b612386..a3be0a1d 100644
+--- a/meta/classes/imagetypes.bbclass
++++ b/meta/classes/imagetypes.bbclass
+@@ -5,8 +5,8 @@
+ 
+ #image type: tar
+ IMAGER_INSTALL:tar = "tar"
+-TAR_OPTIONS ?= ""
+-
++TAR_TRANSFORM = "--transform='s|rootfs|.|'"
++TAR_OPTIONS:append = " ${TAR_TRANSFORM}"
+ IMAGE_CMD:tar() {
+     ${SUDO_CHROOT} tar ${TAR_OPTIONS} -cvSf \
+                  ${IMAGE_FILE_CHROOT} --one-file-system -C ${PP} rootfs
+diff --git a/meta/classes/sdk.bbclass b/meta/classes/sdk.bbclass
+index 3d650a18..216213ac 100644
+--- a/meta/classes/sdk.bbclass
++++ b/meta/classes/sdk.bbclass
+@@ -53,7 +53,7 @@ ROOTFS_MANIFEST_DEPLOY_DIR:class-sdk = "${DEPLOY_DIR_SDKCHROOT}"
+ ROOTFS_DPKGSTATUS_DEPLOY_DIR:class-sdk = "${DEPLOY_DIR_SDKCHROOT}"
+ 
+ IMAGE_FSTYPES:class-sdk = "${SDK_FORMATS}"
+-TAR_OPTIONS:append:class-sdk = " --transform="s|rootfs|${IMAGE_FULLNAME}|""
++TAR_TRANSFORM:class-sdk = " --transform='s|rootfs|${IMAGE_FULLNAME}|'"
+ 
+ # bitbake dependencies
+ SDKDEPENDS += "sdk-files ${SDK_INSTALL}"
+-- 
+2.35.3
+
diff --git a/kas.yml b/kas.yml
index 26ea415..69d4265 100644
--- a/kas.yml
+++ b/kas.yml
@@ -22,9 +22,13 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 4de8b0d5d68ad46829fa1360eabcf3fc8662a39e
+    commit: 670bf5ce31000f24e2ab6cefa7c20a87a2d3879f
     layers:
       meta:
+    patches:
+      tar-revert:
+        repo: xenomai
+        path: isar-patches/0001-classes-imagetypes-Fix-image-tarball-by-removing-fir.patch 
 
 bblayers_conf_header:
   standard: |
-- 
2.35.3

