From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 1/4] linux-xenomai: update ipipe versions
Date: Wed,  4 Nov 2020 17:11:51 +0100
Message-Id: <20201104161154.32366-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20201104161154.32366-1-Quirin.Gylstorff@siemens.com>
References: <20201104161154.32366-1-Quirin.Gylstorff@siemens.com>
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
To: xenomai@xenomai.org, jan.kiszka@siemens.com

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Update linux-xenomai 4.19 and 4.4 to latest release tag.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/linux-xenomai_4.19.bb | 12 ++++++------
 recipes-kernel/linux/linux-xenomai_4.4.bb  |  8 +++++---
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai_4.19.bb b/recipes-kernel/linux/linux-xenomai_4.19.bb
index 29e9f05..12e2199 100644
--- a/recipes-kernel/linux/linux-xenomai_4.19.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.19.bb
@@ -12,15 +12,15 @@
 require recipes-kernel/linux/linux-xenomai.inc
 
 SRC_URI_append_amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
-SRCREV_amd64 ?= "ipipe-core-4.19.94-cip18-x86-10"
-PV_amd64 ?= "4.19.94+"
+SRCREV_amd64 ?= "ipipe-core-4.19.140-cip33-x86-14"
+PV_amd64 ?= "4.19.140+"
 
 SRC_URI_append_arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
-SRCREV_arm64 ?= "ipipe-core-4.19.55-arm64-4"
-PV_arm64 ?= "4.19.55+"
+SRCREV_arm64 ?= "ipipe-core-4.19.144-cip34-arm64-08"
+PV_arm64 ?= "4.19.144+"
 
 SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1"
-SRCREV_armhf ?= "ipipe-core-4.19.55-arm-5"
-PV_armhf ?= "4.19.55+"
+SRCREV_armhf ?= "ipipe-core-4.19.140-cip33-arm-11"
+PV_armhf ?= "4.19.140+"
 
 S = "${WORKDIR}/git"
diff --git a/recipes-kernel/linux/linux-xenomai_4.4.bb b/recipes-kernel/linux/linux-xenomai_4.4.bb
index 1c8c80f..c141914 100644
--- a/recipes-kernel/linux/linux-xenomai_4.4.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.4.bb
@@ -11,10 +11,12 @@
 
 require recipes-kernel/linux/linux-xenomai.inc
 
-SRC_URI_append_amd64 = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1;tag=ipipe-core-4.4.208-cip41-x86-21"
-PV_amd64 = "4.4.208+"
+SRC_URI_append_amd64 = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
+SRCREV_amd64 ?= "ipipe-core-4.4.235-cip49-x86-25"
+PV_amd64 = "4.4.235+"
 
-SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1;tag=ipipe-core-4.4.176-arm-10"
+SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
+SRCREV_armhf ?= "ipipe-core-4.4.176-arm-10"
 PV_armhf = "4.4.176+"
 
 S = "${WORKDIR}/git"
-- 
2.20.1


