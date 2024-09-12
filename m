Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0E918BC05
	for <xenomai@lists.linux.dev>; Thu, 12 Sep 2024 06:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123924; cv=none; b=EvZbh6y4xME0s0C2GCY+Xdv5xWKfRm4gCY+Coj8nVFbpeKsejCNqEQ7IlAu2fzZfVdZToi4J6tMbCkToXZk7x4JzUPC0eOXFS/tnCGQSIsX61f3m0mirXnXNGMrb7/wpms8t7mJFUL9lxuKv63TjF/8Bxhekd+H5Pe0umIEb+4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123924; c=relaxed/simple;
	bh=aXAqlDYdKo3/viSQuHU6j9uo/dkE4iIsu8uVK1oeK8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bC4ownNYfABbtyd4Zun40sk9HcyhAYFYMunEIs8Rv/Cguwhp507uTtuXCAWUSpwPGP9jFfFd7FaMaRM1wnOOVG9te3sqNUxKy7xKUKprSimtcgAJK+LU6lW/bls3yuy19wR9cBP6ESqsjwQbEpqjpmERC8vHNtHRvjvCTyQO+4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1xQS9QC; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1xQS9QC"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8a7903cb7dso49740866b.3
        for <xenomai@lists.linux.dev>; Wed, 11 Sep 2024 23:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726123918; x=1726728718; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/7PY86ZQ8tYmTyx3RaU/G2c/r/Ihlw4x2UWpLbcixc=;
        b=A1xQS9QCn5XDj2Fk9ehr94PRDs/hizb1SdYIOWOoL5zvsjoHgrfMh4TUJpoLhKBLk1
         qIj3eD/ZOxa1b+l1NwraTmecUhpvgWx20DWEdSG8KCqtdiJgttOhJVpfitEuQDz52r2k
         23DVnQM15s0YQIdJFoF3aTi8SCeBs/v8W0hfKaoPbaoBVZdyvkt+c0/1z8Vx4uvqQ7QA
         uomQ1aSZesNKOHKu2csqZNj23uHYwbrlKpUHH6wtLK7mwX8DLFXWvPMX9J02n3Pd0lZF
         Xe6lJwyxbIVz89iQRC0uUVGRFn7XFgNjJeQjisfDq2wzgcIXpMnRKJd1tnsdxPlSaewS
         Dacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726123918; x=1726728718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/7PY86ZQ8tYmTyx3RaU/G2c/r/Ihlw4x2UWpLbcixc=;
        b=O39GuoF4fmJho9K4d5k20B9Iv+aUuuiFfPkoH9qBiEA1jY2un4tglF6N1To6gn5cBB
         DnUWiK4+SADc2k9jgf90EpQKE0QM+ZOH+k207zJDaKZuNS5a4MzVYrN06cuXv1YKXq1P
         8BLMrEJrr9fHbK0VaRQ6kMHAqPKgoEuZOtcYoxFhMja+eRVSTsDOSCsliernpxl3b7Q1
         R7ws1O9cBzlUOEKyIaIgiSX2Ww9RFtgJ30baxvcgyRZndtW1G2xqtfkKbwTJs9a88EW4
         8Wd9a2bBTAF9DOZnsZZPcCk+XAbQr2NQkTiBryqVTBgivlVRus5ZVhaL/pjQVkpPJmem
         BhZA==
X-Forwarded-Encrypted: i=1; AJvYcCUMl+8kfLnJNDEhmBKZ/zg/W228Cng8i1FL7gSnj6MvOrVNUjoqZuIPUQIeA73xidv8ydHnNZK6@lists.linux.dev
X-Gm-Message-State: AOJu0YwD6uDkbCfCw6WqHiHfiCFIHzY4nVkqzDi1Ygt7j/woJ/GzU3Te
	hjr/2Tg2vHW8ZEU2WlxSr4WyE80j6bdETLAe6trhxkxgdWNPpxIMY1ksnUYiymWW7KA0m3Omibd
	7SF3E9Imx/O3eQvb0dHLm+eEpEFywr3YH
X-Google-Smtp-Source: AGHT+IHM9hAHq3D56/mofq66EuQhZ3Ikje3Uxz79V7vpX6aFc8hwh41LVyoKQaBM4sZr0qej83J3BAmuh0CZoiUy09g=
X-Received: by 2002:a05:6402:4308:b0:5c2:70a2:9418 with SMTP id
 4fb4d7f45d1cf-5c413e05887mr1704591a12.6.1726123916866; Wed, 11 Sep 2024
 23:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <AM6PR05MB6024420AB2F1754C19B5612EAD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
 <fc38f3af6fa7b993fdbc81deecd7134ad6a39af4.camel@siemens.com>
 <AM6PR05MB60248E3F1360E8FDFFFADCD4AD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
 <f8bdb69f-b500-4a5d-9739-90cb1a1a88d8@siemens.com> <AM6PR05MB60248187776E0975A0D64FBBAD9A2@AM6PR05MB6024.eurprd05.prod.outlook.com>
 <e45dc61e-bcae-4d45-aeb8-d195528428f7@siemens.com>
