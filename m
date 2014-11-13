Date: Thu, 13 Nov 2014 15:44:34 +0100 (CET)
From: tbultel@free.fr
Message-ID: <374075126.116806222.1415889874529.JavaMail.root@zimbra90-e16.priv.proxad.net>
In-Reply-To: <20141111200358.GL17476@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 +
 adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: nicolas Mabire <nicolas.mabire@basystemes.fr>, xenomai@xenomai.org



----- Mail original -----
> De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> =C3=80: "Thierry Bultel" <tbultel@free.fr>
> Cc: xenomai@xenomai.org, "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca=
>, "nicolas Mabire"
> <nicolas.mabire@basystemes.fr>
> Envoy=C3=A9: Mardi 11 Novembre 2014 21:03:58
> Objet: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 + adeos-ipipe-3.0.43-mx6q-1.=
18-14 -> very slow boot
>=20
> On Tue, Nov 11, 2014 at 08:57:34PM +0100, Thierry Bultel wrote:
> > Le 10/11/2014 13:36, Gilles Chanteperdrix a =C3=A9crit :
> > >You can use printascii in the timer interrupt acknowledge routine
> > >to
> > >print a character every HZ ticks, this will give bad latency, but
> > >should work.
> > >
> >=20
> > For unknown reason, the kernel gets stuck after
> > "console [tty0] enabled, bootconsole disabled" if I use printascii
> > in do_local_timer().
> > earlyprintk seems broken as well.
>=20
> Without doing this, does earlyprintk work?
>=20
> > >If this is indeed the broadcast timer, it should never tick,
> > >because
> > >we should never switch to broadcast mode.
> >=20
> > I have found out why it was ticking.
> > This is due to tick_broadcast_switch_to_oneshot() in
> > kernel/time/tick-broadcast.c
> >=20
> > This sets the oneshot mode to the time, and leads to a call of
> > mxc_set_mode()
> >=20
> > In that function, there is that comment:
> > =09if (mode !=3D clockevent_mode) {
> > =09=09/* Set event time into far-far future */
> > =09=09if (timer_is_v2())
> >=20
> > ... and I estimate "far-far future" to be about 20 minutes.
> >=20
> > As a correction, I have made that change to
> > tick_broadcast_switch_to_oneshot():
> >=20
> > @@ -603,11 +610,21 @@ void tick_broadcast_setup_oneshot(struct
> > clock_event_device *bc)
> >  {
> >         int cpu =3D smp_processor_id();
> >=20
> > +#if defined(CONFIG_IPIPE) && defined(CONFIG_SMP)
> > +       printk(KERN_ALERT "%s cpu %d -> dev %s
> > IGNORED\n",__PRETTY_FUNCTION__, cpu, bc->name);
> > +       return;
> > +#endif
> >=20
> > ... and that makes the job, the iMX Timer is no longer armed.
> > What do you think about it ?
> >=20
> > Still currently stress-testing to see if things are getting better.
>=20
> I am afraid this should not change anything. This timer ticking is
> not a problem by itself, it is a problem if the twd gets disabled.
>=20

Unfortunately, you were right.
Even with that fix, we have 2 fail cases

I have added 4 leds to the GPIOs, and toggle them in do_local_timer, each 1=
00 ticks
for being human visible. I found it more convenient at keeps my console cle=
an.

1) on one machine, the freeze does not make a backtrace on the serial conso=
le
 a) in most cases, the leds do not blink, no more interrupts
 b) in one case, a single one kept blinking for a while before stopping

I first thought about graphics hardware acceleration because with it the di=
splay gets corrupted,
but even without it, the freeze happens the same way.=20

2) on another machine, I am getting this backtrace. The local timers keep t=
icking.

Since it was hard to reproduce with IPIPE_DEBUG, it was unfortunately disab=
led for that run.
Attempting again with IPIPE_DEBUG enabled.

