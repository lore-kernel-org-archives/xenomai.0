From: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Date: Fri, 27 Jul 2012 18:12:40 +0200
Message-ID: <CE2E43470FE5444A811B580382FE5EDF2113EA9385@KEMPMAIL2.woodward.com>
References: <CE2E43470FE5444A811B580382FE5EDF2113D8D95A@KEMPMAIL2.woodward.com>
	<5009A292.4060508@grandegger.com>
	<CE2E43470FE5444A811B580382FE5EDF2113EA8DE7@KEMPMAIL2.woodward.com>
	<501028DC.8000803@xenomai.org> <50102E8D.1040004@xenomai.org>
	<CE2E43470FE5444A811B580382FE5EDF2113EA8E07@KEMPMAIL2.woodward.com>
	<50105A22.3090704@xenomai.org>
	<CE2E43470FE5444A811B580382FE5EDF2113EA8FD2@KEMPMAIL2.woodward.com>
	<50113143.50101@xenomai.org>
	<CE2E43470FE5444A811B580382FE5EDF2113EA9383@KEMPMAIL2.woodward.com>
	<5012BB11.9000407@xenomai.org> <5012BD08.8030305@xenomai.org>
In-Reply-To: <5012BD08.8030305@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Xenomai installation on P1020RDB
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>


> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org]
> Sent: Friday, July 27, 2012 6:09 PM
> To: Gilles Chanteperdrix
> Cc: Lukasz Zemla; Xenomai@xenomai.org
> Subject: Re: [Xenomai] Xenomai installation on P1020RDB
>=20
> On 07/27/2012 06:00 PM, Gilles Chanteperdrix wrote:
> > On 07/27/2012 05:53 PM, Lukasz Zemla wrote:
> >
> >> What I discovered, the source of the '76s problem' could be
> preemption model. Now, when I set:
> >>   - CONFIG_PREEMPT - the lag exists exactly after eth0
> initialization.
> >>   - CONFIG_PREEMPT_VOLUNTARY - the boot process stops for a while
> (about 50-70s) in different places.
> >>   - CONFIG_PREEMPT_NONE then all is fine, I cannot observe any
> described problems.
> >
> >
> > CONFIG_PREEMPT or PREEMPT_VOLUNTARY. Try this patch:
> >
> > diff --git a/arch/powerpc/kernel/ipipe.c
> b/arch/powerpc/kernel/ipipe.c
> > index 45302c1..5b706da 100644
> > --- a/arch/powerpc/kernel/ipipe.c
> > +++ b/arch/powerpc/kernel/ipipe.c
> > @@ -344,8 +344,10 @@ static void __ipipe_do_IRQ(unsigned int irq,
> void
> > *cookie)
> >
> >   static void __ipipe_do_timer(unsigned int irq, void *cookie)
> >   {
> > +=09irq_enter();
> >   =09check_stack_overflow();
> >   =09timer_interrupt(__this_cpu_ptr(&ipipe_percpu.tick_regs));
> > +=09irq_exit();
> >   }
> >
> >   asmlinkage int __ipipe_grab_timer(struct pt_regs *regs)
> >
> > Or to remove the #ifdef CONFIG_IPIPE / #endif around the calls to
> > irq_enter/irq_exit in arch/powerpc/kernel/time.c
> >
>=20
> Mm, no. On ppc, we use a virtual irq to map the decrementer, so the
> pipeline core already took care of marking the irq entry before calling
> the __ipipe_do_timer handler. The issue may be in the log syncer
> instead.

Maybe I have some symptom which I forgot to write. When the system with C=
ONFIG_PREEMPT stayed unused for last night I saw following errors:

Yocto (Built by Poky 6.0) 1.1 p1020rdb ttyS0

