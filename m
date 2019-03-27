From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 2/8] Revert "clocksource: imx/imx53: ipipe: add support for
 user-visible TSC"
Date: Wed, 27 Mar 2019 14:18:01 +0100
Message-Id: <d1742ce96f1500c3a203334d7c0873838eabaee1.1553692686.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1553692686.git.jan.kiszka@siemens.com>
References: <cover.1553692686.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1553692686.git.jan.kiszka@siemens.com>
References: <cover.1553692686.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This reverts commit de53c9b26caa1c28785bb642350c07cfac6ebc3a.

Belongs into the ARM tree.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/mach-imx/mach-imx53.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index a02550b5ef7b..07c2e8dca494 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -37,11 +37,6 @@ static void __init imx53_dt_init(void)
 
 static void __init imx53_init_late(void)
 {
-#ifdef CONFIG_IPIPE
-	/* Allow user-space access to emulated tsc */
-	imx_set_aips(IMX_IO_ADDRESS(0x53f00000));
-	imx_set_aips(IMX_IO_ADDRESS(0x63f00000));
-#endif
 	imx53_pm_init();
 }
 
-- 
2.16.4


