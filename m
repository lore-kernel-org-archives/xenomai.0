From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Sat, 11 May 2013 19:51:33 +0200
Message-Id: <1368294693-4769-2-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <518E84CD.7010506@xenomai.org>
References: <518E84CD.7010506@xenomai.org>
Subject: [Xenomai] [PATCH 2/2] skins/posix: rework user-space thread signals
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Calling xnshadow_relax() from xnpod_schedule() signals dispatcher causes
issues with the I-pipe patch. Rely on xnshadow_call_mayday() to cause a
switch to secondary mode instead.
---
 ksrc/skins/posix/signal.c |   34 ++++++++++------------------------
 1 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/ksrc/skins/posix/signal.c b/ksrc/skins/posix/signal.c
index dfc4b77..42829a4 100644
--- a/ksrc/skins/posix/signal.c
+++ b/ksrc/skins/posix/signal.c
@@ -318,16 +318,19 @@ int pse51_sigqueue_inner(pthread_t thread, pse51_siginfo_t * si)
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	if (xnthread_test_state(&thread->threadbase, XNSHADOW)) {
 		pse51_schedule_lostage(PSE51_LO_SIGNAL_REQ, thread, 0);
+		thread->threadbase.signals = 0;
 		if (xnthread_test_state(&thread->threadbase,
 					XNDELAY|XNPEND|XNSUSP|XNRELAX)) {
 			/* Thread is suspended in a syscall, or already relaxed,
-			   we do not need to run the signal dispatcher, the
+			   we do not need to cann xnshadow_call_mayday, the
 			   signal APC will cause the sigwake_event to be
 			   generated, which will kick the thread. */
-			thread->threadbase.signals = 0;
 			return 0;
-		} else
-			return thread == pse51_current_thread();
+		} 
+
+		xnthread_set_info(&thread->threadbase, XNAMOK);
+		xnshadow_call_mayday(&thread->threadbase);
+		return thread == pse51_current_thread();
 	}
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
@@ -1086,16 +1089,6 @@ static void pse51_dispatch_signals(xnsigmask_t sigs)
 }
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
-static void pse51_dispatch_shadow_signals(xnsigmask_t sigs)
-{
-	spl_t dummy;
-	/* Migrate to secondary mode in order to get the signals delivered by
-	   Linux. */
-	xnshadow_relax(1, SIGDEBUG_MIGRATE_SIGNAL);
-	xnlock_get_irqsave(&nklock, dummy);
-	(void)dummy;
-}
-
 void pse51_signal_handle_request(pthread_t thread)
 {
 	pse51_siginfo_t *si;
@@ -1103,8 +1096,6 @@ void pse51_signal_handle_request(pthread_t thread)
 
 	xnlock_get_irqsave(&nklock, s);
 
-	thread->threadbase.signals = 0;
-
 	while ((si = pse51_getsigq(&thread->pending,
 				   &thread->pending.mask, NULL))) {
 		siginfo_t info = si->info;
@@ -1121,13 +1112,10 @@ void pse51_signal_handle_request(pthread_t thread)
 		   reschedule. */
 		xnlock_put_irqrestore(&nklock, s);
 
-		send_sig_info(info.si_signo,
-			      &info,
+		send_sig_info(info.si_signo, &info,
 			      xnthread_user_task(&thread->threadbase));
 
 		xnlock_get_irqsave(&nklock, s);
-
-		thread->threadbase.signals = 0;
 	}
 
 	xnlock_put_irqrestore(&nklock, s);
@@ -1148,14 +1136,12 @@ void pse51_signal_init_thread(pthread_t newthread, const pthread_t parent)
 		emptyset(&newthread->sigmask);
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
-	if (testbits(newthread->threadbase.state, XNSHADOW))
-		newthread->threadbase.asr = &pse51_dispatch_shadow_signals;
-	else
+	if (testbits(newthread->threadbase.state, XNSHADOW) == 0)
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 		newthread->threadbase.asr = &pse51_dispatch_signals;
 
-	newthread->threadbase.asrmode = 0;
 	newthread->threadbase.asrimask = 0;
+	newthread->threadbase.asrmode = 0;
 }
 
 /* Unqueue, and free any pending siginfo structure. Assume we are called nklock
-- 
1.7.2.5


