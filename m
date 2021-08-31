From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH V2 0/3] add support for cherryview gpio controller driver
Date: Tue, 31 Aug 2021 01:07:33 -0400
Message-Id: <20210831050736.5371-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

1. move out of OF config conditional compilation so that non-OF platform
  call same API to remove rtdm gpio chip device and remove _of for api
  name.
2. Introduce helper to find gpiochip as referring to pair of 
   rtdm_gpiochip_scan_of and rtdm_gpiochip_scan_array_of. 
3. Add Intel Cherryview pinctrl driver based on on 1 and 2.

I also did following tests with this patchset:
1. run /usr/lib/xenomai/testsuite/gpiobench -i 334 -i 335 -c INT33FF:02
   to validate patch 9afea5ff2d7ba97db96b22a005a9a7fcf5f2d892 when
   setting GPIO_RTIOC_TS
2. apply following patch, and rerun 1.

index f83d7689f..50afbd418 100644
--- a/testsuite/gpiobench/gpiobench.c
+++ b/testsuite/gpiobench/gpiobench.c
@@ -619,7 +619,7 @@ int main(int argc, char **argv)
                        goto out;
                }

-               ret = ioctl(ti.fd_dev_intr, GPIO_RTIOC_TS, &value);
+               ret = ioctl(ti.fd_dev_intr, GPIO_RTIOC_TS_MONO, &value);
                if (ret) {
                        printf("ioctl gpio port ts, failed\n");
                        goto out;

3. test result for inner related output:
   REALTIME clock:
	# Total: 000999999
	# Min Latencies: 00013
	# Avg Latencies: 16.879997
	# Max Latencies: 00043

   MONO clock:
	# Total: 000083988
	# Min Latencies: 00012
	# Avg Latencies: 2814377.000000
	# Max Latencies: 00041

Hardware env:
1. Rock PI X V1.4.
2. GPIO loopback connection between GPIO 334 and 335.

Hongzhan Chen (3):
  drivers/gpio: core: Move out of OF config conditional compilation
  drivers/gpio: core: Introduce helper to find gpiochip
  driver/gpio: Add Intel Cherryview pinctrl driver

 include/cobalt/kernel/rtdm/gpio.h     | 12 +++++--
 kernel/drivers/gpio/Kconfig           |  7 ++++
 kernel/drivers/gpio/Makefile          |  2 ++
 kernel/drivers/gpio/gpio-bcm2835.c    |  2 +-
 kernel/drivers/gpio/gpio-cherryview.c | 42 ++++++++++++++++++++++
 kernel/drivers/gpio/gpio-core.c       | 50 ++++++++++++++++++++++++---
 kernel/drivers/gpio/gpio-mxc.c        |  2 +-
 kernel/drivers/gpio/gpio-omap.c       |  2 +-
 kernel/drivers/gpio/gpio-sun8i-h3.c   |  2 +-
 kernel/drivers/gpio/gpio-xilinx.c     |  2 +-
 kernel/drivers/gpio/gpio-zynq7000.c   |  2 +-
 11 files changed, 112 insertions(+), 13 deletions(-)
 create mode 100644 kernel/drivers/gpio/gpio-cherryview.c

-- 
2.17.1


