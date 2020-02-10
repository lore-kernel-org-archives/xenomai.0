From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 07/10] linux-xenomai: Enable latest 4.4 build
 with Xenomai 3.0
Date: Mon, 10 Feb 2020 19:17:46 +0100
Message-Id: <ad5fe8f558b33ec0eecd932996d84cfe546a4b70.1581358669.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1581358669.git.jan.kiszka@siemens.com>
References: <cover.1581358669.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1581358669.git.jan.kiszka@siemens.com>
References: <cover.1581358669.git.jan.kiszka@siemens.com>
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

When building with Xenomai 3.0, the meaning of "latest kernel" is
different from 3.1 and head. Rather than adding some
opt-linux-latest-4.4.yml, enhance the linux-xenomai_latest recipe with
that knowledge.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 opt-linux-latest.yml                         |  2 +-
 recipes-kernel/linux/linux-xenomai.inc       |  1 +
 recipes-kernel/linux/linux-xenomai_latest.bb | 25 +++++++++++++++++--------
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/opt-linux-latest.yml b/opt-linux-latest.yml
index a55c78f..7cf291a 100644
--- a/opt-linux-latest.yml
+++ b/opt-linux-latest.yml
@@ -14,4 +14,4 @@ header:
 
 local_conf_header:
   linux-xenomai-latest: |
-    PREFERRED_VERSION_linux-xenomai = "9999-latest"
+    PREFERRED_VERSION_linux-xenomai = "9999-%"
diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index 3388776..baa353b 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -19,6 +19,7 @@ DEPENDS += "xenomai-kernel-source"
 KBUILD_DEPENDS += "xenomai-kernel-source"
 
 LINUX_COMMIT="${@bb.fetch2.get_srcrev(d).strip('AUTOINC+')}"
+
 dpkg_runbuild_prepend() {
 	case ${DISTRO_ARCH} in
 	armhf)
diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index 4aa246d..506dbdd 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -1,24 +1,33 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2020
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Jan Kiszka <jan.kiszka@siemens.com>
 #
 # SPDX-License-Identifier: MIT
 #
 
 require recipes-kernel/linux/linux-xenomai.inc
 
-PV = "9999-latest"
+PV = "9999-g${LINUX_COMMIT}"
 
-SRC_URI_append_amd64 = " git://gitlab.denx.de/Xenomai/ipipe-x86.git;protocol=https;branch=ipipe-x86-4.19.y"
-SRCREV_amd64 = "${AUTOREV}"
+def is_xeno_3_0(d):
+    xeno_ver = d.getVar('PREFERRED_VERSION_xenomai') or ''
+    return xeno_ver.startswith('3.0') or xeno_ver == 'stable-3.0.x'
 
-SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;branch=ipipe/master"
-SRCREV_arm64 = "${AUTOREV}"
+GIT_REPO_amd64 = "${@'ipipe.git' if is_xeno_3_0(d) else 'ipipe-x86.git'}"
+GIT_BRANCH_amd64 = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'ipipe-x86-4.19.y'}"
+
+GIT_REPO_armhf = "${@'ipipe.git' if is_xeno_3_0(d) else 'ipipe-arm.git'}"
+GIT_BRANCH_armhf = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'ipipe/master'}"
+
+GIT_REPO_arm64 = "ipipe-arm64.git"
+GIT_BRANCH_arm64 = "ipipe/master"
+
+SRC_URI += "git://gitlab.denx.de/Xenomai/${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
+SRCREV = "${AUTOREV}"
 
-SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;branch=ipipe/master"
-SRCREV_armhf = "${AUTOREV}"
 S = "${WORKDIR}/git"
-- 
2.16.4


