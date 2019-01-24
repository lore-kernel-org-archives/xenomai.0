From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 02/12] drivers/gpio: provide optional timestamped readouts
Date: Thu, 24 Jan 2019 16:34:18 +0100
Message-Id: <20190124153428.21006-3-rpm@xenomai.org>
In-Reply-To: <20190124153428.21006-1-rpm@xenomai.org>
References: <20190124153428.21006-1-rpm@xenomai.org>
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

In timestamping mode, read() returns the timestamp of the latest event
receipt on the pin based on CLOCK_MONOTONIC, along with the pin
state. This is an optional pin readout mode controlled by the
GPIO_RTIOC_TS request, e.g.:

struct rtdm_gpio_readout rdo;
int ret, on, val;

on = 1;
ret = ioctl(pinfd, GPIO_RTIOC_TS, &on);
ret = read(pinfd, &rdo, sizeof(rdo));
/* pin state changed to rdo.value at time rdo.timestamp */

on = 0;
ret = ioctl(pinfd, GPIO_RTIOC_TS, &on);
ret = read(pinfd, &val, sizeof(val));
/* pin state changed to value (time of change unspecified) */

By default, timestamping mode is disabled, which corresponds to the
original behavior.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/rtdm/gpio.h |  1 +
 include/rtdm/uapi/gpio.h          | 18 +++++++----
 kernel/drivers/gpio/gpio-core.c   | 54 +++++++++++++++++++++++--------
 3 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/gpio.h b/include/cobalt/kernel/rtdm/gpio.h
