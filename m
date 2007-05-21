From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4651AFF9.5030402@domain.hid>
References: <465099CE.2010004@domain.hid>  <4651AFF9.5030402@domain.hid>
Content-Type: text/plain
Date: Mon, 21 May 2007 18:07:01 +0200
Message-Id: <1179763621.473.145.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [BUG] module_put called over non-root domain
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Mon, 2007-05-21 at 16:43 +0200, Jan Kiszka wrote:
> Hi Philippe,
> 
> Jan Kiszka wrote:
> > Just ran into this with CONFIG_IPIPE_DEBUG_CONTEXT (maybe due to some
> > bug of my own):
> 
> Here is some code to trigger the issue reliably:
> 
> #include <sys/mman.h>
> #include <native/task.h>
> 
> void task_fnct(void *arg)
> {
>         rt_task_delete(NULL);
> }
> 
> main()
> {
>         RT_TASK task;
>         mlockall(MCL_CURRENT|MCL_FUTURE);
>         rt_task_spawn(&task, "task", 0, 10, 0, task_fnct, NULL);
> }
> 
> 
> > 
> > [  102.616000] I-pipe: Detected illicit call from domain 'Xenomai'
> > [  102.616000]         into a service reserved for domain 'Linux' and below.
> > [  102.616000]        c741bdc8 00000000 00000000 c8860ef8 c741bdec c0105683 c032c200 c13fe22c
> > [  102.616000]        c0361f00 c741be08 c01519ed c032f5b8 c032c742 c03380b3 c8885100 c78beac0
> > [  102.616000]        c741be14 c0142ce9 c7a80b30 c741be3c c884d075 c885f150 c8860ef8 c741be3c
> > [  102.616000] Call Trace:
> > [  102.616000]  [<c0104d9f>] show_trace_log_lvl+0x1f/0x40
> > [  102.616000]  [<c0104e71>] show_stack_log_lvl+0xb1/0xe0
> > [  102.616000]  [<c0105683>] show_stack+0x33/0x40
> > [  102.616000]  [<c01519ed>] ipipe_check_context+0xad/0xc0
> > [  102.616000]  [<c0142ce9>] module_put+0x19/0x90
> > [  102.616000]  [<c884d075>] xnshadow_unmap+0xb5/0x130 [xeno_nucleus]
> > [  102.616000]  [<c8871dc5>] __shadow_delete_hook+0x25/0x30 [xeno_native]
> > [  102.616000]  [<c8842f78>] xnpod_schedule+0xb58/0x12f0 [xeno_nucleus]
> > [  102.616000]  [<c8844bfb>] xnpod_delete_thread+0x2cb/0x3d0 [xeno_nucleus]
> > [  102.616000]  [<c886f5bd>] rt_task_delete+0x20d/0x220 [xeno_native]
> > 
> > I would dare to say that module_put in xnshadow_unmap is not well placed
> > as it can wakeup a Linux process. The module ref-counter maintenance
> > needs some postponing, I guess.
> 

Mm, I should definitely read mails entirely.

> Attached is a patch proposal. It solves the issue by postponing the
> module_put via a new schedule_linux_call. Note that this approach issues
> LO_WAKEUP_REQ where the old test (p->state != TASK_RUNNING) would not
> have done so. I don't see negative side effects yet,

This code has to work with an awful lot of runtime situations, including
those raised by ptracing/GDB, and thread signaling in general, so test
harnessing is key here.

>  and I'm furthermore
> not sure of the old code was handling SMP scenarios safely (What if the
> thread to be unmapped was running on different CPU than xnshadow_unmap?
> How to ensure test-atomicity then?).
> 

This wakeup call is there to release emerging shadows waiting on their
start barrier that get killed before start. Other regular cases imply
that either the current thread is exiting - in which case this is a no
brainer, or it has been sent a group kill signal, in which case it has
to wake up anyway.

> 
> Well, this thing seems to work,

It does, actually.

>  but it doesn't leave me with a good
> feeling. IMHO, there are far too many cleanup cases with all the
> combinations of non-shadow termination, shadow self-termination,
> termination on task exit, various SMP scenarios, etc.
>  Moreover, quite a
> lot of stuff is executed in atomic scheduling hooks (namely on cleanup).
> At least for shadow threads, I don't think all of this is necessary.
> Actually, deferring most of the uncritical cleanup work into Linux
> context would make things more regular, easier to review, and likely
> less disturbing for overall system latencies. I know that atomic
> scheduling hooks are required to implement certain skins, but I don't
> see why janitor work should be done there as well. And we also still
> have that tiny uncleanness on shadow threads termination around TCB
> release vs. hook execution.

Talking about xnshadow_unmap, and as your patch illustrates, what you
could postpone is basically the first part of the routine, which updates
the reference counts. The rest _must_ run over the deletion hook in
atomic context (already runs fine all Linux debug switches on). The
latency hit is certainly not seen there; the real issues are left in the
native and POSIX skin thread deletion routines (heap management and
other housekeeping calls under nklock and so on).

> 
> As we are already at it: LO_MAX_REQUESTS is a hidden limitation that
> may (theoretically) bite large setups when e.g. too many threads gets
> killed from the "wrong" context. At least some overflow detection is
> required here to warn the unfortunate user that he reached hard-coded
> scalability limits.

Yes.

