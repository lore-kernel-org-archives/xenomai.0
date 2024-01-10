Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5B3EA3
	for <xenomai@lists.linux.dev>; Wed, 10 Jan 2024 04:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="HWv0P8Vm"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202401100446031282821a9ddc8da46f
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jan 2024 05:46:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=yybP3yiLe9V8MfyrILNzPNfEJXJE9outJicM3XWvl2Q=;
 b=HWv0P8Vm4/QGTFXdIuXINY5wB2lGUFI25pD14e2VGjM/p4OlAwtEgGKGWN+sxF8zJPW7J4
 8U6AVpCaF5GYpznLxb+BcCaBc6KkEgC/3zPjnP+5xEgwfOd/msO3VTatT9QlgVwKFDJOCC/r
 APZFrDyERlwrz/G6Z4t3360oTEmtU=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH v3 06/10] xenomai-4: Enable kernel build
Date: Wed, 10 Jan 2024 05:45:58 +0100
Message-Id: <3e7db3bf53e46be24d99f602932febd8c0eaf05c.1704861962.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1704861962.git.jan.kiszka@siemens.com>
References: <cover.1704861962.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Clara Kowalsky <clara.kowalsky@siemens.com>

This permits to build the linux-evl kernel v6.1 and v6.6.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
[Jan: added latest recipe, renamed cfg file]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 opt-linux-latest-6.1.yml                      |  1 +
 opt-linux-latest-6.6.yml                      |  1 +
 recipes-kernel/linux/files/evl.cfg            |  3 ++
 recipes-kernel/linux/linux-xenomai-4-evl.inc  | 16 +++++++++
 recipes-kernel/linux/linux-xenomai-4.inc      | 16 +++++++++
 recipes-kernel/linux/linux-xenomai-4_6.1.bb   | 14 ++++++++
 recipes-kernel/linux/linux-xenomai-4_6.6.bb   | 14 ++++++++
 .../linux/linux-xenomai-4_latest.bb           | 35 +++++++++++++++++++
 8 files changed, 100 insertions(+)
 create mode 100644 recipes-kernel/linux/files/evl.cfg
 create mode 100644 recipes-kernel/linux/linux-xenomai-4-evl.inc
 create mode 100644 recipes-kernel/linux/linux-xenomai-4.inc
 create mode 100644 recipes-kernel/linux/linux-xenomai-4_6.1.bb
 create mode 100644 recipes-kernel/linux/linux-xenomai-4_6.6.bb
 create mode 100644 recipes-kernel/linux/linux-xenomai-4_latest.bb

diff --git a/opt-linux-latest-6.1.yml b/opt-linux-latest-6.1.yml
index 388f116..632a38a 100644
--- a/opt-linux-latest-6.1.yml
+++ b/opt-linux-latest-6.1.yml
@@ -15,4 +15,5 @@ header:
 local_conf_header:
   linux-xenomai-version: |
     PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
+    PREFERRED_VERSION_linux-xenomai-4 = "9999-%"
     LATEST_GIT_BRANCH = "6.1"
diff --git a/opt-linux-latest-6.6.yml b/opt-linux-latest-6.6.yml
index 2287d4b..a17e78b 100644
--- a/opt-linux-latest-6.6.yml
+++ b/opt-linux-latest-6.6.yml
@@ -15,4 +15,5 @@ header:
 local_conf_header:
   linux-xenomai-version: |
     PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
+    PREFERRED_VERSION_linux-xenomai-4 = "9999-%"
     LATEST_GIT_BRANCH = "6.6"
diff --git a/recipes-kernel/linux/files/evl.cfg b/recipes-kernel/linux/files/evl.cfg
new file mode 100644
index 0000000..65d9b33
--- /dev/null
+++ b/recipes-kernel/linux/files/evl.cfg
@@ -0,0 +1,3 @@
+CONFIG_EVL=y
+CONFIG_EVL_SCHED_QUOTA=y
+CONFIG_EVL_SCHED_TP=y
diff --git a/recipes-kernel/linux/linux-xenomai-4-evl.inc b/recipes-kernel/linux/linux-xenomai-4-evl.inc
new file mode 100644
index 0000000..b13d203
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai-4-evl.inc
@@ -0,0 +1,16 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-kernel/linux/linux-xenomai-4.inc
+
+SRC_URI += "git://source.denx.de/Xenomai/xenomai4/linux-evl.git;protocol=https;nobranch=1"
+
+PV ?= "${@d.getVar('SRCREV').strip('-')[0].lstrip('v')}+"
diff --git a/recipes-kernel/linux/linux-xenomai-4.inc b/recipes-kernel/linux/linux-xenomai-4.inc
new file mode 100644
index 0000000..7827978
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai-4.inc
@@ -0,0 +1,16 @@
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
+SRC_URI += "file://evl.cfg"
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.1.bb b/recipes-kernel/linux/linux-xenomai-4_6.1.bb
new file mode 100644
index 0000000..a037e4c
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai-4_6.1.bb
@@ -0,0 +1,14 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2023-2024
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-kernel/linux/linux-xenomai-4-evl.inc
+
+SRCREV ?= "v6.1.61-evl2-rebase"
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.6.bb b/recipes-kernel/linux/linux-xenomai-4_6.6.bb
new file mode 100644
index 0000000..f499bd0
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai-4_6.6.bb
@@ -0,0 +1,14 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2023-2024
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-kernel/linux/linux-xenomai-4-evl.inc
+
+SRCREV ?= "v6.6-evl2-rebase"
diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
new file mode 100644
index 0000000..c225034
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
@@ -0,0 +1,35 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-kernel/linux/linux-xenomai-4.inc
+
+PV = "9999-g${COMMIT}"
+
+python () {
+    import subprocess
+    if is_kernel(d, 'latest'):
+        cmd = 'git ls-remote --tags --head --refs https://source.denx.de/Xenomai/xenomai4/linux-evl.git | ' \
+              'sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | ' \
+              'grep "v6\.[0-9].*-evl-rebase" | ' \
+              'sort -r -n -k 1.4 | head -1'
+        (ret, out) = subprocess.getstatusoutput(cmd)
+        d.setVar('LATEST_KERNEL_BRANCH', out)
+    else:
+        d.setVar('LATEST_KERNEL_BRANCH', 'v6.6.y-evl-rebase')
+}
+
+GIT_BRANCH = "${@ \
+    'v6.1.y-evl-rebase' if is_kernel(d, '6.1') \
+    else 'v6.6.y-evl-rebase' if is_kernel(d, '6.6') \
+    else d.getVar('LATEST_KERNEL_BRANCH') }"
+
+SRC_URI += "git://source.denx.de/Xenomai/xenomai4/linux-evl.git;protocol=https;branch=${GIT_BRANCH}"
+SRCREV = "${AUTOREV}"
-- 
2.35.3

