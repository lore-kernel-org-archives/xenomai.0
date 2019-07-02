From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/2] ipipe: Restore trace_hardirqs_on_virt_caller
Date: Tue,  2 Jul 2019 18:32:26 +0200
Message-Id: <b8eea59c3403f307022712574ed49aee80aa8a08.1562085146.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1562085146.git.jan.kiszka@siemens.com>
References: <cover.1562085146.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1562085146.git.jan.kiszka@siemens.com>
References: <cover.1562085146.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Lost in d7fc2c06edc9 ("lockdep: ipipe: exclude the head stage from IRQ
state tracing") but still needed by x86 at least.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/trace/trace_preemptirq.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 3c482c02c1d9..19605695a6a2 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -66,6 +66,17 @@ __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
 }
 EXPORT_SYMBOL(trace_hardirqs_on_caller);
 
+__visible void trace_hardirqs_on_virt_caller(unsigned long ip)
+{
+	/*
+	 * The IRQ tracing logic only applies to the root domain, and
+	 * must consider the virtual disable flag exclusively when
+	 * leaving an interrupt/fault context.
+	 */
+	if (ipipe_root_p && !irqs_disabled())
+		trace_hardirqs_on_caller(ip);
+}
+
 __visible void trace_hardirqs_on_virt(void)
 {
 	/*
-- 
2.16.4


