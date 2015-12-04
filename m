Date: Fri, 4 Dec 2015 17:33:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151204163315.GD29398@hermes.click-hack.org>
References: <trinity-3a616500-d86a-4f71-bb11-16fa1d6cf8a2-1448533977790@3capp-webde-bs12>
 <20151128064325.GC10399@hermes.click-hack.org>
 <trinity-4550a539-a311-4cb6-853e-f6f5fb983201-1448975385774@3capp-webde-bap47>
 <20151201181155.GC30041@hermes.click-hack.org>
 <trinity-8e5e4a49-df3c-4391-b1ce-b1bc4d77ffcc-1449061119000@3capp-webde-bs35>
 <trinity-edf656b8-4eef-4967-92eb-85856ad3f8bd-1449246268211@3capp-webde-bs27>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <trinity-edf656b8-4eef-4967-92eb-85856ad3f8bd-1449246268211@3capp-webde-bs27>
Subject: Re: [Xenomai] "RT throttling" issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: JK.Behnke@web.de
Cc: xenomai@xenomai.org

On Fri, Dec 04, 2015 at 05:24:28PM +0100, JK.Behnke@web.de wrote:
> Hello Gilles,
>=20
> sorry for bothering you again.
>=20
> > >
> > > Using the I-pipe tracer, you may be able to understand what happens.
> > Should I patch my Linux kernel so that xntrace_user_freeze is called,
> > when Linux scheduler sends "RT throttling activated" message?
>=20
> I now have been able to capture an I-pipe frozen file, when the
> "RT throttling" condition occurs.
> I have done this by adding the line
> =A0 ipipe_trace_freeze(1);
> right before
> =A0 printk_sched("sched: RT Throttling activated\n");
> inside "kernel/sched/rt.c".
> I have set back_trace_points to 10000 to get about 1 second of
> backtrace history.
>=20
> Here is a fragment of my huge frozen file which contains
> the last 1.6 seconds before the freeze.
>=20
> //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D frozen file star=
t =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =A0+----- Hard IRQs ('|': locked)
> =A0|+-- Xenomai
> =A0||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
> =A0|||=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0 +---------- Delay flag ('+': > 1 =
us, '!': > 10 us)
> =A0|||=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0 |=A0=A0 =A0=A0=A0 +- NMI noise ('=
N')
> =A0|||=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0 |=A0=A0 =A0=A0=A0 |
> =A0=A0 =A0=A0 Type=A0=A0 =A0=A0 User Val.=A0=A0 Time=A0=A0=A0 Delay=A0 Fu=
nction (Parent)
> :|=A0 # [ 4936] -<?>-=A0=A0=A0 0 -1613869=A0=A0 =A0=A0 0.852=A0 xnpod_res=
ume_thread+0x4e (xnthread_timeout_handler+0x1e)
> :|=A0 # event=A0=A0 tick@-1611814-1613868+=A0=A0 3.538=A0 xntimer_next_lo=
cal_shot+0xb4 (xntimer_tick_aperiodic+0x1a0)
> :|=A0 # [ 5066] prc6hmi -1 -1613864+=A0=A0 1.964=A0 __xnpod_schedule+0x77=
 (xnintr_clock_handler+0x105)
> :|=A0 # [ 4936] -<?>-=A0=A0=A0 0 -1613862+=A0=A0 3.127=A0 __xnpod_schedul=
e+0x45d (xnpod_suspend_thread+0x197)
> :|=A0 # [ 4936] -<?>-=A0=A0=A0 0 -1613859+=A0=A0 1.192=A0 __xnpod_schedul=
e+0x77 (xnpod_suspend_thread+0x171)
> :|=A0 # [ 5066] prc6hmi -1 -1613858!=A0 27.286=A0 __xnpod_schedule+0x45d =
(xnintr_clock_handler+0x105)
> :|=A0 *+[ 4936] -<?>-=A0=A0=A0 0 -1613831+=A0=A0 1.824=A0 xnpod_resume_th=
read+0x4e (gatekeeper_thread+0xf1)
> :|=A0 # [=A0 456] gatekee -1 -1613829+=A0=A0 4.200=A0 __xnpod_schedule+0x=
77 (xnpod_schedule_handler+0x29)
> :|=A0 # [ 4936] -<?>-=A0=A0=A0 0 -1613825=A0=A0 =A0=A0 0.952=A0 __xnpod_s=
chedule+0x77 (xnpod_suspend_thread+0x171)
> :|=A0 # [=A0 456] gatekee -1 -1613824!=A0 13.001=A0 __xnpod_schedule+0x45=
d (xnpod_schedule_handler+0x29)
> :|=A0 *+[ 4936] -<?>-=A0=A0=A0 0 -1613811=A0=A0 =A0=A0 0.882=A0 xnpod_res=
ume_thread+0x4e (gatekeeper_thread+0xf1)
> :|=A0 # [=A0 456] gatekee -1 -1613810+=A0=A0 2.506=A0 __xnpod_schedule+0x=
77 (xnpod_schedule_handler+0x29)
> :|=A0 # [ 4936] -<?>-=A0=A0=A0 0 -1613807=A0=A0 =A0=A0 0.952=A0 __xnpod_s=
chedule+0x77 (xnpod_suspend_thread+0x171)
> :|=A0 # [=A0 456] gatekee -1 -1613806!=A0 11.588=A0 __xnpod_schedule+0x45=
d (xnpod_schedule_handler+0x29)
> :|=A0 *+[ 4936] -<?>-=A0=A0=A0 0 -1613795=A0=A0 =A0=A0 0.721=A0 xnpod_res=
ume_thread+0x4e (gatekeeper_thread+0xf1)
> :|=A0 # [=A0 456] gatekee -1 -1613794+=A0=A0 6.395=A0 __xnpod_schedule+0x=
77 (xnpod_schedule_handler+0x29)
> :|=A0 # [ 4936] -<?>-=A0=A0=A0 0 -1613788=A0=A0 =A0=A0 0.922=A0 __xnpod_s=
chedule+0x77 (xnpod_suspend_thread+0x171)
> :|=A0 # [=A0 456] gatekee -1 -1613787!=A0 10.124=A0 __xnpod_schedule+0x45=
d (xnpod_schedule_handler+0x29)
> :|=A0 *+[ 4936] -<?>-=A0=A0=A0 0 -1613777=A0=A0 =A0=A0 0.711=A0 xnpod_res=
ume_thread+0x4e (gatekeeper_thread+0xf1)
> :|=A0 # [=A0 456] gatekee -1 -1613776+=A0=A0 2.686=A0 __xnpod_schedule+0x=
77 (xnpod_schedule_handler+0x29)
> :|=A0 # [ 4936] -<?>-=A0=A0=A0 0 -1613773=A0=A0 =A0=A0 0.892=A0 __xnpod_s=
chedule+0x77 (xnpod_suspend_thread+0x197)
> :|=A0 # [=A0 456] gatekee -1 -1613772! 1977.417=A0 __xnpod_schedule+0x45d=
 (xnpod_schedule_handler+0x29)
> :|=A0 # [ 4956] -<?>-=A0=A0 50 -1611795+=A0=A0 1.794=A0 xnpod_resume_thre=
ad+0x4e (xnthread_timeout_handler+0x1e)
> ...
> ...
> ...
> :|=A0 # event=A0=A0 tick@-5129 -5382+=A0=A0 4.771=A0 xntimer_next_local_s=
hot+0xb4 (xntimer_tick_aperiodic+0x1a0)
> :|=A0 # [ 4961] -<?>-=A0=A0 -1 -5377+=A0=A0 3.448=A0 __xnpod_schedule+0x7=
7 (xnintr_clock_handler+0x105)
> :|=A0 # [ 4936] -<?>-=A0=A0=A0 0 -5374+=A0=A0 7.027=A0 __xnpod_schedule+0=
x45d (xnpod_suspend_thread+0x197)
> :|=A0 # [ 4936] -<?>-=A0=A0=A0 0 -5367+=A0=A0 1.172=A0 __xnpod_schedule+0=
x77 (xnpod_suspend_thread+0x171)
> :|=A0 # [ 4961] -<?>-=A0=A0 -1 -5366! 253.408=A0 __xnpod_schedule+0x45d (=
xnintr_clock_handler+0x105)
> :|=A0 # [ 4957] -<?>-=A0=A0 50 -5112+=A0=A0 1.884=A0 xnpod_resume_thread+=
0x4e (xnthread_periodic_handler+0x28)
> :|=A0 # event=A0=A0 tick@-4525 -5110+=A0=A0 3.548=A0 xntimer_next_local_s=
hot+0xb4 (xntimer_tick_aperiodic+0x1a0)
> :|=A0 # [ 4961] -<?>-=A0=A0 -1 -5107+=A0=A0 2.476=A0 __xnpod_schedule+0x7=
7 (xnintr_clock_handler+0x105)
> :|=A0 # [ 4957] -<?>-=A0=A0 50 -5104!=A0 59.785=A0 __xnpod_schedule+0x45d=
 (xnpod_suspend_thread+0x197)
