Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B803C4B66E7
	for <xenomai@lists.linux.dev>; Tue,  8 Sep 2026 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865710; cv=none; b=D4AwDXujZXhgS9s6g3GIxwvWRMokAuZkMIiU0Amqaj0fv/ZxiaIkugeQVsRdCvodlqASCzP2pvhW3aZmrxlp68RRjFddxEqaDXlSHyDIM9ljiZfch8BrLKylGFLn5dimw0QsZbZ7l65+8NrJ+00J1A7KG+6faL65Yy9nTPGvFMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865710; c=relaxed/simple;
	bh=a7yEUHGvzdtZF5WfQpWy9nMPSOdT7JqDqSfQXUqhj3I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iC3HpnVRONgWClOYyMxouxLAKUYefz/fP5g8BTkYQ9+LUX1UmYcxXS0B0IqWk/622qND7kFwaI4M+ATlf3ujHI77832GFce2CH9MDKZUs3zuD5aYc8OMmxMzqn8mvIyrtuxsEHFPfZpQ2YUiKcGWBIP5HQEq2YYJaVXtxO1IR9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=P6nmVgbS; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="P6nmVgbS"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202609081108229ec4a5f661000207c2
        for <xenomai@lists.linux.dev>;
        Tue, 08 Sep 2026 13:08:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=HZMlkAB4BNYDWbiOkc3SsQwnu97E1fSUShtR9jd6L3s=;
 b=P6nmVgbSyczug4hpdHAYjgw6DYk38COk4/GhgqKcnlbVwCOaYHzpXk473OtRDbJWmMpUpi
 g71ovMxiVXEqB8ntiydQBlvr73ediYBEqHsoda1ZDQ+lUJxTODZSoqkJboqy9coaFT0y4ZT4
 4tseasoRtrPs6Dy74fJ3yknQOoeWdYYQHXQt8RlBNYQDqVyCOS0s7wl4LwjJrDcw2X2L8PMB
 9IAOjaJV8X//jRnL4iS5lm+sHS00DFKjDIK2IC//7FFF0bBmPOTOm5xVFd5bs3OeK3UdeL+N
 7rG/L0QSmFixWRuMv65/UmzatI0S6s1t6+NdfW9wk7kBDk7jDmJZAdwA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/2] xenomai 3: Add support for Dovetail 7.2
Date: Tue, 08 Sep 2026 13:08:20 +0200
Message-Id: <20260908-wip-flo-prepare-for-7-2-v1-0-eaf975a56944@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKTsn2oC/x2MQQqAIBAAvxJ7bsGMtPpKdJBaayFSVqgg/HvSc
 RhmXkgkTAnG6gWhixOHs0BTV7Ds7twIeS0MWmmjBtXjzRH9ETAKRSeEPgha1Oha6hrdkVWLgVI
 X7/n5z9Oc8wcidABzaQAAAA==
X-Change-ID: 20260908-wip-flo-prepare-for-7-2-a3e5125e70c6
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

Turns out the code base needs - at least - the following adjustments to
build against Dovetail 7.2.

This series has been build tested against Dovetail 6.1 and 7.2. There
was no CI run this time - I had to move on.

To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (2):
      cobalt: Replace strncpy() with strscpy()
      cobalt/x86: Replace {wr,rd}msrl() with {wr,rd}msrq()

 include/cobalt/kernel/ancillaries.h                        |  3 +--
 kernel/cobalt/arch/x86/c1e.c                               |  5 +++--
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h       |  2 ++
 kernel/drivers/can/c_can/rtcan_c_can_platform.c            |  2 +-
 kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c           |  2 +-
 kernel/drivers/can/rtcan_dev.c                             |  2 +-
 kernel/drivers/can/rtcan_flexcan.c                         |  2 +-
 kernel/drivers/can/rtcan_module.c                          | 14 +++++++-------
 kernel/drivers/can/rtcan_virt.c                            |  2 +-
 kernel/drivers/can/sja1000/rtcan_adv_pci.c                 |  2 +-
 kernel/drivers/can/sja1000/rtcan_ems_pci.c                 |  2 +-
 kernel/drivers/can/sja1000/rtcan_esd_pci.c                 |  2 +-
 kernel/drivers/can/sja1000/rtcan_isa.c                     |  2 +-
 kernel/drivers/can/sja1000/rtcan_ixxat_pci.c               |  2 +-
 kernel/drivers/can/sja1000/rtcan_mem.c                     |  2 +-
 kernel/drivers/can/sja1000/rtcan_peak_dng.c                |  2 +-
 kernel/drivers/can/sja1000/rtcan_peak_pci.c                |  2 +-
 kernel/drivers/can/sja1000/rtcan_plx_pci.c                 |  2 +-
 kernel/drivers/net/drivers/e1000e/netdev.c                 |  6 +++---
 .../drivers/net/drivers/experimental/e1000/e1000_ethtool.c |  8 ++++----
 kernel/drivers/net/drivers/experimental/e1000/e1000_main.c |  2 +-
 kernel/drivers/net/drivers/igb/igb_main.c                  |  2 +-
 kernel/drivers/net/drivers/igc/igc_main.c                  |  2 +-
 kernel/drivers/net/stack/ipv4/route.c                      |  2 +-
 kernel/drivers/net/stack/rtdev.c                           |  2 +-
 25 files changed, 39 insertions(+), 37 deletions(-)
---
base-commit: f40522cb9f6d971872c510028f2a44a7f19ba22f
change-id: 20260908-wip-flo-prepare-for-7-2-a3e5125e70c6

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