p1020rdb login: [  193.919436] INFO: rcu_preempt detected stalls on CPUs/=
tasks: { 1} (detected by 0, t=3D15002 jiffies)
[  193.928407] Call Trace:
[  193.930860] [c0799cb0] [c0008234] show_stack+0x4c/0x174 (unreliable)
[  193.937222] [c0799cf0] [c0092464] __rcu_pending+0x424/0x440
[  193.942794] [c0799d30] [c0092a84] rcu_check_callbacks+0x150/0x1f8
[  193.948893] [c0799d50] [c0056f40] update_process_times+0x3c/0x60
[  193.954904] [c0799d70] [c0079fe4] tick_sched_timer+0x8c/0xfc
[  193.960570] [c0799da0] [c006bdb4] __run_hrtimer.isra.28+0x58/0x100
[  193.966751] [c0799dc0] [c006cc3c] hrtimer_interrupt+0x160/0x408
[  193.972673] [c0799e50] [c0009d14] timer_interrupt+0x13c/0x1b8
[  193.978421] [c0799e80] [c000e2cc] __ipipe_do_timer+0x44/0x54
[  193.984082] [c0799e90] [c009467c] __ipipe_do_sync_stage+0x1e0/0x220
[  193.990350] [c0799ec0] [c000e9a0] __ipipe_grab_timer+0xa8/0xc0
[  193.996186] [c0799ed0] [c00107a4] __ipipe_ret_from_except+0x0/0xc
[  194.002282] --- Exception: 901 at cpu_idle+0x8c/0xf0
[  194.002286]     LR =3D cpu_idle+0x8c/0xf0
[  194.011067] [c0799f90] [c0008df8] cpu_idle+0xb0/0xf0 (unreliable)
[  194.017165] [c0799fb0] [c0002438] rest_init+0x88/0x98
[  194.022221] [c0799fc0] [c072778c] start_kernel+0x2e8/0x2fc
[  194.027706] [c0799ff0] [c00003fc] skpinv+0x2e8/0x324
[ 6662.479437] INFO: rcu_bh detected stalls on CPUs/tasks: { 1} (detected=
 by 0, t=3D15002 jiffies)
[ 6662.487975] Call Trace:
[ 6662.490428] [c0799cb0] [c0008234] show_stack+0x4c/0x174 (unreliable)
[ 6662.496790] [c0799cf0] [c0092464] __rcu_pending+0x424/0x440
[ 6662.502363] [c0799d30] [c0092a68] rcu_check_callbacks+0x134/0x1f8
[ 6662.508460] [c0799d50] [c0056f40] update_process_times+0x3c/0x60
[ 6662.514473] [c0799d70] [c0079fe4] tick_sched_timer+0x8c/0xfc
[ 6662.520138] [c0799da0] [c006bdb4] __run_hrtimer.isra.28+0x58/0x100
[ 6662.526319] [c0799dc0] [c006cc3c] hrtimer_interrupt+0x160/0x408
[ 6662.532241] [c0799e50] [c0009d14] timer_interrupt+0x13c/0x1b8
[ 6662.537989] [c0799e80] [c000e2cc] __ipipe_do_timer+0x44/0x54
[ 6662.543650] [c0799e90] [c009467c] __ipipe_do_sync_stage+0x1e0/0x220
[ 6662.549917] [c0799ec0] [c000e9a0] __ipipe_grab_timer+0xa8/0xc0
[ 6662.555752] [c0799ed0] [c00107a4] __ipipe_ret_from_except+0x0/0xc
[ 6662.561849] --- Exception: 901 at cpu_idle+0x8c/0xf0
[ 6662.561852]     LR =3D cpu_idle+0x8c/0xf0
[ 6662.570635] [c0799f90] [c0008df8] cpu_idle+0xb0/0xf0 (unreliable)
[ 6662.576732] [c0799fb0] [c0002438] rest_init+0x88/0x98
[ 6662.581788] [c0799fc0] [c072778c] start_kernel+0x2e8/0x2fc
[ 6662.587273] [c0799ff0] [c00003fc] skpinv+0x2e8/0x324

--=20
Best regards,
 Lukasz


***=0D
The information in this email is confidential and intended solely for the=
 individual or entity to whom it is addressed. If you have received this =
email in error please notify the sender by return e-mail, delete this ema=
il, and refrain from any disclosure or action based on the information.=0D
***

