Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18037306768
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590892; cv=pass; b=gD+xKgTuOeoLaeGGOv8ydvoW87+TdYKYHhqXElCex3re9JI62mGSzRyqJCsK5WlZBAgB42mdn9r9fWOrqTSYPU5VnnSBaB93WfK+PSFIKzljXGp5LyMK48bCH3I84OiGucVVyXS2OhTf+gugV8ipj5KIvQAGs6qkFENSt2O1Q9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590892; c=relaxed/simple;
	bh=zxGzj7bsY10rU70xZaQZnh09Rhj/iOL12LamCxMVjyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6EKEvUeDhS/TrmrzP1uhDUyvVxn4VN1JyFPZKJ/z7tT6CdZJgF0qmPQvyVZqjKTZWN4DBFgz7h8jeX4RFRci9Af+ZbM/DjuRZLo0wiJCA2HGBUzZncA+Ox+CcoCzh96Mk+POPrCVMJCS+H1JGl8I7Khy9KqjRoml2l+NOS6MtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dF1zy7yl; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF1zy7yl"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36523acb0c1so3855661a91.0
        for <xenomai@lists.linux.dev>; Tue, 12 May 2026 06:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778590890; cv=none;
        d=google.com; s=arc-20240605;
        b=Ff/i4Y0T9vopA6VCFP8+zKL8vtdpBYt10yndNsfRJn8CesZBZlQyAb/NUNNXxD7hLH
         rnuhlPa/dxytI4P5qrlKIO+2xJyHW8ZZZVbkN/KD/KvBon7WvEG9iRwzzTuYvTU0dV7U
         jAnKRHze2tuPN+nd1dGH7ovyDEaYFvx2O6gDj/jvRtkF67HNQBqWdd8EHx7UCoRXfLhA
         p1kRoyrpBzFhCsbETJGJJKhYE0Ig0rm5N+8E6DUXSBlimS6kr736JUO2w1NsnMIPU2pl
         W0j3H6ij38dTYOmXc6A8BHXXg9G9AEcUxegwuagNf72S3ER3sP33Awcu24uSi9Ihe4Mx
         hyfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YKmEOsGmmHm7lrp0uUg6Fpi4tERwqbKvPvM5LEBc57k=;
        fh=i70F/xJHSCaIJBRR2HH0YJ3Zub44gl66K0lYSx46+ok=;
        b=PYRBW7Q3ctUt90n0UXeGHUR4hwqYcwYsN/gQU0E6yqo6BE5G2LgkSAe1laKqAfidGv
         rhp3UK9nhYxMwLg83jxYx5AEqpfEY+Ln3LGnTd5z3Z9bOb1OoRjTfAgzFLS1qfS2FGDv
         XrBAfujSB416oYF8Gl/XW3Kutz6lZwmyiWvoYz/T91DslNZbZPtWUxcntmY0Z4uTz4ph
         GGcIWJTxNuXJhc11ExbmGUW2pcPXGD1SxlKazmBm6VbxXN4+zmg1E/OyOh4rvfbr9NxF
         eBJnhLSxiWQS3dozGoY2JADhzBa3YcfCrKj1l+pNY9rxMBj2Z24kT5cmZv94V/vPsNPf
         FpLA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778590890; x=1779195690; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKmEOsGmmHm7lrp0uUg6Fpi4tERwqbKvPvM5LEBc57k=;
        b=dF1zy7ylsuvq6MJNVJfFthC3Km+K9dQA02T5jOc42LU8P+PPLTDZHKdZn/h9C2wija
         yCvBLbt62xWkIdDyfLEkJFOKF3Wf/qkTrMyMGoBI3aXZcDpQBwOMAg96geqgDy0DYShz
         gn//zccoPVUy6hRBd9xKA7kJjY6t8m6KPV2VyYwUGePGlcO/9AmZQAIEDpHff5PKOgNZ
         m95rc4tgFxajUTAOFHOIDrtrDoeSPdaxwZQJwZzakAqJrIv7LNfpqg5nMz8UdB2EGOaw
         se8mM2UshEckrppvt5HnaTryo3qRnTd/MAIJFqzuV7wsv2qC/o1n2zHKR4BjxiRp1DMz
         lgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778590890; x=1779195690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YKmEOsGmmHm7lrp0uUg6Fpi4tERwqbKvPvM5LEBc57k=;
        b=rVBWZhb9gwSBSTx58TSIHWivhy09OqgkndIDRlJc/GsUnGcZdu5reWOzHX+oeMliZC
         54CyhClUjzokPR8TO/9g4b2wkTj+Bk1pCQqbmjQVsfgfbALoktrMbYHCxQ8Kq8Ycigs2
         T3JfmLpwpjInor11Ww91Aazb5nLN1Y3V90cxcFNAlS9jZlrnaPlhFkd96cw83or0k7iO
         VhbAtWcutu4musKEJgAsg+5xpbHnumrAOYrAcHfTqA8ahtU35mTt0RU7cv7dJadbOycA
         vOwoaXwJwQAC1+eOuY4B7yj0/NefzxKL3gJmctbN2/nyJ2rrD6x04NPxsp5t8mJDllAv
         qnTg==
