From: Dario Binacchi <dariobin@libero.it>
Subject: [PATCH v2 4/6] drivers/can: add a minimal support to ethtool API
Date: Mon, 29 Nov 2021 23:07:48 +0100
Message-Id: <20211129230612.v2.4.Ia5c620cabdfdf1d9fb20719eddce89c52aa4af62@changeid>
In-Reply-To: <20211129220750.10362-1-dariobin@libero.it>
References: <20211129220750.10362-1-dariobin@libero.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, Gianluca Falavigna <gianluca.falavigna@inwind.it>, Wolfgang Grandegger <wg@grandegger.com>, Dario Binacchi <dariobin@libero.it>, Michael Trimarchi <michael@amarulasolutions.com>, "Stephen J . Battazzo" <stephen.j.battazzo@nasa.gov>

Like in the Linux kernel, the API allows to get/set device controller
parameters.
For now it only supports:
 - ETHTOOL_GDRVINFO: get general driver and device information
 - ETHTOOL_GRINGPARAM: get RX/TX ring parameters

It allows the userspace to know the number of messages managed by the
controller and how many of them are used for reception/transmission.
This information allows you to know the maximum number of messages that
sendmsg() can transmit without returning a full FIFO error.

Application programs are expected to use the new API directly via IOCTL,
since, unlike the Linux Kernel, there is currently no userspace
application like ethtool in Xenomai.

Signed-off-by: Dario Binacchi <dariobin@libero.it>
---

Changes in v2:
- Expand the commit message to better describe the added API.

 kernel/drivers/can/Makefile        |  2 +-
 kernel/drivers/can/rtcan_dev.h     |  4 +-
 kernel/drivers/can/rtcan_ethtool.c | 75 ++++++++++++++++++++++++++++++
 kernel/drivers/can/rtcan_ethtool.h | 24 ++++++++++
 kernel/drivers/can/rtcan_raw_dev.c | 20 ++++++++
 5 files changed, 123 insertions(+), 2 deletions(-)
 create mode 100644 kernel/drivers/can/rtcan_ethtool.c
 create mode 100644 kernel/drivers/can/rtcan_ethtool.h

diff --git a/kernel/drivers/can/Makefile b/kernel/drivers/can/Makefile
index f78f6afdf..65761a010 100644
--- a/kernel/drivers/can/Makefile
+++ b/kernel/drivers/can/Makefile
@@ -5,6 +5,6 @@ obj-$(CONFIG_XENO_DRIVERS_CAN) += xeno_can.o mscan/ sja1000/ peak_canfd/
 obj-$(CONFIG_XENO_DRIVERS_CAN_FLEXCAN) += xeno_can_flexcan.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_VIRT) += xeno_can_virt.o
 
-xeno_can-y := rtcan_dev.o rtcan_socket.o rtcan_module.o rtcan_raw.o rtcan_raw_dev.o rtcan_raw_filter.o
+xeno_can-y := rtcan_dev.o rtcan_socket.o rtcan_module.o rtcan_raw.o rtcan_raw_dev.o rtcan_raw_filter.o rtcan_ethtool.o
 xeno_can_virt-y := rtcan_virt.o
 xeno_can_flexcan-y := rtcan_flexcan.o
diff --git a/kernel/drivers/can/rtcan_dev.h b/kernel/drivers/can/rtcan_dev.h
index 3642e92f0..cc081f6e8 100644
--- a/kernel/drivers/can/rtcan_dev.h
+++ b/kernel/drivers/can/rtcan_dev.h
@@ -34,7 +34,7 @@
 #include <linux/semaphore.h>
 
 #include "rtcan_list.h"
-
+#include "rtcan_ethtool.h"
 
 /* Number of MSCAN devices the driver can handle */
 #define RTCAN_MAX_DEVICES    CONFIG_XENO_DRIVERS_CAN_MAX_DEVICES
