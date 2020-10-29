From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH v3 4/7][wip/dovetail] cobalt/clock: call
 irq_pipeline_send_remote to trigger interrupt TIMER_OOB_IPI
Date: Wed, 28 Oct 2020 22:15:37 -0400
Message-Id: <20201029021540.2824-4-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

call irq_pipeline_send_remote to trigger interrupt TIMER_OOB_IPI

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 kernel/cobalt/clock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
index 9716a0391..ab9fa394d 100644
--- a/kernel/cobalt/clock.c
+++ b/kernel/cobalt/clock.c
@@ -235,7 +235,8 @@ void xnclock_core_remote_shot(struct xnsched *sched)
 #ifdef CONFIG_IPIPE
 	ipipe_send_ipi(IPIPE_HRTIMER_IPI, *cpumask_of(xnsched_cpu(sched)));
 #else
-#warning TODO
+	irq_pipeline_send_remote(TIMER_OOB_IPI,
+			cpumask_of(xnsched_cpu(sched)));
 #endif
 }
 #endif
-- 
2.17.1


