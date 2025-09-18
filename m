Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B7B1A9FBD
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202690; cv=none; b=WDar54nHsc+zrFcDXNE0benJDE9OUu3UpM+6b06xoWvB6fd88bNenvS6Yzh6LLPK935Da18S2BRtIcRsvFSczorlPvg43wiZ9eU/BLXOj0alfba3rl2RBiJNJ4pmRa/NCa+5zk9K2fPjEIgNGMesxTiUOu/Ea+NskLlsjxm4A0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202690; c=relaxed/simple;
	bh=kyBYwFnWwpk3DGt2nZ2IqlVTN38Ltjqk+s/0kydlVGw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=latQG32wzDH5JlGfr/DvSH7LVVLb03XZrwyX8R7rvvuGd57/wzG30/EjlGas14Do79tyqwE6St6I/CFUu0JZU1yCtBMFQPpLQk1zyJ48Zcmc0B7bDGRci5PdRcRS+hC9vepSLkuYgB7oeNczsle6c3LNRpiM9h65CW+aYhcplSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=usYA2RvA; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="usYA2RvA"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250918133758995c7259d20002074c
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 15:37:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=a6/E/q4Z5TABnX5n3+3aK96fgCrK19P540qDR+rvWzI=;
 b=usYA2RvAM+wqo28kd9RNnW5cS6FR0Zpi7Mb4X2XxF/dc0F70jjrrwou6a47Cs6RMiyKp02
 1KAPW9e0TYy4u2DeLWUUnCt7aHmV26K36sNgxn9+0F3fjRdJFVF1t6IcQlUNHzk50TXGMA1y
 Fv+VyyX6k1SmkNCE/9Q4TmA8aJgQJ1IPUv0fHNG7zGZlpap6g1uQWJP8PZlH9sl9Y9UNeEOk
 oue/BP6zbWbGb9ssOv5wvBhhK9wG95oyMdBGThfRaTXZ9/r1910nPSp1QTsDH4FzkdNclWY8
 ogajMVXbkDOi/RxyV0SqpKYiVf2G5JWX5NVhf1IuCBbc4XhpG9VFwl5A==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/4] dovetail: Add support for hyper-v as hypervisor
Date: Thu, 18 Sep 2025 15:37:56 +0200
Message-Id: <20250602-flo-add-hyperv-support-for-6-15-v1-0-449e6c20debd@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADQLzGgC/x3NywqDMBBG4VeRWfeHXDCWvkrpQs2kDhQTJlVax
 Hdv6PLbnHNQZRWudOsOUt6lSl4b7KWjeRnXJ0NiMznjehOMQ3pljDFi+RbWHXUrJesbKSsCbA8
 /+OE6xeATW2qVopzk8z/cH+f5A03sPg9xAAAA
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

with this series applied dovetail is successfully booting up on a
Windows host using the Hyper-V hypervisor as virtualization platform.

You won't get any RT guarantees - that's clear - but it helps to test
non-RT stuff using a dovetail enabled kernel on such a platform.

The following config knobs were turned on during testing:
  - CONFIG_HYPERV
  - CONFIG_HYPERV_NET
  - CONFIG_HYPERV_KEYBOARD
  - CONFIG_HYPERV_TIMER
  - CONFIG_HYPERV_UTILS
  - CONFIG_HYPERV_BALLOON
  - CONFIG_HYPERV_IOMMU
  - CONFIG_HYPERV_STORAGE

Best regards,
Florian

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (4):
      clocksource/hyper-v: irq_pipeline: Enable pipelined clock events
      x86: irq_pipeline: Implement inband handler for hyper-v specific vectors
      hyper-v: x86: dovetail: Close race window in PV spinlocks
      x86: irq_pipeline: Allow CONFIG_HYPERV in combination with CONFIG_DOVETAIL

 arch/x86/hyperv/hv_spinlock.c      |  4 ++--
 arch/x86/kernel/irq_pipeline.c     |  9 +++++++++
 drivers/clocksource/hyperv_timer.c | 34 +++++++++++++++++++++++++++++++++-
 drivers/hv/Kconfig                 |  2 +-
 4 files changed, 45 insertions(+), 4 deletions(-)
---
base-commit: 138f1183deed300fd1f03abb6511635a916b98d0
change-id: 20250602-flo-add-hyperv-support-for-6-15-37378bd63fe1

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