@@ -137,6 +137,8 @@ struct rtcan_device {
     void                (*do_enable_bus_err)(struct rtcan_device *dev);
 #endif
 
+    const struct rtcan_ethtool_ops *ethtool_ops;
+
     /* Reception list head. This list contains all filters which have been
      * registered via a bind call. */
     struct rtcan_recv               *recv_list;
diff --git a/kernel/drivers/can/rtcan_ethtool.c b/kernel/drivers/can/rtcan_ethtool.c
new file mode 100644
index 000000000..cfcf77ac3
--- /dev/null
+++ b/kernel/drivers/can/rtcan_ethtool.c
@@ -0,0 +1,75 @@
+#include "rtcan_dev.h"
+
+static int rtcan_ethtool_drvinfo(struct rtdm_fd *fd, struct rtcan_device *dev,
+				 void __user *useraddr)
+{
+	const struct rtcan_ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_drvinfo info = {.cmd = ETHTOOL_GDRVINFO };
+
+	if (!ops->get_drvinfo)
+		return -EOPNOTSUPP;
+
+	ops->get_drvinfo(dev, &info);
+
+	if (!rtdm_fd_is_user(fd) ||
+	    rtdm_copy_to_user(fd, useraddr, &info, sizeof(info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int rtcan_ethtool_get_ringparam(struct rtdm_fd *fd,
+				       struct rtcan_device *dev,
+				       void __user *useraddr)
+{
+	const struct rtcan_ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_ringparam ringparam = { .cmd = ETHTOOL_GRINGPARAM };
+
+	if (!ops->get_ringparam)
+		return -EOPNOTSUPP;
+
+	ops->get_ringparam(dev, &ringparam);
+
+	if (!rtdm_fd_is_user(fd) ||
+	    rtdm_copy_to_user(fd, useraddr, &ringparam, sizeof(ringparam)))
+		return -EFAULT;
+
+	return 0;
+}
+
+int rtcan_ethtool(struct rtdm_fd *fd, struct rtcan_device *dev,
+		  struct ifreq *ifr)
+{
+	void __user *useraddr = ifr->ifr_data;
+	u32 ethcmd;
+	int rc;
+
+	if (!dev->ethtool_ops)
+		return -EOPNOTSUPP;
+
+	if (!rtdm_read_user_ok(fd, useraddr, sizeof(ethcmd)) ||
+	    rtdm_copy_from_user(fd, &ethcmd, useraddr, sizeof(ethcmd)))
+		return -EFAULT;
+
+	if (dev->ethtool_ops->begin) {
+		rc = dev->ethtool_ops->begin(dev);
+		if (rc < 0)
+			return rc;
+	}
+
+	switch (ethcmd) {
+	case ETHTOOL_GDRVINFO:
+		rc = rtcan_ethtool_drvinfo(fd, dev, useraddr);
+		break;
+	case ETHTOOL_GRINGPARAM:
+		rc = rtcan_ethtool_get_ringparam(fd, dev, useraddr);
+		break;
+	default:
+		rc = -EOPNOTSUPP;
+	}
+
+	if (dev->ethtool_ops->complete)
+		dev->ethtool_ops->complete(dev);
+
+	return rc;
+}
diff --git a/kernel/drivers/can/rtcan_ethtool.h b/kernel/drivers/can/rtcan_ethtool.h
new file mode 100644
index 000000000..b01090fd3
--- /dev/null
+++ b/kernel/drivers/can/rtcan_ethtool.h
@@ -0,0 +1,24 @@
+#ifndef __RTCAN_ETHTOOL_H_
+#define __RTCAN_ETHTOOL_H_
+
+#ifdef __KERNEL__
+
+#include <linux/ethtool.h>
+
+struct rtcan_device;
+
+struct rtcan_ethtool_ops {
+	int (*begin)(struct rtcan_device *dev);
+	int (*complete)(struct rtcan_device *dev);
+	void (*get_drvinfo)(struct rtcan_device *dev,
+			     struct ethtool_drvinfo *info);
+	void (*get_ringparam)(struct rtcan_device *dev,
+			      struct ethtool_ringparam *ring);
+};
+
+int rtcan_ethtool(struct rtdm_fd *fd, struct rtcan_device *dev,
+		  struct ifreq *ifr);
+
+#endif /* __KERNEL__ */
+
+#endif /* __RTCAN_ETHTOOL_H_ */
diff --git a/kernel/drivers/can/rtcan_raw_dev.c b/kernel/drivers/can/rtcan_raw_dev.c
index d1ff640e3..d418c481f 100644
--- a/kernel/drivers/can/rtcan_raw_dev.c
+++ b/kernel/drivers/can/rtcan_raw_dev.c
@@ -354,6 +354,7 @@ static inline int rtcan_raw_ioctl_dev_set(struct rtcan_device *dev,
 int rtcan_raw_ioctl_dev(struct rtdm_fd *fd, int request, void *arg)
 {
     struct can_ifreq *ifr;
+    struct ifreq *ifreq;
     int ret = 0, get = 0;
     union {
 	    /*
@@ -414,7 +415,26 @@ int rtcan_raw_ioctl_dev(struct rtdm_fd *fd, int request, void *arg)
 		rtcan_dev_dereference(dev);
 	}
 	break;
+    case SIOCETHTOOL:
+	if (rtdm_fd_is_user(fd)) {
+	    /* Copy struct can_ifreq from userspace */
+	    if (!rtdm_read_user_ok(fd, arg, sizeof(*ifreq)) ||
+		rtdm_copy_from_user(fd, &ifr_buf, arg, sizeof(*ifreq)))
+		return -EFAULT;
+
+	    ifreq = &ifr_buf.ifr_legacy;
+	} else {
+	    ifreq = (struct ifreq *)arg;
+	}
 
+	/* Get interface index and data */
+	dev = rtcan_dev_get_by_name(ifreq->ifr_name);
+	if (dev == NULL)
+	    return -ENODEV;
+
+	ret = rtcan_ethtool(fd, dev, ifreq);
+	rtcan_dev_dereference(dev);
+	break;
     default:
 	ret = -EOPNOTSUPP;
 	break;
-- 
2.17.1


