Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C43D1A2C0B
	for <xenomai@lists.linux.dev>; Wed, 26 Feb 2025 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740568334; cv=none; b=SXD8LdMqS02fqBMbHaeytJklljfUMRdnYrRk4UhrxCKvG/jabyh3Xv6aNKyHinPqdoZZpmsye/xagQelDc/mq/PnVom2Jw7MS/CL7K8oJATjPNwVH4fUdQLHvUjMhHEfTHrQGXW/arac30yV8pXQEmOnWfeB2nCAgW7Jv+y6tyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740568334; c=relaxed/simple;
	bh=L66vOYIu91WF79SBs2vWTydZ54fEoA/qqo6gmzhiA9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTmHt90taYRhezQx84ZjzFX8vWhlDj1deiRKnsd7kfbAbrLlCtlJKaQqs98FWTdOkKb0SopOPTRX3wfwdAqoEtnhRmUxp3DYQzlVhWyM52QeZmbO7XCp3gkx1Aee6u8MEWQ0DgEA7XG0+rWBgrhhwP7F6KC7s01AfjmY/liKHXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Se0pXAIY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Se0pXAIY"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22328dca22fso8438725ad.1
        for <xenomai@lists.linux.dev>; Wed, 26 Feb 2025 03:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740568333; x=1741173133; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/aJg0sFFM5J726aCHawbrXJ3hZzY00FEzW0ItdEUrg=;
        b=Se0pXAIYkB5QlaGOFfpsX4IsaZ3j5VYVnpUXJZsVZy1vVdDs7YNT1akRdKnUtuGsxF
         WBwUwsIyxCZCp62gkP3s2TLqsgDvb4cPV+apdog3u7fXpCMX7YepSjKOVjcC5SGQeyj2
         do7UJ4pQ3CB9gJ5RSy3RC9NLFEg1f3WmhX/CbPa76SVePBF7t2PF4yv0OnW6trawhm/j
         AeCK8LyEZSdv6wP8dhHXVmgWl29mRUsi2Hsxw25LSOUbyoGj45u0o1sWNap87aomRN/p
         zG5VOpld9ASRVwPNEPmX0S8ne/7PhxsiHzCDJtUgCWD/L3ucf3PqQkOR1skGxD86jrLP
         3drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740568333; x=1741173133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/aJg0sFFM5J726aCHawbrXJ3hZzY00FEzW0ItdEUrg=;
        b=u4xaLgyUopWjAKAjzmPjx4aCozmFgTQsSscPIwrnWze1VjHPlyQUbgdriE7Vtg6+Q+
         e7neg9fP3fbxpWfSx0KBtBL99oMd2YrYz3qU3b2DTy31baQizXw2Aget0omnMS4B+E2q
         Ofxkil33+VIhMIRfxwVlOXZl5vmQxVisdy8Kxrn/tIzzfJW/BOLhnsmzuPrWb12+XBJp
         x5rRayNouvV25Y3mYvDYhI5BDcCxDf7jtWv5+3NOSLvAOTXU31y9HxqvbHQTFYgHVFuc
         Y5TELgbGFlCD6YrC5hn7LGAdRHN19s+zohHJgUP4CpAzOZj+NkBqL39yiKUYBxgg8Ven
         TEEA==
X-Gm-Message-State: AOJu0YymmpEDXFpZnmgRSj+KfR5kvKJEnYP4yqj5JqOeCfEEIf/807Hp
	L1PQT9Q2xUmdPoM8J+8gAEUJO95f+dQtwp7qGYmXaM91PnR7XPjBL7+PXaPRu7VDDGkrRMkCWVK
	Yl1GPMIuQ86gkL67gNQCHf0Ldns5YNqlE
X-Gm-Gg: ASbGncsXfEkzzjAOPdVQ5e6DBMmlkndg6PyseSzehFIQRqFP/cvzYJlYOgCUzUvw5d+
	uF/yr3y53TC7AY0s8fdjHM26pr1GeI4fIIiQ+HMKJmkK+Ev/WCnscTD3ivQ49P/f4LgF/Hztj1D
	7yVxHf2Q==
X-Google-Smtp-Source: AGHT+IFd4whB0ZPHioVnSLlJUKTCKA5Ssaag5lZGk5qBgtNTC1Zrzk6tK7AnkEymZQFerrFPJY/rvndC/6ByAx58CNc=
X-Received: by 2002:a17:90b:2551:b0:2ee:a583:e616 with SMTP id
 98e67ed59e1d1-2fe68ada3ccmr11736278a91.9.1740568332731; Wed, 26 Feb 2025
 03:12:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <51ff9147-9af7-4f5c-9407-b7a73bd1d290@siemens.com>
In-Reply-To: <51ff9147-9af7-4f5c-9407-b7a73bd1d290@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 26 Feb 2025 12:11:58 +0100
X-Gm-Features: AWEUYZlqUKoTRJqrnEtXCwQkw7Btt3GUWn3xK8obShVyz0mhi7VCUwGznqKxgGU
Message-ID: <CAFLxGvz9YrUh0_mh0H-_r0of+4JOKz7eCxRMX+7KRmmXs8ewcw@mail.gmail.com>
Subject: Re: [PATCH] cobalt/intr: Restore support for IRQ sharing
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>, Johann Obermayr <johann@fam-obermayr.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 6:48=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
> +       if (intr->flags & XN_IRQTYPE_SHARED)
> +               flags |=3D IRQF_PROBE_SHARED;

Hmm, I expected IRQF_SHARED | IRQF_PROBE_SHARED.
Why is IRQF_PROBE_SHARED alone sufficient?

--=20
Thanks,
//richard
