Date: Fri, 14 Nov 2014 11:15:00 +0100 (CET)
From: tbultel@free.fr
Message-ID: <37845582.117817940.1415960100507.JavaMail.root@zimbra90-e16.priv.proxad.net>
In-Reply-To: <20141113145115.GD4656@sisyphus.hd.free.fr>
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
> =C3=80: tbultel@free.fr
> Cc: xenomai@xenomai.org, "nicolas Mabire" <nicolas.mabire@basystemes.fr>
> Envoy=C3=A9: Jeudi 13 Novembre 2014 15:51:15
> Objet: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 + adeos-ipipe-3.0.43-mx6q-1.=
18-14 -> very slow boot
>=20
> On Thu, Nov 13, 2014 at 03:44:34PM +0100, tbultel@free.fr wrote:
> >=20
> >=20
> > ----- Mail original -----
> > > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> > > =C3=80: "Thierry Bultel" <tbultel@free.fr>
> > > Cc: xenomai@xenomai.org, "Lennart Sorensen"
> > > <lsorense@csclub.uwaterloo.ca>, "nicolas Mabire"
> > > <nicolas.mabire@basystemes.fr>
> > > Envoy=C3=A9: Mardi 11 Novembre 2014 21:03:58
> > > Objet: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 +
> > > adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
> > >=20
> > > On Tue, Nov 11, 2014 at 08:57:34PM +0100, Thierry Bultel wrote:
> > > > Le 10/11/2014 13:36, Gilles Chanteperdrix a =C3=A9crit :
> > > > >You can use printascii in the timer interrupt acknowledge
> > > > >routine
> > > > >to
> > > > >print a character every HZ ticks, this will give bad latency,
> > > > >but
> > > > >should work.
> > > > >
> > > >=20
> > > > For unknown reason, the kernel gets stuck after
> > > > "console [tty0] enabled, bootconsole disabled" if I use
> > > > printascii
> > > > in do_local_timer().
> > > > earlyprintk seems broken as well.
> > >=20
> > > Without doing this, does earlyprintk work?
> > >=20
> > > > >If this is indeed the broadcast timer, it should never tick,
> > > > >because
> > > > >we should never switch to broadcast mode.
> > > >=20
> > > > I have found out why it was ticking.
> > > > This is due to tick_broadcast_switch_to_oneshot() in
> > > > kernel/time/tick-broadcast.c
> > > >=20
> > > > This sets the oneshot mode to the time, and leads to a call of
> > > > mxc_set_mode()
> > > >=20
> > > > In that function, there is that comment:
> > > > =09if (mode !=3D clockevent_mode) {
> > > > =09=09/* Set event time into far-far future */
> > > > =09=09if (timer_is_v2())
> > > >=20
> > > > ... and I estimate "far-far future" to be about 20 minutes.
> > > >=20
> > > > As a correction, I have made that change to
> > > > tick_broadcast_switch_to_oneshot():
> > > >=20
> > > > @@ -603,11 +610,21 @@ void tick_broadcast_setup_oneshot(struct
> > > > clock_event_device *bc)
> > > >  {
> > > >         int cpu =3D smp_processor_id();
> > > >=20
> > > > +#if defined(CONFIG_IPIPE) && defined(CONFIG_SMP)
> > > > +       printk(KERN_ALERT "%s cpu %d -> dev %s
> > > > IGNORED\n",__PRETTY_FUNCTION__, cpu, bc->name);
> > > > +       return;
> > > > +#endif
> > > >=20
> > > > ... and that makes the job, the iMX Timer is no longer armed.
> > > > What do you think about it ?
> > > >=20
> > > > Still currently stress-testing to see if things are getting
> > > > better.
> > >=20
> > > I am afraid this should not change anything. This timer ticking
> > > is
> > > not a problem by itself, it is a problem if the twd gets
> > > disabled.
> > >=20
> >=20
> > Unfortunately, you were right.
> > Even with that fix, we have 2 fail cases
> >=20
> > I have added 4 leds to the GPIOs, and toggle them in
> > do_local_timer, each 100 ticks
> > for being human visible. I found it more convenient at keeps my
> > console clean.
> >=20
> > 1) on one machine, the freeze does not make a backtrace on the
> > serial console
> >  a) in most cases, the leds do not blink, no more interrupts
> >  b) in one case, a single one kept blinking for a while before
> >  stopping
>=20
>=20
> do_local_timer is a bit to high level, try putting it in
> twd_timer_ack. Also, try setting the Linux timer to periodic
> (disable HIGHRES_TIMERS), this should make Xenomai timer tick
> periodically, not matter what happens on linux side.
>=20
>=20
> >=20
> > I first thought about graphics hardware acceleration because with
> > it the display gets corrupted,
> > but even without it, the freeze happens the same way.
> >=20
> > 2) on another machine, I am getting this backtrace. The local
> > timers keep ticking.
> >=20
> > Since it was hard to reproduce with IPIPE_DEBUG, it was
> > unfortunately disabled for that run.
> > Attempting again with IPIPE_DEBUG enabled.
> >=20
> > SGT_AGV2 login: Internal error: Oops - undefined instruction: 0
> > [#1] PREEMPT SMP
> > Modules linked in:
> > CPU: 2    Not tainted  (3.0.43_4.1.0 #8)
> > PC is at flush_tlb_page+0x20/0xe8
> > LR is at ptep_set_access_flags+0x4c/0x8c
> > pc : [<80057da8>]    lr : [<8019a748>]    psr: 20000113
> > sp : ba989d90  ip : 00000800  fp : 00000002
> > r10: 00000000  r9 : 00000000  r8 : ba882380
> > r7 : 8bf5104c  r6 : ba97d108  r5 : ba97d108  r4 : 00000001
> > r3 : 2aae0000  r2 : 00000001  r1 : 2aae0000  r0 : ba97d108
> > Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> > Control: 10c53c7d  Table: 4a06004a  DAC: 00000015
> > Process watch (pid: 3904, stack limit =3D 0xba9882f0)
> > Stack: (0xba989d90 to 0xba98a000)
> > 9d80:                                     00000000 00000000
> > 00000000 00000000
> > 9da0: 00000001 2aae0000 ba97d108 8019a748 4f6b075f ba882380
> > 00000001 ba97d108
> > 9dc0: 2aae0000 8018d828 00000001 ba988000 ba989e54 80083a50
> > 8004c094 ba5a7ba0
> > 9de0: 00000000 00000000 00000002 bffb4000 800494c8 4f6b07df
> > ba882380 ba97d108
> > 9e00: ba060aa8 2aae0000 8bf5104c ba5a7ba0 00000002 8018f598
> > ba060aa8 8bf5104c
> > 9e20: 4f6b07df bffb4000 00000002 800ae980 00000000 ba060000
> > 00000155 2aae0000
> > 9e40: ba97d108 00000001 ba060aa8 ba5a7ba0 00000002 8018f8b8
> > ba060aa8 00000001
> > 9e60: ba989fb0 2aae0000 0000081f ba5a7ba0 bac1ae80 ba97d108
> > ba5a7bdc 8005d64c
> > 9e80: 80046204 80049b80 ba989e9c 00000001 e96703c8 0000037d
> > 8c01c4f8 80668000
> > 9ea0: 8c01c4f8 800ad3d0 00000001 00000000 00000001 ba988000
> > ba989ecc 80082754
> > 9ec0: ba989f38 00000000 ba989f98 80668000 8c01c4f8 800ace68
> > 00000001 00000000
> > 9ee0: 00000000 0000040f 0000000f 0000081f ba989fb0 80c8ba88
> > 0006b08e 2aae0000
> > 9f00: 2aad54c0 8004b4e0 3b9b8d50 00000000 00000001 00000000
> > ba988000 0000c350
> > 9f20: 7e9977a4 800adcf4 0000c350 00000000 3b9b8d50 00000000
> > ba989f39 8c01c5a8
> > 9f40: 00000000 00000000 e967c718 0000037d e96703c8 0000037d
> > 800ac958 8c01c4f8
> > 9f60: 00000000 00000000 00000000 8009da50 00000000 7e9977a4
> > 00000000 00010000
> > 9f80: 000000a2 800517a8 ba988000 00000000 00000000 0000040f
> > 0000000f 00000000
> > 9fa0: 0006b094 00000000 0005767b 80051544 2aae0000 0006b092
> > 00000006 1b485b1b
> > 9fc0: 00000006 2ac39a90 00000000 0006b094 00000000 0006b08e
> > 0005767b 2aad54c0
> > 9fe0: 2aae0000 7e9973b8 2abb98f9 2abbd158 00000010 ffffffff
> > 00000000 00000000
> > [<80057da8>] (flush_tlb_page+0x20/0xe8) from [<8019a748>]
> > (ptep_set_access_flags+0x4c
> >                                                             /0x8c)
> > [<8019a748>] (ptep_set_access_flags+0x4c/0x8c) from [<8018d828>]
> > (do_wp_page+0x2a4/0x
> >                                                             728)
> > [<8018d828>] (do_wp_page+0x2a4/0x728) from [<8018f598>]
> > (handle_pte_fault+0x1bc/0x410
> >                                                             )
> > [<8018f598>] (handle_pte_fault+0x1bc/0x410) from [<8018f8b8>]
> > (handle_mm_fault+0xcc/0
> >                                                             x11c)
> > [<8018f8b8>] (handle_mm_fault+0xcc/0x11c) from [<8005d64c>]
> > (do_page_fault+0x26c/0x3e
> >                                                             4)
> > [<8005d64c>] (do_page_fault+0x26c/0x3e4) from [<8004b4e0>]
> > (do_DataAbort+0x34/0x17c)
> > [<8004b4e0>] (do_DataAbort+0x34/0x17c) from [<80051544>]
> > (ret_from_exception+0x0/0x40
> >                                                             )
> > Exception stack(0xba989fb0 to 0xba989ff8)
> > 9fa0:                                     2aae0000 0006b092
> > 00000006 1b485b1b
> > 9fc0: 00000006 2ac39a90 00000000 0006b094 00000000 0006b08e
> > 0005767b 2aad54c0
> > 9fe0: 2aae0000 7e9973b8 2abb98f9 2abbd158 00000010 ffffffff
> > Code: e5922000 e24dd010 e3520000 0a00000c (ee102ff1)
> > ---[ end trace 1a38ad1feb34b78d ]---
>=20
> Do you have unlocked context switch enabled? If yes, turn it off.
>=20
> Also, if enabling all debugs do not work, try only enabling the
> I-pipe tracer, define sufficient back trace points (1000), and try
> and get a trace when the problem happens.
>=20
> You should try and debug the issue for which you have a trace of
> course, but I do not see how it could be related to the other
> issues.
>=20

Gilles, it has taken time (about 3 hours), but I finally got
a backtrace with IPIPE_DEBUG: (I have disabled CONFIG_IPIPE_TRACE_VMALLOC)

Before the trace went to the serial console, I saw that there were no more =
timer irq
on 2 CPUs (my ssh session froze). Some 3 or 4 seconds later it came up.
Not clear to me why there are only 100 points, because I have CONFIG_IPIPE_=
TRACE_SHIFT=3D14

[root@SGT_AGV2 ~]#
[root@SGT_AGV2 ~]# Unable to handle kernel paging request at virtual addres=
s 0c2d3000
pgd =3D 80004000
[0c2d3000] *pgd=3D00000000
Internal error: Oops: 5 [#1] PREEMPT SMP
Modules linked in:
CPU: 2    Not tainted  (3.0.43_4.1.0 #10)
PC is at timekeeping_resume+0x98/0x120
LR is at __timekeeping_inject_sleeptime+0xb0/0xe0
pc : [<802407fc>]    lr : [<8023f990>]    psr: 600f0013
sp : bffb5e58  ip : 00000000  fp : bffb5ea4
r10: 80ee80e0  r9 : 00f6f581  r8 : 80ee80e0
r7 : 8c31c560  r6 : 00000000  r5 : 0c2d3000  r4 : 80f59af0
r3 : 02d5c6da  r2 : 87e00000  r1 : 3b9aca00  r0 : 0c2d3000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 499b404a  DAC: 00000015
Process swapper (pid: 0, stack limit =3D 0xbffb42f0)
Stack: (0xbffb5e58 to 0xbffb6000)
5e40:                                                       80f58380 000000=
01
5e60: 00000000 8c31c4c0 8c31c598 bffb5ed8 8020bf38 80262728 0c2d3000 000000=
00
5e80: 0c2d3000 00000000 80f58380 00000001 00000000 8c31c4c0 bffb5f14 bffb5e=
a8
5ea0: 8023afb0 802417bc 80f58380 8c31c598 00000000 00000000 bffb5ed4 bffb5e=
c8
5ec0: 80267ee8 80266e94 8c31c560 bffb5ed8 80269cd0 80267ec0 b1f34262 365a31=
98
5ee0: 801d5000 80269cb4 00000002 80049040 0c2d3000 00000000 80f58380 000000=
01
5f00: 00000000 00000000 bffb5f2c bffb5f18 801db9b8 8023af40 80efc100 801ccb=
24
5f20: bffb5f4c bffb5f30 801ce5ec 801db988 80f5c380 80efc100 80f5c380 80f5c7=
80
5f40: bffb5f5c bffb5f50 801dbe48 801ce588 bffb5f9c bffb5f60 802640d0 801dbe=
1c
5f60: 80267ee8 80266e94 80049800 80049808 80269cd0 8c31c808 80f4e6e4 80efbb=
10
5f80: 8088cfc4 80eff42c 412fc09a 00000000 bffb5fb4 bffb5fa0 801d5c44 80263f=
40
5fa0: bffb4000 80f4e6e4 bffb5fdc bffb5fb8 801d5e90 801d5ba8 00000002 80f13b=
30
5fc0: 00000002 10c03c7d 80f4e898 1000406a bffb5ff4 bffb5fe0 8087e59c 801d5d=
e8
5fe0: 4ffb806a 00000015 00000000 bffb5ff8 1087ded4 8087e478 00000000 000000=
00
[<802407fc>] (timekeeping_resume+0x98/0x120) from [<8023afb0>] (hrtimer_int=
errupt+0x7c/0x2cc)
[<8023afb0>] (hrtimer_interrupt+0x7c/0x2cc) from [<801db9b8>] (ipi_timer+0x=
3c/0x40)
[<801db9b8>] (ipi_timer+0x3c/0x40) from [<801ce5ec>] (do_local_timer+0x70/0=
x9c)
[<801ce5ec>] (do_local_timer+0x70/0x9c) from [<801dbe48>] (__ipipe_root_loc=
altimer+0x38/0x3c)
Exception stack(0xbffb5f50 to 0xbffb5f98)
5f40:                                     bffb5f9c bffb5f60 802640d0 801dbe=
1c
5f60: 80267ee8 80266e94 80049800 80049808 80269cd0 8c31c808 80f4e6e4 80efbb=
10
5f80: 8088cfc4 80eff42c 412fc09a 00000000 bffb5fb4 bffb5fa0
[<801dbe48>] (__ipipe_root_localtimer+0x38/0x3c) from [<802640d0>] (__ipipe=
_sync_stage+0x19c/0x330)
[<802640d0>] (__ipipe_sync_stage+0x19c/0x330) from [<801d5c44>] (default_id=
le+0xa8/0xc0)
[<801d5c44>] (default_idle+0xa8/0xc0) from [<801d5e90>] (cpu_idle+0xb4/0x11=
c)
[<801d5e90>] (cpu_idle+0xb4/0x11c) from [<8087e59c>] (secondary_start_kerne=
l+0x130/0x154)
[<8087e59c>] (secondary_start_kernel+0x130/0x154) from [<1087ded4>] (0x1087=
ded4)
Code: e50b302c e51b3020 e50b3028 ebfffc38 (e5956000)
I-pipe tracer log (100 points):
     #func                    0 ipipe_trace_panic_freeze+0x10 (oops_enter+0=
x1c)
     #func                   -1 oops_enter+0x10 (die+0x30)
     #func                   -1 die+0x14 (__do_kernel_fault.part.3+0x64)
     #func                   -3 ipipe_check_context+0x14 (sub_preempt_count=
+0x20)
     #func                   -3 sub_preempt_count+0x10 (vprintk+0x21c)
     #func                   -4 __ipipe_stall_root+0x10 (__ipipe_restore_ro=
ot+0x34)
     #func                   -5 ipipe_check_context+0x14 (__ipipe_restore_r=
oot+0x20)
     #func                   -5 __ipipe_restore_root+0x10 (vprintk+0x214)
     #func                   -6 ipipe_check_context+0x14 (sub_preempt_count=
