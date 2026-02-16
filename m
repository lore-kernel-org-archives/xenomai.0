Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A7630DD07
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249497; cv=none; b=K0l0NOtt+AQJH60jN0/PEZwmcnQTQ4Ct8Nl45gFBty6fhd0qJ2wSd7bJgoWLw/J3+9xi0xBqsSFyLKrTorT2kAuNzIMPnYcBcrySAtL8fPkSB4/CwQ9PKbXDd0A5SPXU10muQccAHMMeP+DbMjYmtSq5wywgpUDQ6mByHn0HXyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249497; c=relaxed/simple;
	bh=GT/w3WAC4pPitgLNNPzxt8rGtjKI/8tvylnAaMwppZk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XIo3KnBei7O26nxziUkXsq2hzEnlHp/zbRr9t261GzEAO9Db/X3DkinxEdQAMd2JGck194Lus9ZD7nI072NeDENS08nKEE+9ZiguFFpmzHvb6/8tYrhEOpIWI2vE17a9Pl//KM8N9FFXhHDTnCw92163uA4sKC1f4VrBoZrlyeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=el/DP10B; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="el/DP10B"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202602161344505ea8a6af1f000207f9
        for <xenomai@lists.linux.dev>;
        Mon, 16 Feb 2026 14:44:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=M72+ghR08tAscmF9y8kn+HLW5hRVfFNtufFRk0cO+Is=;
 b=el/DP10BPuU96xAf7QubmHdfSClPm5x/8CRcKR7WiHymMiWosZNvFmNmerTvi8RcK2WRzw
 fUs3kCrPDfNzAOfIEg3aDmM7HoIEkhcgJQtrXvBNZxOU841GUT1GQumol43Mt09wK+2G89td
 3rhJatKbUzU2gOBbP/FGHDHMVdBzDsKJaHRebleqfxqf/T7XmKTd/cBWOCirmeyC+cmyb53v
 7zPq8ocv1GLgj3Zflwe88bjNlec+eAxZC3tasAJ11LCxRqMTHisUYF2GFx1NTrJWLjh/C9wr
 nxr14vsguFSz0AIUkJ+YlfxBUTfxi8MwkXuhn+5TRjsBNGZ0EfNmZ4Xg==;
Message-ID: <1b3f15931ae8e2d8c17437c89bcb0a355ed2c1ef.camel@siemens.com>
Subject: Re: [PATCH 1/3] cobalt: Prepare for new signature of
 __request_percpu_irq() in 6.19
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Mon, 16 Feb 2026 14:44:50 +0100
In-Reply-To: <dd35c586-269c-40b5-b628-1c78479cfc98@siemens.com>
References: 
	<20260216-wip-flo-prepare-for-6-19-v1-0-f7362cdd2532@siemens.com>
	 <20260216-wip-flo-prepare-for-6-19-v1-1-f7362cdd2532@siemens.com>
	 <0c22f949-8bf2-4566-aa37-10baca291b5c@siemens.com>
	 <07bf64686c2fe140c55cd6d3b38a00f0b603024e.camel@siemens.com>
	 <d0042085-122f-4fb4-a47b-7a8bed8133a1@siemens.com>
	 <22e57c125201eae8993aeaaa6fb49a5d9ccfa3c7.camel@siemens.com>
	 <dd35c586-269c-40b5-b628-1c78479cfc98@siemens.com>
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

