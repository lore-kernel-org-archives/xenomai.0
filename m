Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E331922E9
	for <xenomai@lists.linux.dev>; Wed,  9 Oct 2024 11:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474435; cv=none; b=C0RVXRseoQQ6iv0qGxQND/6Y8qS2vw/vKLEy4qgrH2Bbhdq8ppFr11xIMiwSGYiCsws3vxrXg116VYRNFRwfsk96L8UZa4yX48qh8BitamWnXYmS4qCQ80KBAkRVZfZBZhxBRX6s51aV/u6+zRQzvEkt4gqq1FowIS46KzpACCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474435; c=relaxed/simple;
	bh=Z0pYKxHhxPnEghXndAg5cEI3htIwZC5YFAdneeqlyOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=om7JTRzDlWmLVEEyNYbBupKHqYdlsszKgHv/1YSJq5R31ly5xE4WPnFxv6Q/0JOqLFN4V6sRl3QhHKdMTZWNiGt/3XqXxZpGfjGTQ80OxOSstKkOFaE/R14qHpwj8mV2fBsm6tRAozFxqqXdV0R+AsuE7GKq3L25KnpRhLQozX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=dxohCw3n; arc=none smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="dxohCw3n"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 046D480006
	for <xenomai@lists.linux.dev>; Wed,  9 Oct 2024 11:47:11 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 2F8F5941771
	for <xenomai@xenomai.org>; Wed,  9 Oct 2024 11:47:10 +0000 (UTC)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2facf00b0c7so7665101fa.1
        for <xenomai@xenomai.org>; Wed, 09 Oct 2024 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1728474429; x=1729079229; darn=xenomai.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IbUyZsAQiFwovZZO+nd/e08zN3n6XCcCECrqGQ6T78=;
        b=dxohCw3nuIiTTXCDySBEEAVMNzP1VKVy1r4nY1t9weami2co7nD2SHuHT4Pi/KOv8T
         HsBJ/znq3yQaC1Oh5PQ3xrQFMCXh96DhC5kHV49cr1MaGthIFqogXBP9WjXmTFbgZ2E1
         FnJz4yVZMrSjsLExegQ8Egp5DjSFCnGlkpnVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728474429; x=1729079229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IbUyZsAQiFwovZZO+nd/e08zN3n6XCcCECrqGQ6T78=;
        b=oU0hBRRw7v0c4Up1MFqw5FHe0/FXS4NiijeV2YW0KE9KLhKHpVi2D96cFa/a7kIXUk
         bAoFclhxpS1OeD5MWAyeNKIVQxANhVurUav82kJ1rdDICv8DJ1LOy+gUSivYae2w6/X4
         iTmGDktHOege+veTeuB/MMlEFtB7UDXIaeIT/op3df+y0LFwymzsyhZLVnBQJt2aAe5d
         nstqp4eQa9KIMYhPg6V4gHT4kvV81AfQAxpVEWBLLjty4xaE7SUn81+m1b3ulEgn4bA/
         Kr9h48w4Npa1eAo45duwexQPcXbgtj1uX89X3pH88TaHoym/iJIR3tZsCaXNDhU/E+lX
         NpnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjknqAxa2Y9TLi6GIsQaVK8jddWrKf7A3ms0UGsrGdkke2ey+yKiGZLKgM0aaN9Xqfgpz7L0Vn@xenomai.org
X-Gm-Message-State: AOJu0YwA62F7pvnkCbwFJcbOBgjqG1gq2opsvwDNrMjHw98t7i/i/T2O
	RC8Qx0kCD8isF7PaxozA5q8HpRuNIOy9+m5QZNZkzjNcyQ2hvok8vMX1KD+7MnijuCChKYmYu09
	fDtrIuT/bVYYk1DmraKIErMuk0C5febWfCnPsVQ==
X-Google-Smtp-Source: AGHT+IGK6QGWDxEm/mHGgWYYkEMU2Ac80yo0gfPu/mp9eJKJZn9kH363AGpksEcDhhaQUayQjKUSJ0UdIHcBNaD2G9s=
X-Received: by 2002:a05:651c:1987:b0:2fa:e52f:4460 with SMTP id
 38308e7fff4ca-2fb0de68da4mr19016071fa.1.1728474429268; Wed, 09 Oct 2024
 04:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0vYfF_aj5a0zz7GwpjZATgB9td4Usc6JivATCe6tmoSLQ@mail.gmail.com>
 <87set6lajm.fsf@xenomai.org> <CAFc1U0uaqt8Kqd3+nFijfukFousvWHmM3KQtRqYGRkezDgkQdg@mail.gmail.com>
 <815623d2-2222-4eb7-8c64-2f5f9aaf48fb@siemens.com> <87ttdlcxnq.fsf@xenomai.org>
