Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BD42BEFFA
	for <xenomai@lists.linux.dev>; Mon, 16 Jun 2025 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750085284; cv=none; b=QGHdBG2JXunPDSbxu0F5yAgWNtZ0UixWpCFLvdRnFPKX3/qA8xyC/tRauncnwu+NT2dBqEnmLyrTZRbmBXpRgJmgQQkJG1z9J+5MqOhmxFTPj7Lvcm+bN7KZz1fV75HXDpl9B5Bt7urF5dikaikITBXPjsDIyFbm8GWSTU6q7+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750085284; c=relaxed/simple;
	bh=J5FzWkUeB232B7N0sK4zDhFsweD1Tp3oEX5UQbNXS6o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LY94o1zt8ZfW0QbrMqCtl9lxCot6+RqWaOHewzRSYP3OtLjpaifQ5rRe+MMrxdLUBnR8fQPdn731yQOg4Y75tPkX7dtaHi/T0ZSPdcA7b32rBucUYjyqQA4L/O4w206vmFbSw5pW6ovSP7B59DbfUyystLSGELVJWZm4k48EWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=jGZp+ERu; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="jGZp+ERu"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3292aad800aso50766001fa.0
        for <xenomai@lists.linux.dev>; Mon, 16 Jun 2025 07:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1750085280; x=1750690080; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GXuZ8rNy9ICseDPZxNYuZeC8AyyGgbes7E9EUvxqX/o=;
        b=jGZp+ERuGu61sPvmBSvVWmIAZIpuOHboCVztRKuLBKTsx3Df+v4fCAcWaxbrEKb5bV
         Yi12yvR6Sv0iPaKm5YgprOaeLLFRTW2rdw/FLtik60NSFXoxIz1Ns+T+fMXnPwcltMFt
         9EwAojnL0Vnk9H+7pP+Lb5XI430AxBW7wFCVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750085280; x=1750690080;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXuZ8rNy9ICseDPZxNYuZeC8AyyGgbes7E9EUvxqX/o=;
        b=TwNz+OdtdVhxWPgXLrmdXFw2bWd7YvbbIN2q9vBwZarEWXXDfsJNCq5juvCtohynQ3
         MunTAEt6dynV7xgeC/B6LIExUq8DuAZYmBHjrBycWq73ROkyGE/OIAiZKKZWNnO1gLzO
         Uf9tsjDxjmvK+zst0Pd45kl4NQP7XFx7GVz52Og9Vvb2rNs+i1wIAWFFEDQKdUiEoPX6
         0v2AK4yV64t7shBz+7D0hpjyJ7JUVireb0XMz651d3veghLd84qsObzfqdryeqsBtoZw
         RjuHjyMSaV98ovWqEoEwqTBQr+mdDkiT6x2lmREGvqflqRAj8sl+VqrNBh3FzW/JMzx+
         N8iA==
X-Gm-Message-State: AOJu0YyVosvfl0PqsGP5Pa+9YkcXT8cpnA/peY995HiqjndY1C8a7hkh
	Pt5SlzIAfYjmjHMTEKLz69VaFtUew/gP148CEg96JSzrbIGlaeCtAgJMEmwX+xOqJdX4KSYf131
	JF2Ub1M+zKl34rtdmUwms/KrUGMWGdx+Ola762XQg9JtWttc6i/Nf
X-Gm-Gg: ASbGncscFYhArqk4XuI4G0hc6Aya8qcLDmFUSa6mXIMlUgrh7hgvqPFBp278+VfyYGr
	ukhb4lXUgvghDP/dTvZmNoZVRnzoCMf70g1/0Bq3mejauzFslQgTl+ZYZii3cUEc+cXOQW+APfR
	Og6UrB96/SzUI9nQhwu0FNkixdURbL+RZA+Nm7rbhFMi1Hog==
X-Google-Smtp-Source: AGHT+IHdqMmL5RL8w6MwNAWDJoSVZlAevbP4Zf5CNsCM5ZBK426+wtJnAZxMor8++/Go1RIiPU4jRt/t3UdeQzOi5go=
X-Received: by 2002:a05:651c:60f:b0:30b:b78e:c445 with SMTP id
 38308e7fff4ca-32b49520a54mr17101471fa.17.1750085279922; Mon, 16 Jun 2025
 07:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Mon, 16 Jun 2025 16:47:47 +0200
X-Gm-Features: AX0GCFvd9lg_PyJxde1fs9endjNHIKY0e3ucG4ZDOk2wMCgFzskfQXe-Vye_T54
Message-ID: <CAFc1U0uuOi0bW6P-eAW+i1WUKfp4UpWokdPi77HjVt3GyvonYg@mail.gmail.com>
Subject: Testing OOB networking
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi all,

We would like to test OOB networking on Xenomai 4. AFAIK it's only
available for IGB and FEC adapters.

What is the best way ?

- Building a Xenomai image with xenomai-images (x86-64 EFI target) ?
- Trying to create an image for iMX6 (not supported by xenomai-images) ?

Thx a lot

-- 

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
