From: Julien Heyman <bidsonux@domain.hid>
Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
Date: Fri, 28 Jul 2006 23:17:34 +0200
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>
	<200607221152.34298.bidsonux@domain.hid> <44C25DB0.50601@domain.hid>
In-Reply-To: <44C25DB0.50601@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_u7nyE5Ra/BOQheB"
Message-Id: <200607282317.34990.bidsonux@domain.hid>
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
Cc: xenomai@xenomai.org

--Boundary-00=_u7nyE5Ra/BOQheB
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

here's a quick follow-up on my issue, thanks for your time !

Julien Heyman


On Saturday 22 July 2006 19:17, Jan Kiszka wrote:
> Julien Heyman wrote:
> > Hi,
> >
> > On Thursday 20 July 2006 23:58, Jan Kiszka wrote:
> >> Julien Heyman wrote:
> >>> Hi,
> >>>
> >>> I am currently trying to evaluate Xenomai, and my current setup is :
> >>> VIA C3 533Mhz processor, Kubuntu 6.06 Linux distribution.
> >>> I am using Xenomai-2.1.0 over a 2.6.17.4 kernel.
> >>
> >> General advice: especially when starting new, try to pick the latest
> >> version, at least the latest from the preferred series (here 2.1.2). B=
ut
> >> 2.2 is even better. :)
> >
> > OK. Actually started with Xenomai-2.1.0 then switched to 2.1.1 to fix a
> > kernel build error. But anyway, I will start with a fresh install of 2.2
> > as soon as I have figured out the other points :)
> >
> >>> When I run the latency part of the testsuite (in a console under KDE),
> >>> I get
> >>> results that I cannot understand, so I probably did something wrong
> >>> (execution trace included below).
> >>> I get reasonable values during the first seconds, then all of a sudden
> >>> latencies begin to rise, continuously, to very large values.
> >>> - I did check that DMA transfer is activated on my HD.
> >>> - I did select "Enable SMI workaround" + "Globally disable SMI" in the
> >>> Xenomai
> >>> options while configuring the kernel.
> >>> - I have disabled power management at BIOS level and disabled ACPI
> >>> support and
> >>> CPU frequency scaling during kernel configuration.
> >>> - I checked that I don't have anything called "legacy USB" in my BIOS.
> >>> I do have an "OnChip USB" option enable in the BIOS though.
> >>>
> >>> Any advice would be appreciated !
> >>
> >> Maybe it's related to some other weird on-chip hardware. At work we run
> >> Xenomai only on a head-less VIA C3 box, i.e. without X. No problems so
> >> far. I would suggest to try stopping X and run the test from the text
> >> mode.
> >
> > This is interesting : indeed when I switch to console mode (Ctrl+Atl+F1)
> > and run the test, the latency values stay right on track.
> > If I let the test run, switch to X, and switch back to the original
> > console, the values have gone wild in the meantime.
> > So there seems to be a strong link with X.
> > What does that say about potential causes of my issue ?
>
> Don't know. Might be a weird hardware design (wrt bus latencies) - or do
> you=20
> use any binary-only driver for X?=20


I did not install any specific driver, I probably use the standard Trident=
=20
driver that came with the Kubuntu distribution.


