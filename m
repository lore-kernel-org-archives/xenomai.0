Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556B338F64C
	for <xenomai@lists.linux.dev>; Mon, 22 Jun 2026 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115550; cv=none; b=Dzc9oKlidJnXnSEBaZ8ojkIP1mychJwWF2x6uZcwGm6TXmrxhe8mGGAmtuc2GA4MvNK0ukfAE+rRGrKxomdnkYMaa11n4BmyFBmkRfOUAl1cLQO40jN1Jr2x/+/Tx5ErQMzsybwB6cJ8VgvkmGByYKDRl37ps9slZXZHnw42mG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115550; c=relaxed/simple;
	bh=N6jCMCjlKTYQYNqCtEXX4Y4oX3dvVLI2nwuGxk+KKV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LekbMSVoxxMJd/xZuvmVpA9qArz1fGSjkScz9gepFk/oc20N9xa5SBQy/n2qnmW/EGUCXi7wfeKDX35N1JUq97GNeMiFkb14kylwdqWldQ8x8YHPZeIBahRUutjMdv698Ll8vyJs7zFwpkSIdYRTZGzJJCEJSIHgV4csZQXVkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=is8Zq1Nh; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="is8Zq1Nh"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260622080538200291aa12000207ac
        for <xenomai@lists.linux.dev>;
        Mon, 22 Jun 2026 10:05:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=L00Gaic9yO7ES2F/xy3ZPDjz26jWLY7mYbzVFAsOIsg=;
 b=is8Zq1Nhm18d3BJGCrGM43fWEzZDwUhcQbHNKGe4bF63Yo78lXhTcHyGyjCTJd53sZn5WZ
 +xXN6A7t/5rEXvXx9RNEl6Kxec8bjOaXQ7glVoHsUZFVlIfCk2PMAcVhRBGTRSjDKU8jRftq
 6s2FQzTPF8/3rKkk2/yaEhG2qCoYouVYM3N3cBJwxd9S5kqepYo8T2ayWUH/QhIw2ECYEq/s
 9FLkAj+Ko1PIdNmeQg7l4pwZsJw9iYvM6XcxlrT1NxZAz6o5b8PHQ1GgFGBo9WBBDkBnQgtp
 gEBpX0S8uB6kmpe2zZbP59Hlc2Frlwc84Zw5upk6+wCBmZgVha3Zxr8A==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 22 Jun 2026 10:05:26 +0200
Subject: [PATCH Dovetail v3 2/6] arm: irq_pipeline: Fix
 dovetail_fault_{entry,exit} bypass in do_kernel_address_page_fault
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-2-230f03227abb@siemens.com>
References: <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-0-230f03227abb@siemens.com>
In-Reply-To: <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-0-230f03227abb@siemens.com>
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
2.54.0

