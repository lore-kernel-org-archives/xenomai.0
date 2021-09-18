From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH] recipes-kernel: disable more debugs that influence latency
 performance
Date: Fri, 17 Sep 2021 21:08:50 -0400
Message-Id: <20210918010850.23821-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

For dovetail-based xenomai, max lat may drop from 203.800 us
to 9.807 us in 10 hours stressed latency test on Maxtang 8565U board
with lava test.

diff --git a/recipes-kernel/linux/files/common_nodbg.cfg b/recipes-kernel/linux/files/common_nodbg.cfg
index d7d87c5..29b3522 100644
--- a/recipes-kernel/linux/files/common_nodbg.cfg
+++ b/recipes-kernel/linux/files/common_nodbg.cfg
@@ -1,2 +1,9 @@
 # CONFIG_IPIPE_DEBUG is not set
 # CONFIG_XENO_OPT_DEBUG is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
+# CONFIG_DEBUG_RWSEMS is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
-- 
2.17.1


