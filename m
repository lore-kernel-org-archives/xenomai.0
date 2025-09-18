Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A21E9B1C
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203526; cv=none; b=SlolitD886ffcnxU1zLzb8qp7oT72uemWeYgt2ekUKcJ5SRBuIboF62sp8VVevCfio62tWPrFk6+3CUaMYoNivjfrjgyVOB3fcHG7yC8Ox4ih3a4rCBXtdPDJr34zIs8T0fEtk5tucNaW1ihSM0NxZOc+uprxabB4kCPR2mH3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203526; c=relaxed/simple;
	bh=SaQ5raOv6KMv03ZydXhUSnEHnCF6aZfjh+VenmNkcRQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IJIn/QtyFK/bJ8FSKQ0agLBFwGJzhxoVVCopEymhrYhjN/ikjt06zhTjtCKJMWQmx4Cnh45GVFZFUO/UeSCPpcKjm3Qr1c9aj9KmBlu+hwcIJRaWlrzm5pMEFBDf9kn5yfv8RFC49xCM7V1JPex+BA4zzCS0KKw/gYnL9+YzLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=vDfy+xC8; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="vDfy+xC8"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250918134152440e2cb25c00020755
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 15:41:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=kITz3J1b7CK9P6odJp4egYyyM81HWByAn/RNQr+UVms=;
 b=vDfy+xC8eM/wTGK39SjhZuN9LDS8+q+eTiCSBRkAfDzE6QKXRWrzXgnSqwyNa2t8bHTult
 onxawqs+pB8SquUWE+eiV7u6KaKXNna4HyL1IRvtW9e0ChxHJb9APT1IUzF8yfuBUxWdDeOu
 JjkVXtQosMxPHKxz4Uheq6sAKNVTXlqSrGvJOUBcCptGsAvTrvDLs481T5iPzfasWoHcs9/R
 5xTQpn5/cVwFY2mLk+sGVsJVfOdSfhp7zHnaWTd3SrIoxuwnVupcECulb0gFGLzXW8v87e8W
 dpzuY6801WZKBfQgovAQJp97oW1POz65o3ovQYBiKTn1JkXAiDaciinw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail 6.16 v2 0/4] dovetail: Add support for hyper-v as
 hypervisor
Date: Thu, 18 Sep 2025 15:41:50 +0200
Message-Id: <20250602-flo-add-hyperv-support-for-6-15-v2-0-f1c802b1aba3@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB4MzGgC/42NQQ6CMBBFr0Jm7ZC2QFFXLryFYQF0kEmANi02E
 sLdbTiBy5f/894OgTxTgHu2g6fIge2SQF0y6Md2eROySQxKqEpooXCYLLbG4Lg58hHDxznrVxy
 sR42ywqIu6mtndDGQhGRxngb+noUXPG2kteUp07nU0KR55LBav539KM/T36koUWBZ3kj3Shjqz
 CMwzbSEvLczNMdx/ACP6Yqp3wAAAA==
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
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

Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Changes in v2:
- Added correct "Dovetail 6.16" prefix
- Updated Cc list 
- Link to v1: https://lore.kernel.org/r/20250602-flo-add-hyperv-support-for-6-15-v1-0-449e6c20debd@siemens.com

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

