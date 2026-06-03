Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0818630148B
	for <xenomai@lists.linux.dev>; Wed,  3 Jun 2026 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499254; cv=none; b=YCmTQrfo4lZmAE8X5U5e8j+tRtL2eL+/aLU65Xb+kwx//1IPEMQ3fom18SY2TYz1g7a/8AvL0pKzKXf3zoHu3a+OksHSUfMRTkDu6OHvNblb3FWiZJhm8tpzNV7FEYMicQr/1ZzEMQzjQbcqJFP/dk0/MiPxn3jw13bFGL7FtBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499254; c=relaxed/simple;
	bh=XmVfUcDVGEsYRmSq4nx9HH03YuiMeEF5x2GZPhlDzQQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=as22IpLzwCJBE67t5RecdxKoeb1wYCi58i3hsXLTceP8RH2cP7A+2Fms5hCAtaSFSSG+vEzH8IgXqDdY04gvqKJ5FkjV1yRE9/TWor5keQzSVBsMlP5sZR+x3Ppz3+dHx4Z9k/xRW5j7AWrGWGS/gguJ8dy4mdr+pTiltVL+9tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Sa3WRoRB; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Sa3WRoRB"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2026060315072328c579db4f00020701
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jun 2026 17:07:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=47SuTo1CVJ6NuRdPm0hxFtK43IZYHjgHSRMZdQxFyCQ=;
 b=Sa3WRoRBoGhCCITUmY1dLX3bREbbLp7yUgtmVjM/Br/9Dt9BrUXqQMuh0QwRzGbDx8OJ33
 EcZvAzkUvtOndY+ORbyiOLwFU/O1LgN5o4lAfQgJw4hbug2Vq0THpYaFZVzYwj2589+fYKLy
 RZbMaISTVt7/2ZRlCQb1+cXwQdBdnU7iPKMZD57GQChX/FUhNHWySDD/tm+wdzbY9mb/hwYt
 T8jxBdvGJ3JRlXudQH1pXGSNMon/aq0JlPQ4iRxkt3pvZ4zwlUTc52JKGyo5fpCGczax/JKY
 Ee4YXC/qk+Y/89R7Dw1cnLuFoA58fmTddJOavSVLoy9JR1hp8VMU9tEA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/2] arm: Review irq pipeline
Date: Wed, 03 Jun 2026 17:07:14 +0200
Message-Id: <20260603-wip-flo-v7-1-arm-fixups-v1-0-c28b4ff180ed@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACJDIGoC/x2MWwqAIBAArxL73YIpaXSV6KPHWgs9RMmC8O5Jn
 8Mw80IgzxSgLV7wFDnweWSoygKmdTgWQp4zgxRSCy0U3uzQbidGgxUOfkfLz+UCynquGzsaaRV
 Brp2nbP5z16f0AaWcJp5pAAAA
X-Change-ID: 20260603-wip-flo-v7-1-arm-fixups-25d58fb72f3e
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi Philippe,

This is the result of a review of the arm implementation of the IRQ
pipeline. Triggered by some risc-v reviews.

I'm sure about the two easy fixes, targeting different Dovetail
versions, so split into different patches.

In addition there is one more, I need your input here:

We have two calls to interrupts_enabled() in arch/arm/mm/fault.c,
both in the do_page_fault() path.

Assuming that we are handling a page fault over kernel space,
inband stage stalled, we would leave the kernel with the inband stage
unstalled, as interrupts_enabled() is checking the hardware state (as
pushed to the stack on entry) instead of the inband stage stall bit.

Is that correct?

I'm quite sure we have more real problems that in this case, but
maybe we should fix that up?

We would have to call something that does the HW check in case
CONFIG_IRQ_PIPELINE is off, but checks the stall bit in case pipelining
is enabled.

To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (2):
      arm: irq_pipeline: Fix fault_{entry,exit} imbalance
      arm: irq_pipeline: Fix fault_{entry,exit} imbalance

 arch/arm/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 5c4243abc449083b74c94fcd353d360b6ce78b5b
change-id: 20260603-wip-flo-v7-1-arm-fixups-25d58fb72f3e

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