X-Forwarded-Encrypted: i=1; AFNElJ9cnDCpVGfwoEkfJ55UMEr0zHQknjcyCKT0nqKQDsGvq/ueHgjiIN28RsGLxxdTeypjsr5wZV9c@lists.linux.dev
X-Gm-Message-State: AOJu0YzX4Vsg/0xdM810QIL6RRmtHccCKo0Xs0iGmR+ZSHidQdKeiDEc
	BTk6ctYwPGAvMLcL0nCbv3bx3/GSBbjyvlbAnoFZCr/a9diP2BNoqcK3/MfWPjxduj89Yvqzjqe
	Olq7AgVlXA/3BaasRF2cZBL2MWjLrfIs=
X-Gm-Gg: Acq92OF+jEa+5tU0R9/G/fB1SqvU8CPfjrwVN8FGNNQhhnBiSBbMjQOrdEDyz4Jwkyu
	LhXhwviddFooQ9WFbmdxyROIfQLYXUnyctcmNAoYvnoZyax+nIvNMBgAXu0V2vnHx0JxWkHh+Ah
	0GmAYt60reueDimQplroPcfkRHtnwZE2cTjCQMUsESmcTx170JkANBP4iN6bX6XNbUSknLXI4Tp
	GKKtETFkn3+Uv2t/38h7/2MRFMZU//1nbe/P4d7y73yCrNoW1Z8nUxftkHB9NbObEd90OTOQU3x
	UNGpyIs=
X-Received: by 2002:a17:90b:3d50:b0:366:346a:6891 with SMTP id
 98e67ed59e1d1-368b269e663mr3249179a91.16.1778590890234; Tue, 12 May 2026
 06:01:30 -0700 (PDT)
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
In-Reply-To: <2961c9be-b80f-438e-95b6-a2339f14d738@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 12 May 2026 15:01:16 +0200
X-Gm-Features: AVHnY4JmmMQKZrVpToPmAFXBhjZ0AMWyscy3wU8XWZYJzgcCvprBSb4kVg2CjkQ
Message-ID: <CAFLxGvzYXjy3kkZMSiOqFbHgWTOaBccg3oBtVDKbyB97fedfGw@mail.gmail.com>
Subject: Re: [PATCH] Add build time guard to detect off_t mismatch
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Richard Weinberger <richard@nod.at>, xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 4:22=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com> =
wrote:
> OK, given that Xenomai intercepts the mmap path, we could argue that
> this is also stable relevant.
>
> Can you confirm that this issue is truly gone in next, whatever mode you
> choose on both sides?

Still had no chance to build or run tests with Xenomai next on my ARM board=
s.
But I had a look at the code.

I think it's still broken, at least for the following scenario:
- 32 bit application built with  _FILE_OFFSET_BITS=3D64
- 32 bit libcobalt without
- application calls mmap() using __RT(mmap), so __cobalt_mmap() in libcobal=
t
- off_t differs in size ass seen by caller and callee

On x86 it works by chance because callee reads only the first 4 bytes
of the 8 byte off_t.
All parameters are on the stack and have 4 byte alignment.

On ARM EABI the story is different.
The first four parameters are in registers r0 to r3, all others on the stac=
k.
5th parameter, fd, is a 4 byte integer, so the caller needs to add 4
bytes padding
to make sure the 6th parameter, off_t, is on an 8 byte alignment
boundary since off_t
is from the callers point of view 8 bytes.
The callee expects off_t being 4 bytes, knows nothing about the
padding and reads
the uninitialized padding bytes as offset.

I don't see how this case is avoided in next.

--=20
Thanks,
//richard
