Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7A22F44
	for <xenomai@lists.linux.dev>; Tue, 18 Apr 2023 13:57:05 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230418121632216f742482ebc730d5
        for <xenomai@lists.linux.dev>;
        Tue, 18 Apr 2023 14:16:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=GyauwGAvLQLXztQP1rpHYu2CqTXVa5ipXkPN+bpVZRc=;
 b=IZhjY6u5n2g2k6U1g6jLHIwJo+/6eVdMYLrDT3BD7SjwM5g3RzMsJqtW4eS9Oi256l7hnX
 sHQLJo577t+E2mySOrEFXjxcPW1G//2a7+SIR5mzMzFpp0C5xXFSxhGKM3WQm8uNK8lrRV0H
 Y0998o/8hIJ9eGwqvyDUHW0ZVeLu0=;
Message-ID: <8bc373bcf9b5a52eba1b45f1d8ce2e33efb7dd13.camel@siemens.com>
Subject: Re: RFC: System hang / deadlock on Linux 6.1
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Jan Kiszka <jan.kiszka@web.de>, 
	xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 18 Apr 2023 14:16:30 +0200
In-Reply-To: <d86fab4595a09ff4e78b9e49ab59f96e20a95a99.camel@siemens.com>
References: <1550a773-6461-5006-3686-d5f2f7e78ee4@siemens.com>
	 <09e26675-d1f5-7726-a803-6ee1fd01ecbb@web.de>
	 <8cdb7db3-cf99-9fa7-be7e-d0104b74831b@siemens.com>
	 <de2ff0a777bc4d42a4d788c16061b7ed245b7616.camel@siemens.com>
	 <03cf4874-9a8a-12c6-00f4-6ee435180128@siemens.com>
	 <d86fab4595a09ff4e78b9e49ab59f96e20a95a99.camel@siemens.com>
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

On Mon, 2023-04-03 at 10:52 +0200, Florian Bezdeka wrote:
> On Mon, 2023-04-03 at 07:31 +0200, Jan Kiszka wrote:
> > On 30.03.23 18:13, Florian Bezdeka wrote:
> > > On Tue, 2023-03-28 at 18:01 +0200, Florian Bezdeka wrote:
> > > > On 28.03.23 01:01, Jan Kiszka wrote:
> > > > > On 27.03.23 19:30, Florian Bezdeka wrote:
> > > > > > Hi all,
> > > > > >=20
> > > > > > I'm currently investigating an issue reported by an internal cu=
stomer. When
> > > > > > trying to run Xenomai (next branch) on top of Dovetail (6.1.15)=
 in an virtual
> > > > > > environment (VirtualBox 7.0.6) a complete system hang / deadloc=
k can be
> > > > > > observed.
> > > > > >=20
> > > > > > I was not able to reproduce the locking issue myself, but I'm a=
ble to "stall"
> > > > > > the system by putting a lot of load on the system (stress-ng). =
After 10-20
> > > > > > minutes there is no progress anymore.
> > > > > >=20
> > > > > > The locking issue reported by the customer:
> > > > > >=20
> > > > > > [    5.063059] [Xenomai] lock (____ptrval____) already unlocked=
 on CPU #3
