Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8470C8BEE
	for <xenomai@lists.linux.dev>; Thu, 30 Mar 2023 16:54:13 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202303301613495fff096f483be017e6
        for <xenomai@lists.linux.dev>;
        Thu, 30 Mar 2023 18:13:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=YHwT5Ho5ZPVTpNxv2L4IwFMokb6CGrjJy8UYhwMYwH0=;
 b=m6sYrgUzBfW3bBkPLYJFDw4NnZ91JVAs1m4hbJkGec/McuKTg5X+OSvlm/utkE+mbanX8H
 y2CUS0NPeBW3WorWkwVjs4fBzTqDA2SUArR3+B1iiKYdTwq6gTuw1tuh/3TXOZya2iQDz80H
 Ms7c0xu9gRxiM0v3JjXQFPPh4olag=;
Message-ID: <de2ff0a777bc4d42a4d788c16061b7ed245b7616.camel@siemens.com>
Subject: Re: RFC: System hang / deadlock on Linux 6.1
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@web.de>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Thu, 30 Mar 2023 18:13:49 +0200
In-Reply-To: <8cdb7db3-cf99-9fa7-be7e-d0104b74831b@siemens.com>
References: <1550a773-6461-5006-3686-d5f2f7e78ee4@siemens.com>
	 <09e26675-d1f5-7726-a803-6ee1fd01ecbb@web.de>
	 <8cdb7db3-cf99-9fa7-be7e-d0104b74831b@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Tue, 2023-03-28 at 18:01 +0200, Florian Bezdeka wrote:
> On 28.03.23 01:01, Jan Kiszka wrote:
> > On 27.03.23 19:30, Florian Bezdeka wrote:
> > > Hi all,
> > >=20
> > > I'm currently investigating an issue reported by an internal customer=
. When
> > > trying to run Xenomai (next branch) on top of Dovetail (6.1.15) in an=
 virtual
> > > environment (VirtualBox 7.0.6) a complete system hang / deadlock can =
be
> > > observed.
> > >=20
> > > I was not able to reproduce the locking issue myself, but I'm able to=
 "stall"
> > > the system by putting a lot of load on the system (stress-ng). After =
10-20
> > > minutes there is no progress anymore.
> > >=20
> > > The locking issue reported by the customer:
> > >=20
> > > [    5.063059] [Xenomai] lock (____ptrval____) already unlocked on CP=
U #3
> > > [    5.063059]           last owner =3D kernel/xenomai/pipeline/intr.=
c:26 (xnintr_core_clock_handler(), CPU #0)
> > > [    5.063072] CPU: 3 PID: 130 Comm: systemd-udevd Not tainted 6.1.15=
-xenomai-1 #1
> > > [    5.063075] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIO=
S VM 12/01/2006
> > > [    5.063075] IRQ stage: Xenomai
> > > [    5.063077] Call Trace:
> > > [    5.063141]  <TASK>
> > > [    5.063146]  dump_stack_lvl+0x71/0xa0
> > > [    5.063153]  xnlock_dbg_release.cold+0x21/0x2c
> > > [    5.063158]  xnintr_core_clock_handler+0xa4/0x140
> > > [    5.063166]  lapic_oob_handler+0x41/0xf0
> > > [    5.063172]  do_oob_irq+0x25a/0x3e0
> > > [    5.063179]  handle_oob_irq+0x4e/0xd0
> > > [    5.063182]  generic_pipeline_irq_desc+0xb0/0x160
> > > [    5.063213]  arch_handle_irq+0x5d/0x1e0
> > > [    5.063218]  arch_pipeline_entry+0xa1/0x110
> > > [    5.063222]  asm_sysvec_apic_timer_interrupt+0x16/0x20
> > > ...
> > >=20
> > > After reading a lot of code I realized that the so called paravirtual=
ized
> > > spinlocks are being used when running under VB (VirtualBox):
> > >=20
> > > [    0.019574] kvm-guest: PV spinlocks enabled
> > >=20
> > > vs. Qemu:
> > >=20
> > > Qemu (with -enable-kvm):
> > > [    0.255790] kvm-guest: PV spinlocks disabled, no host support
> > >=20
> > > The good news: With CONFIG_PARAVIRT_SPINLOCKS=3Dn (or "nopvspin" on t=
he kernel
> > > cmdline) the problem disappears.
> > >=20
> > > The bad news: As Linux alone (and dovetail without Xenomai patch) run=
s fine,
> > > even with all the stress applied, I'm quite sure that we have a (mayb=
e
> > > longstanding) locking bug.
> > >=20
> > > RFC: I'm now testing the patch below, which is already running fine f=
or some
> > > hours now. Please let me know if all of this makes sense. I might hav=
e
> > > overlooked something.
> > >=20
> > > If I'm not mistaken the following can happen on one CPU:
> > >=20
> > > // Example: taken from tick.c, proxy_set_next_ktime()
> > > xnlock_get_irqsave(&nklock, flags);
> > > // root domain stalled, but hard IRQs are still enabled
> >=20
> > OOB + hard IRQs stalled (xnlock_get_irqsave -> splhigh -> oob_irq_save)=
.
> >=20
> > >=20
> > > 	// PROXY TICK IRQ FIRES
> > > 	// taken from intr.c, xnintr_core_clock_handler()
> > > 	xnlock_get(&nklock);	// we already own the lock
> >=20
> > If this code runs under the assumption that hard-IRQs and OOB is stalle=
d
> > while they are not, we indeed have a problem. Please check where that
> > may have gone wrong.
>=20
> My warnings used to check the context actually never triggered so far,
> but the system is still entering the broken state. Some further findings:
>=20
> - nklock internally uses a arch_spinlock_t for locking
> - nklock is used by the proxy timer tick IRQ, so very "often"
> - arch_spinlock_t is very rarely used in Linux, I found only a couple
>   of usages inside x86 code (dumpstack.c, hpet.c, tsc_sync.c)
> - arch_spinlock_t might use the PV optimized spinlock operations
> - Most other spinlocks (especially in dovetail) are based on
>   raw_spinlock
> - raw_spinlock does not use PV optimized operations
>=20
> That might be the reason why Linux alone runs fine.
>=20
> I'm now asking myself if the PV spinlock implementation provided by
> virtualbox has a bug... As virtualbox is to some degree based on KVM
> that might be a KVM bug as well...
>=20
> Let me try to force the slow path for arch_spinlock_t. Maybe my vCPUs
> never come back...

