From: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Date: Mon,  6 Nov 2017 10:46:46 +0100
Message-Id: <20171106094646.28769-4-christoph.muellner@theobroma-systems.com>
In-Reply-To: <20171106094646.28769-1-christoph.muellner@theobroma-systems.com>
References: <20171106094646.28769-1-christoph.muellner@theobroma-systems.com>
Subject: [Xenomai] [PATCH v2 3/3] kernel: rtdm: gpio: Add support for
	GPIO_RTIOC_IRQAFF.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, rpm@xenomai.org

To set a GPIO interrupt's CPU affinity, we simply call
rtdm_irq_affinity() with a proper bitmask.

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 kernel/drivers/gpio/gpio-core.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index 55594f6ae..3d11ef1bf 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -118,6 +118,31 @@ static void release_gpio_irq(unsigned int gpio, struct rtdm_gpio_pin *pin,
 	chan->requested = false;
 }
 
+static int set_irq_affinity(struct rtdm_fd *fd, struct rtdm_gpio_pin *pin, rtdm_cpumask_t *user_mask)
+{
+	int ret;
+	size_t size;
+	cpumask_t cpumask;
+	rtdm_cpumask_t mask;
+
+	ret = rtdm_safe_copy_from_user(fd, &mask, user_mask, sizeof(mask));
+	if (ret)
+		return ret;
+
+	cpumask_clear(&cpumask);
+
+	if (cpumask_size() < mask.size)
+		size = cpumask_size();
+	else
+		size = mask.size;
+
+	ret = rtdm_safe_copy_from_user(fd, &cpumask, mask.mask, size);
+	if (ret)
+		return ret;
+
+	return rtdm_irq_affinity(&pin->irqh, cpumask);
+}
+
 static int gpio_pin_ioctl_nrt(struct rtdm_fd *fd,
 			      unsigned int request, void *arg)
 {
@@ -158,6 +183,11 @@ static int gpio_pin_ioctl_nrt(struct rtdm_fd *fd,
 		release_gpio_irq(gpio, pin, chan);
 		chan->requested = false;
 		break;
+	case GPIO_RTIOC_IRQAFF:
+		if (!chan->requested)
+			return -EINVAL;
+		ret = set_irq_affinity(fd, pin, arg);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.11.0


