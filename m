Message-ID: <5047B2B3.2050309@xenomai.org>
Date: Wed, 05 Sep 2012 22:14:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANKLDmsO-1E7+d9X6-t532RJ=CWY4P4x30nCNCwgHffJjAFkDA@mail.gmail.com>	<50460BCE.8010505@xenomai.org>	<CANKLDmtmnbAb7PM4URTjxYtaH5WnvGjVcEPOpSNr2A6gPwLLaA@mail.gmail.com>	<50464969.2000902@xenomai.org>	<5046549C.7030008@xenomai.org>	<CANKLDmufv25Bngqb3CapS6ybHG9DH76DUq1q6dinzJ5ai7TowA@mail.gmail.com>	<5046FF0A.9000208@xenomai.org>	<CANKLDmverDgL3c2BEtXAwkGhq7KLRopGnM3q9Z_TQiAAeMponw@mail.gmail.com>	<50470D2D.8020004@xenomai.org>	<CANKLDmudbBw5gyWVe_nPSLkQTopaH0ajs3FXgJottn84Cm6anQ@mail.gmail.com>	<5047318D.8060106@xenomai.org>	<504735A6.5040800@xenomai.org>
	<CANKLDmtbOPWG_bc3=pcbSpgbEvSj=5ZsiXm3CWgBCwBx=yQ8Pw@mail.gmail.com>
In-Reply-To: <CANKLDmtbOPWG_bc3=pcbSpgbEvSj=5ZsiXm3CWgBCwBx=yQ8Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel NULL pointer dereference
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henri Roosen <henriroosen@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 09/05/2012 02:10 PM, Henri Roosen wrote:

> On Wed, Sep 5, 2012 at 1:21 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>>> Anyway, what seems to happen is that your application calls exit, while
>>> some thread was waiting for a a PI mutex, the nucleus tries to send a
>>> signal to the mutex holder. However, something gets wrong, and the mutex
>>> holder task pointer is invalid.
>>>
>>> What is strange, also, is how a task can be waiting for a mutex and
>>> calling exit at the same time. Could you try to increase the number of
>>> trace points to say 1000 points?
>>
>>
>> Answering myself. The thread killed is the one holding the mutex. The
>> signal is sent to this precise thread, so this may fail because the
>> thread is in the process of being destroyed, and its user_task pointer
>> is no longer valid.
> 
> Please find attached ipipe_trace_2.txt that has the number of
> tracepoints to 1000. Note that this log also doesn't trace whether
> irqs are off (arch_irqs_disable_flags is not in the current ipipe tree
> yet either).
> 
> I will find out why the application is doing a sys_exit. However I'm
> not sure how this is related to the thread affinity; when not setting
> the affinity, the problem is not reproducable.


Please try the following patch, it should avoid the bug, but I will 
wait for Philippe's ack before pushing it:

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 260fdef..1f1a737 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -274,7 +274,9 @@ static void rpi_update(struct xnthread *thread)
 	if (rpi_p(thread)) {
 		xnsched_pop_rpi(thread);
 		thread->rpi = NULL;
-		rpi_push(sched, thread);
+
+		if (xnthread_user_task(thread))
+			rpi_push(sched, thread);
 	}
 
 	xnlock_put_irqrestore(&sched->rpilock, s);
@@ -1516,15 +1518,18 @@ EXPORT_SYMBOL_GPL(xnshadow_start);
 /* Called with nklock locked, Xenomai interrupts off. */
 void xnshadow_renice(struct xnthread *thread)
 {
-	/*
-	 * We need to bound the priority values in the
-	 * [1..MAX_RT_PRIO-1] range, since the Xenomai priority scale
-	 * is a superset of the Linux priority scale.
-	 */
-	int prio = normalize_priority(thread->cprio);
+	if (xnthread_user_task(thread)) {
+		/*
+		 * We need to bound the priority values in the
+		 * [1..MAX_RT_PRIO-1] range, since the Xenomai priority scale
+		 * is a superset of the Linux priority scale.
+		 */
+		int prio = normalize_priority(thread->cprio);
 
-	xnshadow_send_sig(thread, SIGSHADOW,
-			  sigshadow_int(SIGSHADOW_ACTION_RENICE, prio), 1);
+		xnshadow_send_sig
+			(thread, SIGSHADOW,
+			 sigshadow_int(SIGSHADOW_ACTION_RENICE, prio), 1);
+	}
 
 	if (!xnthread_test_state(thread, XNDORMANT) &&
 	    xnthread_sched(thread) == xnpod_current_sched())


-- 
                                                                Gilles.

