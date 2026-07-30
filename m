Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4404543C7C4
	for <xenomai@lists.linux.dev>; Thu, 30 Jul 2026 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419864; cv=none; b=jo6T95nSKlNknKcfXYjxTt+86KqSEpj1uxcI3a5NtnJW9X84UZBRr7DttSDHog9Fsc8a9yAeUAw5bwqd++Oev2dzPWZJw7Y6s7++1QavZ+FMZruTVnu/pXMozR8MrqzDfONdURlhLT+DquYAlWQXvWVQz9YslHrybOYso86CWTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419864; c=relaxed/simple;
	bh=jRyTYEMjV6aZhR6CvAnxxfLV87AQOFsrCWHYNrf5q6k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X7XwrM9ZgVvbExBHAP33sL5SrH9DtWdBmtmuujJZb0XM+bgiab1jCeaDj3b1rO13Qow313y/fh3Ed6SKvad1u0ljJ0bsW2s5oSj7BlQpBzSJoATvDSwqbiRQC5HRqf9IO73G8mYsGInbkMjpitgcVbrWsGijV1Bq6zDDKkNjSNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=fOLn+K4X; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="fOLn+K4X"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 2E3AC5833B5
	for <xenomai@lists.linux.dev>; Thu, 30 Jul 2026 13:27:47 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7BCB3EC2A;
	Thu, 30 Jul 2026 13:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1785418059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyRqIzQR1CkxllDjltCdT2ahJ5Ei0s1MyhIFJNyZOZM=;
	b=fOLn+K4Xn49ZpY++GuHDPBDme65p3rTUgWjhlmVDbM6X5FAW1PcVwGQmX8PL6PX7Zz9YTZ
	Byfg87V3xtwsVkGGIP52t6FxxM5ta4+wzuCFLit9FYqDFFWAvsprExv2sVM8W6Tk5LnWRL
	pO9iBuN1CfIToQrdc0Uj0ykUpJ3ZGtK/JhwNyuYoImLXHk7djmqhZAWvWtc/KtcVuJs1JO
	YvcmVXKqpUqftjYXv5NjSXt7lu8Yo38iZNMLTLyBd9UlbIxyoPi0tHwK2BSoRfoPnNKuc0
	4jjQKJmNlfwgdYDKKkRH+O6I6A34md2CUeEDpWeRgsgpkToKbW9qDpZ69Y4KiQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  florian.bezdeka@siemens.com,
  jan.kiszka@siemens.com
Subject: Re: [PATCH linux-evl v3 1/2] riscv: Add EVL core
In-Reply-To: <20260728111305.2699306-2-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Tue, 28 Jul 2026 13:13:02 +0200")
References: <20260728111305.2699306-1-tobias.schaffner@siemens.com>
	<20260728111305.2699306-2-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 30 Jul 2026 15:27:38 +0200
Message-ID: <87v79w8v5h.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTFExiSM1Abm4tlqDFkMIhsOq42tdCbNFH7vmSUihqaqImWHk/4JdmtWuDWEMgT+uITf/Gm4Q9IYkvyBy7MgNBJA5FzWk1OodBqNorcWeYFFAf8hPPyJaHVp0NgmrowdTYyJigjfmMyS0IuUMqqQss8aVgDACDS/0nLhtCctZE8SUK2ZlRV/6wQqpxKTG2ejlICO2BJg8wLUlu9PPELknVKx9Dkb0ANQQ1YL0JCmofuPNxFX2+1Vqcq6pPw3E+1d50YThc97c6omxNax5FLQ9D+EhqVFh32zy7rDEkUFQT+J6jszfSFxdAQZFjisKUaeF6gniwNLupNe0CCGAoyypWoBDXkaQu7S19Y6Q1sah8jbibBtMPcl2lysAFb6xRbn3xD/BgXKYmBBwL/Y6v+MFgJ7776EeAETBmfK8JtHDnGfvbv9Tjp7Ac4eB1koWEsUcIzZK3sDd2IpQz3+cdPHbkNDndxMPU/aOrQzh6cKoLtyMRL/tgAI8rOWW3Bi4EscR57i6CtNt7t+zG14g9QbZAJR2HD/chU61G2od1qQja8z+HWNjxP8mj/sE+RqWuEu1KNaKBxbbVlgk/Q8gjEDsUfkm+enHDBE4yqiD2J06G3ayMiNMGSOk6dGby/CSEzKRJmtEYDsvqzlxPz8NqdLZ/wLeaSALWPWdK9osyO6cDV5fg
X-GND-State: clean
X-GND-Score: -100

Tobias Schaffner <tobias.schaffner@siemens.com> writes:
> diff --git a/arch/riscv/include/uapi/asm/evl/fptest.h b/arch/riscv/include/uapi/asm/evl/fptest.h
> new file mode 100644
> index 000000000000..1b1f4f0ce373
> --- /dev/null
> +++ b/arch/riscv/include/uapi/asm/evl/fptest.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
> + *
> + * Derived from Xenomai Cobalt, https://xenomai.org/
> + * Copyright (C) 2006 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
> + */
> +#ifndef _EVL_RISCV_ASM_UAPI_FPTEST_H
> +#define _EVL_RISCV_ASM_UAPI_FPTEST_H
> +
> +#include <linux/types.h>
> +
> +#define evl_riscv_fp  0x1
> +
> +#define evl_set_fpregs(__features, __val)
> +#define evl_check_fpregs(__features, __val, __bad) 0
> +
> +#endif /* !_EVL_RISCV_ASM_UAPI_FPTEST_H */

Gilles did write the fptest bits for x86, arm and arm64 a long time ago
when we were working on xenomai3, which I then picked for implementing
xenomai4/evl. However, the risc-v bits can hardly be seen as an
adaptation of any existing code, although the basic pattern has to be
the same, since this implements an internal API. I believe that you
should copyright it, I don't see this as a work derived from the other
fptest implementations.

-- 
Philippe.
