From: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Date: Wed,  8 Feb 2017 11:40:39 -1000
Message-Id: <1486590039-5193-2-git-send-email-dmitriy@mperpetuo.com>
In-Reply-To: <1486590039-5193-1-git-send-email-dmitriy@mperpetuo.com>
References: <1486590039-5193-1-git-send-email-dmitriy@mperpetuo.com>
Subject: [Xenomai] [PATCH v3 2/2] ipipe: add support for arm64 to genpatches
	script
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This adds support for properly generating arm64 patches.

Signed-off-by: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
---
 scripts/ipipe/genpatches.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/ipipe/genpatches.sh b/scripts/ipipe/genpatches.sh
index 4c21c9c..3714c1b 100755
--- a/scripts/ipipe/genpatches.sh
+++ b/scripts/ipipe/genpatches.sh
@@ -62,7 +62,6 @@ BEGIN {
     driver_arch["iommu/irq_remapping.c"]="noarch"
 
     driver_arch["clk/mxs/clk-imx28.c"]="arm"
-    driver_arch["clocksource/arm_arch_timer.c"]="arm"
     driver_arch["clocksource/mxs_timer.c"]="arm"
     driver_arch["clocksource/arm_global_timer.c"]="arm"
     driver_arch["clocksource/pxa_timer.c"]="arm"
@@ -81,7 +80,6 @@ BEGIN {
     driver_arch["irqchip/spear-shirq.c"]="arm"
     driver_arch["irqchip/irq-mxs.c"]="arm"
     driver_arch["irqchip/irq-s3c24xx.c"]="arm"
-    driver_arch["irqchip/irq-gic.c"]="arm"
     driver_arch["irqchip/irq-vic.c"]="arm"
     driver_arch["irqchip/irq-atmel-aic.c"]="arm"
     driver_arch["irqchip/irq-atmel-aic5.c"]="arm"
@@ -89,7 +87,6 @@ BEGIN {
     driver_arch["irqchip/irq-bcm7120-l2.c"]="arm"
     driver_arch["irqchip/irq-brcmstb-l2.c"]="arm"
     driver_arch["irqchip/irq-dw-apb-ictl.c"]="arm"
-    driver_arch["irqchip/irq-gic-v3.c"]="arm"
     driver_arch["irqchip/irq-sunxi-nmi.c"]="arm"
     driver_arch["irqchip/irq-crossbar.c"]="arm"
     driver_arch["mfd/twl4030-irq.c"]="arm"
@@ -105,6 +102,10 @@ BEGIN {
     driver_arch["pinctrl/pinctrl-single.c"]="arm"
     driver_arch["tty/serial/xilinx_uartps.c"]="arm"
 
+    driver_arch["irqchip/irq-gic.c"]="arm arm64"
+    driver_arch["irqchip/irq-gic-v3.c"]="arm arm64"
+    driver_arch["clocksource/arm_arch_timer.c"]="arm arm64"
+
     driver_arch["tty/serial/amba-pl011.c"]="arm64"
     driver_arch["gpio/gpio-pl061.c"]="arm64"
 
-- 
1.9.1


