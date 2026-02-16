Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D59F2C11FA
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771268736; cv=none; b=rfhlMxtZVA/+19E3DIwQURJ2xbzshlMN3k7QGyo9EqHKJ0cfWtehYt1bv4EDyulk8XadzcQAsgXsZcKMFeW42p+awAdcUr2HibUGFPwS7hIw+caC7rDRTpereXdRyuqnCYtiVXUkURW82mcthsJtwAA7ZHMrlvdlg6EaamWTmNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771268736; c=relaxed/simple;
	bh=N9Y7vX+m2v0FLGMyc11AZTVmjKqD9lVnfxSW4HXc1BQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=izofWb9h9p6Je71Rcqh682qb7GyOxCTUc9nOnpXfVjMldCuWIXoFd+XfDWxnRQanqDlTqlNVknLXrC0CjSSoSjvDt6bD4OLof+Py+XVawkLVFo6cU0pYdw8Pms/EJKAyzXnq5iv9fYzSDOxdc3w1RLpCtJ+GTMNNLs04yKqPUg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=WOn91EV4; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="WOn91EV4"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026021619052670c238897600020720
        for <xenomai@lists.linux.dev>;
        Mon, 16 Feb 2026 20:05:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=vB9n9wfhnqUngMZzr44dBc4GzcxnKKqxLhYAtSCrfJY=;
 b=WOn91EV42swXPL47+o36WPq7eWmQSvwqw+7MhHhx1spKK7zpUXHvGVFgMQWIzTMjrrBP6R
 nkKyCLkyKo2A9fK7dxuv/FcGn+qLxUmGlnlZAQVf3+KtFTSZXmtXLXsIZhjJAotUD4MTCeMy
 P2Yp/BoXIf/VxGvVIb/ZYSUHdSnZfN9Nk4K9Q65iKY33eFwFAiilRzLUtNpzWGjtLtSu68Q9
 gqdF+lVny38gKfHUNMSAmoZIcVkYmW3nolsUy4Os2j0SGgbn+yqeBRr+s1y0U+lk3v5ff1SQ
 CClqDuZOj/gGjavl/KAoAJ3+XThIrHo7xFSC9uVExNZXV0GVMlcBO4mQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail 0/2] Dovetail: Fix for arm64 IRQ pipelining, API
 for co-kernels
Date: Mon, 16 Feb 2026 20:05:24 +0100
Message-Id: <20260216-wip-flo-v6-19-dovetail-rebase-v1-0-5c36863cba17@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHRqk2kC/y3MSwqDMBRG4a3IHfdCkkFQx+6idJDHb3tBjCQlC
 uLeG4rDDw7npIIsKDR2J2VUKZLWBv3oKHzc+gZLbCajjFVGW95l43lJXC3rgWOq+DpZOMO7Ag7
 Ra+MBFYae2mPLmOX4/5803TG9rusHcPD1/XkAAAA=
X-Change-ID: 20260216-wip-flo-v6-19-dovetail-rebase-cdb12bee0c98
To: Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

There were two issues detected while doing the forward port to 6.19:

  - The signature of __request_percpu_irq() has been changed in 6.19 and
    7.0 will remove the function entirely. We need a replacement for
    that function as co-kernels (evl, cobalt) relied on it for
    registering the OOB IRQs. All existing alternatives are missing the
    flags parameter that we require.

    Patch 1 is trying to address that by introducing a dovetail specific
    helper.

    The implementation has to be adjusted a bit during the forward
    porting to 7.0, but the API can stay the same.

  - While reviewing the pipeline entry code for arm64 - triggered by a
    patch review - I noticed that the checks for the demotion case are
    wrong on arm64.

Both patches should be backported to older Dovetail branches:

  - Patch 1: Allows co-kernels to migrate to the new API without any
    need for Linux / Dovetail version checks.

  - Patch 2: Fixes a bug.

To: Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (2):
      dovetail: genirq: Add request_percpu_irq_affinity_flags()
      arm64: irq_pipeline: Fix the demotion checks for el0 and el1 IRQs

 arch/arm64/kernel/entry-common.c |  8 ++++----
 include/linux/interrupt.h        |  5 +++++
 kernel/irq/manage.c              | 10 ++++++++++
 3 files changed, 19 insertions(+), 4 deletions(-)
---
base-commit: 61ac9499b2a582aad9e190db04bb48747e7f5821
change-id: 20260216-wip-flo-v6-19-dovetail-rebase-cdb12bee0c98

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

