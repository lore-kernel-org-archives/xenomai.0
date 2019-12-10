From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xneomai-images][PATCH] linux-xenomai: Update to
 ipipe-core-4.14.110-arm-7
Message-ID: <e6626ca7-54b3-1d81-9f33-1e4be8028bc9@siemens.com>
Date: Tue, 10 Dec 2019 18:51:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Comes with a patch needed for the BeagleBone Black.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This replaces "linux-xenomai: Add 4.19-backport to 4.14 for BeagleBoneBlack irqchip".

 recipes-kernel/linux/linux-xenomai_4.14.bb | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai_4.14.bb b/recipes-kernel/linux/linux-xenomai_4.14.bb
index f147eed..1a5500d 100644
--- a/recipes-kernel/linux/linux-xenomai_4.14.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.14.bb
@@ -18,8 +18,7 @@ PV_amd64 = "4.14.134+"
 SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;nobranch=1;tag=ipipe-core-4.14.78-arm64-2"
 PV_arm64 = "4.14.78+"
 
-SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;branch=stable/4.14.96-arm"
-SRCREV_armhf = "723539db0d5a1c995c9bb5524abe311a97b33e43"
-PV_armhf = "4.14.96+"
+SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;nobranch=1;tag=ipipe-core-4.14.110-arm-7"
+PV_armhf = "4.14.110+"
 
 S = "${WORKDIR}/git"
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

