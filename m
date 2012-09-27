From: Wolfgang Grandegger <wg@grandegger.com>
Date: Thu, 27 Sep 2012 17:29:14 +0200
Message-Id: <1348759755-13500-3-git-send-email-wg@grandegger.com>
In-Reply-To: <1348759755-13500-1-git-send-email-wg@grandegger.com>
References: <1348759755-13500-1-git-send-email-wg@grandegger.com>
Subject: [Xenomai] [PATCH 2/3] rtcan: add bit-timing calulation from
	Linux-CAN
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org
Cc: Wolfgang Grandegger <wg@denx.de>

From: Wolfgang Grandegger <wg@denx.de>

So far we use a very simple method to calculate bit-timing parameters
from the bitrate. This works fine for the SJA1000 and MSCAN but fails
for the Flexcan. This patch introduces the more general bit-timing
algorithm from Linux-CAN, which is based on bit-timing constants.
The Kconfig option XENO_DRIVERS_CAN_CALC_BITTIME_OLD allows to set
the old algorithm for backward compatibility.

Signed-off-by: Wolfgang Grandegger <wg@denx.de>
---
 ksrc/drivers/can/Kconfig                 |    6 ++
 ksrc/drivers/can/mscan/rtcan_mscan.c     |   17 ++++
 ksrc/drivers/can/rtcan_dev.h             |   17 ++++
 ksrc/drivers/can/rtcan_raw_dev.c         |  127 +++++++++++++++++++++++++++++-
 ksrc/drivers/can/sja1000/rtcan_sja1000.c |   18 ++++
 5 files changed, 184 insertions(+), 1 deletions(-)

diff --git a/ksrc/drivers/can/Kconfig b/ksrc/drivers/can/Kconfig
index e659a3c..a3917da 100644
--- a/ksrc/drivers/can/Kconfig
+++ b/ksrc/drivers/can/Kconfig
@@ -62,6 +62,12 @@ config XENO_DRIVERS_CAN_BUS_ERR
 	processing. This option is automatically selected for CAN controllers
 	supporting bus error interrupts like the SJA1000.
 
+config XENO_DRIVERS_CAN_CALC_BITTIME_OLD
+	depends on XENO_DRIVERS_CAN
+	bool "Old bit-time calculation algorithm"
+	default n
+	help
+
 config XENO_DRIVERS_CAN_VIRT
 	depends on XENO_DRIVERS_CAN
 	tristate "Virtual CAN bus driver"
diff --git a/ksrc/drivers/can/mscan/rtcan_mscan.c b/ksrc/drivers/can/mscan/rtcan_mscan.c
index edd590e..2b53e79 100644
--- a/ksrc/drivers/can/mscan/rtcan_mscan.c
+++ b/ksrc/drivers/can/mscan/rtcan_mscan.c
@@ -42,6 +42,20 @@
 
 #define MSCAN_SET_MODE_RETRIES	255
 
