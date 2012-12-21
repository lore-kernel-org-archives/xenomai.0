From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Date: Fri, 21 Dec 2012 14:26:09 +0100
Message-Id: <1356096375-29859-5-git-send-email-wolfgang.mauerer@siemens.com>
In-Reply-To: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
References: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
Subject: [Xenomai] [PATCH 04/10] Harden trace_vbprintk for non-root use
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: jan.kiszka@siemens.com, wolfgang.mauerer@siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

We depend on hard-irqs being disabled to push trace_printk
data safely to ftrace.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/trace/trace.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a7fa070..a85936f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1592,8 +1592,9 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 	/* Don't pollute graph traces with trace_vprintk internals */
 	pause_graph_tracing();
 
+	flags = hard_local_irq_save();
+
 	pc = preempt_count();
-	preempt_disable_notrace();
 
 	tbuffer = get_trace_buf();
 	if (!tbuffer) {
@@ -1606,7 +1607,6 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 	if (len > TRACE_BUF_SIZE/sizeof(int) || len < 0)
 		goto out;
 
-	local_save_flags(flags);
 	size = sizeof(*entry) + sizeof(u32) * len;
 	buffer = tr->buffer;
 	event = trace_buffer_lock_reserve(buffer, TRACE_BPRINT, size,
@@ -1624,7 +1624,7 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 	}
 
 out:
-	preempt_enable_notrace();
+	hard_local_irq_restore(flags);
 	unpause_graph_tracing();
 
 	return len;
-- 
1.7.1


