Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010804;
	b=NMSuq2GLA4WpxBy+jLxOZWESbg3Mp3Q5EqBrrK+tC+o7L1t4/oQi08vevHSZ6ENAMYWs
	 cjGixymaCUtHhsP8lCMU23TjnkNAN9bdJcasUtdK8ErGfDzE2TPeWHXOEU4HnM3ilrmRr
	 /CJQs/CMfpW/lsLugkATPYh9wqVl0b0tVD+LNH9uk2iRHDy4VINUnhZqb8CuY3iC2fiCQ
	 FA4rNrSp37SZEYwJybOZGnecZY8Aqz4+bZeR3YMTL5i5+OoeBqWToMNCidLVpWzdOeQDB
	 ml3GgcPv2oKYLJN2CFo4qYtkNdgkBxkhp9O+mwMuY/ABt4cCm5WUZDO3xHFTZRCrlRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3JyexZQDaicxXgg7gXbzeo55gtNXVS4eVQ/anaWIMwE=;
	b=nrwTkDRq8cb8RNfcDqhK7AjnupkbdkuxwKUo+D7JBR/SUQYNLpkSoG46tZi+/5jlTfSm
	 PyXBAZtBtA46zmtf8raVAGEC54/0TLxNBG+OUErFfdmZbq4M6P9d+ldT3+lo6KYjM5Xps
	 Gb+epy0CAJSESH9mEyJvbTHlD1dqA7VL3tKFQI8XMJ7C6tpppoZGENmDw7/q4ICrmBRW2
	 FTVv7qtbp1mG7RfwjcBv7zxcWxAMZSY59AwTT6jYwELKULlOSWRhDXWuPHL3vUZVro6Ak
	 +EhyEh+2Jhhc61f0XXVFbHmHUJ1ceOL75uRuvO2v+LyYLqFO21oKvV0w0fQhaX8moOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=fTjixDzg;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE934606A331
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 14:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE934606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=fTjixDzg
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c247f6687dcso139615566b.2
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 06:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795010802; x=1795615602; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3JyexZQDaicxXgg7gXbzeo55gtNXVS4eVQ/anaWIMwE=;
        b=fTjixDzgJ57vz6zLiqJc5cQ/gpXZHmYUvlfvYG7P9/VBfFHHc1X+ZVLFmbmNBstwdh
         jQBVDLlItfbjiBnV2xCLMfOxMOZTjrovIyP4RSgDb1iVlwpMNEtrJ5rYBhFM0l4SAmCl
         ht5nDI59pmsiEtBKq8kPvllHG8m7EbXns5/O7We/uaoV0sY31BNEmm+bCruhbhVrE0Xt
         xCYFra7A4/EImCSl+U/FyqgY8WNn0t4as6tsdQz++yctZX6pJXYUS6gqj4Xol+hKPcQX
         adwRDlOczWEkEDxkxnES1EU8hbtl9vg6nqbKfDancNXWrtmE5/SV0faOBwHrovZHqkEm
         eTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010802; x=1795615602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3JyexZQDaicxXgg7gXbzeo55gtNXVS4eVQ/anaWIMwE=;
        b=B1flYEtBoxJ7pPO6CyOGfGXheGaX8IRPCy02kIUBj75NLPAq/hh8jAPflN02P4BQW3
         sJgWljA3fVuFMIKS/7N4R76DpSFHtddKwwybjz5ijzJyMcwVkwBy/46tqststXPgOmI0
         yH4ui1g6dLILGSeV1yEJuHng5fSIAzPqDxOokgZK6wB/ZHoocE7CvU3ujCBy9p8mri4l
         sGOXQNGsgUqEVwV4VNp2Ra/PSgDeQNHFcyvCafw02DXlEfAi+AdZmUtqNDrQlsndWcVP
         ZltUgQ15EeWdd7zmKPs2eLZhGE37W0NNzdHnlcQ3+ft1MNJt1zFZSp4vqaOmFuarhzEN
         OSdg==
X-Gm-Message-State: APuU4Z8wHQa8P5D/3y+dLgvJKiqGGjryEdG72FRHeNd3IbtaEVTu+7K1
	zqVFHR3GPcVB3tfUcWNg7pZcFfmcK9T+FK9zgMFk+qkXdBAVTyPd8ZaF
X-Gm-Gg: AYBFou0MvxKi7zrBQcwZqFUqTZUSpfRNJd5/LMcbrRAM/ROqigm1/TUz79BhZJL1ajq
	5rQdvxHHtdzkfBwwOHAoKb4Ns1m4JlLYPxHxnEfP7DXMRp6m/vi5iIItGfHrOYLP204oQGCTYsK
	HT9Ic07ciRBK4u5h3ay+Ddq8MN0lX0sP4VWVhZsHXUysAc9ChvYYavhiimijbbfg6kmwEBXxMxQ
	ktwFziwulUHkX5UWCyZ5kwR4Vb0aSfrL04s6sU3KHCxHcK/QXFe45hTJQJJ17IvtkyfbVfpHTTk
	mpe7vKOaMcp7rfC7NiENNSIJGUEsCGV9wm4nulXGPTkEp66thvrcWGUyf+DrXFcp849CY16jpWv
	wXbJ6hxSKQGshuzeVwlUm23tPfOwCAtAzXn7jsOmTZUgU1c7ibSkXdUHqFBINFymKXrIFSf0viC
	W2q7aHGWvSNO+rrMCZBNSARhOlwAH1Ezo1v2YitfAEuMR0uMGEb3oNNb9SNUd+vkD00wPA0moEj
	uwQgXPRF0Nzc8DDwBOYvjQbF/UfryL1EhxWkad3WplqSGKr9lC9WPJzsS4DVAzUM8wQxAdWKQT+
	0awQAY0X8UkWB1vRgTnF+t6SU4ohrN64Zmcxw1oBAGNZCjD6hZklM+0k9LHAxREN/v/W2ZQVUHv
	73zpBGRWb
X-Received: by 2002:a17:907:9341:b0:c41:6de7:7dde with SMTP id a640c23a62f3a-c510df8a989mr261016466b.4.1795010802108;
        Wed, 18 Nov 2026 06:06:42 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51233c5b70sm1983666b.20.2026.11.18.06.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:06:41 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 4/5] testsuite/smokey/alchemytests: Add missing includes
Date: Wed, 18 Nov 2026 15:06:41 +0100
Message-Id: <20261118140641.1080246-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <44c1d4813cc5a3da086e98037afc254007d21dde.camel@siemens.com>
References: <20261118114909.3030884-1-yegorslists@googlemail.com> <20261118114909.3030884-5-yegorslists@googlemail.com> <44c1d4813cc5a3da086e98037afc254007d21dde.camel@siemens.com>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Florian,

On Wed, 2026-11-18 at 13:08 +0100, Florian Bezdeka wrote:
> That one might be still relevant. But: I'm wondering that you did not
> run into another build issue:
[...]
> https://gitlab.com/Xenomai/xenomai3/xenomai/-/commit/454ae865105807f2fcd49901c618f224f3dcab34
>
> I'm quite sure that this is also required for !cobalt.

I did run into it, it's the rt_pipe_read() link error I mentioned in
the cover letter as not addressed. With 454ae865 applied on top of
next, the Mercury testsuite builds fine here. As the include
refactoring will take a while, could that commit go to next (and
stable/v3.3.x) on its own?

Regarding your comment on patch 1: the wip branch includes both
headers, so it covers Mercury. Until it lands, I've guarded them with
CONFIG_XENO_MERCURY in v2.

Thanks,
Yegor
