Message-ID: <3535aae80708290640x37ea29f1y17dc34a2823fed11@domain.hid>
Date: Wed, 29 Aug 2007 15:40:17 +0200
From: "andy motten" <andy.motten@domain.hid>
In-Reply-To: <46D50DFC.5080304@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1129_29888481.1188394817787"
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>
	<46BC8074.3090104@domain.hid>
	<Pine.LNX.4.64.0708130903220.14311@domain.hid>
	<18112.1512.506911.608273@domain.hid>
	<3535aae80708130810s603edb7fo9f7be56342ddf921@domain.hid>
	<46C08E61.9060204@domain.hid>
	<3535aae80708140826o107e0fa3wee8db991ec1e14bd@domain.hid>
	<3535aae80708270627l4064dd1fif3e6aa10314d38f@domain.hid>
	<46D301EE.5020805@domain.hid> <46D50DFC.5080304@domain.hid>
Subject: Re: [Xenomai-help] hard lock-up
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

------=_Part_1129_29888481.1188394817787
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> Jan Kiszka wrote:
> > andy motten wrote:
> >>> I will run continuously several tests on the pc (including "latency
> -f")
> >>> for the rest of this week. Since I am not in the office during this
> period
> >>> (so not in the neighborhood of this problematic pc).
> >>> And I hope (I hope not in vain) that the latency tracer will give us a
> >>> hint for the reason of the hard lock ups (if a hard lock up happens
> during
> >>> this period).
> >>>
> >>> andy
> >>>
> >>
> >> Hello,
> >>
> >> Since  we are having a hard time finding the hard lock-ups. We have
> taken a
> >> closer look at the failed tests of orocos (maybe the source of the
> problem
> >> is the same). These failures occur during the make check execution.
> >>
> >>     The following tests FAILED:
> >>         2 - task-test (OTHER-FAULT)
> >>         3 - event-test (OTHER-FAULT)
> >>         4 - taskcontext-test (OTHER-FAULT)
> >>
> >> When we perform a single test, e.g task-test, we get the the following
> >> messages: Killed
> >> The OROCOS messages are then:
> >>
> >> 0.000 [ Info   ][Logger] Successfully extracted environment variable
> >> ORO_LOGLEVEL
> >> 0.001 [ Info   ][Logger]  OROCOS version '1.2.1' compiled with GCC
> >> 4.1.2.Orocos Logging Activated at level : [ Debug  ] ( 6 )
> >> 0.001 [ Info   ][Logger] Reference System Time is : 880886725351 ticks
> (
> >> 315.369 seconds ).
> >> 0.002 [ Info   ][Logger] Logging is relative to this time.
> >> 0.002 [ Info   ][Logger] Xenomai Periodic Timer runs in preemptive
> >> 'one-shot' mode.
> >> 0.003 [ Debug  ][Logger] Xenomai Timer and Main Task Created
> >> 0.003 [ Debug  ][Logger] MainThread started.
> >> 0.003 [ Debug  ][Logger] Starting StartStopManager.
> >> 0.004 [ Info   ][Toolkit] Loading Tool RealTime.
> >> 0.005 [ Debug  ][Toolkit] Registered Type 'int' to the Orocos Type
> System.
> >> 0.005 [ Debug  ][Toolkit] Registered Type 'uint' to the Orocos Type
> System.
> >> 0.006 [ Debug  ][Toolkit] Registered Type 'double' to the Orocos Type
> >> System.
> >> 0.006 [ Debug  ][Toolkit] Registered Type 'bool' to the Orocos Type
> System.
> >> 0.006 [ Debug  ][Toolkit] Registered Type 'PropertyBag' to the Orocos
> Type
> >> System.
> >> 0.007 [ Debug  ][Toolkit] Registered Type 'float' to the Orocos Type
> System.
> >> 0.007 [ Debug  ][Toolkit] Registered Type 'char' to the Orocos Type
> System.
> >> 0.008 [ Debug  ][Toolkit] Registered Type 'array' to the Orocos Type
> System.
> >> 0.008 [ Debug  ][Toolkit] Registered Type 'string' to the Orocos Type
> >> System.
> >> 0.010 [ Debug  ][./task-test::main()] ORO_main starting...
> >> 0.010 [ Info   ][./task-test::main()] LogLevel unaltered by
> test-runner.
> >> 0.011 [ Info   ][./task-test::main()] Creating PeriodicThread for
> scheduler:
> >> 0
> >> 0.012 [ Info   ][TimerThreadInstance] PeriodicThread created with
> scheduler
> >> type '0', priority 15 and period 0.01.
> >> 0.013 [ Debug  ][Logger] Periodic Thread TimerThreadInstance started.
> >> 0.014 [ Info   ][PThread] PeriodicThread created with scheduler type
> '0',
> >> priority 99 and period 0.1.
> >> 0.014 [ Debug  ][Logger] Periodic Thread PThread started.
> >> 0.115 [ Debug  ][Logger] Periodic Thread PThread stopping... done.
> >> 0.115 [ Debug  ][Logger] Periodic Thread PThread started.
> >> 1.216 [ Debug  ][Logger] Periodic Thread PThread stopping... done.
> >> 1.216 [ Debug  ][~PeriodicThread] Terminating PThread
> >>
> >> On the serial console we get the following listing (complete listing in
> >> appendix):
> >>
> >> Xenomai: starting native API services.
> >> I-pipe: Detected illicit call from domain 'Xenomai'
> >>         into a service reserved for domain 'Linux' and below.
> >>        f635be74 00000000 00000000 52544149 f635be98 c0104789 c02cfa4f
> >> c02f5b80
> >>        f6c4e2f0 f635beb0 c0137d69 c02c256c c02c1186 c02c01b8 f8c0b280
> >> f635bebc
> >>        c0132981 f60a1730 f635bed8 f8bd8570 c010ef8c 00000000 f60a0120
> >> f8beefe0
> >> Call Trace:
> >>  [<c0103ffb>] show_trace_log_lvl+0x1f/0x35
> >>  [<c01040bb>] show_stack_log_lvl+0xaa/0xcf
> >>  [<c0104789>] show_stack+0x2f/0x36
> >>  [<c0137d69>] ipipe_check_context+0x7a/0x81
> >>  [<c0132981>] module_put+0x19/0x7d
> >>  [<f8bd8570>] xnshadow_unmap+0xbc/0xff [xeno_nucleus]
> >>  [<f8bfdc75>] __shadow_delete_hook+0x25/0x27 [xeno_native]
> >>  [<f8bd1454>] xnpod_delete_thread+0x1b9/0x2aa [xeno_nucleus]
> >>  [<f8bfc36b>] rt_task_delete+0x140/0x145 [xeno_native]
> >>  [<f8bfe02a>] __rt_task_delete+0x58/0x69 [xeno_native]
> >>  [<f8bd8165>] hisyscall_event+0x185/0x291 [xeno_nucleus]
> >>  [<c0138940>] __ipipe_dispatch_event+0xc0/0x1da
> >>  [<c010ed6b>] __ipipe_syscall_root+0x43/0x10a
> >>  [<c0102e79>] system_call+0x29/0x41
> >>  =======================
> >
> > That specific Xenomai bug should be fixed in 2.4, please check your
> > testcase against -rc1 e.g. Unfortunately we have no backport of the fix
> > in 2.3 yet. Can't tell right now if this is tricky, but this test
> > demonstrates that $SOMETHING should be done...
>
> OK, in order to start fixing things: Here comes a back-port of the 2.4
> patch to 2.3.x-SVN, moving module_put out of RT context. Be warned, it's
> an early-morning hack, not even compile-tested. Feedback welcome!
>
> Thanks,
> Jan
>
> Index: xenomai-2.3.x/ChangeLog
> ===================================================================
> --- xenomai-2.3.x/ChangeLog     (Revision 2954)
> +++ xenomai-2.3.x/ChangeLog     (Arbeitskopie)
> @@ -1,3 +1,8 @@
> +2007-08-29  Jan Kiszka  <jan.kiszka@domain.hid>
> +
> +       * ksrc/nucleus/shadow.c: Postpone module_put() to the lo-stage
> +       APC handler (back-ported from 2.4).
> +
> 2007-08-24  Wolfgang Grandegger  <wg@domain.hid>
>
>         * ksrc/drivers/can/rtcan_socket.c: protect the list of RTCAN
> Index: xenomai-2.3.x/ksrc/nucleus/shadow.c
> ===================================================================
> --- xenomai-2.3.x/ksrc/nucleus/shadow.c (Revision 2954)
> +++ xenomai-2.3.x/ksrc/nucleus/shadow.c (Arbeitskopie)
> @@ -99,6 +99,7 @@ static struct __lostagerq {
> #define LO_RENICE_REQ 2
> #define LO_SIGGRP_REQ 3
> #define LO_SIGTHR_REQ 4
> +#define LO_UNMAP_REQ  5
>                 int type;
>                 struct task_struct *task;
>                 int arg;
> @@ -753,6 +754,28 @@ void xnshadow_reset_shield(void)
>
> #endif /* CONFIG_XENO_OPT_ISHIELD */
>
> +static void xnshadow_dereference_skin(unsigned magic)
> +{
> +       unsigned muxid;
> +
> +       for (muxid = 0; muxid < XENOMAI_MUX_NR; muxid++) {
> +               if (muxtable[muxid].magic == magic) {
> +                       if
> (xnarch_atomic_dec_and_test(&muxtable[0].refcnt))
> +                               xnarch_atomic_dec(&muxtable[0].refcnt);
> +                       if
> (xnarch_atomic_dec_and_test(&muxtable[muxid].refcnt))
> +
> +                               /* We were the last thread, decrement the
> counter,
> +                                  since it was incremented by the
> xn_sys_bind
> +                                  operation. */
> +
> xnarch_atomic_dec(&muxtable[muxid].refcnt);
> +                       if (muxtable[muxid].module)
> +                               module_put(muxtable[muxid].module);
> +
> +                       break;
> +               }
> +       }
> +}
> +
> static void lostage_handler(void *cookie)
> {
>         int cpuid = smp_processor_id(), reqnum, sig;
> @@ -777,6 +800,12 @@ static void lostage_handler(void *cookie
>
>                         goto do_wakeup;
>
> +               case LO_UNMAP_REQ:
> +
> +                       xnshadow_dereference_skin(
> +                               (unsigned)rq->req[reqnum].arg);
> +
> +               /* fall through */
>                 case LO_WAKEUP_REQ:
>
>                         /* We need to downgrade the root thread
> @@ -1256,7 +1285,6 @@ int xnshadow_map(xnthread_t *thread, xnc
> void xnshadow_unmap(xnthread_t *thread)
> {
>         struct task_struct *p;
> -       unsigned muxid, magic;
>
>         if (XENO_DEBUG(NUCLEUS) &&
>             !testbits(xnpod_current_sched()->status, XNKCOUT))
> @@ -1264,25 +1292,6 @@ void xnshadow_unmap(xnthread_t *thread)
>
>         p = xnthread_archtcb(thread)->user_task;
>
> -       magic = xnthread_get_magic(thread);
> -
> -       for (muxid = 0; muxid < XENOMAI_MUX_NR; muxid++) {
> -               if (muxtable[muxid].magic == magic) {
> -                       if
> (xnarch_atomic_dec_and_test(&muxtable[0].refcnt))
> -                               xnarch_atomic_dec(&muxtable[0].refcnt);
> -                       if
> (xnarch_atomic_dec_and_test(&muxtable[muxid].refcnt))
> -
> -                               /* We were the last thread, decrement the
> counter,
> -                                  since it was incremented by the
> xn_sys_bind
> -                                  operation. */
> -
> xnarch_atomic_dec(&muxtable[muxid].refcnt);
> -                       if (muxtable[muxid].module)
> -                               module_put(muxtable[muxid].module);
> -
> -                       break;
> -               }
> -       }
> -
>         xnthread_clear_state(thread, XNMAPPED);
>         rpi_pop(thread);
>
> @@ -1298,13 +1307,7 @@ void xnshadow_unmap(xnthread_t *thread)
>
>         xnshadow_thrptd(p) = NULL;
>
> -       if (p->state != TASK_RUNNING)
> -               /* If the shadow is being unmapped in primary mode or
> blocked
> -                  in secondary mode, the associated Linux task should
> also
> -                  die. In the former case, the zombie Linux side
> returning to
> -                  user-space will be trapped and exited inside the pod's
> -                  rescheduling routines. */
> -               schedule_linux_call(LO_WAKEUP_REQ, p, 0);
> +       schedule_linux_call(LO_UNMAP_REQ, p, xnthread_get_magic(thread));
> }
>
> int xnshadow_wait_barrier(struct pt_regs *regs)
> @@ -2010,6 +2013,7 @@ RTHAL_DECLARE_EVENT(losyscall_event);
> static inline void do_taskexit_event(struct task_struct *p)
> {
>         xnthread_t *thread = xnshadow_thread(p); /* p == current */
> +       unsigned magic;
>         spl_t s;
>
>         if (!thread)
> @@ -2018,6 +2022,8 @@ static inline void do_taskexit_event(str
>         if (xnpod_shadow_p())
>                 xnshadow_relax(0);
>
> +       magic = xnthread_get_magic(thread);
> +
>         xnlock_get_irqsave(&nklock, s);
>         /* Prevent wakeup call from xnshadow_unmap(). */
>         xnshadow_thrptd(p) = NULL;
> @@ -2028,6 +2034,7 @@ static inline void do_taskexit_event(str
>         xnlock_put_irqrestore(&nklock, s);
>         xnpod_schedule();
>
> +       xnshadow_dereference_skin(magic);
>         xnltt_log_event(xeno_ev_shadowexit, thread->name);
> }


This  patch is working with linux kernel 2.6.20.9 and ipipe 1.8-08.

thanks andy

------=_Part_1129_29888481.1188394817787
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><span class="gmail_quote"><br></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan Kiszka wrote:<br>&gt; andy motten wrote:<br>&gt;&gt;&gt; I will run continuously several tests on the pc (including &quot;latency -f&quot;)
<br>&gt;&gt;&gt; for the rest of this week. Since I am not in the office during this period<br>&gt;&gt;&gt; (so not in the neighborhood of this problematic pc).<br>&gt;&gt;&gt; And I hope (I hope not in vain) that the latency tracer will give us a
<br>&gt;&gt;&gt; hint for the reason of the hard lock ups (if a hard lock up happens during<br>&gt;&gt;&gt; this period).<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; andy<br>&gt;&gt;&gt;<br>&gt;&gt;<br>&gt;&gt; Hello,<br>&gt;&gt;<br>
&gt;&gt; Since&nbsp;&nbsp;we are having a hard time finding the hard lock-ups. We have taken a<br>&gt;&gt; closer look at the failed tests of orocos (maybe the source of the problem<br>&gt;&gt; is the same). These failures occur during the make check execution.
<br>&gt;&gt;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; The following tests FAILED:<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 - task-test (OTHER-FAULT)<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3 - event-test (OTHER-FAULT)<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4 - taskcontext-test (OTHER-FAULT)<br>&gt;&gt;<br>
&gt;&gt; When we perform a single test, e.g task-test, we get the the following<br>&gt;&gt; messages: Killed<br>&gt;&gt; The OROCOS messages are then:<br>&gt;&gt;<br>&gt;&gt; 0.000 [ Info&nbsp;&nbsp; ][Logger] Successfully extracted environment variable
<br>&gt;&gt; ORO_LOGLEVEL<br>&gt;&gt; 0.001 [ Info&nbsp;&nbsp; ][Logger]&nbsp;&nbsp;OROCOS version &#39;1.2.1&#39; compiled with GCC<br>&gt;&gt; 4.1.2.Orocos Logging Activated at level : [ Debug&nbsp;&nbsp;] ( 6 )<br>&gt;&gt; 0.001 [ Info&nbsp;&nbsp; ][Logger] Reference System Time is : 880886725351 ticks (
<br>&gt;&gt; 315.369 seconds ).<br>&gt;&gt; 0.002 [ Info&nbsp;&nbsp; ][Logger] Logging is relative to this time.<br>&gt;&gt; 0.002 [ Info&nbsp;&nbsp; ][Logger] Xenomai Periodic Timer runs in preemptive<br>&gt;&gt; &#39;one-shot&#39; mode.<br>
&gt;&gt; 0.003 [ Debug&nbsp;&nbsp;][Logger] Xenomai Timer and Main Task Created<br>&gt;&gt; 0.003 [ Debug&nbsp;&nbsp;][Logger] MainThread started.<br>&gt;&gt; 0.003 [ Debug&nbsp;&nbsp;][Logger] Starting StartStopManager.<br>&gt;&gt; 0.004 [ Info&nbsp;&nbsp; ][Toolkit] Loading Tool RealTime.
<br>&gt;&gt; 0.005 [ Debug&nbsp;&nbsp;][Toolkit] Registered Type &#39;int&#39; to the Orocos Type System.<br>&gt;&gt; 0.005 [ Debug&nbsp;&nbsp;][Toolkit] Registered Type &#39;uint&#39; to the Orocos Type System.<br>&gt;&gt; 0.006 [ Debug&nbsp;&nbsp;][Toolkit] Registered Type &#39;double&#39; to the Orocos Type
<br>&gt;&gt; System.<br>&gt;&gt; 0.006 [ Debug&nbsp;&nbsp;][Toolkit] Registered Type &#39;bool&#39; to the Orocos Type System.<br>&gt;&gt; 0.006 [ Debug&nbsp;&nbsp;][Toolkit] Registered Type &#39;PropertyBag&#39; to the Orocos Type<br>&gt;&gt; System.
<br>&gt;&gt; 0.007 [ Debug&nbsp;&nbsp;][Toolkit] Registered Type &#39;float&#39; to the Orocos Type System.<br>&gt;&gt; 0.007 [ Debug&nbsp;&nbsp;][Toolkit] Registered Type &#39;char&#39; to the Orocos Type System.<br>&gt;&gt; 0.008 [ Debug&nbsp;&nbsp;][Toolkit] Registered Type &#39;array&#39; to the Orocos Type System.
<br>&gt;&gt; 0.008 [ Debug&nbsp;&nbsp;][Toolkit] Registered Type &#39;string&#39; to the Orocos Type<br>&gt;&gt; System.<br>&gt;&gt; 0.010 [ Debug&nbsp;&nbsp;][./task-test::main()] ORO_main starting...<br>&gt;&gt; 0.010 [ Info&nbsp;&nbsp; ][./task-test::main()] LogLevel unaltered by test-runner.
<br>&gt;&gt; 0.011 [ Info&nbsp;&nbsp; ][./task-test::main()] Creating PeriodicThread for scheduler:<br>&gt;&gt; 0<br>&gt;&gt; 0.012 [ Info&nbsp;&nbsp; ][TimerThreadInstance] PeriodicThread created with scheduler<br>&gt;&gt; type &#39;0&#39;, priority 15 and period 
0.01.<br>&gt;&gt; 0.013 [ Debug&nbsp;&nbsp;][Logger] Periodic Thread TimerThreadInstance started.<br>&gt;&gt; 0.014 [ Info&nbsp;&nbsp; ][PThread] PeriodicThread created with scheduler type &#39;0&#39;,<br>&gt;&gt; priority 99 and period 0.1.
<br>&gt;&gt; 0.014 [ Debug&nbsp;&nbsp;][Logger] Periodic Thread PThread started.<br>&gt;&gt; 0.115 [ Debug&nbsp;&nbsp;][Logger] Periodic Thread PThread stopping... done.<br>&gt;&gt; 0.115 [ Debug&nbsp;&nbsp;][Logger] Periodic Thread PThread started.<br>
&gt;&gt; 1.216 [ Debug&nbsp;&nbsp;][Logger] Periodic Thread PThread stopping... done.<br>&gt;&gt; 1.216 [ Debug&nbsp;&nbsp;][~PeriodicThread] Terminating PThread<br>&gt;&gt;<br>&gt;&gt; On the serial console we get the following listing (complete listing in
<br>&gt;&gt; appendix):<br>&gt;&gt;<br>&gt;&gt; Xenomai: starting native API services.<br>&gt;&gt; I-pipe: Detected illicit call from domain &#39;Xenomai&#39;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; into a service reserved for domain &#39;Linux&#39; and below.
<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;f635be74 00000000 00000000 52544149 f635be98 c0104789 c02cfa4f<br>&gt;&gt; c02f5b80<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;f6c4e2f0 f635beb0 c0137d69 c02c256c c02c1186 c02c01b8 f8c0b280<br>&gt;&gt; f635bebc<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c0132981 f60a1730 f635bed8 f8bd8570 c010ef8c 00000000 f60a0120
<br>&gt;&gt; f8beefe0<br>&gt;&gt; Call Trace:<br>&gt;&gt;&nbsp;&nbsp;[&lt;c0103ffb&gt;] show_trace_log_lvl+0x1f/0x35<br>&gt;&gt;&nbsp;&nbsp;[&lt;c01040bb&gt;] show_stack_log_lvl+0xaa/0xcf<br>&gt;&gt;&nbsp;&nbsp;[&lt;c0104789&gt;] show_stack+0x2f/0x36<br>
&gt;&gt;&nbsp;&nbsp;[&lt;c0137d69&gt;] ipipe_check_context+0x7a/0x81<br>&gt;&gt;&nbsp;&nbsp;[&lt;c0132981&gt;] module_put+0x19/0x7d<br>&gt;&gt;&nbsp;&nbsp;[&lt;f8bd8570&gt;] xnshadow_unmap+0xbc/0xff [xeno_nucleus]<br>&gt;&gt;&nbsp;&nbsp;[&lt;f8bfdc75&gt;] __shadow_delete_hook+0x25/0x27 [xeno_native]
<br>&gt;&gt;&nbsp;&nbsp;[&lt;f8bd1454&gt;] xnpod_delete_thread+0x1b9/0x2aa [xeno_nucleus]<br>&gt;&gt;&nbsp;&nbsp;[&lt;f8bfc36b&gt;] rt_task_delete+0x140/0x145 [xeno_native]<br>&gt;&gt;&nbsp;&nbsp;[&lt;f8bfe02a&gt;] __rt_task_delete+0x58/0x69 [xeno_native]
<br>&gt;&gt;&nbsp;&nbsp;[&lt;f8bd8165&gt;] hisyscall_event+0x185/0x291 [xeno_nucleus]<br>&gt;&gt;&nbsp;&nbsp;[&lt;c0138940&gt;] __ipipe_dispatch_event+0xc0/0x1da<br>&gt;&gt;&nbsp;&nbsp;[&lt;c010ed6b&gt;] __ipipe_syscall_root+0x43/0x10a<br>&gt;&gt;&nbsp;&nbsp;[&lt;c0102e79&gt;] system_call+0x29/0x41
<br>&gt;&gt;&nbsp;&nbsp;=======================<br>&gt;<br>&gt; That specific Xenomai bug should be fixed in 2.4, please check your<br>&gt; testcase against -rc1 e.g. Unfortunately we have no backport of the fix<br>&gt; in 2.3 yet. Can&#39;t tell right now if this is tricky, but this test
<br>&gt; demonstrates that $SOMETHING should be done...<br><br>OK, in order to start fixing things: Here comes a back-port of the 2.4<br>patch to 2.3.x-SVN, moving module_put out of RT context. Be warned, it&#39;s<br>an early-morning hack, not even compile-tested. Feedback welcome!
<br><br>Thanks,<br>Jan<br><br>Index: xenomai-2.3.x/ChangeLog<br>===================================================================<br>--- xenomai-2.3.x/ChangeLog&nbsp;&nbsp;&nbsp;&nbsp; (Revision 2954)<br>+++ xenomai-2.3.x/ChangeLog&nbsp;&nbsp;&nbsp;&nbsp; (Arbeitskopie)
<br>@@ -1,3 +1,8 @@<br>+2007-08-29&nbsp;&nbsp;Jan Kiszka&nbsp;&nbsp;&lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * ksrc/nucleus/shadow.c: Postpone module_put() to the lo-stage<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; APC handler (back-ported from 
2.4).<br>+<br> 2007-08-24&nbsp;&nbsp;Wolfgang Grandegger&nbsp;&nbsp;&lt;<a href="mailto:wg@domain.hid">wg@domain.hid</a>&gt;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* ksrc/drivers/can/rtcan_socket.c: protect the list of RTCAN<br>Index: xenomai-2.3.x/ksrc/nucleus/shadow.c
<br>===================================================================<br>--- xenomai-2.3.x/ksrc/nucleus/shadow.c (Revision 2954)<br>+++ xenomai-2.3.x/ksrc/nucleus/shadow.c (Arbeitskopie)<br>@@ -99,6 +99,7 @@ static struct __lostagerq {
<br> #define LO_RENICE_REQ 2<br> #define LO_SIGGRP_REQ 3<br> #define LO_SIGTHR_REQ 4<br>+#define LO_UNMAP_REQ&nbsp;&nbsp;5<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int type;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct task_struct *task;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int arg;<br>@@ -753,6 +754,28 @@ void xnshadow_reset_shield(void)
<br><br> #endif /* CONFIG_XENO_OPT_ISHIELD */<br><br>+static void xnshadow_dereference_skin(unsigned magic)<br>+{<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned muxid;<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (muxid = 0; muxid &lt; XENOMAI_MUX_NR; muxid++) {<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (muxtable[muxid].magic == magic) {
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (xnarch_atomic_dec_and_test(&amp;muxtable[0].refcnt))<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnarch_atomic_dec(&amp;muxtable[0].refcnt);<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (xnarch_atomic_dec_and_test(&amp;muxtable[muxid].refcnt))
<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We were the last thread, decrement the counter,<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;since it was incremented by the xn_sys_bind<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;operation. */
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnarch_atomic_dec(&amp;muxtable[muxid].refcnt);<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (muxtable[muxid].module)<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; module_put(muxtable[muxid].module);<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>+}<br>+<br> static void lostage_handler(void *cookie)<br> {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int cpuid = smp_processor_id(), reqnum, sig;<br>@@ -777,6 +800,12 @@ static void lostage_handler(void *cookie<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto do_wakeup;<br><br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case LO_UNMAP_REQ:<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnshadow_dereference_skin(<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned)rq-&gt;req[reqnum].arg);<br>+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* fall through */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case LO_WAKEUP_REQ:<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* We need to downgrade the root thread<br>@@ -1256,7 +1285,6 @@ int xnshadow_map(xnthread_t *thread, xnc<br> void xnshadow_unmap(xnthread_t *thread)
<br> {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct task_struct *p;<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned muxid, magic;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (XENO_DEBUG(NUCLEUS) &amp;&amp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;!testbits(xnpod_current_sched()-&gt;status, XNKCOUT))<br>@@ -1264,25 +1292,6 @@ void xnshadow_unmap(xnthread_t *thread)
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;p = xnthread_archtcb(thread)-&gt;user_task;<br><br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; magic = xnthread_get_magic(thread);<br>-<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (muxid = 0; muxid &lt; XENOMAI_MUX_NR; muxid++) {<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (muxtable[muxid].magic == magic) {
<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (xnarch_atomic_dec_and_test(&amp;muxtable[0].refcnt))<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnarch_atomic_dec(&amp;muxtable[0].refcnt);<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (xnarch_atomic_dec_and_test(&amp;muxtable[muxid].refcnt))
<br>-<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We were the last thread, decrement the counter,<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;since it was incremented by the xn_sys_bind<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;operation. */
<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnarch_atomic_dec(&amp;muxtable[muxid].refcnt);<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (muxtable[muxid].module)<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; module_put(muxtable[muxid].module);<br>-<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>-<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;xnthread_clear_state(thread, XNMAPPED);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rpi_pop(thread);<br><br>@@ -1298,13 +1307,7 @@ void xnshadow_unmap(xnthread_t *thread)<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;xnshadow_thrptd(p) = NULL;
<br><br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;state != TASK_RUNNING)<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If the shadow is being unmapped in primary mode or blocked<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;in secondary mode, the associated Linux task should also<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;die. In the former case, the zombie Linux side returning to
<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user-space will be trapped and exited inside the pod&#39;s<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rescheduling routines. */<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_linux_call(LO_WAKEUP_REQ, p, 0);<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_linux_call(LO_UNMAP_REQ, p, xnthread_get_magic(thread));
<br> }<br><br> int xnshadow_wait_barrier(struct pt_regs *regs)<br>@@ -2010,6 +2013,7 @@ RTHAL_DECLARE_EVENT(losyscall_event);<br> static inline void do_taskexit_event(struct task_struct *p)<br> {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;xnthread_t *thread = xnshadow_thread(p); /* p == current */
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned magic;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;spl_t s;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (!thread)<br>@@ -2018,6 +2022,8 @@ static inline void do_taskexit_event(str<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (xnpod_shadow_p())<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;xnshadow_relax(0);<br><br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; magic = xnthread_get_magic(thread);
<br>+<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;xnlock_get_irqsave(&amp;nklock, s);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Prevent wakeup call from xnshadow_unmap(). */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;xnshadow_thrptd(p) = NULL;<br>@@ -2028,6 +2034,7 @@ static inline void do_taskexit_event(str<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;xnlock_put_irqrestore(&amp;nklock, s);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;xnpod_schedule();<br><br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnshadow_dereference_skin(magic);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;xnltt_log_event(xeno_ev_shadowexit, thread-&gt;name);<br> }</blockquote><div><br>This&nbsp; patch is working with linux kernel <a href="http://2.6.20.9">
2.6.20.9</a> and ipipe 1.8-08.<br><br>thanks andy<br></div><br></div><br>

------=_Part_1129_29888481.1188394817787--

