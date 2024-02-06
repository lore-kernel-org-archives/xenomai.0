Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798481D68A
	for <xenomai@lists.linux.dev>; Tue,  6 Feb 2024 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707204375; cv=none; b=KlnmpLQLS4q6wJsychPRPdUPTd0fK3T1ENDBaO0iMvhKm4OiEb+xCHRxd41JHbENhnzKv8oIFzx5FgHyCJGjwa8kdJ+b4y4KzoL9HE2XMTPd7fKT4axxJomsO8jXPqsXFNPEx81nb4i5wYBKY41hZ8+/JHEOTAxbglHOQ/2uFL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707204375; c=relaxed/simple;
	bh=FfQzg/OU1uXgvahwi9/zHewAIQDIUgVuwZVDzQSnOwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdrR6kzY6zaTzYrRGYpmRVo1ILzldsSxszFltlogojEPSmnrDSXBtheTva2Xot9v/+9gcHqm8NVzK3fkVFu62l3PJNbbEDJNCu4blLIzHmKjxtqt5UkC7hBEVwrL/lcqyCuf7VbeI5yV+FY+arHZrzMnsfN2iFtJWpNl5/2HqFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4aaJKHb; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4aaJKHb"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbc649c275so2999300b6e.0
        for <xenomai@lists.linux.dev>; Mon, 05 Feb 2024 23:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707204373; x=1707809173; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfQzg/OU1uXgvahwi9/zHewAIQDIUgVuwZVDzQSnOwY=;
        b=J4aaJKHbbEMTSOUsmfHcuVWOR4NKe94al1SDSBcJeiQHrkzaPAtZnCqEZRh1AAyPZ+
         tZ/hNFeEf6fIGoR15MhEPg073jw2lzFqCYk0sXIuvXzO8clQOQt4Wp0wmWXwayh2ue6A
         GdV3/s9uX47189QxBNOETc34D57fmK4DNwUHYA+oFdCXxAES1p+JPbOXaJfL5k6uFVNy
         njGPmMfI1EpKUTZG5lnC2SpXqO17iz17u4S1GHzB/p2R/L+zlkzch3fXi80MdGox3AL3
         SlwzoRdqo8YIukXPLti744WyTcmWX8IG2HZ1gMPzujlZN2gog+nD8pZMsgKU2YY4fro7
         1zSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707204373; x=1707809173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfQzg/OU1uXgvahwi9/zHewAIQDIUgVuwZVDzQSnOwY=;
        b=W+8IakwljCJRfsgrIKJuswL0VcpLJj7Si9fb1GrDg8Pwmo86Ot76hxw2iwOC54nVse
         0NnaIRbuUJsWMq9AH5N7xWUBJJ5GE6odrK0lw3z1k2IgX6Nfw6NTzGuSYzFVnKtueoun
         r8ZhJjyGWBmrMQpLm/aGLwYcZeT39bJZvXnob1ZxyGHN3HmiKeKpxVBt65Ix/8qwA1sS
         Pnp3Ru42wpeBeVbhxjFJljEpvUNxToL/LVQc2b3qoyuDZ/jzZiCdEbjOop5SGoiZN66t
         Qb7sTNLLhCZabLMdg+feD8EdrkivhGIrEpXq1/my9g2TYKumri/P5JtU6rvRPIaoWqvX
         ByTw==
X-Gm-Message-State: AOJu0Yx020Fsfj2sZk6gMTN4gsThllNkElk4a60oNeok5mr/IxzS/Jir
	foqRRWaC1Bs62THukpDb+pLqXVokAoOyTq6mLESJ/z9IGx+yn8NVl7wE4jQOnlFe+0jiw+fm9ic
	/BT5TZNojm/c1+WtzWRbuvt30hYg=
X-Google-Smtp-Source: AGHT+IHPouyNiaceKHy6XB7/0P3EC2UgrslTmK3UmwdhRrhdrtltIUkP3FB1qDyQpPLHjJpBDolicw7Ldql5OB5WAaQ=
X-Received: by 2002:a05:6808:20a7:b0:3bd:e347:5b77 with SMTP id
 s39-20020a05680820a700b003bde3475b77mr1834282oiw.12.1707204373469; Mon, 05
 Feb 2024 23:26:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CALB5Fwj5g-feayCXagd+rYhq2Wkwu0cgixZssDJs5A_WAmNuQQ@mail.gmail.com>
In-Reply-To: <CALB5Fwj5g-feayCXagd+rYhq2Wkwu0cgixZssDJs5A_WAmNuQQ@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 6 Feb 2024 08:25:58 +0100
Message-ID: <CAFLxGvw--ieUV9v6WKLyvwBKntmcSbt+3jZV-cdhbX_VB73_hw@mail.gmail.com>
Subject: Re: Xenomai 3 setup for BeagleBone Black
To: Mit Jothiravi <mit@mytra.ai>, "J. Kiszka" <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 12:25=E2=80=AFAM Mit Jothiravi <mit@mytra.ai> wrote:
> I would like to run the `configure` script to specify the single-core
> processor using the following command: `./configure --enable-smp`, but
> the script does not exist in the Xenomai 3.1.x stable branch:
> https://source.denx.de/Xenomai/xenomai/-/tree/stable/v3.1.x?ref_type=3Dhe=
ads.

You need to generate the configure file first.
e.g. autoreconf -sif

> In addition, the self-contained source tarballs outlined in the README
> -> http://xenomai.org/downloads/xenomai/, returns a 404 Page Not Found
> error.

I fear the new website causes irritations.
Jan?

--=20
Thanks,
//richard
