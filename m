Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03D23C470
	for <xenomai@lists.linux.dev>; Mon, 12 Feb 2024 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750259; cv=none; b=W8c3HkJauC+KAotdaP8mJFdYRliCV1KIUIvEBr3AOwlf8GSOKFOd6+I5YzwKyJJQHPtYNub9B4Qs2hxXYzkdgf8slh6mi/OwS4llklOObMlkYPDhr8onlMX0tgHgoJQZMgYp6yY/Hab1opCmB8gB1PgOKncF+CJFimveDC/43Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750259; c=relaxed/simple;
	bh=+NsxiSemXSQzZ734T8Lwu7FCadXjamIvVF7HjIUevms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5WTrv53wYgbdFZw0E5uqz09wuBRoBkYoPTMg3qOPj8PcTZ9Rap6iT5AjZKuD0ZwJyTB2CI1WxC6/lGwutOEjPAMcBCmHmRi2JkBFfEDGAh8CWCj1GsVE7fd084R/OSo1AJU5vepd+8wqM5jwDJvGRXsQ0KHuRYvoDLBpqn56Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=M2Rv4g9l; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="M2Rv4g9l"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3c0efb9223so399321866b.1
        for <xenomai@lists.linux.dev>; Mon, 12 Feb 2024 07:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1707750254; x=1708355054; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHxrvilBDN19+JfprvPrNalkXv2C/IjM3MjfrUpRVbY=;
        b=M2Rv4g9lO5hMK2feqQVuqEKn4E3kE+XfqizWn07nJTdkfG2IU5Ghp2+zD8SEmEvICb
         6XTRv+3otUMxsbG+mYvSW2vP4b9UQDMLmmvmiiDRhN3E3GX7U+ojNBFtEEvLK1fbGHhn
         yP4Ul3pBVjYCITDeu439y1UYVxCykmQYn0xOdUVBnP72PP9K62UyZ6IlRGg/k67oVJCy
         Hl1xg7W6OLbL3hHITwYxHLMp/LGUwj/S8We4LlqLWwteHBxbagdkX7CCrdsIkjYk6XmF
         A/PCJJGQ6cBqBtNtgG4/OZ5THhh2OowkQB5kZ/knmVJqivCnSjW3YgwhKLy1DsWgzv5x
         NCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707750254; x=1708355054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHxrvilBDN19+JfprvPrNalkXv2C/IjM3MjfrUpRVbY=;
        b=qfSX+19UqfElYy/3SRqXTb4G4XBrAEaUvo14dgJN52xntDzL3WN3xQnQUwVDXnh/AQ
         uanRHlz3ezm8DUg3yuUVMlk+B7aidnSh8bc7fozYkH+2ddNGqEatQNnU7yb75ovrXHlM
         GnTwi2uuI3r8d8VCPaZYutOB66D6dbrdMyuW/pv3s/+vLwvse7iwcSKJ/qqYwS4mF52k
         50Un95Pl/FAVyZxRE4e9LAxll+LuAKx0knuo3d0+RNx3YXg1/YntKyiF8je5g8m+oOk5
         jVLDDJlnE6Z9P38ssiURZ6fPbz/qe0zbjRaLwkVUAWzPbFoVKVjUZNBbaPRujWW6yTzm
         QQwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF8YNp8gExVIousgyhrOK5qrfK2ITkZcpt+4S5RKZyIwr+pK+RYOy1CX49nDPGwTYfowNfNejiTrAIhynX3EFjQ6+7GTspNw==
X-Gm-Message-State: AOJu0YxPDrOmWLnjpwxWHVQEx9HU0hWV1ell0R8l8SfMZ6cuIDrBDA9A
	Xr3VEfrSZ++4NDNzL54oOYMVnafR9CQomP0Oq4xC9OZ0IBwpNLxuU3NXS3tN5cU=
X-Google-Smtp-Source: AGHT+IHI/7NrlmMeL7U+Qn73W0kgcjKuMTCpraSSI1jEJuR+XXG6lWeqfGnth4C0a/lI+kbWXTnrGg==
X-Received: by 2002:a17:906:491b:b0:a3c:c323:2069 with SMTP id b27-20020a170906491b00b00a3cc3232069mr1732339ejq.28.1707750254037;
        Mon, 12 Feb 2024 07:04:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUEmCNwAawY6H4SU5nGOhE8Xk9BEkxF2wN8nO06QwYBOB8c4m/KDtFl3YZBItwyCPFWV1vaYnZlxG5zcoj4ukVqG7ypJEZBy+ZKvn90RNdKZxDc1N+qLb6
Received: from blindfold.localnet ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id s8-20020a1709066c8800b00a3be8b717dasm292342ejr.58.2024.02.12.07.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 07:04:13 -0800 (PST)
From: Richard Weinberger <richard@sigma-star.at>
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>, Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Subject: Re: [RFC][PATCH] x86: dovetail: Permit to declare a trap handled
Date: Mon, 12 Feb 2024 16:04:12 +0100
Message-ID: <5809272.1B3tZ46Xf9@somecomputer>
In-Reply-To: <874jv7rxb2.fsf@xenomai.org>
References: <006148b8-dfa1-1abb-b243-029db08ceb0a@siemens.com> <VE1PR08MB490963A18B8D61A5AF0B7AFA923E9@VE1PR08MB4909.eurprd08.prod.outlook.com> <874jv7rxb2.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi!

Sorry for exhuming this old mail thread.

Am Donnerstag, 10. November 2022, 10:00:33 CET schrieb Philippe Gerum:
> >> >>> I also did some similar changes for arm64. As we also use imx8 boa=
rds.
> >> >>> If there is interest in those, I could post them.
> >> >>
> >> >> Yes, please share. Then we can continue with proposing it for the l=
atest
> >> >> dovetail port (6.1 now).
> >> >>
> >> >
> >> > There is a slightly different approach which expresses the intent of
> >> > that notification hook Dovetail-wise:
> >> >
> >> > - if the real-time core switches in-band upon notification, then the
> >> >   in-band kernel code may assume that all regular fixups need to be
> >> >   applied next. This is the common case for most traps.
> >> >
> >> > - if the real-time core stays on the out-of-band stage upon
> >> >   notification, then the in-band kernel code should assume that all
> >> >   required fixups were done from that stage already, returning asap =
from
> >> >   the outer trap handler.
> >> >
> >> > This gives the same flexibility than by expecting the hook to return=
 a
> >> > continuation status, but makes sure that regular fixups cannot be
> >> > bypassed when/if switching to in-band mode is required to handle the
> >> > trap. Rationale: the regular in-band trap handlers know better about=
 the
> >> > way to deal with those events from in-band context.
> >> >
> >
> > I like that idea because as I was looking at the arm code, I was not su=
re what would happen if we are out of band but=20
> > indicate that the kernel should handle the exception. With your idea th=
at=E2=80=99s not possible.
> >
> > Will have a look at my arm64 patch and try to adapt it.
> >
>=20
> Ok, so since the idea is generally agreed, I'll push the x86 and arm
> support for this in a couple of days.

Currently, I'm looking into implementing Johannes's RT-Signals for ARM64,
but from what I see on the dovetail side, only x86 has gained support to de=
clare traps handled.

At least on x86, I see that a trap is considered handled if no switch to in=
=2Dband has occurred.
Did I miss something?

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