Short update:

Seems the slowpath matters, especially when there is noticeable load on
the host itself. The vCPU is "parked" and it's simply taking too long
until it is back on the CPU. In my case I'm running into an AHCI
timeout in most cases, rootfs unaccessable, system "dead".

Still wondering how the "lockdep" error above can actually happen. This
was on a different host, so maybe a different problem.

>=20
> Florian
>=20
> >=20
> > Jan
> >=20
> > > 	xnclock_tick(&nkclock);
> > > 	xnlock_put(&nklock);	// we unconditionally release the lock
> > > 	// EOI
> > >=20
> > > // back in proxy_set_next_ktime(), but nklock released!
> > > // Other CPU might already own the lock
> > > sched =3D xnsched_current();
> > > ret =3D xntimer_start(&sched->htimer, delta, XN_INFINITE, XN_RELATIVE=
);
> > > xnlock_put_irqrestore(&nklock, flags);
> > >=20
> > >=20
> > > To avoid unconditional lock release I switched to xnlock_{get,put}_ir=
qsave() in
> > > xnintr_core_clock_handler. I think it's correct. Additionally stallin=
g the
> > > root domain should not be an issues as hard IRQs are already disabled=
.
> > >=20
> > > diff --git a/kernel/cobalt/dovetail/intr.c b/kernel/cobalt/dovetail/i=
ntr.c
> > > index a9459b7a8..ce69dd602 100644
> > > --- a/kernel/cobalt/dovetail/intr.c
> > > +++ b/kernel/cobalt/dovetail/intr.c
> > > @@ -22,10 +22,11 @@ void xnintr_host_tick(struct xnsched *sched) /* h=
ard irqs off */
> > >  void xnintr_core_clock_handler(void)
> > >  {
> > >         struct xnsched *sched;
> > > +       unsigned long flags;
> > >=20
> > > -       xnlock_get(&nklock);
> > > +       xnlock_get_irqsave(&nklock, flags);
> > >         xnclock_tick(&nkclock);
> > > -       xnlock_put(&nklock);
> > > +       xnlock_put_irqrestore(&nklock, flags);
> > >=20
> > > Please let me know what you think!
> > >=20
> > > Best regards,
> > > Florian
> > >=20
> >=20
>=20
>=20

