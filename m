From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Date: Fri, 21 Dec 2012 14:26:06 +0100
Message-Id: <1356096375-29859-2-git-send-email-wolfgang.mauerer@siemens.com>
In-Reply-To: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
References: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
Subject: [Xenomai] [PATCH 01/10] ipipe: Add root domain guard to
	preempt_schedule
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

When we start allowing preempt_disable/enable over non-root domains,
there is the risk to re-enable preemption in non-root contexts. If also
TIF_NEED_RESCHED is set, this will result in a call to preempt_schedule.
Therefore we have to catch any rescheduling over non-root domains on
preempt_schedule entry.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
---
 kernel/sched/core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ec38567..9fdcc22 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3557,7 +3557,8 @@ asmlinkage void __sched notrace preempt_schedule(void)
 	 * If there is a non-zero preempt_count or interrupts are disabled,
 	 * we do not want to preempt the current task. Just return..
 	 */
-	if (likely(ti->preempt_count || irqs_disabled()))
+	if (likely(ti->preempt_count || irqs_disabled() ||
+		   !ipipe_root_domain_p))
 		return;
 
 	do {
-- 
1.7.1


