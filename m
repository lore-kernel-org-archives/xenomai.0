From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 1/4][wip/dovetail] cobalt/sched: call irq_pipeline_send_remote
 to send TIMER_OOB_IPI
Date: Tue, 20 Oct 2020 03:14:57 -0400
Message-Id: <20201020071457.22856-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

call call irq_pipeline_send_remote to send TIMER_OOB_IPI instead
of ipipe_send_ipi

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index 82a51ce93..0a40d58d7 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -945,6 +945,8 @@ static inline int test_resched(struct xnsched *sched)
 		smp_mb();
 #warning TODO
 		//ipipe_send_ipi(IPIPE_RESCHEDULE_IPI, sched->resched);
+		irq_pipeline_send_remote(TIMER_OOB_IPI,
+				&sched->resched);
 		cpumask_clear(&sched->resched);
 	}
 #endif
-- 
2.17.1


