Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795038324;
	b=rVp5IWt6hOfWyWggQY+cZhKdrZu1lgxs54zC3S6kygWeiz0zf79DfbOqQCmin0So/5S6
	 GB02UOn0Yq3UgaZk5EeOxANxRRO/i6pY0jNIgy5U32rU1rh8PgWPeTQ4hQrLvTIp/Wk7k
	 ubIrMv3sd4tgLGuKhsKBFl+XwzNRK9E+IBNdLf4J69QI6N67xZct+vkaOVAV8tV8N1BlM
	 AGuf+xqo/dBcmBNVb8jUW/z4aC2zBnoJIX+62Q6Co633krJus8I3cWdNe5mLOGkHtbPkF
	 Qq6PHlq0lQB+0T+CTq+7GyJ+yoXsGDmXAWFH1XziUQ0y3ov57+9KIAsXP6fcgHIQ1Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Bpe4dCp8JTxz2Xl3vLRtq7EtMvK+Z7FVHwQw4803J8g=;
	b=4RszBs7XMXS90I/AaCydBo2HgioyYuhjpohKZY6LN6DyRFwLaSYzfuFvGs8Ht+psyfai
	 n1KjxXziE3VC4O1TAn36KIb7HeJKfDtkMwUT4OR4Jrzu4J7k+B9/iK9AiOPlGN+eHk8q4
	 lrSOC61ZIaFJqHMfCE6U0x9PXKu57C4nYkxatBp/uZn2XtCSW5x3BCCyEwyYzgIbOf6bk
	 MR2nM30mChmGw30cTDkJl98/ftdw+QYYco966Jmq5Ikgd6d+GWZlaLXXHehkIW6hQ0Tbn
	 PLTgWYnxNQSWT1Xv1FzsjRWcmjuTbSpPSLCZw0BIjXWfLZjDjwhsdlFu93BjQtoeKTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=x04pXWpT;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B21D606A331
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 21:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B21D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=x04pXWpT
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b887ca9f5cso766719a12.0
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 13:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795038323; x=1795643123; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bpe4dCp8JTxz2Xl3vLRtq7EtMvK+Z7FVHwQw4803J8g=;
        b=x04pXWpT9HvfQNB8eVf/wED7EKvGK7tb/bM+flJBVD3kWVA2cVSPy2OZL7OHsDH75I
         z2ZI0KMxADBl5PuGxSl9B03bBy5VQ0PfQocMibWYv5Q4awRlKV9zIws/h/s0Gd6AZ9GV
         iv+kFuwWh0StgQD+zp3bo5IEYMdlVSCc/TrhZHnyubEeRESi5dFQyG0mIV+cBlrwuq8b
         TWFIDrdc17iiogMlhfalBy6Q6JXzyNPONkmY8s1MPQXvMzWwOfbkxfIjgsAA2aCsNLnQ
         hZr5E/jmP0ZDZ0tmnoOhe//tSAR1g2XyhEL5wfbq/f4g/fEt55iHNQKS793LZzCs0Wtx
         DALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795038323; x=1795643123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bpe4dCp8JTxz2Xl3vLRtq7EtMvK+Z7FVHwQw4803J8g=;
        b=OtGMnCe8RPmIjswqAvT9EoiL6X+e3yb98OSEZFH54U9YqzEFtF3GrpjDcKweVYpQ9j
         iCZKP/30Kx///dm2e3+/TXgdEYn3/BNQsAdXZg3/NT2baFH0Dfwzi2u4LTUo5VkAjotN
         zVVpURVNxstk7zuPmVs9XRtgNUFwS3tM3YoWoNCMrLEGmuySD5QkiPTJH8J02WUEPCe/
         DX5JtPZKA1NzVlvw2A4L208QqEHrfXpCuLGHW7V91ISHH47GgExH11pHaI+L+J5kDu8q
         zQ/hsPVFos1mi4IYuUqJSgB6l5zBrRAsQUuAR0rPOt/QJZJPrLfysG37UIV2+SVkVeiW
         c8hA==
X-Gm-Message-State: APuU4Z83dvPhmIROD10kQHRlghcDp4S1J7WgL511gjFR3rEA4cR/iyGw
	sTrjfWD3Op2lZ4zy2wN360MFmnSj8qvrL2DiZQYPvKJxglz0QX76mMZK
