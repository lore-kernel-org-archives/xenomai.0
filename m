Message-ID: <44CB6EB3.5070707@domain.hid>
Date: Sat, 29 Jul 2006 16:20:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>
	<200607221152.34298.bidsonux@domain.hid> <44C25DB0.50601@domain.hid>
	<200607282317.34990.bidsonux@domain.hid>
In-Reply-To: <200607282317.34990.bidsonux@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEF6510CE6EF1EB8DA25644A2"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Julien Heyman <bidsonux@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEF6510CE6EF1EB8DA25644A2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Julien Heyman wrote:
> Hi,
>=20
> here's a quick follow-up on my issue, thanks for your time !
>=20
> Julien Heyman
>=20
>=20
> On Saturday 22 July 2006 19:17, Jan Kiszka wrote:
>> Julien Heyman wrote:
>>> Hi,
>>>
>>> On Thursday 20 July 2006 23:58, Jan Kiszka wrote:
>>>> Julien Heyman wrote:
>>>>> Hi,
>>>>>
>>>>> I am currently trying to evaluate Xenomai, and my current setup is =
:
>>>>> VIA C3 533Mhz processor, Kubuntu 6.06 Linux distribution.
>>>>> I am using Xenomai-2.1.0 over a 2.6.17.4 kernel.
>>>> General advice: especially when starting new, try to pick the latest=

>>>> version, at least the latest from the preferred series (here 2.1.2).=
 But
>>>> 2.2 is even better. :)
>>> OK. Actually started with Xenomai-2.1.0 then switched to 2.1.1 to fix=
 a
>>> kernel build error. But anyway, I will start with a fresh install of =
2.2
>>> as soon as I have figured out the other points :)
>>>
>>>>> When I run the latency part of the testsuite (in a console under KD=
E),
>>>>> I get
>>>>> results that I cannot understand, so I probably did something wrong=

>>>>> (execution trace included below).
>>>>> I get reasonable values during the first seconds, then all of a sud=
den
>>>>> latencies begin to rise, continuously, to very large values.
>>>>> - I did check that DMA transfer is activated on my HD.
>>>>> - I did select "Enable SMI workaround" + "Globally disable SMI" in =
the
>>>>> Xenomai
>>>>> options while configuring the kernel.
>>>>> - I have disabled power management at BIOS level and disabled ACPI
>>>>> support and
>>>>> CPU frequency scaling during kernel configuration.
>>>>> - I checked that I don't have anything called "legacy USB" in my BI=
OS.
>>>>> I do have an "OnChip USB" option enable in the BIOS though.
>>>>>
>>>>> Any advice would be appreciated !
>>>> Maybe it's related to some other weird on-chip hardware. At work we =
run
>>>> Xenomai only on a head-less VIA C3 box, i.e. without X. No problems =
so
>>>> far. I would suggest to try stopping X and run the test from the tex=
t
>>>> mode.
>>> This is interesting : indeed when I switch to console mode (Ctrl+Atl+=
F1)
>>> and run the test, the latency values stay right on track.
>>> If I let the test run, switch to X, and switch back to the original
>>> console, the values have gone wild in the meantime.
>>> So there seems to be a strong link with X.
>>> What does that say about potential causes of my issue ?
>> Don't know. Might be a weird hardware design (wrt bus latencies) - or =
do
>> you=20
>> use any binary-only driver for X?=20
>=20
>=20
> I did not install any specific driver, I probably use the standard Trid=
ent=20
> driver that came with the Kubuntu distribution.
>=20
>=20
>>>> A further tool to analyse such effects in details is the I-pipe trac=
er.
>>>> It's an additional patch you have to apply to your kernel (see
>>>> http://download.gna.org/adeos/patches/v2.6/i386/tracer). Enable this=

>>>> I-pipe option, rebuild your kernel, and start the latency test with =
-f.
>>>> The test will then capture on every new worst-case delay a backtrace=
 to
