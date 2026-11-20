Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210822;
	b=GM3kmstFkfr1f1h0gKgGq+PHUAjm0przwBjbA/qtvBFaGoT2hOVoEIspyHgZl/S9kGQZ
	 QBgsamofaUcDaCakR9wouA5t6Ho7H2EPzYK2QL7pM9CAuSuICHRc5lT+fF9V4HPW9B5HR
	 UrT5gRGuY9xLX4u8fxeVikF0hBLF9Ke3RPRPvoyhMCTw18JObDZIOwuhAdXA2P0xWLy2G
	 6eUSAxXRIRs0NS2kuiDW7TiEfCngs0x1EJ6wZ+cLpyySiDOfPGlvDR/vBQA18ip7QZRvP
	 6NJMdvTgeH0qCzsr33T5PW/uIVu2qg89KDKgxBcPFSy25cND+aJjr2IWd3nSVd1mORw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Y1Y/YiU7fgyuongufAXLcbOUC06O0+nVQOq73hfDiLg=;
	b=a//xZeax6EXeebn0GPPEfAaDV8iZctn9pgEk6dOL5qsCVteaNECOMBkJsU9FAc6WfXuq
	 URtHlMorlkBX+o18+cRJ9oNF51vqcb84bjS1h+dQ26bK2CDDWTq8TlUm+Ag1jCFB57vLu
	 3Tl0dIFdbRiukTFyhJMpxG7mQrWASNNE5VWHXxLqfY2WyBZb65TrvhNn90uh9IsoJoSpU
	 rfNAe+97eOC4qV7+/61ERXsKj6nFobA6ixaoc9tpP0MDw5tLb9SVJV+QQvKanluTXq6yx
	 H5wOKEwE+cdE/dFI1PTc7PQ64WyTHIhh04/BYIBpwJ+Mnewp1v0BrU0c2HWgta8qmOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=OjNnXAwC;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CB4606A6AB
	for <xenomai@lists.linux.dev>; Fri, 20 Nov 2026 21:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0CB4606A6AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=OjNnXAwC
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c247f6687dcso210878266b.2
        for <xenomai@lists.linux.dev>; Fri, 20 Nov 2026 13:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795210819; x=1795815619; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y1Y/YiU7fgyuongufAXLcbOUC06O0+nVQOq73hfDiLg=;
        b=OjNnXAwCLsKGko4+9/rPZqubdaEkbU+Yjho4CpIECHv0S2d/QLz+Rhq/Oc2sVAh/el
         JK7DUYkHuFu1M/rLbyBcZqC9aoGIX3Nbk6qacNKjH6NHX/iejRbgFU5dKa0upe1StIjA
         5zJC+5zGtk2FZSjv9RACQxHVPwMKEB+0jwk0ier95rdvmqwkr6gvL1+T7t8olKst6Xrw
         Hd+eWLy5KLlUoC8X+eKXx8S/QIOpnXDCF320K3AIR21fq5OYRg83y6CVe5gOHcwYuMOi
         GiUBJchtpthvRLwWHnAUyqvqZlWm892zb3FyCzuwACKxu38TWsKRHmv4lSfLg0K1YWlK
         cD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795210819; x=1795815619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y1Y/YiU7fgyuongufAXLcbOUC06O0+nVQOq73hfDiLg=;
        b=X2GgQ/9nFNlj0ZvmtLaDBnTzY4gE2xVo6+zxzgeIcpWRRfNvqSL5DUnFX+cgM9IrdT
         hl7xeIpYi4OWkF19ADk6pG2whgXnBYPumK111WINq5djYqX93K0DqIr62gzOUOFRUZx3
         Wba7h9IAi6TDlyYJkc0t9wpsRIoO4+fHkaUOXPJmNP4JY/l6DyZIprIj8RkcAdUke/5n
         g7dztoPvRK7L51FE9xs8Wxv83bYJuYA+T/Ux0vmBW2Wlgf4w85yf0SQdo4rZ1iamKykc
         5xnIdiHkc169PBczHk6QxUkcu4QHaHLlDNv30QAzFrfZYNi+p5s5Tk5UDfgKElKhJF7d
         zvog==
X-Forwarded-Encrypted: i=1; AL+hErFWfmOXE//+Ce5nI17uWPhsc63uACPRwKS6QOH2P8BIakipcxJxgeZj4qr3XQ1Crsyav3ayVn29@lists.linux.dev
X-Gm-Message-State: APuU4Z9dgOmCWrj9uLsk49M5xMt2WVMJR04I1/V3gKJkkTJdrgyBjK7P
	JVfVc303Nk7eHXGg9NPb8yTi/PkP8Z1EdE+agod2t+ryamOQdIk5bmwk
