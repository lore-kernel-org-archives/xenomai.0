From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 5/9] cobalt/thread: Switch to MAX_RT_PRIO
Date: Wed, 13 Oct 2021 13:55:49 +0200
Message-Id: <527a4f0274527f0246a7d7842f1c4c788a05313c.1634126152.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1634126152.git.jan.kiszka@siemens.com>
References: <cover.1634126152.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Identical to MAX_USER_RT_PRIO which was removed in 5.12.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/thread.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 2c1ec6d3a4..2e1667d197 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2008,8 +2008,8 @@ void __xnthread_propagate_schedparam(struct xnthread *curr)
 	 */
 	if (xnthread_test_state(curr, XNWEAK) && kprio == 0)
 		kpolicy = SCHED_NORMAL;
-	else if (kprio >= MAX_USER_RT_PRIO)
-		kprio = MAX_USER_RT_PRIO - 1;
+	else if (kprio >= MAX_RT_PRIO)
+		kprio = MAX_RT_PRIO - 1;
 
 	if (p->policy != kpolicy || (kprio > 0 && p->rt_priority != kprio)) {
 		param.sched_priority = kprio;
-- 
2.31.1


