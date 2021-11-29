From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH v2 1/2] cobalt/trace: dovetail: improve xntrace_user_stop and
 xntrace_user_start
Date: Sun, 28 Nov 2021 20:03:56 -0500
Message-Id: <20211129010357.20263-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

xntrace_user_stop is widely similar to xntrace_user_freeze, call
trace_cobalt_trigger to improve it and also make xntrace_user_start visible
to balance them.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 include/cobalt/kernel/dovetail/pipeline/trace.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/trace.h b/include/cobalt/kernel/dovetail/pipeline/trace.h
index 513d9b48b..479191e0e 100644
--- a/include/cobalt/kernel/dovetail/pipeline/trace.h
+++ b/include/cobalt/kernel/dovetail/pipeline/trace.h
@@ -45,13 +45,14 @@ static inline int xntrace_max_reset(void)
 
 static inline int xntrace_user_start(void)
 {
-	TODO();
+	trace_cobalt_trigger("user-start");
 	return 0;
 }
 
 static inline int xntrace_user_stop(unsigned long v)
 {
-	TODO();
+	trace_cobalt_trace_longval(0, v);
+	trace_cobalt_trigger("user-stop");
 	return 0;
 }
 
-- 
2.17.1


