From: Philippe Gerum <rpm@xenomai.org>
Date: Sun, 23 Sep 2018 17:37:38 +0200
Message-Id: <20180923153738.32331-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 3/3] cobalt: use generic linux/uaccess.h header
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

asm/uaccess.h is an arch-local, partial header which may cause build
issues if included directly.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h      | 2 +-
 kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h   | 2 +-
 kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h | 2 +-
 kernel/cobalt/include/asm-generic/xenomai/syscall.h    | 4 ----
 kernel/cobalt/pipe.c                                   | 2 +-
 kernel/drivers/analogy/rtdm_interface.c                | 2 +-
 kernel/drivers/net/drivers/8139too.c                   | 2 +-
 kernel/drivers/net/drivers/eepro100.c                  | 2 +-
 kernel/drivers/net/drivers/eth1394.c                   | 2 +-
 kernel/drivers/net/drivers/experimental/3c59x.c        | 2 +-
 kernel/drivers/net/drivers/mpc8260_fcc_enet.c          | 2 +-
 kernel/drivers/net/drivers/mpc8xx_enet.c               | 2 +-
 kernel/drivers/net/drivers/mpc8xx_fec.c                | 2 +-
 kernel/drivers/net/drivers/natsemi.c                   | 2 +-
 kernel/drivers/net/drivers/pcnet32.c                   | 2 +-
 kernel/drivers/net/drivers/tulip/tulip_core.c          | 2 +-
 kernel/drivers/net/drivers/via-rhine.c                 | 2 +-
 kernel/drivers/net/stack/ipv4/af_inet.c                | 2 +-
 kernel/drivers/net/stack/rtmac/nomac/nomac_ioctl.c     | 2 +-
 kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c       | 2 +-
 20 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h b/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
index 1f6bfea11..1de219f96 100644
--- a/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
+++ b/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
@@ -27,7 +27,7 @@
 #include <linux/time.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <rtdm/driver.h>
 
 /* --- Trace section  --- */
diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
index 120713612..362f0ebd8 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
@@ -23,7 +23,7 @@
 #define _COBALT_ARM_ASM_SYSCALL_H
 
 #include <linux/errno.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/ptrace.h>
 #include <asm-generic/xenomai/syscall.h>
diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h
index e345c9aca..6b8b71d3b 100644
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h
@@ -23,7 +23,7 @@
 #define _COBALT_ARM64_ASM_SYSCALL_H
 
 #include <linux/errno.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/ptrace.h>
 #include <asm-generic/xenomai/syscall.h>
diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
index 3873fa634..7909fc310 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
@@ -21,11 +21,7 @@
 
 #include <linux/types.h>
 #include <linux/version.h>
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
-#include <asm/uaccess.h>
-#else
 #include <linux/uaccess.h>
-#endif
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/wrappers.h>
 #include <asm/xenomai/machine.h>
diff --git a/kernel/cobalt/pipe.c b/kernel/cobalt/pipe.c
index 76db67277..0b8f8cbf8 100644
--- a/kernel/cobalt/pipe.c
+++ b/kernel/cobalt/pipe.c
@@ -26,8 +26,8 @@
 #include <linux/termios.h>
 #include <linux/spinlock.h>
 #include <linux/device.h>
+#include <linux/uaccess.h>
 #include <asm/io.h>
-#include <asm/uaccess.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/heap.h>
 #include <cobalt/kernel/pipe.h>
diff --git a/kernel/drivers/analogy/rtdm_interface.c b/kernel/drivers/analogy/rtdm_interface.c
index 23fd7b393..4fb2b5ca5 100644
--- a/kernel/drivers/analogy/rtdm_interface.c
+++ b/kernel/drivers/analogy/rtdm_interface.c
@@ -22,7 +22,7 @@
 #include <linux/ioport.h>
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <rtdm/driver.h>
 #include <rtdm/analogy/device.h>
 
diff --git a/kernel/drivers/net/drivers/8139too.c b/kernel/drivers/net/drivers/8139too.c
index c61c06ab0..05a4042f4 100644
--- a/kernel/drivers/net/drivers/8139too.c
+++ b/kernel/drivers/net/drivers/8139too.c
@@ -47,8 +47,8 @@
 #include <linux/mii.h>
 #include <linux/completion.h>
 #include <linux/crc32.h>
