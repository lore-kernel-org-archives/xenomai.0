From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 1/5] linux-xenomai: Update to latest 4.4 and
 4.19 ipipe releases
Date: Fri, 11 Jun 2021 22:13:08 +0200
Message-Id: <e5ba93f17dac1cce9700a92637aff05007a5585b.1623442392.git.jan.kiszka@siemens.com>
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai_4.19.bb | 12 ++++++------
 recipes-kernel/linux/linux-xenomai_4.4.bb  |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai_4.19.bb b/recipes-kernel/linux/linux-xenomai_4.19.bb
index 12e2199..ef67067 100644
--- a/recipes-kernel/linux/linux-xenomai_4.19.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.19.bb
@@ -12,15 +12,15 @@
 require recipes-kernel/linux/linux-xenomai.inc
 
 SRC_URI_append_amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
-SRCREV_amd64 ?= "ipipe-core-4.19.140-cip33-x86-14"
-PV_amd64 ?= "4.19.140+"
+SRCREV_amd64 ?= "ipipe-core-4.19.192-cip50-x86-18"
+PV_amd64 ?= "4.19.192+"
 
 SRC_URI_append_arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
-SRCREV_arm64 ?= "ipipe-core-4.19.144-cip34-arm64-08"
-PV_arm64 ?= "4.19.144+"
+SRCREV_arm64 ?= "ipipe-core-4.19.190-cip49-arm64-10"
+PV_arm64 ?= "4.19.190+"
 
 SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1"
-SRCREV_armhf ?= "ipipe-core-4.19.140-cip33-arm-11"
-PV_armhf ?= "4.19.140+"
+SRCREV_armhf ?= "ipipe-core-4.19.190-cip49-arm-15"
+PV_armhf ?= "4.19.190+"
 
 S = "${WORKDIR}/git"
diff --git a/recipes-kernel/linux/linux-xenomai_4.4.bb b/recipes-kernel/linux/linux-xenomai_4.4.bb
index 0c2b1f3..2a1137c 100644
--- a/recipes-kernel/linux/linux-xenomai_4.4.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.4.bb
@@ -12,11 +12,11 @@
 require recipes-kernel/linux/linux-xenomai.inc
 
 SRC_URI_append_amd64 = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
-SRCREV_amd64 ?= "ipipe-core-4.4.238-cip50-x86-26"
-PV_amd64 = "4.4.238+"
+SRCREV_amd64 ?= "ipipe-core-4.4.268-cip57-x86-28"
+PV_amd64 = "4.4.268+"
 
 SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
-SRCREV_armhf ?= "ipipe-core-4.4.238-cip50-arm-11"
-PV_armhf = "4.4.238+"
+SRCREV_armhf ?= "ipipe-core-4.4.268-cip57-arm-13"
+PV_armhf = "4.4.268+"
 
 S = "${WORKDIR}/git"
-- 
2.26.2


