Message-ID: <49B4EE44.3070109@domain.hid>
Date: Mon, 09 Mar 2009 11:24:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49B3AA0E.5020805@domain.hid> <49B4E102.5050904@domain.hid>
In-Reply-To: <49B4E102.5050904@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v2] nucleus: Cleanup taskexit hook
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

[ Updated according to discussion. ]

xnshadow_relax is no longer needed as do_exit, the caller of this hook,
always runs in secondary mode, ie. over the ROOT thread. Enforce this
assumptions by leaving a XENO_BUGON behind.

And as the target thread is relaxed already, ie. suspended, there is
also no need for explicit reschedule. But keep xnpod_schedule for the
case the exit hook caused a prio change to the ROOT thread.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/nucleus/shadow.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index e2f2968..416e675 100644
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
@@ -2193,7 +2192,6 @@ static inline void do_taskexit_event(struct task_struct *p)
 	xnthread_archtcb(thread)->user_task = NULL;
 	/* xnpod_delete_thread() -> hook -> xnshadow_unmap(). */
 	xnpod_delete_thread(thread);
-	xnsched_set_resched(thread->sched);
 	xnlock_put_irqrestore(&nklock, s);
 	xnpod_schedule();
 

