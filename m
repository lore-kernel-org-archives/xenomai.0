From: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Date: Mon, 23 Oct 2017 16:59:43 +0200
Message-Id: <20171023145944.11262-3-christoph.muellner@theobroma-systems.com>
In-Reply-To: <20171023145944.11262-1-christoph.muellner@theobroma-systems.com>
References: <20171023145944.11262-1-christoph.muellner@theobroma-systems.com>
Subject: [Xenomai] [PATCH 2/3] RTDM: uapi: Define ioctl code to set an IRQ
	affinity.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This patch adds an ioctl code to set a GPIO IRQ's CPU affinity
to the RTDM user space API.

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 include/rtdm/uapi/gpio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/rtdm/uapi/gpio.h b/include/rtdm/uapi/gpio.h
index f846f48b2..efd30fd28 100644
--- a/include/rtdm/uapi/gpio.h
+++ b/include/rtdm/uapi/gpio.h
@@ -22,6 +22,7 @@
 #define GPIO_RTIOC_DIR_IN		_IO(RTDM_CLASS_GPIO, 1)
 #define GPIO_RTIOC_IRQEN		_IOW(RTDM_CLASS_GPIO, 2, int) /* GPIO trigger */
 #define GPIO_RTIOC_IRQDIS		_IO(RTDM_CLASS_GPIO, 3)
+#define GPIO_RTIOC_IRQAFF		_IOW(RTDM_CLASS_GPIO, 4, int)
 
 #define GPIO_TRIGGER_NONE		0x0 /* unspecified */
 #define GPIO_TRIGGER_EDGE_RISING	0x1
-- 
2.11.0


