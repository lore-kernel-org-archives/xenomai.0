MIME-Version: 1.0
In-Reply-To: <1272020058.9515.753.camel@domain.hid>
References: <j2yb88603c31004020058i3aae7947s1428f1b87f4b1097@domain.hid>
	<4BB5B64B.6040803@domain.hid> <4BB5B7C1.4020301@domain.hid>
	<4BB5B874.5090904@domain.hid>
	<k2pb88603c31004020232z28e10d59vc546b1b8803113f2@domain.hid>
	<4BB5BA2D.1080604@domain.hid>
	<245373446233674495BCA5CA2FC1EB17378D015932@domain.hid>
	<4BBAD880.5040603@domain.hid>
	<20100415001912.GB26116@domain.hid>
	<1271322120.2365.605.camel@domain.hid>
	<20100420141227.GB9203@domain.hid>
	<1272020058.9515.753.camel@domain.hid>
Date: Thu, 30 Sep 2010 14:52:10 +0200
Message-ID: <AANLkTi=0WtJnPrX1GX-Hd+erzABbNPVP=o5zr4-4=p5Q@mail.gmail.com>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

On Fri, Apr 23, 2010 at 12:54 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On Tue, 2010-04-20 at 10:12 -0400, Andreas Glatz wrote:
>> > > > >> For the time being, you can work around this by issuing a Linux=
 syscall
>> > > > >> before entering long processing loops - unless your task doesn'=
t do this
>> > > > >> anyway, e.g. to perform some Linux I/O.
>> > > > >>
>> > > > >
>> > > > > I think that's need. Currently the statistics task takes a mutex=
 and waits on a message queue for messages. That's the only time it should =
potentially run in primary mode. After it returns the Mutex it should conti=
nue running with a policy similar to SCHED_IDLE to give other tasks a chanc=
e to run. I see how switching back to secondary mode could be achieved by i=
ssuing a Linux syscall. Is there another way which doesn't involve changing=
 the source code of our application? (The proper way?)
