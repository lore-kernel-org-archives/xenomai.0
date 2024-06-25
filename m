Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F12146587
	for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306212; cv=none; b=PM6Ntm5D55dYSVXM6LFUo4im57LqQmzQFgYGKtHwXMDugR052yEDi5J1XMqLgMgksVaNft0UH8g0af1yPN7bt5EF4My5iLJtmLpFdo15Ahlgp7YcjnVWtU0h5aRcKFYhFJ4KbBkkgjqiBi7QEZsOiVZ6xffCfA/Z+LEoYADa+pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306212; c=relaxed/simple;
	bh=LoEmPSN8OLwQDcDz1k+jgWgnQYqWD+NhB8SfWafEPj0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A1aTndDHYky/hX7SImu5R1/XgYTOWrdaBDOMsGCJOU+m9/T7Pkw2bSJl/yvhyxug9SAd/FfqeezYYhBVrJ2moow0LvEtDQot8JdsIqicxoZdKUrVYzNMlodWgBcZKrA6rPmpE2SHRnDDsX58Ll4DFS9j2HeomMQvlDzyiR2mVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=UmAvqv7B; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="UmAvqv7B"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202406250903180d82a1ca3ed73d59cb
        for <xenomai@lists.linux.dev>;
        Tue, 25 Jun 2024 11:03:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=iRduPd7VgvUsVmIWU7PcP2Uyi12hQoRJtCsFpS+WSdg=;
 b=UmAvqv7BKrzGPQJHzZhvmoKMh7OzJuJvFS8ahd4oiaRodDOdqYSNnoR3o6DQgMtxEA3XtI
 eQVbUi9Cl+B19VZfJuIRsrdBZhRj3Gj4oDx15oslIfJmxzImBG7iOKwyOUZ14LiY2GB88MQW
 ocnKxnChIGF0wgkyy/f9lu8IIMawY=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH dovetail v5 0/2] Fix KVM guest support of dovetail
Date: Tue, 25 Jun 2024 11:03:14 +0200
Message-Id: <20240531-flo-fix-kvm-guest-for-6-9-v5-0-1efec77fe0a0@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANKHemYC/43Ou27DMAwF0F8JNJeFnn506n8UGWSJioXaUiE5Q
 orA/17CW5HF4yXBc/lkFUvEyj4uT1awxRpzomDeLszNNt0QoqfMJJeaGyUgLBlCfMB3W+F2x7p
 ByAU6GMFg6IS1jg/WM7qfbEWYik1uJiHdl4WGPwXp+ij8Yj433Gxc2JU2c6xbLr/HJ00c+xOlT
 QAH4YbROGm6MPjPGnHFVN9dXg+3ydOWJMsYpYOzqHEyr5Y6bSmycHLBiN5wbtWrpU9bmqy+171
 wo+6VH/5b+77/AVqO78HHAQAA
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
Changes in v5:
- Patch 2: safe_halt() -> native_safe_halt()
- Link to v4: https://lore.kernel.org/r/20240531-flo-fix-kvm-guest-for-6-9-v4-0-77471c9473d8@siemens.com

Changes in v4:
- Patch 2: Sligthly changed the patch description 
- Patch 2: Do not stall the inband stage in task context (handle Linux
  IRQ context and task context the same way)
- Link to v3: https://lore.kernel.org/r/20240531-flo-fix-kvm-guest-for-6-9-v3-0-ebcf517500a3@siemens.com

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
 arch/x86/kernel/irq_pipeline.c  |  6 ++++++
 arch/x86/kernel/kvm.c           | 29 ++++++++++++++++++++++-------
 3 files changed, 29 insertions(+), 8 deletions(-)
---
base-commit: 17865a05b459df6e7e7e38018b15b29a96df49af
change-id: 20240531-flo-fix-kvm-guest-for-6-9-5ef61aac08ad

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