SGT_AGV2 login: Internal error: Oops - undefined instruction: 0 [#1] PREEMP=
T SMP
Modules linked in:
CPU: 2    Not tainted  (3.0.43_4.1.0 #8)
PC is at flush_tlb_page+0x20/0xe8
LR is at ptep_set_access_flags+0x4c/0x8c
pc : [<80057da8>]    lr : [<8019a748>]    psr: 20000113
sp : ba989d90  ip : 00000800  fp : 00000002
r10: 00000000  r9 : 00000000  r8 : ba882380
r7 : 8bf5104c  r6 : ba97d108  r5 : ba97d108  r4 : 00000001
r3 : 2aae0000  r2 : 00000001  r1 : 2aae0000  r0 : ba97d108
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: 4a06004a  DAC: 00000015
Process watch (pid: 3904, stack limit =3D 0xba9882f0)
Stack: (0xba989d90 to 0xba98a000)
9d80:                                     00000000 00000000 00000000 000000=
00
9da0: 00000001 2aae0000 ba97d108 8019a748 4f6b075f ba882380 00000001 ba97d1=
08
9dc0: 2aae0000 8018d828 00000001 ba988000 ba989e54 80083a50 8004c094 ba5a7b=
a0
9de0: 00000000 00000000 00000002 bffb4000 800494c8 4f6b07df ba882380 ba97d1=
08
9e00: ba060aa8 2aae0000 8bf5104c ba5a7ba0 00000002 8018f598 ba060aa8 8bf510=
4c
9e20: 4f6b07df bffb4000 00000002 800ae980 00000000 ba060000 00000155 2aae00=
00
9e40: ba97d108 00000001 ba060aa8 ba5a7ba0 00000002 8018f8b8 ba060aa8 000000=
01
9e60: ba989fb0 2aae0000 0000081f ba5a7ba0 bac1ae80 ba97d108 ba5a7bdc 8005d6=
4c
9e80: 80046204 80049b80 ba989e9c 00000001 e96703c8 0000037d 8c01c4f8 806680=
00
9ea0: 8c01c4f8 800ad3d0 00000001 00000000 00000001 ba988000 ba989ecc 800827=
54
9ec0: ba989f38 00000000 ba989f98 80668000 8c01c4f8 800ace68 00000001 000000=
00
9ee0: 00000000 0000040f 0000000f 0000081f ba989fb0 80c8ba88 0006b08e 2aae00=
00
9f00: 2aad54c0 8004b4e0 3b9b8d50 00000000 00000001 00000000 ba988000 0000c3=
50
9f20: 7e9977a4 800adcf4 0000c350 00000000 3b9b8d50 00000000 ba989f39 8c01c5=
a8
9f40: 00000000 00000000 e967c718 0000037d e96703c8 0000037d 800ac958 8c01c4=
f8
9f60: 00000000 00000000 00000000 8009da50 00000000 7e9977a4 00000000 000100=
00
9f80: 000000a2 800517a8 ba988000 00000000 00000000 0000040f 0000000f 000000=
00
9fa0: 0006b094 00000000 0005767b 80051544 2aae0000 0006b092 00000006 1b485b=
1b
9fc0: 00000006 2ac39a90 00000000 0006b094 00000000 0006b08e 0005767b 2aad54=
c0
9fe0: 2aae0000 7e9973b8 2abb98f9 2abbd158 00000010 ffffffff 00000000 000000=
00
[<80057da8>] (flush_tlb_page+0x20/0xe8) from [<8019a748>] (ptep_set_access_=
flags+0x4c                                                             /0x8=
c)
[<8019a748>] (ptep_set_access_flags+0x4c/0x8c) from [<8018d828>] (do_wp_pag=
e+0x2a4/0x                                                             728)
[<8018d828>] (do_wp_page+0x2a4/0x728) from [<8018f598>] (handle_pte_fault+0=
x1bc/0x410                                                             )
[<8018f598>] (handle_pte_fault+0x1bc/0x410) from [<8018f8b8>] (handle_mm_fa=
ult+0xcc/0                                                             x11c=
)
[<8018f8b8>] (handle_mm_fault+0xcc/0x11c) from [<8005d64c>] (do_page_fault+=
0x26c/0x3e                                                             4)
[<8005d64c>] (do_page_fault+0x26c/0x3e4) from [<8004b4e0>] (do_DataAbort+0x=
34/0x17c)
[<8004b4e0>] (do_DataAbort+0x34/0x17c) from [<80051544>] (ret_from_exceptio=
n+0x0/0x40                                                             )
Exception stack(0xba989fb0 to 0xba989ff8)
9fa0:                                     2aae0000 0006b092 00000006 1b485b=
1b
9fc0: 00000006 2ac39a90 00000000 0006b094 00000000 0006b08e 0005767b 2aad54=
c0
9fe0: 2aae0000 7e9973b8 2abb98f9 2abbd158 00000010 ffffffff
Code: e5922000 e24dd010 e3520000 0a00000c (ee102ff1)
---[ end trace 1a38ad1feb34b78d ]---
note: watch[3904] exited with preempt_count 1
BUG: scheduling while atomic: watch/3904/0x40000002
Modules linked in:
[<8005876c>] (unwind_backtrace+0x0/0xf8) from [<80665ce8>] (__schedule+0x61=
0/0x894)
[<80665ce8>] (__schedule+0x610/0x894) from [<80084200>] (__cond_resched+0x1=
4/0x20)
[<80084200>] (__cond_resched+0x14/0x20) from [<8066600c>] (_cond_resched+0x=
3c/0x44)
[<8066600c>] (_cond_resched+0x3c/0x44) from [<8018e8d8>] (unmap_vmas+0x520/=
0x68c)
[<8018e8d8>] (unmap_vmas+0x520/0x68c) from [<80193dec>] (exit_mmap+0x108/0x=
248)
[<80193dec>] (exit_mmap+0x108/0x248) from [<800888b8>] (mmput+0x48/0x160)
[<800888b8>] (mmput+0x48/0x160) from [<8008ce08>] (exit_mm+0x128/0x168)
[<8008ce08>] (exit_mm+0x128/0x168) from [<8008e3f0>] (do_exit+0x130/0x7a0)
[<8008e3f0>] (do_exit+0x130/0x7a0) from [<80054fc4>] (die+0x218/0x28c)
[<80054fc4>] (die+0x218/0x28c) from [<8004b120>] (do_undefinstr+0x11c/0x154=
)
[<8004b120>] (do_undefinstr+0x11c/0x154) from [<800510c0>] (__und_svc+0x60/=
0x80)
Exception stack(0xba989d48 to 0xba989d90)
9d40:                   ba97d108 2aae0000 00000001 2aae0000 00000001 ba97d1=
08
9d60: ba97d108 8bf5104c ba882380 00000000 00000000 00000002 00000800 ba989d=
90
9d80: 8019a748 80057da8 20000113 ffffffff
[<800510c0>] (__und_svc+0x60/0x80) from [<80057da8>] (flush_tlb_page+0x20/0=
xe8)
[<80057da8>] (flush_tlb_page+0x20/0xe8) from [<8019a748>] (ptep_set_access_=
flags+0x4c                                                             /0x8=
c)
[<8019a748>] (ptep_set_access_flags+0x4c/0x8c) from [<8018d828>] (do_wp_pag=
e+0x2a4/0x                                                             728)
[<8018d828>] (do_wp_page+0x2a4/0x728) from [<8018f598>] (handle_pte_fault+0=
x1bc/0x410                                                             )
[<8018f598>] (handle_pte_fault+0x1bc/0x410) from [<8018f8b8>] (handle_mm_fa=
ult+0xcc/0                                                             x11c=
)
[<8018f8b8>] (handle_mm_fault+0xcc/0x11c) from [<8005d64c>] (do_page_fault+=
0x26c/0x3e                                                             4)
[<8005d64c>] (do_page_fault+0x26c/0x3e4) from [<8004b4e0>] (do_DataAbort+0x=
34/0x17c)
[<8004b4e0>] (do_DataAbort+0x34/0x17c) from [<80051544>] (ret_from_exceptio=
n+0x0/0x40                                                             )
Exception stack(0xba989fb0 to 0xba989ff8)
9fa0:                                     2aae0000 0006b092 00000006 1b485b=
1b
9fc0: 00000006 2ac39a90 00000000 0006b094 00000000 0006b08e 0005767b 2aad54=
c0
9fe0: 2aae0000 7e9973b8 2abb98f9 2abbd158 00000010 ffffffff


> Note that we discovered in another thread that CONFIG_TRACE_IRQFLAGS
> should not be enabled. So, if it is enabled, you should disable it.
>=20

It is disabled, yes.

> Also, are you running with all I-pipe and Xenomai debugs?
>=20
> --
> =09=09=09=09=09    Gilles.
>=20

