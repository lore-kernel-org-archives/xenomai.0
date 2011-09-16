Message-ID: <4E73B403.1060706@domain.hid>
Date: Fri, 16 Sep 2011 22:39:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E6C927F.3070901@domain.hid>
	<4E6CC49C.1020403@domain.hid>	<4E6CC5CC.5020204@domain.hid>
	<4E73AE00.3040002@domain.hid>
In-Reply-To: <4E73AE00.3040002@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Policy switching and XNOTHER maintenance
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On 09/16/2011 10:13 PM, Gilles Chanteperdrix wrote:
> On 09/11/2011 04:29 PM, Jan Kiszka wrote:
>> On 2011-09-11 16:24, Gilles Chanteperdrix wrote:
>>> On 09/11/2011 12:50 PM, Jan Kiszka wrote:
>>>> Hi all,
>>>>
>>>> just looked into the hrescnt issue again, specifically the corner case
>>>> of a shadow thread switching from real-time policy to SCHED_OTHER.
>>>
>>> Doing this while holding a mutex looks invalid.
>>
>> Looking at POSIX e.g., is there anything in the spec that makes this
>> invalid? If the kernel preserves or established proper priority
>> boosting, I do not see what could break in principle.
>>
>> It is nothing I would design into some app, but we should somehow handle
>> it (doc update or code adjustments).
>>
>>> If we do not do it, the current code is valid.
>>
>> Except for its dependency on XNOTHER which is not updated on RT->NORMAL
>> transitions.
> 
> The fact that this update did not take place made the code work. No 
> negative rescnt could happen with that code.
> 
> Anyway, here is a patch to allow switching back from RT to NORMAL, but 
> send a SIGDEBUG to a thread attempting to release a mutex while its 
> counter is already 0. We end up avoiding a big chunk of code that would 
> have been useful for a really strange corner case.
> 

Here comes version 2:
diff --git a/include/nucleus/sched-idle.h b/include/nucleus/sched-idle.h
index 6399a17..417170f 100644
--- a/include/nucleus/sched-idle.h
+++ b/include/nucleus/sched-idle.h
@@ -39,6 +39,8 @@ extern struct xnsched_class xnsched_class_idle;
 static inline void __xnsched_idle_setparam(struct xnthread *thread,
 					   const union xnsched_policy_param *p)
 {
+	if (xnthread_test_state(thread, XNSHADOW))
+		xnthread_clear_state(thread, XNOTHER);
 	thread->cprio = p->idle.prio;
 }
 
diff --git a/include/nucleus/sched-rt.h b/include/nucleus/sched-rt.h
index 71f655c..cc1cefa 100644
--- a/include/nucleus/sched-rt.h
+++ b/include/nucleus/sched-rt.h
@@ -86,6 +86,12 @@ static inline void __xnsched_rt_setparam(struct xnthread *thread,
 					 const union xnsched_policy_param *p)
 {
 	thread->cprio = p->rt.prio;
+	if (xnthread_test_state(thread, XNSHADOW)) {
+		if (thread->cprio)
+			xnthread_clear_state(thread, XNOTHER);
+		else
+			xnthread_set_state(thread, XNOTHER);
+	}
 }
 
 static inline void __xnsched_rt_getparam(struct xnthread *thread,
diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 9a02e80..d19999f 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -1896,16 +1896,6 @@ int __xnpod_set_thread_schedparam(struct xnthread *thread,
 		xnsched_putback(thread);
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
-	/*
-	 * A non-real-time shadow may upgrade to real-time FIFO
-	 * scheduling, but the latter may never downgrade to
-	 * SCHED_NORMAL Xenomai-wise. In the valid case, we clear
-	 * XNOTHER to reflect the change. Note that we keep handling
-	 * non real-time shadow specifics in higher code layers, not
-	 * to pollute the core scheduler with peculiarities.
-	 */
-	if (sched_class == &xnsched_class_rt && sched_param->rt.prio > 0)
-		xnthread_clear_state(thread, XNOTHER);
 	if (propagate) {
 		if (xnthread_test_state(thread, XNRELAX))
 			xnshadow_renice(thread);
diff --git a/ksrc/nucleus/sched-sporadic.c b/ksrc/nucleus/sched-sporadic.c
index fd37c21..ffc9bab 100644
--- a/ksrc/nucleus/sched-sporadic.c
+++ b/ksrc/nucleus/sched-sporadic.c
@@ -258,6 +258,8 @@ static void xnsched_sporadic_setparam(struct xnthread *thread,
 		}
 	}
 
+	if (xnthread_test_state(thread, XNSHADOW))
+		xnthread_clear_state(thread, XNOTHER);
 	thread->cprio = p->pss.current_prio;
 }
 
diff --git a/ksrc/nucleus/sched-tp.c b/ksrc/nucleus/sched-tp.c
index 43a548e..a2af1d3 100644
--- a/ksrc/nucleus/sched-tp.c
+++ b/ksrc/nucleus/sched-tp.c
@@ -100,6 +100,8 @@ static void xnsched_tp_setparam(struct xnthread *thread,
 {
 	struct xnsched *sched = thread->sched;
 
+	if (xnthread_test_state(thread, XNSHADOW))
+		xnthread_clear_state(thread, XNOTHER);
 	thread->tps = &sched->tp.partitions[p->tp.ptid];
 	thread->cprio = p->tp.prio;
 }
diff --git a/ksrc/nucleus/synch.c b/ksrc/nucleus/synch.c
index b956e46..47bc0c5 100644
--- a/ksrc/nucleus/synch.c
+++ b/ksrc/nucleus/synch.c
@@ -684,9 +684,13 @@ xnsynch_release_thread(struct xnsynch *synch, struct xnthread *lastowner)
 
 	XENO_BUGON(NUCLEUS, !testbits(synch->status, XNSYNCH_OWNER));
 
-	if (xnthread_test_state(lastowner, XNOTHER))
-		xnthread_dec_rescnt(lastowner);
-	XENO_BUGON(NUCLEUS, xnthread_get_rescnt(lastowner) < 0);
+	if (xnthread_test_state(lastowner, XNOTHER)) {
+		if (xnthread_get_rescnt(lastowner) == 0)
+			xnshadow_send_sig(lastowner, SIGDEBUG,
+					  SIGDEBUG_MIGRATE_PRIOINV, 1);
+		else
+			xnthread_dec_rescnt(lastowner);
+	}
 	lastownerh = xnthread_handle(lastowner);
 
 	if (use_fastlock &&



-- 
                                                                Gilles.

