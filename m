Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFB61C4A13
	for <xenomai@lists.linux.dev>; Mon,  8 Sep 2025 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323225; cv=none; b=bGiMBuXi+teTXVQiWU1Jp8Ua1YHF3dtbsHpWF1O58JZEruW7jM8868qNVWeFxEDmtLI8bLS6ouZfJQqwPH0XW+IqeyL5B4HnuRxaeuMqRrPsabWMCnsKNojrElYKt2uQ172ip4dK7QQ/Zv9CUlmCIwOBfRK12jxQ/RwH7OxbD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323225; c=relaxed/simple;
	bh=QiC9HbPFEMN/KyxD3w6/AMk/lWjV6ug5aXWYUpIM8no=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Up/m+ABgPG7uZ9bQIGElMpxEjw46/bIEEwALl2T4TOWZv9Ges/+2X2sJPe8PFMOgV7PzVlz+ho4XrpEiBbU62ZNNCpuVpK/YGu9A+n2PlGTfqPeZuZZemUhfxuuYcm1C8My5Kmt1V+qg5tm/3ywRV4WQk0MsnXT1hLw5n75Os1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Tzw8f4Er; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Tzw8f4Er"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250908092011b5f3b861f3000207d0
        for <xenomai@lists.linux.dev>;
        Mon, 08 Sep 2025 11:20:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=siuI3Gwlb1tb489/eWW1Pii+hd5r/UIf2QKq10WU5Kk=;
 b=Tzw8f4ErkaklkL/HALMqGpjsCx65igGn38+eLJwuQGz5klj/boMGAMs+7bxu+mZOYOyY4N
 kjStKKgCUEePWVngBt/R9ZRWhq9oKRlpIpD7cqDMeV5DPxBYC066oelRywfuLzACQWg1AadZ
 2cPkj9XTXUdoAmBGhRfHQhBwspNrTtf9cB1zmiTxyQwA7bpEkZUFcBWvA4E7d/wLoMniVJsk
 LU7RA/AUNEG5Rd0RzbP/6Nh/JDrE6LrTDydzgmXl6YH0FpDXSSiRp/PtiGc7UB6L2dUt6JT1
 MLYLAV6HPSka5ZhR/hoxQ13PzxYrn2i3oTOHDykks3pMxFfIprr0Ic0w==;
Message-ID: <5f4b2b48567e207ced79ac99476193194ed2fd57.camel@siemens.com>
Subject: Re: [PATCH Dovetail 6.16 v3 0/3] Dovetail 6.16: Fix some
 regressions introduced during last forward port
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 08 Sep 2025 11:20:10 +0200
In-Reply-To: <20250820-wip-flo-fixes-for-dovetail-6-15-v3-0-ae4a674d8e10@siemens.com>
References: 
	<20250820-wip-flo-fixes-for-dovetail-6-15-v3-0-ae4a674d8e10@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Fri, 2025-09-05 at 16:26 +0200, Florian Bezdeka wrote:
>=20
> Changes in v3:
> - Rework patch 1: Move preemption marker to thread local flags
> - Added patch 2: Align arm64 and x86 fpu preemption code
> - Patch 3: was Patch 2 in v2, updated to match latest Linux code
> - Link to v2: https://lore.kernel.org/r/20250820-wip-flo-fixes-for-doveta=
il-6-15-v2-0-535e4fa355f7@siemens.com
>=20

Any further comments to this series?

Would be nice to get that in as it hinders testing the edge IRQ
handling because of the FPU stall and stalls my hyper-v enablement
branch as well.

Florian

> Changes in v2:
> - Patch 1: Reworked as discussed on the list
>            Following the same pattern as for arm64=20
> - Link to v1: https://lore.kernel.org/r/20250820-wip-flo-fixes-for-doveta=
il-6-15-v1-0-d44f50cb4b0b@siemens.com
>=20
> ---
> Florian Bezdeka (3):
>       x86/fpu: dovetail: Fix FPU corruption
>       arm64: fpsimd: dovetail: Align with x86 implementation
>       irq_pipeline: Fix pipelining code for level triggered IRQs
>=20
>  arch/arm64/include/asm/thread_info.h | 10 +++++-----
>  arch/arm64/kernel/fpsimd.c           |  7 +++++--
>  arch/x86/include/asm/fpu/sched.h     | 17 ++++-------------
>  arch/x86/include/asm/fpu/types.h     | 12 ------------
>  arch/x86/include/asm/thread_info.h   |  9 +++++----
>  arch/x86/kernel/fpu/core.c           | 13 +++++--------
>  kernel/irq/chip.c                    | 22 ++++++++++++++++++++--
>  7 files changed, 44 insertions(+), 46 deletions(-)
> ---
> base-commit: eec111a874f5899e1078ef785ccf29dff986e5a0
> change-id: 20250820-wip-flo-fixes-for-dovetail-6-15-1368f7f6e0b1
>=20
> Best regards,
> --=20
> Florian Bezdeka <florian.bezdeka@siemens.com>
