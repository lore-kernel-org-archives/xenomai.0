Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE398263F31
	for <xenomai@lists.linux.dev>; Mon, 24 Feb 2025 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417834; cv=none; b=CTz+QajVq1oNZ3cvqI8tq6lNb45CiPW5HiSemNtc7QlWNVhZ4p/mVwgq90TNwpAAVZyl0yGmRAnfk4UdIW8KcYlN3VHPLFEZjuaoyZ3YFzGTwePVZz1Ldh0tvnLH35xlbqZ3UGJiOkriIcqP9/ToJwtBUXpjsklJtoYYCP6UHEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417834; c=relaxed/simple;
	bh=HmskjaYvaBawwFujOc3T1FYtXvC9KFNIixGj+moo3J0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DDXhPe7X62gQK5ql+zZl9FkhZ1k9L5HrCgKlJZo87mdETBKjmHN97RkXthQAnFE5hBjlwL1UGl3qgVez/VKFtcFK4BoZxgTI/Hh3yeanILOhyV5bWBOPfZfbYupMPeAMBartwkrXBWArXlw+LtYYP3Nxk9nEukFHz7MwSJVZANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ScmJdZdE; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ScmJdZdE"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250224172346568ff7093d8b8a1039
        for <xenomai@lists.linux.dev>;
        Mon, 24 Feb 2025 18:23:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=iN+Q5OUVTXPNDHleIMCyPtbNdLVWsYoWZzYjuCRA4os=;
 b=ScmJdZdEx0BQDO8mfqCj9Aeq6GehBvNOkmnhzSIliTyQxLrhEYLycQ4GZAs4l+ePgCTGTs
 ZeHbMbBreqtbP/2vj7ZzHnKS8Cj+cNZJfSk8dupNNv6RwuC2UTI+jgSQpS7EoLGckuVJrZ7Z
 XHV8IC+6pzYamKQufbMl9sQBUEz3gJDGU0IofrgkzgRDcNWt4efb4IDSmg3wOnL5DKMhVE3X
 itb8CNJGO5eCXYMiHmBBrfgBAlRK5S3VnKKTMv2jzvQjlz3wzB+yH68bx4MPCW9PU4hrwP6N
 ZiqqfSZEWZkmEg/nA4sXLEqMitz6bNiLMLa35PI5+0cMg8xAnLc+p5aA==;
Message-ID: <04ccd31401260b4920b84f3e0b6c94437c5264a7.camel@siemens.com>
Subject: Re: [PATCH] x86: dovetail: Harden __send_ipi_mask for KVM guests
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Date: Mon, 24 Feb 2025 18:23:46 +0100
In-Reply-To: <87plj72rib.fsf@xenomai.org>
References: <eeca1faa-bf32-47c9-aba7-fa197034dcac@siemens.com>
	 <87plj72rib.fsf@xenomai.org>
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

On Mon, 2025-02-24 at 18:15 +0100, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
>=20
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >=20
> > This function is called in case paravirtual IPIs of a KVM host are used=
.
> > Just like for hard submission handlers, we need to harden the path to
> > avoid splashes like these:
> >=20
> >  IRQ pipeline: some code running in oob context 'Xenomai'
> >                called an in-band only routine
> >  CPU: 0 PID: 410 Comm: (udev-worker) Not tainted 5.10.229-cip54+ #265
> >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-=
gd478f380-rebuilt.opensuse.org 04/01/2014
> >  IRQ stage: Xenomai
> >  Call Trace:
> >   dump_stack+0x84/0x9c
> >   inband_irq_save+0xa/0x30
> >   __send_ipi_mask+0x81/0x260
> >   ? preempt_count_sub+0x96/0xe0
> >   ? _raw_spin_unlock_irq+0x33/0x50
> >   ? xnsched_pick_next+0xe0/0xe0
> >   ? ___xnsched_run+0x491/0x5b0
> >   ? ktime_get_mono_fast_ns+0x50/0xb0
> >   ___xnsched_run+0x491/0x5b0
> >   run_oob_call+0x97/0x170
> >   xnthread_start+0x23f/0x330
> >   ? rt_stack_deliver+0x340/0x340 [rtnet]
> >   rtdm_task_init.part.14+0x7e/0xc0
> >=20
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >  arch/x86/kernel/kvm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index 5df1061fc6ee1..b183caf41aa44 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> > @@ -525,7 +525,7 @@ static void __send_ipi_mask(const struct cpumask *m=
ask, int vector)
> >  	if (cpumask_empty(mask))
> >  		return;
> > =20
> > -	local_irq_save(flags);
> > +	flags =3D hard_local_irq_save();
> > =20
> >  	switch (vector) {
> >  	default:
> > @@ -563,7 +563,7 @@ static void __send_ipi_mask(const struct cpumask *m=
ask, int vector)
> >  			  ret);
> >  	}
> > =20
> > -	local_irq_restore(flags);
> > +	hard_local_irq_restore(flags);
> >  }
> > =20
> >  static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
>=20
> Ack.

Ack. The hyperv PV code is also affected (__send_ipi_mask_ex).

>=20
> --=20
> Philippe.

