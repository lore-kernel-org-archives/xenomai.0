From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 09/10] linux-xenomai: Update to
 ipipe-core-4.19.94-cip18-x86-10
Date: Mon, 10 Feb 2020 19:17:48 +0100
Message-Id: <ae9090b060b6284f96f423f772c3f98f337657fa.1581358669.git.jan.kiszka@siemens.com>
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai_4.19.bb | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai_4.19.bb b/recipes-kernel/linux/linux-xenomai_4.19.bb
index 8623f1b..e0757c2 100644
--- a/recipes-kernel/linux/linux-xenomai_4.19.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.19.bb
@@ -12,14 +12,13 @@
 require recipes-kernel/linux/linux-xenomai.inc
 
 SRC_URI_append_amd64 = " git://gitlab.denx.de/Xenomai/ipipe-x86.git;protocol=https;nobranch=1"
-SRCREV_amd64 ?= "f83bda3e0785ae2e0ea8ad530bc903d2b420c2c7"
-PV_amd64 ?= "4.19.66+"
+SRCREV_amd64 ?= "ipipe-core-4.19.94-cip18-x86-10"
+PV_amd64 ?= "4.19.94+"
 
 SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;nobranch=1"
 SRCREV_arm64 ?= "ipipe-core-4.19.55-arm64-4"
 PV_arm64 ?= "4.19.55+"
 
-
 SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;nobranch=1"
 SRCREV_armhf ?= "ipipe-core-4.19.55-arm-5"
 PV_armhf ?= "4.19.55+"
-- 
2.16.4


