From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH 2/2] cobalt/trace: dovetail: remove TODO and return -ENOSYS
 for unportable features
Date: Tue, 23 Nov 2021 20:40:58 -0500
Message-Id: <20211124014058.12195-3-hongzhan.chen@intel.com>
In-Reply-To: <20211124014058.12195-1-hongzhan.chen@intel.com>
References: <20211124014058.12195-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Some of the features are unportable because ftrace does not
provide equivalent functionality to the ipipe tracer (namely double
buffering so that you can continue to record in flight-recorder mode
while a previous recording remains available).

We remove TODO to pass allyesconfig make.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 .../cobalt/kernel/dovetail/pipeline/trace.h    | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/trace.h b/include/cobalt/kernel/dovetail/pipeline/trace.h
index 68b5fdb23..1a2e86cc1 100644
--- a/include/cobalt/kernel/dovetail/pipeline/trace.h
+++ b/include/cobalt/kernel/dovetail/pipeline/trace.h
@@ -27,26 +27,22 @@
 
 static inline int xntrace_max_begin(unsigned long v)
 {
-	TODO();
-	return 0;
+	return -ENOSYS;
 }
 
 static inline int xntrace_max_end(unsigned long v)
 {
-	TODO();
-	return 0;
+	return -ENOSYS;
 }
 
 static inline int xntrace_max_reset(void)
 {
-	TODO();
-	return 0;
+	return -ENOSYS;
 }
 
 static inline int xntrace_user_start(void)
 {
-	TODO();
-	return 0;
+	return -ENOSYS;
 }
 
 static inline int xntrace_user_stop(unsigned long v)
@@ -96,14 +92,12 @@ static inline int xntrace_tick(unsigned long delay_ticks) /* ns */
 
 static inline int xntrace_panic_freeze(void)
 {
-	TODO();
-	return 0;
+	return -ENOSYS;
 }
 
 static inline int xntrace_panic_dump(void)
 {
-	TODO();
-	return 0;
+	return -ENOSYS;
 }
 
 static inline bool xntrace_enabled(void)
-- 
2.17.1


