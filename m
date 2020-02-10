From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 10/10] Switch to github as source explicitly
Date: Mon, 10 Feb 2020 19:17:49 +0100
Message-Id: <cd022053cc59514e16af851a41fa1ad609711238.1581358669.git.jan.kiszka@siemens.com>
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

The current outage of gitlab.denx.de showed that PREMIRRORS does not
work for us because of the use of bb.util.get_srcrev which ignores it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas.yml                                         | 3 ---
 recipes-kernel/linux/linux-xenomai_4.14.bb      | 6 +++---
 recipes-kernel/linux/linux-xenomai_4.19.bb      | 6 +++---
 recipes-kernel/linux/linux-xenomai_4.4.bb       | 4 ++--
 recipes-kernel/linux/linux-xenomai_latest.bb    | 2 +-
 recipes-xenomai/xenomai/xenomai_3.0.10.bb       | 2 +-
 recipes-xenomai/xenomai/xenomai_3.1.bb          | 2 +-
 recipes-xenomai/xenomai/xenomai_master.bb       | 2 +-
 recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb | 2 +-
 9 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/kas.yml b/kas.yml
index f4ee0e5..d04b9c3 100644
--- a/kas.yml
+++ b/kas.yml
@@ -35,6 +35,3 @@ local_conf_header:
     CONF_VERSION = "1"
   cross: |
     ISAR_CROSS_COMPILE = "1"
-  github-mirror: |
-    PREMIRRORS_prepend = " \
-        git://gitlab.denx.de/Xenomai/ git://github.com/xenomai-ci/ \n"
diff --git a/recipes-kernel/linux/linux-xenomai_4.14.bb b/recipes-kernel/linux/linux-xenomai_4.14.bb
index 1a5500d..8ffc66f 100644
--- a/recipes-kernel/linux/linux-xenomai_4.14.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.14.bb
@@ -11,14 +11,14 @@
 
 require recipes-kernel/linux/linux-xenomai.inc
 
-SRC_URI_append_amd64 = " git://gitlab.denx.de/Xenomai/ipipe-x86.git;protocol=https;branch=ipipe-x86-4.14.y"
+SRC_URI_append_amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;branch=ipipe-x86-4.14.y"
 SRCREV_amd64 = "fdfa1aff4578edf6a03e2e77ea20bf7f97863954"
 PV_amd64 = "4.14.134+"
 
-SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;nobranch=1;tag=ipipe-core-4.14.78-arm64-2"
+SRC_URI_append_arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1;tag=ipipe-core-4.14.78-arm64-2"
 PV_arm64 = "4.14.78+"
 
-SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;nobranch=1;tag=ipipe-core-4.14.110-arm-7"
+SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1;tag=ipipe-core-4.14.110-arm-7"
 PV_armhf = "4.14.110+"
 
 S = "${WORKDIR}/git"
diff --git a/recipes-kernel/linux/linux-xenomai_4.19.bb b/recipes-kernel/linux/linux-xenomai_4.19.bb
index e0757c2..29e9f05 100644
--- a/recipes-kernel/linux/linux-xenomai_4.19.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.19.bb
@@ -11,15 +11,15 @@
 
 require recipes-kernel/linux/linux-xenomai.inc
 
-SRC_URI_append_amd64 = " git://gitlab.denx.de/Xenomai/ipipe-x86.git;protocol=https;nobranch=1"
+SRC_URI_append_amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
 SRCREV_amd64 ?= "ipipe-core-4.19.94-cip18-x86-10"
 PV_amd64 ?= "4.19.94+"
 
-SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;nobranch=1"
+SRC_URI_append_arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
 SRCREV_arm64 ?= "ipipe-core-4.19.55-arm64-4"
 PV_arm64 ?= "4.19.55+"
 
-SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;nobranch=1"
+SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1"
 SRCREV_armhf ?= "ipipe-core-4.19.55-arm-5"
 PV_armhf ?= "4.19.55+"
 
diff --git a/recipes-kernel/linux/linux-xenomai_4.4.bb b/recipes-kernel/linux/linux-xenomai_4.4.bb
index f76e847..1c8c80f 100644
--- a/recipes-kernel/linux/linux-xenomai_4.4.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.4.bb
@@ -11,10 +11,10 @@
 
 require recipes-kernel/linux/linux-xenomai.inc
 
-SRC_URI_append_amd64 = " git://gitlab.denx.de/Xenomai/ipipe.git;protocol=https;nobranch=1;tag=ipipe-core-4.4.208-cip41-x86-21"
+SRC_URI_append_amd64 = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1;tag=ipipe-core-4.4.208-cip41-x86-21"
 PV_amd64 = "4.4.208+"
 
-SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe.git;protocol=https;nobranch=1;tag=ipipe-core-4.4.176-arm-10"
+SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1;tag=ipipe-core-4.4.176-arm-10"
 PV_armhf = "4.4.176+"
 
 S = "${WORKDIR}/git"
diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index 506dbdd..8f6636b 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -27,7 +27,7 @@ GIT_BRANCH_armhf = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'ipipe/master'}"
 GIT_REPO_arm64 = "ipipe-arm64.git"
 GIT_BRANCH_arm64 = "ipipe/master"
 
-SRC_URI += "git://gitlab.denx.de/Xenomai/${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
+SRC_URI += "git://github.com/xenomai-ci/${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
 SRCREV = "${AUTOREV}"
 
 S = "${WORKDIR}/git"
diff --git a/recipes-xenomai/xenomai/xenomai_3.0.10.bb b/recipes-xenomai/xenomai/xenomai_3.0.10.bb
index aaefa31..4b733fb 100644
--- a/recipes-xenomai/xenomai/xenomai_3.0.10.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.0.10.bb
@@ -12,7 +12,7 @@
 require xenomai.inc
 
 SRC_URI = " \
-    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=stable/v3.0.x;tag=v${PV} \
+    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.0.x;tag=v${PV} \
 file://0001-debian-Add-config-folder-to-xenomai-kernel-source.patch \
 file://0001-debian-Enable-SMP-in-userspace-package.patch \
     "
diff --git a/recipes-xenomai/xenomai/xenomai_3.1.bb b/recipes-xenomai/xenomai/xenomai_3.1.bb
index 3af1d98..f117eee 100644
--- a/recipes-xenomai/xenomai/xenomai_3.1.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.1.bb
@@ -12,6 +12,6 @@
 require xenomai.inc
 
 SRC_URI = " \
-    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=master;tag=v${PV}"
+    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=master;tag=v${PV}"
 
 S = "${WORKDIR}/git"
diff --git a/recipes-xenomai/xenomai/xenomai_master.bb b/recipes-xenomai/xenomai/xenomai_master.bb
index 0852c0c..298492f 100644
--- a/recipes-xenomai/xenomai/xenomai_master.bb
+++ b/recipes-xenomai/xenomai/xenomai_master.bb
@@ -13,7 +13,7 @@
 require xenomai.inc
 
 SRC_URI = " \
-    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=${PV}"
+    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=${PV}"
 SRCREV = "${AUTOREV}"
 
 S = "${WORKDIR}/git"
diff --git a/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb b/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
index 34cb4b1..6e8cd97 100644
--- a/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
+++ b/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
@@ -13,7 +13,7 @@
 require xenomai.inc
 
 SRC_URI = " \
-    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=stable/v3.0.x"
+    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.0.x"
 SRCREV = "${AUTOREV}"
 
 S = "${WORKDIR}/git"
-- 
2.16.4


