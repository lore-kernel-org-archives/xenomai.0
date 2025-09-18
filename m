Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE11DF74F
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203297; cv=none; b=sebUU0jbRtmHJ971xAXe4zo6F7bEH+Ib2k1IHD0rThIMt9VZc5yneh9n0HRn35Qv0hfMFvGLTKRN1scwDXeaDgsab3S4jlUQmuI9hJxdZhO6UiYeOE4GxeiA5wSUUIQChHOtuoaR2Kz4cbXOBrvVOz8mcx8C87J75R6GP6Igkeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203297; c=relaxed/simple;
	bh=3SghNpil1UgVQwLPfRsaHeOjNRPnhNGMbiDiUd2tV1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rVERYae2QmFs6CMEXdlRdyeUsXZDqwpPberTXfLIw62XHq0aBJeu+z8lyKuaI+VCGePRFtrQpLah0mXGEwnSN188lYnWYeq5kVHfu0XbRBg2bzu5G5ThecJFKe0M1aF8yP3Gs9LXZPZdXRTQR8AH84yps3F7c1khMagwJyieOf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=TK3/KLyJ; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="TK3/KLyJ"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250918133801037a0785640002078e
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 15:38:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=R8qaxBQy7HIy4f8mljECBfZeWYR8Swvw14dF8H8tYQY=;
 b=TK3/KLyJxkNFVy1kiNsHyDueY1TdzYZQ/HyydvZH+A+UOKgsfgkwxCkm3AxJFOBQwvW4Iz
 E0pCtjsQwLkKTH6b1KhegRDPB5Cp3aycQDpvWQzY1ZrIsfjkp3jvVEnTr//rLULmdsWKIKq6
 YChfFrejZ8AxGElRbaLhQ0eBpdZpp+SbdXj0aYOvN4jezospxBd9dV841Q5+EN7Q1ZGqayPK
 3c4Q7yDTpCBVlYafuQ6ZujUnVDfiYQP78jcEr5TSCGLEOA4t2XyHg8+e/X/cSCYs+BPxwhn5
 YlscD0xsNNEneNbRp2/Djy1okZTSbraxfJtQvnBuwnswvBvR0FMqZSyQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 18 Sep 2025 15:37:59 +0200
Subject: [PATCH 3/4] hyper-v: x86: dovetail: Close race window in PV
 spinlocks
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-flo-add-hyperv-support-for-6-15-v1-3-449e6c20debd@siemens.com>
References: <20250602-flo-add-hyperv-support-for-6-15-v1-0-449e6c20debd@siemens.com>
In-Reply-To: <20250602-flo-add-hyperv-support-for-6-15-v1-0-449e6c20debd@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
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

