From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/2] clocksource/drivers: dovetail: fix dependency on
 GENERIC_CLOCKSOURCE_VDSO
Date: Sat,  2 Apr 2022 12:47:10 +0200
Message-Id: <20220402104711.720244-1-rpm@xenomai.org>
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

From: Philippe Gerum <rpm@xenomai.org>

GENERIC_CLOCKSOURCE_VDSO is currently available for ARM and ARM64, but
some drivers which can export their clocksource via the vDSO can still
be built for unsupported architectures like x86.

Use a weak reverse dependency logic for vDSO-exported clocksources,
enabling GENERIC_CLOCKSOURCE_VDSO only when building for the proper
architecture.

Suggested-by: Hongzhan Chen <hongzhan.chen@intel.com>
Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 drivers/clocksource/Kconfig | 12 ++++++------
 lib/vdso/Kconfig            |  1 +
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 6277a1199635..c1c930b13a52 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -25,7 +25,7 @@ config I8253_LOCK
 config OMAP_DM_TIMER
 	bool
 	select TIMER_OF
-	select GENERIC_CLOCKSOURCE_VDSO
+	imply GENERIC_CLOCKSOURCE_VDSO
 
 config CLKBLD_I8253
 	def_bool y if CLKSRC_I8253 || CLKEVT_I8253 || I8253_LOCK
@@ -60,7 +60,7 @@ config DIGICOLOR_TIMER
 config DW_APB_TIMER
 	bool "DW APB timer driver" if COMPILE_TEST
         select CLKSRC_MMIO
-	select GENERIC_CLOCKSOURCE_VDSO if ARM
+	imply GENERIC_CLOCKSOURCE_VDSO
 	help
 	  Enables the support for the dw_apb timer.
 
@@ -359,7 +359,7 @@ config SUN50I_ERRATUM_UNKNOWN1
 config ARM_GLOBAL_TIMER
 	bool "Support for the ARM global timer" if COMPILE_TEST
 	select TIMER_OF if OF
-	select GENERIC_CLOCKSOURCE_VDSO
+	imply GENERIC_CLOCKSOURCE_VDSO
 	depends on ARM
 	help
 	  This option enables support for the ARM global timer unit.
@@ -424,7 +424,7 @@ config CLKSRC_EXYNOS_MCT
 	bool "Exynos multi core timer driver" if COMPILE_TEST
 	depends on ARM || ARM64
 	depends on ARCH_EXYNOS || COMPILE_TEST
-	select GENERIC_CLOCKSOURCE_VDSO
+	imply GENERIC_CLOCKSOURCE_VDSO
 	help
 	  Support for Multi Core Timer controller on Exynos SoCs.
 
@@ -595,7 +595,7 @@ config H8300_TPU
 config CLKSRC_IMX_GPT
 	bool "Clocksource using i.MX GPT" if COMPILE_TEST
 	depends on (ARM || ARM64) && HAVE_CLK
-	select GENERIC_CLOCKSOURCE_VDSO
+	imply GENERIC_CLOCKSOURCE_VDSO
 
 config CLKSRC_IMX_TPM
 	bool "Clocksource using i.MX TPM" if COMPILE_TEST
@@ -617,7 +617,7 @@ config CLKSRC_ST_LPC
 	bool "Low power clocksource found in the LPC" if COMPILE_TEST
 	select TIMER_OF if OF
 	depends on HAS_IOMEM
-	select GENERIC_CLOCKSOURCE_VDSO
+	imply GENERIC_CLOCKSOURCE_VDSO
 	help
 	  Enable this option to use the Low Power controller timer
 	  as clocksource.
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index a293f387ac98..7b327e182c0c 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -31,6 +31,7 @@ config GENERIC_VDSO_TIME_NS
 	  VDSO
 
 config GENERIC_CLOCKSOURCE_VDSO
+        depends on ARM || ARM64
         select CLKSRC_MMIO
 	bool
 	help
-- 
2.34.1


