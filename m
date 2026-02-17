Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACFD1ADC7E
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771368873; cv=none; b=e1o4V+9TxNqlz4OKof5ehiMNYTfu334ovqiqrBMniMbWKTjClSzRnOheK23ZimyLK8Qr+76RRw3A+Y3fTvNrjSu27+eI9z5XTRIeM2TUMdx37AniapkTDwYJ2ZOyGB86W8nJozLKPtRd3rj5nwfvfGMVXHngXZSvF68WIlan48k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771368873; c=relaxed/simple;
	bh=szBUnC7C+dRj4Z/mgFkD7iWDyOUvfu4GC58fgLfusUk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ru3I9WTVKsO6Jc5Q/OJFw2DhzCb22ub1Ktp3bAR0oXv0+nMofhLnsFqzNH6eDACMv4mrf78zN2GGKN2iDR+qSFy9mnPmG1GlshqCKJ1aCETY9qmCECjnOvv46C05kTcE8T/pJY8H7j+lKwnxpXYY5kiWxRJGLMrhJF/PSxupxpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Ycul2cLT; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Ycul2cLT"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260217225427e34fdf0ab1000207ee
        for <xenomai@lists.linux.dev>;
        Tue, 17 Feb 2026 23:54:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=iqzIxRLkPfCEc7Z0kn9EVz1HxKwcZooTpEgjFnRz3z4=;
 b=Ycul2cLTR8N1iZ8YILSezgsFyf8NfEV5MnC3UWMQPZnnj8u35t5sT9WQhKknebDMfbqwvc
 tPhw15mTpUy2d5vKQX4mm20sni7m2uWuA2PhFqUG7kOlsAnmVJFHDlTnyrbLsXzt09ipc4jK
 xrU0uK1cRF+G1oCqJB1408ydAPt2TR9W2MJ/5GtqWf3hh/yZ0woPlp61l2psod/N2DyG1IrO
 WiJbtxJvzLTZuXhIAD/k7QUHCO8rrVRiiuD7nsDqhte341f/4HllX+pil1CVxTwRZHPLw7hw
 oMJM89tAXnovIa+qYY+BP+9+3onfiTqTqujLsfkKF7d7OVZHUPu/LLNQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail v2 0/2] Dovetail: Fix for arm64 IRQ pipelining,
 API for co-kernels
Date: Tue, 17 Feb 2026 23:54:26 +0100
Message-Id: <20260217-wip-flo-v6-19-dovetail-rebase-v2-0-45fc326a166a@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKLxlGkC/42NQQ6CMBBFr0Jm7Zi2xAquWHgLw6Itg0wClLSka
 gh3tyEewOXL+3l/g0iBKcKt2CBQ4sh+zqBOBbjBzE9C7jKDEkoLJTW+eMF+9Jg0yho7n2g1PGI
 gayKh66xUlki4uoLcWAL1/D76D7j/xtBmM3Bcffgcx0ke/s+PJFHgxZW60qWzRl6byDTRHM/OT
 9Du+/4FKLCrkdYAAAA=
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
    confusing on arm64.

Patch 1 qualifies for backporting. It allows co-kernels to migrate to 
the new API without any need for Linux / Dovetail version checks.

To: Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Changes in v2:
- Updated wording / backport candidates in cover letter
- Rework patch 2 after review from Philippe 
- Link to v1: https://lore.kernel.org/r/20260216-wip-flo-v6-19-dovetail-rebase-v1-0-5c36863cba17@siemens.com

---
Florian Bezdeka (2):
      dovetail: genirq: Add request_percpu_irq_affinity_flags()
      arm64: irq_pipeline: Cleanup demotion check for el1

 arch/arm64/kernel/entry-common.c |  4 ----
 include/linux/interrupt.h        |  5 +++++
 kernel/irq/manage.c              | 10 ++++++++++
 3 files changed, 15 insertions(+), 4 deletions(-)
---
base-commit: 61ac9499b2a582aad9e190db04bb48747e7f5821
change-id: 20260216-wip-flo-v6-19-dovetail-rebase-cdb12bee0c98

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