+0x20)
     #func                   -6 sub_preempt_count+0x10 (wake_up_klogd+0x50)
     #func                   -7 ipipe_check_context+0x14 (add_preempt_count=
+0x20)
     #func                   -8 add_preempt_count+0x10 (wake_up_klogd+0x30)
     #func                   -8 wake_up_klogd+0x10 (console_unlock+0x194)
     #func                   -9 ipipe_check_context+0x14 (sub_preempt_count=
+0x20)
     #func                   -9 sub_preempt_count+0x10 (_raw_spin_unlock_ir=
qrestore+0x38)
     #func                  -10 __ipipe_stall_root+0x10 (__ipipe_restore_ro=
ot+0x34)
     #func                  -11 ipipe_check_context+0x14 (__ipipe_restore_r=
oot+0x20)
     #func                  -11 __ipipe_restore_root+0x10 (_raw_spin_unlock=
_irqrestore+0x30)
     #func                  -12 _raw_spin_unlock_irqrestore+0x10 (console_u=
nlock+0x188)
     #func                  -12 __ipipe_spin_unlock_debug+0x10 (console_unl=
ock+0x17c)
     #func                  -13 ipipe_check_context+0x14 (sub_preempt_count=
+0x20)
     #func                  -13 sub_preempt_count+0x10 (_raw_spin_unlock_ir=
