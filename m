From: Zqiang <qiang1.zhang@intel.com>
Subject: [PATCH 1/4] driver/ptp: introduce real-time PTP driver support
Date: Tue, 17 May 2022 09:51:49 +0800
Message-Id: <20220517015152.697886-2-qiang1.zhang@intel.com>
In-Reply-To: <20220517015152.697886-1-qiang1.zhang@intel.com>
References: <20220517015152.697886-1-qiang1.zhang@intel.com>
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
To: rpm@xenomai.org, jan.kiszka@siemens.com
Cc: hongzhan.chen@intel.com, xenomai@xenomai.org

This patch add an infrastructure for TGPIO hardware, it
offer a registration method to generate rtdm type of tgpio
device.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 include/rtdm/uapi/rt_ptp_clock.h | 258 +++++++++++++++
 include/rtdm/uapi/rtdm.h         |   1 +
 kernel/drivers/Kconfig           |   2 +-
 kernel/drivers/Makefile          |   2 +-
 kernel/drivers/ptp/Kconfig       |   9 +
 kernel/drivers/ptp/Makefile      |   2 +
 kernel/drivers/ptp/ptp.c         | 537 +++++++++++++++++++++++++++++++
 kernel/drivers/ptp/ptp.h         | 106 ++++++
 8 files changed, 915 insertions(+), 2 deletions(-)
 create mode 100644 include/rtdm/uapi/rt_ptp_clock.h
 create mode 100644 kernel/drivers/ptp/Kconfig
 create mode 100644 kernel/drivers/ptp/Makefile
 create mode 100644 kernel/drivers/ptp/ptp.c
 create mode 100644 kernel/drivers/ptp/ptp.h

