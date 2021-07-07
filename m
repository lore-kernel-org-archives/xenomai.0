From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [xenomai-images PATCH] recipes-kernel: arm64_config: enable debug for
 testing purposes
Date: Tue,  6 Jul 2021 22:34:42 -0400
Message-Id: <20210707023442.8318-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

Enable debug for sigdebug of smokey test.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/recipes-kernel/linux/files/arm64_defconfig b/recipes-kernel/linux/files/arm64_defconfig
index 122aeac..7634788 100644
--- a/recipes-kernel/linux/files/arm64_defconfig
+++ b/recipes-kernel/linux/files/arm64_defconfig
@@ -390,6 +390,7 @@ CONFIG_XENO_OPT_SYS_HEAPSZ=4096
 CONFIG_XENO_OPT_PRIVATE_HEAPSZ=256
 CONFIG_XENO_OPT_SHARED_HEAPSZ=256
 CONFIG_XENO_OPT_NRTIMERS=256
+CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ=16
 
 #
 # Latency settings
@@ -397,7 +398,19 @@ CONFIG_XENO_OPT_NRTIMERS=256
 CONFIG_XENO_OPT_TIMING_SCHEDLAT=0
 CONFIG_XENO_OPT_TIMING_KSCHEDLAT=0
 CONFIG_XENO_OPT_TIMING_IRQLAT=0
-# CONFIG_XENO_OPT_DEBUG is not set
+CONFIG_XENO_OPT_DEBUG=y
+CONFIG_XENO_OPT_DEBUG_COBALT=y
+CONFIG_XENO_OPT_DEBUG_MEMORY=y
+CONFIG_XENO_OPT_DEBUG_CONTEXT=y
+CONFIG_XENO_OPT_DEBUG_LOCKING=y
+CONFIG_XENO_OPT_DEBUG_USER=y
+CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED=y
+CONFIG_XENO_OPT_DEBUG_MUTEX_SLEEP=y
+CONFIG_XENO_OPT_DEBUG_LEGACY=y
+CONFIG_XENO_OPT_DEBUG_TRACE_RELAX=y
+CONFIG_XENO_OPT_WATCHDOG=y
+CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=4
+# CONFIG_XENO_TODO is not set
 
 #
 # Drivers
@@ -436,6 +449,7 @@ CONFIG_XENO_DRIVERS_CAN_BUS_ERR=y
 # CONFIG_XENO_DRIVERS_CAN_CALC_BITTIME_OLD is not set
 CONFIG_XENO_DRIVERS_CAN_VIRT=y
 # CONFIG_XENO_DRIVERS_CAN_FLEXCAN is not set
+# CONFIG_XENO_DRIVERS_CAN_PEAK_CANFD is not set
 CONFIG_XENO_DRIVERS_CAN_SJA1000=y
 CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA=y
 CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM=y
-- 
2.17.1


