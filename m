From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100420141227.GB9203@domain.hid>
References: <j2yb88603c31004020058i3aae7947s1428f1b87f4b1097@domain.hid>
	<4BB5B64B.6040803@domain.hid> <4BB5B7C1.4020301@domain.hid>
	<4BB5B874.5090904@domain.hid>
	<k2pb88603c31004020232z28e10d59vc546b1b8803113f2@domain.hid>
	<4BB5BA2D.1080604@domain.hid>
	<245373446233674495BCA5CA2FC1EB17378D015932@domain.hid>
	<4BBAD880.5040603@domain.hid> <20100415001912.GB26116@domain.hid>
	<1271322120.2365.605.camel@domain.hid>
	<20100420141227.GB9203@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 23 Apr 2010 12:54:18 +0200
Message-ID: <1272020058.9515.753.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Glatz <andreasglatz@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

On Tue, 2010-04-20 at 10:12 -0400, Andreas Glatz wrote:
> > > > >> For the time being, you can work around this by issuing a Linux syscall
> > > > >> before entering long processing loops - unless your task doesn't do this
> > > > >> anyway, e.g. to perform some Linux I/O.
> > > > >>
> > > > >
> > > > > I think that's need. Currently the statistics task takes a mutex and waits on a message queue for messages. That's the only time it should potentially run in primary mode. After it returns the Mutex it should continue running with a policy similar to SCHED_IDLE to give other tasks a chance to run. I see how switching back to secondary mode could be achieved by issuing a Linux syscall. Is there another way which doesn't involve changing the source code of our application? (The proper way?)
> > > >
> > > > The proper way would be to not having to change the application code.
> > > > But this workaround (Linux syscall or *_set_mode()) is required until we
> > > > improve the nucleus.
> > >
> > > I generated a patch against 2.4.10.1 to get this behaviour (see further down). Instead of having
> > > to review and insert a Linux syscall or *_set_mode() in the application code I just call
> > > rt_task_set_mode(0, T_IDLE, NULL) at the beginning of the task body of the task which
> > > should mostly run in secondary mode under SCHED_IDLE (see example further down). The task
> > > marked with T_IDLE will switch to primary mode at every Xenomai skincall and immediately
> > > switch back to secondary mode once the Xenomai skincall is done.
> > >
> > > We identified just one case where this task has to stay in primary mode. This is between
> > > rt_mutex_aquire() and rt_mutex_release() since it may undergo a priority inversion boost.
> > > If the task stayed in secondary mode during that time it either would potentally delay the
> > > execution of a high priority task or would kill the system.
> > >
> > > The patch seems to work for us. Our statistics task which blocked the system for a long
> > > time (and made the UI running under Linux unresponsive) is running with T_IDLE. If Linux is
> > > heavily loaded now the statistics will get out of sync but the UI will still be responsive.
> > >
> > 
> > The logic of this patch looks ok for the native skin, given that 2.4.x
> > does not provide a centralized implementation for dealing with exclusive
> > resources, like 2.5.x with xnsynch_acquire/release, and always emits a
> > syscall to manage those resources.
> > 
> > This said, you could spare the T_IDLE tag by assuming that any non-RT
> > shadow thread has to switch back to secondary mode after a syscall,
> > unless the owned resource count is non-zero. This is where we are
> > heading to in 2.5.x, since the preferred mode of operation for such
> > thread has to be fundamentally "relaxed" (otherwise, one would have
> > created a RT thread, right).
> > 
> > I'm also unsure you should force SCHED_IDLE, instead of picking
> > SCHED_OTHER for a more general approach to this issue. You can't assume
> > that userland does want to be reniced that way, at least not from the
> > nucleus. But I guess this fits your problem though.
> > 
> > To sum up, since we can't really provide a true SCHED_IDLE policy on
> > linux (i.e. not a nice-level hack), and implementing a sched class in
> > Xenomai having a lower priority than the existing xnsched_class_idle (in
> > 2.5.x) is not feasible (we could not run any userland task in it
> > anyway), we'd better stick with SCHED_OTHER.
> > 
> 
> Thanks a lot for the feedback. Your suggestions simplified the patch. I
> also changed SCHED_IDLE to SCHED_OTHER since it might be more beneficial
> for the broader audience. Any other suggestions?

