Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C29719BD9
	for <xenomai@lists.linux.dev>; Thu, 31 Aug 2023 20:37:49 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230831203740a0c8c68a50a06e6144
        for <xenomai@lists.linux.dev>;
        Thu, 31 Aug 2023 22:37:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=js0oWCgs0kAqb/KhlDKTqJmNIw//g/tSb7FlUjTIweI=;
 b=BCpsXigKBoIFYPwzE20TgV4hAsvubQ+g7PcPOYDGsPwIHIk99LSazCaj9VVqHm7cb3EXtJ
 eIKir7HqGKbIO18PgzwAwdFYA2Ox3znkL9Mjqugs7ubI6kcCT0Keof22nkJqxJ6TCbq6IFc4
 Bup7+Bm+xBRfGF5SvAs6J5dV6P1rM=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 00/19] Enable stable/v3.2.x branch to be buildable with 6.1
 kernels
Date: Thu, 31 Aug 2023 22:37:26 +0200
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAb68GQC/yWNQQrDIBBFrxJm3UmNNkV6ldKFmrEZEC1jGgIhd
 6+kq8/7i/d2qCRMFR7dDkIrVy65wXDpIMwuvwl5agxaaaOsthhTEXYZKTufCOtyjkGNsQjeccC
 gJnubyMY4jtA83lVCLy6HuZnyN6V2foQib2f4CX/JdTW97jd4HccPUelhyJcAAAA=
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

with this series applied the stable/3.2.x branch gets buildable with
the 6.1 LTS series of Linux / dovetail.

Most of the patches were taken 1:1 from the master branch. The commit id
on the master branch is mentioned in each patch / commit.

The last patch is a manual backport to support 4.19 kernels. The
referenced commit in master did not have to care about such old kernels.
We already stopped supporting them in master. Please review carefully!

Best regards,
Florian

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (4):
      cobalt: Adjust dev_addr_set wrapper to 5.10, 5.1 and 4.19 backports
      cobalt/pipe: Allow building with kernels up to 6.1
      cobalt/x86: Allow building with kernels up to 6.1
      drivers/spi: Add support for kernels < 5.1

Jan Kiszka (15):
      Account for switch to pde_data in 5.17
      Use linux/stddef.h instead of toolchain header
      drivers/serial/16550A: Account for privatized defines in 5.17
      drivers/net: Switch to dev_addr_set and eth_hw_addr_set
      drivers: Convert pci_set_*dma_mask to DMA API
      drivers: Convert pci_alloc/free_consistent to DMA API
      drivers: Convert pci_map/unmap_single/page to DMA API
      drivers: Convert pci_dma_sync_single_for_cpu/device to DMA API
      cobalt: Resolve cast-function-type warnings
      drivers/net/experimental/e1000: Use fallthrough
      drivers/spi: Convert to GPIO descriptor API
      drivers/spi: Switch to spi_controller API
      drivers/spi: Account for dropped return value of spi_driver.remove
      drivers/testing/heapcheck: Replace prandom_u32 with custom implementation
      drivers/net/pcnet32: Adjust for kernel 6.1

 .../arch/x86/include/asm/xenomai/syscall32.h       |   3 +-
 .../cobalt/arch/x86/include/asm/xenomai/wrappers.h |   4 +-
 .../cobalt/include/asm-generic/xenomai/wrappers.h  |  15 +++
 kernel/cobalt/pipe.c                               |   1 +
 kernel/cobalt/posix/sem.c                          |   2 +-
 kernel/cobalt/posix/syscall.c                      |   3 +-
 kernel/cobalt/rtdm/device.c                        |  10 +-
 kernel/cobalt/rtdm/fd.c                            |   2 +-
 kernel/cobalt/vfile.c                              |   8 +-
 kernel/drivers/analogy/device.c                    |   2 +-
 kernel/drivers/analogy/national_instruments/mite.c |  12 +-
 kernel/drivers/analogy/national_instruments/mite.h |   4 +-
 kernel/drivers/can/rtcan_module.c                  |   4 +-
 kernel/drivers/can/sja1000/rtcan_sja1000_proc.c    |   2 +-
 kernel/drivers/net/addons/cap.c                    |   5 +-
 kernel/drivers/net/addons/proxy.c                  |   2 +-
 kernel/drivers/net/drivers/8139too.c               |  18 ++-
 kernel/drivers/net/drivers/e1000/e1000_main.c      |  84 ++++++++------
 kernel/drivers/net/drivers/eepro100.c              |  75 +++++++------
 kernel/drivers/net/drivers/experimental/3c59x.c    |  21 ++--
 .../net/drivers/experimental/e1000/e1000_82540.c   |   2 +-
 .../net/drivers/experimental/e1000/e1000_82571.c   |   2 +-
 .../net/drivers/experimental/e1000/e1000_ethtool.c |  14 ++-
 .../net/drivers/experimental/e1000/e1000_main.c    | 122 +++++++++++----------
 .../net/drivers/experimental/rt2500/rt2500pci.c    |   4 +-
 kernel/drivers/net/drivers/freescale/fec_main.c    |  11 +-
 kernel/drivers/net/drivers/natsemi.c               |  35 +++---
 kernel/drivers/net/drivers/pcnet32.c               |  57 +++++-----
 kernel/drivers/net/drivers/r8169.c                 |  36 +++---
 kernel/drivers/net/drivers/tulip/interrupt.c       |  18 +--
 kernel/drivers/net/drivers/tulip/tulip_core.c      |  51 +++++----
 kernel/drivers/net/drivers/via-rhine.c             |  71 ++++++------
 kernel/drivers/net/stack/rtmac/nomac/nomac_dev.c   |   4 +-
 kernel/drivers/net/stack/rtmac/rtmac_vnic.c        |   5 +-
 kernel/drivers/serial/16550A_pci.h                 |  19 +++-
 kernel/drivers/spi/spi-bcm2835.c                   |  63 +++++++----
 kernel/drivers/spi/spi-device.c                    |  61 +++++++----
 kernel/drivers/spi/spi-device.h                    |   1 -
 kernel/drivers/spi/spi-master.c                    |  31 +++---
 kernel/drivers/spi/spi-master.h                    |   2 +-
 kernel/drivers/spi/spi-omap2-mcspi-rt.c            |  20 ++--
 kernel/drivers/spi/spi-sun6i.c                     |  24 ++--
 kernel/drivers/testing/heapcheck.c                 |  14 ++-
 43 files changed, 542 insertions(+), 402 deletions(-)
---
base-commit: ee85e330c26c72974d57d4130c24e3369f1d85c4
change-id: 20230828-florian-enable-stable-3-2-for-6-1-c0d84de8ff55

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

