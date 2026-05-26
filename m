Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58993D9684
	for <xenomai@lists.linux.dev>; Tue, 26 May 2026 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805927; cv=none; b=YeDnCzKtEfIKf92gW0uVM0jdZNu9kyE8BDWtIAQ8nxaiw6NarwBKL7cdah6XWmGvf7zKq4Ei9TQ9eymfjDirwYUHd7RbURp0O4tICLJpvwzh78aEx7AJcHounVp/Zd6Lm7oxAb5lCDemLc84ZQcljG1jw/mGa+f16PgKrwnCGKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805927; c=relaxed/simple;
	bh=3GwtavNU0xi5J2G4AtGecEfpOb75zaVay5Flo2DRx9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KQlBYRLtXXbcxJLTheLUjemUJ/6+EV3VYJGvT79QCioW+zr8ZPohhVJUcRcptGY8nN4Cgc8Exne9jgvEFpn7WmP43YekjpGQ8AAP9JZdgPtEj1iAsbxc7qlIBX8umUFvYfI0Hh0Mnrmle25kYnOieUeRtqxwFhbco9zHTPVThR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=FpIy3RkH; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="FpIy3RkH"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 3265F581D4A
	for <xenomai@lists.linux.dev>; Tue, 26 May 2026 14:08:09 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DEC673EBA5;
	Tue, 26 May 2026 14:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1779804482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3h8mCEdph4f0HAtqQcETtoG7jPIwqybP/ga7gbZlto=;
	b=FpIy3RkHfdvk4byXd3fZo5tRRRCPv9V510p3yYYKGw/khTyMK5Vo6oHom4Mw9UzwAlf32l
	EBB4tq4nE8kmADwjjSotMEMV2jEcQU62GrPJHZTUq+fck5bv86QGLmyH9pAQGXWHhySX2m
	3DxHpJC/X6rGjXyLNm1yjn3/Td7IDK79AgDknAHIUWAMaY9GNipiH5yVnbrdp3GfqrNdxe
	MwxT46Cgpf6Mtn5jHJFeJEJ8tA5z86UKiUPycBOnOA0SiAuL2BDO3dp5mqX/ThSxVjksik
	BCGPMNnpZlznaf1hTrvXNU33BwdoickDHVvDk5bBD0NVhDvX/vXq4eISXjofDg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH Dovetail 6.18, 7.0] lib/vdso: Fix build failure around
 CONFIG_GENERIC_VDSO_CLOCKSOURCE
In-Reply-To: <20260526103158.2476350-1-florian.bezdeka@siemens.com> (Florian
	Bezdeka's message of "Tue, 26 May 2026 12:31:57 +0200")
References: <20260526103158.2476350-1-florian.bezdeka@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 26 May 2026 16:07:54 +0200
Message-ID: <874iju5kn9.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFSpZNMjK/WLoL/rjYEF4ST3/0CFF2rWM7W73bTuMv7WhgQYG9o+9ez8OKRqgmaVb34f07hFGeWQLOxDfupjyoKS1pQVB1cSYtqx/dCpmRdNWAkAY4gpwXPDB7WQsnvgDc7aaa4KriC5FsRL/PNqn9p0pUugiICL5vpV1AUlJ+UP/XqBTz18BIiPTS3fql/iEkjfOeFgU+aMxG9QeP9iCG9rQKrAFyTb3j/Nz84U5KFxatilSPYL/WTN/i2/MyJzUuqmxFPl5eTQwNWak9yAVPh7Ce9bi5YbbFgBpXGJuXN/vQPYU1uW7XEgBBk3Vcjc9xvhYlUmo0ZLPR1YCTyKmrDR2smN3E7wc2fZFQcfX6/M0RWUeAPk+KHl3a2WIofEs52k+A3eRCWpkehdO3IJ3pKqldehYwn9aXGUy7iwUIS2frxPKKM20mQvEuNK9Tvn3tFsjxx31TXiWG5BOOAjW5t7OkzQraZn7pDiKIEI6Pyz4AJLzNYTf+2Mxgkw7+vu8QbabLFBRVSoTo3FvUH7KOmXowTj7c/0KGLGexy83+zmXjae5SGKf7WZ0V0zQT8viIBj+KnSSAj3saWhTCjFmA3cqoWOPOmG6RapXzXVH1jl61BLJXmoiHgQEE8EejQq8bkHp6EliNpRvU+SLZFQsPXpOuCoYj7dfCO1bMO6CtQ2A

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> During the forward porting to 6.18 the signature of
> update_generic_mmio() changed and introduced one undeclared variable.
>
> At the same time the name of the kconfig variable got invalid.
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/time/vsyscall.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
> index 13f6c9d91045..5fa096452dba 100644
> --- a/kernel/time/vsyscall.c
> +++ b/kernel/time/vsyscall.c
> @@ -76,7 +76,8 @@ static inline void update_vdso_time_data(struct vdso_time_data *vdata, struct ti
>  
>  static void update_generic_mmio(struct vdso_time_data *vdata, struct clocksource *cs)
>  {
> -#ifdef CONFIG_GENERIC_CLOCKSOURCE_VDSO
> +#ifdef CONFIG_GENERIC_VDSO_CLOCKSOURCE
> +	struct vdso_clock *vc = vdata->clock_data;
>  	u16 seq;
>  
>  	if (cs->vdso_type == (vc->cs_type_seq >> 16))

Merged, thanks.

-- 
Philippe.
