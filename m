Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9641FAC4D
	for <xenomai@lists.linux.dev>; Mon,  3 Mar 2025 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013051; cv=none; b=gpP1O3TBnTHkV28NSKxgJ7OI3Zv080sM25t2tOXXUBSJ6whNylGbNlzHXO7nz9fGfKXGSUBMjWg+HHaBZnX+F2FxavS+HTHNb/rqMCa+pZ+VAf654/PAU7x/lzWg9d1RKl9QyKIqwOk2aDpgDwXzAWc8pnzwSNP9ZGJmDfjHsS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013051; c=relaxed/simple;
	bh=fAPySB6mHpV0FOqUqANmA58KLGiYI2v69MPLjINYogQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IPk+pSfFiNQTpAbuHwaohU3KQUZIVHpRRbUxirY/nQcU511ohaUmlwoa7EwbiiKET9i/gBqKiMjGZvQq18grvMQJeiaUOLOTwflhORD8t1+u+diN0A9gkuY0fOlnut660P9yAq8emuvH+3xAphDldagTtFEcdpkyhiWuQQVe9wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZCP3a6Ie; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZCP3a6Ie"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250303144403344c1fa87b529f4eac
        for <xenomai@lists.linux.dev>;
        Mon, 03 Mar 2025 15:44:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=TZ5MGXvF03j75Ytar6cXHXK0GLz8ym2QZ4xp8wmEZ18=;
 b=ZCP3a6Ie/V7aHpyzps4BHrec7IZw6TNUj+uzWqhzyei13DMKycZZZIxgHdgJFKwJnenhdZ
 bOl59rWdXR/0Qemrav2iHWOSyHog0KE+wUWBsrcxm98eRFKXMiLx9PoOjHgt9g79dL40lsek
 bz/SlGtuWJXOCocZFW11be30ek3e3iUxpzZZ3MvlZDMU2XTkE0SwU3NwUZGEIZeDE+K9mYs/
 rmAWFkrYTezcTq9LtVKKOvZ1e9xJ48BknOOF8iYiaq2l6ZOtDTkqL6+zfNcCDlbr6mrFzr3m
 kFDypBShkPcMSaWyyBSFarsixCbOTUgwomAHhCPrFsKzdbBhqEzZUC7g==;
Message-ID: <e748f601bc89d5040995809850c8a8f00c82defa.camel@siemens.com>
Subject: Re: [Dovetail] v6.14: fix up to oob page pool
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
Date: Mon, 03 Mar 2025 15:44:03 +0100
In-Reply-To: <87frju2nu5.fsf@xenomai.org>
References: <87ldtm2ogz.fsf@xenomai.org>
		<3f7587adac06cf5384e763c364baa55733d3ced4.camel@siemens.com>
	 <87frju2nu5.fsf@xenomai.org>
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

On Mon, 2025-03-03 at 15:25 +0100, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Mon, 2025-03-03 at 15:11 +0100, Philippe Gerum wrote:
> > > Hi Florian,
> > >=20
> > > For some reason, the hunk below disappeared from the Dovetail v6.13 c=
ode
> > > when rebasing on v6.14-rc, this causes a crash at boot when
> > > CONFIG_PAGE_POOL_OOB is turned on. This fix up should be merged to:
> > >=20
> > > e4ecbcc40e7e6 net: dovetail: add infrastructure for oob device I/O
> > >=20
> > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > index 7860c3a88c5d2..07ad13dd5ed2e 100644
> > > --- a/net/core/page_pool.c
> > > +++ b/net/core/page_pool.c
> > > @@ -563,7 +563,7 @@ static noinline netmem_ref __page_pool_alloc_page=
s_slow(struct page_pool *pool,
> > >  		return pool->alloc.cache[--pool->alloc.count];
> > > =20
> > >  	/* Mark empty alloc.cache slots "empty" for alloc_pages_bulk */
> > > -	memset(&pool->alloc.cache, 0, sizeof(void *) * bulk);
> > > +	memset(pool->alloc.cache, 0, sizeof(void *) * bulk);
> > > =20
> > >  	nr_pages =3D alloc_pages_bulk_node(gfp, pool->p.nid, bulk,
> > >  					 (struct page **)pool->alloc.cache);
> > >=20
> >=20
> > I will take care of that. I'm currently rebasing on top of 6.14-rc5.
>=20
> Ok. Meanwhile, I'm preparing a patch to fix the hard irq context
> detection (inverted test of IRQS_DEFERRED). We need to have that one as
> a separate patch for backporting.
>=20

wip/v6.14-dovetail-rebase is now up to date. Tests have been triggered.

Short changelog:
- rebased on top of 6.14-rc5
- Fixed a missing Signed-off for the arm64 fpsimd patch
- Fixed the issue above (net/core/page_pool.c)
- Squashed the IRQS_DEFERRED fix into the introducing commit

Best regards,
Florian
