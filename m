From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH] tracing: irq_pipeline: export missing symbols
Date: Thu, 10 Jun 2021 09:29:15 +0200
Message-Id: <20210610072915.3832992-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/trace/trace_preemptirq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 261ea4101d018ac..2b4110cf6ea2824 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -124,6 +124,8 @@ void trace_hardirqs_off_pipelined(void)
 	if (running_inband())
 		trace_hardirqs_off();
 }
+EXPORT_SYMBOL(trace_hardirqs_off_pipelined);
+NOKPROBE_SYMBOL(trace_hardirqs_off_pipelined);
 
 void trace_hardirqs_on_pipelined(void)
 {
@@ -142,6 +144,8 @@ void trace_hardirqs_on_pipelined(void)
 		unstall_inband_nocheck();
 	}
 }
+EXPORT_SYMBOL(trace_hardirqs_on_pipelined);
+NOKPROBE_SYMBOL(trace_hardirqs_on_pipelined);
 
 #else
 
@@ -149,11 +153,15 @@ void trace_hardirqs_off_pipelined(void)
 {
 	trace_hardirqs_off();
 }
+EXPORT_SYMBOL(trace_hardirqs_off_pipelined);
+NOKPROBE_SYMBOL(trace_hardirqs_off_pipelined);
 
 void trace_hardirqs_on_pipelined(void)
 {
 	trace_hardirqs_on();
 }
+EXPORT_SYMBOL(trace_hardirqs_on_pipelined);
+NOKPROBE_SYMBOL(trace_hardirqs_on_pipelined);
 
 #endif
 
-- 
2.31.1


