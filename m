Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F4F85944
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653192; cv=none; b=AGB4pe2lQ6G1vVLYnaW10lvdh20HB/wK9pEfZaTvv4k7lva8cMjTubPYZZRF9cZV6RWoSBKoW8pCO3HsVYZevq68zl9GD46FUlLQRUUbxX3GkhWc6C/sUlKo8DM9Eo7rkf6zUMudmcJVPt+ys/HzeoXIIzETRpXpXOch14GkT9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653192; c=relaxed/simple;
	bh=zc/n08aGARGhBVlBtA07Vz0GdFB2Fvi4Y2HRV/myUAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLgQVt+0nS7VRwUPQolFseS/wMgxNnbfaJEpWc+BMsko0oedjF05GhiG3SfjpwoBP/NHkQ+IAzUFXUTCGjK1c1QtUcGfQd3hS1yhxE5c2sHQGD4XeuctBZGvBvtoby4oSHcdIeu8grMbILTTa5t/yLn2HgJAnob651k9ZK6BjXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHOHeTFX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHOHeTFX"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dcce5e84bcso47043215ad.1
        for <xenomai@lists.linux.dev>; Tue, 05 Mar 2024 07:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709653190; x=1710257990; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zc/n08aGARGhBVlBtA07Vz0GdFB2Fvi4Y2HRV/myUAc=;
        b=HHOHeTFXJsa5GZvDEnZzS1iPBH88QKPwXA1SYCVsG1l2N5FlPKEs00YSzPtZhF9gVx
         mwaWN6mVMTZTNYlyeLnRp20dcriX8C8LYgmOsvNHCGan92eRuYWe9SgnS4wHjT+AalCU
         Yy6S3rFrQzCVclw5LvCQPtrBUpXhOdnZZWDBFPi3c65x+bLqdN9ew5WxEuaPAY6KRUHe
         qgl/lOMD914v9S7MugXcFUS/Y+dowbbvn4KemDkf57/f0Ca5GEe9TWUwl+iftRAdNfsK
         8GAG1mgoDKs8HMAvLINgljgbUQINB2lu3y6Dt2BjhQnUT8olbkAI6sYk813NL3EwTWMw
         vrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709653190; x=1710257990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zc/n08aGARGhBVlBtA07Vz0GdFB2Fvi4Y2HRV/myUAc=;
        b=kBT8k/FdHtcSIW2DA5MUtP2Zw8QD89ZzR6WfVZqDABjYbBOEo6eCQXP3neyabUhIOe
         enVRvjsrTXZ+2Cq7o0f3oQ9Vy4zbinI0Rx3hvMK5QdgTqFI2HEXz2TCxyDkE1XheOWVr
         PD9UT0W12bU1J5ZLYQHljR2iCmGSUqlvPjCm5IFGuEk8J++HGabjwMb74h7VH+SJHsS4
         hXds7j4uVyIw+p1g8OIiDQBTwaGTvxWlq90w6nOTXZvII2K91nNisS7jo/FHUnar11FX
         d2CNWbEwUlnUMqnCMo6RTFsDRHh6VPGh6P4onngDgtVL9QDDGrT1iEX8f36xb/RUHEWo
         uXQQ==
X-Gm-Message-State: AOJu0YyHuCtBzAtVhc7dW7e/bRWUSGJuReJkLdZQWLOFXHYsQpE9Gn1Z
	CPfkVvIf0s+6hYvOMQ2PuyG4PkshwjKlL2G5nU8hQvBGczv1PP9hl9dn71oVE7XqFAWWMnSiJy2
	gtcs7iCKX5+uh6RoyMotDFZVtnWw=
X-Google-Smtp-Source: AGHT+IEbz+26C3ccRvniY/hxm5AZWycP5dguNIxwxK7g0uCtLlzoR3r8SU8mKwaOsWE41u0QjO80EX1eOSsyXhrD+oY=
X-Received: by 2002:a17:902:eb8a:b0:1dc:84ab:95d with SMTP id
 q10-20020a170902eb8a00b001dc84ab095dmr3062731plg.45.1709653190246; Tue, 05
 Mar 2024 07:39:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvzXWdySKjXmWv=onYk0urPzkn8bxWuvoFEmLzLyuQTj1Q@mail.gmail.com>
 <CAFLxGvwE76ud4K9iE-Vh8XOdsePWC7JPuearPxZu0omGTFE=ww@mail.gmail.com> <5501876e-57cb-4b24-b83f-815f3ee1cf61@siemens.com>
In-Reply-To: <5501876e-57cb-4b24-b83f-815f3ee1cf61@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 5 Mar 2024 16:39:37 +0100
Message-ID: <CAFLxGvxaEf-XBAo=NMEt5jpAnnDCA_YQV1Cq_Nd5J4Bd26LY-w@mail.gmail.com>
Subject: Re: ARM64 prefault weirdness
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>, 
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 4:00=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com> =
wrote:
> On 28.02.24 14:44, Richard Weinberger wrote:
> > On Tue, Feb 27, 2024 at 10:24=E2=80=AFAM Richard Weinberger
> If prefault was only about breaking copy-on-write early, this would be
> fine. But we just readded it to iomem mapping helper. Something still
> does not fit together for me.

Well, this is not iomem. It's vmalloc memory.
But I agree, still many lose ends...

--=20
Thanks,
//richard
