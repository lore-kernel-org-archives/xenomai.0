From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100415001912.GB26116@domain.hid>
References: <4BB53566.3010601@domain.hid> <4BB53643.2080604@domain.hid>
	<j2yb88603c31004020058i3aae7947s1428f1b87f4b1097@domain.hid>
	<4BB5B64B.6040803@domain.hid> <4BB5B7C1.4020301@domain.hid>
	<4BB5B874.5090904@domain.hid>
	<k2pb88603c31004020232z28e10d59vc546b1b8803113f2@domain.hid>
	<4BB5BA2D.1080604@domain.hid>
	<245373446233674495BCA5CA2FC1EB17378D015932@domain.hid>
	<4BBAD880.5040603@domain.hid> <20100415001912.GB26116@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Apr 2010 11:02:00 +0200
Message-ID: <1271322120.2365.605.camel@domain.hid>
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


Hi,

On Wed, 2010-04-14 at 20:19 -0400, Andreas Glatz wrote:
> Hi,
> 
> On Tue, Apr 06, 2010 at 02:45:20AM -0400, Jan Kiszka wrote:
> > Andreas Glatz wrote:
> > >>> Actually that is what I thought in the first place, however Jan's
> > >>> comment "That's not true, Xenomai threads can run in non-RT scheduling
> > >>> classes as well. They may just gain RT priority while holding some
> > >>> lock that is requested by a RT thread as well." made me think I was
> > >>> wrong...
> > >>>
> > >>> So we would really need a SCHED_IDLE for Xenomai then to solve this problem?
> > >> I don't think so. But we do need to solve the issue that a non-RT thread
> > >> stays too long in primary mode and is thus scheduled by Xenomai with the
> > >> wrong priority /wrt other Linux task at its level.
> > >>
> > >> For the time being, you can work around this by issuing a Linux syscall
> > >> before entering long processing loops - unless your task doesn't do this
> > >> anyway, e.g. to perform some Linux I/O.
> > >>
> > > 
> > > I think that's need. Currently the statistics task takes a mutex and waits on a message queue for messages. That's the only time it should potentially run in primary mode. After it returns the Mutex it should continue running with a policy similar to SCHED_IDLE to give other tasks a chance to run. I see how switching back to secondary mode could be achieved by issuing a Linux syscall. Is there another way which doesn't involve changing the source code of our application? (The proper way?)
> > 
> > The proper way would be to not having to change the application code.
> > But this workaround (Linux syscall or *_set_mode()) is required until we
> > improve the nucleus.
> 
> I generated a patch against 2.4.10.1 to get this behaviour (see further down). Instead of having 
> to review and insert a Linux syscall or *_set_mode() in the application code I just call 
> rt_task_set_mode(0, T_IDLE, NULL) at the beginning of the task body of the task which 
> should mostly run in secondary mode under SCHED_IDLE (see example further down). The task 
> marked with T_IDLE will switch to primary mode at every Xenomai skincall and immediately 
> switch back to secondary mode once the Xenomai skincall is done. 
> 
> We identified just one case where this task has to stay in primary mode. This is between 
> rt_mutex_aquire() and rt_mutex_release() since it may undergo a priority inversion boost. 
> If the task stayed in secondary mode during that time it either would potentally delay the 
> execution of a high priority task or would kill the system.
> 
> The patch seems to work for us. Our statistics task which blocked the system for a long 
> time (and made the UI running under Linux unresponsive) is running with T_IDLE. If Linux is 
> heavily loaded now the statistics will get out of sync but the UI will still be responsive.
> 

The logic of this patch looks ok for the native skin, given that 2.4.x
does not provide a centralized implementation for dealing with exclusive
resources, like 2.5.x with xnsynch_acquire/release, and always emits a
syscall to manage those resources.

This said, you could spare the T_IDLE tag by assuming that any non-RT
shadow thread has to switch back to secondary mode after a syscall,
unless the owned resource count is non-zero. This is where we are
heading to in 2.5.x, since the preferred mode of operation for such
thread has to be fundamentally "relaxed" (otherwise, one would have
created a RT thread, right).