qrestore+0x38)
     #func                  -14 __ipipe_stall_root+0x10 (__ipipe_restore_ro=
ot+0x34)
     #func                  -15 ipipe_check_context+0x14 (__ipipe_restore_r=
oot+0x20)
     #func                  -15 __ipipe_restore_root+0x10 (_raw_spin_unlock=
_irqrestore+0x30)
     #func                  -16 _raw_spin_unlock_irqrestore+0x10 (up+0x50)
     #func                  -16 __ipipe_spin_unlock_debug+0x10 (up+0x44)
     #func                  -17 ipipe_check_context+0x14 (add_preempt_count=
+0x20)
     #func                  -17 add_preempt_count+0x10 (_raw_spin_lock_irqs=
ave+0x28)
     #func                  -18 __ipipe_test_and_stall_root+0x10 (_raw_spin=
_lock_irqsave+0x1c)
     #func                  -19 _raw_spin_lock_irqsave+0x10 (up+0x1c)
     #func                  -19 up+0x10 (console_unlock+0x174)
     #func                  -20 ipipe_check_context+0x14 (add_preempt_count=
+0x20)
     #func                  -20 add_preempt_count+0x10 (_raw_spin_lock_irqs=
ave+0x28)
     #func                  -21 __ipipe_test_and_stall_root+0x10 (_raw_spin=
