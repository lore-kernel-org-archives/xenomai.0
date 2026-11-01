Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793556138;
	b=EaQXc8W5u89xvC35RPXu4K7zQJu6LxDDJhbHmz4nVeiCXn3fWv656XEGCK/9/CWmxHGY
	 BcT6Lgg/WwKqVIJynnBZiKVaX86LsvmVfIjT+x2+Rpcgs1w/k1ciloMJ6cXUFfnKh3OcJ
	 qkB9gcAiiQqhtQDLT5IU0l9HtcLMg/klVO6YYTfjJksrzwaZlwBENJrxeXq4wtkgjCNp2
	 lXHrZLcKBzGyeqz2k5kfDjbRp2jSuxkWiZiP0cvNkV05fbquTjym67sQzzrozMjkEUfU4
	 L4yAwmNzJOUZQYIXnEJ4ljEe/RclGY0RKm2KdRRpsp/IEyLgIdd2fSc9Ofcn2S5m3og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793556138;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=1zUC63ZhqO0PwlRS4WF2x1QgdZ3zqLvE1HNcwo/IZnU=;
	b=v0d31dAaCbzKDUKnddQDUBquR9WRFty9s5yQnlr8aFULFJe2pkuFq/pS1rNa8wJUfmgi
	 Ghqvpv6yLOeviS5wl+FkOywvJ+tiCo4rjcXABaJBAssNI2/hL4v+EXMNVN98Co33uIEYu
	 jBuMXJ1llAB2LeIrywU55N+49HoB0gqsGainUYZppVHM+r0OI6KCoqBszUYmio4l88QgI
	 mKpWdjjp2cQISA1J/Yw4esnJvhMluMvFcBttV6S7X3LQxfkelAt9Q2oBPW0Mx1Pg5ZXem
	 VpOhSic/GGd+kXQbUk1swFUmrDwT+KONsRJ/074fFwU/DgLnvgN+rVJaYKG83V3HALg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=cAtKtg0Y;
	arc=none smtp.remote-ip=217.70.183.198
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA3A606A32D
	for <xenomai@lists.linux.dev>; Sun,  1 Nov 2026 18:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADA3A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=cAtKtg0Y
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D5FB3F467;
	Sun,  1 Nov 2026 18:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1793556128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1zUC63ZhqO0PwlRS4WF2x1QgdZ3zqLvE1HNcwo/IZnU=;
	b=cAtKtg0YGSfCAjAUo3hGQRi25FvK3xZyt8NhW+wC1ukDBJZ3Vc7nC1EY2d8T6XbpshGi95
	a8cIrVGfU1VB9focQtAQGQltCVXQdEE4BLOmeadjAr7Xrki+9YLvljwntd0wRwyxlwQh2D
	U3snaqB2xf8VM5JSZLAjWRBXKNe64nRw9s5lUeVKjM50kPdJlkFqpuVQXxpnjGqfu7HYxB
	JLb88XcfiwWwLXT1oicsF4cSqUlmIlCT0Sz+ks/KZjZCtfrZZXISMJLvouv3bjZjqTcAr9
	P2z8CbVfi3H27+uMJjKRw/16XTQgJQd0cKhrBruY6OKs4WL47Npd/tgdgbdCjg==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Florian Bezdeka
 <florian.bezdeka@siemens.com>
Subject: Re: [PATCH 7.2.y] net: dovetail: Restore accidentally lost mp_ops
 cleanup
In-Reply-To: <660c8205-c3d1-414d-8977-6ee6ce1ebe1c@siemens.com> (Jan Kiszka's
	message of "Sun, 1 Nov 2026 19:39:41 +0800")
References: <660c8205-c3d1-414d-8977-6ee6ce1ebe1c@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 01 Nov 2026 19:02:06 +0100
Message-ID: <874ie0topt.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTG4MaVXHwXPjZaWl98OAUds/uvj/jl/jIo/MTaWsK70S4LwdblQAO/SlNg34fgtrLHtiyeEx57/Mkj+btWYRoisl5flbPt1Ee7HyALwB60jY4ZlVIPRhqmwggoX0FL6bpBbNKI1M0gdewb3Mf2qAMeLpJTE4oasPAnoeGD/c7olh5u8z2M/xZvVi8ppISxLfEs2I230QkECe8H20OQma4WLkTmDY9wkYjZU9Gio0I0hIDhUeWLLLjS+dZh2HXsewOhjzq+uTBdRvjsHeamqZ8298MrAWv+lKvux2OZHybxw3ARRJ6KZo0nWZrXS9i0foPZ0mWicODD/Xvx67cOxoDtva/SSjKIphWXo+i1fZAEveVYUz+TyF2XBAY4KAoacP1H+uXP6a8NO4GUrs4RKtslF4d7bdLljrvJnsygaaPlb0aO37MzPm74/Z+X1A1X8Igh0u7EFxpev1mFh4Pr3WU38wKfOHNxsBP2TI1S0+cTgrphy3KIINvGjv0NxN+JdTDKEKI3+Vsf1K2F/DCxYc6Yp34EgOcrhrr5K3ytd1NU1QVUf3uHoHUcF+tu/FRazrBNVgZMVc/+7AQHTdhZGgoTTFWKdkEy7y2+kJY5RtH+QBbyu0vCnldbY92StVu7UnZRYTrehHinga0Vj669p10wfUAEQfGbntVryxT5waV71GQ
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Fixes: 2db757ed1c20 ("net: dovetail: enable out-of-band networking")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Should go into 7.3 as well.
>
>  net/core/page_pool.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 13ef7c723a89c..6136471425fe3 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -338,6 +338,11 @@ static void page_pool_uninit(struct page_pool *pool)
>  	if (!pool->system)
>  		free_percpu(pool->recycle_stats);
>  #endif
> +
> +	if (pool->mp_ops) {
> +		pool->mp_ops->destroy(pool);
> +		static_branch_dec(&page_pool_mem_providers);
> +	}
>  #ifdef CONFIG_PAGE_POOL_OOB
>  	kfree(pool->alloc.cache);
>  #endif

Merged into 7.2, thanks. Noted for 7.3.

-- 
Philippe.
