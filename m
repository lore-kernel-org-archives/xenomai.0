Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43BE3D9052
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417833; cv=none; b=pxcXhCHW9kWqe4jDbpcaqClCZw0QvNzFzASwObNCZACxMpoxOBpzlghEi/9CtSVj/nIdyudqbD871ghyFCJfPM5uZpl+HpWkVM//4Lz/tCATWICm/Z2agWXNndjokW0EMs/bUDbwJsoRjy308v3ESWC6nqlHjpUyMTNCVZU7tKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417833; c=relaxed/simple;
	bh=zLPvHGFoVGB1bYr/Fs4splVHGZnfm4f/N2pmSRotm8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K53Ehrac04HxgCX9Fvg8SmMFEm3OgKFBi1n4E1P/IlrY0DinhlMXQ8qEWfScuudTSLwUUPzwT+hQjzQz3/RvpKs25sIGLOAjwSYYq/Hp2PcHamhCZK+JTrWyjyH5LPko4SCrmsP3VYU6tItduHFaqvuhRYIMbJ9NtX/QstN9yUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=hIa7lrLj; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="hIa7lrLj"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260707095020a34474866a000207a2
        for <xenomai@lists.linux.dev>;
        Tue, 07 Jul 2026 11:50:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=P1+TeLZUspQ9nEbVQHR94WZnVko+cc1C8GGhpi1LMyM=;
 b=hIa7lrLjLOiplYHwLmQZhhW1MQSVjWlPEseQl+zmUWE8HwypE6oXzdCntOxqXptZ5+hQWh
 qG59ZAAXfi415nDYaJ3mV3Gi0eQ4tIbPfG/YKfpoEsLvIYdJyi8PnbKGuWT486GSnxuAkUVd
 Q8RIvq2jzRF6zFcUWwiH5aFBkUTevKZJSA4Nw5bg8BqMKKrvlK5KJ6JgcRgJ83JZxkCFzrZr
 5fw5MrhuwruRcc4FoEkWun3ei9dI7DdJCf+XBUDF1Ze+jMC/XVTGfuW4CqYfPmAstt9Z4xKr
 9AhEKKPeo1LBQb0nK8dUbkNDA+8nlhlulpGXTXOR8RMSFvTpN692c1Ow==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 07 Jul 2026 11:50:20 +0200
Subject: [PATCH Dovetail v4 4/8] arm: irq_pipeline: Fix ordering problem in
 alignment trap handling
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-4-057b8af5a2ca@siemens.com>
References: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
In-Reply-To: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
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
2.55.0

