Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB416379C53
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496327; cv=none; b=WiL5vzIpwWY7E47XphKreiCvJzIL/RE/CkyQJLSTOK8OHuiZnvEwi/ER3a4DXOi++KkUPzoWRnhihIotDpY1zyr8Q35uVEidjfO/MC11CYvXt36gTi0p7IQXvokDIFZ9AKNxV5VIoZlyY7ZG8Mc/tMUH/V1SLF+6vrHHmtWRWvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496327; c=relaxed/simple;
	bh=8wm0Kn227YQHBJSS0qWuhqnWtFCycSlooZ0NlO+bMPM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mijF/a5UzmNu3vlskhKPFvLIwvZlynRhP+8XyAzk/g9pTdTziT7j0IUoZvHSlxxqrB76sj5wxj1x+5nwN/00ALdDQZgsewHuKbhgjm0CBEMj9ssQifQJoazPsWjvbBEgOhgyMHVa1rzpZqHz3UaiXn2LJaDJbF/urR9yI6iynh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Ze0nsBpm; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Ze0nsBpm"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C4DEC1F749;
	Wed,  8 Jul 2026 07:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783496309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KDZvZ4GaG+7BEwYI36V0Z9SMyWVvgE9qwyDtsusdhYk=;
	b=Ze0nsBpmgPwQ+oW+Alixf7xo6CPXDNhhdDIAF71xBG8Yss2qMZR9zAPUR5p5oqd3TjZTSX
	u2QuKGr934VsVQd19fzdGr//lOianxItSsv/8a+P4+YjoNHgBfiIlmXW9zHpauyVC617aD
	ZsxVepK0GXgeWS6fc/XIRi3ii/kBVp798LM8wwDbI5YWF2U3iESLDregByBs+mDic82pLJ
	JV3tETNlvmNRJvdjalSvMm8gNsULgD4ZaWx9G5AwBafTBhBsixCbvwb9CfxGRHe8+M60rN
	9TJ4U01cuybgx1TUV56xYG3kWDK+9MUCCPIlLCKZg266+EEYvU+OjJnpfc+nSA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,
  jan.kiszka@siemens.com,  shannmu <shanmu1901@gmail.com>,
  xenomai@lists.linux.dev
Subject: Re: [PATCH dovetail v11 02/11] riscv: irq_pipeline: add IRQ
 pipelining core
In-Reply-To: <c318d9f72d698bd20cb3b75817ec011330b06144.camel@siemens.com>
	(Florian Bezdeka's message of "Wed, 08 Jul 2026 09:19:14 +0200")
References: <20260708062748.1029852-1-tobias.schaffner@siemens.com>
	<20260708062748.1029852-3-tobias.schaffner@siemens.com>
	<c318d9f72d698bd20cb3b75817ec011330b06144.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 08 Jul 2026 09:38:28 +0200
Message-ID: <875x2qlymj.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTG4pBqFpV50ZXJPrfC/oo+yQNuOkS73YbSfe0Yc0+anG2lPXDK3MG/LDgJcszpVNPioavmXfB6WWAz4wsfeR5DBk0S9A+Hv6n+9mgNjXMkQwwFI6ZnviqDg+IFp6klBm7ehIVo73JCwGxsXV3D+ubiaz8vT1/bV/8CxCXGUAFV6Qt0Nu4VeIUoiK9ue3qcG1pLYsxckxXMExIiytIW54ETyPs16qKaQdOdTddM6AfWMjkUfMtKsvoCrAenPLlFODTto58KXDu7RjKK3oj19wUQhfQDkaOWLcPS1TreBMZTT2y1SYhiAF2b9XUlAXMbxttQgx6jWmqLFE1YSaAiVkVWGkSNVDa8MjOWJx3Sf6EWEO1155nHVyGgnGsGWKBnp2zamS0qe8fIAA/Pyf5tSDFnjQM4EK4mluNeWIYZfch55u4L4ldleC3cvqfvfemV+DQcXFKY7hKN1az/r0aJSSCB31/KTnfuzRQDeUn3zhHH3MrgHIjij9SsL2C/SSeh1lPsG4pt9/O9nM2krEDFWErloA1ooaztBZQDDHTx+snykpX1aBvyVRAYJx0oaxAdzbfRIvzFOQflMCFw1F0+2Ean++GL8EBf8Mwna+qQGRN3NIRpz0e2kQKBcg7UkaIlyTQAn+LqlllqF/AffL9QQ8pumpiEM5UEx9e6EKXltfa1MxA

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Wed, 2026-07-08 at 08:27 +0200, Tobias Schaffner wrote:
>> This patchset integrates IRQ pipelining into the RISC-V architecture,
>> bringing it in line with the Dovetail/IRQ pipeline model used on other
>> architectures. It adds the core pipelining infrastructure and adapts
>> low-level primitives to cleanly separate in-band and out-of-band
>> interrupt handling.
>> 
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> Co-authored-by: shannmu <shanmu1901@gmail.com>
>> Co-authored-by: Philippe Gerum <rpm@xenomai.org>
>> ---
>
> Philippe, your Signed-off-by should be added as well, so that all co-
> authors approved it.
>
> A short confirmation is enough, I will fix it up on merge.

Fine with me.

-- 
Philippe.
