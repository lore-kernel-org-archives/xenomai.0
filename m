Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19242156F46
	for <xenomai@lists.linux.dev>; Fri, 31 May 2024 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154441; cv=none; b=TTTKPVYBKegJ3p18gutf+kvN1HreonQuJhnIZaiMImT2sHdJrJQ4UM02BOqwC9+lyicDd1vl3lONJ3wVrk9Pyuh0IA/1WwTWTWgPS+3/lrPAkWYzwduUJcI0mYHhBgC8UUZoq45vG/oXbk/H8xvsag4IvuwNLxqEqlhijUEnJjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154441; c=relaxed/simple;
	bh=4Tbiz6uOzW4m05iMb+GROLfpF22BXC5xBRBZ+XrDFWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gdZs9S/df2nwSR5OcspR30MecXzMSemdqNeUUJG7BDieWGm9DjSbysi6/vjje9W2gT43X9aJ2Nm3iF6e6WaEMwbffz7QUj3YHihG7oAYfFvne3CwbVS5IgwS1ELWrEgCUlVF5XZ/ILuEuYayoWnJX1aHD5r910mY1g7i5tr5OZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=r2RtlBzf; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="r2RtlBzf"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024053111203045db85eac85f605615
        for <xenomai@lists.linux.dev>;
        Fri, 31 May 2024 13:20:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=C83Z+WEeeA7iBdKctnXhhWHLFGf7w03iuVdAr4hNTUE=;
 b=r2RtlBzfrWdZ8HZJo7aX/SlW2nYq+WNtKYPjNSgdR5Tu9DksSE/0IJFNIyAScam+W+nLWA
 lwmSWC0QkF4jTCscGtPkUDWsT/69XBZ/xN7UOwQ8cSV+n6Xy4Srv7XSmAwidLNIAbFCVLdau
 kjNX+6IYAj3JxZQv3vIHuXX4LL4Bc=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 31 May 2024 13:20:29 +0200
Subject: [PATCH RFC dovetail 6.9 2/2] KVM: x86: dovetail: Make
 HYPERVISOR_CALLBACK_VECTOR pipelined
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-flo-fix-kvm-guest-for-6-9-v1-2-1c895c256f8d@siemens.com>
References: <20240531-flo-fix-kvm-guest-for-6-9-v1-0-1c895c256f8d@siemens.com>
In-Reply-To: <20240531-flo-fix-kvm-guest-for-6-9-v1-0-1c895c256f8d@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Dovetail 6.9 was stuck in the boot phase as KVM guest on a system that
reported the asynchronous page fault handling feature.

The apic_eoi() call in sysvec_kvm_asyncpf_interrupt() has no effect in
case CONFIG_IRQPIPELINE is enabled, thus those IRQs / vectors where
never ACKed at APIC level, the CPUs stalled.

Instead of migrating to __apic_oie() the IDT entry for
HYPERVISOR_CALLBACK_VECTOR for KVM on x86 is now marked as PIPELINED.
Other architectures (and other guest extensions) already used
DECLARE_IDTENTRY_SYSVEC_PIPELINED().

The imbalance of how HYPERVISOR_CALLBACK_VECTOR is being used /
pipelined goes back to 5.10. Backporting might be required.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/x86/include/asm/idtentry.h | 2 +-
 arch/x86/kernel/kvm.c           | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 500f4e8c6542..e544b24f61bf 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -829,7 +829,7 @@ DECLARE_IDTENTRY_SYSVEC_PIPELINED(HYPERVISOR_CALLBACK_VECTOR,	sysvec_xen_hvm_cal
 #endif
 
 #ifdef CONFIG_KVM_GUEST
-DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_kvm_asyncpf_interrupt);
+DECLARE_IDTENTRY_SYSVEC_PIPELINED(HYPERVISOR_CALLBACK_VECTOR,	sysvec_kvm_asyncpf_interrupt);
 #endif
 
 #undef X86_TRAP_OTHER
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index d767b2fede14..fa6505041d5d 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -292,7 +292,8 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 	return true;
 }
 
-DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_asyncpf_interrupt)
+DEFINE_IDTENTRY_SYSVEC_PIPELINED(HYPERVISOR_CALLBACK_VECTOR,
+				 sysvec_kvm_asyncpf_interrupt)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	u32 token;

-- 
2.39.2

