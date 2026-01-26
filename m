Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D739D3BB4A
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440320; cv=none; b=EDQuDqhBEbNi+ByX+V8z5FGAWIxL20O2BCEcClAMm36xVvI10yeEL5UalFpdd2RRsOVcot6WhuhFPpQDn3QgsiPN4OBUsP6tS5nq591MyRUbMo5sOtuCbv6etO0HUgEbarLDZuCyhIGPofq6eGosdHhytFD9uMnLYkjxX3/Euwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440320; c=relaxed/simple;
	bh=zvux5hnsA1dNCPJJC3UQrzX/YTdAdMqpFoOQhVt2AVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8tQYH9SOxAnywMXOIBzsAsKMqJ/zHqOBv5qzDOSFddnzRWeblOp5D42Lr5UAZupvmD3RyuV1xoYmp1DqbtWuYaeTfuAa3glxFWpc5u2QE6NPFp0XASJyWTjIkfK70Av34gy8CyP1GoUjplscl0qTIbHBDvuRO7xzVLl533TQ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=qqWIM3IO; arc=none smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="qqWIM3IO"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id BF46D43D3F
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 15:11:49 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 44FAB27E0CE3
	for <xenomai@xenomai.org>; Mon, 26 Jan 2026 16:11:49 +0100 (CET)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=sigma-star.at header.s=google header.b=qqWIM3IO;
	dmarc=pass (policy=none) header.from=sigma-star.at;
	spf=pass (spool.mail.gandi.net: domain of richard@sigma-star.at designates 2a00:1450:4864:20::32d as permitted sender) smtp.mailfrom=richard@sigma-star.at
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4801d24d91bso48564915e9.2
        for <xenomai@xenomai.org>; Mon, 26 Jan 2026 07:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1769440309; x=1770045109; darn=xenomai.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvux5hnsA1dNCPJJC3UQrzX/YTdAdMqpFoOQhVt2AVs=;
        b=qqWIM3IOhXEKk/b1omN26dEGzatZtpHK4raRjrJLZlUQurLeZPw28nz7BvD75fzg+P
         c8OQl+7jQgGxPH+ZsOQjebWZ0LbUmly0DfGL3S1/t9GpXcTAhBZgbdaX4korLNwFwQkX
         rjR6G6Ge6aKKGVbYWoFOxlbWGzatVqKvQZV2dZhWVYLYOmqNhta7Oobjlk4eEAJe5gAE
         j0TVPP5LJMUlV5wnxdh2WUK76otLRpgd4UCchZrIGraQFxUzgIrLXya8G4vNV4cg+2zT
         H7e0E6WeJBlg1h6wZUK4HqXTBBGFnPXjfBX5IaAk9iMwKJ/iEEhCRJHTwVH9R7znhY7w
         Wzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769440309; x=1770045109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zvux5hnsA1dNCPJJC3UQrzX/YTdAdMqpFoOQhVt2AVs=;
        b=WDPmCYba2Eqg5lh+QN4bSYbuXmxl1yBG3fzPUYan25gmMIqSapcuHuDcT76HpunMcg
         cO9no+XGU7DuliH3zDH0+hf9B4S2/gfjZ4d5lf1E713tVIyqwHVkH/egc7+0x39XNkgt
         yMr0CXZ22pImephPvi2bwn7wrk8z9GW6XqXXJpgMqgsO4x1DzLKy8WBDkEJi40k/tsZa
         afo+DEnI/oMO2Bm38ojw6BnREFdsVAR//+HVjk/BJy3tQSdl/7C2p9L36irV4td/1WwF
         7uGrFQlKrzRNXNWdKbZx6t4zyArHgmubX1+z6LZLBgVZQSjhLhuNHx4ABimOybY2IL/i
         3d0g==
