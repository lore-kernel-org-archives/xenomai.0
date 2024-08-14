Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C8244C93
	for <xenomai@lists.linux.dev>; Wed, 14 Aug 2024 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723666523; cv=none; b=oVtXvnN2AjCdS8eyUMwpqpXYZoUdJ/s3byZroOfpa0OrlQx8MU3CcpDcamPP+vdkTzNc6mDIdbJpXR6E1KlcMRvCBk6P8TLhfltIfky/B+wUZC2mwbb5bQ+aYjgcNIxpjRMYxIETTzwr8MoUs9zZ82f8RuBjHD9Al5nC3UZyp4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723666523; c=relaxed/simple;
	bh=Vf2VNNje9NZ9fdkP/hKHduclAd3fvN1D9NxZNdXurwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmD1/AH8HNfWcaL46/GFC1gudeymv5WSHm9ftGIrB05BZHBoPnJp/vjT24ByV8ZIQnWpGK66GXSTHUjNnmZaczy+7qP4cfUY+GJXrfe8sdmcQjNth1HzjJYFCYKRtwWyj7mp6+4epaNSZ46n3olHWjvNnb9nqRILF0Cl/rRNbog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpQfU5h+; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpQfU5h+"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa7bso438369a12.1
        for <xenomai@lists.linux.dev>; Wed, 14 Aug 2024 13:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723666520; x=1724271320; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnGt3OTivKgBzgQDAeOs3YcuiBsXLcL+0p0xcAInEC0=;
        b=QpQfU5h+j0mNuewaTUoqhjx6aXECkgb0TweK3xpIPpQG+KRTGKZvvYzzPDW6RAxnb/
         KxY6UMvxrHFAyPzPCM1i7NLEuGQlqRspsOFyoV/RKE9dBtClDmIiOkej9m6RG58isdtg
         jGvdICcmWjvrCASC/PQ7c53WS83feM4ifgDaJdlVkjFYz9eDbp4KSa78zQPW01LLiwa4
         p0/eW5J3dLHYdBZ/ZZm6BSXcG13OTRZvi/KL5jrML+48epMGUWEFKpo7OCwZ4ZOVg7kN
         D5zkAY+ebz8LKiiS3EdGBQ/sreAsLr6V4fqvdTPz14DbZsRWqnKfYpJO5txDSbaNbJVM
         aTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723666520; x=1724271320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnGt3OTivKgBzgQDAeOs3YcuiBsXLcL+0p0xcAInEC0=;
        b=dKh45e0SQQlOU0rVODYqXoGgmlADmNTzeWyvc0F3q2SMuUJPYWLAYOwEBpO5Qi4eRx
         TZpoI52uA9djiut+Gw86DbNM4OyWCWtw8/Oe0fUGG8/YnfP60+a2utb/VKdlSXp2nuUF
         diDqWqi5t71VOikCS294IxYWw5TLM9wnCxZXUtjS+9Gkh+dhd/81W9TxY3O4ZjzxU1FH
         K1zoahP7r0knspBXsu7QHmr4c+OXlAhJJYmE1eourEZHwbITtMKjAf0Dhl/5clfQQzc6
         lVZyj8yCYokCM93Uoh3/Mtix73RTYv6nv++UAXjNzbAlLXU4/d5SZ0VSfmikpRe6h5Zv
         DO8w==
X-Forwarded-Encrypted: i=1; AJvYcCV5fNmcMisnWsA8cKZXtlIdYtFtFL39rvSAJsi+b7GJrgvRLeeLu0Elxge9VSSjAPw1LQC5L6mLDjM2XWZMBJ3Z3gYeeKX+vg==
X-Gm-Message-State: AOJu0Yy48n1JRxZcrVSSfmQgVefO8G0JMEaNNfzASTbv/78MAli8kBfy
	RhSUVA+5C2ZOtRXqH9WKN3jgzO8Tj/XHPbzu16dLrrq4YqaWvOdrN+dFeak97VglUYCph7CZX7M
	dhI7G5UM7dr6+1uE8rR34wk/55LWduh9S
X-Google-Smtp-Source: AGHT+IFFeyy996RT+nG8e0ak6D4yeaYXpFsX07HXR7hwwzrkPGlG3v/0Sr63ARoFyg7QpBzjUYwqHM9t8jZ4qhCdpnE=
X-Received: by 2002:a17:907:e268:b0:a80:f7d5:addd with SMTP id
 a640c23a62f3a-a8366bfc2d1mr287566066b.13.1723666519384; Wed, 14 Aug 2024
 13:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADYdroMJCeW_UNvc6K1p_2dc2-hCDWyATXcDq6iHL5pVSrFknA@mail.gmail.com>
 <207f29ba1fe51a1656c5f72cb719ba0fab5b2e6d.camel@siemens.com>
 <5f546c94-440f-4641-9549-f6c27652caf7@siemens.com> <CADYdroPpqtYYwvAgmpH=E4a3u0-C4chaBqwioe658kN8Tx5BFQ@mail.gmail.com>
 <b54d8394-da9d-40a9-9320-3bab5ced2da0@siemens.com>
