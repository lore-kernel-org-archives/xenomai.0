From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [PATCH] kernel/linux: Update arm kernels
Date: Mon, 14 Oct 2019 10:07:08 +0200
Message-Id: <20191014080708.23033-1-Quirin.Gylstorff@siemens.com>
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

Update arm/arm64 Linux kernel to new versions.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/linux-xenomai_4.19.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai_4.19.bb b/recipes-kernel/linux/linux-xenomai_4.19.bb
index 1607c58..8623f1b 100644
--- a/recipes-kernel/linux/linux-xenomai_4.19.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.19.bb
@@ -16,12 +16,12 @@ SRCREV_amd64 ?= "f83bda3e0785ae2e0ea8ad530bc903d2b420c2c7"
 PV_amd64 ?= "4.19.66+"
 
 SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;nobranch=1"
-SRCREV_arm64 ?= "ipipe-core-4.19.55-arm64-2"
+SRCREV_arm64 ?= "ipipe-core-4.19.55-arm64-4"
 PV_arm64 ?= "4.19.55+"
 
 
 SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;nobranch=1"
-SRCREV_armhf ?= "ipipe-core-4.19.55-arm-3"
+SRCREV_armhf ?= "ipipe-core-4.19.55-arm-5"
 PV_armhf ?= "4.19.55+"
 
 S = "${WORKDIR}/git"
-- 
2.20.1