+#include <linux/uaccess.h>
 #include <asm/io.h>
-#include <asm/uaccess.h>
 
 /* *** RTnet *** */
 #include <rtnet_port.h>
diff --git a/kernel/drivers/net/drivers/eepro100.c b/kernel/drivers/net/drivers/eepro100.c
index 863f72b75..414eb7a45 100644
--- a/kernel/drivers/net/drivers/eepro100.c
+++ b/kernel/drivers/net/drivers/eepro100.c
@@ -95,10 +95,10 @@ static int local_debug = -1;	/* The debug level */
 #include <linux/init.h>
 #include <linux/mii.h>
 #include <linux/delay.h>
+#include <linux/uaccess.h>
 
 #include <asm/bitops.h>
 #include <asm/io.h>
-#include <asm/uaccess.h>
 
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
diff --git a/kernel/drivers/net/drivers/eth1394.c b/kernel/drivers/net/drivers/eth1394.c
index 7c6494e33..e6bf2d6ca 100644
--- a/kernel/drivers/net/drivers/eth1394.c
+++ b/kernel/drivers/net/drivers/eth1394.c
@@ -28,7 +28,7 @@
 #include <linux/ip.h>
 #include <linux/in.h>
 #include <linux/bitops.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <net/arp.h>
 
 #define rtos_spinlock_t rtdm_lock_t
diff --git a/kernel/drivers/net/drivers/experimental/3c59x.c b/kernel/drivers/net/drivers/experimental/3c59x.c
index bae330869..c2cf4786c 100644
--- a/kernel/drivers/net/drivers/experimental/3c59x.c
+++ b/kernel/drivers/net/drivers/experimental/3c59x.c
@@ -255,10 +255,10 @@ static int vortex_debug = 1;
 #include <linux/skbuff.h>
 #include <linux/ethtool.h>
 #include <linux/highmem.h>
+#include <linux/uaccess.h>
 #include <asm/irq.h>			/* For NR_IRQS only. */
 #include <asm/bitops.h>
 #include <asm/io.h>
-#include <asm/uaccess.h>
 
 // *** RTnet ***
 #include <rtnet_port.h>
diff --git a/kernel/drivers/net/drivers/mpc8260_fcc_enet.c b/kernel/drivers/net/drivers/mpc8260_fcc_enet.c
index ad64407b7..5167dd77c 100644
--- a/kernel/drivers/net/drivers/mpc8260_fcc_enet.c
+++ b/kernel/drivers/net/drivers/mpc8260_fcc_enet.c
@@ -37,13 +37,13 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
+#include <linux/uaccess.h>
 
 #include <asm/immap_8260.h>
 #include <asm/pgtable.h>
 #include <asm/mpc8260.h>
 #include <asm/irq.h>
 #include <asm/bitops.h>
-#include <asm/uaccess.h>
 #include <asm/cpm_8260.h>
 
 #ifdef CONFIG_XENO_DRIVERS_NET_USE_MDIO
diff --git a/kernel/drivers/net/drivers/mpc8xx_enet.c b/kernel/drivers/net/drivers/mpc8xx_enet.c
index 943053264..7fb0fcf80 100644
--- a/kernel/drivers/net/drivers/mpc8xx_enet.c
+++ b/kernel/drivers/net/drivers/mpc8xx_enet.c
@@ -45,12 +45,12 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
+#include <linux/uaccess.h>
 
 #include <asm/8xx_immap.h>
 #include <asm/pgtable.h>
 #include <asm/mpc8xx.h>
 #include <asm/bitops.h>
-#include <asm/uaccess.h>
 #include <asm/irq.h>
 #include <asm/commproc.h>
 
diff --git a/kernel/drivers/net/drivers/mpc8xx_fec.c b/kernel/drivers/net/drivers/mpc8xx_fec.c
index df31f99a5..e57f85aa9 100644
--- a/kernel/drivers/net/drivers/mpc8xx_fec.c
+++ b/kernel/drivers/net/drivers/mpc8xx_fec.c
@@ -56,13 +56,13 @@
 #include <linux/spinlock.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
+#include <linux/uaccess.h>
 
 #include <asm/8xx_immap.h>
 #include <asm/pgtable.h>
 #include <asm/mpc8xx.h>
 #include <asm/irq.h>
 #include <asm/bitops.h>
