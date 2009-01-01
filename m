Message-ID: <495CD29A.3020901@domain.hid>
Date: Thu, 01 Jan 2009 15:26:34 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <495C80FB.7050501@domain.hid> <495CCF2C.40008@domain.hid>
In-Reply-To: <495CCF2C.40008@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Oops when exiting Xenomai POSIX application
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
Cc: xenomai-help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Wolfgang Grandegger wrote:
>> Hello,
>>
>> first a Happy New Year to everybody.
>>
>> With the POSIX skin of Xenomai trunk I get the following Oops when I
>> exit my application (with ^C) on my PowerPC :
>>
>>  Xenomai: fatal: removing non-linked element, holder=c78e69c8, qslot=c7b03030 at kernel/xenomai/skins/posix/thread.c:52
>> [ 4081.676346]  CPU  PID    PRI      TIMEOUT  STAT      NAME
>> [ 4081.676356] >  0  0       -1      0        00500080  ROOT
>> [ 4081.676366]    0  1128    37      0        00300380  UT1
>> [ 4081.676376] Master time base: clock=137696806566
>> [ 4081.676385] 
>> [ 4081.722024] Call Trace:
>> [ 4081.724515] [c7b19d40] [c0008088] show_stack+0x4c/0x1ac (unreliable)
>> [ 4081.731030] [c7b19d80] [c0085670] thread_destroy+0x230/0x23c
>> [ 4081.736823] [c7b19da0] [c0085c28] thread_delete_hook+0xf4/0xf8
>> [ 4081.742781] [c7b19dc0] [c0053b74] xnpod_fire_callouts+0x48/0x94
>> [ 4081.748845] [c7b19de0] [c005fa64] xnsched_zombie_hooks+0x5c/0xcc
>> [ 4081.754982] [c7b19df0] [c005fb50] xnsched_finish_unlocked_switch+0x7c/0x9c
>> [ 4081.762003] [c7b19e00] [c0054ad4] __xnpod_schedule+0x1f8/0x6e4
>> [ 4081.767962] [c7b19e50] [c0055c34] xnpod_suspend_thread+0x3c0/0x54c
>> [ 4081.774275] [c7b19e90] [c0064810] xnshadow_relax+0x90/0x23c
>> [ 4081.779972] [c7b19eb0] [c00651c0] hisyscall_event+0x2a4/0x2cc
>> [ 4081.785841] [c7b19ee0] [c004d850] __ipipe_dispatch_event+0xac/0x224
>> [ 4081.792243] [c7b19f30] [c0009560] __ipipe_syscall_root+0x40/0xf0
>> [ 4081.798383] [c7b19f40] [c0011118] DoSyscall+0x20/0x5c
>> [ 4081.803556] --- Exception: c01 at 0xffaa1b0
>> [ 4081.807823]     LR = 0xffaa18c
>>
>>
>> Does that trigger a bell?
> 
> Wait, yes, this is bad, I think we should not execute
> xnsched_finish_unlocked_switch at this point. Try this. This is a
> temporary patch, we probably have to work out something better for SMP,
> but it should at least show us if this is the reason for the problem you
> have.
> 
> Index: ksrc/nucleus/pod.c
> ===================================================================
> --- ksrc/nucleus/pod.c	(revision 4519)
> +++ ksrc/nucleus/pod.c	(working copy)
> @@ -2085,18 +2085,8 @@ void __xnpod_schedule(struct xnsched *sc
> 
>  	xnpod_switch_to(sched, prev, next);
> 
> -	switched = 1;
> -	sched = xnsched_finish_unlocked_switch(sched);
> -	/*
> -	 * Re-read the currently running thread, this is needed
> -	 * because of relaxed/hardened transitions.
> -	 */
>  	curr = sched->curr;
> 
> -	xnarch_trace_pid(xnthread_user_task(curr) ?
> -			 xnarch_user_pid(xnthread_archtcb(curr)) : -1,
> -			 xnthread_current_priority(curr));
> -
>  #ifdef CONFIG_XENO_OPT_PERVASIVE
>  	/*
>  	 * Test whether we are relaxing a thread. In such a case, we
> @@ -2107,6 +2097,16 @@ void __xnpod_schedule(struct xnsched *sc
>  		goto relax_epilogue;
>  #endif /* CONFIG_XENO_OPT_PERVASIVE */
> 
> +	switched = 1;
> +	sched = xnsched_finish_unlocked_switch(sched);
> +	/*
> +	 * Re-read the currently running thread, this is needed
> +	 * because of relaxed/hardened transitions.
> +	 */
> +	xnarch_trace_pid(xnthread_user_task(curr) ?
> +			 xnarch_user_pid(xnthread_archtcb(curr)) : -1,
> +			 xnthread_current_priority(curr));
> +
>  	if (zombie)
>  		xnpod_fatal("zombie thread %s (%p) would not die...",
>  			    prev->name, prev);

With this patch, I do not get an Oops any more :-).

Wolfgang.



