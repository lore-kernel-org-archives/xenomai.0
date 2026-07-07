Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985B3DA5D9
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418437; cv=none; b=gpm1f0Vz/8Do0YdO3fWOs1grKMB5yduHLnskHWdNGD7Kkerj56isMAB24uB9J9+P23++upRo0mtGzBwvBSfpMiTezElVNqMvNF+TKp3Hi64WMMXLEHrSI1pZrzRDV5BTrg4PXXZuiAgECWpmHCQwqygtr0em/ZxKI4/b5QZFtsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418437; c=relaxed/simple;
	bh=G3/iOXk65Pf1dph/d/bwMOMJzY22semUv0JToFmphGY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hfOm59iYBaiVs/Jx/sdmw3tV0o8y8+GXSkpikgATyTFuuQFVx8Ajpo50WrPimgHg9lfAJgTvQq+ZxeWGcdFcOMSOky72mcIK9bjSvXrY1D1/DaeRExTzmZHW0GZA+kHzjg/2nISXgNYu3I6SnSa6cYRfT8qVI+RoerU9wGOYqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=PXwCYY2r; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="PXwCYY2r"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260707095019b6ee117b2b00020781
        for <xenomai@lists.linux.dev>;
        Tue, 07 Jul 2026 11:50:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=INa7UZE1jkebOTeJO3eTRN2aZU/mV1OwmrKKIvMjBUc=;
 b=PXwCYY2rC98b1K6k0RAFqqbQJT/5ZRwznowkh0PF56P+9+KDsQ2MO0lakIyGcI7zyAluYf
 ioFkIU6srA9WMWBOoNjSN3cjcpJlSUoJNYPMKyhS3TD07uV7wK6dCjOsga4Vu4v/1RiJYH4a
 yNaI/9UKDzKoI7fiELWpIRhCBxp/+/Tec5C2nmA6YImPXIKbZyay2cDw+Ccg4wOWlKo0xvtX
 317PhuV+Zqa59H/ZhV0QXZ2ZDLb9Nsu0J8hSsnK1OL230vPmo6rBras81Ue8KEFXxF6i6UsA
 +bNrDLrjQWkfyozXYoQiMKzUeTYx2g3SMUa3xev5o1Fdwra7SZfwXAsQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail v4 0/8] Dovetail: arm: Finalize review results
Date: Tue, 07 Jul 2026 11:50:16 +0200
Message-Id: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANjLTGoC/5XOwW7CMBAE0F+JfO6izTrEpKce+AvEwUnXsFJiR
 zYyIJR/xwqXVr3Q42ikN/NQiaNwUp/VQ0XOkiT4EpqPSg1n608M8l2yIqQWW+zgKjO4MUA2UIO
 NE8wy8yhe/Amc3DhB19Bu25AxxrWqOHPktSjMQe1D5ouVUR1Lc5Z0CfG+jud67V87Nb6xk2tA0
 GzQatQdsv1KwhP7tBnCtPqZ/m1SMVsauqEp93eO/pr6h0n0jqmLSRodaiJj+/63uSzLE3nNT7K
 GAQAA
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
Changes in v4:
- Split patch 5 into 3 separate commits (now patch 5, 6 and 7)
- Patch 5: (and now 6 and 7 as well) rename functions according to
  feedback from Philippe
- Patch 3: Merge ARM_TRAP_HW_BREAK into ARM_TRAP_BREAK
- Link to v3: https://lore.kernel.org/r/20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-0-230f03227abb@siemens.com

Changes in v3:
- Patch 1: Integrate review comments
- Patch 2: Integrate review comments, rename to dovetail_fault_entry 
- Link to v2: https://lore.kernel.org/r/20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-0-62c9c477f8f2@siemens.com

Changes in v2:
- Resend. Forgot the list...

---
Florian Bezdeka (8):
      arm: irq_pipeline: Rename and move fault_entry_{enter,exit}
      arm: irq_pipeline: Fix dovetail_fault_{entry,exit} bypass in do_kernel_address_page_fault
      arm: irq_pipeline: Fix dovetail_fault_{entry,exit} bypass in hw_breakpoint_pending
      arm: irq_pipeline: Fix ordering problem in alignment trap handling
      genirq: irq_pipeline: Decouple kernel/irq/pipeline.c from irqstate bit definitions
      arm: irq_pipeline: Add arch specific arch_kentry_ implementation
      arm64: irq_pipeline: Add arch specific arch_kentry_ implementation
      arm: irq_pipeline: Fix IRQ state checking in trap entry paths

 arch/arm/include/asm/irq_pipeline.h   | 41 +++++++++++----
 arch/arm/include/asm/trap_entry.h     | 83 +++++++++++++++++++++++++++++++
 arch/arm/kernel/hw_breakpoint.c       |  8 ++-
 arch/arm/mm/alignment.c               |  6 +--
 arch/arm/mm/fault.c                   | 94 +++++++----------------------------
 arch/arm64/include/asm/irq_pipeline.h |  9 ++--
 kernel/irq/pipeline.c                 | 20 +++-----
 7 files changed, 153 insertions(+), 108 deletions(-)
---
base-commit: 0ea6cb72940b40c147655ae13dd77ffcae553df9
change-id: 20260609-wip-flo-v7-1-arm-pipelining-fixes-9428542777f6

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