_lock_irqsave+0x1c)
     #func                  -22 _raw_spin_lock_irqsave+0x10 (console_unlock=
+0x54)
     #func                  -22 __ipipe_stall_root+0x10 (__ipipe_restore_ro=
ot+0x34)
     #func                  -23 ipipe_check_context+0x14 (__ipipe_restore_r=
oot+0x20)
     #func                  -23 __ipipe_restore_root+0x10 (console_unlock+0=
x48)
     #func                  -24 _call_console_drivers+0x10 (console_unlock+=
0x40)
     #func                  -24 __ipipe_stall_root+0x10 (__ipipe_restore_ro=
ot+0x34)
     #func                  -25 ipipe_check_context+0x14 (__ipipe_restore_r=
oot+0x20)
     #func                  -26 __ipipe_restore_root+0x10 (imx_console_writ=
e+0x154)
     #func                  -27 ipipe_check_context+0x14 (sub_preempt_count=
+0x20)
     #func                  -27 sub_preempt_count+0x10 (_raw_spin_unlock+0x=
30)
     #func                  -28 _raw_spin_unlock+0x10 (imx_console_write+0x=
178)
 |   #func                  -28 __ipipe_spin_unlock_irqrestore+0x10 (l2x0_c=
ache_sync+0x3c)
     #func                  -29 __ipipe_spin_lock_irqsave+0x10 (l2x0_cache_=
