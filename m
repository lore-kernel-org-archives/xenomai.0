MIME-Version: 1.0
Message-ID: <trinity-edf656b8-4eef-4967-92eb-85856ad3f8bd-1449246268211@3capp-webde-bs27>
From: JK.Behnke@web.de
Content-Type: text/plain; charset=UTF-8
Date: Fri, 4 Dec 2015 17:24:28 +0100
In-Reply-To: <trinity-8e5e4a49-df3c-4391-b1ce-b1bc4d77ffcc-1449061119000@3capp-webde-bs35>
References: <trinity-3a616500-d86a-4f71-bb11-16fa1d6cf8a2-1448533977790@3capp-webde-bs12>
 <20151128064325.GC10399@hermes.click-hack.org>
 <trinity-4550a539-a311-4cb6-853e-f6f5fb983201-1448975385774@3capp-webde-bap47>,
 <20151201181155.GC30041@hermes.click-hack.org>,
 <trinity-8e5e4a49-df3c-4391-b1ce-b1bc4d77ffcc-1449061119000@3capp-webde-bs35>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] "RT throttling" issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hello Gilles,

sorry for bothering you again=2E

> >
> > Using the I-pipe tracer, you may be able to understand what happens=2E
> Should I patch my Linux kernel so that xntrace_user_freeze is called,
> when Linux scheduler sends "RT throttling activated" message?

I now have been able to capture an I-pipe frozen file, when the
"RT throttling" condition occurs=2E
I have done this by adding the line
=C2=A0 ipipe_trace_freeze(1);
right before
=C2=A0 printk_sched("sched: RT Throttling activated\n");
inside "kernel/sched/rt=2Ec"=2E
I have set back_trace_points to 10000 to get about 1 second of
backtrace history=2E

Here is a fragment of my huge frozen file which contains
the last 1=2E6 seconds before the freeze=2E

