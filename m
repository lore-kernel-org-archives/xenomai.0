Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605207;
	b=mtWFDD4CI+d3ajoUtEO35BJGxBLULcmHVdfwqZIETHPHEEONc69KX4fTvBRMpXXt6rIK
	 KMtGzCYl+HTqQ4mqBAl8SbfuJKfrNivngEV48m345cJuZCUnvbI2ugfHwF/phdoYCq1Z8
	 j6STa1tKhCf3bOV71wNIxkrrsDQIS+KDbs93xBjVCPgk90hIp2exPBwJt99BWP32ALoNy
	 25d+p3Te05AuyQrZf9ttLD8N/rFnmTsIxNwLVsM13xyzIQoyc9+HjcTupoLLjyfu7henJ
	 vJ/SRWecStzQIoP3nVSDEUOkQpCRWSpZoSE1DZmGFz9WD2eME3Sm3GlpZG4QmPRHJsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605207;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=yuCS1k9a50T84KnzqmfOBpNX0hvEMon/b8s1fcbzuUg=;
	b=3kex/nq1RtS/UyULSY1J1kKMWdpOnG1H63Eh8DyCNTbBdERiYlu3jSerIqmeeP9a5Q1Y
	 a3pvyObQ3Gx7jvnauADFsh0j3lyiIgDeu3lEZN+aROxkwQvccejhHcpuczC85ri8LtDqX
	 M08yz4SoIuCqe58q715I0UJxz2yYCtH3o8X53/5+pVWi2jMLxc4Ykv7nzLyg0wm0sWRWC
	 yAGghrR5rHFTs/GVpoPEtjvs7Bdwr4P5NfH0/I677svpHrAytDcZs3Fjjsn6TTOKFboG9
	 p6tusnYMfs3qz2WvDQ1CenIiG3kriR8lOJFsl09uPmy+yEdk5hZYMdjLmMedChw8WCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=dxjSiAuV;
	arc=none smtp.remote-ip=185.136.64.225
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D653606A31E
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 11:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D653606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=dxjSiAuV
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20261125111321daa0d5f7e3000207f9
        for <xenomai@lists.linux.dev>;
        Wed, 25 Nov 2026 12:13:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yuCS1k9a50T84KnzqmfOBpNX0hvEMon/b8s1fcbzuUg=;
 b=dxjSiAuVtxuTY3LAyY4zY31qnyGVRnlIBTWDOrX/9P9mwDBBPe2gktlGzK+uQENW4kC0yr
 H8rfVd6csj25fsjc5+hmB5+vDhAyq0AFOGxVkcq2iCOE9/2oIubr8ZDbxXMyPCIdgeVrB0/+
 wOmIK8i5lBBJJnQ8PERdtC15XsgUfs757Y4JV2p/tfRNWTHYvloBHROXxb5o+Z8jj8lFmXO8
 0HJV8uXYmpvhVl2t8+bL9SICTFk/xNgUlRy3RjgKM8hbWgbB8ukrdaB1eaCnWLY0b9mEuTsx
 4B0pRnR02rhjT20UPzHcZAf9YDb/rGpD7rJuYzeiI1Gq2s9UHvteEcpA==;
Message-ID: <09e0fe247ecf465c589e189338d58ec78f7eba98.camel@siemens.com>
Subject: Re: [PATCH dovetail v2 3/4] riscv: dovetail: inherit the hard irq
 state on kernel page faults
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
Date: Wed, 25 Nov 2026 12:13:20 +0100
In-Reply-To: <0a1ae6c1-55ef-4e48-b9c5-b3963923701f@siemens.com>
References: <20261121165933.57310-1-tobias.schaffner@siemens.com>
	 <20261121165933.57310-4-tobias.schaffner@siemens.com>
	 <DN2371TJAB7G.334DTWMEPJTQI@siemens.com>
	 <915d53fb-fc8b-4c07-935f-a9d4680ee8a5@siemens.com>
	 <87afa16be7aada0d995e63364bb9e7785af24675.camel@siemens.com>
	 <5e8681d8-7d2a-4337-807d-80eab19d36cc@siemens.com>
	 <e55022378f5d521c20e037597c04a8698b615a15.camel@siemens.com>
	 <0a1ae6c1-55ef-4e48-b9c5-b3963923701f@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Tue, 2026-11-24 at 20:53 +0100, Tobias Schaffner wrote:
