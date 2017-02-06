From: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Date: Mon,  6 Feb 2017 14:52:31 -0800
Message-Id: <1486421551-31257-1-git-send-email-dmitriy@mperpetuo.com>
Subject: [Xenomai] [PATCH] ipipe: add missing drivers to genpatches script
	for arm64
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This adds the clocksource and GIC drivers to the arm64 patch.
---
 scripts/ipipe/genpatches.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/ipipe/genpatches.sh b/scripts/ipipe/genpatches.sh
index 07b6cf3..e2846a4 100755
--- a/scripts/ipipe/genpatches.sh
+++ b/scripts/ipipe/genpatches.sh
@@ -107,6 +107,9 @@ BEGIN {
 
     driver_arch["tty/serial/amba-pl011.c"]="arm64"
     driver_arch["gpio/gpio-pl061.c"]="arm64"
+    driver_arch["clocksource/arm_arch_timer.c"]="arm64"
+    driver_arch["irqchip/irq-gic.c"]="arm64"
+    driver_arch["irqchip/irq-gic-v3.c"]="arm64"
 
     driver_arch["tty/serial/bfin_uart.c"]="blackfin"
 
-- 
1.9.1


