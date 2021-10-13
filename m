From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 0/9] Enable support for kernel 5.15
Date: Wed, 13 Oct 2021 13:55:44 +0200
Message-Id: <cover.1634126152.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Most of these are harmless conversions with backward-compatible
wrappings. Only the last patch is a bit hairy as I'm unsure whether the
new detection mechanism for vDSO VMAs is truly reliable. Therefore, this
patch is not (yet?) targeting next, thus 3.2-rc2.

Jan


CC: Philippe Gerum <rpm@xenomai.org>

Jan Kiszka (9):
  cobalt/dovetail: Use IRQ_WORK_INIT to please 5.11+
  cobalt: Use close_fd for kernel 5.14+
  cobalt: Use linux/stdarg.h
  cobalt/posix: Add required FORCE makefile rule
  cobalt/thread: Switch to MAX_RT_PRIO
  cobalt: Use fallthrough key word rather than comments
  drivers/can: Drop MODULE_SUPPORTED_DEVICE
  drivers/net/e1000e: Add missing ethtool.h include
  cobalt/debug: Detect vDSO via absence of vm_file

 .../kernel/dovetail/pipeline/inband_work.h    |  6 +-----
 kernel/cobalt/debug.c                         | 12 +++++------
 kernel/cobalt/heap.c                          |  2 +-
 .../include/asm-generic/xenomai/wrappers.h    | 19 ++++++++++++++++++
 kernel/cobalt/include/linux/stdarg.h          |  1 +
 kernel/cobalt/posix/Makefile                  |  4 ++--
 kernel/cobalt/posix/compat.c                  |  2 +-
 kernel/cobalt/posix/mqueue.c                  |  2 +-
 kernel/cobalt/posix/process.c                 |  2 +-
 kernel/cobalt/posix/sched.c                   |  6 +++---
 kernel/cobalt/posix/signal.c                  |  2 +-
 kernel/cobalt/posix/signal.h                  |  2 +-
 kernel/cobalt/posix/thread.h                  |  2 +-
 kernel/cobalt/rtdm/core.c                     |  4 ++--
 kernel/cobalt/rtdm/fd.c                       |  2 +-
 kernel/cobalt/synch.c                         |  2 +-
 kernel/cobalt/thread.c                        |  4 ++--
 kernel/cobalt/timer.c                         |  2 +-
 kernel/cobalt/vfile.c                         |  2 +-
 .../analogy/national_instruments/mio_common.c |  2 +-
 .../drivers/can/peak_canfd/rtcan_peak_canfd.c |  2 +-
 .../can/peak_canfd/rtcan_peak_pciefd.c        |  3 +--
 kernel/drivers/can/rtcan_flexcan.c            |  2 +-
 kernel/drivers/can/rtcan_raw_dev.c            |  2 +-
 kernel/drivers/can/sja1000/rtcan_adv_pci.c    |  1 -
 kernel/drivers/can/sja1000/rtcan_ems_pci.c    |  1 -
 kernel/drivers/can/sja1000/rtcan_esd_pci.c    |  2 --
 kernel/drivers/can/sja1000/rtcan_isa.c        |  1 -
 kernel/drivers/can/sja1000/rtcan_ixxat_pci.c  |  1 -
 kernel/drivers/can/sja1000/rtcan_mem.c        |  1 -
 kernel/drivers/can/sja1000/rtcan_peak_dng.c   |  1 -
 kernel/drivers/can/sja1000/rtcan_peak_pci.c   | 11 +++++-----
 kernel/drivers/can/sja1000/rtcan_plx_pci.c    |  7 -------
 kernel/drivers/can/sja1000/rtcan_sja1000.c    |  1 -
 kernel/drivers/ipc/bufp.c                     |  2 +-
 kernel/drivers/ipc/iddp.c                     |  2 +-
 kernel/drivers/ipc/xddp.c                     |  2 +-
 kernel/drivers/net/drivers/e1000/e1000_hw.c   | 20 +++++++++----------
 kernel/drivers/net/drivers/e1000/e1000_main.c |  2 +-
 kernel/drivers/net/drivers/e1000e/82571.c     |  4 ++--
 kernel/drivers/net/drivers/e1000e/e1000.h     |  1 +
 kernel/drivers/net/drivers/e1000e/ich8lan.c   |  8 ++++----
 kernel/drivers/net/drivers/e1000e/netdev.c    |  4 ++--
 .../experimental/e1000/e1000_ethtool.c        |  4 ++--
 .../drivers/experimental/e1000/e1000_main.c   | 10 +++++-----
 .../drivers/experimental/e1000/e1000_param.c  |  2 +-
 kernel/drivers/net/drivers/igb/e1000_82575.c  |  4 ++--
 kernel/drivers/net/drivers/igb/e1000_nvm.c    |  2 +-
 kernel/drivers/net/drivers/igb/e1000_phy.c    |  4 ++--
 kernel/drivers/net/drivers/igb/igb_main.c     | 10 +++++-----
 kernel/drivers/net/stack/ipv4/udp/udp.c       |  2 +-
 kernel/drivers/net/stack/packet/af_packet.c   |  2 +-
 kernel/drivers/testing/switchtest.c           |  2 +-
 scripts/prepare-kernel.sh                     |  1 +
 54 files changed, 101 insertions(+), 103 deletions(-)
 create mode 100644 kernel/cobalt/include/linux/stdarg.h

-- 
2.31.1


