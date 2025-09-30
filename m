Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200F230AAC2
	for <xenomai@lists.linux.dev>; Tue, 30 Sep 2025 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251809; cv=none; b=D8S8kdkvq8YBeaQxdeUTefjIMOPLxu0ecNyHXQpccCaBLfWR441qXVhmhMOb+FdYZW8Y3UjIjANFSwNJznoB0q7B1kzqKBrRcXFJYu7mKg5XUoMyDoNOT2PEUZl9CTDLYUEe7IxRZeASvElMBjPmcX/7/5NXdiiHgR8DJ2Hhyf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251809; c=relaxed/simple;
	bh=mpgkv49W4o9CVOWCT99jDc7pp+FfVNaCrrQ2NrTDC4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwP3D2GJNP7t5glz/yacARFsRoeOVPdG2JCzVsCszHU2/xaL/84HGtksQqiTY3gOMktKljZMhr2cvMAWF5I9evV3Qj8o4rX35PGtZI0Fmx4NB/MFxzZu7cbyi3CYTDmuVrF13ePcJzioZdxFmOUECl4uqP0Ssl958YA5cncSJbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=2EkVnhxA; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="2EkVnhxA"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-36c0b946cb5so50162591fa.3
        for <xenomai@lists.linux.dev>; Tue, 30 Sep 2025 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1759251805; x=1759856605; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtI5xOgxyefdyzUHN5Tgdo2+ut18YJPb4R1BUfmyBhk=;
        b=2EkVnhxAoopwe/mZIokpu+vRShUv+I9pJyPX8+WT0Ofhz9AluTz3t27EAvYJuISBX0
         xh6SnSQkvOYQjV2bIazbt7K4z5tLAicCKHykjEJTST40YLnwT7zOZPCWBVRZuZADk0oU
         FlCyz2i1eZNOaWLpkjXtMH9/K4CPsqZHMxDMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759251805; x=1759856605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtI5xOgxyefdyzUHN5Tgdo2+ut18YJPb4R1BUfmyBhk=;
        b=FLIXEcmBTDfaQ9qmIpEt5UyFVRjnNuPh+0np3s2tZrJxX1It0jV/9Yl2bIfNNm1d8+
         rNODTk0IChHS1Yw/RWuLFGRC8xXWWO/cXzXNhS1lYze2wWGMXoU6eGfaMmYtgyuTTzYq
         BWmz59cLOlx0NnJkDCm6kTcJ4XNnqvS3jZqL1H1vtR2eTlAvKP/i8uopxKShgRy0tG3k
         8QuTcbwxx6O1uMW0pCD5AnEQDWvLd7Yz7Gp38O2JIHKy1E9fyAmMN8/qXLwDE+H9aUNv
         8TE7z3qMlkT9HBUsopWsm4jGopqzwY2y5bdyB+Pa800fiCnTg0VKpk+BtqpgXJA95dRh
         N1ew==
X-Gm-Message-State: AOJu0Yx5NHzFMG6b4LfeaXsW9mFlQvLmxpL6Z5FjnLq1g8LpgRO+ivek
	8WayfVaHTOQF5D/M1IdpTWZOfYgmcopzwkn4/P4KdiW6NMcqiWTye68pBojCnpAwokhlqkpIpOW
	UTQskFxC9xK/bk1izx3fPOFTXUHIx2YjZXqSKLZ4dQuWH82iWvMu1
X-Gm-Gg: ASbGncvRjf02e/5Zr1xvtdxVdDmb4E6z+ASGEULaiqxFAEqpRLP1RFzdp0yQad83Da3
	2Q35YckpOWf477xqyO1gifAiuvnO1LIjYx4aSqnyOYz23vrFdp+OU+HursSof/26XjDFo/UedX8
	xMtA6ZHMHA5jkADStBPntIeJFBM9D+65ZgCMuMxCNirVdIql5iqW4y3OgcNjua4wMbfKzy6if+0
	TN74516iMRYQkaD7oT4lEYm+xBNb8r7rayswKd4h7YwqJTvDcHVZVimtJZKnmc/
X-Google-Smtp-Source: AGHT+IHpN5F3YoYBfumrKeWHB73nkydyEnULiNGWdMCbjpHtQJBJGE0hymH6awGvumNPHO99kDzTFVzKluV298g27is=
X-Received: by 2002:a05:651c:2106:b0:36c:ce89:e4cb with SMTP id
 38308e7fff4ca-373a737f826mr624261fa.9.1759251805096; Tue, 30 Sep 2025
 10:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0tVxe4sYCkmjyUxTBZDphUm71V8wfpjj9CbyeDwe9gVNA@mail.gmail.com>
 <CAFc1U0tbuuttzNjBZLX9ftrwAyFkG7zu4MhGK-TTTB=mqa=6AA@mail.gmail.com> <591cc54d-3aa6-41cb-acbe-0a3998927909@siemens.com>
In-Reply-To: <591cc54d-3aa6-41cb-acbe-0a3998927909@siemens.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Tue, 30 Sep 2025 19:03:13 +0200
X-Gm-Features: AS18NWDTWYqOfaM1WmiXCLu0WYNTVd-1JukSAyc8fruVK4ssWhhOyJ-u_x9qD9o
Message-ID: <CAFc1U0u8XaTb+0iFtP053b609pO=w2SWfxosd2i2LPDofDqR1Q@mail.gmail.com>
Subject: Re: Used memory by a Xenomai 3 application
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok thx a lot.

Le mar. 30 sept. 2025 =C3=A0 18:42, Jan Kiszka <jan.kiszka@siemens.com> a =
=C3=A9crit :
>
> On 30.09.25 16:48, Pierre FICHEUX wrote:
> > Maybe /proc/xenomai/sched/acct (how to decode the  matrix ?)
> >
> > 2 18470 1 1 4 0 000680c0 142909332360 0 4840 hello_thread rt 0 0
> > 2 18472 1 64474024 64474025 0 00048044 142909332360 66962026760
> > 430302553600 hello_thread rt 99 0
> >
>
> You found a documentation gap - though this pseudo file is primarily for
> rtps. In its code, you will find the structure:
>
> sscanf(acctbuf, ACCT_FMT_2,
>        &cpu, &pid, &ssw, &csw, &xsc, &pf, &state,
>        &account_period, &exectime_period,
>        &exectime_total, name)
>
> ssw - domain switches
> csw - scheduling switches
> xsc - Xenomai syscall
> pf  - page faults
> state - thread state flags (include/cobalt/uapi/kernel/thread.h)
> account_period - length of last accounting period
> exectime_period - execution time of task in that period
> exectime_total - total execution time of task since its start
>
> Rest of the field should be clear. Please cross-check if my explanation
> fits (only quickly derived from code and memory). And I would be happy
> to receive doc enhancement patches.
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
