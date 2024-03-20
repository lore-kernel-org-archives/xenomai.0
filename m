Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A7D2231C
	for <xenomai@lists.linux.dev>; Wed, 20 Mar 2024 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920513; cv=none; b=dEcz5H7M2tiH+yNUCS5f/2ch3ezO8d8GygKHHQdHihFSTaASoM9XuKsnx/hiAHDHtHwE5NVl5pRUTFiuUR7pLVeHdCLWx3iALbQbx9s5m7p7hcrNl7Rkp5hVUTwZmJG9f9e/iLMkMQs2we2eb6Px2BHxWya3EJ1YgLUmmmk8sd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920513; c=relaxed/simple;
	bh=6KzEwcnterq4hNeM2jH6y2rBKniLM+TPKM0+sry4ugk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqf0qcBUt+/JkDFk9kjrfTpybKTQ0XX9/RZDdPRn+4Mr7w6iQZ+ahykSkV42PduHx1evIINLrp/fUJB2OX/1iwsaSm8id4b0fUE4spwnAAxgpKAxS9oarlGcEfKCwVo1AQj8evCvD/7nAvh9tPMpUtoGRAqA8M9kDltZFoOWjkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=w7LtNUnH; arc=none smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="w7LtNUnH"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 7781D200003
	for <xenomai@lists.linux.dev>; Wed, 20 Mar 2024 07:41:42 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 99A38D80520
	for <xenomai@xenomai.org>; Wed, 20 Mar 2024 07:41:41 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2d4515ec3aaso4979141fa.1
        for <xenomai@xenomai.org>; Wed, 20 Mar 2024 00:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1710920501; x=1711525301; darn=xenomai.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FiVngiqg4EoKtkjJDnUhFA+mK+cvoxo40Qxr7Hr8UY=;
        b=w7LtNUnHMPdUO/qfRtY+uugp7C8vI4AFENT5WwXjgKPRZvnRCygohT3rOhKKLpHka4
         ltVfBoJoE2hxRcgfYImFkbAis/f1J/hiZeDonuNfpegrPXwchrKwOMyny1FEG28+NIqe
         MfJqxd81XCSP+w01rJeGf0A0bHBOmuEmY0lFyBwpfkMbyAzj935c1A3XNMDuHRVeOlbC
         CGNq7orUDIiVCKES2i+3eMmPYPZIkh/E052R4QDshcRit/VNt9KKUbur+L6Z1i/U4HM3
         8lqo+6rCQRuvZjKg5wTNpZlq7Sp/9YkXZtj/2BRs3RQF/WpTFj4ONr0GxbvfVlC4qzuD
         Cv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710920501; x=1711525301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FiVngiqg4EoKtkjJDnUhFA+mK+cvoxo40Qxr7Hr8UY=;
        b=b3jJpJeYV9xF9q+wqetnJahFxEgEYYbOYuhMsYowg4qhAS5rdx25TGy93rl9JjbNxA
         aFaZchjLhu1U3wVbMhtjc97Lp3fu2DBWVyh044n8xmKKv/Ym4N/v1SSZIRTM4Ty9u64y
         xX7Av2mX2fD4My+FS/gLA8XYQdZa3+f+q6JitCkGCsGcrwNxkExjpSCzR6VpGzfuVpTL
         EBeTKUtpghbo7ibP15RmuCw37uMBquCANGUu3uNAhwyhAovvL11OBeTiTC9q6KuVfcT2
         ODeY7j99h54cvsi2o5VzFTVASvXdSSnvjH/bVVHDjRfzADRWYaSZ4aDcYGm5PhOrwMHV
         WWRQ==
X-Gm-Message-State: AOJu0YwWF3Kp54rd47LvLgboPHDhGDd48Y1eElD8CU2AlVM6WIoEHLxn
	ZpEVuVw3UG+mrf1uqoXQ+g4l1BOg6R1lPQ23tVQ3MHWVH0/Nw441+D7L4K/HDLFzXX7A3V6WY5+
	KWfDIOYvFhnr/zB1PinOvFmKgWBLv4daiuHfnFQ==
X-Google-Smtp-Source: AGHT+IGPKxIV1VVOTcdfWUqPHUNKtdLONpteYLK4GYrsim3B7sZHXy/rSblrNDRJVT1R+irOIhN2kX9bnN/TSVtQjEM=
X-Received: by 2002:a2e:9815:0:b0:2d4:9334:3c11 with SMTP id
 a21-20020a2e9815000000b002d493343c11mr1699607ljj.16.1710920500914; Wed, 20
 Mar 2024 00:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0taqtH_iP=f1z6E=Gm91YG4q_2Wosmstygb9wiadThj7Q@mail.gmail.com>
 <CAFLxGvzjsYjFnOyAz7ikwwvXf2yiiPvN6Ytg4NGUa5R95Jsy0w@mail.gmail.com>
In-Reply-To: <CAFLxGvzjsYjFnOyAz7ikwwvXf2yiiPvN6Ytg4NGUa5R95Jsy0w@mail.gmail.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Wed, 20 Mar 2024 08:41:30 +0100
Message-ID: <CAFc1U0tEXtEjLHzorT2KPdBB=wFFkyd4_JB1Uij5zd+R8b3TcQ@mail.gmail.com>
Subject: Re: Detecting migration
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::235 as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr;
	dmarc=pass (policy=none) header.from=smile.fr

Hi Richard,

Thanks for your answer.

As we said during the meeting, I will try to find  a generic
documentation about the subject (finding the origin of a signal) in
the Linux environnement.

regards

Le mar. 19 mars 2024 =C3=A0 21:47, Richard Weinberger
<richard.weinberger@gmail.com> a =C3=A9crit :
>
> Pierre,
>
> On Tue, Mar 19, 2024 at 6:22=E2=80=AFPM Pierre FICHEUX <pierre.ficheux@sm=
ile.fr> wrote:
> > Using the SIGDEBUG signal, is there a way to know the source of the
> > migration (function name) ?
> >
> > I did a test with:
> >
> > nentries =3D backtrace(bt,sizeof(bt) / sizeof(bt[0]));
> > backtrace_symbols_fd(bt,nentries,fileno(stdout));
> >
> > It seems to work (using nm + readelf)   but it's a bit "rough".
>
> This is more or less what I prefer for SIGDEBUG, either unwinding the sta=
ck
> and printing the whole thing or dumping core for later analysis with gdb.
>
> --
> Thanks,
> //richard



--

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
