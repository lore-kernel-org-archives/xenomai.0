Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7366E15AACD
	for <xenomai@lists.linux.dev>; Fri, 31 May 2024 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163614; cv=none; b=AmEhqjsFR4Sc5ONJ8qLGDdXNNlRDFknkMrJRCLjMhUwivoDuCD0Ttp4T8bAGI1ftnSL27JXeLf8yZT/JEUU2828arzYbjDmRLlnDtj4YuJY4gmo6iYEcsFAdBmt3GyOEAaaqAMuywAIlev4w46QmzqrhsE97aBcBbTsBVDeCnWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163614; c=relaxed/simple;
	bh=yUW+JUb6+xM2c6r/JhYs8ONE9MHjh6uSfDZ6yWQB6ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNPC+H2x8CU+ZIt7QtORVAYDTnidQh29joHa5+lQT4MzHiJOfCYPIZuj75tucUlB0VPuDiIrjfgYxM/Px+0blpZk7nKBeKodKeYXxxnHdhSlmlEdXN2y0mZ5ObjYye4biBP5oCMl6nRVfdHeiPJ/WtGxIdCfOldoSVSBgA/xSIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jA0ju8Ss; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA0ju8Ss"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-794c3ae6db2so129214685a.0
        for <xenomai@lists.linux.dev>; Fri, 31 May 2024 06:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717163610; x=1717768410; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tTzYrf9NPCj9DJ9CIZMeof7PJwO6zDgIom1GpDh0zKE=;
        b=jA0ju8Ss01NGU3Prt1C6PeY6W0O6FYPcSW6hiADgs74daumGy3pq2MhuYqQZQBP/ZD
         ig5QbnW9q9+1D3l2afDpja7ZkcoGSXVIq9n+Hu+vy6USpU0bHLAd9InHz/Z2rqyeZ3sx
         7l7N7xls9NpuIxL5EjdnSu6Xp5uNAHf4L6mWx7IdmAInA0XgHoHRsQ7DrnLvS5S39L8M
         30QZFNXFWe2T9929zSk3p3uqInE/iOImHGgPR2ZoDSeXtMXfA8iPbziYkJZScy+Fasqe
         6o/eQw30PjgOf8wwJg3d57L6+Pec7EiN4s9tLRgc0lqyrsTA9uAWyAlk8Wl2h0emIk6t
         4vZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717163610; x=1717768410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTzYrf9NPCj9DJ9CIZMeof7PJwO6zDgIom1GpDh0zKE=;
        b=C17/oaYofwLMIVbIA9hF5lTH5IMNdd10ea7ZU2+KSwg1CR6NmwZsRTawZrDmHMYKmw
         6YHe3V832yrgPQ/VLjgfhc9ZQQcRwzXqRe+CGXIM0l6X+L2y0b3ciI7uSBCAeqPZli6X
         H1cz0+IxZ2Jl99v7IyhnBmhVwx7CfYcp7SrdRfFfESatKLu8bdXe01lm4CiYmKaoWJip
         Poa3lQ1lo2v6oaAzoPy089xu102yh88dRzzqAvkPA8QwK6/nrgv0GSZ12cAo02txhPym
         JvIH6+Qq0rhI8FvR9A/zcUJe2eVXLMVCwL9QDEx/hxAv6LnoxX76uPD1c/ij3JMH7HjH
         m/Og==
X-Forwarded-Encrypted: i=1; AJvYcCUNnWWDKcm90TNQypnnr6sUOMVLYEbQ96HMW9jIkBIUYDMksHMm0pwMBKGIdaFJfS/iTr570gciwzh2z4SpZDFPV5Q6fC53ww==
X-Gm-Message-State: AOJu0YxfHNbSFZH8ysKw0rsQwCDq/PwrKtBZRny7XscIY/fGNHLbaTl4
	3k8bAJKI+ZhBCbjeL2SD9lqH+HQ9kYzp8iuplrAhpUTXH6iWyOBRbqNcdKg48OZ8gdBDMYQovFU
	McJGoUtaLY3aUafW4qhCKjZihTNc=
X-Google-Smtp-Source: AGHT+IFNr1qDGycTGPR0RwvehatkgngPoXnPCbdssBmFH0k8y6pRE3QL9z/4gmm/RW6PaP/k2Ji9HOLGJH8AMTddZNU=
X-Received: by 2002:a05:620a:3726:b0:794:f1d8:2798 with SMTP id
 af79cd13be357-794f5c881ffmr244811885a.43.1717163610065; Fri, 31 May 2024
 06:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADYdroMJCeW_UNvc6K1p_2dc2-hCDWyATXcDq6iHL5pVSrFknA@mail.gmail.com>
 <207f29ba1fe51a1656c5f72cb719ba0fab5b2e6d.camel@siemens.com> <5f546c94-440f-4641-9549-f6c27652caf7@siemens.com>
In-Reply-To: <5f546c94-440f-4641-9549-f6c27652caf7@siemens.com>
From: Norbert Lange <nolange79@gmail.com>
Date: Fri, 31 May 2024 15:53:18 +0200
Message-ID: <CADYdroPpqtYYwvAgmpH=E4a3u0-C4chaBqwioe658kN8Tx5BFQ@mail.gmail.com>
Subject: Re: Dowload URL for ipipe patches?
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Am Fr., 31. Mai 2024 um 15:00 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>
> On 31.05.24 09:11, Florian Bezdeka wrote:
> > Hi Norbert,
> >
> > On Thu, 2024-05-23 at 09:32 +0200, Norbert Lange wrote:
> >> Hello,
> >>
> >> the older URL's dont work, and I did not find any reference to the
> >> replacement, even rather recent releases have non-working URLs [0].
> >> So the links dont work, and the gitlab repository doesnt offer them
> >> either, eg  [1].
> >>
> >> Whats the plan going forward?
> >
> > the main point is: I-Pipe is "dead" / in maintenance only mode. The
> > last supported Linux version was 5.4. We have dovetail for modern
> > kernels, so the way forward is "use dovetail".
> >
> > That said, we have a downloads archive [2] here. That might help to
> > some degree, "newer" I-Pipe versions are available through the
> > architecture specific ipipe git repositories, so no "ready for
> > download" patches anymore (as far as I know). For x86 it's [3].
> >
>
> Right, we are no longer having infrastructure in place to format those
> individual patches and push them somewhere on a static page. None of
> that is technically impossible, but given the current demand for
> restoring this (you are the first to ask for it, TBH), we were not very
> motivated to do the required work (likely more than some hour on a rainy
> Friday afternoon).

My  main point being that *all the docs* still refer to the old URL,
and the method
of using an upstream-kernel + i-pipe patch.
I don't have a problem using git repos but I would like to use the
correct infrastructure.

As far being the first to ask, first we have all we need stored
locally, so we can still
build our past versions. 5.4 LTS should have still a year+ of support ahead.
Changing to dovetail is not really an option without RT-capable
network drivers, and would
be anything but a simple change. Is there even a plan how to support
for ex. reading PTP Clocks
from realtime?

FWIW, given how thin the RT-driver support is with Dovetail I dont get
the point of using a hard RT
OS without getting your IO in hard RT. I get that someone has to do
the work, I get that the old ipipe was hard to maintain,
but this replaced a much more "complete" framework.

regards, Norbert
