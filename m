Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9641FB2
	for <xenomai@lists.linux.dev>; Mon, 13 Feb 2023 07:11:29 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2023021307011803c50e75de125d0c35
        for <xenomai@lists.linux.dev>;
        Mon, 13 Feb 2023 08:01:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=wjXoXPGzY1fFzUNrkVJvNLMngtya4RfdD78tssVTYcM=;
 b=eyh1e4kwrd550HLjjMw7gUSn0baO8MUxFeOqJ6rMaKH16L0Q/p7m/fEFaZ5GsNq8J5fVmE
 3NxKg5hQ1BdT/VYysqeb5SPXcFv/1V/ihv3jBnkqWGgx1r+w7JZPjpnpfkEKrj5YFvNiK15L
 bQZ74auvAMdvLWpt181GyZX4z/Q84=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 3/7] Add kernel 6.1 recipe and kas files
Date: Mon, 13 Feb 2023 08:01:12 +0100
Message-Id: <7fdfcbe38c3f05a13f80268998b320427d3457ee.1676271676.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1676271676.git.jan.kiszka@siemens.com>
References: <cover.1676271676.git.jan.kiszka@siemens.com>
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

Allows to build against v6.1.y-dovetail[-rebase] with xenomai-next.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                      | 10 ++++++++++
 opt-linux-6.1.yml                            | 17 +++++++++++++++++
 opt-linux-latest-6.1.yml                     | 18 ++++++++++++++++++
 recipes-kernel/linux/linux-xenomai_6.1.bb    | 14 ++++++++++++++
 recipes-kernel/linux/linux-xenomai_latest.bb |  5 ++++-
 5 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 opt-linux-6.1.yml
 create mode 100644 opt-linux-latest-6.1.yml
 create mode 100644 recipes-kernel/linux/linux-xenomai_6.1.bb

diff --git a/Kconfig b/Kconfig
index 25e6d8c..b49e22d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -93,6 +93,14 @@ config KERNEL_LATEST
 	bool "Head of latest Dovetail branch"
 	depends on XENOMAI_LATEST
 
+config KERNEL_6_1_LATEST
+	bool "Head of 6.1 Dovetail branch"
+	depends on XENOMAI_LATEST
+
+config KERNEL_6_1
+	bool "Latest 6.1 Dovetail version"
+	depends on XENOMAI_LATEST
+
 config KERNEL_5_15_LATEST
 	bool "Head of 5.15 Dovetail branch"
 	depends on XENOMAI_LATEST
@@ -138,6 +146,8 @@ endchoice
 config KAS_INCLUDE_KERNEL
 	string
 	default "opt-linux-latest.yml" if KERNEL_LATEST
+	default "opt-linux-latest-6.1.yml" if KERNEL_6_1_LATEST
+	default "opt-linux-6.1.yml" if KERNEL_6_1
 	default "opt-linux-latest-5.15.yml" if KERNEL_5_15_LATEST
 	default "opt-linux-5.15.yml" if KERNEL_5_15
 	default "opt-linux-latest-5.10.yml" if KERNEL_5_10_LATEST
diff --git a/opt-linux-6.1.yml b/opt-linux-6.1.yml
new file mode 100644
index 0000000..fb0df24
--- /dev/null
+++ b/opt-linux-6.1.yml
@@ -0,0 +1,17 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2023
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
+    PREFERRED_VERSION_linux-xenomai = "6.1%"
diff --git a/opt-linux-latest-6.1.yml b/opt-linux-latest-6.1.yml
new file mode 100644
index 0000000..c5eecd8
--- /dev/null
+++ b/opt-linux-latest-6.1.yml
@@ -0,0 +1,18 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2023
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
+    LATEST_GIT_BRANCH = "6.1"
diff --git a/recipes-kernel/linux/linux-xenomai_6.1.bb b/recipes-kernel/linux/linux-xenomai_6.1.bb
new file mode 100644
index 0000000..d9655e0
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai_6.1.bb
@@ -0,0 +1,14 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2021-2023
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-kernel/linux/linux-xenomai-dovetail.inc
+
+SRCREV ?= "v6.1.11-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index 6804391..682e973 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019-2021
+# Copyright (c) Siemens AG, 2019-2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -44,6 +44,7 @@ GIT_BRANCH = "${@ \
     else 'ipipe-x86-5.4.y' if is_kernel(d, '5.4') \
     else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
+    else 'v6.1.y-dovetail-rebase' if is_kernel(d, '6.1') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 GIT_REPO_armhf = "${@ \
@@ -56,6 +57,7 @@ GIT_BRANCH_armhf = "${@ \
     else 'ipipe/5.4.y' if is_kernel(d, '5.4') \
     else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
+    else 'v6.1.y-dovetail-rebase' if is_kernel(d, '6.1') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 GIT_REPO_arm64 = "${@ \
@@ -66,6 +68,7 @@ GIT_BRANCH_arm64 = "${@ \
     else 'ipipe/5.4.y' if is_kernel(d, '5.4') \
     else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
+    else 'v6.1.y-dovetail-rebase' if is_kernel(d, '6.1') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 SRC_URI += "${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
-- 
2.35.3

