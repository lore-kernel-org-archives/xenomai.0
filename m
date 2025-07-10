Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8C28751B
	for <xenomai@lists.linux.dev>; Thu, 10 Jul 2025 19:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752175808; cv=none; b=nOjxO9tJQk3c+jBX2IAJXELMBRPSQFTQciKKkUYcAUFjugQTu4o4guJ/6MKFoNkRwdxIHkZOTNGSPDPJb51y2N+tAdn6K2P6Q8I0Q85U5+KSGlIwfgFWzx+PX0FIEs4fGEQZHB6KeZgsSx0izUP7aORv2peJxMDXpM4wAQCNb50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752175808; c=relaxed/simple;
	bh=bei6xTZkIGrvZ74nQSfKMq/h0bSPRRx7tqFAqqqGqjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/MMNxOyTAZsU01s0Fqe/zWKvjwiv2nauuuCNDW4ZOjS0zsERaifRGbScRI2exzI9s2G7yOPgY0udEDuBjmZX0oGcHelMcWpGTz5u4VaQuKXOCwtfVR/i/GkII0P7TB8WF62peb0OCyNrgw6mQgKB64+rySIho2+2q+xVrTk4ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4IK9q/k; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4IK9q/k"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so2013257a12.1
        for <xenomai@lists.linux.dev>; Thu, 10 Jul 2025 12:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752175805; x=1752780605; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bei6xTZkIGrvZ74nQSfKMq/h0bSPRRx7tqFAqqqGqjY=;
        b=E4IK9q/km6IyGThgJU160DDKgaX7CMjcE5PGP2U/AWZJtk9XcBBqWE8yLotUlJ8l6J
         6rtlbpCsV1Rt/G/YvxC7MdrZMkgIG2ev59TEzKcwXoYsc3c/x1dTWVyAO5SyZL3nC3DA
         YAflJImE/a4bnPSOnGhhKQnO/IlyKHFfcxzXrqh6S6iinbGlItU069GQawAnBxN4PEA3
         w6h0UCUJn9VLMaeYqFsRSlucLCHcOtM/9JB8bLqxuBJonZxwJUVkAHgO5FT4/hqkd8EO
         I0dpYs083uKlC247g6MeJA2vtYg7Dzl6Ohj47y+gZtNJigwSdaAckIvDVE5DRwgiAFtO
         hQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752175805; x=1752780605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bei6xTZkIGrvZ74nQSfKMq/h0bSPRRx7tqFAqqqGqjY=;
        b=JR7ea8lCPcGjMca7Wf2D968RmvMgbyK24YcStY2whE7QOWQfW7o8xJXuoszZjLnV7F
         d03Q/Ll/KqJ4HpckwXDEuaHeJ8qaeChzUGYzWdU8QDYGh3F/yFs+Tv3ET02asqAN9jV2
         UcyDJTh0+BzQnWHGfeDgDZXf4s/I9hhItETZQP5bKkntK+Rxa1wcIwBZZbqfhcJ8vlMR
         1RMjp4xiSW9dvwq4PJ55kAH0M/HeSbquweIDHHlfys1n/FL3Jjl0uGicRRC09NXs77PI
         1o7ItKP86MfIduDx1Om74IOFQ4pIMDM2lP6krMwvI9cIuqesbUYaRfTAMnKF1qYADWQL
         yfWg==
X-Forwarded-Encrypted: i=1; AJvYcCU0RTkmHJBOWjIeZIpRTw/m5zSOUyhfXEglGSS8KFCst34ux4HvwyQqg7IHY8EukHDG9g9+Bkl/@lists.linux.dev
X-Gm-Message-State: AOJu0YytVlIIbSKtYLnqI+rEzCvBZlnTUJ86Vo2zYYHcFaIgrEJVvvpR
	JPCbGEd2iBFyv8brqcap0BbFE8kWJQoi9GSs6NpF0kueNuoo8C40crdLhwk579AinPjnVRnS2T9
	cVXkdFSIXmBec5gGuaTcvXIJYqc4sPGU=
X-Gm-Gg: ASbGncui+91t8lfRPFyGtZiyBBFJkb74cwO14TfGG4E4OX1rSRX6Z2pM0eYG8nEmRD8
	1l9DLIQh7UQ6bKFchmKjh4ua/4eEp/T16dpt92Dafi7ScLhutxJXxx/I8/iGcZRwRvGudj7CqS9
	bJvx0Z5D6TjZAaOy+MvM8C+mc3uUARrksAYHgxVExSxkWTZA==
X-Google-Smtp-Source: AGHT+IEaKGHPOviz9Ud1dgxl556IN0/EVxj/QFf50S1rQPvvMN6rTmJp6biXjQ+qxtewpio/WsALv1zWH4eESho5CUg=
X-Received: by 2002:a17:907:3f94:b0:ae0:9fdf:25e8 with SMTP id
 a640c23a62f3a-ae6fcc27ccfmr30521966b.47.1752175804690; Thu, 10 Jul 2025
 12:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvy2U_0hfTKfPPZAui8XFBMAFqxLnjgCUcD2-Xw3=79UBA@mail.gmail.com>
 <343ed054-2d25-4e30-92ea-ff355bfc2556@siemens.com>
In-Reply-To: <343ed054-2d25-4e30-92ea-ff355bfc2556@siemens.com>
From: Steve Rosenbluth <stever8@gmail.com>
Date: Thu, 10 Jul 2025 12:29:53 -0700
X-Gm-Features: Ac12FXxaMDlwET7UJCBT8Ul0F2pso_PC-q64k13VeS5Emx8s8AJBycHW9LvxHss
Message-ID: <CAExw09CzR9UXe9y2a+YGtQ5Of-g2wP6hmNh4Y4HvyGgwHQ55TQ@mail.gmail.com>
Subject: Re: Xenomai Meetup at OSS Amsterdam in August
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 8:21=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com> =
wrote:
>
> On 09.07.25 16:55, Richard Weinberger wrote:
> > Like last year, I expect that some members of the Xenomai community
> > will be attending
> > the upcoming Open Source Summit in Amsterdam. If there's enough interes=
t,
> > we could arrange an in-person community meeting at a local beer
> > garden?
> >
>
> I will be around.
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center

'Wish I could be there.

-Steve
