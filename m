From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC][PATCH 4/7] cobalt/kernel: Introduce XNDBGSTOP
Date: Fri, 30 Nov 2018 21:03:18 +0100
Message-Id: <9c7657a07913a18bab6f3fc7b0da95c6eb0dd3c7.1543608201.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1543608201.git.jan.kiszka@siemens.com>
References: <cover.1543608201.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1543608201.git.jan.kiszka@siemens.com>
References: <cover.1543608201.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This Introduces an additional blocking state for threads. It is used to
hold back threads after resumption by the debugger in primary mode for
coordinated continuation.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/thread.h      | 2 +-
 include/cobalt/uapi/kernel/thread.h | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
index f1f06ff0a6..03adb25296 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -38,7 +38,7 @@
  * @addtogroup cobalt_core_thread
  * @{
  */
-#define XNTHREAD_BLOCK_BITS   (XNSUSP|XNPEND|XNDELAY|XNDORMANT|XNRELAX|XNMIGRATE|XNHELD)
+#define XNTHREAD_BLOCK_BITS   (XNSUSP|XNPEND|XNDELAY|XNDORMANT|XNRELAX|XNMIGRATE|XNHELD|XNDBGSTOP)
 #define XNTHREAD_MODE_BITS    (XNRRB|XNWARN|XNTRAPLB)
 
 struct xnthread;
diff --git a/include/cobalt/uapi/kernel/thread.h b/include/cobalt/uapi/kernel/thread.h
index 04982ee0e4..0802a16dcd 100644
--- a/include/cobalt/uapi/kernel/thread.h
+++ b/include/cobalt/uapi/kernel/thread.h
@@ -51,6 +51,7 @@
 #define XNJOINED  0x00080000 /**< Another thread waits for joining this thread */
 #define XNTRAPLB  0x00100000 /**< Trap lock break (i.e. may not sleep with sched lock) */
 #define XNDEBUG   0x00200000 /**< User-level debugging enabled */
+#define XNDBGSTOP 0x00400000 /**< Stopped for synchronous debugging */
 
 /** @} */
 
@@ -101,8 +102,9 @@
  * 'r' -> Undergoes round-robin.
  * 't' -> Runtime mode errors notified.
  * 'L' -> Lock breaks trapped.
+ * 's' -> Ptraced, stopped synchronously.
  */
-#define XNTHREAD_STATE_LABELS  "SWDRU..X.HbTlrt.....L."
+#define XNTHREAD_STATE_LABELS  "SWDRU..X.HbTlrt.....L.s"
 
 struct xnthread_user_window {
 	__u32 state;
-- 
2.16.4


