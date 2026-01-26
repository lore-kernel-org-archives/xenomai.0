Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C87129E0E7
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769443480; cv=none; b=m8U5MqMTCb88uu0V0Ch5RZfEn/R5qsTooffw1RBLKoXCIAT1ACOs02xpDmVDRrrHA5oB/On+oZBUcUe08WV8gQdvJFTqnpG2iNxxumDpVAcgtHU2VYahvsPkeC+F5thUdn6y8q7JMnmT50p50INiIHRMobjt8+WlVz6S1uuAydA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769443480; c=relaxed/simple;
	bh=05BqfvTURjRnuRKcLI4foLw+G4+jMXCVDV57tZic/zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKm0/DJqDW8D1d8aQq8YcwO0/7Rb+RnACh7nOq1VjICaFKX0sG7coRQQzYT/KApAxhqC/n9l9kTSAlI/91Lz3Yf98FyCRmeim7Pvvl+BS0wOO7MTi9um+pS+Np97u6AJle2LVR0vzBkxEwB1PaIrX/Ub/cwf8FYvDHedLP/bbp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=PuXHgq3W; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="PuXHgq3W"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47ee4338e01so26676775e9.2
        for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 08:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1769443476; x=1770048276; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0LiJp121UBlv+apYycdZpMYwY79dBkYg4Ia2vNs+1A=;
        b=PuXHgq3WRPGDULxkv6bfjhgSFq9Vtxpy8IyHm36H5ngDqM5JCkAXF1GpOyhfzeFvvv
         ozuSV+30zUypmTYqbcjAt0UP2jvazmySPKok078WdJGviAczSbE7TxXDB30zZO+Y7lrS
         /IoWbghKzBGc3vC6xRleqhwqgBXfXV3Mf38WeO9ZL61jKhl+oUTRdVIg1ug3qM+1Dppe
         dRMximBBmvVTjzQt9glrQf1wvJr8+RhmHaJ9c138qveQ5bLxSLo8DQxnYcCe4pgTUxWV
         TcEgh3B00aFd0MsCCVSvTwIUSsluScw9dIIb5jN/C9A1XJt/dOPVSWY3uqEaB27k3mNT
         WOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769443476; x=1770048276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x0LiJp121UBlv+apYycdZpMYwY79dBkYg4Ia2vNs+1A=;
        b=HqmkdPsQW1o3uj+Ao9dUBnXMn3uWFyMY7OzQRWyheBcsF5S09yqxfR7BuvD1wapkhW
         kblkWwiNGeU7F0C7HDsQ++KnPisyiY1l7z1gRDZBgPdxkcINBnJiHaLFPEoaJBcK5MB8
         pgt+N7q5XDRLQruqEEX7FBD2IYrSpp3AgcdEj5XjeMOXg5m62hO9xE/fjCLTmoT7GTHb
         uv1fy1nABTwdnGijKvHFmNx3i3U/GZ2qqZMRujUai6ZKMfei60iMd3KvJnlILApiE4PD
         mTFBKJLT8j7eE/Gf2Np9GHZq5Ks/ShwbcSW2WFMAX23bfkBgqMJsoTGZL2V5OnqApXCc
         kHkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuV+HZsbiEWnh2ytcclI0muxJ8/Llz0zhfS70Lk3OEe8t/Gmc0K+0NLrkpZF9V+PXW/W5V36cB@lists.linux.dev
X-Gm-Message-State: AOJu0YwN9x0tJOZvDQJzjtpny2TzvjGjevywuxmLs1Yil1a61kP4ud5o
	b2+gZPG8T0JiIDiUyMrkHpk03ZWnTMmufJBF4ucV+FfG8pcT0nuRBVu+MFsq8RDH7sA=
X-Gm-Gg: AZuq6aLKbELm/+6X0Ud5nU9tyzUqIL/bbRG2u1LY9qXMYY2SsbsXL8B3TIMrXV0KZZm
	DGfRzNQC6SKOnc0px7Upzl1qZJRuRNpqTgG90uzqWIgDcSeL6t+xKuBbS+iYcz8vEHg7vbJ900i
	mRQHXRLNWXDJiPD+n9xoeNn3/ce3vb7/ZPq+Hlub4MSTVX2Aw3JfBuXH5G/fv0OegNyTWXYqeyr
	r05d28gEahwTANHG0vykqJw+lVHwZvWl483KmSdaz/aayoQ4j7q0mNDpKs+J6m/tIIw5B43EPU6
	vTbVk6vl1aKH7geoEYpQdo9op990zBkR1bbvrNK+p3oPRSnaEW/5DLCdHok6SFRG9MYs92JMxnG
	qu223nJjRaO/ECwhncww9TrbojouWBRvP8nGYOh8pOh7RigcKmaDhdJTxya+fkrMe3mXMx0UCk8
	WL1RBkgjeZ5wg/T1x0XF7YJU43LY94291c9yCYP7733zncJb6GZX0R
X-Received: by 2002:a05:600c:6812:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-4805cf69d4emr76261695e9.31.1769443476144;
        Mon, 26 Jan 2026 08:04:36 -0800 (PST)
Received: from somecomputer (85-127-105-34.dsl.dynamic.surfer.at. [85.127.105.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d84ef51sm258206655e9.5.2026.01.26.08.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 08:04:35 -0800 (PST)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev,
 upstream+xenomai@sigma-star.at
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: Re: [PATCH] Allow changing CPU affinity of RT kernel tasks
Date: Mon, 26 Jan 2026 17:04:35 +0100
Message-ID: <49247512.Jbu8ZFrLSN@nailgun>
In-Reply-To: <e3c92da16a134131ab9f0e958da4844d7394e6e2.camel@siemens.com>
References:
 <20260126125701.21000-1-richard@nod.at>
 <e3c92da16a134131ab9f0e958da4844d7394e6e2.camel@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Montag, 26. J=C3=A4nner 2026 16:50 'Florian Bezdeka' via upstream wrote:
> On Mon, 2026-01-26 at 13:57 +0100, Richard Weinberger wrote:
>=20
> General note: xenomai@xenomai.org is the old address. Not sure if those
> mails make it to all the inboxes.=20
>=20
> New: xenomai@lists.linux.dev

rw@foxxylove:~/xenomai (next)> git grep xenomai@lists.linux.dev | wc -l
0

:-(

>=20
> > [snip]=20
> > =20
> > +static inline int __rtdm_task_should_stop(void)
> > +{
> > +	return xnthread_test_info(xnthread_current(), XNCANCELD);
> > +}
>=20
> ^ Is that used somewhere? Haven't looked into more details yet.

No. It's a helper for RTDM threads that know what they're doing
and want to call rtdm_task_test_sigshadow() at different places.

Thanks,
//richard


=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


