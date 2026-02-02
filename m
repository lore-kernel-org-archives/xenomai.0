Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618F72C11F1
	for <xenomai@lists.linux.dev>; Mon,  2 Feb 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018935; cv=none; b=udrXJcP2MCI4Pq9EPQUylssHiKTS4iDoPrv/ecDsICzSMnnypPdGyuaSRFXcqeqdu0HOO1dYu6/A51ZPthw9URX99bWAlttyySmilZoITpFobPwugpprHL75ZjP2sNXlIGXcY6XkRGOdjIK4DBFtyDxUr6RJn36DcFvvWoytJPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018935; c=relaxed/simple;
	bh=HHG5jNmJKUkx3HvIpxMoC1tZcKshjlgNQNt81+NjDlM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fVkLHJDrxg/YxrM/aKbuvlSDgXwjJ6g8OZmX7lXTnLRY6yz4Wp/nyhLtopFpuUO45KXrBa4NDWxNa0KA1BdOY/7M4S6KaF9p+xloigPIYSZes/tRXALr6ZemNRItXJkQJBuW86uQcrv8qr55tcZA6FrvDX8w6E5HKjpQ+HQXzC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=EYwzQtvQ; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="EYwzQtvQ"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260202075521e2a2517faf00020746
        for <xenomai@lists.linux.dev>;
        Mon, 02 Feb 2026 08:55:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=tgOyEzvn7lXx+Sc444mkkz/kQ7/lcOVtn28Vs1vIr60=;
 b=EYwzQtvQgXJFP0mzMcihxACgWRCVzZEQqr3eN1UeSsOtPCazcGTTUZ2ZvbinNmbIWgj/BP
 OK3itt1L3wd1qELM2eBAXIqEwFO818onjRr04w0Rd/m/F3HNcR1axV17yZqLzGjKBWZ5gUL1
 kEwwsRMB+X3bcWufnk8brPUFLgr41WnO8eEk3Nq6te343K70Jek++C+0R45oBQuc1RHFoN+U
 stlF7YzhvWQTlIMKhTlpgXXyibxL8eFz93XW5FPp7ZtlUBhKytY38p61WK31uA0mV0aEnzuJ
 pXDBiHWqqVyLhuTY67LOsPUzaf9/CkgZ3qWj8QmDqODHtVJkAkhMruTQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail 6.18 0/3] Fix IPI mapping for arm64
Date: Mon, 02 Feb 2026 08:55:19 +0100
Message-Id: <20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGdYgGkC/x2LQQ7CIBAAv9Ls2TXAAVrP/sJ4oLDYTQg0oNWk6
 d9dPc5kZodOjanDZdih0cadaxHQpwHC4suDkKMwGGWsMkrjm1dMuWLiD3VMtaFFPaI3k5uMczE
 GApln3wnn5ktYZC+vnEWujf6bmBtc60ZPz/lX27Me4X4cX7W7IU+PAAAA
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

this is the result of a quite longish debugging session revealed by some
sporadic failures seen in CI.

Please review carefully as the code paths around the KGDB and BACKTRACE IPI
are not part of the hot path.

Backporting:
Patches 2 and 3 should go into Dovetail 6.12 as well. Older versions do
not have the BACKTRACE and KGDB IPIs implemented.

Cc: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (3):
      arm64: irq_pipeline: Fix mapping of SGI/LPI IPIs
      arm64: irq_pipeline: Fix size of IPI statistics array
      arm64: irq_pipeline: Fix IPI_KGDB_ROUNDUP and IPI_CPU_BACKTRACE IPIs

 arch/arm64/kernel/smp.c | 81 +++++++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 33 deletions(-)
---
base-commit: c30f265e8ac5feb0b7076141dd8877d0394e1437
change-id: 20260201-wip-flo-fixes-for-6-18-a2979277ddce

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

