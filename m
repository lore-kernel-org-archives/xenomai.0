Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FEB3DBD49
	for <xenomai@lists.linux.dev>; Wed, 10 Jun 2026 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083228; cv=none; b=mKVRqeOLYN0f8J+fzpd7igu63pBEfMmhllic5qeI9o5G2kHjEU3nYBK3f31dmrfjY+A1ogCpHoyfDyE3FmVXtHQoLTva3iMCSYl8jvyD2mrowB5aUcoOli5GbACEl5KvHlYrgGYWNUBi9eV1iTd0DdHNuJXqzAWrSDAcmJtMa/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083228; c=relaxed/simple;
	bh=j9rWthIk085YO84Z95eDtiRJWahJjRRwQLpYiMu1qEk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RErs5DpvGdro+U3+BXDJ8cMTAz5O8Ea09XY4XfxDK/lDg6rCDAXjQDcsiaD+PrSfMZHAMCPpY+xZy+roPeRZIwTHIRbS3RHPrpNJ05bNomS4Jl52+hoc1Q+083aFKDWpmBArQtlvWVy23xzfa8xiuNF6Vu7T+GJVrFvjtQU7rME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=qcxTVBc0; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="qcxTVBc0"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202606100920139753f8c6850002079d
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jun 2026 11:20:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=1ul8GZZN9RZRDzlQnDXUpagfcQjOmRPcUjI46MROXPk=;
 b=qcxTVBc0Sbd9dwccHyQlC+pegUs6rHjsNB2BhhxLEmw9iElzXN4MhEoKZXqfMr4Y+6g/ca
 Nvv8Q8gXP1na1sySVrMIU0V+0fSHvf62cLEtbr8nGiCBZ9Y/RR64cHg0CWUilVv4C17pBd2q
 MMy2cHRyS0OEsaBTUFFWTav/Ekl15nCWckB50DViHqSaNNXlA815D3jvCw6OtSYzMRzaS57g
 9LnseHXygmBSKNGUZWS5kL6DxML66YG922oYuzns/okdZ9lT/EUatR5iBgS4bDtt6WTk3j7k
 QJ0+ON0rtwbZk0w8pG6LF+dmW6RS55mmVUUMyGltXYClZF3DEwOI9RxQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail v2 0/6] Dovetail: arm: Finalize review results
Date: Wed, 10 Jun 2026 11:20:12 +0200
Message-Id: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-0-62c9c477f8f2@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEwsKWoC/42NQQ6CMBAAv2L27JqlIBVPHvyF4dDgAptA27Ska
 gh/t8EPeJxMMrNC5CAc4XpYIXCSKM5mUMcDdKOxA6M8M4MiVVNNDb7EYz85TBoLNGFGL54nsWI
 H7OXNEZtKXc6V0lr3NeSOD7yLnHnA3SVejEzQZjNKXFz47PNU7P73KeiPTyqQsGRNpqSyITa3K
 DyzjafOzdBu2/YFfpIHct4AAAA=
X-Change-ID: 20260609-wip-flo-v7-1-arm-pipelining-fixes-9428542777f6
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi Philippe,

This is the first try to fully process the feedback on the
interrupts_enabled() issue mentioned in the former patch series.

Input welcome.

I tried hard to keep everything easy, but changing the current
implementation triggered a lot of unexpected include / build problems, 
especially within the arch/arm/include/asm folder.

Testing looks good, I'm going to schedule a full CI run now.

To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Changes in v2:
- Resend. Forgot the list...

---
Florian Bezdeka (6):
      arm: irq_pipeline: Fix fault_{entry,exit} bypass in do_kernel_address_page_fault
      arm: irq_pipeline: Move fault_entry() fault_exit() into separate header
      arm: irq_pipeline: Fix fault_{entry,exit} bypass in hw_breakpoint_pending
      arm: irq_pipeline: Fix ordering problem in alignment trap handling
      dovetail: Decouple kernel/irq/pipeline.c from irqstate bit definitions
      arm: irq_pipeline: Fix IRQ state checking in trap entry paths

 arch/arm/include/asm/dovetail.h         |  1 +
 arch/arm/include/asm/irq_pipeline.h     | 41 +++++++++++++----
 arch/arm/include/asm/trace/exceptions.h |  3 +-
 arch/arm/include/asm/trap_entry.h       | 82 +++++++++++++++++++++++++++++++++
 arch/arm/kernel/hw_breakpoint.c         |  8 +++-
 arch/arm/mm/alignment.c                 |  8 ++--
 arch/arm/mm/fault.c                     | 73 +++--------------------------
 arch/arm64/include/asm/irq_pipeline.h   |  9 ++--
 kernel/irq/pipeline.c                   | 20 +++-----
 9 files changed, 145 insertions(+), 100 deletions(-)
---
base-commit: 01b2d00fe7ab9fc7663219e4c75ab205a257832c
change-id: 20260609-wip-flo-v7-1-arm-pipelining-fixes-9428542777f6

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

