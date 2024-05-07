Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1959214E2D0
	for <xenomai@lists.linux.dev>; Tue,  7 May 2024 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074793; cv=none; b=ANoeuGfSJlbbtTkpN7+WunRQ01ibfhiDMJCnx94bbajZ/Z29YYnock53cD0vjQ2ogpOG7I7HxuIzIsOPOr4zxEtYq1t9+mkEOXkCwVUV1vMj1kCNXcAyJnWsnL3/PKDPmdlsfJA7sVph8SkUGS+5xtyHVrY8wA7ky61YqSLywvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074793; c=relaxed/simple;
	bh=FT5WNAQt5TrvV1NQYd0R4AesT5UK5X5RGuBZMGqmUrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gx6LM0E++yAziMgmNwHZGjuTa5dXocDCoayE346mogXt/CxhvicaWVLCpM518vDR4AdB5/YRLBfUpe4bHVPA2kFfGCkUiyzSfWXiMtDxr//yzGyXulaaAD1LBLUNzw6cPGAMsnCS0d7PJXwG3AXouRdVrphzRiCFn6N6wG1CebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/elm5iE; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/elm5iE"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2b36232fa48so2051093a91.1
        for <xenomai@lists.linux.dev>; Tue, 07 May 2024 02:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074791; x=1715679591; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FT5WNAQt5TrvV1NQYd0R4AesT5UK5X5RGuBZMGqmUrU=;
        b=E/elm5iEOrw786886I2MaZXYdS9+CML9dpqmkE4JJt4oSERr9xMn3N6mGvP7AZPSYj
         aRGEXAgExcVuKcNZneENcATmDAiTGrHKugOdfGY/QXK0vh3zsaGC+rwUSWlyMfH96I/L
         8jl6gKRxh/tiyZ8GWB5vuY7ufgipaOP5nvcAKE64M42PLcnVp/ODybvweh2xkaMfvaFl
         3kt4hdsrn13nTJ9u+uImSJNbD6wAe+felW6KGwcfgdweTfMa02rrS8RmatHPkIkv5gYX
         Ebr4mesIJFFZAtHHzqw2erUgRaJENsSQUr4zvWAwIwKOuEaAfGZhc+78ibWF80xJ35H8
         qGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074791; x=1715679591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FT5WNAQt5TrvV1NQYd0R4AesT5UK5X5RGuBZMGqmUrU=;
        b=HHPSdgV7ZTHYWuV3OWP9GkL1R4CHg0BI7FKjB1GGj6Hg0aZpisNcSgjZZBifYEHeww
         eRz3Y8TVSk/xQDn7LagPXAvQdEHKe0HilOPqP7gcEce6PzXIbJsWse2Hi1GgHoIRVDLO
         8O6W+qxz8ZsBQpqtxYjOFHHjdxGG56IrjQxVJvzNhaQKGNwUP1+SuyL/ToEZ51b1aBMP
         mo7/FTBoER3Rk1kuOtO58/fuG2SvMndJFWXpRVHeDMSWO7Kk3fkvJYFTavANj8ToOFrc
         3HEv74gb7PGREQ3EVyjSoNV6RPXYwPM9NrWVl7EtCURuGTxNZoyh3pxJlLq29QC7PdTx
         d4+Q==
X-Gm-Message-State: AOJu0Yy8Q4i3foIUYtG2k7eH2bZb81oOa6oY+KXeT7QAWqSLQXhUSv+C
	ePHm9g+fveQz6RPfUVl7fN12UNstVV/FsWLUqk8qkCEvTQ/ahoUynm9F3I82Lc0c3hh17wmLkxI
	uc0fFgaTqhhiaxqcX3UWJwKTRrew=
X-Google-Smtp-Source: AGHT+IECV+7JFBuIqwY0ZPTv25vQgLaotWdAATtPlj5xRRdaQGH4jFU4xCo8piLFYQFMfrFwQY4NtcsuC+VGDg95aBk=
X-Received: by 2002:a17:90a:8581:b0:2b2:7c42:bf6e with SMTP id
 m1-20020a17090a858100b002b27c42bf6emr9935368pjn.12.1715074791325; Tue, 07 May
 2024 02:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvyY+T1qQTq6gZ5UKfbZsxcan8adyj-Y95BCEA8SYe31=g@mail.gmail.com>
 <PH7PR11MB74999755B34FF7230FCAE0F8F2092@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74998A90B5CD2F8E507A20E9F2092@PH7PR11MB7499.namprd11.prod.outlook.com>
 <CAFLxGvzU6c9fz4DAATcq19iLK+B5o6Sjtovacfu1ikr935-1Uw@mail.gmail.com> <PH7PR11MB749982301BE568CE531BB6FEF2082@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB749982301BE568CE531BB6FEF2082@PH7PR11MB7499.namprd11.prod.outlook.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 7 May 2024 11:39:38 +0200
Message-ID: <CAFLxGvwUW-+DuMGuEX8oRFQYXvPcs3GiEz5uCuZa_uDCQBx-wg@mail.gmail.com>
Subject: Re: i915 GPU woes
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 4:02=E2=80=AFAM Chen, Hongzhan <hongzhan.chen@intel=
.com> wrote:
> >What do you think about the i915 module parameters I have configured?
>
> You already set all the parameters we suggest to set for i915 like " i915=
.disable_power_well=3D0
> i915.enable_dc=3D0 i915.enable_rc6=3D0" which is to prevent integrated gr=
aphics from changing power states.
> If you already narrow down to graphics MMIO related, I do not know if it =
may help improve performance to limit
> mem used by graphics via DVMT but there is no such options in your bios.

The riddle is more or less solved.

It turned(sic!) out that the problem occurs only on systems with a
rotated screen.
Plus, only when the Intel xorg driver is in use.
By switching to xorg modsetting the problem is gone. Looks like the
modesetting driver
causes the GPU to do the screen rotation differently and the GPU no
longer blocks other
cores.
Further I had to disable frame buffer compression (i915.enable_fbc=3D0)
to get decent results.

--=20
Thanks,
//richard
