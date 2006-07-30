From: Julien Heyman <bidsonux@domain.hid>
Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
Date: Sun, 30 Jul 2006 19:36:51 +0200
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>
	<200607282317.34990.bidsonux@domain.hid> <44CB6EB3.5070707@domain.hid>
In-Reply-To: <44CB6EB3.5070707@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_04OzEX4EvMEgJ20"
Message-Id: <200607301936.52929.bidsonux@domain.hid>
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

--Boundary-00=_04OzEX4EvMEgJ20
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 29 July 2006 16:20, Jan Kiszka wrote:
> Julien Heyman wrote:
> > Hi,
> >
> > here's a quick follow-up on my issue, thanks for your time !
> >
> > Julien Heyman
> >
> > On Saturday 22 July 2006 19:17, Jan Kiszka wrote:
> >> Julien Heyman wrote:
> >>> Hi,
> >>>
> >>> On Thursday 20 July 2006 23:58, Jan Kiszka wrote:
> >>>> Julien Heyman wrote:
> >>>>> Hi,
> >>>>>
> >>>>> I am currently trying to evaluate Xenomai, and my current setup is :
> >>>>> VIA C3 533Mhz processor, Kubuntu 6.06 Linux distribution.
> >>>>> I am using Xenomai-2.1.0 over a 2.6.17.4 kernel.
> >>>>
> >>>> General advice: especially when starting new, try to pick the latest
> >>>> version, at least the latest from the preferred series (here 2.1.2).
> >>>> But 2.2 is even better. :)
> >>>
> >>> OK. Actually started with Xenomai-2.1.0 then switched to 2.1.1 to fix=
 a
> >>> kernel build error. But anyway, I will start with a fresh install of
> >>> 2.2 as soon as I have figured out the other points :)
> >>>
> >>>>> When I run the latency part of the testsuite (in a console under
> >>>>> KDE), I get
> >>>>> results that I cannot understand, so I probably did something wrong
> >>>>> (execution trace included below).
> >>>>> I get reasonable values during the first seconds, then all of a
> >>>>> sudden latencies begin to rise, continuously, to very large values.=
 -
