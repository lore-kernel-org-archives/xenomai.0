Message-ID: <45DEBF20.2060907@domain.hid>
Date: Fri, 23 Feb 2007 11:17:04 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] soft lockup detected on AT91RM9200
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Hi Gilles,

I am running xenomai (svn 22.02.2007) with adeos-ipipe-2.6.19-arm-1.6-02.=
patch
on our AT91RM9200 board. (# CONFIG_PREEMPT is not set)

When starting latency with 100=B5s period I get

~ # latency
=3D=3D Sampling period: 100 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
BUG: soft lockup detected on CPU#0!
[<c001dce8>] (dump_stack+0x0/0x14) from [<c004ce50>] (softlockup_tick+0x9=
8/0xb8)
[<c004cdb8>] (softlockup_tick+0x0/0xb8) from [<c0037cf8>] (run_local_time=
rs+0x18/0x1c) r7 =3D 00000011  r6 =3D 00000000  r5 =3D 00000000  r4 =3D C=
02F8940
[<c0037ce0>] (run_local_timers+0x0/0x1c) from [<c0037d40>] (update_proces=
s_times+0x44/0x6c)[<c0037cfc>] (update_process_times+0x0/0x6c) from [<c00=
1db4c>] (timer_tick+0xf8/0x120) r5 =3D C01F9DE0  r4 =3D C01F0660
[<c001da54>] (timer_tick+0x0/0x120) from [<c0023a8c>] (at91rm9200_timer_i=
nterrupt+0x34/0xf8) r5 =3D C01F9DE0  r4 =3D C01F0660
[<c0023a58>] (at91rm9200_timer_interrupt+0x0/0xf8) from [<c004d320>] (han=
dle_IRQ_event+0x38/0x6c) r5 =3D 00000000  r4 =3D C01AD8F0
[<c004d2e8>] (handle_IRQ_event+0x0/0x6c) from [<c004e5e8>] (handle_level_=
irq+0x74/0xcc) r7 =3D 00000011  r6 =3D C01AF2C0  r5 =3D 00000011  r4 =3D =
C01A8440
[<c004e574>] (handle_level_irq+0x0/0xcc) from [<c001a6c0>] (asm_do_IRQ+0x=
48/0x60) r5 =3D 00000000  r4 =3D C0213930
[<c001a678>] (asm_do_IRQ+0x0/0x60) from [<c004f2c0>] (__ipipe_sync_stage+=
0x208/0x290) r5 =3D 00000000  r4 =3D C01AF2C8
[<c004f0b8>] (__ipipe_sync_stage+0x0/0x290) from [<c004f86c>] (__ipipe_wa=
lk_pipeline+0xa4/0xc8)
[<c004f7c8>] (__ipipe_walk_pipeline+0x0/0xc8) from [<c001f004>] (__ipipe_=
handle_irq+0x18c/0x19c) r7 =3D 00000011  r6 =3D C01FC2C0  r5 =3D 00000011=
  r4 =3D FFFFFFFF
[<c001ee78>] (__ipipe_handle_irq+0x0/0x19c) from [<c001f140>] (__ipipe_gr=
ab_irq+0xbc/0x120)
[<c001f084>] (__ipipe_grab_irq+0x0/0x120) from [<c00199a4>] (__irq_svc+0x=
24/0x4c)
[<c004f578>] (__ipipe_unstall_root+0x0/0x4c) from [<c004f5e4>] (__ipipe_r=
estore_root+0x20/0x24)
[<c004f5c4>] (__ipipe_restore_root+0x0/0x24) from [<c0045a20>] (hrtimer_t=
ry_to_cancel+0x6c/0x74)
[<c00459b4>] (hrtimer_try_to_cancel+0x0/0x74) from [<c0045a40>] (hrtimer_=
cancel+0x18/0x24) r7 =3D 00000000  r6 =3D 00000001  r5 =3D C1D82000  r4 =3D=
 C1D83F3C
[<c0045a28>] (hrtimer_cancel+0x0/0x24) from [<c0179b08>] (do_nanosleep+0x=
50/0x80) r4 =3D C1D83F3C
[<c0179ab8>] (do_nanosleep+0x0/0x80) from [<c0045d6c>] (hrtimer_nanosleep=
+0x4c/0x16c) r6 =3D 00000001  r5 =3D C1D83F3C  r4 =3D 00000000
[<c0045d20>] (hrtimer_nanosleep+0x0/0x16c) from [<c0045f28>] (sys_nanosle=
ep+0x9c/0xb0)[<c0045e8c>] (sys_nanosleep+0x0/0xb0) from [<c0019d84>] (ret=
_fast_syscall+0x0/0x10) r6 =3D 00000000  r5 =3D BEAB9D5E  r4 =3D 00000000


This text is printed very slowly onto teh serial console. Also the timer =
leds blinks very slowly.
I'd say 10 times slower.

Ideas? How can I help with debugging this?

--=20
Steven

