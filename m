Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4A8218592
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805556; cv=none; b=ij5hJezyzmyGoMAYdyjG50gT/wDrPk9VL/sADEV7s0wNoV0bxEkGbufBek1mOPMKBhA177oDrXrmUWGPjN49zlHANZYB38NAxZcHk1/v0RqmDV41LbLIBGDRoQruSb1t4/tZfDoZF5KJLeQzihV2I6Ot8fbOrbPYIQMBM92FM/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805556; c=relaxed/simple;
	bh=HtnJhtaTFhFacQdJAhSQ0p50/+CxQ+nT8TJE0I8GIuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQWQNlBfnZGNfs0NSRQzdGPhzWyiFmmFBSdGmoA/F7dZHlZpEqoHAig4b728iN11UhAa4kjlsU9rGUYyCrz4QRQMAdgAqLGp5drpPISBz3XgZbUuu4FPiJ9GFdytgAoNVjx/yKw21sreIRpfkNAWX3MLULt4hF4YPVmNo3Hn7Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Os02fL4e; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Os02fL4e"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025092513054979095c30c100020765
        for <xenomai@lists.linux.dev>;
        Thu, 25 Sep 2025 15:05:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=H2uvYcv/qdfjbnvkCmNeirkyL0pfgiPllV0/Ub+asVQ=;
 b=Os02fL4ev+90CKN9o3X0/zxvJvpIzPdim5idzHTJZW4bMkSyt7YZygJ9yo2RuvVNNwzSLX
 OVe45/zw4D2i9mXb/y0GqoPJJCPnGRL/+Rieqsad5In+iuJulA+8CFcEVgv1QqQow40BPb77
 HBglng2RrWuzCtBG+kJTnx7Ve9zZieeY84Oa+cb6FoHAVDGYwEvA9x4vyApcexIl6q31ohfb
 Lw/A1cDg6vdF2vBA/RUT4zBexlB5XhNtSwQ77fskvNUjUfB875G8tuwepWHuk91q7FE9s1dE
 KtT01fdiIZL+AEfZEH1qnPtUaTSgyOO8j2+SgR7xfUUXoYJ4NFaz09Kw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 25 Sep 2025 15:05:49 +0200
Subject: [PATCH RFC Dovetail 6.16 3/5] kernel/irq/chip: Simplify
 may_start_flow()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-wip-flo-cleanups-based-on-6-16-v1-3-8c4ac7b52cd8@siemens.com>
References: <20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
In-Reply-To: <20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There was something like IRQ_FLOW_PILEUP in the past which does no
longer exist. We can now clean up and simplify may_start_flow().
No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/irq/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 5774fd96ec6c5..8593cdfb6e2ca 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -479,7 +479,7 @@ enum {
 
 static inline bool may_start_flow(int flow)
 {
-	return flow != IRQ_FLOW_REPLAY && flow != IRQ_FLOW_FORWARD;
+	return flow == IRQ_FLOW_START;
 }
 
 void irq_clear_deferral(struct irq_desc *desc)

-- 
2.39.5

