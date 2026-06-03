Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8617385D64
	for <xenomai@lists.linux.dev>; Wed,  3 Jun 2026 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499255; cv=none; b=Les/Z5z76ug1Z4ywNDeJ/wMGuWAcOVqMVIgQ32n9fYwbThxHB3lcVfP3rSvwvWgcgNwlB8EHgIIA9qnJ+CAw2EuXoQij3SDazbjSB+3KHoco1EnOZZae3LASas2E1tLgoZEE9H3N1zC9BQ0PwcfhZb+g/IrwhddHi8BjDbnd9ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499255; c=relaxed/simple;
	bh=BOVLTpRRyYJl9GmFDzO/KpA7YC3KRK36X3atvUH9dXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r7OQW5ghWOndOb2fo43a5bcvfdm0KmjwzvXU7/RDYPviIG8B4hR8J4aYnT5h63zOp1DJdBbqb9KAXZCFWNr3rIt3FvIPDLohyv4bqMQXLRbOmcPHgkbKDwJVssLIJJivToY9CW28b/g4t5k9IsGTj7yNDkD7CaVW1Y+LShtvpd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=U4myOH4a; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="U4myOH4a"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260603150724ed1405e8640002077a
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jun 2026 17:07:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=TMmO+cJmuBNau0NZYW2HhwDLeHl89Iuk/3/vxkkwUIc=;
 b=U4myOH4aOoFPgvplbrqhtPYy7vFm4JjWQe9doQDbsoZIdrWs2Mq4AnIrBjPFm1H4zq+cpb
 IlH+PbxKgLWeNKDuDyDr9yS2smySFfkaj41iTTsZHpB0x8Cpn9JQGouPoEb9pCKktubu/vd9
 B/a0juXHdxEEOGNiUatu7/wRGyYf9NzU6djDQ0HUwp2/2McBjQJbtDi89Fsi+0qcPl+X0lNP
 tpX1ONsciC+ZrPFZCytC3Ut4/VB6lZxIGU+TBG8n0DxGQg+q5zjewi4CK+T4GrRxvSQ1i7h3
 nQ/9y+sBcYJdmK8laFHjwa1Q1zfrZkIZyTA/xoHNTkLWQfYI8Yi2XNrQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jun 2026 17:07:15 +0200
Subject: [PATCH 1/2] arm: irq_pipeline: Fix fault_{entry,exit} imbalance
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-wip-flo-v7-1-arm-fixups-v1-1-c28b4ff180ed@siemens.com>
References: <20260603-wip-flo-v7-1-arm-fixups-v1-0-c28b4ff180ed@siemens.com>
In-Reply-To: <20260603-wip-flo-v7-1-arm-fixups-v1-0-c28b4ff180ed@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

upstream commit
d92725256b4f ("mm: avoid unnecessary page fault retires on shared memory types")
introduced a new exit path to do_page_fault(), so that an imbalance
of fault_{entry,exit} can happen.

The commit was introduced with Linux 6.0, so all newer Dovetail
versions are affected.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index b4bb33e1638cd67ce2b6c0b90a4a9693e784bb3e..4beae304c0269d11173cd3b360cec05e59f30d82 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -539,7 +539,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	/* The fault is fully completed (including releasing mmap lock) */
 	if (fault & VM_FAULT_COMPLETED)
-		return 0;
+		goto out;
 
 	if (!(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_RETRY) {

-- 
2.54.0

