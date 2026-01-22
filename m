Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E359339855
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 05:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769058813; cv=pass; b=qgBCbR6pobGjuIH5BrNywPA65IbJN1a8LnJn5gwBfHLtQtY0De2ZXQSqVkc/Oo0ToJX2FNCBlE82XgDh/bjM3UI3GhU//ERRugBIcPkwu7izk2Sa6P08jB1uu+Fbo9bW/s2yc10oJFPpO9vjx/UJJxYRmICmNmf9DGPMtJbNe80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769058813; c=relaxed/simple;
	bh=27bLH46q4QcN2IwaZ+W/RYmPzmHTBd9dAX3k7dEADd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ggx1cZcTwLBKedDxnZyw3dSWBay/wuYtd2XW3FpmSnFm+u6B3GlKHCdcArRN9bj4A2LnTgaFpTM12ciX/ua8sxJ/CRggnegs+4LQQhO6Fq17V3E19kjpQTzl2S4qwQnRzgn2UUH9jNQba883PSuqTydm/Y2aJDaFnt1njN0ScVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=uGwr1WhA; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="uGwr1WhA"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fbc305552so408771f8f.0
        for <xenomai@lists.linux.dev>; Wed, 21 Jan 2026 21:13:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769058810; cv=none;
        d=google.com; s=arc-20240605;
        b=TnpKjSNk3vOhB0UP1M+Zn+jQMP446TPWlYfYj7qvgB2O0dubQfOYzpqgHW/gOqZcpa
         alU7opjguCqED5lfcMZVqj6RA3JzIshE8ZRBXkoPj01PHYtV0w0gxIYtyHFhSCEvX7wa
         3G38D7Tcg+9DUL/LseUXo0+he/Ee+5ommBXUtnVrrhrkysOCxURmE1Hk8hqqndz7UUGK
         kRhHedSGUGfS+aNTZPxi+IoGH6bpnx2H1nsYzOLdtHWNd2ZUzGGXfuYu0bG2hMy+EnQK
         RivghgSKLB1tMpfpQItDTeY81zD2pyPQGb+vkHgQ/C3CLoD1knfXE/sWt/CufToafIpt
         9uSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HeW9sIV/JhLAl5aTN2Yj7YSgRKzzxImH2ZNEs6jX244=;
        fh=Gbokv2cqjXipI/isbuuM2AkWdnz5ZRsDr4BAyqPfOQ0=;
        b=RZn3+5dQepJA0lhxbzay/rPikoV/6p1gGFLuY73Hu+aa8SbGaCVmn/XAFMCaM6MN+u
         Ltf206H4MHL32yfxeDG2SfvJMOlPJ6KjtBMjryQ09QagcgKdLluxVGFYxlYZ2EgQ4ubk
         d/h8W7JGj9GdlTwjBxzBIFd7DxYZcJxRR/hI+sDzV/mZaXBGf+aWecvImWOQL3N/mNRb
         uIz68VMxSsBH7O8Tan3WIQW61kDS5tIXJTBaCH78ZW8Qr675KJbDeZ47eMgMCKhvMzx0
         j0ihGUwGw/0dSAeuVtGeEuKhCLrvOqSn5qojPFm3sDMS65nRlUvWtMODIZqSQ1o79J88
         zIyw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769058810; x=1769663610; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeW9sIV/JhLAl5aTN2Yj7YSgRKzzxImH2ZNEs6jX244=;
        b=uGwr1WhAK7NAOCG3wl+bQ/VbgEXzt75ME0LJipwzzunHQRgLQXtsF5dk+3kaH+4LGz
         fa79YEHHKIT9wPtMuf/B4iwsjeNTUtjlTLEVIYtJJvCUc19MVS0FkwQMEiv6VYqdFBjQ
         q9ChW6gJ6DdAmcnKeCYRwo3hKb0vvQpcbbAuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769058810; x=1769663610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HeW9sIV/JhLAl5aTN2Yj7YSgRKzzxImH2ZNEs6jX244=;
        b=wA1oMPAno7bvZaoftcB4KYP2DmlO2IAdRmimX2+E70o93YbNpSkkCnq/X7H3JanNJz
         7UzFak5VqidKxwgED0ODmUe4jQc0gB4/0CWIPV+UCZLPMDlOTTB0ADCwlap1+ip1W6tq
         B2RKwUldTG2N15WSfm/DhnBjP5FoNiWeU+mNBhL4DyyQtetVWLWMiGlMhcLknhTjz0cU
         jLTsQopXbpt+sz+4rwR+AqHvhlTs3rtlK5Kx3d9u5D56VP+Sx+eliPQis4b0vJGM5iPw
         vBNi6W0vD7A/MCOtqSwlOvejc+8SZuNG2H5f3u/NBiab2D89SAF/mMt9Z21z6JI9T2vU
         CwOw==
