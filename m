From: roman.stratiienko@globallogic.com
Subject: [PATCH 4/7] kernel: cobalt: add missing quotes
Date: Tue,  5 Mar 2019 16:45:18 +0200
Message-Id: <20190305144521.2567-4-roman.stratiienko@globallogic.com>
In-Reply-To: <20190305144521.2567-1-roman.stratiienko@globallogic.com>
References: <20190305144521.2567-1-roman.stratiienko@globallogic.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Roman Stratiienko <roman.stratiienko@globallogic.com>

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
 kernel/drivers/analogy/Kconfig | 8 ++++----
 kernel/drivers/can/Kconfig     | 4 ++--
 scripts/Kconfig.frag           | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/drivers/analogy/Kconfig b/kernel/drivers/analogy/Kconfig
index e8fa953d5..858762bda 100644
--- a/kernel/drivers/analogy/Kconfig
+++ b/kernel/drivers/analogy/Kconfig
@@ -48,9 +48,9 @@ config XENO_DRIVERS_ANALOGY_DRIVER_DEBUG_LEVEL
        WARNING: this threshold is only applied on the Analogy
        driver. That will not affect the core.
 
-source drivers/xenomai/analogy/testing/Kconfig
-source drivers/xenomai/analogy/intel/Kconfig
-source drivers/xenomai/analogy/national_instruments/Kconfig
-source drivers/xenomai/analogy/sensoray/Kconfig
+source "drivers/xenomai/analogy/testing/Kconfig"
+source "drivers/xenomai/analogy/intel/Kconfig"
+source "drivers/xenomai/analogy/national_instruments/Kconfig"
+source "drivers/xenomai/analogy/sensoray/Kconfig"
 
 endmenu
diff --git a/kernel/drivers/can/Kconfig b/kernel/drivers/can/Kconfig
index 33ca722ad..0bbfcc9d1 100644
--- a/kernel/drivers/can/Kconfig
+++ b/kernel/drivers/can/Kconfig
@@ -85,7 +85,7 @@ config XENO_DRIVERS_CAN_FLEXCAN
 
 	Say Y here if you want to support for Freescale FlexCAN.
 
-source drivers/xenomai/can/mscan/Kconfig
-source drivers/xenomai/can/sja1000/Kconfig
+source "drivers/xenomai/can/mscan/Kconfig"
+source "drivers/xenomai/can/sja1000/Kconfig"
 
 endmenu
diff --git a/scripts/Kconfig.frag b/scripts/Kconfig.frag
index c9655d43a..f2e89a896 100644
--- a/scripts/Kconfig.frag
+++ b/scripts/Kconfig.frag
@@ -48,4 +48,4 @@ config XENO_REVISION_LEVEL
 
 config XENO_VERSION_STRING
        string
-       default @VERSION_STRING@
+       default "@VERSION_STRING@"
-- 
2.17.1


