Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA751799A
	for <xenomai@lists.linux.dev>; Fri,  2 Feb 2024 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706894799; cv=none; b=T2fTpwzD6Bw1zB2Xufzgh9tLWdRPWjmYgE+oQAACDv8Hh/dTVo5ginWx3xBSVtyJapO9SAvfKoVDhBpKC3RIH2HZavHdsBrwxvdhKPZexGc60KnCh82uk2ZTMKCSisfQNW6w3D4K6maTOp1mr5ky7LPOGSYGXwLSLrlMyz/iVI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706894799; c=relaxed/simple;
	bh=EYymgUbEkKJ+SYQGT9/ny5h9aQr7NBsCF6PePp48Lqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r77MO/9zXuubHSt2PyRrfCdIny9oHCbTOjJL+WS5GAY0KrETWu7+bmMdC07dSNb1POCLF9fu7grR/mOwB/g3fhCgm6UI8wn9Rcm0cY3kizjFKo6tzIWGxCKMedQIs0NFGuYjjFBYY2CIAlF2rpzUz1G/KTSOkfynY9WPVxXx5Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=if6DUDBA; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if6DUDBA"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso1864725a12.3
        for <xenomai@lists.linux.dev>; Fri, 02 Feb 2024 09:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706894797; x=1707499597; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nhQJhYKumMTgkO4ghPw09ALhB+UL+aq8OCxXouezjE=;
        b=if6DUDBAECD8uqVcmV9Kncmwrmp/I2T7Rqt8j9aY1V1O6xMQdjjI4AaKK9P1KSUc9X
         5ZaN4mnMN0b23WoyBBzemD7vhqeFt7nfiCitIjYYc2DvTJ1v+VYGM3Z8bbqS2HMHqkbq
         wz4fGPbtpL5TtQZp9N9d9ejXapEkuAbyCTxP6TOE454PGrNNrITZtrCaPT4Yv2ee+Qyx
         HZXDd7CVwi3YRM2eLeDIDKMmJNFaqB01ws3nmmHOsn8/IL0FvfPzujELkP0gzINRYKgB
         z138CFVbw1iZqbDb+ALfJraOLDJ55GMeRdr5k24iUls2z4d0H+NAGVboWH9+59EkywRK
         3Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706894797; x=1707499597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nhQJhYKumMTgkO4ghPw09ALhB+UL+aq8OCxXouezjE=;
        b=FUGFf64uM0NcBqUNbISS0opfHLghXwetj6ncCS3o6wv09hz5p+ye59/gN2kgPiesJT
         6qqcaiicPI1rrtqyk/hKAWl63DfkTQuKqAcuTkJRew3ipB96+LIb4+VjRYfDhKWw+Z49
         jURxLk6Yyz8E34k35nfSRAXIynApqxW3NeKwtLX6URNTfP5b86Sh0hembKKTsYmHD7TL
         4Ej/WNonU815eDqHbH5dg7wr9btv39d4M0WxOMAsjwcvn9kQCN462MUH0P1bfagkwd78
         8SbJ3hhPKDzD8u4UZEzfe+t9acNiK82WmnXf2K1rX8zqTH2i1Z9dzygxIc9GspyKlfo+
         ugkg==
X-Gm-Message-State: AOJu0YwNZoSGm58KP3W/uJAI6zpEraAf3yYgtk/JrKtJSxGfd74jYkqm
	9bmIYuX4LUZ3sW9ijySj2PE5hUcJK/sWvaIBujpM4h4q2q/M4sCsKuY68BFvF9DcWpsmrblWmP2
	pssdlfgIE1CqfPWrKNJ5gnnbJydU9Z5qM
X-Google-Smtp-Source: AGHT+IGfh2Os2Rm+b8oplIqtt8B0dt7MikfbFC+mj4tV3+QkUHM1dDW3W7lXz3xHpEyLfL7ViaIjx1Y6Od/xfWJ5SJA=
X-Received: by 2002:a05:6a20:3b1d:b0:199:37ce:2370 with SMTP id
 c29-20020a056a203b1d00b0019937ce2370mr2402104pzh.23.1706894796949; Fri, 02
 Feb 2024 09:26:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com> <20240122160105.2452024-5-clara.kowalsky@siemens.com>
In-Reply-To: <20240122160105.2452024-5-clara.kowalsky@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 2 Feb 2024 18:26:23 +0100
Message-ID: <CAFLxGvzgbZdgzpwc8QSMxY0KJRDAKymmiMkPJ3WM4taogdmPKw@mail.gmail.com>
Subject: Re: [PATCH v1 4/7] compat support: cobalt/arm64: Update ABI revision level
To: Clara Kowalsky <clara.kowalsky@siemens.com>
Cc: xenomai@lists.linux.dev, rpm@xenomai.org, jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 6:20=E2=80=AFPM Clara Kowalsky
<clara.kowalsky@siemens.com> wrote:
>
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h=
 b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
> index fba1db391..3060bcfae 100644
> --- a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
> +++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
> @@ -22,7 +22,7 @@
>  #define _COBALT_ARM64_ASM_UAPI_FEATURES_H
>
>  /* The ABI revision level we use on this arch. */
> -#define XENOMAI_ABI_REV   3UL
> +#define XENOMAI_ABI_REV   19UL

Doesn't this unnecessarily force everyone to rebuild their arm64 applicatio=
ns?
The ABI revision check could also test whether the calling task is in
compat mode or not
and then either compare against the arm64 or arm32 ABI revision.

--=20
Thanks,
//richard
