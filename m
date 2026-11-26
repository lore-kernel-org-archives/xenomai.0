Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795679584;
	b=dqf+G5IBixd03N7uV0eUhF/dKZqGxdZwT2LT9sZvWmDM1qs86l4+0s8/jHh191vQG08I
	 xFqvcLxg8OLrWnxxJ/DyU3ng8S4u0gDLcM0eqQHmuBhVFqWHtPV4vNXIEJk7ZvCntnf/o
	 +ycXKitRuyaCB+5aG7/8ZJmrt2qkt9GjEpDuvF2nnRtXXsKMMv1pwWkYUgZRA7x+YiHrO
	 oBkFv4NqbsSOoWutDwUpWYyvxlp6YNjxfyrtR/OK5bLRB2visAkrXS9E3AHpN6a0z+n9Y
	 63tj3ENuSEnBjN6O30gg2/eQgJN1rSsksysjXprmdu26gQ4kfFnOAnmeoqSRsg1CinQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=4NIZB1s3850k+fH/oMzzQ3kxCIeOCeRQLb1Ds4UEpaQ=;
	b=yf3gay+qL7bELNYHe9JOurJIZNWvQ60T1RWMneFVq9NCKXkcKg8Aa9tSePMAvhVCWGkK
	 N15N0GfS4V8cjeTXinu5Ox/oJVXmglSxAGJ5p9oqXv21swvY0CrtScPcTJ6O0oHVEvexi
	 dBE8udX/zpJSxnN9QQV3vW/6iCG9HsZiZh12mOSU2s0LWChpC1FQafa0oj9TS9tHqYzpJ
	 6aFQpWXDwoIF9Oqpan1IjG5Y9uKi3MeGSyLSX8RL/jK2VH9G53Oh56D16l/vVTYBxFYoL
	 P5MdcCOtGrKSbgEyvR9j2u97V0NoxztFnUFUMW/lHlwOG1L0sAwjafA8nr+hkhjHAZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sigma-star.at;
	spf=pass smtp.mailfrom=sigma-star.at;
	dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256 header.s=google header.b=LJtvCRpZ;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D2D606A31C
	for <xenomai@lists.linux.dev>; Thu, 26 Nov 2026 07:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27D2D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256 header.s=google header.b=LJtvCRpZ
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so41444295e9.0
        for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 23:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1795679581; x=1796284381; darn=lists.linux.dev;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4NIZB1s3850k+fH/oMzzQ3kxCIeOCeRQLb1Ds4UEpaQ=;
        b=LJtvCRpZ5R5RleqLzYf8lRI9YZ49Ye/r59Ulsfyei/3ulZ8xe4pTIK+tBYmC4zQG9c
         6Y0m8Akp1HgfJWHA8ybZbzJ5gxZ/nUjmjlk/nts4fWxktxU47bMDZHGAU2INCvOku4M2
         HfqG7nAZuKaIzFQHXEeSVp/LzsLjHLXjVU4qmp+Duw6uNrblLkj4CavX26Bx8GkRBu77
         zl+tVS7SoksLS+JFE7B5s32uDinGCwgaBoBJvBr+bmzKQOY++8SZ8bG2hP+ub22/b3zg
         pNW+oliJQ0lLgAMsC6EfBHe2hC3zDZ4l5OMvQaF4M8iJ+nsRi0KzCpNnvRbIpigFnnDY
         Ca4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795679581; x=1796284381;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4NIZB1s3850k+fH/oMzzQ3kxCIeOCeRQLb1Ds4UEpaQ=;
        b=wIGdp3qdrUNZ40qewtOaumbqznR7vllUbdQ1u/7DmMai/xJPjosOqXyrdFDncCUABq
         zSgT7na1iGWBnHzkgdcZGqDGYi/pOulqifP399RuGJnJ6PTcLW1b/RX28UEmmK2OBQ/4
         K2hYxCjYheINTsc+4xvQL26frM1bm9/7gzecKYVeTXCZgXDJfFX/WhlQr3XmwFEimThR
         qBlKWOdqQiqbx0SyAOftIxNP1c4TQbubk7CxILdOcRsOUZn9g+5rmoJ86QkqrM0kZPH4
         uni8N+aP8o0R85WBpU5Ba6yyZAsGW+z65Z28kJUiKLqUTHpCtf1WvaWPFDwFB+hcz4iu
         +f4w==
