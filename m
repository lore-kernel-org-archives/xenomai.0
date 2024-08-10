Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0705137742
	for <xenomai@lists.linux.dev>; Sat, 10 Aug 2024 05:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723267331; cv=none; b=bj31CisHO9PqCt15QVhmgh8L1cDt6jXxmTfA4oi72UgPmngSdwQI9daW1Qg8wj457sqSsVOeejTYEdhI7m3WHqzV1yhVk+/yfKrzT/s3ooxLlTZqYL1G5Bp6T/Yr0tJuxFGUp/Sb0QYaZ+cKSgAqePRHwQXA6tRYrAW5lTqb3C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723267331; c=relaxed/simple;
	bh=FIzjFbTxiEOJlchg6zNK2ZXgAgtWbX9Zx3MrF12sFmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmHrX3VF14OGGIj7+uuFFA2hTH/qndpYXuyaTTYjltwNNkbteltfCnSR74b/55WDFtgZU8ZrHvNYEmv4uUVaobB5LiyQZ6B1cu7NxcJWqMteNwKaZHaA7B/BcsP2owBawpNVuGZ3g3isi1UBsKLkC810J/9cBJzDV2xnE8XGtPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=dO8RVaDe; arc=none smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="dO8RVaDe"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 92983240002
	for <xenomai@lists.linux.dev>; Sat, 10 Aug 2024 05:22:05 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by spool.mail.gandi.net (Postfix) with ESMTPS id BDCADD800F5
	for <xenomai@xenomai.org>; Sat, 10 Aug 2024 05:22:04 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2f189a2a841so26160241fa.3
        for <xenomai@xenomai.org>; Fri, 09 Aug 2024 22:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1723267324; x=1723872124; darn=xenomai.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmYSST/MrOy3k5YtALxpOy6R7mg+G5/cXNU+qZ3tg6U=;
        b=dO8RVaDeLO2/4AmgunFCSV+6kU/IxVLpB9jv/BRQctoWqpM7Rfr41l5ijOQc4VLRpp
         S4EaQ7o9GzM0IET+dC8700BXXO2NGnsSFaM1ncalD1GKuE7SB8tECsg1DktlWZfj9vaZ
         tDhG18hHrv7V688St+iDs2cQ25MrSISjMD14c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723267324; x=1723872124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmYSST/MrOy3k5YtALxpOy6R7mg+G5/cXNU+qZ3tg6U=;
        b=T0DPCuO3CR5wKKmkMWj/1jDdXXGJWps7ndAxDJbO/D/fkp0py1eJJbLxRAm2od60Sz
         3eeUl1Hgk5us1ED2MwrCz8UCD+enjUeysThGDgG3zVQiaYbkelLAvsIL8fpdX01mHLiw
         L9uk65IlHKHwjD6YMePFqotptZdw8KGOuzwVhhyaGw8M6yaaAtsTGwDPzXMKDLPsl7WL
         16BD1KdMCuF27hYtH6sY8rbdItGXJLQamtWwaSbhNWLNbqHdiFdWGT8xKBT3HaxRbocI
         LtediL41bKpySFd00CFw/GY+TypLnDObRaq4eS8ITN8VKeMbiPz9tBz298A9IqBgtRNT
         CkTg==
X-Gm-Message-State: AOJu0YxWe5Vjcwvw9pHENkJl0LaOn1wAtz7BEyfuKdYOJvMYtjBojYwn
	x+zap/jnwYgWP4/wLbhuh1r5i4rZCkdL0UeqQss3ohCwcvJw8KVMW83E7yhKPqNUIDAfXtFhD1Q
	6CM3M6m9Tmcb9HooJuF/nDfOvRbvgcFuA7M5DMWNHVUCYfKwh
X-Google-Smtp-Source: AGHT+IFXui/m+3DplARNvY+TRm0fM/saLuNOka59aoQjZ2WLgFm/D8PG10sEAq5x2DcHmshX1UdXYnVOdCYXsCU6m9U=
X-Received: by 2002:a2e:81d6:0:b0:2ef:2d58:ec24 with SMTP id
 38308e7fff4ca-2f1a6c66ed1mr23610451fa.17.1723267323596; Fri, 09 Aug 2024
 22:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0sm5nyd_P2oXH20nkCjfip-d=B66htnaC0bunx4quzzFg@mail.gmail.com>
 <3d1a1b320ed6b3f999551ecdc403367b99656c5d.camel@siemens.com>
In-Reply-To: <3d1a1b320ed6b3f999551ecdc403367b99656c5d.camel@siemens.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Sat, 10 Aug 2024 07:21:50 +0200
Message-ID: <CAFc1U0umoibaSeQcwxjsHab-qrjk7y2EegLLjY+mWSWQGj-6fA@mail.gmail.com>
Subject: Re: Dovetail kernel compilation error
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::229 as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr;
	dmarc=pass (policy=reject) header.from=smile.fr

Hi,

Thanks a lot for your help !

Regards

Le ven. 9 ao=C3=BBt 2024 =C3=A0 17:42, Florian Bezdeka
<florian.bezdeka@siemens.com> a =C3=A9crit :
>
> On Fri, 2024-08-09 at 17:29 +0200, Pierre FICHEUX wrote:
> > Hi,
> >
> > As compiling linux-6.1.y-dovetail or linux-6.6.y-dovetail I get the
> > following error :
> >
> > kernel/xenomai/posix/timer.c:216:1: erreur: conflicting types for
> > =C2=ABtimer_delete=C2=BB; have =C2=ABint(timer_t)=C2=BB {alias =C2=ABin=
t(int)=C2=BB}
> >   216 | timer_delete(timer_t timerid)
> >       | ^~~~~~~~~~~~
>
> This means that your xenomai version is not compatible with the kernel
> version. 6.1 and 6.6 got some backports that required us to do some
> changes to get compatible again.
>
> The following branches / versions are compatible:
> - master
> - next
> - stable/3.2.x since 3.2.5 (3.2.4 is too old)
>
> Hope that helps,
> Florian
>
> > Dans le fichier inclus depuis ./include/linux/workqueue.h:9,
> >                  depuis ./include/linux/mm_types.h:19,
> >                  depuis ./include/linux/buildid.h:5,
> >                  depuis ./include/linux/module.h:14,
> >                  depuis kernel/xenomai/posix/timer.c:19:
> > ./include/linux/timer.h:186:12: note: previous declaration of
> > =C2=ABtimer_delete=C2=BB with type =C2=ABint(struct timer_list *)=C2=BB
> >   186 | extern int timer_delete(struct timer_list *timer);
> >
> > The target is a Pi 3 used in 32 bits (Cortex A7). I use the 13-2-rel1
> > toolchain with Buildroot.
> >
> > https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads/13-2-=
rel1
> >
> > Thanks by advance
> >
> > regards
>
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
