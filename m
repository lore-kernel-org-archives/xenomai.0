MIME-Version: 1.0
References: <25f3e78c-c294-1322-4206-204dfaa48b8a@rsi-elektrotechnik.de>
In-Reply-To: <25f3e78c-c294-1322-4206-204dfaa48b8a@rsi-elektrotechnik.de>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 2 Jul 2020 08:07:05 -0400
Message-ID: <CALLqZ8SW=nD8gp52C_1--Kgvcfi6k72iXVRjgmqRve=Nj=ysPQ@mail.gmail.com>
Subject: Re: ARM: switchtest fails
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Leupold <leupold@rsi-elektrotechnik.de>
Cc: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On Thu., Jul. 2, 2020, 6:16 a.m. Jan Leupold via Xenomai <
xenomai@xenomai.org> wrote:

> Hi,
>
> I have a problem with switchtest, executed on sama5d2,
> ipipe-4.19.128-cip28, xenomai-3.1.
>
> When started without arguments:
> =3D=3D Testing FPU check routines...
> d0: 1 !=3D 2
> ... snip ...
> d15: 1 !=3D 2
> =3D=3D FPU check routines: OK.
> =3D=3D Threads: sleeper_ufps-0 rtk-1 rtk-2 rtk_fp-3 rtk_fp-4 rtk_fp_ufpp-=
5
> rtk_fp_ufpp-6 rtup-7 rtup-8 rtup_ufpp-9 rtup_ufpp-10 rtus-11 rtus-12
> rtus_ufps-13 rtus_ufps-14 rtuo-15 rtuo-16 rtuo_ufpp-17 rtuo_ufpp-18
> rtuo_ufps-19 rtuo_ufps-20 rtuo_ufpp_ufps-21 rtuo_ufpp_ufps-22
> RTT|  00:00:00
> RTH|ctx switches|-------total
> RTD|          25|          25
>
> no more output, exit status =3D 1
>
> When started as "switchtest -n":
>
> =3D=3D Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-7 =
rtuo-8
> RTT|  00:00:01
> RTH|ctx switches|-------total
> RTD|        4295|        4295
> RTD|        4316|        8611
> RTD|        4279|       12890
> RTD|        4316|       17206
> RTD|        4313|       21519
> ^C
> RTD|        1215|       22734
>
> deliberately terminated by CTRL-C, exit status =3D 0
>
> Any threadspec of rtus_ufps, rtup_ufpp or rtuo_ufpp will cause the effect=
.
> When looking at the source code I would suspect "fp_regs_set()" to cause
> it.
> The kernel log reports messages like this one:
> [Xenomai] rtup_ufpp-1[1599] called regular ioctl() on /dev/rtdm/switchtes=
t
>
> While I have no reason to think that floating point operations are not
> OK on this target I would like to at least know why switchtest fails
> when using floating point:
> * VFP initialization with respect to register access?
> * Number of floating point registers? (although NEON should have more tha=
n
>   the tested 16)
> * Any ideas?
>
> Regards,
> Jan
>
> Some more details:
>
> CONFIG_VFP, CONFIG_VFPv3 and CONFIG_NEON are set.
>
> trace-cmd record -e cobalt* -e sched* -e signal*
> switchtest
> trace-cmd report
> ---> output (at least the portion that seems to me relevant):
>
> ... switchtest threads are doing their work, and then comes rtup-ufpp-9 .=
..
>      rtup-8-1538  [000]   135.112086: cobalt_switch_context:
> prev_name=3Drtup-8 prev_pid=3D1538 prev_prio=3D1 prev_state=3D0x48042 =3D=
=3D>
> next_name=3Drtup_ufpp-9 next_pid=3D1539 next_prio=3D1
>      rtup_ufpp-9-1539  [000]   135.112129: cobalt_head_sysexit:  result=
=3D0
>      rtup_ufpp-9-1539  [000]   135.112154: cobalt_head_sysentry:
> syscall=3Dioctl
>      rtup_ufpp-9-1539  [000]   135.112170: cobalt_fd_ioctl:
> device=3D0xc0b7a988 fd=3D3 arg=3D0x9 pid=3D1539 comm=3Drtup_ufpp-9
>      rtup_ufpp-9-1539  [000]   135.112192: cobalt_fd_ioctl_status:
> device=3D0xc0b7a988 fd=3D3 pid=3D1539 comm=3Drtup_ufpp-9
>      rtup_ufpp-9-1539  [000]   135.112207: cobalt_shadow_gorelax:
> reason=3Dsyscall
>      rtup_ufpp-9-1539  [000]   135.112221: cobalt_lostage_request:
> request=3Dc090b004 pid=3D1539 comm=3Drtup_ufpp-9
>      rtup_ufpp-9-1539  [000]   135.112240: cobalt_thread_suspend: pid=3D1=
539
> mask=3D0x80 timeout=3D0 timeout_mode=3D0 wchan=3D(nil)
>      rtup_ufpp-9-1539  [000]   135.112254: cobalt_schedule:
> status=3D0x10000000
>      rtup_ufpp-9-1539  [000]   135.112262: cobalt_switch_context:
> prev_name=3Drtup_ufpp-9 prev_pid=3D1539 prev_prio=3D1 prev_state=3D0x480c=
0 =3D=3D>
> next_name=3DROOT next_pid=3D0 next_prio=3D-1
>       switchtest-1530  [000]   135.112308: cobalt_lostage_wakeup: pid=3D1=
539
> comm=3Drtup_ufpp-9
>       switchtest-1530  [000]   135.112329: sched_waking:
> comm=3Drtup_ufpp-9 pid=3D1539 prio=3D98 target_cpu=3D000
>       switchtest-1530  [000]   135.112380: sched_wakeup:
> rtup_ufpp-9:1539 [98] success=3D1 CPU:000
>       switchtest-1530  [000]   135.112450: sched_stat_runtime:
> comm=3Dswitchtest pid=3D1530 runtime=3D3009028 [ns] vruntime=3D2256390495=
6 [ns]
>       switchtest-1530  [000]   135.112489: sched_switch:
> switchtest:1530 [120] R =3D=3D> rtup_ufpp-9:1539 [98]
>      rtup_ufpp-9-1539  [000]   135.112561: cobalt_shadow_relaxed:
> state=3D0x480c0 info=3D0x0
>      rtup_ufpp-9-1539  [000]   135.112581: cobalt_fd_ioctl:
> device=3D0xc0b7a988 fd=3D3 arg=3D0x9 pid=3D1539 comm=3Drtup_ufpp-9
>      rtup_ufpp-9-1539  [000]   135.112602: cobalt_fd_ioctl_status:
> device=3D0xc0b7a988 fd=3D3 pid=3D1539 comm=3Drtup_ufpp-9
>      rtup_ufpp-9-1539  [000]   135.112614: cobalt_head_sysexit:  result=
=3D-38
>      rtup_ufpp-9-1539  [000]   135.112997: sched_waking:
> comm=3Dswitchtest pid=3D1527 prio=3D120 target_cpu=3D000
>      rtup_ufpp-9-1539  [000]   135.113036: sched_wakeup:
> switchtest:1527 [120] success=3D1 CPU:000
>      rtup_ufpp-9-1539  [000]   135.113055: signal_generate:      sig=3D15
> errno=3D0 code=3D-6 comm=3Dswitchtest pid=3D1527 grp=3D0 res=3D0
>      rtup_ufpp-9-1539  [000]   135.113204: sched_switch:
> rtup_ufpp-9:1539 [98] S =3D=3D> switchtest:1527 [120]
>       switchtest-1527  [000]   135.113621: sched_waking:
> comm=3Dswitchtest pid=3D1530 prio=3D120 target_cpu=3D000
>       switchtest-1527  [000]   135.113656: sched_stat_runtime:
> comm=3Dswitchtest pid=3D1527 runtime=3D492337 [ns] vruntime=3D22561734482=
 [ns]
