Message-ID: <49B54780.6040504@domain.hid>
Date: Mon, 09 Mar 2009 17:44:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49B3A126.6000602@domain.hid> <49B53AC3.10707@domain.hid>
In-Reply-To: <49B53AC3.10707@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Watchdog / immediate Linux signal delivery
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> the watchdog is currently broken in trunk ("zombie [...] would not
>> die..."). In fact, it should also be broken in older versions, but only
>> recent thread termination rework made this visible.
>>
>> When a Xenomai CPU hog is caught by the watchdog, xnpod_delete_thread is
>> invoked, causing the current thread to be set in zombie state and
>> scheduled out. But as its Linux mate still exist, hell breaks loose once
>> Linux tries to get rid of it (the Xenomai zombie is scheduled in again).
>> In short: calling xnpod_delete_thread(<self>) for a shadow thread is not
>> working, probably never worked cleanly.
> 
> Nak, it is a regression introduced by the scheduler changes in 2.5.x. We should 
> detect _any_ shadow thread that schedules out in primary mode then regains 
> control in secondary mode like we do in the 2.4.x series, not only _relaxing_ 
> shadow threads. It is perfectly valid to have the Linux task orphaned from the 
> deletion of its shadow TCB until Xenomai notices the issue and reaps it; problem 
> was that such regression prevented the nucleus to get the memo.
> 
> The following patch should fix the issue:
> 
>   Index: include/asm-generic/system.h
> ===================================================================
> --- include/asm-generic/system.h	(revision 4676)
> +++ include/asm-generic/system.h	(working copy)
> @@ -311,6 +311,11 @@
>   	return !!s;
>   }
> 
> +static inline int xnarch_root_domain_p(void)
> +{
> +	return rthal_current_domain == rthal_root_domain;
> +}
> +
>   #ifdef CONFIG_SMP
> 
>   #define xnlock_get(lock)		__xnlock_get(lock  XNLOCK_DBG_CONTEXT)
> Index: ksrc/nucleus/pod.c
> ===================================================================
> --- ksrc/nucleus/pod.c	(revision 4676)
> +++ ksrc/nucleus/pod.c	(working copy)
> @@ -2137,7 +2137,7 @@
>   void __xnpod_schedule(struct xnsched *sched)
>   {
>   	struct xnthread *prev, *next, *curr = sched->curr;
> -	int zombie, switched = 0, need_resched, relaxing;
> +	int zombie, switched = 0, need_resched, shadow;
>   	spl_t s;
> 
>   	if (xnarch_escalate())
> @@ -2174,9 +2174,9 @@
>   		   next, xnthread_name(next));
> 
>   #ifdef CONFIG_XENO_OPT_PERVASIVE
> -	relaxing = xnthread_test_state(prev, XNRELAX);
> +	shadow = xnthread_test_state(prev, XNSHADOW);
>   #else
> -	(void)relaxing;
> +	(void)shadow;
>   #endif /* CONFIG_XENO_OPT_PERVASIVE */
> 
>   	if (xnthread_test_state(next, XNROOT)) {
> @@ -2204,12 +2204,18 @@
> 
>   #ifdef CONFIG_XENO_OPT_PERVASIVE
>   	/*
> -	 * Test whether we are relaxing a thread. In such a case, we
> -	 * are here the epilogue of Linux' schedule, and should skip
> -	 * xnpod_schedule epilogue.
> +	 * Test whether we transitioned from primary mode to secondary
> +	 * over a shadow thread. This may happen in two cases:
> +	 *
> +	 * 1) the shadow thread just relaxed.
> +	 * 2) the shadow TCB has just been deleted, in which case
> +	 * we have to reap the mated Linux side as well.
> +	 *
> +	 * In both cases, we are running over the epilogue of Linux's
> +	 * schedule, and should skip our epilogue code.
>   	 */
> -	if (relaxing)
> -		goto relax_epilogue;
> +	if (shadow && xnarch_root_domain_p())
> +		goto shadow_epilogue;
>   #endif /* CONFIG_XENO_OPT_PERVASIVE */
> 
>   	switched = 1;
> @@ -2252,7 +2258,7 @@
>   	return;
> 
>   #ifdef CONFIG_XENO_OPT_PERVASIVE
> -      relax_epilogue:
> +      shadow_epilogue:
>   	{
>   		spl_t ignored;

Finally makes sense and works (but your posting was corrupted). Great.

> 
>> There are basically two approaches to fix it: The first one is to find a
>> different way to kill (or only suspend?)
> 
> Suspending the hog won't work, particularly when GDB is involved, because a 
> pending non-lethal Linux signal may cause the suspended shadow to resume 
> immediately for processing the signal, therefore defeating the purpose of the 
> watchdog, leading to an infinite loop. This is why we moved from suspension to 
> deletion upon watchdog trigger in 2.3 (2.2 used to suspend only).

Yes, that became clear to me in the meantime, too.

> 
>   the current shadow thread when
>> the watchdog strikes. The second one brought me to another issue: Raise
>> SIGKILL for the current thread and make sure that it can be processed by
>> Linux (e.g. via xnpod_suspend_thread(<cpu-hog>). Unfortunately, there is
>> no way to force a shadow thread into secondary mode to handle pending
>> Linux signals unless that thread issues a syscall once in a while. And
>> that raises the question if we shouldn't improve this as well while we
>> are on it.
>>
>> Granted, non-broken Xenomai user space threads always issue frequent
>> syscalls, otherwise the system would starve (and the watchdog would come
>> around). On the other hand, delaying signals till syscall prologues is
>> different from plain Linux behaviour...
>>
>> Comments, ideas?
>>
> 
> We probably need a two-stage approach: first record the thread was bumped out 
> and suspend it from the watchdog handler to give Linux a chance to run again, 
> then finish the work, killing it for good, next time the root thread is 
> scheduled in on the same CPU.

That confuses me again: The watchdog issue is solved now, no? We are
only left with the scenario of breaking out of a user space loop of some
Xenomai thread via a Linux signal (which implies SMP - otherwise there
is no chance to raise the signal...).

Meanwhile I played with some light-weight approach to relax a thread
that received a signal (according to do_sigwake_event). Worked, but only
once due to a limitation (if not bug) of I-pipe x86: in __ipipe_run_isr,
it does not handle the case that a non-root handler may alter the
current domain, causing corruptions to the IPIPE_SYNC_FLAG states of the
involved domains. Will try to fix this and post my signaling proposal so
that this work is not lost.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

