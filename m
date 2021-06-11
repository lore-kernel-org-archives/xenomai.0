From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 4/5] linux-xenomai: Add support for 5.10 to
 latest recipe
Date: Fri, 11 Jun 2021 22:13:11 +0200
Message-Id: <2b000ccfc7c4e8ee8ded825339a4a89ca8413dd5.1623442392.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1623442392.git.jan.kiszka@siemens.com>
References: <cover.1623442392.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Add a corresponding kas option file as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 opt-linux-latest-5.10.yml                    | 18 ++++++++++++++++++
 recipes-kernel/linux/linux-xenomai_latest.bb | 20 ++++++++++----------
 2 files changed, 28 insertions(+), 10 deletions(-)
 create mode 100644 opt-linux-latest-5.10.yml

diff --git a/opt-linux-latest-5.10.yml b/opt-linux-latest-5.10.yml
new file mode 100644
index 0000000..89530b8
--- /dev/null
+++ b/opt-linux-latest-5.10.yml
@@ -0,0 +1,18 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2021
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
+  linux-xenomai-latest: |
+    PREFERRED_VERSION_linux-xenomai = "9999-%"
+    LATEST_GIT_BRANCH = "5.10"
diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index 91b4743..09df461 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019-2020
+# Copyright (c) Siemens AG, 2019-2021
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -18,20 +18,20 @@ def is_xeno_3_0(d):
     xeno_ver = d.getVar('PREFERRED_VERSION_xenomai') or ''
     return xeno_ver.startswith('3.0') or xeno_ver == 'stable-3.0.x'
 
-def is_5_4_branch(d):
+def is_kernel(d, ver):
     linux_ver = d.getVar('LATEST_GIT_BRANCH') or ''
-    return linux_ver.startswith('5.4')
+    return linux_ver.startswith(ver)
 
-GIT_REPO_amd64 = "${@'ipipe.git' if is_xeno_3_0(d) else 'ipipe-x86.git'}"
-GIT_BRANCH_amd64 = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'ipipe-x86-5.4.y' if is_5_4_branch(d) else 'ipipe-x86-4.19.y-cip'}"
+GIT_REPO_amd64 = "${@'git://github.com/xenomai-ci/ipipe.git' if is_xeno_3_0(d) else 'git://source.denx.de/xenomai/linux-dovetail.git' if is_kernel(d, '5.10') else 'git://github.com/xenomai-ci/ipipe-x86.git'}"
+GIT_BRANCH_amd64 = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') else 'ipipe-x86-5.4.y' if is_kernel(d, '5.4') else 'ipipe-x86-4.19.y-cip'}"
 
-GIT_REPO_armhf = "${@'ipipe.git' if is_xeno_3_0(d) else 'ipipe-arm.git'}"
-GIT_BRANCH_armhf = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'ipipe/5.4.y' if is_5_4_branch(d) else 'ipipe/4.19.y-cip'}"
+GIT_REPO_armhf = "${@'git://github.com/xenomai-ci/ipipe.git' if is_xeno_3_0(d) else 'git://source.denx.de/xenomai/linux-dovetail.git' if is_kernel(d, '5.10') else 'git://github.com/xenomai-ci/ipipe-arm.git'}"
+GIT_BRANCH_armhf = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') else 'ipipe/5.4.y' if is_kernel(d, '5.4') else 'ipipe/4.19.y-cip'}"
 
-GIT_REPO_arm64 = "ipipe-arm64.git"
-GIT_BRANCH_arm64 = "${@'ipipe/5.4.y' if is_5_4_branch(d) else 'ipipe/4.19.y-cip'}"
+GIT_REPO_arm64 = "${@'git://source.denx.de/xenomai/linux-dovetail.git' if is_kernel(d, '5.10') else 'git://github.com/xenomai-ci/ipipe-arm64.git'}"
+GIT_BRANCH_arm64 = "${@'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') else 'ipipe/5.4.y' if is_kernel(d, '5.4') else 'ipipe/4.19.y-cip'}"
 
-SRC_URI += "git://github.com/xenomai-ci/${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
+SRC_URI += "${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
 SRCREV = "${AUTOREV}"
 
 S = "${WORKDIR}/git"
-- 
2.26.2


