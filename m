Message-ID: <45DEC477.2070901@domain.hid>
Date: Fri, 23 Feb 2007 11:39:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <45DEBF20.2060907@domain.hid>
In-Reply-To: <45DEBF20.2060907@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: Quoted-Printable
Subject: [Xenomai-core] Re: soft lockup detected on AT91RM9200
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Scholz <steven.scholz@domain.hid>
Cc: Xenomai-core@domain.hid

Steven Scholz wrote:
> Hi Gilles,
>=20
> I am running xenomai (svn 22.02.2007) with adeos-ipipe-2.6.19-arm-1.6-0=
2.patch
> on our AT91RM9200 board. (# CONFIG_PREEMPT is not set)
>=20
> When starting latency with 100=B5s period I get
>=20
> ~ # latency
> =3D=3D Sampling period: 100 us
> =3D=3D Test mode: periodic user-mode task
> =3D=3D All results in microseconds
> warming up...
> BUG: soft lockup detected on CPU#0!
> [<c001dce8>] (dump_stack+0x0/0x14) from [<c004ce50>] (softlockup_tick+0=
x98/0xb8)
> [<c004cdb8>] (softlockup_tick+0x0/0xb8) from [<c0037cf8>] (run_local_ti=
mers+0x18/0x1c) r7 =3D 00000011  r6 =3D 00000000  r5 =3D 00000000  r4 =3D=
 C02F8940
> [<c0037ce0>] (run_local_timers+0x0/0x1c) from [<c0037d40>] (update_proc=
ess_times+0x44/0x6c)[<c0037cfc>] (update_process_times+0x0/0x6c) from [<c=
001db4c>] (timer_tick+0xf8/0x120) r5 =3D C01F9DE0  r4 =3D C01F0660
> [<c001da54>] (timer_tick+0x0/0x120) from [<c0023a8c>] (at91rm9200_timer=
_interrupt+0x34/0xf8) r5 =3D C01F9DE0  r4 =3D C01F0660
> [<c0023a58>] (at91rm9200_timer_interrupt+0x0/0xf8) from [<c004d320>] (h=
andle_IRQ_event+0x38/0x6c) r5 =3D 00000000  r4 =3D C01AD8F0
> [<c004d2e8>] (handle_IRQ_event+0x0/0x6c) from [<c004e5e8>] (handle_leve=
l_irq+0x74/0xcc) r7 =3D 00000011  r6 =3D C01AF2C0  r5 =3D 00000011  r4 =3D=
 C01A8440
> [<c004e574>] (handle_level_irq+0x0/0xcc) from [<c001a6c0>] (asm_do_IRQ+=
0x48/0x60) r5 =3D 00000000  r4 =3D C0213930
> [<c001a678>] (asm_do_IRQ+0x0/0x60) from [<c004f2c0>] (__ipipe_sync_stag=
e+0x208/0x290) r5 =3D 00000000  r4 =3D C01AF2C8
> [<c004f0b8>] (__ipipe_sync_stage+0x0/0x290) from [<c004f86c>] (__ipipe_=
walk_pipeline+0xa4/0xc8)
> [<c004f7c8>] (__ipipe_walk_pipeline+0x0/0xc8) from [<c001f004>] (__ipip=
e_handle_irq+0x18c/0x19c) r7 =3D 00000011  r6 =3D C01FC2C0  r5 =3D 000000=
11  r4 =3D FFFFFFFF
> [<c001ee78>] (__ipipe_handle_irq+0x0/0x19c) from [<c001f140>] (__ipipe_=
grab_irq+0xbc/0x120)
> [<c001f084>] (__ipipe_grab_irq+0x0/0x120) from [<c00199a4>] (__irq_svc+=
0x24/0x4c)
> [<c004f578>] (__ipipe_unstall_root+0x0/0x4c) from [<c004f5e4>] (__ipipe=
_restore_root+0x20/0x24)
> [<c004f5c4>] (__ipipe_restore_root+0x0/0x24) from [<c0045a20>] (hrtimer=
_try_to_cancel+0x6c/0x74)
> [<c00459b4>] (hrtimer_try_to_cancel+0x0/0x74) from [<c0045a40>] (hrtime=
r_cancel+0x18/0x24) r7 =3D 00000000  r6 =3D 00000001  r5 =3D C1D82000  r4=
 =3D C1D83F3C
> [<c0045a28>] (hrtimer_cancel+0x0/0x24) from [<c0179b08>] (do_nanosleep+=
0x50/0x80) r4 =3D C1D83F3C
> [<c0179ab8>] (do_nanosleep+0x0/0x80) from [<c0045d6c>] (hrtimer_nanosle=
ep+0x4c/0x16c) r6 =3D 00000001  r5 =3D C1D83F3C  r4 =3D 00000000
> [<c0045d20>] (hrtimer_nanosleep+0x0/0x16c) from [<c0045f28>] (sys_nanos=
leep+0x9c/0xb0)[<c0045e8c>] (sys_nanosleep+0x0/0xb0) from [<c0019d84>] (r=
et_fast_syscall+0x0/0x10) r6 =3D 00000000  r5 =3D BEAB9D5E  r4 =3D 000000=
00
>=20
>=20
> This text is printed very slowly onto teh serial console. Also the time=
r leds blinks very slowly.
> I'd say 10 times slower.
>=20
> Ideas? How can I help with debugging this?

100us is too small, as I already told you here:

https://mail.gna.org/public/xenomai-core/2007-02/msg00019.html

The latency process spend 100% of its time handling the timer ticks, and
the kernel detects a soft lockup.

The difference between I-pipe patch 1.6-01 and 1.6-02 is that the return
=66rom exception is correctly handled. Maybe it is what allows the kernel
to print a clean message. Maybe it is because you now have enabled the
soft lockup detector whereas you previously did not.

--=20
                                                 Gilles Chanteperdrix

