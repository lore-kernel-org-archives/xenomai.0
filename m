Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612051;
	b=Lp6OGkMv3z/uEgsw0Lnndu73S5yAgxM4yNgWubpmdjXZCl8Vlx+/AJDXLm83c4cNhZDQ
	 hMmF8SlYIRDp1uKpmygwOFakS7OCPhTR2OA5uH4KvQnqN6fxHYY3XsG5WrBD+0RMl31Ol
	 aa2manQxLzTxovt7ulgfAK//BXPqPUX1eZBerqZHml84WDZZ0rSvfHtJyKXwlnEIP2SYZ
	 B9zDYS48GWhMGpdCLNaYeFc9TvAfDSZNI2v7GG9QdeozZZ8m8DpEAc7tiCCs2r0fEfYn0
	 HH0FmkKuwhyaQJ23c7zF8tKFK59nvwZZt739dSk2D9ZjZqC8LwH8T0WDc7K1YTFXZlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1XOj1Kh2JQHHm6+rwgkeXjHwAYf5ley/XaQjVx1qYrg=;
	b=LlqphDhH7GSQ7xXv83XXXq2EaBUTSkeJY4sF/yureuhI/t5m1ZgvFL/w6nE4T9q814zi
	 xO00JV/HoorXofFLEGKUGRvrj3pCdxy3Q9pbgG2hpLCAUqhxCxubJ8eAzx8H1mPHTpS8K
	 Yid201uNoiQjSBZt/zW9Oh25G2xRQQi07QBgXL0QkNUja8N4xrus/XoO4k/VmJGdIpjKk
	 LbrdpTfcKpFIUKuDm4h9Nv4PxD0SL1JVHGVRoFeva+E2xlWOgoXddPtSaQA7vLLe5Bnne
	 xihSn65pp4YS2BiBM6GYnXLoTnwKcDv8mcsLtUmR/DTnQe7ulUjdLt5yc1jPAAWI/aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=C5JdNYna;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E86A606A336
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 13:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E86A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=C5JdNYna
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b88b74e54eso7094886a12.0
        for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 05:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795612049; x=1796216849; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1XOj1Kh2JQHHm6+rwgkeXjHwAYf5ley/XaQjVx1qYrg=;
        b=C5JdNYna3Rg4l2F5mZi8MA3mBorfhIaUwhCbl2zTbVegIlN/IrlGj3ZM5cfSCuLgcF
         vFdAfcNb/m27Xbw53SjT/r1f2JMd5Hf9SgdJ/EK59DqHR51jX+rhwQmUJlXFSvpgt3g5
         ZIhcIQrKA0JLJRc3nSYE5DUVosrlzKyfBynZFEi9Tib8QnFXMGAMABevboLSds7tWaRM
         2X9MouGfEuw/7dxtY/1IOdmH0qEV/siI/u8/cFyqcColUiPX2TuCHNn1KFY8vzzhPZLc
         884kfyFI0efOPqWlGeLJwQqIOS5SIV+ZOpREuj5r8N5MPYzANu8ObSYdcHUHn0PVze7V
         88Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612049; x=1796216849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1XOj1Kh2JQHHm6+rwgkeXjHwAYf5ley/XaQjVx1qYrg=;
        b=TafehXgTd2XtyNk7qAIuMlr0MswBflH8iuAsjywMALyx/Um1iHakwcxATl00Db2SMD
         Fia/oZMFEZ2N1oOuhKDqrgKfufIg2PB0/tG4yfmAqMZhInQUdGbFFzQsDKYCSnNihzG0
         n4XoqZkIydgvtl7GdtLd9fKYTJKLM6DLwoYtYRzuotgaAp68bWcnuE5nfqaTRcUvzVBx
         qrrAhpy6ugqIabPT7sfa27gToVX28wmZro5wYreCENU6XEgre8OQt/Fx5f4BpW/9TwCA
         8bEpnP2FKpsVJCrnyGLhgjzCf0KwZrAurya+Ra3Zqnr0wKRWOWoi1JGXQ9VVLQb8JcdD
         3pug==
X-Gm-Message-State: APuU4Z/tTixtfIHAMwGk8TKFRNe/TW9xL5N5t9TVn1q40+mMLbxnzbT1
	sLBq1NVOsHV8JcwDTV+OI81M7hh7DvrAyuST8r8MDOkaajEnGYc1a/oSojHcaQ==
