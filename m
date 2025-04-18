Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBDE171D2
	for <xenomai@lists.linux.dev>; Fri, 18 Apr 2025 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744962984; cv=none; b=D4F5XtfyF1uCz6ReyIAstjGpr116Wk8RfQn8RpeB11/tnmlkZNFP89jGZJ8NWiQwzejy2fyxP+K/M7tf8uuTTHmZWue74Ahgl0fOSdEI0YyGiiLDhH5CfOzX53rf6Nryxhi3abR+UWwymIo2uDyFoP0t4k+5KflTyCni78KTFdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744962984; c=relaxed/simple;
	bh=1QbhQ+i0VaBBaFeLFXeUqwxPa1VtK3G+gpKPAXbmLJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qahDN2r7ckzbgh6Sg3wld5LVQHfTr2KmBTJ81xv/+TIOy7IPQyF+U9+56Vl6iIf7jbZkqzIv44eaFsXVjnPSULpIl+oh5SxBY/3+raCV0THIw+yUjQb84obsKCTnTEqkDeIeNYoFFM1+CwSm5pJtWTkbSQ0qXa2C38JYHP4dQSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=df2XxlAF; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="df2XxlAF"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30effbfaf61so18826961fa.0
        for <xenomai@lists.linux.dev>; Fri, 18 Apr 2025 00:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1744962979; x=1745567779; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVgeW+jzTgcbjw2/Owe8UVLKjsCow2SRXCId4DOM3pI=;
        b=df2XxlAFLLVhdZkiM8VK6cLOf/n+etqMEQP3jUm/WnXTfVXeU70lfvGhZEmBYGZWpW
         8fk+ALEbxxYEZeD0NLjTN7UQEqDDmMc9l1Y1ATOn8KfP37cqdyUxoBDviO1gHbz7rpsh
         WGY7poUieafBL8/nnI+mbvv2/Dc40gtZxFnxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744962979; x=1745567779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVgeW+jzTgcbjw2/Owe8UVLKjsCow2SRXCId4DOM3pI=;
        b=s/zXaSSik/Iu4vvCduIFnhqoJw8QFmQks2x7SrAFPuw0CCgAgX2Bv+nSz+1HRMA/RA
         njU1vyhTk9hM1lY8biFywe36pwU/uKLWHPeFfl1wvh4TFjU5k1NMpVISMYdkP6MsVHQY
         HkH/xsoc9FqES5C+jF3b+Dd1ioyUDqjfZvL4PW5YQ/g5z2EcEzLn4UnGmTxxNNUk9cE5
         G26WH29hzLJghL9u3pxbFYT+fchJiOIsodRU+jTb6S9O36NaWWhXGMwIrGxSH3u0M6ST
         E7FBB7qAlhAJRe57qYieyqgvBqqIBv1REXwcggUvvEQ2IEkIqfSZgfQk5U2yKwWKTOJO
         UBXA==
X-Forwarded-Encrypted: i=1; AJvYcCVLEER/UqOXnfFHUi6VRSirWXsB/y+Uple8n2lBbjXDztPCFiHyKRJEtvExZPhcgF45Klds0X+M@lists.linux.dev
X-Gm-Message-State: AOJu0Yzj033qIBn0s3+lgxqCU8HxgZ6LdsGI6+7kbeur0UdKlNV4wCbI
	3Y/sbsDlTX5k0h8Nde3eeQIRNhEyUvO12gjfZ6wx9j2nkDlHGHRfR/T/2EjmrE1GwG0G2bu28Ei
	/CqMZjYBaAxF2XIrumMg2rsr5Owzd4suqOho+ug==
X-Gm-Gg: ASbGncs53qQRAFqfs7HqKP26Kx1s4U7Ff3KOTqXEwpnE+ui48ZLg5nXtxADQ9JOdYad
	mL0uL8Tz9op5EJ1xxId/O6LEOwzH0irD26OlqgYNLIhztKxE1JLkW/KqZ/Cz+zpbFN+Pc71fBEB
	I01amr1GMGmFKG/7nZW0KvgeGKp1BRtQKHbaulS49TYd+KSa/KBLc0
