Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4269914AB3
	for <xenomai@lists.linux.dev>; Sat,  3 Feb 2024 23:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707004262; cv=none; b=KwlDRFXBa/aQOtV/RzDjKYvr4/1+8O4iFZQOppittOD87IwGoz/hHnwBrCft66w24OghdtB6uDemtv8/rBw7lDgn8hcgPohJZvkwo27mz7G8pyzRA4KJpscBCgTk8hsP4Floe1YBUZ4K1TLOriv3uqYQX54qRb+hvDj0sP/aj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707004262; c=relaxed/simple;
	bh=fupWcgLAaqW9PA9f5kFBtFCjFdwkFEjjPSPpA5YgnOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAH4jslpYQQqQi8xD6LJSv0bNxZv1CZh0kdcZCVKyoX1+0S+FWFMQo+Jri6ZAwHudX93p8UDDK2oogI11TXw84NbNnF10EVO3/5yVQunc6KRL7duH73FPSPHLc+wHJts3+tiVAFptw1P3dYYubyAueyDJNi8KVLpvRxfF/SHMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbxhspQA; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbxhspQA"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2725726a12.3
        for <xenomai@lists.linux.dev>; Sat, 03 Feb 2024 15:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707004260; x=1707609060; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Dnu544UwZfZmai0vGCenjOzLbD0IeJ6RVYoLAGZSeY=;
        b=BbxhspQAQmFnTK0UgTpXlWGIMol+akbcs+Nf3FgEBmrhPVTJBZJCE/mIqHb5xlu1y9
         g7aRsUGXZCFPU5Ih08ZALp4gcnXH5fLVYA/qRgFJKNxcdhoF4ft/8qAtMOfghVwXVnsC
         PCIlGD8Kv0nBqy+SWWPrez4g0C39Z+2VbaRPLOXmJMVGR2ZZEFDcvuPFMcSma1bZfG8M
         RS025qefeP4k2c/LUfGwWoU275/QcKbSuot9jSG372eQCPou7hbzsLXx0DJXZcPLjqc8
         8/e9GxLCP6+HatPPrpcPKDUPDTQqFbHUv5z/UuL7V5BAH0PvIB2rO0tDpqxPkKbVUlJc
         dsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707004260; x=1707609060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Dnu544UwZfZmai0vGCenjOzLbD0IeJ6RVYoLAGZSeY=;
        b=th3jd1RQ2/mF4kP+/TuuQW6WibK85ZrTOIf4my/oSffQ8JFoReA6Mv0FoDgIfK64r6
         6yRs+/ceeydM8yOCjqvH4XTzbw8Rwy1W00VNuVE5uk7R6Kgk8coIyuHbxe4rHho2P+P2
         WU33M/n7ebyTd3deGXjq4GAjc3k0uhhITuhuIT/QegZXHEUkXxdwlOVvyL/sxZgl7eze
         gSqUWLDEl66d8J2jGcuPOJdlX7sDK14XrTwWrusn2ZMMU+YfTH9sk9pYz3iGvmXZ+hSo
         7q5Zuq3iizL/XfgP4xU2y+vlR3g1WhvPWjsHbtfTogP4RavPX70N4MPcwJMM/8f7+J82
         239g==
X-Gm-Message-State: AOJu0YyUc1md35WfKsbyHOSfTVSwbZgAvFmyvQ8IqQuGbg4+BOaROYTN
	lsKMnJHHkMHfJeOIPQiETwOT714/FKRTQ9lHz8v7uDY9GYft8839HoEMisxr3sNBZU1TVteZGTv
	GbN+da/T+i7aPlYVfe85mWR3Km565jCfzu0o=
X-Google-Smtp-Source: AGHT+IH9t/0L2mbohUhjeOMvxIqmpe8XjUNV9SEKoM1SVHxNR3v7ZGO2uovqtr2xWgrPEx0EWa9KADN9lIqbfs+vo7w=
X-Received: by 2002:a05:6a20:7a98:b0:19c:aba2:69e5 with SMTP id
 u24-20020a056a207a9800b0019caba269e5mr8551103pzh.45.1707004260421; Sat, 03
 Feb 2024 15:51:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com> <20240122160105.2452024-3-clara.kowalsky@siemens.com>