> 
> Jan
> 
> 
> ---
>  ksrc/nucleus/shadow.c |   61 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 34 insertions(+), 27 deletions(-)
> 
> Index: xenomai/ksrc/nucleus/shadow.c
> ===================================================================
> --- xenomai.orig/ksrc/nucleus/shadow.c
> +++ xenomai/ksrc/nucleus/shadow.c
> @@ -92,6 +92,7 @@ static struct __lostagerq {
>  #define LO_RENICE_REQ 2
>  #define LO_SIGGRP_REQ 3
>  #define LO_SIGTHR_REQ 4
> +#define LO_UNMAP_REQ  5
>  		int type;
>  		struct task_struct *task;
>  		int arg;
> @@ -778,6 +779,28 @@ static inline void unlock_timers(void)
>  		clrbits(nktbase.status, XNTBLCK);
>  }
>  
> +static void xnshadow_dereference_skin(unsigned magic)
> +{
> +	unsigned muxid;
> +
> +	for (muxid = 0; muxid < XENOMAI_MUX_NR; muxid++) {
> +		if (muxtable[muxid].magic == magic) {
> +			if (xnarch_atomic_dec_and_test(&muxtable[0].refcnt))
> +				xnarch_atomic_dec(&muxtable[0].refcnt);
> +			if (xnarch_atomic_dec_and_test(&muxtable[muxid].refcnt))
> +
> +				/* We were the last thread, decrement the counter,
> +				   since it was incremented by the xn_sys_bind
> +				   operation. */
> +				xnarch_atomic_dec(&muxtable[muxid].refcnt);
> +			if (muxtable[muxid].module)
> +				module_put(muxtable[muxid].module);
> +
> +			break;
> +		}
> +	}
> +}
> +
>  static void lostage_handler(void *cookie)
>  {
>  	int cpuid = smp_processor_id(), reqnum, sig;
> @@ -790,6 +813,12 @@ static void lostage_handler(void *cookie
>  		xnltt_log_event(xeno_ev_lohandler, reqnum, p->comm, p->pid);
>  
>  		switch (rq->req[reqnum].type) {
> +		case LO_UNMAP_REQ:
> +
> +			xnshadow_dereference_skin(
> +				(unsigned)rq->req[reqnum].arg);
> +
> +			/* fall through */
>  		case LO_WAKEUP_REQ:
>  
>  #ifdef CONFIG_SMP
> @@ -1248,7 +1277,6 @@ int xnshadow_map(xnthread_t *thread, xnc
>  void xnshadow_unmap(xnthread_t *thread)
>  {
>  	struct task_struct *p;
> -	unsigned muxid, magic;
>  
>  	if (XENO_DEBUG(NUCLEUS) &&
>  	    !testbits(xnpod_current_sched()->status, XNKCOUT))
> @@ -1256,25 +1284,6 @@ void xnshadow_unmap(xnthread_t *thread)
>  
>  	p = xnthread_archtcb(thread)->user_task;	/* May be != current */
>  
> -	magic = xnthread_get_magic(thread);
> -
> -	for (muxid = 0; muxid < XENOMAI_MUX_NR; muxid++) {
> -		if (muxtable[muxid].magic == magic) {
> -			if (xnarch_atomic_dec_and_test(&muxtable[0].refcnt))
> -				xnarch_atomic_dec(&muxtable[0].refcnt);
> -			if (xnarch_atomic_dec_and_test(&muxtable[muxid].refcnt))
> -
> -				/* We were the last thread, decrement the counter,
> -				   since it was incremented by the xn_sys_bind
> -				   operation. */
> -				xnarch_atomic_dec(&muxtable[muxid].refcnt);
> -			if (muxtable[muxid].module)
> -				module_put(muxtable[muxid].module);
> -
> -			break;
> -		}
> -	}
> -
>  	xnthread_clear_state(thread, XNMAPPED);
>  	rpi_pop(thread);
>  
> @@ -1285,13 +1294,7 @@ void xnshadow_unmap(xnthread_t *thread)
>  
>  	xnshadow_thrptd(p) = NULL;
>  
> -	if (p->state != TASK_RUNNING)
> -		/* If the shadow is being unmapped in primary mode or blocked
> -		   in secondary mode, the associated Linux task should also
> -		   die. In the former case, the zombie Linux side returning to
> -		   user-space will be trapped and exited inside the pod's
> -		   rescheduling routines. */
> -		schedule_linux_call(LO_WAKEUP_REQ, p, 0);
> +	schedule_linux_call(LO_UNMAP_REQ, p, xnthread_get_magic(thread));
>  }
>  
>  int xnshadow_wait_barrier(struct pt_regs *regs)
> @@ -1984,6 +1987,7 @@ RTHAL_DECLARE_EVENT(losyscall_event);
>  static inline void do_taskexit_event(struct task_struct *p)
>  {
>  	xnthread_t *thread = xnshadow_thread(p); /* p == current */
> +	unsigned magic;
>  	spl_t s;
>  
>  	if (!thread)
> @@ -1992,6 +1996,8 @@ static inline void do_taskexit_event(str
>  	if (xnpod_shadow_p())
>  		xnshadow_relax(0);
>  
> +	magic = xnthread_get_magic(thread);
> +
>  	xnlock_get_irqsave(&nklock, s);
>  	/* Prevent wakeup call from xnshadow_unmap(). */
>  	xnshadow_thrptd(p) = NULL;
> @@ -2002,6 +2008,7 @@ static inline void do_taskexit_event(str
>  	xnlock_put_irqrestore(&nklock, s);
>  	xnpod_schedule();
>  
> +	xnshadow_dereference_skin(magic);
>  	xnltt_log_event(xeno_ev_shadowexit, thread->name);
>  }
>  
> 
> 
-- 
Philippe.



