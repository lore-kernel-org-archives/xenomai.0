Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B561339A801
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417828; cv=none; b=OmRBhKdofi9bV2btU2J/s22zqh0Ji0uqrz05QahFhOMYGoSp+mwaWgj6X31G0hwMgZEk0Hv//4UUIhwtCquAqjHtAHoTKfGwrOTL8W+Lde1omhNOJdHK9YoSQRdAYYFRSz0vcuhAdSpz166S4ofDlgXDREsk2vgLPhuY9mQ3UHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417828; c=relaxed/simple;
	bh=rMhW78V/BuOlqh8dNlcK6E06X059jLpboCu+n9NaEXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RphlOUwBkJMmuBeoL7hcbBbvzmJh1a97TOfUdRTd7VzYN32oTXO4w/4It2bmOzbv6J/6aAfHVqa6429+Y2kYjp+cPXGSj0C1xXxtMDJQq6EUjtwLM4A6DfBZm6hqeY14/7n56ATonBici/oP2vl37Yec9QUN5hxkudRQGiyAv+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=t4F1aCh3; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="t4F1aCh3"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202607070950204f2ca28494000207b8
        for <xenomai@lists.linux.dev>;
        Tue, 07 Jul 2026 11:50:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=VgM7F/OX3Cgwxr3j5zJypqDZsN+bJr/ulH4bc9b5MwM=;
 b=t4F1aCh3/g1TlHFDTPgwPu3NZ/jcLtnYU1wtusnQoAgpFelUiCo//4Wedqam550wfWdPxt
 HlIQ5f1nJ12Z1cGIM3ZophwSNMTHcDWywfAyhBXMdZlxY5xGELWtN9/TBNeCavFsl8jClhen
 W5RkJ+N2Q7byKbiXWM5JK2ozoYLc6uWfB3ZKQst4AmvKci3DYIFBvyMztR+5Scdj+sS8BNFW
 3pJvn/sckrrU/FjbTpSDnHKcA50yUKvUdwtq2zMEjswZiM9JX4CPoKYxhS71pLzXFjXlizse
 OeJT+PJCimKfePZkvLbY9HpODTi6EBzn0BJY48K5zpT17aQV67933Xpw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 07 Jul 2026 11:50:18 +0200
Subject: [PATCH Dovetail v4 2/8] arm: irq_pipeline: Fix
 dovetail_fault_{entry,exit} bypass in do_kernel_address_page_fault
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-2-057b8af5a2ca@siemens.com>
References: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
In-Reply-To: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

In case do_kernel_address_page_fault() was entered over supervisor mode
the dovetail_fault_{entry,exit} machinery was bypassed. As a result the
inband IRQ mask might have been touched from the oob stage.

There is another problem with interrupts_enabled() in the supervisor
mode code path. That one will be addressed in a separate patch.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm/mm/fault.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index b6b766652b753ef860d16b153685b0d3b582bffa..08ebc043971000fd8d6245bcbb6c170d801c73b3 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -332,6 +332,7 @@ do_kernel_address_page_fault(struct mm_struct *mm, unsigned long addr,
 		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
 		dovetail_fault_exit(ARM_TRAP_ACCESS, regs, irqflags);
 	} else {
+		irqflags = dovetail_fault_entry(ARM_TRAP_ACCESS, regs);
 		/*
 		 * Fault from kernel mode. Enable interrupts if they were
 		 * enabled in the parent context. Section (upper page table)
@@ -344,6 +345,8 @@ do_kernel_address_page_fault(struct mm_struct *mm, unsigned long addr,
 			local_irq_enable();
 
 		__do_kernel_fault(mm, addr, fsr, regs);
+
+		dovetail_fault_exit(ARM_TRAP_ACCESS, regs, irqflags);
 	}
 
 	return 0;

-- 
2.55.0