> > > > > > [    5.063059]           last owner =3D kernel/xenomai/pipeline=
/intr.c:26 (xnintr_core_clock_handler(), CPU #0)
> > > > > > [    5.063072] CPU: 3 PID: 130 Comm: systemd-udevd Not tainted =
6.1.15-xenomai-1 #1
> > > > > > [    5.063075] Hardware name: innotek GmbH VirtualBox/VirtualBo=
x, BIOS VM 12/01/2006
> > > > > > [    5.063075] IRQ stage: Xenomai
> > > > > > [    5.063077] Call Trace:
> > > > > > [    5.063141]  <TASK>
> > > > > > [    5.063146]  dump_stack_lvl+0x71/0xa0
> > > > > > [    5.063153]  xnlock_dbg_release.cold+0x21/0x2c
> > > > > > [    5.063158]  xnintr_core_clock_handler+0xa4/0x140
> > > > > > [    5.063166]  lapic_oob_handler+0x41/0xf0
> > > > > > [    5.063172]  do_oob_irq+0x25a/0x3e0
> > > > > > [    5.063179]  handle_oob_irq+0x4e/0xd0
> > > > > > [    5.063182]  generic_pipeline_irq_desc+0xb0/0x160
> > > > > > [    5.063213]  arch_handle_irq+0x5d/0x1e0
> > > > > > [    5.063218]  arch_pipeline_entry+0xa1/0x110
> > > > > > [    5.063222]  asm_sysvec_apic_timer_interrupt+0x16/0x20
> > > > > > ...
> > > > > >=20
> > > > > > After reading a lot of code I realized that the so called parav=
irtualized
> > > > > > spinlocks are being used when running under VB (VirtualBox):
> > > > > >=20
> > > > > > [    0.019574] kvm-guest: PV spinlocks enabled
> > > > > >=20
> > > > > > vs. Qemu:
> > > > > >=20
> > > > > > Qemu (with -enable-kvm):
> > > > > > [    0.255790] kvm-guest: PV spinlocks disabled, no host suppor=
t
> > > > > >=20
> > > > > > The good news: With CONFIG_PARAVIRT_SPINLOCKS=3Dn (or "nopvspin=
" on the kernel
> > > > > > cmdline) the problem disappears.
> > > > > >=20
> > > > > > The bad news: As Linux alone (and dovetail without Xenomai patc=
h) runs fine,
> > > > > > even with all the stress applied, I'm quite sure that we have a=
 (maybe
> > > > > > longstanding) locking bug.
> > > > > >=20
> > > > > > RFC: I'm now testing the patch below, which is already running =
fine for some
> > > > > > hours now. Please let me know if all of this makes sense. I mig=
ht have
> > > > > > overlooked something.
> > > > > >=20
> > > > > > If I'm not mistaken the following can happen on one CPU:
> > > > > >=20
> > > > > > // Example: taken from tick.c, proxy_set_next_ktime()
> > > > > > xnlock_get_irqsave(&nklock, flags);
> > > > > > // root domain stalled, but hard IRQs are still enabled
> > > > >=20
> > > > > OOB + hard IRQs stalled (xnlock_get_irqsave -> splhigh -> oob_irq=
_save).
> > > > >=20
> > > > > >=20
> > > > > > 	// PROXY TICK IRQ FIRES
> > > > > > 	// taken from intr.c, xnintr_core_clock_handler()
> > > > > > 	xnlock_get(&nklock);	// we already own the lock
> > > > >=20
> > > > > If this code runs under the assumption that hard-IRQs and OOB is =
stalled
> > > > > while they are not, we indeed have a problem. Please check where =
that
> > > > > may have gone wrong.
> > > >=20
> > > > My warnings used to check the context actually never triggered so f=
ar,
> > > > but the system is still entering the broken state. Some further fin=
dings:
> > > >=20
> > > > - nklock internally uses a arch_spinlock_t for locking
> > > > - nklock is used by the proxy timer tick IRQ, so very "often"
> > > > - arch_spinlock_t is very rarely used in Linux, I found only a coup=
le
> > > >   of usages inside x86 code (dumpstack.c, hpet.c, tsc_sync.c)
> > > > - arch_spinlock_t might use the PV optimized spinlock operations
> > > > - Most other spinlocks (especially in dovetail) are based on
> > > >   raw_spinlock
> > > > - raw_spinlock does not use PV optimized operations
> > > >=20
> > > > That might be the reason why Linux alone runs fine.
> > > >=20
> > > > I'm now asking myself if the PV spinlock implementation provided by
> > > > virtualbox has a bug... As virtualbox is to some degree based on KV=
M
> > > > that might be a KVM bug as well...
> > > >=20
> > > > Let me try to force the slow path for arch_spinlock_t. Maybe my vCP=
Us
> > > > never come back...
> > >=20
> > > Short update:
> > >=20
> > > Seems the slowpath matters, especially when there is noticeable load =
on
> > > the host itself. The vCPU is "parked" and it's simply taking too long
> > > until it is back on the CPU. In my case I'm running into an AHCI
> > > timeout in most cases, rootfs unaccessable, system "dead".
> > >=20
> > > Still wondering how the "lockdep" error above can actually happen. Th=
is
> > > was on a different host, so maybe a different problem.
> > >=20
> >=20
> > It might be that the PV code is not playing according to dovetail rules=
,
> > e.g. not always using virtualized irq-enable/disable or not using hard
> > disabling when actually needed. Tracing the call path, along with the
> > virtual and physical irq states, may help. Any this may easier be
> > debugged over KVM with pv-spinlocks enabled.
>=20
> Some more test results over the weekend:
>=20
>=20
> Kernel                         PV spin            test result
> Linux 6.1.15                   enabled            OK (5h test)
> Linux 6.1.15-dovetail          enabled            OK (5h test)
> Linux 6.1.15-dovetail + xeno   enabled            FAIL after ~20m
> Linux 6.1.15-dovetail + xeno   disabled           FAIL after ~4h
>=20
> Booting the same image with KVM on the same host gives me
> [    0.284674] kvm-guest: PV spinlocks disabled, no host support
> so I'm not able to debug that under KVM.
>=20
> Disabling PV spinlocks with "nopvspin" does not fully solve this
> problem, but it seems to minimize the "race window".
>=20
> I have some RCU stall warnings with some call graphs from the failed
> runs above. I will try to analyze them. They seem to be identical.
> Let's see.

TLDR: It's not a Xenomai issue. Problem disappeared after a KVM bug has
been identified [1]. In addition the guest/systemd no longer detects
KVM as hypervisor but "oracle" (VBox vendor) which is even more
correct.

I saw that after some time the highest bit of the ISR of the vCPU was
set and never cleared. With that I easily found [1], which was
available as update for my host system. After updating my host
something else must have changed in addition. The guest no longer
detects KVM as hypervisor but "oracle". I did not spend the time yet to
identify which patch/commit introduced this behavior.

The system is running fine for > 24h now. No further investigations
will be made.

[1] is part of Linux >=3D 6.1.16.

[1] https://github.com/torvalds/linux/commit/97a71c444a147ae41c7d0ab5b3d855=
d7f762f3ed

Florian

>=20
> >=20
> > Jan
> >=20
>=20
>=20

