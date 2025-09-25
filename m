Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326EB1FF1AD
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805558; cv=none; b=E7Hm5x4coFsKZXX7jA/cVnjh779xr7udqkGr5a6vHSmz9Aot/MGqUaIG9DvxE6tVfTBcrXo2ry8U+4Ubp2UHPscREb46ECPP90naCWBYoG3vFq017guZFCV3mzmZuaZXukwHxNOBhthC7si/5vf+Ka+sOV42kvNshgdeK01IeT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805558; c=relaxed/simple;
	bh=HTWzdrYdR9TrPwtmR4duq0QTgHjU6DsFaWn3xy1rusc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pTr75ivn8+FXPyadnM48jc1UDkdg2XJNbOb8Nh3QBGgC3pANYAuS0LUphN4Q8oD39PcZRsV3/gDUG0AHZKS4XgnT5XQPcD8rhntunTRZZwlBmM4DGTInS27vc2bp21A4wp7onRQNcPWJCObGMq8xZDN5tjo/FndK/0tRPlmxjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=nBplwiRa; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="nBplwiRa"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250925130547fc8b0aacbc0002073d
        for <xenomai@lists.linux.dev>;
        Thu, 25 Sep 2025 15:05:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=KIXyQm7qmadoQ2GNWU9uRp1dxH979szgOY4x9TnSMLM=;
 b=nBplwiRaoVyHxTvSUPb3i6FkDARdE3Ldx73JH5326NWhnhHG8Z/HBG7BjyVt7d1io/eawx
 KTxnzhw0C4NjCcnYuKsZk6/kuZrXBRtF6r9Qye9xJ7gJU2pjQ4w0H3lQaUet23bCkz6pF5Fz
 OQl69pb08MpqqITruwo27a+zko01/h4ev9dKtqm5XMWcxjfqk2iy/BFnraswDjqLlMKOFrQz
 d41fG+4ZFJltVmHQwZsuJoE6BSUSQkIjFcjW8bDx1PuIKlBW/xriip6ZgG3h4cSAnBTkHMAl
 3TNymFgjZ9K358+Syj7fjABAum8FM6r4Ia113uLKMx0elmZQYS4+JR/A==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH RFC Dovetail 6.16 0/5] Dovetail: Minor cleanups found while
 debugging the pipeline entry code
Date: Thu, 25 Sep 2025 15:05:46 +0200
Message-Id: <20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACo+1WgC/x2NQQrCMBBFrxJm7UhTbEjcWjyAW3GRplM7EJKQ2
 CqU3t3o8r0P729QKDMVOIsNMq1cOIYK8iDAzTY8CXmsDG3Tdo1pO3xzwslHdJ5sWFLBwRYaMQZ
 UKBVqY7RxznQnpaFGfisO2QY310xYvK8yZZr483+9w+16EX1c6WXZC3WUCh77/gVh2tjZmAAAA
 A==
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi Philippe,

this is now the end of my queue. Nothing more pending.

All of that was found / noticed while debugging the pipeline entry code
some weeks back. Maybe you can scan that and let me know which parts you
like to have / take.

Cc: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (5):
      kernel/entry: irq_pipeline: Do not leave .noinstr.text section
      kernel/irq/chip: Change return value of get_flow_step() to int
      kernel/irq/chip: Simplify may_start_flow()
      kernel/irq/chip: Simplify should_feed_pipeline()
      kernel/irq/chip: Do not call low level irq chip hooks directly

 kernel/entry/common.c |  4 ++--
 kernel/irq/chip.c     | 29 ++++++++++++-----------------
 2 files changed, 14 insertions(+), 19 deletions(-)
---
base-commit: 138f1183deed300fd1f03abb6511635a916b98d0
change-id: 20250925-wip-flo-cleanups-based-on-6-16-89989cc95468

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

