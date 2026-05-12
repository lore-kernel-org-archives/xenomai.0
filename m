Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972DD27E1A1
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598284; cv=pass; b=e2A14r5LQxTXSylLtuprNNd7PGu/7FfOCSfxCEvW+L+kOkrGfFTFKZq9WH0dqXWaJp06A7dyCUWaoRHvppwdKkLoBaLwxltvjfrRn1ewH6URWXxBmAD7oCFRxC8nc7c2mSYTKDIkRUUnyZsKs6p3aT3CgCCr7U6YTSzPld8DYn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598284; c=relaxed/simple;
	bh=SyCxSLUKj4dioTjc4xqMWskNi69lJfQxSXywvrZ+gNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2HGYd+UYs97LRfZi/JHfw+FIl5H+fZKcAwxgzUiPqS08Cp2tzZY9rIDDScqU/ZF7GPWoNEK+V3Qa0nBmIx9sS9TrJaSW18siBT4ERT8n+j0YFKI32TjwPz/tll9LYqDengFMFrN/TxAiNF3i2bwNGn5qXmpfsJDyUH4I2UDiq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiU5d+dp; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiU5d+dp"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67c9616b4feso8303452a12.1
        for <xenomai@lists.linux.dev>; Tue, 12 May 2026 08:04:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778598282; cv=none;
        d=google.com; s=arc-20240605;
        b=lQ8UAlzS3C3mFv/dy5hDWjBhs0FteO88AEgLR/ATfBJF4mYiuRx62kAQJL0XUSKag9
         7k1vw8Ik6PGB9/cEOvWGesNSvLDP9Qcp8/4BF99P9rSr0mso0mK4j+TES7XbXWN0u9BA
         A59aGO5/Kb+Ev9nhHDSsnNPCm9HgMHlEgT5RnnK/Ip4t1Ya6AZoq6cGHptl/6LmXjbrR
         kUvEE1lc/v2M/TCO6EMttdZkXmOpWtTqv2TgChspLUNKEwIC6qX9gbnMuTSPCYkDJDX1
         mffcqSQ1zhx6YdqEu7ZNB84nIlkgMt+wo1Ti2HhMX6L9PJz46xo9mwHytmeHPqq4BAje
         M/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bBM7zC+yzn7ZsM03mU1vx2cYcl6NmP7i1JcTFqIMn5A=;
        fh=1C+L5ASQ20FQhUu9GOmFRyAC0+rkALJkfPMCvOfF89U=;
        b=V7U9OpzFXsW6tLnG39HCmSOWfP8GWpyBweS9MW0P2D1d9RCWxANgCDEeEEhfOsqDAw
         dGAbsfwKwZtnd1h+YBdMkBH3rhq/wPflUvTWrpV7hh/oBP+k9C6ECCLWgUALW4gS2VWW
         hRsaVEfGVC7jRLHes7DBflmoiBDO02XSr//1iCaSse7QVq2gYH9fJEshFDBq//hH5NFu
         6bSOrs7XyVnwCRM4xiEIC8ZdY9dmhhrwwzxsyW/S8FRhmuEeCLN6BfSaBgIWh41i4ztG
         AY/wOIsKOMB1dNeKDAvmoaFmDPWAu2rn4EzRpQCLTPgjz0IzCgg6gjIjn3/Z0A4u0le+
         Araw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778598282; x=1779203082; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBM7zC+yzn7ZsM03mU1vx2cYcl6NmP7i1JcTFqIMn5A=;
        b=DiU5d+dpIpb2Rx9lqfVmI37mIafUD++bbrSQIpITXAnHajyVFlyaLqQKnuqias9DwV
         N0DqXA+eQiQAfb7LOIWTe9TimA0LzqVaAky8rrOcFvhMHVh0FZjxvhb0yRWl/npQy7c0
         3n7c6a42cX+So5vaJFoasjvwuC0HenDYRDbW+ywYw6VJ945MiHvafLd6p6bQ4eGO8fdU
         CmwbjJSTWxVidUu/xZhZ81LwERw+inIoz9fQgCchLIOCrqyaBvkD3SekJqH7GZpUTa07
         jnpBbas5Ae6EHVarIt4tNSSo/5vv8RrMxNo6wtduTdVWiToid1JOfCkom/BS6lSA9eRe
         yDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778598282; x=1779203082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bBM7zC+yzn7ZsM03mU1vx2cYcl6NmP7i1JcTFqIMn5A=;
        b=Q1hMSj/tUxoCwzhvB1cdMA/IJ4OLmJDLIFajhxAPbZp/puDjrEudhZUjK/DeeIiJvs
         XtuKrk8ue+iKS8w1JO9pcGf5vLoMc+QDxEyrjc+qKNAaTfQDSUGo9+qTeTV4j3E15AaI
         crQxySRn7lpIpcPJU8K+Ygzgl560iJgiZnCsBv8yw6wDYyck7KH0suUh5lFKLeK7CbtH
         qg6ypeq/jc/E2as/hSuCZkyHqyRLc6lUzIjCDgJ/r7qiPLyhlSVlnoFzu7YS+wnlU63x
         MhpDX2/m7liP++mrzX9tKalv1C1ULWaZeTCjb5H/Txna9JrSv9Su8wgvlDaHXWMDAXQ/
         gNkg==