>       switchtest-1527  [000]   135.113684: sched_wakeup:
> switchtest:1530 [120] success=3D1 CPU:000
>       switchtest-1527  [000]   135.113697: signal_generate:      sig=3D32
> errno=3D0 code=3D-6 comm=3Dswitchtest pid=3D1530 grp=3D0 res=3D0
>       switchtest-1527  [000]   135.113805: cobalt_thread_unblock: pid=3D1=
537
> state=3D0x48042 info=3D0x0
>       switchtest-1527  [000]   135.113820: cobalt_thread_resume:
> name=3Drtup-7 pid=3D1537 mask=3D0x2
>       switchtest-1527  [000]   135.113837: cobalt_synch_forget:
> synch=3D0xd92e00e0
>       switchtest-1527  [000]   135.113872: cobalt_schedule_remote:
> status=3D0x10000000
>       switchtest-1527  [000]   135.113880: cobalt_schedule:
> status=3D0x10000000
>       switchtest-1527  [000]   135.113893: cobalt_switch_context:
> prev_name=3DROOT prev_pid=3D0 prev_prio=3D-1 prev_state=3D0x18008 =3D=3D>
> next_name=3Drtup-7 next_pid=3D1537 next_prio=3D1
>           rtup-7-1537  [000]   135.113948: cobalt_fd_ioctl_status:
> device=3D0xc0b7a988 fd=3D3 pid=3D1537 comm=3Drtup-7
>           rtup-7-1537  [000]   135.113972: cobalt_shadow_gorelax:
> reason=3Dsignal
>           rtup-7-1537  [000]   135.113985: cobalt_lostage_request:
> request=3Dc090b004 pid=3D1537 comm=3Drtup-7
>           rtup-7-1537  [000]   135.113999: cobalt_thread_suspend: pid=3D1=
537
> mask=3D0x80 timeout=3D0 timeout_mode=3D0 wchan=3D(nil)
>           rtup-7-1537  [000]   135.114013: cobalt_schedule:
> status=3D0x10000000
>           rtup-7-1537  [000]   135.114021: cobalt_switch_context:
> prev_name=3Drtup-7 prev_pid=3D1537 prev_prio=3D1 prev_state=3D0x480c0 =3D=
=3D>
> next_name=3DROOT next_pid=3D0 next_prio=3D-1
>
>
> Mit freundlichen Gr=C3=BC=C3=9Fen
>
> *Jan Leupold*
> Entwicklung
> Development
> --
>
I can take a look and see if I can reproduce on another arm platform. I'm
not too familiar with this test but I'll run it and see if there's anything
unusual on the ipipe side of things.

-Greg


---------------------------------------------------------------------------
> R-S-I Logo <https://www.rsi-elektrotechnik.de/>
>
> R-S-I Elektrotechnik GmbH & Co. KG
> Woelkestra=C3=9Fe 11
> D-85301 Schweitenkirchen
> www.rsi-elektrotechnik.de <https://www.rsi-elektrotechnik.de/>
>
> Tel: +49 8444 9204-32
> Fax: +49 8444 9204-50
> leupold@rsi-elektrotechnik.de <mailto:leupold@rsi-elektrotechnik.de>
> -------------------------------------------------------------------------=
--
>
> Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
> Gesch=C3=A4ftsf=C3=BChrer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
> USt-IdNr.: DE 128592548
>
>
>
>
