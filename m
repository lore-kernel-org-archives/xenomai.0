Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E6D59B6C
	for <xenomai@lists.linux.dev>; Wed,  7 Feb 2024 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308155; cv=none; b=Snu4XZR9IXqdxNIMmF9eJZlTaEdLZr5Ws0Y2EZdJLE8tgHenT9KlFOGgP+zmX4nT1PqFjQgJXogi5Zqyxtqe6ftSpzp0fT2dBf/SOrEwiYEn4fG/aTCHLND+eui7vYUHEwv74wBaVzZN5NYETKEGOotJJN7XjQSVg4ZU1eCAURQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308155; c=relaxed/simple;
	bh=sa8kLvYEUhxAMQZ5c3oiIHeIE0C9TMHEU8nD6oF86V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZC19FuFtZy7gitYH/2cq9fn/y8B1W+m/W8zFu5hlsUfC2ZINMO6YhtnUqFJncso6r2gJlYNRrqNLjxcqVU0jt5XvdUk6IpPL8J+xGvrnKSVkXU/hkezT3nXADXIMAMN0iOk9Vj9KR2RwLD8fKU82gMN6n41w2B+ecqXOXhlHnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fb3gnZBH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fb3gnZBH"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d72f71f222so4816025ad.1
        for <xenomai@lists.linux.dev>; Wed, 07 Feb 2024 04:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707308153; x=1707912953; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88I2KF/CBrRHO7w4L2CaZzlppwc2wyV51yc21jZzER4=;
        b=fb3gnZBHPs5T0MIzwu5sdc3ZTYtq2HlhNjruFcbd+cFaAxPvPlppsAQBns+z2NfptT
         iezP40goGVpSOe56nu9/A3mD4JxHRiOzJJ/RlT0Ww4/jx0A1X3s796vQFaLMokPjj9AY
         PFtqFUKK2LT8fzw9bVccPNJ22bqcMevGI+CDEDDtRqL+TQCr+JKxbIvNDtvC3F8OQzte
         ueRvv+wU4kKn0D9l2f2kYOGfqkPkS5Y79sIWybk4POpZidN9m96wM4Am4EsQiC6HS1JG
         hDw5O9taGk0609I8kxBVpnE02pHUiNU1oylKepbV+X/7YxfudEEHoeY01TjPbphREBlR
         TtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707308153; x=1707912953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88I2KF/CBrRHO7w4L2CaZzlppwc2wyV51yc21jZzER4=;
        b=tVuUU3WRS9khBKMM0dLkgymy8i+ftH4TUe7cc2ZjRy1f24L1dfHjGU6TdYEnE9ZNgK
         x+oU0/atJea/bD9FiGvjrhBEWGoLE9p5rSgiG8LqMDA8clespLjwaln/qCbuPufFfBk3
         cLfsFdESfF62uOjVtnPddOErqHhBzh1Sxb6LH0j5KGR9SmKm4qW777j9U22Fm9m3OVdG
         pGfQkIaDHwpdanEQgS7GCr21iZVy4cgMrS+NuBNPSRuQ0pl6ftaCrV/LBCmCxUjYhZPI
         BqmlDAPGtDKC+FDg09bCjQLPhMvfUeCt7tJ0cIX2B4rdKb2/eplseD+yurjuSR9I8hph
         sUdg==
X-Gm-Message-State: AOJu0YzcPA0/IugCHANoPuEk/JiAXV9sND79XX8EBfDgnW9dcSCyd2vI
	f2U0VjbgoevNLyegebCe38j9Ka6Ioth0oj8OLjzGGnGQoDEkoKThcc16cDoeivbkv6dKClvfd3p
	fNdwGXRSx1VLf7tehpvtxb3HrZgY=
X-Google-Smtp-Source: AGHT+IFeskm3YzKO2tdSvIKVbtRX8MeMk+RtBWbyyJE0smsXm74vak0w8pL0ow2800KWc6w8AU9aP61fdQ9a5B7zuIw=
X-Received: by 2002:a17:90b:3146:b0:28f:fa10:937c with SMTP id
 ip6-20020a17090b314600b0028ffa10937cmr2554577pjb.36.1707308152986; Wed, 07
 Feb 2024 04:15:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com>
In-Reply-To: <20240122160105.2452024-1-clara.kowalsky@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 7 Feb 2024 13:15:40 +0100
Message-ID: <CAFLxGvz4f2Lwv-+NF0sqF+MLTguqDX0YAFJuV7JQgMvf8y1f0A@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Add 32-bit compat support for arm64 to xenomai
To: Clara Kowalsky <clara.kowalsky@siemens.com>
Cc: xenomai@lists.linux.dev, rpm@xenomai.org, jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 6:55=E2=80=AFPM Clara Kowalsky
<clara.kowalsky@siemens.com> wrote:
>
> Hi all,
>
> this series adds the 32-bit compat support for arm64 to xenomai 3.
> It allows us to run arm(hf) applications on arm64 kernels.
>
> Best regards,
> Clara Kowalsky
>
> Clara Kowalsky (7):
>   compat support: cobalt: Move 32-bit compat files to generic
>   compat support: cobalt/arm: Refactor registers
>   compat support: cobalt/arm64: Add compat support and clean-up
>   compat support: cobalt/arm64: Update ABI revision level
>   compat support: cobalt/posix/syscall: Use syscall_get_arguments()
>   compat support: lib/cobalt: Fix VFP detection for arm on arm64
>   compat support: cobalt/arm64: Enable compat support for arm64

BTW: Do you have a public git tree with these changes?
