Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31B446AA
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:44 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 5D1812000F
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:37 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 516017803D2
	for <xenomai@xenomai.org>; Mon,  4 Jul 2022 13:08:36 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2022070413083576bbbc828aa6b9fc78
        for <xenomai@xenomai.org>;
        Mon, 04 Jul 2022 15:08:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ApJkPxWrtT8azRHMEYpqcswGTuib7UE6QnedsNh4fqo=;
 b=GVVlfdp0w1MZ/gm3AqhRDAWsUv+GUxsYIsIRjOd3AFcRhZXCoHKNJDMsIcV918cgdmwNAK
 9pR/PA/+VnfdkbfTEXtLp3R/X+1+2pnK+y6TpZbdH9ZbsdaDYO37iVMBRniiagIGeHG0QDFV
 qIWHXPGjJtax7MaAST30AzeH8QKMw=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Cc: Gunter Grau <gunter.grau@philips.com>,
	Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 00/15] Kernel 5.19 adjustments
Date: Mon,  4 Jul 2022 15:08:20 +0200
Message-Id: <cover.1656940114.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool4: domain of rts-flowmailer.siemens.com designates 185.136.64.227 as permitted sender) client-ip=185.136.64.227; envelope-from=fm-294854-2022070413083576bbbc828aa6b9fc78-_es__k@rts-flowmailer.siemens.com; helo=mta-64-227.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=GVVlfdp0;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-2022070413083576bbbc828aa6b9fc78-_es__k@rts-flowmailer.siemens.com designates 185.136.64.227 as permitted sender) smtp.mailfrom=fm-294854-2022070413083576bbbc828aa6b9fc78-_es__k@rts-flowmailer.siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

This allows to compile and run Xenomai against latest 5.19-dovetail. The
kernel deprecated a number of APIs that forces us to move on. Luckily,
we can do that unconditionally in many cases as our lower limit is now
5.10.

Philippe, could you have a look at the SPI changes, specifically at
"drivers/spi: Convert to GPIO descriptor API"? I'm unable to test and
unsure if the conversion of find_cs_gpio is correct.

Gunter, please review/test the fec driver conversion, it wasn't fully
mechanic.

Finally, this adds a CI job to identify the latest dovetail branch and
automatically try to build against it. Let's see how well this works,
but it should allow to catch porting needs earlier. A similar change is
pending for xenomai-images.

The tests look good, except for some likely Dovetail/Xenomai-unrelated
mainline regressions [1][2].

Jan

[1] https://source.denx.de/Xenomai/xenomai-images/-/jobs/459629#L534
[2] https://source.denx.de/Xenomai/xenomai-images/-/jobs/459713#L738


CC: Gunter Grau <gunter.grau@philips.com>
CC: Philippe Gerum <rpm@xenomai.org>

Jan Kiszka (15):
  Account for switch to pde_data in 5.17
  Use linux/stddef.h instead of toolchain header
  drivers/switchtest: Remove unused local vars
  drivers/serial/16550A: Account for privatized defines in 5.17
  drivers/net: Switch to dev_addr_set
  drivers: Convert pci_set_*dma_mask to DMA API
  drivers: Convert pci_alloc/free_consistent to DMA API
  drivers: Convert pci_map/unmap_single/page to DMA API
  drivers: Convert pci_dma_sync_single_for_cpu/device to DMA API
  cobalt: Resolve cast-function-type warnings
  drivers/net/experimental/e1000: Use fallthrough
  drivers/spi: Convert to GPIO descriptor API
  drivers/spi: Switch to spi_controller API
  drivers/spi: Account for dropped return value of spi_driver.remove
  ci: Add targets for latest dovetail queue

 .gitlab-ci.yml                                |  26 +++-
 .../arch/x86/include/asm/xenomai/syscall32.h  |   3 +-
 .../include/asm-generic/xenomai/wrappers.h    |   8 ++
 kernel/cobalt/posix/sem.c                     |   2 +-
 kernel/cobalt/posix/syscall.c                 |   3 +-
 kernel/cobalt/rtdm/device.c                   |  10 +-
 kernel/cobalt/rtdm/fd.c                       |   2 +-
 kernel/cobalt/vfile.c                         |   8 +-
 kernel/drivers/analogy/device.c               |   2 +-
 .../analogy/national_instruments/mite.c       |  12 +-
 .../analogy/national_instruments/mite.h       |   4 +-
 kernel/drivers/can/rtcan_module.c             |   4 +-
 .../drivers/can/sja1000/rtcan_sja1000_proc.c  |   2 +-
 kernel/drivers/net/addons/cap.c               |   5 +-
 kernel/drivers/net/addons/proxy.c             |   2 +-
 kernel/drivers/net/drivers/8139too.c          |  18 ++-
 kernel/drivers/net/drivers/e1000/e1000_main.c |  84 ++++++------
 kernel/drivers/net/drivers/eepro100.c         |  75 ++++++-----
 .../drivers/net/drivers/experimental/3c59x.c  |  21 +--
 .../drivers/experimental/e1000/e1000_82540.c  |   2 +-
 .../drivers/experimental/e1000/e1000_82571.c  |   2 +-
 .../experimental/e1000/e1000_ethtool.c        |  14 +-
 .../drivers/experimental/e1000/e1000_main.c   | 122 +++++++++---------
 .../drivers/experimental/rt2500/rt2500pci.c   |   4 +-
 .../drivers/net/drivers/freescale/fec_main.c  |  11 +-
 kernel/drivers/net/drivers/natsemi.c          |  35 ++---
 kernel/drivers/net/drivers/pcnet32.c          |  52 ++++----
 kernel/drivers/net/drivers/r8169.c            |  36 +++---
 kernel/drivers/net/drivers/tulip/interrupt.c  |  18 +--
 kernel/drivers/net/drivers/tulip/tulip_core.c |  51 ++++----
 kernel/drivers/net/drivers/via-rhine.c        |  71 +++++-----
 .../drivers/net/stack/rtmac/nomac/nomac_dev.c |   4 +-
 kernel/drivers/net/stack/rtmac/rtmac_vnic.c   |   5 +-
 kernel/drivers/serial/16550A_pci.h            |  19 ++-
 kernel/drivers/spi/spi-bcm2835.c              |  41 +++---
 kernel/drivers/spi/spi-device.c               |  34 ++---
 kernel/drivers/spi/spi-device.h               |   1 -
 kernel/drivers/spi/spi-master.c               |  29 +++--
 kernel/drivers/spi/spi-master.h               |   2 +-
 kernel/drivers/spi/spi-omap2-mcspi-rt.c       |  20 +--
 kernel/drivers/spi/spi-sun6i.c                |  24 ++--
 kernel/drivers/testing/switchtest.c           |   2 +-
 42 files changed, 493 insertions(+), 397 deletions(-)

-- 
2.35.3

