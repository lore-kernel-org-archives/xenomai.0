Date: Thu, 15 Apr 2010 08:36:07 -0400
Message-ID: <20100415123607.GC26116@domain.hid>
References: <j2yb88603c31004020058i3aae7947s1428f1b87f4b1097@domain.hid>
	<4BB5B64B.6040803@domain.hid> <4BB5B7C1.4020301@domain.hid>
	<4BB5B874.5090904@domain.hid>
	<k2pb88603c31004020232z28e10d59vc546b1b8803113f2@domain.hid>
	<4BB5BA2D.1080604@domain.hid>
	<245373446233674495BCA5CA2FC1EB17378D015932@domain.hid>
	<4BBAD880.5040603@domain.hid>
	<20100415001912.GB26116@domain.hid>
	<1271328418.2365.622.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1271328418.2365.622.camel@domain.hid>
From: Andreas Glatz <andreasglatz@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Andreas Glatz <AndreasGlatz@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>

Hi,

On Thu, Apr 15, 2010 at 06:46:58AM -0400, Philippe Gerum wrote:
> On Wed, 2010-04-14 at 20:19 -0400, Andreas Glatz wrote:
> 
> > One thing I've noticed though, and this is not related to the patch (I verified it on a
> > vanilla Xenomai system): Consider the example I included. It prints average cycle times
> > and the cycle time variance of the high priority task ("T2"). I noticed a big difference
> > in the cycle time variance when switching the first task ("T1") to secondary mode with
> > rt_task_set_mode() and setting the scheduler policy to either SCHED_FIFO, SCHED_IDLE or
> > SCHED_NORMAL. I'm assuming someone asked this before and I didn't pay attention :)
> > Can someone give me a short explanation or point me somewhere to get an explanation for
> > this behaviour? I didn't expect such a difference in variance:
> >
> 
> Moving back to secondary mode is nothing more than triggering the
> rescheduling procedure linux-wise, so the time credit for
> SCHED_OTHER/IDLE tasks decay as usual during your work loop, preemption
> by high priority task is more likely and so on. This variance is just
> the sign that those tasks cannot ask for more than what their scheduling
> policy grants.
> 

I think, I didn't express myself clearly enough. I was more puzzled about 
the variance of the pure RT task (task w/o any secondary mode switches).
So it seems that changing the scheduling policy of the "relaxed" task has
an influence on the variance of the pure RT task. So the RT task seems
to wait for the "relaxed" task. But where exacly does it wait for it? Mmmmm...

Andreas