diff --git a/include/rtdm/uapi/rt_ptp_clock.h b/include/rtdm/uapi/rt_ptp_clock.h
new file mode 100644
index 0000000..08016b7
--- /dev/null
+++ b/include/rtdm/uapi/rt_ptp_clock.h
@@ -0,0 +1,258 @@
+/**
+ * @note Copyright (C) 2022 Zqiang <qiang1.zhang@intel.com>
+ *
+ * This RTDM PTP device profile header is based on:
+ * include/uapi/linux/ptp_clock.h PTP 1588 clock support for Linux
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef _RTDM_UAPI_PTP_CLOCK_H_
+#define _RTDM_UAPI_PTP_CLOCK_H_
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/*
+ * Bits of the rt_ptp_extts_request.flags field:
+ */
+#define RT_PTP_ENABLE_FEATURE		(1<<0)
+#define RT_PTP_RISING_EDGE		(1<<1)
+#define RT_PTP_FALLING_EDGE		(1<<2)
+#define RT_PTP_STRICT_FLAGS		(1<<3)
+#define RT_PTP_EVENT_COUNTER_MODE	(1<<4)
+#define RT_PTP_EXTTS_EDGES		(RT_PTP_RISING_EDGE | RT_PTP_FALLING_EDGE)
+
+/*
+ * Bits of the rt_ptp_pin_desc.flags field:
+ */
+#define RT_PTP_PINDESC_EVTCNTVALID	(1<<0)
+#define RT_PTP_PINDESC_INPUTPOLL	(1<<1)
+
+/*
+ * flag fields valid for the new RT_PTP_EXTTS_REQUEST2 ioctl.
+ */
+#define RT_PTP_EXTTS_VALID_FLAGS	(RT_PTP_ENABLE_FEATURE |	\
+					RT_PTP_RISING_EDGE |		\
+					RT_PTP_FALLING_EDGE |		\
+					RT_PTP_STRICT_FLAGS)
+
+/*
+ * flag fields valid for the original RT_PTP_EXTTS_REQUEST ioctl.
+ * DO NOT ADD NEW FLAGS HERE.
+ */
+#define RT_PTP_EXTTS_V1_VALID_FLAGS	(RT_PTP_ENABLE_FEATURE |	\
+					RT_PTP_RISING_EDGE |		\
+					RT_PTP_FALLING_EDGE |		\
+					RT_PTP_EVENT_COUNTER_MODE)
+
+/*
+ * Bits of the rt_ptp_perout_request.flags field:
+ */
+#define RT_PTP_PEROUT_ONE_SHOT		(1<<0)
+#define RT_PTP_PEROUT_DUTY_CYCLE	(1<<1)
+#define RT_PTP_PEROUT_PHASE		(1<<2)
+#define RT_PTP_PEROUT_FREQ_ADJ		(1<<3)
+
+/*
+ * flag fields valid for the new RT_PTP_PEROUT_REQUEST2 ioctl.
+ */
+#define RT_PTP_PEROUT_VALID_FLAGS	(RT_PTP_PEROUT_ONE_SHOT |	\
+					 RT_PTP_PEROUT_DUTY_CYCLE |	\
+					 RT_PTP_PEROUT_PHASE |		\
+					 RT_PTP_PEROUT_FREQ_ADJ)
+
+/*
+ * No flags are valid for the original RT_PTP_PEROUT_REQUEST ioctl
+ */
+#define RT_PTP_PEROUT_V1_VALID_FLAGS	(0)
+
+/*
+ * struct rt_ptp_clock_time - represents a time value
+ *
+ * The sign of the seconds field applies to the whole value. The
+ * nanoseconds field is always unsigned. The reserved field is
+ * included for sub-nanosecond resolution, should the demand for
+ * this ever appear.
+ *
+ */
+struct rt_ptp_clock_time {
+	__s64 sec;  /* seconds */
+	__u32 nsec; /* nanoseconds */
+	__u32 reserved;
+};
+
+struct rt_ptp_clock_caps {
+	int max_adj;   /* Maximum frequency adjustment in parts per billon. */
+	int n_alarm;   /* Number of programmable alarms. */
+	int n_ext_ts;  /* Number of external time stamp channels. */
+	int n_per_out; /* Number of programmable periodic signals. */
+	int pps;       /* Whether the clock supports a PPS callback. */
+	int n_pins;    /* Number of input/output pins. */
+	/* Whether the clock supports precise system-device cross timestamps */
+	int cross_timestamping;
+	/* Whether the clock supports adjust phase */
+	int adjust_phase;
+	int rsv[12];   /* Reserved for future use. */
+};
+
+struct rt_ptp_extts_request {
+	unsigned int index;  /* Which channel to configure. */
+	unsigned int flags;  /* Bit field for PTP_xxx flags. */
+	unsigned int rsv[2]; /* Reserved for future use. */
+};
+
+struct rt_ptp_perout_request {
+	union {
+		/*
+		 * Absolute start time.
+		 * Valid only if (flags & PTP_PEROUT_PHASE) is unset.
+		 */
+		struct rt_ptp_clock_time start;
+		/*
+		 * Phase offset. The signal should start toggling at an
+		 * unspecified integer multiple of the period, plus this value.
+		 * The start time should be "as soon as possible".
+		 * Valid only if (flags & PTP_PEROUT_PHASE) is set.
+		 */
+		struct rt_ptp_clock_time phase;
+	};
+	struct rt_ptp_clock_time period; /* Desired period, zero means disable. */
+	unsigned int index;           /* Which channel to configure. */
+	unsigned int flags;
+	union {
+		/*
+		 * The "on" time of the signal.
+		 * Must be lower than the period.
+		 * Valid only if (flags & PTP_PEROUT_DUTY_CYCLE) is set.
+		 */
+		struct rt_ptp_clock_time on;
+		/* Reserved for future use. */
+		unsigned int rsv[4];
+	};
+};
+
+struct rt_ptp_event_count_tstamp {
+	struct rt_ptp_clock_time device_time;
+	unsigned long long event_count;
+	unsigned int index;
+	unsigned int flags;
+	unsigned int rsv[4];          /* Reserved for future use. */
+};
+
+#define RT_PTP_MAX_SAMPLES 25 /* Maximum allowed offset measurement samples. */
+
+struct rt_ptp_sys_offset {
+	unsigned int n_samples; /* Desired number of measurements. */
+	unsigned int rsv[3];    /* Reserved for future use. */
+	/*
+	 * Array of interleaved system/phc time stamps. The kernel
+	 * will provide 2*n_samples + 1 time stamps, with the last
+	 * one as a system time stamp.
+	 */
+	struct rt_ptp_clock_time ts[2 * RT_PTP_MAX_SAMPLES + 1];
+};
+
+struct rt_ptp_sys_offset_extended {
+	unsigned int n_samples; /* Desired number of measurements. */
+	unsigned int rsv[3];    /* Reserved for future use. */
+	/*
+	 * Array of [system, phc, system] time stamps. The kernel will provide
+	 * 3*n_samples time stamps.
+	 */
+	struct rt_ptp_clock_time ts[RT_PTP_MAX_SAMPLES][3];
+};
+
+struct rt_ptp_sys_offset_precise {
+	struct rt_ptp_clock_time device;
+	struct rt_ptp_clock_time sys_realtime;
+	struct rt_ptp_clock_time sys_monoraw;
+	unsigned int rsv[4];    /* Reserved for future use. */
+};
+
+enum rt_ptp_pin_function {
+	RT_PTP_PF_NONE,
+	RT_PTP_PF_EXTTS,
+	RT_PTP_PF_PEROUT,
+	RT_PTP_PF_PHYSYNC,
+};
+
+struct rt_ptp_pin_desc {
+	/*
+	 * Hardware specific human readable pin name. This field is
+	 * set by the kernel during the PTP_PIN_GETFUNC ioctl and is
+	 * ignored for the PTP_PIN_SETFUNC ioctl.
+	 */
+	char name[64];
+	/*
+	 * Pin index in the range of zero to ptp_clock_caps.n_pins - 1.
+	 */
+	unsigned int index;
+	/*
+	 * Which of the PTP_PF_xxx functions to use on this pin.
+	 */
+	unsigned int func;
+	/*
+	 * The specific channel to use for this function.
+	 * This corresponds to the 'index' field of the
+	 * PTP_EXTTS_REQUEST and PTP_PEROUT_REQUEST ioctls.
+	 */
+	unsigned int chan;
+	/*
+	 * Per pin capability flag
+	 */
+	unsigned int flags;
+	/*
+	 * Reserved for future use.
+	 */
+	unsigned int rsv[5];
+};
+
+#define RT_PTP_CLK_MAGIC RTDM_CLASS_PTP
+
+#define RT_PTP_CLOCK_GETCAPS	_IOR(RT_PTP_CLK_MAGIC, 1, struct rt_ptp_clock_caps)
+#define RT_PTP_EXTTS_REQUEST	_IOW(RT_PTP_CLK_MAGIC, 2, struct rt_ptp_extts_request)
+#define RT_PTP_PEROUT_REQUEST	_IOW(RT_PTP_CLK_MAGIC, 3, struct rt_ptp_perout_request)
+#define RT_PTP_ENABLE_PPS	_IOW(RT_PTP_CLK_MAGIC, 4, int)
+#define RT_PTP_SYS_OFFSET	_IOW(RT_PTP_CLK_MAGIC, 5, struct rt_ptp_sys_offset)
+#define RT_PTP_PIN_GETFUNC	_IOWR(RT_PTP_CLK_MAGIC, 6, struct rt_ptp_pin_desc)
+#define RT_PTP_PIN_SETFUNC	_IOW(RT_PTP_CLK_MAGIC, 7, struct rt_ptp_pin_desc)
+#define RT_PTP_SYS_OFFSET_PRECISE	\
+	_IOWR(RT_PTP_CLK_MAGIC, 8, struct rt_ptp_sys_offset_precise)
+#define RT_PTP_SYS_OFFSET_EXTENDED	\
+	_IOWR(RT_PTP_CLK_MAGIC, 9, struct rt_ptp_sys_offset_extended)
+
+#define RT_PTP_CLOCK_GETCAPS2	_IOR(RT_PTP_CLK_MAGIC, 10, struct rt_ptp_clock_caps)
+#define RT_PTP_EXTTS_REQUEST2	_IOW(RT_PTP_CLK_MAGIC, 11, struct rt_ptp_extts_request)
+#define RT_PTP_PEROUT_REQUEST2	_IOW(RT_PTP_CLK_MAGIC, 12, struct rt_ptp_perout_request)
+#define RT_PTP_ENABLE_PPS2	_IOW(RT_PTP_CLK_MAGIC, 13, int)
+#define RT_PTP_SYS_OFFSET2	_IOW(RT_PTP_CLK_MAGIC, 14, struct rt_ptp_sys_offset)
+#define RT_PTP_PIN_GETFUNC2	_IOWR(RT_PTP_CLK_MAGIC, 15, struct rt_ptp_pin_desc)
+#define RT_PTP_PIN_SETFUNC2	_IOW(RT_PTP_CLK_MAGIC, 16, struct rt_ptp_pin_desc)
+#define RT_PTP_SYS_OFFSET_PRECISE2	\
+	_IOWR(RT_PTP_CLK_MAGIC, 17, struct rt_ptp_sys_offset_precise)
+#define RT_PTP_SYS_OFFSET_EXTENDED2	\
+	_IOWR(RT_PTP_CLK_MAGIC, 18, struct rt_ptp_sys_offset_extended)
+#define RT_PTP_EVENT_COUNT_TSTAMP2	\
+	_IOWR(RT_PTP_CLK_MAGIC, 19, struct rt_ptp_event_count_tstamp)
+
+struct rt_ptp_extts_event {
+	struct rt_ptp_clock_time t; /* Time event occured. */
+	unsigned int index;      /* Which channel produced the event. */
+	unsigned int flags;      /* Reserved for future use. */
+	unsigned int rsv[2];     /* Reserved for future use. */
+};
+
+#endif
diff --git a/include/rtdm/uapi/rtdm.h b/include/rtdm/uapi/rtdm.h
index 80c789a..027b88c 100644
--- a/include/rtdm/uapi/rtdm.h
+++ b/include/rtdm/uapi/rtdm.h
@@ -82,6 +82,7 @@ typedef int64_t nanosecs_rel_t;
 #define RTDM_CLASS_GPIO			11
 #define RTDM_CLASS_SPI			12
 #define RTDM_CLASS_PWM			13
