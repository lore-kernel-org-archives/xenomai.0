Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8EA3DA7F7
	for <xenomai@lists.linux.dev>; Wed, 10 Jun 2026 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083230; cv=none; b=BWMSgVqhHugqog9LD6MofP6nrJZ5ClAPvVnV6hQSvdYXQnKjUy8xvS08PpciVOnbQG/wNVKEofrJtD0QaS8WRXKxxDEHcewvc6f9XprW+GbuLgmAzVQY10Tm2+JZFB9EN9aCKkmMqkFmL/euKtuVtZU7th84HZlqt+Gnj2cdPxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083230; c=relaxed/simple;
	bh=/s2AIYJOFRzEu3hOI1SL4Gn9z+BWz/3iZeNyq7HnqRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e/+e8FktaTLkz06hJS2UN4TUblxWzy1lS9I4vEfXtfcNdnyk0epc3ktdkKCgy6tDMLurcvlq0h5oVd72j68IRVCKr2UXsWYseEnjFCUrXDb4mj0lAA3hGVTB1OuV4ZC+CKkph6z/aErlTZXedfMIUMJMxL4WjSGItVVl+YZbv7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ePCG4qYa; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ePCG4qYa"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260610092014c3fb685d1d00020774
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jun 2026 11:20:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nwWmL+CUd/1/Vwx0NEvhFm1eB7blWtZj0cc+ppHJkrc=;
 b=ePCG4qYaHQScbo3jTEK8ZbLmiU+L8X+jsSEoPf8jQIL11meWMR0Bv1NMUSKG2KJlF4oVXH
 sreWCj1Tl7Qo6NXa8OxkLmDXT5maBK52oCWZxdJjM4nEqI3yg9kDcvCx3iBGvRW6t3/1g7pS
 V/vGG8kKLK12oPWEN1uIl6XZ16qq6v7MbZbBIOa9uCMEvrKZzGwAtT3S4e6Dv5VDm7+UoX5F
 wE2atqTLnbK9yUUYPLF/78k+4JHYdolLZjKB0OnlsOmS+hZlsDrB3yztz+HUMvpQ6Sy11ydS
 s/Q/FF8CJ5OgR44AfLD55m6F6gNL4SuJcUZeRo0/mjfJdwUkrmssGuvw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 10 Jun 2026 11:20:16 +0200
Subject: [PATCH Dovetail v2 4/6] arm: irq_pipeline: Fix ordering problem in
 alignment trap handling
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-4-62c9c477f8f2@siemens.com>
References: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-0-62c9c477f8f2@siemens.com>
In-Reply-To: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-0-62c9c477f8f2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

mark_trap_entry() will migrate to the inband stage and enable hard
IRQs. With that the IRQ pipelining is active, allowing hard IRQs to
arrive but keeping the inband stage stalled.

Moving the mark_trap_entry() above the - still wrong -
interrupts_enabled() to follow the same pattern as in other trap
handlers. As we are inband after the call we can now enable inband IRQs
if the parent context allows that.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm/mm/alignment.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 76f2716635b73a0001efc3308777fc6a3bd712ca..1d457f22a3e7db8b71006b673dd20646847de3c1 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -815,11 +815,11 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (addr >= TASK_SIZE && user_mode(regs))
 		harden_branch_predictor();
 
-	if (interrupts_enabled(regs))
-		hard_local_irq_enable();
-
 	mark_trap_entry(ARM_TRAP_ALIGNMENT, regs);
 
+	if (interrupts_enabled(regs))
+		local_irq_enable();
+
 	instrptr = instruction_pointer(regs);
 
 	if (thumb_mode(regs)) {
@@ -1001,7 +1001,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		 * entry-common.S) and disable the alignment trap only if
 		 * there is no work pending for this thread.
 		 */
-		hard_local_irq_disable();
+		local_irq_disable();
 		if (!(read_thread_flags() & _TIF_WORK_MASK))
 			set_cr(cr_no_alignment);
 	}

-- 
2.54.0

