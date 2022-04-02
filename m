From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [linux-dovetail PATCH 2/2] clocksource: GENERIC_CLOCKSOURCE_VDSO only
 supported on ARM
Date: Fri,  1 Apr 2022 23:09:19 -0400
Message-Id: <20220402030919.5104-2-hongzhan.chen@intel.com>
In-Reply-To: <20220402030919.5104-1-hongzhan.chen@intel.com>
References: <20220402030919.5104-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Currently, GENERIC_CLOCKSOURCE_VDSO only supported well on ARM.
To fix build issue like following when make allyesconfig on x86 platform.

arch/x86/entry/vdso/../../../../lib/vdso/gettimeofday.c:145:14:
error: implicit declaration of function clock_open_device

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5138cd593373..1e8c1cd086d5 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -644,7 +644,7 @@ config CLKSRC_ST_LPC
 	bool "Low power clocksource found in the LPC" if COMPILE_TEST
 	select TIMER_OF if OF
 	depends on HAS_IOMEM
-	select GENERIC_CLOCKSOURCE_VDSO
+	select GENERIC_CLOCKSOURCE_VDSO if ARM
 	help
 	  Enable this option to use the Low Power controller timer
 	  as clocksource.
-- 
2.17.1


