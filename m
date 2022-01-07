From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH v3 5/5] linux-xenomai: Refactor latest recipe
Date: Fri, 7 Jan 2022 13:01:02 +0100
Message-ID: <325a74f29dbc873738930925b76f484b4f3c56c3.1641556862.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1641556862.git.jan.kiszka@siemens.com>
References: <cover.1641556862.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Prepare for adding more dovetail kernel version and reformat the lengthy
GIT_REPO and GIT_BRANCH inline-python statements. Should also improve
readability.

is_kernel() does not have to use startswith because we always compare
exact version strings.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai_latest.bb | 37 +++++++++++++++-----
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index 05946f7..bc5379e 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -20,17 +20,36 @@ def is_xeno_3_0(d):
 
 def is_kernel(d, ver):
     linux_ver = d.getVar('LATEST_GIT_BRANCH') or ''
-    return linux_ver.startswith(ver)
+    return linux_ver == ver
 
 # default: amd64 or i386
-GIT_REPO = "${@'git://github.com/xenomai-ci/ipipe.git' if is_xeno_3_0(d) else 'git://source.denx.de/xenomai/linux-dovetail.git' if is_kernel(d, '5.10') else 'git://github.com/xenomai-ci/ipipe-x86.git'}"
-GIT_BRANCH = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') else 'ipipe-x86-5.4.y' if is_kernel(d, '5.4') else 'ipipe-x86-4.19.y-cip'}"
-
-GIT_REPO_armhf = "${@'git://github.com/xenomai-ci/ipipe.git' if is_xeno_3_0(d) else 'git://source.denx.de/xenomai/linux-dovetail.git' if is_kernel(d, '5.10') else 'git://github.com/xenomai-ci/ipipe-arm.git'}"
-GIT_BRANCH_armhf = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') else 'ipipe/5.4.y' if is_kernel(d, '5.4') else 'ipipe/4.19.y-cip'}"
-
-GIT_REPO_arm64 = "${@'git://source.denx.de/xenomai/linux-dovetail.git' if is_kernel(d, '5.10') else 'git://github.com/xenomai-ci/ipipe-arm64.git'}"
-GIT_BRANCH_arm64 = "${@'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') else 'ipipe/5.4.y' if is_kernel(d, '5.4') else 'ipipe/4.19.y-cip'}"
+GIT_REPO = "${@ \
+    'git://github.com/xenomai-ci/ipipe.git' if is_xeno_3_0(d) \
+    else 'git://github.com/xenomai-ci/ipipe-x86.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
+    else 'git://source.denx.de/xenomai/linux-dovetail.git' }"
+GIT_BRANCH = "${@ \
+    'ipipe-4.4.y-cip' if is_xeno_3_0(d) \
+    else 'ipipe-x86-4.19.y-cip' if is_kernel(d, '4.19') \
+    else 'ipipe-x86-5.4.y' if is_kernel(d, '5.4') \
+    else 'v5.10.y-dovetail-rebase' }"
+
+GIT_REPO_armhf = "${@ \
+    'git://github.com/xenomai-ci/ipipe.git' if is_xeno_3_0(d) \
+    else 'git://github.com/xenomai-ci/ipipe-arm.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
+    else 'git://source.denx.de/xenomai/linux-dovetail.git' }"
+GIT_BRANCH_armhf = "${@ \
+    'ipipe-4.4.y-cip' if is_xeno_3_0(d) \
+    else 'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
+    else 'ipipe/5.4.y' if is_kernel(d, '5.4') \
+    else 'v5.10.y-dovetail-rebase' }"
+
+GIT_REPO_arm64 = "${@ \
+    'git://github.com/xenomai-ci/ipipe-arm64.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
+    else 'git://source.denx.de/xenomai/linux-dovetail.git' }"
+GIT_BRANCH_arm64 = "${@ \
+    'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
+    else 'ipipe/5.4.y' if is_kernel(d, '5.4') \
+    else 'v5.10.y-dovetail-rebase' }"
 
 SRC_URI += "${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
 SRCREV = "${AUTOREV}"
-- 
2.31.1


