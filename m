From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 7/8] ipipe: Call present ack and end handlers for timer irq
 unconditionally
Date: Wed, 27 Mar 2019 14:18:06 +0100
Message-Id: <052cfd1fd8ec6d74182aeccc7f7eb645e8ae4af8.1553692686.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1553692686.git.jan.kiszka@siemens.com>
References: <cover.1553692686.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1553692686.git.jan.kiszka@siemens.com>
References: <cover.1553692686.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

These steps must be done unconditionally, because if
__ipipe_ack_hrtimer_irq() is called, the tick event will be delivered to
the head domain next, which will neither call ipipe_end() for a tick
event, nor propagate such event to the root stage (at least not using
the same IRQ line).

This plugs a race for timers that are per-CPU but share the same
interrupt number. When setting them up, there is a window where the
first CPU already called ipipe_request_irq, but some other CPU did not
yet ran through grab_timer, thus have ipipe_stolen = 0.

It also solves boot issues with the TSC deadline timer in use.

Based on reasoning provided by Philippe Gerum.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/ipipe/timer.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/ipipe/timer.c b/kernel/ipipe/timer.c
index 5532be93e951..1471a4ed85ea 100644
--- a/kernel/ipipe/timer.c
+++ b/kernel/ipipe/timer.c
@@ -367,15 +367,18 @@ static void __ipipe_ack_hrtimer_irq(struct irq_desc *desc)
 {
 	struct ipipe_timer *timer = __ipipe_raw_cpu_read(percpu_timer);
 
+	/*
+	 * Pseudo-IRQs like pipelined IPIs have no descriptor, we have
+	 * to check for this.
+	 */
 	if (desc)
 		desc->ipipe_ack(desc);
 
-	if (timer->host_timer->ipipe_stolen) {
-		if (timer->ack)
-			timer->ack();
-		if (desc)
-			desc->ipipe_end(desc);
-	}
+	if (timer->ack)
+		timer->ack();
+
+	if (desc)
+		desc->ipipe_end(desc);
 }
 
 static int do_set_oneshot(struct clock_event_device *cdev)
-- 
2.16.4


