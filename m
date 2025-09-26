Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF45C2F25ED
	for <xenomai@lists.linux.dev>; Fri, 26 Sep 2025 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882397; cv=none; b=M6u0NgWum9z6TP+jbH8rBsfML+SKqYln3pVaDH9zs067J5qFqsNukN1vVed3fvR2YFHPzPbevxF+Bu5WjuXzibwE5UpNnCld9O3ddOlcg1thptIAjuNPVTons1o7WI4osy5HT6JleobgnYkewcJESwxQoOB8unVYHFbfoUqhIPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882397; c=relaxed/simple;
	bh=Ky/zDIAN9KWxFylSpuhvg3S2jix8vVhYdnt2qZ0PfRM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gxymncEbaTbG8my+0Rkn9jE4smUKcDbo+ushHsPv4KSnqFDLKxvK2OudO4erDhvvd95dx5nbrUeS5XMSWZdeqIuBH3dQLMTGz7LZiVZSE/9Hxc/Iiwv7bJYDUS60poaSUiQ+qhPsu9HT578YslyVd+R3IRlqfUNONWSAwDvmi90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=QPwq3UlJ; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="QPwq3UlJ"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025092610262268153d3a01000207aa
        for <xenomai@lists.linux.dev>;
        Fri, 26 Sep 2025 12:26:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=o/n8kGTVIh9apbLuLqv8Mv6idWTxM2WJDpYPPf9XdIM=;
 b=QPwq3UlJlrcSatJwEJLbKhMd9miD96X6FWJUkIU96EI6p2wLARjkqnze7d8/MxnHrVmXuH
 ve+4aL8AYADBxCCmMOaXpv0FUqBMkfJQQOD6d3AsxOHrbQp+yPak4odo9ik7VyQcW65tsoeP
 Ha1oiOsiDV83alRh17+zFFHMDm5GgH4GCj3d2odL2xADsmwKkEizDq9vKUkII0vL9EtA+yjJ
 l+W8clrVef4fkv5O1W+yzrlgkgTrjPF0Wq0gR1HS1a+6IjECgJfaYkk5J1x+xTJwSM9uW7Oo
 RH0TGWQL5BAXf5O59/z/t05vuZ/s61OpBHBwBFpUc/tMjvjqvjQriePA==;
Message-ID: <0ec46f0daf973c66d194cdbec1366106f71881ba.camel@siemens.com>
Subject: Re: [PATCH RFC Dovetail 6.16 1/5] kernel/entry: irq_pipeline: Do
 not leave .noinstr.text section
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Date: Fri, 26 Sep 2025 12:26:22 +0200
In-Reply-To: <87ikh5ha31.fsf@xenomai.org>
References: 
	<20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
		<20250925-wip-flo-cleanups-based-on-6-16-v1-1-8c4ac7b52cd8@siemens.com>
	 <87ikh5ha31.fsf@xenomai.org>
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

On Fri, 2025-09-26 at 10:49 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > Fixing the following warning by moving the call to irqentry_syncstage()
> > into a instrumentation_begin() section.
> >=20
> > vmlinux.o: warning: objtool: irqentry_exit+0xab: call to synchronize_pi=
peline() leaves .noinstr.text section
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  kernel/entry/common.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> > index 583dcef13c7c0..284d41cb1c918 100644
> > --- a/kernel/entry/common.c
> > +++ b/kernel/entry/common.c
> > @@ -393,6 +393,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, ir=
qentry_state_t state)
> >  		return;
> >  	}
> > =20
> > +	instrumentation_begin();
> >  	synchronized =3D irqentry_syncstage(state);
> >=20
>=20
> This means that we won't have ftracing or anything that depends on
> instrumentation in any inband irq handler triggered during stage sync
> from this code path.

Hm. Really? The instrumentation is now enabled before running into
irqendtry_syncstage(). No?

Seems I have some issues to fully understand that instrumentation
thingy. Let me double check...

>=20
> --=20
> Philippe.