X-Forwarded-Encrypted: i=1; AL+hErHracgRwFCLu6EWf2rT79ufOZZU2jujTZNdrRU52MvhEP2hwjbCqdCrMMMCcRSMw61g8gdAQDQ4@lists.linux.dev
X-Gm-Message-State: APuU4Z9ertggulJ3ZSSZQIM7EdQnNutGFQmr7JLuHrWE649R7MvTp/Ys
	lkXLbdf+eLJgjkvRKIy85KnJ7zWoQ7oQqAPErCF69muwytMw/TCNCURLcktVdoE58IsvWbnVEAr
	/4ViY
X-Gm-Gg: AZFdTZesyFy3+H/C9vTrk4luUzKHkvdoUQMvWnt7L5J2YofDoUaOteKBliJhYefAyFH
	Pg0jgyoSEo3pZDH2iyRO0/3MNKS0Otl/U73fE2TWt1tApaQCFxrZuY3vPVzV3pt6JMk4mG1bbhd
	BC4JkKD9bVpeicpL/nTM3qJQvaTNC0wfEFlPBVfRvZXN3Zomr8JSJYxMw55zqkSdwaJUMURYSrP
	LdIoZpeXh9SkvkrKXLYieBP2TYRI9Z9640RsOrE60fIvGOXduRLlqmxq7Czxxq0ibpdlXGAW4iI
	hafXfxIEoFnrnNf/+jmxKCs20TmKDo84lZBfM7mXdsKyUEK10J150SB1GoWYekTRcM2jTbimBkk
	lZ/CkWrJf4I/IKn4zuWKpGpkOXwT74VTSb19/l4Lnawn6LLL/UjnA+vR2B81b/LogjfT2qdV4oF
	3HgAbWzyHMU5rs5VkyWYqWIlE37xC93lgst8/ZdqgMVRoEQw22XBuu+kiZxVg/osd6a9n98S4xY
	pnm2pqpBYEXlyGdoEJXZMgaLOK3XbWLal3T1FbT3JGtE669HtgLA44332adrHmv+EQP5ZgyPC/h
	bZEthZpGK7WR+EJkZ9bt9tkVkQYAIQ==
X-Received: by 2002:a05:600c:4f53:b0:4bb:68cc:7b94 with SMTP id 5b1f17b1804b1-4bb8616516cmr508908405e9.18.1795679581033;
        Wed, 25 Nov 2026 23:53:01 -0800 (PST)
Received: from somecomputer ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf6804sm38219808f8f.10.2026.11.25.23.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 23:53:00 -0800 (PST)
From: Richard Weinberger <richard@sigma-star.at>
To: "Richard Weinberger (sigma star gmbh)" <rw@kernel.org>,
 xenomai@lists.linux.dev, upstream@sigma-star.at
Cc: upstream+xenomai@sigma-star.at, Jan Kiszka <jan.kiszka@siemens.com>
Subject:
 Re: [PATCH 1/7] lib/alchemy/mutex: Allow any Xenomai thread to acquire a
 mutex
Date: Thu, 26 Nov 2026 08:53:00 +0100
Message-ID: <cvGNuoMaQjWhCjyESrcF6g@sigma-star.at>
In-Reply-To: <320f2a18-9b27-4583-8a1c-46b9aeddba2d@siemens.com>
References:
 <20261125213419.2363742-1-rw@kernel.org>
 <20261125213419.2363742-2-rw@kernel.org>
 <320f2a18-9b27-4583-8a1c-46b9aeddba2d@siemens.com>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Donnerstag, 26. November 2026 07:14 'Jan Kiszka' via upstream wrote:
> NO_ALCHEMY_TASK =3D=3D no owner - you are changing at least internal
> semantics, if not worse.
>=20
> I'm still in favor of fixing the docs, rather than adding this new mode
> and trying to figure out which corner cases we missed.

I hoped that you at least won't hate patch 1/7... :-D

But yeah, let's stay on the safe side and fixup the docs.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