X-Gm-Gg: AZFdTZc20MC0jqnbEagNsMp95H3RiuCithOqZlwqzrqTsaWP4f3WjO2SD5LyaV3bTSc
	v2l+cfvxWlbpBD9mrV+3V6lVaoBPC1hnGPoXyGhqpTBxQ0A+pv/S7IF5khtA/oiYggKsdkvUSGD
	cEdGEoa7u7zVhEipsVbTXMJxiBo2iXyh5CFMZMs9bZsBq82BvsZS5/ZlCuky4GqmcotVqDCDxvx
	vnchFzu6DvSFS0ScSOmqlN8IGhMxr1e1hCv0R2RXOdDXJTc96VNvYbtoSQlWYxRVAbNtDdhuwMY
	b4E97FelzQ/5XFKK71uXVU1DGNHUJzjBdJH8jjKfKYpPvaMprXHMwHQ1EUZiZWoDE3D4bCtO5Qp
	rBVQpoJMfv6MfpS/5axAcgL5Am6eA2J9KxyWHjDihnH3uyswHvHIlzhoSOHOwiep1WwEvnCFwH0
	m74+LAiaInba2l2z7SPX4qb6xCHCvlyqCCSRGRnl8zGhlyJFVqL1rMJ103SWETyme/7XQrrxcn3
	gyPmHAXERYFyYLo99HWhMuqGJNbZ7xKJcSNSEyMAZM2NP6E8ryYfcFJ6UvZg3WaJI07wu4hJAa4
	G99DGkzTyQ4+i/i7afWn9VmetZJrTYiJFgIRFVIb1jGUhM8CnOB5TzItVLJ8cLR916Mik39CwtC
	QcphF4MLE
X-Received: by 2002:a17:906:7d90:b0:c4c:f85f:aa12 with SMTP id a640c23a62f3a-c513aac3559mr347529966b.31.1795210819085;
        Fri, 20 Nov 2026 13:40:19 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aea3537sm133445666b.36.2026.11.20.13.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 13:40:18 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Yegor Yefremov <yegorslists@googlemail.com>,
	xenomai@lists.linux.dev,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 0/4] Mercury build fixes
Date: Fri, 20 Nov 2026 22:40:18 +0100
Message-Id: <20261120214018.3745861-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <231ed4e64e4210b736a9ef7eb41a9b86abfd5ebe.camel@siemens.com>
References: <20261118140632.1080213-1-yegorslists@googlemail.com> <9222017bd591f01dd92d6cbfd34b90f5e7abe93a.camel@siemens.com> <20261118214521.2292680-1-yegorslists@googlemail.com> <231ed4e64e4210b736a9ef7eb41a9b86abfd5ebe.camel@siemens.com>
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

On Fri, Nov 20, 2026 at 10:40 AM Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
> Thanks! Just wondering if mercury is really (still) used. At least from
> my perspective I/we did not care much about this in the recent past.

Buildroot offers both cores, and Mercury is the only option on boards
without a Dovetail kernel. The Buildroot autobuilders build it with
random configurations, which is how these failures showed up.

> - All, especially armv5, uClibc-ng 1.0.59, GCC 15
> What is the situation regarding time64_t in this scenario? Is that
> properly handled? (relevant mapping, libc macros, ...)

uClibc-ng has no _TIME_BITS opt-in: with UCLIBC_USE_TIME64 (the default,
enabled in Buildroot with kernel headers >= 5.1), time_t is always
64-bit on 32-bit targets. features.h then defines __USE_TIME_BITS64,
but not __TIMESIZE. In the armv5 and armv7 uClibc-ng toolchains,
sizeof(time_t) is 8 and sizeof(struct timespec) is 16.

For Mercury this is fine: nothing outside lib/cobalt depends on these
macros, so it uses the 64-bit time_t of the C library. The only issue is
that configure only recognizes glibc >= 2.34, so on 32-bit uClibc-ng it
sets CONFIG_XENO_LIBS_TIME64=no and warns "You're affected by the time_t
overflow in 2038", which is not true there.

Since you asked, I also built the Cobalt libraries from next for armv7
with uClibc-ng 1.0.59 (Bootlin armv7-eabihf uclibc stable-2026.08) and
found two problems:

1. lib/cobalt/rtdm.c does not build: __OPEN_NEEDS_MODE() is a glibc
   specific macro from <fcntl.h> that uClibc-ng doesn't have. This
   has been there since 89f00a2e5 ("lib/cobalt: Wrap __open_2/__open64_2
   to support _FORTIFY_SOURCE"), so Cobalt on uClibc-ng doesn't build
   since v3.1.1.

2. With a local fallback for that macro, libcobalt builds, but the vDSO
   lookup and struct timespec don't match. lib/cobalt/wrappers_time64.c
   checks only __USE_TIME_BITS64 and uses the 64-bit syscalls, which is
   right. lib/cobalt/arch/{arm,x86}/include/asm/xenomai/time.h checks
   "__USE_TIME_BITS64 && __TIMESIZE == 32", which is false without
   __TIMESIZE, so libcobalt resolves the 32-bit __vdso_clock_gettime
   (with glibc it resolves __vdso_clock_gettime64). cobalt_read_ns(),
   and therefore copperplate's clockobj, then passes a 16-byte struct
   timespec to a function that fills an 8-byte old_timespec32. I could
   not run it on Cobalt hardware, but calling a function with the same
   ABI that way under qemu-arm gives 8680820741732130394 ns instead of
   1000500000000 ns.

I can send patches for both, e.g. falling back to __WORDSIZE == 32 when
__TIMESIZE is not defined, and teaching the configure check about
uClibc-ng's __UCLIBC_USE_TIME64__, if that's the direction you prefer.

> - All:
> We mainly test and build for the current Debian releases, with default
> compiler/toolchain versions.
>
> If you need more than that, we have to make sure that we build and test
> against those versions as well. At least some build tests should be
> added. Otherwise, we will most likely break it again.
>
> Will you look into that?

Yes. Buildroot's autobuilders build Xenomai with many toolchains (glibc,
uClibc-ng, old and new GCC), so I'll report and fix breakages from
there. I can also add a few build-only CI jobs, e.g. Mercury and Cobalt
with a uClibc-ng toolchain and an older GCC, if you're fine with using
Bootlin's prebuilt toolchains for that.

Regards,
Yegor
