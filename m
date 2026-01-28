Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD93E3563FC
	for <xenomai@lists.linux.dev>; Wed, 28 Jan 2026 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769607091; cv=none; b=Bf01e6HgpC+Vc8ipeWCS9A6Qr+wSfkSiax8cHf362n0l0vBLTJFpthNMzMOvw27cgLnRNjSKr1kO8MzMcTOh2qL+xs8qKAoQ2pWWHMkaeOGhzMe83dG2xDkXxAL2ZRNEdAlvQdKYx4fixK1nN8dAdmUkkWqfQWPr1T7JoMyIu88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769607091; c=relaxed/simple;
	bh=Bq3fLdbNgmjQryzspuKkCBA/n7baXG85kTvDk158MB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rw8LFPNqi0REsiU+38L8sgMmDnJldF0cSphwheIDr8jYuINmWq2nzcIQ6z7+1k/ezTOPbdzPdYgnlfo8qEQjh2n4UaVFZA937H3ZdhxS6g1/uoA35n/Al1yxMHrhE1pcIzO52gZ6H/SBnln0cUHbzkmuwYlsBl5aR3vzuLMmQb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=FptCbY4L; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="FptCbY4L"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so99558025e9.0
        for <xenomai@lists.linux.dev>; Wed, 28 Jan 2026 05:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1769607073; x=1770211873; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17UsWEjw8BpLitEFUQdwKcADmP+CogaXbvjxqDzDhRs=;
        b=FptCbY4L2qtwDOF99YM7ncu234lnVWV8fUTwSu+zmyw4Y8Z3LodGSh2HGDWFibxuax
         pq2d3VgXcfqiBq6PY8ecM1Nkq+/dSaMrp+ldvexfWxwXO8etoBj8N4LeiLwxmcxL6sz8
         ka+A5Wz1O2lif6yYlKum72Kq8BE2y/V3fO9HqkRhW7UqEJmrBAwnzk2GjmoGLNXqdFfR
         +NTc5V+MdP4hEfsvJHSgwpNd/iSb0fGmR8BwAmYWg/q0hKK7582UYSmNeku5JJay1Nz0
         7sLpRFqHRsu2xVjUyrg+QFgfKfctZUHNT7EBQEBpTbanT+QPnJRNfm8Em7czhQkRUFZx
         pxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769607073; x=1770211873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=17UsWEjw8BpLitEFUQdwKcADmP+CogaXbvjxqDzDhRs=;
        b=KrLcbXcVzEvCwbovMVSbszR8V5kg8eDQRSQIJsQby4bH4esiQ5rn+9EoriciybUZLC
         M5M3U5KCEyoKBOKt35n0Y98YQadLz56yXrXddgwC1o2mdPZUwyIPut3QUHksB77pEaW5
         wGhD+12ziynpHufenlggb6X+FZ9UoGwwBLzd5W2MsOS1kIdkxTTKYT/wuV7QG5BdoaGm
         fONHyJMVIgWI46Kx8dm5Wrr1vsBa4IyCJZUxOpyBVXpzbT02LESsPfJW0ol0fChbUaMt
         IqxxluZ9jvj1/R7NF2Ht3QCiECBbbhdduz3P3PWA6n4vdDPxA1DrivoKTZCy7vpNopMl
         0pcg==
X-Forwarded-Encrypted: i=1; AJvYcCV2iAaxiBB9foJsljfBpsJLCBOfp+2S0wAvYwwZ0VW7TJs+IAasjCj7OCYu433RG9z7+YMrwPGS@lists.linux.dev
X-Gm-Message-State: AOJu0YzSa9B8ARheC7+LJ2DmxhaJkju5a71KtpFATWk64mzvKtKquJ1n
	6TgHOjrU22MbkjHBt74MBqGA7awiuORzl4puXWroTYZkANjiBq4LYJ9R42vQQWMOxZ6uIH6CNMn
	75X73
X-Gm-Gg: AZuq6aIYwa4T3fOzaLB1i+EoIake4vif0stBqWqTU9rjFFvEQo1LD9f+oXQp0dSL5Gv
	ja7frK4YJmSO1HZSUkCe4bmGbVJv60SMKcvxzfgTpT4k0N7FPQRDW/PtR9VQDBgQqfhsDL4I7++
	xhi3jY0pp9/W+2jx4wjIBpkDowyABYMtuRWEZEMnxv9XGGn/E89bsY9p3cc15T0HT2utr8bIk8c
	PgDtV7ErDfIUD7jFVCPU8vS26+h7P80k8gjJs4VTg2ybmRegwnW4wOVqMvQ8Cgm+lwWQfV9a5VM
	jSVEmZ/mioSb6HCmnir/tKYAUta6nrb7AopfdP3E4Du4OPez5CfT5cmp0KX1VY5wSHqvHxmvzVR
	nUUYj8uax0rm7OG5u7QQhvYET309NrY2RYDUeaXMiWFLmr9shRTdX8bLlNArKM8xpg6QFGxkmss
	/+P/0nNmZJmSlw+seBmICNvK6oYIKDE0/lm8J3jDE+44fm6iKz+BVc
X-Received: by 2002:a05:600c:1994:b0:477:9986:5e6b with SMTP id 5b1f17b1804b1-48069c78895mr64037405e9.28.1769607072493;
        Wed, 28 Jan 2026 05:31:12 -0800 (PST)
Received: from somecomputer (85-127-105-34.dsl.dynamic.surfer.at. [85.127.105.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e48a6sm7180432f8f.8.2026.01.28.05.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 05:31:11 -0800 (PST)
From: Richard Weinberger <richard@sigma-star.at>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev,
 upstream+xenomai@sigma-star.at
Subject: Re: [PATCH 2/5] Make RTDM tasks behave, part I
Date: Wed, 28 Jan 2026 14:31:09 +0100
Message-ID: <6094973.eUyiRONoq7@nailgun>
In-Reply-To: <874io5vpkl.fsf@xenomai.org>
References:
 <20260128112821.1232-1-richard@nod.at> <20260128112821.1232-2-richard@nod.at>
 <874io5vpkl.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Mittwoch, 28. J=C3=A4nner 2026 14:23 Philippe Gerum wrote:
> > +	while (!rtdm_task_should_stop()) {
> >  		ret =3D rtdm_event_wait(&k_tuner->barrier);
> > -		if (ret)
> > +		if (ret =3D=3D -EINTR)
> > +			continue;
>=20
> Using -EINTR is going to be a problem if xnthread_unblock() is called to
> forcibly wake up a kernel task from a sleep. In this case, you would not
> be able to distinguish a signal receipt from a forcible
> unblock. -ERESTARTSYS may be better for that specific purpose in the
> RTDM API.

What is the expected behavior of a RTDM task when xnthread_unblock() is cal=
led?
Currently, it will just terminate, which seems also odd to me.

With my changes it will at least revisit rtdm_task_should_stop() and distin=
guishing
between unblocking and signals is possible.
rtdm_task_should_stop() uses signal_pending().

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


