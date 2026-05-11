Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869D44D98EA
	for <xenomai@lists.linux.dev>; Mon, 11 May 2026 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536165; cv=pass; b=dN6pQJLD1Axd9ycvkRMa4Fk9eMbObDIqhaU81abaTqZjro2MepH7pJiNQ9tyRVFzjBS34zPcNPqTQvmuTgREMj6ZkfeEzZxFSmwPtzoCpj0tSCeDk1fT1vHt19YYp4b0UVVJGQrGi5bYDvzJa6gvQrFboRplIXoVnlzQOWxluZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536165; c=relaxed/simple;
	bh=ALqT7ozhvB2Q6+T2ZJpXKFZDb0OH93ydG2h6ETFRyG0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZoebO5B9yuE2DwEEu16cHg+/19nVl4gFywoix8tcASGL9+OGtaPAqu+ypeCjxBPa2fP6KeFimSijDJ0dKbwMS6oReLkybqkCRJMQZSVNPvQ7O1Hjtm+jsuZDu5zcYPVrbP4QiVZD7bFIUN/SZGuiD9oT8wj8dqi13mRGRUnVv8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYvT+ojY; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYvT+ojY"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b9705613ddso29727605ad.1
        for <xenomai@lists.linux.dev>; Mon, 11 May 2026 14:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778536162; cv=none;
        d=google.com; s=arc-20240605;
        b=BKRW+OscN4VI31LRwhXum3EWc9KUdWNdEmitF3zf/rUq3B2rI9ryri1yBrXVSXZsFK
         /ksIoVMYPlHS3dKEG48MfLUmWR/3jx/MydIgcjK8Bu9+Pz0yB6FeVSar7V1PDBdUAZsF
         Be4C7jp2KzfIl9CL4ds3HTOy0THX/TNIE9HLbd07B4FRFVMvJPBty9bAzgzMLVfMep+C
         cmmJsy3LbOVxl/WDghARcb5swiep9XkTWmrO0Z0eHBKebqDyWuusgFDKCTxjcwMRQMg4
         qgtC1xp9rBibkyiffDHVFdvQfkZG3/98Y/oHvB5xOKJ0jlqL1WNIUfG7TU0T8xMLTHsb
         oGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=jq6ytAf1JC1WQ7oZPFABqaJV4SQrJmXdKJTouZOxKTs=;
        fh=O15oOK5VJ7+HnQyR0P4j8h8E3vdYlzLasLiICAHXHME=;
        b=P5nxzByJO5emh+CPlXkq+BOTJxsdWE5+kxQrojwPiOrWsxKSDQSIPUKBxHgGROZXEd
         vTkwW2lp6xMbLKZBcZ8rl8G7Of9Zg7W1oVXITy1sUfulPVrLXrfJt24OXcDMW4/MtfwO
         XLjbvs8JWZP8h3YiLXR0306sOiP4vkH3x1ChFpXJDB8UMZgR0sNay7MWf79gvtlD9b00
         amR9f+duvbcZRwOZytiayFm7MX4iq2iEVBfkhDMu2ba/nB94QZBtaCLycs8WtXe7FVQd
         ui8G0chxBWx/geMyZRb+2Er/L2taM+xdN3RXPil/6RY/3tLSyXnF8T1gQhbYnu2+ZmIf
         Z+bg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778536162; x=1779140962; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jq6ytAf1JC1WQ7oZPFABqaJV4SQrJmXdKJTouZOxKTs=;
        b=PYvT+ojYZ6tdHWxsJZOfonuyZloZmgQCFSrB9/5Crr65aFMBE10w4oi5Jfp1elbWXj
         6Dcy4JamEyPGv3/IxaDBk3iMJx6+XNpketCrNFV2/mGlmvglXPhvYKWuGi5RMA8cImM/
         WxzyiHGfpc4vB+OPByskaMhHZWV8Z8EfUdfqek+KK8BO4jXJiHZD8PAw4BW9PQlS7QRY
         1fEypVp7N7ggl/tuoei+wem7vRcQp7Sf8eAliyWEFW2c2xYmuuJITEULxGaNRckMBCgy
         0L/5CVPDDbgloP+Y2G2KzK8c5TtfMsAarRbaC/d+7NnnFeo/NFQrxaRgmXpMh057kKqU
         O6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778536162; x=1779140962;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jq6ytAf1JC1WQ7oZPFABqaJV4SQrJmXdKJTouZOxKTs=;
        b=puRuktWqlfWsfy18BfO4ZfFvea9jJBDeCiJgctUfSzjUTbvLQO4l0s0dWSEiVRFCLJ
         zp9QEfxasi6TsnP39xVNursT6z6oorqXOYjBse4ed9ILuHr42pvCrN6n9QtgnWnLYaXo
         nNl7d5gMltoFtgpwzbg0F+4pHyggzlOEadyyy2cKv9l/dsPi8QO+ZkRui1BQm+v3dQIZ
         Yhh3T4BaAtq9IsXDZCZxoeFOxPoe+A8Vlo21H/0tSHpZ3X0jb+9FEBSHUS/Bx8p5Ox12
         qM9GAxOMYKc9vDvT0QkCiczhfiyEyG352jsVS6KxoaCKrQ0dvYnf76O3tOz45rfP5GEM
         plRQ==
