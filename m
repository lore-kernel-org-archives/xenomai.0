Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610473EF0A9
	for <xenomai@lists.linux.dev>; Thu,  5 Feb 2026 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300019; cv=none; b=nytql6CkRuaAb42jenGdA5KkxqSaZl8b1rdkRE8pXOLRYhlqnOnTLJUVABZJ1VA2byaWmu+3yLQBMTsjVVuyLPp+dXLz7nrKmqcBjthw/mY/CA/jV/pUk4dbiasSiGTh3nmbRS4REnEGsoVs1Epxf0dnPLI82P5NwQkC3g7nRac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300019; c=relaxed/simple;
	bh=3j8GD7xAODSMjl/xpK6XJbDNh1t1Mq8PoTE6J/JC4Y8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u8V9NyHCh230XX3GgNwwHyl4uTjCOQY1Er8ot4YMj3c1zZwhGOpUr3ZPnEY7kd7RO2Y0pb8lAIdJPgGhf+IwMdCSzOG8KsHcM68KW5HaTZ6oqzcpw45ypjY7GcpCP/aBCINJKWE83mRcPZsIB4Gs6HpjMFsXc8D9oJKC5tZMP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=BNFZmNiJ; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="BNFZmNiJ"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2026020514001411f3d1541c00020772
        for <xenomai@lists.linux.dev>;
        Thu, 05 Feb 2026 15:00:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=oZBzAJNlOfvftFozHJ+9XXQ0DGXnGGq0styCILIWkUE=;
 b=BNFZmNiJkFXv9bYl0nQKMGrAqhPCR0htUjK2qCoJHoAIUOVOwJx/RH9c8/NNPifd4hPeZG
 +Mt4usvE831bmNTIoeguVly9QWv9NDIDZD9xuWOgFPZLyeckMEEEtfxOcsxGRMHGxgPN8y9q
 bL28LoeVuc+w/Gu6XhIbZOGgMsyZdmj6suo21LXhDqNks97jZoFP8QrKMDIVzYZaeEYryvpJ
 5FQKBKQTN/UZtJW3xpGrwd8MaDam13mJicVEi1PfNKq3lIZdK87uacyAQpM6+2w56RluaJeU
 Yury2y6K5zPblFQfgayaCqYddo+J4H6Yt849askekW2pFV4e13KeY1Tw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail 6.18 v2 0/4] Fix IPI mapping for arm64
Date: Thu, 05 Feb 2026 15:00:11 +0100
Message-Id: <20260201-wip-flo-fixes-for-6-18-v2-0-28b30dbcfdf8@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGuihGkC/4WOQQ6CMBREr0L+2k/aLii4cuEtDItSPvKT0poWq
 4ZwdysXcDczmZeZDRJFpgTnaoNImRMHX4w6VWBn4++EPBYPSqhGKCHxxQ+cXMCJ35RwChEblC0
 a1elOaT2OlqDAg0mEQzTezgX3T+dK+Ih0YCW5wTVkWg27X7upZQt9ETOnNcTPcSfLo/dvOUsU2
 EkyQltNg6ZLYlrIp9qGBfp9378Jf5I75QAAAA==
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

this is the result of a quite longish debugging session revealed by some
sporadic failures seen in CI.

Please review carefully as the code paths around the KGDB and BACKTRACE IPI
are not part of the hot path.

Backporting:
Patches 2 and 3 should go into Dovetail 6.12 as well. Older versions do
not have the BACKTRACE and KGDB IPIs implemented.

Cc: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Changes in v2:
- Patch 1: Reworked to address the LPI mapping issue only
- Patch 2: Unmodified
- Patch 3: Reworked to address the root cause properly
- Patch 4: New, address wrong IPI reason in tracepoint
- Link to v1: https://lore.kernel.org/r/20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com

---
Florian Bezdeka (4):
      arm64: irq_pipeline: Fix mapping of IPIs in LPI mode
      arm64: irq_pipeline: Fix size of IPI statistics array
      arm64: irq_pipeline: Fix IPI_KGDB_ROUNDUP and IPI_CPU_BACKTRACE IPIs
      arm64: irq_pipeline: Fix tracepoint for multiplexed IPIs

 arch/arm64/kernel/smp.c | 59 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 20 deletions(-)
---
base-commit: c30f265e8ac5feb0b7076141dd8877d0394e1437
change-id: 20260201-wip-flo-fixes-for-6-18-a2979277ddce

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

