Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C776A18C3D
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 06:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716360803; cv=none; b=FkEDg2th5UPUq2uHCvDQFCb+s+he+evfF5H86G2+gefWyQqNF97Vijo1xvvZXLIR5faOW+WwE7tvhNGjjLeaEYX/IC+2gVRm+6VDANGqakevkaR06r7UF2kh7g2QApcse54+f3xWU7DAygl3Uz/B4U8fS/O1BNF7lAQ/oZCsV0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716360803; c=relaxed/simple;
	bh=SiZpswon9lbff3uO8sepybDZmdRXLoGnEGuS8fpi9HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJzQamrA2K5yPHEpC7iQRUamFaPk35up7g4Ni85DfP8hTyWLTQEPxNuNRazmE/pjFmglzjQpnW/ifGuLCRLJX6SSpPU3BUR9Q4z0knjBe9FdyTjeUBcFHNB+MThcKF9ad88Fo3jPLq7jj93yK3bMBpqyqTf5r1hmsTm6Cd++fGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifrhQofJ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifrhQofJ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-66986f58b43so458268a12.0
        for <xenomai@lists.linux.dev>; Tue, 21 May 2024 23:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716360801; x=1716965601; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiZpswon9lbff3uO8sepybDZmdRXLoGnEGuS8fpi9HM=;
        b=ifrhQofJInQfOeMOoh/xSgMu6BnfHKrnH/7wdOkcZ96H+JKHS84L/rMhZ4QmT8sfet
         g3FccEj6caicAAryGuXTinRDPLoei88tsVM5bNDeW2LGvR4c6qcOaLPx8KJ3S2xOvHSA
         GR8/8al1PUlYNo9+1u0I8Rg+46+CTpTw2UA+fToZJQdkeUWYuZWAm/F5aM1uAhxyuGYB
         cgE4QG4K0NoQIeVjPYPSggH5VpEyoJh2WG6QxBZLre/q4hDbbMFS5I01wMPflEZvtF+l
         fYLivGNB5LS5mMEQycPvZbbdOLvn98NYUuciZIvOGFVWI20gy5ME99PMjTeiW0YDQals
         UO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716360801; x=1716965601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiZpswon9lbff3uO8sepybDZmdRXLoGnEGuS8fpi9HM=;
        b=Kt6yMLfwz8AyRePxv6u7eiOR7RhRBVUp7KCbtv6Id6kl4fFVjWxhCOGE1ZxptY0PFs
         A61tX/IFDMKykUMlzoCx+OobuJDUJF2Ug+885gjCGUwOSEeClotcjG4VVPRdA1Mo/Nyx
         OH7VN0PAHUKsT2vYeOexEGThCDyHtifykIOPvH2JqY4bZSQdferDKZ8IBuK2DMKtLxA0
         oxTyy+ik5xprPf3n/Qinw1nQNLKQp1xj7tDFAYnn7XM9h/DQOd7XYYj+hgia1IwlOegg
         DCtDiP/XfkbZ6s29ZsdAPj6v59T1jZ2VeGgGdtBFtCz8G/KjpwjbHD1/6M64kumrEmnV
         HFpQ==
X-Gm-Message-State: AOJu0YyGr6j3BTeKWQYhrIMrPKxZfmwuzZWjCtjfN7Q8i0xBhtPkqp/I
	KnOGXkf+5bJQJCc4n/YoPynFUzM/IcUfugCOi99AewEm6kD/4kN1tofhfeEgvLbfWzUPteYFkPb
	QRUVc1TK916ampfDSaVjjAWuyNscicnkG
X-Google-Smtp-Source: AGHT+IGhuNwlfXyCtoytttgwh1Kcmf7hSuIPczLlQ5et9ScH7+SpkaLR3CHROE85LXWPIN/CBVApHbfYKeZYxVFU6JY=
X-Received: by 2002:a17:90b:68b:b0:2b6:208c:2aee with SMTP id
 98e67ed59e1d1-2bd9f604d7cmr1849056a91.20.1716360801021; Tue, 21 May 2024
 23:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <5b789e4b-5375-47fe-a49e-f48fba026250@siemens.com>
In-Reply-To: <5b789e4b-5375-47fe-a49e-f48fba026250@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 22 May 2024 08:53:08 +0200
Message-ID: <CAFLxGvxHA6fOAHs7kzs1i8stS81q68rzq4xGqbtP8NC6Q4UdDA@mail.gmail.com>
Subject: Re: [PATCH] drivers/spi: Avoid legacy functions and types
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 8:00=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Those have been dropped with 6.9, but we already have them since 4.13,
> thus before our current oldest supported kernel.

Are the supported kernel versions somewhere available?
scripts/prepare-kernel.sh should check them too.
Currently it tests only whether the target kernel is version 2.* and
aborts if so.

--=20
Thanks,
//richard
