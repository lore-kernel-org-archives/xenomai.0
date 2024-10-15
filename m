Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1FB166F34
	for <xenomai@lists.linux.dev>; Tue, 15 Oct 2024 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728986705; cv=none; b=iz+neTGZ5I6Yj7yRHZaZP9XD2k6PNIQUc1H/QqQtnPrf04hZpDQBGsfYiM9gjwwZm5yKvmsh/hdvk39M+oBpMMldzGelPZCmmTWYqefu+uw4gFtcp0ebK+ptdv0KYt0UMg16r+1ymrMLVuPkkI13AzYtezX33NuLGS2Gs54G6yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728986705; c=relaxed/simple;
	bh=mMvFTzm20U0pSPNcFq17GN7xs4tPv9m14HP0DgXFVUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJi+vl+t9NGiyHMxtmKqYVjdG4Z4WJywemYSMtxel371zhbVZeDs8BxEVatZK0LgwBvvt6UzZAMErHMMJLjD7gYjCcOBehfV1usRSoJCONckLpY4kVcuoWxTlLpL3H3jexMmpaOR0WwZeNIrCp2sbyJR5MQcIXeJZCTlJiyBNlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=sFKryOM1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="sFKryOM1"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d4612da0fso3720498f8f.0
        for <xenomai@lists.linux.dev>; Tue, 15 Oct 2024 03:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1728986699; x=1729591499; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMvFTzm20U0pSPNcFq17GN7xs4tPv9m14HP0DgXFVUc=;
        b=sFKryOM1V3uC6Lb2r9FI/SigCs+U9jhVU1EaBNPUJuh9Pemo/wVMXLtAUlR1en29Q4
         gxGrl01RdXiMHCiBzz2Zf88HWX1otA7L6/NFUzayRHxhiglKR5zPw0SwvDnjBpnoq21v
         RCsFe1Bn9tBewvsL2vzA9iU1763fUZIaXgTaqcqevQ6+k4vQleS0EE2n/VwsqMnULmyk
         ftejR+uXzatcePwEwFiU0FJcTgfg+JltgaKl2pOldBb6ovmnEejt32q3pIVsRkn7Blde
         eNRANgbYLa747McBQvoaq+8Brrh8RaLL3Boh1Ou/5H2e77TyrgpahdP+SnFTS4WSeUkl
         kmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728986699; x=1729591499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMvFTzm20U0pSPNcFq17GN7xs4tPv9m14HP0DgXFVUc=;
        b=LbGIkcSMSikwGLIiudQTXEkcxJTpX7B46jgGqw3QUOOg6SapwJaR9i4rufX5XNpxzr
         OuNB9e6ePz6n7lbE/gLr5/Z8BrPQfaftp4EjkrmKs7F3nuqPTtoJ8zOfEke7XD2feLmb
         o52S0UIerkevvkbHVDp7rdsnOu7mvWkR0kd7wcqNk/3aOvJg3lapcA5s2sqUJSx1qW+Q
         Tzthoc0AEHgJDEUidIT0apw6yr6/QebjbPIignSnmAiO+uXKaB3CHzInLQVgf+0ZCTUS
         182xUdVLCxxJksQEuZOgYYTG8EoqaV0Hixb4yHslKFauwh3ohLiNM/foSrIyqKJdawX9
         ExGA==
X-Forwarded-Encrypted: i=1; AJvYcCVrxtIbGJ1LKhFFkwxmOxFp4oMd5pLm7oQ45uhpf6tW6jSl4+Rez1jfzEywbWkLzATG2fLNHqRe@lists.linux.dev
X-Gm-Message-State: AOJu0YwimbNovZggp7doEgkcyRxXCUctdxqjcgL5kf6LwPdSHIx0LBl7
	Q/15W0h0mt3ZFS3kOOHmP/m8xNtmOuli+4SUW0Hmdj/tHtd1sIYxnwM3ZVVgNaA=
X-Google-Smtp-Source: AGHT+IHiMseGDheu3USWEfsOXDHWWI0YMPNMvMtZTodhHj3DaPIpkk3aqPXs6ij0saFnmjByKqs+Jw==
X-Received: by 2002:a5d:4241:0:b0:367:8e57:8 with SMTP id ffacd0b85a97d-37d481c24f2mr15393545f8f.19.1728986699273;
        Tue, 15 Oct 2024 03:04:59 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at. [84.115.238.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f55e071sm13021275e9.3.2024.10.15.03.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 03:04:59 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Simon Graber <simon.graber@sigma-star.at>, xenomai@lists.linux.dev, upstream+xenomai@sigma-star.at
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v4 3/4] alchemytests: Set cpu-affinity by env var
Date: Tue, 15 Oct 2024 12:04:58 +0200
Message-ID: <10419636.0AQdONaE2F@somecomputer>
In-Reply-To: <ad9d6b95-5f3d-4cf2-ad49-ede55cec7a18@siemens.com>
References: <20240902131124.37844-1-simon.graber@sigma-star.at> <20240902131124.37844-4-simon.graber@sigma-star.at> <ad9d6b95-5f3d-4cf2-ad49-ede55cec7a18@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Dienstag, 15. Oktober 2024, 12:02:01 CEST schrieb 'Jan Kiszka' via upstr=
eam:
> I suspect we have some regression here as I see a lot of heap-1 tests
> failing in qemu runners, see eg.
>=20
> https://source.denx.de/Xenomai/xenomai-images/-/jobs/918773
> https://source.denx.de/Xenomai/xenomai-images/-/jobs/918984
>=20
> Could you check this?

I'll. Simon was our intern this summer. :-)

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


