Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471942;
	b=zf5ZpY8KpCQ4DNKWfZcsco/F2JWZBgayI5mJCi+USIUwoGJjWCCgP99ScxCtXWdmU3x5
	 lfxxbLhXEgGNafItk7WfxPWclXZeEdVYS+givXO99WnJi1huo7NsXeQ/dxaCQFCILV4gX
	 vcFgD1WiRdiwHkULnRmxU3A9v5vLMGy91dNtO/Aj6jH3Ny5rFiwAX+JAkso+P6TUht18d
	 6cz0WIL/MSCuS1dPATZoCl3XZZKZH0+oxeffExzQuwS9Y4u3kAhIAGCQwDduYwdyXltTq
	 0W1cuBgKnUMWVG2x4x0HO+CVq3qktpfOGNYtjHbbKoypP/rUDFsTf/lyjO6rmvPozbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471942;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=+rmpkX/jJAzZN75lz4TFazXvGTX7YFzmlxEc0ss7ZEk=;
	b=TeeMDms8oG1VanUIY4O9Bm3sirSqaRnpsmIKWAdrBncefMPQZcu/orbNck5uBiGFdRfQ
	 X3Ml/d/f9WcxihQ+eInsAeTTC0XL8UbqrR0Veu6+K5ZvJ9m//peEkS8igSuaH5VmwtbyJ
	 n7ZeFa7e6XbDlcGWnr8UrpXX0UCQKPGp8B1OfwwtRPE3IUPmntDGdR0m4S8k/Fp5Ywf7Z
	 B2TVBUpjn+p3ZFdNkjJm6NgUOxeNN1y6VXGl2mHbnANzB0K+Oxuu/bI+uNyIwdY77z5bz
	 pSY2OHem7YTUh10oz1VY6n4KAhLCm101cu+SAHVvwSJ255HZg6dQlG5th2h17cz+SEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=P7dx+ohK;
	arc=none smtp.remote-ip=185.136.64.226
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F64606A33A
	for <xenomai@lists.linux.dev>; Mon, 23 Nov 2026 22:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67F64606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=P7dx+ohK
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202611232212118f8790f2ea00020750
        for <xenomai@lists.linux.dev>;
        Mon, 23 Nov 2026 23:12:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+rmpkX/jJAzZN75lz4TFazXvGTX7YFzmlxEc0ss7ZEk=;
 b=P7dx+ohKnHWj3TCWzxsRZ52VBQldp+J3rEXWSPeGpuylcrezJIb9aem8jW0MiyADzgTsiX
 j2yYC2IJ6gIA+U3Z5Pv1yGOptGeK1G0ggKd3issaV7eMXpB6lO89gcFDYXfCtvxonbNFFf3Q
 F6R96XK1I+mx1rrmXAtNFvsqHG7K5UP6OaLqiyjRHhjtiO5SBWadr5hm0EzeUD4DfmDD7blg
 tDci9triazQFzAKM61sQVjuxwqP3PzWxzQ0HVUEaSWwoeyW+vYGn5UUwcVo+1awdCi6YjNQY
 droi21Bgz5juWJ2UCHmzVrz2aJ5RWWvpmrwm0S3MyBUOFsGW0MhB/JNA==;
Message-ID: <e55022378f5d521c20e037597c04a8698b615a15.camel@siemens.com>
Subject: Re: [PATCH dovetail v2 3/4] riscv: dovetail: inherit the hard irq
 state on kernel page faults
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
Date: Mon, 23 Nov 2026 23:12:11 +0100
In-Reply-To: <5e8681d8-7d2a-4337-807d-80eab19d36cc@siemens.com>
References: <20261121165933.57310-1-tobias.schaffner@siemens.com>
	 <20261121165933.57310-4-tobias.schaffner@siemens.com>
	 <DN2371TJAB7G.334DTWMEPJTQI@siemens.com>
	 <915d53fb-fc8b-4c07-935f-a9d4680ee8a5@siemens.com>
	 <87afa16be7aada0d995e63364bb9e7785af24675.camel@siemens.com>
	 <5e8681d8-7d2a-4337-807d-80eab19d36cc@siemens.com>
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

On Mon, 2026-11-23 at 14:43 +0100, Tobias Schaffner wrote:
> On 11/23/26 13:05, Florian Bezdeka wrote:
> > On Mon, 2026-11-23 at 12:39 +0100, Tobias Schaffner wrote:
> > > On 11/22/26 23:18, Florian Bezdeka wrote:
> > > > On Sat Nov 21, 2026 at 5:59 PM CET, Tobias Schaffner wrote:
> > > > > A page fault may hit kernel code which runs with hard irqs off, e=
.g. a
> > > > > kprobe whose fetch argument faults within the breakpoint trap. Th=
e fault
> > > > > handler still enables hard irqs for every kernel mode fault, so a=
n
> > > > > interrupt may break into that code. If the fault is handled out-o=
f-band,
> > > > > the handler also unstalls the in-band stage over the out-of-band =
stage.
> > > > >=20
> > > > > Enable hard irqs in handle_page_fault() only if the faulting code=
 had