>> > > >
>> > > > The proper way would be to not having to change the application co=
de.
>> > > > But this workaround (Linux syscall or *_set_mode()) is required un=
til we
>> > > > improve the nucleus.
>> > >
>> > > I generated a patch against 2.4.10.1 to get this behaviour (see furt=
her down). Instead of having
>> > > to review and insert a Linux syscall or *_set_mode() in the applicat=
ion code I just call
>> > > rt_task_set_mode(0, T_IDLE, NULL) at the beginning of the task body =
of the task which
>> > > should mostly run in secondary mode under SCHED_IDLE (see example fu=
rther down). The task
>> > > marked with T_IDLE will switch to primary mode at every Xenomai skin=
call and immediately
>> > > switch back to secondary mode once the Xenomai skincall is done.
>> > >
>> > > We identified just one case where this task has to stay in primary m=
ode. This is between
>> > > rt_mutex_aquire() and rt_mutex_release() since it may undergo a prio=
rity inversion boost.
>> > > If the task stayed in secondary mode during that time it either woul=
d potentally delay the
>> > > execution of a high priority task or would kill the system.
>> > >
>> > > The patch seems to work for us. Our statistics task which blocked th=
e system for a long
>> > > time (and made the UI running under Linux unresponsive) is running w=
ith T_IDLE. If Linux is
>> > > heavily loaded now the statistics will get out of sync but the UI wi=
ll still be responsive.
>> > >
>> >
>> > The logic of this patch looks ok for the native skin, given that 2.4.x
>> > does not provide a centralized implementation for dealing with exclusi=
ve
>> > resources, like 2.5.x with xnsynch_acquire/release, and always emits a
>> > syscall to manage those resources.
>> >
>> > This said, you could spare the T_IDLE tag by assuming that any non-RT
>> > shadow thread has to switch back to secondary mode after a syscall,
>> > unless the owned resource count is non-zero. This is where we are
>> > heading to in 2.5.x, since the preferred mode of operation for such
>> > thread has to be fundamentally "relaxed" (otherwise, one would have
>> > created a RT thread, right).
>> >
>> > I'm also unsure you should force SCHED_IDLE, instead of picking
>> > SCHED_OTHER for a more general approach to this issue. You can't assum=
e
>> > that userland does want to be reniced that way, at least not from the
>> > nucleus. But I guess this fits your problem though.
>> >
>> > To sum up, since we can't really provide a true SCHED_IDLE policy on
>> > linux (i.e. not a nice-level hack), and implementing a sched class in
>> > Xenomai having a lower priority than the existing xnsched_class_idle (=
in
>> > 2.5.x) is not feasible (we could not run any userland task in it
>> > anyway), we'd better stick with SCHED_OTHER.
>> >
>>
>> Thanks a lot for the feedback. Your suggestions simplified the patch. I
>> also changed SCHED_IDLE to SCHED_OTHER since it might be more beneficial
>> for the broader audience. Any other suggestions?
>
> For an even broader audience, the POSIX skin mutexes should be tracked
> as well.
>
>>
>> After applying this patch, a thread with priority 0 will automatically
>> switch back to secondary mode after every (native) skincall unless the
>> task holds a mutex (simple and nested).
>>
>> The benefit is, that the task with priority 0 (which I called a linux
>> domain rt thread)
>
> Actually, no. This is not a rt thread at all, in the sense that you have
> zero guarantee wrt latency in that case. Such a thread is actually a non
> real-time Xenomai shadow thread, meaning that it may invoke Xenomai
> services that require the caller to be a Xenomai thread, without
> real-time support though.
>
>> =A0can issue (native) skincalls and share resources with
>> high prioritiy task. But it doesn't hold up Linux tasks unless it holds
>> a mutex since it mostly runs in secondary mode and just switches to
>> primary mode when needed.
>>
>> Just one more questions: Philippe said that you have something similar i=
n
>> 2.5. How do you enable it there? By setting the correct sheduling policy=
?
>>
>
> There are plans to have it. That behavior would be enabled whenever the
> linux policy is SCHED_OTHER, and the base priority is 0 Xenomai-wise.
> The latter would be enough for now, but it seems more future-proof not
> to assume that only SCHED_OTHER tasks could be assigned Xenomai priority
> 0.
>

Is there any update on the plans to have Xenomai base priority 0
threads to be operating by default in relaxed mode? We are using 2.5.4
and currently apply the patch below as a workaround. The patch is
similar to the 2.4 patch of Andreas in that it actively switches back
base prio 0 shadowed threads into relaxed mode, but doesn't take any
held locks into account.

Please comment on this patch. If there is any preliminary code for
2.5.x available regarding this functionality I'll be happy to test it
;-)

--- xenomai-2.5.4-orig/ksrc/nucleus/shadow.c	2010-07-03 19:58:26.000000000 =
+0200
+++ xenomai-2.5.4/ksrc/nucleus/shadow.c	2010-09-30 11:35:08.000000000 +0200
@@ -2518,7 +2518,16 @@ static inline int do_losyscall_event(uns
 		sigs =3D 1;
 		handle_rt_signals(thread, regs, sysflags);
 	}
-	if (!sigs && (sysflags & __xn_exec_switchback) !=3D 0 && switched)
+	/*
+	 * Switch back to relaxed state when the syscall requires it
+	 * or when the base priority of the thread is 0. This way
+	 * base-prio 0 threads will by default be in the Linux domain
+	 * and can compete with the Linux threads for the processor.
+	 */
+	if (switched && !sigs &&
+	    ((sysflags & __xn_exec_switchback) ||
+	     (xnpod_active_p() && xnpod_shadow_p() &&
+	      !xnthread_base_priority(xnshadow_thread(current)))))
 		xnshadow_relax(0, 0);

       ret_handled:


