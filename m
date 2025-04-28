Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70A718EAB
	for <xenomai@lists.linux.dev>; Mon, 28 Apr 2025 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745822529; cv=none; b=DyqWVYolPT6sPRJpOnkUuiGBFImR9vk8P3rYDApFKhBhd7wf3q+U/YqsxhVPAtDFellNPaoBZW1Mul3ydbSVUb6lxD3ZPPgWHg1WN7loSLV85jioeiBBlNm/WJRlZJiecQJAcCQ1nYBB3dhpsFd810q2qutO80HrSoCscccGLrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745822529; c=relaxed/simple;
	bh=HZF3V3C70Xy08tiRNGrgI8nCgiFGxK1vKOD6uT8PbSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEhiHhMuktPmyTnuL/5n53FYV7qAqH0hWc/mCktlCin/u6a4wjGSRZEU7RgtJ4fXU8EHzhVjbyCGpRbU9te1x6v1oxudNP3Hgu5oqXMThdlBL03qSOevmeCu0rm6A0ltjFluAhAwDtFQxJTYQZ9Rr2V52CjP6xnzZxzJU1pWvIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3elZ0iR; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3elZ0iR"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e8be1bdb7bso6851821a12.0
        for <xenomai@lists.linux.dev>; Sun, 27 Apr 2025 23:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745822526; x=1746427326; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TU3kCylfZtatorXECVwuH6E13CIzr4cHIEI4Ugh0KIw=;
        b=C3elZ0iRJ5yntS6s52rPHlOCe8Volaokm9XKSSXPCf2fcYNoB+bunyjkS5a7eOryx+
         yLTYMcXywrQVWi0MCf/GyJDqbK0+a1aquijtmX/BVwTyno53v30DNXHS9mgJyuoSGuV+
         GjRHCWhLdvbFzJaKrOU7C2KcORAyQ/AgKq7tTlh+G97V7gtEJLzLD1hcOEkax6jcNsHJ
         bUhrYJJONE0zN2DrnRjfrKI+VKlpQ2zr5CzAJQsbHgDMHZ9hM58d7plr9MUdIPyOk3Ex
         nxS9ZuUcEANB5OGgQLDlVm1IyiAEunc883lR12jBl//NxTqWoY4DFrCs7NlM2olXloWG
         c/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745822526; x=1746427326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TU3kCylfZtatorXECVwuH6E13CIzr4cHIEI4Ugh0KIw=;
        b=kMaU//7maYEP3BX2hdwbxR/KN+thaauZRqdKmXkrzbvuqFzKimLkiXB/cV1c+c74wp
         v5hMfQs9sCwCb0a7Nx0sBMR+UYihjQxiHl9hKgGmKoAkYDW5NnRgbtNjtzodaVanaLDm
         ldBqQcqB3EQzwTAFpEBiSjnJMYykG4DZalE9Bnw59YBGP7anvoW/NV5OCXl/sbUvFTZu
         Pa+3Eg2tykC5KqWfFndM+SyCwg5IoDQG/5qTusqGKE6alsjFdqVeN9e01IBKABk8daQN
         3BCNfEus8I1NN/dzlG40AG6lBzHr68UYmmhr8v+MtvzCwESIl3zdtL2XqrItEnFgamnd
         ENnQ==
X-Gm-Message-State: AOJu0YygIrV92lrusD1/SWA2UMi0ZRDzgS0ok+uxGUYjRMW/YT/6EcMR
	5+03tPv5zMUPl7SL/44Ak2dMYNsEGAfBDv7qstyDV0zmsKhCKDYBfSOmEzcP4CEXMexqOFmuHZF
	z426l7fYOULhUJ9sdgFF7VW704IEsQD59
X-Gm-Gg: ASbGncvUlf8ZFLNn8Hdn3j2C1H8/O6YP00fffbITyalrBCvzK7tMiRqRnrRhDmwP2aU
	0O9LkBPGuy00Yw1gOfAk+NoRtrVTIs9qWpPa7Mo9MXVsrr2YoFbx6+ofF2HwoQjQVM+VYy9h7em
	Hde+XvFqOCMYEVhDdsH2hhEPYB
X-Google-Smtp-Source: AGHT+IGbih8a5TcxkrG+Gsc5nPyljtYqsQbyFxIHDHv/DqmVCtXJmWIqlG5es0rAEVT80D4ZxgWP/+3WIc3duWtkAbs=
X-Received: by 2002:a17:907:9805:b0:acb:86f0:feda with SMTP id
 a640c23a62f3a-ace710c635fmr924640466b.14.1745822525895; Sun, 27 Apr 2025
 23:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+K1mPFJgDYmyM5iZV80JwP21n6vSnrdsQaHV1jGfrhw=+WKFw@mail.gmail.com>
 <1c1f2f75-b1d9-410b-8610-90c3b7caef0a@siemens.com>
In-Reply-To: <1c1f2f75-b1d9-410b-8610-90c3b7caef0a@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Sun, 27 Apr 2025 23:41:55 -0700
X-Gm-Features: ATxdqUE4B6QyRH95wTyu1cNMT1Ow7OYN3BxmA9kmfVKbuq0SnQ40GVohK-TQQcU
Message-ID: <CA+K1mPGzOvNhwifZLD_2zOEwQ-HfzY0ZNkCum4Wem9VX9A6S9A@mail.gmail.com>
Subject: Re: Atomic double writes
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 10:39=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com=
> wrote:
> On 23.04.25 01:23, C Smith wrote:
> > I have a Xenomai RT Task which instantiates shared memory and is
> > writing doubles to that area. A Linux user space task is attached to
> > that shared memory and reads the values asynchronously. Is the write
> > of a double atomic such that the userspace will see a valid value at
> > all times?
> >
> > I am using: Xeno tag: v3.2.5, ipipe patch to kernel 5.4.281
> >
>
> Not really a xenomai question.
>
> You can study e.g.
> https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html
>
> It likely boils down to casting a 64-bit double to a 64-bit atomic and
> use the related ops.
> Jan

OK, I read the link and indeed the compiler has the best facilities
for guaranteeing atomicity.  Shared memory is a common cross-domain
IPC mechanism in real-time drivers, and your answer confirms that a 64
bit double may not be atomic, so one should use the gcc atomic API.
Thank you for clarifying, for all Xenomai users, an important Xenomai
technique.

-C Smith
