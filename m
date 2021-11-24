From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH 1/2] cobalt/trace: dovetail: improve xntrace_user_stop to
 replace TODO
Date: Tue, 23 Nov 2021 20:40:57 -0500
Message-Id: <20211124014058.12195-2-hongzhan.chen@intel.com>
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

xntrace_user_stop is widely similar to xntrace_user_freeze, call
trace_cobalt_trigger to improve it.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 include/cobalt/kernel/dovetail/pipeline/trace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/trace.h b/include/cobalt/kernel/dovetail/pipeline/trace.h
index 513d9b48b..68b5fdb23 100644
--- a/include/cobalt/kernel/dovetail/pipeline/trace.h
+++ b/include/cobalt/kernel/dovetail/pipeline/trace.h
@@ -51,7 +51,8 @@ static inline int xntrace_user_start(void)
 
 static inline int xntrace_user_stop(unsigned long v)
 {
-	TODO();
+	trace_cobalt_trace_longval(0, v);
+	trace_cobalt_trigger("user-stop");
 	return 0;
 }
 
-- 
2.17.1


