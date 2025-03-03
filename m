Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507AC78F40
	for <xenomai@lists.linux.dev>; Mon,  3 Mar 2025 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011614; cv=none; b=hMy1tbV9AdZAhnlQU+oGC1Q8zfSXTzQK+bwcDBNiF/+nwcM3o8NMFJs8j721bDx90RBlm4EAiIP6rdfCFPkankd5Cbj6a5YexlyBGTApZlbRsvEDQe4rJl07lAmZlLoad8q/nK5+c4A5nreAqfYgdr4Je2K9E9SriUOrHk3bjmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011614; c=relaxed/simple;
	bh=q4gDCu81jj1JzAsIAXsu8cc98M2qu1XtSP+5XSCKUnE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s/DdS2WfQW4v+v0FSodXrHxLqBfwtWQYBagJE3ray9vHaEnOGzenheKPrFvENjlGTloUD74BOUGhIFa2F991fOOnG/VriAaNjSOiK/rJRBRspsHmX8wwiNVqii1tHRzLUwHw4zyiYwkl0ghlBP1/oRr4Ajh/x3VI4cYa9hNbI/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=JNl0PUTu; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="JNl0PUTu"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250303141958c4fc2021398868b373
        for <xenomai@lists.linux.dev>;
        Mon, 03 Mar 2025 15:19:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zZTQvogfA6pvyeKRNsY7aLRzlJunn7qJDU2/R7upnF4=;
 b=JNl0PUTu04NEoQFB74ik2XluoK1818NCzv8G2Y3kdcJ/nSCbopv6nKixxdo/PiM3HKBsIN
 bltdaPOJrCriIaGd/YOqSoodMgw9ySMfEVJe22Q29E41zY8GVY+mpZLqkyvrL0HzSiOgfq7e
 /PU2qr9w9Ah8XgiQgaY/SZ+0P2fQItKDwt1yCtgDvYRx/Xe8Ufoe9PmflZ/VyvLzdHYrbdUJ
 Of7kAeLnhpPw41T+DcXgm7H0mdVJTZ/gMlw1a+i7MnojVKEc/8T5QSq387EiLx1CEJxN230I
 ydnLkMzlzDohdbA6aVyPzJ0h7zwh7GK9JO0lr3lLozB5ZOY5qfqbzFDQ==;
Message-ID: <3f7587adac06cf5384e763c364baa55733d3ced4.camel@siemens.com>
Subject: Re: [Dovetail] v6.14: fix up to oob page pool
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
Date: Mon, 03 Mar 2025 15:19:58 +0100
In-Reply-To: <87ldtm2ogz.fsf@xenomai.org>
References: <87ldtm2ogz.fsf@xenomai.org>
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

On Mon, 2025-03-03 at 15:11 +0100, Philippe Gerum wrote:
> Hi Florian,
>=20
> For some reason, the hunk below disappeared from the Dovetail v6.13 code
> when rebasing on v6.14-rc, this causes a crash at boot when
> CONFIG_PAGE_POOL_OOB is turned on. This fix up should be merged to:
>=20
> e4ecbcc40e7e6 net: dovetail: add infrastructure for oob device I/O
>=20
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 7860c3a88c5d2..07ad13dd5ed2e 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -563,7 +563,7 @@ static noinline netmem_ref __page_pool_alloc_pages_sl=
ow(struct page_pool *pool,
>  		return pool->alloc.cache[--pool->alloc.count];
> =20
>  	/* Mark empty alloc.cache slots "empty" for alloc_pages_bulk */
> -	memset(&pool->alloc.cache, 0, sizeof(void *) * bulk);
> +	memset(pool->alloc.cache, 0, sizeof(void *) * bulk);
> =20
>  	nr_pages =3D alloc_pages_bulk_node(gfp, pool->p.nid, bulk,
>  					 (struct page **)pool->alloc.cache);
>=20

I will take care of that. I'm currently rebasing on top of 6.14-rc5.

