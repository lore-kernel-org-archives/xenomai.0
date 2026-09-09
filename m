Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DC34F55A5
	for <xenomai@lists.linux.dev>; Wed,  9 Sep 2026 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964392; cv=none; b=HXefuXdwnXYNY2h2+YRqw9MwP2PZeZPSCBXYmjoR25ayTJns54GrNuAC3NlWdaxjKI2t/osU2Rt3ZnIt7vNEqpg2FFJ8G+wOWRET+hm461e5x1RAfq6CIztPptF5GT3NZUOo3rmXSed2Z5s0Ar9StQHQl5ykP5v34eK11SC/JTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964392; c=relaxed/simple;
	bh=lx0JtMZe8KinkHQWoF6POkq2GjjgcsN4OGmO3HnCRcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NF2qoVTYNG3YhALzpERYrm1rNYPHHDKzfVOsqUGvHj7wThcEHgBsEI615XyD8n4X3OWw18kNYzRedci6ZFbWwqQeDagVovMoLVvJyP6IV6NIEgjD2yzK4onTvAoarh/GxOs1S4KeXPodQ1W4FGCBRfPf/eXBOFIuBnTHg23ACbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=BdHR0bcK; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="BdHR0bcK"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260909143301bd6d032d5e000207d8
        for <xenomai@lists.linux.dev>;
        Wed, 09 Sep 2026 16:33:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=plC4RZK2+okEmm2Fk971xgyOUv4MJ1Io0N1uSXAzXPA=;
 b=BdHR0bcKb/DPb0bwT2MowcD0/XR9iqTWAeLgOSWY1NLw9MNKN4p3BRhjvqtMczOphr1UW1
 mk+GBOF45kuOzDYXUtSMnRmsJzQwq0d3f4kc122gjW/NCEPz3gsIGPYQIcDqjqVejU0Q5fgK
 UOfeuGrHxNecM6SNZv6ouS96Zodo/mfnC1JBcK9hChN5CExYH/cmhc4d5ImI2YKTb9a4Ol6p
 xR+VsC3WaqGXu+3a9ZDfs/psGb/PqcE2N6ISnhoqwje5f6EQWD0JNphjQIEiFgcmT4gKNYgw
 8yCE+ygEvchSDTs9y+6nJ71PIBV19xc7kVjXD23g3JVBJt0pqXpDQV2w==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 09 Sep 2026 16:32:58 +0200
Subject: [PATCH Dovetail 1/2] genirq: irq_pipeline: Remove irq_is_oob()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-wip-flo-v7-2-irq-cleanup-v1-1-825a908785ae@siemens.com>
References: <20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com>
In-Reply-To: <20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>, 
 Gerte Hoogewerf <ghoogewerf@lmi3d.com>, 
 Andrew MacPherson <andrew@elk.audio>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There are no users, so let's remove the dead code.
No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/linux/irqdesc.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 260ffd288bd8110b810540e2998966083cb9bc25..b8347550f87f75e1d3f590502fbcc6a6612508e3 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -269,11 +269,6 @@ static inline bool irq_is_percpu_devid(unsigned int irq)
 	return irq_check_status_bit(irq, IRQ_PER_CPU_DEVID);
 }
 
-static inline int irq_is_oob(unsigned int irq)
-{
-	return irq_check_status_bit(irq, IRQ_OOB);
-}
-
 void __irq_set_lockdep_class(unsigned int irq, struct lock_class_key *lock_class,
 			     struct lock_class_key *request_class);
 static inline void

-- 
2.55.0

