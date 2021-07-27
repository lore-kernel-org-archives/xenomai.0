From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [xenomai-image PATCH v2 2/5] recipes-kernel: armhf_config: enable
 IPIPE_DEBUG for armhf by default
Date: Mon, 26 Jul 2021 20:42:14 -0400
Message-Id: <20210727004217.10892-3-hongzhan.chen@intel.com>
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

Enable IPIPE_DEBUG for armhf by default. We enable IPIPE_DEBUG for
all arch types uniformly by default in order to controll enabling
and disabling them via same method.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 recipes-kernel/linux/files/armhf_defconfig | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/recipes-kernel/linux/files/armhf_defconfig b/recipes-kernel/linux/files/armhf_defconfig
index 3c42582..ef4981d 100644
--- a/recipes-kernel/linux/files/armhf_defconfig
+++ b/recipes-kernel/linux/files/armhf_defconfig
@@ -162,7 +162,7 @@ CONFIG_KALLSYMS=y
 CONFIG_KALLSYMS_BASE_RELATIVE=y
 CONFIG_PRINTK=y
 CONFIG_PRINTK_NMI=y
-# CONFIG_RAW_PRINTK is not set
+CONFIG_RAW_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
@@ -1079,6 +1079,14 @@ CONFIG_IPIPE_CORE_APIREV=2
 CONFIG_IPIPE_WANT_APIREV_2=y
 CONFIG_IPIPE_TARGET_APIREV=2
 CONFIG_IPIPE_HAVE_HOSTRT=y
+
+#
+# CAUTION: DEBUG_LL must be selected, and properly configured for
+#
+
+#
+# RAW_PRINTK to work. Otherwise, you will get no output on raw_printk()
+#
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
@@ -6820,8 +6828,11 @@ CONFIG_SECTION_MISMATCH_WARN_ONLY=y
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


