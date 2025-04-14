Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934951ACED9
	for <xenomai@lists.linux.dev>; Mon, 14 Apr 2025 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665253; cv=none; b=eeomO5zKA6BW7JGTNH+O8uaJiCCytZbJn8JTE+sgy1odnCLx46JfVI3+0VTGxuUaIlSXLdelUMv385FX9wAZH7VTFB2jACAU9bi+wLlvYG6N7bTtFN+ainVvXbl8K2T0yuTTJtxoWSQnTRUkJoRlL/dcNamK+sWot6maqyKywPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665253; c=relaxed/simple;
	bh=8oqXlsx5xqOSz+Osd76fiStj5BaXLPL0IZTeU2Klg9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrycO2kKDhNXdDYE1mQoJSULoz1sUojBFEe2hofz/glULmPP1iIofdtWTkUI2qPMFiyjFI1iIppg8ebfMLc+PGkcLkdasSz4Hf2MLJKX9c353j5IXGXMOSNUYtoG5q7Z4ONKxvR61HbqWbvfYMcUowFC03xRdWZVhSZq1cwuUJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAUQbZqp; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAUQbZqp"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-af5cdf4a2f8so3565360a12.3
        for <xenomai@lists.linux.dev>; Mon, 14 Apr 2025 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744665252; x=1745270052; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oqXlsx5xqOSz+Osd76fiStj5BaXLPL0IZTeU2Klg9g=;
        b=nAUQbZqpNKFL+5K4wwwBi4ro6S5vc0PuCn7xNLDzyQ3N5keQ2hTX2I7MqNbGNiS/ur
         J/rGWieCfvAj06KVYa7GhI3aC7tcfR0Y6YFK3VIa0lNlydpXVGvH0/CaDkqlZvqblSfi
         94JhostQWX7jDYqQeP84sqCBhMf6ONA0T1Yl4dDpHmcEYvyK3Hs/GUuelP8BSHpzYFPF
         s1Pe75H0/m2Jp+5TEiqwTmj1Vabns+KOKqE2id4VKVnd5BeJHo1+fbwrcskT2iWDXqay
         o+3A+F8Q+YY/JdgDYhB9KGLzg7T5n63luIzV1IEdQzUxxyADhYvSH4VRy2cWGm1hWFvJ
         hyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744665252; x=1745270052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oqXlsx5xqOSz+Osd76fiStj5BaXLPL0IZTeU2Klg9g=;
        b=dNzWVXofGxSOlY6D/kB6oYVSSDeK/DI7Ldv3zh/svsZfTLgzEwzeahKnmRPW2TIrYu
         HYfyZbWw4YNVJoKWUcj8scU+A1/E7jONgaYRHug/3v4VxetxEJVlNBbHtEIltjTvg3DJ
         OAiidKtm/yWrNZhpeJ9AxAER4cnLoLbdMiZHa53G1hmIFfxIm1gJMJ+FxZ8ZM3dIW0Eq
         Kd1Zqp4KyDo0+BN7KddIQuWZTuNlH13lxRXw9HZTjr0RJphxrW1V9nyouzvfngV2+WAx
         8aG55PyJNu6wV977/Po9mPYK9nncFhV0XFQm9zPlFgiL9W5DjUAaJ/C7vqikGZqMPv6h
         42ew==
X-Forwarded-Encrypted: i=1; AJvYcCUg4sh+0w+PKMPnG0HZ64PK9K/DBWn/EutH4UtEz6IR1tuhMf0lvgGizRU4LKR+F4rtueTFMdmm@lists.linux.dev
X-Gm-Message-State: AOJu0Yzb59ulHOk7geV3pfBqgdUfVx0aiKRFlwStqqt+ls/LItrV1nwv
	85QmAmtzmEBZOhl0qONnYbvs+8rkEL9+xTn5awjEq9mfUHt8gZv0Oa6k9ROxDwsGBPNhRZWK/lu
	noaGjA0l0XXq0YT36HYamvUdUC7c=
X-Gm-Gg: ASbGnct0GAwft08M0pLd1RRr31ryxVeBC2VfiT4vIpX95ecbl+ea2ZtY3mjrrJ9rqV8
	XKSckquGUECDwUOZrsZFqNb+WYf2J6+pibmrJUQZ27cSbkk0DNBT7oHqtF40bklnE6ZYPA4xOes
	wNUZTVaMd099Mpp+KBhTGzTw==
X-Google-Smtp-Source: AGHT+IFh2bqmrjiu22s3n8+ghMpuuSDp/Oon7azmf/Qztg8LJ6xW8eKBZSLT+57Nld0QSUlymLfntMJkdbRJWnr1VZI=
X-Received: by 2002:a17:90b:254c:b0:2f6:dcc9:38e0 with SMTP id
 98e67ed59e1d1-308235db9cfmr24138657a91.0.1744665251822; Mon, 14 Apr 2025
 14:14:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250414153817.1829100-1-aspirestro@163.com> <89584308d4044af665ec7ed2ce71258edc237ca9.camel@siemens.com>
 <3e4268139f9fb21608367b46d939b8d1c93e1f88.camel@siemens.com>
 <CAFLxGvxC+TZKfQ90Q29fh1kQxjqLruUWezdHtjD-OKw=fJBVjg@mail.gmail.com> <cc0b3c1d50ccb79828cfa12058265119b663b1f7.camel@siemens.com>
In-Reply-To: <cc0b3c1d50ccb79828cfa12058265119b663b1f7.camel@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 14 Apr 2025 23:13:59 +0200
X-Gm-Features: ATxdqUEVQxAVQSOuP7BIcvcyCWqMf9ufybJgcbGqhy11KK0AeBhn77Jxeu89oEM
Message-ID: <CAFLxGvw+YK=4pW6+jcVt-_=ZjpikiQpc1m_XwiG5Lkxj--Q4zw@mail.gmail.com>
Subject: Re: [PATCH v2] prepare-kernel.sh: expand tilde in --outpatch path parameter
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Haiyang He <aspirestro@163.com>, jan.kiszka@siemens.com, richard@nod.at, 
	xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 11:02=E2=80=AFPM Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
> > We are already in this hell.
> > Both --linux and --dovetail use eval.
> > AFAIK, this is the only way to fully support tilde expansion.
>
> Ouch... With that said, I think v2 can be merged.

I'm not sure. v1 does exactly what we do already for --linux and --dovetail=
.
No realpath needed.
We should provide the very same semantics for --linux, --dovetail and
--outpatch.

--=20
Thanks,
//richard