On Mon, 2026-02-16 at 12:43 +0100, Jan Kiszka wrote:
> On 16.02.26 12:22, Florian Bezdeka wrote:
> > On Mon, 2026-02-16 at 12:16 +0100, Jan Kiszka wrote:
> > > On 16.02.26 12:15, Florian Bezdeka wrote:
> > > > On Mon, 2026-02-16 at 12:11 +0100, Jan Kiszka wrote:
> > > > > On 16.02.26 11:58, Florian Bezdeka wrote:
> > > > > > Since 6.19 the signature of __request_percpu_irq() got one addi=
tional
> > > > > > affinity parameter.
> > > > > >=20
> > > > > > A new Linux version specific wrapper cobalt_request_percpu_irq(=
) is
> > > > > > introduced to hide the signature change between different Linux
> > > > > > versions.
> > > > > >=20
> > > > > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > > > > ---
> > > > > >  include/cobalt/kernel/dovetail/pipeline/irq.h      | 20 ++++++=
++++++++++++++
> > > > > >  include/cobalt/kernel/dovetail/pipeline/pipeline.h | 10 +++++-=
----
> > > > > >  include/cobalt/kernel/dovetail/pipeline/sirq.h     |  8 +++---=
--
> > > > > >  kernel/cobalt/dovetail/tick.c                      |  8 ++++--=
--
> > > > > >  4 files changed, 32 insertions(+), 14 deletions(-)
> > > > > >=20
> > > > > > diff --git a/include/cobalt/kernel/dovetail/pipeline/irq.h b/in=
clude/cobalt/kernel/dovetail/pipeline/irq.h
> > > > > > index 55d9b8ff17cd08e5e8c09aec393a1e23736c1b76..ac780a4bb322388=
9ccf827b5b8cb279035a5dd7b 100644
> > > > > > --- a/include/cobalt/kernel/dovetail/pipeline/irq.h
> > > > > > +++ b/include/cobalt/kernel/dovetail/pipeline/irq.h
> > > > > > @@ -5,6 +5,26 @@
> > > > > >  #ifndef _COBALT_KERNEL_DOVETAIL_IRQ_H
> > > > > >  #define _COBALT_KERNEL_DOVETAIL_IRQ_H
> > > > > > =20
> > > > > > +#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 19, 0)
> > > > > > +static inline int cobalt_request_percpu_irq(unsigned int irq,
> > > > > > +					    irq_handler_t handler,
> > > > > > +					    unsigned long flags,
> > > > > > +					    const char *devname,
> > > > > > +					    void __percpu *dev_id)
> > > > > > +{
> > > > > > +	return __request_percpu_irq(irq, handler, flags, devname, dev=
_id);
> > > > > > +}
> > > > > > +#else
> > > > > > +static inline int cobalt_request_percpu_irq(unsigned int irq,
> > > > > > +					    irq_handler_t handler,
> > > > > > +					    unsigned long flags,
> > > > > > +					    const char *devname,
> > > > > > +					    void __percpu *dev_id)
> > > > > > +{
> > > > > > +	return __request_percpu_irq(irq, handler, flags, devname, NUL=
L, dev_id);
> > > > > > +}
> > > > > > +#endif
> > > > >=20
> > > > > Please use a define for request_percpu_irq on older kernels that =
uses
> > > > > the new signature and resolves to the old one via __request_percp=
u_irq
> > > > > as needed.=C2=A0
> > > > > Yes, also switch to request_percpu_irq directly because
> > > > > __request_percpu_irq is going to be removed in 7.0.
> > > > >=20
> > > >=20
> > > > request_percpu_irq() doesn't allow us to specify the=C2=A0flags. IR=
QF_OOB and
> > > > IRQF_NO_THREAD would be needed.
> > >=20
> > > Then request_percpu_irq_affinity - whatever survives 7.0 already as w=
ell.
> > >=20
> >=20
> > No flags as well.=20
> >=20
> > I was not aware of __request_percpu_irq() being renamed in 7.0. Will tr=
y
> > to find something else, but that doesn't look promising at the moment.
> >=20
>=20
> Ouch, indeed, trouble ahead (or extra API needed from dovetail). If this
> becomes a blocker moving forward with 6.19, just re-#define
> __request_percpu_irq for now.

This is what this patch does, avoiding a strange function name override.

Anyhow, as this way turned out to be not future prove I might have to
provide an additional API in dovetail. Evl should have the same problem,
so reuse seems likely.

