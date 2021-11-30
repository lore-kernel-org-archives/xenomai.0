From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH 1/2] cobalt/trace: dovetail: remove TODO and return -ENOSYS
 for unportable features
Date: Tue, 30 Nov 2021 02:31:39 -0500
Message-Id: <20211130073140.14252-1-hongzhan.chen@intel.com>
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

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/include/cobalt/kernel/dovetail/pipeline/trace.h b/include/cobalt/kernel/dovetail/pipeline/trace.h
index 479191e0e..7147ab183 100644
--- a/include/cobalt/kernel/dovetail/pipeline/trace.h
+++ b/include/cobalt/kernel/dovetail/pipeline/trace.h
@@ -27,20 +27,17 @@
 
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
-- 
2.17.1


