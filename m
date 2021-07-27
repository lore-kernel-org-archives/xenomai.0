From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [xenomai-image PATCH v2 1/5] recipes-kernel: arm64_config: enable
 IPIPE_DEBUG for arm64 by default
Date: Mon, 26 Jul 2021 20:42:13 -0400
Message-Id: <20210727004217.10892-2-hongzhan.chen@intel.com>
In-Reply-To: <20210727004217.10892-1-hongzhan.chen@intel.com>
References: <20210727004217.10892-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Enable IPIPE_DEBUG for arm64 by default. We enable IPIPE_DEBUG for
all arch types uniformly by default in order to controll enabling
and disabling them via same method.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 recipes-kernel/linux/files/arm64_defconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/recipes-kernel/linux/files/arm64_defconfig b/recipes-kernel/linux/files/arm64_defconfig
index 7634788..a010c30 100644
--- a/recipes-kernel/linux/files/arm64_defconfig
+++ b/recipes-kernel/linux/files/arm64_defconfig
@@ -191,7 +191,7 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_KALLSYMS_BASE_RELATIVE=y
 CONFIG_PRINTK=y
 CONFIG_PRINTK_NMI=y
-# CONFIG_RAW_PRINTK is not set
+CONFIG_RAW_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
@@ -410,7 +410,6 @@ CONFIG_XENO_OPT_DEBUG_LEGACY=y
 CONFIG_XENO_OPT_DEBUG_TRACE_RELAX=y
 CONFIG_XENO_OPT_WATCHDOG=y
 CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=4
-# CONFIG_XENO_TODO is not set
 
 #
 # Drivers
@@ -449,7 +448,6 @@ CONFIG_XENO_DRIVERS_CAN_BUS_ERR=y
 # CONFIG_XENO_DRIVERS_CAN_CALC_BITTIME_OLD is not set
 CONFIG_XENO_DRIVERS_CAN_VIRT=y
 # CONFIG_XENO_DRIVERS_CAN_FLEXCAN is not set
-# CONFIG_XENO_DRIVERS_CAN_PEAK_CANFD is not set
 CONFIG_XENO_DRIVERS_CAN_SJA1000=y
 CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA=y
 CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM=y
@@ -5907,8 +5905,11 @@ CONFIG_FRAME_POINTER=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
 CONFIG_MAGIC_SYSRQ_SERIAL=y
-# CONFIG_IPIPE_DEBUG is not set
+CONFIG_IPIPE_DEBUG=y
+CONFIG_IPIPE_DEBUG_CONTEXT=y
+CONFIG_IPIPE_DEBUG_INTERNAL=y
 CONFIG_HAVE_IPIPE_TRACER_SUPPORT=y
+# CONFIG_IPIPE_TRACE is not set
 CONFIG_DEBUG_KERNEL=y
 
 #
-- 
2.17.1


