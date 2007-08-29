Message-ID: <3535aae80708290723g1f94976ajf3c762da6ab0a0c4@domain.hid>
Date: Wed, 29 Aug 2007 16:23:37 +0200
From: "andy motten" <andy.motten@domain.hid>
In-Reply-To: <46D57EC8.3090504@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1262_307128.1188397417619"
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>
	<18112.1512.506911.608273@domain.hid>
	<3535aae80708130810s603edb7fo9f7be56342ddf921@domain.hid>
	<46C08E61.9060204@domain.hid>
	<3535aae80708140826o107e0fa3wee8db991ec1e14bd@domain.hid>
	<3535aae80708270627l4064dd1fif3e6aa10314d38f@domain.hid>
	<46D301EE.5020805@domain.hid> <46D50DFC.5080304@domain.hid>
	<3535aae80708290640x37ea29f1y17dc34a2823fed11@domain.hid>
	<46D57EC8.3090504@domain.hid>
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

------=_Part_1262_307128.1188397417619
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/8/29, Jan Kiszka <jan.kiszka@domain.hid>:
>
> andy motten wrote:
> >> Jan Kiszka wrote:
> >> Index: xenomai-2.3.x/ChangeLog
> >> ===================================================================
> >> --- xenomai-2.3.x/ChangeLog     (Revision 2954)
> >> +++ xenomai-2.3.x/ChangeLog     (Arbeitskopie)
> >> @@ -1,3 +1,8 @@
> >> +2007-08-29  Jan Kiszka  <jan.kiszka@domain.hid>
> >> +
> >> +       * ksrc/nucleus/shadow.c: Postpone module_put() to the lo-stage
> >> +       APC handler (back-ported from 2.4).
> >> +
> >> 2007-08-24  Wolfgang Grandegger  <wg@domain.hid>
> >>
> >>         * ksrc/drivers/can/rtcan_socket.c: protect the list of RTCAN
> >> Index: xenomai-2.3.x/ksrc/nucleus/shadow.c
> >> ===================================================================
> >> --- xenomai-2.3.x/ksrc/nucleus/shadow.c (Revision 2954)
> >> +++ xenomai-2.3.x/ksrc/nucleus/shadow.c (Arbeitskopie)
> >> @@ -99,6 +99,7 @@ static struct __lostagerq {
> >> #define LO_RENICE_REQ 2
> >> #define LO_SIGGRP_REQ 3
> >> #define LO_SIGTHR_REQ 4
> >> +#define LO_UNMAP_REQ  5
> >>                 int type;
> >>                 struct task_struct *task;
> >>                 int arg;
> >> @@ -753,6 +754,28 @@ void xnshadow_reset_shield(void)
> >>
> >> #endif /* CONFIG_XENO_OPT_ISHIELD */
> >>
> >> +static void xnshadow_dereference_skin(unsigned magic)
> >> +{
> >> +       unsigned muxid;
> >> +
> >> +       for (muxid = 0; muxid < XENOMAI_MUX_NR; muxid++) {
> >> +               if (muxtable[muxid].magic == magic) {
> >> +                       if
> >> (xnarch_atomic_dec_and_test(&muxtable[0].refcnt))
> >> +                               xnarch_atomic_dec(&muxtable[0].refcnt);
> >> +                       if
> >> (xnarch_atomic_dec_and_test(&muxtable[muxid].refcnt))
> >> +
> >> +                               /* We were the last thread, decrement
> the
> >> counter,
> >> +                                  since it was incremented by the
> >> xn_sys_bind
> >> +                                  operation. */
> >> +
> >> xnarch_atomic_dec(&muxtable[muxid].refcnt);
> >> +                       if (muxtable[muxid].module)
> >> +                               module_put(muxtable[muxid].module);
> >> +
> >> +                       break;
> >> +               }
> >> +       }
> >> +}
> >> +
> >> static void lostage_handler(void *cookie)
> >> {
> >>         int cpuid = smp_processor_id(), reqnum, sig;
> >> @@ -777,6 +800,12 @@ static void lostage_handler(void *cookie
> >>
> >>                         goto do_wakeup;
> >>
> >> +               case LO_UNMAP_REQ:
> >> +
> >> +                       xnshadow_dereference_skin(
> >> +                               (unsigned)rq->req[reqnum].arg);
> >> +
> >> +               /* fall through */
> >>                 case LO_WAKEUP_REQ:
> >>
> >>                         /* We need to downgrade the root thread
> >> @@ -1256,7 +1285,6 @@ int xnshadow_map(xnthread_t *thread, xnc
> >> void xnshadow_unmap(xnthread_t *thread)
> >> {
> >>         struct task_struct *p;
> >> -       unsigned muxid, magic;
> >>
> >>         if (XENO_DEBUG(NUCLEUS) &&
> >>             !testbits(xnpod_current_sched()->status, XNKCOUT))
> >> @@ -1264,25 +1292,6 @@ void xnshadow_unmap(xnthread_t *thread)
> >>
> >>         p = xnthread_archtcb(thread)->user_task;
> >>
> >> -       magic = xnthread_get_magic(thread);
> >> -
> >> -       for (muxid = 0; muxid < XENOMAI_MUX_NR; muxid++) {
> >> -               if (muxtable[muxid].magic == magic) {
> >> -                       if
> >> (xnarch_atomic_dec_and_test(&muxtable[0].refcnt))
> >> -                               xnarch_atomic_dec(&muxtable[0].refcnt);
> >> -                       if
> >> (xnarch_atomic_dec_and_test(&muxtable[muxid].refcnt))
> >> -
> >> -                               /* We were the last thread, decrement
> the
> >> counter,
> >> -                                  since it was incremented by the
> >> xn_sys_bind
> >> -                                  operation. */
> >> -
> >> xnarch_atomic_dec(&muxtable[muxid].refcnt);
> >> -                       if (muxtable[muxid].module)
> >> -                               module_put(muxtable[muxid].module);
> >> -
> >> -                       break;
> >> -               }
> >> -       }
> >> -
> >>         xnthread_clear_state(thread, XNMAPPED);
> >>         rpi_pop(thread);
> >>
> >> @@ -1298,13 +1307,7 @@ void xnshadow_unmap(xnthread_t *thread)
> >>
> >>         xnshadow_thrptd(p) = NULL;
> >>
> >> -       if (p->state != TASK_RUNNING)
> >> -               /* If the shadow is being unmapped in primary mode or
> >> blocked
> >> -                  in secondary mode, the associated Linux task should
> >> also
> >> -                  die. In the former case, the zombie Linux side
> >> returning to
> >> -                  user-space will be trapped and exited inside the
> pod's
> >> -                  rescheduling routines. */
> >> -               schedule_linux_call(LO_WAKEUP_REQ, p, 0);
> >> +       schedule_linux_call(LO_UNMAP_REQ, p,
> xnthread_get_magic(thread));
> >> }
> >>
> >> int xnshadow_wait_barrier(struct pt_regs *regs)
> >> @@ -2010,6 +2013,7 @@ RTHAL_DECLARE_EVENT(losyscall_event);
> >> static inline void do_taskexit_event(struct task_struct *p)
> >> {
> >>         xnthread_t *thread = xnshadow_thread(p); /* p == current */
> >> +       unsigned magic;
> >>         spl_t s;
> >>
> >>         if (!thread)
> >> @@ -2018,6 +2022,8 @@ static inline void do_taskexit_event(str
> >>         if (xnpod_shadow_p())
> >>                 xnshadow_relax(0);
> >>
> >> +       magic = xnthread_get_magic(thread);
> >> +
> >>         xnlock_get_irqsave(&nklock, s);
> >>         /* Prevent wakeup call from xnshadow_unmap(). */
> >>         xnshadow_thrptd(p) = NULL;
> >> @@ -2028,6 +2034,7 @@ static inline void do_taskexit_event(str
> >>         xnlock_put_irqrestore(&nklock, s);
> >>         xnpod_schedule();
> >>
> >> +       xnshadow_dereference_skin(magic);
> >>         xnltt_log_event(xeno_ev_shadowexit, thread->name);
> >> }
> >
> >
> > This  patch is working with linux kernel 2.6.20.9 and ipipe 1.8-08.
>
> Means the OROCOS test now runs fine against Xenomai 2.3.x at least?


no, sorry for the confusion. I only meant that we don't get the I-pipe
message anymore (see listing below). The OROCOS tests are still NOT running
correctly.

I-pipe: Detected illicit call from domain 'Xenomai'
        into a service reserved for domain 'Linux' and below.
       f635be74 00000000 00000000 52544149 f635be98 c0104789 c02cfa4f
c02f5b80
       f6c4e2f0 f635beb0 c0137d69 c02c256c c02c1186 c02c01b8 f8c0b280
f635bebc
       c0132981 f60a1730 f635bed8 f8bd8570 c010ef8c 00000000 f60a0120
f8beefe0
Call Trace:
 [<c0103ffb>] show_trace_log_lvl+0x1f/0x35
 [<c01040bb>] show_stack_log_lvl+0xaa/0xcf
 [<c0104789>] show_stack+0x2f/0x36
 [<c0137d69>] ipipe_check_context+0x7a/0x81
 [<c0132981>] module_put+0x19/0x7d
 [<f8bd8570>] xnshadow_unmap+0xbc/0xff [xeno_nucleus]
 [<f8bfdc75>] __shadow_delete_hook+0x25/0x27 [xeno_native]
 [<f8bd1454>] xnpod_delete_thread+0x1b9/0x2aa [xeno_nucleus]
 [<f8bfc36b>] rt_task_delete+0x140/0x145 [xeno_native]
 [<f8bfe02a>] __rt_task_delete+0x58/0x69 [xeno_native]
 [<f8bd8165>] hisyscall_event+0x185/0x291 [xeno_nucleus]
 [<c0138940>] __ipipe_dispatch_event+0xc0/0x1da
 [<c010ed6b>] __ipipe_syscall_root+0x43/0x10a
 [<c0102e79>] system_call+0x29/0x41
 =======================

------=_Part_1262_307128.1188397417619
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">2007/8/29, Jan Kiszka &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
andy motten wrote:<br>&gt;&gt; Jan Kiszka wrote:<br>&gt;&gt; Index: xenomai-2.3.x/ChangeLog<br>&gt;&gt; ===================================================================<br>&gt;&gt; --- xenomai-2.3.x/ChangeLog&nbsp;&nbsp;&nbsp;&nbsp; (Revision 2954)
<br>&gt;&gt; +++ xenomai-2.3.x/ChangeLog&nbsp;&nbsp;&nbsp;&nbsp; (Arbeitskopie)<br>&gt;&gt; @@ -1,3 +1,8 @@<br>&gt;&gt; +2007-08-29&nbsp;&nbsp;Jan Kiszka&nbsp;&nbsp;&lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;<br>&gt;&gt; +<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * ksrc/nucleus/shadow.c: Postpone module_put() to the lo-stage
<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; APC handler (back-ported from 2.4).<br>&gt;&gt; +<br>&gt;&gt; 2007-08-24&nbsp;&nbsp;Wolfgang Grandegger&nbsp;&nbsp;&lt;<a href="mailto:wg@domain.hid">wg@domain.hid</a>&gt;<br>&gt;&gt;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * ksrc/drivers/can/rtcan_socket.c: protect the list of RTCAN
<br>&gt;&gt; Index: xenomai-2.3.x/ksrc/nucleus/shadow.c<br>&gt;&gt; ===================================================================<br>&gt;&gt; --- xenomai-2.3.x/ksrc/nucleus/shadow.c (Revision 2954)<br>&gt;&gt; +++ xenomai-2.3.x
/ksrc/nucleus/shadow.c (Arbeitskopie)<br>&gt;&gt; @@ -99,6 +99,7 @@ static struct __lostagerq {<br>&gt;&gt; #define LO_RENICE_REQ 2<br>&gt;&gt; #define LO_SIGGRP_REQ 3<br>&gt;&gt; #define LO_SIGTHR_REQ 4<br>&gt;&gt; +#define LO_UNMAP_REQ&nbsp;&nbsp;5
<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int type;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct task_struct *task;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int arg;<br>&gt;&gt; @@ -753,6 +754,28 @@ void xnshadow_reset_shield(void)<br>&gt;&gt;<br>&gt;&gt; #endif /* CONFIG_XENO_OPT_ISHIELD */
<br>&gt;&gt;<br>&gt;&gt; +static void xnshadow_dereference_skin(unsigned magic)<br>&gt;&gt; +{<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned muxid;<br>&gt;&gt; +<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (muxid = 0; muxid &lt; XENOMAI_MUX_NR; muxid++) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (muxtable[muxid].magic == magic) {<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if<br>&gt;&gt; (xnarch_atomic_dec_and_test(&amp;muxtable[0].refcnt))<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnarch_atomic_dec(&amp;muxtable[0].refcnt);
<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if<br>&gt;&gt; (xnarch_atomic_dec_and_test(&amp;muxtable[muxid].refcnt))<br>&gt;&gt; +<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We were the last thread, decrement the<br>&gt;&gt; counter,
<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;since it was incremented by the<br>&gt;&gt; xn_sys_bind<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;operation. */<br>&gt;&gt; +<br>&gt;&gt; xnarch_atomic_dec(&amp;muxtable[muxid].refcnt);
<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (muxtable[muxid].module)<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; module_put(muxtable[muxid].module);<br>&gt;&gt; +<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;&gt; +}<br>&gt;&gt; +<br>&gt;&gt; static void lostage_handler(void *cookie)<br>&gt;&gt; {<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int cpuid = smp_processor_id(), reqnum, sig;<br>&gt;&gt; @@ -777,6 +800,12 @@ static void lostage_handler(void *cookie
<br>&gt;&gt;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto do_wakeup;<br>&gt;&gt;<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case LO_UNMAP_REQ:<br>&gt;&gt; +<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnshadow_dereference_skin(<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned)rq-&gt;req[reqnum].arg);
<br>&gt;&gt; +<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* fall through */<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case LO_WAKEUP_REQ:<br>&gt;&gt;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We need to downgrade the root thread<br>&gt;&gt; @@ -1256,7 +1285,6 @@ int xnshadow_map(xnthread_t *thread, xnc
<br>&gt;&gt; void xnshadow_unmap(xnthread_t *thread)<br>&gt;&gt; {<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct task_struct *p;<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned muxid, magic;<br>&gt;&gt;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (XENO_DEBUG(NUCLEUS) &amp;&amp;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !testbits(xnpod_current_sched()-&gt;status, XNKCOUT))<br>&gt;&gt; @@ -1264,25 +1292,6 @@ void xnshadow_unmap(xnthread_t *thread)<br>&gt;&gt;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p = xnthread_archtcb(thread)-&gt;user_task;
<br>&gt;&gt;<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; magic = xnthread_get_magic(thread);<br>&gt;&gt; -<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (muxid = 0; muxid &lt; XENOMAI_MUX_NR; muxid++) {<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (muxtable[muxid].magic == magic) {
<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if<br>&gt;&gt; (xnarch_atomic_dec_and_test(&amp;muxtable[0].refcnt))<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnarch_atomic_dec(&amp;muxtable[0].refcnt);<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
<br>&gt;&gt; (xnarch_atomic_dec_and_test(&amp;muxtable[muxid].refcnt))<br>&gt;&gt; -<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We were the last thread, decrement the<br>&gt;&gt; counter,<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;since it was incremented by the
<br>&gt;&gt; xn_sys_bind<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;operation. */<br>&gt;&gt; -<br>&gt;&gt; xnarch_atomic_dec(&amp;muxtable[muxid].refcnt);<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (muxtable[muxid].module)
<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; module_put(muxtable[muxid].module);<br>&gt;&gt; -<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;&gt; -<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnthread_clear_state(thread, XNMAPPED);
<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rpi_pop(thread);<br>&gt;&gt;<br>&gt;&gt; @@ -1298,13 +1307,7 @@ void xnshadow_unmap(xnthread_t *thread)<br>&gt;&gt;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnshadow_thrptd(p) = NULL;<br>&gt;&gt;<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;state != TASK_RUNNING)
<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If the shadow is being unmapped in primary mode or<br>&gt;&gt; blocked<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;in secondary mode, the associated Linux task should<br>&gt;&gt; also<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;die. In the former case, the zombie Linux side
<br>&gt;&gt; returning to<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user-space will be trapped and exited inside the pod&#39;s<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rescheduling routines. */<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_linux_call(LO_WAKEUP_REQ, p, 0);
<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_linux_call(LO_UNMAP_REQ, p, xnthread_get_magic(thread));<br>&gt;&gt; }<br>&gt;&gt;<br>&gt;&gt; int xnshadow_wait_barrier(struct pt_regs *regs)<br>&gt;&gt; @@ -2010,6 +2013,7 @@ RTHAL_DECLARE_EVENT(losyscall_event);
<br>&gt;&gt; static inline void do_taskexit_event(struct task_struct *p)<br>&gt;&gt; {<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnthread_t *thread = xnshadow_thread(p); /* p == current */<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned magic;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spl_t s;
<br>&gt;&gt;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!thread)<br>&gt;&gt; @@ -2018,6 +2022,8 @@ static inline void do_taskexit_event(str<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (xnpod_shadow_p())<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnshadow_relax(0);<br>&gt;&gt;
<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; magic = xnthread_get_magic(thread);<br>&gt;&gt; +<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnlock_get_irqsave(&amp;nklock, s);<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Prevent wakeup call from xnshadow_unmap(). */<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnshadow_thrptd(p) = NULL;
<br>&gt;&gt; @@ -2028,6 +2034,7 @@ static inline void do_taskexit_event(str<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnlock_put_irqrestore(&amp;nklock, s);<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnpod_schedule();<br>&gt;&gt;<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnshadow_dereference_skin(magic);
<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnltt_log_event(xeno_ev_shadowexit, thread-&gt;name);<br>&gt;&gt; }<br>&gt;<br>&gt;<br>&gt; This&nbsp;&nbsp;patch is working with linux kernel <a href="http://2.6.20.9">2.6.20.9</a> and ipipe 1.8-08.<br><br>Means the OROCOS test now runs fine against Xenomai 
2.3.x at least?</blockquote><div><br>no, sorry for the confusion. I only meant that  we don&#39;t get the I-pipe message anymore (see listing below). The OROCOS tests are still NOT running correctly.<br><br>I-pipe: Detected illicit call from domain &#39;Xenomai&#39;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; into a service reserved for domain &#39;Linux&#39; and below.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f635be74 00000000 00000000 52544149 f635be98 c0104789 c02cfa4f<br>c02f5b80<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f6c4e2f0 f635beb0 c0137d69 c02c256c c02c1186 c02c01b8 f8c0b280
<br>f635bebc<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c0132981 f60a1730 f635bed8 f8bd8570 c010ef8c 00000000 f60a0120<br>f8beefe0<br>Call Trace:<br>&nbsp;[&lt;c0103ffb&gt;] show_trace_log_lvl+0x1f/0x35<br>&nbsp;[&lt;c01040bb&gt;] show_stack_log_lvl+0xaa/0xcf<br>&nbsp;[&lt;c0104789&gt;] show_stack+0x2f/0x36
<br>&nbsp;[&lt;c0137d69&gt;] ipipe_check_context+0x7a/0x81<br>&nbsp;[&lt;c0132981&gt;] module_put+0x19/0x7d<br>&nbsp;[&lt;f8bd8570&gt;] xnshadow_unmap+0xbc/0xff [xeno_nucleus]<br>&nbsp;[&lt;f8bfdc75&gt;] __shadow_delete_hook+0x25/0x27 [xeno_native]
<br>&nbsp;[&lt;f8bd1454&gt;] xnpod_delete_thread+0x1b9/0x2aa [xeno_nucleus]<br>&nbsp;[&lt;f8bfc36b&gt;] rt_task_delete+0x140/0x145 [xeno_native]<br>&nbsp;[&lt;f8bfe02a&gt;] __rt_task_delete+0x58/0x69 [xeno_native]<br>&nbsp;[&lt;f8bd8165&gt;] hisyscall_event+0x185/0x291 [xeno_nucleus]
<br>&nbsp;[&lt;c0138940&gt;] __ipipe_dispatch_event+0xc0/0x1da<br>&nbsp;[&lt;c010ed6b&gt;] __ipipe_syscall_root+0x43/0x10a<br>&nbsp;[&lt;c0102e79&gt;] system_call+0x29/0x41<br>&nbsp;=======================<br><br><br></div><br></div>

------=_Part_1262_307128.1188397417619--

