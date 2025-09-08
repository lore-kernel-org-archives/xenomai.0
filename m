Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33F84A06
	for <xenomai@lists.linux.dev>; Mon,  8 Sep 2025 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757366288; cv=none; b=tGLNd+4r9CAGCbqftf7d8IkTKexA5/+bO2Zx5ppX6Fq/E6NxmyanumNjVFz+hPaFs7bamdYRLytJoQ1xrLbd36CvxaUzix7+C+SnsfZkWSk5kAbh7QJcvUQ4R8QDLe7yhEv9jx+8aQ5Bna6Yn3Ptnp6g+tut3nOT4Fdedq/NtUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757366288; c=relaxed/simple;
	bh=tPzBq2dFI9BWf7nCjGErMl4wDRJFQwiSHXt1am8o4Tw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mGCgUALAOiAj2wMtUsDLw7ol0JprbguLM0lXZ89rnUfb3amfJ1UkPjYrmwcuuEncrygowjtVH7g5efxB8q2do1zGojqm3CQD9YxI1jzyd0a0jJvBJ2QWZyv5MvGDXRkzzY2Bqfxodvhl2NdRHavbpnCITNVQp8jdIuJBzsKpXgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=jNiSIBcz; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="jNiSIBcz"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250908211755cff18295ee000207cf
        for <xenomai@lists.linux.dev>;
        Mon, 08 Sep 2025 23:17:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=debkjhnDT7gGTzN4WZHMvIqp80H8Qxe/Sr3DpBH4aZk=;
 b=jNiSIBczdK905QmtcrEg4bDgj0UMCRchAOMVlD2o4wGWIaH/lA6hd15wV4rxUvctfztHbi
 xAY1MpQzXYuyTx2AhMW4bZDoipYV8l0ZyUxehm53gOciJne8+w4FAiii0O3nP8/dpfpoXJpu
 XBGeYNOE9v0A5N5iVXUHM8ZbPAfu0ogLXvm51LBJ0sJEgBT4lL8D0RY8NUFJ3QuIuzpoybc9
 KnS0J+lV4z4QNVMuAXgBNks746lKAJoiTdClAthArxBZwUHYHxFU8eQQX3vH4KvUNgdd0Pb9
 QI/NG9DjFTIzR2M6sJ5BxhPcAxkD/DolRxCw5NUhDJ/YeSYPxfckIVkA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail 6.16 v4 0/3] Dovetail 6.16: Fix some regressions
 introduced during last forward port
Date: Mon, 08 Sep 2025 23:17:53 +0200
Message-Id: <20250820-wip-flo-fixes-for-dovetail-6-15-v4-0-d661652d03fa@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAFIv2gC/5XOS07EMAwG4KtUWeNR3q1YseAWiEXSOtRSJxklQ
 wCNenesig1iwyz9+D/7JhpWwiYeh5uo2KlRyVzYh0HMa8hvCLRwLbTUTk5awgddIG0FEn1ig1Q
 qLKXjNdAGHpQDZfyUxuRRRiVYiaEhxBryvLKT37eNm5eKR547L+L5Jz/4k/LilccrtWupX8dTX
 R1L/77fFUhYrE1OztFGGZ8a4RlzO83lfOhd3ylqFp1xaFMwzqXxr2juFA2LAW3wo10mVPK3uO/
 7N6lT6uGYAQAA
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

seems the last forward port to 6.16 introduced some regressions.
Please review carefully, thanks!

With that applied I have two open problems:
  - Running dmesg kills the system, no idea yet
    Requires at least 3 CPUs on my qemu system to reproduce.
    Update: I know how to fix that, but not fully understood yet.
    Update: Discussion ongoing, see ML.

  - I'm able to reproduce [1] on 6.16 now
    Update: This one is understood now. Xenomai 3 bug.
    Tests already ongoing.
    Update: Fix posted to ML and merged into Xenomai next.

Cc: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>

[1] https://lore.kernel.org/xenomai/6fcb3f9830056d99161ea8f50a016b99d98a7c71.camel@siemens.com/T/

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Changes in v4:
- Patch 1: Define _TLF_KERNEL_FPU_PREEMPTED as an alias to 
           TS_KERNEL_FPU_PREEMPTED
- Link to v3: https://lore.kernel.org/r/20250820-wip-flo-fixes-for-dovetail-6-15-v3-0-ae4a674d8e10@siemens.com

Changes in v3:
- Rework patch 1: Move preemption marker to thread local flags
- Added patch 2: Align arm64 and x86 fpu preemption code
- Patch 3: was Patch 2 in v2, updated to match latest Linux code
- Link to v2: https://lore.kernel.org/r/20250820-wip-flo-fixes-for-dovetail-6-15-v2-0-535e4fa355f7@siemens.com

Changes in v2:
- Patch 1: Reworked as discussed on the list
           Following the same pattern as for arm64 
- Link to v1: https://lore.kernel.org/r/20250820-wip-flo-fixes-for-dovetail-6-15-v1-0-d44f50cb4b0b@siemens.com

---
Florian Bezdeka (3):
      x86/fpu: dovetail: Fix FPU corruption
      arm64: fpsimd: dovetail: Align with x86 implementation
      irq_pipeline: Fix pipelining code for level triggered IRQs

 arch/arm64/include/asm/thread_info.h | 10 +++++-----
 arch/arm64/kernel/fpsimd.c           |  7 +++++--
 arch/x86/include/asm/fpu/sched.h     | 17 ++++-------------
 arch/x86/include/asm/fpu/types.h     | 12 ------------
 arch/x86/include/asm/thread_info.h   | 10 ++++++----
 arch/x86/kernel/fpu/core.c           | 13 +++++--------
 kernel/irq/chip.c                    | 22 ++++++++++++++++++++--
 7 files changed, 45 insertions(+), 46 deletions(-)
---
base-commit: eec111a874f5899e1078ef785ccf29dff986e5a0
change-id: 20250820-wip-flo-fixes-for-dovetail-6-15-1368f7f6e0b1

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

