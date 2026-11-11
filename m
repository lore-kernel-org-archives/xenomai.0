Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385886;
	b=mWcmGxEqiAu8amSRNQX3loga91FKkXwcWg83+xbIhFMl0rq/+H8E/c7ULXn9RVapmEYH
	 2j8x9ON+2nttsMqXwZagR35lH33TX+UsT2aL8LF7tx5nG1PjBXO0i3feWSbgRqa6QBcml
	 9z8T6aQmdfHIHtOIhLG9VkMzMYTfuwL++UFlhCRZ0hPP/Uwu7JAzjdw+y0w3wZuttzdRT
	 UuUbbR+nY/SMnsukoTheo+1gCVkT/jpHFFS2C750OjeMZ6VgFzr/k6bye4XmMvWoD7ktL
	 d5yIQGy7GK+jTSjuD03SkHvnxByDYjcqKGiVfpd/kQe5+b1lV8vTrvsvP/98DkWOxVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385886;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-GND-Cause:X-GND-State:X-GND-Score;
	bh=c+jsp/cnQ7gvrAyBL6bEWp46qYJ7wiBp8exDTYvmN/w=;
	b=WHDBRowMasF8qmCZY8mvCjXb31rLnCxdKuY1eI7rYawCgzkrOPqzAty4AUXNLbx8q60M
	 ul7/C+v5vX4OBYcG3fKHP26OxJ+tjQ30M5fASeD4zbUNVW+WHHtrmkwMC8LXY71+9tWtZ
	 xWx22JSPsiXdyrYnTJjRu/LO9csmhqC6oIG1Ha0IxCOeU6dJVjes9Lo+4yp7kLi4OPrxO
	 dDVkwEu3ImI/3DToee3/lvvbUYaUWqKL65eApzArw4L0BzYBMRindZBREaZa5giuBMjVQ
	 Jn9dD9Yaz/nL1zgxtGTYKwCcf6GMQ4JabCdaWg4q1WodqklbLj/mCi3FGk2wd28FTew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b="Pq21ajZ/";
	arc=none smtp.remote-ip=217.70.178.233
Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E6A606A31C
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 08:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2E6A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=Pq21ajZ/
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 4CA57441C2
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 08:31:18 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B089127E01ED
	for <xenomai@xenomai.org>; Wed, 11 Nov 2026 08:31:17 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b="Pq21ajZ/";
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 2001:4b98:dc4:8::221 as permitted sender) smtp.mailfrom=rpm@xenomai.org;
	dmarc=none
Received: by mail.gandi.net (Postfix) with ESMTPSA id 60BC13F652;
	Wed, 11 Nov 2026 08:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794385877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c+jsp/cnQ7gvrAyBL6bEWp46qYJ7wiBp8exDTYvmN/w=;
	b=Pq21ajZ/RP0WEesRJszOrBv2brOdUuZceT1nykdEOett9edK5Sco/SzT63fSK8vBTz8w0R
	4Gg9O+afV/p6hynFDcFzYZZOpYMK0pvTMXhLgtQP/D7+nKKmYn9quHrEdiPmW86rqZt2P8
	R9rWmJg168n+ziXdUGW37WOAm0bbHpLxgxtQNtVAFfKWcJ7Nxax6Odu/lzwEJ2GueXvYMy
	GQ5DJyztqlxXtzHUNBgA8D/sDG+j4GOB6KM4Ul2BPAyNetRpIQfHz5bVCDo0MgoaAqgCyd
	coa7/wB6BMbMfzvREGFJwW/Qa20yZTGJfTSc0DVPhIZ6aDTn21OJ3fUnFgz/kw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  xenomai@xenomai.org
Subject: Re: [dovetail][PATCH 0/4] ARM trap fixes and generic handling of
 trap nesting
In-Reply-To: <ed4a5ca3-009b-431c-b014-02046df3c04d@siemens.com> (Jan Kiszka's
	message of "Mon, 9 Nov 2026 09:10:56 +0100")
References: <ed4a5ca3-009b-431c-b014-02046df3c04d@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 11 Nov 2026 09:31:17 +0100
Message-ID: <87ld6z6a7e.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Cause: dmFkZTETswP+Qlp/7Enxlv7NF8LV28Ib58wMrWm5PToysySXv17hFMSl0Fj8huUThCRsttna8LVc5ZMU30NZROM//nCEmneJJA+J2eZucdqDg4H9FeQrYmPKNtOtnyx7RLm2d09VNjHV067e4nQS69qGEqZtKEurxGY9nsZMw92tQaJxmMTNTtr2eoHJCRK0uShbJ68Kf8bTz1C2q69z6WDIQGOTu16JmnJTMSWWW3uiGfqNtxO0fpPwZEr4Wl8V5uISAvG1PUTuJjOLysdyM5UMdbYAsmCz5mj0CEi+rmEOousWDPnSWeCmVOSsJQSe4WThPU2/g2YaIvJouBHyFsxkLI3dU6oeyPnM4+Gd4sfgsHDORt0qFpQtgBnypeGTF2MZHfL69PfL0Cbmjej65EBoYl9filvlxckG5Nni02+s1bom97X4jUYjfbm0KV8KHRtPUNkNIzDgQcfvkTwSWo9PxQw0p3dN954qIMNDzufMyC0FdWYow0htVc9bO/hcuFHYOX1m2Bom3RfMf12EXMLldHnpikULAxt/A5Eeigl3AMqqaySxX6UqBE2M2kB+O0JVqn5vJIBrOx0GIn4d64J/MqhjlfWqgeVV9zs1wmTsX6vUuboRREk+9U5nUZPCkGP257ouAnw/ljgPCGmf48wNmzjuLpAVZpPUIdbQ3SzqxVvE4g
X-GND-State: clean
X-GND-Score: -100

Jan Kiszka <jan.kiszka@siemens.com> writes:

> Jan Kiszka (4):
>   dovetail: Track the owner of a trap notification by exception frame
>   ARM: dovetail: Fix trap unwind condition in __und_svc
>   ARM: dovetail: Notify the core about undefined instruction traps from
>     user mode
>   ARM: dovetail: Fix VFP exception trap notification
>
>  arch/arm/include/asm/thread_info.h   |  1 -
>  arch/arm/include/asm/traps.h         |  2 ++
>  arch/arm/kernel/asm-offsets.c        |  2 --
>  arch/arm/kernel/entry-armv.S         | 20 ++++----------------
>  arch/arm/kernel/swp_emulate.c        | 22 ++++++++++++++++++----
>  arch/arm/kernel/traps.c              | 27 +++++++++++++++++++++++++++
>  arch/arm/probes/uprobes/core.c       | 10 ++++++++++
>  arch/arm/vfp/vfpmodule.c             | 27 +++++++++++++++++++--------
>  arch/arm64/include/asm/thread_info.h |  1 -
>  arch/riscv/include/asm/thread_info.h |  1 -
>  arch/x86/include/asm/thread_info.h   |  2 --
>  include/linux/dovetail.h             | 12 ++++++++++--
>  include/linux/sched.h                |  5 +++++
>  kernel/dovetail.c                    | 10 ++++++++--
>  14 files changed, 103 insertions(+), 39 deletions(-)

Please resend the whole series, some patches arrived garbled.

-- 
Philippe.
