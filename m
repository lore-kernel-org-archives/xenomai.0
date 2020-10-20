From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 3/4][wip/dovetail] cobalt/clock: call irq_pipeline_send_remote
 to trigger interrupt TIMER_OOB_IPI
Date: Tue, 20 Oct 2020 03:15:23 -0400
Message-Id: <20201020071523.22958-1-hongzhan.chen@intel.com>
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

diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
index 9716a0391..1ab29e9e7 100644
--- a/kernel/cobalt/clock.c
+++ b/kernel/cobalt/clock.c
@@ -236,6 +236,8 @@ void xnclock_core_remote_shot(struct xnsched *sched)
 	ipipe_send_ipi(IPIPE_HRTIMER_IPI, *cpumask_of(xnsched_cpu(sched)));
 #else
 #warning TODO
+	irq_pipeline_send_remote(TIMER_OOB_IPI,
+			cpumask_of(xnsched_cpu(sched)));
 #endif
 }
 #endif
-- 
2.17.1


