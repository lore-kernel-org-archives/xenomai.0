Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F921FA4
	for <xenomai@lists.linux.dev>; Tue, 23 Jan 2024 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020226; cv=none; b=kBxU5dnz06crE1T/xnq40gAnE1jZaiJyylsQfkuSN0fONdgFpmqMy7rLWaQtYHwV7SmgqOfZOcy/NQS0hKDBYvOq36f2B3e/yZ3fvXYibnpb2OeHKw4zPnGqzxWiuBH88lTFrxOU3SPHzJv/jz6kj4euGmxTPsETgqOopD18bYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020226; c=relaxed/simple;
	bh=27jlmauGulfNWZHHArnUNHulZ91FFIrf8D87tSIE1Oo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=WN+L/yqEIs/KRmS2/V0q+wuZqpK2Ga+cVjtT7FWsUmbocBI1F7Tabq7MIgMZhuNzNczSpmuMkLBiozJzZtQopu44Yr6LDENyCTsgwt/+1KIGt4wvqk4c8Z8kavmNLxwAY+715fx2yD4DJkmIjIYD7LZpYY9osO8pAkoLSaT8lv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5100cb64e7dso202968e87.0
        for <xenomai@lists.linux.dev>; Tue, 23 Jan 2024 06:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706020222; x=1706625022;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=27jlmauGulfNWZHHArnUNHulZ91FFIrf8D87tSIE1Oo=;
        b=eaxhobC5oCiBwfAxQ0XYjgwoAYtJeM1Q+uPU9i7RUJiw/7iXWQY5qxh+QNdGcHpFOb
         4jiLh6iGbau2GbI5X8gexCAhTukHlxfi2FBsZY2kT5qU/3l0xowxZiDJoGBxp4cPHRhP
         3g6CCggDeXpTzm98MrjDsxhVLY2wqrNi/Gcg4kaXj4DysQwwV6sq70EYYwqvnEDT3MVN
         uwDQy+rHkYDdH0H86tjtvh8pGNSmVJxyuRs2Px3/IkHZXPAsBRF6US+IahJ9rpgiCgVN
         wigL7TKh92ZmThZ2VmTgo7r+Rhg8yFlqpWRrFDLNQrhwOEYLOQVBMBaFgcvVxWWWjlPI
         WGzQ==
X-Gm-Message-State: AOJu0Yxs1ptnW+L/6sDHidNESwmoauJ4P93ZT7DSJ5z9qy9FgmyWk3ME
	Nc180SSStWyNTwy28fehDMZNde8oJpZ8YOxEu3gEwMZiSinJbz6rx/KnIFTnkxM=
X-Google-Smtp-Source: AGHT+IF0qokYJRnpgJEY0Qa39kNUsssDy/OiQ1gsCy20wzKyXkQUv3/ZZQgMFc2a4hQlWQk1KG0knw==
X-Received: by 2002:a05:6512:550:b0:50e:a2e7:14ca with SMTP id h16-20020a056512055000b0050ea2e714camr1145577lfl.56.1706020222113;
        Tue, 23 Jan 2024 06:30:22 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id i2-20020a056512224200b0050e74491b06sm2295514lfu.116.2024.01.23.06.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 06:30:21 -0800 (PST)
References: <65aab24f.050a0220.e75a1.ee69@mx.google.com>
 <87h6j5h4t7.fsf@xenomai.org> <65afcb1c.170a0220.d7f9.11b2@mx.google.com>
User-agent: mu4e 1.10.5; emacs 29.1
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?C=C3=A9dric_Ch=C3=A9pied?= <cedric.chepied@drotek.com>
Cc: xenomai@lists.linux.dev
Subject: Re: imx6 flexcan
Date: Tue, 23 Jan 2024 15:29:33 +0100
In-reply-to: <65afcb1c.170a0220.d7f9.11b2@mx.google.com>
Message-ID: <87mssw5dhk.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


C=C3=A9dric Ch=C3=A9pied <cedric.chepied@drotek.com> writes:

> Philippe Gerum wrote:
>> Real-time driver support with EVL is documented here:
>> https://evlproject.org/core/oob-drivers/
>
> Socket Interface is under construction.
>

Socket is an interface, an access point. The real meat is the stack underne=
ath.

>> There is more than just enabling an oob path for the flexcan driver,
>> such path should be enabled in the generic CAN stack as well for this to
>> work, as this was done for the generic DMA engine, the generic SPI core,
>> and the generic GPIO layer.
>
> Sounds like a lot of work. Perhaps I should consider switching to Xenomai=
 3.

It is a lot of work.

--=20
Philippe.