//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D frozen file start=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=C2=A0+----- Hard IRQs ('|': locked)
=C2=A0|+-- Xenomai
=C2=A0||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
=C2=A0|||=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 +=
---------- Delay flag ('+': > 1 us, '!': > 10 us)
=C2=A0|||=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 |=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 +- NMI noise ('N')
=C2=A0|||=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 |=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 |
=C2=A0=C2=A0 =C2=A0=C2=A0 Type=C2=A0=C2=A0 =C2=A0=C2=A0 User Val=2E=C2=A0=
=C2=A0 Time=C2=A0=C2=A0=C2=A0 Delay=C2=A0 Function (Parent)
:|=C2=A0 # [ 4936] -<?>-=C2=A0=C2=A0=C2=A0 0 -1613869=C2=A0=C2=A0 =C2=A0=
=C2=A0 0=2E852=C2=A0 xnpod_resume_thread+0x4e (xnthread_timeout_handler+0x1=
e)
:|=C2=A0 # event=C2=A0=C2=A0 tick@-1611814-1613868+=C2=A0=C2=A0 3=2E538=C2=
=A0 xntimer_next_local_shot+0xb4 (xntimer_tick_aperiodic+0x1a0)
:|=C2=A0 # [ 5066] prc6hmi -1 -1613864+=C2=A0=C2=A0 1=2E964=C2=A0 __xnpod_=
schedule+0x77 (xnintr_clock_handler+0x105)
:|=C2=A0 # [ 4936] -<?>-=C2=A0=C2=A0=C2=A0 0 -1613862+=C2=A0=C2=A0 3=2E127=
=C2=A0 __xnpod_schedule+0x45d (xnpod_suspend_thread+0x197)
:|=C2=A0 # [ 4936] -<?>-=C2=A0=C2=A0=C2=A0 0 -1613859+=C2=A0=C2=A0 1=2E192=
=C2=A0 __xnpod_schedule+0x77 (xnpod_suspend_thread+0x171)
:|=C2=A0 # [ 5066] prc6hmi -1 -1613858!=C2=A0 27=2E286=C2=A0 __xnpod_sched=
ule+0x45d (xnintr_clock_handler+0x105)
:|=C2=A0 *+[ 4936] -<?>-=C2=A0=C2=A0=C2=A0 0 -1613831+=C2=A0=C2=A0 1=2E824=
=C2=A0 xnpod_resume_thread+0x4e (gatekeeper_thread+0xf1)
:|=C2=A0 # [=C2=A0 456] gatekee -1 -1613829+=C2=A0=C2=A0 4=2E200=C2=A0 __x=
npod_schedule+0x77 (xnpod_schedule_handler+0x29)
:|=C2=A0 # [ 4936] -<?>-=C2=A0=C2=A0=C2=A0 0 -1613825=C2=A0=C2=A0 =C2=A0=
=C2=A0 0=2E952=C2=A0 __xnpod_schedule+0x77 (xnpod_suspend_thread+0x171)
:|=C2=A0 # [=C2=A0 456] gatekee -1 -1613824!=C2=A0 13=2E001=C2=A0 __xnpod_=
schedule+0x45d (xnpod_schedule_handler+0x29)
:|=C2=A0 *+[ 4936] -<?>-=C2=A0=C2=A0=C2=A0 0 -1613811=C2=A0=C2=A0 =C2=A0=
=C2=A0 0=2E882=C2=A0 xnpod_resume_thread+0x4e (gatekeeper_thread+0xf1)
:|=C2=A0 # [=C2=A0 456] gatekee -1 -1613810+=C2=A0=C2=A0 2=2E506=C2=A0 __x=
npod_schedule+0x77 (xnpod_schedule_handler+0x29)
:|=C2=A0 # [ 4936] -<?>-=C2=A0=C2=A0=C2=A0 0 -1613807=C2=A0=C2=A0 =C2=A0=
=C2=A0 0=2E952=C2=A0 __xnpod_schedule+0x77 (xnpod_suspend_thread+0x171)
:|=C2=A0 # [=C2=A0 456] gatekee -1 -1613806!=C2=A0 11=2E588=C2=A0 __xnpod_=
schedule+0x45d (xnpod_schedule_handler+0x29)
:|=C2=A0 *+[ 4936] -<?>-=C2=A0=C2=A0=C2=A0 0 -1613795=C2=A0=C2=A0 =C2=A0=
=C2=A0 0=2E721=C2=A0 xnpod_resume_thread+0x4e (gatekeeper_thread+0xf1)
:|=C2=A0 # [=C2=A0 456] gatekee -1 -1613794+=C2=A0=C2=A0 6=2E395=C2=A0 __x=
npod_schedule+0x77 (xnpod_schedule_handler+0x29)
:|=C2=A0 # [ 4936] -<?>-=C2=A0=C2=A0=C2=A0 0 -1613788=C2=A0=C2=A0 =C2=A0=
=C2=A0 0=2E922=C2=A0 __xnpod_schedule+0x77 (xnpod_suspend_thread+0x171)
:|=C2=A0 # [=C2=A0 456] gatekee -1 -1613787!=C2=A0 10=2E124=C2=A0 __xnpod_=
schedule+0x45d (xnpod_schedule_handler+0x29)
:|=C2=A0 *+[ 4936] -<?>-=C2=A0=C2=A0=C2=A0 0 -1613777=C2=A0=C2=A0 =C2=A0=
=C2=A0 0=2E711=C2=A0 xnpod_resume_thread+0x4e (gatekeeper_thread+0xf1)
:|=C2=A0 # [=C2=A0 456] gatekee -1 -1613776+=C2=A0=C2=A0 2=2E686=C2=A0 __x=
npod_schedule+0x77 (xnpod_schedule_handler+0x29)
:|=C2=A0 # [ 4936] -<?>-=C2=A0=C2=A0=C2=A0 0 -1613773=C2=A0=C2=A0 =C2=A0=
=C2=A0 0=2E892=C2=A0 __xnpod_schedule+0x77 (xnpod_suspend_thread+0x197)
:|=C2=A0 # [=C2=A0 456] gatekee -1 -1613772! 1977=2E417=C2=A0 __xnpod_sche=
dule+0x45d (xnpod_schedule_handler+0x29)
:|=C2=A0 # [ 4956] -<?>-=C2=A0=C2=A0 50 -1611795+=C2=A0=C2=A0 1=2E794=C2=
=A0 xnpod_resume_thread+0x4e (xnthread_timeout_handler+0x1e)
=2E=2E=2E
=2E=2E=2E
=2E=2E=2E
:|=C2=A0 # event=C2=A0=C2=A0 tick@-5129 -5382+=C2=A0=C2=A0 4=2E771=C2=A0 x=
ntimer_next_local_shot+0xb4 (xntimer_tick_aperiodic+0x1a0)
:|=C2=A0 # [ 4961] -<?>-=C2=A0=C2=A0 -1 -5377+=C2=A0=C2=A0 3=2E448=C2=A0 _=
_xnpod_schedule+0x77 (xnintr_clock_handler+0x105)
:|=C2=A0 # [ 4936] -<?>-=C2=A0=C2=A0=C2=A0 0 -5374+=C2=A0=C2=A0 7=2E027=C2=
=A0 __xnpod_schedule+0x45d (xnpod_suspend_thread+0x197)
:|=C2=A0 # [ 4936] -<?>-=C2=A0=C2=A0=C2=A0 0 -5367+=C2=A0=C2=A0 1=2E172=C2=
=A0 __xnpod_schedule+0x77 (xnpod_suspend_thread+0x171)
:|=C2=A0 # [ 4961] -<?>-=C2=A0=C2=A0 -1 -5366! 253=2E408=C2=A0 __xnpod_sch=
edule+0x45d (xnintr_clock_handler+0x105)
:|=C2=A0 # [ 4957] -<?>-=C2=A0=C2=A0 50 -5112+=C2=A0=C2=A0 1=2E884=C2=A0 x=
npod_resume_thread+0x4e (xnthread_periodic_handler+0x28)
:|=C2=A0 # event=C2=A0=C2=A0 tick@-4525 -5110+=C2=A0=C2=A0 3=2E548=C2=A0 x=
ntimer_next_local_shot+0xb4 (xntimer_tick_aperiodic+0x1a0)
:|=C2=A0 # [ 4961] -<?>-=C2=A0=C2=A0 -1 -5107+=C2=A0=C2=A0 2=2E476=C2=A0 _=
_xnpod_schedule+0x77 (xnintr_clock_handler+0x105)
:|=C2=A0 # [ 4957] -<?>-=C2=A0=C2=A0 50 -5104!=C2=A0 59=2E785=C2=A0 __xnpo=
d_schedule+0x45d (xnpod_suspend_thread+0x197)
:|=C2=A0 # [ 4957] -<?>-=C2=A0=C2=A0 50 -5045+=C2=A0=C2=A0 1=2E794=C2=A0 _=
_xnpod_schedule+0x77 (xnpod_suspend_thread+0x197)
:|=C2=A0 # [ 4961] -<?>-=C2=A0=C2=A0 -1 -5043! 538=2E795=C2=A0 __xnpod_sch=
edule+0x45d (xnintr_clock_handler+0x105)
:|=C2=A0 # [ 5012] -<?>-=C2=A0=C2=A0 99 -4504+=C2=A0=C2=A0 2=2E195=C2=A0 x=
npod_resume_thread+0x4e (xnthread_periodic_handler+0x28)
:|=C2=A0 # event=C2=A0=C2=A0 tick@-129=C2=A0 -4502+=C2=A0=C2=A0 4=2E180=C2=
=A0 xntimer_next_local_shot+0xb4 (xntimer_tick_aperiodic+0x1a0)
:|=C2=A0 # [ 4961] -<?>-=C2=A0=C2=A0 -1 -4498+=C2=A0=C2=A0 2=2E596=C2=A0 _=
_xnpod_schedule+0x77 (xnintr_clock_handler+0x105)
:|=C2=A0 # [ 5012] -<?>-=C2=A0=C2=A0 99 -4495! 677=2E824=C2=A0 __xnpod_sch=
edule+0x45d (xnpod_suspend_thread+0x197)
:|=C2=A0 # [ 5012] -<?>-=C2=A0=C2=A0 99 -3817+=C2=A0=C2=A0 5=2E844=C2=A0 _=
_xnpod_schedule+0x77 (xnpod_suspend_thread+0x197)
:|=C2=A0 # [ 4961] -<?>-=C2=A0=C2=A0 -1 -3811! 3709=2E015=C2=A0 __xnpod_sc=
hedule+0x45d (xnintr_clock_handler+0x105)
:|=C2=A0 # [ 4957] -<?>-=C2=A0=C2=A0 50=C2=A0 -102+=C2=A0=C2=A0 3=2E147=C2=
=A0 xnpod_resume_thread+0x4e (xnthread_periodic_handler+0x28)
:|=C2=A0 # event=C2=A0=C2=A0 tick@474=C2=A0=C2=A0=C2=A0=C2=A0 -99+=C2=A0=
=C2=A0 4=2E210=C2=A0 xntimer_next_local_shot+0xb4 (xntimer_tick_aperiodic+0=
x1a0)
:|=C2=A0 # [ 4961] -<?>-=C2=A0=C2=A0 -1=C2=A0=C2=A0 -95+=C2=A0=C2=A0 3=2E3=
88=C2=A0 __xnpod_schedule+0x77 (xnintr_clock_handler+0x105)
:|=C2=A0 # [ 4957] -<?>-=C2=A0=C2=A0 50=C2=A0=C2=A0 -92!=C2=A0 55=2E645=C2=
=A0 __xnpod_schedule+0x45d (xnpod_suspend_thread+0x197)
:|=C2=A0 # [ 4957] -<?>-=C2=A0=C2=A0 50=C2=A0=C2=A0 -36+=C2=A0=C2=A0 2=2E0=
65=C2=A0 __xnpod_schedule+0x77 (xnpod_suspend_thread+0x197)
:|=C2=A0 # [ 4961] -<?>-=C2=A0=C2=A0 -1=C2=A0=C2=A0 -34!=C2=A0 34=2E474=C2=
=A0 __xnpod_schedule+0x45d (xnintr_clock_handler+0x105)
<=C2=A0=C2=A0=C2=A0 #freeze=C2=A0 0x00000001=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=
=A0=C2=A0 =C2=A0489=2E264=C2=A0 update_curr_rt+0x10f (task_tick_rt+0x15)
=C2=A0|=C2=A0 # [ 5012] -<?>-=C2=A0=C2=A0 99=C2=A0=C2=A0 489=C2=A0=C2=A0 =
=C2=A0=C2=A0 1=2E724=C2=A0 xnpod_resume_thread+0x4e (xnthread_periodic_hand=
ler+0x28)
=C2=A0|=C2=A0 # event=C2=A0=C2=A0 tick@4870=C2=A0=C2=A0=C2=A0 490=C2=A0=C2=
=A0 =C2=A0=C2=A0 3=2E147=C2=A0 xntimer_next_local_shot+0xb4 (xntimer_tick_a=
periodic+0x1a0)
=C2=A0|=C2=A0 # [=C2=A0=C2=A0=C2=A0 0] -<?>-=C2=A0=C2=A0 -1=C2=A0=C2=A0 49=
4=C2=A0=C2=A0 =C2=A0=C2=A0 2=2E866=C2=A0 __xnpod_schedule+0x77 (xnintr_cloc=
k_handler+0x105)
=C2=A0|=C2=A0 # [ 5012] -<?>-=C2=A0=C2=A0 99=C2=A0=C2=A0 497=C2=A0=C2=A0 =
=C2=A0662=2E948=C2=A0 __xnpod_schedule+0x45d (xnpod_suspend_thread+0x197)
=C2=A0|=C2=A0 # [ 5012] -<?>-=C2=A0=C2=A0 99=C2=A0 1159=C2=A0=C2=A0 =C2=A0=
=C2=A0 3=2E608=C2=A0 __xnpod_schedule+0x77 (xnpod_suspend_thread+0x197)
=C2=A0|=C2=A0 # [=C2=A0=C2=A0=C2=A0 0] -<?>-=C2=A0=C2=A0 -1=C2=A0 1163=C2=
=A0=C2=A0 =C2=A03720=2E243=C2=A0 __xnpod_schedule+0x45d (xnintr_clock_handl=
er+0x105)
=C2=A0|=C2=A0 # [ 4957] -<?>-=C2=A0=C2=A0 50=C2=A0 4883=C2=A0=C2=A0 =C2=A0=
=C2=A0 2=2E085=C2=A0 xnpod_resume_thread+0x4e (xnthread_periodic_handler+0x=
28)
=C2=A0|=C2=A0 # event=C2=A0=C2=A0 tick@5474=C2=A0=C2=A0 4885=C2=A0=C2=A0 =
=C2=A0=C2=A0 3=2E368=C2=A0 xntimer_next_local_shot+0xb4 (xntimer_tick_aperi=
odic+0x1a0)
=C2=A0|=C2=A0 # [=C2=A0=C2=A0=C2=A0 0] -<?>-=C2=A0=C2=A0 -1=C2=A0 4889=C2=
=A0=C2=A0 =C2=A0=C2=A0 1=2E233=C2=A0 __xnpod_schedule+0x77 (xnintr_clock_ha=
ndler+0x105)
=C2=A0|=C2=A0 # [ 4957] -<?>-=C2=A0=C2=A0 50=C2=A0 4890=C2=A0=C2=A0 =C2=A0=
=C2=A0 0=2E000=C2=A0 __xnpod_schedule+0x45d (xnpod_suspend_thread+0x197)
//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D frozen file end =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

There is no process utilizing the CPU=C2=A0 for > 950000 us, which
leads me to the conclusion, that the problem is not caused by
an infinite loop=2E
However I observe delay values of up to 3900 us multiple times which
makes me think that there is a high CPU utilization which in the
worst case exceeds the limit of 950000 us per 1 second interval=2E
Probably I would have to sum up all delay values of processes in=20
secondary mode within 1 second time interval and see if it exceeds
950000 us=2E

Now I have the following questions
1=2E What is meant by "domain stalled", "current" and "current+stalled"?
2=2E What is that process having ID "[=C2=A0=C2=A0 0]"
3=2E How can I tell processes running in secondary mode from others?
=C2=A0=C2=A0 (just by looking at the priority value?)

Any hint on interpreting my frozen file is appreciated=2E

Thanks
Jochen

