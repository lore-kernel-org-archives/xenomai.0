Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0293838E8D3
	for <xenomai@lists.linux.dev>; Mon, 22 Jun 2026 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115552; cv=none; b=W141myQgEFUcREVAYRzZfokOSsabFXJKOL37gOOpyl1qlxlEDh+c0GzQWY/joxJtm6HBDzlc4BLPySGRmhkevd9Oeq6b1p9T2guvAbcQom+cwPqkd5TdpR/1OMSeOKOaGTi2z2YTNpMHJL8YJ2q9Xn5Z2kuIPPzq5SQ+WQQe1AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115552; c=relaxed/simple;
	bh=Jvfooe2wQs3TClZ8jYqaxdURfT+bWkNyt3IgqucFp0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKj0NQ/Hp8C6EWmvlZIfcsyyMn5xRGUqslcUQeVRSKNrfahqFItPjTlwnMvaPlrhfZufdHr3c+3Gede8ZVdt2Y47FUmIGwE49VxyMj1zkZE+2awnysKzmL9NXX+IBXs1OMB4Uy19+02+1AvD8JiZuHM/UH41Lo1OEg4cjTZdSVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=hbIQf3By; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="hbIQf3By"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202606220805384a78faada40002075e
        for <xenomai@lists.linux.dev>;
        Mon, 22 Jun 2026 10:05:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=A/MvjFjMafmCEZgyjTmt7qS0VtzBZckd4ViP4u0OFYk=;
 b=hbIQf3ByIxqSxz+/YvProbC3pmDohUz0QmVIZQHINMpC60uyna2pwh5vIhYz70Qc6eIPyx
 V1EXVQbu9sHsvBGERDxu/eoKIu8ytARVOjMt4MqVw03Q8ZNQrJM53BepSl9ZFbyIck45b12b
 UhVrb/f1IKMymLS1ST20qKWZAuhJ1fjRyQWnrW28FupTrgRa1J92PPDuiyVKLqxMn7sEYDXV
 bzk9zfk6h68dnNKdIu8UbJfWc5XGLAl6w7PRxIGVZJrGqilJuSOru8onoAs4DF1k40vRjx9F
 Ma++JDhxDuoC3jZ1gxzA3TLbJ+ZGXsOndV77If3xtApEheMUudJ309rg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 22 Jun 2026 10:05:28 +0200
Subject: [PATCH Dovetail v3 4/6] arm: irq_pipeline: Fix ordering problem in
 alignment trap handling
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-4-230f03227abb@siemens.com>
References: <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-0-230f03227abb@siemens.com>
In-Reply-To: <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-0-230f03227abb@siemens.com>
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
 arch/arm/mm/alignment.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 76f2716635b73a0001efc3308777fc6a3bd712ca..37023b96a468531c026ea5f6c47d25f3d49fd6a7 100644
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

-- 
2.54.0

