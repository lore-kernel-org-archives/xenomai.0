From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Date: Fri, 21 Dec 2012 14:26:14 +0100
Message-Id: <1356096375-29859-10-git-send-email-wolfgang.mauerer@siemens.com>
In-Reply-To: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
References: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
Subject: [Xenomai] [PATCH 09/10] ipipe: Fix CONFIG_PREEMPT build
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

API change: ipipe_root_domain_p -> ipipe_root_p

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
---
 kernel/sched/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9fdcc22..d8e0e9e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3558,7 +3558,7 @@ asmlinkage void __sched notrace preempt_schedule(void)
 	 * we do not want to preempt the current task. Just return..
 	 */
 	if (likely(ti->preempt_count || irqs_disabled() ||
-		   !ipipe_root_domain_p))
+		   !ipipe_root_p))
 		return;
 
 	do {
-- 
1.7.1