-#include <asm/uaccess.h>
 #include <asm/commproc.h>
 
 #ifdef CONFIG_XENO_DRIVERS_NET_USE_MDIO
diff --git a/kernel/drivers/net/drivers/natsemi.c b/kernel/drivers/net/drivers/natsemi.c
index e3392d4ed..b46d0ffef 100644
--- a/kernel/drivers/net/drivers/natsemi.c
+++ b/kernel/drivers/net/drivers/natsemi.c
@@ -165,11 +165,11 @@
 #include <linux/delay.h>
 #include <linux/rtnetlink.h>
 #include <linux/mii.h>
+#include <linux/uaccess.h>
 #include <asm/processor.h>	/* Processor type for cache alignment. */
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/uaccess.h>
 
 /*** RTnet ***/
 #include <rtnet_port.h>
diff --git a/kernel/drivers/net/drivers/pcnet32.c b/kernel/drivers/net/drivers/pcnet32.c
index b0f8b1a60..d2bd42525 100644
--- a/kernel/drivers/net/drivers/pcnet32.c
+++ b/kernel/drivers/net/drivers/pcnet32.c
@@ -46,10 +46,10 @@ DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE " Jan.Kiszka@web.de\n";
 #include <linux/ethtool.h>
 #include <linux/mii.h>
 #include <linux/crc32.h>
+#include <linux/uaccess.h>
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/dma.h>
-#include <asm/uaccess.h>
 
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
diff --git a/kernel/drivers/net/drivers/tulip/tulip_core.c b/kernel/drivers/net/drivers/tulip/tulip_core.c
index 0a7a86ea0..0d68ef387 100644
--- a/kernel/drivers/net/drivers/tulip/tulip_core.c
+++ b/kernel/drivers/net/drivers/tulip/tulip_core.c
@@ -29,8 +29,8 @@
 #include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/crc32.h>
+#include <linux/uaccess.h>
 #include <asm/unaligned.h>
-#include <asm/uaccess.h>
 
 #ifdef __sparc__
 #include <asm/pbm.h>
diff --git a/kernel/drivers/net/drivers/via-rhine.c b/kernel/drivers/net/drivers/via-rhine.c
index bd02161dd..9618d23e3 100644
--- a/kernel/drivers/net/drivers/via-rhine.c
+++ b/kernel/drivers/net/drivers/via-rhine.c
@@ -199,11 +199,11 @@ static const int multicast_filter_limit = 32;
 #include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/crc32.h>
+#include <linux/uaccess.h>
 #include <asm/processor.h>		/* Processor type for cache alignment. */
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/uaccess.h>
 
 /*** RTnet ***/
 #include <rtnet_port.h>
diff --git a/kernel/drivers/net/stack/ipv4/af_inet.c b/kernel/drivers/net/stack/ipv4/af_inet.c
index 3780ffdcd..e5108137e 100644
--- a/kernel/drivers/net/stack/ipv4/af_inet.c
+++ b/kernel/drivers/net/stack/ipv4/af_inet.c
@@ -24,7 +24,7 @@
  */
 
 #include <linux/module.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 #include <ipv4_chrdev.h>
 #include <rtnet_internal.h>
diff --git a/kernel/drivers/net/stack/rtmac/nomac/nomac_ioctl.c b/kernel/drivers/net/stack/rtmac/nomac/nomac_ioctl.c
index 6945ac12f..ac6fbd6d9 100644
--- a/kernel/drivers/net/stack/rtmac/nomac/nomac_ioctl.c
+++ b/kernel/drivers/net/stack/rtmac/nomac/nomac_ioctl.c
@@ -23,7 +23,7 @@
  */
 
 #include <linux/module.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 #include <nomac_chrdev.h>
 #include <rtmac/nomac/nomac.h>
diff --git a/kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c b/kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c
index a1f5e5b36..151e4dfab 100644
--- a/kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c
+++ b/kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c
@@ -24,8 +24,8 @@
 
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/uaccess.h>
 #include <asm/div64.h>
-#include <asm/uaccess.h>
 
 #include <tdma_chrdev.h>
 #include <rtmac/rtmac_vnic.h>
-- 
2.14.4


