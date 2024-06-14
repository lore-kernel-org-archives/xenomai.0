Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5386196446
	for <xenomai@lists.linux.dev>; Fri, 14 Jun 2024 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718365995; cv=none; b=k1HiAJmMHCacMAuuvz6TflZfTc3WNlC/dyM6lJN0saGCcuuKDMCyQVzTZNEw4dnQehYQlllQIVbPSVmxLPaTIv901IEaAmuDZtwi7SftssR3V3KQImaNieL/1aIo5aJSjijhCbFNsAiHJSywcSAC2FxiI7j7fZYlXP49OOd3tD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718365995; c=relaxed/simple;
	bh=D4UVpL2zZqyUtgVrbAeKaw+H5E30IaYzz/AzPoKf/Os=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p3jZjHtS6B8lEV6+jsClRde6qEZ+EXfV4HcipAVGNSVAwnWvO+Q1hZsbQeDjixBtE4uOYVOD1m8b2B+ugqkU/xSXI05c/wZzZauXTUkk4MNEQIK6m4/mk1emm7L36OPComWRfWoadgdopclP5yptAkLQUYi9en18Ghr9u15voZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=pd3NVX/n; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="pd3NVX/n"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202406141153061b57f54316c05fc116
        for <xenomai@lists.linux.dev>;
        Fri, 14 Jun 2024 13:53:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=jjviLOYp7LNXu7ek2x7qVQqbv1/nLhYXPVcQ6Na4Mz0=;
 b=pd3NVX/n6ldSNKyqDSkscI1fmIbfj8AKScdW5OUaqMCX/rmEKW56xVAhLlBO/2x4pOdF3a
 BwLdik+fPVY3o3S0EejQ0JdrusJC2d3dDRcg5ZgeC127Stac8htc/1RRG4lm0WNKAPRkerp7
 8CGYy0lRWHMXgZb5hLewNezFoTweQ=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH dovetail v3 0/2] Fix KVM guest support of dovetail
Date: Fri, 14 Jun 2024 13:53:04 +0200
Message-Id: <20240531-flo-fix-kvm-guest-for-6-9-v3-0-ebcf517500a3@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACAvbGYC/42OQQ6DIBREr2JY9zeAYrSr3qPpAuGjpAoNKGljv
 HsJu+5czkzmzewkYrAYya3aScBko/Uui/pSETVJNyJYnTXhlDdU1AzM7MHYD7zSAuOGcQXjA7T
 Qg0DTMikV7aQmuT/IiDAE6dSUCW6b52y+A+Z2GXwQ7ROu0s7kmZPJxtWHb3mSWMlPjCYGFJjqe
 qG4aE2n79Higi5elV8KN/HTLJ5ZQtSNURIbHMQ/6ziOHxy8tG4vAQAA
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all, 

this is hopefully the final version of the dovetail KVM guest support
enablement. Dovetail failed to boot without patch 1 and crashed without
patch 2 under high IO load scenarios.

Tested with LOCKDEP / PROVE_LOCKING enabled. Stress-Tests passed on two
different hypervisors, namely KVM and VirtualBox.

All dovetail versions (down to 5.10) are affected. Backporting would be
required on my end, I need 6.1 to be fixed.

This patches apply down to 5.15, 5.10 would need manual backporting. I
can look into that once this series is accepted for 6.9.

CC: Jan Kiszka <jan.kiszka@siemens.com>
CC: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Changes in v3:
- Removed RFC tag
- Took care of review comments from Jan (patch 2) 
- Link to v2: https://lore.kernel.org/r/20240531-flo-fix-kvm-guest-for-6-9-v2-0-5534fcae4eb5@siemens.com

Changes in v2:
- Drop patch one 
- Now patch 1: Handle async page faults inband, rework patch subject
- Now patch 2: Fix kvm_wait(), PV spinlocks
- Link to v1: https://lore.kernel.org/r/20240531-flo-fix-kvm-guest-for-6-9-v1-0-1c895c256f8d@siemens.com

---
Florian Bezdeka (2):
      KVM: x86: dovetail: Move handling async page faults to the inband stage
      KVM: x86: dovetail: Allow kvm_wait() to be called from any context

 arch/x86/include/asm/idtentry.h |  2 +-
 arch/x86/kernel/irq_pipeline.c  |  6 +++++
 arch/x86/kernel/kvm.c           | 50 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 51 insertions(+), 7 deletions(-)
---
base-commit: 17865a05b459df6e7e7e38018b15b29a96df49af
change-id: 20240531-flo-fix-kvm-guest-for-6-9-5ef61aac08ad

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

