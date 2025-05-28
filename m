Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299B61C860C
	for <xenomai@lists.linux.dev>; Wed, 28 May 2025 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447238; cv=none; b=qL4SSBoHDH1j1do4NaC2jEiVccs2/edVYHFa3RjIb972AareZCf3k3HvR2U1DpAPXwnu75rt36YCDQYrCtfGbm7yQV136DegNecdJHoLBy6HPFod0JG5Kwiqb5tX12o7kpdN8OwxdwUbWWB1b0+qIYmk+nZaKHQyrVUXtLmT5Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447238; c=relaxed/simple;
	bh=m/4RTH9gp+R00cNgTZp7NlQUbMZjeT6//PsiFqCt6/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOUY/4xMA0zWGiJNKa+rEmaLjO6P77pfAmuczxgpsYPGwVqOPFBYeWNyKSkk76a3p8TPMsE0MtBEqyuhyf6VEHrVc2O8QCXwQW/c8/FwoqR66E9+MMAskHUiiQRh9T4G6s4zQVY4f4K+wfmdP022RwBqP3oJv3XhsIu4Hk3sBzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=diZM8FRR; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="diZM8FRR"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3105ef2a071so53692251fa.1
        for <xenomai@lists.linux.dev>; Wed, 28 May 2025 08:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1748447234; x=1749052034; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhUJ7yAIH9XgFPg+ZFC10jZ6RdO0WIoaLBpeo0I13RM=;
        b=diZM8FRRRUmOU/wEDMzlD2CM9/+alEz+r92OmXwswWU3jsjpSeRsE8iyGpD0973/jk
         rSo6vw8sjF0SgM2MqzavE2DhPJcjiWMTY4unANUh4sG2m4anqWs4efHnHo/c8k4zSQO3
         UVQmQCeiBAjmpzY1W4sWgtUJG0wdw739ZB/bI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748447234; x=1749052034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhUJ7yAIH9XgFPg+ZFC10jZ6RdO0WIoaLBpeo0I13RM=;
        b=vIeLFU+Pqu4uNQoszInLjW6b1ZacuIIBb5Avj+gbjLGJGL2BxEHcRHBfiZqlOOPPpO
         4CJwdNg2+HUPFXUfiZCgO/G4drwwdfV8Ld+KoW6bHUElJQvbQXOwL/x6f7LRWv+C+kXX
         MTxuDG3vHmDOq4eV1cUzGSBoeBBUGw9WUMAES4EjDlIR4QHet3k92hEeq3u7pt6PdMa1
         yobDS25gtSF+mC5yLB+K7MGxctAJ7ZI08RuaQ1NL+qV9EP+iHfIOQ8x4FXLQblfnSrzR
         9PPZZjrNYvWC8ZFyWN+a7FKlBjwUgPkzT/SDaJwneKcObE07q+mBVpesZNPv+Wew3w1g
         KeLg==
X-Gm-Message-State: AOJu0Yzr5AKxOgAw5D0KcQgIoSJ4MD5lO23NIzd3ovBHiEFZOCd+eXxI
	brifiTJVHKg5i0Uyf9QwC3xKUS2+KoaHdS0FvNmUl2KnamC1hrOxquPmhV94E5R++iJ4ogx+IM4
	q+XmK2N2UFBZ+4wcYW9lWsca2+LJLy4HnZsbyMfccHK48S4odRHRD
X-Gm-Gg: ASbGncvecyBg6a1vwZr+65ycAFGXekg+BhHTCXCFnjCK9fVSPQ+nPI+5CrxtAmEEZ4o
	tcWma0yg15m/sEXHMW5cWJ+GYDIjqTV0iS47mlXq7kt5DjRmQC0U40XcG63floqFNbcChPquH/a
	4U3isqJf/aR28T7MpKVzFLYJ8zv17sXZPqlWmoYkBS/Gi8JrljF9SExUtuWy8ubXskDeWJSIJwi
	CXE
X-Google-Smtp-Source: AGHT+IGs0zaWlI3OAT1QNcJSsvhLehnPyKffPL2a4URqxJrOgS1HTcrZvP42d7BUI7gsvEy3wrshhxnmHuej3sxTmXQ=
X-Received: by 2002:a2e:bcc2:0:b0:32a:646d:458a with SMTP id
 38308e7fff4ca-32a646d475cmr38098981fa.31.1748447233980; Wed, 28 May 2025
 08:47:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEzxD05xAJmeUeyFwcfqBDZMOqDfa1sL+iEUDknzmr6XwX5Q5Q@mail.gmail.com>
 <CAFc1U0vhiFvELw7Y0uxiASQspk2ZDkiA4G-1e_qDRZMVH3rf=w@mail.gmail.com>
 <CAEzxD05krv7gruQvkXe+-zpgjtbdrFOdr-ZY490uyp9ezcyDyQ@mail.gmail.com>
 <CAEzxD07g24GxEwV51QWa2SUg8+6xnXUteyaa_Vf9L97iVmX89w@mail.gmail.com>
 <CAFc1U0uNW-NiZqQFA4tU=GVYDOxa5tq5W1Vd1Fa1xjgr3nzbVA@mail.gmail.com> <CAEzxD05N_icELe2dP8w_5ibFHW28oUteJSjpW4Q-XFL=AY594g@mail.gmail.com>
