Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A90B4314A
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434678; cv=none; b=gzswFw1h+MwENueSKM5T0LtIr3/rUTugYBRSlcHQtTor0nG6uWDMH96DooNxWnk05Dojqt7IwyPIUkngeCoStCTIlGzKMqhryDJ7UwBfnA5WbZYcvfCL44QBzcorHd1XW8dlTZZM3GAQscwhcZ3Fl5fas39sR+rHoTJ1tJ7vdb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434678; c=relaxed/simple;
	bh=uyAM5jP7rsugpU8tkhR6FSJZKiH4y4p/KMA0o32puLw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ouyTrtkldUIpPWjtbvEJcxi7bPkmd6NdGXtr8eDQnUd8SYZnBpHw+X+Hn0v5TtKjSy7u+96cr6E7nLqC8MapPC/EhJuxrWyR5j0I/3dlbKtRkMmzz+e99UWH19JMP9t3gB4BwERrJohr5fX6FkmYlrfflJWYYk7veVEqZyMtPlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=FfOx7NXu; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="FfOx7NXu"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202403260631069710f48edd3da396b2
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=gnVvroWW2fZU11wk+ccooRMHbibgsyPObuhmN2/TPlM=;
 b=FfOx7NXurJiafT6+ZPkjVkkHVXBxdCusU5+BQX9XFd57NwqlovyN4P9TybJdh3RDBdqiWt
 rbpeASThrnmp54TburuCin//8hvUi/57IWhcIQNGPnnYNBG6M/x8a1DluX40JKyo6UOWbY5Y
 g/JEg9a5ZVlB/DDI8Xv2EEi/Tks0M=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 00/25] Support for kernel 6.8
Date: Tue, 26 Mar 2024 07:30:39 +0100
Message-Id: <cover.1711434664.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

Primarily, a lot of 'static' annotations for private functions and some
proper headers with prototypes. See patches for details.

Jan

