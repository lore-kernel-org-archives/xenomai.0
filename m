Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1C51862B5
	for <xenomai@lists.linux.dev>; Wed,  9 Oct 2024 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460437; cv=none; b=VOBN30/vhH+Feq5DTqyv3YEMB/kQQsGV8fUxnWPV3YjqnRvPqG0czm2kKdaVzsRbm7EN6f3XQ3A+RlY242O+YQn742QdQp19Z/oFb8MkYVLSngqQiTVNe+nwHKkMMScwwfoffk/zfiivWitEfd4fry3/KmtxKQyCxwYyVopjHOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460437; c=relaxed/simple;
	bh=9qGtQQgFN5AZxmPQtDFI+MVghL2PTzAKEKUFdyFIV6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icnTF/Z3U/68yw3PLQCY44nRhnlSvH0tVj6We4CItAzVMa6PCRayxP0N9gq6Q3YzekLbGhq8g+A2SkhWuBlXMmOuFG+4QGxaULXagUQZF9FNU+2LqKgzBdQFcwpVZIMwJoE718TqHsziQCMwmvO0GGu8u60N3t+WbVWD37Maz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=HB9c6MRo; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="HB9c6MRo"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 553FA100009
	for <xenomai@lists.linux.dev>; Wed,  9 Oct 2024 07:53:47 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 7AF657803E0
	for <xenomai@xenomai.org>; Wed,  9 Oct 2024 07:53:46 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2fac63abf63so63799841fa.1
        for <xenomai@xenomai.org>; Wed, 09 Oct 2024 00:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1728460426; x=1729065226; darn=xenomai.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TzHd+QakTtvdlOPMcur7NY3gitpN6HXxlCV7H8NuIo=;
        b=HB9c6MRokC1kAXS+7gLN9yDwEiwa7D3tpbHz91WJJhPsHtUNK8SygSMJYootlDaBjr
         Dw7hN7ciieD7nqudIY+c+LrpEUpV8TUUarnfLQAgOt4J8dkkvV1y2DwFCYnVJlFytLts
         gjv2CzEmp0B0U2i2A3tQ94orS0gr5j4h3g67o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728460426; x=1729065226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TzHd+QakTtvdlOPMcur7NY3gitpN6HXxlCV7H8NuIo=;
        b=wk2bM4c2cQHh9NxmKpGbO5oMqFD9eMALl1enZVYszwXcHgi73Jr5lBVJbvfQHniTEW
         k7fBp361VijjkmtRhCM0QIQ3f8siSB2QRTG4mF//27Ij8p5pM86w6JEvqc0WWvvieOTG
         2KaJ0nT1tjaKWRaJqiCL3jt01BnRphAd0QI0mFNIQ57503gEMQZgdwmeFmU23lKbWLS7
         8vUuxupaqD+KPJPNzm+1MQBcT/d1m9j/ZzBedaW7M7DaPIiNue1aDaC5FZGi/xV8G6Kd
         zt1/eONx7QOi8dpZx2HwUjVm/9S6zdnczzpHrSsOmvKQZFqb7vZg/4zrWDaV5SNzapGC
         /fzg==
X-Gm-Message-State: AOJu0YxEpPkpVFm7LWfkfZMQTCin2d17RkzT7rFziYkhYm07SdkIgw2K
	bMZJjHuUqVLzbLLabIxDqKgc5bCWVabyTJlxlqxYRAGxtjrvGYv98ETamI6p4sLvDut6a7MIeTo
	t8Is617FBVjHBDjX5zz716VLBxeMROIhwaFlLhnrGTO9LCQWXNro=
X-Google-Smtp-Source: AGHT+IEbsw9ixZeISi3u/tHHw7x/nRfAMwwxwzUtYGezvHWO8M3/pqTN8JmU5epwyGb9ohFyUsIVldzjsH6BYe40SdI=
X-Received: by 2002:a05:651c:2227:b0:2fa:cc50:e6c3 with SMTP id
 38308e7fff4ca-2fb1872b586mr8113031fa.10.1728460425367; Wed, 09 Oct 2024
 00:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0vYfF_aj5a0zz7GwpjZATgB9td4Usc6JivATCe6tmoSLQ@mail.gmail.com>
 <87set6lajm.fsf@xenomai.org>
In-Reply-To: <87set6lajm.fsf@xenomai.org>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Wed, 9 Oct 2024 09:53:34 +0200
Message-ID: <CAFc1U0uaqt8Kqd3+nFijfukFousvWHmM3KQtRqYGRkezDgkQdg@mail.gmail.com>
Subject: Re: POSIX API for EVL
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=reject) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::22c as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

Hi Philippe,

Yes, I do remember.

https://source.denx.de/Xenomai/xenomai/-/wikis/Common_Xenomai_Platform

The lack of interest is a bit strange as the industry is mostly based on PO=
SIX.

regards


Le mar. 8 oct. 2024 =C3=A0 20:22, Philippe Gerum <rpm@xenomai.org> a =C3=A9=
crit :
>
> Pierre FICHEUX <pierre.ficheux@smile.fr> writes:
>
> > Hi all,
> >
> > I've read some discussions (may 2024) about the lack of POSIX skin in
> > EVL.  Supporting several skins just like for Xenomai 3 is not
> > really useful but POSIX is an industrial standard and so for people
> > willing to use Xenomai instead of PREEMPT_RT.
> >
> > In the EVL documentation
> > (https://evlproject.org/core/user-api/thread/) I can read :
> >
> > The main kernel=E2=80=99s thread is the basic execution unit in EVL.
> > The most common kind of EVL threads is a regular POSIX thread started
> > by pthread_create(3) which has attached itself to the EVL core by a
> > call to evl_attach_self().
> >
> > Don't you think a kind of POSIX "wrapper" could be useful or is that a
> > silly question ? Did I miss anything ?
> >
> > I'm about to start a study for a big industrial company and the lack
> > of POSIX support is a real issue.
> >
>
> Years ago, there has been a proposal for a Common Xenomai Platform
> effort (aka CXP). Its purpose was to establish bridges between the
> xenomai3 and xenomai4 systems, user space (e.g. POSIX interface for evl)
> and kernel space (e.g. RTDM emulation over the evl kernel API)
> included. AFAIR, this proposal did not get any traction, no user
> feedback showing interest on this list, so it had to be ditched as a
> consequence. The only way to revive this effort is contributing detailed
> ideas, a plan and some code.
>
> --
> Philippe.



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