> > > > > them on and we run in-band, and stall the in-band stage on exit o=
nly if
> > > > > we run in-band.
> > > > >=20
> > > > > Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
> > > > > Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> > > > > ---
> > > > >    arch/riscv/kernel/traps.c | 11 ++++-------
> > > > >    arch/riscv/mm/fault.c     |  7 +++++--
> > > > >    2 files changed, 9 insertions(+), 9 deletions(-)
> > > > >=20
> > > > > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.=
c
> > > > > index a8e37ec27cc2..47799f18fa7d 100644
> > > > > --- a/arch/riscv/kernel/traps.c
> > > > > +++ b/arch/riscv/kernel/traps.c
> > > > > @@ -488,17 +488,14 @@ asmlinkage __visible __trap_section void do=
_trap_software_check(struct pt_regs *
> > > > >    asmlinkage __visible noinstr void do_page_fault(struct pt_regs=
 *regs)
> > > > >    {
> > > > >    =09irqentry_state_t state =3D irqentry_enter(regs);
> > > > > +=09bool inband =3D mark_trap_entry(regs);
> > > > >   =20
> > > > > -=09mark_trap_entry(regs);
> > > > > -
> > > > > -=09BUG_ON(dovetail_debug() && !running_inband());
> > > > > -
> > > > > -=09if (!user_mode(regs))
> > > > > -=09=09hard_cond_local_irq_enable();
> > > > > +=09BUG_ON(dovetail_debug() && !inband && user_mode(regs));
> > > > >   =20
> > > > >    =09handle_page_fault(regs, state);
> > > > >   =20
> > > > > -=09local_irq_disable();
> > > > > +=09if (inband)
> > > > > +=09=09local_irq_disable();
> > > > >   =20
> > > > >    =09mark_trap_exit(regs);
> >=20
> > Below comes another hard_cond_local_irq_disable() call that is a
> > duplicate as already handled by mark_trap_exit(). =3D> More code to be
> > removed.
>=20
> One is for user_mode and one for !user_mode().

Can't follow here, but I agree: Some on the confusion is/was on my side.
Let's bring back the complete sequence:

=09mark_trap_entry(regs); [1]

=09if (!user_mode(regs))
=09=09hard_cond_local_irq_enable(); [2]

=09handle_page_fault(regs, state); [3]

=09local_irq_disable(); [4]

=09mark_trap_exit(regs); [5]

=09if (!user_mode(regs))
=09=09hard_cond_local_irq_disable(); [6]

[1] and [5] open/close the trap handling section. Entry into this area
and exit from it should match. But: [2] is inside the section while it's
counterpart [6] is outside the section. That's a mismatch (even if the
code does the right thing, more later).

[2] and [6] must be in lock-step. In v2 only [2] has been removed on my
request, because it is a partial duplicate, right, but removal likely
leads to confusion.

[4] must only be called when running inband.

Now the most confusing part, at least on my end: My expectation was that
you follow the same pattern as x86 does. But that is not the case. The
page fault handler on x86 does not use mark_trap_entry/exit() at all.

That's why cond_reenable_irqs_{user,kernel} exist. That is - so to say -
the IRQ mask touching counterpart of mark_trap_{entry,exit}() on riscv.
The fault handler itself is directly calling oob_trap_notify() on x86.

hard IRQ enablement inside the page fault handler:
I went to x86 today and reviewed the code again, mostly to make sure
we're not following a broken pattern. Outcome: I consider the x86
implementation as correct.

The main logic (on x86):

1) Re-enable interrupts following the following rules:

   - Fault over user space: Enable hard IRQs and in addition,
     when running inband: enable inband IRQs=C2=A0
     (see cond_reenable_irqs_user())

   - Fault over kernel space: Enable hard IRQs and in case the=C2=A0
     inband stage was unstalled on fault entry: enable inband IRQs
     (see cond_reenable_irqs_kernel())

2) Notify the co-kernel, by calling oob_trap_notify()

3) Call the fault handler=20

4) Restore IRQ state (see cond_disable_irqs())

Coming back to risc-v now: Starting in do_page_fault(), I see a
completely different order of things. Starting with mark_trap_entry()
being called which notifies the co-kernel first, without doing 1) as on
x86. At least the notification has to take place under the same
conditions as on other archs. Otherwise we might confuse the co-kernel.

I hope that helps (and makes sense).