For an even broader audience, the POSIX skin mutexes should be tracked
as well.

> 
> After applying this patch, a thread with priority 0 will automatically
> switch back to secondary mode after every (native) skincall unless the
> task holds a mutex (simple and nested).
> 
> The benefit is, that the task with priority 0 (which I called a linux 
> domain rt thread)

Actually, no. This is not a rt thread at all, in the sense that you have
zero guarantee wrt latency in that case. Such a thread is actually a non
real-time Xenomai shadow thread, meaning that it may invoke Xenomai
services that require the caller to be a Xenomai thread, without
real-time support though.

>  can issue (native) skincalls and share resources with
> high prioritiy task. But it doesn't hold up Linux tasks unless it holds
> a mutex since it mostly runs in secondary mode and just switches to 
> primary mode when needed.
> 
> Just one more questions: Philippe said that you have something similar in
> 2.5. How do you enable it there? By setting the correct sheduling policy?
> 

There are plans to have it. That behavior would be enabled whenever the
linux policy is SCHED_OTHER, and the base priority is 0 Xenomai-wise.
The latter would be enough for now, but it seems more future-proof not
to assume that only SCHED_OTHER tasks could be assigned Xenomai priority
0.

> Andreas 
> 
> PATCH:
> 
> diff -ruN linux-2.6.32-5RR9/include/xenomai/nucleus/thread.h linux-2.6.32-5RR9-new/include/xenomai/nucleus/thread.h
> --- linux-2.6.32-5RR9/include/xenomai/nucleus/thread.h	2010-04-13 20:02:21.000000000 -0400
> +++ linux-2.6.32-5RR9-new/include/xenomai/nucleus/thread.h	2010-04-19 09:35:44.000000000 -0400
> @@ -186,6 +186,8 @@
>  
>      xnpqueue_t claimq;		/* Owned resources claimed by others (PIP) */
>  
> +    int lockcnt;			/* Mutexes which are currently locked by this thread */
> +
>      struct xnsynch *wchan;	/* Resource the thread pends on */
>  
>      struct xnsynch *wwake;	/* Wait channel the thread was resumed from */
> diff -ruN linux-2.6.32-5RR9/kernel/xenomai/nucleus/shadow.c linux-2.6.32-5RR9-new/kernel/xenomai/nucleus/shadow.c
> --- linux-2.6.32-5RR9/kernel/xenomai/nucleus/shadow.c	2010-04-13 20:02:22.000000000 -0400
> +++ linux-2.6.32-5RR9-new/kernel/xenomai/nucleus/shadow.c	2010-04-19 18:06:39.000000000 -0400
> @@ -976,6 +976,16 @@
>  	return prio < MAX_RT_PRIO ? prio : MAX_RT_PRIO - 1;
>  }
>  
> +static inline int relax_thread(xnthread_t *thread)
> +{
> +	/* A thread with bprio == 0 is called a Linux Domain RT thread.
> +	   It has to switch to secondary mode after every skin call
> +	   if it doesn't hold any mutexes. */
> +	return (xnthread_base_priority(thread) == 0 &&
> +			thread->lockcnt == 0)
> +			? 1 : 0;
> +}
> +
>  static int gatekeeper_thread(void *data)
>  {
>  	struct __gatekeeper *gk = (struct __gatekeeper *)data;
> @@ -1187,7 +1197,7 @@
>  void xnshadow_relax(int notify)
>  {
>  	xnthread_t *thread = xnpod_current_thread();
> -	int prio;
> +	int prio, policy;
>  	spl_t s;
>  
>  	XENO_BUGON(NUCLEUS, xnthread_test_state(thread, XNROOT));
> @@ -1217,9 +1227,11 @@
>  		xnpod_fatal("xnshadow_relax() failed for thread %s[%d]",
>  			    thread->name, xnthread_user_pid(thread));
>  
> +	/* If thread is a Linux Domain RT thread and it should be relaxed the
> +	   base priority should be equal to the current priority equal to 0. */
> +	policy = relax_thread(thread) ? SCHED_NORMAL : SCHED_FIFO;
>  	prio = normalize_priority(xnthread_current_priority(thread));
> -	rthal_reenter_root(get_switch_lock_owner(),
> -			   prio ? SCHED_FIFO : SCHED_NORMAL, prio);
> +	rthal_reenter_root(get_switch_lock_owner(), policy, prio);
>  
>  	xnstat_counter_inc(&thread->stat.ssw);	/* Account for secondary mode switch. */
>  
> @@ -2001,8 +2013,14 @@
>  
>  	if (xnpod_shadow_p() && signal_pending(p))
>  		request_syscall_restart(thread, regs, sysflags);
> -	else if ((sysflags & __xn_exec_switchback) != 0 && switched)
> -		xnshadow_harden();	/* -EPERM will be trapped later if needed. */
> +	else {
> +		int relax = xnpod_shadow_p() && relax_thread(thread);
> +		
> +		if ((sysflags & __xn_exec_switchback) != 0 && switched && !relax)
> +			xnshadow_harden();  /* -EPERM will be trapped later if needed. */
> +		else if (relax)
> +			xnshadow_relax(0);
> +	}
>  
>  	return RTHAL_EVENT_STOP;
>  
> @@ -2137,6 +2155,9 @@
>  		request_syscall_restart(xnshadow_thread(current), regs, sysflags);
>  	else if ((sysflags & __xn_exec_switchback) != 0 && switched)
>  		xnshadow_relax(0);
> +	else if (xnpod_active_p() && xnpod_shadow_p() && 
> +			 relax_thread(xnshadow_thread(current)))
> +		xnshadow_relax(0);
>  
>  	return RTHAL_EVENT_STOP;
>  }
> diff -ruN linux-2.6.32-5RR9/kernel/xenomai/nucleus/thread.c linux-2.6.32-5RR9-new/kernel/xenomai/nucleus/thread.c
> --- linux-2.6.32-5RR9/kernel/xenomai/nucleus/thread.c	2010-04-13 20:02:22.000000000 -0400
> +++ linux-2.6.32-5RR9-new/kernel/xenomai/nucleus/thread.c	2010-04-19 19:00:39.000000000 -0400
> @@ -124,6 +124,7 @@
>  	thread->rpi = NULL;
>  #endif /* CONFIG_XENO_OPT_PRIOCPL */
>  	initpq(&thread->claimq);
> +	thread->lockcnt = 0;
>  
>  	xnarch_init_display_context(thread);
>  
> diff -ruN linux-2.6.32-5RR9/kernel/xenomai/skins/native/mutex.c linux-2.6.32-5RR9-new/kernel/xenomai/skins/native/mutex.c
> --- linux-2.6.32-5RR9/kernel/xenomai/skins/native/mutex.c	2010-04-13 20:02:22.000000000 -0400
> +++ linux-2.6.32-5RR9-new/kernel/xenomai/skins/native/mutex.c	2010-04-19 09:35:44.000000000 -0400
> @@ -396,6 +396,8 @@
>  		/* xnsynch_sleep_on() might have stolen the resource,
>  		   so we need to put our internal data in sync. */
>  		mutex->lockcnt = 1;
> +		
> +		thread->lockcnt++;
>  	}
>  
>        unlock_and_exit:
> @@ -462,6 +464,8 @@
>  	if (--mutex->lockcnt > 0)
>  		goto unlock_and_exit;
>  
> +	xnpod_current_thread()->lockcnt--;
> +
>  	if (xnsynch_wakeup_one_sleeper(&mutex->synch_base)) {
>  		mutex->lockcnt = 1;
>  		xnpod_schedule();
>  


-- 
Philippe.



