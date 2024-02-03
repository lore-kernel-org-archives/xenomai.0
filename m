Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8351640B
	for <xenomai@lists.linux.dev>; Sat,  3 Feb 2024 23:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707004076; cv=none; b=QgSMx3LnRwXH60/P9NIJPW0fiZu8Tl7Xq+1BYmMJVVm46CVmlzLIPkhTkXoMhqn81xlGhAWco8PXj2hr0CutcPp+qUd0XlqbpFMxtjYjQvBhX+7ie2KHHcRD168M5xo9419+Zxz0Mtxb9ZzcyhCt1LZPpXXq5CH9GbrUe9kbWxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707004076; c=relaxed/simple;
	bh=6M8qVquTisg5Nyq7qniqwToXIfu0mrMIyzy8dCuSnek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bm0q4e67DTqFY8hBZ5AUpl6HR5xtHYZUC4YWHBPcYUvWbRO+Pm4vwzRaVkWA7j91tIS2zmERYhu3FOdVshC0Tap8nZE0EnyZCdsWKOmUmR3TIyvxX0dWFh91g9wyi3uthSxCNw7oUtD9r+7j06R5Mdm+5ub1TJaISMZrZSVtt+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qcm3Qpwi; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qcm3Qpwi"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bfcd76fc58so311517b6e.0
        for <xenomai@lists.linux.dev>; Sat, 03 Feb 2024 15:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707004074; x=1707608874; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6M8qVquTisg5Nyq7qniqwToXIfu0mrMIyzy8dCuSnek=;
        b=Qcm3QpwiIUG187rz6iWSTxYujYUHKqwxtPRBaaeMw8ID6i76XiKBOay5A2BTfBt+Ch
         13TQec5JlhAC3aYYHKbgGOr9BqCJEUhOdvO0ZlRTSwDgnRhX6Q9PSPzDKtJuhmqgRrEX
         4ooEiF/MuHjHN4+yD4n7LF5f+64Zv/moVB/2EErE8GC42xUBYIRVC9IGO26YUpGzv5sb
         9ER8h3Qh6NGfSTj7C2GrOqaYrA9rOzqWx/anEGUVX6vfzCdAOyZEbdZ2qHIvL//yfM3q
         MqTwJTWjV50wCQWPz6wW6SUYhWxHQqDSAwhZ8Pa14Uqgkr62apFKwaM6BkGZE2ZO4xZN
         6ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707004074; x=1707608874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6M8qVquTisg5Nyq7qniqwToXIfu0mrMIyzy8dCuSnek=;
        b=nx3JmZVxMFm03yf2/JZqTnVaHCvkg7pKvh4VGN1hU1Qv6icvgD2psLWVU2PJyxEZfU
         wBiUc0/0alS5J/AmdfjoOlfUm5b0Jz7rDnSPvBa6i5XPEh6NiOrhZ3xfn2Z3sfIBxC0c
         Fq2um2+RrsDRjrjdMYzVT5quGrYSgk0jXggC454BMh+O32ROTnQRGhgusG4d5SPOXIQX
         WwHHZrN8XHV6cCXHlHE4Z4wxoOXJtckXO3TVf30WOI6J4rJ4ACn6/dtNiAM1ISxDiSAw
         axn4phcgNB422Hhdhd3FuFxuwl8/LWEpOMW/5EbkX2lHPTl+6bCzuqy6J4Mhov2uJBoE
         +TRw==
X-Gm-Message-State: AOJu0YzkVsynbVeGZrPrZRsvYmkyBQcthZ9+Zpv9jZCWcKQIfr/KiNOr
	ILEKIk/7huI3dYcMRvFwwakBj4l7z95Hktl8dFbvLdEFwGe6YPcdBTD/PlOxi8l7cYdD3HdtQeH
	tqBw6pwweVSflPGiBW89dY1c6ZT4=
X-Google-Smtp-Source: AGHT+IGpS/RsbRygGsjjD5ChQ0oi2YjJmDCLVDLS+8L3Ewn8k3u61t5ImTo9tuBL5HSpC47st9RMDOiqWMnR7QRkKXE=
X-Received: by 2002:a05:6808:d54:b0:3bf:bcd5:361f with SMTP id
 w20-20020a0568080d5400b003bfbcd5361fmr8751193oik.3.1707004074032; Sat, 03 Feb
 2024 15:47:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com>
 <CAFLxGvyy2r5dWUVNbXHtT6W=60DAByh63hi+1U_ynjrECtHvLA@mail.gmail.com> <3020e412aeca8625d054d72bed65c1a16128db7e.camel@siemens.com>
In-Reply-To: <3020e412aeca8625d054d72bed65c1a16128db7e.camel@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 4 Feb 2024 00:47:41 +0100
Message-ID: <CAFLxGvyQhUqHJbanQN0Zc128Qs2Bkd=MM7exo-HNELZnxe3ueQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Add 32-bit compat support for arm64 to xenomai
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev, rpm@xenomai.org, 
	jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 12:02=E2=80=AFAM Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
> On Fri, 2024-02-02 at 18:08 +0100, Richard Weinberger wrote:
> > I don't know how I missed your patches but I spent yesterday the whole
> > day with the very same cleanup. :-S
> > What I miss in your changes is the VDSO handling.
> > By default aarm64 does not offer AT_SYSINFO_EHDR, so
> > cobalt_lookup_vdso() will fail.
> > Enabling CONFIG_COMPAT_VDSO on aarm64 is tricky because you need
> > wither clang or a second cross compiler.
> > In my version I'm using a fallback to sc_cobalt_clock_gettime/64().
>
> just forgot: I can't recall the correct / concrete names, but we simply
> set something like CONFIG_CROSS_COMPILE_COMPAT or
> CONFIG_CROSS_COMPILE_COMPAT_VDSO.

If you set CONFIG_CROSS_COMPILE_COMPAT to a arm32 cross compiler,
you'll get COMPAT_VDSO.
But sadly, that's not so easy on various build systems.

And I'm on Xenomai 3.2.4 (yes, yes, I know...).

> IIRC, the debian build process (or the Makefile machinery of Linux)
> takes care when you set CROSS_COMPILE in combination with COMPAT_VDSO.
>
> Thanks for all your input! Very valuable!

You're welcome!
I'm glad to see that I'm not the only poor sod that has to deal with
compat applications. ;-)

--=20
Thanks,
//richard
