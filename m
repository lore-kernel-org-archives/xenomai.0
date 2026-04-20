Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339E61E5724
	for <xenomai@lists.linux.dev>; Mon, 20 Apr 2026 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776686787; cv=pass; b=F9GaC/AWGeoQt7pGgLvBB9UhGpHiLQsHHEo1ysQvTHzCtpu0vQQBXdA7j64OyXQ5BsQP+wuAG9QcOyET9PxHwZj+Rl80xjBkl0UZyiYj+5OWnBv6FE/OW+wyaFB2qFiCN9Xef1ixnq5ZBQ5iaYLH/zgJb2RXJ6IIcpy3dmlkbn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776686787; c=relaxed/simple;
	bh=zA8q1P0WTe6BJQXKXAWcVlRixt8D7qlEvWmRXi6rpTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpJv2lTxl44FFN0jftPPLNBlmKcxboXjH7S13WMErt9NR6K5f6mEVLlpaqiB7Y455Clgj9EPAMfA7zjRuidytnodkc4KiDKQA3WI0uD/nahsZzySaV7xWOJ86LktbBl2rjiEv8u0ZyT2hV0/Aw8mDsrUWHJyjWjqu2saB3cCDRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWUlZNhV; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWUlZNhV"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ba36357195bso331263366b.0
        for <xenomai@lists.linux.dev>; Mon, 20 Apr 2026 05:06:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776686784; cv=none;
        d=google.com; s=arc-20240605;
        b=IDd6Q1NU5pNb40LnSMdFTteUgdnbSh3ukkG5goYQve9IKPg2oNsgwRvVMkm39Zfpbk
         NtvAz2ugTUUHOGKsNCe102z+Ilgi6SfLErm6MW7hd1WoourMopUvFcU/khENLEc0OmRQ
         WFhdE41f8z/1P2mD7WJlnec4MmVyjsFvOmwuw7ozm+5NLywykGaPfyRkyigXhIzRLxCp
         xtnzvAD6YGMUmC8VVCi6h7H/slJpV5G6I/+OwGuUYPjWhJ5Qe24l4iP4OtmIGy+svNgO
         aelPHBIDyGW9Kuh1R4ts4as6xUXLe9lPrsg+Sxcy0z4Zp+B2gZNkZg2IbiB/zQYFDHhg
         tnfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zA8q1P0WTe6BJQXKXAWcVlRixt8D7qlEvWmRXi6rpTA=;
        fh=uZ2GMTfPygb6p/C7CAc2jfPl2XLw7VFgbthLjXmtrLU=;
        b=GB4yQCoiKry9wa9rTAfEBq7EJKiKMs5Njh1khr3ASLn+V5lMLgMOIBv10TrM+V814i
         luHHIFFx4QS6YGFlZJCq6RqMk9BWv7EjQZLA/LY1DZTvxWJMWuBLphkXqOS0FVYsBkkB
         Ly2w0ByfrRrE9d5jkwUaw8trPDFzu5NPUj6bnuCP3FmtBMUKCtY0G22wDevoHg765NWu
         wwuzKSVqtRWU+KAaNjqb7xhqiZz9/rMp4+m6admbnew50om4SWphQ6danpSPgYbAUxH1
         zHeXRND1tIk0Bzwhf7nkPJBde1pl88Q/6AkewAf/+Ns/Z4yJTUBsPQ8QNWFZjyTV14K2
         oLpg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776686784; x=1777291584; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zA8q1P0WTe6BJQXKXAWcVlRixt8D7qlEvWmRXi6rpTA=;
        b=gWUlZNhVpghF5jwSpbxRH68hQM2qvitxhtPMD2rUuYNCx044MjapH/T4ggEaQrGCRt
         5AZSDIu1Aju6cZ1LQemFANErpirJkXmklW4aHCdg3TMLD+uTWwCfT4XAaGytNaN/4HoW
         RnZTYjtS7aX/8+j9HW8o276lJLQjGHzsdavUTaDNtpbRQNtL3elZVfu4zNcsIO1ISaF3
         rVlundbtb+Z55kuTZNmtSLxynX08iR3Kyn5OT3MHUa8W1FR79twljfWMpO3Dgm7AGSoV
         jEbjOys4XyTwNn4a0i3nmCiQYNAr4IvM/pfzs93OCNzWnEFQUNI7KceLt37p5SWCe69/
         H/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776686784; x=1777291584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zA8q1P0WTe6BJQXKXAWcVlRixt8D7qlEvWmRXi6rpTA=;
        b=hz1G3/FcfQWpmRJFVmFFsFoNRoz/EX2fBG+LqYC/K0ggrxTaaGN3V2svmBy4mVb0U2
         rM61yzU0X0dgTTJpm3hBlI7pB4IbpuJuWgqQL0j25+9XJwXKNxtizrythCGtRTDpp5fc
         NA5YclxRYcr57wnjZDX+emHY8mz8EamSS5iydmwJOMIFZTQRZpQZS+EeVzn1ks8c/zWa
         ehTwewtMYnSF8mzO+UpNiMYb+MxLbB97Zn5sbd8F385/hPjhHPYEqK/p2Zn/B+66dr1z
         zLLmaY5xN82QqESbt97CmHwRcEqUrQEmEV+MoAqZPjjnafmNqvaOWiLsnoLzd11tR1is
         477g==
