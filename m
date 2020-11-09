From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 02/15] cobalt/sched: call irq_pipeline_send_remote to send
 RESCHEDULE_OOB_IPI
Date: Mon,  9 Nov 2020 02:50:14 -0500
Message-Id: <20201109075027.14760-2-hongzhan.chen@intel.com>
In-Reply-To: <20201109075027.14760-1-hongzhan.chen@intel.com>
References: <20201109075027.14760-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan.kiszka@siemens.com, xenomai@xenomai.org

call irq_pipeline_send_remote to send RESCHEDULE_OOB_IPI instead
of ipipe_send_ipi

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 kernel/cobalt/sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index 36eff09d4..5f090ec79 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -937,8 +937,8 @@ static inline int test_resched(struct xnsched *sched)
 	/* Send resched IPI to remote CPU(s). */
 	if (unlikely(!cpumask_empty(&sched->resched))) {
 		smp_mb();
-#warning TODO
-		//ipipe_send_ipi(IPIPE_RESCHEDULE_IPI, sched->resched);
+		irq_pipeline_send_remote(RESCHEDULE_OOB_IPI,
+				&sched->resched);
 		cpumask_clear(&sched->resched);
 	}
 #endif
-- 
2.17.1


