Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A04752F74
	for <xenomai@lists.linux.dev>; Thu, 27 Jun 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719476441; cv=none; b=dk3eRH5Z3IcIrrRIskoByPRHYdzreUkHrf+eInIhcZNZG5pug39FtqeSLI9SFgLo5frutucRySOKggOYLI+nKQzj6ZY4OEtRMLtkahdxCVuNBqUhigHC3f2gAV/F0nt3EFsXwLA8QCwApjKTcuDAOnkVhst52NiSkZU6fFtpXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719476441; c=relaxed/simple;
	bh=1NmeEgQi4Hn4JsG/NYfpvNBRz32U8phyfHoTK5G+JjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FiqS0Cp+oYq0A6FYTAdYWtDSUTIOxYHSc9Vh13ZTPFH0eV3qA6uvAfiCarfOJ7TJhHSgSqmQmMywnChH5Hc/J/CZP3dhpsfLXecK9rSAvtBirhysomfnjckYizc6GoqIu/3bK2hGwu5/cBdgzgoFAAGR/KVuzRGt7EGcGp1/TI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=aJzUpOA1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="aJzUpOA1"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42565697036so1734465e9.1
        for <xenomai@lists.linux.dev>; Thu, 27 Jun 2024 01:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1719476436; x=1720081236; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NmeEgQi4Hn4JsG/NYfpvNBRz32U8phyfHoTK5G+JjY=;
        b=aJzUpOA1AMNt00H6y4Qijr7GYbA0Ltchf6Wo7FauzYYtNrSRLpho40cMg6NBPezL9c
         yEbGcgBbXhI/fVhM2KPhqJ3NgTvInTg14CDezzrdxTJ+yfRySaDTJegoYE/1C9bjiQsk
         633PWttLvAC44finYRAytk7MTLlRzN0LdrsvlezhZtMY2FAGxyRHbXbCycGAZ/bYfrRn
         1AHMaHpKsTRr4ZK2A/WsjLokNTEYkTNBW7se+IydKEVRlATOlRFyij6jQ+xDb8AIzIEp
         e8Su35h5+20MDq30+H/rwcNTAxQClgmmwPSFRiwde3cX1cyL3hICeOhBvDzvGXJLTbXA
         t5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719476436; x=1720081236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NmeEgQi4Hn4JsG/NYfpvNBRz32U8phyfHoTK5G+JjY=;
        b=Zf+IZ/LH6LXMTxLNDP4Tgb3XTGd/g16V5mvxUzHK3SMZY9VRWt+EVeVZhskvroAzL+
         AfMA27kM4YhBdrbvjdAaccSVsCOJiHvz49NzoPY12bhNQOHru2NWM0XqB+IKWVMawZZJ
         x3lXhJ2Xt5+RMQaTzYgX1NvRbA4pnw9zFjFNsUARawUCAFMryXtz6STTn6OIJvqOkmv5
         glkyWDBwjHmHutzWHkXCogTE0RBeT9sEgjUbQZmwqOtRoGInS7tsFmQSFa5YqFro+Z/b
         MbNVvv9TZBwuPZkskjHs3RvREk523TS6ukPm3s9tXw8KZ+arGo9OD/zSiw8vJoH0W1Gc
         K4uA==
X-Forwarded-Encrypted: i=1; AJvYcCXnL8Hx1YEbnJcOq0dpUwYRkJrN0ej258yirXbywcWGxqaexj5P6JcNbjRbfgn8Li8M0JkyQ9ewB7uXUai+lUCpxQ/TimU0iQ==
X-Gm-Message-State: AOJu0YyxPAfiHqS6Gh/L5+mqhLGMlFMyukjkJ96NSTwGHJ/5a2dm/1hm
	/kZDcLeKEnmDt3SW3QmjIE0OAwtmcGfRBLR0jjMqRY4v27z0xyS2Me1QsBykzVU=
X-Google-Smtp-Source: AGHT+IG5AGJCVfIoHkhCFISvPrTXKueL27XNQxLIzms++iZ81B5iEKeJwcF0qEHg3uq9e1DL4JkPgg==
X-Received: by 2002:a05:600c:4586:b0:422:1def:e1ac with SMTP id 5b1f17b1804b1-4256437b683mr8862195e9.20.1719476436377;
        Thu, 27 Jun 2024 01:20:36 -0700 (PDT)
Received: from blindfold.localnet ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424bb91c9d3sm54514005e9.0.2024.06.27.01.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 01:20:36 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev, upstream@sigma-star.at, Jan Kiszka <jan.kiszka@siemens.com>
Cc: upstream+xenomai@sigma-star.at
Subject: Re: [PATCH] kernel: Clean up generated syscall_entries.h file
Date: Thu, 27 Jun 2024 10:20:34 +0200
Message-ID: <3081086.VqyquhjGfd@somecomputer>
In-Reply-To: <33dbafe0-3da7-4065-bfa5-0fc7fe4432bf@siemens.com>
References: <20240626192625.14745-1-richard@nod.at> <4209190.8TcEBkooeH@somecomputer> <33dbafe0-3da7-4065-bfa5-0fc7fe4432bf@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Donnerstag, 27. Juni 2024, 09:36:27 CEST schrieb Jan Kiszka:
> "Any target that utilizes if_changed must be listed in $(targets),
> otherwise the command line check will fail, and the target will
> always be built."

Yes, but why is if_changed needed at all?
syscall_entries is in the prerequisites list of $(obj)/syscall_entries.h.
=20
> If you find a better pattern, that propose it - but test all the corner
> cases of required as well as unneeded rebuilding first.

The diff in my last mail should fulfill all that.
I removed if_changed and replaced it with cmd.

But let's stay on the safe side, I'll send a v2 for the syscall_entries.h
file and do more testing wrt. if_changed/target.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