In-Reply-To: <b54d8394-da9d-40a9-9320-3bab5ced2da0@siemens.com>
From: Steve Rosenbluth <stever8@gmail.com>
Date: Wed, 14 Aug 2024 13:15:08 -0700
Message-ID: <CAExw09CJA3ydfAti47czAi4QM7xvtqPQzrvR48JVhWcVGUEj5w@mail.gmail.com>
Subject: Re: Dowload URL for ipipe patches?
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Norbert Lange <nolange79@gmail.com>, Florian Bezdeka <florian.bezdeka@siemens.com>, 
	xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 7:04=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> On 31.05.24 15:53, Norbert Lange wrote:
> > Am Fr., 31. Mai 2024 um 15:00 Uhr schrieb Jan Kiszka <jan.kiszka@siemen=
s.com>:
> >>
> >> On 31.05.24 09:11, Florian Bezdeka wrote:
> >>> Hi Norbert,
> >>>
> >>> On Thu, 2024-05-23 at 09:32 +0200, Norbert Lange wrote:
> >>>> Hello,
> >>>>
> >>>> the older URL's dont work, and I did not find any reference to the
> >>>> replacement, even rather recent releases have non-working URLs [0].
> >>>> So the links dont work, and the gitlab repository doesnt offer them
> >>>> either, eg  [1].
> >>>>
> >>>> Whats the plan going forward?
> >>>
> >>> the main point is: I-Pipe is "dead" / in maintenance only mode. The
> >>> last supported Linux version was 5.4. We have dovetail for modern
> >>> kernels, so the way forward is "use dovetail".
> >>>
> >>> That said, we have a downloads archive [2] here. That might help to
> >>> some degree, "newer" I-Pipe versions are available through the
> >>> architecture specific ipipe git repositories, so no "ready for
> >>> download" patches anymore (as far as I know). For x86 it's [3].
> >>>
> >>
> >> Right, we are no longer having infrastructure in place to format those
> >> individual patches and push them somewhere on a static page. None of
> >> that is technically impossible, but given the current demand for
> >> restoring this (you are the first to ask for it, TBH), we were not ver=
y
> >> motivated to do the required work (likely more than some hour on a rai=
ny
> >> Friday afternoon).
> >
> > My  main point being that *all the docs* still refer to the old URL,
> > and the method
> > of using an upstream-kernel + i-pipe patch.
> > I don't have a problem using git repos but I would like to use the
> > correct infrastructure.
>
> We may need a friendly janitor to update the docs in this regard...
>
> >
> > As far being the first to ask, first we have all we need stored
> > locally, so we can still
> > build our past versions. 5.4 LTS should have still a year+ of support a=
head.
> > Changing to dovetail is not really an option without RT-capable
> > network drivers, and would
> > be anything but a simple change. Is there even a plan how to support
> > for ex. reading PTP Clocks
> > from realtime?
> >
> > FWIW, given how thin the RT-driver support is with Dovetail I dont get
> > the point of using a hard RT
> > OS without getting your IO in hard RT. I get that someone has to do
> > the work, I get that the old ipipe was hard to maintain,
> > but this replaced a much more "complete" framework.
>
> First, I-pipe support is not completely dead yet, 3.2.x still has it,
> and we are updating 4.19 and 5.4 in principle (needs a kick, though).
> Second, dovetail does not imply moving to Xenomai 4 / EVL. You can
> continue to use Xenomai 3 with the driver supported there.
>
> PTP clock access is an interesting topic, though. You get it "for free"
> if you sync the system clock against one PTP clock with all dovetail
> kernels. Precision should not be affected by the fact that Linux
> organizes the sync. However, there are no plans to provide other kind of
> accesses so far, specifically if there are multiples clock or if there
> is no synchronization to the host.
>
> Jan

We definitely support xeno3.2 ipipe patches being published on the
web, though I understand Xenomai's roadmap.
Most industrial "long term" programs are 10 years, it seems a shame to
take down small static files from FTP after just a few years. Such a
file requires little storage space.

I found this latest patch
ipipe-core-5.4.253-x86-14.patch
at https://ftp.denx.de/pub/xenomai/ipipe/v5.x/x86/
But I only found up to the 5.4.239 patch at
https://source.denx.de/Xenomai/download-archive/-/tree/main/ipipe/v5.x/x86

I am currently building the ipipe patch for kernel 5.4.281 from a
clone of the ipipe-x86 git repo. Thank you for that!

-Steve
