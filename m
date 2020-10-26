From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 00/11] Enable kernel 5.4
Date: Mon, 26 Oct 2020 12:04:46 +0100
Message-Id: <cover.1603710297.git.jan.kiszka@siemens.com>
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
Cc: Fino Meng <fino.meng@linux.intel.com>, Mingliang Hu <mingliang.hu@intel.com>

This contains the changes needed to build and run most of Xenomai
against kernel 5.4 on x86. Other archs still need porting. Furthermore,
we still need to adjust RTnet and Analogy to some kernel changes.

Jan


CC: Fino Meng <fino.meng@linux.intel.com>

Fino Meng (2):
  cobalt/kernel: adapt adjtime syscall with upstream kernel
  cobalt/kernel: fix compile error for incompatible pointer type

Jan Kiszka (9):
  cobalt/x86: Account for FPU changes in kernel 5.2
  drivers/ipc: Account for renaming of SO_RCVTIMEO/SO_SNDTIMEO
  driver/net: Update to kernel 5.4
  wrappers: Add mmiowb stub for kernels >= 5.2
  drivers/analogy: Fix unintended fallthrough
  drivers/e1000: Fix unintended fallthrough
  cobalt/posix: Address -Wimplicit-fallthrough
  testsuite/switchtest: Fix help output
  ci: Add x86 5.4 kernel to CI

 .gitlab-ci.yml                                |  8 ++++
 include/cobalt/kernel/compat.h                |  4 +-
 include/cobalt/kernel/stat.h                  |  4 +-
 kernel/cobalt/arch/x86/thread.c               | 46 +++++++++++++++++++
 .../include/asm-generic/xenomai/wrappers.h    | 10 ++++
 kernel/cobalt/posix/compat.c                  |  6 +--
 kernel/cobalt/posix/sched.c                   |  5 +-
 kernel/cobalt/posix/signal.c                  |  2 +-
 kernel/cobalt/posix/signal.h                  |  2 +-
 kernel/cobalt/posix/syscall32.c               |  2 +-
 kernel/cobalt/posix/syscall32.h               |  2 +-
 .../analogy/national_instruments/tio_common.c |  1 +
 kernel/drivers/can/rtcan_raw_dev.c            |  2 +-
 kernel/drivers/can/sja1000/rtcan_peak_pci.c   |  5 ++
 kernel/drivers/ipc/bufp.c                     |  9 ++--
 kernel/drivers/ipc/iddp.c                     |  9 ++--
 kernel/drivers/ipc/xddp.c                     |  5 +-
 kernel/drivers/net/drivers/e1000/e1000_hw.c   |  4 +-
 kernel/drivers/net/drivers/e1000/e1000_main.c |  1 +
 kernel/drivers/net/drivers/e1000e/e1000.h     |  1 -
 kernel/drivers/net/drivers/e1000e/netdev.c    |  4 ++
 kernel/drivers/net/drivers/igb/e1000_82575.c  |  4 +-
 kernel/drivers/net/drivers/igb/e1000_phy.c    |  1 +
 kernel/drivers/net/drivers/igb/igb_main.c     |  2 +-
 kernel/drivers/net/drivers/r8169.c            |  5 +-
 kernel/drivers/net/stack/ipv4/tcp/tcp.c       |  2 +-
 kernel/drivers/net/stack/ipv4/udp/udp.c       |  1 +
 kernel/drivers/net/stack/packet/af_packet.c   |  1 +
 testsuite/switchtest/switchtest.c             |  5 ++
 29 files changed, 124 insertions(+), 29 deletions(-)

-- 
2.26.2


