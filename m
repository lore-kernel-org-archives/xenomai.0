Message-ID: <49B4E102.5050904@domain.hid>
Date: Mon, 09 Mar 2009 10:27:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49B3AA0E.5020805@domain.hid>
In-Reply-To: <49B3AA0E.5020805@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] nucleus: Cleanup taskexit hook
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

[ Enhanced version, removing more unneeded code. ]

xnshadow_relax is no longer needed as do_exit, the caller of this hook,
always runs in secondary mode, ie. over the ROOT thread. Enforce this
assumptions by leaving a XENO_BUGON behind.

And as the target thread is relaxed already, ie. suspended, there is
also no need for a reschedule. Drop the related code.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/nucleus/shadow.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index e2f2968..1f90054 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -2179,12 +2179,11 @@ static inline void do_taskexit_event(struct task_struct *p)
 	if (!thread)
 		return;
 
+	XENO_BUGON(NUCLEUS, !xnpod_root_p());
+
 	if (xnthread_test_state(thread, XNDEBUG))
 		unlock_timers();
 
-	if (xnpod_shadow_p())
-		xnshadow_relax(0);
-
 	magic = xnthread_get_magic(thread);
 
 	xnlock_get_irqsave(&nklock, s);
@@ -2193,9 +2192,10 @@ static inline void do_taskexit_event(struct task_struct *p)
 	xnthread_archtcb(thread)->user_task = NULL;
 	/* xnpod_delete_thread() -> hook -> xnshadow_unmap(). */
 	xnpod_delete_thread(thread);
-	xnsched_set_resched(thread->sched);
 	xnlock_put_irqrestore(&nklock, s);
-	xnpod_schedule();
+
+	/* The deleted thread was suspended (relaxed), so there is no need for
+	   reschedule. */
 
 	xnshadow_dereference_skin(magic);
 	trace_mark(xn_nucleus, shadow_exit, "thread %p thread_name %s",