> On 11/23/26 23:12, Florian Bezdeka wrote:
> > On Mon, 2026-11-23 at 14:43 +0100, Tobias Schaffner wrote:
> > > On 11/23/26 13:05, Florian Bezdeka wrote:
> > > > On Mon, 2026-11-23 at 12:39 +0100, Tobias Schaffner wrote:
> > > > > On 11/22/26 23:18, Florian Bezdeka wrote:
> > > > > > On Sat Nov 21, 2026 at 5:59 PM CET, Tobias Schaffner wrote:
> > > > > > > A page fault may hit kernel code which runs with hard irqs of=
f, e.g. a
> > > > > > > kprobe whose fetch argument faults within the breakpoint trap=
. The fault
> > > > > > > handler still enables hard irqs for every kernel mode fault, =
so an
> > > > > > > interrupt may break into that code. If the fault is handled o=
ut-of-band,
> > > > > > > the handler also unstalls the in-band stage over the out-of-b=
and stage.
> > > > > > >=20
> > > > > > > Enable hard irqs in handle_page_fault() only if the faulting =
code had
> > > > > > > them on and we run in-band, and stall the in-band stage on ex=
it only if
> > > > > > > we run in-band.
> > > > > > >=20
> > > > > > > Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
> > > > > > > Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com=
>
> > > > > > > ---
> > > > > > >     arch/riscv/kernel/traps.c | 11 ++++-------
> > > > > > >     arch/riscv/mm/fault.c     |  7 +++++--
> > > > > > >     2 files changed, 9 insertions(+), 9 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/tr=
aps.c
> > > > > > > index a8e37ec27cc2..47799f18fa7d 100644
> > > > > > > --- a/arch/riscv/kernel/traps.c
> > > > > > > +++ b/arch/riscv/kernel/traps.c
> > > > > > > @@ -488,17 +488,14 @@ asmlinkage __visible __trap_section voi=
d do_trap_software_check(struct pt_regs *
> > > > > > >     asmlinkage __visible noinstr void do_page_fault(struct pt=
_regs *regs)
> > > > > > >     {
> > > > > > >     =09irqentry_state_t state =3D irqentry_enter(regs);
> > > > > > > +=09bool inband =3D mark_trap_entry(regs);
> > > > > > >    =20
> > > > > > > -=09mark_trap_entry(regs);
> > > > > > > -
> > > > > > > -=09BUG_ON(dovetail_debug() && !running_inband());
> > > > > > > -
> > > > > > > -=09if (!user_mode(regs))
> > > > > > > -=09=09hard_cond_local_irq_enable();
> > > > > > > +=09BUG_ON(dovetail_debug() && !inband && user_mode(regs));
> > > > > > >    =20
> > > > > > >     =09handle_page_fault(regs, state);
> > > > > > >    =20
> > > > > > > -=09local_irq_disable();
> > > > > > > +=09if (inband)
> > > > > > > +=09=09local_irq_disable();
> > > > > > >    =20
> > > > > > >     =09mark_trap_exit(regs);
> > > >=20
> > > > Below comes another hard_cond_local_irq_disable() call that is a
> > > > duplicate as already handled by mark_trap_exit(). =3D> More code to=
 be
> > > > removed.
> > >=20
> > > One is for user_mode and one for !user_mode().
> >=20
> > Can't follow here, but I agree: Some on the confusion is/was on my side=
.
> > Let's bring back the complete sequence:
> >=20
> > =09mark_trap_entry(regs); [1]
> >=20
> > =09if (!user_mode(regs))
> > =09=09hard_cond_local_irq_enable(); [2]
> >=20
> > =09handle_page_fault(regs, state); [3]
> >=20
> > =09local_irq_disable(); [4]
> >=20
> > =09mark_trap_exit(regs); [5]
> >=20
> > =09if (!user_mode(regs))
> > =09=09hard_cond_local_irq_disable(); [6]
> >=20
> > [1] and [5] open/close the trap handling section. Entry into this area
> > and exit from it should match. But: [2] is inside the section while it'=
s
> > counterpart [6] is outside the section. That's a mismatch (even if the
> > code does the right thing, more later).
> >=20
> > [2] and [6] must be in lock-step. In v2 only [2] has been removed on my
> > request, because it is a partial duplicate, right, but removal likely
> > leads to confusion.
> >=20
> > [4] must only be called when running inband.
> >=20
> > Now the most confusing part, at least on my end: My expectation was tha=
t
> > you follow the same pattern as x86 does. But that is not the case. The
> > page fault handler on x86 does not use mark_trap_entry/exit() at all.
> >=20
> > That's why cond_reenable_irqs_{user,kernel} exist. That is - so to say =
-
> > the IRQ mask touching counterpart of mark_trap_{entry,exit}() on riscv.
> > The fault handler itself is directly calling oob_trap_notify() on x86.
> >=20
> > hard IRQ enablement inside the page fault handler:
> > I went to x86 today and reviewed the code again, mostly to make sure
> > we're not following a broken pattern. Outcome: I consider the x86
> > implementation as correct.
> >=20
> > The main logic (on x86):
> >=20
> > 1) Re-enable interrupts following the following rules:
> >=20
> >     - Fault over user space: Enable hard IRQs and in addition,
> >       when running inband: enable inband IRQs
> >       (see cond_reenable_irqs_user())
> >=20
> >     - Fault over kernel space: Enable hard IRQs and in case the
> >       inband stage was unstalled on fault entry: enable inband IRQs
> >       (see cond_reenable_irqs_kernel())
> >=20
> > 2) Notify the co-kernel, by calling oob_trap_notify()
> >=20
> > 3) Call the fault handler
> >=20
> > 4) Restore IRQ state (see cond_disable_irqs())
> >=20
> > Coming back to risc-v now: Starting in do_page_fault(), I see a
> > completely different order of things. Starting with mark_trap_entry()
> > being called which notifies the co-kernel first, without doing 1) as on
> > x86. At least the notification has to take place under the same
> > conditions as on other archs. Otherwise we might confuse the co-kernel.
> >=20
> > I hope that helps (and makes sense).
>=20
> You have a point regarding the ordering. Thanks for putting that much
> effort in describing this in detail. That helped a lot.
>=20
> I will have to spend some additional time to think this through.
> When comparing both I also noticed that some kernel traps are not
> notified at all in x86 and arm64. This will eventually make it a
> bigger change than I expected it in the first place.

Stay focused on riscv for the moment. I can have a look at the other
archs. What do you think is missing/odd? Any pointers?
