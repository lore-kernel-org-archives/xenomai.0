Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338CEE573
	for <xenomai@lists.linux.dev>; Fri, 28 Mar 2025 05:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743141492; cv=none; b=dazlPMgwfdP5n/DDpb0MyIJjcTS4FWJlFyW10YDd63Pvsy9SNgkTpooPa5em4Yx+cXb1YdTBCONDyAN4C5KE88jjsTRWWkYOh1xRSZPtUCvvMKABhAFrDHOqqUoQ15hJOlFa/4f/iSnwH3UCFkWbaaEjrtI9QdQSkPJqGGwo9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743141492; c=relaxed/simple;
	bh=1FTlrUvrmrn5/06/xev22FWnYmmQ1A4j8h8mVevutmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6C2l4ROgSBOnn+dQMvmw28h0v2kYP6p/BPGmzX26lciF66XdZ5CRJC3Gv/MiIoz+P8ZcQIJMW3zQMmy4ElKBBvcKK9Ml6AMthBJEbIeshbeacdfjT1JtMlK+V11YjQllHIjB2MuL1qeFZQR8cbq1goWwBuWKXW4jztmzHYp85o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=shFwKnyo; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="shFwKnyo"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54ac9d57173so3137128e87.0
        for <xenomai@lists.linux.dev>; Thu, 27 Mar 2025 22:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1743141487; x=1743746287; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbatxizFqMKDwvPHDkH2geGFx9At6jvRXpmpSmtMsSQ=;
        b=shFwKnyoEAUhFUVOOS0VBkNpD+UC44/5Bkyz3GtzI3EFk8esSaed0czOypBrXAVOoa
         8EOJi8Y4+hrU6yHKCHytsD0y/T1PcaRiVIndcX1Em9V9AtM3BrzXU1O1IJn06R4sjVgh
         aG/2x1Kugm/tunik3/qT/GWdzv92pOWEOF0GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743141487; x=1743746287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbatxizFqMKDwvPHDkH2geGFx9At6jvRXpmpSmtMsSQ=;
        b=uSTCHaWt9AnD/UmvDeDeIshzgb6UYs/4DlB/8uBNZnakeaP8av6LH6gguZ9oEUc0x5
         CCGb9sjHNvJ4da9Vv+g1rYWgmcaYyN7lMyejGDxQjUbExlHdhyp/waa/xQc5VTEIzHoB
         7+TrtDbwAzuwO4Jt/ivVJevaZnSzsrOCWr2IFXMLOSB+RKjHXq1qVsWgfWTaQkjWTIyD
         rBpXVHjmQs1cneTQmB8fskRAvOBouy1E3+EgEm2thtVcvjG6kSW3jk6vwS3PjRmr8dWS
         knc0McYoVmJkPyzF0eQ+mn9sIQScrjHmjd5DObzIT4maHbkfB3R5sOVuLQFMkXURxY5R
         DLWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEjp50bBtXvBw7oCHs9uMmtbRMKp2ZkMPYqDAbGv336CGDCjaU6gisNBcHm91tu/rtvqQm34Sc@lists.linux.dev
X-Gm-Message-State: AOJu0YxxoXFdUjaDDUJda/e65G2QXT3qOarVuqUhXvz/A3zDzmY1TUL0
	R+nioQcLEslTuvZ37Aild1CA73iE6nFwM9XtwwB/Tf2Suu7iTs3ePMC5beWn0bQm762DcfEkmEB
	Ul15Ta7KO/AFhXE8xJsRe95/MRCBpNHmD6Edi7w==
X-Gm-Gg: ASbGncur7rIpz7b3D9oNjzutRHvrKwLWLcImoiyKqdmifhEtTqucO5g9uyWKSPkRp5b
	ko6jyrAm09tZ+/qdDof2OxQDTv6J8WfNx1TU87mNaGvR2RGLLNUTkvYjZ+/IDRBxskquedijq8T
	KRVOfplZPFqXZOnz+LLDr1nJiOmTksPVbUefIXe8j6VWASC6tGjXluH4wfVg==
X-Google-Smtp-Source: AGHT+IGNs6S5waWzJXKo0ea4UKWbovWA1nkzISttIb1Wxio5Qw7QeUCaJH+TTXt9DvQvuYT44T764/58hORf5g8cWhI=
X-Received: by 2002:a05:6512:3bb:b0:546:1ffa:51ce with SMTP id
 2adb3069b0e04-54b0ace1a57mr360608e87.21.1743141487038; Thu, 27 Mar 2025
 22:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <DB9PR09MB60325FCC7AEFE1880D9698EF81A62@DB9PR09MB6032.eurprd09.prod.outlook.com>
 <DB9PR09MB6032B14E3FA653EB1FD4BDEC81A62@DB9PR09MB6032.eurprd09.prod.outlook.com>
 <582f231a-3e17-4b4a-804e-7f43ebda3c48@siemens.com>
In-Reply-To: <582f231a-3e17-4b4a-804e-7f43ebda3c48@siemens.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 28 Mar 2025 06:57:56 +0100
X-Gm-Features: AQ5f1JpHNLMqxBvNZ6BiFdzpeMfMQeXPIymQFmv3SW8pvsBl3puaNITQw_bah68
Message-ID: <CAFc1U0t8cWGpCc-ntsxCm-+obz7fu3w8jMrV1w=XtRyRCMDKqQ@mail.gmail.com>
Subject: Re: Xenomai 3 and Linux Dovetail Compatibility Table
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Yann Le Chevoir <yann.lechevoir@cae.com>, 
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

The xenomai-images link seems to be "forbidden" (error 403).

regards

Le jeu. 27 mars 2025 =C3=A0 07:11, Jan Kiszka <jan.kiszka@siemens.com> a =
=C3=A9crit :
>
> On 26.03.25 21:47, Yann Le Chevoir wrote:
> > Hello everyone,
> >
> > We previously discussed when I installed Xenomai 3.0.9 on an imx6q with=
 Linux 4.9 + I-Pipe.
> > It's working well!
> >
> > I am now trying to migrate this work to our imx8 with Linux 6.6.23 + Do=
vetail + Xenomai 3.2.6 (?).
> > I also plan to try Xenomai 4 after becoming familiar with the latest Xe=
nomai 3.
> >
> > At first glance, I find it difficult to determine which versions are su=
pposed to work together.
> > Did I miss a compatibility table somewhere?
> >
>
> The only table we have are our CI and image configurations, see e.g
> https://source.denx.de/Xenomai/xenomai-images.
>
> > After successfully preparing the kernel linux-dovetail-v6.6.23-dovetail=
2 + Xenomai 3.2.6 (using the tarball associated with the tag),
> > I encountered a redefinition issue with DEFINE_SEMAPHORE in rtcan_dev.c=
, which does not compile,
> > along with other compilation issues when fixing this one.
>
> You need 3.3 for kernels > 6.1.
>
> >
> > Should I try Xenomai 3.3?
> > Any other recommendations for this migration?
>
> Unless your hardware (and some unfortunate vendor kernel) puts
> constraints on you, always start with latest stable version. That is
> 3.3, and that is 6.12. 6.6 is no longer maintained as dovetail series.
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
