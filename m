Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D9A36B1D
	for <xenomai@lists.linux.dev>; Fri,  9 Feb 2024 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707482818; cv=none; b=VxElDGavwyEq7rq9LONKfzVhKzuiynZRqIUC4nUng/RALaVwx/1XDcBkObn1JraMU6uBU8yDNNsL987v+XtvHjoNY8S4OG6CNJ++lAe1FGRbqjwHVPJD71ikUgqbII9RzxsCXBJB8qDbYE2i2gmlpUYUKydFX6TouWJpAHgnenM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707482818; c=relaxed/simple;
	bh=U6yVjIDmfWWaeSRlKpLFyAUflcjX0VCerz3Ae+rkoGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIXsJmrGbtCdasOR7C7O6lEDf71IYSzsMF5RLehG4PvjCM1KhHcR9apLj+hLFR3D53CYpE1GbLeY/J8lRyAh2HONJlFC6w4qeX2/W+LOD2rxggYcruN5ecPkVN5wQL/6vVu20VmzIuYpvDJ0ut3sD6Hqwxp4K5dgSZ7CpVS8o94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APzQRwEq; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APzQRwEq"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8df2edd29so619576a12.2
        for <xenomai@lists.linux.dev>; Fri, 09 Feb 2024 04:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707482816; x=1708087616; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58NMvC5JWDkj7aHwdUrgHd4ejNKwaQje8ItCCPZJOFA=;
        b=APzQRwEqerZWT6j0JwqN3hWbslKH4Mqa1h8Bt65wZSRjIMepLdp/bNs6zGfSZre963
         oiKHIlyKczGrjdlHhf8ppYPLekX8xS1BxXXwgkn/Euph9F9J54UVfWB97fm8ar4YcEbW
         AhoKX9SjWBuNtXMg1O4wzyi9N8lScGGoauFd1TUdm9XoeMV4sHIpoXaTUkQ/3KyfO4c0
         hkNQbu4GhLfpOQ8VAGP23Ok/OOchyDywLLT6ievjsDA003kYOVCCcPX843nUTEUBH8vU
         TZhyE8huZTUKhknkYfTNsMLTAanGN3kHTQLtUQ6xJb6IdUnU4d6o8O7c2QSwt3JCJlmI
         y54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707482816; x=1708087616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58NMvC5JWDkj7aHwdUrgHd4ejNKwaQje8ItCCPZJOFA=;
        b=TgO1w3Cg8lHDqJneiVQ5UKB0sLgGgbg4dxnYose8f0yBTJLJvEyne9pspPO2PdDC0h
         y2XrdR5ugP0sWpfHC4j4eBGTfQLUQcH5OWedvqZReEtlNiR2eL8X4OJVHnPdq2AMYhZg
         emieCwDEwZBc/qVMMo0VZmPKq/ZhG2drjAJKO86RrOnQgjt3dYpZMoKz+v12rZkPcOqT
         D9Zlp3IAM8QsT2UYBscN5hsYkO5QnCqraP6Jvyxa4WdP7qLJgpxU6VZfKxuOuuRicyC/
         vNEFH1pwLH/zkupyEKqDwoU2goQ9iXMoOOwRiTY7pUFuVqeGEZgzhKSTTnMllB7Wxruv
         zJFQ==
X-Gm-Message-State: AOJu0YwADnHt4V2pCcwxavAnx1hRIdAG6Hnjvctn8Xh7sq5AfHDvzyIa
	sFM4fIAplXnIZBd8f4HtNnMn4eV/7XTAep9+fUvperTK8zYtjlkxQ3C12DrV5oWW2xoQ3OF0eZ2
	I7rJl+w5WP0Egwk5ZSqCyr2dpYLc=
X-Google-Smtp-Source: AGHT+IFaV7JXvrmfF89KSBn0i9O0FI3UsGdMkU5RRsYXUZ3BMDInk6frOvXMsAqQ321731JDpt+vtTyJ+B65lQ4ZP/o=
X-Received: by 2002:a05:6a20:c78f:b0:19e:a45e:3b7e with SMTP id
 hk15-20020a056a20c78f00b0019ea45e3b7emr1726746pzb.53.1707482816276; Fri, 09
 Feb 2024 04:46:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240209115025.1884451-1-clara.kowalsky@siemens.com>
