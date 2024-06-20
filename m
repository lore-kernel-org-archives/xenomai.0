Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B99C15B0E5
	for <xenomai@lists.linux.dev>; Thu, 20 Jun 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880411; cv=none; b=OPrJ++/q+ATDRQzbSDmw2oOoqifIFEMu9rRyujCWTcqlw0df0DZ0hcjHZEtRU0g8ydD6uZVfuyWfoFB/plsu5KTy0dzKO1nJ3zuB3c1Mi3TMxo2R3FQInFtQTOyCWTAISUO9/BjQfCJ3ak7e0S3+vQW1arov93jHi01Cjir/fWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880411; c=relaxed/simple;
	bh=DaLPtKMAYJcvTjrY13YWv16zeHNF+r9zBNqPOz1eBX0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dtlxjvtORrz94sORhaSmGMpqi9rft0vY2YRuN54Nx10fY//p8JovwwNulCJn/AScrk8l/BJefmgWc9xmTs/iC+qzv9iH4BERkAC1iFwAS+LPlbHi8FbzNZcgeoFtpVdqyhodl8QGrK8tjZCEi5BSibb7lDib+0pDyBI+GTkKv3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ilvgi/uh; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ilvgi/uh"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202406201036295b310764f05074cd91
        for <xenomai@lists.linux.dev>;
        Thu, 20 Jun 2024 12:36:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=E6yk0rcLZE6Nvgvzk87+94MdeoLyOytFVGjur030Q3A=;
 b=ilvgi/uhpsflobKQGFpGEi/18+9v7LKRUugb8AoOug2+1w/iGmMCEmDlVkdsLZdPVa7nRS
 016GNvaC6rfkqY/1GvpiXu5eaWbFCRFqKJ3Vke5VAnA8RvryWtarW/B1CGQsP0JIpaOuE+e5
 9ZegqpbL/2RX6jPwZHKZYI5w8TcZ0=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH dovetail v4 0/2] Fix KVM guest support of dovetail
Date: Thu, 20 Jun 2024 12:36:24 +0200
Message-Id: <20240531-flo-fix-kvm-guest-for-6-9-v4-0-77471c9473d8@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACgGdGYC/43OTU7EMAwF4KuMssYoP3XpsOIeiIWbOtOINkFJJ
 wKNenes7hCbLp8tf88PVblErur18lCFW6wxJwnd00X5mdKNIU6SldW20+gMhCVDiN/w2Va43bl
 uEHKBHq6AHHpD5PVAk5L7kSrDWCj5WYR0XxYZfhWW66PwXU258UZxUR+ymWPdcvk5Pmnm2J8ob
 QY0GD9c0VvswzC91cgrp/rs83q4zZ62rFiIrgueuOMR/1vutOXE4tEHNC+oNbm/1r7vv0+UkA5
 7AQAA
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

