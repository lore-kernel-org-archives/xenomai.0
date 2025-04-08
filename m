Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F9720FA83
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744137603; cv=none; b=M3giMvo6hmKf543pjlaeZ7Cfi2dtcozngeJg9ZWou8expfUQADX9ucYCx4V412MAS1CKhcr7NRNRT0vDb4TmpDXRpHrnBlYYm2vnvJWnRXuylDaSIUQWvdbGFMGErGtDJuF/4cORQM1wgvfNH6S/pDSpjbmgXeNUvX2RJVr1mzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744137603; c=relaxed/simple;
	bh=KjjH2BMSU2uX8vXHTd9vjHE/S/zRhi5Zpn/nXKMCqeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vgs2a+8hIRXJZrTg0Vq0AnJAQueGkx0BjZo6fuxJ/pzYBt5BL4dQmlHSMWGJcSK7mg17urSZboYJ/VbFfgOZNXEq5PcGaaHlzUWtSCjsRdaJwD/OpECW9Be2PkPUwNKJ2lqc3vvBPqvFJdPzDOs4LnfTDz9yvHfiaB9pL0XYNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=cNdtj0ny; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="cNdtj0ny"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso6445580f8f.0
        for <xenomai@lists.linux.dev>; Tue, 08 Apr 2025 11:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1744137599; x=1744742399; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL6n7FPMwGsFg1YWP9kzlE/SzH1jSMhJOBWb76BGVpY=;
        b=cNdtj0nyctjrQzxXcCNWjx01j49QzPk8Xiqp+bu1hW8BC2zDP/696gwF0EwKcYzsoN
         ZblkUzMNixFjf8UBGAvGRnAu5k3pQXKbg7khMAD/7kcaSgGP904gP3br7kwVsS3iZ4tq
         L9XIzOi1ITtd6rMEHNRldQHDU4D/ik9eEsO6J2nOTAqgP8iVRGD5oBfEbg0S0WlD/hFZ
         KUnfs0ZGKCUveOj2hgAFfTTblfRemqeofeSvbHZQqv0+mpJobGjiDReCh/mYnsUVHjdM
         +km+ILEEiuu1obdo+GMYvdP621TIAmCQ25xD/P1shSyEB+2JrDGrgW64tnnsRJk7mMqg
         C3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744137599; x=1744742399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yL6n7FPMwGsFg1YWP9kzlE/SzH1jSMhJOBWb76BGVpY=;
        b=QFlMbYrR3Lgpva36kXzcvPh56tNt0XNhFMsgQtL+GJNJs90uHUFB0rcvf0A8kuF3OI
         w2zuMTkq2kQsirXlz8GlhHxzbNM022tsrizc6CDrkG1xEhQkOTBulYHwe47Q+xiT7uF2
         IZvrqq/nbZq3wF3kjr2wuT03eEUU2iiapyjXWQ8scaPJrC2Vt8JXszF9pRg77OBfO8yR
         dx5UoG3o4nnyPWewOPhDsAfG7JbOvRlC/1Uq49480MbKlykw+FSXktgrAYfmKAC0Gg7x
         4pOTsb7Ae5WFbXVWYgTYOwbEPR1XzSNFPabnvPzHFil7VsItBKzbtWycPoAJvlyEZ9ph
         3qvw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ9zNxMFjjinsHlf79X41M6s/3bt66+2NP/82D+7FFLnb7yb/FkXiDWYjsV3xrXxnEhIIxg+nq@lists.linux.dev
X-Gm-Message-State: AOJu0YyqEr4alAaX6ryCJpIPH2J2eBL1KFPYo/CGmLxyW3EmL0vzo5i1
	i9MNxrn5h4k/ixy+MMNSUoKyekJnEdnTCB6uYF3I3HUuSJ5NuBKuwS//Sn6XstM=