In-Reply-To: <87ttdlcxnq.fsf@xenomai.org>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Wed, 9 Oct 2024 13:46:58 +0200
Message-ID: <CAFc1U0vbhHG_NQYve5htfr3PAGd_PLW2Vv=xSKO3GSHncJ=Feg@mail.gmail.com>
Subject: Re: POSIX API for EVL
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=reject) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::233 as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

I have a contract with a (big) customer to study several flavours of
Linux RT   for their future projects.

As it's for the future, I'm quite sure v4 should be better...as they
want to fire VxWorks !

A+



Le mer. 9 oct. 2024 =C3=A0 13:40, Philippe Gerum <rpm@xenomai.org> a =C3=A9=
crit :
>
> Jan Kiszka <jan.kiszka@siemens.com> writes:
>
> > On 09.10.24 09:53, Pierre FICHEUX wrote:
> >> Hi Philippe,
> >>
> >> Yes, I do remember.
> >>
> >> https://source.denx.de/Xenomai/xenomai/-/wikis/Common_Xenomai_Platform
> >>
> >> The lack of interest is a bit strange as the industry is mostly based =
on POSIX.
> >>
> >
> > I would say the challenge of moving forward is right now that users
> > already on Xenomai 3 are happy enough to stay so far, plus some have th=
e
> > blocker of missing POSIX with EVL. So, there is now an upfront invest
> > needed to enable POSIX over EVL in order to evaluate if the own
> > application works even better there. This is at least the case for our
> > internal users.
> >
>
> I agree, this makes sense. This said, I may emphasize a couple of major
> differences between x3 and x4:
>
> - SMP scalability. Because of its outdated serialization scheme, x3
>   performs properly (latency-wise) on up to 4-6? cores max. running
>   real-time threads concurrently. x4 does not have the big-lock
>   scalability issue x3 has, so virtually any number of cores can be used
>   for concurrent real-time activity. Granted, not every rt app needs a
>   truckload of CPUs to run concurrently, however the fine-grained
>   locking scheme x4 implements like the rest of the kernel does also
>   greatly improves concurrency within any given real-time CPU
>   (typically, this shows when running the context switcher stress test
>   alongside a latency-sensitive application on mid-range or low-end hw).
>
> - Complexity, maintenance burden. Only looking at the Cobalt vs EVL core
>   code footprints, including the netstack but no drivers, excluding user
>   APIS, we currently have:
>
> {rpm@pyro} cloc kernel/evl include/uapi/evl include/evl
>      147 text files.
>      139 unique files.
>        8 files ignored.
>
> github.com/AlDanial/cloc v 2.02  T=3D0.11 s (1268.6 files/s, 281809.5 lin=
es/s)
> -------------------------------------------------------------------------=
------
> Language                     files          blank        comment         =
  code
> -------------------------------------------------------------------------=
------
> C                               48           3955           4078         =
 16404
> C/C++ Header                    83           1260            932         =
  4190
> ...
> -------------------------------------------------------------------------=
------
>
> VS
>
> {rpm@pyro} cloc kernel/cobalt include/cobalt/kernel kernel/drivers/net/st=
ack
>      355 text files.
>      329 unique files.
>       26 files ignored.
>
> github.com/AlDanial/cloc v 2.02  T=3D0.22 s (1479.4 files/s, 341314.9 lin=
es/s)
> -------------------------------------------------------------------------=
------
> Language                     files          blank        comment         =
  code
> -------------------------------------------------------------------------=
------
> C                              109           8781          11091         =
 33066
> C/C++ Header                   198           3762           6128         =
 12771
> ...
> -------------------------------------------------------------------------=
------
>
> - Integration. EVL reuses the standard VFS abstraction to implement the
>   everything-is-a-file scheme for accessing its features/elements, which
>   x3 cannot. As a result, a real-time capable driver is a regular Linux
>   character driver in essence, plus there is no redundant rt-specific
>   file descriptor namespace. IOW, the regular Linux file resource
>   management applies to any element created by the EVL core (reference
>   tracking, release, dups and so on).
>
> - EVL is Dovetail-native. For instance, valgrind support is readily
>   there and for-free, because the core relies on the prctl() redirection
>   to receive real-time syscalls, which x3 won't be able to use until its
>   way of marshalling syscall args is entirely reworked. The real-time
>   network stack can provide UDP and raw ethernet socket support by
>   sharing few but important portions of the regular network stack when
>   running out-of-band, which explains why the x4 netstack exhibits
>   roughly a third of the x3 footprints.
>
> So indeed, x4 may not be a requirement to some/many, but still, there
> are some advantages there.
>
> > But my plan remains to enhance portability from Xenomai 3 to 4 so that
> > more comparisons are possible, and we may eventually even consolidate
> > over a single code base again.
> >
>
> Ok, I'd be there to help if/when this happens.
>
> --
> Philippe.



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
