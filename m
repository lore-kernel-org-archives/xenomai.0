Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBB51BC099
	for <xenomai@lists.linux.dev>; Fri, 18 Apr 2025 06:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744957843; cv=none; b=VenpnBaTc+KFLNBh5dpn1e7GeasRMBjgo+TbBcSIvQrtsN4lgHqxivOiOTZJrh83F2NJ9v8EGhXeo6at7e+m8tIsSEYbSwyXTZU8rcYElU+ijx+31iFhJaocBcN812p+WiZHAfI9/AKd5/+EdX+R4HxaifPQYo0R65Hd+byY0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744957843; c=relaxed/simple;
	bh=mue/4ajHX0ur+oWgbfH9pMtvGbnk/sqjdq+AhBruX6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGqqiuwoLz5UOt/nhWXp+/kDU6c5H+Xd/fzDl1ZA0Ih8aYFctMEMl2bxfwyLHECLgH9WrhLWNm0zZlANVcSbj4jDI9JHpVQsrjJzrh/QepjLCUR+3FrQGIbmYtN5d49PsK2BIfZLZHYCLzJ8v/0GKddZDGQF0wS7DXUS8SJPwQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=2TvRKlGi; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="2TvRKlGi"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bfca745c7so14471281fa.0
        for <xenomai@lists.linux.dev>; Thu, 17 Apr 2025 23:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1744957838; x=1745562638; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0sHXbV7hVzbDQQ/uZOd7GyVRHKxGx/kF9C+0Bgm+9c=;
        b=2TvRKlGi7P3YNPwFVoYTHGwcsFirHOuSZL7dx29M3AWuhp6ND0IxDV/tcJjMfi0aBV
         ER2kCe4rQvsBhzFgo8dLqpBWSxmsPrqBGcQCUIqeAN6088i21QKIY9p7x47lPiPtGprv
         uTKWrLwZN+T9Ywsf+ti1kWrj49Mkw8GQBfyJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744957838; x=1745562638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0sHXbV7hVzbDQQ/uZOd7GyVRHKxGx/kF9C+0Bgm+9c=;
        b=SQbOYaQWMxNiFgstBoFt7BrI4Dm4rGWwLrJuMTparQt7e7znBHeVrQ/coQQ2jNfq7R
         lxvie2XCuRZq99yc+Sggr/eq0eepW5eJSG00lqTuwfJu0ZeqTbBO5Z16Ud2Sl9T9x8Lz
         Pew5ZwYfLSQuQDAXDePY6WN9rzobW22qHFkhzhTG0vlnscbLz7FVhDh5SJIryw1qCTCs
         t04OMzeNJePi0kqKQZDmAEytIL4nkl+8gJ+FH1j91LNJu/6DHSht9Szcb6hx0dZcazUb
         3IpF1FfLuXok7ubk5WZdZR96nU0jRSZLiPyWS/YX0WQfX9UBXvaIg1paFlLQJh7X2uJn
         BYfg==
X-Forwarded-Encrypted: i=1; AJvYcCWbAKaQRYq0V/ryjMby+KVntUQ0wn1w2Eq7vkslneCCnwdKxWKH3cQhGvGkp9+Fn0WGjrY8Sh16@lists.linux.dev
X-Gm-Message-State: AOJu0YxzXvD+i57R4XWBeoN0a0x/bH38Cue314mCEmWB5DDenUCIhJkY
	rAUjl8M06rKA0yEAZAF/Buc1X9/5EOU1w0S5Kk09LyQtHCLTln8XZqEIkDkxsiHAdoXmdjxVs9u
	47nZX6dVKKCwOqAtDvlPwok6nHSvGXgXtI2RFEw==
X-Gm-Gg: ASbGnctzo0tRWu/LB+iwUHigjFhM3EI+Csr1ANmcOOgK9A8QsH4Mf/mRB3c1VkXtvlZ
	P/QW4SS7fIOHdMzo2wEkxe2efSEnNg5aTZ+KAbBzp9lxvVzcsSMKC5gSeybhbltOVDKp0tAQUu6
	oCtenVRXC0Avj7HJhHvmC8gjPQxm3finTABPMEM8yuaJQKkcSMKD1hMPCxeMFllRBf
X-Google-Smtp-Source: AGHT+IH0YYThg39KvY9++kHbujfPmjkoyQ7pM+cqEIeTqHqXKlyKO5P5in/zoJJCbOqCwyXaLDhdEZ7mpJMk74W478Q=
X-Received: by 2002:a2e:be9f:0:b0:30c:2da3:1493 with SMTP id
 38308e7fff4ca-310905020b5mr4806501fa.19.1744957837668; Thu, 17 Apr 2025
 23:30:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADjXCUdi2vswJNN8n2BWtPgtXu_ZXDrAD5qTcNNh=ovBmw=-yg@mail.gmail.com>
 <8bc51145-3e99-4b78-87d2-7859f9c35a4b@siemens.com>
In-Reply-To: <8bc51145-3e99-4b78-87d2-7859f9c35a4b@siemens.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 18 Apr 2025 08:30:26 +0200
X-Gm-Features: ATxdqUGtct1oEiFYDyjs5X4Ql-9JpWXOOhhzHg5PlAEEp9hLpMEeAmVLTJvrD9k
Message-ID: <CAFc1U0s64TakhZUG=ym-oANAnkNsj-L=L2T3pYAtzgEwROtHkg@mail.gmail.com>
Subject: Re: [EVL_XENOMAI-4] Consistent Latency Spike at 4s on Isolated CPU
 with EVL (Raspberry Pi 4)
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Zoran KRIVOKUCA <zoran.krivokuca@smile.fr>, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thx for your answer.

Do you know if there is a "migration guide from v3 to v4" as there is
such a document for v2 to v3 ?

https://doc.xenomai.org/v3/pdf/MIGRATION.pdf

regards

Le mer. 16 avr. 2025 =C3=A0 15:33, Jan Kiszka <jan.kiszka@siemens.com> a =
=C3=A9crit :
>
> On 16.04.25 14:38, Zoran KRIVOKUCA wrote:
> > Hello,
> >
> > I=E2=80=99m working on a real-time application using EVL (Xenomai 4) on=
 a
> > Raspberry Pi 4. My application consists of a single EVL thread that
> > toggles a GPIO pin periodically using an EVL timer (evl_new_timer) and
> > logs jitter values. I'm using mmap() for direct GPIO access and
> > evl_read_clock() to measure timing.
> >
> > The thread is configured with SCHED_FIFO at priority 99, locked in
> > memory via mlockall(), and pinned to CPU 3 using sched_setaffinity().
> >
> > Overall, the jitter is low and consistent, which is great. However,
> > I=E2=80=99m observing a recurring and reproducible latency spike exactl=
y
> > around 4 seconds after starting the test. This spike only happens once
> > and does not repeat afterward. Once past that point, jitter returns to
> > normal and remains stable.
> >
> > Could this be related to a misuse or oversight in my application, or
> > perhaps some in-band task that is scheduled to run at that moment
> > despite CPU isolation?
> >
>
> 4 seconds... you have been kicked out of RT by the EVL watchdog. And
> that means you are trying to create a 100%-RT task which will starve the
> Linux on your system to death. Will not work this way. Schedule your
> work based on time or external events and make sure it completes
> eventually. 4 s is already way longer than what a task should take.
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