+#define RTDM_CLASS_PTP			14
 
 #define RTDM_CLASS_MISC			223
 #define RTDM_CLASS_EXPERIMENTAL		224
diff --git a/kernel/drivers/Kconfig b/kernel/drivers/Kconfig
index 197a48e..0dfe1b6 100644
--- a/kernel/drivers/Kconfig
+++ b/kernel/drivers/Kconfig
@@ -31,5 +31,5 @@ source "drivers/xenomai/udd/Kconfig"
 source "drivers/xenomai/gpio/Kconfig"
 source "drivers/xenomai/gpiopwm/Kconfig"
 source "drivers/xenomai/spi/Kconfig"
-
+source "drivers/xenomai/ptp/Kconfig"
 endmenu
diff --git a/kernel/drivers/Makefile b/kernel/drivers/Makefile
index b8fe1b3..6064209 100644
--- a/kernel/drivers/Makefile
+++ b/kernel/drivers/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_XENOMAI) += autotune/ serial/ testing/ can/ net/ analogy/ ipc/ udd/ gpio/ gpiopwm/ spi/
+obj-$(CONFIG_XENOMAI) += autotune/ serial/ testing/ can/ net/ analogy/ ipc/ udd/ gpio/ gpiopwm/ spi/ ptp/
diff --git a/kernel/drivers/ptp/Kconfig b/kernel/drivers/ptp/Kconfig
new file mode 100644
index 0000000..cc22ffe
--- /dev/null
+++ b/kernel/drivers/ptp/Kconfig
@@ -0,0 +1,9 @@
+menu "PTP drivers"
+
+config XENO_DRIVERS_PTP
+	tristate "PTP clock support"
+	default y
+	help
+	This driver adds support for PTP clocks as RT devices.
+
+endmenu
diff --git a/kernel/drivers/ptp/Makefile b/kernel/drivers/ptp/Makefile
new file mode 100644
index 0000000..bcb2faa
--- /dev/null
+++ b/kernel/drivers/ptp/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_XENO_DRIVERS_PTP) += xeno_ptp.o
+xeno_ptp-y := ptp.o
diff --git a/kernel/drivers/ptp/ptp.c b/kernel/drivers/ptp/ptp.c
new file mode 100644
index 0000000..4045bf8
--- /dev/null
+++ b/kernel/drivers/ptp/ptp.c
@@ -0,0 +1,537 @@
+/**
+ * @note Copyright (C) 2011 Richard Cochran <richardcochran@gmail.com>
+ *
+ * Derived from the Linux PTP driver (drivers/ptp/ptp_chardev.c)
+ *
+ * RTDM integration by:
+ * 	Copyright (C) 2022 Zqiang <qiang1.zhang@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+#include <linux/module.h>
+#include <linux/nospec.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include "ptp.h"
+
+static int rt_ptp_disable_pinfunc(struct rt_ptp_clock_info *ops,
+			enum rt_ptp_pin_function func, unsigned int chan)
+{
+	struct rt_ptp_clock_request rq;
+	int err = 0;
+	memset(&rq, 0, sizeof(rq));
+
+	switch (func) {
+		case RT_PTP_PF_NONE:
+			break;
+		case RT_PTP_PF_EXTTS:
+			rq.type = RT_PTP_CLK_REQ_EXTTS;
+			rq.extts.index = chan;
+			err = ops->enable(ops, &rq, 0);
+			break;
+		case RT_PTP_PF_PEROUT:
+			rq.type = RT_PTP_CLK_REQ_PEROUT;
+			rq.perout.index = chan;
+			err = ops->enable(ops, &rq, 0);
+			break;
+		case RT_PTP_PF_PHYSYNC:
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	return err;
+}
+
+int rt_ptp_set_pinfunc(struct rt_ptp_clock *ptp, unsigned int pin,
+			enum rt_ptp_pin_function func, unsigned int chan)
+{
+	struct rt_ptp_clock_info *info = ptp->info;
+	struct rt_ptp_pin_desc *pin1 = NULL, *pin2 = &info->pin_config[pin];
+	unsigned int i;
+
+	/* Check to see if any other pin previously had this function. */
+	for (i = 0; i < info->n_pins; i++) {
+		if (info->pin_config[i].func == func &&
+			info->pin_config[i].chan == chan) {
+			pin1 = &info->pin_config[i];
+			break;
+		}
+	}
+
+	if (pin1 && i == pin)
+		return 0;
+
+	/* Check the desired function and channel. */
+	switch (func) {
+		case RT_PTP_PF_NONE:
+			break;
+		case RT_PTP_PF_EXTTS:
+			if (chan >= info->n_ext_ts)
+				return -EINVAL;
+			break;
+		case RT_PTP_PF_PEROUT:
+			if (chan >= info->n_per_out)
+				return -EINVAL;
+			break;
+		case RT_PTP_PF_PHYSYNC:
+			if (chan != 0)
+				return -EINVAL;
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	if (info->verify(info, pin, func, chan)) {
+		printk(XENO_ERR "driver cannot use function %u on pin %u\n",
+				func, chan);
+		return -EOPNOTSUPP;
+	}
+
+	/* Disable whatever function was previously assigned. */
+	if (pin1) {
+		rt_ptp_disable_pinfunc(info, func, chan);
+		pin1->func = RT_PTP_PF_NONE;
+		pin1->chan = 0;
+	}
+	rt_ptp_disable_pinfunc(info, pin2->func, pin2->chan);
+	pin2->func = func;
+	pin2->chan = chan;
+
+	return 0;
+}
+
+static int rtdm_ptp_open(struct rtdm_fd *fd, int oflags)
+{
+	return 0;
+}
+
+static int rtdm_ptp_nrt_ioctl(struct rtdm_fd *fd, unsigned int request,
+				void *arg)
+{
+	printk(KERN_ERR "Not support nrt ptp ioctl.\n");
+	return -ENOSYS;
+}
+
+static int rtdm_ptp_ioctl(struct rtdm_fd *fd, unsigned int request, void *arg)
+{
+	int enable, err;
+	struct rt_ptp_clock *ptp;
+	struct rt_ptp_clock_info *ops;
+	struct rt_ptp_clock_caps caps;
+	struct rt_ptp_sys_offset_precise precise_offset;
+	struct rt_ptp_pin_desc pd;
+	struct rt_ptp_clock_request req;
+	struct system_device_crosststamp xtstamp;
+	unsigned int pin_index;
+	struct timespec64 ts;
+	struct rt_ptp_event_count_tstamp counttstamp;
+	ptp = (struct rt_ptp_clock *)rtdm_fd_device(fd)->device_data;
+	ops = ptp->info;
+
+	switch (request) {
+	case RT_PTP_CLOCK_GETCAPS:
+	case RT_PTP_CLOCK_GETCAPS2:
+		memset(&caps, 0, sizeof(caps));
+		caps.max_adj = ptp->info->max_adj;
+		caps.n_alarm = ptp->info->n_alarm;
+		caps.n_ext_ts = ptp->info->n_ext_ts;
+		caps.n_per_out = ptp->info->n_per_out;
+		caps.pps = ptp->info->pps;
+		caps.n_pins = ptp->info->n_pins;
+		caps.cross_timestamping = ptp->info->getcrosststamp != NULL;
+		caps.adjust_phase = ptp->info->adjphase != NULL;
+		if (rtdm_copy_to_user(fd, arg, &caps, sizeof(caps)))
+			err = -EFAULT;
+		break;
+
+	case RT_PTP_EXTTS_REQUEST:
+	case RT_PTP_EXTTS_REQUEST2:
+		memset(&req, 0, sizeof(req));
+		if (rtdm_copy_from_user(fd, &req.extts, (void __user *)arg,
+					sizeof(req.extts))) {
+			err = -EFAULT;
+			break;
+		}
+		if (request == RT_PTP_EXTTS_REQUEST2) {
+			/* Tell the drivers to check the flags carefully. */
+			req.extts.flags |= RT_PTP_STRICT_FLAGS;
+			/* Make sure no reserved bit is set. */
+			if ((req.extts.flags & ~RT_PTP_EXTTS_VALID_FLAGS) ||
+			req.extts.rsv[0] || req.extts.rsv[1]) {
+				err = -EINVAL;
+				break;
+			}
+			/* Ensure one of the rising/falling edge bits is set. */
+			if ((req.extts.flags & RT_PTP_ENABLE_FEATURE) &&
+				(req.extts.flags & RT_PTP_EXTTS_EDGES) == 0) {
+				err = -EINVAL;
+				break;
+			}
+		} else if (request == RT_PTP_EXTTS_REQUEST) {
+			req.extts.flags &= RT_PTP_EXTTS_V1_VALID_FLAGS;
+			/* zero_rsv_field(req.extts.rsv); */
+			/* TOFIX: Temporarily uses RESERVED field to */
+			/* pass event count value */
+			req.extts.rsv[0] = 0;
+			req.extts.rsv[1] = 0;
+		}
+		if (req.extts.index >= ops->n_ext_ts) {
+			err = -EINVAL;
+			break;
+		}
+		req.type = RT_PTP_CLK_REQ_EXTTS;
+		enable = req.extts.flags & RT_PTP_ENABLE_FEATURE ? 1 : 0;
+		rtdm_mutex_lock(&ptp->pincfg_mux);
+		err = ops->enable(ops, &req, enable);
+		rtdm_mutex_unlock(&ptp->pincfg_mux);
+		break;
+
+	case RT_PTP_PEROUT_REQUEST:
+	case RT_PTP_PEROUT_REQUEST2:
+		memset(&req, 0, sizeof(req));
+
+		if (rtdm_copy_from_user(fd, &req.perout, (void __user *)arg,
+				sizeof(req.perout))) {
+			err = -EFAULT;
+			break;
+		}
+		if (request == RT_PTP_PEROUT_REQUEST2) {
+			struct rt_ptp_perout_request *perout = &req.perout;
+
+			if (perout->flags & ~RT_PTP_PEROUT_VALID_FLAGS) {
+				err = -EINVAL;
+				break;
+			}
+			/*
+			* The "on" field has undefined meaning if
+			* PTP_PEROUT_DUTY_CYCLE isn't set, we must still treat
+			* it as reserved, which must be set to zero.
+			*/
+			if (!(perout->flags & RT_PTP_PEROUT_DUTY_CYCLE) &&
+				(perout->rsv[0] || perout->rsv[1] ||
+				perout->rsv[2] || perout->rsv[3])) {
+				err = -EINVAL;
+				break;
+			}
+			if (perout->flags & RT_PTP_PEROUT_DUTY_CYCLE) {
+				/* The duty cycle must be subunitary. */
+				if (perout->on.sec > perout->period.sec ||
+					(perout->on.sec == perout->period.sec &&
+					perout->on.nsec > perout->period.nsec)) {
+					err = -ERANGE;
+					break;
+				}
+			}
+			if (perout->flags & RT_PTP_PEROUT_PHASE) {
+				/*
+				* The phase should be specified modulo the
+				* period, therefore anything equal or larger
+				* than 1 period is invalid.
+				*/
+				if (perout->phase.sec > perout->period.sec ||
+				(perout->phase.sec == perout->period.sec &&
+				perout->phase.nsec >= perout->period.nsec)) {
+					err = -ERANGE;
+					break;
+				}
+			}
+		} else if (request == RT_PTP_PEROUT_REQUEST) {
+			req.perout.flags &= RT_PTP_PEROUT_V1_VALID_FLAGS;
+			req.perout.rsv[0] = 0;
+			req.perout.rsv[1] = 0;
+			req.perout.rsv[2] = 0;
+			req.perout.rsv[3] = 0;
+		}
+
+		if (req.perout.index >= ops->n_per_out) {
+			err = -EINVAL;
+			break;
+		}
+		req.type = RT_PTP_CLK_REQ_PEROUT;
+		enable = req.perout.period.sec || req.perout.period.nsec;
+		rtdm_mutex_lock(&ptp->pincfg_mux);
+		err = ops->enable(ops, &req, enable);
+		rtdm_mutex_unlock(&ptp->pincfg_mux);
+		break;
+
+	case RT_PTP_EVENT_COUNT_TSTAMP2:
+		if (!ops->counttstamp)
+			return -ENOTSUPP;
+		if (rtdm_copy_from_user(fd, &counttstamp, (void __user *)arg,
+					sizeof(counttstamp))) {
+			err = -EFAULT;
+			break;
+		}
+
+		err = ops->counttstamp(ops, &counttstamp);
+		if (!err && rtdm_copy_to_user(fd, (void __user *)arg, &counttstamp,
+					sizeof(counttstamp)))
+			err = -EFAULT;
+		break;
+
+	case RT_PTP_SYS_OFFSET_PRECISE:
+	case RT_PTP_SYS_OFFSET_PRECISE2:
+		if (!ptp->info->getcrosststamp) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+		err = ptp->info->getcrosststamp(ptp->info, &xtstamp);
+		if (err)
+			break;
+
+		memset(&precise_offset, 0, sizeof(precise_offset));
+		ts = ktime_to_timespec64(xtstamp.device);
+		precise_offset.device.sec = ts.tv_sec;
+		precise_offset.device.nsec = ts.tv_nsec;
+		ts = ktime_to_timespec64(xtstamp.sys_realtime);
+		precise_offset.sys_realtime.sec = ts.tv_sec;
+		precise_offset.sys_realtime.nsec = ts.tv_nsec;
+		ts = ktime_to_timespec64(xtstamp.sys_monoraw);
+		precise_offset.sys_monoraw.sec = ts.tv_sec;
+		precise_offset.sys_monoraw.nsec = ts.tv_nsec;
+		if (rtdm_copy_to_user(fd, (void __user *)arg, &precise_offset,
+					sizeof(precise_offset)))
+			err = -EFAULT;
+		break;
+
+	case RT_PTP_PIN_GETFUNC:
+	case RT_PTP_PIN_GETFUNC2:
+		if (rtdm_copy_from_user(fd, &pd, (void __user *)arg, sizeof(pd)))
+		{
+			err = -EFAULT;
+			break;
+		}
+		if ((pd.rsv[0] || pd.rsv[1] || pd.rsv[2]
+				|| pd.rsv[3] || pd.rsv[4])
+			&& request == RT_PTP_PIN_GETFUNC2) {
+			err = -EINVAL;
+			break;
+		} else if (request == RT_PTP_PIN_GETFUNC) {
+			pd.rsv[0] = 0;
+			pd.rsv[1] = 0;
+			pd.rsv[2] = 0;
+			pd.rsv[3] = 0;
+			pd.rsv[4] = 0;
+		}
+		pin_index = pd.index;
+		if (pin_index >= ops->n_pins) {
+			err = -EINVAL;
+			break;
+		}
+		pin_index = array_index_nospec(pin_index, ops->n_pins);
+		rtdm_mutex_lock(&ptp->pincfg_mux);
+		pd = ops->pin_config[pin_index];
+		rtdm_mutex_unlock(&ptp->pincfg_mux);
+		if (!err && rtdm_copy_to_user(fd, arg, &pd, sizeof(pd)))
+			err = -EFAULT;
+		break;
+
+	case RT_PTP_PIN_SETFUNC:
+	case RT_PTP_PIN_SETFUNC2:
+		if (rtdm_copy_from_user(fd, &pd, (void __user *)arg, sizeof(pd)))
+		{
+			err = -EFAULT;
+			break;
+		}
+		if ((pd.rsv[0] || pd.rsv[1] || pd.rsv[2]
+				|| pd.rsv[3] || pd.rsv[4])
+				&& request == RT_PTP_PIN_SETFUNC2) {
+			err = -EINVAL;
+			break;
+		} else if (request == RT_PTP_PIN_SETFUNC) {
+			pd.rsv[0] = 0;
+			pd.rsv[1] = 0;
+			pd.rsv[2] = 0;
+			pd.rsv[3] = 0;
+			pd.rsv[4] = 0;
+		}
+		pin_index = pd.index;
+		if (pin_index >= ops->n_pins) {
+			err = -EINVAL;
+			break;
+		}
+		pin_index = array_index_nospec(pin_index, ops->n_pins);
+		rtdm_mutex_lock(&ptp->pincfg_mux);
+		err = rt_ptp_set_pinfunc(ptp, pin_index, pd.func, pd.chan);
+		rtdm_mutex_unlock(&ptp->pincfg_mux);
+		break;
+
+	default:
+		err = -ENOTTY;
+		break;
+	}
+
+	return err;
+}
+
+static void enqueue_external_event(struct rt_ptp_event_queue *queue,
+                                       struct rt_ptp_event *src)
+{
+	struct rt_ptp_extts_event *dst;
+	rtdm_lockctx_t flags;
+	s64 seconds;
+	u32 remainder;
+
+	seconds = div_u64_rem(src->timestamp, 1000000000, &remainder);
+
+	rtdm_lock_get_irqsave(&queue->lock, flags);
+	dst = &queue->buf[queue->tail];
+	dst->index = src->index;
+	dst->t.sec = seconds;
+	dst->t.nsec = remainder;
+
+	if (!queue_free(queue))
+		queue->head = (queue->head + 1) % PTP_EVENT_MAX;
+
+	queue->tail = (queue->tail + 1) % PTP_EVENT_MAX;
+	rtdm_lock_put_irqrestore(&queue->lock, flags);
+}
+
+void rt_ptp_clock_event(struct rt_ptp_clock *ptp, struct rt_ptp_event *event)
+{
+	switch (event->type) {
+		case RT_PTP_CLK_REQ_EXTTS:
+			enqueue_external_event(&ptp->tsevq, event);
+			rtdm_event_signal(&ptp->event);
+			break;
+		default:
+			break;
+	}
+}
+EXPORT_SYMBOL_GPL(rt_ptp_clock_event);
+
+#define EXTTS_BUFSIZE (PTP_BUF_MAX * sizeof(struct rt_ptp_extts_event))
+static ssize_t rtdm_ptp_read(struct rtdm_fd *fd, void __user *buf, size_t cnt)
+{
+	struct rt_ptp_clock *ptp;
+	struct rt_ptp_event_queue *queue;
+	struct rt_ptp_extts_event *event;
+	rtdm_lockctx_t flags;
+	size_t qcnt, i;
+	int result;
+
+	ptp = (struct rt_ptp_clock *)rtdm_fd_device(fd)->device_data;
+	queue = &ptp->tsevq;
+
+	if (cnt % sizeof(struct rt_ptp_extts_event) != 0)
+		return -EINVAL;
+
+	if (cnt > EXTTS_BUFSIZE)
+                cnt = EXTTS_BUFSIZE;
+	cnt = cnt / sizeof(struct rt_ptp_extts_event);
+
+	rtdm_mutex_lock(&ptp->tsevq_mux);
+	result = rtdm_event_wait(&ptp->event);
+	if (result) {
+		rtdm_mutex_unlock(&ptp->tsevq_mux);
+		return result;
+	}
+
+	event = xnmalloc(cnt * sizeof(struct rt_ptp_extts_event));
+	if (!event) {
+		rtdm_mutex_unlock(&ptp->tsevq_mux);
+		return -ENOMEM;
+	}
+
+	rtdm_lock_get_irqsave(&queue->lock, flags);
+	qcnt = queue_cnt(queue);
+
+	if (cnt > qcnt)
+		cnt = qcnt;
+
+	for (i = 0; i < cnt; i++) {
+		event[i] = queue->buf[queue->head];
+		queue->head = (queue->head + 1) % PTP_EVENT_MAX;
+	}
+
+	rtdm_lock_put_irqrestore(&queue->lock, flags);
+	cnt = cnt * sizeof(struct rt_ptp_extts_event);
+	rtdm_mutex_unlock(&ptp->tsevq_mux);
+
+	result = cnt;
+	if (rtdm_copy_to_user(fd, buf, event, cnt))
+		result = -EFAULT;
+
+	xnfree(event);
+	return result;
+}
+
+static void rtdm_ptp_close(struct rtdm_fd *fd)
+{
+}
+
+static struct rtdm_driver rtdm_ptp_driver = {
+	.profile_info = RTDM_PROFILE_INFO(rtdm_ptp_basic,
+					RTDM_CLASS_PTP,
+					RTDM_SUBCLASS_RTDMPTP,
+					RTPTP_PROFILE_VER),
+	.device_flags = RTDM_NAMED_DEVICE,
+	.device_count = DEVICE_COUNT,
+	.context_size = 0,
+	.ops          = {
+		.open		= rtdm_ptp_open,
+		.read_rt	= rtdm_ptp_read,
+		.close		= rtdm_ptp_close,
+		.ioctl_rt	= rtdm_ptp_ioctl,
+		.ioctl_nrt	= rtdm_ptp_nrt_ioctl,
+	},
+};
+
+struct rt_ptp_clock *rt_ptp_clock_register(struct rt_ptp_clock_info *info,
+					const char *name)
+{
+	struct rt_ptp_clock *ptp;
+	int err = -ENOMEM;
+	struct rtdm_device *dev;
+
+	ptp = kzalloc(sizeof(struct rt_ptp_clock), GFP_KERNEL);
+	if (ptp == NULL)
+		goto no_memory;
+
+	ptp->info = info;
+	dev = &ptp->dev;
+	dev->driver = &rtdm_ptp_driver;
+	dev->label  = name;
+	dev->device_data = ptp;
+
+	err = rtdm_dev_register(dev);
+	if (err) {
+		printk(KERN_ERR "rtdm ptp dev register error.\n");
+		goto fail;
+	}
+
+	rtdm_mutex_init(&ptp->pincfg_mux);
+	rtdm_mutex_init(&ptp->tsevq_mux);
+	rtdm_event_init(&ptp->event, 0);
+	return ptp;
+fail:
+	kfree(ptp);
+no_memory:
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(rt_ptp_clock_register);
+
+void rt_ptp_clock_unregister(struct rt_ptp_clock *ptp)
+{
+	struct rtdm_device *dev = &ptp->dev;
+
+	rtdm_dev_unregister(dev);
+	rtdm_mutex_destroy(&ptp->pincfg_mux);
+	rtdm_mutex_destroy(&ptp->tsevq_mux);
+	rtdm_event_destroy(&ptp->event);
+	kfree(ptp);
+}
+EXPORT_SYMBOL_GPL(rt_ptp_clock_unregister);
diff --git a/kernel/drivers/ptp/ptp.h b/kernel/drivers/ptp/ptp.h
new file mode 100644
index 0000000..37fbc33
--- /dev/null
+++ b/kernel/drivers/ptp/ptp.h
@@ -0,0 +1,106 @@
+/**
+ * @note Copyright (C) 2022 Zqiang <qiang1.zhang@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+#ifndef _RTDM_PTP_DEVICE_H
+#define _RTDM_PTP_DEVICE_H
+
+#include <rtdm/driver.h>
+#include <rtdm/uapi/rt_ptp_clock.h>
+
+#define DEVICE_COUNT            6
+#define RTDM_SUBCLASS_RTDMPTP   1
+#define RTPTP_PROFILE_VER       2
+
+#define PTP_EVENT_MAX		128
+#define PTP_BUF_MAX		30
+
+struct rt_ptp_event_queue
+{
+	struct rt_ptp_extts_event buf[PTP_EVENT_MAX];
+	int head;
+	int tail;
+	rtdm_lock_t lock;
+};
+
+struct rt_ptp_event {
+	int type;
+	int index;
+	u64 timestamp;
+};
+
+struct rt_ptp_clock_request {
+	enum {
+		RT_PTP_CLK_REQ_EXTTS,
+		RT_PTP_CLK_REQ_PEROUT,
+		RT_PTP_CLK_REQ_PPS,
+	} type;
+	union {
+		struct rt_ptp_extts_request extts;
+		struct rt_ptp_perout_request perout;
+	};
+};
+
+struct rt_ptp_clock_info {
+	struct module *owner;
+	char name[16];
+	s32 max_adj;
+	int n_alarm;
+	int n_ext_ts;
+	int n_per_out;
+	int n_pins;
+	int pps;
+	struct rt_ptp_pin_desc *pin_config;
+
+	int (*getcrosststamp)(struct rt_ptp_clock_info *ptp,
+			struct system_device_crosststamp *cts);
+	int (*counttstamp)(struct rt_ptp_clock_info *ptp,
+			struct rt_ptp_event_count_tstamp *count);
+	int (*enable)(struct rt_ptp_clock_info *ptp,
+			struct rt_ptp_clock_request *request, int on);
+	int (*verify)(struct rt_ptp_clock_info *ptp, unsigned int pin,
+			enum rt_ptp_pin_function func, unsigned int chan);
+	int (*adjphase)(struct rt_ptp_clock_info *ptp, s32 phase);
+};
+
+struct rt_ptp_clock {
+	struct rtdm_device dev;
+	struct rt_ptp_clock_info *info;
+	rtdm_mutex_t pincfg_mux;
+	struct rt_ptp_event_queue tsevq;
+	rtdm_event_t event;
+	rtdm_mutex_t tsevq_mux;
+};
+
+static inline int queue_cnt(struct rt_ptp_event_queue *q)
+{
+	int cnt = q->tail - q->head;
+
+	return cnt < 0 ? PTP_EVENT_MAX + cnt : cnt;
+}
+
+static inline int queue_free(struct rt_ptp_event_queue *q)
+{
+	return PTP_EVENT_MAX - queue_cnt(q) - 1;
+}
+
+struct rt_ptp_clock *rt_ptp_clock_register(struct rt_ptp_clock_info *info,
+					const char *name);
+
+void rt_ptp_clock_event(struct rt_ptp_clock *ptp, struct rt_ptp_event *event);
+
+void rt_ptp_clock_unregister(struct rt_ptp_clock *ptp);
+#endif
-- 
2.25.1


