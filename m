Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E8A1BF58
	for <xenomai@lists.linux.dev>; Wed, 16 Apr 2025 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744807111; cv=none; b=P7+Hpkn7vMBbCtKwHFOowyaYGLsLikCkXIl8UBG13a8o87Vd080O+xqnLwPQbT4/wzD1ak7GhSSLCnf4ejI6kFKgl91L+cJmlsZ5itkVwGFGJaf7TZafDcZHzTnck2u7UFp2CTlpBkBC/dWlXfLdqj20RiVIyjB4sg0CauG3yMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744807111; c=relaxed/simple;
	bh=rjqfrqpzXO2MAWfl0SyaQ7n+q8Iyk8b/ZbuiQmFWJuM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=EGykb4mxu9Q25R7EEeHDtf/rZzvkfImL5xgcCs/HKhIGBsTMnFrTHc5TrjJv5TG7yqxPn6ecWRMcvFHfJFrtC19ST6vyDdGK8XKXMVrgKTAHPHuVktij0QV29EQ/gfFKBsE1GyKAvoTZXuVlC+iUYiHA+D/C0BlyZezVO332U9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=VgEbk8EA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="VgEbk8EA"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so4181701f8f.0
        for <xenomai@lists.linux.dev>; Wed, 16 Apr 2025 05:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1744807105; x=1745411905; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rjqfrqpzXO2MAWfl0SyaQ7n+q8Iyk8b/ZbuiQmFWJuM=;
        b=VgEbk8EAC/TdgkOnxnuc2DzcxMkAmfhlWaSYdXekMfB2ZpOdBFwtBcBxqSRwZyxNLd
         /lJ69l8Qn3vV1i+AojNM/poiCr/DkKyAK7NMADLCzvxJEzs3ZeO2kZTmdqGV6jedPLSd
         2Ij3qOLQy+2bUt1wF/2Xi1XF7xdq48gjYCKxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744807105; x=1745411905;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjqfrqpzXO2MAWfl0SyaQ7n+q8Iyk8b/ZbuiQmFWJuM=;
        b=AypGmC4nIP/WNOw6CwRezM2zxhtJCwO+GyWKj8EzeL4ggbrHSSTqcxA95rSy5IAw8R
         TS6tDLC/wQaLLsRhWJMoaWarvrtBdMOcBDhJe4WIks4sAwY7QuXw28XWya6r2CWs1Lpu
         XOkElXGrdSQFQ8eGhCUiBVuVGljHOCMMiI2LzYqIipGyzNd/LV4ktQOBQ4JMXV+CZV8C
         9EmLpaNcM2ZwnXgL175shkH2yNmQWS1/H6sQueu7BjvQQPOEOLLLCLZNuLwZ8DibJptO
         tmMXhOIq3p3dtHAz1GP22Hjz/9SqxtWjTDnqUPw8VNkAZnXU9mkIKjuQ6PErt7WPued9
         FxRw==
X-Gm-Message-State: AOJu0YwghfTB6HJc0OdLwwpWGnJl6Z1fafo3rQTNgFY0w7p8B3YKq5tv
	eVYeZhVXOSNQAEXH6I9+GSe9LtPCf4XpmAQK9grrJwJcW+p/FiONt2+jQGFIZyIqIya2CxSm+Z+
	r5yqeJlJMjRK/gVIEj7VTJt+xykFpixIiAyC+ZNy/S/I/VcJoo/M=
X-Gm-Gg: ASbGncsVIN5sh8xepFmLfRe/4alinUydx2S/OeBtn2Cobpkl9Qp2rA/Nr3Hjv1p9B6P
	xGWvQETtoQ3rWRNaEm/YwISnAv+Ibkm+BKGiALykbpGzl9RZXtOvEdKEAdBrpvPbCsFkLUhIEUO
	lfcCHZ1bbUdbGNJspcXn9Nj+kE
X-Google-Smtp-Source: AGHT+IH59MPBMF0A5wt3K2AiHtI0JUkIJhbLEi2qGCqFuDGtjVD1FMvXmuLuU8RnxYfOkQPlPJygg1fj3sXaIj18U4k=
X-Received: by 2002:a5d:47c9:0:b0:391:2f71:bbb3 with SMTP id
 ffacd0b85a97d-39ee5b9957bmr1444816f8f.46.1744807105571; Wed, 16 Apr 2025
 05:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Zoran KRIVOKUCA <zoran.krivokuca@smile.fr>
Date: Wed, 16 Apr 2025 14:38:14 +0200
X-Gm-Features: ATxdqUGCX0MpO9SipYkpnsL4SHV4MX9zKSbC38PgBUv7LqcdR_gFtgjVzB_Zhk8
Message-ID: <CADjXCUdi2vswJNN8n2BWtPgtXu_ZXDrAD5qTcNNh=ovBmw=-yg@mail.gmail.com>
Subject: [EVL_XENOMAI-4] Consistent Latency Spike at 4s on Isolated CPU with
 EVL (Raspberry Pi 4)
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I=E2=80=99m working on a real-time application using EVL (Xenomai 4) on a
Raspberry Pi 4. My application consists of a single EVL thread that
toggles a GPIO pin periodically using an EVL timer (evl_new_timer) and
logs jitter values. I'm using mmap() for direct GPIO access and
evl_read_clock() to measure timing.

The thread is configured with SCHED_FIFO at priority 99, locked in
memory via mlockall(), and pinned to CPU 3 using sched_setaffinity().

Overall, the jitter is low and consistent, which is great. However,
I=E2=80=99m observing a recurring and reproducible latency spike exactly
around 4 seconds after starting the test. This spike only happens once
and does not repeat afterward. Once past that point, jitter returns to
normal and remains stable.

Could this be related to a misuse or oversight in my application, or
perhaps some in-band task that is scheduled to run at that moment
despite CPU isolation?

Thanks in advance for any insights.
Best regards,
Zoran Krivokuca