In-Reply-To: <20240122160105.2452024-3-clara.kowalsky@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 4 Feb 2024 00:50:48 +0100
Message-ID: <CAFLxGvyg_PUg-EkEc2OfsBueVp8p4g_8TLT-=6orJSU7wLVcVw@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] compat support: cobalt/arm: Refactor registers
To: Clara Kowalsky <clara.kowalsky@siemens.com>
Cc: xenomai@lists.linux.dev, rpm@xenomai.org, jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 6:20=E2=80=AFPM Clara Kowalsky
<clara.kowalsky@siemens.com> wrote:
>
> For EABI, the syscall number has to be loaded into r7.
>
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  .../arch/arm/include/asm/xenomai/syscall.h    |  4 +-
>  .../arch/arm/include/asm/xenomai/syscall.h    | 65 +++++++++----------
>  2 files changed, 34 insertions(+), 35 deletions(-)
>
> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h b/kerne=
l/cobalt/arch/arm/include/asm/xenomai/syscall.h
> index 172197725..a46f0e94b 100644
> --- a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
> +++ b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
> @@ -44,8 +44,8 @@
>   * Dovetail abides by, with the actual syscall number into r7 ORed
>   * with __OOB_SYSCALL_BIT, freeing r0 for passing a call argument.
>   */
> -#define __xn_reg_sys(__regs)   ((__regs)->ARM_ORIG_r0)
> -#define __xn_syscall_p(__regs) (((__regs)->ARM_r7 & ~__COBALT_SYSCALL_BI=
T) =3D=3D XENO_ARM_SYSCALL)

I think you can remove XENO_ARM_SYSCALL from uapi/syscall.h now as well.