sync+0x24)
     #func                  -29 l2x0_cache_sync+0x10 (imx_console_write+0x1=
34)
 |   #func                  -30 __ipipe_spin_unlock_irqrestore+0x10 (l2x0_c=
ache_sync+0x3c)
     #func                  -31 __ipipe_spin_lock_irqsave+0x10 (l2x0_cache_=
sync+0x24)
     #func                  -31 l2x0_cache_sync+0x10 (imx_console_write+0x1=
18)
 |   #func                  -32 __ipipe_spin_unlock_irqrestore+0x10 (l2x0_c=
ache_sync+0x3c)
     #func                  -32 __ipipe_spin_lock_irqsave+0x10 (l2x0_cache_=
sync+0x24)
     #func                  -33 l2x0_cache_sync+0x10 (imx_console_write+0xf=
c)
 |   #func                 -212 __ipipe_spin_unlock_irqrestore+0x10 (l2x0_c=
ache_sync+0x3c)
     #func                 -213 __ipipe_spin_lock_irqsave+0x10 (l2x0_cache_=
sync+0x24)
     #func                 -213 l2x0_cache_sync+0x10 (imx_console_putchar+0=
x4c)
     #func                 -214 imx_console_putchar+0x10 (uart_console_writ=
e+0x64)
 |   #func                 -215 __ipipe_spin_unlock_irqrestore+0x10 (l2x0_c=
