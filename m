Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F010214AD2B
	for <xenomai@lists.linux.dev>; Fri,  2 Feb 2024 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895012; cv=none; b=cW0Rfjy/LbR+GhrrusfV6K4gnEmIkVrcxuKto04cEN58rxIFrk1QseXTq01JlSrDb3WAAHdJ5blCblld5/tpolHBB/QaejRoQdawrbbTaIwuYcOjxw9RSmKfDpCUSk4ssEjzdo1idAztpjoHSAOwYPXYeJgARZKJSlr8blazjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895012; c=relaxed/simple;
	bh=iWbacw98+I88FlDBsKJNp68iH13BSqYeIMsHPan00W0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mamb2LrsYsOGStAmYXTgSz8xRVhaDmFqlTKbyMshS2kHooQZF6fJnRchjz+nuo8/LC6hp2KCAyQJX51l9g3xnmp3abGbjpDyfUIUfRSKuwtqK/RuWYdYEtJiNyWV8gUb1wwHpZFgNB0lUFKWx9z8KCXN+MQxeXOhRGEtDCM0lKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eme/kQ3u; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eme/kQ3u"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso1868155a12.3
        for <xenomai@lists.linux.dev>; Fri, 02 Feb 2024 09:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706895010; x=1707499810; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3B7ZZUrx5E+xUy92NbU8gRlAqBDrG6gERwkhxPutXA=;
        b=Eme/kQ3usj2ubG+EsFsu2K6bVI0+yGLBO3gHBl/iWFtScTmcaqnCqlzPFurqxnd6uc
         cji6O5kj76T3AtUx+rJXXY7jI9QF8RC0H+30YdxhKA1kUhzd8OmK6vO4ha/lA2gAuChd
         hfsR1CBl98lZQ+Pd/CobrO0yRZrYCIxuuIKssFh/66IkACR1Z4AQRP2Bg7VNtJsT1ohK
         z97+2ToMIbGvkTw917W9ctWm0VETxYdd2+ZZ5Y2wnEWO/FB0m++NzEuj6uB+9HWq/eS6
         N6hrPV1MmoMMQv+NvUeIa1ARgRmmncfWJdGMAF1x+mR4EjpLGRTgalakrnx3fasyUwcc
         V+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895010; x=1707499810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3B7ZZUrx5E+xUy92NbU8gRlAqBDrG6gERwkhxPutXA=;
        b=VPtQ6zvN2jaBpvsteTwSPPoxr6xBprQzDtxS5BZMt19+qLAM21mpYakyGS/S5+/qqo
         WlAMaYBHCyzuFm2gm4vQVF4dgGe9+xu84eD+PV7H7tMOl3YE+iObCGlgGlDbbNEbt4Cu
         GzDtyls7y4t4LmpxnaoqRH/iPeAk6F2/iCbRrym3C0bpjNIowMuQr6RbqbrLw60G8dt+
         wmGEPwxBeSQFR4ckZw8bGIKUXNn4ZJ9oa2FsVL/fQqbbz/GHu4chjsFwmE3cUgbN2mq2
         RkZ7kBigizc1uKA/uX/4Fz4SBVT70qn7Mnp+CepnJs9cXfPmJKlJ3cV0nWOcOwOUvKEU
         4GCA==
X-Gm-Message-State: AOJu0Yz6A91xYHP6zsBV51wwgOM6QAb9z8FiSQETV7OlXUTzBdS53AWA
	tv/3zrbchUrB/7AsQ9pGtMzNo39CIl/et/oJDjGRhzvkhuMLzv7EL7WtvHJGUqLebZW0e/6yNK2
	9WRkEpCSdzL5/Mo/nbaB53agDQtk=
X-Google-Smtp-Source: AGHT+IGN02LUrkUGkK0nNofsKKiSBBZXwatxCK/CPEvpKpVWCJeQnU2NjcuWcaVNsx9J82u8XdbknNMrcNnXvEI9MlM=
X-Received: by 2002:a05:6a20:9f47:b0:19e:3e75:f28c with SMTP id
 ml7-20020a056a209f4700b0019e3e75f28cmr2868847pzb.11.1706895010251; Fri, 02
 Feb 2024 09:30:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com> <20240122160105.2452024-8-clara.kowalsky@siemens.com>
In-Reply-To: <20240122160105.2452024-8-clara.kowalsky@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 2 Feb 2024 18:29:57 +0100
Message-ID: <CAFLxGvyuksoHCnYm0hWCby64QNSaQ0LbJ0kkRJp=KaN-1tRNuw@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] compat support: cobalt/arm64: Enable compat
 support for arm64
To: Clara Kowalsky <clara.kowalsky@siemens.com>
Cc: xenomai@lists.linux.dev, rpm@xenomai.org, jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 6:20=E2=80=AFPM Clara Kowalsky
<clara.kowalsky@siemens.com> wrote:
>
> This enables the 32-bit EABI compat mode for building the user-space
> libraries of arm64. It allows us to run arm(hf) applications on arm64
> kernels.
>
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  kernel/cobalt/arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cobalt/arch/arm64/Kconfig b/kernel/cobalt/arch/arm64/=
Kconfig
> index bdf5f1602..2d7b204d4 100644
> --- a/kernel/cobalt/arch/arm64/Kconfig
> +++ b/kernel/cobalt/arch/arm64/Kconfig
> @@ -5,7 +5,7 @@ config XENO_ARCH_FPU
>         def_bool y
>
>  config XENO_ARCH_SYS3264
> -        def_bool n
> +        def_bool COMPAT

As written before, I think some VDSO bits are missing.
XENO_ARCH_SYS3264 should depend on CONFIG_COMPAT_VDSO.

--=20
Thanks,
//richard