>> Andreas
>>
>> PATCH:
>>
>> diff -ruN linux-2.6.32-5RR9/include/xenomai/nucleus/thread.h linux-2.6.3=
2-5RR9-new/include/xenomai/nucleus/thread.h
>> --- linux-2.6.32-5RR9/include/xenomai/nucleus/thread.h =A0 =A0 =A0 =A020=
10-04-13 20:02:21.000000000 -0400
>> +++ linux-2.6.32-5RR9-new/include/xenomai/nucleus/thread.h =A0 =A02010-0=
4-19 09:35:44.000000000 -0400
>> @@ -186,6 +186,8 @@
>>
>> =A0 =A0 =A0xnpqueue_t claimq; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Owned resou=
rces claimed by others (PIP) */
>>
>> + =A0 =A0int lockcnt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Mutexes=
 which are currently locked by this thread */
>> +
>> =A0 =A0 =A0struct xnsynch *wchan; =A0 /* Resource the thread pends on */
>>
>> =A0 =A0 =A0struct xnsynch *wwake; =A0 /* Wait channel the thread was res=
umed from */
>> diff -ruN linux-2.6.32-5RR9/kernel/xenomai/nucleus/shadow.c linux-2.6.32=
-5RR9-new/kernel/xenomai/nucleus/shadow.c
>> --- linux-2.6.32-5RR9/kernel/xenomai/nucleus/shadow.c 2010-04-13 20:02:2=
2.000000000 -0400
>> +++ linux-2.6.32-5RR9-new/kernel/xenomai/nucleus/shadow.c =A0 =A0 2010-0=
4-19 18:06:39.000000000 -0400
>> @@ -976,6 +976,16 @@
>> =A0 =A0 =A0 return prio < MAX_RT_PRIO ? prio : MAX_RT_PRIO - 1;
>> =A0}
>>
>> +static inline int relax_thread(xnthread_t *thread)
>> +{
>> + =A0 =A0 /* A thread with bprio =3D=3D 0 is called a Linux Domain RT th=
read.
>> + =A0 =A0 =A0 =A0It has to switch to secondary mode after every skin cal=
l
>> + =A0 =A0 =A0 =A0if it doesn't hold any mutexes. */
>> + =A0 =A0 return (xnthread_base_priority(thread) =3D=3D 0 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thread->lockcnt =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ? 1 : 0;
>> +}
>> +
>> =A0static int gatekeeper_thread(void *data)
>> =A0{
>> =A0 =A0 =A0 struct __gatekeeper *gk =3D (struct __gatekeeper *)data;
>> @@ -1187,7 +1197,7 @@
>> =A0void xnshadow_relax(int notify)
>> =A0{
>> =A0 =A0 =A0 xnthread_t *thread =3D xnpod_current_thread();
>> - =A0 =A0 int prio;
>> + =A0 =A0 int prio, policy;
>> =A0 =A0 =A0 spl_t s;
>>
>> =A0 =A0 =A0 XENO_BUGON(NUCLEUS, xnthread_test_state(thread, XNROOT));
>> @@ -1217,9 +1227,11 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 xnpod_fatal("xnshadow_relax() failed for thr=
ead %s[%d]",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thread->name, xnthre=
ad_user_pid(thread));
>>
>> + =A0 =A0 /* If thread is a Linux Domain RT thread and it should be rela=
xed the
>> + =A0 =A0 =A0 =A0base priority should be equal to the current priority e=
qual to 0. */
>> + =A0 =A0 policy =3D relax_thread(thread) ? SCHED_NORMAL : SCHED_FIFO;
>> =A0 =A0 =A0 prio =3D normalize_priority(xnthread_current_priority(thread=
));
>> - =A0 =A0 rthal_reenter_root(get_switch_lock_owner(),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prio ? SCHED_FIFO : SCH=
ED_NORMAL, prio);
>> + =A0 =A0 rthal_reenter_root(get_switch_lock_owner(), policy, prio);
>>
>> =A0 =A0 =A0 xnstat_counter_inc(&thread->stat.ssw); =A0/* Account for sec=
ondary mode switch. */
>>
>> @@ -2001,8 +2013,14 @@
>>
>> =A0 =A0 =A0 if (xnpod_shadow_p() && signal_pending(p))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 request_syscall_restart(thread, regs, sysfla=
gs);
>> - =A0 =A0 else if ((sysflags & __xn_exec_switchback) !=3D 0 && switched)
>> - =A0 =A0 =A0 =A0 =A0 =A0 xnshadow_harden(); =A0 =A0 =A0/* -EPERM will b=
e trapped later if needed. */
>> + =A0 =A0 else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 int relax =3D xnpod_shadow_p() && relax_thread=
(thread);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((sysflags & __xn_exec_switchback) !=3D 0 &=
& switched && !relax)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xnshadow_harden(); =A0/* -EPER=
M will be trapped later if needed. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (relax)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xnshadow_relax(0);
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 return RTHAL_EVENT_STOP;
>>
>> @@ -2137,6 +2155,9 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 request_syscall_restart(xnshadow_thread(curr=
ent), regs, sysflags);
>> =A0 =A0 =A0 else if ((sysflags & __xn_exec_switchback) !=3D 0 && switche=
d)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 xnshadow_relax(0);
>> + =A0 =A0 else if (xnpod_active_p() && xnpod_shadow_p() &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0relax_thread(xnshadow_threa=
d(current)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 xnshadow_relax(0);
>>
>> =A0 =A0 =A0 return RTHAL_EVENT_STOP;
>> =A0}
>> diff -ruN linux-2.6.32-5RR9/kernel/xenomai/nucleus/thread.c linux-2.6.32=
-5RR9-new/kernel/xenomai/nucleus/thread.c
>> --- linux-2.6.32-5RR9/kernel/xenomai/nucleus/thread.c 2010-04-13 20:02:2=
2.000000000 -0400
>> +++ linux-2.6.32-5RR9-new/kernel/xenomai/nucleus/thread.c =A0 =A0 2010-0=
4-19 19:00:39.000000000 -0400
>> @@ -124,6 +124,7 @@
>> =A0 =A0 =A0 thread->rpi =3D NULL;
>> =A0#endif /* CONFIG_XENO_OPT_PRIOCPL */
>> =A0 =A0 =A0 initpq(&thread->claimq);
>> + =A0 =A0 thread->lockcnt =3D 0;
>>
>> =A0 =A0 =A0 xnarch_init_display_context(thread);
>>
>> diff -ruN linux-2.6.32-5RR9/kernel/xenomai/skins/native/mutex.c linux-2.=
6.32-5RR9-new/kernel/xenomai/skins/native/mutex.c
>> --- linux-2.6.32-5RR9/kernel/xenomai/skins/native/mutex.c =A0 =A0 2010-0=
4-13 20:02:22.000000000 -0400
>> +++ linux-2.6.32-5RR9-new/kernel/xenomai/skins/native/mutex.c 2010-04-19=
 09:35:44.000000000 -0400
>> @@ -396,6 +396,8 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* xnsynch_sleep_on() might have stolen the =
resource,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0so we need to put our internal data i=
n sync. */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex->lockcnt =3D 1;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 thread->lockcnt++;
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0unlock_and_exit:
>> @@ -462,6 +464,8 @@
>> =A0 =A0 =A0 if (--mutex->lockcnt > 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unlock_and_exit;
>>
>> + =A0 =A0 xnpod_current_thread()->lockcnt--;
>> +
>> =A0 =A0 =A0 if (xnsynch_wakeup_one_sleeper(&mutex->synch_base)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex->lockcnt =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 xnpod_schedule();
>>
>
>
> --
> Philippe.
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

Thanks,
Henri.

