Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAB1225AF
	for <xenomai@lists.linux.dev>; Fri,  7 Jun 2024 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717801515; cv=none; b=e5m9MPzbS9YfiXcpoZ5cP7uinKkDY2oPEx0MgZQepj042SohsZRX1SaNCaC39UmpEtzHiEjGW+YQvzDEk9I9R+cdpoaSZqrJYrbeDf+vIL/zo9erkEtW40XELWG+mitR0Xv/NRraaYI4P2JcZMJkhlaSmEEpdYTRxfG5q2DBq9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717801515; c=relaxed/simple;
	bh=hZ7q/PrwXGV8ahVMa7WhrfEmKEg45xGOFgGRvqZz1FE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uloWYqCQq0V6zdjfyPUam11wGfoUMDkgBs1slRw7SU5NWJnH0uZmxEm5Sf2NJ7xQt7LkOaESaGq5lwp7tzmLYS4DCFVCrGMclHn15Q+ZuAvFnzNh7mQNG2U1ZTSNRxvrBAeeQO+W7MIqkTeWDXhdT2vVTCcLgeCYqiqNQg2KJeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=qEKtG4eq; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="qEKtG4eq"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20240607230501ed5d7bb6410ac1ac6c
        for <xenomai@lists.linux.dev>;
        Sat, 08 Jun 2024 01:05:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=bc1CMoX6HWkbOCcxQ1NOmhUiMnKNTmOvUFFBAlvK7oM=;
 b=qEKtG4eqcjj9S8M5s59sSQwDRjtCaNJcQ+Ck+wDVAPPUZxXesUdHTVxF0G2q+TzpxvYxYa
 5xQPULJSy2hj7iIGtUeilPnmzj47eF1jmTrzTUShuiKVAkYiwXORz3XELb1GdakK0ZP5m8J+
 D2dXNuV3ZysYxhUd2RPe5I8hcwscM=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH RFC dovetail 6.9 v2 0/2] Input needed: Boot hang, dovetail
 6.9 as KVM guest
Date: Sat, 08 Jun 2024 01:04:52 +0200
Message-Id: <20240531-flo-fix-kvm-guest-for-6-9-v2-0-5534fcae4eb5@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABSSY2YC/42OQQ6CMBREr0L+2k9aFAKuTEw8gFvDorS/0lha0
 0KjIdzdhhO4nMm8mVkhUjAU4VysECiZaLzLojoUIEfhnoRGZQ0Vq06sPnLU1qM2H3ylCZ8LxRm
 1D9hghzXphgshWSsUZH4QkXAIwskxN7jF2my+A2V6H3zA/XYtlE80C2OLpuygz4nRxNmH7/4o8
 T33x3jiyJDLtqtlVTe6VZdoaCIXS+kn6Ldt+wFo8uQz6wAAAA==
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all, 

this is the result of the debug sessions last week. Feedback highly
appreciated.

Tested with LOCKDEP / PROVE_LOCKING enabled. Stress-Tests passed on two
different hypervisors, namely KVM and VirtualBox.

CC: Jan Kiszka <jan.kiszka@siemens.com>
CC: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
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
 arch/x86/kernel/irq_pipeline.c  |  6 ++++
 arch/x86/kernel/kvm.c           | 62 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 62 insertions(+), 8 deletions(-)
---
base-commit: 17865a05b459df6e7e7e38018b15b29a96df49af
change-id: 20240531-flo-fix-kvm-guest-for-6-9-5ef61aac08ad

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

