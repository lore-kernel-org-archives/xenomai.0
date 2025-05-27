Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DF5253B4C
	for <xenomai@lists.linux.dev>; Tue, 27 May 2025 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748359691; cv=none; b=NHh1BPMOkdsAh3YHZOjeC44oRNdp+hnyzby/0N1WMcVhIotdPPTJKTkF/PUgZ4g123tTI20AwdUvxVpOWQn2plw0Zzuvkmy0UvijgTnwvIk0C0qfDXVRORktIYeZmsTrtNe4Hn/gpvTd1i64l1eMUa2dGKJM2tBRCwKmmj85iUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748359691; c=relaxed/simple;
	bh=kvtDuQDFNlBZX9NcRG6RPJGLpn+qHPvTMCpd1bHKduI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CM4du1fxPkBZ7NMXhshpEd5iUlfCWH2SWmL3C0ldwpLNEjQAP97Cpl4Jk+Y/ntNYfHU8Ypvfo9PbHeDripqpigypbwbZVuTrvI/X9g1lWc+R8fxsJJkxBxrGcEy3JJLNEFnWi9krAvSebq44uwF2FlYaI+t4cVNwCE/vmTzKnr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lY4v5cLR; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY4v5cLR"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e302191a3so25364717b3.2
        for <xenomai@lists.linux.dev>; Tue, 27 May 2025 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748359688; x=1748964488; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gw2tt3kcoMbmknLtQXmTvx8KmybVifUdRqjKGHeOHOY=;
        b=lY4v5cLRnqKFz4j2jVwRE5R/WBtMiT0XjGwueMWnSOR8CWWUP+hyvfMep4FGtBv4LU
         rQ8axPCO4PT+zhwI2LkvTpGeuzzBsXtFGHSbf1P/eOpQzFcZP14vC0t6IlIbUmlFbV2c
         fA5jgqOAfmgmSqxq03VB6+vjavK8Vpsstw7h59aJmqF5+yytrQ3C9KSe4uJ71r7KztlC
         T9i3o67s7JEG82xcer9knlHFBvyB8x4ycoMpuWAmZKKMwAc/mKx+0ReBhMApbhQTAG1n
         OqbhTDlgHaoBfaP9WB+nyDp/C/0oxET3rFUIhA9m+9lhEkgsnnWeCeu5gfATUJtzF/8P
         ubPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748359688; x=1748964488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gw2tt3kcoMbmknLtQXmTvx8KmybVifUdRqjKGHeOHOY=;
        b=F9U5rFk225eojcMzVmISKEgusXHCSIm9pLzfVOo+5e/BNbZO4VGG0MqidtLuM+FOpR
         S6chR90LZQTNhfw66z6ROwg6YxkzYPQL9mvSjkNLLFUgIjJdvy9KHwy5zwSE/b3CAXWd
         +CpWWTHyE0A84Q1oeKs6wA+Fkv2NNINCvN4Z8adLpo0psMs/ReTSqeozMzmuXJSOqNtS
         IlkRoSNovw8zRvzM52cRoJuWhqb66h/X2ZaWa5RbJ3zsI9sfPkfkkJNTsGb/INWrWbLO
         AXOO8ctmUYkJDQ1CWPrDZJENZYDOTvQuasSJpINDJvB8fWsP4oCemoyI2bVNTa9xOpbh
         KUeA==
X-Gm-Message-State: AOJu0Yztp2QcRyIzAwkM700lRnhzyQR4nLq10UjHHzdaeG4B2Y9OwVF2
	QmfFNbnU1TX4zqWlYxtgwDURZbDlbEsOvuQQxXzgtREIgFxIcjjBg8Qpk4pVukJZDF/Ohkg64II
	He9sVbm7LASmjt+3yI4IpRTp202eBD5g=
X-Gm-Gg: ASbGncsQ8LibNBAQS7aNiNSWrr1cRFSreS1cOg6rxTgtTvTV2LR/w7xjcGxZCgeK9P2
	7Vaft9e03A/eN0aZk8xFDJRIhG0K0U+fPrHJsNHv4MwzA+yzYFyx9fHVxE03WJstMFhYiGBzOWp
	09LLnUeUe9W8wqduz40YXr4eKo85AZMNqbL4RAAVy6HwM=
X-Google-Smtp-Source: AGHT+IH4zbaQv9VLO9C+/Kc8aZa/8RZFqIh/Zgd3guAoX/yZEYDKF+INrsuP4PtThbjPTWXbUXZCwEird2pYZ/5adRQ=
X-Received: by 2002:a05:690c:688c:b0:6fb:b8a1:d3bb with SMTP id
 00721157ae682-70e2d9d4b09mr154104687b3.17.1748359688267; Tue, 27 May 2025
 08:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEzxD05xAJmeUeyFwcfqBDZMOqDfa1sL+iEUDknzmr6XwX5Q5Q@mail.gmail.com>
 <CAFc1U0vhiFvELw7Y0uxiASQspk2ZDkiA4G-1e_qDRZMVH3rf=w@mail.gmail.com>
 <CAEzxD05krv7gruQvkXe+-zpgjtbdrFOdr-ZY490uyp9ezcyDyQ@mail.gmail.com>
 <CAEzxD07g24GxEwV51QWa2SUg8+6xnXUteyaa_Vf9L97iVmX89w@mail.gmail.com> <CAFc1U0uNW-NiZqQFA4tU=GVYDOxa5tq5W1Vd1Fa1xjgr3nzbVA@mail.gmail.com>
