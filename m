From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 4.19 & 5.4] ftrace: ipipe: Fix hardening of
 trace_recursive_lock
Message-ID: <3c22d72d-351e-ed2f-372a-ab5a1af5f38f@siemens.com>
Date: Sun, 14 Mar 2021 17:09:06 +0100
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
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

cpu_buffer->current_context is supposed to be protected by irq
disabling, just like in dovetail.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

No-arch branches updated with this already.

 kernel/trace/ring_buffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index dfaeee5b54e3..90be9e613887 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2726,9 +2726,9 @@ rb_wakeups(struct ring_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 static __always_inline int
 trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	unsigned int val = cpu_buffer->current_context;
 	unsigned long pc = preempt_count();
 	unsigned long flags;
+	unsigned int val;
 	int bit;
 
 	if (!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
@@ -2739,6 +2739,8 @@ trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 
 	flags = hard_local_irq_save();
 
+	val = cpu_buffer->current_context;
+
 	if (unlikely(val & (1 << (bit + cpu_buffer->nest)))) {
 		/*
 		 * It is possible that this was called by transitioning
-- 
2.26.2

