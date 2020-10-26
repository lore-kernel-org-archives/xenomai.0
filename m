From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 05/11] driver/net: Update to kernel 5.4
Date: Mon, 26 Oct 2020 12:04:51 +0100
Message-Id: <97270814930fb623c1922b9ab81b6283523ca575.1603710297.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1603710297.git.jan.kiszka@siemens.com>
References: <cover.1603710297.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

linux/pci-aspm.h has been folded into linux/pci.h in that version.
Account for that in drivers that actually need it.

Furthermore, our implementation of SO_SNDTIMEO is now SO_SNDTIMEO_OLD
until 2038 has been addressed.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/e1000e/e1000.h  | 1 -
 kernel/drivers/net/drivers/e1000e/netdev.c | 4 ++++
 kernel/drivers/net/drivers/igb/igb_main.c  | 1 -
 kernel/drivers/net/drivers/r8169.c         | 5 ++++-
 kernel/drivers/net/stack/ipv4/tcp/tcp.c    | 2 +-
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/drivers/net/drivers/e1000e/e1000.h b/kernel/drivers/net/drivers/e1000e/e1000.h
index 2de681422f..7454c6350a 100644
--- a/kernel/drivers/net/drivers/e1000e/e1000.h
+++ b/kernel/drivers/net/drivers/e1000e/e1000.h
@@ -38,7 +38,6 @@
 #include <linux/io.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/crc32.h>
 #include <linux/if_vlan.h>
 
diff --git a/kernel/drivers/net/drivers/e1000e/netdev.c b/kernel/drivers/net/drivers/e1000e/netdev.c
index baeb6aa09d..5beaf2b552 100644
--- a/kernel/drivers/net/drivers/e1000e/netdev.c
+++ b/kernel/drivers/net/drivers/e1000e/netdev.c
@@ -53,6 +53,10 @@
 #include <linux/aer.h>
 #include <linux/prefetch.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,4,0)
+#include <linux/pci-aspm.h>
+#endif
+
 #include "e1000.h"
 
 #define RT_E1000E_NUM_RXD	64
diff --git a/kernel/drivers/net/drivers/igb/igb_main.c b/kernel/drivers/net/drivers/igb/igb_main.c
index 2c9d51e7f2..37d891a620 100644
--- a/kernel/drivers/net/drivers/igb/igb_main.c
+++ b/kernel/drivers/net/drivers/igb/igb_main.c
@@ -42,7 +42,6 @@
 #include <linux/if.h>
 #include <linux/if_vlan.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/ip.h>
diff --git a/kernel/drivers/net/drivers/r8169.c b/kernel/drivers/net/drivers/r8169.c
index 619ecc0434..6255fcb3f2 100644
--- a/kernel/drivers/net/drivers/r8169.c
+++ b/kernel/drivers/net/drivers/r8169.c
@@ -69,7 +69,6 @@ RTL8169_VERSION "2.2"	<2004/08/09>
  */
 
 #include <linux/module.h>
-#include <linux/pci-aspm.h>
 #include <linux/pci.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
@@ -79,6 +78,10 @@ RTL8169_VERSION "2.2"	<2004/08/09>
 #include <linux/timer.h>
 #include <linux/init.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,4,0)
+#include <linux/pci-aspm.h>
+#endif
+
 #include <rtnet_port.h>	/*** RTnet ***/
 
 #define RTL8169_VERSION "2.2-04"
diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
index b8263e5d23..8fef3ae5b5 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -1762,7 +1762,7 @@ static int rt_tcp_setsockopt(struct rtdm_fd *fd, struct tcp_socket *ts,
 	    */
 		return 0;
 
-	case SO_SNDTIMEO:
+	case SO_SNDTIMEO_OLD:
 		if (optlen < sizeof(tv))
 			return -EINVAL;
 		if (rtdm_copy_from_user(fd, &tv, optval, sizeof(tv)))
-- 
2.26.2