ache_sync+0x3c)
     #func                 -215 __ipipe_spin_lock_irqsave+0x10 (l2x0_cache_=
sync+0x24)
     #func                 -216 l2x0_cache_sync+0x10 (imx_console_putchar+0=
x4c)
     #func                 -217 imx_console_putchar+0x10 (uart_console_writ=
e+0x58)
     #func                 -217 uart_console_write+0x10 (imx_console_write+=
0xd4)
 |   #func                 -218 __ipipe_spin_unlock_irqrestore+0x10 (l2x0_c=
ache_sync+0x3c)
     #func                 -219 __ipipe_spin_lock_irqsave+0x10 (l2x0_cache_=
sync+0x24)
     #func                 -219 l2x0_cache_sync+0x10 (imx_console_write+0xb=
4)
 |   #func                 -220 __ipipe_spin_unlock_irqrestore+0x10 (l2x0_c=
ache_sync+0x3c)
     #func                 -220 __ipipe_spin_lock_irqsave+0x10 (l2x0_cache_=
sync+0x24)
     #func                 -221 l2x0_cache_sync+0x10 (imx_console_write+0x9=
4)
     #func                 -222 ipipe_check_context+0x14 (add_preempt_count=
+0x20)
     #func                 -223 add_preempt_count+0x10 (_raw_spin_lock+0x20=
)
     #func                 -224 _raw_spin_lock+0x10 (imx_console_write+0x16=
c)
     #func                 -224 __ipipe_test_and_stall_root+0x10 (imx_conso=
le_write+0x30)
     #func                 -225 imx_console_write+0x14 (__call_console_driv=
ers+0xdc)
     #func                 -225 __call_console_drivers+0x10 (_call_console_=
drivers+0x70)
     #func                 -226 _call_console_drivers+0x10 (console_unlock+=