> >>>>> I did check that DMA transfer is activated on my HD.
> >>>>> - I did select "Enable SMI workaround" + "Globally disable SMI" in
> >>>>> the Xenomai
> >>>>> options while configuring the kernel.
> >>>>> - I have disabled power management at BIOS level and disabled ACPI
> >>>>> support and
> >>>>> CPU frequency scaling during kernel configuration.
> >>>>> - I checked that I don't have anything called "legacy USB" in my
> >>>>> BIOS. I do have an "OnChip USB" option enable in the BIOS though.
> >>>>>
> >>>>> Any advice would be appreciated !
> >>>>
> >>>> Maybe it's related to some other weird on-chip hardware. At work we
> >>>> run Xenomai only on a head-less VIA C3 box, i.e. without X. No
> >>>> problems so far. I would suggest to try stopping X and run the test
> >>>> from the text mode.
> >>>
> >>> This is interesting : indeed when I switch to console mode
> >>> (Ctrl+Atl+F1) and run the test, the latency values stay right on trac=
k.
> >>> If I let the test run, switch to X, and switch back to the original
> >>> console, the values have gone wild in the meantime.
> >>> So there seems to be a strong link with X.
> >>> What does that say about potential causes of my issue ?
> >>
> >> Don't know. Might be a weird hardware design (wrt bus latencies) - or =
do
> >> you
> >> use any binary-only driver for X?
> >
> > I did not install any specific driver, I probably use the standard
> > Trident driver that came with the Kubuntu distribution.
> >
> >>>> A further tool to analyse such effects in details is the I-pipe
> >>>> tracer. It's an additional patch you have to apply to your kernel (s=
ee
> >>>> http://download.gna.org/adeos/patches/v2.6/i386/tracer). Enable this
> >>>> I-pipe option, rebuild your kernel, and start the latency test with
> >>>> -f. The test will then capture on every new worst-case delay a
> >>>> backtrace to /proc/ipipe/trace/frozen. You may want to play with the
> >>>> number of back-trace points or the verbose mode (see
> >>>> /proc/ipipe/trace/*) even after the capturing.
> >>>
> >>> I had already used an adeos patch during my initial kernel-patching
> >>> (adeos-ipipe-2.6.17-i386-1.3-07.patch)
> >>
> >> The tracer is an additional patch on top of I-pipe, see link above.
> >>
> >>> I tried running the latency test using /usr/xenomai/bin/xeno-load
> >>> latency -f but I get this error :
> >>>
> >>> =3D=3D Sampling period: 100 us
> >>> =3D=3D Test mode: periodic user-mode task
> >>> =3D=3D All results in microseconds
> >>> latency: failed to open benchmark device, code -19
> >>> (modprobe xeno_timerbench?)
> >>>
> >>> What am I doing wrong ?
> >>
> >> For < 2.2: check if CONFIG_XENO_DRIVERS_TIMERBENCH is y or m. If it's a
> >> module, follow the suggestion latency printed.
> >>
> >> In 2.2 the required tracing interface was moved to the nucleus, no need
> >> for these steps then.
> >
> > Ok, I installed Xenomai 2.2 from scratch over a freshly extracted kernel
> > source tree, used the tracer patch ipipe-tracer-2.6.17-i386-1.3-08.patc=
h,
> > rebuilt the kernel and relaunch the test : I still get increasing
> > latencies.
> >
> > I attach a copy of the latency test run, and the associated traces in
> > files "max" and "frozen" from /proc/ipipe/trace
> >
> > I have no clue how to interpret theses traces, is there a
> > documentation/user's guide available for the ipipe tracer ?
>
> Nope, I skipped this "boring" part so far. But I will provide some
> explanations below.
>
> > Regarding Gilles' comments on this topic :
> >> Losing too many ticks!
> >> TSC cannot be used as a timesource. =C3=82
> >> Possible reasons for this are:
> >> =C3=82  You're running with Speedstep,
> >> =C3=82  You don't have DMA enabled for your hard disk (see hdparm),
> >> =C3=82  Incorrect TSC synchronization on an SMP system (see dmesg).
> >> Falling back to a sane timesource now.
> >>
> >> Do you see such message in kernel logs ?
> >
> > No, I don't get any of these.
> >
> >> If this is the issue you are having, then you may try passing idle=3Dp=
oll
> >> on kernel boot line. Or recompile the kernel selecting a processor that
> >> has no tsc (for example 486), xenomai will then use the 8254 counter to
> >> emulate the tsc.
> >
> > I tried to rebuild with CPU=3D486, but it gives the same result.
> >
> >> Jan
> >>
> >> ----------------------------------------------------------------------=
=2D-
> >>
> >> bids@domain.hid$ sudo
> >> /usr/xenomai/bin/xeno-load latency -f Password:
> >> *
> >> *
> >> * Type ^C to stop this application.
> >> *
> >> *
> >> =3D=3D Sampling period: 100 us
> >> =3D=3D Test mode: periodic user-mode task
> >> =3D=3D All results in microseconds
> >> warming up...
> >> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> >> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
> >> worst RTD|      21.428|      23.956|      38.249|       0|      21.428=
|=20
> >>     38.249 RTD|      22.419|      24.491|      31.760|       0|    =20
> >> 21.428|      38.249 RTD|      21.833|      23.731|      52.247|       =
0|
> >>      21.428|      52.247 RTD|      21.776|      23.733|      45.060|  =
 =20
> >>   0|      21.428|      52.247 RTD|      21.467|      24.434|    =20
> >> 40.813|       0|      21.428|      52.247 RTD|      21.613|      24.68=
4|
> >>      40.517|       0|      21.428|      52.247 RTD|      21.585|    =20
> >> 25.503|      51.990|       0|      21.428|      52.247 RTD|      21.21=
2|
> >>      25.497|      44.028|       0|      21.212|      52.247 RTD|    =20
> >> 21.587|      25.535|     119.516|       1|      21.212|     119.516 RT=
D|
> >>      21.604|      26.543|     225.722|       3|      21.212|     225.7=
22
> >> RTD|      21.958|      26.575|      48.329|       3|      21.212|   =20
> >> 225.722 RTD|      22.247|      25.216|      57.580|       3|    =20
> >> 21.212|     225.722 RTD|      22.253|      25.017|      53.521|       =
3|
> >>      21.212|     225.722 RTD|      22.376|      24.824|      54.095|  =
 =20
> >>   3|      21.212|     225.722 RTD|      22.256|      24.655|    =20
> >> 55.816|       3|      21.212|     225.722 RTD|      22.324|      24.68=
2|
> >>      48.350|       3|      21.212|     225.722 RTD|      21.454|    =20
> >> 24.519|     342.492|       9|      21.212|     342.492 RTD|      21.57=
8|
> >>      23.617|      49.107|       9|      21.212|     342.492 RTD|    =20
> >> 21.621|      23.611|      38.444|       9|      21.212|     342.492 RT=
D|
> >>      21.625|      23.958|     192.672|      10|      21.212|     342.4=
92
> >> RTD|      21.656|      23.675|      34.820|      10|      21.212|   =20
> >> 342.492 RTT|  00:00:22  (periodic user-mode task, 100 us period,
> >> priority 99) RTH|-----lat min|-----lat avg|-----lat max|-overrun|----l=
at
> >> best|---lat worst RTD|      21.688|      23.626|      36.496|      10|=
 =20
> >>    21.212|     342.492 RTD|      21.527|      23.720|      49.283|    =
=20
> >> 10|      21.212|     342.492 RTD|      21.643|      23.711|      43.02=
8|
> >>      10|      21.212|     342.492
> >> ---|------------|------------|------------|--------|------------------=
=2D-
> >>----- RTS|      21.212|      24.562|     342.492|      10|  =20
> >> 00:00:24/00:00:24
> >>
> >>
> >> cat frozen :
>
> This is the trace the latency application triggered on the maximum delay
> (342.492 us). You should extend the back-trace period to cover at least
> the observed latency (say up to -400 us). Try "echo 500 >
> /proc/ipipe/trace/back_trace_points" for this. You can furthermore
> switch on more verbosity with echo 1 > /proc/ipipe/trace/verbose".


Attached is a backtrace with 500 points and verbosity turned on.
There is a big time gap at time -799, but I have no clue as to interpret th=
e=20
related traces to figure out where this time is spend.


>
> >> Freeze: 4770308881064 cycles, Trace Points: 30 (+10)
> >>
> >>  +--------------- Hard IRQs ('|': locked)
> >>
> >>  |             +- Delay flag ('+': > 1 us, '!': > 10 us)
> >>
> >>   Type     Time   Function (Parent)
> >>
> >> :|func      -35   xnpod_schedule (xnintr_irq_handler)
> >> :|[ 3096]   -34+  xnpod_schedule (xnintr_irq_handler)
>
> This traces the process (pid) being switched out.
>
> >> :|func      -32+  __switch_to (xnpod_schedule)
> >> :|[21768]   -30+  xnpod_schedule (xnpod_suspend_thread)
>
> This pid gets switched in, the latency test (more precisely the sampling
> thread).
>
> >> :|func      -28   __ipipe_restore_pipeline_head
> >> :| (xnpod_wait_thread_period) end       -28+=20
> >> :| __ipipe_restore_pipeline_head (xnpod_wait_thread_period) begin   =20
> >> :| -26   __ipipe_dispatch_event (__ipipe_syscall_root) end       -25+=
=20
> >> :| __ipipe_dispatch_event (__ipipe_syscall_root)
> >> :
> >> : func      -22   __ipipe_syscall_root (system_call)
>
> This is roughly the point when the latency test takes its timestamp to
> calculate the delay. This syscall here is then issued to convert TSCs
> into nanoseconds.
>
> >> : func      -21   __ipipe_dispatch_event (__ipipe_syscall_root)
> >> :
> >> :|begin     -21   __ipipe_dispatch_event (__ipipe_syscall_root)
> >> :|end       -20   __ipipe_dispatch_event (__ipipe_syscall_root)
> >> :
> >> : func      -19+  hisyscall_event (__ipipe_dispatch_event)
> >> : func      -18   __rt_timer_tsc2ns (hisyscall_event)
> >> : func      -17   __copy_from_user_ll (__rt_timer_tsc2ns)
> >> : func      -16+  rt_timer_tsc2ns (__rt_timer_tsc2ns)
> >> : func      -15   __copy_to_user_ll (__rt_timer_tsc2ns)
> >> :
> >> :|begin     -14+  __ipipe_dispatch_event (__ipipe_syscall_root)
> >> :|end       -13+  __ipipe_dispatch_event (__ipipe_syscall_root)
> >> :
> >> : func      -11   __ipipe_syscall_root (system_call)
> >> : func      -11   __ipipe_dispatch_event (__ipipe_syscall_root)
> >> :
> >> :|begin     -10+  __ipipe_dispatch_event (__ipipe_syscall_root)
> >> :|end        -9   __ipipe_dispatch_event (__ipipe_syscall_root)
> >> :
> >> : func       -8+  hisyscall_event (__ipipe_dispatch_event)
> >> : func       -7+  xnshadow_sys_trace (hisyscall_event)
> >> : func       -5   ipipe_trace_frozen_reset (xnshadow_sys_trace)
> >> : func       -4   __ipipe_global_path_lock (ipipe_trace_frozen_reset)
> >> :
> >> :|begin      -3+  __ipipe_global_path_lock (ipipe_trace_frozen_reset)
> >> :|end         0   __ipipe_global_path_unlock (ipipe_trace_frozen_reset)
> >>
> >> < freeze      0   xnshadow_sys_trace (hisyscall_event)
>
> And here we freeze after detecting a new worst-case (also issued as a
> syscall).
>
> >>  |begin       1   __ipipe_dispatch_event (__ipipe_syscall_root)
> >>  |end         1   __ipipe_dispatch_event (__ipipe_syscall_root)
> >>
> >>   func        3   __ipipe_syscall_root (system_call)
> >>   func        3   __ipipe_dispatch_event (__ipipe_syscall_root)
> >>
> >>  |begin       4   __ipipe_dispatch_event (__ipipe_syscall_root)
> >>  |end         5   __ipipe_dispatch_event (__ipipe_syscall_root)
> >>
> >>   func        5   hisyscall_event (__ipipe_dispatch_event)
> >>   func        6   __rt_task_wait_period (hisyscall_event)
> >>   func        7   rt_task_wait_period (__rt_task_wait_period)
> >>   func        8   xnpod_wait_thread_period (rt_task_wait_period)
> >>
> >>
> >> cat max :
>
> This trace captured the maximum time the system spent in IRQs-off context.
>
> >> Begin: 943575374801 cycles, Trace Points: 218 (-10/+1), Length: 376 us
>
> And that period took 376 us, a pathological result. It's a bit more than
> what latency observed, but that's normal for a short test cycle.
>
> >>  +--------------- Hard IRQs ('|': locked)
> >>
> >>  |             +- Delay flag ('+': > 1 us, '!': > 10 us)
> >>
> >>   Type     Time   Function (Parent)
> >>
> >>  |func    -19650   xnpod_schedule (xnpod_suspend_thread)
> >>  |[21559] -19649   xnpod_schedule (xnpod_suspend_thread)
> >>  |func    -19647   __switch_to (xnpod_schedule)
> >>  |[ 3096] -19646   xnpod_schedule (xnintr_irq_handler)
> >>  |func    -19644   __ipipe_walk_pipeline (__ipipe_handle_irq)
> >>  |end     -19643   common_interrupt (<b7a31ed5>)
> >>  |func    -19643   __ipipe_stall_root (resume_userspace)
> >>
> >>   func    -19642   __ipipe_unstall_iret_root (restore_raw)
> >>
> >>  |begin   -19641   __ipipe_unstall_iret_root (restore_raw)
> >>  |end     -19640   __ipipe_unstall_iret_root (restore_raw)
> >>  |
> >>> |begin       0+  common_interrupt (<080c4fce>)
>
> Here we start our critical region. The interesting thing is that there
> are almost 20 ms(!) between the last kernel activity and the interrupt
> entry. Likely a sign for hardware-related IRQ delays (unless some
> privileged user-space program does dirty dancing with cli, i.e. hard IRQ
> blocking).
>
> >> :|func        1   __ipipe_handle_irq (common_interrupt)
> >> :|func        1   __ipipe_ack_common_irq (__ipipe_handle_irq)
> >> :|func        2   ipipe_test_and_stall_pipeline_from
> >> :| (__ipipe_ack_common_irq) func        3+  mask_and_ack_8259A
> >> :| (__ipipe_ack_common_irq)
> >> :|func        5   __ipipe_dispatch_wired (__ipipe_handle_irq)
> >> :|func        6   xnintr_clock_handler (__ipipe_dispatch_wired)
> >> :|func        6   xnintr_irq_handler (xnintr_clock_handler)
> >> :|func        7   xnpod_announce_tick (xnintr_irq_handler)
> >> :|func        8+  xntimer_do_tick_aperiodic (xnpod_announce_tick)
> >> :|func        9   xnthread_periodic_handler (xntimer_do_tick_aperiodic)
> >> :|func       10   xnpod_resume_thread (xnthread_periodic_handler)
> >> :|[21559]    11+  xnpod_resume_thread (xnthread_periodic_handler)
> >> :|func       13+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
>
> ...
>
> >> :|func      363+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
>
> That are a lot of overruns. Haven't counted, but it should be one
> xnthread_periodic_handler per missed 100 us period (20000 / 100 =3D 200!).
>
> [BTW, I think we should handle even this failure scenario without
> looping. And there is another loop in xnpod_wait_thread_period.]
>
> >> :|func      369+  xnpod_schedule (xnintr_irq_handler)
> >> :|[ 3096]   370+  xnpod_schedule (xnintr_irq_handler)
> >> :|func      372+  __switch_to (xnpod_schedule)
> >> :|[21559]   374+  xnpod_schedule (xnpod_suspend_thread)
> >> :|func      375   __ipipe_restore_pipeline_head
> >> :| (xnpod_wait_thread_period)
> >>
> >> <|end       376   __ipipe_restore_pipeline_head
> >> (xnpod_wait_thread_period)
> >>
> >>  |begin     377   __ipipe_dispatch_event (__ipipe_syscall_root)
>
> No final judgement yet, but it looks to me like your hardware doesn't
> want to play with us.
>
> To exclude the possibility that the timer events get programmed wrongly
> as TSCs are skewed up, you could also try the irqbench test case. All
> you need is a nullmodem cable and a second PC with RS232 port, see
> doc/txt/irqbench.txt. And that test can also take back-traces.
>
> Jan


Ok, thanks. Unfortunately I don't have another Linux PC on hand right now.
I will try this as soon as I can.

Julien Heyman



--Boundary-00=_04OzEX4EvMEgJ20
Content-Type: text/plain; charset="utf-8";
	name="latency_pb_trace500points_acpi_enabled_except_CPU.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="latency_pb_trace500points_acpi_enabled_except_CPU.txt"

bids@domain.hid$ sudo /usr/xenomai/bin/xeno-load latency -f
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
RTD|      13.326|      23.257|      40.380|       0|      13.326|      40.380
RTD|      12.837|      22.680|     324.986|       5|      12.837|     324.986
RTD|      21.047|      23.158|     215.680|       7|      12.837|     324.986
RTD|      21.193|      25.083|     723.495|      15|      12.837|     723.495
RTD|      21.527|      24.250|     155.760|      16|      12.837|     723.495
RTD|      21.656|      23.979|     250.887|      18|      12.837|     723.495
vRTD|      21.859|      24.115|     226.351|      20|      12.837|     723.495
RTD|      21.604|      23.932|     355.300|      23|      12.837|     723.495
cRTD|      21.709|      24.130|     225.133|      24|      12.837|     723.495
---|------------|------------|------------|--------|-------------------------
RTS|      12.837|      23.842|     723.495|      24|    00:00:10/00:00:10
bids@domain.hid$ cat /proc/ipipe/trace/frozen
I-pipe frozen back-tracing service on 2.6.17.4GEXenomai/ipipe-1.3-07
------------------------------------------------------------
Freeze: 562608224481 cycles, Trace Points: 500 (+10)

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- Xenomai
 |||+-- IShield
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
:| #  [ 3718] -<?>-   99 -1609+   1.280  xnpod_schedule+0x8f (xnpod_suspend_thread+0x16b)
:| #  func               -1608+   1.580  __switch_to+0xc (xnpod_schedule+0x597)
:| #  [ 3201] Xorg    -1 -1606+   1.870  xnpod_schedule+0x5e3 (xnintr_irq_handler+0xa5)
:|   +func               -1604    0.797  __ipipe_walk_pipeline+0xb (__ipipe_handle_irq+0x108)
:|   +end     0xffffff00 -1603    0.720  common_interrupt+0x34 (memcpy_toiovec+0x1)
:|   +func               -1603    0.880  __ipipe_unstall_iret_root+0x9 (restore_raw+0x0)
:|   +end     0x8000000d -1602    0.822  __ipipe_unstall_iret_root+0x2c (restore_raw+0x0)
:    +func               -1601    0.689  memcpy_toiovec+0xb (unix_stream_recvmsg+0x15e)
:    +func               -1600    0.994  copy_to_user+0xa (memcpy_toiovec+0x46)
:    +func               -1599!  51.588  __copy_to_user_ll+0xa (copy_to_user+0x36)
:|   +begin   0xffffff00 -1548+   1.767  common_interrupt+0x21 (__copy_to_user_ll+0x46)
:|   +func               -1546    0.906  __ipipe_handle_irq+0xe (common_interrupt+0x29)
:|   +func               -1545    0.595  __ipipe_ack_common_irq+0xb (__ipipe_handle_irq+0x1ea)
:|   +func               -1544    0.792  ipipe_test_and_stall_pipeline_from+0x9 (__ipipe_ack_common_irq+0x18)
:|   #func               -1544+   2.114  mask_and_ack_8259A+0xc (__ipipe_ack_common_irq+0x8a)
:|   +func               -1542    0.659  __ipipe_dispatch_wired+0xb (__ipipe_handle_irq+0x18a)
:| #  func               -1541    0.588  xnintr_clock_handler+0x8 (__ipipe_dispatch_wired+0xa0)
:| #  func               -1540    0.676  xnintr_irq_handler+0xb (xnintr_clock_handler+0x18)
:| #  func               -1540    0.694  xnpod_announce_tick+0xb (xnintr_irq_handler+0x2a)
:| #  func               -1539    0.775  xntimer_do_tick_aperiodic+0xe (xnpod_announce_tick+0xa1)
:| #  func               -1538    0.906  xnthread_periodic_handler+0x8 (xntimer_do_tick_aperiodic+0x1f0)
:| #  func               -1537    0.870  xnpod_resume_thread+0xc (xnthread_periodic_handler+0x1e)
:| #  [ 3718] -<?>-   99 -1536+   4.185  xnpod_resume_thread+0x50 (xnthread_periodic_handler+0x1e)
:| #  func               -1532    0.666  xnpod_schedule+0xe (xnintr_irq_handler+0xa5)
:| #  [ 3201] Xorg    -1 -1532+   1.368  xnpod_schedule+0x8f (xnintr_irq_handler+0xa5)
:| #  func               -1530+   2.258  __switch_to+0xc (xnpod_schedule+0x597)
:| #  [ 3718] -<?>-   99 -1528+   1.054  xnpod_schedule+0x5e3 (xnpod_suspend_thread+0x16b)
:| #  func               -1527    0.861  xntimer_get_raw_clock_aperiodic+0x8 (xnpod_wait_thread_period+0xa2)
:| #  func               -1526    0.662  __ipipe_restore_pipeline_head+0xa (xnpod_wait_thread_period+0x11e)
:| +  end     0x80000000 -1525+   1.204  __ipipe_restore_pipeline_head+0x6d (xnpod_wait_thread_period+0x11e)
:| +  begin   0x80000001 -1524    0.889  __ipipe_dispatch_event+0x131 (__ipipe_syscall_root+0x32)
:| +  end     0x80000001 -1523+   1.567  __ipipe_dispatch_event+0x10e (__ipipe_syscall_root+0x32)
:  +  func               -1522    0.653  __ipipe_syscall_root+0xa (system_call+0x20)
:  +  func               -1521    0.880  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x32)
:| +  begin   0x80000001 -1520    0.964  __ipipe_dispatch_event+0x152 (__ipipe_syscall_root+0x32)
:| +  end     0x80000001 -1519    0.885  __ipipe_dispatch_event+0x141 (__ipipe_syscall_root+0x32)
:  +  func               -1518    0.769  hisyscall_event+0xe (__ipipe_dispatch_event+0x86)
:  +  func               -1517+   1.067  __rt_task_wait_period+0xb (hisyscall_event+0x19e)
:  +  func               -1516+   1.104  rt_task_wait_period+0x8 (__rt_task_wait_period+0x1d)
:  +  func               -1515    0.816  xnpod_wait_thread_period+0xe (rt_task_wait_period+0x3f)
:| +  begin   0x80000001 -1515    0.870  xnpod_wait_thread_period+0x133 (rt_task_wait_period+0x3f)
:| #  func               -1514+   1.949  xntimer_get_raw_clock_aperiodic+0x8 (xnpod_wait_thread_period+0x56)
:| #  func               -1512+   1.029  xnpod_suspend_thread+0xc (xnpod_wait_thread_period+0x86)
:| #  func               -1511    0.803  xnpod_schedule+0xe (xnpod_suspend_thread+0x16b)
:| #  [ 3718] -<?>-   99 -1510+   1.295  xnpod_schedule+0x8f (xnpod_suspend_thread+0x16b)
:| #  func               -1509+   1.432  __switch_to+0xc (xnpod_schedule+0x597)
:| #  [ 3201] Xorg    -1 -1507+   1.456  xnpod_schedule+0x5e3 (xnintr_irq_handler+0xa5)
:|   +func               -1506    0.940  __ipipe_walk_pipeline+0xb (__ipipe_handle_irq+0x108)
:|   +end     0xffffff00 -1505    0.692  common_interrupt+0x34 (__copy_to_user_ll+0x46)
:|   +func               -1504    0.882  __ipipe_unstall_iret_root+0x9 (restore_raw+0x0)
:|   +end     0x8000000d -1503!  17.353  __ipipe_unstall_iret_root+0x2c (restore_raw+0x0)
:    +func               -1486    0.676  skb_queue_head+0xa (unix_stream_recvmsg+0x23b)
:    +func               -1485+   1.299  __ipipe_test_and_stall_root+0x8 (skb_queue_head+0x15)
:    #func               -1484+   1.552  __ipipe_restore_root+0x8 (skb_queue_head+0x48)
:    #func               -1482+   1.052  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x18)
:|   #begin   0x80000000 -1481+   1.264  __ipipe_unstall_root+0x5b (__ipipe_restore_root+0x18)
:|   +end     0x80000000 -1480+   1.352  __ipipe_unstall_root+0x3a (__ipipe_restore_root+0x18)
:    +func               -1479+   2.376  mutex_unlock+0x8 (unix_stream_recvmsg+0x245)
:    +func               -1476+   3.936  dnotify_parent+0xa (vfs_read+0xd0)
:    +func               -1472+   1.777  inotify_dentry_parent_queue_event+0xa (vfs_read+0xf0)
:    +func               -1471+   3.067  inotify_inode_queue_event+0xe (vfs_read+0xfe)
:    +func               -1467    0.917  __ipipe_stall_root+0x8 (syscall_exit+0x5)
:    #func               -1467    0.906  __ipipe_unstall_iret_root+0x9 (restore_raw+0x0)
:|   #begin   0x80000000 -1466+   1.220  __ipipe_unstall_iret_root+0x6f (restore_raw+0x0)
:|   +end     0x8000000d -1464!  16.292  __ipipe_unstall_iret_root+0x2c (restore_raw+0x0)
:|   +begin   0xffffff00 -1448+   1.043  common_interrupt+0x21 (<b7954ed1>)
:|   +func               -1447    0.857  __ipipe_handle_irq+0xe (common_interrupt+0x29)
:|   +func               -1446    0.604  __ipipe_ack_common_irq+0xb (__ipipe_handle_irq+0x1ea)
:|   +func               -1446    0.674  ipipe_test_and_stall_pipeline_from+0x9 (__ipipe_ack_common_irq+0x18)
:|   #func               -1445+   2.305  mask_and_ack_8259A+0xc (__ipipe_ack_common_irq+0x8a)
:|   +func               -1443    0.994  __ipipe_dispatch_wired+0xb (__ipipe_handle_irq+0x18a)
:| #  func               -1442    0.722  xnintr_clock_handler+0x8 (__ipipe_dispatch_wired+0xa0)
:| #  func               -1441    0.586  xnintr_irq_handler+0xb (xnintr_clock_handler+0x18)
:| #  func               -1440+   1.162  xnpod_announce_tick+0xb (xnintr_irq_handler+0x2a)
:| #  func               -1439    0.818  xntimer_do_tick_aperiodic+0xe (xnpod_announce_tick+0xa1)
:| #  func               -1438    0.687  xnthread_periodic_handler+0x8 (xntimer_do_tick_aperiodic+0x1f0)
:| #  func               -1438    0.719  xnpod_resume_thread+0xc (xnthread_periodic_handler+0x1e)
:| #  [ 3718] -<?>-   99 -1437+   4.086  xnpod_resume_thread+0x50 (xnthread_periodic_handler+0x1e)
:| #  func               -1433    0.958  xnpod_schedule+0xe (xnintr_irq_handler+0xa5)
:| #  [ 3201] Xorg    -1 -1432+   1.831  xnpod_schedule+0x8f (xnintr_irq_handler+0xa5)
:| #  func               -1430+   2.089  __switch_to+0xc (xnpod_schedule+0x597)
:| #  [ 3718] -<?>-   99 -1428+   1.310  xnpod_schedule+0x5e3 (xnpod_suspend_thread+0x16b)
:| #  func               -1427    0.985  xntimer_get_raw_clock_aperiodic+0x8 (xnpod_wait_thread_period+0xa2)
:| #  func               -1426    0.820  __ipipe_restore_pipeline_head+0xa (xnpod_wait_thread_period+0x11e)
:| +  end     0x80000000 -1425    0.981  __ipipe_restore_pipeline_head+0x6d (xnpod_wait_thread_period+0x11e)
:| +  begin   0x80000001 -1424+   1.310  __ipipe_dispatch_event+0x131 (__ipipe_syscall_root+0x32)
:| +  end     0x80000001 -1423+   1.794  __ipipe_dispatch_event+0x10e (__ipipe_syscall_root+0x32)
:  +  func               -1421    0.775  __ipipe_syscall_root+0xa (system_call+0x20)
:  +  func               -1420    0.619  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x32)
:| +  begin   0x80000001 -1419+   1.050  __ipipe_dispatch_event+0x152 (__ipipe_syscall_root+0x32)
:| +  end     0x80000001 -1418    0.685  __ipipe_dispatch_event+0x141 (__ipipe_syscall_root+0x32)
:  +  func               -1418    0.807  hisyscall_event+0xe (__ipipe_dispatch_event+0x86)
:  +  func               -1417    0.638  __rt_task_wait_period+0xb (hisyscall_event+0x19e)
:  +  func               -1416+   1.065  rt_task_wait_period+0x8 (__rt_task_wait_period+0x1d)
:  +  func               -1415    0.629  xnpod_wait_thread_period+0xe (rt_task_wait_period+0x3f)
:| +  begin   0x80000001 -1414    0.868  xnpod_wait_thread_period+0x133 (rt_task_wait_period+0x3f)
:| #  func               -1414    0.792  xntimer_get_raw_clock_aperiodic+0x8 (xnpod_wait_thread_period+0x56)
:| #  func               -1413    0.867  xnpod_suspend_thread+0xc (xnpod_wait_thread_period+0x86)
:| #  func               -1412    0.820  xnpod_schedule+0xe (xnpod_suspend_thread+0x16b)
:| #  [ 3718] -<?>-   99 -1411+   1.423  xnpod_schedule+0x8f (xnpod_suspend_thread+0x16b)
:| #  func               -1410+   1.335  __switch_to+0xc (xnpod_schedule+0x597)
:| #  [ 3201] Xorg    -1 -1408+   1.878  xnpod_schedule+0x5e3 (xnintr_irq_handler+0xa5)
:|   +func               -1407+   1.294  __ipipe_walk_pipeline+0xb (__ipipe_handle_irq+0x108)
:|   +end     0xffffff00 -1405    0.672  common_interrupt+0x34 (<b7954ed1>)
:|   +func               -1405    0.709  __ipipe_stall_root+0x8 (resume_userspace+0x5)
:    #func               -1404+   1.172  __ipipe_unstall_iret_root+0x9 (restore_raw+0x0)
:|   #begin   0x80000000 -1403+   1.183  __ipipe_unstall_iret_root+0x6f (restore_raw+0x0)
:|   +end     0x8000000d -1401!  54.043  __ipipe_unstall_iret_root+0x2c (restore_raw+0x0)
:|   +begin   0xffffff00 -1347    0.840  common_interrupt+0x21 (<b79a709f>)
:|   +func               -1347+   1.230  __ipipe_handle_irq+0xe (common_interrupt+0x29)
:|   +func               -1345    0.722  __ipipe_ack_common_irq+0xb (__ipipe_handle_irq+0x1ea)
:|   +func               -1345+   1.361  ipipe_test_and_stall_pipeline_from+0x9 (__ipipe_ack_common_irq+0x18)
:|   #func               -1343+   1.953  mask_and_ack_8259A+0xc (__ipipe_ack_common_irq+0x8a)
:|   +func               -1341    0.904  __ipipe_dispatch_wired+0xb (__ipipe_handle_irq+0x18a)
:| #  func               -1340+   1.026  xnintr_clock_handler+0x8 (__ipipe_dispatch_wired+0xa0)
:| #  func               -1339+   1.086  xnintr_irq_handler+0xb (xnintr_clock_handler+0x18)
:| #  func               -1338    0.677  xnpod_announce_tick+0xb (xnintr_irq_handler+0x2a)
:| #  func               -1338    0.837  xntimer_do_tick_aperiodic+0xe (xnpod_announce_tick+0xa1)
:| #  func               -1337    0.642  xnthread_periodic_handler+0x8 (xntimer_do_tick_aperiodic+0x1f0)
:| #  func               -1336    0.646  xnpod_resume_thread+0xc (xnthread_periodic_handler+0x1e)
:| #  [ 3718] -<?>-   99 -1336+   3.730  xnpod_resume_thread+0x50 (xnthread_periodic_handler+0x1e)
:| #  func               -1332    0.857  xnpod_schedule+0xe (xnintr_irq_handler+0xa5)
:| #  [ 3201] Xorg    -1 -1331+   1.456  xnpod_schedule+0x8f (xnintr_irq_handler+0xa5)
:| #  func               -1329+   3.219  __switch_to+0xc (xnpod_schedule+0x597)
:| #  [ 3718] -<?>-   99 -1326    1.000  xnpod_schedule+0x5e3 (xnpod_suspend_thread+0x16b)
:| #  func               -1325+   1.529  xntimer_get_raw_clock_aperiodic+0x8 (xnpod_wait_thread_period+0xa2)
:| #  func               -1324    0.750  __ipipe_restore_pipeline_head+0xa (xnpod_wait_thread_period+0x11e)
:| +  end     0x80000000 -1323+   1.001  __ipipe_restore_pipeline_head+0x6d (xnpod_wait_thread_period+0x11e)
:| +  begin   0x80000001 -1322    0.880  __ipipe_dispatch_event+0x131 (__ipipe_syscall_root+0x32)
:| +  end     0x80000001 -1321+   1.735  __ipipe_dispatch_event+0x10e (__ipipe_syscall_root+0x32)
:  +  func               -1319    0.724  __ipipe_syscall_root+0xa (system_call+0x20)
:  +  func               -1319    0.814  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x32)
:| +  begin   0x80000001 -1318    0.882  __ipipe_dispatch_event+0x152 (__ipipe_syscall_root+0x32)
:| +  end     0x80000001 -1317    0.795  __ipipe_dispatch_event+0x141 (__ipipe_syscall_root+0x32)
:  +  func               -1316    0.840  hisyscall_event+0xe (__ipipe_dispatch_event+0x86)
:  +  func               -1315    0.825  __rt_task_wait_period+0xb (hisyscall_event+0x19e)
:  +  func               -1314    0.616  rt_task_wait_period+0x8 (__rt_task_wait_period+0x1d)
:  +  func               -1314    0.846  xnpod_wait_thread_period+0xe (rt_task_wait_period+0x3f)
:| +  begin   0x80000001 -1313    0.941  xnpod_wait_thread_period+0x133 (rt_task_wait_period+0x3f)
:| #  func               -1312    0.818  xntimer_get_raw_clock_aperiodic+0x8 (xnpod_wait_thread_period+0x56)
:| #  func               -1311    0.747  xnpod_suspend_thread+0xc (xnpod_wait_thread_period+0x86)
:| #  func               -1310+   1.039  xnpod_schedule+0xe (xnpod_suspend_thread+0x16b)
:| #  [ 3718] -<?>-   99 -1309+   1.365  xnpod_schedule+0x8f (xnpod_suspend_thread+0x16b)
:| #  func               -1308+   1.333  __switch_to+0xc (xnpod_schedule+0x597)
:| #  [ 3201] Xorg    -1 -1307+   1.494  xnpod_schedule+0x5e3 (xnintr_irq_handler+0xa5)
:|   +func               -1305    0.872  __ipipe_walk_pipeline+0xb (__ipipe_handle_irq+0x108)
:|   +end     0xffffff00 -1304    0.735  common_interrupt+0x34 (<b79a709f>)
:|   +func               -1304    0.790  __ipipe_stall_root+0x8 (resume_userspace+0x5)
:    #func               -1303    0.662  __ipipe_unstall_iret_root+0x9 (restore_raw+0x0)
:|   #begin   0x80000000 -1302+   1.013  __ipipe_unstall_iret_root+0x6f (restore_raw+0x0)
:|   +end     0x8000000d -1301!  53.312  __ipipe_unstall_iret_root+0x2c (restore_raw+0x0)
:|   +begin   0xffffff00 -1248+   1.071  common_interrupt+0x21 (<0806ff70>)
:|   +func               -1247    0.724  __ipipe_handle_irq+0xe (common_interrupt+0x29)
:|   +func               -1246    0.975  __ipipe_ack_common_irq+0xb (__ipipe_handle_irq+0x1ea)
:|   +func               -1245    0.838  ipipe_test_and_stall_pipeline_from+0x9 (__ipipe_ack_common_irq+0x18)
:|   #func               -1244+   2.050  mask_and_ack_8259A+0xc (__ipipe_ack_common_irq+0x8a)
:|   +func               -1242    0.670  __ipipe_dispatch_wired+0xb (__ipipe_handle_irq+0x18a)
:| #  func               -1242    0.726  xnintr_clock_handler+0x8 (__ipipe_dispatch_wired+0xa0)
:| #  func               -1241    0.704  xnintr_irq_handler+0xb (xnintr_clock_handler+0x18)
:| #  func               -1240    0.923  xnpod_announce_tick+0xb (xnintr_irq_handler+0x2a)
:| #  func               -1239    0.720  xntimer_do_tick_aperiodic+0xe (xnpod_announce_tick+0xa1)
:| #  func               -1238    0.928  xnthread_periodic_handler+0x8 (xntimer_do_tick_aperiodic+0x1f0)
:| #  func               -1238    0.777  xnpod_resume_thread+0xc (xnthread_periodic_handler+0x1e)
:| #  [ 3718] -<?>-   99 -1237+   1.380  xnpod_resume_thread+0x50 (xnthread_periodic_handler+0x1e)
:| #  func               -1235    0.771  ipipe_trigger_irq+0xe (xntimer_do_tick_aperiodic+0x1c7)
:| #  func               -1235+   1.423  __ipipe_handle_irq+0xe (ipipe_trigger_irq+0x50)
:| #  func               -1233+   1.121  __ipipe_dispatch_wired+0xb (__ipipe_handle_irq+0x18a)
:| #  func               -1232    0.840  xnpod_schedule+0xe (xnintr_irq_handler+0xa5)
:| #  [ 3201] Xorg    -1 -1231+   1.419  xnpod_schedule+0x8f (xnintr_irq_handler+0xa5)
:| #  func               -1230+   2.312  __switch_to+0xc (xnpod_schedule+0x597)
:| #  [ 3718] -<?>-   99 -1227    0.986  xnpod_schedule+0x5e3 (xnpod_suspend_thread+0x16b)
:| #  func               -1226    0.719  xntimer_get_raw_clock_aperiodic+0x8 (xnpod_wait_thread_period+0xa2)
:| #  func               -1226    0.689  __ipipe_restore_pipeline_head+0xa (xnpod_wait_thread_period+0x11e)
:| +  func               -1225+   1.340  __ipipe_sync_stage+0xe (__ipipe_restore_pipeline_head+0x94)
:| #  func               -1224    0.850  xnintr_clock_handler+0x8 (__ipipe_sync_stage+0xd8)
:| #  func               -1223    0.820  xnintr_irq_handler+0xb (xnintr_clock_handler+0x18)
:| #  func               -1222    0.762  xnpod_announce_tick+0xb (xnintr_irq_handler+0x2a)
:| #  func               -1221+   3.831  xntimer_do_tick_aperiodic+0xe (xnpod_announce_tick+0xa1)
:| #  func               -1217    0.908  rthal_irq_host_pend+0x8 (xnintr_irq_handler+0x75)
:| #  func               -1217+   1.129  __ipipe_schedule_irq+0xc (rthal_irq_host_pend+0x18)
:| +  end     0x80000000 -1215+   1.455  __ipipe_restore_pipeline_head+0x6d (xnpod_wait_thread_period+0x11e)
:| +  begin   0x80000001 -1214+   1.054  __ipipe_dispatch_event+0x131 (__ipipe_syscall_root+0x32)
:| +  end     0x80000001 -1213+   1.668  __ipipe_dispatch_event+0x10e (__ipipe_syscall_root+0x32)
:  +  func               -1211    0.728  __ipipe_syscall_root+0xa (system_call+0x20)
:  +  func               -1211    0.619  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x32)
:| +  begin   0x80000001 -1210+   1.144  __ipipe_dispatch_event+0x152 (__ipipe_syscall_root+0x32)
:| +  end     0x80000001 -1209+   1.016  __ipipe_dispatch_event+0x141 (__ipipe_syscall_root+0x32)
:  +  func               -1208    0.979  hisyscall_event+0xe (__ipipe_dispatch_event+0x86)
:  +  func               -1207    0.619  __rt_task_wait_period+0xb (hisyscall_event+0x19e)
:  +  func               -1206+   1.631  rt_task_wait_period+0x8 (__rt_task_wait_period+0x1d)
:  +  func               -1205    0.734  xnpod_wait_thread_period+0xe (rt_task_wait_period+0x3f)
:| +  begin   0x80000001 -1204+   1.078  xnpod_wait_thread_period+0x133 (rt_task_wait_period+0x3f)
:| #  func               -1203    0.807  xntimer_get_raw_clock_aperiodic+0x8 (xnpod_wait_thread_period+0x56)
:| #  func               -1202+   1.116  xnpod_suspend_thread+0xc (xnpod_wait_thread_period+0x86)
:| #  func               -1201    0.908  xnpod_schedule+0xe (xnpod_suspend_thread+0x16b)
:| #  [ 3718] -<?>-   99 -1200+   1.453  xnpod_schedule+0x8f (xnpod_suspend_thread+0x16b)
:| #  func               -1198+   1.327  __switch_to+0xc (xnpod_schedule+0x597)
:| #  [ 3201] Xorg    -1 -1197+   1.653  xnpod_schedule+0x5e3 (xnintr_irq_handler+0xa5)
:|   +func               -1195    0.779  __ipipe_walk_pipeline+0xb (__ipipe_handle_irq+0x108)
:|  + func               -1195+   1.125  ipipe_suspend_domain+0xc (__ipipe_walk_pipeline+0x85)
:|  + func               -1194+   1.159  __ipipe_sync_stage+0xe (ipipe_suspend_domain+0x58)
:|  # end     0x80000000 -1192    0.889  __ipipe_sync_stage+0x100 (ipipe_suspend_domain+0x58)
:   # func               -1191    0.754  shield_handler+0x8 (__ipipe_sync_stage+0xd8)
:   # func               -1191    0.820  __ipipe_schedule_irq+0xc (shield_handler+0x18)
:|  # begin   0x80000001 -1190+   1.035  __ipipe_schedule_irq+0xfb (shield_handler+0x18)
:|  # end     0x80000001 -1189    0.900  __ipipe_schedule_irq+0x12c (shield_handler+0x18)
:|  # begin   0x80000000 -1188+   1.123  __ipipe_sync_stage+0x14b (ipipe_suspend_domain+0x58)
:|   +func               -1187+   1.127  __ipipe_sync_stage+0xe (ipipe_suspend_domain+0x58)
:|   #end     0x80000000 -1186    0.810  __ipipe_sync_stage+0x100 (ipipe_suspend_domain+0x58)
:    #func               -1185    0.936  do_IRQ+0x8 (__ipipe_sync_stage+0x135)
:    #func               -1184+   1.602  __do_IRQ+0xd (do_IRQ+0x22)
:    #func               -1182+   1.219  handle_IRQ_event+0xd (__do_IRQ+0x9b)
:    #func               -1181    0.717  timer_interrupt+0x9 (handle_IRQ_event+0x44)
:    #func               -1180+   1.694  mark_offset_pmtmr+0xc (timer_interrupt+0x2c)
:    #func               -1179+   1.039  do_timer+0xb (timer_interrupt+0x32)
:    #func               -1178+   1.151  adjtime_adjustment+0x8 (do_timer+0x3d)
:    #func               -1177    0.582  update_process_times+0xa (timer_interrupt+0x50)
:    #func               -1176+   1.074  account_user_time+0x8 (update_process_times+0x22)
:    #func               -1175+   1.411  run_local_timers+0x8 (update_process_times+0x29)
:    #func               -1173    0.767  raise_softirq+0xa (run_local_timers+0x12)
:    #func               -1173    0.631  __ipipe_test_and_stall_root+0x8 (raise_softirq+0x11)
:    #func               -1172    1.000  __ipipe_restore_root+0x8 (raise_softirq+0x5e)
:    #func               -1171    0.810  __ipipe_stall_root+0x8 (__ipipe_restore_root+0x11)
:    #func               -1170    0.805  softlockup_tick+0x9 (run_local_timers+0x17)
:    #func               -1169    0.584  rcu_pending+0x8 (update_process_times+0x30)
:    #func               -1169    0.857  __rcu_pending+0x8 (rcu_pending+0x17)
:    #func               -1168+   1.329  __rcu_pending+0x8 (rcu_pending+0x35)
:    #func               -1167+   1.252  scheduler_tick+0xe (update_process_times+0x44)
:    #func               -1165+   1.934  sched_clock+0xd (scheduler_tick+0x1f)
:    #func               -1164+   1.904  task_timeslice+0x8 (scheduler_tick+0x251)
:    #func               -1162+   1.282  run_posix_cpu_timers+0xe (update_process_times+0x4a)
:    #func               -1160    0.891  __ipipe_test_root+0x8 (run_posix_cpu_timers+0x1c)
:    #func               -1159    0.749  profile_tick+0xa (timer_interrupt+0x58)
:    #func               -1159    0.852  __ipipe_stall_root+0x8 (handle_IRQ_event+0x75)
:    #func               -1158+   1.146  note_interrupt+0xe (__do_IRQ+0xfe)
:    #func               -1157    0.756  end_8259A_irq+0x8 (__do_IRQ+0xca)
:    #func               -1156    0.657  enable_8259A_irq+0xc (end_8259A_irq+0x1e)
:|   #begin   0x80000001 -1155+   2.232  enable_8259A_irq+0xcb (end_8259A_irq+0x1e)
:|   #end     0x80000001 -1153    0.930  enable_8259A_irq+0x83 (end_8259A_irq+0x1e)
:    #func               -1152    0.722  irq_exit+0x8 (do_IRQ+0x27)
:    #func               -1151    0.640  do_softirq+0x9 (irq_exit+0x55)
:    #func               -1151+   1.099  __ipipe_test_and_stall_root+0x8 (do_softirq+0x25)
:    #func               -1150+   1.252  __do_softirq+0xb (do_softirq+0x4a)
:|   #begin   0xffffff00 -1148    0.921  common_interrupt+0x21 (__ipipe_trace+0x246)
:|   #func               -1147    0.788  __ipipe_handle_irq+0xe (common_interrupt+0x29)
:|   #func               -1147+   1.475  __ipipe_ack_common_irq+0xb (__ipipe_handle_irq+0x1ea)
:|   #func               -1145    0.960  ipipe_test_and_stall_pipeline_from+0x9 (__ipipe_ack_common_irq+0x18)
:|   #func               -1144+   2.445  mask_and_ack_8259A+0xc (__ipipe_ack_common_irq+0x8a)
:|   #func               -1142    0.676  __ipipe_dispatch_wired+0xb (__ipipe_handle_irq+0x18a)
:| # *func               -1141+   1.095  xnintr_clock_handler+0x8 (__ipipe_dispatch_wired+0xa0)
:| # *func               -1140+   2.513  xnintr_irq_handler+0xb (xnintr_clock_handler+0x18)
:| # *func               -1138    0.822  xnpod_announce_tick+0xb (xnintr_irq_handler+0x2a)
:| # *func               -1137    0.827  xntimer_do_tick_aperiodic+0xe (xnpod_announce_tick+0xa1)
:| # *func               -1136    0.780  xnthread_periodic_handler+0x8 (xntimer_do_tick_aperiodic+0x1f0)
:| # *func               -1135    0.979  xnpod_resume_thread+0xc (xnthread_periodic_handler+0x1e)
:| # *[ 3718] -<?>-   99 -1134+   3.810  xnpod_resume_thread+0x50 (xnthread_periodic_handler+0x1e)
:| # *func               -1130    0.758  xnpod_schedule+0xe (xnintr_irq_handler+0xa5)
:| # *[ 3201] Xorg    -1 -1130+   1.614  xnpod_schedule+0x8f (xnintr_irq_handler+0xa5)
:| # *func               -1128+   2.271  __switch_to+0xc (xnpod_schedule+0x597)
:| # *[ 3718] -<?>-   99 -1126+   1.061  xnpod_schedule+0x5e3 (xnpod_suspend_thread+0x16b)
:| # *func               -1125    0.771  xntimer_get_raw_clock_aperiodic+0x8 (xnpod_wait_thread_period+0xa2)
:| # *func               -1124+   1.014  __ipipe_restore_pipeline_head+0xa (xnpod_wait_thread_period+0x11e)
:| + *end     0x80000000 -1123+   1.252  __ipipe_restore_pipeline_head+0x6d (xnpod_wait_thread_period+0x11e)
:| + *begin   0x80000001 -1122    0.971  __ipipe_dispatch_event+0x131 (__ipipe_syscall_root+0x32)
:| + *end     0x80000001 -1121+   1.629  __ipipe_dispatch_event+0x10e (__ipipe_syscall_root+0x32)
:  + *func               -1119    0.852  __ipipe_syscall_root+0xa (system_call+0x20)
:  + *func               -1118    0.822  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x32)
:| + *begin   0x80000001 -1117    0.898  __ipipe_dispatch_event+0x152 (__ipipe_syscall_root+0x32)
:| + *end     0x80000001 -1116    0.696  __ipipe_dispatch_event+0x141 (__ipipe_syscall_root+0x32)
:  + *func               -1116+   1.174  hisyscall_event+0xe (__ipipe_dispatch_event+0x86)
:  + *func               -1115    0.844  __rt_task_wait_period+0xb (hisyscall_event+0x19e)
:  + *func               -1114    0.775  rt_task_wait_period+0x8 (__rt_task_wait_period+0x1d)
:  + *func               -1113    0.649  xnpod_wait_thread_period+0xe (rt_task_wait_period+0x3f)
:| + *begin   0x80000001 -1112+   1.234  xnpod_wait_thread_period+0x133 (rt_task_wait_period+0x3f)
:| # *func               -1111+   1.181  xntimer_get_raw_clock_aperiodic+0x8 (xnpod_wait_thread_period+0x56)
:| # *func               -1110    0.921  xnpod_suspend_thread+0xc (xnpod_wait_thread_period+0x86)
:| # *func               -1109    0.737  xnpod_schedule+0xe (xnpod_suspend_thread+0x16b)
:| # *[ 3718] -<?>-   99 -1108+   1.805  xnpod_schedule+0x8f (xnpod_suspend_thread+0x16b)
:| # *func               -1106+   1.707  __switch_to+0xc (xnpod_schedule+0x597)
:| # *[ 3201] Xorg    -1 -1105+   1.528  xnpod_schedule+0x5e3 (xnintr_irq_handler+0xa5)
:|   #func               -1103    0.876  __ipipe_walk_pipeline+0xb (__ipipe_handle_irq+0x108)
:|   #end     0xffffff00 -1102    0.975  common_interrupt+0x34 (__ipipe_trace+0x246)
:    #func               -1101    0.741  __ipipe_unstall_root+0x8 (__do_softirq+0x3f)
:|   #begin   0x80000000 -1101+   1.016  __ipipe_unstall_root+0x5b (__do_softirq+0x3f)
:|   +end     0x80000000 -1100    0.735  __ipipe_unstall_root+0x3a (__do_softirq+0x3f)
:    +func               -1099+   1.061  run_timer_softirq+0xe (__do_softirq+0x55)
:    +func               -1098+   1.367  hrtimer_run_queues+0xe (run_timer_softirq+0x1b)
:    +func               -1096    0.732  __ipipe_stall_root+0x8 (hrtimer_run_queues+0xc5)
:    #func               -1096    0.642  __ipipe_unstall_root+0x8 (hrtimer_run_queues+0xf8)
:|   #begin   0x80000000 -1095+   1.245  __ipipe_unstall_root+0x5b (hrtimer_run_queues+0xf8)
:|   +end     0x80000000 -1094    0.844  __ipipe_unstall_root+0x3a (hrtimer_run_queues+0xf8)
:    +func               -1093    0.932  __ipipe_stall_root+0x8 (run_timer_softirq+0x31)
:    #func               -1092    0.589  __ipipe_unstall_root+0x8 (run_timer_softirq+0x191)
:|   #begin   0x80000000 -1091+   1.026  __ipipe_unstall_root+0x5b (run_timer_softirq+0x191)
:|   +end     0x80000000 -1090+   1.196  __ipipe_unstall_root+0x3a (run_timer_softirq+0x191)
:    +func               -1089    0.867  __ipipe_stall_root+0x8 (__do_softirq+0x6c)
:    #func               -1088    0.662  __ipipe_restore_root+0x8 (do_softirq+0x42)
:    #func               -1088    0.960  __ipipe_stall_root+0x8 (__ipipe_restore_root+0x11)
:|   #func               -1087    0.889  __ipipe_unstall_iret_root+0x9 (restore_raw+0x0)
:|   +end     0x8000000d -1086    0.844  __ipipe_unstall_iret_root+0x2c (restore_raw+0x0)
:|   +begin   0x80000000 -1085+   1.243  __ipipe_sync_stage+0x14b (ipipe_suspend_domain+0x58)
:|   +end     0xffffff00 -1084+   1.179  common_interrupt+0x34 (<0806ff70>)
:|   +func               -1082+   1.056  __ipipe_stall_root+0x8 (resume_userspace+0x5)
:    #func               -1081    0.960  __ipipe_unstall_iret_root+0x9 (restore_raw+0x0)
:|   #begin   0x80000000 -1080    0.921  __ipipe_unstall_iret_root+0x6f (restore_raw+0x0)
:|   +end     0x8000000d -1080!  31.586  __ipipe_unstall_iret_root+0x2c (restore_raw+0x0)
:|   +begin   0xffffff00 -1048+   3.477  common_interrupt+0x21 (<b79522ee>)
:|   +func               -1044    0.908  __ipipe_handle_irq+0xe (common_interrupt+0x29)
:|   +func               -1044    0.593  __ipipe_ack_common_irq+0xb (__ipipe_handle_irq+0x1ea)
:|   +func               -1043    0.900  ipipe_test_and_stall_pipeline_from+0x9 (__ipipe_ack_common_irq+0x18)
:|   #func               -1042+   2.035  mask_and_ack_8259A+0xc (__ipipe_ack_common_irq+0x8a)
:|   +func               -1040    0.662  __ipipe_dispatch_wired+0xb (__ipipe_handle_irq+0x18a)
:| #  func               -1039    0.617  xnintr_clock_handler+0x8 (__ipipe_dispatch_wired+0xa0)
:| #  func               -1039    0.745  xnintr_irq_handler+0xb (xnintr_clock_handler+0x18)
:| #  func               -1038    0.876  xnpod_announce_tick+0xb (xnintr_irq_handler+0x2a)
:| #  func               -1037+   1.073  xntimer_do_tick_aperiodic+0xe (xnpod_announce_tick+0xa1)
:| #  func               -1036    0.631  xnthread_periodic_handler+0x8 (xntimer_do_tick_aperiodic+0x1f0)
:| #  func               -1035+   1.028  xnpod_resume_thread+0xc (xnthread_periodic_handler+0x1e)
:| #  [ 3718] -<?>-   99 -1034+   3.788  xnpod_resume_thread+0x50 (xnthread_periodic_handler+0x1e)
:| #  func               -1031    0.794  xnpod_schedule+0xe (xnintr_irq_handler+0xa5)
:| #  [ 3201] Xorg    -1 -1030+   1.404  xnpod_schedule+0x8f (xnintr_irq_handler+0xa5)
:| #  func               -1028+   2.387  __switch_to+0xc (xnpod_schedule+0x597)
:| #  [ 3718] -<?>-   99 -1026+   1.488  xnpod_schedule+0x5e3 (xnpod_suspend_thread+0x16b)
:| #  func               -1025    0.754  xntimer_get_raw_clock_aperiodic+0x8 (xnpod_wait_thread_period+0xa2)
:| #  func               -1024    0.717  __ipipe_restore_pipeline_head+0xa (xnpod_wait_thread_period+0x11e)
:| +  end     0x80000000 -1023+   1.132  __ipipe_restore_pipeline_head+0x6d (xnpod_wait_thread_period+0x11e)
:| +  begin   0x80000001 -1022    0.971  __ipipe_dispatch_event+0x131 (__ipipe_syscall_root+0x32)
:| +  end     0x80000001 -1021+   1.647  __ipipe_dispatch_event+0x10e (__ipipe_syscall_root+0x32)
:  +  func               -1019    0.670  __ipipe_syscall_root+0xa (system_call+0x20)
:  +  func               -1019+   1.415  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x32)
:| +  begin   0x80000001 -1017    0.977  __ipipe_dispatch_event+0x152 (__ipipe_syscall_root+0x32)
:| +  end     0x80000001 -1016    0.752  __ipipe_dispatch_event+0x141 (__ipipe_syscall_root+0x32)
:  +  func               -1016    0.769  hisyscall_event+0xe (__ipipe_dispatch_event+0x86)
:  +  func               -1015+   1.097  __rt_task_wait_period+0xb (hisyscall_event+0x19e)
:  +  func               -1014    0.872  rt_task_wait_period+0x8 (__rt_task_wait_period+0x1d)
:  +  func               -1013    0.756  xnpod_wait_thread_period+0xe (rt_task_wait_period+0x3f)
:| +  begin   0x80000001 -1012    0.867  xnpod_wait_thread_period+0x133 (rt_task_wait_period+0x3f)
:| #  func               -1011+   1.211  xntimer_get_raw_clock_aperiodic+0x8 (xnpod_wait_thread_period+0x56)
:| #  func               -1010    0.970  xnpod_suspend_thread+0xc (xnpod_wait_thread_period+0x86)
:| #  func               -1009    0.720  xnpod_schedule+0xe (xnpod_suspend_thread+0x16b)
:| #  [ 3718] -<?>-   99 -1008+   1.277  xnpod_schedule+0x8f (xnpod_suspend_thread+0x16b)
:| #  func               -1007+   1.651  __switch_to+0xc (xnpod_schedule+0x597)
:| #  [ 3201] Xorg    -1 -1005+   1.807  xnpod_schedule+0x5e3 (xnintr_irq_handler+0xa5)
:|   +func               -1004+   1.035  __ipipe_walk_pipeline+0xb (__ipipe_handle_irq+0x108)
:|   +end     0xffffff00 -1002    0.638  common_interrupt+0x34 (<b79522ee>)
:|   +func               -1002+   1.146  __ipipe_stall_root+0x8 (resume_userspace+0x5)
:    #func               -1001+   1.649  __ipipe_unstall_iret_root+0x9 (restore_raw+0x0)
:|   #begin   0x80000000  -999+   1.014  __ipipe_unstall_iret_root+0x6f (restore_raw+0x0)
:|   +end     0x8000000d  -998!  49.636  __ipipe_unstall_iret_root+0x2c (restore_raw+0x0)
:|   +begin   0xffffff00  -948+   1.013  common_interrupt+0x21 (<b795413b>)
:|   +func                -947    0.782  __ipipe_handle_irq+0xe (common_interrupt+0x29)
:|   +func                -947    0.606  __ipipe_ack_common_irq+0xb (__ipipe_handle_irq+0x1ea)
:|   +func                -946    0.691  ipipe_test_and_stall_pipeline_from+0x9 (__ipipe_ack_common_irq+0x18)
:|   #func                -945+   2.102  mask_and_ack_8259A+0xc (__ipipe_ack_common_irq+0x8a)
:|   +func                -943    0.741  __ipipe_dispatch_wired+0xb (__ipipe_handle_irq+0x18a)
:| #  func                -942    0.672  xnintr_clock_handler+0x8 (__ipipe_dispatch_wired+0xa0)
:| #  func                -942    0.586  xnintr_irq_handler+0xb (xnintr_clock_handler+0x18)
:| #  func                -941+   1.043  xnpod_announce_tick+0xb (xnintr_irq_handler+0x2a)
:| #  func                -940    0.788  xntimer_do_tick_aperiodic+0xe (xnpod_announce_tick+0xa1)
:| #  func                -939    0.614  xnthread_periodic_handler+0x8 (xntimer_do_tick_aperiodic+0x1f0)
:| #  func                -939    0.664  xnpod_resume_thread+0xc (xnthread_periodic_handler+0x1e)
:| #  [ 3718] -<?>-   99  -938+   3.966  xnpod_resume_thread+0x50 (xnthread_periodic_handler+0x1e)
:| #  func                -934    0.825  xnpod_schedule+0xe (xnintr_irq_handler+0xa5)
:| #  [ 3201] Xorg    -1  -933+   1.498  xnpod_schedule+0x8f (xnintr_irq_handler+0xa5)
:| #  func                -932+   2.260  __switch_to+0xc (xnpod_schedule+0x597)
:| #  [ 3718] -<?>-   99  -930+   1.108  xnpod_schedule+0x5e3 (xnpod_suspend_thread+0x16b)
:| #  func                -928    0.779  xntimer_get_raw_clock_aperiodic+0x8 (xnpod_wait_thread_period+0xa2)
:| #  func                -928    0.842  __ipipe_restore_pipeline_head+0xa (xnpod_wait_thread_period+0x11e)
:| +  end     0x80000000  -927    0.977  __ipipe_restore_pipeline_head+0x6d (xnpod_wait_thread_period+0x11e)
:| +  begin   0x80000001  -926+   1.704  __ipipe_dispatch_event+0x131 (__ipipe_syscall_root+0x32)
:| +  end     0x80000001  -924+   1.775  __ipipe_dispatch_event+0x10e (__ipipe_syscall_root+0x32)
:  +  func                -922    0.788  __ipipe_syscall_root+0xa (system_call+0x20)
:  +  func                -922    0.631  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x32)
:| +  begin   0x80000001  -921+   1.086  __ipipe_dispatch_event+0x152 (__ipipe_syscall_root+0x32)
:| +  end     0x80000001  -920    0.966  __ipipe_dispatch_event+0x141 (__ipipe_syscall_root+0x32)
:  +  func                -919    0.882  hisyscall_event+0xe (__ipipe_dispatch_event+0x86)
:  +  func                -918    0.634  __rt_task_wait_period+0xb (hisyscall_event+0x19e)
:  +  func                -917    0.758  rt_task_wait_period+0x8 (__rt_task_wait_period+0x1d)
:  +  func                -917    0.985  xnpod_wait_thread_period+0xe (rt_task_wait_period+0x3f)
:| +  begin   0x80000001  -916    0.867  xnpod_wait_thread_period+0x133 (rt_task_wait_period+0x3f)
:| #  func                -915    0.797  xntimer_get_raw_clock_aperiodic+0x8 (xnpod_wait_thread_period+0x56)
:| #  func                -914    0.880  xnpod_suspend_thread+0xc (xnpod_wait_thread_period+0x86)
:| #  func                -913    0.735  xnpod_schedule+0xe (xnpod_suspend_thread+0x16b)
:| #  [ 3718] -<?>-   99  -912+   1.543  xnpod_schedule+0x8f (xnpod_suspend_thread+0x16b)
:| #  func                -911+   1.327  __switch_to+0xc (xnpod_schedule+0x597)
:| #  [ 3201] Xorg    -1  -909+   1.833  xnpod_schedule+0x5e3 (xnintr_irq_handler+0xa5)
:|   +func                -908+   1.162  __ipipe_walk_pipeline+0xb (__ipipe_handle_irq+0x108)
:|   +end     0xffffff00  -906    0.807  common_interrupt+0x34 (<b795413b>)
:|   +func                -906    0.709  __ipipe_stall_root+0x8 (resume_userspace+0x5)
:    #func                -905    0.962  __ipipe_unstall_iret_root+0x9 (restore_raw+0x0)
:|   #begin   0x80000000  -904+   1.279  __ipipe_unstall_iret_root+0x6f (restore_raw+0x0)
:|   +end     0x8000000d  -903!  54.747  __ipipe_unstall_iret_root+0x2c (restore_raw+0x0)
:|   +begin   0xffffff00  -848    0.825  common_interrupt+0x21 (<0806f198>)
:|   +func                -847+   1.198  __ipipe_handle_irq+0xe (common_interrupt+0x29)
:|   +func                -846    0.917  __ipipe_ack_common_irq+0xb (__ipipe_handle_irq+0x1ea)
:|   +func                -845    0.973  ipipe_test_and_stall_pipeline_from+0x9 (__ipipe_ack_common_irq+0x18)
:|   #func                -844+   2.001  mask_and_ack_8259A+0xc (__ipipe_ack_common_irq+0x8a)
:|   +func                -842    0.868  __ipipe_dispatch_wired+0xb (__ipipe_handle_irq+0x18a)
:| #  func                -841+   1.026  xnintr_clock_handler+0x8 (__ipipe_dispatch_wired+0xa0)
:| #  func                -840+   1.460  xnintr_irq_handler+0xb (xnintr_clock_handler+0x18)
:| #  func                -839    0.691  xnpod_announce_tick+0xb (xnintr_irq_handler+0x2a)
:| #  func                -838    0.853  xntimer_do_tick_aperiodic+0xe (xnpod_announce_tick+0xa1)
:| #  func                -837    0.612  xnthread_periodic_handler+0x8 (xntimer_do_tick_aperiodic+0x1f0)
:| #  func                -837    0.705  xnpod_resume_thread+0xc (xnthread_periodic_handler+0x1e)
:| #  [ 3718] -<?>-   99  -836+   3.852  xnpod_resume_thread+0x50 (xnthread_periodic_handler+0x1e)
:| #  func                -832    0.947  xnpod_schedule+0xe (xnintr_irq_handler+0xa5)
:| #  [ 3201] Xorg    -1  -831+   2.091  xnpod_schedule+0x8f (xnintr_irq_handler+0xa5)
:| #  func                -829+   2.320  __switch_to+0xc (xnpod_schedule+0x597)
:| #  [ 3718] -<?>-   99  -827+   1.014  xnpod_schedule+0x5e3 (xnpod_suspend_thread+0x16b)
:| #  func                -826+   1.191  xntimer_get_raw_clock_aperiodic+0x8 (xnpod_wait_thread_period+0xa2)
:| #  func                -824    0.707  __ipipe_restore_pipeline_head+0xa (xnpod_wait_thread_period+0x11e)
:| +  end     0x80000000  -824    0.990  __ipipe_restore_pipeline_head+0x6d (xnpod_wait_thread_period+0x11e)
:| +  begin   0x80000001  -823    0.945  __ipipe_dispatch_event+0x131 (__ipipe_syscall_root+0x32)
:| +  end     0x80000001  -822+   1.852  __ipipe_dispatch_event+0x10e (__ipipe_syscall_root+0x32)
:  +  func                -820    0.749  __ipipe_syscall_root+0xa (system_call+0x20)
:  +  func                -819    0.822  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x32)
:| +  begin   0x80000001  -818    0.880  __ipipe_dispatch_event+0x152 (__ipipe_syscall_root+0x32)
:| +  end     0x80000001  -817    0.797  __ipipe_dispatch_event+0x141 (__ipipe_syscall_root+0x32)
:  +  func                -817    0.780  hisyscall_event+0xe (__ipipe_dispatch_event+0x86)
:  +  func                -816    0.698  __rt_task_wait_period+0xb (hisyscall_event+0x19e)
:  +  func                -815    0.616  rt_task_wait_period+0x8 (__rt_task_wait_period+0x1d)
:  +  func                -815    0.853  xnpod_wait_thread_period+0xe (rt_task_wait_period+0x3f)
:| +  begin   0x80000001  -814    0.996  xnpod_wait_thread_period+0x133 (rt_task_wait_period+0x3f)
:| #  func                -813    0.846  xntimer_get_raw_clock_aperiodic+0x8 (xnpod_wait_thread_period+0x56)
:| #  func                -812    0.747  xnpod_suspend_thread+0xc (xnpod_wait_thread_period+0x86)
:| #  func                -811+   2.380  xnpod_schedule+0xe (xnpod_suspend_thread+0x16b)
:| #  [ 3718] -<?>-   99  -809+   1.634  xnpod_schedule+0x8f (xnpod_suspend_thread+0x16b)
:| #  func                -807+   1.466  __switch_to+0xc (xnpod_schedule+0x597)
:| #  [ 3201] Xorg    -1  -806+   1.462  xnpod_schedule+0x5e3 (xnintr_irq_handler+0xa5)
:|   +func                -804+   1.370  __ipipe_walk_pipeline+0xb (__ipipe_handle_irq+0x108)
:|   +end     0xffffff00  -803    0.735  common_interrupt+0x34 (<0806f198>)
:|   +func                -802    0.910  __ipipe_stall_root+0x8 (resume_userspace+0x5)
:    #func                -801    0.685  __ipipe_unstall_iret_root+0x9 (restore_raw+0x0)
:|   #begin   0x80000000  -800+   1.314  __ipipe_unstall_iret_root+0x6f (restore_raw+0x0)
:|   +end     0x8000000d  -799! 727.050  __ipipe_unstall_iret_root+0x2c (restore_raw+0x0)
:|   +begin   0xffffff00   -72    0.848  common_interrupt+0x21 (<b7966c54>)
:|   +func                 -71    0.735  __ipipe_handle_irq+0xe (common_interrupt+0x29)
:|   +func                 -71    0.683  __ipipe_ack_common_irq+0xb (__ipipe_handle_irq+0x1ea)
:|   +func                 -70    0.734  ipipe_test_and_stall_pipeline_from+0x9 (__ipipe_ack_common_irq+0x18)
:|   #func                 -69+   2.037  mask_and_ack_8259A+0xc (__ipipe_ack_common_irq+0x8a)
:|   +func                 -67    0.670  __ipipe_dispatch_wired+0xb (__ipipe_handle_irq+0x18a)
:| #  func                 -66    0.799  xnintr_clock_handler+0x8 (__ipipe_dispatch_wired+0xa0)
:| #  func                 -66    0.679  xnintr_irq_handler+0xb (xnintr_clock_handler+0x18)
:| #  func                 -65    0.685  xnpod_announce_tick+0xb (xnintr_irq_handler+0x2a)
:| #  func                 -64    0.735  xntimer_do_tick_aperiodic+0xe (xnpod_announce_tick+0xa1)
:| #  func                 -64    0.698  xnthread_periodic_handler+0x8 (xntimer_do_tick_aperiodic+0x1f0)
:| #  func                 -63    0.670  xnpod_resume_thread+0xc (xnthread_periodic_handler+0x1e)
:| #  [ 3718] -<?>-   99   -62+   1.114  xnpod_resume_thread+0x50 (xnthread_periodic_handler+0x1e)
:| #  func                 -61    0.938  xnthread_periodic_handler+0x8 (xntimer_do_tick_aperiodic+0x1f0)
:| #  func                 -60+   1.009  xnthread_periodic_handler+0x8 (xntimer_do_tick_aperiodic+0x1f0)
:| #  func                 -59    0.895  xnthread_periodic_handler+0x8 (xntimer_do_tick_aperiodic+0x1f0)
:| #  func                 -58+   1.417  xnthread_periodic_handler+0x8 (xntimer_do_tick_aperiodic+0x1f0)
:| #  func                 -57+   1.209  xnthread_periodic_handler+0x8 (xntimer_do_tick_aperiodic+0x1f0)
:| #  func                 -56+   3.715  xnthread_periodic_handler+0x8 (xntimer_do_tick_aperiodic+0x1f0)
:| #  func                 -52    0.801  xnpod_schedule+0xe (xnintr_irq_handler+0xa5)
:| #  [ 3201] Xorg    -1   -51+   1.486  xnpod_schedule+0x8f (xnintr_irq_handler+0xa5)
:| #  func                 -50+   2.131  __switch_to+0xc (xnpod_schedule+0x597)
:| #  [ 3718] -<?>-   99   -47+   1.084  xnpod_schedule+0x5e3 (xnpod_suspend_thread+0x16b)
:| #  func                 -46    0.932  xntimer_get_raw_clock_aperiodic+0x8 (xnpod_wait_thread_period+0xa2)
:| #  func                 -45    0.823  __ipipe_restore_pipeline_head+0xa (xnpod_wait_thread_period+0x11e)
:| +  end     0x80000000   -45+   1.205  __ipipe_restore_pipeline_head+0x6d (xnpod_wait_thread_period+0x11e)
:| +  begin   0xffffff00   -43+   1.001  common_interrupt+0x21 (__ipipe_restore_pipeline_head+0x6f)
:| +  func                 -42+   1.131  __ipipe_handle_irq+0xe (common_interrupt+0x29)
:| +  func                 -41    0.569  __ipipe_ack_common_irq+0xb (__ipipe_handle_irq+0x1ea)
:| +  func                 -41    0.704  ipipe_test_and_stall_pipeline_from+0x9 (__ipipe_ack_common_irq+0x18)
:| #  func                 -40+   1.981  mask_and_ack_8259A+0xc (__ipipe_ack_common_irq+0x36)
:| +  func                 -38    0.713  __ipipe_dispatch_wired+0xb (__ipipe_handle_irq+0x18a)
:| #  func                 -37    0.644  xnintr_clock_handler+0x8 (__ipipe_dispatch_wired+0xa0)
:| #  func                 -37    0.797  xnintr_irq_handler+0xb (xnintr_clock_handler+0x18)
:| #  func                 -36+   1.013  xnpod_announce_tick+0xb (xnintr_irq_handler+0x2a)
:| #  func                 -35    0.816  xntimer_do_tick_aperiodic+0xe (xnpod_announce_tick+0xa1)
:| #  func                 -34+   3.535  xnthread_periodic_handler+0x8 (xntimer_do_tick_aperiodic+0x1f0)
:| #  func                 -30    0.580  rthal_irq_host_pend+0x8 (xnintr_irq_handler+0x75)
:| #  func                 -30+   1.204  __ipipe_schedule_irq+0xc (rthal_irq_host_pend+0x18)
:| +  func                 -29    0.646  __ipipe_walk_pipeline+0xb (__ipipe_handle_irq+0x108)
:| +  end     0xffffff00   -28+   1.243  common_interrupt+0x34 (__ipipe_restore_pipeline_head+0x6f)
:| +  begin   0x80000001   -27    0.971  __ipipe_dispatch_event+0x131 (__ipipe_syscall_root+0x32)
:| +  end     0x80000001   -26+   3.011  __ipipe_dispatch_event+0x10e (__ipipe_syscall_root+0x32)
:  +  func                 -23    0.702  __ipipe_syscall_root+0xa (system_call+0x20)
:  +  func                 -22    0.642  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x32)
:| +  begin   0x80000001   -21    0.880  __ipipe_dispatch_event+0x152 (__ipipe_syscall_root+0x32)
:| +  end     0x80000001   -21    0.775  __ipipe_dispatch_event+0x141 (__ipipe_syscall_root+0x32)
:  +  func                 -20+   1.513  hisyscall_event+0xe (__ipipe_dispatch_event+0x86)
:  +  func                 -18    0.792  __rt_timer_tsc2ns+0xc (hisyscall_event+0x19e)
:  +  func                 -17+   1.498  __copy_from_user_ll+0xa (__rt_timer_tsc2ns+0x1e)
:  +  func                 -16+   1.468  rt_timer_tsc2ns+0xe (__rt_timer_tsc2ns+0x2b)
:  +  func                 -15    0.923  __copy_to_user_ll+0xa (__rt_timer_tsc2ns+0x3f)
:| +  begin   0x80000001   -14    0.923  __ipipe_dispatch_event+0x131 (__ipipe_syscall_root+0x32)
:| +  end     0x80000001   -13+   1.264  __ipipe_dispatch_event+0x10e (__ipipe_syscall_root+0x32)
:  +  func                 -11    0.698  __ipipe_syscall_root+0xa (system_call+0x20)
:  +  func                 -11    0.627  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x32)
:| +  begin   0x80000001   -10    0.876  __ipipe_dispatch_event+0x152 (__ipipe_syscall_root+0x32)
:| +  end     0x80000001    -9    0.655  __ipipe_dispatch_event+0x141 (__ipipe_syscall_root+0x32)
:  +  func                  -9+   1.470  hisyscall_event+0xe (__ipipe_dispatch_event+0x86)
:  +  func                  -7+   1.853  xnshadow_sys_trace+0xb (hisyscall_event+0x19e)
:  +  func                  -5    0.619  ipipe_trace_frozen_reset+0xa (xnshadow_sys_trace+0xd7)
:  +  func                  -5    0.629  __ipipe_global_path_lock+0x9 (ipipe_trace_frozen_reset+0xf)
:| +  begin   0x80000001    -4+   3.421  __ipipe_global_path_lock+0x4c (ipipe_trace_frozen_reset+0xf)
:| +  end     0x80000001    -1+   1.065  __ipipe_global_path_unlock+0x52 (ipipe_trace_frozen_reset+0x63)
<  +  freeze  0x000b0a27     0    0.906  xnshadow_sys_trace+0xa1 (hisyscall_event+0x19e)
 | +  begin   0x80000001     0    0.689  __ipipe_dispatch_event+0x131 (__ipipe_syscall_root+0x32)
 | +  end     0x80000001     1    1.488  __ipipe_dispatch_event+0x10e (__ipipe_syscall_root+0x32)
   +  func                   3    0.713  __ipipe_syscall_root+0xa (system_call+0x20)
   +  func                   3    1.146  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x32)
 | +  begin   0x80000001     4    0.700  __ipipe_dispatch_event+0x152 (__ipipe_syscall_root+0x32)
 | +  end     0x80000001     5    0.814  __ipipe_dispatch_event+0x141 (__ipipe_syscall_root+0x32)
   +  func                   6    0.831  hisyscall_event+0xe (__ipipe_dispatch_event+0x86)
   +  func                   7    0.668  __rt_task_wait_period+0xb (hisyscall_event+0x19e)
   +  func                   7    0.616  rt_task_wait_period+0x8 (__rt_task_wait_period+0x1d)
   +  func                   8    0.000  xnpod_wait_thread_period+0xe (rt_task_wait_period+0x3f)
bids@domain.hid$  
--Boundary-00=_04OzEX4EvMEgJ20--

