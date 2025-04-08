Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7672F1B6CFE
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744134933; cv=none; b=orBNm+frlhF9amyV5AnU8S7Qd8RYC/yB++MZnKIhhD5vUuHpg/61IM2ih9ocTVQJ85IygWP8R1b6OvL4k5/17dJSoyrWvTWal5BcoSu34Ge6k6DOr+IbVSGkWY/p+qYbKHavQOQnRwM+4a4wkRNhS/oT79n6v6bqP3yCPp1mCAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744134933; c=relaxed/simple;
	bh=M1bXHeooELpmekxSGsRvcO7ZDj0icu7ujD2y1UU7VIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JoCNjK82dTRi9q6UgjPYqJOF1juC0UGuPU1QzrRf1pRYSRW0d8SqRoorBUGD8/156M2w8CRBN8SP+ZTszGFZMOAx2frZ6p3Jusiu53iA1fPruCi/vxI8C5Zn1gIkIy3l8Ii86KXHnXumyESRR3FFFNixZow+pIGVWeR2RMOAE/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=q8VkQJKL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="q8VkQJKL"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-399737f4fa4so3260507f8f.0
        for <xenomai@lists.linux.dev>; Tue, 08 Apr 2025 10:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1744134927; x=1744739727; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1bXHeooELpmekxSGsRvcO7ZDj0icu7ujD2y1UU7VIc=;
        b=q8VkQJKLC3P75i3zCLa2L6cEudDw/SkPlikFhGg4chg5yGfIs7d1Mr+4JmRoVq8eCG
         IcnRMAnvBO/CCuLYRgnxBm5MK2WCBLOhaATA2uqwwcFOtFu8ExB+ZYFszjdoHQ/kd+Ya
         PIog0ORXKdRTQpD0qSiYlq2itjIqKl6tCbwE1xnX2b0B3B+iMmhPKuuN3/arbX+c3TmI
         4A/zzd9k9zyQ7yGs+VzAfeNYPwFd0nJXoJF+v/xce00zVZ4Wr1grBS07Vnv9cFtBZLFK
         NeYkOwbLrbTCf2VAV5xNGhSmUac8XY65Qabg6aaCMQi0J56V7JEBCWC8YHgrI4ObQ+m5
         tiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744134927; x=1744739727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1bXHeooELpmekxSGsRvcO7ZDj0icu7ujD2y1UU7VIc=;
        b=cbCpi5nIMSIz2dQuSIlc79HkDbgFxN9USWc4nkGQH6onIQegmMJcRSvLE0XPKRzp2A
         YuzbxafVWYtN1zGEsu0AO3k+tSb3XANUGSeJqdKDtL5y7pBTPo47pT0i2a1nMdYPTtbc
         RBLru02M3tC65hOA2eU6HY+K3AgW9fCX6XRw4NjDFRxWP+XNsJPmLPEvK8SQTMnGgk2T
         HoaEacWFxBBSXSfL1pKTlXyqyZoJ3MARFeXy6dQTVnFRqrSHu3cc5vqHHrVj9sFpIFea
         K4XRYaKysJQvLkctLfUJVdFiBCwDHUuvwHDuOF4ImN6uzlICVX9pCif8/BTRcm8F3Vcj
         Gjlw==
X-Forwarded-Encrypted: i=1; AJvYcCWCBbk/KK3E++rAHaqbBsQT2Hrbnd4LyxBYAa2gdakxuIr/i9GWmdaPhMXnx+96jLuc6os2SSg3@lists.linux.dev
X-Gm-Message-State: AOJu0Yxdam5Zk9vCWorT07J6n0l8iaPJ35uiIvFKfLMpEtRmIgiH0Uc9
	qFEmo7fFqb1x3CB0ZhNEcmLqzl2naGa5rlzfdcp4wo6QtdHbDuxe7lSH8cDqQuA=
X-Gm-Gg: ASbGncvcDKt9xj+jK0a2LLyz3+77UcrzGjYxC58JBgnlQT7AZUzPddFORmvxHjfUfpG
	RWdM0fa+P3yHIlQ0hF4uGhslaWsjstXH+jnxsb6NYSJ6wscYAvCxY1lU39+rOAWyrvHO+SqJI9x
	pKdS+7q5R4zpsG9xGRIyqqzSOuUbo017D67Wzt/WmOI70dYuKmA6sWi3UCpezhIdyDXv7hCtsiz
	yUKdUxn0c5aak13dkNHhUkzDWgDntxvqhiSX0Zp5fs6vbfk0Y5ZsupzVDNbuDLvajpABag0F8a0
	/DAAthqm0meRmNUD5RXyC5ubt2KnJVsQBrOkMenmzZGfP0j4YU/o2pOMs8Pt7xsQhh1ONc5QmHO
	5CnXTq0a9X4Ml
X-Google-Smtp-Source: AGHT+IFnnkrweHDmfQmtSAKYppS/I6mCmD2aJP7sUYaiGOj6FhM7xJoPStfqvzuIYuaxkbZRWj+kHg==
X-Received: by 2002:a05:6000:1ac7:b0:390:f0ff:2c11 with SMTP id ffacd0b85a97d-39d87aa1285mr153622f8f.2.1744134927484;
        Tue, 08 Apr 2025 10:55:27 -0700 (PDT)
Received: from somecomputer (84-115-238-41.cable.dynamic.surfer.at. [84.115.238.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b0dbesm172015255e9.33.2025.04.08.10.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 10:55:27 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Nikolaus Funk <nikolaus.funk@sigmatek.at>, xenomai@lists.linux.dev,
 Jan Kiszka <jan.kiszka@siemens.com>
Cc: Richard Weinberger <richard@nod.at>
Subject: Re: [RFC PATCH 0/5] Dovetail: Real-time Exception Handling
Date: Tue, 08 Apr 2025 19:55:26 +0200
Message-ID: <3955601.ZKlY2gecqU@anvil>
In-Reply-To: <4c59337c-4cfe-48b7-85bb-2410e71a642a@siemens.com>
References:
 <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
 <4c59337c-4cfe-48b7-85bb-2410e71a642a@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Dienstag, 8. April 2025 18:58 Jan Kiszka wrote:
> On 08.04.25 14:34, Nikolaus Funk wrote:
> > From: Richard Weinberger <richard@nod.at>
> >=20
> > This is the Dovetail side of the real-time exception handling
> > (aka real-time signal) feature.
> >=20
> > In its current form, it's a bit larger than expected because it also
> > includes the signal frame helper functions. It's debatable whether
> > these should be part of Dovetail or Xenomai.
> >=20
> > The smaller, but much more important changes are for ARM32 and
> > ARM64. These allow fast return from exception handling so that
> > Xenomai can decide whether an exception should be propagated
> > to Linux or not.
>=20
> Is this targeting latest dovetail (6.14.y-dovetail-rebase) or something
> older? Did you already look into how well backporting works? Just to
> collect already information upfront.

It is based on v6.14-dovetail1-rebase.
So gar porting to other releases worked okay'isch.

In ARM64 this changed caused a little friction:
2e8a1acea859 ("arm64: signal: Improve POR_EL0 handling to avoid uaccess fai=
lures")

Thanks,
//richard


=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


