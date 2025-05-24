Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D6156F5D
	for <xenomai@lists.linux.dev>; Sat, 24 May 2025 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748065026; cv=none; b=NkE+gs36oga5vMh6+Abp5Ruv6h7ra44u2UaUlR3KLRXqjW8qXPLNb6KHUHfdc7PgnPXPfc54s7gaZ+C6rF73X3GihmBYx+huKxRY5DEKVGlLmD9D2hN4TRamT1j2C0xYsVFQLCzEYZjCFwGq3fQJ4qw0WWJ7yigZ4TpEfzWNRzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748065026; c=relaxed/simple;
	bh=ulfCKIo6BuyDqXh8jwQGS9jxeFaOFYTPbb+XspDeRgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lro70lRswprq0UqWFwD6ePsveCkFSRIrx4qUUfEnfBbzEXcMYUKacnR6dyLqR9Y8wdtVtJFVfcBLefm0eSF40JUM3bdMRfWv1B4HiQB5Kefv8mZ9HQLUPd71WH1IHAx2rEmu/Kxsqe6k/hDeMS8kEf3cnA8B1P0oUyC2wc/WCEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=kMooqvYt; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="kMooqvYt"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3105ef2a06cso4429191fa.2
        for <xenomai@lists.linux.dev>; Fri, 23 May 2025 22:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1748065022; x=1748669822; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTARTrjPa/l5psjhkG4Yr2OpbJauWSP7WhCyNMFWzF8=;
        b=kMooqvYtcNzmBGzd2bmQp3js+bzSYj3NPNqpXluk21K+nIDRhk5XlXz7jRzXsADoOt
         lkQB9xA7Mq0cvH0wZlArZ1+wnH1sv67tMdaQVt7pHEnx7nWvybchmYbk7GY9fRuihjm3
         j4LbLc8EMFZGRdjma3K3D9212b82FrZDwIcQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748065022; x=1748669822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTARTrjPa/l5psjhkG4Yr2OpbJauWSP7WhCyNMFWzF8=;
        b=tmg2N9xFYb+Cal7n2n3N+kzaG40zmwXbwbuIoTGr3JjCcp14ZCcAze9mzMySxxR8cT
         260CSCVL6knyuwKBw/LsYWx04zIR9auchpkvSzdxrg1qoRkAdhTgZox/hKm1H5lnILmE
         g5/MyU0wXTBu0AAs2Mox/s6QcWuCY7IVeb8kcD7TG1N51g2zsNa0JtYXwSCQpTWO1Uqv
         b4+TqMkhb+CcgJUOrqYQmFLBGgdNl6nCbs2b2yRtkgGdWMEPlYvViAd+aCBnjIiqNho9
         6ApRxn5o9lkJAcjDMjyeAxjYP7SNMFwwM9jcJ3rsd0PVlW2rOZb37P2YU0CggQZlwxbC
         xxlw==
X-Gm-Message-State: AOJu0Yz4+GNgMq21MQ82iswMRY0RWLR4ELbWaVnhUM36xptr2X3yVC60
	ml+mZvJNycR6b9VAcNx/Tt3TWVPaAKK/8Td4UtdfnLlqi7u2/J7XKx+skffKkh8Cw2OS0FatfEW
	8Z9mKonsKWBEtxgFBkPhpHT0yiJobDpNmzl7Jdmmgnw==
X-Gm-Gg: ASbGncvb3T3fBI1lF9baWtIMZWWobP7/epAXIGhXxFYH7xiKzujnjFuB2BIlANSYRx4
	n1Yby4gkWMfhJ9XB071dOEC2yKPWbpQU4Fp94nZ4iKjrMpZwPqx7Bi4G+MPe+wFKe3PmUPxpnMx
	yiWZEeMGRhmQRedf5rJ6yKDDkYHbsYxw==
X-Google-Smtp-Source: AGHT+IE0XqkLhOfJ3Aqs2Q2PhyQj0M8yWLoEMGOI7xJhHoutsY397aw/tASyaEo9xfxv0lwsfRUFq0dh+egFRIEKPgE=
X-Received: by 2002:a05:651c:19ab:b0:30b:d656:1485 with SMTP id
 38308e7fff4ca-3295ba58c45mr4943981fa.32.1748065022161; Fri, 23 May 2025
 22:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEzxD05xAJmeUeyFwcfqBDZMOqDfa1sL+iEUDknzmr6XwX5Q5Q@mail.gmail.com>
 <CAFc1U0vhiFvELw7Y0uxiASQspk2ZDkiA4G-1e_qDRZMVH3rf=w@mail.gmail.com>
 <CAEzxD05krv7gruQvkXe+-zpgjtbdrFOdr-ZY490uyp9ezcyDyQ@mail.gmail.com> <CAEzxD07g24GxEwV51QWa2SUg8+6xnXUteyaa_Vf9L97iVmX89w@mail.gmail.com>
