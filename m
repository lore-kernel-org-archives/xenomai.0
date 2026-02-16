Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D24B15A86D
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771240978; cv=none; b=qnAEUJ0TE84k43cOQdgNhold+ZOtt3dAMqU3yhO/pxBw63z9zqC5zdDxzX/ujUV5cspsSsl11d0V5Z3rJSQRTne/CFijj8IG4xDsp55n05oO6RmsU4OJr049MJHddda+cIlE7pUfIGt6757BBDgDTHwhl7xoei9+vhXOIaZYetQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771240978; c=relaxed/simple;
	bh=yRXR1oe3aXd6tKd6nb4SUW7OoRhxfTrPCPHEO3XcrTk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tpz3OpdwlbIFBH09tEi0nGNE0sQXUiNtnl+0LWiTyfO8Qpnfmw/HVPYeVL4TqE/Udv8xwp8JLZ7rtotBdtQMsgy9m6QxCsBk/bs3f+R4X4LjIbg967XIJo7Pbc/D01yZsq6eY6K0A3Vr8WHTWFcaHY02HsvUMd8ayum4MCcVzYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=LHE4n5sS; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="LHE4n5sS"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202602161122509b36209e37000207ec
        for <xenomai@lists.linux.dev>;
        Mon, 16 Feb 2026 12:22:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=pF7xpWDwIzUM8v5ftOkOkYOsQ5FUoVAa181zhaNbxVk=;
 b=LHE4n5sSBtUqE6LivQ1RXDbQarAFhIfkAgTTHGGMxe45v6G2mVvUV07q0u8PYjyDvkF1Lu
 UhYnC5eFnHRFq0lKHMfidOmoBWnYN5Av9pIpi2va4eP9YnCGyPpXQbN2gchnWHiMslzA5vAz
 X1sGn56/Q+itzx7gs90PsYtg0mQlQT6v1lwuz0Y0rX72huyM0Si8li4uHAoz4j3vRIir6Ojf
 26tghdyNJYoBrxtTIJ1pWswU/NuebsxnADw6gC8mIKI50/hBJiYMRThJRo9F5H5CbOR8Q6oX
 y0sGBlw2WMSPsn7gVd7AfPOBr02YpKcFKEB6q3Ap0Wn0tdLEZJdIjODA==;
Message-ID: <22e57c125201eae8993aeaaa6fb49a5d9ccfa3c7.camel@siemens.com>
Subject: Re: [PATCH 1/3] cobalt: Prepare for new signature of
 __request_percpu_irq() in 6.19
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Mon, 16 Feb 2026 12:22:50 +0100
In-Reply-To: <d0042085-122f-4fb4-a47b-7a8bed8133a1@siemens.com>
References: 
	<20260216-wip-flo-prepare-for-6-19-v1-0-f7362cdd2532@siemens.com>
	 <20260216-wip-flo-prepare-for-6-19-v1-1-f7362cdd2532@siemens.com>
	 <0c22f949-8bf2-4566-aa37-10baca291b5c@siemens.com>
	 <07bf64686c2fe140c55cd6d3b38a00f0b603024e.camel@siemens.com>
	 <d0042085-122f-4fb4-a47b-7a8bed8133a1@siemens.com>
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

On Mon, 2026-02-16 at 12:16 +0100, Jan Kiszka wrote:
> On 16.02.26 12:15, Florian Bezdeka wrote:
> > On Mon, 2026-02-16 at 12:11 +0100, Jan Kiszka wrote:
> > > On 16.02.26 11:58, Florian Bezdeka wrote:
> > > > Since 6.19 the signature of __request_percpu_irq() got one addition=
al
> > > > affinity parameter.
> > > >=20
> > > > A new Linux version specific wrapper cobalt_request_percpu_irq() is
> > > > introduced to hide the signature change between different Linux
> > > > versions.
> > > >=20
> > > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > > ---
> > > >  include/cobalt/kernel/dovetail/pipeline/irq.h      | 20 ++++++++++=
++++++++++
> > > >  include/cobalt/kernel/dovetail/pipeline/pipeline.h | 10 +++++-----
> > > >  include/cobalt/kernel/dovetail/pipeline/sirq.h     |  8 +++-----
> > > >  kernel/cobalt/dovetail/tick.c                      |  8 ++++----
> > > >  4 files changed, 32 insertions(+), 14 deletions(-)
> > > >=20
> > > > diff --git a/include/cobalt/kernel/dovetail/pipeline/irq.h b/includ=
e/cobalt/kernel/dovetail/pipeline/irq.h
> > > > index 55d9b8ff17cd08e5e8c09aec393a1e23736c1b76..ac780a4bb3223889ccf=
827b5b8cb279035a5dd7b 100644
> > > > --- a/include/cobalt/kernel/dovetail/pipeline/irq.h
> > > > +++ b/include/cobalt/kernel/dovetail/pipeline/irq.h
> > > > @@ -5,6 +5,26 @@
> > > >  #ifndef _COBALT_KERNEL_DOVETAIL_IRQ_H
> > > >  #define _COBALT_KERNEL_DOVETAIL_IRQ_H
> > > > =20
> > > > +#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 19, 0)
> > > > +static inline int cobalt_request_percpu_irq(unsigned int irq,
> > > > +					    irq_handler_t handler,
> > > > +					    unsigned long flags,
> > > > +					    const char *devname,
> > > > +					    void __percpu *dev_id)
> > > > +{
> > > > +	return __request_percpu_irq(irq, handler, flags, devname, dev_id)=
;
> > > > +}
> > > > +#else
> > > > +static inline int cobalt_request_percpu_irq(unsigned int irq,
> > > > +					    irq_handler_t handler,
> > > > +					    unsigned long flags,
> > > > +					    const char *devname,
> > > > +					    void __percpu *dev_id)
> > > > +{
> > > > +	return __request_percpu_irq(irq, handler, flags, devname, NULL, d=
ev_id);
> > > > +}
> > > > +#endif
> > >=20
> > > Please use a define for request_percpu_irq on older kernels that uses
> > > the new signature and resolves to the old one via __request_percpu_ir=
q
> > > as needed.=C2=A0
> > > Yes, also switch to request_percpu_irq directly because
> > > __request_percpu_irq is going to be removed in 7.0.
> > >=20
> >=20
> > request_percpu_irq() doesn't allow us to specify the=C2=A0flags. IRQF_O=
OB and
> > IRQF_NO_THREAD would be needed.
>=20
> Then request_percpu_irq_affinity - whatever survives 7.0 already as well.
>=20

No flags as well.=20

I was not aware of __request_percpu_irq() being renamed in 7.0. Will try
to find something else, but that doesn't look promising at the moment.