In-Reply-To: <CAEzxD05N_icELe2dP8w_5ibFHW28oUteJSjpW4Q-XFL=AY594g@mail.gmail.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Wed, 28 May 2025 17:47:02 +0200
X-Gm-Features: AX0GCFtBAmbF5_-w6rIfTXXd6O19S8xkc9KArFDhprBA8XQW0KREBm4gax6uk3k
Message-ID: <CAFc1U0tTeiR=khP2-8bdHUPE1vbFKdBk8Q3TNGfD+Wkh4LxNzw@mail.gmail.com>
Subject: Re: Xenomai Installation Inquiry
To: Tom <t93252352@gmail.com>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Some kernel features such as CONFIG_ACPI or CONFIG_CPU_FREQ should be
disabled as they are not compatible with
Xenomai (and could lead to performance issues). Is that what you mean ?

I use a Yocto (or Buildroot)  configuration fragment to disable them.

Regards

Le mar. 27 mai 2025 =C3=A0 17:28, Tom <t93252352@gmail.com> a =C3=A9crit :
>
> Thanks Jan and Pierre.
> Pierre, could you clarify if specific kernel features or modules were
> disabled in the Xenomai configuration or was that a typo?
>
> On Sat, May 24, 2025 at 1:37=E2=80=AFAM Pierre FICHEUX <pierre.ficheux@sm=
ile.fr> wrote:
> >
> > Here is the footprint with and without Xenomai 3 (rootfs + kernel) for
> > a Pi 4. As you can notice, not a great difference.
> >
> > Xenomai
> >
> > $ ls -lLh tmp/deploy/images/raspberrypi4-64/core-image-base-raspberrypi=
4-64.rootfs.ext3
> > -rw-r--r-- 2 pierre pierre 304M mai 24 07:24
> > tmp/deploy/images/raspberrypi4-64/core-image-base-raspberrypi4-64.rootf=
s.ext3
> >
> > $ ls -lLh tmp/deploy/images/raspberrypi4-64/Image
> > -rw-r--r-- 2 pierre pierre 44M mai  7 15:10
> > tmp/deploy/images/raspberrypi4-64/Image
> >
> > $ du -s tmp/work/raspberrypi4_64-poky-linux/core-image-base/1.0/rootfs/=
usr/lib
> > 29380 tmp/work/raspberrypi4_64-poky-linux/core-image-base/1.0/rootfs/us=
r/lib
> >
> > Mainline
> >
> > $ ls -lLh tmp/deploy/images/raspberrypi4-64/core-image-base-raspberrypi=
4-64.rootfs.ext3
> > -rw-r--r-- 2 pierre pierre 316M mai 24 07:30
> > tmp/deploy/images/raspberrypi4-64/core-image-base-raspberrypi4-64.rootf=
s.ext3
> >
> > $ ls -lLh tmp/deploy/images/raspberrypi4-64/Image
> > -rw-r--r-- 2 pierre pierre 45M mai  7 15:40
> > tmp/deploy/images/raspberrypi4-64/Image
> >
> > $ du -s tmp/work/raspberrypi4_64-poky-linux/core-image-base/1.0/rootfs/=
usr/lib
> > 28588 tmp/work/raspberrypi4_64-poky-linux/core-image-base/1.0/rootfs/us=
r/lib
> >
> > regards
> >
> > Le ven. 23 mai 2025 =C3=A0 16:37, Tom <t93252352@gmail.com> a =C3=A9cri=
t :
> > >
> > > Hello all,
> > >
> > > Just sending a follow up message as I wanted to know if there is an
> > > exact number for the storage space required for Xenomai 3 vs 4 and
> > > co-kernel vs single kernel.
> > >
> > > Thanks
> > >
> > > On Tue, May 20, 2025 at 10:30=E2=80=AFAM Tom <t93252352@gmail.com> wr=
ote:
> > > >
> > > > Thanks, is there a specific number for the storage space required f=
or
> > > > Xenomai, including all the additional libraries and updated kernel?
> > > >
> > > > On Tue, May 20, 2025 at 12:50=E2=80=AFAM Pierre FICHEUX <pierre.fic=
heux@smile.fr> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > The footprint is very small: some additional libraries on the tar=
get
> > > > > and an updated kernel.
> > > > >
> > > > > PREEMPT_RT doesn't need libraries but not a great difference comp=
ared
> > > > > with rootfs footprint.
> > > > >
> > > > > Regards
> > > > >
> > > > > Le lun. 19 mai 2025 =C3=A0 20:55, Tom <t93252352@gmail.com> a =C3=
=A9crit :
> > > > > >
> > > > > > Dear Xenomai Project Team,
> > > > > >
> > > > > > I am part of a research team currently evaluating Xenomai 3 for=
 hard
> > > > > > real-time control on our system. Could you please provide an es=
timate
> > > > > > of the typical storage space required for installing Xenomai 3?
> > > > > >
> > > > > > Additionally, if the installation has a relatively large footpr=
int,
> > > > > > are there any recommended alternatives that offer comparable ha=
rd
> > > > > > real-time capabilities but with a smaller storage requirement?
> > > > > >
> > > > > > Thank you for your time and assistance.
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > >
> > > > > Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile=
.fr
> > > > >                              http://www.smile.fr
> > > > >                              https://smile.eu/fr/offres/embarque-=
iot
> > > > > I would love to change the world, but they won't give me the sour=
ce code
> >
> >
> >
> > --
> >
> > Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
> >                              http://www.smile.fr
> >                              https://smile.eu/fr/offres/embarque-iot
> > I would love to change the world, but they won't give me the source cod=
e



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