index cdb472f8a..00055ec0a 100644
--- a/include/cobalt/kernel/rtdm/gpio.h
+++ b/include/cobalt/kernel/rtdm/gpio.h
@@ -33,6 +33,7 @@ struct rtdm_gpio_pin {
 	rtdm_event_t event;
 	char *name;
 	struct gpio_desc *desc;
+	nanosecs_abs_t timestamp;
 };
 
 struct rtdm_gpio_chip {
diff --git a/include/rtdm/uapi/gpio.h b/include/rtdm/uapi/gpio.h
index b745f156c..ac14be66c 100644
--- a/include/rtdm/uapi/gpio.h
+++ b/include/rtdm/uapi/gpio.h
@@ -18,12 +18,18 @@
 #ifndef _RTDM_UAPI_GPIO_H
 #define _RTDM_UAPI_GPIO_H
 
-#define GPIO_RTIOC_DIR_OUT		_IOW(RTDM_CLASS_GPIO, 0, int)
-#define GPIO_RTIOC_DIR_IN		_IO(RTDM_CLASS_GPIO, 1)
-#define GPIO_RTIOC_IRQEN		_IOW(RTDM_CLASS_GPIO, 2, int) /* GPIO trigger */
-#define GPIO_RTIOC_IRQDIS		_IO(RTDM_CLASS_GPIO, 3)
-#define GPIO_RTIOC_REQS                _IO(RTDM_CLASS_GPIO, 4)
-#define GPIO_RTIOC_RELS                _IO(RTDM_CLASS_GPIO, 5)
+struct rtdm_gpio_readout {
+	__u64 timestamp;
+	__s32 value;
+};
+
+#define GPIO_RTIOC_DIR_OUT	_IOW(RTDM_CLASS_GPIO, 0, int)
+#define GPIO_RTIOC_DIR_IN	_IO(RTDM_CLASS_GPIO, 1)
+#define GPIO_RTIOC_IRQEN	_IOW(RTDM_CLASS_GPIO, 2, int) /* GPIO trigger */
+#define GPIO_RTIOC_IRQDIS	_IO(RTDM_CLASS_GPIO, 3)
+#define GPIO_RTIOC_REQS		_IO(RTDM_CLASS_GPIO, 4)
+#define GPIO_RTIOC_RELS		_IO(RTDM_CLASS_GPIO, 5)
+#define GPIO_RTIOC_TS		_IOR(RTDM_CLASS_GPIO, 7, int)
 
 #define GPIO_TRIGGER_NONE		0x0 /* unspecified */
 #define GPIO_TRIGGER_EDGE_RISING	0x1
diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index 3ce73dbd5..81f9653f1 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -28,7 +28,8 @@ struct rtdm_gpio_chan {
 	int requested : 1,
 		has_direction : 1,
 		is_output : 1,
-		is_interrupt : 1;
+	        is_interrupt : 1,
+		want_timestamp : 1;
 };
 
 static LIST_HEAD(rtdm_gpio_chips);
@@ -41,6 +42,7 @@ static int gpio_pin_interrupt(rtdm_irq_t *irqh)
 
 	pin = rtdm_irq_get_arg(irqh, struct rtdm_gpio_pin);
 
+	pin->timestamp = rtdm_clock_read_monotonic();
 	rtdm_event_signal(&pin->event);
 
 	return RTDM_IRQ_HANDLED;
@@ -187,6 +189,12 @@ static int gpio_pin_ioctl_nrt(struct rtdm_fd *fd,
 		gpio_free(gpio);
 		chan->requested = false;
 		break;
+	case GPIO_RTIOC_TS:
+		ret = rtdm_safe_copy_from_user(fd, &val, arg, sizeof(val));
+		if (ret)
+			return ret;
+		chan->want_timestamp = !!val;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -199,11 +207,9 @@ static ssize_t gpio_pin_read_rt(struct rtdm_fd *fd,
 {
 	struct rtdm_gpio_chan *chan = rtdm_fd_to_private(fd);
 	struct rtdm_device *dev = rtdm_fd_device(fd);
+	struct rtdm_gpio_readout rdo;
 	struct rtdm_gpio_pin *pin;
-	int value, ret;
-
-	if (len < sizeof(value))
-		return -EINVAL;
+	int ret;
 
 	if (!chan->has_direction)
 		return -EAGAIN;
@@ -213,16 +219,37 @@ static ssize_t gpio_pin_read_rt(struct rtdm_fd *fd,
 
 	pin = container_of(dev, struct rtdm_gpio_pin, dev);
 
-	if (!(fd->oflags & O_NONBLOCK)) {
-		ret = rtdm_event_wait(&pin->event);
-		if (ret)
-			return ret;
-	}
+	if (chan->want_timestamp) {
+		if (len < sizeof(rdo))
+			return -EINVAL;
+
+		if (!(fd->oflags & O_NONBLOCK)) {
+			ret = rtdm_event_wait(&pin->event);
+			if (ret)
+				return ret;
+			rdo.timestamp = pin->timestamp;
+		} else
+			rdo.timestamp = rtdm_clock_read_monotonic();
+
+		len = sizeof(rdo);
+		rdo.value = gpiod_get_raw_value(pin->desc);
+		ret = rtdm_safe_copy_to_user(fd, buf, &rdo, len);
+	} else {
+		if (len < sizeof(rdo.value))
+			return -EINVAL;
 
-	value = gpiod_get_raw_value(pin->desc);
-	ret = rtdm_safe_copy_to_user(fd, buf, &value, sizeof(value));
+		if (!(fd->oflags & O_NONBLOCK)) {
+			ret = rtdm_event_wait(&pin->event);
+			if (ret)
+				return ret;
+		}
+
+		len = sizeof(rdo.value);
+		rdo.value = gpiod_get_raw_value(pin->desc);
+		ret = rtdm_safe_copy_to_user(fd, buf, &rdo.value, len);
+	}
 	
-	return ret ?: sizeof(value);
+	return ret ?: len;
 }
 
 static ssize_t gpio_pin_write_rt(struct rtdm_fd *fd,
@@ -462,6 +489,7 @@ int rtdm_gpiochip_post_event(struct rtdm_gpio_chip *rgc,
 		return -EINVAL;
 
 	pin = rgc->pins + offset;
+	pin->timestamp = rtdm_clock_read_monotonic();
 	rtdm_event_signal(&pin->event);
 	
 	return 0;
-- 
2.17.2