0xf8)
     #func                 -227 ipipe_check_context+0x14 (sub_preempt_count=
+0x20)
     #func                 -227 sub_preempt_count+0x10 (_raw_spin_unlock+0x=
30)
     #func                 -228 _raw_spin_unlock+0x10 (console_unlock+0x84)
     #func                 -228 ipipe_check_context+0x14 (add_preempt_count=
+0x20)
     #func                 -229 add_preempt_count+0x10 (_raw_spin_lock_irqs=
ave+0x28)
     #func                 -230 __ipipe_test_and_stall_root+0x10 (_raw_spin=
_lock_irqsave+0x1c)
     #func                 -230 _raw_spin_lock_irqsave+0x10 (console_unlock=
+0x54)
     #func                 -231 console_unlock+0x10 (vprintk+0x208)
     #func                 -231 ipipe_check_context+0x14 (sub_preempt_count=
+0x20)
     #func                 -232 sub_preempt_count+0x10 (_raw_spin_unlock+0x=
30)
     #func                 -232 _raw_spin_unlock+0x10 (vprintk+0x204)
     #func                 -233 ipipe_check_context+0x14 (sub_preempt_count=
+0x20)
     #func                 -234 sub_preempt_count+0x10 (_raw_spin_unlock_ir=
qrestore+0x38)
     #func                 -234 __ipipe_stall_root+0x10 (__ipipe_restore_ro=
ot+0x34)
     #func                 -235 ipipe_check_context+0x14 (__ipipe_restore_r=
oot+0x20)
     #func                 -236 __ipipe_restore_root+0x10 (_raw_spin_unlock=
_irqrestore+0x30)
     #func                 -236 _raw_spin_unlock_irqrestore+0x10 (down_tryl=
ock+0x40)
     #func                 -237 __ipipe_spin_unlock_debug+0x10 (down_tryloc=
k+0x34)
     #func                 -237 ipipe_check_context+0x14 (add_preempt_count=
+0x20)
     #func                 -238 add_preempt_count+0x10 (_raw_spin_lock_irqs=
ave+0x28)
     #func                 -239 __ipipe_test_and_stall_root+0x10 (_raw_spin=
_lock_irqsave+0x1c)
     #func                 -239 _raw_spin_lock_irqsave+0x10 (down_trylock+0=
x1c)
     #func                 -240 down_trylock+0x10 (console_trylock+0x1c)
