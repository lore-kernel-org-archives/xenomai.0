Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0802A128819
	for <xenomai@lists.linux.dev>; Fri, 23 May 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011082; cv=none; b=ov2M/Xaonii9ZdR1eTHHMG4rtOrAsbYGT4MA12IAW75QTp8R6dcoKDNNixL6yni27oLI0TX7hcp5sF32yEqJ99b6Wh3FN+EVuG3QyW/aAJYyBYEgTCgEJxC91A9+D+7UD1uvUp/cxZvaz6zBQ7HfClDE4ShdxCLfaxwA/S3KMWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011082; c=relaxed/simple;
	bh=JX5CyAksKkuuXj2kp9qMJ3xVPF5tAZY5cKnSe+LNIek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfgTged1wqNZeX3A0XujIbCmq/U8f6lt1GMAEQ1N22NJmeUfUQeIatwmPvOyj++byP/tEwGZS/rIwPQxOopQJhdYxknFmM6HIHW/k/KuT+eJ6z1SxR5OM0JB+ao8B/56VELVfXYb8afYB8UYdcgJRAqBXuQZ9KOUU6W1qhalHPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rxr0lGQR; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rxr0lGQR"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e7d6cbd3a82so1830709276.3
        for <xenomai@lists.linux.dev>; Fri, 23 May 2025 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748011079; x=1748615879; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOqfsSRPtjyp0UzIABmuQoHl1cEVt6b54L/ZERA6WKo=;
        b=Rxr0lGQRLWzJFP5ck8pzpY1iiNJpnd4EwMNjPm8K8OAT6zLmscCoHTs4CAlGBRV5zE
         UW324OqHiHOf6hI2PNNuoOA1KEuyxiJEKQsoM+hfP1VXb25CwGsljKmJMMPP7oFsI2Sk
         GRDjzTSzps3tJ4mkNbm3vW/M7jABL5YGoSsVQJ8ntamHns261YpwMJSFXSfd8LvQEu+D
         YoIi2X64DFSZ5MvhOfEQQqFj5e6sZwb7ZPSPJmbZmolmYTXIjWUXR38mNuqRJrwLs1fV
         hbElEc2tivW6PUQpZ2jtZIVNzSnQ5C8JzTJO0yhJrnROEyHrD3IPdpppmSdaLqP4AzrO
         iEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748011079; x=1748615879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOqfsSRPtjyp0UzIABmuQoHl1cEVt6b54L/ZERA6WKo=;
        b=fkhzhrZl+WvK4lU4Ay1pzuPJ3hTi/+8vrvEuPIgiDzYpcMkj9xUnlBu8I1JU18dNIY
         0o4x4coFc+WvLO1onwdHZ9MA+Fr3LZ0hPG9YPuAbT+ql35O2Q/1vJvPT4xsJ90Qobp0B
         MJd8KMYdBcHvxUOskh8biuInhNhaZfoUT39j7DB9kHqYkvAUjAAlNo4oMXoWLuWWVoVX
         aTdZftvQsb9Usfd89EyKLD3qj8m27SkFxDzMNNsViKcw+byahwCdoP4YolVMWRPJ8JBk
         4j77mNAhplxvcYOi2iXt32ciw0et15kD0joSm9NE6zq+TUQYHojs821TYmfiRJ0rYC/u
         LFlg==
X-Gm-Message-State: AOJu0Yway1MesPCdSJB9HS1fgEvlHjRxQ+SfvW5zv7H67s/hgR2XlXLg
	UBVKB6WsvwEKVY3KFbfJb6CSpSr8ouRFsJuqhaNU+CdrdqHLcdpr6QO/d5BoIz5Uk5h/QbkIrQP
	YUyaBqVwHkrwpClH93phZThH6YXtJ20o=
X-Gm-Gg: ASbGncsOqrrVUafN9I+lM9yWagmP3IGmTOZmq5Y+a0LpURUUKG8CYIbFS6qJEArVfhz
	JTr2bEGjCBJ6JywP4J0/m5m8tElDoSR1oPbV+bODwAMnPWKYZ8y3NoX+kgudxrIY1cHE4/8YY2B
	ngBdjD9lYvxxVnLjbcxPHtkqPKGkFPWk0Q
X-Google-Smtp-Source: AGHT+IEq9CJlQpCsxSAOKeDAhty0p+55HMFwKkfBwwDPw4y/om/3YiXzqj5wYwa1h//dEsZFjBLOtAGuETAiJaMGCH4=
X-Received: by 2002:a05:6902:1143:b0:e7d:605d:da20 with SMTP id
 3f1490d57ef6-e7d605ddb16mr12745579276.48.1748011078849; Fri, 23 May 2025
 07:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEzxD05xAJmeUeyFwcfqBDZMOqDfa1sL+iEUDknzmr6XwX5Q5Q@mail.gmail.com>
 <CAFc1U0vhiFvELw7Y0uxiASQspk2ZDkiA4G-1e_qDRZMVH3rf=w@mail.gmail.com> <CAEzxD05krv7gruQvkXe+-zpgjtbdrFOdr-ZY490uyp9ezcyDyQ@mail.gmail.com>
In-Reply-To: <CAEzxD05krv7gruQvkXe+-zpgjtbdrFOdr-ZY490uyp9ezcyDyQ@mail.gmail.com>
From: Tom <t93252352@gmail.com>
Date: Fri, 23 May 2025 10:37:48 -0400
X-Gm-Features: AX0GCFu9amAvrsEDw6vry9OWtj5ufxRNqQUJMXFT_GngTWPj9vW9Tzi2mbrQ700
Message-ID: <CAEzxD07g24GxEwV51QWa2SUg8+6xnXUteyaa_Vf9L97iVmX89w@mail.gmail.com>
Subject: Re: Xenomai Installation Inquiry
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello all,

Just sending a follow up message as I wanted to know if there is an
exact number for the storage space required for Xenomai 3 vs 4 and
co-kernel vs single kernel.

Thanks

On Tue, May 20, 2025 at 10:30=E2=80=AFAM Tom <t93252352@gmail.com> wrote:
>
> Thanks, is there a specific number for the storage space required for
> Xenomai, including all the additional libraries and updated kernel?
>
> On Tue, May 20, 2025 at 12:50=E2=80=AFAM Pierre FICHEUX <pierre.ficheux@s=
mile.fr> wrote:
> >
> > Hi,
> >
> > The footprint is very small: some additional libraries on the target
> > and an updated kernel.
> >
> > PREEMPT_RT doesn't need libraries but not a great difference compared
> > with rootfs footprint.
> >
> > Regards
> >
> > Le lun. 19 mai 2025 =C3=A0 20:55, Tom <t93252352@gmail.com> a =C3=A9cri=
t :
> > >
> > > Dear Xenomai Project Team,
> > >
> > > I am part of a research team currently evaluating Xenomai 3 for hard
> > > real-time control on our system. Could you please provide an estimate
> > > of the typical storage space required for installing Xenomai 3?
> > >
> > > Additionally, if the installation has a relatively large footprint,
> > > are there any recommended alternatives that offer comparable hard
> > > real-time capabilities but with a smaller storage requirement?
> > >
> > > Thank you for your time and assistance.
> > >
> >
> >
> > --
> >
> > Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
> >                              http://www.smile.fr
> >                              https://smile.eu/fr/offres/embarque-iot
> > I would love to change the world, but they won't give me the source cod=
e
