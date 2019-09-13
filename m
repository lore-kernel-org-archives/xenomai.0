From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 00/12] rtdm: realtime_core_enabled cleanups and fixes
Date: Fri, 13 Sep 2019 18:46:43 +0200
Message-Id: <cover.1568393215.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This adds a proper RTDM interface for realtime_core_enabled and also
converts existing users to a slightly less invasive - because correctly
failing - usage pattern.

Still, this remains fragile: Drivers need to be reviewed and patched to
avoid requesting core services that can crash when not available. And
there can be many. RTnet was easy to enhance because there is a central
module-only point that, if it fails, automatically prevents the rest to
do anything. With CAN and its ability to be built-in, the situation is
different, and mscan was not covered so far.

Philippe, what are the use cases of starting with a disabled core?

What I'm aware of are startup failures, though only in virtual
environments when the TSC calibration failed. But that is quite a corner
case.

Jan


CC: Philippe Gerum <rpm@xenomai.org>

Jan Kiszka (12):
  rtdm: Harden key services against invocations with disabled core
  rtdm: Introduce rtdm_available()
  drivers: Remove unneeded realtime_core_enabled checks
  drivers/udd: Consolidate over ENOSYS on disabled core
  drivers/rtipc: Convert to rtdm_available and clean up
  drivers/analogy: Convert to rtdm_available and clean up
  drivers/serial: Convert to rtdm_available() and clean up
  drivers/net: Do not load when the core is not available
  drivers/net: udp: Roll back if rtdm_dev_register fails
  drivers/gpio: Convert to rtdm_available() and clean up
  drivers/can: Convert to rtdm_available() and clean up
  drivers/can: Convert to module_pci_driver

 include/cobalt/kernel/rtdm/driver.h            | 17 ++++-----
 kernel/cobalt/rtdm/device.c                    |  2 +-
 kernel/cobalt/rtdm/drvlib.c                    | 52 ++++++++++++++++++++++----
 kernel/drivers/analogy/driver.c                |  7 +---
 kernel/drivers/analogy/rtdm_interface.c        |  7 +---
 kernel/drivers/autotune/autotune.c             |  6 ---
 kernel/drivers/can/mscan/rtcan_mscan_mpc5xxx.c |  3 ++
 kernel/drivers/can/rtcan_module.c              |  7 +---
 kernel/drivers/can/rtcan_virt.c                |  7 +---
 kernel/drivers/can/sja1000/rtcan_adv_pci.c     | 20 ++--------
 kernel/drivers/can/sja1000/rtcan_ems_pci.c     | 20 ++--------
 kernel/drivers/can/sja1000/rtcan_esd_pci.c     | 20 ++--------
 kernel/drivers/can/sja1000/rtcan_isa.c         |  7 +---
 kernel/drivers/can/sja1000/rtcan_ixxat_pci.c   | 21 ++---------
 kernel/drivers/can/sja1000/rtcan_mem.c         |  7 +---
 kernel/drivers/can/sja1000/rtcan_peak_dng.c    |  7 +---
 kernel/drivers/can/sja1000/rtcan_peak_pci.c    | 21 ++---------
 kernel/drivers/can/sja1000/rtcan_plx_pci.c     | 20 ++--------
 kernel/drivers/can/sja1000/rtcan_sja1000.c     | 10 ++---
 kernel/drivers/gpio/gpio-core.c                |  7 +---
 kernel/drivers/gpiopwm/gpiopwm.c               |  3 --
 kernel/drivers/ipc/rtipc.c                     |  7 +---
 kernel/drivers/net/stack/ipv4/udp/udp.c        |  8 +++-
 kernel/drivers/net/stack/rtnet_module.c        |  3 ++
 kernel/drivers/serial/16550A.c                 |  7 +---
 kernel/drivers/serial/mpc52xx_uart.c           |  7 ++--
 kernel/drivers/serial/rt_imx_uart.c            |  7 ++--
 kernel/drivers/testing/heapcheck.c             |  3 --
 kernel/drivers/testing/rtdmtest.c              |  3 --
 kernel/drivers/testing/switchtest.c            |  6 ---
 kernel/drivers/testing/timerbench.c            |  6 ---
 kernel/drivers/udd/udd.c                       |  9 +----
 32 files changed, 120 insertions(+), 217 deletions(-)

-- 
2.16.4