X-Gm-Message-State: AOJu0Yzsz3Pfki+/PLzWLWxhSJzBtHQof0YR7pnvvb98VwpocwbrOhoy
	dtmIOxHG/vkUec/svCsqbsOBxfv4+I9YvZsaiRFkC9A3X8x3ymZNQYn3eg+bFYjS2aNrF4Mx4lV
	q2YdF2exbExYpquvyZJlnSAzJXYhCRkwn5frz
X-Gm-Gg: Acq92OG6ACJ6FuseIBLAD+jsUthoB0wLIDiNNhbDz/NqqBG38wHbEVZkSE3lCab1xoT
	CjCgeDtPh5eEIORkqwQm6v3p2sqA5sGj1SnFDRMnYa89Zoitwz0ekvjVEuyFlOwiP1DetURPQIt
	nwVmQghRzHqOHlp/fd4csjuFdthMtPiYmWKCkOGWJ+j1/GOoiWgS8jKwd+SiNqqEWqY0Sbf65tf
	f0CUgaf7BI4Vn7/Jba1AfueKIrLNUfrtAj0SueTnDNYRwZZUszbsZdJdx229tMGTkQ2JgIwECWH
	upPJzC4=
X-Received: by 2002:a17:902:cf43:b0:2b2:67ca:5ff9 with SMTP id
 d9443c01a7336-2ba78a4564dmr258968195ad.0.1778536162295; Mon, 11 May 2026
 14:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 11 May 2026 23:49:10 +0200
X-Gm-Features: AVHnY4KAN1o5VLIYrV8t89IsibXx5Q3lj1Z9nJUjb1qU1cqXam2-F0rWeV5MlK0
Message-ID: <CAFLxGvw_cRpJbBKg2YG9_oi5Bv_DU39OB41nPyJcq7hv7hK6YQ@mail.gmail.com>
Subject: Spurious task resume due to SIGSHADOW
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

I'm currently debugging an issue on a very old Xenomai system, while
reading the source I noticed that the very same issue could also exist
on recent Xenomai releases.

What I see is the following:
- A task gets suspended and unblocked using rt_task_suspend() and
rt_task_unblock()
- In some cases it happens that the task resumes to execute
- It resumes because a Linux signal is pending, being SIGSHADOW

Since SIGSHADOW is internally used to suspend a task, this alerted me.
So, I suspect the following issue:
When xnthread_suspend() fires SIGSHADOW using
__xnthread_signal(thread, SIGSHADOW, SIGSHADOW_ACTION_HARDEN); nothing
seems to prevent the case where the target task enters the primary
domain right before it sees SIGSHADOW. In the next step
do_sigwake_event() causes it to resume instead of sleeping.

Hmm?

-- 
Thanks,
//richard
