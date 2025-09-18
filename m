Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9AF30BBB7
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202921; cv=none; b=PlVNtOJIqscvcyp84eknv6sBxeUi02o82B9d3K72P4DjKc92OzoGpHpOnllfSbnb0OkYQOJgcnH8zqwdpWi5tx4pHzKvxvKhIBbi1SswdkBMws1Rc45GpN2XulPXvI0GOHkfY/2QgRFp0J2bUzxRdrtQ/mfZ5FMEeDhtkdbxjb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202921; c=relaxed/simple;
	bh=zVEE/zHbCPz3/vfI/O4NZP4fa3tn4KApBEAZqyQDvNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=onRG2o0oYndEQARCStbTwCwJyAcwZktPk3sSPfW1bPDnClQypK5PAcfiz2jn2hRDh8UV2vDnva0xMCObGxMEyjtG8ivACCwddVa0K7E1FIswBNUopLqRS2nFMDu6Bc0TAC06KWoicMae8nY4BtyEGj/WNCv5z9A6ZnPX9Fcgzr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=DnHjWE1F; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="DnHjWE1F"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202509181341546d7baf497f00020789
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 15:41:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=f58Yr2D4xIctZyI7yhfNcYqC1s1mZopF7zDXsecM5a8=;
 b=DnHjWE1FKD46En9mq2haEAcdRsmfAEZgLjLhoyNfP48e1ynYHu6lUjg4zP0h8UlD/6tmLp
 3wYtgAWNqViycUTXoDicIzKUcP8qbOf2/PzhB7d3nggqgbx2oHMKBihCNJCY4W4hLV7YgP7D
 9pAAz7IPWqg/MBANR+XyhExuHaHAmWv+7KWVZs09oLNDHo65rmUXHwHcCyVCmtokpz6RbNsu
 IQazB9SixaXchg8QjMbv7uKJanbgaUobt74txuxBV8rTceH1vVIQjIDAJgJUk8jd6RI/YmcJ
 ZMvEK9yiP8lenhBZS0yjHZHMrubCllYfafmC2EbqRG9FFHtuN30YOtPw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 18 Sep 2025 15:41:54 +0200
Subject: [PATCH Dovetail 6.16 v2 4/4] x86: irq_pipeline: Allow
 CONFIG_HYPERV in combination with CONFIG_DOVETAIL
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-flo-add-hyperv-support-for-6-15-v2-4-f1c802b1aba3@siemens.com>
References: <20250602-flo-add-hyperv-support-for-6-15-v2-0-f1c802b1aba3@siemens.com>
In-Reply-To: <20250602-flo-add-hyperv-support-for-6-15-v2-0-f1c802b1aba3@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
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

