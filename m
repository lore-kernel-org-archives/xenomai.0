From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 3/4] linux-xenomai: Update to latest releases
Date: Wed, 17 Nov 2021 19:34:18 +0100
Message-Id: <f8d95226b02aa296997157966507c94e67f2c38b.1637174059.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1637174059.git.jan.kiszka@siemens.com>
References: <cover.1637174059.git.jan.kiszka@siemens.com>
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai_4.19.bb | 14 +++++++-------
 recipes-kernel/linux/linux-xenomai_4.4.bb  | 10 +++++-----
 recipes-kernel/linux/linux-xenomai_5.10.bb |  4 ++--
 recipes-kernel/linux/linux-xenomai_5.4.bb  | 12 ++++++------
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai_4.19.bb b/recipes-kernel/linux/linux-xenomai_4.19.bb
index ef67067..5b12ce4 100644
--- a/recipes-kernel/linux/linux-xenomai_4.19.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.19.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2021
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -12,15 +12,15 @@
 require recipes-kernel/linux/linux-xenomai.inc
 
 SRC_URI_append_amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
-SRCREV_amd64 ?= "ipipe-core-4.19.192-cip50-x86-18"
-PV_amd64 ?= "4.19.192+"
+SRCREV_amd64 ?= "ipipe-core-4.19.207-cip58-x86-20"
+PV_amd64 ?= "4.19.207+"
 
 SRC_URI_append_arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
-SRCREV_arm64 ?= "ipipe-core-4.19.190-cip49-arm64-10"
-PV_arm64 ?= "4.19.190+"
+SRCREV_arm64 ?= "ipipe-core-4.19.209-cip59-arm64-12"
+PV_arm64 ?= "4.19.209+"
 
 SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1"
-SRCREV_armhf ?= "ipipe-core-4.19.190-cip49-arm-15"
-PV_armhf ?= "4.19.190+"
+SRCREV_armhf ?= "ipipe-core-4.19.207-cip58-arm16"
+PV_armhf ?= "4.19.207+"
 
 S = "${WORKDIR}/git"
diff --git a/recipes-kernel/linux/linux-xenomai_4.4.bb b/recipes-kernel/linux/linux-xenomai_4.4.bb
index 42c6d83..a5cce7d 100644
--- a/recipes-kernel/linux/linux-xenomai_4.4.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.4.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2020
+# Copyright (c) Siemens AG, 2018-2021
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,12 +12,12 @@
 require recipes-kernel/linux/linux-xenomai.inc
 
 SRC_URI_append_amd64 = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
-SRCREV_amd64 ?= "ipipe-core-4.4.268-cip57-x86-28"
-PV_amd64 = "4.4.268+"
+SRCREV_amd64 ?= "ipipe-core-4.4.285-cip63-x86-30"
+PV_amd64 = "4.4.285+"
 
 SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
 SRC_URI_append_armhf = " ${@ 'file://bbb_4.4.cfg' if d.getVar('MACHINE') == 'beagle-bone-black' else '' }"
-SRCREV_armhf ?= "ipipe-core-4.4.268-cip57-arm-13"
-PV_armhf = "4.4.268+"
+SRCREV_armhf ?= "ipipe-core-4.4.285-cip63-arm-15"
+PV_armhf = "4.4.285+"
 
 S = "${WORKDIR}/git"
diff --git a/recipes-kernel/linux/linux-xenomai_5.10.bb b/recipes-kernel/linux/linux-xenomai_5.10.bb
index afc129c..0e8b414 100644
--- a/recipes-kernel/linux/linux-xenomai_5.10.bb
+++ b/recipes-kernel/linux/linux-xenomai_5.10.bb
@@ -12,7 +12,7 @@
 require recipes-kernel/linux/linux-xenomai.inc
 
 SRC_URI += "git://source.denx.de/xenomai/linux-dovetail.git;protocol=https;nobranch=1"
-SRCREV = "v5.10.61-dovetail"
-PV = "5.10.61+"
+SRCREV = "v5.10.76-dovetail3"
+PV = "5.10.76+"
 
 S = "${WORKDIR}/git"
diff --git a/recipes-kernel/linux/linux-xenomai_5.4.bb b/recipes-kernel/linux/linux-xenomai_5.4.bb
index 9f070cf..f19dcd6 100644
--- a/recipes-kernel/linux/linux-xenomai_5.4.bb
+++ b/recipes-kernel/linux/linux-xenomai_5.4.bb
@@ -12,15 +12,15 @@
 require recipes-kernel/linux/linux-xenomai.inc
 
 SRC_URI_append_amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
-SRCREV_amd64 ?= "ipipe-core-5.4.124-x86-5"
-PV_amd64 ?= "5.4.124+"
+SRCREV_amd64 ?= "ipipe-core-5.4.151-x86-7"
+PV_amd64 ?= "5.4.151+"
 
 SRC_URI_append_arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
-SRCREV_arm64 ?= "ipipe-core-5.4.119-arm64-2"
-PV_arm64 ?= "5.4.119+"
+SRCREV_arm64 ?= "ipipe-core-5.4.152-arm64-3"
+PV_arm64 ?= "5.4.152+"
 
 SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1"
-SRCREV_armhf ?= "ipipe-core-5.4.119-arm-2"
-PV_armhf ?= "5.4.119+"
+SRCREV_armhf ?= "ipipe-core-5.4.151-arm-4"
+PV_armhf ?= "5.4.151+"
 
 S = "${WORKDIR}/git"
-- 
2.31.1


