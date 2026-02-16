Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950223EBF24
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771240533; cv=none; b=ukG2hdxAjFMuc26423ifOizT+GdgvmRqcSWU6S/VlcQAWHx++tNpYQew5g/lxjSyPMi+7jB2vG2Wn3AwEVkFPOp5FGgFDd7CIa6inQjEpDz2THXfBk9HN2SNUQN8R8XF2yG8wHOPcoz8oIMMPy9DVtbCBH+HUhBW9C9nBIvOE4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771240533; c=relaxed/simple;
	bh=9yult73P7sSXxprhaWNauI/LEAEK11yxnfoOinLcnKE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XKmohvBQXNTP+0ljgfF2/ehlYjj1BKWj27cTTteb+9bYzhsQyRAqBSbYhUPvTbpBboLotLm0PawVwTY7asH4z7t+8fBc9qNd0n9ey8mMZ5wvhUTfwrgbsQ3Lcfd7KkPtyL31iVfp9E2wAc2rTp3Xmb+HMHR6cydL8dey6pwqsEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=PxePPzeS; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="PxePPzeS"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260216111526a424432dbb00020759
        for <xenomai@lists.linux.dev>;
        Mon, 16 Feb 2026 12:15:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=FlO+gEyM6/HyYgJOgkBrMrOEh1ZvsmcD/qkkGfn2ulM=;
 b=PxePPzeSh+3plTLktGF0jjTmn1Hk617hZ3RdAqx0Hp/LvQL0cbur9q5sv+4WzK+cSgKNGT
 qRFY+4j75KvKDzRYNjoLO0FMjITPZdhPWNSZmN6d6BhoL9XUZmiO3ZpsEEw71bYojdlsd2wi
 VBL72RrAKFhjEFz/GSgr2M2hEApoRNYrdNQZkYN8419eY6+1P7X4KC4NEWZgeOi9AKwDe29o
 5nlfUtwac4f8gQ9ITomwH85msHdNB8VBMUSXmVM+1UiGUAsbd+KoOW7MljCVCB3l8q/8mJM6
 3QK3i5A6F/M5y7npgSVQ54jPzAPFMl53yjn1xdFcAH/XJyayFLI5mngg==;
Message-ID: <07bf64686c2fe140c55cd6d3b38a00f0b603024e.camel@siemens.com>
Subject: Re: [PATCH 1/3] cobalt: Prepare for new signature of
 __request_percpu_irq() in 6.19
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Mon, 16 Feb 2026 12:15:26 +0100
In-Reply-To: <0c22f949-8bf2-4566-aa37-10baca291b5c@siemens.com>
References: 
	<20260216-wip-flo-prepare-for-6-19-v1-0-f7362cdd2532@siemens.com>
	 <20260216-wip-flo-prepare-for-6-19-v1-1-f7362cdd2532@siemens.com>
	 <0c22f949-8bf2-4566-aa37-10baca291b5c@siemens.com>
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

On Mon, 2026-02-16 at 12:11 +0100, Jan Kiszka wrote:
> On 16.02.26 11:58, Florian Bezdeka wrote:
> > Since 6.19 the signature of __request_percpu_irq() got one additional
> > affinity parameter.
> >=20
> > A new Linux version specific wrapper cobalt_request_percpu_irq() is
> > introduced to hide the signature change between different Linux
> > versions.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  include/cobalt/kernel/dovetail/pipeline/irq.h      | 20 ++++++++++++++=
++++++
> >  include/cobalt/kernel/dovetail/pipeline/pipeline.h | 10 +++++-----
> >  include/cobalt/kernel/dovetail/pipeline/sirq.h     |  8 +++-----
> >  kernel/cobalt/dovetail/tick.c                      |  8 ++++----
> >  4 files changed, 32 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/include/cobalt/kernel/dovetail/pipeline/irq.h b/include/co=
balt/kernel/dovetail/pipeline/irq.h
> > index 55d9b8ff17cd08e5e8c09aec393a1e23736c1b76..ac780a4bb3223889ccf827b=
5b8cb279035a5dd7b 100644
> > --- a/include/cobalt/kernel/dovetail/pipeline/irq.h
> > +++ b/include/cobalt/kernel/dovetail/pipeline/irq.h
> > @@ -5,6 +5,26 @@
> >  #ifndef _COBALT_KERNEL_DOVETAIL_IRQ_H
> >  #define _COBALT_KERNEL_DOVETAIL_IRQ_H
> > =20
> > +#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 19, 0)
> > +static inline int cobalt_request_percpu_irq(unsigned int irq,
> > +					    irq_handler_t handler,
> > +					    unsigned long flags,
> > +					    const char *devname,
> > +					    void __percpu *dev_id)
> > +{
> > +	return __request_percpu_irq(irq, handler, flags, devname, dev_id);
> > +}
> > +#else
> > +static inline int cobalt_request_percpu_irq(unsigned int irq,
> > +					    irq_handler_t handler,
> > +					    unsigned long flags,
> > +					    const char *devname,
> > +					    void __percpu *dev_id)
> > +{
> > +	return __request_percpu_irq(irq, handler, flags, devname, NULL, dev_i=
d);
> > +}
> > +#endif
>=20
> Please use a define for request_percpu_irq on older kernels that uses
> the new signature and resolves to the old one via __request_percpu_irq
> as needed.=C2=A0
> Yes, also switch to request_percpu_irq directly because
> __request_percpu_irq is going to be removed in 7.0.
>=20

request_percpu_irq() doesn't allow us to specify the=C2=A0flags. IRQF_OOB a=
nd
IRQF_NO_THREAD would be needed.
