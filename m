Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D141FFC55
	for <xenomai@lists.linux.dev>; Thu, 29 May 2025 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748528550; cv=none; b=lrEAq5snoUmo6stwts3+ZBKad3bQGmXW3idBsEOf07NnISmeR3n75itSt5Rgl7jfHqf0w6SHKfnvHhCABRF8iKUJNPal9wisW0yFiVfblWmMkreG1Y83/QXIcnjTcrh/eb5Z8ukhGgRmNdcf9RTTr7T+ufYlLtCgvnOT3pYxvWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748528550; c=relaxed/simple;
	bh=YrqgIwiiutcgz0GgVbka/207AJCngK5W7NyHdU0wrI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WeKmrbYEcgp2AlW64i9tFsNi6C7dTjWmHagVRrd4EsUzjLLHhWK3lvDdr4Zu6QdMszzol1aOVjcEMtgCMx61xhluC/P8ORSA8ZI6aK3pJVJhn+8VdqvKmCu6KelSjzcUyOCnknzlzBX0SOGMVPHtuVF4rcBEwb7YZxHKuKv12pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6xNCa0e; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6xNCa0e"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e7da03bb0cdso638106276.3
        for <xenomai@lists.linux.dev>; Thu, 29 May 2025 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748528547; x=1749133347; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrqgIwiiutcgz0GgVbka/207AJCngK5W7NyHdU0wrI0=;
        b=Q6xNCa0eMtqSYCYf5olAw7Rho83xd1aF14vn094GjL65ULSHiZlC004qfRYv07gJBo
         iHbyJ3Tg6CNCpMNjx/t5RYhCYN4aKTnK2OWcOo84sK4q3MDuslBVye36eBA2jmCexLVM
         oBaa0JRvjAiiZtlpOGLcSSrLzA6CBceDiEg4yKybS0QTzySw8C1IPIZM2Fg5xWv17aex
         CjdHyaY+Aa1dlJ5TPZV665ZEcoGJsqfHApLfRmwuZf/aicE18jWUAkcSkud1bvhCTHmo
         8ez1FrSkgVhIHmn8uDrrwd+c26lZxj+m3ebijZvSlSSnLm/pqbXW1jQp3z+Rvhyu9w0f
         hTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748528547; x=1749133347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrqgIwiiutcgz0GgVbka/207AJCngK5W7NyHdU0wrI0=;
        b=FZaqglStPhjhUX4nRRwhp75Lv9KTKf5GMRqvSmCyayS4ccgNx75n2kgMY2MsSYE84Z
         TAtbbUPD8VcKXJxDZG4bSOC/f72DZXsap/gQFsf4ji4xj01Kp7ySLGYwyu72zYbHVHtb
         NH99PwNaVhnaLGYdilBgKgVnM0qHU/q3Xg5RaS8hFQcornU5XwsZ7sP9gANfZKIqyYTV
         84Ss9nyy+KORKmvDsSW7PVdpZ07VhyEsWxCbnZjHVBORja12XK9Z2adcfj+nzEQBdsML
         up0MD2c+rkLwRTqCAspa38INrNFUG8ctUcOqgm9ikVQttuSRCgY53WLsVbNYSTYwT7aV
         z+WA==
X-Forwarded-Encrypted: i=1; AJvYcCVvKcVjjKHb2jsrMUVlz1Y3zBEL/mFpQj4XG8oQ45GXl6D8dZC47E4l3zHrv2qcbnDSGm+pwMBl@lists.linux.dev
X-Gm-Message-State: AOJu0YwGuXwDDScc4+xh5QOdi/1jMVtYvoMGKXumOTyU9GKYDO4kcASy
	zBZWrBYmHAj8f+Tyz9Cw/X66F/S+AdYgn5vjHVUlYbIPRQXu2evSkn2+uY80XC8P/XzMgVOFUMu
	lz8nwBYpudEaA7h53tzL7dwNb03KRs+Q=
X-Gm-Gg: ASbGncu0AG3SG83kDREE8sk7zMGo0Oik3aPxmDfEp4SkTx7HzeFzsFX9NSWcR91L+mP
	Mo74K5vUXRtQUlDUCfjrWxH7NHA+S6GdXRw55fsOeiOza3qc8HgOaK4B1SwJHKZ7/1KX98ldvGY
	okF/dqgDhN/YLtL/WrBvr7VTyaTlTPvHylbtZmr7JAk18=
X-Google-Smtp-Source: AGHT+IGvq2GwIses+7RS8dCAPfEUBGRNVsgjMiyIZJXeirefImbc1J2+CvTb3M24zPDL42wZBlFKpK416V2sVZ3iZFI=
X-Received: by 2002:a05:6902:1002:b0:e7f:6752:2e0b with SMTP id
 3f1490d57ef6-e7f67523224mr7739652276.34.1748528547518; Thu, 29 May 2025
 07:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEzxD05xAJmeUeyFwcfqBDZMOqDfa1sL+iEUDknzmr6XwX5Q5Q@mail.gmail.com>
 <CAFc1U0vhiFvELw7Y0uxiASQspk2ZDkiA4G-1e_qDRZMVH3rf=w@mail.gmail.com>
 <CAEzxD05krv7gruQvkXe+-zpgjtbdrFOdr-ZY490uyp9ezcyDyQ@mail.gmail.com>
 <CAEzxD07g24GxEwV51QWa2SUg8+6xnXUteyaa_Vf9L97iVmX89w@mail.gmail.com>
 <CAFc1U0uNW-NiZqQFA4tU=GVYDOxa5tq5W1Vd1Fa1xjgr3nzbVA@mail.gmail.com>
 <CAEzxD05N_icELe2dP8w_5ibFHW28oUteJSjpW4Q-XFL=AY594g@mail.gmail.com>
 <CAFc1U0tTeiR=khP2-8bdHUPE1vbFKdBk8Q3TNGfD+Wkh4LxNzw@mail.gmail.com> <50cd30c5-8818-4719-b607-0746a5cc0d99@siemens.com>
In-Reply-To: <50cd30c5-8818-4719-b607-0746a5cc0d99@siemens.com>
From: Tom <t93252352@gmail.com>
Date: Thu, 29 May 2025 10:22:17 -0400
X-Gm-Features: AX0GCFsfSAIL5J7Vy-FBDGwLq11x2bxtGigVgjs0aTtW3ksIMzJsMm8yS1gDhvU
Message-ID: <CAEzxD06KHdsT8i5-q+1i0Foj3Q=Gs5gzrSKJ-bfeNDrfBSJO2g@mail.gmail.com>
Subject: Re: Xenomai Installation Inquiry
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pierre FICHEUX <pierre.ficheux@smile.fr>, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

What I was meaning, is it seems the Xenomai install slightly decreases
the footprint of the rootfs and kernel compared to the mainline
without Xenomai, even though the /usr/lib size is a bit larger. Is
that correct?

On Wed, May 28, 2025 at 2:53=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> On 28.05.25 17:47, Pierre FICHEUX wrote:
> > Hi,
> >
> > Some kernel features such as CONFIG_ACPI or CONFIG_CPU_FREQ should be
> > disabled as they are not compatible with
> > Xenomai (and could lead to performance issues). Is that what you mean ?
>
> You likely meant CONFIG_ACPI_PROCESSOR_IDLE. Almost no modern x86 system
> will run without CONFIG_ACPI.
>
> There is chkkconf to validate kernel configs for known issues, fed by
> utils/chkkconf/kconf-checklist.
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
