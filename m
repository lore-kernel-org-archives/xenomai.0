Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B853DB63D
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781517430; cv=none; b=MRmJiM99g+RHiRw5gaOigXVMZ1xqMJuTQBg+FwT6h+/xElnOUThd6j8WHVTgYMfaDseo0lEfvXar24iYL+4WdBh7hyi37mbN/xhmJT01uUCplggaS6AKzHKdsPyHEaVXZp2dO8w+06SifYZSkZXi24KRtIWDoGOJS/l5sJCWXck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781517430; c=relaxed/simple;
	bh=kVr8UppswCerCn5pxOsbyIFJHEJ3Mz0TtXMi797ATHg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fQDwLQ4+i2xjh7EBlgyoebWWJk77vuCP4KrXmp8l3REpfSYc5plX/aIfjBQMjQfc0THWr/gY7zuneAT/7yo3CgOu+OrOPnTKl9yrb6lTjUtBjiplcfXvoXqeK9k1W6YnwjLsHZ4h2CKmdvyvGrBmG9E7yykKAyML5t+Su9UDGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Ot1passP; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Ot1passP"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260615095655a80ca92a3a000207ea
        for <xenomai@lists.linux.dev>;
        Mon, 15 Jun 2026 11:56:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=MVKbc3Zv22dh/RiHgBGPeX2FBwbB8GVpB+trLAen0Ck=;
 b=Ot1passP/d7e3lqbrNUw5yZwaYbnjUTLcAgZY8aactkEzAKkBAl8MEtygQKX0e1HvWOLxI
 HnYCZzwj2pjqg/YCc0u0p0taQb83zW3tlFgQ96RPAJznBYr2x2PRnI0c1RSXlSvBxAU0PDKt
 z4Y6Uu8Y1VarYNsQkvZI+1RNYRAzA/4DOH7/gq7igVoowleLGcQlxTaUZJ/yrJQAJNr8TcHV
 HyC0HHzThGIbl2JOxK0bwsqVyjobxjXXJi5OxfBxWS8wiZ90TKDEhK+ReZJ10f+PDCucjf0q
 V6QZKbt6OG1emDAzJOBYK709ibd7KPwBlqB5kyeOkQDv3aBE5T5VHpqA==;
Message-ID: <59a7a9f8931703b299f1883e275efbe077e17d1f.camel@siemens.com>
Subject: Re: [PATCH] x86: dovetail: Call trap exit code with hard IRQs
 disabled
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Tobias Schaffner
 <tobias.schaffner@siemens.com>,  Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 15 Jun 2026 11:56:54 +0200
In-Reply-To: <87bjdexrn2.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
References: <20260612211719.3054905-1-florian.bezdeka@siemens.com>
		<874ij6tleh.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
	 <87bjdexrn2.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
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

On Sat, 2026-06-13 at 19:43 +0200, Philippe Gerum wrote:
> Philippe Gerum <rpm@xenomai.org> writes:
>=20
> > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> >=20
> > > mark_trap_exit() should do the reverse operations of mark_trap_entry(=
)
> > > keeping ordering in mind. Especially as oob_trap_unwind() is expectin=
g
> > > hard IRQs to be off.
> > >=20
> >=20
> > oob_trap_unwind() does not require irqs to be disabled,
> > __oob_trap_unwind() already takes care of this. However, we do want
> > oob_trap_unwind() to return with irqs off unconditionally because
> > handle_oob_trap_exit() might not ensure this. So the original ordering
> > is right.
>=20
> A better fix may be to disable hard irqs right before leaving
> __oob_trap_unwind(), instead of expecting handle_oob_trap_exit() - which
> is user-provided - to do so. This would make things clearer, and the
> conditional disabling in mark_trap_exit() pointless.

But=C2=A0wouldn't that unpair the irq enable/disable calls in the exit
handler? (evl only, cobalt has no implementation)

I clearly overlooked the hard_local_irq_disable() call in
__oob_trap_unwind().

Now looking at that again I think that the hard_cond_local_irq_disable()
call (that I moved) in mark_trap_exit() is a unnecessary for oob tasks.
The trap exit handler should have done the right thing already. That
would synchronize mark_trap_{entry,exit} on x86.

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 6b5b33b4d511..8230b785664a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -355,7 +355,9 @@ static __always_inline
 void mark_trap_exit(int trapnr, struct pt_regs *regs)
 {
        oob_trap_unwind(trapnr, regs);
-       hard_cond_local_irq_disable();
+
+       if (likely(running_inband()))
+               hard_cond_local_irq_disable();
 }