X-Forwarded-Encrypted: i=1; AFNElJ84ay62UyJkgcZgn8MBJx7T1OnTOTDYSLOO2hiXO9VG/1ZF1qfe0nKZBTv3fro0yclhkQlA0G16@lists.linux.dev
X-Gm-Message-State: AOJu0Yxvh6ifFunj/KVjBLjydPVtKZ2fRZYcr1RMuMx+IyS95RqbmNSz
	t8gkJ0u6cfMbbbfhgvlWVHSfx/CTzMNr05Y3vVIryZlCZhom5LYlbLM4T/Cz+OVd5bDkZnFZdXW
	pzRT1YOocsW1Q68L1Kq9cb8ZzF+nng5s=
X-Gm-Gg: AeBDiesMVpE9RPz9vKjMW4OHZ3F79Bmy7SAjiPsGEN11sV9cldkjn64f+X86qED+1zQ
	nmKZMS/CxhHt1/YKveJnhvPDs5PwrKuba79EtoRCSY0jja5NMP/GMR9DEvP4TsChdFTFaQ+vQ4N
	cPP2bjwM6Ww+sM4/Grq5d6jfZruYsdjOmEFaRLFs7qVmxwiHkUcpcMC3VyelZTF5JLxsb6/tPmW
	AMQkjs8F8t9wT+Jz6+yVjrvFE8FxlZg5ZijRBXF5LSPtZ7ObNkit/EUahBDxyS0syTX0CCREf5r
	26ytg6Eab1dXQRGT
X-Received: by 2002:a17:907:1c2a:b0:ba7:4cd9:ca26 with SMTP id
 a640c23a62f3a-ba74cd9ef1bmr206431466b.35.1776686784339; Mon, 20 Apr 2026
 05:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260412073425.956320-1-richard@nod.at> <af74e234-327a-4b59-a33d-8d817e34eaec@siemens.com>
 <946371069.54252.1776111069832.JavaMail.zimbra@nod.at> <0b212101-486d-4334-9e03-89ed95fdfd99@siemens.com>
 <277806441.56046.1776164574699.JavaMail.zimbra@nod.at> <e0887ec6-53b9-46b1-b360-84acd154a561@siemens.com>
In-Reply-To: <e0887ec6-53b9-46b1-b360-84acd154a561@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 20 Apr 2026 14:06:06 +0200
X-Gm-Features: AQROBzAvNtOuVHEqUnnbID0bSTEQ63BpuN_uyGYmnDzeISHomjpdzaePUC-8lNY
Message-ID: <CAFLxGvwhLbg=+h78gUokbnH1N+YtttLn6hDsShx-TRc4pyfkWQ@mail.gmail.com>
Subject: Re: [PATCH] xnsynch_requeue_sleeper: Return early when !XNSYNCH_PRIO
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Richard Weinberger <richard@nod.at>, xenomai <xenomai@lists.linux.dev>, 
	Philippe Gerum <rpm@xenomai.org>, "upstream+xenomai" <upstream+xenomai@sigma-star.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 1:33=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
> > It passed my tests. I'll resend updates patches ASAP.
> >
>
> Perfect!

FYI, I didn't send the patches so far because I see yet another linked
list corruption on the customer side.
So, I need to double check.

--=20
Thanks,
//richard
