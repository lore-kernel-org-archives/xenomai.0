Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD7A21578D
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805560; cv=none; b=HHJ2LsoCdqeqWGjoBIPSMbq/I7wqLWNkc0PB/l1cw8ZXndGunILHbTJgr1XIm9HCzZETNdTJcAWebR4e7sfT4J9SmWV2Fi5fUPk/scUhEcrTYzG8SN6emp04DBXUfgs8anleiywMG8Qt3KWUfEPmhVLxUgurax+KY01bm5aW+fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805560; c=relaxed/simple;
	bh=JK8Yt/0TgXQnjPhN1LrUkJtstCsBiMz3qxGqxzouEqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZOT7ANbGiF0VE8YgT/Fgc5d+Qy2WuZO79PUUvKPauhRm4feKznOYB7gaoxAnaoQdHkcLhKhZ6a37CePrhVkYFXtEl8XO+xTeyxCqXUz0c1qXZTwCXxDpUpIZNPH155L46OiCIV66iSH6ykM6rg1F6QD7ozItJ0eSfrjDby59LYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=s0pgfJ5g; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="s0pgfJ5g"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250925130549dc7cb2353c00020773
        for <xenomai@lists.linux.dev>;
        Thu, 25 Sep 2025 15:05:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=6qSVMxPUVOJs9Dm1b2bOgoN3a18BnK+pr6fz/EDNv0E=;
 b=s0pgfJ5gzUZofK5ldTD4jaNDOP/PWzxpdgMEeK9jHp20kchqcIljBEIZi0VrFlhFqCFCd8
 H9YxTaF9se3/bsMmZVhTtbivUn60mxknT806+jiKWwnGvrOLNN7+k2caWuUA9mtDU4ZppKyV
 2+UfyIiBXChZxDTWveEn9RZuJRQeEwL/kaDV7KwEbJGyQKPYIMOEwBzIGTbYuiHG2opMOQKX
 I1/kvajTlrEckurdRveVkCde0duT/oBnrLiWoXZLgt3G4IXL1v74yktKauOKsH+1REx+LmQ8
 7k9cxtQJaCFFxgyG1kBPNUGtsH7WoF4JWigmbEC5IvCD1t28j4Wy/FkQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 25 Sep 2025 15:05:48 +0200
Subject: [PATCH RFC Dovetail 6.16 2/5] kernel/irq/chip: Change return value
 of get_flow_step() to int
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-wip-flo-cleanups-based-on-6-16-v1-2-8c4ac7b52cd8@siemens.com>
References: <20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
In-Reply-To: <20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

IRQ_FLOW_* is modeled as enum, so the underlying type is int.
All callers were already using an int typed variable to store
the result.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/irq/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 12f520f6a1972..5774fd96ec6c5 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -578,7 +578,7 @@ static irqreturn_t forward_irq_event(struct irq_desc *desc)
  *   IRQ_FLOW_REPLAY since only the oob handler may request
  *   forwarding.
  */
-static inline unsigned int get_flow_step(struct irq_desc *desc)
+static inline int get_flow_step(struct irq_desc *desc)
 {
 	if (likely(!irqs_pipelined() || in_pipeline()))
 		return IRQ_FLOW_START;

-- 
2.39.5

