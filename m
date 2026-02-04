Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4147839C64D
	for <xenomai@lists.linux.dev>; Wed,  4 Feb 2026 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196049; cv=pass; b=j/AkLhfjq3xhAkJyKkMym2IGXyWeOnOPHkScCCBVZx3MgolCr7Xz/YZLRjfrIuLXi1Jq8K4TZT2vCaTjwSTnNhsygKTZ8Uc87CRrMTrSYnZ8RwT2HAl9ioQ83PQyiQXn/c7y2aIf1uDqxUGDQdMm/6QvuywvixcYLHh1yN6Vjpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196049; c=relaxed/simple;
	bh=nYzIphIBlXQxQjSHUDEd0szzmIZSXezdZTA68oeNpUQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=J9j9s/nnEp9stb8XPKP3vQ5WBdCnx0Dlpc1cIllw7sH30RFmki6ivms7RNKlmHZIDBWkdkccYTyuEqshdVOBmf4UBcg3sQmNIZExaJYowx0E9Kri6wEfJd+wLZPYKq7faxpW550+MkbQFi9P9iKInwP/3dq6d660uIfiIEFrdFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=kair6y4A; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="kair6y4A"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee2715254so36047705e9.3
        for <xenomai@lists.linux.dev>; Wed, 04 Feb 2026 01:07:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770196047; cv=none;
        d=google.com; s=arc-20240605;
        b=TO5EwxDI1CG0j5Dnj+o5ip9PrXLl+/i2CTMk59wDU6Bh0SIEMiU9PRNQFBz1tM6swP
         nlHvg9kl0U8JgcZ6NOpHDl57opc4B0FxsEnKLJ0avGPept421yAt6DNpHAYtQzGkHpC3
         4YxSZhAZ1GkWfo8IQCaZVd1YE8936RPevpNilhmquvAykcKaMcdd8QW7am7pc5cZ1Prl
         oBQwJ4Mmvfen72TKSXEoFBItzbE/0jQlwHe2pJrPmGPeMuKUuKH2j3h99RchZeKfNHde
         Kz4w6tl4AGOOXCdp6uIehG2qupdu9EutXlm5ORF/qD4QEQ1yJbglssId2kfBa1XieZQ6
         xVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=qlVbClGqxjVYqnDrJA+KzmWBO4Kt4WAdFXIbZ2tDbkk=;
        fh=O15oOK5VJ7+HnQyR0P4j8h8E3vdYlzLasLiICAHXHME=;
        b=fagMofpB/sRVlFLuhpwcEzq7qJEYaobsJqbRVKOJfybtMBYXSREJrTOpApXo4JU7M5
         aWogo36AKSlEu5MZbLwboCpjfvTkapCVn++9VPyI4r0ONfXgKyM2qwmae+XvLT5Ni9EB
         EIk6yQuywbEklePFs1e2jN59DpcyrChkg1nkSAO6BBaMSjdeoV/n8ZWoODV6QY4U1g9g
         VUfkm9xe0nXJuRDGwhc0r2QShnResiNWfH4Rs2Q0SSsdB2NUAf+3+WPTg9cSpcCJi4SD
         bcb8H18xPtO0XqmsWxiBakcaiH4tJXrvj9jMKHsZH/W4tnC3A+HzBfTFv7wr3v6Pe6nk
         kQPw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1770196047; x=1770800847; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qlVbClGqxjVYqnDrJA+KzmWBO4Kt4WAdFXIbZ2tDbkk=;
        b=kair6y4A+Y4IgEFF6UgPSBGI4yBHx22Gbpx8Fel0isLgA8t/sQY0BfprusftIIcS/1
         iX/VF3FzDqhqJOS0xdVTVjF0gzHdiGQRiG01YZ/SoZVQbxBoXhPPfCswPROHhLxZZGjX
         dVt6SGoyNQ1O2YVsU6mmuVATY4xkVwFyAGSuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770196047; x=1770800847;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qlVbClGqxjVYqnDrJA+KzmWBO4Kt4WAdFXIbZ2tDbkk=;
        b=oVxgSrjBhHhFoTOT/HaKgnHuqgDbyvFaaBCS9PfdYzocKbFxsMVC1cG8URVI/XtLSU
         /oOVMnwvpj8hhYIGxUY1Ym/JpvOnnDHxHaAW/ujquj2bw+dFe3l9Rd+VATMAmC/TQa39
         KV0iPBqgUO0tKuPA833rh6DAoJpAUx5wnmvZVu/r8TTSZIAzoYCxhTI89Crl2ke+Jh7z
         8kWhbUIF/Dcp+ckuTWqduIUa9j6OgQKmT+iFxTaSrzJbaNRxFC3NRnc8PgBRhZdj9CGn
         2gvW1R0blFQy2EfnW7+Lms/RZcY6RAqfJcVYQbw6aN8KhNzNCZRupW6cAm+GuVvIgT9l
         72qw==
X-Gm-Message-State: AOJu0YyqwXFsYQSca3eKJGtpCNbYojec0jM4GPLCn//8BLkQtnLF0AMf
	KR04Q+Uivm/vLOYGeKVsZw433hf3p4pbmyYV3tJIUTb704q6UbXrYzHcb+QxoxDEhrT99zYQqRf
	e8vE7SEYcxc2AnrWEyKkYPFP/WoOczIKSuFHmFEQqBSIR4GD50FB0
X-Gm-Gg: AZuq6aKwE7D1uHz5j7J8KO2KRRLUZ14pa0tlFEzf5XIraUiQrGb/L41KGVZ8NBRUWst
	0gOfsLGnVZuuJwyZpTV/BnkTTxJnXYsH7Ir4niOlupFZnKRIu92KLdDYnCvP2OOU/2GT6kW/LNw
	ZJqaRDfVp2zlcwQLWer9gY7H3PKLZhdo5Idx5EQPHkLM29ZUj7QBtDPStR+d7JXvN/9YdZWqCNL
	IQqZm2jExn/BmWU0L40ZfsDnejUZSPfCGthIRIHp3Vm6nb8OG9lgFrA/Ew/QkrnfHChRo7A47b2
	pa79AdLcX1N+aQYdwc5rrN3LS40FArVjudpYtTvTdOEdfttAcOnrBEFGnGTw3kXu3xJKKIQTwwf
	7EOfDcdHQkLcLuaO8vQOkHeHpYS8=
X-Received: by 2002:a05:600c:6748:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-4830e99b49fmr26920435e9.28.1770196047359; Wed, 04 Feb 2026
 01:07:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Wed, 4 Feb 2026 10:07:16 +0100
X-Gm-Features: AZwV_Qi-b9hSZ84C8WmF1WZMWbjbCXWBgn6UYdwiRiHAUlksFiFEe-CcZBJ8Tdg
Message-ID: <CAFc1U0tiZrh_GZAahX8_PRJkGPVr8_UAfdtv3GisRn01MqM+cQ@mail.gmail.com>
Subject: RTDM driver for AM64x driver (PhyCORE)
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi,

I talked about the subject today during the community call. We would
like to use the PhyCORE/ARM64x UART (which is 16550 "compatible") with
a RTDM driver. The 16550 driver exists for Xenomai but will not work
out-of-the-box for the ARM64x. There are several modes for I/O access
(Port-based I/O, Memory-mapped I/O,  both) but it's not enough to make
it work.

Is it possible to get any help about the subject here? I know Richard
Weinberger has a very good knowledge of RTDM and maybe he  could help
through his company.

Thx for your help

Regards


-- 
Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
