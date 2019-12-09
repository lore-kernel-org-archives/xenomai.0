From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xneomai-images][PATCH] linux-xenomai: Add 4.19-backport to 4.14 for
 BeagleBoneBlack irqchip
Message-ID: <3daa9b1b-f011-0dcc-f406-4584f74def82@siemens.com>
Date: Mon, 9 Dec 2019 14:42:25 +0100
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

Required to resolve a boot-up warning of 4.14.96 on that target when
doing a stable test.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...ps65217-ipipe-enable-interrupt-pipelining.patch | 24 ++++++++++++++++++++++
 recipes-kernel/linux/linux-xenomai_4.14.bb         |  4 +++-
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 recipes-kernel/linux/files/0001-mfd-tps65217-ipipe-enable-interrupt-pipelining.patch

diff --git a/recipes-kernel/linux/files/0001-mfd-tps65217-ipipe-enable-interrupt-pipelining.patch b/recipes-kernel/linux/files/0001-mfd-tps65217-ipipe-enable-interrupt-pipelining.patch
new file mode 100644
index 0000000..a6a0297
--- /dev/null
+++ b/recipes-kernel/linux/files/0001-mfd-tps65217-ipipe-enable-interrupt-pipelining.patch
@@ -0,0 +1,24 @@
+From 1682a7f1da2af8f30a51dfc49fae6bdd241e070a Mon Sep 17 00:00:00 2001
+From: Philippe Gerum <rpm@xenomai.org>
+Date: Wed, 3 Apr 2019 15:23:55 +0200
+Subject: [PATCH] mfd: tps65217: ipipe: enable interrupt pipelining
+
+---
+ drivers/mfd/tps65217.c | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
+index 7566ce4457a0..23095cdc1ced 100644
+--- a/drivers/mfd/tps65217.c
++++ b/drivers/mfd/tps65217.c
+@@ -84,6 +84,7 @@ static struct irq_chip tps65217_irq_chip = {
+ 	.irq_bus_sync_unlock	= tps65217_irq_sync_unlock,
+ 	.irq_enable		= tps65217_irq_enable,
+ 	.irq_disable		= tps65217_irq_disable,
++	.flags			= IRQCHIP_PIPELINE_SAFE,
+ };
+ 
+ static struct mfd_cell tps65217s[] = {
+-- 
+2.16.4
+
diff --git a/recipes-kernel/linux/linux-xenomai_4.14.bb b/recipes-kernel/linux/linux-xenomai_4.14.bb
index f147eed..88f0845 100644
--- a/recipes-kernel/linux/linux-xenomai_4.14.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.14.bb
@@ -18,7 +18,9 @@ PV_amd64 = "4.14.134+"
 SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;nobranch=1;tag=ipipe-core-4.14.78-arm64-2"
 PV_arm64 = "4.14.78+"
 
-SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;branch=stable/4.14.96-arm"
+SRC_URI_append_armhf = " \
+    git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;branch=stable/4.14.96-arm \
+    file://0001-mfd-tps65217-ipipe-enable-interrupt-pipelining.patch"
 SRCREV_armhf = "723539db0d5a1c995c9bb5524abe311a97b33e43"
 PV_armhf = "4.14.96+"
 
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

