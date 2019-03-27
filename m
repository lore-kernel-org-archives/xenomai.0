From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3/8] Revert "clocksource: imx/imx51: ipipe: add support for
 user-visible TSC"
Date: Wed, 27 Mar 2019 14:18:02 +0100
Message-Id: <fce21f714e385dab70171ad1cfc6feea32524ebc.1553692686.git.jan.kiszka@siemens.com>
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

This reverts commit 2f8ff661dfbfa84b14571d1629f73455b2bd707b.

Belongs into the ARM tree.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/mach-imx/mach-imx51.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
index 60975275ff88..3835b6a3423c 100644
--- a/arch/arm/mach-imx/mach-imx51.c
+++ b/arch/arm/mach-imx/mach-imx51.c
@@ -59,11 +59,6 @@ static void __init imx51_dt_init(void)
 static void __init imx51_init_late(void)
 {
 	mx51_neon_fixup();
-#ifdef CONFIG_IPIPE
-	/* Allow user-space access to emulated tsc */
-	imx_set_aips(IMX_IO_ADDRESS(0x73f00000));
-	imx_set_aips(IMX_IO_ADDRESS(0x83f00000));
-#endif
 	imx51_pm_init();
 }
 
-- 
2.16.4