X-Gm-Message-State: AOJu0YzBrSCNV+XqTQ4qxlqIdjgRophHNIH82QZOnQjaiEJo0SCUAMfL
	80pGcM/bs68Gy2ZbO0i5CrJdSkBr33oa52ULA2x+PgH7jVlU4Ba83i068lrrpVXwmdV1pmUE603
	TiCxddakxak+eVmqlpre680RwQFPn3MNG/22yq0eraQOxhomUzJIY
X-Gm-Gg: AZuq6aJ6gf6JNuRL8/rmMl+1ufndEd+phFnLTv132aDxASaP+YQ3eH+yKHyYQkAQc6S
	udyIii1lbBTK/G1RFV9Y1wKvl7/ZB0fTjWGsgSscx1DIWbymHAIE2HZsgm45hW5hqHCgho/zptx
	GZpECFtcbuNGYWfQ4pcnGhnNa1jZsbIhQTnMtj9pYw1OVl1pn/QWoE34MQBrZUJRODkz+bWlOLA
	OCnRdP2i0/DtIBpeHrrx2IO+6zf6jmlPvwXJ1Zu7oElB4vRIvw82Qd+GmJCOQBfo5UZUqIySS8l
	S3/uZ87O6ZTIgD2Yumtgk0NvZHacGfAv6CZ8FGsV7tYXtDI4HkuhK3r/BNEvuEiMKG4msEG+9AH
	OdK4e2WsE5k6T2SRor8bYbmqydA==
X-Received: by 2002:a05:6000:186b:b0:430:f255:14b3 with SMTP id
 ffacd0b85a97d-4356a082ecamr27119914f8f.43.1769058809553; Wed, 21 Jan 2026
 21:13:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <dce6da1a-7ebc-4d5e-af4a-bf55142a95cd@siemens.com>
 <CAFc1U0vYDM0sS_BvNh7VHH=j9aFkfteabawTctkae6wwQmx+CA@mail.gmail.com> <bf3e7a23-0b43-4974-9037-a49438aaad06@siemens.com>
In-Reply-To: <bf3e7a23-0b43-4974-9037-a49438aaad06@siemens.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Thu, 22 Jan 2026 06:13:18 +0100
X-Gm-Features: AZwV_Qi4rQ85Yd0c3VqCKG-g0aVq_eqbC63UMyegCEinUF8drXWO9CfEDHxWnAg
Message-ID: <CAFc1U0ss+iMGZx0_GJ83B0nDOmt+zYbt_m3ORpK1uydpHYi5_A@mail.gmail.com>
Subject: Re: Meet & greet at FOSDEM
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

What about a drink/dinner on saturday after the conference ?


Le mer. 21 janv. 2026 =C3=A0 14:43, Jan Kiszka <jan.kiszka@siemens.com> a =
=C3=A9crit :
>
> On 21.01.26 13:40, Pierre FICHEUX wrote:
> > Hi Jan,
> >
> > Did you plan a time for an (informal) meeting ?
> >
>
> Depends a bit on the amount of feedback. But we could also just define a
> slot to meet e.g. on Saturday, 14:00. I just do not have a good idea for
> a local yet, one that is easy to describe and find.
>
> Jan
>
> > Le mer. 21 janv. 2026 =C3=A0 08:48, Jan Kiszka <jan.kiszka@siemens.com
> > <mailto:jan.kiszka@siemens.com>> a =C3=A9crit :
> >
> >     Hi all,
> >
> >     in case you run around at FOSDEM next-but-one weekend and feel like
> >     chatting about Xenomai a bit, just drop a note, I will be there as =
well.
> >     I'm always curious to learn about use cases I haven't heard before,=
 just
> >     like I'm happy to exchange thoughts on how to evolve the project
> >     further.
> >
> >     Jan
> >
> >     --
> >     Siemens AG, Foundational Technologies
> >     Linux Expert Center
> >
> >
> >
> >
> > --
> >
> > Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr <m=
ailto:pierre.ficheux@smile.fr>
> >                              http://www.smile.fr <http://www.smile.fr/>
> >                              https://smile.eu/fr/offres/embarque-iot <h=
ttps://smile.eu/fr/offres/embarque-iot>
> > I would love to change the world, but they won't give me the source cod=
e
> >
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
