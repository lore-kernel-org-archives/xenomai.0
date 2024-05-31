Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B5156F46
	for <xenomai@lists.linux.dev>; Fri, 31 May 2024 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154435; cv=none; b=oeGHI7cQpGbQ5CXYsYLlMC+WCtiZdOBHQgojxvXA63foOZ0C5ZuKhlc32nxwn5zDmHL4n8Kc+dwX+mlIKIHzKDrNXpA2NEAWQ3inWN/PHTlyHa2aKYEu11H/LaEn/N8oYSSq/Ci2S1h5K82/2iOCQcieghHX24/UC+dmu5CMcuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154435; c=relaxed/simple;
	bh=zkQHmSuIQHNgbLqLNpz0Ph/DXdIIeX0snkoutPpHnsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R2kpDLv2hyePGPWqz4qOHgsMZacJAqf/eoTpui+xk0ej8aCq/spbqFN0YzDX5ZYc1ZT/937SwNhs8h0SYV0tiRRCg05+gfXlEHu4gy6xiuRl3PpU6raMRHvExNxgrE9T7H+l6m+8+E0lQ2rUB6ngm2DwfimuW+Ce7WhpP3zvNNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=pdbNxI5a; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="pdbNxI5a"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240531112029d3c049e136d09f97a1
        for <xenomai@lists.linux.dev>;
        Fri, 31 May 2024 13:20:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=F4Kybf3rIUb4c+buS8qSzUegCoZFKFJ5nE1pTVwArD0=;
 b=pdbNxI5a51RnBQXKrBqMETqAsOvPnUDfm+0vlSVcFzUpDmmJG7Xxx0FJgiZs8WzFd9+/2B
 OL9gGIN9/ZpLQt2rxPyPdqtnakKPJO00x5/Zbbkx4ZHuAV0Tluo4mHe3iuObnat1Sejx16dn
 jCQVQdIHiN8gfTUnYXnxLgWEmTAtg=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 31 May 2024 13:20:28 +0200
Subject: [PATCH RFC dovetail 6.9 1/2] KVM: x86: dovetail: Fix stalling
 HYPERVISOR_CALLBACK_VECTOR
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-flo-fix-kvm-guest-for-6-9-v1-1-1c895c256f8d@siemens.com>
References: <20240531-flo-fix-kvm-guest-for-6-9-v1-0-1c895c256f8d@siemens.com>
In-Reply-To: <20240531-flo-fix-kvm-guest-for-6-9-v1-0-1c895c256f8d@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Linux commit
8f4a29b0e8a4 ("x86/traps: Add sysvec_install() to install a system interrupt handler")
migrated from alloc_intr_gate() to sysvec_install() for registering the
HYPERVISOR_CALLBACK_VECTOR in arch/x86/kernel/kvm.c.

As a result the call stack for sysvec_kvm_asyncpf_interrupt looks like
that:

  <IRQ>
  ? __sysvec_kvm_asyncpf_interrupt+0xa9/0xb0
  ? __sysvec_kvm_asyncpf_interrupt+0xa9/0xb0
  sysvec_kvm_asyncpf_interrupt+0x3e/0x80
  </IRQ>

With that, no additional IRQ chip is involved, so the affected vector /
IRQ is never ACKed at APIC level. apic_eoi() has no effect in case IRQ
pipelining is active.

Migration to __epic_eoi() fixes that problem, dovetail is able to boot
in setups where the async page fault KVM feature is advertised.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/x86/kernel/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index c65e88f94f32..d767b2fede14 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -297,7 +297,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_asyncpf_interrupt)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	u32 token;
 
-	apic_eoi();
+	__apic_eoi();
 
 	inc_irq_stat(irq_hv_callback_count);
 

-- 
2.39.2

