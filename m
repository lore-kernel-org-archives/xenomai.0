Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C512580CF
	for <xenomai@lists.linux.dev>; Fri, 22 Aug 2025 06:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845715; cv=none; b=rFXIxSzkCIH1i7AXnF+q4X8vFNeIy4pHh1ONUO37is9ErHDJYA6yYm0VdC3PZJx4wj67MTOaTiz3lm7whMFxBLA1JvxEjZDUcMaYS+zUJnEqp2JL2clItD8AkKOPKkdTvzzd+2i8zfpBRXZamBB1vnvOfenzd2WXJhB/Hq+iEZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845715; c=relaxed/simple;
	bh=F4dRoYPlc6b6dmAHmZLvI1/nHpa0FaWK1XipBJJaFvU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MM3AV8lmmHPsvsSM9QfIlJB5Er93xRrvyYI2aGWP2xhQqn9FlaPd7lqNtQaNqZCZemaipG+Rvy0enfAwMJg/y9PbjHRUR23rcg5QX/OytsmH/U485/yfDRMnusibS3GZWDg1Dt+PlbWfYiyL5RXHmFN1ufKHMsFS0n/I4k96yAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Mo9+zqyn; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Mo9+zqyn"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250822065501abbf6cadc8acb62e06
        for <xenomai@lists.linux.dev>;
        Fri, 22 Aug 2025 08:55:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=efahKiYRg4kBSSYB2wYIuQZLjTnksxnX3TR10Ti1Drk=;
 b=Mo9+zqynqY6Uea/PdQIFYMkHipF1dSV0vUmQ59r9LcatXkV9ObA7kHOj9jTayyoG9C4fnF
 0UicLjyqtoA+7rlATHJT6TzTsWedhndf4YXKD4JDibDgLQMGb2M6cRaWpgyEuMfyx1+9urmg
 vEYIBT5WBjff59i3Rg3PJsc1PrcOR3nXWgB1bCPO80uNxFW7j1kUPxSjqs/IphYfgXWgQCFf
 mqCFkxieIyj5dCZhSk9dkHqTecvZzQLjSDhvcn9ecQSUS6E4+U6XMJs1aAm0k0hVtZm71Cqd
 vIemV/LauVib/fbE0MkyW6Bz3yykAgMTq+oOpaXDtbuaCknZC0FtG8qg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail 6.16 v2 0/2] Dovetail 6.16: Fix some regressions
 introduced during last forward port
Date: Fri, 22 Aug 2025 08:54:59 +0200
Message-Id: <20250820-wip-flo-fixes-for-dovetail-6-15-v2-0-535e4fa355f7@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEMUqGgC/41OSw6CMBC9Cpm1Q1qESly58BaGBS1TmaS2pEXUE
 O5uQzyAy/d/KySKTAnOxQqRFk4cfAbVoQAz9v5OyEPGUImqEW0l8MUTWhfQ8psS2hBxCAvNPTt
 UKBuUR9Xak1UktITcovtEqGPvzZh7/NO5TE6R9nxmbnD95QtVSgVdlkdOc4if/dQid9Pf+4tEg
 UNd20YYXWuhL4npQT6VJjyg27btC1oxPp30AAAA
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

seems the last forward port to 6.16 introduced some regressions.
Please review carefully, thanks!

With that applied I have two open problems:
  - Running dmesg kills the system, no idea yet
    Requires at least 3 CPUs on my qemu system to reproduce.
    Update: I know how to fix that, but not fully understood yet.

  - I'm able to reproduce [1] on 6.16 now
    Update: This one is understood now. Xenomai 3 bug.
    Tests already ongoing.

CC: Philippe Gerum <rpm@xenomai.org>
CC: Jan Kiszka <jan.kiszka@siemens.com>

[1] https://lore.kernel.org/xenomai/6fcb3f9830056d99161ea8f50a016b99d98a7c71.camel@siemens.com/T/

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Changes in v2:
- Patch 1: Reworked as discussed on the list
           Following the same pattern as for arm64 
- Link to v1: https://lore.kernel.org/r/20250820-wip-flo-fixes-for-dovetail-6-15-v1-0-d44f50cb4b0b@siemens.com

---
Florian Bezdeka (2):
      x86/fpu: dovetail: Fix FPU corruption
      irq_pipeline: Fix pipelining code for level triggered IRQs

 arch/x86/include/asm/fpu/sched.h   | 17 ++++-------------
 arch/x86/include/asm/fpu/types.h   | 12 ------------
 arch/x86/include/asm/thread_info.h |  1 +
 arch/x86/kernel/fpu/core.c         | 12 ++++--------
 kernel/irq/chip.c                  | 33 +++++++++++++++++++++++++++++++--
 5 files changed, 40 insertions(+), 35 deletions(-)
---
base-commit: eec111a874f5899e1078ef785ccf29dff986e5a0
change-id: 20250820-wip-flo-fixes-for-dovetail-6-15-1368f7f6e0b1

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