>
> >> A further tool to analyse such effects in details is the I-pipe tracer.
> >> It's an additional patch you have to apply to your kernel (see
> >> http://download.gna.org/adeos/patches/v2.6/i386/tracer). Enable this
> >> I-pipe option, rebuild your kernel, and start the latency test with -f.
> >> The test will then capture on every new worst-case delay a backtrace to
> >> /proc/ipipe/trace/frozen. You may want to play with the number of
> >> back-trace points or the verbose mode (see /proc/ipipe/trace/*) even
> >> after the capturing.
> >
> > I had already used an adeos patch during my initial kernel-patching
> > (adeos-ipipe-2.6.17-i386-1.3-07.patch)
>
> The tracer is an additional patch on top of I-pipe, see link above.
>
> > I tried running the latency test using /usr/xenomai/bin/xeno-load laten=
cy
> > -f but I get this error :
> >
> > =3D=3D Sampling period: 100 us
> > =3D=3D Test mode: periodic user-mode task
> > =3D=3D All results in microseconds
> > latency: failed to open benchmark device, code -19
> > (modprobe xeno_timerbench?)
> >
> > What am I doing wrong ?
>
> For < 2.2: check if CONFIG_XENO_DRIVERS_TIMERBENCH is y or m. If it's a
> module, follow the suggestion latency printed.
>
> In 2.2 the required tracing interface was moved to the nucleus, no need
> for these steps then.


Ok, I installed Xenomai 2.2 from scratch over a freshly extracted kernel=20
source tree, used the tracer patch ipipe-tracer-2.6.17-i386-1.3-08.patch,=20
rebuilt the kernel and relaunch the test : I still get increasing latencies.

I attach a copy of the latency test run, and the associated traces in=20
files "max" and "frozen" from /proc/ipipe/trace

I have no clue how to interpret theses traces, is there a documentation/use=
r's=20
guide available for the ipipe tracer ?

Regarding Gilles' comments on this topic :=20

> Losing too many ticks!
> TSC cannot be used as a timesource. =C2=A0
> Possible reasons for this are:
> =C2=A0 You're running with Speedstep,
> =C2=A0 You don't have DMA enabled for your hard disk (see hdparm),
> =C2=A0 Incorrect TSC synchronization on an SMP system (see dmesg).
> Falling back to a sane timesource now.

> Do you see such message in kernel logs ?

No, I don't get any of these.

> If this is the issue you are having, then you may try passing idle=3Dpoll
> on kernel boot line. Or recompile the kernel selecting a processor that
> has no tsc (for example 486), xenomai will then use the 8254 counter to
> emulate the tsc.

I tried to rebuild with CPU=3D486, but it gives the same result.

>
> Jan

--Boundary-00=_u7nyE5Ra/BOQheB
Content-Type: text/plain;
  charset="utf-8";
  name="ipipe_trace_xen2.2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ipipe_trace_xen2.2.txt"

bids@domain.hid$ sudo /usr/xenomai/bin/xeno-load latency -f
Password:
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      21.428|      23.956|      38.249|       0|      21.428|      38.249
RTD|      22.419|      24.491|      31.760|       0|      21.428|      38.249
RTD|      21.833|      23.731|      52.247|       0|      21.428|      52.247
RTD|      21.776|      23.733|      45.060|       0|      21.428|      52.247
RTD|      21.467|      24.434|      40.813|       0|      21.428|      52.247
RTD|      21.613|      24.684|      40.517|       0|      21.428|      52.247
RTD|      21.585|      25.503|      51.990|       0|      21.428|      52.247
RTD|      21.212|      25.497|      44.028|       0|      21.212|      52.247
RTD|      21.587|      25.535|     119.516|       1|      21.212|     119.516
RTD|      21.604|      26.543|     225.722|       3|      21.212|     225.722
RTD|      21.958|      26.575|      48.329|       3|      21.212|     225.722
RTD|      22.247|      25.216|      57.580|       3|      21.212|     225.722
RTD|      22.253|      25.017|      53.521|       3|      21.212|     225.722
RTD|      22.376|      24.824|      54.095|       3|      21.212|     225.722
RTD|      22.256|      24.655|      55.816|       3|      21.212|     225.722
RTD|      22.324|      24.682|      48.350|       3|      21.212|     225.722
RTD|      21.454|      24.519|     342.492|       9|      21.212|     342.492
RTD|      21.578|      23.617|      49.107|       9|      21.212|     342.492
RTD|      21.621|      23.611|      38.444|       9|      21.212|     342.492
RTD|      21.625|      23.958|     192.672|      10|      21.212|     342.492
RTD|      21.656|      23.675|      34.820|      10|      21.212|     342.492
RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      21.688|      23.626|      36.496|      10|      21.212|     342.492
RTD|      21.527|      23.720|      49.283|      10|      21.212|     342.492
RTD|      21.643|      23.711|      43.028|      10|      21.212|     342.492
---|------------|------------|------------|--------|-------------------------
RTS|      21.212|      24.562|     342.492|      10|    00:00:24/00:00:24


cat frozen : 

Freeze: 4770308881064 cycles, Trace Points: 30 (+10)

 +--------------- Hard IRQs ('|': locked)
 |             +- Delay flag ('+': > 1 us, '!': > 10 us)
 |             |
  Type     Time   Function (Parent)
:|func      -35   xnpod_schedule (xnintr_irq_handler)
:|[ 3096]   -34+  xnpod_schedule (xnintr_irq_handler)
:|func      -32+  __switch_to (xnpod_schedule)
:|[21768]   -30+  xnpod_schedule (xnpod_suspend_thread)
:|func      -28   __ipipe_restore_pipeline_head (xnpod_wait_thread_period)
:|end       -28+  __ipipe_restore_pipeline_head (xnpod_wait_thread_period)
:|begin     -26   __ipipe_dispatch_event (__ipipe_syscall_root)
:|end       -25+  __ipipe_dispatch_event (__ipipe_syscall_root)
: func      -22   __ipipe_syscall_root (system_call)
: func      -21   __ipipe_dispatch_event (__ipipe_syscall_root)
:|begin     -21   __ipipe_dispatch_event (__ipipe_syscall_root)
:|end       -20   __ipipe_dispatch_event (__ipipe_syscall_root)
: func      -19+  hisyscall_event (__ipipe_dispatch_event)
: func      -18   __rt_timer_tsc2ns (hisyscall_event)
: func      -17   __copy_from_user_ll (__rt_timer_tsc2ns)
: func      -16+  rt_timer_tsc2ns (__rt_timer_tsc2ns)
: func      -15   __copy_to_user_ll (__rt_timer_tsc2ns)
:|begin     -14+  __ipipe_dispatch_event (__ipipe_syscall_root)
:|end       -13+  __ipipe_dispatch_event (__ipipe_syscall_root)
: func      -11   __ipipe_syscall_root (system_call)
: func      -11   __ipipe_dispatch_event (__ipipe_syscall_root)
:|begin     -10+  __ipipe_dispatch_event (__ipipe_syscall_root)
:|end        -9   __ipipe_dispatch_event (__ipipe_syscall_root)
: func       -8+  hisyscall_event (__ipipe_dispatch_event)
: func       -7+  xnshadow_sys_trace (hisyscall_event)
: func       -5   ipipe_trace_frozen_reset (xnshadow_sys_trace)
: func       -4   __ipipe_global_path_lock (ipipe_trace_frozen_reset)
:|begin      -3+  __ipipe_global_path_lock (ipipe_trace_frozen_reset)
:|end         0   __ipipe_global_path_unlock (ipipe_trace_frozen_reset)
< freeze      0   xnshadow_sys_trace (hisyscall_event)
 |begin       1   __ipipe_dispatch_event (__ipipe_syscall_root)
 |end         1   __ipipe_dispatch_event (__ipipe_syscall_root)
  func        3   __ipipe_syscall_root (system_call)
  func        3   __ipipe_dispatch_event (__ipipe_syscall_root)
 |begin       4   __ipipe_dispatch_event (__ipipe_syscall_root)
 |end         5   __ipipe_dispatch_event (__ipipe_syscall_root)
  func        5   hisyscall_event (__ipipe_dispatch_event)
  func        6   __rt_task_wait_period (hisyscall_event)
  func        7   rt_task_wait_period (__rt_task_wait_period)
  func        8   xnpod_wait_thread_period (rt_task_wait_period)


cat max : 
Begin: 943575374801 cycles, Trace Points: 218 (-10/+1), Length: 376 us

 +--------------- Hard IRQs ('|': locked)
 |             +- Delay flag ('+': > 1 us, '!': > 10 us)
 |             |
  Type     Time   Function (Parent)
 |func    -19650   xnpod_schedule (xnpod_suspend_thread)
 |[21559] -19649   xnpod_schedule (xnpod_suspend_thread)
 |func    -19647   __switch_to (xnpod_schedule)
 |[ 3096] -19646   xnpod_schedule (xnintr_irq_handler)
 |func    -19644   __ipipe_walk_pipeline (__ipipe_handle_irq)
 |end     -19643   common_interrupt (<b7a31ed5>)
 |func    -19643   __ipipe_stall_root (resume_userspace)
  func    -19642   __ipipe_unstall_iret_root (restore_raw)
 |begin   -19641   __ipipe_unstall_iret_root (restore_raw)
 |end     -19640   __ipipe_unstall_iret_root (restore_raw)
>|begin       0+  common_interrupt (<080c4fce>)
:|func        1   __ipipe_handle_irq (common_interrupt)
:|func        1   __ipipe_ack_common_irq (__ipipe_handle_irq)
:|func        2   ipipe_test_and_stall_pipeline_from (__ipipe_ack_common_irq)
:|func        3+  mask_and_ack_8259A (__ipipe_ack_common_irq)
:|func        5   __ipipe_dispatch_wired (__ipipe_handle_irq)
:|func        6   xnintr_clock_handler (__ipipe_dispatch_wired)
:|func        6   xnintr_irq_handler (xnintr_clock_handler)
:|func        7   xnpod_announce_tick (xnintr_irq_handler)
:|func        8+  xntimer_do_tick_aperiodic (xnpod_announce_tick)
:|func        9   xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       10   xnpod_resume_thread (xnthread_periodic_handler)
:|[21559]    11+  xnpod_resume_thread (xnthread_periodic_handler)
:|func       13+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       15+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       17+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       19+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       20+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       22+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       24+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       25+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       27+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       29+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       30+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       32+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       34+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       36+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       38+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       39+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       41+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       43+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       44+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       46+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       48+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       49+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       52+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       53+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       55+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       57+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       58+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       60+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       62+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       63+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       65+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       67+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       69+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       71+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       73+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       75+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       77+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       78+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       80+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       81+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       83+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       85+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       87+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       89+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       91+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       92+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       94+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       95+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       97+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func       99+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      100+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      102+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      105+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      106+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      108+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      109+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      111+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      113+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      114+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      116+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      118+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      119+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      122+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      123+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      125+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      127+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      128+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      131+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      133+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      135+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      137+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      138+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      141+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      142+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      144+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      146+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      147+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      149+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      151+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      152+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      154+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      155+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      158+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      160+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      162+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      163+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      165+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      167+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      169+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      170+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      172+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      173+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      176+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      178+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      179+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      181+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      183+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      184+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      186+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      187+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      189+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      191+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      194+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      195+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      198+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      199+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      201+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      202+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      204+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      206+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      208+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      210+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      213+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      214+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      216+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      218+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      219+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      221+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      223+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      224+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      226+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      227+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      230+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      232+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      233+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      235+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      237+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      238+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      240+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      242+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      243+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      245+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      248+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      249+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      251+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      253+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      255+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      256+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      258+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      260+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      262+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      264+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      266+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      268+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      270+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      271+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      273+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      275+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      276+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      278+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      280+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      281+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      284+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      285+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      287+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      289+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      290+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      292+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      293+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      295+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      297+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      298+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      301+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      303+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      305+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      306+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      308+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      309+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      311+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      313+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      314+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      316+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      319+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      320+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      322+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      324+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      325+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      327+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      328+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      330+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      332+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      333+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      336+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      338+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      339+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      341+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      343+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      344+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      346+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      347+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      349+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      351+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      353+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      355+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      357+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      358+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      360+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      361+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      363+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
:|func      369+  xnpod_schedule (xnintr_irq_handler)
:|[ 3096]   370+  xnpod_schedule (xnintr_irq_handler)
:|func      372+  __switch_to (xnpod_schedule)
:|[21559]   374+  xnpod_schedule (xnpod_suspend_thread)
:|func      375   __ipipe_restore_pipeline_head (xnpod_wait_thread_period)
<|end       376   __ipipe_restore_pipeline_head (xnpod_wait_thread_period)
 |begin     377   __ipipe_dispatch_event (__ipipe_syscall_root)





--Boundary-00=_u7nyE5Ra/BOQheB--