> +#define __xn_reg_sys(__regs)   ((__regs)->ARM_r7)
> +#define __xn_syscall_p(__regs) ((__regs)->ARM_r7 & __COBALT_SYSCALL_BIT)
>  #define __xn_syscall(__regs)   (__xn_reg_sys(__regs) & ~__COBALT_SYSCALL=
_BIT)
>
>  /*
> diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h b/lib/coba=
lt/arch/arm/include/asm/xenomai/syscall.h
> index 864330490..105bf9faf 100644
> --- a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
> +++ b/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
> @@ -37,62 +37,61 @@
>  #error TLS support (__thread) is broken with GCC >=3D 4.3, use --disable=
-tls when configuring
>  #endif
>
> -#define LOADARGS_0(syscode, dummy...)  \
> -       __a0 =3D (unsigned long) (syscode)
> +#define LOADARGS_0(syscode, arg1...)
>  #define LOADARGS_1(syscode, arg1)      \
> -       LOADARGS_0(syscode);            \
> -       __a1 =3D (unsigned long) (arg1)
> +       LOADARGS_0(syscode, arg1);      \
> +       __a0 =3D (unsigned long) (arg1)
>  #define LOADARGS_2(syscode, arg1, arg2)        \
>         LOADARGS_1(syscode, arg1);      \
> -       __a2 =3D (unsigned long) (arg2)
> +       __a1 =3D (unsigned long) (arg2)
>  #define LOADARGS_3(syscode, arg1, arg2, arg3)  \
>         LOADARGS_2(syscode,  arg1, arg2);       \
> -       __a3 =3D (unsigned long) (arg3)
> +       __a2 =3D (unsigned long) (arg3)
>  #define LOADARGS_4(syscode,  arg1, arg2, arg3, arg4)   \
>         LOADARGS_3(syscode,  arg1, arg2, arg3);         \
> -       __a4 =3D (unsigned long) (arg4)
> +       __a3 =3D (unsigned long) (arg4)
>  #define LOADARGS_5(syscode, arg1, arg2, arg3, arg4, arg5)      \
>         LOADARGS_4(syscode, arg1, arg2, arg3, arg4);            \
> -       __a5 =3D (unsigned long) (arg5)
> +       __a4 =3D (unsigned long) (arg5)
>
> -#define CLOBBER_REGS_0 "r0"
> -#define CLOBBER_REGS_1 CLOBBER_REGS_0, "r1"
> -#define CLOBBER_REGS_2 CLOBBER_REGS_1, "r2"
> -#define CLOBBER_REGS_3 CLOBBER_REGS_2, "r3"
> -#define CLOBBER_REGS_4 CLOBBER_REGS_3, "r4"
> -#define CLOBBER_REGS_5 CLOBBER_REGS_4, "r5"
> +#define CLOBBER_REGS_0
> +#define CLOBBER_REGS_1 "r0"
> +#define CLOBBER_REGS_2 CLOBBER_REGS_1, "r1"
> +#define CLOBBER_REGS_3 CLOBBER_REGS_2, "r2"
> +#define CLOBBER_REGS_4 CLOBBER_REGS_3, "r3"
> +#define CLOBBER_REGS_5 CLOBBER_REGS_4, "r4"
>
> -#define LOADREGS_0 __r0 =3D __a0
> -#define LOADREGS_1 LOADREGS_0; __r1 =3D __a1
> -#define LOADREGS_2 LOADREGS_1; __r2 =3D __a2
> -#define LOADREGS_3 LOADREGS_2; __r3 =3D __a3
> -#define LOADREGS_4 LOADREGS_3; __r4 =3D __a4
> -#define LOADREGS_5 LOADREGS_4; __r5 =3D __a5
> +#define LOADREGS_0
> +#define LOADREGS_1 __r0 =3D __a0
> +#define LOADREGS_2 LOADREGS_1; __r1 =3D __a1
> +#define LOADREGS_3 LOADREGS_2; __r2 =3D __a2
> +#define LOADREGS_4 LOADREGS_3; __r3 =3D __a3
> +#define LOADREGS_5 LOADREGS_4; __r4 =3D __a4
>
>  #define ASM_INDECL_0                                                   \
> -       unsigned long __a0; register unsigned long __r0  __asm__ ("r0");
> +       register unsigned long __r0  __asm__ ("r0");
>  #define ASM_INDECL_1 ASM_INDECL_0;                                     \
> -       unsigned long __a1; register unsigned long __r1  __asm__ ("r1")
> +       unsigned long __a0;
>  #define ASM_INDECL_2 ASM_INDECL_1;                                     \
> -       unsigned long __a2; register unsigned long __r2  __asm__ ("r2")
> +       unsigned long __a1; register unsigned long __r1  __asm__ ("r1")
>  #define ASM_INDECL_3 ASM_INDECL_2;                                     \
> -       unsigned long __a3; register unsigned long __r3  __asm__ ("r3")
> +       unsigned long __a2; register unsigned long __r2  __asm__ ("r2")
>  #define ASM_INDECL_4 ASM_INDECL_3;                                     \
> -       unsigned long __a4; register unsigned long __r4  __asm__ ("r4")
> +       unsigned long __a3; register unsigned long __r3  __asm__ ("r3")
>  #define ASM_INDECL_5 ASM_INDECL_4;                                     \
> -       unsigned long __a5; register unsigned long __r5  __asm__ ("r5")
> +       unsigned long __a4; register unsigned long __r4  __asm__ ("r4")
>
> -#define ASM_INPUT_0 "0" (__r0)
> -#define ASM_INPUT_1 ASM_INPUT_0, "r" (__r1)
> -#define ASM_INPUT_2 ASM_INPUT_1, "r" (__r2)
> -#define ASM_INPUT_3 ASM_INPUT_2, "r" (__r3)
> -#define ASM_INPUT_4 ASM_INPUT_3, "r" (__r4)
> -#define ASM_INPUT_5 ASM_INPUT_4, "r" (__r5)
> +#define ASM_INPUT_0 "r" (__r7)
> +#define ASM_INPUT_1 ASM_INPUT_0, "0" (__r0)
> +#define ASM_INPUT_2 ASM_INPUT_1, "r" (__r1)
> +#define ASM_INPUT_3 ASM_INPUT_2, "r" (__r2)
> +#define ASM_INPUT_4 ASM_INPUT_3, "r" (__r3)
> +#define ASM_INPUT_5 ASM_INPUT_4, "r" (__r4)
>
>  #define XENOMAI_DO_SYSCALL(nr, op, args...)                            \
>         ({                                                              \
>                 ASM_INDECL_##nr;                                        \
> -               unsigned long __r7 =3D XENO_ARM_SYSCALL;                 =
 \
> +               unsigned long __r7 =3D __xn_syscode(op);                 =
 \
>                 LOADARGS_##nr(__xn_syscode(op), args);                  \
>                 __asm__ __volatile__ ("" : /* */ : /* */ :              \
>                                       CLOBBER_REGS_##nr);               \
> --
> 2.39.2
>
>


--
Thanks,
//richard
