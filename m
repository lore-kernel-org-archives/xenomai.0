Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A620779CF
	for <xenomai@lists.linux.dev>; Fri, 28 Mar 2025 06:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743141659; cv=none; b=fXojihRxToiGDKLQ1iDnByC6vwJN/jjbN5gnne87Fjx4PoxoaR/HPwUpvRwnv4sipdrWDNTaOGe/w0h84/Vp45pXNKlTX4PvcHNgIbdXTKvYzF4cJ42C10/gPThfCX1ry3I0gEjsN8bkMwmUP68TTw27fV3cH26hTfMX1MaqdW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743141659; c=relaxed/simple;
	bh=NbttmN+QtXzjLGRLGUB0XdxqeuV3DADkrjPFV1Pp5ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Br93wO7wPLjRC19LtYCg+18L0KmZl3tvL5Oprqu3J30La3hECE72QISwovdSFMgYt5Jpv0BzOKjxFGKi16PnVHBmmxX42AcVcRQAYEk/vX/+3Zo/7ck+hC9uJqWFcyuy1jIUd5oAJxChnZ2S2qjIk7bDtN5WBFSzM6cEjKBwn6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=FYAg1++7; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="FYAg1++7"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30db1bd3bebso16869061fa.2
        for <xenomai@lists.linux.dev>; Thu, 27 Mar 2025 23:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1743141655; x=1743746455; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWCN8VB5DCdciaAvMnSrvOG+1SAMT1CWgPqGKRf17eE=;
        b=FYAg1++7AxsrdxdzB7kyD+j23IOuOkG04OdV85uws9d+wK9MMLkhxVSlwrrZ+FfZuX
         NUi+i7b0ofwpQpJG8M+bZaw6Pky3xz1AyCWIwVnI3SZu9HuYN5nvxpbTTsHQnRaxB0ZL
         JQoDWn+o79T7T6d2f52mytyGO29AgB4i7UIeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743141655; x=1743746455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWCN8VB5DCdciaAvMnSrvOG+1SAMT1CWgPqGKRf17eE=;
        b=fbvVr8t+WmiUa1JFSWscII7awBZ68ixLf39uZvtfQB2Ta1g1AQB6Lpc6mMWRTTvDlP
         QBZss0hzPsNHhzPkWn/F3qiTnK2O2FvK9/30lKIQK8iaYXqKx0viiXZgpQXKtlCcdwgX
         R193W//qd/AE1eqjrEweX8ILvb5j8KqQfsvsoEyi/6jU9UcVSrg0skEJehR4sxlEeXc2
         iRvT7lPj7FcnFKu+T4I8KckeJKCvKYCcLGv5Tyy5PRWqynTJKdq7Ko2rIAjrtcRnbIvo
         X45Yv/eyGfbZMB101LQzHy3HDhXBXKyoA1ieatsMUu3KAzVtIQjANS8ANjO2oN+rHimG
         +xbA==
X-Forwarded-Encrypted: i=1; AJvYcCWuMdgLG9j+2ikTUb807M/B70W+aqyKuf2aP5e/ok1C3IIv0qtOGPvahZQcOPMz8Be5/bAzJa3v@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6D05qdPxUsqAqkgOuzbLszXP1PZg2XQXKyOrM5cd3ixls8ZwA
	EyZ7YZj+h8pkw02lNvFHy+9rOF6z0LEPXzvp/dd1DddIhXg4h25mMeZKVzAjK2Sy/9Tb8ByxQ3f
	TxXXszWSO2gJ7KHhXqVKfr3QR2mTMSFHEvqCznA==
X-Gm-Gg: ASbGncsQvaDEzuo0qZlx0do8od1vovKyEd4jdMYGy0UyN3nFClEGHPQh1ZBTiTFSbyG
	Fmy6Cdc83djvcP27k0puITqlO2oP7QsjOHpNI7Ywjgh93Kwz7Ba5/7d/CG66QbQE/AZLgDqPGL/
	tUxh6QSH6edYJjz36SsHimr2K9LShr8h0HxAzY8I8x57Jh8vebj0MlRqrRyg==