> :|=A0 # [ 4957] -<?>-=A0=A0 50 -5045+=A0=A0 1.794=A0 __xnpod_schedule+0x7=
7 (xnpod_suspend_thread+0x197)
> :|=A0 # [ 4961] -<?>-=A0=A0 -1 -5043! 538.795=A0 __xnpod_schedule+0x45d (=
xnintr_clock_handler+0x105)
> :|=A0 # [ 5012] -<?>-=A0=A0 99 -4504+=A0=A0 2.195=A0 xnpod_resume_thread+=
0x4e (xnthread_periodic_handler+0x28)
> :|=A0 # event=A0=A0 tick@-129=A0 -4502+=A0=A0 4.180=A0 xntimer_next_local=
_shot+0xb4 (xntimer_tick_aperiodic+0x1a0)
> :|=A0 # [ 4961] -<?>-=A0=A0 -1 -4498+=A0=A0 2.596=A0 __xnpod_schedule+0x7=
7 (xnintr_clock_handler+0x105)
> :|=A0 # [ 5012] -<?>-=A0=A0 99 -4495! 677.824=A0 __xnpod_schedule+0x45d (=
xnpod_suspend_thread+0x197)
> :|=A0 # [ 5012] -<?>-=A0=A0 99 -3817+=A0=A0 5.844=A0 __xnpod_schedule+0x7=
7 (xnpod_suspend_thread+0x197)
> :|=A0 # [ 4961] -<?>-=A0=A0 -1 -3811! 3709.015=A0 __xnpod_schedule+0x45d =
(xnintr_clock_handler+0x105)
> :|=A0 # [ 4957] -<?>-=A0=A0 50=A0 -102+=A0=A0 3.147=A0 xnpod_resume_threa=
d+0x4e (xnthread_periodic_handler+0x28)
> :|=A0 # event=A0=A0 tick@474=A0=A0=A0=A0 -99+=A0=A0 4.210=A0 xntimer_next=
_local_shot+0xb4 (xntimer_tick_aperiodic+0x1a0)
> :|=A0 # [ 4961] -<?>-=A0=A0 -1=A0=A0 -95+=A0=A0 3.388=A0 __xnpod_schedule=
+0x77 (xnintr_clock_handler+0x105)
> :|=A0 # [ 4957] -<?>-=A0=A0 50=A0=A0 -92!=A0 55.645=A0 __xnpod_schedule+0=
x45d (xnpod_suspend_thread+0x197)
> :|=A0 # [ 4957] -<?>-=A0=A0 50=A0=A0 -36+=A0=A0 2.065=A0 __xnpod_schedule=
+0x77 (xnpod_suspend_thread+0x197)
> :|=A0 # [ 4961] -<?>-=A0=A0 -1=A0=A0 -34!=A0 34.474=A0 __xnpod_schedule+0=
x45d (xnintr_clock_handler+0x105)
> <=A0=A0=A0 #freeze=A0 0x00000001=A0=A0=A0=A0 0=A0=A0 =A0489.264=A0 update=
_curr_rt+0x10f (task_tick_rt+0x15)
> =A0|=A0 # [ 5012] -<?>-=A0=A0 99=A0=A0 489=A0=A0 =A0=A0 1.724=A0 xnpod_re=
sume_thread+0x4e (xnthread_periodic_handler+0x28)
> =A0|=A0 # event=A0=A0 tick@4870=A0=A0=A0 490=A0=A0 =A0=A0 3.147=A0 xntime=
r_next_local_shot+0xb4 (xntimer_tick_aperiodic+0x1a0)
> =A0|=A0 # [=A0=A0=A0 0] -<?>-=A0=A0 -1=A0=A0 494=A0=A0 =A0=A0 2.866=A0 __=
xnpod_schedule+0x77 (xnintr_clock_handler+0x105)
> =A0|=A0 # [ 5012] -<?>-=A0=A0 99=A0=A0 497=A0=A0 =A0662.948=A0 __xnpod_sc=
hedule+0x45d (xnpod_suspend_thread+0x197)
> =A0|=A0 # [ 5012] -<?>-=A0=A0 99=A0 1159=A0=A0 =A0=A0 3.608=A0 __xnpod_sc=
hedule+0x77 (xnpod_suspend_thread+0x197)
> =A0|=A0 # [=A0=A0=A0 0] -<?>-=A0=A0 -1=A0 1163=A0=A0 =A03720.243=A0 __xnp=
od_schedule+0x45d (xnintr_clock_handler+0x105)
> =A0|=A0 # [ 4957] -<?>-=A0=A0 50=A0 4883=A0=A0 =A0=A0 2.085=A0 xnpod_resu=
me_thread+0x4e (xnthread_periodic_handler+0x28)
> =A0|=A0 # event=A0=A0 tick@5474=A0=A0 4885=A0=A0 =A0=A0 3.368=A0 xntimer_=
next_local_shot+0xb4 (xntimer_tick_aperiodic+0x1a0)
> =A0|=A0 # [=A0=A0=A0 0] -<?>-=A0=A0 -1=A0 4889=A0=A0 =A0=A0 1.233=A0 __xn=
pod_schedule+0x77 (xnintr_clock_handler+0x105)
> =A0|=A0 # [ 4957] -<?>-=A0=A0 50=A0 4890=A0=A0 =A0=A0 0.000=A0 __xnpod_sc=
hedule+0x45d (xnpod_suspend_thread+0x197)
> //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D frozen file end =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> There is no process utilizing the CPU=A0 for > 950000 us, which
> leads me to the conclusion, that the problem is not caused by
> an infinite loop.

The problem is caused by processes scheduled by the Linux scheduler
utilizing the CPU without never releasing it. These may be different
processes you are right.

> However I observe delay values of up to 3900 us multiple times which
> makes me think that there is a high CPU utilization which in the
> worst case exceeds the limit of 950000 us per 1 second interval.
> Probably I would have to sum up all delay values of processes in=20
> secondary mode within 1 second time interval and see if it exceeds
> 950000 us.
>=20
> Now I have the following questions
> 1. What is meant by "domain stalled", "current" and "current+stalled"?
> 2. What is that process having ID "[=A0=A0 0]"
> 3. How can I tell processes running in secondary mode from others?
> =A0=A0 (just by looking at the priority value?)
>=20
> Any hint on interpreting my frozen file is appreciated.

This trace is worthless. To have a meaningful trace, enable tracing
on functions entry (the default when you enable the I-pipe tracer).

--=20
					    Gilles.
https://click-hack.org

