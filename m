Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C79CA52
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203296; cv=none; b=Rj1IdSkllVrfuRO4o+L8j3/p5lactufoube3OyQcSxrFxHZk38Pcg8xxEBVms2OhmPCUwp+HNxc3cmpXKLqWd4+HFLPoFveWsfNltchlbizWPCmAPqV6BN5JYyu0Hl66nYTypNdJinmLIDioAxx7Pfe+3g+zaxzhKhSQygT7KhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203296; c=relaxed/simple;
	bh=zVEE/zHbCPz3/vfI/O4NZP4fa3tn4KApBEAZqyQDvNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iV2uAG1xHgZrruyq2K0XPKPT/x6bu13cHGpm0hhWM9nB6oG+2EetlrBF2ZrnMTQ97oIFH2CZdmfJh8+qAHZwERAIUngwmut9mXvYomOk/wgPgMdwu41F1I9AwwDlW0FR1jDYIjcqCBBCxVfgr+dxc5Gab5RuUAFvpHJhn0dPkr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=L1YHbHWj; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="L1YHbHWj"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250918133801a93ecfaa2b00020789
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 15:38:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=f58Yr2D4xIctZyI7yhfNcYqC1s1mZopF7zDXsecM5a8=;
 b=L1YHbHWjp5d7hsbsqUpO7DVPSV+hOGFoaZZeMcw8hrPUAhGWQJq9FnFsVJXEVisKNZFios
 DK3ELMvOSywzlbxwiN4suwXl1k9kinAd431V2Mvs9mya1x1GWM0pcV+zKPhstC37h3A+wAAW
 rGiOVx7CHGBY29F0ZTQfMms+J0ixVw9lXAqrtncimWc09REaHZnrrzQWxsoBEy/kRFuQPMSI
 ch4IwP346o7BFi+zb093acDON1bfWXMYvMXJy0Zg5dpQnFqz2sYjYyzRhKEu/+xASbZX7VxB
 mDUwoHD4PXCOQM2pI6VhNIiq3FmGuNlaZwpDMlTzI9Q7lVnNJH69m9IA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 18 Sep 2025 15:38:00 +0200
Subject: [PATCH 4/4] x86: irq_pipeline: Allow CONFIG_HYPERV in combination
 with CONFIG_DOVETAIL
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-flo-add-hyperv-support-for-6-15-v1-4-449e6c20debd@siemens.com>
References: <20250602-flo-add-hyperv-support-for-6-15-v1-0-449e6c20debd@siemens.com>
In-Reply-To: <20250602-flo-add-hyperv-support-for-6-15-v1-0-449e6c20debd@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

No known issues anymore, so we can allow that combination now.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 drivers/hv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index cf9cf77ac2187..6c7e76fd1b01e 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -5,7 +5,7 @@ menu "Microsoft Hyper-V guest support"
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
 	depends on ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
-		|| (ARM64 && !CPU_BIG_ENDIAN)) && !IRQ_PIPELINE
+		|| (ARM64 && !CPU_BIG_ENDIAN))
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
 	select OF_EARLY_FLATTREE if OF

-- 
2.39.5