> > SCHED_FIFO:
> > task=2 count=1000 average=10505us variance=851(us)^2
> > task=2 count=1000 average=10504us variance=176(us)^2
> > task=2 count=1000 average=10505us variance=716(us)^2
> > task=2 count=1000 average=10504us variance=148(us)^2
> > task=2 count=1000 average=10504us variance=143(us)^2
> > task=2 count=1000 average=10504us variance=141(us)^2
> > task=2 count=1000 average=10504us variance=138(us)^2
> >
> > SCHED_NORMAL:
> > task=2 count=1000 average=10501us variance=2115(us)^2
> > task=2 count=1000 average=10504us variance=3121(us)^2
> > task=2 count=1000 average=10500us variance=161(us)^2
> > task=2 count=1000 average=10501us variance=1136(us)^2
> > task=2 count=1000 average=10500us variance=194(us)^2
> > task=2 count=1000 average=10501us variance=1971(us)^2
> > task=2 count=1000 average=10500us variance=132(us)^2
> > task=2 count=1000 average=10501us variance=1173(us)^2
> >
> > SCHED_IDLE:
> > task=2 count=1000 average=10504us variance=3413(us)^2
> > task=2 count=1000 average=10503us variance=3567(us)^2
> > task=2 count=1000 average=10504us variance=3409(us)^2
> > task=2 count=1000 average=10504us variance=1743(us)^2
> > task=2 count=1000 average=10504us variance=2710(us)^2
> > task=2 count=1000 average=10504us variance=2548(us)^2
> > task=2 count=1000 average=10504us variance=2364(us)^2
> > task=2 count=1000 average=10504us variance=2867(us)^2
> > task=2 count=1000 average=10504us variance=2755(us)^2
> >
> >
> > Regards, Andreas
> >
> > (Xenomai 2.4.10.1, Linux 2.6.32, Ipipe 2.8)
> >
> >
> > EXAMPLE APPLICATION:
> >
> > #include <stdio.h>
> > #include <unistd.h>
> > #include <native/task.h>
> > #include <native/sem.h>
> > #include <native/mutex.h>
> > #include <sys/mman.h>
> > #include <rtdk.h>
> > #include <sched.h>
> > #include <linux/sched.h>
> >
> > typedef struct test {
> >     RTIME timestamp;
> >     RTIME sum;
> >     RTIME sumsq;
> >     int count;
> > } test_t;
> >
> > static test_t test1 = {0, 0, 0, 0}, test2 = {0, 0, 0, 0};
> > static RT_TASK task1, task2;
> > static RT_MUTEX mutex1, mutex2;
> >
> > static void task_body( void* cookie )
> > {
> >     RTIME timestamp, delta;
> >     test_t* ptr = (test_t*)cookie;
> >     int num = ( ptr == &test1) ? 1 : 2;
> >
> >     if( num == 1 ) rt_task_set_mode(0, 0x00080000, NULL);
> >
> >     while(1)
> >     {
> >         rt_mutex_acquire(&mutex1, TM_INFINITE);
> >
> >         timestamp = __xn_rdtsc();
> >         delta = (timestamp - ptr->timestamp) >> 6 /* in us */;
> >         ptr->sum += delta;
> >         ptr->sumsq += delta*delta;
> >         ptr->timestamp = timestamp;
> >         if( ++ptr->count >= 1000 ) {
> >             RTIME avg, var;
> >             avg = ptr->sum/ptr->count;
> >             var = (ptr->sumsq - (ptr->sum*ptr->sum)/ptr->count)/(ptr->count-1);
> >
> >             if( num == 2 )
> >                 rt_printf("task=%d count=%d average=%lluus variance=%llu(us)^2\n",
> >                           num, ptr->count, avg, var);
> >
> >             ptr->sum = 0;
> >             ptr->sumsq = 0;
> >             ptr->count = 0;
> >         }
> >
> >               // If commented T1 basically runs in a while(1) {}
> >               // loop without any sleeps. UI should be responsive
> >               // since T1 runs with SCHED_IDLE.
> >               // If uncommented the sleep causes T2 to boost the
> >               // priority of T1.
> >         if( num == 1 ) rt_task_sleep(10000000);
> >
> >               // T1 automatically switches to secondary mode after
> >               // this call.
> >         rt_mutex_release(&mutex1);
> >
> >         // Give T1 time to run
> >         if( num == 2 ) rt_task_sleep(10000000);
> >     }
> > }
> >
> > int main(int argc, char* argv[])
> > {
> >     int err;
> >
> >     mlockall(MCL_CURRENT|MCL_FUTURE);
> >
> >     rt_print_auto_init(1);
> >
> >     test1.timestamp = test2.timestamp = __xn_rdtsc();
> >     err  = rt_mutex_create(&mutex1, "M1");
> >     err += rt_mutex_create(&mutex2, "M2");
> >     err += rt_task_spawn(&task1, "T1", 0, 33, 0, task_body, (void*)&test1);
> >     err += rt_task_spawn(&task2, "T2", 0, 66, 0, task_body, (void*)&test2);
> >     if( !err )
> >     {
> >         pause();
> >     }
> >
> >     return err;
> > }
> >
> > IDLE PATCH:
> >
> > diff -ruN linux-2.6.32-5RR9/include/asm-generic/xenomai/syscall.h linux-2.6.32-5RR9-new/include/asm-generic/xenomai/syscall.h
> > --- linux-2.6.32-5RR9/include/asm-generic/xenomai/syscall.h   2010-04-13 20:02:21.000000000 -0400
> > +++ linux-2.6.32-5RR9-new/include/asm-generic/xenomai/syscall.h       2010-04-14 10:38:09.000000000 -0400
> > @@ -89,6 +89,8 @@
> >  #define __xn_exec_adaptive   0x40
> >  /* Do not restart syscall upon signal receipt. */
> >  #define __xn_exec_norestart  0x80
> > +/* Do not switch to secondary mode after syscall if thread has XNIDLE flag set (see #XNIDLE) */
> > +#define __xn_exec_norelax    0x100
> >  /* Context-agnostic syscall. Will actually run in Xenomai domain. */
> >  #define __xn_exec_any        0x0
> >  /* Short-hand for shadow init syscall. */
> > diff -ruN linux-2.6.32-5RR9/include/xenomai/native/task.h linux-2.6.32-5RR9-new/include/xenomai/native/task.h
> > --- linux-2.6.32-5RR9/include/xenomai/native/task.h   2010-04-13 20:02:21.000000000 -0400
> > +++ linux-2.6.32-5RR9-new/include/xenomai/native/task.h       2010-04-14 10:38:09.000000000 -0400
> > @@ -52,6 +52,7 @@
> >  #define T_SHIELD   XNSHIELD   /**< See #XNSHIELD  */
> >  #define T_WARNSW   XNTRAPSW   /**< See #XNTRAPSW  */
> >  #define T_RPIOFF   XNRPIOFF   /**< See #XNRPIOFF  */
> > +#define T_IDLE     XNIDLE     /**< See #XNIDLE    */
> >  #define T_PRIMARY  0x00000200        /* Recycle internal bits status which */
> >  #define T_JOINABLE 0x00000400        /* won't be passed to the nucleus.  */
> >  /*! @} */ /* Ends doxygen-group native_task_status */
> > diff -ruN linux-2.6.32-5RR9/include/xenomai/nucleus/thread.h linux-2.6.32-5RR9-new/include/xenomai/nucleus/thread.h
> > --- linux-2.6.32-5RR9/include/xenomai/nucleus/thread.h        2010-04-13 20:02:21.000000000 -0400
> > +++ linux-2.6.32-5RR9-new/include/xenomai/nucleus/thread.h    2010-04-14 10:38:09.000000000 -0400
> > @@ -55,6 +55,7 @@
> >  #define XNSHIELD  0x00010000 /**< IRQ shield is enabled (shadow only) */
> >  #define XNTRAPSW  0x00020000 /**< Trap execution mode switches */
> >  #define XNRPIOFF  0x00040000 /**< Stop priority coupling (shadow only) */
> > +#define XNIDLE    0x00080000 /**< Switches to secondary mode after syscalls if not holding mutexes */
> >
> >  #define XNFPU     0x00100000 /**< Thread uses FPU */
> >  #define XNSHADOW  0x00200000 /**< Shadow thread */
> > @@ -90,7 +91,7 @@
> >  }
> >
> >  #define XNTHREAD_BLOCK_BITS   (XNSUSP|XNPEND|XNDELAY|XNDORMANT|XNRELAX|XNHELD)
> > -#define XNTHREAD_MODE_BITS    (XNLOCK|XNRRB|XNASDI|XNSHIELD|XNTRAPSW|XNRPIOFF)
> > +#define XNTHREAD_MODE_BITS    (XNLOCK|XNRRB|XNASDI|XNSHIELD|XNTRAPSW|XNRPIOFF|XNIDLE)
> >
> >  /* These state flags are available to the real-time interfaces */
> >  #define XNTHREAD_STATE_SPARE0  0x10000000
> > @@ -186,6 +187,8 @@
> >
> >      xnpqueue_t claimq;               /* Owned resources claimed by others (PIP) */
> >
> > +    int lockcnt;                     /* Mutexes which are currently locked by this thread */
> > +
> >      struct xnsynch *wchan;   /* Resource the thread pends on */
> >
> >      struct xnsynch *wwake;   /* Wait channel the thread was resumed from */
> > diff -ruN linux-2.6.32-5RR9/kernel/xenomai/nucleus/shadow.c linux-2.6.32-5RR9-new/kernel/xenomai/nucleus/shadow.c
> > --- linux-2.6.32-5RR9/kernel/xenomai/nucleus/shadow.c 2010-04-13 20:02:22.000000000 -0400
> > +++ linux-2.6.32-5RR9-new/kernel/xenomai/nucleus/shadow.c     2010-04-14 18:04:20.000000000 -0400
> > @@ -1187,7 +1187,7 @@
> >  void xnshadow_relax(int notify)
> >  {
> >       xnthread_t *thread = xnpod_current_thread();
> > -     int prio;
> > +     int prio, policy;
> >       spl_t s;
> >
> >       XENO_BUGON(NUCLEUS, xnthread_test_state(thread, XNROOT));
> > @@ -1217,9 +1217,9 @@
> >               xnpod_fatal("xnshadow_relax() failed for thread %s[%d]",
> >                           thread->name, xnthread_user_pid(thread));
> >
> > -     prio = normalize_priority(xnthread_current_priority(thread));
> > -     rthal_reenter_root(get_switch_lock_owner(),
> > -                        prio ? SCHED_FIFO : SCHED_NORMAL, prio);
> > +     prio = xnthread_test_state(thread, XNIDLE) ? 0 : normalize_priority(xnthread_current_priority(thread));
> > +     policy = xnthread_test_state(thread, XNIDLE) ? SCHED_IDLE : (prio ? SCHED_FIFO : SCHED_NORMAL);
> > +     rthal_reenter_root(get_switch_lock_owner(), policy, prio);
> >
> >       xnstat_counter_inc(&thread->stat.ssw);  /* Account for secondary mode switch. */
> >
> > @@ -2001,8 +2001,13 @@
> >
> >       if (xnpod_shadow_p() && signal_pending(p))
> >               request_syscall_restart(thread, regs, sysflags);
> > -     else if ((sysflags & __xn_exec_switchback) != 0 && switched)
> > -             xnshadow_harden();      /* -EPERM will be trapped later if needed. */
> > +     else if ((sysflags & __xn_exec_switchback) != 0 && switched) {
> > +             if (!xnthread_test_state(thread, XNIDLE) ||
> > +                 (xnthread_test_state(thread, XNIDLE) && (sysflags & __xn_exec_norelax) != 0))
> > +             xnshadow_harden();  /* -EPERM will be trapped later if needed. */
> > +     } else if ((sysflags & __xn_exec_norelax) == 0 && xnpod_primary_p() &&
> > +                        xnpod_current_thread()->lockcnt == 0 && xnthread_test_state(thread, XNIDLE))
> > +             xnshadow_relax(0);
> >
> >       return RTHAL_EVENT_STOP;
> >
> > @@ -2137,6 +2142,9 @@
> >               request_syscall_restart(xnshadow_thread(current), regs, sysflags);
> >       else if ((sysflags & __xn_exec_switchback) != 0 && switched)
> >               xnshadow_relax(0);
> > +     else if ((sysflags & __xn_exec_norelax) == 0 && xnpod_primary_p() &&
> > +                      xnpod_current_thread()->lockcnt == 0 && xnthread_test_state(thread, XNIDLE))
> > +             xnshadow_relax(0);
> >
> >       return RTHAL_EVENT_STOP;
> >  }
> > diff -ruN linux-2.6.32-5RR9/kernel/xenomai/nucleus/thread.c linux-2.6.32-5RR9-new/kernel/xenomai/nucleus/thread.c
> > --- linux-2.6.32-5RR9/kernel/xenomai/nucleus/thread.c 2010-04-13 20:02:22.000000000 -0400
> > +++ linux-2.6.32-5RR9-new/kernel/xenomai/nucleus/thread.c     2010-04-14 10:38:09.000000000 -0400
> > @@ -124,6 +124,7 @@
> >       thread->rpi = NULL;
> >  #endif /* CONFIG_XENO_OPT_PRIOCPL */
> >       initpq(&thread->claimq);
> > +     thread->lockcnt = 0;
> >
> >       xnarch_init_display_context(thread);
> >
> > diff -ruN linux-2.6.32-5RR9/kernel/xenomai/skins/native/mutex.c linux-2.6.32-5RR9-new/kernel/xenomai/skins/native/mutex.c
> > --- linux-2.6.32-5RR9/kernel/xenomai/skins/native/mutex.c     2010-04-13 20:02:22.000000000 -0400
> > +++ linux-2.6.32-5RR9-new/kernel/xenomai/skins/native/mutex.c 2010-04-14 10:38:09.000000000 -0400
> > @@ -396,6 +396,8 @@
> >               /* xnsynch_sleep_on() might have stolen the resource,
> >                  so we need to put our internal data in sync. */
> >               mutex->lockcnt = 1;
> > +
> > +             thread->lockcnt++;
> >       }
> >
> >        unlock_and_exit:
> > @@ -462,6 +464,8 @@
> >       if (--mutex->lockcnt > 0)
> >               goto unlock_and_exit;
> >
> > +     xnpod_current_thread()->lockcnt--;
> > +
> >       if (xnsynch_wakeup_one_sleeper(&mutex->synch_base)) {
> >               mutex->lockcnt = 1;
> >               xnpod_schedule();
> > diff -ruN linux-2.6.32-5RR9/kernel/xenomai/skins/native/syscall.c linux-2.6.32-5RR9-new/kernel/xenomai/skins/native/syscall.c
> > --- linux-2.6.32-5RR9/kernel/xenomai/skins/native/syscall.c   2010-04-13 20:02:22.000000000 -0400
> > +++ linux-2.6.32-5RR9-new/kernel/xenomai/skins/native/syscall.c       2010-04-14 10:38:09.000000000 -0400
> > @@ -3932,7 +3932,7 @@
> >       [__native_mutex_create] = {&__rt_mutex_create, __xn_exec_any},
> >       [__native_mutex_bind] = {&__rt_mutex_bind, __xn_exec_conforming},
> >       [__native_mutex_delete] = {&__rt_mutex_delete, __xn_exec_any},
> > -     [__native_mutex_acquire] = {&__rt_mutex_acquire, __xn_exec_primary},
> > +     [__native_mutex_acquire] = {&__rt_mutex_acquire, __xn_exec_primary|__xn_exec_norelax},
> >       [__native_mutex_release] = {&__rt_mutex_release, __xn_exec_primary},
> >       [__native_mutex_inquire] = {&__rt_mutex_inquire, __xn_exec_any},
> >       [__native_cond_create] = {&__rt_cond_create, __xn_exec_any},
> > diff -ruN linux-2.6.32-5RR9/kernel/xenomai/skins/native/task.c linux-2.6.32-5RR9-new/kernel/xenomai/skins/native/task.c
> > --- linux-2.6.32-5RR9/kernel/xenomai/skins/native/task.c      2010-04-13 20:02:22.000000000 -0400
> > +++ linux-2.6.32-5RR9-new/kernel/xenomai/skins/native/task.c  2010-04-14 10:38:09.000000000 -0400
> > @@ -1498,7 +1498,7 @@
> >       }
> >
> >       if (((clrmask | setmask) &
> > -          ~(T_LOCK | T_RRB | T_NOSIG | T_SHIELD | T_WARNSW)) != 0)
> > +          ~(T_LOCK | T_RRB | T_NOSIG | T_SHIELD | T_WARNSW | T_IDLE)) != 0)
> >               return -EINVAL;
> >
> >       if (!xnpod_primary_p())
> >
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> 
> 
> --
> Philippe.
> 
> 