X-Gm-Gg: AYBFou1UEpo4fx97TPAw+UERCi1wIckGDs1KIaqwVOUYEJHlwMbnLisF+t3c3abrpPU
	Dxdd8mGhVqdF/COJ919qK+P4M/Dqr1FBV7n0Lxin9QuOV6lERNIzwPvxJMwIFwnO8thFixBVCkI
	NR1DbD7HoQvPdd+KYLDLTA9kJHfWCTAqvXIMUVxBB6B5oLyAlnkjhxbkoWFrmOuyiAAQtDAkELj
	DIWaVP0eeMQ0SIB4Hgl7Fn1YHxtBg6pLYUsaCnH/NmKqUbNPb2Bb9l6ubyxwzkU+yo6w8ZlfrZc
	KJD9IXilHuKhVsNd/mKV2Xt0ixHgm2yET9y8U8ZBuRyin/zrSdDJ96vZi3Wmgb57RaqqEiFKVKW
	fVCMaSWKFOm31FYkA68Nur33n/FVyLSOBhdERUb26GeGz/dNHLeEq4kVI2gRssdYrWkduNyPgYL
	1nT0a9E84ZsAHiScuy6oLV09fbY/IIFV7BdwYOWm4iRO0XOc1DLY+VMW0dsfPZUOFY6ZNj3U86n
	H+v6/WrFlom9V5u7LlLzB8DbT0G+UL3lIXN9sErbrbPmh0xfPJUjpeg2gzHsO75yUe+MEaWqAkg
	OHRGZhf7wgxejYTLdQC6DyG/HdLVUz5pKztCmhMBDhRcTJOfEy892isswXwMsF6Kj6ZkjRdOOfm
	Ua7inErh1pHZArx+zvQjOA3R8xmDsuA==
X-Received: by 2002:a05:6402:1ec4:b0:6b7:b872:27b4 with SMTP id 4fb4d7f45d1cf-6b887f13e2bmr3352110a12.21.1795038322431;
        Wed, 18 Nov 2026 13:45:22 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b88a22e1b4sm1657394a12.31.2026.11.18.13.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:45:21 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH v2 0/4] Mercury build fixes
Date: Wed, 18 Nov 2026 22:45:21 +0100
Message-Id: <20261118214521.2292680-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9222017bd591f01dd92d6cbfd34b90f5e7abe93a.camel@siemens.com>
References: <20261118140632.1080213-1-yegorslists@googlemail.com> <9222017bd591f01dd92d6cbfd34b90f5e7abe93a.camel@siemens.com>
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

On Wed, Nov 18, 2026 at 8:05 PM Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
> > The Mercury testsuite
> > also needs Florian's 454ae865 ("testsuite/smokey/alchemytests: Fix
> > build failure with core !cobalt") from wip/flo/refactor-includes,
> > which I applied for testing.
>
> Feel free to integrate that patch into your series already.

OK, I'll include it in v3.

> Could you please share the exact build configuration (./configure
> arguments) and glibc version that you are using?
>
> I want to learn if the missing includes are related to the glibc version
> or not. Should be easy to figure out. I want to make sure the ongoing
> refactoring doesn't introduce any regression.

Buildroot runs (apart from the usual --host/--prefix/... options):

  ./configure --with-core=mercury --enable-smp --disable-registry \
      --enable-testsuite --includedir=/usr/include/xenomai/

and only "-O2 -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=1" in CFLAGS.

To answer the glibc question, I built next plus 454ae865 outside of
Buildroot with these options, plain "-O2" and "make -k", so that all
errors show up:

  aarch64, glibc 2.24, GCC 6
  armv7, glibc 2.44, GCC 16
  armv5, uClibc-ng 1.0.59, GCC 15
  x86_64 host, glibc 2.35, GCC 11

The missing includes are not related to the C library. Every toolchain
fails on the same lines:

  lib/boilerplate/setup.c: mlockall, MCL_CURRENT, MCL_FUTURE
  lib/copperplate/internal.c: __NR_tkill
  alchemytests.c: fprintf, stderr
  alchemytests task-2.c: compiler_barrier
  gpiobench.c: va_start, va_end (with uClibc also va_list)

The only one that depends on the toolchain is bool. It is missing with
GCC 6 and GCC 11 (in event-1.c, mq-2.c, task-11.c and task-2.c), but
not with GCC 15 and 16, which default to C23, where bool is a keyword.

With the v2 series on top, the GCC 6 and GCC 11 builds complete
without errors.

Regards,
Yegor