X-Google-Smtp-Source: AGHT+IHkV8KDW8AvqYOu0SNWf7gpo1f92VlxA8MEIw/8cTHQkIIbEnSp/W1AG4abLMi9NT33w3sP0inUa0pDdU4eufA=
X-Received: by 2002:a05:651c:1502:b0:30c:2590:124c with SMTP id
 38308e7fff4ca-30dc5e5290bmr27899201fa.11.1743141654643; Thu, 27 Mar 2025
 23:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <DB9PR09MB60325FCC7AEFE1880D9698EF81A62@DB9PR09MB6032.eurprd09.prod.outlook.com>
 <DB9PR09MB6032B14E3FA653EB1FD4BDEC81A62@DB9PR09MB6032.eurprd09.prod.outlook.com>
 <582f231a-3e17-4b4a-804e-7f43ebda3c48@siemens.com> <CAFc1U0t8cWGpCc-ntsxCm-+obz7fu3w8jMrV1w=XtRyRCMDKqQ@mail.gmail.com>
In-Reply-To: <CAFc1U0t8cWGpCc-ntsxCm-+obz7fu3w8jMrV1w=XtRyRCMDKqQ@mail.gmail.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 28 Mar 2025 07:00:43 +0100
X-Gm-Features: AQ5f1Jp5bbNutyyVoK-iaTwjKJHnAb_WH3fk1GbK4drPr8qbBIq_SXX0DuV_0TU
Message-ID: <CAFc1U0vf9y98v_iaWdBz1YcdRfJ+6pd_t1Hv+9F3zfmNu3+C1Q@mail.gmail.com>
Subject: Re: Xenomai 3 and Linux Dovetail Compatibility Table
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Yann Le Chevoir <yann.lechevoir@cae.com>, 
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Same for "all" the links (repositories) from xenomai.org !


Le ven. 28 mars 2025 =C3=A0 06:57, Pierre FICHEUX <pierre.ficheux@smile.fr>=
 a =C3=A9crit :
>
> Hi,
>
> The xenomai-images link seems to be "forbidden" (error 403).
>
> regards
>
> Le jeu. 27 mars 2025 =C3=A0 07:11, Jan Kiszka <jan.kiszka@siemens.com> a =
=C3=A9crit :
> >
> > On 26.03.25 21:47, Yann Le Chevoir wrote:
> > > Hello everyone,
> > >
> > > We previously discussed when I installed Xenomai 3.0.9 on an imx6q wi=
th Linux 4.9 + I-Pipe.
> > > It's working well!
> > >
> > > I am now trying to migrate this work to our imx8 with Linux 6.6.23 + =
Dovetail + Xenomai 3.2.6 (?).
> > > I also plan to try Xenomai 4 after becoming familiar with the latest =
Xenomai 3.
> > >
> > > At first glance, I find it difficult to determine which versions are =
supposed to work together.
> > > Did I miss a compatibility table somewhere?
> > >
> >
> > The only table we have are our CI and image configurations, see e.g
> > https://source.denx.de/Xenomai/xenomai-images.
> >
> > > After successfully preparing the kernel linux-dovetail-v6.6.23-doveta=
il2 + Xenomai 3.2.6 (using the tarball associated with the tag),
> > > I encountered a redefinition issue with DEFINE_SEMAPHORE in rtcan_dev=
.c, which does not compile,
> > > along with other compilation issues when fixing this one.
> >
> > You need 3.3 for kernels > 6.1.
> >
> > >
> > > Should I try Xenomai 3.3?
> > > Any other recommendations for this migration?
> >
> > Unless your hardware (and some unfortunate vendor kernel) puts
> > constraints on you, always start with latest stable version. That is
> > 3.3, and that is 6.12. 6.6 is no longer maintained as dovetail series.
> >
> > Jan
> >
> > --
> > Siemens AG, Foundational Technologies
> > Linux Expert Center
> >
>
>
> --
>
> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
>                              http://www.smile.fr
>                              https://smile.eu/fr/offres/embarque-iot
> I would love to change the world, but they won't give me the source code



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