X-Forwarded-Encrypted: i=1; AJvYcCUic/xy68XJGgPBAOvDwZTegAD0+ipkRXPj6/wvB/B7I6LY/rxEDC5ZKyYGoC20lZrJM9hue8xr@xenomai.org
X-Gm-Message-State: AOJu0YzNSyt1SF1WnvV74J8jJKZwv+T+mH92ZdG5CPGb7rkzR7b06wbU
	sQBMJmKvPByoXsgbicLaTFHdk6y8BuFymbpHGVeP2ou1kNcFodl/BZ1DOHiLRH7tCxY=
X-Gm-Gg: AZuq6aKLvLeIAnRk2tfIZ8EKHfaijzn7kV7lVMxyCshFCuCi2YrmDLPy0zc4IC7zK5f
	ixlKhzXjJZULYHcVO9+I6WkS1LZ2HISIGf7UAH1Ybk5wFoc8AETvb5Kgi0S3rNSAoD3XXRnl95p
	ltDtD0XCCexETIwwePBQdzJa2TiEaShulYU1K2zp9rSzzZxuukoi0lAx9Q/Z2QGiSSnDIpb61pI
	xDbrXW56KakrtMtwrVUkuvPG8DIYWPpyj/COfTJ/jj4tRDpkEjNUPBWGXoIzNPvpnbJzSfQ5rBc
	NRXsGSJnnQDk6K8Tvxb0ddOTWHqkGzq08MYtTcSeJgxcIZmEiidAyD6RrPEJFm4zu0yMWmk/flS
	sBhJjau/dHocQWQWRfli4y1gj4qmcjEDgbv7HqYFJmrKSeyR4OPNybc09T8733A==
X-Received: by 2002:a05:600c:4e8e:b0:480:4a90:1b06 with SMTP id 5b1f17b1804b1-4805d06c7efmr74192725e9.34.1769440308552;
        Mon, 26 Jan 2026 07:11:48 -0800 (PST)
Received: from somecomputer ([213.208.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d8a5c32sm343194095e9.11.2026.01.26.07.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 07:11:48 -0800 (PST)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org,
 upstream+xenomai@sigma-star.at
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] Allow changing CPU affinity of RT kernel tasks
Date: Mon, 26 Jan 2026 16:11:46 +0100
Message-ID: <3016173.h6DGQjDypG@nailgun>
In-Reply-To: <29de15c3-4d96-4194-9cbf-c362e9e83698@siemens.com>
References:
 <20260126125701.21000-1-richard@nod.at>
 <29de15c3-4d96-4194-9cbf-c362e9e83698@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpeftihgthhgrrhguucghvghinhgsvghrghgvrhcuoehrihgthhgrrhgusehsihhgmhgrqdhsthgrrhdrrghtqeenucggtffrrghtthgvrhhnpeetkeffffefgfeuieeivdejhfevfffghfeuffduheduuefhjedugffgleefgffffeenucfkphepvddujedrjedtrddujeekrddvuddupddvudefrddvtdekrdduheejrdefkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvdduuddphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehrihgthhgrrhgusehsihhgmhgrqdhsthgrrhdrrghtpdhqihgupeeuhfegieffgeefffefhfdpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

On Montag, 26. J=C3=A4nner 2026 15:28 'Jan Kiszka' via upstream wrote:
> This is one issue with setting the affinity "from outside",
> asynchronously. The other is that it will always imply a migration of
> the kernel task, thus a phase of non-RT. If someone forgets about this
> and sets the affinity at the wrong time, it can ruin RT workloads.

I assumed this is known and expected since changing the CPU affinity of use=
rspace
tasks as the same implications.

> This tuning gap for RTDM task is rather old. I was already considering
> to add an explicit affinity API to RTDM to set this from the driver.
> That would allow to set the affinity early, right after task creation
> and before the driver signals it is ready. Risk of such an interface is
> that people start to hard-code the affinity into the drivers, rather
> than making it configurable to userspace.

Well, the goal of my patch is improving the situation to match userspace
semantics.
People expect that sched_setaffinity() kinda works.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