Jan Kiszka (25):
  Account for renaming of MAX_ORDER in kernel 6.8
  cobalt/synch: add [__cobalt_mutex_]lookup_lazy_pp prototype to header
  cobalt/rtdm: Drop __rtdm_synch_flush from public interface
  Drop duplicate define of inclusion guard
  cobalt/arith: Only implement xnarch_generic_full_divmod64 when used
  cobalt: Address missing prototype warnings by adding includes
  cobalt: Make private functions static
  analogy/national_instruments: Drop dead mio_common_detach
  drivers/analogy: Make private functions static
  drivers/autotune: Make private functions static
  drivers/can/corectl: Provide proper prototypes via corectl.h
  drivers/can/c_can: Replace deprecated strlcpy with strscpy
  drivers/can: Make private functions static
  drivers/gpio: Address missing prototype warnings by adding includes
  drivers/gpio: Make private functions static
  drivers/ipc: Make private functions static
  drivers/net/ipv4: Align signatures of rt_ip_build_xmit
  drivers/net: Address missing prototype warnings by adding includes
  drivers/net/corectl: Provide proper prototypes via corectl.h
  drivers/net: Make rtdev_init private
  drivers/net/e1000: Move e1000_check_options prototype to a header
  drivers/net: Make private functions static
  drivers/serial: Make private functions static
  drivers/spi: Use spi_get_chipselect/gpiod
  drivers/testing: Make private functions static

 include/cobalt/kernel/synch.h                 |  2 +
 include/cobalt/uapi/asm-generic/arith.h       | 11 ++-
 kernel/cobalt/arch/x86/c1e.c                  |  1 +
 .../arch/x86/include/asm/xenomai/uapi/arith.h |  1 -
 kernel/cobalt/arch/x86/smi.c                  |  1 +
 kernel/cobalt/arith.c                         |  3 +
 kernel/cobalt/clock.c                         |  8 +-
 kernel/cobalt/dovetail/kevents.c              |  2 +-
 kernel/cobalt/dovetail/syscall.c              |  1 +
 .../include/asm-generic/xenomai/wrappers.h    |  9 ++
 kernel/cobalt/posix/mqueue.c                  |  4 +-
 kernel/cobalt/posix/mutex.c                   |  2 +-
 kernel/cobalt/posix/syscall.c                 |  1 +
 kernel/cobalt/procfs.c                        |  1 +
 kernel/cobalt/rtdm/drvlib.c                   |  4 +-
 kernel/cobalt/synch.c                         |  4 +-
 kernel/cobalt/timer.c                         |  2 +-
 kernel/cobalt/vfile.c                         |  8 +-
 kernel/drivers/analogy/buffer.c               |  4 +-
 kernel/drivers/analogy/command.c              | 10 ++-
 kernel/drivers/analogy/device.c               | 25 +++---
 kernel/drivers/analogy/instruction.c          | 25 ++++--
 kernel/drivers/analogy/intel/8255.c           | 13 +--
 .../analogy/national_instruments/mio_common.c | 90 ++++++++++---------
 .../analogy/national_instruments/mite.c       |  2 +-
 kernel/drivers/analogy/rtdm_interface.c       | 20 ++---
 kernel/drivers/analogy/testing/fake.c         | 32 +++----
 kernel/drivers/autotune/autotune.c            |  2 +-
 .../drivers/can/c_can/rtcan_c_can_ethtool.c   |  6 +-
 kernel/drivers/can/corectl.c                  |  1 +
 kernel/drivers/can/corectl.h                  |  7 ++
 kernel/drivers/can/rtcan_module.c             |  9 +-
 kernel/drivers/can/rtcan_raw.c                | 16 ++--
 kernel/drivers/can/sja1000/rtcan_isa.c        |  2 +-
 kernel/drivers/can/sja1000/rtcan_mem.c        |  2 +-
 kernel/drivers/can/sja1000/rtcan_peak_dng.c   |  4 +-
 kernel/drivers/can/sja1000/rtcan_sja1000.c    | 19 ++--
 kernel/drivers/gpio/gpio-core.c               |  3 +-
 kernel/drivers/ipc/rtipc.c                    |  4 +-
 kernel/drivers/net/addons/cap.c               | 15 ++--
 kernel/drivers/net/drivers/e1000/e1000.h      |  2 +
 kernel/drivers/net/drivers/e1000/e1000_main.c |  8 --
 kernel/drivers/net/drivers/e1000e/netdev.c    |  4 +-
 .../drivers/experimental/rt2500/rt2500pci.c   | 17 ++--
 kernel/drivers/net/drivers/igc/igc_main.c     |  8 +-
 kernel/drivers/net/drivers/r8169.c            |  4 +-
 kernel/drivers/net/drivers/via-rhine.c        |  2 +-
 kernel/drivers/net/stack/corectl.c            |  1 +
 kernel/drivers/net/stack/eth.c                |  1 +
 kernel/drivers/net/stack/include/corectl.h    | 20 +++++
 kernel/drivers/net/stack/ipv4/arp.c           |  2 +-
 kernel/drivers/net/stack/ipv4/icmp.c          |  8 +-
 kernel/drivers/net/stack/ipv4/ip_output.c     | 15 ++--
 kernel/drivers/net/stack/ipv4/ip_sock.c       | 21 +++--
 kernel/drivers/net/stack/ipv4/tcp/tcp.c       |  4 +-
 kernel/drivers/net/stack/ipv4/udp/udp.c       | 30 ++++---
 .../net/stack/rtcfg/rtcfg_client_event.c      |  1 +
 kernel/drivers/net/stack/rtcfg/rtcfg_frame.c  |  4 +-
 kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c  | 24 ++---
 kernel/drivers/net/stack/rtcfg/rtcfg_module.c |  4 +-
 kernel/drivers/net/stack/rtcfg/rtcfg_proc.c   | 15 ++--
 kernel/drivers/net/stack/rtcfg/rtcfg_timer.c  |  2 +-
 kernel/drivers/net/stack/rtdev.c              |  6 +-
 kernel/drivers/net/stack/rtdev_mgr.c          |  1 +
 .../drivers/net/stack/rtmac/nomac/nomac_dev.c |  1 +
 .../net/stack/rtmac/nomac/nomac_ioctl.c       |  1 +
 .../net/stack/rtmac/nomac/nomac_module.c      | 10 +--
 .../net/stack/rtmac/nomac/nomac_proto.c       |  3 +-
 kernel/drivers/net/stack/rtmac/rtmac_module.c |  4 +-
 kernel/drivers/net/stack/rtmac/rtmac_proto.c  |  2 +-
 .../drivers/net/stack/rtmac/tdma/tdma_dev.c   |  1 +
 .../drivers/net/stack/rtmac/tdma/tdma_ioctl.c |  7 +-
 .../net/stack/rtmac/tdma/tdma_module.c        | 12 +--
 .../net/stack/rtmac/tdma/tdma_worker.c        |  1 +
 kernel/drivers/net/stack/rtnet_module.c       |  5 +-
 kernel/drivers/net/stack/rtwlan.c             |  4 +-
 kernel/drivers/serial/16550A.c                | 18 ++--
 kernel/drivers/serial/rt_imx_uart.c           |  6 +-
 kernel/drivers/spi/spi-bcm2835.c              | 17 ++--
 kernel/drivers/spi/spi-device.c               | 14 +--
 kernel/drivers/spi/spi-omap2-mcspi-rt.c       | 13 +--
 kernel/drivers/testing/switchtest.c           |  4 +-
 82 files changed, 392 insertions(+), 311 deletions(-)
 create mode 100644 kernel/drivers/can/corectl.h
 create mode 100644 kernel/drivers/net/stack/include/corectl.h

-- 
2.35.3

