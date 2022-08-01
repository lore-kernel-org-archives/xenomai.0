Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E705429A2
	for <xenomai@lists.linux.dev>; Mon,  1 Aug 2022 13:47:49 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay.mail.gandi.net (Postfix) with ESMTPS id A0DFC20004
	for <xenomai@lists.linux.dev>; Mon,  1 Aug 2022 13:47:41 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 67D61AC0AAD
	for <xenomai@xenomai.org>; Mon,  1 Aug 2022 13:47:40 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20220801134739884485051840b2962b
        for <xenomai@xenomai.org>;
        Mon, 01 Aug 2022 15:47:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ioEVZrYL8xZDHG5iZZMZn9VzpaZ3K6zslkDSW+T6AWI=;
 b=CLst8RoDnsA9V/JX1w7/RzFce7OZ6OCFxyX1oC0+7OdJVAbPobv1qhZHcUu6kWmGRldtb0
 7F8z1sYfQ/fbxxXlvkIbFCqnNeQUU4m5moGELm3zFfhZwPLJQ6slHYl+NwSQkp0qPmY1Pqx7
 L4aQTordLy1pbPKmsm36SY2gRoFQA=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [xenomai-images][PATCH 4/4] Add option to build latest kernel version
Date: Mon,  1 Aug 2022 15:47:37 +0200
Message-Id: <4575c20c613cf58e490e704ffdfb3167bbb2d05c.1659361657.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1659361657.git.jan.kiszka@siemens.com>
References: <cover.1659361657.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool3: domain of rts-flowmailer.siemens.com designates 185.136.64.225 as permitted sender) client-ip=185.136.64.225; envelope-from=fm-294854-20220801134739884485051840b2962b-V7iwwY@rts-flowmailer.siemens.com; helo=mta-64-225.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm2 header.b=CLst8RoD;
	dmarc=pass (policy=none) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20220801134739884485051840b2962b-V7iwwY@rts-flowmailer.siemens.com designates 185.136.64.225 as permitted sender) smtp.mailfrom=fm-294854-20220801134739884485051840b2962b-V7iwwY@rts-flowmailer.siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

This is currently 5.19-dovetail. Permits to enable and test Xenomai
early against newer kernels. Official support will remain focused on
LTS kernels, though.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                      |  5 +++++
 opt-linux-latest.yml                         | 18 ++++++++++++++++++
 recipes-kernel/linux/linux-xenomai_latest.bb | 20 +++++++++++++++++---
 3 files changed, 40 insertions(+), 3 deletions(-)
 create mode 100644 opt-linux-latest.yml

diff --git a/Kconfig b/Kconfig
index af10be1..1e3371e 100644
--- a/Kconfig
+++ b/Kconfig
@@ -89,6 +89,10 @@ choice
 	prompt "Kernel version"
 	default KERNEL_5_10
 
+config KERNEL_LATEST
+	bool "Head of latest Dovetail branch"
+	depends on XENOMAI_LATEST
+
 config KERNEL_5_15_LATEST
 	bool "Head of 5.15 Dovetail branch"
 	depends on XENOMAI_LATEST
@@ -133,6 +137,7 @@ endchoice
 
 config KAS_INCLUDE_KERNEL
 	string
+	default "opt-linux-latest.yml" if KERNEL_LATEST
 	default "opt-linux-latest-5.15.yml" if KERNEL_5_15_LATEST
 	default "opt-linux-5.15.yml" if KERNEL_5_15
 	default "opt-linux-latest-5.10.yml" if KERNEL_5_10_LATEST
diff --git a/opt-linux-latest.yml b/opt-linux-latest.yml
new file mode 100644
index 0000000..4f4dd3b
--- /dev/null
+++ b/opt-linux-latest.yml
@@ -0,0 +1,18 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 10
+
+local_conf_header:
+  linux-xenomai-version: |
+    PREFERRED_VERSION_linux-xenomai = "9999-%"
+    LATEST_GIT_BRANCH = "latest"
diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index 4117113..9c6fdaa 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -22,6 +22,17 @@ def is_kernel(d, ver):
     linux_ver = d.getVar('LATEST_GIT_BRANCH') or ''
     return linux_ver == ver
 
+python () {
+    import subprocess
+    if is_kernel(d, 'latest'):
+        cmd = 'git ls-remote --tags --head --refs https://source.denx.de/xenomai/linux-dovetail.git | ' \
+              'sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | ' \
+              'grep "v5\.[0-9][0-9].*-dovetail-rebase" | ' \
+              'sort -r -n -t - -k 5 -k 6 | head -1'
+        (ret, out) = subprocess.getstatusoutput(cmd)
+        d.setVar('LATEST_KERNEL_BRANCH', out)
+}
+
 # default: amd64 or i386
 GIT_REPO = "${@ \
     'git://github.com/xenomai-ci/ipipe.git' if is_xeno_3_0(d) \
@@ -32,7 +43,8 @@ GIT_BRANCH = "${@ \
     else 'ipipe-x86-4.19.y-cip' if is_kernel(d, '4.19') \
     else 'ipipe-x86-5.4.y' if is_kernel(d, '5.4') \
     else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') \
-    else 'v5.15.y-dovetail-rebase' }"
+    else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
+    else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 GIT_REPO_armhf = "${@ \
     'git://github.com/xenomai-ci/ipipe.git' if is_xeno_3_0(d) \
@@ -43,7 +55,8 @@ GIT_BRANCH_armhf = "${@ \
     else 'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
     else 'ipipe/5.4.y' if is_kernel(d, '5.4') \
     else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') \
-    else 'v5.15.y-dovetail-rebase' }"
+    else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
+    else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 GIT_REPO_arm64 = "${@ \
     'git://github.com/xenomai-ci/ipipe-arm64.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
@@ -52,7 +65,8 @@ GIT_BRANCH_arm64 = "${@ \
     'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
     else 'ipipe/5.4.y' if is_kernel(d, '5.4') \
     else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') \
-    else 'v5.15.y-dovetail-rebase' }"
+    else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
+    else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 SRC_URI += "${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
 SRCREV = "${AUTOREV}"
-- 
2.35.3

