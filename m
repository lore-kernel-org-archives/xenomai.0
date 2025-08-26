Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAFB312805
	for <xenomai@lists.linux.dev>; Tue, 26 Aug 2025 09:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200967; cv=none; b=lFC/AcK64W8cC1E6ezFLOuGMuCALryamd8BuOi9cLlW1CPmlWcHDurTT9iGYRAvHkhKzZqMxwTzjaAJ5rImkiZwpThTv17KPM4idSJ6pr/i8/O48XQQpeTxGI9zqU450zC6ppk8sdfKT/ajorahmV0STX2cSlObPUl6FklJogkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200967; c=relaxed/simple;
	bh=TyPgmNBtSN7B2bJ/aQOPFDgAtqMBE4gxUvvX/X99TLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O7Alnz3sQqBiB56F5fnngLFj+DrPCjsluvqopOFJwvJFZCnKT4cYNsxDKbkOecE9xket9ed+slQgM14nBSHEw6MVPwJvFKhw3WmLhPsCTEorTVJDeTpC3VsSZD/PoaR1M+pwL7XjavSdSXzQMF59lt9SgxADU3546xjjRJ5o/CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hF1Bv+xV; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hF1Bv+xV"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c4e9efb88aso2939250f8f.2
        for <xenomai@lists.linux.dev>; Tue, 26 Aug 2025 02:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756200963; x=1756805763; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyPgmNBtSN7B2bJ/aQOPFDgAtqMBE4gxUvvX/X99TLA=;
        b=hF1Bv+xVSi7VVVjjfNih6H4tKQdMjl2inIDRTyLuccaA3KNIxOksv0CwZeZiWD1mrl
         s9d7aujEk96nh2bk/6R8xDLefdOnAEzppfMNzYU/H1ErilRCzgrlW2yg1w3HMsMRBD50
         svpS3iMO+fsZ9ZdG5mcYadkDvP9SEyOCb86q7Jgdz2VW4/Bjbfe9IL9Bblic/W99zg+w
         fmWjHtDsRmMgdgod7wD4PN/dHS9Sctqf2fVLAXl7K4oudXuqrZyz5fR2eVOIW9BwbSKi
         4HUziFOvrjP5hu6DSvlrZsDk6JL1xTLP6cWA4eHixG0tLB6J8N8VwHL0b+N3BNnXb8IJ
         K82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756200963; x=1756805763;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TyPgmNBtSN7B2bJ/aQOPFDgAtqMBE4gxUvvX/X99TLA=;
        b=h5ZEG1bEYAttqXFP3Q+0SvMC2rBmC75IKUi7rnDHvcYat5PEpcagKq9tferV5QNMzw
         nGtXmr9uI2MiwdzlHJA+fyVycHgYmq3s8RgxVq3s8VgToX9Y7/3d/CN0FPrVCYvTPUOy
         Q2uDSNvYhCzYBOwQbdcytHQC42bfccshPj1uIoONg3PgMlRQZ1ct7cLb/E+yYVpJmghe
         23stKbhyREr7dJXLgx3uJtY0fBHiJ0yP5PW3CmsiSpUAYsvg08F0JPb/VjaBWWqGIfHY
         Akh/p5wtNl8o+pO9kZXTMQseErvcAH4VR0irU1dMfBiEUIVP+puwgli8fK4aQ/RX/N/8
         pnOg==
X-Forwarded-Encrypted: i=1; AJvYcCW+3aJMKHFCxSGXBVOVcYDqJ7qQI4cXZCUp8MEm8Fvi8z+N0LW7/KQGbTwKRaKilAoTS4Z25IwJ@lists.linux.dev
X-Gm-Message-State: AOJu0YxdJpmjGKVx6qCGABnMj+0N0Iq+npSnCUu8oebMy7HPlWj/CPYW
	k97YlP+/YZffgJoQCtk/FgEqpfe6o9nCytnCmKEE0FklQdINQg8YsaTnwrTQEQ==