In-Reply-To: <e45dc61e-bcae-4d45-aeb8-d195528428f7@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Wed, 11 Sep 2024 23:51:45 -0700
Message-ID: <CA+K1mPEmN1_GEJY9QQ=yJ1fiCT6MfozAQBJJmUnUVWyc+6Ud6A@mail.gmail.com>
Subject: Re: Compilation error kernel Xenomai3 for x86 32 bits
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: LE-DOUARAIN Marc <m.ledouarain@fareco.fayat.com>, 
	Florian Bezdeka <florian.bezdeka@siemens.com>, 
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 6:32=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> On 10.09.24 14:46, LE-DOUARAIN Marc wrote:
> >
> >>>
> >>>>> I=E2=80=99ve tried to compile linux-dovetail-v5.10.214-dovetail1 gi=
thub
> >>>>> repository for Xenomai 3.2.5 (from a Debian12.6 i386), and it faile=
d on theses errors :
> >>>>> (the same with Xenomai 3.2.4)
> >>>
> >>>> I think the main point here is that we do no longer support 32 bit k=
ernels. We still support the compat case, so 32 bit applications running on=
 a 64 bit kernel. Might that be an option for you?
> >>>> Should work as long as your board supports is 64 bit.
> >>>
> >>> We are working step by step to update OS with an old base hardware (I=
SA bus) as transitional for now, and will use a 32 bits CPU "Vortex86DX3".
> >>>
> >>>>>
> >>>>> I=E2=80=99ve used the command =C2=AB /prepare-kernel.sh --linux=3D#=
#######/linux-dovetail-v5.10.214-dovetail1 --arch=3Di386 =C2=BB before conf=
iguring kernel.
> >>>>> Not better with linux-dovetail-v6.6.23-dovetail2.
> >>>
> >>>> Haven't touched the prepare-kernel script for a while. Seems we shou=
ld bail out and complain loudly when trying to use --arch=3Di386.
> >>>
> >>> If I can understand that for the =E2=80=9Cnew=E2=80=9D Xenomai 4, 32 =
bits is excluded,
> >>> it's perhaps a pity that Xenomai 3 can't continue to be used, especia=
lly if there's not much to be done to fix it and make it work on 32 bits.
> >>
> >> 32-bit x86 kernels are practically history since almost a decade, inde=
pendent of Xenomai. 32-bit applications on 64-bit kernels are still support=
ed (even with Intel upcoming cuts), but only few people were testing 32-bit=
-only x86 kernels that long ago. Probably almost no one is doing it in this=
 decade anymore. Distros have dropped 32-bit, and CPUs that lack 64-bit sup=
port can be counted with one hand - if not even a single finger.
> > Although rare these days, some distros 32 bits are still available, lik=
e the classic Debian ! =F0=9F=98=89
> >
>
> Right, but nothing I would dare to deploy into anything mission critical.
>
> >>> Is the error, on Xenomai side, or moreover kernel patched ?
> >>> Which kernel / Xenomai latest versions were running on 32 bits for su=
re, or at what time ?
> >
> >> I would not say that Xenomai 3 is definitely dead on i386 but no one l=
ooked at it in a very long while. It could theoretically still work with ip=
ipe-4.4.y-cip, but anything newer dropped it. While we are still carrying i=
386 in that kernel, we didn't test it for many years now. Also note that th=
is kernel is now getting closer to its EOL.
> >
> > I could effectively go back to ipipe for this transition stage on our c=
urrent hardware.
> > The latest ipipe kernels seems to be available here : https://source.de=
nx.de/Xenomai/
> > but what is the difference between repositories ipipe and ipipe-x86 ?
> > What was the last known Xenomai version 3.x really used and tested with=
 ipipe?
>
> Here is our full test pipeline:
>
> https://source.denx.de/Xenomai/xenomai-images/-/pipelines/22174
>
> 3.2 and older are still (or only) supporting I-pipe.
>
> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center

Hi Marc,

I still use 32 bit Xenomai 2.6.5 with ipipe patch on kernel 3.18.20,
on a Fedora 21 distro. It is very stable.  I have to use this version
because we have a legacy 32-bit AMD Geode LX800 CPU (X86) on one of
our embedded PCs. I don't know how well your Vortex CPU would work.
The Xenomai project is not actively supporting Xenomai 2.x but it is
well documented, and you can search the mailing list for prior
messages.

-C Smith