+#ifndef CONFIG_XENO_DRIVERS_CAN_CALC_BITTIME_OLD
+static struct can_bittiming_const mscan_bittiming_const = {
+	.name = "mscan",
+	.tseg1_min = 4,
+	.tseg1_max = 16,
+	.tseg2_min = 2,
+	.tseg2_max = 8,
+	.sjw_max = 4,
+	.brp_min = 1,
+	.brp_max = 64,
+	.brp_inc = 1,
+};
+#endif
+
 /**
  *  Reception Interrupt handler
  *
@@ -722,6 +736,9 @@ int rtcan_mscan_register(struct rtcan_device *dev, int irq, int mscan_clksrc)
 	dev->hard_start_xmit = rtcan_mscan_start_xmit;
 	dev->do_set_mode = rtcan_mscan_set_mode;
 	dev->do_set_bit_time = rtcan_mscan_set_bit_time;
+#ifndef CONFIG_XENO_DRIVERS_CAN_CALC_BITTIME_OLD
+	dev->bittiming_const = &mscan_bittiming_const;
+#endif
 
 	/* Register IRQ handler and pass device structure as arg */
 	ret = rtdm_irq_request(&dev->irq_handle, irq, rtcan_mscan_interrupt,
diff --git a/ksrc/drivers/can/rtcan_dev.h b/ksrc/drivers/can/rtcan_dev.h
index ab0431c..65fed69 100644
--- a/ksrc/drivers/can/rtcan_dev.h
+++ b/ksrc/drivers/can/rtcan_dev.h
@@ -51,6 +51,22 @@
 #define RTCAN_USE_REFCOUNT
 #endif
 
+/*
+ * CAN harware-dependent bit-timing constant
+ *
+ * Used for calculating and checking bit-timing parameters
+ */
+struct can_bittiming_const {
+	char name[16];		/* Name of the CAN controller hardware */
+	__u32 tseg1_min;	/* Time segement 1 = prop_seg + phase_seg1 */
+	__u32 tseg1_max;
+	__u32 tseg2_min;	/* Time segement 2 = phase_seg2 */
+	__u32 tseg2_max;
+	__u32 sjw_max;		/* Synchronisation jump width */
+	__u32 brp_min;		/* Bit-rate prescaler */
+	__u32 brp_max;
+	__u32 brp_inc;
+};
 
 struct rtcan_device {
     unsigned int        version;
@@ -94,6 +110,7 @@ struct rtcan_device {
     can_baudrate_t      baudrate;
 
     struct can_bittime  bit_time;
+    const struct can_bittiming_const *bittiming_const;
 
     /* State which the controller is in. Protected by device_lock in all
      * device structures. */
diff --git a/ksrc/drivers/can/rtcan_raw_dev.c b/ksrc/drivers/can/rtcan_raw_dev.c
index 5e7e260..c5fd1b6 100644
--- a/ksrc/drivers/can/rtcan_raw_dev.c
+++ b/ksrc/drivers/can/rtcan_raw_dev.c
@@ -28,6 +28,8 @@
 #include "rtcan_raw.h"
 #include "rtcan_internal.h"
 
+#ifdef CONFIG_XENO_DRIVERS_CAN_CALC_BITTIME_OLD
+
 #define RTCAN_MAX_TSEG1  15
 #define RTCAN_MAX_TSEG2  7
 
@@ -108,6 +110,128 @@ static int rtcan_calc_bit_time(struct rtcan_device *dev,
     return 0;
 }
 
+#else /* !CONFIG_XENO_DRIVERS_CAN_CALC_BITTIME_OLD */
+
+/* This is the bit-time calculation method from the Linux kernel */
+
+#define CAN_CALC_MAX_ERROR 50 /* in one-tenth of a percent */
+
+static int can_update_spt(const struct can_bittiming_const *btc,
+			  unsigned int sampl_pt, unsigned int tseg,
+			  unsigned int *tseg1, unsigned int *tseg2)
+{
+    *tseg2 = tseg + 1 - (sampl_pt * (tseg + 1)) / 1000;
+    *tseg2 = clamp(*tseg2, btc->tseg2_min, btc->tseg2_max);
+    *tseg1 = tseg - *tseg2;
+    if (*tseg1 > btc->tseg1_max) {
+	*tseg1 = btc->tseg1_max;
+	*tseg2 = tseg - *tseg1;
+    }
+
+    return 1000 * (tseg + 1 - *tseg2) / (tseg + 1);
+}
+
+static int rtcan_calc_bit_time(struct rtcan_device *dev,
+			       can_baudrate_t bitrate,
+			       struct can_bittime_std *bt)
+{
+    const struct can_bittiming_const *btc = dev->bittiming_const;
+    long rate;	/* current bitrate */
+    long rate_error;/* difference between current and target value */
+    long best_rate_error = 1000000000;
+    int spt;	/* current sample point in thousandth */
+    int spt_error;	/* difference between current and target value */
+    int best_spt_error = 1000;
+    int sampl_pt;	/* target sample point */
+    int best_tseg = 0, best_brp = 0;	/* current best values for tseg and brp */
+    unsigned int brp, tsegall, tseg, tseg1, tseg2;
+    u64 v64;
+
+    if (!dev->bittiming_const)
+	return -ENOTSUPP;
+
+    /* Use CIA recommended sample points */
+    if (bitrate > 800000)
+	sampl_pt = 750;
+    else if (bitrate > 500000)
+	sampl_pt = 800;
+    else
+	sampl_pt = 875;
+
+    /* tseg even = round down, odd = round up */
+    for (tseg = (btc->tseg1_max + btc->tseg2_max) * 2 + 1;
+	 tseg >= (btc->tseg1_min + btc->tseg2_min) * 2; tseg--) {
+	tsegall = 1 + tseg / 2;
+
+	/* Compute all possible tseg choices (tseg=tseg1+tseg2) */
+	brp = dev->can_sys_clock / (tsegall * bitrate) + tseg % 2;
+
+	/* chose brp step which is possible in system */
+	brp = (brp / btc->brp_inc) * btc->brp_inc;
+	if ((brp < btc->brp_min) || (brp > btc->brp_max))
+	    continue;
+
+	rate = dev->can_sys_clock / (brp * tsegall);
+	rate_error = abs((long)(bitrate - rate));
+
+	/* tseg brp biterror */
+	if (rate_error > best_rate_error)
+	    continue;
+
+	/* reset sample point error if we have a better bitrate */
+	if (rate_error < best_rate_error)
+	    best_spt_error = 1000;
+
+	spt = can_update_spt(btc, sampl_pt, tseg / 2, &tseg1, &tseg2);
+	spt_error = abs((long)(sampl_pt - spt));
+	if (spt_error > best_spt_error)
+	    continue;
+
+	best_spt_error = spt_error;
+	best_rate_error = rate_error;
+	best_tseg = tseg / 2;
+	best_brp = brp;
+
+	if (rate_error == 0 && spt_error == 0)
+	    break;
+    }
+
+    if (best_rate_error) {
+	/* Error in one-tenth of a percent */
+	rate_error = (best_rate_error * 1000) / bitrate;
+	if (rate_error > CAN_CALC_MAX_ERROR) {
+	    rtcandev_err(dev,
+			 "bitrate error %ld.%ld%% too high\n",
+			 rate_error / 10, rate_error % 10);
+	    return -EDOM;
+	} else {
+	    rtcandev_warn(dev, "bitrate error %ld.%ld%%\n",
+			  rate_error / 10, rate_error % 10);
+	}
+    }
+
+    /* real sample point */
+    sampl_pt = can_update_spt(btc, sampl_pt, best_tseg, &tseg1, &tseg2);
+
+    v64 = (u64)best_brp * 1000000000UL;
+    do_div(v64, dev->can_sys_clock);
+    bt->prop_seg = tseg1 / 2;
+    bt->phase_seg1 = tseg1 - bt->prop_seg;
+    bt->phase_seg2 = tseg2;
+    bt->sjw = 1;
+    bt->brp = best_brp;
+
+    /* real bit-rate */
+    rate = dev->can_sys_clock / (bt->brp * (tseg1 + tseg2 + 1));
+
+    rtcandev_dbg(dev, "real bitrate %ld, sampling point %d.%d%%\n",
+		 rate, sampl_pt/10, sampl_pt%10);
+
+    return 0;
+}
+
+#endif /* CONFIG_XENO_DRIVERS_CAN_CALC_BITTIME_OLD */
+
 static inline int rtcan_raw_ioctl_dev_get(struct rtcan_device *dev,
 					  int request, struct ifreq *ifr)
 {
@@ -168,7 +292,8 @@ static inline int rtcan_raw_ioctl_dev_set(struct rtcan_device *dev,
 	if (!dev->do_set_bit_time)
 	    return 0;
 	baudrate = (can_baudrate_t *)&ifr->ifr_ifru;
-	if ((ret = rtcan_calc_bit_time(dev, *baudrate, &bit_time.std)))
+	ret = rtcan_calc_bit_time(dev, *baudrate, &bit_time.std);
+	if (ret)
 	    break;
 	bit_time.type = CAN_BITTIME_STD;
 	break;
diff --git a/ksrc/drivers/can/sja1000/rtcan_sja1000.c b/ksrc/drivers/can/sja1000/rtcan_sja1000.c
index 9fd392d..cf91439 100644
--- a/ksrc/drivers/can/sja1000/rtcan_sja1000.c
+++ b/ksrc/drivers/can/sja1000/rtcan_sja1000.c
@@ -83,6 +83,19 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("RT-Socket-CAN driver for SJA1000");
 MODULE_SUPPORTED_DEVICE("SJA1000 CAN controller");
 
+#ifndef CONFIG_XENO_DRIVERS_CAN_CALC_BITTIME_OLD
+static struct can_bittiming_const sja1000_bittiming_const = {
+	.name = "sja1000",
+	.tseg1_min = 1,
+	.tseg1_max = 16,
+	.tseg2_min = 1,
+	.tseg2_max = 8,
+	.sjw_max = 4,
+	.brp_min = 1,
+	.brp_max = 64,
+	.brp_inc = 1,
+};
+#endif
 
 static inline void rtcan_sja_rx_interrupt(struct rtcan_device *dev,
 					  struct rtcan_skb *skb)
@@ -622,6 +635,7 @@ int rtcan_sja_set_bit_time(struct rtcan_device *dev,
 	return -EINVAL;
     }
 
+    printk("%s: btr0=%#x btr1=%#x\n", __func__, btr0, btr1);
     chip->write_reg(dev, SJA_BTR0, btr0);
     chip->write_reg(dev, SJA_BTR1, btr1);
 
@@ -757,6 +771,10 @@ int rtcan_sja1000_register(struct rtcan_device *dev)
     dev->do_get_state = rtcan_sja_get_state;
     dev->do_set_bit_time = rtcan_sja_set_bit_time;
     dev->do_enable_bus_err = rtcan_sja_enable_bus_err;
+#ifndef CONFIG_XENO_DRIVERS_CAN_CALC_BITTIME_OLD
+    dev->bittiming_const = &sja1000_bittiming_const;
+#endif
+
     chip->bus_err_on = 1;
 
     ret = rtdm_irq_request(&dev->irq_handle,
-- 
1.7.7.6