>>>> /proc/ipipe/trace/frozen. You may want to play with the number of
>>>> back-trace points or the verbose mode (see /proc/ipipe/trace/*) even=

>>>> after the capturing.
>>> I had already used an adeos patch during my initial kernel-patching
>>> (adeos-ipipe-2.6.17-i386-1.3-07.patch)
>> The tracer is an additional patch on top of I-pipe, see link above.
>>
>>> I tried running the latency test using /usr/xenomai/bin/xeno-load lat=
ency
>>> -f but I get this error :
>>>
>>> =3D=3D Sampling period: 100 us
>>> =3D=3D Test mode: periodic user-mode task
>>> =3D=3D All results in microseconds
>>> latency: failed to open benchmark device, code -19
>>> (modprobe xeno_timerbench?)
>>>
>>> What am I doing wrong ?
>> For < 2.2: check if CONFIG_XENO_DRIVERS_TIMERBENCH is y or m. If it's =
a
>> module, follow the suggestion latency printed.
>>
>> In 2.2 the required tracing interface was moved to the nucleus, no nee=
d
>> for these steps then.
>=20
>=20
> Ok, I installed Xenomai 2.2 from scratch over a freshly extracted kerne=
l=20
> source tree, used the tracer patch ipipe-tracer-2.6.17-i386-1.3-08.patc=
h,=20
> rebuilt the kernel and relaunch the test : I still get increasing laten=
cies.
>=20
> I attach a copy of the latency test run, and the associated traces in=20
> files "max" and "frozen" from /proc/ipipe/trace
>=20
> I have no clue how to interpret theses traces, is there a documentation=
/user's=20
> guide available for the ipipe tracer ?

Nope, I skipped this "boring" part so far. But I will provide some
explanations below.

>=20
> Regarding Gilles' comments on this topic :=20
>=20
>> Losing too many ticks!
>> TSC cannot be used as a timesource. =C2=20
>> Possible reasons for this are:
>> =C2  You're running with Speedstep,
>> =C2  You don't have DMA enabled for your hard disk (see hdparm),
>> =C2  Incorrect TSC synchronization on an SMP system (see dmesg).
>> Falling back to a sane timesource now.
>=20
>> Do you see such message in kernel logs ?
>=20
> No, I don't get any of these.
>=20
>> If this is the issue you are having, then you may try passing idle=3Dp=
oll
>> on kernel boot line. Or recompile the kernel selecting a processor tha=
t
>> has no tsc (for example 486), xenomai will then use the 8254 counter t=
o
>> emulate the tsc.
>=20
> I tried to rebuild with CPU=3D486, but it gives the same result.
>=20
>> Jan
>>
>> ----------------------------------------------------------------------=
--
>>
>> bids@domain.hid$ sudo /usr/xenomai/bin/xen=
o-load latency -f
>> Password:
>> *
>> *
>> * Type ^C to stop this application.
>> *
>> *
>> =3D=3D Sampling period: 100 us
>> =3D=3D Test mode: periodic user-mode task
>> =3D=3D All results in microseconds
>> warming up...
>> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
>> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---la=
t worst
>> RTD|      21.428|      23.956|      38.249|       0|      21.428|     =
 38.249
>> RTD|      22.419|      24.491|      31.760|       0|      21.428|     =
 38.249
>> RTD|      21.833|      23.731|      52.247|       0|      21.428|     =
 52.247
>> RTD|      21.776|      23.733|      45.060|       0|      21.428|     =
 52.247
>> RTD|      21.467|      24.434|      40.813|       0|      21.428|     =
 52.247
>> RTD|      21.613|      24.684|      40.517|       0|      21.428|     =
 52.247
>> RTD|      21.585|      25.503|      51.990|       0|      21.428|     =
 52.247
>> RTD|      21.212|      25.497|      44.028|       0|      21.212|     =
 52.247
>> RTD|      21.587|      25.535|     119.516|       1|      21.212|     =
119.516
>> RTD|      21.604|      26.543|     225.722|       3|      21.212|     =
225.722
>> RTD|      21.958|      26.575|      48.329|       3|      21.212|     =
225.722
>> RTD|      22.247|      25.216|      57.580|       3|      21.212|     =
225.722
>> RTD|      22.253|      25.017|      53.521|       3|      21.212|     =
225.722
>> RTD|      22.376|      24.824|      54.095|       3|      21.212|     =
225.722
>> RTD|      22.256|      24.655|      55.816|       3|      21.212|     =
225.722
>> RTD|      22.324|      24.682|      48.350|       3|      21.212|     =
225.722
>> RTD|      21.454|      24.519|     342.492|       9|      21.212|     =
342.492
>> RTD|      21.578|      23.617|      49.107|       9|      21.212|     =
342.492
>> RTD|      21.621|      23.611|      38.444|       9|      21.212|     =
342.492
>> RTD|      21.625|      23.958|     192.672|      10|      21.212|     =
342.492
>> RTD|      21.656|      23.675|      34.820|      10|      21.212|     =
342.492
>> RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
>> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---la=
t worst
>> RTD|      21.688|      23.626|      36.496|      10|      21.212|     =
342.492
>> RTD|      21.527|      23.720|      49.283|      10|      21.212|     =
342.492
>> RTD|      21.643|      23.711|      43.028|      10|      21.212|     =
342.492
>> ---|------------|------------|------------|--------|------------------=
-------
>> RTS|      21.212|      24.562|     342.492|      10|    00:00:24/00:00=
:24
>>
>>
>> cat frozen :=20

This is the trace the latency application triggered on the maximum delay
(342.492 us). You should extend the back-trace period to cover at least
the observed latency (say up to -400 us). Try "echo 500 >
/proc/ipipe/trace/back_trace_points" for this. You can furthermore
switch on more verbosity with echo 1 > /proc/ipipe/trace/verbose".

>>
>> Freeze: 4770308881064 cycles, Trace Points: 30 (+10)
>>
>>  +--------------- Hard IRQs ('|': locked)
>>  |             +- Delay flag ('+': > 1 us, '!': > 10 us)
>>  |             |
>>   Type     Time   Function (Parent)
>> :|func      -35   xnpod_schedule (xnintr_irq_handler)
>> :|[ 3096]   -34+  xnpod_schedule (xnintr_irq_handler)

This traces the process (pid) being switched out.

>> :|func      -32+  __switch_to (xnpod_schedule)
>> :|[21768]   -30+  xnpod_schedule (xnpod_suspend_thread)

This pid gets switched in, the latency test (more precisely the sampling
thread).

>> :|func      -28   __ipipe_restore_pipeline_head (xnpod_wait_thread_per=
iod)
>> :|end       -28+  __ipipe_restore_pipeline_head (xnpod_wait_thread_per=
iod)
>> :|begin     -26   __ipipe_dispatch_event (__ipipe_syscall_root)
>> :|end       -25+  __ipipe_dispatch_event (__ipipe_syscall_root)
>> : func      -22   __ipipe_syscall_root (system_call)

This is roughly the point when the latency test takes its timestamp to
calculate the delay. This syscall here is then issued to convert TSCs
into nanoseconds.

>> : func      -21   __ipipe_dispatch_event (__ipipe_syscall_root)
>> :|begin     -21   __ipipe_dispatch_event (__ipipe_syscall_root)
>> :|end       -20   __ipipe_dispatch_event (__ipipe_syscall_root)
>> : func      -19+  hisyscall_event (__ipipe_dispatch_event)
>> : func      -18   __rt_timer_tsc2ns (hisyscall_event)
>> : func      -17   __copy_from_user_ll (__rt_timer_tsc2ns)
>> : func      -16+  rt_timer_tsc2ns (__rt_timer_tsc2ns)
>> : func      -15   __copy_to_user_ll (__rt_timer_tsc2ns)
>> :|begin     -14+  __ipipe_dispatch_event (__ipipe_syscall_root)
>> :|end       -13+  __ipipe_dispatch_event (__ipipe_syscall_root)
>> : func      -11   __ipipe_syscall_root (system_call)
>> : func      -11   __ipipe_dispatch_event (__ipipe_syscall_root)
>> :|begin     -10+  __ipipe_dispatch_event (__ipipe_syscall_root)
>> :|end        -9   __ipipe_dispatch_event (__ipipe_syscall_root)
>> : func       -8+  hisyscall_event (__ipipe_dispatch_event)
>> : func       -7+  xnshadow_sys_trace (hisyscall_event)
>> : func       -5   ipipe_trace_frozen_reset (xnshadow_sys_trace)
>> : func       -4   __ipipe_global_path_lock (ipipe_trace_frozen_reset)
>> :|begin      -3+  __ipipe_global_path_lock (ipipe_trace_frozen_reset)
>> :|end         0   __ipipe_global_path_unlock (ipipe_trace_frozen_reset=
)
>> < freeze      0   xnshadow_sys_trace (hisyscall_event)

And here we freeze after detecting a new worst-case (also issued as a
syscall).

>>  |begin       1   __ipipe_dispatch_event (__ipipe_syscall_root)
>>  |end         1   __ipipe_dispatch_event (__ipipe_syscall_root)
>>   func        3   __ipipe_syscall_root (system_call)
>>   func        3   __ipipe_dispatch_event (__ipipe_syscall_root)
>>  |begin       4   __ipipe_dispatch_event (__ipipe_syscall_root)
>>  |end         5   __ipipe_dispatch_event (__ipipe_syscall_root)
>>   func        5   hisyscall_event (__ipipe_dispatch_event)
>>   func        6   __rt_task_wait_period (hisyscall_event)
>>   func        7   rt_task_wait_period (__rt_task_wait_period)
>>   func        8   xnpod_wait_thread_period (rt_task_wait_period)
>>
>>
>> cat max :=20

This trace captured the maximum time the system spent in IRQs-off context=
=2E

>> Begin: 943575374801 cycles, Trace Points: 218 (-10/+1), Length: 376 us=


And that period took 376 us, a pathological result. It's a bit more than
what latency observed, but that's normal for a short test cycle.

>>
>>  +--------------- Hard IRQs ('|': locked)
>>  |             +- Delay flag ('+': > 1 us, '!': > 10 us)
>>  |             |
>>   Type     Time   Function (Parent)
>>  |func    -19650   xnpod_schedule (xnpod_suspend_thread)
>>  |[21559] -19649   xnpod_schedule (xnpod_suspend_thread)
>>  |func    -19647   __switch_to (xnpod_schedule)
>>  |[ 3096] -19646   xnpod_schedule (xnintr_irq_handler)
>>  |func    -19644   __ipipe_walk_pipeline (__ipipe_handle_irq)
>>  |end     -19643   common_interrupt (<b7a31ed5>)
>>  |func    -19643   __ipipe_stall_root (resume_userspace)
>>   func    -19642   __ipipe_unstall_iret_root (restore_raw)
>>  |begin   -19641   __ipipe_unstall_iret_root (restore_raw)
>>  |end     -19640   __ipipe_unstall_iret_root (restore_raw)
>>> |begin       0+  common_interrupt (<080c4fce>)

Here we start our critical region. The interesting thing is that there
are almost 20 ms(!) between the last kernel activity and the interrupt
entry. Likely a sign for hardware-related IRQ delays (unless some
privileged user-space program does dirty dancing with cli, i.e. hard IRQ
blocking).

>> :|func        1   __ipipe_handle_irq (common_interrupt)
>> :|func        1   __ipipe_ack_common_irq (__ipipe_handle_irq)
>> :|func        2   ipipe_test_and_stall_pipeline_from (__ipipe_ack_comm=
on_irq)
>> :|func        3+  mask_and_ack_8259A (__ipipe_ack_common_irq)
>> :|func        5   __ipipe_dispatch_wired (__ipipe_handle_irq)
>> :|func        6   xnintr_clock_handler (__ipipe_dispatch_wired)
>> :|func        6   xnintr_irq_handler (xnintr_clock_handler)
>> :|func        7   xnpod_announce_tick (xnintr_irq_handler)
>> :|func        8+  xntimer_do_tick_aperiodic (xnpod_announce_tick)
>> :|func        9   xnthread_periodic_handler (xntimer_do_tick_aperiodic=
)
>> :|func       10   xnpod_resume_thread (xnthread_periodic_handler)
>> :|[21559]    11+  xnpod_resume_thread (xnthread_periodic_handler)
>> :|func       13+  xnthread_periodic_handler (xntimer_do_tick_aperiodic=
)

=2E..

>> :|func      363+  xnthread_periodic_handler (xntimer_do_tick_aperiodic=
)

That are a lot of overruns. Haven't counted, but it should be one
xnthread_periodic_handler per missed 100 us period (20000 / 100 =3D 200!)=
=2E

[BTW, I think we should handle even this failure scenario without
looping. And there is another loop in xnpod_wait_thread_period.]

>> :|func      369+  xnpod_schedule (xnintr_irq_handler)
>> :|[ 3096]   370+  xnpod_schedule (xnintr_irq_handler)
>> :|func      372+  __switch_to (xnpod_schedule)
>> :|[21559]   374+  xnpod_schedule (xnpod_suspend_thread)
>> :|func      375   __ipipe_restore_pipeline_head (xnpod_wait_thread_per=
iod)
>> <|end       376   __ipipe_restore_pipeline_head (xnpod_wait_thread_per=
iod)
>>  |begin     377   __ipipe_dispatch_event (__ipipe_syscall_root)
>>

No final judgement yet, but it looks to me like your hardware doesn't
want to play with us.

To exclude the possibility that the timer events get programmed wrongly
as TSCs are skewed up, you could also try the irqbench test case. All
you need is a nullmodem cable and a second PC with RS232 port, see
doc/txt/irqbench.txt. And that test can also take back-traces.

Jan


--------------enigEF6510CE6EF1EB8DA25644A2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEy26zniDOoMHTA+kRAn3gAJ0Wa/CWm4NxpchMObM1hhDGzK3PSACfdZD0
J7hrxUpfdolqMSyczKUFsCI=
=jai/
-----END PGP SIGNATURE-----

--------------enigEF6510CE6EF1EB8DA25644A2--

