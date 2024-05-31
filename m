Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390FC156F5B
	for <xenomai@lists.linux.dev>; Fri, 31 May 2024 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154435; cv=none; b=lw2LfC1E1pD2wKPcYOTzX3SoxqAyMEaDBo0LfuujbscUqUEjajqwP00M+q1xj702RDFmKDU7/J9Qji15e3Sg7PUioY9R3v9GpFO8AAsTGHaAtn8YoG+CAg/VY27XIyXWWqzsflmFAmOOM7IoIKmIRLTcSHx842Pj8RCqKkia2jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154435; c=relaxed/simple;
	bh=+cKy3Wzy+a3Fzpshus3gq5GVyz/JYhLMxBWGdgLhBps=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bCloNLmEz74cVbPWWEUc4XOQZZyLd1zCCwmkfitxgt0CcQ5vp4+N/CK0OCn5/r0e6ltlvT8gWVzQQk5R+wWhFnC+uI3C0x10tG3gDW+YJlbEYJDVlze5CfiNCTQpo5bzj/3R0ipq32Oh6fag5BBijE+bcrdS/fmni1ETZug1lUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=oDeR2YhC; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="oDeR2YhC"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240531112029c33d18ec5ff6dd9623
        for <xenomai@lists.linux.dev>;
        Fri, 31 May 2024 13:20:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=1RjUcOeHLvb9JJ/61UAXu1nHh39kDfKbnp3AwaFPIDk=;
 b=oDeR2YhCQF5lZtLkKsrTukUIdpTokg5NPu/m2cJx0xsq2EHbYrTU+DNpvakd3qK0+LxAia
 zpISfb/Di3TWikF2ZY6Pi+4V12ahDCPMSDtZ5/h/y/wmTFVFu6Pnl2APVYLHOS59fcOMDnou
 Cb94xmzRwVZSjHoHByKeWmbIJUyMQ=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH RFC dovetail 6.9 0/2] Input needed: Boot hang, dovetail 6.9
 as KVM guest
Date: Fri, 31 May 2024 13:20:27 +0200
Message-Id: <20240531-flo-fix-kvm-guest-for-6-9-v1-0-1c895c256f8d@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHuyWWYC/x2NQQrCMBBFrxJm7UhabbBuBQ/gVlxMk0kbTBNJ2
 iCU3t3g8n1472+QOTnOcBUbJC4uuxgqNAcBeqIwMjpTGVrZnmV3atD6iNZ98V1mHFfOC9qYUGG
 PHVvVEGl5IQPVHygzDomCnmohrN7X8ZO42v/DJzzuN2Fi4YWcF+rYw2vffzWjrNaSAAAA
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all, 

this is the result of my debug session yesterday. I was unable to boot
up Dovetail 6.9 inside a KVM guest when KVM guest extensions
(CONFIG_KVM_GUEST) were enabled.

I was able to find the root cause, but I'm unsure how to fix it. I found
two ways, both attached as patches, maybe one qualifies as official fix.

My host advertieses the KVM async page fault feature, so the guest
enables the IRQ / vector around HYPERVISOR_CALLBACK_VECTOR.

First way:
The call graph to the IRQ handler can be seen in patch 1, it's basically
an OOB IRQ. Migrating the IRQ ACK to the OOB version fixes the issue. The
description of patch 1 should provide all necessary information.

Second way:
There is some inconsistency related to HYPERVISOR_CALLBACK_VECTOR on
different archs / for different guest extensions. The KVM guest on x86
was the only remaining one using DEFINE_IDTENTRY_SYSVEC() insted of the
_PIPELINED() variant.

Patch two fixes the imbalance and works. The problem is, that with that
patch applied I see no single call of the IRQ handler anymore... So at
the end I'm not sure why this works now.

@Philippe: Any ideas? Which way is correct?
Patch 1 references a Linux commit that changed the registering part of
the involved IRQ/vector. Is that considered problematic?
idt_install_sysvec is now being called with the asm_ prefix as
argument...

Best regards,
Florian

CC: Jan Kiszka <jan.kiszka@siemens.com>
CC: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (2):
      KVM: x86: dovetail: Fix stalling HYPERVISOR_CALLBACK_VECTOR
      KVM: x86: dovetail: Make HYPERVISOR_CALLBACK_VECTOR pipelined

 arch/x86/include/asm/idtentry.h | 2 +-
 arch/x86/kernel/kvm.c           | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)
---
base-commit: 17865a05b459df6e7e7e38018b15b29a96df49af
change-id: 20240531-flo-fix-kvm-guest-for-6-9-5ef61aac08ad

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

