From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 1/3] linux-4.19: Use SRCREV instead of
 branches or tags in SRC_URI
Date: Fri, 20 Sep 2019 16:57:29 +0200
Message-Id: <20190920145731.25281-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20190920145731.25281-1-Quirin.Gylstorff@siemens.com>
References: <20190920145731.25281-1-Quirin.Gylstorff@siemens.com>
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

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

TO switch to new commits select the ipipe-kernel version by
with the SRCREV instead SRC_URI.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/linux-xenomai_4.19.bb | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai_4.19.bb b/recipes-kernel/linux/linux-xenomai_4.19.bb
index 5137319..1607c58 100644
--- a/recipes-kernel/linux/linux-xenomai_4.19.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.19.bb
@@ -11,15 +11,17 @@
 
 require recipes-kernel/linux/linux-xenomai.inc
 
-SRC_URI_append_amd64 = " git://gitlab.denx.de/Xenomai/ipipe-x86.git;protocol=https;branch=ipipe-x86-4.19.y"
-SRCREV_amd64 = "f83bda3e0785ae2e0ea8ad530bc903d2b420c2c7"
-PV_amd64 = "4.19.66+"
+SRC_URI_append_amd64 = " git://gitlab.denx.de/Xenomai/ipipe-x86.git;protocol=https;nobranch=1"
+SRCREV_amd64 ?= "f83bda3e0785ae2e0ea8ad530bc903d2b420c2c7"
+PV_amd64 ?= "4.19.66+"
 
-SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;nobranch=1;tag=ipipe-core-4.19.55-arm64-2"
-PV_arm64 = "4.19.55+"
+SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;nobranch=1"
+SRCREV_arm64 ?= "ipipe-core-4.19.55-arm64-2"
+PV_arm64 ?= "4.19.55+"
 
 
-SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;nobranch=1;tag=ipipe-core-4.19.55-arm-3"
-PV_armhf = "4.19.55+"
+SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;nobranch=1"
+SRCREV_armhf ?= "ipipe-core-4.19.55-arm-3"
+PV_armhf ?= "4.19.55+"
 
 S = "${WORKDIR}/git"
-- 
2.20.1


