Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5E2857C2
	for <xenomai@lists.linux.dev>; Wed, 24 Sep 2025 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749036; cv=none; b=IsSv47aUpNWq3gieoytCMkkUTp+wxDLv2OhtA74a57fNHPR2z+eEfVxtBDAFdTQtAvEdvsV37kRc76u20dpbvK4GWQgpgEr+gi8IA7gmmw3oi6eCKvRczkriOujPIcE1+3GZ2fg8oftOolq/45bBtmBpLloourpKI85WpISnvic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749036; c=relaxed/simple;
	bh=NCBi5+Qj4DbMkzgdhvtrHcfcDZnC5XQeI76/b4FP9No=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PvxpU7NSc4yjoZKp16jKejm6MEFPbjGL7bm1CPqLk/v0NJzIO52rCwZqqbvMePDETb/y6EG0kuzQjK6ZBEg8xIZLiw9lDHiKtAkS4jmaQysF9Q3T54Z/GRJJtBiIiWtntdrH+hru2sNr4GgRVtPxfROoT/jUYMA9NrhLL7mpv4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZJ7SGNex; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZJ7SGNex"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202509242123424dca7bdf5500020762
        for <xenomai@lists.linux.dev>;
        Wed, 24 Sep 2025 23:23:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=PDm4Oi5bDDWyhw+WDwII0tGuO2TqB+H/tOh8cOk7/gs=;
 b=ZJ7SGNex623WfkDfbYfIAK4rBvea2IitI8omLI4wQYNDi1HeUgv9H2pr5KIKVx9SbiAdB/
 JosIxn91vEGDhbk0uyD0C3mLtTvxw2bd8DRrakRU3sM/AL8vTZvAJj6p427GSdwQ5JfdFGm0
 YgfnhS911W0tYGysBAKaUWUBPsND95mwiKzCQUjT7117IS+M2RruKthZ2H0tjvCGNayu+WxN
 Z4+S8wLKakBp8I2NZSIrNHhELvprik/zEpOoKgoh4p3UubIIGuZpBjaUjZHvYQP+CY0/hZLw
 KYNyAMedWvXxnPe1fDPASIxnH3ycRKeO3udRYIfegNjDE91MWf5UFn+Q==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH RFC Dovetail 6.16 0/2] Dovetail: Fix lockdep warning
 observed on 6.16
Date: Wed, 24 Sep 2025 23:23:13 +0200
Message-Id: <20250924-wip-flo-fix-lockdep-warning-for-6-16-v1-0-8a8475e2cdc0@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEFh1GgC/x3NQQ7CIBCF4auQWTumUEuiWxsP4Na4oHRoJxIgo
 K1J07tLXP5v8b0NCmWmAhexQaaFC8dQQx4E2NmEiZDH2qAa1TVndcKVEzof0fEXfbSvkRKuJgc
 OE7qYUaPUaGTryHat0w1BpQZTCIdsgp0rFj7e1zFlqsj/+wH321X0caG3YS/0UWp47vsP74WKW
 J4AAAA=
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

as disussed in [1] this series is trying to fix the lockdep report that
was quite easy to observe on 6.16 in an qemu environment.

[1] https://lore.kernel.org/xenomai/871poezs9z.fsf@xenomai.org/T/#m2e90cf7017d5a2ca3a8bd9276528e9f80aded314

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (2):
      locking: irq_pipeline: Rename MUTABLE_SPINLOCK to HYBRID_SPINLOCK
      genirq: irq_pipeline: Migrate mask_lock to a hybrid spinlock

 include/linux/spinlock_types.h | 8 ++++----
 kernel/irq/manage.c            | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)
---
base-commit: 138f1183deed300fd1f03abb6511635a916b98d0
change-id: 20250924-wip-flo-fix-lockdep-warning-for-6-16-a13fec53f60e

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

