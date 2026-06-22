Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191C0388E6E
	for <xenomai@lists.linux.dev>; Mon, 22 Jun 2026 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115545; cv=none; b=cwiH9y83GM5EBdpvEpaKdOvOS0QbJkmSK1cBNifxANQuGW0Pdly3ikdRljUzLGvBsL3OA5mTMc7QvhFLZWucIui3Bk85N902/wgzRJyi0JvmxIjwhFYFQHChQyNMniw5YuP8g7qcMmrFtZ68eIFkKdR505wMgHwmTe8o4Xjw23E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115545; c=relaxed/simple;
	bh=c5HKNzVqFRdztn3UdbjuZZKmZFiUtvCFHkdLf4Mqn7c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s2pAC8+6hjBt6uAi2BgBmfdnIuSj3DP1X/lLcAGWT7ir1jM0kjy4GWvjMn/MUTUNZAVPxAcfXa35UqT0BPs/sNZEeVoBRNuGR3s/RNWIOnwjDwQ2gg4Mem9CcajNRgWocUnCE72SYKRuAso3rxIUJUzaigiF+aSUKN7wimc6Zjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=rvLkoooK; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="rvLkoooK"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260622080538a056bfe0fa0002074d
        for <xenomai@lists.linux.dev>;
        Mon, 22 Jun 2026 10:05:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=h4g9gVEy00y+2eTnR7cQFwcKnaNG6wQPg8bEzCWprcQ=;
 b=rvLkoooKywUDjBlNGgcpWeOn+NCdkYZi7sKf9D2jx4Z/89OV0pBCpfcgGqeay46aGgUoTW
 65Rs0cU/hzRm9edqT+zX7jAKy8JdeSvK3GX9LuBpOA1V9W7MWH8DF+erAkYhtE2O8TpP4LmG
 ZTh9b06K+MGN2MajnPnMunjpjjNCz1kcbNTHklmRt89Py9QtMhAI4HdDHMp7aLceZ6gIllws
 xX2SbAMTj/85BL3ZVc43tW/MugrVFDXVjx3F4oC2m2jAsNF0d8YMVq91x28HqVfFWmfWGfFx
 XPZtsN5Xrz3zKKA+Nd403ArZBhPRxKFfkIwofgfnRyq5csyDDzJMj8mA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail v3 0/6] Dovetail: arm: Finalize review results
Date: Mon, 22 Jun 2026 10:05:24 +0200
Message-Id: <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-0-230f03227abb@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMTsOGoC/5WOsQ7CIBRFf6Vh9hmgFcTJwb8wDgRf25e00ECDm
 qb/LqmTm443JznnLixhJEzsVC0sYqZEwZdR7yrmeus7BLqXzSSXiitu4EETtEOArEGAjSNMNOF
 AnnwHLT0xgWnk8dBIrXWrWPFMETdQNFd2CRlnSwO7FdJTmkN8bfEsNv7pCP5DJwvgUKPmtua14
 WjPiXBEn/YujJs/y7+dsjiVdMY15f6xld/OdV3ff3sSRDIBAAA=
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
Changes in v3:
- Patch 1: Integrate review comments
- Patch 2: Integrate review comments, rename to dovetail_fault_entry 
- Link to v2: https://lore.kernel.org/r/20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-0-62c9c477f8f2@siemens.com

Changes in v2:
- Resend. Forgot the list...

---
Florian Bezdeka (6):
      arm: irq_pipeline: Rename and move fault_entry_{enter,exit}
      arm: irq_pipeline: Fix dovetail_fault_{entry,exit} bypass in do_kernel_address_page_fault
      arm: irq_pipeline: Fix dovetail_fault_{entry,exit} bypass in hw_breakpoint_pending
      arm: irq_pipeline: Fix ordering problem in alignment trap handling
      dovetail: Decouple kernel/irq/pipeline.c from irqstate bit definitions
      arm: irq_pipeline: Fix IRQ state checking in trap entry paths

 arch/arm/include/asm/dovetail.h         |  1 +
 arch/arm/include/asm/irq_pipeline.h     | 41 ++++++++++----
 arch/arm/include/asm/trace/exceptions.h |  3 +-
 arch/arm/include/asm/trap_entry.h       | 83 +++++++++++++++++++++++++++++
 arch/arm/kernel/hw_breakpoint.c         |  8 ++-
 arch/arm/mm/alignment.c                 |  6 +--
 arch/arm/mm/fault.c                     | 94 ++++++---------------------------
 arch/arm64/include/asm/irq_pipeline.h   |  9 ++--
 kernel/irq/pipeline.c                   | 20 +++----
 9 files changed, 156 insertions(+), 109 deletions(-)
---
base-commit: 0ea6cb72940b40c147655ae13dd77ffcae553df9
change-id: 20260609-wip-flo-v7-1-arm-pipelining-fixes-9428542777f6

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