I'm also unsure you should force SCHED_IDLE, instead of picking
SCHED_OTHER for a more general approach to this issue. You can't assume
that userland does want to be reniced that way, at least not from the
nucleus. But I guess this fits your problem though.

To sum up, since we can't really provide a true SCHED_IDLE policy on
linux (i.e. not a nice-level hack), and implementing a sched class in
Xenomai having a lower priority than the existing xnsched_class_idle (in
2.5.x) is not feasible (we could not run any userland task in it
anyway), we'd better stick with SCHED_OTHER.

> One thing I've noticed though, and this is not related to the patch (I verified it on a 
> vanilla Xenomai system): Consider the example I included. It prints average cycle times 
> and the cycle time variance of the high priority task ("T2"). I noticed a big difference 
> in the cycle time variance when switching the first task ("T1") to secondary mode with 
> rt_task_set_mode() and setting the scheduler policy to either SCHED_FIFO, SCHED_IDLE or 
> SCHED_NORMAL. I'm assuming someone asked this before and I didn't pay attention :) 
> Can someone give me a short explanation or point me somewhere to get an explanation for
> this behaviour? I didn't expect such a difference in variance:
> 
> SCHED_FIFO:
> task=2 count=1000 average=10505us variance=851(us)^2
> task=2 count=1000 average=10504us variance=176(us)^2
> task=2 count=1000 average=10505us variance=716(us)^2
> task=2 count=1000 average=10504us variance=148(us)^2
> task=2 count=1000 average=10504us variance=143(us)^2
> task=2 count=1000 average=10504us variance=141(us)^2
> task=2 count=1000 average=10504us variance=138(us)^2
> 
> SCHED_NORMAL:
> task=2 count=1000 average=10501us variance=2115(us)^2
> task=2 count=1000 average=10504us variance=3121(us)^2
> task=2 count=1000 average=10500us variance=161(us)^2
> task=2 count=1000 average=10501us variance=1136(us)^2
> task=2 count=1000 average=10500us variance=194(us)^2
> task=2 count=1000 average=10501us variance=1971(us)^2
> task=2 count=1000 average=10500us variance=132(us)^2
> task=2 count=1000 average=10501us variance=1173(us)^2
> 
> SCHED_IDLE:
> task=2 count=1000 average=10504us variance=3413(us)^2
> task=2 count=1000 average=10503us variance=3567(us)^2
> task=2 count=1000 average=10504us variance=3409(us)^2
> task=2 count=1000 average=10504us variance=1743(us)^2
> task=2 count=1000 average=10504us variance=2710(us)^2
> task=2 count=1000 average=10504us variance=2548(us)^2
> task=2 count=1000 average=10504us variance=2364(us)^2
> task=2 count=1000 average=10504us variance=2867(us)^2
> task=2 count=1000 average=10504us variance=2755(us)^2
> 
> 
> Regards, Andreas
> 
> (Xenomai 2.4.10.1, Linux 2.6.32, Ipipe 2.8)
> 
> 
> EXAMPLE APPLICATION:
> 
> #include <stdio.h>
> #include <unistd.h>
> #include <native/task.h>
> #include <native/sem.h>
> #include <native/mutex.h>
> #include <sys/mman.h>
> #include <rtdk.h>
> #include <sched.h>
> #include <linux/sched.h>
> 
> typedef struct test {
>     RTIME timestamp;
>     RTIME sum;
>     RTIME sumsq;
>     int count;
> } test_t;
> 
> static test_t test1 = {0, 0, 0, 0}, test2 = {0, 0, 0, 0};
> static RT_TASK task1, task2;
> static RT_MUTEX mutex1, mutex2;
> 
> static void task_body( void* cookie )
> {
>     RTIME timestamp, delta;
>     test_t* ptr = (test_t*)cookie;
>     int num = ( ptr == &test1) ? 1 : 2;
> 
>     if( num == 1 ) rt_task_set_mode(0, 0x00080000, NULL);
> 
>     while(1)
>     {
>         rt_mutex_acquire(&mutex1, TM_INFINITE);
> 
>         timestamp = __xn_rdtsc();
>         delta = (timestamp - ptr->timestamp) >> 6 /* in us */;
>         ptr->sum += delta;
>         ptr->sumsq += delta*delta;
>         ptr->timestamp = timestamp;
>         if( ++ptr->count >= 1000 ) {
>             RTIME avg, var;
>             avg = ptr->sum/ptr->count;
>             var = (ptr->sumsq - (ptr->sum*ptr->sum)/ptr->count)/(ptr->count-1);
> 
>             if( num == 2 )
>                 rt_printf("task=%d count=%d average=%lluus variance=%llu(us)^2\n",
>                           num, ptr->count, avg, var);
> 
>             ptr->sum = 0;
>             ptr->sumsq = 0;
>             ptr->count = 0;
>         }
> 
> 		// If commented T1 basically runs in a while(1) {}
> 		// loop without any sleeps. UI should be responsive
> 		// since T1 runs with SCHED_IDLE.
> 		// If uncommented the sleep causes T2 to boost the
> 		// priority of T1. 
>         if( num == 1 ) rt_task_sleep(10000000);
> 
> 		// T1 automatically switches to secondary mode after
> 		// this call.
>         rt_mutex_release(&mutex1);
> 
>         // Give T1 time to run
>         if( num == 2 ) rt_task_sleep(10000000);
>     }
> }
> 
> int main(int argc, char* argv[])
> {
>     int err;
> 
>     mlockall(MCL_CURRENT|MCL_FUTURE);
> 
>     rt_print_auto_init(1);
> 
>     test1.timestamp = test2.timestamp = __xn_rdtsc();
>     err  = rt_mutex_create(&mutex1, "M1");
>     err += rt_mutex_create(&mutex2, "M2");
>     err += rt_task_spawn(&task1, "T1", 0, 33, 0, task_body, (void*)&test1);
>     err += rt_task_spawn(&task2, "T2", 0, 66, 0, task_body, (void*)&test2);
>     if( !err )
>     {
>         pause();
>     }
> 
>     return err;
> }
> 
> IDLE PATCH:
> 
> diff -ruN linux-2.6.32-5RR9/include/asm-generic/xenomai/syscall.h linux-2.6.32-5RR9-new/include/asm-generic/xenomai/syscall.h
> --- linux-2.6.32-5RR9/include/asm-generic/xenomai/syscall.h	2010-04-13 20:02:21.000000000 -0400
> +++ linux-2.6.32-5RR9-new/include/asm-generic/xenomai/syscall.h	2010-04-14 10:38:09.000000000 -0400
> @@ -89,6 +89,8 @@
>  #define __xn_exec_adaptive   0x40
>  /* Do not restart syscall upon signal receipt. */
>  #define __xn_exec_norestart  0x80
> +/* Do not switch to secondary mode after syscall if thread has XNIDLE flag set (see #XNIDLE) */
> +#define __xn_exec_norelax    0x100
>  /* Context-agnostic syscall. Will actually run in Xenomai domain. */
>  #define __xn_exec_any        0x0
>  /* Short-hand for shadow init syscall. */
> diff -ruN linux-2.6.32-5RR9/include/xenomai/native/task.h linux-2.6.32-5RR9-new/include/xenomai/native/task.h
> --- linux-2.6.32-5RR9/include/xenomai/native/task.h	2010-04-13 20:02:21.000000000 -0400
> +++ linux-2.6.32-5RR9-new/include/xenomai/native/task.h	2010-04-14 10:38:09.000000000 -0400
> @@ -52,6 +52,7 @@
>  #define T_SHIELD   XNSHIELD   /**< See #XNSHIELD  */ 
>  #define T_WARNSW   XNTRAPSW   /**< See #XNTRAPSW  */ 
>  #define T_RPIOFF   XNRPIOFF   /**< See #XNRPIOFF  */ 
> +#define T_IDLE     XNIDLE     /**< See #XNIDLE    */
>  #define T_PRIMARY  0x00000200	/* Recycle internal bits status which */
>  #define T_JOINABLE 0x00000400	/* won't be passed to the nucleus.  */
>  /*! @} */ /* Ends doxygen-group native_task_status */
> diff -ruN linux-2.6.32-5RR9/include/xenomai/nucleus/thread.h linux-2.6.32-5RR9-new/include/xenomai/nucleus/thread.h
> --- linux-2.6.32-5RR9/include/xenomai/nucleus/thread.h	2010-04-13 20:02:21.000000000 -0400
> +++ linux-2.6.32-5RR9-new/include/xenomai/nucleus/thread.h	2010-04-14 10:38:09.000000000 -0400
> @@ -55,6 +55,7 @@
>  #define XNSHIELD  0x00010000 /**< IRQ shield is enabled (shadow only) */
>  #define XNTRAPSW  0x00020000 /**< Trap execution mode switches */
>  #define XNRPIOFF  0x00040000 /**< Stop priority coupling (shadow only) */
> +#define XNIDLE    0x00080000 /**< Switches to secondary mode after syscalls if not holding mutexes */
>  
>  #define XNFPU     0x00100000 /**< Thread uses FPU */
>  #define XNSHADOW  0x00200000 /**< Shadow thread */
> @@ -90,7 +91,7 @@
>  }
>  
>  #define XNTHREAD_BLOCK_BITS   (XNSUSP|XNPEND|XNDELAY|XNDORMANT|XNRELAX|XNHELD)
> -#define XNTHREAD_MODE_BITS    (XNLOCK|XNRRB|XNASDI|XNSHIELD|XNTRAPSW|XNRPIOFF)
> +#define XNTHREAD_MODE_BITS    (XNLOCK|XNRRB|XNASDI|XNSHIELD|XNTRAPSW|XNRPIOFF|XNIDLE)
>  
>  /* These state flags are available to the real-time interfaces */
>  #define XNTHREAD_STATE_SPARE0  0x10000000
> @@ -186,6 +187,8 @@
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
> +++ linux-2.6.32-5RR9-new/kernel/xenomai/nucleus/shadow.c	2010-04-14 18:04:20.000000000 -0400
> @@ -1187,7 +1187,7 @@
>  void xnshadow_relax(int notify)
>  {
>  	xnthread_t *thread = xnpod_current_thread();
> -	int prio;
> +	int prio, policy;
>  	spl_t s;
>  
>  	XENO_BUGON(NUCLEUS, xnthread_test_state(thread, XNROOT));
> @@ -1217,9 +1217,9 @@
>  		xnpod_fatal("xnshadow_relax() failed for thread %s[%d]",
>  			    thread->name, xnthread_user_pid(thread));
>  
> -	prio = normalize_priority(xnthread_current_priority(thread));
> -	rthal_reenter_root(get_switch_lock_owner(),
> -			   prio ? SCHED_FIFO : SCHED_NORMAL, prio);
> +	prio = xnthread_test_state(thread, XNIDLE) ? 0 : normalize_priority(xnthread_current_priority(thread));
> +	policy = xnthread_test_state(thread, XNIDLE) ? SCHED_IDLE : (prio ? SCHED_FIFO : SCHED_NORMAL);
> +	rthal_reenter_root(get_switch_lock_owner(), policy, prio);
>  
>  	xnstat_counter_inc(&thread->stat.ssw);	/* Account for secondary mode switch. */
>  
> @@ -2001,8 +2001,13 @@
>  
>  	if (xnpod_shadow_p() && signal_pending(p))
>  		request_syscall_restart(thread, regs, sysflags);
> -	else if ((sysflags & __xn_exec_switchback) != 0 && switched)
> -		xnshadow_harden();	/* -EPERM will be trapped later if needed. */
> +	else if ((sysflags & __xn_exec_switchback) != 0 && switched) {
> +		if (!xnthread_test_state(thread, XNIDLE) || 
> +		    (xnthread_test_state(thread, XNIDLE) && (sysflags & __xn_exec_norelax) != 0))
> +		xnshadow_harden();  /* -EPERM will be trapped later if needed. */
> +	} else if ((sysflags & __xn_exec_norelax) == 0 && xnpod_primary_p() && 
> +			   xnpod_current_thread()->lockcnt == 0 && xnthread_test_state(thread, XNIDLE))
> +		xnshadow_relax(0);
>  
>  	return RTHAL_EVENT_STOP;
>  
> @@ -2137,6 +2142,9 @@
>  		request_syscall_restart(xnshadow_thread(current), regs, sysflags);
>  	else if ((sysflags & __xn_exec_switchback) != 0 && switched)
>  		xnshadow_relax(0);
> +	else if ((sysflags & __xn_exec_norelax) == 0 && xnpod_primary_p() && 
> +			 xnpod_current_thread()->lockcnt == 0 && xnthread_test_state(thread, XNIDLE))
> +		xnshadow_relax(0);
>  
>  	return RTHAL_EVENT_STOP;
>  }
> diff -ruN linux-2.6.32-5RR9/kernel/xenomai/nucleus/thread.c linux-2.6.32-5RR9-new/kernel/xenomai/nucleus/thread.c
> --- linux-2.6.32-5RR9/kernel/xenomai/nucleus/thread.c	2010-04-13 20:02:22.000000000 -0400
> +++ linux-2.6.32-5RR9-new/kernel/xenomai/nucleus/thread.c	2010-04-14 10:38:09.000000000 -0400
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
> +++ linux-2.6.32-5RR9-new/kernel/xenomai/skins/native/mutex.c	2010-04-14 10:38:09.000000000 -0400
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
> diff -ruN linux-2.6.32-5RR9/kernel/xenomai/skins/native/syscall.c linux-2.6.32-5RR9-new/kernel/xenomai/skins/native/syscall.c
> --- linux-2.6.32-5RR9/kernel/xenomai/skins/native/syscall.c	2010-04-13 20:02:22.000000000 -0400
> +++ linux-2.6.32-5RR9-new/kernel/xenomai/skins/native/syscall.c	2010-04-14 10:38:09.000000000 -0400
> @@ -3932,7 +3932,7 @@
>  	[__native_mutex_create] = {&__rt_mutex_create, __xn_exec_any},
>  	[__native_mutex_bind] = {&__rt_mutex_bind, __xn_exec_conforming},
>  	[__native_mutex_delete] = {&__rt_mutex_delete, __xn_exec_any},
> -	[__native_mutex_acquire] = {&__rt_mutex_acquire, __xn_exec_primary},
> +	[__native_mutex_acquire] = {&__rt_mutex_acquire, __xn_exec_primary|__xn_exec_norelax},
>  	[__native_mutex_release] = {&__rt_mutex_release, __xn_exec_primary},
>  	[__native_mutex_inquire] = {&__rt_mutex_inquire, __xn_exec_any},
>  	[__native_cond_create] = {&__rt_cond_create, __xn_exec_any},
> diff -ruN linux-2.6.32-5RR9/kernel/xenomai/skins/native/task.c linux-2.6.32-5RR9-new/kernel/xenomai/skins/native/task.c
> --- linux-2.6.32-5RR9/kernel/xenomai/skins/native/task.c	2010-04-13 20:02:22.000000000 -0400
> +++ linux-2.6.32-5RR9-new/kernel/xenomai/skins/native/task.c	2010-04-14 10:38:09.000000000 -0400
> @@ -1498,7 +1498,7 @@
>  	}
>  
>  	if (((clrmask | setmask) &
> -	     ~(T_LOCK | T_RRB | T_NOSIG | T_SHIELD | T_WARNSW)) != 0)
> +	     ~(T_LOCK | T_RRB | T_NOSIG | T_SHIELD | T_WARNSW | T_IDLE)) != 0)
>  		return -EINVAL;
>  
>  	if (!xnpod_primary_p())
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