---[ end trace 01c68765b125b83c ]---
Kernel panic - not syncing: Fatal exception in interrupt
[<801dd1d8>] (unwind_backtrace+0x0/0x104) from [<80881184>] (dump_stack+0x2=
0/0x24)
[<80881184>] (dump_stack+0x20/0x24) from [<80882028>] (panic+0x74/0x190)
[<80882028>] (panic+0x74/0x190) from [<801d90a8>] (die+0x248/0x2b8)
[<801d90a8>] (die+0x248/0x2b8) from [<808811ec>] (__do_kernel_fault.part.3+=
0x64/0x84)
[<808811ec>] (__do_kernel_fault.part.3+0x64/0x84) from [<801e2db4>] (do_pag=
e_fault+0x240/0x4b8)
[<801e2db4>] (do_page_fault+0x240/0x4b8) from [<801e3200>] (do_translation_=
fault+0x144/0x254)
[<801e3200>] (do_translation_fault+0x144/0x254) from [<801ce29c>] (do_DataA=
bort+0x44/0x260)
[<801ce29c>] (do_DataAbort+0x44/0x260) from [<801d4750>] (__dabt_svc+0x70/0=
xa0)
Exception stack(0xbffb5e10 to 0xbffb5e58)
5e00:                                     0c2d3000 3b9aca00 87e00000 02d5c6=
da
5e20: 80f59af0 0c2d3000 00000000 8c31c560 80ee80e0 00f6f581 80ee80e0 bffb5e=
a4
5e40: 00000000 bffb5e58 8023f990 802407fc 600f0013 ffffffff
[<801d4750>] (__dabt_svc+0x70/0xa0) from [<802407fc>] (timekeeping_resume+0=
x98/0x120)
[<802407fc>] (timekeeping_resume+0x98/0x120) from [<8023afb0>] (hrtimer_int=
errupt+0x7c/0x2cc)
[<8023afb0>] (hrtimer_interrupt+0x7c/0x2cc) from [<801db9b8>] (ipi_timer+0x=
3c/0x40)
[<801db9b8>] (ipi_timer+0x3c/0x40) from [<801ce5ec>] (do_local_timer+0x70/0=
x9c)
[<801ce5ec>] (do_local_timer+0x70/0x9c) from [<801dbe48>] (__ipipe_root_loc=
altimer+0x38/0x3c)
Exception stack(0xbffb5f50 to 0xbffb5f98)
5f40:                                     bffb5f9c bffb5f60 802640d0 801dbe=
1c
5f60: 80267ee8 80266e94 80049800 80049808 80269cd0 8c31c808 80f4e6e4 80efbb=
10
5f80: 8088cfc4 80eff42c 412fc09a 00000000 bffb5fb4 bffb5fa0
[<801dbe48>] (__ipipe_root_localtimer+0x38/0x3c) from [<802640d0>] (__ipipe=
_sync_stage+0x19c/0x330)
[<802640d0>] (__ipipe_sync_stage+0x19c/0x330) from [<801d5c44>] (default_id=
le+0xa8/0xc0)
[<801d5c44>] (default_idle+0xa8/0xc0) from [<801d5e90>] (cpu_idle+0xb4/0x11=
c)
[<801d5e90>] (cpu_idle+0xb4/0x11c) from [<8087e59c>] (secondary_start_kerne=
l+0x130/0x154)
[<8087e59c>] (secondary_start_kernel+0x130/0x154) from [<1087ded4>] (0x1087=
ded4)
CPU1: stopping
[<801dd1d8>] (unwind_backtrace+0x0/0x104) from [<80881184>] (dump_stack+0x2=
0/0x24)
[<80881184>] (dump_stack+0x20/0x24) from [<801ce754>] (do_IPI+0x13c/0x164)
[<801ce754>] (do_IPI+0x13c/0x164) from [<801dbe84>] (__ipipe_root_ipi+0x38/=
0x3c)
Exception stack(0xbffade48 to 0xbffade90)
de40:                   bffade94 bffade58 802640d0 801dbe58 80f5c380 8c1928=
08
de60: 80049800 80049808 80269cd0 80f5c384 80efc100 80049808 80f5c380 80f103=
a0
de80: 80049800 80049808 bffaded4 bffade98
[<801dbe84>] (__ipipe_root_ipi+0x38/0x3c) from [<802640d0>] (__ipipe_sync_s=
tage+0x19c/0x330)
[<802640d0>] (__ipipe_sync_stage+0x19c/0x330) from [<80264b7c>] (__ipipe_wa=
lk_pipeline+0x190/0x2e4)
[<80264b7c>] (__ipipe_walk_pipeline+0x190/0x2e4) from [<801e1014>] (__ipipe=
_handle_irq+0x1e0/0x29c)
[<801e1014>] (__ipipe_handle_irq+0x1e0/0x29c) from [<801ce1b4>] (__ipipe_gr=
ab_ipi+0x3c/0xe0)
[<801ce1b4>] (__ipipe_grab_ipi+0x3c/0xe0) from [<801d47c0>] (__irq_svc+0x40=
/0xd4)
Exception stack(0xbffadf40 to 0xbffadf88)
df40: 20000000 0000001d 00000000 f40dc010 8c192808 80f4e6e4 80efbb10 8088cf=
c4
df60: 80eff42c 412fc09a 00000000 bffadf9c 801e7c28 bffadf88 801e8214 801e67=
0c
df80: 20000013 ffffffff
[<801d47c0>] (__irq_svc+0x40/0xd4) from [<801e670c>] (cpu_v7_do_idle+0x8/0x=
c)
SMP: failed to stop secondary CPUs




> --
> =09=09=09=09=09    Gilles.
>=20