In-Reply-To: <20240209115025.1884451-1-clara.kowalsky@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 9 Feb 2024 13:46:43 +0100
Message-ID: <CAFLxGvwbyeq0LsKAnj6CTaCE-BpM8jEnWTAk+PpAAKy5zytYZQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add 32-bit compat support for arm64 to xenomai
To: Clara Kowalsky <clara.kowalsky@siemens.com>
Cc: xenomai@lists.linux.dev, rpm@xenomai.org, florian.bezdeka@siemens.com, 
	jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 12:52=E2=80=AFPM Clara Kowalsky
<clara.kowalsky@siemens.com> wrote:
>
> Hi all,
>
> this is the second version of the series for adding the 32-bit compat
> support for arm64 to xenomai 3.
>
> Thank you Richard for your comments on v1.
> Changements compared to v1:
> - P2/7: Removed unused XENO_ARM_SYSCALL
> - P4/7: Synchronized ABI revision for armhf and arm64
> - P7/7: Added COMPAT_VDSO dependency

FWIW, if you happen to build with Yocto, this patch is needed:
https://lists.openembedded.org/g/openembedded-core/message/195064

> Best regards,
> Clara Kowalsky
>
>
> Clara Kowalsky (7):
>   compat support: cobalt: Move 32-bit compat files to generic
>   compat support: cobalt/arm: Refactor registers for arm alignment
>   compat support: cobalt/arm64: Add compat support and clean-up
>   compat support: cobalt: Bump ABI revision
>   compat support: cobalt/posix/syscall: Use syscall_get_arguments()
>   compat support: lib/cobalt: Fix VFP detection for arm on arm64
>   compat support: cobalt/arm64: Enable compat support for arm64
>
>  .../arch/arm/include/asm/xenomai/syscall.h    |  14 ++-
>  .../arch/arm/include/asm/xenomai/syscall32.h  |   8 +-
>  .../include/asm/xenomai/uapi/abirevision.h    |   1 +
>  .../arm/include/asm/xenomai/uapi/features.h   |   3 +-
>  .../arm/include/asm/xenomai/uapi/syscall.h    |   2 -
>  kernel/cobalt/arch/arm64/Kconfig              |   3 +-
>  .../arch/arm64/include/asm/xenomai/syscall.h  |  10 +-
>  .../arm64/include/asm/xenomai/syscall32.h     |  12 ---
>  .../include/asm/xenomai/uapi/abirevision.h    |  16 +++
>  .../arm64/include/asm/xenomai/uapi/features.h |   3 +-
>  .../arch/x86/include/asm/xenomai/syscall32.h  | 102 ------------------
>  .../asm-generic}/xenomai/syscall32-table.h    |   6 +-
>  .../include/asm-generic/xenomai/syscall32.h   |  78 +++++++++++++-
>  kernel/cobalt/posix/syscall.c                 |  16 +--
>  kernel/cobalt/posix/syscall.h                 |   2 +-
>  kernel/cobalt/trace/cobalt-posix.h            |   4 +-
>  lib/cobalt/arch/arm/features.c                |   5 +
>  .../arch/arm/include/asm/xenomai/syscall.h    |  65 ++++++-----
>  18 files changed, 166 insertions(+), 184 deletions(-)
>  create mode 120000 kernel/cobalt/arch/arm/include/asm/xenomai/uapi/abire=
vision.h
>  delete mode 100644 kernel/cobalt/arch/arm64/include/asm/xenomai/syscall3=
2.h
>  create mode 100644 kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/abi=
revision.h
>  delete mode 100644 kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.=
h
>  rename kernel/cobalt/{arch/x86/include/asm =3D> include/asm-generic}/xen=
omai/syscall32-table.h (94%)

For the whole series:
Reviewed-by: Richard Weinberger <richard@nod.at>

--=20
Thanks,
//richard
