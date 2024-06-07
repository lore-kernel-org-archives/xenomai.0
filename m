Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D711BC2F
	for <xenomai@lists.linux.dev>; Fri,  7 Jun 2024 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717741119; cv=none; b=DhbVryW/y2ZPfhJqE+cICm1jCvHRsrLiYpll7Q7SGkwFzKflH+WljqcndlZlZTpxGOwjLKbVXUUzHuos+LEyloqrTa7FB8n/6M/rqqCwKYIFeHOL1njOYCuzI/9KpeOkBGkU2kCJ+q2kwgXt4/LZOKemIuIs+OzL3Rg6Q61p89Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717741119; c=relaxed/simple;
	bh=trVDygJYj4/ldYq07xP8e8UdQFpNViqimuDgmMWRgBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNK3+c5P0zYEeFRq9fhnOjI2qRX6Ki16HZaGId84na+vF9I+rcgaGaFuW9OxLeNT4LWqdmcVYjJ9M5JpipZjJH7V0+Nr36z9gEO7zYvnCk5JpPJSj6TniiR/3g3vcNrZucm/UcGw35Q/+fWzXio33Hx82rp6gYybwvvq2wFppQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juCL9XSl; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juCL9XSl"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c2c3c9f97fso157378a91.2
        for <xenomai@lists.linux.dev>; Thu, 06 Jun 2024 23:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717741117; x=1718345917; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6u8DdsCVCGTWjm4OW7dfgwOkMAQzMh3nK7SDPmKMI5Y=;
        b=juCL9XSl/c5C1TZN47EDLS9kXH/6kMH2b3ysg6+uiUXQxcAqhBdXpFb3y219H4oBCe
         TVKBG29Zo2pynEDBd2Lwbm3LN3O6ERZpE5DzyokLA3RgpbyIN1lha+NUhphL/G6VKCoe
         ylpyar4A+berDMBhEIPAch8Z5yfW9Q5a1iUtnNm3Wk+CV+loAKmeQHoTDYxj661DTU2s
         CGnvrq/+y3C/PrcEnWh+2cbyuMMjLYtPnrc+MmO5fdPhDa0LwghwNZ1sPbAEVKHkmvjl
         cVf1PtAdRxbCNs6CrApy3woynZtlPJc/JwcxAgTeWXsqhmVyLHpL+Ri5mGERxiUiFXmE
         CzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717741117; x=1718345917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6u8DdsCVCGTWjm4OW7dfgwOkMAQzMh3nK7SDPmKMI5Y=;
        b=h9VwfNih0NJKqevd0ddy96zDm1Y9R4OYiq9GPZ3Rof9YxRrks7OoXjmLHmfWJXu14T
         aO2mXNV1QXHHfMLfsXGgXiewSNRip1h1gQ9wauMxnLNkMWwzSEbe7nkP1BttrSX5PBFK
         YDIgYJGptNuVt3DYpYHqZvRbiodGj75jL7bFmv7C5NfjN1bde8eUJcMFEJRA0Qlb+YDN
         Pyp6mEi80le9PjrXgR93xH0RrlRxeJYM4QJR+LjKk+QsN1HieKuPX2sAMnRBEa2a/PoH
         k9LjeXroZEzWHyM9yN22Wedd291LV7waD0+7UEAQhE+uJCybPSiC0WzCugoQkwz3hGr6
         9ygQ==
X-Gm-Message-State: AOJu0YyfXTE6U0mwucxr+muJdRGsudWooQ+s+VFRtvgsO3OEUQiriV5f
	0w6z84Sz1b9U2CIGD3P0s1gaDfFDqSJk4pv/viK862kEHVKrxqIsdAOgvCh0vm2qoYQlc9bOcYw
	X++KNju3Vu5IDs9rS4pcehMQC2Ko=
X-Google-Smtp-Source: AGHT+IFtbQMQJhf+zBpwiWmIypuQ/Xp2JK51GXJWOGLRZ177JDpDQ649nxGuvBj7U5eD+CVC9aor1poa0B0gRPrx0VU=
X-Received: by 2002:a17:90a:4383:b0:2ac:9baf:25b5 with SMTP id
 98e67ed59e1d1-2c2bcc0b8c4mr1524075a91.25.1717741117140; Thu, 06 Jun 2024
 23:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <BBCC5A52-C147-4CC7-9BD2-CD0185382EE8@gmail.com>
In-Reply-To: <BBCC5A52-C147-4CC7-9BD2-CD0185382EE8@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 7 Jun 2024 08:18:24 +0200
Message-ID: <CAFLxGvxE1rTOstXPyMjLrqud3er2AeKrR5HFYH1jLVJdJQUesg@mail.gmail.com>
Subject: Re: Dovetail/Xenomai 3: kernel config CONFIG_XENO_OPT_REGISTRY_NRSLOTS
To: YinJie LI <liyinjie0418@gmail.com>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 4:41=E2=80=AFAM YinJie LI <liyinjie0418@gmail.com> w=
rote:
>
> Hi all,
>
> What is the maximum value of the kernel option CONFIG_XENO_OPT_REGISTRY_N=
RSLOTS?
>
> When I set more than 30,000, Linux failed to start.

The value is used for an allocation with kmalloc().

       registry_obj_slots =3D kmalloc(CONFIG_XENO_OPT_REGISTRY_NRSLOTS *
                                    sizeof(struct xnobject), GFP_KERNEL);
       if (registry_obj_slots =3D=3D NULL)
               return -ENOMEM;

kmalloc() gives you at most a few pages. Depends on the memory
fragmentation of the system.

--=20
Thanks,
//richard