In-Reply-To: <CAEzxD07g24GxEwV51QWa2SUg8+6xnXUteyaa_Vf9L97iVmX89w@mail.gmail.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Sat, 24 May 2025 07:36:51 +0200
X-Gm-Features: AX0GCFu-dCU8iXTZKOvR4PaHeQVDQBrCh25Y1b9DZOchHozec9QUsATvd3YuX08
Message-ID: <CAFc1U0uNW-NiZqQFA4tU=GVYDOxa5tq5W1Vd1Fa1xjgr3nzbVA@mail.gmail.com>
Subject: Re: Xenomai Installation Inquiry
To: Tom <t93252352@gmail.com>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here is the footprint with and without Xenomai 3 (rootfs + kernel) for
a Pi 4. As you can notice, not a great difference.

Xenomai

$ ls -lLh tmp/deploy/images/raspberrypi4-64/core-image-base-raspberrypi4-64=
.rootfs.ext3
-rw-r--r-- 2 pierre pierre 304M mai 24 07:24
tmp/deploy/images/raspberrypi4-64/core-image-base-raspberrypi4-64.rootfs.ex=
t3

$ ls -lLh tmp/deploy/images/raspberrypi4-64/Image
-rw-r--r-- 2 pierre pierre 44M mai  7 15:10
tmp/deploy/images/raspberrypi4-64/Image

$ du -s tmp/work/raspberrypi4_64-poky-linux/core-image-base/1.0/rootfs/usr/=
lib
29380 tmp/work/raspberrypi4_64-poky-linux/core-image-base/1.0/rootfs/usr/li=
b

Mainline

$ ls -lLh tmp/deploy/images/raspberrypi4-64/core-image-base-raspberrypi4-64=
.rootfs.ext3
-rw-r--r-- 2 pierre pierre 316M mai 24 07:30
tmp/deploy/images/raspberrypi4-64/core-image-base-raspberrypi4-64.rootfs.ex=
t3

$ ls -lLh tmp/deploy/images/raspberrypi4-64/Image
-rw-r--r-- 2 pierre pierre 45M mai  7 15:40
tmp/deploy/images/raspberrypi4-64/Image

$ du -s tmp/work/raspberrypi4_64-poky-linux/core-image-base/1.0/rootfs/usr/=
lib
28588 tmp/work/raspberrypi4_64-poky-linux/core-image-base/1.0/rootfs/usr/li=
b

regards

Le ven. 23 mai 2025 =C3=A0 16:37, Tom <t93252352@gmail.com> a =C3=A9crit :
>
> Hello all,
>
> Just sending a follow up message as I wanted to know if there is an
> exact number for the storage space required for Xenomai 3 vs 4 and
> co-kernel vs single kernel.
>
> Thanks
>
> On Tue, May 20, 2025 at 10:30=E2=80=AFAM Tom <t93252352@gmail.com> wrote:
> >
> > Thanks, is there a specific number for the storage space required for
> > Xenomai, including all the additional libraries and updated kernel?
> >
> > On Tue, May 20, 2025 at 12:50=E2=80=AFAM Pierre FICHEUX <pierre.ficheux=
@smile.fr> wrote:
> > >
> > > Hi,
> > >
> > > The footprint is very small: some additional libraries on the target
> > > and an updated kernel.
> > >
> > > PREEMPT_RT doesn't need libraries but not a great difference compared
> > > with rootfs footprint.
> > >
> > > Regards
> > >
> > > Le lun. 19 mai 2025 =C3=A0 20:55, Tom <t93252352@gmail.com> a =C3=A9c=
rit :
> > > >
> > > > Dear Xenomai Project Team,
> > > >
> > > > I am part of a research team currently evaluating Xenomai 3 for har=
d
> > > > real-time control on our system. Could you please provide an estima=
te
> > > > of the typical storage space required for installing Xenomai 3?
> > > >
> > > > Additionally, if the installation has a relatively large footprint,
> > > > are there any recommended alternatives that offer comparable hard
> > > > real-time capabilities but with a smaller storage requirement?
> > > >
> > > > Thank you for your time and assistance.
> > > >
> > >
> > >
> > > --
> > >
> > > Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
> > >                              http://www.smile.fr
> > >                              https://smile.eu/fr/offres/embarque-iot
> > > I would love to change the world, but they won't give me the source c=
ode



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
