From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 1/2] ipipe: fixup patch generator
Date: Wed,  5 Dec 2018 16:25:33 +0100
Message-Id: <20181205152534.28290-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 scripts/ipipe/genpatches.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/ipipe/genpatches.sh b/scripts/ipipe/genpatches.sh
index cb83b6aed8fb..cd62d1bf258e 100755
--- a/scripts/ipipe/genpatches.sh
+++ b/scripts/ipipe/genpatches.sh
@@ -61,6 +61,7 @@ BEGIN {
     driver_arch["cpuidle/cpuidle.c"]="noarch"
     driver_arch["tty/serial/8250/8250_core.c"]="noarch"
     driver_arch["iommu/irq_remapping.c"]="noarch"
+    driver_arch["base/core.c"]="noarch"
 
     driver_arch["clk/mxs/clk-imx28.c"]="arm"
     driver_arch["clocksource/mxs_timer.c"]="arm"
-- 
2.17.2


