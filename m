Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB797320386
	for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520016; cv=none; b=gyjZ0rl+RxfluM4jhEl6aabdHYPwlB9Fm7w4tl6EdJdvOwPRuMqATo9Z4xpqU6IQz+nfhQXC3AHdwMXU5Nl4H96ylTgqoDlKPijdtb0hzIZjHqvycTasfZB1qh607u1Eoin57zGN/KtJyb/YOYdFRCbTG97QRx9U49rMAr7g7Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520016; c=relaxed/simple;
	bh=k1VHTTwLHUhXWT57jQ87lvWxf/P8pysnhAJqQ46QGC0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ieHyOZKqYF+Vi/IsRhkw6tDzO+ubMvPyXMBQH+8M85WQHgRdTHQbVybD7hzY6SBnEPYD6IINY4WhDqWAyBZQJOMbxQdIl6q9f3pjugIeIna3Y0aFcEijFlSPEget9Hzq1RGNwKE2oboxfWsGqrAo2T3kTrmysM7kvmq+x5+OrZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=BFV6vbMS; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="BFV6vbMS"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025081812264410305a008a591dae7d
        for <xenomai@lists.linux.dev>;
        Mon, 18 Aug 2025 14:26:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=O5/9fYSqLtiKRuB+LCWMu6s5Ershkr38u4BGq6779qo=;
 b=BFV6vbMS1m6yPbBwEZzJwtmXDBDT6IVTY2xUNWCfFNtCaEmaN4LE5u4q+Fvqr1GTrWBQQ1
 66EL25jv9YoljqoKqfPCkCQnoGfrU75AW9aq+6Gk5VsTnSEvqBwQ+VwxOyP+VzBLqAh+1RF+
 fUb+JhFxVm8Saf2EtULPMkxhlaJuIeXtOWCT8FEKZYj3L9uH7RPLo8OI9SfNxZ97cb5dkqnt
 dx4keabsjbK3I4jdmLLlcKjcArq5/9neuulOQo6rsGgqyw8qoF55AS1y9Rv3Cnxnp6PmJH6a
 VKHE7E8SodPeZnQ6ebUxncxtFXbh9Vn3L/EbAeLm9lQCA7QKm3/hgpfA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 00/13] Add missing MODULE_DESCRIPTION() to all affected
 drivers
Date: Mon, 18 Aug 2025 14:26:42 +0200
Message-Id: <20250812-wip-flo-add-missing-module-descriptions-v1-0-c57f195e3f93@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAIco2gC/x3NQQqDMBCF4avIrDtgDFLtVUoXMRl1ICYho21Bv
 HuHLv+3+N4JQpVJ4NGcUOnNwjlpmFsDfnVpIeSgDV3b9e1gOvxwwTlmdCHgxiKcFtxyOCJhIPG
 Vy66E4OBdb8lYO95HUG1yQjhVl/yqXjpi1LFUmvn7v3++rusH+ARHGo4AAAA=
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

when building Xenomai against newer Dovetail/Linux versions build
warnings like the following occur:

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xenomai/net/stack/ipv4/rtipv4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xenomai/net/stack/ipv4/udp/rtudp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xenomai/net/stack/ipv4/tcp/rttcp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xenomai/net/stack/packet/rtpacket.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xenomai/net/stack/rtmac/tdma/tdma.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xenomai/net/stack/rtmac/rtmac.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xenomai/net/stack/rtcfg/rtcfg.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xenomai/udd/xeno_udd.o

I went through all drivers that had a MODULE_LICENSE() but no
MODULE_DESCRIPTION() and added the latter.

Cc: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (13):
      drivers/gpio: Add missing MODULE_DESCRIPTION()
      drivers/testing: Add missing MODULE_DESCRIPTION()
      drivers/analogy/national_instruments: Add missing MODULE_DESCRIPTION()
      drivers/net/freescale: Add missing MODULE_DESCRIPTION()
      drivers/eth1394: Add missing MODULE_DESCRIPTION()
      drivers/stack/rtmac: Add missing MODULE_DESCRIPTION()
      drivers/stack/ipv4: Add missing MODULE_DESCRIPTION()
      drivers/stack/packet: Add missing MODULE_DESCRIPTION()
      drivers/stack/rtcfg: Add missing MODULE_DESCRIPTION()
      drivers/net/addons: Add missing MODULE_DESCRIPTION()
      drivers/can: Add missing MODULE_DESCRIPTION()
      drivers/spi: Add missing MODULE_DESCRIPTION()
      drivers/udd: Add missing MODULE_DESCRIPTION()

 kernel/drivers/analogy/national_instruments/mite.c  | 1 +
 kernel/drivers/can/rtcan_module.c                   | 1 +
 kernel/drivers/gpio/gpio-bcm2711.c                  | 1 +
 kernel/drivers/gpio/gpio-bcm2835.c                  | 2 +-
 kernel/drivers/gpio/gpio-cherryview.c               | 1 +
 kernel/drivers/gpio/gpio-mxc.c                      | 1 +
 kernel/drivers/gpio/gpio-omap.c                     | 1 +
 kernel/drivers/gpio/gpio-sun8i-h3.c                 | 1 +
 kernel/drivers/gpio/gpio-xilinx.c                   | 2 +-
 kernel/drivers/gpio/gpio-zynq7000.c                 | 2 +-
 kernel/drivers/net/addons/cap.c                     | 1 +
 kernel/drivers/net/addons/proxy.c                   | 1 +
 kernel/drivers/net/drivers/eth1394.c                | 1 +
 kernel/drivers/net/drivers/freescale/fec_main.c     | 1 +
 kernel/drivers/net/stack/ipv4/af_inet.c             | 1 +
 kernel/drivers/net/stack/ipv4/tcp/tcp.c             | 1 +
 kernel/drivers/net/stack/ipv4/udp/udp.c             | 1 +
 kernel/drivers/net/stack/packet/af_packet.c         | 1 +
 kernel/drivers/net/stack/rtcfg/rtcfg_module.c       | 1 +
 kernel/drivers/net/stack/rtmac/nomac/nomac_module.c | 1 +
 kernel/drivers/net/stack/rtmac/rtmac_module.c       | 1 +
 kernel/drivers/net/stack/rtmac/tdma/tdma_module.c   | 1 +
 kernel/drivers/spi/spi-bcm2835.c                    | 1 +
 kernel/drivers/spi/spi-master.c                     | 1 +
 kernel/drivers/spi/spi-omap2-mcspi-rt.c             | 1 +
 kernel/drivers/spi/spi-sun6i.c                      | 1 +
 kernel/drivers/testing/heapcheck.c                  | 1 +
 kernel/drivers/udd/udd.c                            | 1 +
 28 files changed, 28 insertions(+), 3 deletions(-)
---
base-commit: 8569b52053cb766a913d18118f4ede2666a9ae4c
change-id: 20250812-wip-flo-add-missing-module-descriptions-8ca53e133979

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