X-Gm-Gg: ASbGnctcxVuJxe7X+gCQkICpXPbmKGZEw7lZ66RVJTgfoVA1y+4ZZ3a/7CIJ6N09AR1
	lobC62AG7SgFL+1iTX6oizGML7uxqbkcKCUCx+OWKnlgIJfqTcJAF/J/rgvaEkAlgLChlilrLbD
	B6xs+dIL/GEnpWiOvppsBF7mHFF226gc9eumRdc/ibvRWtSMTyU59MWvPeVbqIP9qjmsGeEhFdB
	160whUwayeWwi+sk1RPpUAO6L4+fLtnVI3s1HElbGm6P3+F1PHDymxJkP2LcB7mPNfztWnZQbDu
	V2vXE1HZHD5BDHT0XBj31dFOZ7+L8F+pEsU+ZYepQjqGr99anpvIRiEECH0jVKZySXYjNbANSI4
	H6dqSOQOelXVB
X-Google-Smtp-Source: AGHT+IE9Tw2YxpoK7YaAJWyQ065XNU61IOCFiMYslf9gGhswNoOEiQm7X35IIZj6CgKtWUc/I3A2bA==
X-Received: by 2002:a05:6000:250a:b0:39c:30fd:ca7 with SMTP id ffacd0b85a97d-39d87aa1b7dmr245315f8f.7.1744137598681;
        Tue, 08 Apr 2025 11:39:58 -0700 (PDT)
Received: from somecomputer (84-115-238-41.cable.dynamic.surfer.at. [84.115.238.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a7586sm15883683f8f.38.2025.04.08.11.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:39:58 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Nikolaus Funk <nikolaus.funk@sigmatek.at>, xenomai@lists.linux.dev,
 Jan Kiszka <jan.kiszka@siemens.com>
Cc: Richard Weinberger <richard@nod.at>
Subject: Re: [RFC PATCH 0/6] Xenomai: Real-time Exception Handling
Date: Tue, 08 Apr 2025 20:39:57 +0200
Message-ID: <6934535.sGJI6kyIVQ@anvil>
In-Reply-To: <879ad6e6-3f38-4f22-aa74-fa3862d85cb5@siemens.com>
References:
 <20250408122817.626897-1-nikolaus.funk@sigmatek.at>
 <879ad6e6-3f38-4f22-aa74-fa3862d85cb5@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Dienstag, 8. April 2025 19:32 Jan Kiszka wrote:
> > real-time.  A notable example is a page fault, determining whether
> > SIGSEGV is appropriate requires deep traversal into the memory
> > management code.
>=20
> ...on arm and arm64. It worked fairly well for x86. This is indeed a
> very prominent exception that people may expect behind this feature. And
> it is also a use case we have with our (x86-only) deployment.

True that.
I think the set of supported exceptions should be architecture specific
anyways. And we need to state that it is best effort.

>=20
> >=20
> > Patches 1, 2, 3, and 4 implement the Xenomai-side changes for this
> > feature.  Dovetail will receive a separate patch set. Patches 5 and 6
> > introduce tests.
> >=20
> > It is important to note that this is not a fully-fledged signal
> > implementation.  The only supported use case is delivering exceptions
> > as signals to the affected thread.
> > There is no support for sending signals or handling block/ignore masks.
> > The only user visible API so far is cobalt_rt_signal().
> > It takes a signal number (SIGILL or SIGFPE so far) and a handler
> > function with the signature fn(int, siginfo_t *, void *).
>=20
> Did you intentionally left out the oldact parameter of sigaction?

Not really. Adding this should be trivial.
Maybe my subconsciousness tried to make it less look like POSIX
real time signals. ;-)

>=20
> >=20
> > TODO:
> > - Better naming, IMHO "signal" is the wrong term and will confuse users.
> >   Especially since POSIX real-time signals are something different.
> >   Maybe "umex" for "user mode exception handling"?
>=20
> Just "exception" might be enough and clearer. OTOH, we are reusing a lot
> of sigaction and siginfo...

That's the problem. It kinda looks like signals but isn't.

>=20
> > - Document new APIs
> > - Improve tests
> > - Carefully select more exceptions
>=20
> Yeah, that is the challenge.
>=20
> And:
>=20
>  - align with EVL / Xenomai 4 to ensure compatible features

Agreed.
The dovetail side is rather small. We could also integrate the signal frame
helper functions into Xenomai.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


