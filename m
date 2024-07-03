Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F5179641
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013149; cv=none; b=gKkOPU26IsucJ+pQxgPg0p6WHXBDaeSTVKZk0naT+BmOZqmV/R5aGAbI9aiAImDRZOmhTjIZAURAgOqFx8ZR5bCe5st6skRqOYkR2ORyBx8Crr1+SAGZ3iplF0s6r6N4wJCk0/FlPhGHrNUDpHwSHLk7urOFf9f4f3iuXoHIi+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013149; c=relaxed/simple;
	bh=l4LtzAfrV91eVOKQkKlHYCR2fWzvC+PrhnAeytX9A5o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W9+4lhhTEKwzX8PDJBa2P4NN8lVAyRSxPkpZKIOHifq5k63C3t+lBy/R1chwPPQoe30Jdk9mwLXb5YrIduOGzUSItmbTa8oqn1zA/gLVNBldDNRgGCgaxnYfvCcpmxC90zO9su30mlYQAsgVQ0WTgXHJOHGV9YelPrHbCfrj02A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=GFi93xCW; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="GFi93xCW"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240703132537a5aa3dde32d569b8a7
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Yky8T7vyFGuswV8Zp6b3JHa+6oxr3syM8stLacXEwKA=;
 b=GFi93xCWDNUWAehJQva0BArv3maPs87MK5Z7Ud5jr7O/pR/4aMRB2rK39atHJtTx7zL5Rc
 JMjsGRqZo27cZhj9ybUFFEesA2mjPNVpU35zlodxOEgN4v3izfXeTKUqYWdFKELPeBGFMOd8
 QYF5i5gKNJuWSetvvVbqFQY4HPUMM=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 00/33] drivers: Fix missing printk log levels, remove
 rtdm_printk()
Date: Wed, 03 Jul 2024 15:25:23 +0200
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAENRhWYC/x2N0QrCMAwAf2Xk2UDNFNFfEZF0S12wa0c6hzD27
 yt7vHu4W6GIqRR4NCuYLFo0pwrnUwPdwOkjqH1lIEcXd3OEIWY0GfPCEXNAm/vxPZmm+Yv+2pJ
 jYrq3DmrAcxH0xqkbaiL9YqxyMgn6P47P17btyBCYlYEAAAA=
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

some background first:

It happened several times now that logs produced by CI runs contained
important warnings (or any log level above) but the actual test run was
still marked as success.

The idea is to add something like a "dmesg check" script to the CI
infrastructure that basically fails the CI run if anything above Warning
(or any other defined log level) is detected.

That requries us to get "warn free". The problem: The default value of
CONFIG_MESSAGE_LOGLEVEL_DEFAULT is 4, which means WARNING. So whenever 
someone calls printk() without any log level it will generate a warning.

This series revisits all of our printk() calls, making sure we use the
correct log level. Especially printing version information is no longer
producing warnings.

As most printk() calls reside in drivers there is another point that is
addressed now: Migrate away from rtdm_printk(). This function will be
removed at the end. rtmd_printk() was only a wrapper for printk(). We
can remove this wrapper and migrate to the "modern" pr_*()
infrastructure.

With that series applied we are closer to the "warn free" goal, but not
there yet. Some remaining "warnings" have to be addressed upstream while
others might not go away in all of our test scenarios. Some filtering
might be necessary... We might find some inspiration at the kernel CI
project.

This series is compile tested only, no runtime tests could be performed
on my side. I don't have the necessary hardware at hand.

