Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D713D667C
	for <xenomai@lists.linux.dev>; Wed,  3 Jun 2026 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501668; cv=none; b=cPLJU1Ax+wZEGFVncNxzw2QlKzwEpeAwQBXgCeaMHXoTed64hGO9b0CltKINTQMFHqe/XniqHIDpxpgcLv+1n2mosD+xs3/YayZwOzVuQKL6aSZCIhepBhG1AnYwb6kvMUMZRJw8VFtO29OYxzXNugdMIghBTBUsYqpkquz8UZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501668; c=relaxed/simple;
	bh=Z4pfJFDhdt+HtgmQYoqyyZoB4lGGkSuxV7k1EqR30As=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZypgGkNAGR85Fy6SVn61zeyJg5eJoZCC5xAAwpqE2TdVMyl9pPKy8P4y8qMNlXoeOGhurfzzLvVX1+NXfQprn5HkYighbX2LWdaNyUwEnGnxGWvY8x+epk6cct1cOCZt1wp6W/jvNHQfU/e9kTG+DhLhi05SEgtwoAUF0YYCBMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=T8YEpRDn; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="T8YEpRDn"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202606031507244fa86b6262000207d9
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jun 2026 17:07:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=i8SYN73a2oZxNEB3HfJ+oIIIslAJ178SYR8KPaIa4O4=;
 b=T8YEpRDn2XS1K1S820KrcK7TxKt2P4ijjlhtrN4Bu7ou3BkmepJ3KU54wykiy/gLMJB1dp
 fsD3jSUa8G2wlty2sYLRfiXvcC+4bdAhMVpkho09DPo9QU4j67RBTlRfUNZzFgcnBbZznihg
 m1pH/B0maNiW8nVyAw3G2bayLiJWQ0ANm4y2KyMKMu6tF/IURhaMptMOzhl/xBaOBMbQffXC
 /Lm2uM/NtnymSCalko97dnPCGTX7O1bsi0rC9boyK92BCbPzMbHrZkxRBSOMDJVGouEinLeD
 Uk8s865Z69zi07IBLxbDiNEmR9nKRf+eoShsrXjmyOo0FvTdZ+HtdWAw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jun 2026 17:07:16 +0200
Subject: [PATCH 2/2] arm: irq_pipeline: Fix fault_{entry,exit} imbalance
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-wip-flo-v7-1-arm-fixups-v1-2-c28b4ff180ed@siemens.com>
References: <20260603-wip-flo-v7-1-arm-fixups-v1-0-c28b4ff180ed@siemens.com>
In-Reply-To: <20260603-wip-flo-v7-1-arm-fixups-v1-0-c28b4ff180ed@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

upstream commit
c16af1212479 ("ARM: 9328/1: mm: try VMA lock-based page fault handling first")
introduced a new exit path to do_page_fault(), so that an imbalance
of fault_{entry,exit} can happen.

The commit was introduced with Linux 6.8, so all newer Dovetail
versions are affected.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 4beae304c0269d11173cd3b360cec05e59f30d82..49f5d628c4c9a91a3e879af0d541fd76665d78fe 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -502,7 +502,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
 			goto no_context;
-		return 0;
+		goto out;
 	}
 lock_mmap:
 

-- 
2.54.0

