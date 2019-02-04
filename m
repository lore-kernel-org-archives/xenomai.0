From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 00/18] Assorted fixes: Cobalt, RTnet, GPIO, serial,
 smokey tests
Date: Mon,  4 Feb 2019 11:56:29 +0100
Message-Id: <20190204105647.5034-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

This is v2, addressing concerns about the previous series, plus a fix
to the i.MX UART driver for recent kernels.

Philippe Gerum (18):
  cobalt/intr: vfile: do not assume all irqs are cobalt-managed
  drivers/autotune: do not read user data we should not expect
  cobalt/thread: skip boundary check for infinite round-robin time slice
  drivers/ipc: bufp: fix read-write, write-write preemption cases
  testsuite/smokey: posix_clock: prevent false positive in
    time-dependent test
  drivers/gpio: provide optional timestamped readouts
  testsuite/gpiotest: enable timestamping on 'timestamp' argument
  net/stack: allow initializing pre-allocated device structs
  net/stack: fresh rtskb should have ip_summed set to CHECKSUM_NONE
  net/rtdev: ensure per-device skbs get mapped at registration
  net/udp: getfrag: fix frag preparation status
  net/udp: getfrag: remove direct reference to user memory
  testsuite/smokey: net: do not unload pre-loaded modules
  testsuite/smokey: net: do not down a previously running test interface
  net/stack: rtskb: do not run nop locking calls
  testsuite/smokey: net_client: improve stats readability
  net/stack: fix assertion testing checksum init value
  drivers/serial: imx: add required clock preparation

 include/cobalt/kernel/rtdm/gpio.h          |   1 +
 include/rtdm/uapi/gpio.h                   |  18 ++-
 kernel/cobalt/intr.c                       |  48 +++++--
 kernel/cobalt/thread.c                     |   6 +-
 kernel/drivers/autotune/autotune.c         |   6 +-
 kernel/drivers/gpio/gpio-core.c            |  54 ++++++--
 kernel/drivers/ipc/bufp.c                  | 118 +++++++---------
 kernel/drivers/net/stack/include/rtdev.h   |   9 ++
 kernel/drivers/net/stack/include/rtskb.h   |   5 +-
 kernel/drivers/net/stack/ipv4/udp/udp.c    |  21 +--
 kernel/drivers/net/stack/rtdev.c           | 151 ++++++++++++++-------
 kernel/drivers/net/stack/rtskb.c           |  26 +---
 kernel/drivers/serial/rt_imx_uart.c        |   6 +-
 testsuite/gpiotest/gpiotest.c              |  37 +++--
 testsuite/smokey/net_common/client.c       |  26 ++--
 testsuite/smokey/net_common/setup.c        | 108 +++++++++++----
 testsuite/smokey/posix-clock/posix-clock.c |   2 +-
 17 files changed, 413 insertions(+), 229 deletions(-)

-- 
2.17.2


