From: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Date: Mon, 23 Oct 2017 16:59:44 +0200
Message-Id: <20171023145944.11262-4-christoph.muellner@theobroma-systems.com>
In-Reply-To: <20171023145944.11262-1-christoph.muellner@theobroma-systems.com>
References: <20171023145944.11262-1-christoph.muellner@theobroma-systems.com>
Subject: [Xenomai] [PATCH 3/3] kernel: rtdm: gpio: Add support for
	GPIO_RTIOC_IRQAFF.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

To set a GPIO interrupt's CPU affinity, we simply call
rtdm_irq_affinity() with a proper bitmask.

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 kernel/drivers/gpio/gpio-core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index 55594f6ae..84153a937 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -118,6 +118,23 @@ static void release_gpio_irq(unsigned int gpio, struct rtdm_gpio_pin *pin,
 	chan->requested = false;
 }
 
+static int set_gpio_irq_affinity(struct rtdm_gpio_pin *pin, int val)
+{
+	cpumask_t tgt;
+	unsigned int i = 0;
+
+	cpumask_clear(&tgt);
+
+	while (val) {
+		if (val & (1 << i))
+			cpumask_set_cpu(i, &tgt);
+		val &= ~(1 << i);
+		i++;
+	}
+
+	return rtdm_irq_affinity(&pin->irqh, tgt);
+}
+
 static int gpio_pin_ioctl_nrt(struct rtdm_fd *fd,
 			      unsigned int request, void *arg)
 {
@@ -158,6 +175,14 @@ static int gpio_pin_ioctl_nrt(struct rtdm_fd *fd,
 		release_gpio_irq(gpio, pin, chan);
 		chan->requested = false;
 		break;
+	case GPIO_RTIOC_IRQAFF:
+		if (!chan->requested)
+			return -EINVAL;
+		ret = rtdm_safe_copy_from_user(fd, &val, arg, sizeof(val));
+		if (ret)
+			return ret;
+		ret = set_gpio_irq_affinity(pin, val);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.11.0


