Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC78E55E79
	for <xenomai@lists.linux.dev>; Thu, 21 Dec 2023 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="LR8w5wQU"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20231221163827504ce2254b75931688
        for <xenomai@lists.linux.dev>;
        Thu, 21 Dec 2023 17:38:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9QRAhllQVF/8g5JFsmB1nk0R3QT01TFXWFJCh7tL4kU=;
 b=LR8w5wQUg1n1BlGDCWxeR6aw3Qo46MJACcC/vimM3+dcmpj0o7FSYaoW+qqbQ0h+uiuR6G
 uQpMhr/8qvRG8wmIPZKHsn3pOWnLguNPCIqBe7GW4UCd1U8NX42MBeJ+beN8K3ItMkSp0e72
 klpTh1c4C8IRp21cwi1B1SpQ/Q0aY=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v2 3/7] xenomai-4: Enable kernel build
Date: Thu, 21 Dec 2023 17:37:39 +0100
Message-Id: <20231221163743.2923801-4-clara.kowalsky@siemens.com>
In-Reply-To: <20231221163743.2923801-1-clara.kowalsky@siemens.com>
References: <20231221163743.2923801-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

This permits to build the linux-evl kernel v6.1 and v6.6.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 conf/distro/xenomai-demo.conf               |  1 +
 opt-xen4-linux-latest-6.1.yml               | 18 ++++++++++++++++
 opt-xen4-linux-latest-6.6.yml               | 18 ++++++++++++++++
 recipes-kernel/linux/files/xen4.cfg         |  3 +++
 recipes-kernel/linux/linux-xenomai-4.inc    | 24 +++++++++++++++++++++
 recipes-kernel/linux/linux-xenomai-4_6.1.bb | 14 ++++++++++++
 recipes-kernel/linux/linux-xenomai-4_6.6.bb | 14 ++++++++++++
 7 files changed, 92 insertions(+)
 create mode 100644 opt-xen4-linux-latest-6.1.yml
 create mode 100644 opt-xen4-linux-latest-6.6.yml
 create mode 100644 recipes-kernel/linux/files/xen4.cfg
 create mode 100644 recipes-kernel/linux/linux-xenomai-4.inc
 create mode 100644 recipes-kernel/linux/linux-xenomai-4_6.1.bb
 create mode 100644 recipes-kernel/linux/linux-xenomai-4_6.6.bb

diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
index d96cdaf..db5a5df 100644
--- a/conf/distro/xenomai-demo.conf
+++ b/conf/distro/xenomai-demo.conf
@@ -17,6 +17,7 @@ include conf/distro/include/xenomai-version.inc
 HOST_DISTRO ?= "debian-bookworm"
 
 KERNEL_NAME:xenomai3 = "xenomai-3"
+KERNEL_NAME:xenomai4 = "xenomai-4"
 
 WKS_FILE = "${MACHINE}.wks"
 
diff --git a/opt-xen4-linux-latest-6.1.yml b/opt-xen4-linux-latest-6.1.yml
new file mode 100644
index 0000000..a71cf92
--- /dev/null
+++ b/opt-xen4-linux-latest-6.1.yml
@@ -0,0 +1,18 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 10
+
+local_conf_header:
+  linux-xenomai-version: |
+    PREFERRED_VERSION_linux-xenomai-4 = "6.1"
+    LATEST_GIT_BRANCH = "6.1"
diff --git a/opt-xen4-linux-latest-6.6.yml b/opt-xen4-linux-latest-6.6.yml
new file mode 100644
index 0000000..5710222
--- /dev/null
+++ b/opt-xen4-linux-latest-6.6.yml
@@ -0,0 +1,18 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 10
+
+local_conf_header:
+  linux-xenomai-version: |
+    PREFERRED_VERSION_linux-xenomai-4 = "6.6"
+    LATEST_GIT_BRANCH = "6.6"
diff --git a/recipes-kernel/linux/files/xen4.cfg b/recipes-kernel/linux/files/xen4.cfg
new file mode 100644
index 0000000..0460249
--- /dev/null
+++ b/recipes-kernel/linux/files/xen4.cfg
@@ -0,0 +1,3 @@
+CONFIG_EVL=y
+CONFIG_EVL_SCHED_QUOTA=y
+CONFIG_EVL_SCHED_TP=y
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-xenomai-4.inc b/recipes-kernel/linux/linux-xenomai-4.inc
new file mode 100644
index 0000000..d91d618
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai-4.inc
@@ -0,0 +1,24 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2018-2023
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-kernel/linux/linux-xenomai.inc
+
+KERNEL_LIBC_DEV_DEPLOY = "1"
+
+SRC_URI += "file://xen4.cfg"
+
+SRC_URI += "git://source.denx.de/Xenomai/xenomai4/linux-evl.git;protocol=https;nobranch=1"
+PV ?= "${@d.getVar('SRCREV').strip('-')[0].lstrip('v')}+"
+
+dpkg_runbuild:prepend() {
+    bbplain $(printf "linux-xenomai-4-%s: Building revision %.20s\n" \
+                     ${PV} ${LINUX_COMMIT})
+}
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.1.bb b/recipes-kernel/linux/linux-xenomai-4_6.1.bb
new file mode 100644
index 0000000..89683dc
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai-4_6.1.bb
@@ -0,0 +1,14 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2021-2023
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-kernel/linux/linux-xenomai-4.inc
+
+SRCREV ?= "v6.1.y-evl-rebase"
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.6.bb b/recipes-kernel/linux/linux-xenomai-4_6.6.bb
new file mode 100644
index 0000000..0ce145e
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai-4_6.6.bb
@@ -0,0 +1,14 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2021-2023
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-kernel/linux/linux-xenomai-4.inc
+
+SRCREV ?= "v6.6-evl-rebase"
-- 
2.39.2

