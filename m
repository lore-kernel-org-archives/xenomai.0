From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH v3 2/7][wip/dovetail] cobalt/sched: call
 irq_pipeline_send_remote to send TIMER_OOB_IPI
Date: Wed, 28 Oct 2020 22:15:35 -0400
Message-Id: <20201029021540.2824-2-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

call irq_pipeline_send_remote to send TIMER_OOB_IPI instead
of ipipe_send_ipi

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 kernel/cobalt/sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index 36eff09d4..4ecbcc3fc 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -937,8 +937,8 @@ static inline int test_resched(struct xnsched *sched)
 	/* Send resched IPI to remote CPU(s). */
 	if (unlikely(!cpumask_empty(&sched->resched))) {
 		smp_mb();
-#warning TODO
-		//ipipe_send_ipi(IPIPE_RESCHEDULE_IPI, sched->resched);
+		irq_pipeline_send_remote(TIMER_OOB_IPI,
+				&sched->resched);
 		cpumask_clear(&sched->resched);
 	}
 #endif
-- 
2.17.1


