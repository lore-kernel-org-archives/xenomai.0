From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/2] drivers/gpio: Add support for selecting real-time clock
 timestamps
Date: Mon, 16 Aug 2021 12:18:51 +0200
Message-Id: <47c62dfb70516b372322839ae5c9aff578aa0e6e.1629109132.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1629109132.git.jan.kiszka@siemens.com>
References: <cover.1629109132.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to compare timestamps of GPIO pins against other devices and
ensures that the stamps are synchronized cross-systems in case PTP is in
use (dovetail-based kernels). Keep default to monotonic for now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/rtdm/gpio.h |  1 +
 include/rtdm/uapi/gpio.h          |  4 +++-
 kernel/drivers/gpio/gpio-core.c   | 14 +++++++++++---
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/gpio.h b/include/cobalt/kernel/rtdm/gpio.h
index 00055ec0a9..72cc3a0356 100644
--- a/include/cobalt/kernel/rtdm/gpio.h
+++ b/include/cobalt/kernel/rtdm/gpio.h
@@ -34,6 +34,7 @@ struct rtdm_gpio_pin {
 	char *name;
 	struct gpio_desc *desc;
 	nanosecs_abs_t timestamp;
+	bool monotonic_timestamp;
 };
 
 struct rtdm_gpio_chip {
diff --git a/include/rtdm/uapi/gpio.h b/include/rtdm/uapi/gpio.h
index 2839f7d51c..fb84274453 100644
--- a/include/rtdm/uapi/gpio.h
+++ b/include/rtdm/uapi/gpio.h
@@ -29,7 +29,9 @@ struct rtdm_gpio_readout {
 #define GPIO_RTIOC_IRQDIS	_IO(RTDM_CLASS_GPIO, 3)
 #define GPIO_RTIOC_REQS		_IO(RTDM_CLASS_GPIO, 4)
 #define GPIO_RTIOC_RELS		_IO(RTDM_CLASS_GPIO, 5)
-#define GPIO_RTIOC_TS		_IOR(RTDM_CLASS_GPIO, 7, int)
+#define GPIO_RTIOC_TS_MONO	_IOR(RTDM_CLASS_GPIO, 7, int)
+#define GPIO_RTIOC_TS		GPIO_RTIOC_TS_MONO
+#define GPIO_RTIOC_TS_REAL	_IOR(RTDM_CLASS_GPIO, 8, int)
 
 #define GPIO_TRIGGER_NONE		0x0 /* unspecified */
 #define GPIO_TRIGGER_EDGE_RISING	0x1
diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index 600ef9789a..06a19b33a9 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -189,11 +189,13 @@ static int gpio_pin_ioctl_nrt(struct rtdm_fd *fd,
 		gpio_free(gpio);
 		chan->requested = false;
 		break;
-	case GPIO_RTIOC_TS:
+	case GPIO_RTIOC_TS_MONO:
+	case GPIO_RTIOC_TS_REAL:
 		ret = rtdm_safe_copy_from_user(fd, &val, arg, sizeof(val));
 		if (ret)
 			return ret;
 		chan->want_timestamp = !!val;
+		pin->monotonic_timestamp = request == GPIO_RTIOC_TS_MONO;
 		break;
 	default:
 		return -EINVAL;
@@ -228,8 +230,11 @@ static ssize_t gpio_pin_read_rt(struct rtdm_fd *fd,
 			if (ret)
 				return ret;
 			rdo.timestamp = pin->timestamp;
-		} else
+		} else if (pin->monotonic_timestamp) {
 			rdo.timestamp = rtdm_clock_read_monotonic();
+		} else {
+			rdo.timestamp = rtdm_clock_read();
+		}
 
 		len = sizeof(rdo);
 		rdo.value = gpiod_get_raw_value(pin->desc);
@@ -489,7 +494,10 @@ int rtdm_gpiochip_post_event(struct rtdm_gpio_chip *rgc,
 		return -EINVAL;
 
 	pin = rgc->pins + offset;
-	pin->timestamp = rtdm_clock_read_monotonic();
+	if (pin->monotonic_timestamp)
+		pin->timestamp = rtdm_clock_read_monotonic();
+	else
+		pin->timestamp = rtdm_clock_read();
 	rtdm_event_signal(&pin->event);
 	
 	return 0;
-- 
2.31.1