X-Gm-Gg: AZFdTZfXhApZXC5lVIwHVFlOG+1deRg89362LZZx3EYsMQdaPkUUDXf1EX9gshmQfhW
	VabNBGleZvQXSMkywUmX3cceGUbgn6nPbcScEcMGTVaB04kiy95wCSB3HN5HG1ZcXbV/PLDHfmG
	EhDI7hgkw2zDHWO/AcWl5rFnTYL965QMVx4dbcs2WFrwlj5yJEM+jUY+m4OZW0QGlj3DBn0G/cN
	RP74VW1U59wnmOMgGpDBeJxXtomvzmqhQgs5q44hdrwIpeBIiCli9b8Ua99a1XFefnqopCYzhYt
	pK47xYQzPe8bOsaZNWNpVsbA0CVNNx8dP7qav9NSBMJALqtuA+YA7Ris4Ngar7jTJNqKpXriNca
	tSKRIu1qh6jPoLIopg5vnE8Tpxc1BnWY/UIBzadB2ucm+HfpLOeM5/UAzH2QBgYt+9JK2lbL0R7
	RDVSYFfMSN0QbWBdPh5Fqfl4FOOt8Q4qyfyw8HJexsipxpXaGtR0kPBVv9HVqUVFtTcNaMo3SUg
	cuVYANJbSlp7IYeswj98wLYXiKJ77tT117ulfqy1R+3zuPkoOkL5s9R7my+Mj8NK8hEK10bu7aC
	0XAUAa1JhiidMIrj71TvpX1FrJc/U6MM8wFwiHPEJTJ28D6+ZKyJwPNrcHprFy29rms8g7gVPmm
	oaOL7etgJ
X-Received: by 2002:a05:6402:4416:b0:6ba:ab83:171a with SMTP id 4fb4d7f45d1cf-6baab83195fmr7268835a12.37.1795612049284;
        Wed, 25 Nov 2026 05:07:29 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370fc020sm8117730a12.25.2026.11.25.05.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:07:28 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 2/3] lib/cobalt: Select the time64 vDSO call without __TIMESIZE
Date: Wed, 25 Nov 2026 14:07:28 +0100
Message-Id: <20261125130728.621987-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <781b970cdfb894f40872da68e4f95dbe3dbf83c9.camel@siemens.com>
References: <20261124145144.3411177-1-yegorslists@googlemail.com> <20261124145144.3411177-3-yegorslists@googlemail.com> <781b970cdfb894f40872da68e4f95dbe3dbf83c9.camel@siemens.com>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Florian,

On Wed, Nov 25, 2026 at 12:44 PM Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
> Not sure if we should really rely on __SIZEOF_LONG__ here.
>
> Anyhow, we have more usages of __TIMESIZE in the code base. I'm sure
> this patch is incomplete and further issues will come up while testing.

You're right, I went through the other users. They fall into two
groups:

1. glibc symbol redirection: include/cobalt/wrappers.h,
   include/cobalt/pthread.h and wrappers_time64.c:686. These are about
   glibc providing both the 32-bit and the *64 symbols. uClibc-ng and
   musl only have the plain names, which are already 64-bit there, so
   not redirecting is correct for them and the glibc-only check is fine.

2. Kernel ABI: the vDSO selection, the select() wrapper
   (wrappers_time64.c:771) and clocktest.c:89. On 32-bit uClibc-ng or
   musl with 64-bit time_t these are all wrong: the clocktest calls
   SYS_clock_gettime with a 64-bit timespec, and select() passes a
   64-bit timeval to sc_cobalt_select. The time64 branch of select()
   also falls back to __select64, which only glibc has.

So v3 would add one helper for group 2 and use it at all of these
places, with the select() fallback picking __select64 only for glibc.
The syscall selection in wrappers_time64.c (XN_USE_TIME64_SYSCALL)
already works this way, as it checks __USE_TIME_BITS64 without
__TIMESIZE.

As for __SIZEOF_LONG__: I found no libc-independent alternative, as
musl only defines __WORDSIZE in <sys/reg.h> and <sys/user.h>. The case
where it gives the wrong answer is x32, where long is 32-bit but the
time syscalls are 64-bit. I would exclude that explicitly:

  #if defined(__TIMESIZE)
  # if __USE_TIME_BITS64 && __TIMESIZE == 32
  #  define XN_TIME64_ON_32BIT
  # endif
  #elif __USE_TIME_BITS64 && __SIZEOF_LONG__ == 4 && !defined(__x86_64__)
  /* e.g. uClibc-ng, musl; __x86_64__ excludes x32 */
  # define XN_TIME64_ON_32BIT
  #endif

Does that work for you? If you'd rather have something else, e.g. a
configure check, I can do that instead.

Regarding musl: I confirm the build is broken there independently of
this (error.h, off64_t/open64, the *_NP mutex initializers, ...; see the
v2 cover letter), so I'd keep that separate.

Best regards,
Yegor
