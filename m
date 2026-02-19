Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A825A33ADBF
	for <xenomai@lists.linux.dev>; Thu, 19 Feb 2026 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771519140; cv=none; b=laQpgYDMI87dY3dZNlnVzzjdLc4hjjXYUz1tKrm0EITr0+XPtUDkC0L/p1jT10FrW1Zw81nYPX8EXJuhuTKqZde8zL4UXpBzX63m5zP3LVCm7WjdrWQxzDbi5zK+SgZstYcw4vozSGqEhpX0thMmbb8w9Wsacr0chzsGM/swDao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771519140; c=relaxed/simple;
	bh=owyBB5ZgTOeXicJlRbOmAh0IohB9pCVFjAl3+YPqoe4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t58UTlhtvYtIdFUvj0J9RZ8iCNmnFSSTjrd2GQqj1PefM8P5x6fuU9auhIm+5dAcP6BvbsGidvgHTaeEuKtWY0b0ymmRrOo+5/EG73RoOkhCVkL5Tqkvtdp2nmSLD3Fq+n1Gbuz4lS6w1Wf7XjK2uBPphrnDYXtnNopI4Ymo1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=J8t9EMYe; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="J8t9EMYe"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260219163846b2a3282ba4000207d4
        for <xenomai@lists.linux.dev>;
        Thu, 19 Feb 2026 17:38:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=YM4WaUGhnTJ3pMR4gFpm8tGMHjgwB4a4/+5BdmGOgxs=;
 b=J8t9EMYeKe5fgB6Car9w+dDskt1Zq1x0QhvGaZoizD6ph5PnWqPg49zUhlYkUdu+btUSph
 UFnOzaUzg6E1fIhAVbwi1BpUoFESS3YTDPuy98H0zpVrqX3TVfrbuRAXuwzxQDUG3j1FBlTU
 IikwKVQX2csgjZIDLhkl3HtlH0ggCpc8XrsDO+dCAhO8Kihv2/DbUPUCSQUAFxSuH1amu9Mv
 6OjgYyWFL8F9pTebhV9IG3Frm3ttS9gPiZaq22dNpfvJ6oq22cgYTe/esnS6l3UqYtP63mMt
 Ke6J6NQtu3BRKRSHIvt4828v/3ItyyCsfDBPuBbgN8/htsOjGCz8MR5w==;
Message-ID: <e2650ecb681d004bdc97f48ac0afaf235bdc9521.camel@siemens.com>
Subject: Re: [PATCH Dovetail v2 1/2] dovetail: genirq: Add
 request_percpu_irq_affinity_flags()
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Thu, 19 Feb 2026 17:38:46 +0100
In-Reply-To: <1d10a103-975b-44c8-89cd-7ac0d059f4cd@siemens.com>
References: 
	<20260217-wip-flo-v6-19-dovetail-rebase-v2-0-45fc326a166a@siemens.com>
	 <20260217-wip-flo-v6-19-dovetail-rebase-v2-1-45fc326a166a@siemens.com>
	 <982c1b8b306d2abd81c88bc4669035957b664f2e.camel@siemens.com>
	 <1d10a103-975b-44c8-89cd-7ac0d059f4cd@siemens.com>
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

On Wed, 2026-02-18 at 08:30 +0100, Jan Kiszka wrote:
> On 18.02.26 00:05, Florian Bezdeka wrote:
> > On Tue, 2026-02-17 at 23:54 +0100, Florian Bezdeka wrote:
> > > cobalt / evl are currently using __request_percpu_irq() for setting u=
p
> > > OOB IRQs. In 6.19 the signature of __request_percpu_irq() has been
> > > updated and 7.0 will remove the function entirely, so we need a
> > > replacement.
> > >=20
> > > All other variants (like the upcoming request_percpu_irq_affinity())
> > > are missing the flags parameter which we require.
> > >=20
> > > This could be backported to all supported dovetail versions. That
> > > would allow co-kernels to switch to the new API unconditionally.
> > >=20
> > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > ---
> > >  include/linux/interrupt.h |  5 +++++
> > >  kernel/irq/manage.c       | 10 ++++++++++
> > >  2 files changed, 15 insertions(+)
> > >=20
> > > diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> > > index bf0511b438c65e119af917763ce92a8f3bfb4c4c..6cd8ad02ffbd87f71869d=
6737fbc8c1ae477c1ee 100644
> > > --- a/include/linux/interrupt.h
> > > +++ b/include/linux/interrupt.h
> > > @@ -213,6 +213,11 @@ request_percpu_irq_affinity(unsigned int irq, ir=
q_handler_t handler,
> > >  				    devname, affinity, percpu_dev_id);
> > >  }
> > > =20
> > > +int request_percpu_irq_affinity_flags(unsigned int irq, irq_handler_=
t handler,
> > > +				      unsigned long flags, const char *devname,
> > > +				      const cpumask_t *affinity,
> > > +				      void __percpu *dev_id);
> > > +
> > >=20
> >=20
> > Would be nice to get some feedback here. The affinity parameter is
> > currently not in use, but would allow us to provide it in the future.
> > Not sure if that will be necessary...
> >=20
>=20
> This is what I was wondering as well... When would one need that? Maybe
> in the context of confining Xenomai to a subset of physical CPUs? Would
> be good to check that again.

@Philippe: Any thoughts?

I would like to complete the 6.19 port on Xenomai side. This is a
blocker right now.

>=20
> > The idea behind were the upcoming 7.0 changes. The implementation of
> > request_percpu_irq_affinity() could move to the dovetail specific
> > variant and the Linux implementation can simply call the dovetail
> > variant.
>=20
