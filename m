Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF01319ABDE
	for <xenomai@lists.linux.dev>; Wed, 21 May 2025 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834830; cv=none; b=tIudKnq2kqUfbvsB9YKNgcAS0QLmXgZeKGUA0Xi/5+QZ5U67ak81LkkyQ6Inr7fCCX03jjyhQFI1alk1HdDT3uGwex0wcDmk5eMkImirXzEU4QD1TBNajckwNHS5W9wto/u/lyIKlEsKXwHHIN/nD0POGeRZO+CpYF9KKrKB8UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834830; c=relaxed/simple;
	bh=S6bw66oSKbltKIL6uJA3stDCKFSY7+kCsQogmx96xko=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aMlxpD4+MzMuYvXE0NBjB4wCJ+JYxb9mf80U+wMW+zNX2jbFNWqwsQXo+WPJyvPZ7Cea3mMz0olt2lGvcpfagTfa5SwmHf/pCpuGg5PLnBDAaZZOHbFK4CkfuQSZCzzHZagwH6u76qkxfIygCZ4j4iWNmPdH/KPA/u8VXcSJ4o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfUKFUiZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfUKFUiZ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74068f95d9fso5976292b3a.0
        for <xenomai@lists.linux.dev>; Wed, 21 May 2025 06:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747834828; x=1748439628; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HvzpIJD4jDQBRuphROYvz73PeGg67BBEx3icLHVkelc=;
        b=HfUKFUiZpZ8Bl8gwLP2LmNvQv0v0tV+zyyXLFc5lZ+dqliANo83kBV5vfHvE1opdpW
         k1OCRZKKuYDEEpN2YV3BbuKI387gdhuDEngfRAcyuLEF/oWri6CYUqR38o/o4t5cOJ5v
         4zoN2NTykPKWASl3kW210lSibJu2C9LbJYbe3sqfJ0iTlL5uSXYmmkDt6G+UD/59zJPr
         hdXvAvQTKiFhhhvVHkAbzOMVN4zGbaIVaJ9YiMp6E07f9phOIFfdtRTle+/d7FshNwXb
         n6Y7WD9io8abdfdBmasEym7idPb4EPvm/J1AWHVZM7DDifz8UQdAgFXMdytcn4BQRXCI
         DuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747834828; x=1748439628;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvzpIJD4jDQBRuphROYvz73PeGg67BBEx3icLHVkelc=;
        b=AYCHO8TPd41w/3ABJE7Dn9Df0EsS6HsovlU27lmbB3jO/MK4E5EB3iBoA5p86ep2ep
         SRiJzfjquNg84T99FAsdP+iexPspccPsLfvjpBezhpDfQMCT4T0buzn/wUBLMxWWVihH
         cWYrpwKMpCirNRF61ap/0xhJgr8V5ppBo+wgrtCj1G3fghAM7nmN6sWkn/b2OvMAALqG
         Npgs34B4SLWQIGstVQzQiQywBF9Qbe9Fn7Ud+utG1+3uOUmSlZr5HMKrPuOw73Me221S
         6RwaPcwFQzt20zYZDTegM8CC68d8ob+wNmc7vTRdjA+ywIsbY/lIeQTXRLTxMZuhmlaQ
         MDfg==
X-Gm-Message-State: AOJu0YyLht1uuPjiKFIejKzldQcoyTLZNVAZdO3BQ4GhM+2EV3IUWtR5
	bfC1viw3eQ+tLll83J5nv3vwlOBXs4dO11BQDPI43IUmEA4CdkxyNIB81LN038ZH0kAAxSv3+yZ
	toWeJgswNg+COfgZS8Zw1eocRvr/vvlsguzWN7Zs=
X-Gm-Gg: ASbGncvHu7rrkslHY7EQldBSa8toZxw8ov/SxFMklAaop65OpWC1hJTCTuyL7ye7M9F
	DMvxdKGOqhBwNim49cf57mfWsP3BvX/9+ra4mQkyoQRmVOeTXEQ2ZM7IR6NrtCwcdJ6ylUx3IGS
	EPOExRY7vx5O6KtjWFUHUYTtvXlxHckL4csQxJn+s=
X-Google-Smtp-Source: AGHT+IE+UMrnpKWn0BSwk4uxHfaD3QGUU5V0T/jZGWBOD9f74ZRyBcaJTbGMQPpTgYZeBhRcpOBdR3xL0rtClY9deDk=
X-Received: by 2002:a17:90b:3dc7:b0:310:8d73:d9d9 with SMTP id
 98e67ed59e1d1-3108d73da51mr5563742a91.18.1747834828109; Wed, 21 May 2025
 06:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 21 May 2025 15:40:15 +0200
X-Gm-Features: AX0GCFv4fb8jxcvXqEo7gAGFggdAeRsHIGg4YCUaqZ06N8VmqxO3lO5AE416SfY
Message-ID: <CAFLxGvxhk27ps98JL0afZx1+iecouV2NFsDHv6Ccp=zpn-yESg@mail.gmail.com>
Subject: schedule_work() from primary domain
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hello,

While debugging a crash, I realized that calling schedule_work() from
the primary domain is not allowed.
That's why we have rtdm_schedule_nrt_work(). So far, so good.

However, it still puzzles me why exactly schedule_work() does not work
from the primary domain.
I always thought this function more or less just appends to list.
Is it because __queue_work() makes certain assumptions about the
interrupt state?
Like here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/workqueue.c#n2242

-- 
Thanks,
//richard