X-Google-Smtp-Source: AGHT+IFYrqDC3dg6jw3u0xuYyN8Pq13WeeO62J9wXfITDjSrmXGgUM5aL9GAfxDdv3/PRt2giu/5idWSoTho6Vj00OA=
X-Received: by 2002:a2e:a54a:0:b0:30b:f2d7:1e7c with SMTP id
 38308e7fff4ca-31090df4571mr4698171fa.5.1744962979079; Fri, 18 Apr 2025
 00:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADjXCUdi2vswJNN8n2BWtPgtXu_ZXDrAD5qTcNNh=ovBmw=-yg@mail.gmail.com>
 <8bc51145-3e99-4b78-87d2-7859f9c35a4b@siemens.com> <CAFc1U0s64TakhZUG=ym-oANAnkNsj-L=L2T3pYAtzgEwROtHkg@mail.gmail.com>
In-Reply-To: <CAFc1U0s64TakhZUG=ym-oANAnkNsj-L=L2T3pYAtzgEwROtHkg@mail.gmail.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 18 Apr 2025 09:56:07 +0200
X-Gm-Features: ATxdqUEETGUzXZtMiXYI-gVR6WnE_pO4hWKfWZhN-6_ydR2xuGq30UfF5JoADsQ
Message-ID: <CAFc1U0s_6A0JKMQ+kWL+hCKGG5GcfS9C721u83Kc_qbxbTXMuw@mail.gmail.com>
Subject: Re: [EVL_XENOMAI-4] Consistent Latency Spike at 4s on Isolated CPU
 with EVL (Raspberry Pi 4)
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Zoran KRIVOKUCA <zoran.krivokuca@smile.fr>, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi again,

To be honest, I don't really  understand the answer.
On xenomai 3 we create a thread in the Xenomai domain and we must not
use Linux syscalls in order to avoid "migrations".
Is that so different on Xenomai 4 / EVL ?

regards

Le ven. 18 avr. 2025 =C3=A0 08:30, Pierre FICHEUX <pierre.ficheux@smile.fr>=
 a =C3=A9crit :
>
> Hi,
>
> Thx for your answer.
>
> Do you know if there is a "migration guide from v3 to v4" as there is
> such a document for v2 to v3 ?
>
> https://doc.xenomai.org/v3/pdf/MIGRATION.pdf
>
> regards
>
> Le mer. 16 avr. 2025 =C3=A0 15:33, Jan Kiszka <jan.kiszka@siemens.com> a =
=C3=A9crit :
> >
> > On 16.04.25 14:38, Zoran KRIVOKUCA wrote:
> > > Hello,
> > >
> > > I=E2=80=99m working on a real-time application using EVL (Xenomai 4) =
on a
> > > Raspberry Pi 4. My application consists of a single EVL thread that
> > > toggles a GPIO pin periodically using an EVL timer (evl_new_timer) an=
d
> > > logs jitter values. I'm using mmap() for direct GPIO access and
> > > evl_read_clock() to measure timing.
> > >
> > > The thread is configured with SCHED_FIFO at priority 99, locked in
> > > memory via mlockall(), and pinned to CPU 3 using sched_setaffinity().
> > >
> > > Overall, the jitter is low and consistent, which is great. However,
> > > I=E2=80=99m observing a recurring and reproducible latency spike exac=
tly
> > > around 4 seconds after starting the test. This spike only happens onc=
e
> > > and does not repeat afterward. Once past that point, jitter returns t=
o
> > > normal and remains stable.
> > >
> > > Could this be related to a misuse or oversight in my application, or
> > > perhaps some in-band task that is scheduled to run at that moment
> > > despite CPU isolation?
> > >
> >
> > 4 seconds... you have been kicked out of RT by the EVL watchdog. And
> > that means you are trying to create a 100%-RT task which will starve th=
e
> > Linux on your system to death. Will not work this way. Schedule your
> > work based on time or external events and make sure it completes
> > eventually. 4 s is already way longer than what a task should take.
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
