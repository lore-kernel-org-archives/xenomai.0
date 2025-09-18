Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD6021ABC9
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203526; cv=none; b=Oo4FNAFiqxHluck/3mMDEJotg2X6A+33rChqNS188uXj7GULkNIha1sK6Kj8EpJ7Ti8/A5+S7IE8p7Uo1ii/hPQTW7xgf4nZGmO+J5lM0oh9juQKtWau/rQOUp7gST1k9RT3pZ4+gBE/9f9og4zLa6UhuNtn0Qn0KAtxkTdZBp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203526; c=relaxed/simple;
	bh=3SghNpil1UgVQwLPfRsaHeOjNRPnhNGMbiDiUd2tV1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3pMNlJzp+PhGya0k5ZNt6ijZhuBSfFI+yfznqU8orUZYLe6+zbcYCAoiWXwBCepRdUHVDQXxCc1RfgyZG+j8W3Rh8lESXJEcRkUZBPgG6pWw1RL/IM12eWUiBnj7qj6Ev8SSMfYMk73VNvnOzDZIsCtD9oSlMdX22JIg4YxFH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=RZwG6Wxa; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="RZwG6Wxa"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250918134153a5a3ee119600020769
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 15:41:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=R8qaxBQy7HIy4f8mljECBfZeWYR8Swvw14dF8H8tYQY=;
 b=RZwG6WxaZTSDikscEO5dVmXSYQnQ8XCUD45Eyuir69lAJ/a/8kCiTgjuzgygIUG4VITw53
 zIPrmxXaVWB8CX975cKkiCz02kwLyPvDGLz59hAjtAfiseJUSgzORPrV2Jlbo3ILbWlhHuKc
 9PJSuhhZtoaRzU5ZPy5GtTWFPJFZ0TxIQ+xj2FdG+QjrDO1Ln90VH39HJUTr3WyLrLYbliGI
 YIAagIxqYQ4ZIyWY3V5GRu05dUuFPK1qOlCK8+C8rYrilUtWydP6cqt+V3tTbKzh3AbIOLZw
 pG2AuSLI6j3J3yOuvA7k75fxO3M08+DmKro3FkJiGGBNiFbraOJqi7eA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 18 Sep 2025 15:41:53 +0200
Subject: [PATCH Dovetail 6.16 v2 3/4] hyper-v: x86: dovetail: Close race
 window in PV spinlocks
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-flo-add-hyperv-support-for-6-15-v2-3-f1c802b1aba3@siemens.com>
References: <20250602-flo-add-hyperv-support-for-6-15-v2-0-f1c802b1aba3@siemens.com>
In-Reply-To: <20250602-flo-add-hyperv-support-for-6-15-v2-0-f1c802b1aba3@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Stalling the in-band stage is not enough, we have to disable hard IRQs
to avoid additional instructions between the comparison of the value
and the rdmsrl() - as explained in the comment above.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/x86/hyperv/hv_spinlock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index 81b006601370c..282a0c69c9110 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -44,7 +44,7 @@ static void hv_qlock_wait(u8 *byte, u8 val)
 	 * into 'idle' state by the hypervisor and kept in that state for
 	 * an unspecified amount of time.
 	 */
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 	/*
 	 * Only issue the rdmsrq() when the lock state has not changed.
 	 */
@@ -55,7 +55,7 @@ static void hv_qlock_wait(u8 *byte, u8 val)
 
 		(void)msr_val;
 	}
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 }
 
 /*

-- 
2.39.5