X-Forwarded-Encrypted: i=1; AFNElJ8uNaOk5CHzBZIywjqadSpx7I5+fgmzsp+d4IDflpvAWNuE0tehqTo+QyqQB7TD/7rF1JCfU9/C@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+el8sQraGk7IzqNM/l+ZyqAlbFGRVhvgX1UNTz4vTdIvfzfMU
	SbfiLRDu3NCy9x+UhxiItGm9plZfQ7IfSkfUjqUiAB1vSjWBOam5isTUcfm/PIsNtBm/bJLSS1t
	IyZR1NSqLXsq7zFAYMbN3KCWTT4aw+MACH0IF
X-Gm-Gg: Acq92OF4dLmwtdyNgAQYXZAxVrsoP/lYfs23z4xlq2g5q4n1xjygLnPm0lXbY0wS17L
	PlWfCSZW/6OfYUCZmgS+kLgS9sdd821V8FKXqimW/lBHLh52mH+uuPhIXu2lhZm0zc+AfZNAM67
	DGcxVE7ONAvQtEiYmKioeUwInb6z+WxgWKa7re+RqABquNGq1SuYvEfn6Fq2bUTnpUD2hM+wFw5
	/h18U3dOaROOMIq6T5HCGcWRxmRTa70QeR7cdE5nab+5vbsZ6e/pQVh35L+mBXzXdXRNGuNQufh
	BfN5GV9P8P7ew3IvPw==
X-Received: by 2002:a17:907:3f90:b0:bcf:f292:9b08 with SMTP id
 a640c23a62f3a-bcff2a1f067mr554543266b.28.1778598281847; Tue, 12 May 2026
 08:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260507122357.2463483-1-richard@nod.at> <945cb32c-88ea-41fa-8223-f3d1e639e9d9@siemens.com>
 <1863085876.2350.1778157171370.JavaMail.zimbra@nod.at> <3997a44b-0ce4-46b1-a0a2-9ddbed951b5c@siemens.com>
 <955375516.2805.1778158548523.JavaMail.zimbra@nod.at> <84f6c3a9-b764-4774-b048-eb8e0c7fdc99@siemens.com>
 <472857942.3063.1778163004494.JavaMail.zimbra@nod.at> <2961c9be-b80f-438e-95b6-a2339f14d738@siemens.com>
 <CAFLxGvzYXjy3kkZMSiOqFbHgWTOaBccg3oBtVDKbyB97fedfGw@mail.gmail.com>
 <dfb6996f-1afc-4526-8b47-5972bccb2c39@siemens.com> <CAFLxGvw+Bnb_OFaBD8KnPqpY769VMnMeCK-tLxLoUyiE_eSyiA@mail.gmail.com>
 <2211f3a8bcca094721e7537dc2854e27806da237.camel@siemens.com>
In-Reply-To: <2211f3a8bcca094721e7537dc2854e27806da237.camel@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 12 May 2026 17:04:17 +0200
X-Gm-Features: AVHnY4LGnz8Z5z6jKEaTqsGiIKi9NRY06geTFjDRxKQAfTGck_83mSU2NmSJfvg
Message-ID: <CAFLxGvxqNJ9L527vVdHWc2M4JPM2+hNcid-NKupAyAvrTCmhyQ@mail.gmail.com>
Subject: Re: [PATCH] Add build time guard to detect off_t mismatch
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Richard Weinberger <richard@nod.at>, 
	xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 4:26=E2=80=AFPM Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
> __RT() might be the problem here. You will end up in __cobalt_mmap()
> unconditionally, right? Does migrating to mmap() with all the wrapping
> magic help here?

When not using __RT(), the unresolved symbol is  __wrap_mmap64().

> Probably the same question as we had for the time_t related services: Do
> we want one libcobalt build to support both worlds at the same time?

At least the application on my desk uses __RT() a lot.
Sorting all this out would make some pople rather unhappy, I guess.

--=20
Thanks,
//richard
