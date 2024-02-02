Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BECD14C594
	for <xenomai@lists.linux.dev>; Fri,  2 Feb 2024 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893751; cv=none; b=g9HJ4XH5E2LGCWSoUJqg/kQAbN5sokpaLQHoSILWCRHm4vNSYZUphtSabDNZgR7sNzfu+RRRFgSBY8FwI7NTzCoefM2Vk+TV9Z6KTF2fktNxjn4OQtMsOemjXzCABHnT1cjOw1RiakPH1cdrp4PNqnIQfQt90gp11SqRxpC/2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893751; c=relaxed/simple;
	bh=yIj23cXm33Xxihh3SKuFr+OGE6zQmYtKfw7u8E1Qr9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hx2uyWofEzGzHwjAzxVRXaNO0V+5T6G6/did7Ao7682MIIyrZTUB3stsBJzEU5Z8wqoxBvRjZpkx9yIE+okMMZZiS7i94dBfEB7c1UGcJryk/zgINXMSBMg7UJfe3HKgmpvnpcyjBWhbST8PrL8iXu3uy1QnDuYGbzchyipa9sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOcPU/yS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOcPU/yS"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6dddf4fc85dso1846109b3a.0
        for <xenomai@lists.linux.dev>; Fri, 02 Feb 2024 09:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706893749; x=1707498549; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ml1OafCapvd62h/Trgwlh8FZDiz5eK/tLQNaTLi9Ecg=;
        b=gOcPU/ySo2JLFSnWz3i7thA3/xrp7v1s+wCiEAVQL8lUiy3zwG5RxRHuB1FI01bEWA
         PA5TL5RHs9SBA9D5Rmkvq+ANN6zL6PMDDlMvBq7Q1nz8nevNQqB5fSidv6nFV3UyAuQY
         1h46VXyBhMXAyRB+iGK5e8iSaZkwuZawxKfqAX7txdUVdj6rjd9puf9QErFJ9HcPwa+g
         tYzcenHXlbtvJlJtihDiFptSUZ+oEqzdvEa6JY94OkFqe+KTs1jmb/zN8DXDft2BNRcI
         jU7latv1b6q1bw/4jgu9iCgidMpVFYALCUJR64+6HQKPdUhON9qFo4Y7xhShP8W303i2
         zS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706893749; x=1707498549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ml1OafCapvd62h/Trgwlh8FZDiz5eK/tLQNaTLi9Ecg=;
        b=lwr62oF3XVxoCPfw41sVZPlXCRwdt5CNTUtwU2KcqJEHwN/LDnc5WWr+NmD7QEj8OM
         IL77H8b2QDsPd8NyT3zu8e3q8A3Vmm9F7cl+A9NlQJeycwhL+1Sm2BD4FZIM9rzAkAoT
         I/Aw3/bo1msTCZGYyqQ6Sl5iOyQ68ymqIlmyrn2+HaTmRox5EEzno8Bs7hrWEWMEufUJ
         Flx/nAxrQtdZCFgnC/JeTiR5jaDKiYo7MyR1yFRJxWome6Rro46pkLb7Vk50RtoW2Nsb
         V63pfyNUNXbM7Bcr/zNHhx9Zq9cdiTQTWTV8D8s6yu4cKBv3giv85ReAtL9LYGikc0JU
         +z9Q==
X-Gm-Message-State: AOJu0YzbMilAv6U2iX418YO5uDrU+/XCjRbbeZWGW/8LhyN5ofSE1rei
	IgJB9VbYEnKmP/5Qz4ZqvZ1kg1f53Tz1382Uja2bH+lUWeBRE+FgEN5zCtTbXHNZ2Lp1yKhBF9R
	SVxs37NV4AzCnAL2CXnI0P3CDhDQ=
X-Google-Smtp-Source: AGHT+IGUHHLt/CUTO7usqyP1HXPv1a2PHrLlgvBmfRxpTGRaEV19zzCZJYf3js5ypQbklnWpS+Yx81EvndliZbvs+no=
X-Received: by 2002:aa7:8502:0:b0:6d9:b266:16c3 with SMTP id
 v2-20020aa78502000000b006d9b26616c3mr2891487pfn.4.1706893748819; Fri, 02 Feb
 2024 09:09:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com>
In-Reply-To: <20240122160105.2452024-1-clara.kowalsky@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 2 Feb 2024 18:08:55 +0100
Message-ID: <CAFLxGvyy2r5dWUVNbXHtT6W=60DAByh63hi+1U_ynjrECtHvLA@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Add 32-bit compat support for arm64 to xenomai
To: Clara Kowalsky <clara.kowalsky@siemens.com>
Cc: xenomai@lists.linux.dev, rpm@xenomai.org, jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 6:55=E2=80=AFPM Clara Kowalsky
<clara.kowalsky@siemens.com> wrote:
>
> Hi all,
>
> this series adds the 32-bit compat support for arm64 to xenomai 3.
> It allows us to run arm(hf) applications on arm64 kernels.
>
> Best regards,
> Clara Kowalsky
>
> Clara Kowalsky (7):
>   compat support: cobalt: Move 32-bit compat files to generic
>   compat support: cobalt/arm: Refactor registers
>   compat support: cobalt/arm64: Add compat support and clean-up
>   compat support: cobalt/arm64: Update ABI revision level
>   compat support: cobalt/posix/syscall: Use syscall_get_arguments()
>   compat support: lib/cobalt: Fix VFP detection for arm on arm64
>   compat support: cobalt/arm64: Enable compat support for arm64
>
>  .../arch/arm/include/asm/xenomai/syscall.h    |   4 +-
>  .../arch/arm/include/asm/xenomai/syscall32.h  |   8 +-
>  kernel/cobalt/arch/arm64/Kconfig              |   2 +-
>  .../arch/arm64/include/asm/xenomai/syscall.h  |  10 +-
>  .../arm64/include/asm/xenomai/syscall32.h     |  12 ---
>  .../arm64/include/asm/xenomai/uapi/features.h |   2 +-
>  .../arch/x86/include/asm/xenomai/syscall32.h  | 102 ------------------
>  .../asm-generic}/xenomai/syscall32-table.h    |   6 +-
>  .../include/asm-generic/xenomai/syscall32.h   |  78 +++++++++++++-
>  kernel/cobalt/posix/syscall.c                 |  16 +--
>  kernel/cobalt/posix/syscall.h                 |   2 +-
>  kernel/cobalt/trace/cobalt-posix.h            |   4 +-
>  lib/cobalt/arch/arm/features.c                |   5 +
>  .../arch/arm/include/asm/xenomai/syscall.h    |  65 ++++++-----
>  14 files changed, 143 insertions(+), 173 deletions(-)
>  delete mode 100644 kernel/cobalt/arch/arm64/include/asm/xenomai/syscall3=
2.h
>  delete mode 100644 kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.=
h
>  rename kernel/cobalt/{arch/x86/include/asm =3D> include/asm-generic}/xen=
omai/syscall32-table.h (94%)

I don't know how I missed your patches but I spent yesterday the whole
day with the very same cleanup. :-S
What I miss in your changes is the VDSO handling.
By default aarm64 does not offer AT_SYSINFO_EHDR, so
cobalt_lookup_vdso() will fail.
Enabling CONFIG_COMPAT_VDSO on aarm64 is tricky because you need
wither clang or a second cross compiler.
In my version I'm using a fallback to sc_cobalt_clock_gettime/64().

--=20
Thanks,
//richard
