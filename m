Message-ID: <48D752BA.3000403@domain.hid>
Date: Mon, 22 Sep 2008 10:09:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48CE7BD7.6060504@domain.hid>
	<48D620DB.2070101@domain.hid>	<48D688EE.7010404@domain.hid>
	<48D68D6D.9070909@domain.hid> <48D69A7A.7090302@domain.hid>
In-Reply-To: <48D69A7A.7090302@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH] Factor out xnsynch_acquire/release
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
> 
>> [1]http://thread.gmane.org/gmane.linux.real-time.xenomai.devel/5412/focus=5405
>>
> always-put-xnthread-base-into-registry.patch:
> 	I understand the need, but I will cowardly let Philippe decide whether
> he likes the implementation details.
> 
> handle-base-xn_sys_current-1.patch:
> 	In some places (pse51_mutex_timedlock_inner for instances) you use
> XN_NO_HANDLE, in others (pse51_mutex_timedlock for instances) you use
> NULL, are the two equivalents ? If yes, should not we always use the
> same consistently ? Otherwise looks ok.

I fail to find the NULL spots - which pse51_mutex_timedlock do you mean?

> 
> remove-xnarch_atomic_intptr.patch:
> 	Ok.
> 
> spread-xeno_set_current.patch:
> 	Ok. This is even a bug fix.
> 
> xnsynch refactoring:
> 	things have moved too much to see what has really changed in
> xnsynch_wakeup_one_sleeper and xnsynch_sleep_on. But is not there a
> common behaviour between the old and new services that could be factored
> ? But otherwise I agree with the general idea of the patch, this is what
> we had discussed with Philippe.

Yes, the diff is unfortunate due to a reordering of the function within
synch.c. Here is a direct diff of both services:

--- a	2008-09-22 10:06:56.000000000 +0200
+++ b	2008-09-22 10:07:39.000000000 +0200
@@ -1,112 +1,47 @@
 void xnsynch_sleep_on(xnsynch_t *synch, xnticks_t timeout,
 		      xntmode_t timeout_mode)
 {
-	xnthread_t *thread = xnpod_current_thread(), *owner;
+	xnthread_t *thread = xnpod_current_thread();
 	spl_t s;
 
+	XENO_BUGON(NUCLEUS, testbits(synch->status, XNSYNCH_OWNER));
+
 	xnlock_get_irqsave(&nklock, s);
 
 	trace_mark(xn_nucleus_synch_sleepon,
 		   "thread %p thread_name %s synch %p",
 		   thread, xnthread_name(thread), synch);
 
-	if (!testbits(synch->status, XNSYNCH_PRIO)) { /* i.e. FIFO */
+	if (!testbits(synch->status, XNSYNCH_PRIO)) /* i.e. FIFO */
 		appendpq(&synch->pendq, &thread->plink);
-		xnpod_suspend_thread(thread, XNPEND, timeout, timeout_mode, synch);
-		goto unlock_and_exit;
-	}
-
-	if (!testbits(synch->status, XNSYNCH_PIP)) { /* i.e. no ownership */
-		insertpqf(&synch->pendq, &thread->plink, thread->cprio);
-		xnpod_suspend_thread(thread, XNPEND, timeout, timeout_mode, synch);
-		goto unlock_and_exit;
-	}
-
-redo:
-	owner = synch->owner;
-
-	if (!owner) {
-		synch->owner = thread;
-		xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK);
-		goto unlock_and_exit;
-	}
-
-	if (thread->cprio > owner->cprio) {
-		if (xnthread_test_info(owner, XNWAKEN) && owner->wwake == synch) {
-			/* Ownership is still pending, steal the resource. */
-			synch->owner = thread;
-			xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK);
-			xnthread_set_info(owner, XNROBBED);
-			goto unlock_and_exit;
-		}
-
-		if (!xnthread_test_state(owner, XNBOOST)) {
-			owner->bprio = owner->cprio;
-			xnthread_set_state(owner, XNBOOST);
-		}
-
-		if (testbits(synch->status, XNSYNCH_CLAIMED))
-			removepq(&owner->claimq, &synch->link);
-		else
-			__setbits(synch->status, XNSYNCH_CLAIMED);
-
-		insertpqf(&owner->claimq, &synch->link, thread->cprio);
-		insertpqf(&synch->pendq, &thread->plink, thread->cprio);
-		xnsynch_renice_thread(owner, thread->cprio);
-	} else
+	else /* i.e. priority-sorted */
 		insertpqf(&synch->pendq, &thread->plink, thread->cprio);
 
 	xnpod_suspend_thread(thread, XNPEND, timeout, timeout_mode, synch);
 
-	if (xnthread_test_info(thread, XNRMID | XNTIMEO | XNBREAK))
-		goto unlock_and_exit;
-
-	if (xnthread_test_info(thread, XNROBBED)) {
-		/* Somebody stole us the ownership while we were ready
-		   to run, waiting for the CPU: we need to wait again
-		   for the resource. */
-		if (timeout_mode != XN_RELATIVE || timeout == XN_INFINITE)
-			goto redo;
-		timeout = xntimer_get_timeout_stopped(&thread->rtimer);
-		if (timeout > 1) /* Otherwise, it's too late. */
-			goto redo;
-		xnthread_set_info(thread, XNTIMEO);
-	}
-
-      unlock_and_exit:
-
-	thread->wwake = NULL;
-	xnthread_clear_info(thread, XNWAKEN);
-
 	xnlock_put_irqrestore(&nklock, s);
 }
 
 xnthread_t *xnsynch_wakeup_one_sleeper(xnsynch_t *synch)
 {
-	xnthread_t *thread = NULL, *lastowner;
+	xnthread_t *thread = NULL;
 	xnpholder_t *holder;
 	spl_t s;
 
+	XENO_BUGON(NUCLEUS, testbits(synch->status, XNSYNCH_OWNER));
+
 	xnlock_get_irqsave(&nklock, s);
 
-	lastowner = synch->owner;
 	holder = getpq(&synch->pendq);
 
 	if (holder) {
 		thread = link2thread(holder, plink);
 		thread->wchan = NULL;
-		thread->wwake = synch;
-		synch->owner = thread;
-		xnthread_set_info(thread, XNWAKEN);
 		trace_mark(xn_nucleus_synch_wakeup_one,
 			   "thread %p thread_name %s synch %p",
 			   thread, xnthread_name(thread), synch);
 		xnpod_resume_thread(thread, XNPEND);
-	} else
-		synch->owner = NULL;
-
-	if (testbits(synch->status, XNSYNCH_CLAIMED))
-		xnsynch_clear_boost(synch, lastowner);
+	}
 
 	xnlock_put_irqrestore(&nklock, s);
 

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

