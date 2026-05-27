Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479A221D590
	for <xenomai@lists.linux.dev>; Wed, 27 May 2026 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890876; cv=none; b=TWapmqTaYe3re0V4YYI8QwuIyFP73phInu4NoD0taSSkKMWRF1M89Ntek6bWN9IlCt79yDcgo52GaWe949kIge+P7LZ3s3EXFNN29d8dO/zHcgRh3IS0k5C16yWsCqpx/UugASC1NHAaFCIA29tmjFyIs0o7ISAuv+jt5upCQuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890876; c=relaxed/simple;
	bh=Jaf1yVsjZ/87tMXg3H28lZpztTcuKv0liNFeqW4v1+U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D22vr2D80NKZX/Hz1/xtB5A2N8t9c7INuSbHYsKsC7Tq+wBNjGTbDQ4wVV2ro9XP892F7SQCE//P4bNyWMDxavWDF+VqtUhnEVRtzMkgZCwyE+ImVS8Vl9gpiK0RUpN05Jc/IrVRQYcUSAhSdNPtGUzGrL9xkXuIEkKD6oF+Uw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Pm8wiZ09; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Pm8wiZ09"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260527140743d631a9e053000207a0
        for <xenomai@lists.linux.dev>;
        Wed, 27 May 2026 16:07:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=KHlbPNa7PE9hGnn29gtHh5rjvk6C6lPkcu39KGXY2Jc=;
 b=Pm8wiZ09PiufOYdJRi65dTAduBfPgJuUBDYiX6CesaEaPdDQuJWUvYS4iFFrvBPXajKVh2
 WXXDZsJhfiLCUH/CceEG58YhJk5jwIOeWvG4abYin9g5Htz5TmhWe2IzUCQ17ktdXTOaLgbo
 b5a363hzSHRpADU5PF4u1Ux+yH2Jn8C0yEM1s9287JfpJnhc4ZoqiVKaByJ3pUm7CTf5ZjmY
 3JNShAxedmnicCAmcN+aOKC1i9NNEwEWQjp4+kIlnq47C5zdp1p1cSIAJA+kvKoYrlk0G5j/
 nx36bseFL/ohQKpBXTq9sJNvoa4LZVRetgBwyS2MarxPibawESHRzJpQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/2] Add support for Dovetail >= 7.1
Date: Wed, 27 May 2026 16:07:36 +0200
Message-Id: <20260527-wip-flo-7-1-preparations-v1-0-b65d1304bb6b@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKj6FmoC/x2MQQqAIBAAvxJ7bkGlFPtKdBDbaiFKNCqI/t7Sc
 RhmHiiUmQp01QOZTi68bwK6riAuYZsJeRQGo4xVrXF4ccJp3dGhxpQphRwOaQq60ajYNNFr60F
 ykRPf/7of3vcDcuIAwGoAAAA=
X-Change-ID: 20260527-wip-flo-7-1-preparations-7d20c44c9169
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

These are the necessary changes to support Dovetail >= 7.1.

This series has been tested against 7.1, and 7.0 to make sure older
releases don't break. But: It might be - I haven't checked all supported
kernel versions yet - that the SPI changes need backporting. Waiting for
a full CI run to stress those cases.

Cc: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (2):
      drivers/spi: Prepare for linux/of_gpio.h removal in Linux 7.1
      cobalt/tick: Prepare for removal of CLOCK_EVT_FEAT_KTIME in Linux 7.1

 kernel/cobalt/dovetail/tick.c                        | 4 ++--
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 6 ++++++
 kernel/drivers/spi/spi-bcm2835.c                     | 3 ++-
 kernel/drivers/spi/spi-omap2-mcspi-rt.c              | 3 ++-
 4 files changed, 12 insertions(+), 4 deletions(-)
---
base-commit: 9fed9de228841e7bc6e3f55fdb44374f15acddc5
change-id: 20260527-wip-flo-7-1-preparations-7d20c44c9169

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