CC: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (33):
      cobalt/clock: Use xenomai specific log level
      cobalt/x86: Add missing log level to printk()
      drivers/analogy: Migrate from rtdm_printk() and printk() to pr_*()
      drivers/serial: Migrate from printk() to pr_*()
      drivers/can/peak_canfd: Migrate from rtdm_printk() to pr_*()
      drivers/can/sja1000: Migrate from printk() to pr_*()
      drivers/can: Migrate from rtdm_printk() and printk() to pr_*()
      drivers/net/addons: Migrate from rtdm_printk() and printk() to pr_*()
      drivers/net/e1000: Migrate from rtdm_printk() and printk() to pr_*()
      drivers/net/e1000e: Migrate from printk() to pr_*()
      drivers/experimental/e1000: Migrate from rtdm_printk() and printk() to pr_*()
      drivers/experimental/rt2500: Migrate from rtdm_printk() and printk() to pr_*()
      drivers/freescale: Add missing log levels of rtdm_printk_ratelimited()
      drivers/tulip: Migrate from rtdm_printk() and printk() to pr_*()
      drivers/8139too: Migrate from rtdm_printk() and printk() to pr_*()
      drivers/eepro100: Migrate from rtdm_printk() and printk() to pr_*()
      drivers/eth1394: Migrate from rtdm_printk() and printk() to pr_*()
      drivers/natsemi: Migrate from rtdm_printk() and printk() to pr_*()
      drivers/pcnet32: Migrate from printk() to pr_*()
      drivers/r8169: Migrate from printk() to pr_*()
      drivers/r8169: Remove RT_DBG_PRINT() macro
      drivers/r8169: Remove DBG_PRINT() macro
      drivers/r8169: Remove rt_assert() macro
      drivers/r8169: Rework assert()
      drivers/via-rhine: Migrate from rtdm_printk() and printk() to pr_*()
      drivers/experimental/3c59x: Remove unused / broken driver
      drivers/stack/ipv4: Migrate from rtdm_printk() and printk() to pr_*()
      drivers/net/stack/rtcfg: Migrate from rtdm_printk() and printk() to pr_*()
      drivers/stack/rtmac: Migrate from rtdm_printk() and printk() to pr_*()
      drivers/stack/rtwlan: Migrate from rtdm_printk() and printk() to pr_*()
      drivers/stack: Migrate from rtdm_printk() and printk() to pr_*()
      drivers/spi: Migrate from printk() to pr_*()
      cobalt/rtdm: Finally remove rtdm_printk()

 include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h  |   16 +-
 include/cobalt/kernel/rtdm/driver.h                |    2 -
 kernel/cobalt/arch/x86/c1e.c                       |    4 +-
 kernel/cobalt/clock.c                              |    2 +-
 kernel/cobalt/rtdm/drvlib.c                        |   13 -
 .../analogy/national_instruments/mio_common.c      |    3 +
 kernel/drivers/analogy/national_instruments/mite.c |   68 +-
 .../drivers/analogy/national_instruments/ni_660x.c |    2 +
 .../drivers/analogy/national_instruments/ni_mio.h  |    2 +-
 .../drivers/analogy/national_instruments/ni_stc.h  |   19 +-
 .../drivers/analogy/national_instruments/pcimio.c  |   21 +-
 kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c   |   41 +-
 kernel/drivers/can/rtcan_dev.c                     |   12 +-
 kernel/drivers/can/rtcan_internal.h                |   14 +-
 kernel/drivers/can/rtcan_module.c                  |   10 +-
 kernel/drivers/can/rtcan_raw.c                     |    4 +-
 kernel/drivers/can/rtcan_raw_filter.c              |    9 +-
 kernel/drivers/can/rtcan_virt.c                    |   16 +-
 kernel/drivers/can/sja1000/rtcan_adv_pci.c         |    4 +-
 kernel/drivers/can/sja1000/rtcan_esd_pci.c         |   10 +-
 kernel/drivers/can/sja1000/rtcan_isa.c             |    8 +-
 kernel/drivers/can/sja1000/rtcan_ixxat_pci.c       |   17 +-
 kernel/drivers/can/sja1000/rtcan_mem.c             |    8 +-
 kernel/drivers/can/sja1000/rtcan_peak_dng.c        |   25 +-
 kernel/drivers/can/sja1000/rtcan_peak_pci.c        |   22 +-
 kernel/drivers/can/sja1000/rtcan_sja1000.c         |   25 +-
 kernel/drivers/net/addons/cap.c                    |   22 +-
 kernel/drivers/net/addons/proxy.c                  |   10 +-
 kernel/drivers/net/doc/README.drvporting           |    3 +-
 kernel/drivers/net/drivers/8139too.c               |   50 +-
 kernel/drivers/net/drivers/e1000/e1000.h           |   16 +-
 kernel/drivers/net/drivers/e1000/e1000_main.c      |   18 +-
 kernel/drivers/net/drivers/e1000/e1000_osdep.h     |    2 +-
 kernel/drivers/net/drivers/e1000e/netdev.c         |  205 +-
 kernel/drivers/net/drivers/eepro100.c              |  235 +-
 kernel/drivers/net/drivers/eth1394.c               |   83 +-
 kernel/drivers/net/drivers/experimental/3c59x.c    | 2752 --------------------
 kernel/drivers/net/drivers/experimental/Kconfig    |    4 -
 kernel/drivers/net/drivers/experimental/Makefile   |    4 -
 .../drivers/net/drivers/experimental/e1000/e1000.h |   14 +-
 .../net/drivers/experimental/e1000/e1000_main.c    |   32 +-
 .../net/drivers/experimental/rt2500/rt2500pci.c    |    4 +-
 .../net/drivers/experimental/rt2500/rt2x00.h       |   37 +-
 .../net/drivers/experimental/rt2500/rt2x00core.c   |    7 +-
 kernel/drivers/net/drivers/freescale/fec_main.c    |    8 +-
 kernel/drivers/net/drivers/natsemi.c               |  188 +-
 kernel/drivers/net/drivers/pcnet32.c               |  136 +-
 kernel/drivers/net/drivers/r8169.c                 |  219 +-
 kernel/drivers/net/drivers/tulip/21142.c           |    6 +-
 kernel/drivers/net/drivers/tulip/eeprom.c          |   22 +-
 kernel/drivers/net/drivers/tulip/interrupt.c       |   42 +-
 kernel/drivers/net/drivers/tulip/media.c           |   38 +-
 kernel/drivers/net/drivers/tulip/pnic.c            |    4 +-
 kernel/drivers/net/drivers/tulip/pnic2.c           |   14 +-
 kernel/drivers/net/drivers/tulip/tulip_core.c      |   96 +-
 kernel/drivers/net/drivers/via-rhine.c             |  184 +-
 kernel/drivers/net/stack/include/rtcfg/rtcfg.h     |    5 +-
 kernel/drivers/net/stack/include/rtmac/tdma/tdma.h |    9 -
 kernel/drivers/net/stack/include/rtnet_internal.h  |    2 +-
 kernel/drivers/net/stack/include/rtwlan.h          |   14 -
 kernel/drivers/net/stack/ipv4/icmp.c               |   25 +-
 kernel/drivers/net/stack/ipv4/ip_fragment.c        |   17 +-
 kernel/drivers/net/stack/ipv4/ip_input.c           |    4 +-
 kernel/drivers/net/stack/ipv4/protocol.c           |    4 +-
 kernel/drivers/net/stack/ipv4/route.c              |   21 +-
 kernel/drivers/net/stack/ipv4/tcp/tcp.c            |   62 +-
 kernel/drivers/net/stack/ipv4/tcp/timerwheel.c     |    9 +-
 kernel/drivers/net/stack/ipv4/udp/udp.c            |    4 +-
 .../drivers/net/stack/rtcfg/rtcfg_client_event.c   |    5 +-
 kernel/drivers/net/stack/rtcfg/rtcfg_module.c      |    6 +-
 kernel/drivers/net/stack/rtcfg/rtcfg_proc.c        |    4 +-
 kernel/drivers/net/stack/rtdev.c                   |   20 +-
 .../drivers/net/stack/rtmac/nomac/nomac_module.c   |    6 +-
 kernel/drivers/net/stack/rtmac/rtmac_disc.c        |   14 +-
 kernel/drivers/net/stack/rtmac/rtmac_module.c      |    6 +-
 kernel/drivers/net/stack/rtmac/rtmac_proc.c        |    4 +-
 kernel/drivers/net/stack/rtmac/rtmac_proto.c       |    9 +-
 kernel/drivers/net/stack/rtmac/rtmac_vnic.c        |    4 +-
 kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c   |   10 +-
 kernel/drivers/net/stack/rtmac/tdma/tdma_module.c  |    7 +-
 kernel/drivers/net/stack/rtmac/tdma/tdma_proto.c   |   15 +-
 kernel/drivers/net/stack/rtnet_chrdev.c            |    4 +-
 kernel/drivers/net/stack/rtnet_module.c            |   10 +-
 kernel/drivers/net/stack/rtskb.c                   |   13 +-
 kernel/drivers/net/stack/rtwlan.c                  |    6 +-
 kernel/drivers/net/stack/stack_mgr.c               |   10 +-
 kernel/drivers/serial/mpc52xx_uart.c               |    9 +-
 kernel/drivers/spi/spi-master.c                    |    2 +-
 88 files changed, 1187 insertions(+), 3985 deletions(-)
---
base-commit: 00454d5d127c29b93f8c0babf1336bfc35be3b98
change-id: 20240702-flo-removal-of-rtdm_printk-b5320a2a2930

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

