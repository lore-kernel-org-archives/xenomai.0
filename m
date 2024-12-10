Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F67886320
	for <xenomai@lists.linux.dev>; Tue, 10 Dec 2024 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853823; cv=none; b=M/JdpTSEuYK62CFlB5PnzkIFmeNCKq7SW+XeQC0iawruR6XK3QhyVfaulmMQK6yFzWTqLXiXbtL2vOGyQqnUDGqNLZUFuTZBrWYCgaZJ+GwXSNuIGu3BswXKRUdmWkvX2M71tl+Li9RMNRKiDYIe7fLVKXpG2Ax/TDHCUpbXFI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853823; c=relaxed/simple;
	bh=ej3cFRGigeYlOZKTC+SOHLmUgI9hUvMk2KLcJC6mIME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rW7dcElP5vRTmK8qPt0u71Evr4XmnQzjdWtbNb8r12G+gIg8v5ZaNOO9wmsUMiE5qioJmWWSSR+tgpXC36xczTDQO05rXEI/kvP3MGr2n/ALwQvpnuHvR5D5XaTwt0Tl+MlafsYINcNVyVi2fu03CxFcOm0X9giq+8AGUu8KdL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUGzHtAB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUGzHtAB"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa67ac42819so467641666b.0
        for <xenomai@lists.linux.dev>; Tue, 10 Dec 2024 10:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733853819; x=1734458619; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpr5WZSTu2I2r/k7tm4qPDGvGQpQY0n5sSn4trykjgM=;
        b=cUGzHtABjzvJk0UVzAYjZXR9qaDyHf3YxryAbvDdUDAeeJScL02JWv+dKAyagWMV9U
         Cxqa7YLBYvOavv1FvdMskUMWRgF9OZ5FKvX09CTQ4GuX91Ltk2azxNZWdoXtDZWGaI+y
         ucDwpdN87bBUVl7tqZoed8g62O9h3S33/Trf7Hyzwjke8kR5OeORZXUCteTB9Fm5NrcM
         +OQ32vNX4PeFz+HFDYI/9/y009XjqEB8EyvNmeZgg1tGRFPV780pWOAXEsTj6CEgMdD5
         0x3G/MEfnZ4723UEX9vKSlnTDst3fZf6ourszxvGezu3uguZbVRi5ZLunY3XfztL+6ZF
         hoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853819; x=1734458619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpr5WZSTu2I2r/k7tm4qPDGvGQpQY0n5sSn4trykjgM=;
        b=r3fNVaF+yMORWLmMD2FYQlsHxlucCt4di9FolIJ50tpAZpVxS9M4cS4TxTnbboCOLG
         4ZxEzEZLH7eeYLsxtJnO7PjBykxvj0mT1aauxLGOVLOKibxltcZ6xNMpeBnCo6fe6di3
         VIOQNTaTz9I7w6p+oxHlYevJ/mkIy3PGKMEZvz6K+pYZwnojSvnS010KH57IjO7MG0cV
         eUbFaUSgOLiXs3PmIdTndZBIy+Anuim7nm152fW1C0m/hf6d12yKucQjaOMOb/QoGBCx
         LtqwgikfPuizup0w9MaGRn8+pvCnZndOhm41nvaxkU5LlzuOwNqpOnqdfzpxY4AFDCyA
         KGhA==
X-Gm-Message-State: AOJu0YzN34kR3YTaebwKJz7ITC/0/a7JZariqpkr1YpwNSqgKCv6ybE1
	SECWKfGI4lNM3+7bNfMza4VAWGYpyXiLwJKdUc+qpHevsuBqT5kcZqWsd0QuQjm3tNlXqyQBQHD
	kwpwedbVVLi3HT0UbhX8vn4y3xUdJk4vx
X-Gm-Gg: ASbGncsJMTUrtqELACl0JosBNgMomHzqw17eJDzusHuBHy1cJ9dp4Vp3N7P0Gnq9oxV
	XD9kjcJx3QS7aEhuCZ2EgCRxrQ1AiFyrBOAolNQ==
X-Google-Smtp-Source: AGHT+IFNlu+nfKZQTBqRoCrDXQUkYfJS6VDOEDzpQyS80wTu4vpWTHCgOBVoDpwTpofoPiEZ4Fj6f1F6/pxT8GwYDwk=
X-Received: by 2002:a17:906:23f2:b0:a9e:d4a9:2c28 with SMTP id
 a640c23a62f3a-aa63a24bb52mr1520396866b.53.1733853819183; Tue, 10 Dec 2024
 10:03:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+K1mPERb-5hy-Ta9QWqbJVV=V7E1_w0bK2kvivxLNYcQB6KZg@mail.gmail.com>
 <1da1e22f-84cb-4dda-a3c3-e0741e10bc9c@siemens.com>
In-Reply-To: <1da1e22f-84cb-4dda-a3c3-e0741e10bc9c@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Tue, 10 Dec 2024 10:03:28 -0800
Message-ID: <CA+K1mPFuC8mPyKSz1aovc39sD-rifyjHJXuJ=M0oQ=nEro-Brg@mail.gmail.com>
Subject: Re: Intel speed scaling
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 6:12=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> On 10.12.24 09:03, C Smith wrote:
> > My Xenomai RT application has good timing latency but my processor
> > seems to be "speed scaling".
> > I'm using Cobalt kernel Xeno 3.2.5  kernel 5.4.281 on Intel X86-64 CPU.
> > Speed scaling is turned off in the BIOS, and as far as I can tell
> > speed scaling is not enabled in the kernel config, yet when I do:
> > cat /proc/cpuinfo
> > I see variable speeds.
> > Are there specific kernel config options I should be using when
> > building the kernel?
>
> Normally, turning CONFIG_CPU_FREQ off should be enough here. But maybe
> the firmware jumps in then and does own things? Never seen that, just
> speculating. If that kernel config switch is already off, you could try
> to enable it again and set the cpufreq governor to "performance" instead.
>
> Or does your CPU support boosting / turbo mode? That may also explain
> peaks. Documentation/admin-guide/pm/cpufreq.rst says that control over
> boosting is with the hardware on x86. But the BIOS may allow to turn
> this off as well.
>
> Jan

The kernel config says:
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

So I didn't forget that. The CPU does support turbo mode. /proc/cpuinfo say=
s
model name : 11th Gen Intel(R) Core(TM) i7-11850HE @ 2.60GHz
I'll try your other suggestions.

-C Smith
