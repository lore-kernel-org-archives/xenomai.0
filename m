From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <73ef1d0b-0a83-4351-e4b5-2a544956af86@siemens.com>
Date: Fri, 26 Jan 2018 19:32:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] cobalt/intr: Move IRQ exit trace point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

It can be confusing for people reading a trace when a context switch due
to a wake up in the IRQ handler comes before the handler was left. Move
the exit instrumentation before the schedule, just like we already do in
the clock handler.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/intr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cobalt/intr.c b/kernel/cobalt/intr.c
index 14dc0b35e..fb27a3295 100644
--- a/kernel/cobalt/intr.c
+++ b/kernel/cobalt/intr.c
@@ -355,12 +355,12 @@ static void xnintr_vec_handler(unsigned int irq, void *cookie)
 out:
 	xnstat_exectime_switch(sched, prev);
 
+	trace_cobalt_irq_exit(irq);
+
 	if (--sched->inesting == 0) {
 		sched->lflags &= ~XNINIRQ;
 		xnsched_run();
 	}
-
-	trace_cobalt_irq_exit(irq);
 }
 
 /*
@@ -441,12 +441,12 @@ static void xnintr_edge_vec_handler(unsigned int irq, void *cookie)
 out:
 	xnstat_exectime_switch(sched, prev);
 
+	trace_cobalt_irq_exit(irq);
+
 	if (--sched->inesting == 0) {
 		sched->lflags &= ~XNINIRQ;
 		xnsched_run();
 	}
-
-	trace_cobalt_irq_exit(irq);
 }
 
 static inline int xnintr_irq_attach(struct xnintr *intr)
-- 
2.13.6

