From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC] simplify wait_for_rcu_grace_period
Message-ID: <1498b3cc-767f-703c-116b-ae102be3e510@siemens.com>
Date: Fri, 31 Jan 2020 21:43:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Philippe,

any reason why you didn't use synchronize_rcu for 
wait_for_rcu_grace_period back then?

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 31d9ceac0f..59038a84cd 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -1596,31 +1596,12 @@ out:
 }
 EXPORT_SYMBOL_GPL(xnthread_cancel);
 
-struct wait_grace_struct {
-	struct completion done;
-	struct rcu_head rcu;
-};
-
-static void grace_elapsed(struct rcu_head *head)
-{
-	struct wait_grace_struct *wgs;
-
-	wgs = container_of(head, struct wait_grace_struct, rcu);
-	complete(&wgs->done);
-}
-
 static void wait_for_rcu_grace_period(struct pid *pid)
 {
-	struct wait_grace_struct wait = {
-		.done = COMPLETION_INITIALIZER_ONSTACK(wait.done),
-	};
 	struct task_struct *p;
-
-	init_rcu_head_on_stack(&wait.rcu);
 	
 	for (;;) {
-		call_rcu(&wait.rcu, grace_elapsed);
-		wait_for_completion(&wait.done);
+		synchronize_rcu();
 		if (pid == NULL)
 			break;
 		rcu_read_lock();
@@ -1628,7 +1609,6 @@ static void wait_for_rcu_grace_period(struct pid *pid)
 		rcu_read_unlock();
 		if (p == NULL)
 			break;
-		reinit_completion(&wait.done);
 	}
 }


I'm currently debugging a hanging xnthread_join in 
wait_for_rcu_grace_period and stumbled over this (both variants hang 
equally well, though).

Jan
 
-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

