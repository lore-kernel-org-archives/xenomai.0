Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5915539A
	for <xenomai@lists.linux.dev>; Thu, 19 Feb 2026 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771537765; cv=none; b=Ludde4W41dynu4IuJsZkZ2M43dfTwhE3a8R1x1kZVl18Sy2/KmKn4vjpVjBYX9NKrNR6FjdJVEAWGaiZf8IdiGgpHf0un3RS0uvEzUR9gbh2x9m8jUNxsWkobn8XY3jXpSVe8ai1WAMgG98W+M5A0dEJ07FSu8YLnoaDw5+U3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771537765; c=relaxed/simple;
	bh=WhstPyzN9rjicsZkjaBbCPdilEWmIQl2jV05mSsbLpE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HTPpxloip29ZjIjCv8bd3M1LsVOIg+lC5wr8UD/viBTMyvQgYEUmJrP8qkSLv8mAMN3W/nMeRMc1a7x+YIaHgDaGDvm6zPT9RJ+AiqO1i9DUynxBzI2arr3jQsT/EHGxuMojx6d7vh6SIDjJzvQ3HuWOVvvHMePInp3TgtNhnjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=K8Q+5tfR; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="K8Q+5tfR"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260219214912600e69b8dc000207fe
        for <xenomai@lists.linux.dev>;
        Thu, 19 Feb 2026 22:49:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5lxkVudMLeZSN+f78sIsT9J0LounbHtTyuA+BXTny98=;
 b=K8Q+5tfRHw/SRlRp+jxz/bwu/uk73Qo+4plQ3mkAIf/m8KA1A8mFR/xLj1NZRUOFNQOX9k
 g4A/4jkIoQf8q5H29pmHmuyKFAUcIM8nUPqYx5+N+zgegDv46uzeeiD8+zRVotPbdFCjGINy
 uy/wtfIvyIFNwY4wh6R104QWgpM+5xHFiLRQUexCV54G7yUoercrOq61kNT+Q8zqjlxZ8CR9
 w/nfcN0e/92iM+RMhA29jXXeXYwGefQSM/T0/i0FIdgbXLwVPJLXC5J+HRGy/9dr+IR3ZHtX
 G7Sy6dCMrwiNg5uRILkY/16o2X2RzNpgFInGvLzdFzsdpfhWJ70IeY3w==;
Message-ID: <d4944aa75e5874d6a7566fc7be0fc5560a4b8ab0.camel@siemens.com>
Subject: Re: [PATCH Dovetail v2 1/2] dovetail: genirq: Add
 request_percpu_irq_affinity_flags()
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Thu, 19 Feb 2026 22:49:11 +0100
In-Reply-To: <87jyw83biv.fsf@xenomai.org>
References: 
	<20260217-wip-flo-v6-19-dovetail-rebase-v2-0-45fc326a166a@siemens.com>
		<20260217-wip-flo-v6-19-dovetail-rebase-v2-1-45fc326a166a@siemens.com>
		<982c1b8b306d2abd81c88bc4669035957b664f2e.camel@siemens.com>
		<1d10a103-975b-44c8-89cd-7ac0d059f4cd@siemens.com>
		<e2650ecb681d004bdc97f48ac0afaf235bdc9521.camel@siemens.com>
	 <87jyw83biv.fsf@xenomai.org>
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

On Thu, 2026-02-19 at 18:10 +0100, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Wed, 2026-02-18 at 08:30 +0100, Jan Kiszka wrote:
> > > On 18.02.26 00:05, Florian Bezdeka wrote:
> > > > On Tue, 2026-02-17 at 23:54 +0100, Florian Bezdeka wrote:
> > > > > cobalt / evl are currently using __request_percpu_irq() for setti=
ng up
> > > > > OOB IRQs. In 6.19 the signature of __request_percpu_irq() has bee=
n
> > > > > updated and 7.0 will remove the function entirely, so we need a
> > > > > replacement.
> > > > >=20
> > > > > All other variants (like the upcoming request_percpu_irq_affinity=
())
> > > > > are missing the flags parameter which we require.
> > > > >=20
> > > > > This could be backported to all supported dovetail versions. That
> > > > > would allow co-kernels to switch to the new API unconditionally.
> > > > >=20
> > > > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > > > ---
> > > > >  include/linux/interrupt.h |  5 +++++
> > > > >  kernel/irq/manage.c       | 10 ++++++++++
> > > > >  2 files changed, 15 insertions(+)
> > > > >=20
> > > > > diff --git a/include/linux/interrupt.h b/include/linux/interrupt.=
h
> > > > > index bf0511b438c65e119af917763ce92a8f3bfb4c4c..6cd8ad02ffbd87f71=
869d6737fbc8c1ae477c1ee 100644
> > > > > --- a/include/linux/interrupt.h
> > > > > +++ b/include/linux/interrupt.h
> > > > > @@ -213,6 +213,11 @@ request_percpu_irq_affinity(unsigned int irq=
, irq_handler_t handler,
> > > > >  				    devname, affinity, percpu_dev_id);
> > > > >  }
> > > > > =20
> > > > > +int request_percpu_irq_affinity_flags(unsigned int irq, irq_hand=
ler_t handler,
> > > > > +				      unsigned long flags, const char *devname,
> > > > > +				      const cpumask_t *affinity,
> > > > > +				      void __percpu *dev_id);
> > > > > +
> > > > >=20
> > > >=20
> > > > Would be nice to get some feedback here. The affinity parameter is
> > > > currently not in use, but would allow us to provide it in the futur=
e.
> > > > Not sure if that will be necessary...
> > > >=20
> > >=20
> > > This is what I was wondering as well... When would one need that? May=
be
> > > in the context of confining Xenomai to a subset of physical CPUs? Wou=
ld
> > > be good to check that again.
> >=20
> > @Philippe: Any thoughts?
> >=20
> > I would like to complete the 6.19 port on Xenomai side. This is a
> > blocker right now.
> >=20
>=20
> To me this is a no-brainer, given that __request_percpu_irq() requires
> an affinity mask, having request_percpu_irq_affinity_flags() is the only
> sane way to set all the properties of a per-cpu interrupt, including
> flags and affinity, in one go. In any case, callers who don't care about
> such affinity can pass NULL.
>=20

Thanks for the confirmation.=C2=A0

I will add the series now to the wip/flo/v6.19-dovetail-rebase branch
and continue with the Xeno 3 adaptions. evl will need the same changes.
Philippe, can you look into that or should I try to reserve some cycles?

The Xeno 3 testsuite is already passing on that branch.

Florian
