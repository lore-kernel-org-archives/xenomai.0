Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BA338838A
	for <xenomai@lists.linux.dev>; Fri, 12 Jun 2026 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781299056; cv=none; b=FV6CE6v8KUnpp8mGsJDBEMM95NRaywOrQGvJCiKiy+S9U7n8Q/plpV3bOQG9L1MuJjcfNFAUcKsNYydzLjHL/0hiewxb7bUPC2UGpBhYuRzalS882PhfrAr1+UN7JJRVhWd+L26BlRXSFyjpdltyEN3TjqVWMCwYp5I5CmiP3ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781299056; c=relaxed/simple;
	bh=eS1vDaMA9VjQ3e6t3ijcR+l0AjI6ezZjZXQY3kyV9OM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tAyzFobM3cVLw0B5E11Icl7ERHddh5283YP3IBK+VUi3rh3wYIj3jLRUlvBZFuUhKefL/SquYQ5t+c0GjJsgpSB6Bc+UcDypkSajEB9y3/Gyd3oiV5WNjwVupe4oU9E1PfITTs5XADh2OB9UCRJULZCOQhAAZJ3SBLoCNFBXBQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=dyHiQOlF; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="dyHiQOlF"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202606122117220de4708b13000207bd
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jun 2026 23:17:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=rsQVeoIMvewAKR+JRirgZPrEWBAEjdZRAIe0mmvrKdk=;
 b=dyHiQOlFgJTj9/U9gK75ql/vSvNmPjnXHdH2p8xgKN1xo18kjPzLRZRbSLsr3y9RBA9jIv
 Ot9Ln331meupnC8+pCVnWrwSbKPFWwa53y2RYE1j9OL/L/gVw6C1Hq7JSbkji8fMB4ybrUqh
 Xq29VO2KgtUeoJb1UJfELVSTDKQnF4RqlMoEKixzjJvA/jC7jTANHGgqme2sClByOv7fpyV6
 ykhVhvi74CnIXGbRHIxVtyp/3al8UMMs7WtxrMKYfSPJdC19f42ar3ZhVVFzFKjCbas2jfTx
 D2tLaIRElMGn6KnVeFu3+11cHktwqOX7HNnILzYEYBiTZP8phZj9rnGA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev,
	Philippe Gerum <rpm@xenomai.org>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] x86: dovetail: Call trap exit code with hard IRQs disabled
Date: Fri, 12 Jun 2026 23:17:19 +0200
Message-ID: <20260612211719.3054905-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

mark_trap_exit() should do the reverse operations of mark_trap_entry()
keeping ordering in mind. Especially as oob_trap_unwind() is expecting
hard IRQs to be off.

Seems that this is a long standing issue, so most likely all currently
maintained dovetail branches seem affected.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/x86/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 6b5b33b4d511..8d1a7889626b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -354,8 +354,8 @@ bool mark_trap_entry(int trapnr, struct pt_regs *regs)
 static __always_inline
 void mark_trap_exit(int trapnr, struct pt_regs *regs)
 {
-	oob_trap_unwind(trapnr, regs);
 	hard_cond_local_irq_disable();
+	oob_trap_unwind(trapnr, regs);
 }
 
 static __always_inline
-- 
2.54.0

