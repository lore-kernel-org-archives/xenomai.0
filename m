Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D921D306496
	for <xenomai@lists.linux.dev>; Tue, 30 Sep 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243732; cv=none; b=E/pa/miRcVftwzep3FBXVIr306njrydSeKkbmHEQ7jPUdMQrVCIwHz33865XzJEjeWhkRLJ2FashTbgO1nBJ00Z+F/jmzWAUdq4j8IdD/kRe6tHZ/NrRgQ4YVMz/JDyJ9d6fpbiFgLa4Vgp4yEIcWCHjjgn182oou+XWQeI2GYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243732; c=relaxed/simple;
	bh=7XCQ+sc6Prq+Dq7Bl+pyuyIjz8a8k2MO8Fo4XPVkd0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ewdsXHTq/38ss5RrJkhEufs0id7pcodXBY9GA1p5cabFSQxt8IdKxb7hGIOa921HtnCjYfGjP3FGeDkY8vFa0lLeE2iPfXg87q79oT8m/F/diExfFC3+KC8hKyKytCfEWx6hs4UpFYGR+Ezwc35XU4VWeeuTgonmFte6fr3xD6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=BHGvME2z; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="BHGvME2z"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-36295d53a10so53416361fa.0
        for <xenomai@lists.linux.dev>; Tue, 30 Sep 2025 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1759243727; x=1759848527; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiB09YuHXdimSRp5iKQcbIT7GOtbFnwpBubgCuLl7ec=;
        b=BHGvME2zzS+iyjDTqOCF+eUPHuiJJ82Hsva2rLon4l639cgke4gRB7QbWILD9NPNc+
         YOmJrSAidNeNg8jyBTKXbQW+ipxobH12ktD2q+G4hVjbRlAEssIZQA/iOCzt00YQlS1K
         O09qvZYn4VY3n2R7Awt8eYIn/Liv9Qi5jQkrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759243727; x=1759848527;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiB09YuHXdimSRp5iKQcbIT7GOtbFnwpBubgCuLl7ec=;
        b=O3f/yqfwAq8UU7+2j96Ig0fRQ+WVLS9SVjxw93VrafAwlMUAGfLFoHIcQm2Fc8fwGx
         9AWPS/tucL2W76HkOWtYtLMIVhkYREpyr1svHjJcXJFfrkJyxwG3RuxFhf8BqlFQ544j
         Trc5ci1tHwrgSUOuK8waWugM4RzwUDygXe3BDKEcbctMc3escFVCw2KTGWd8C38R6Qdv
         FLksi6mQwddvb20hJoZ/TcCRMgGWqTfZ6JmTgVciPBYKUUlOcI1FyuV7sWy8vehdm7mm
         N7LlNE/LTikzcutC4Zi/194ANtWISGTg9IPG0Hred9N9TxcNbVUKIEZy2JB3OAWWl7B2
         Y14A==
X-Gm-Message-State: AOJu0YyYi7KjnDaSmMLkragWOBA7YI67LxlGT5rEERZWWCYkDIvOi6Wx
	kkGhTbwkFc3ZN59epsSWn1SRyDokJL4CK2cWy6aUv9gF85oNjIgPl1PbnoWuwLzDFt9pivinw+b
	L+XbmMjLEoLnYyEnpTqbaMaJ5DHVISLo/xHcjwG1gN3ukfMtIpSbpHuI=
X-Gm-Gg: ASbGncuyafQfj1pqKSF/2Vh0y3GEnbnTzIQznkGZezV//atGBhgfYBvEwv7CUIm740S
	rKHO2uN50h9cxf8E92jKZdVYuiYjP/8BPoo6haRmOXoUeAijZLrzHJW+IoFYXe+bBuXPlWzx94U
	HeYsXr6E9SuGrWsN8Z/ZpixzhVncj5q14ev+1gNHO44+H6rcSbIme0RcQmO+Xf+0bffSgytziQ7
	9E4QkE8SU1feftOQ3yuoRUWz9PxPwXRc7E0cqueDNreDO7lOzBoJBGNgc6QVjiWaXPiJ0kF+QA=
X-Google-Smtp-Source: AGHT+IHhhHn6zyF0o3wsXR7GdAzvJsumbNehIrwIbdLRseVj6YX7Gf1SzV7iDXK/cE1snuWMJXCaCKxMrdhnAnTSipo=
X-Received: by 2002:a05:651c:892:b0:332:1de5:c513 with SMTP id
 38308e7fff4ca-36f7c9e863fmr71187101fa.4.1759243726584; Tue, 30 Sep 2025
 07:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0tVxe4sYCkmjyUxTBZDphUm71V8wfpjj9CbyeDwe9gVNA@mail.gmail.com>
In-Reply-To: <CAFc1U0tVxe4sYCkmjyUxTBZDphUm71V8wfpjj9CbyeDwe9gVNA@mail.gmail.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Tue, 30 Sep 2025 16:48:35 +0200
X-Gm-Features: AS18NWBSqZNCxSkP-bLd_7VyloGt8yNHxggwY4T44FHiZMO7aej1GBgC14xTTuI
Message-ID: <CAFc1U0tbuuttzNjBZLX9ftrwAyFkG7zu4MhGK-TTTB=mqa=6AA@mail.gmail.com>
Subject: Re: Used memory by a Xenomai 3 application
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Maybe /proc/xenomai/sched/acct (how to decode the  matrix ?)

2 18470 1 1 4 0 000680c0 142909332360 0 4840 hello_thread rt 0 0
2 18472 1 64474024 64474025 0 00048044 142909332360 66962026760
430302553600 hello_thread rt 99 0

Le mar. 30 sept. 2025 =C3=A0 16:43, Pierre FICHEUX
<pierre.ficheux@smile.fr> a =C3=A9crit :
>
> Hi,
>
> On Linux, one can get the RSS and VSZ for a running process with top or p=
s.
>
> Is there a way to get the same information for a task running in the
> Xenomai domain?
> 'rtps' does not give such information.
>
> Maybe /proc/xenomai/heap?
>
> # cat /proc/xenomai/heap
>     TOTAL      FREE  NAME
>   4194304   4188544  system heap
>    262144    262112  shared heap
>    262144    262112  private heap[18470]
>
> Thx by advance
>
> --
> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
>                              http://www.smile.fr
>                              https://smile.eu/fr/offres/embarque-iot
> I would love to change the world, but they won't give me the source code



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