X-Gm-Gg: ASbGncvWgRGqIy4fQVj5BIRjJkihheq74rNWxJpbAsR3lme+pdlNQAhxgJAe8G8wPeT
	gGimZuie5GG8HiOVeNLpkc9B6zXDbdLwqfA4bxJCFV0oXJoUJdeFIF6qgMNT/OjxwhGMt6xOAgu
	LH/51OAKETINEioOc0F/kxtZQejYL/QD4yfzc13aWqFuerwzHVHfjt52c1/r81EcE/fDZDDmNnl
	+gRARXOKasbIq+wFS9eP8zoCLGvwOwKwTOaAjSVsGPH/jnpEikLelwMUr6ataIBVKbczFmBAu++
	a1dDqrY6Ingls9IYNo9tJLYv4Qhf2G2CQ8SkeriUldR9gn6zRLK4kPVfzlwJBtnfOL3CRYAglqV
	LuhBh4wrcPPnq4Icw7uGtdAY=
X-Google-Smtp-Source: AGHT+IHvwd3ZGUGZzOr/lANqiPVU4r+v0vdrHOUkECbtdSyEBSOEa7dBegWVNGrmYJZbMhD4WIPnBg==
X-Received: by 2002:a5d:64ec:0:b0:3a6:d95e:f38c with SMTP id ffacd0b85a97d-3c5dd8aa9e5mr11235495f8f.33.1756200962873;
        Tue, 26 Aug 2025 02:36:02 -0700 (PDT)
Received: from bogeyman ([90.121.115.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711abd15asm15545661f8f.56.2025.08.26.02.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:36:02 -0700 (PDT)
From: Philippe Gerum <philippe.gerum@gmail.com>
To: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
Cc: Philippe Gerum <philippe.gerum@gmail.com>,  xenomai
 <xenomai@lists.linux.dev>
Subject: Re: Documentation port to relearn
In-Reply-To: <23c94fc57c83fea60a929065ee47f70755c65d16.camel@lapp.in2p3.fr>
	(Emmanuel Pacaud's message of "Tue, 26 Aug 2025 10:34:28 +0200")
References: <6103a8831efc075fea7ddc7d7cea574f411a7795.camel@lapp.in2p3.fr>
	<87h5xumv36.fsf@xenomai.org>
	<23c94fc57c83fea60a929065ee47f70755c65d16.camel@lapp.in2p3.fr>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Tue, 26 Aug 2025 11:35:51 +0200
Message-ID: <87y0r6ifwo.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr> writes:

> Le mardi 26 ao=C3=BBt 2025 =C3=A0 08:54 +0200, Philippe Gerum a =C3=A9cri=
t=C2=A0:
>
>> > Browsing the Xenomai4 documentation I was annoyed by the sidebar loosi=
ng its
>> > scrolling position at each page change. It looks like it is an issue w=
ith
> the
>> > hugo learn theme. In a commit I saw learn is reaching its end of life,=
 and
> there
>> > is a plan to use relearn instead. I'm willing to do the port if it is =
still
> the
>> > plan.
>> >=20
>> > I have started the work here:
>> >
> <[https://gitlab.com/emmanuelpacaud/xenomai4-website/-/merge_requests/1](=
https://gitlab.com/emmanuelpacaud/xenomai4-website/-/merge_requests/1)
>>
>> >=20
>> > I think at least the first commit is already useful, as it fixes a bun=
ch of
>> > broken links.
>> >=20
>> > Please let me know if the port to relearn is still wanted.
>>=20
>>=20
>> Oops, it's on its way on my end actually, v3.xenomai.org is next, almost=
=20=20
>> done. Basically, only the landing page is missing.
>
> Arhh... I have just finished the port. Let's say it was for learning thin=
gs
> about hugo.

Which is nice, since the documentation can and should be improved as
much as possible, so you are basically up to speed with directly
contributing useful material from the end-user standpoint ATM, which is
very valuable. I'll make my best to commit the new version of
v4.xenomai.org early next week, so that we can resync (I fixed up some
content there as well as porting to relearn).

--=20
Philippe.
