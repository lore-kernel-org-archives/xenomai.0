Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B811E4B2
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118312; cv=none; b=Ymtn6EWdcN79yScYuin6JyVLO1OniQw9tU17QcD2jYdlcjQzjcdHvehBC+A7c80ur3qyr3D3SsfDmUGIhCK4NFPQt8H8HBWIQXppDhpLeiz0UmSQSbj+WBFcJI2yNfKnosnZDesKSQ5vLriHB3qF1lJvjOup3IUFxbUOQhaP+30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118312; c=relaxed/simple;
	bh=zzC854hfAKDR0YZmkhshANXjo5JYbSwwQ3+HIrSD6Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdHSM8SeV54l6n9XQHFn2g7p4LTAv91+4BnnV3KDS5NTSAsiKGTC33IHlbs97sVTnxuF4C1y7vEr/1fuzJafMkVeXaHm+HSR4/YIjZE40YW1T1CrFKuMCm1zcYdgCDhDVgWOrCCd3mu3jvbXcYSRCPlVqwUmmI2RfQlEs8ukjDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=MujRJiMH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="MujRJiMH"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so50467855e9.0
        for <xenomai@lists.linux.dev>; Tue, 08 Apr 2025 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1744118308; x=1744723108; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sr7pyx6G7DaZ2TXOgO8rmZY0iAjqKjLc8516dk2lMDI=;
        b=MujRJiMHLzZ3i9dafCHMLfhxzQ3hjuXAXHfrspucm5vUX5kSpe0bMvUw4GoJoMzBuN
         quXAFOl91zakpBEvhmBsPbTONExxIv+9rydlqeW6moqQZxNLHcMoyx/oYOi4pNbIQP18
         07TTXNbeIjaSUZAAP2m1FyjeopJuyEp/1xDkkvGa0t2XF5ztAQtpiL+U7rLNpwaityd8
         09joPsXIOHfFPD+I1AmSZBqYubSzV1Z3AwMHrXvOLS/0/f4IzGCRIuh2IWxzWc6Bi1dq
         9zxcTRGHKIhzZj8sRvIEQmddx3w9Phm2aER4XxOo5fvLQZlUvQXB4qH2p6AGdFyUJ6n9
         dQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744118308; x=1744723108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sr7pyx6G7DaZ2TXOgO8rmZY0iAjqKjLc8516dk2lMDI=;
        b=hj6dOwhmR7KFxuljXojlQAkU0gNbg5pHNYiXT8YXQdHcPWXZGFDVeZ6GSR2LOrKLL7
         nOCBbNdySdfAmifcmfvgipVPL/cyRru+gq4c/DXUjnLb7uUAGsAyQFEfz2a9OqVYwNjD
         UdPdu9IosXhUiywQj3kX8EWkOFT0VCc2kpLW91K4HCmq+aJKEUVyr4Y7vFOCqFdkmN7+
         IMaOL+BmdrYTvbmzuLVRJK5wI8YKvt8Lk6Z7dja3HkYil2PtygKCvYLndzD44LXl2BMw
         YMIDXAGXVr68+sTPahFYAvXYRudovXOjw/cgyLhZ6/y72qNP+yR0c6/Dgz7ltmLXGeFy
         Dd9A==
X-Forwarded-Encrypted: i=1; AJvYcCXUps/Xz5Cgn6NLEOZW/CVIx7OVtKhf5AuVyp1rflqGjFL4+hxcp7N60kKcSYvun6tawwS20y5W@lists.linux.dev
X-Gm-Message-State: AOJu0YwCSmpL9Awe7VOedcnPM2GzAEKygnui979FPY5XjzMiqT1/tbQ2
	0G/xDYi2kGSHz3lzW0sjnNeV9yf5HUDK7NreRdjEMXDygSrEuNix0vCcEgH4LXU=
X-Gm-Gg: ASbGnctoTf6bnI6qbRxg/EQyWO5uM++YdS2KwExGvGvdAjzw3x8YFBUhTBXJOCI+Qsr
	TTGh6ccoPmSVvRff5zAR+2vl0QwV1iKeBv1XLaXO2fa8wFICxbSNUBT3LYAPHZnqGIWtI8Cq4gY
	vhb+xXJsMLgcY00NrC71m2/HZPvS4oxxGQtT1TU/ETiw+dNa4PDv3Za7M8h5Q6mFuyaV3Hzxpe3
	ot7TbbI94ooC3PKV1zaWF4qtbhg+zL8qLj2HpJJyunQ8PtrLeuPEpS53bjeKTA/PAfI1wZa63DJ
	hdlMkQJDCx0djBK9j3/BbQX0jYe3eeQSgSKbIkiar4cs477BVXPaS2Xo
X-Google-Smtp-Source: AGHT+IE1RDhne2p1HFMYzwbE0xhwxWK01VW16Y2FjBaJapPt63TlgSjOtJDftqAc4RZfGDnrVPZBAw==
X-Received: by 2002:a05:600c:45cc:b0:43d:fa59:be39 with SMTP id 5b1f17b1804b1-43ecfa19d6bmr117388575e9.33.1744118307855;
        Tue, 08 Apr 2025 06:18:27 -0700 (PDT)
Received: from somecomputer ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a8952sm160538085e9.10.2025.04.08.06.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 06:18:27 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Nikolaus Funk <nikolaus.funk@sigmatek.at>, xenomai@lists.linux.dev,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Richard Weinberger <richard@nod.at>
Subject:
 Re: [PATCH 5/5] arm: dovetail: Helper functions for signal frame setup and
 restore
Date: Tue, 08 Apr 2025 15:18:26 +0200
Message-ID: <17455452.87JKscXggJ@anvil>
In-Reply-To: <609d917110db9ea8549a6cf37115554c712e44a8.camel@siemens.com>
References:
 <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
 <20250408123423.627477-6-nikolaus.funk@sigmatek.at>
 <609d917110db9ea8549a6cf37115554c712e44a8.camel@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Dienstag, 8. April 2025 15:12 Florian Bezdeka wrote:
> The different code style here (and below) is by intention?

Too many different persons have worked on this and things got
copy&pasted.

> >=20
> > +
> > +	frame =3D (struct rt_sigframe __user *)regs->ARM_sp;
> > +
> > +	pagefault_disable();
> > +
> > +	if (!access_ok(frame, sizeof (*frame))) {
> > +		goto out_pfe;
> > +	}
> > +
> > +	if (restore_sigframe(regs, &frame->sig)) {
> > +		goto out_pfe;
> > +	}
> > +
> > +	if (copy_from_user(&sig, &frame->info.si_signo, sizeof(sig)))
> > +		goto out_pfe;
>=20
> Hm... Switched the style again... I assume checkpatch would have
> complained... No?

checkpatch issues a warning, so it is a matter of taste.
But I agree, we should be consistent. :-S

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


