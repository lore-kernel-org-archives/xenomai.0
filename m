Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FCE182DA
	for <xenomai@lists.linux.dev>; Mon,  3 Jun 2024 06:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717394700; cv=none; b=RyROynO5g70sP5no+6N4sCgyvzfzjEqtgSj3f/Q2UZN/AG7mbwTgVAfyA481YQ9FdDFRqXOfmUBMDsLMk+cOKzCm4cwQe7VWsOoJmotXXp3Vjt1K/ZZNNzBxydNKtT4KJSlCz0KfFTg+t6ILhy5yuaY5fgyicP6qRZ7F2bfQyAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717394700; c=relaxed/simple;
	bh=2DgD21cWTfYSmeeBRU5loKjsyHtYtOVizH5AmrVO1J0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=V+oZkYyD7chGF4jThsilvhQqjyXwsES7/aXO0m/bRrnxRmhSF1Tda6z5m0PSXZ/EuV41yhZPyjtT/LjC6sFDSQzwUgiTcWcUR2A74y7Sshy5tR2HaBGljy0qs2Ls6SqJkcLOp2JsjaXl+xWYjF32/zRsBvMyPjkkmOHC+9UWRho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJ2kkgcT; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ2kkgcT"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c1ab9e17f6so3015809a91.1
        for <xenomai@lists.linux.dev>; Sun, 02 Jun 2024 23:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717394698; x=1717999498; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ce/EHaQp3BXgvdkB3CeMzvtK0RaJ+N5oaawnoKE/+eA=;
        b=CJ2kkgcTNVKuaxkRwMaEq6Qa6C2tyYEyko7ZG6G8UAyXMrCzjD+mOe7s7C3vWvCXaK
         8oVeJ8Brs+4iaJRfMR8LlQu13jM0MV+jDgsJgNwalG20pSLo01U0Tc52seCKGKlCPFWS
         GGuzX4BZ0dbmhvVTNEP8h5lUQgQoc4iJkuLVMx07DZK5z35EIoF5VOndaj309aAUMD68
         zywM99t4wLgaUcHu9YKCarKSNuPQRLNX9SSVtec7cZuSo2Jk1fcBYQ7NSGrQru6rEkOZ
         Gm2tjZDhx2QyeK7lw73IFKTGFQpU3ftLM1fAZDCjYIgRRKjE85G7KfWqRntu83VFowbm
         qkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717394698; x=1717999498;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ce/EHaQp3BXgvdkB3CeMzvtK0RaJ+N5oaawnoKE/+eA=;
        b=Ir/Kg8TdOMjm4qL65Lt9P5esoNQApMhgZPlYc04vlXaDlv7kl4G/hNBivwUXg4rLPZ
         bY6PpjBLl6nB76kgYnjhIYxCI4TQnIXSLMZvbb50lTZ93tRgTCTnCmnbH2YCy2EOfwRo
         RYjHeSgWepMidbEh7LwnItogdSah3wcw9vgJ5rM0M8CZ37xBhDrH49tJ5Y31nGtetx4t
         h2+STXtIfWtceE2QQXS2xlgbT0FtTKbR2IN2kg98GN5NT5L48zx5vmw2TRtV4S/QyzBV
         bpvHk/EsA6YThS5IshYHFLsjHuKESb+fdXGEQevHyjrYG3hNxkT73GKFogsDu7GK1hex
         Ovkw==
X-Gm-Message-State: AOJu0YyZ+c1gUpMI01dTOwmxmV9Mugxgku9+TrwAT7OQ85a3Ad+LXPLF
	KznpN86Bcua8IBy3SnV8FTu/yZuVYn49oMrFKGfjimoCaIDl985Z5lfDodqAniizLYJf95kaFj6
	50aj0w7FwsJJJAF3R63NCqtb1YuQ=
X-Google-Smtp-Source: AGHT+IH6j5mBAF0aVTVmFJVeABwkvwQ3GjzXPWokT6N3OdCKrgI6m+oF3OQITHVCVBY5wC7ifjYwvtln3Mos8kl6pEE=
X-Received: by 2002:a17:90a:34cd:b0:2c1:e486:c9bb with SMTP id
 98e67ed59e1d1-2c1e486cdf8mr6769443a91.21.1717394698078; Sun, 02 Jun 2024
 23:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 3 Jun 2024 08:04:46 +0200
Message-ID: <CAFLxGvyg05sVMh8=4G0jh6poYfzd_pdBmjYNxLwWW8kQqaw+Qg@mail.gmail.com>
Subject: Prefaulting memory mappings in EVL
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Philippe,

while digging through EVL I noticed that there is no code like in Xenomai
to force prefaulting of memory mappings. (Chances are great that I'm
just looking at the wrong code/docs.)
How can one make sure that a mapping is fully populated?

-- 
Thanks,
//richard
