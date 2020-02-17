From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH ipipe-noarch] ipipe: Disable rcuidle trace path when running
 over the head domain
Message-ID: <e9561ccb-175f-8cb2-2a93-48e90f262f97@siemens.com>
Date: Mon, 17 Feb 2020 19:06:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

We do not need the special handling of __DO_TRACE(..., rcuidle=1) when
running over the head domain. In fact, we cannot use it because it
switches to srcu which is incompatible with that context. It's safe to
switch to normal RCU because no head domain caller of a trace_*_rcuidle
tracepoints should do this from rcu-problematic paths, specifically
idle.

Ported from the dovetail queue.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Philippe, does this description make sense?

Norbert, please test.

 include/linux/tracepoint.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index e9de8ad0bad7..83df22a6f284 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -21,6 +21,7 @@
 #include <linux/cpumask.h>
 #include <linux/rcupdate.h>
 #include <linux/tracepoint-defs.h>
+#include <linux/ipipe.h>
 
 struct module;
 struct tracepoint;
@@ -212,7 +213,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			__DO_TRACE(&__tracepoint_##name,		\
 				TP_PROTO(data_proto),			\
 				TP_ARGS(data_args),			\
-				TP_CONDITION(cond), 1);			\
+				TP_CONDITION(cond), ipipe_root_p);	\
 	}
 #else
 #define __DECLARE_TRACE_RCU(name, proto, args, cond, data_proto, data_args)
-- 
2.16.4