In-Reply-To: <CAFc1U0uNW-NiZqQFA4tU=GVYDOxa5tq5W1Vd1Fa1xjgr3nzbVA@mail.gmail.com>
From: Tom <t93252352@gmail.com>
Date: Tue, 27 May 2025 11:27:57 -0400
X-Gm-Features: AX0GCFvrOP8VI6Eu_yD0GFLsSQaAdPJMyeRxTZU2CI9Si9DkiMwCl1MZFmdB0jA
Message-ID: <CAEzxD05N_icELe2dP8w_5ibFHW28oUteJSjpW4Q-XFL=AY594g@mail.gmail.com>
Subject: Re: Xenomai Installation Inquiry
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Jan and Pierre.
Pierre, could you clarify if specific kernel features or modules were
disabled in the Xenomai configuration or was that a typo?

On Sat, May 24, 2025 at 1:37=E2=80=AFAM Pierre FICHEUX <pierre.ficheux@smil=
e.fr> wrote:
>
> Here is the footprint with and without Xenomai 3 (rootfs + kernel) for
> a Pi 4. As you can notice, not a great difference.
>
> Xenomai
>
> $ ls -lLh tmp/deploy/images/raspberrypi4-64/core-image-base-raspberrypi4-=
64.rootfs.ext3
> -rw-r--r-- 2 pierre pierre 304M mai 24 07:24
> tmp/deploy/images/raspberrypi4-64/core-image-base-raspberrypi4-64.rootfs.=
ext3
>
> $ ls -lLh tmp/deploy/images/raspberrypi4-64/Image
> -rw-r--r-- 2 pierre pierre 44M mai  7 15:10
> tmp/deploy/images/raspberrypi4-64/Image
>
> $ du -s tmp/work/raspberrypi4_64-poky-linux/core-image-base/1.0/rootfs/us=
r/lib
> 29380 tmp/work/raspberrypi4_64-poky-linux/core-image-base/1.0/rootfs/usr/=
lib
>
> Mainline
>
> $ ls -lLh tmp/deploy/images/raspberrypi4-64/core-image-base-raspberrypi4-=
64.rootfs.ext3
> -rw-r--r-- 2 pierre pierre 316M mai 24 07:30
> tmp/deploy/images/raspberrypi4-64/core-image-base-raspberrypi4-64.rootfs.=
ext3
>
> $ ls -lLh tmp/deploy/images/raspberrypi4-64/Image
> -rw-r--r-- 2 pierre pierre 45M mai  7 15:40
> tmp/deploy/images/raspberrypi4-64/Image
>
> $ du -s tmp/work/raspberrypi4_64-poky-linux/core-image-base/1.0/rootfs/us=
r/lib
> 28588 tmp/work/raspberrypi4_64-poky-linux/core-image-base/1.0/rootfs/usr/=
lib
>
> regards
>
> Le ven. 23 mai 2025 =C3=A0 16:37, Tom <t93252352@gmail.com> a =C3=A9crit =
:
> >
> > Hello all,
> >
> > Just sending a follow up message as I wanted to know if there is an
> > exact number for the storage space required for Xenomai 3 vs 4 and
> > co-kernel vs single kernel.
> >
> > Thanks
> >
> > On Tue, May 20, 2025 at 10:30=E2=80=AFAM Tom <t93252352@gmail.com> wrot=
e:
> > >
> > > Thanks, is there a specific number for the storage space required for
> > > Xenomai, including all the additional libraries and updated kernel?
> > >
> > > On Tue, May 20, 2025 at 12:50=E2=80=AFAM Pierre FICHEUX <pierre.fiche=
ux@smile.fr> wrote:
> > > >
> > > > Hi,
> > > >
> > > > The footprint is very small: some additional libraries on the targe=
t
> > > > and an updated kernel.
> > > >
> > > > PREEMPT_RT doesn't need libraries but not a great difference compar=
ed
> > > > with rootfs footprint.
> > > >
> > > > Regards
> > > >
> > > > Le lun. 19 mai 2025 =C3=A0 20:55, Tom <t93252352@gmail.com> a =C3=
=A9crit :
> > > > >
> > > > > Dear Xenomai Project Team,
> > > > >
> > > > > I am part of a research team currently evaluating Xenomai 3 for h=
ard
> > > > > real-time control on our system. Could you please provide an esti=
mate
> > > > > of the typical storage space required for installing Xenomai 3?
> > > > >
> > > > > Additionally, if the installation has a relatively large footprin=
t,
> > > > > are there any recommended alternatives that offer comparable hard
> > > > > real-time capabilities but with a smaller storage requirement?
> > > > >
> > > > > Thank you for your time and assistance.
> > > > >
> > > >
> > > >
> > > > --
> > > >
> > > > Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.f=
r
> > > >                              http://www.smile.fr
> > > >                              https://smile.eu/fr/offres/embarque-io=
t
> > > > I would love to change the world, but they won't give me the source=
 code
>
>
>
> --
>
> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
>                              http://www.smile.fr
>                              https://smile.eu/fr/offres/embarque-iot
> I would love to change the world, but they won't give me the source code
