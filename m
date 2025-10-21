Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B65F355023
	for <xenomai@lists.linux.dev>; Tue, 21 Oct 2025 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049405; cv=none; b=boAi4OTxoBurUlg9wUR13CFkVSlac8DHC+OboKO9CphrAtLDUnU6oR8WxBRCGSXw6t8jCGYbGOC4jUWBqTQVzUeAMjFuN8UHVhZCvWMezJxF5NbDaDfsjWUUqVzhRYCCPHkU/82HDS+U0oVDTubJMzSU2wvTEC7iflUxKkDze3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049405; c=relaxed/simple;
	bh=zVEE/zHbCPz3/vfI/O4NZP4fa3tn4KApBEAZqyQDvNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pnPIfhO426gXe0A2byYHzwoU0UNdgm//IJQJc5/1VL9vYiiJhB55Iw7pPqNUPlhJDZfzGVmDivrbRcFFkntvdiGsx/qlSR6Vpae+JSXyYDlmm2Pl246JSoHmK9ZdY4qxQBgXzhn36Cue8PS1IvxoZA5nbQ0UpcFmv5RPklazBQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=GARqI8ev; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="GARqI8ev"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20251021122313b67542b94d0002072b
        for <xenomai@lists.linux.dev>;
        Tue, 21 Oct 2025 14:23:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=f58Yr2D4xIctZyI7yhfNcYqC1s1mZopF7zDXsecM5a8=;
 b=GARqI8evyMOzj81XaAmStmIwLQ9Bm/ACdnpnf49tSoMRubowiEtyOIfEecJdsiZV3be2Rj
 lBtjkedUFEC5w94gvmMPE+Tt9JCTrT39mcE1qVr7aCXpE2wvSCVbtWhDCZ6OEdOvLUPGljwt
 cS+Dxvaci+xy9p9/+3MPZR3Z319y06py/Gp8PBltWhDPUpxzvejx2+AcawisRv4W85KV+cwA
 pbL77xdLHassxXC60OoxId6EfktfKREIB9Gcy7WL7O9YLYSfbEjHFALY8PTkey11gJ+scUEX
 b/OblN/dLgKtofcWcQ/24t8PHCuKtD7ING0Z2pNOdU5DGN842YBTGxQA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 21 Oct 2025 14:23:14 +0200
Subject: [PATCH Dovetail 6.17 v3 4/4] x86: irq_pipeline: Allow
 CONFIG_HYPERV in combination with CONFIG_DOVETAIL
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-flo-add-hyperv-support-for-6-15-v3-4-f3b45eaed2e8@siemens.com>
References: <20250602-flo-add-hyperv-support-for-6-15-v3-0-f3b45eaed2e8@siemens.com>
In-Reply-To: <20250602-flo-add-hyperv-support-for-6-15-v3-0-f3b45eaed2e8@siemens.com>
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

