Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC16441C68
	for <xenomai@lists.linux.dev>; Sun, 14 Apr 2024 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713128063; cv=none; b=A9op9q7HMsCQcUPZ5SmccbzqhMtxpzzmx7wdqKIEmXwbYB2LWb3gSpUEzzwrFacpn9SsMBchDNKmie2LbiKx1kQycjjjNOUOwWytFfhGhVVdYMr1Ip4QBV2S2eVGb1wHkyLmqt8iJNcHatvK5gDPttpRaOyZzWp7fyvRAUIlMGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713128063; c=relaxed/simple;
	bh=mgp+zdq7eXIG0/X+09sX/nRvZsN0eN9rn8++Iagqokw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Vp/NTdEnPfyApiuvHEViw7XGy4hJ+xQ3Z+4N0n/Oega3qMqPiKmz9TWNCNO+N5mNJOdLlwMw+2/aKUdMMv7tTyX7cqV33K3Q9TAd1qT2hB8mKtKZx4gg4o2lfiXm1QS3mNqr7kYwYIldxhTUdC6v7W2npX9VX9vsh3CCQ3ShEFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moU0Vx3d; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moU0Vx3d"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a58209b159so1320083a91.3
        for <xenomai@lists.linux.dev>; Sun, 14 Apr 2024 13:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713128061; x=1713732861; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=94k1B3qs7RyMxZ7Jye2KIIeIuQLCGJ7Q0QCk/YVbhlI=;
        b=moU0Vx3dJH252Dj4/bqD6ekj1AucGjbn3L2r3jVAeK3RzanzVWPymLvkE1X/ov9gXD
         IdqZFRhbvJzfvzCrOMIWguL6XQxOu1t76wH4f2cD7qQD0k7AFVbHrPmtJPhNr6S1VDTV
         viuZABTXrXXQw65Cxzlnlsg4Ridjz1GYZJV3AyZ958ek7Ys4+LxH8R8psO/n9l0Z6kEF
         /Xp+HsXqnHnvaPFPdf/zixeyJp7ejrVwF/xDYwnXcePCGNflcgBgwuH4YK4AzVGL+QrQ
         iWP0DSPuKHaoVcv/TcmJEEB5Hn8KJw03PCmBwatJSsgRKs+qFz5U5GF9se5Y43UGJNL4
         ZOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713128061; x=1713732861;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94k1B3qs7RyMxZ7Jye2KIIeIuQLCGJ7Q0QCk/YVbhlI=;
        b=sRBC4jm8UfoUkQSNWv16k9Bi1niycw1N23oU4ZYI7qoicO8H5Gs36+mgN6YXFZKPxv
         0CR/CuBMoLeSQcY5/c7qnDuX+LGBGUHub+lNvwhiL9q+Fka3C9NRMzFQ8cQDXDFIgl2O
         SmO7mQWNZwcuwR8rtt8m7Qe1xTQZ92wev2gGvgajvxzU5jO3Rvq2EMCoRL1dRXYYANT3
         c0rqD6kiuD5bacwkJ2GZxuWnJUScPzSP+If6AtKxgRMliHdWPFVpzfOJJcDTol5Yv057
         Zq+IqdKUe62lbv1isU7/VUYrKcNumxu/7Fg+ImnAZvDl402nxD2cP3qHrCDASJnhNR7V
         KchA==
X-Gm-Message-State: AOJu0YyCAaOdZJe7rAraETQbsA3Z5CsO1D427VIDpjyr9PG6OZk7Q6Qc
	eKt/lDeD5NGhSmOzyYVlMJkLTkL8CS3Rur2bHC476lSrA6T9GuQ1hrwtL29b+Yuus7OOn5I0NBJ
	XXZ+oEUFMNndtF2PA/mWB3Mv3ZFQ4JqhH
X-Google-Smtp-Source: AGHT+IHMMCLXs7LTEbdfen/RrK0oYpULR7jxzI0gCW4ehqm1OhRCB9MbzjAbdJgaEtti6KhNoZqwahODaZYRMaiketI=
X-Received: by 2002:a17:90b:4d91:b0:2a5:457a:8263 with SMTP id
 oj17-20020a17090b4d9100b002a5457a8263mr5416046pjb.19.1713128060911; Sun, 14
 Apr 2024 13:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 14 Apr 2024 22:54:08 +0200
Message-ID: <CAFLxGvyY+T1qQTq6gZ5UKfbZsxcan8adyj-Y95BCEA8SYe31=g@mail.gmail.com>
Subject: i915 GPU woes
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi!

On an Intel(R) Celeron(R) J6413 4-core system, I've observed the
following symptoms:

As soon as an X11 application redraws frequently, real-time
performance suffers. In such situations, the i915 IRQ takes between
200 and 1500 microseconds, seemingly blocking the real-time thread for
an equivalent amount of time. Since the i915 IRQ is a) on the Linux
side and b) pinned to a different core than the real-time thread, it
does not seem to be a software issue.

With extensive tracing, I've noticed that both the i915 IRQ and my
real-time thread stall when accessing memory-mapped IO (the real-time
application drivers an Ethernet card in userspace).

It appears that the GPU is doing something that dramatically slows
down MMIO access across all CPU cores. With graphics disabled, the
application runs smoothly.

The following i915 module parameters are already set:
i915.disable_power_well=0 i915.enable_dc=0 i915.enable_guc=2
i915.enable_rc6=0

I'm currently using Xenomai 3.2.4 on Linux kernel version 6.1, though
I don't think this detail is very significant.

Does anyone have suggestions on what else to try?

-- 
Thanks,
//richard
