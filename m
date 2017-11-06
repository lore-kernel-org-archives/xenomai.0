From: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Date: Mon,  6 Nov 2017 10:46:43 +0100
Message-Id: <20171106094646.28769-1-christoph.muellner@theobroma-systems.com>
Subject: [Xenomai] [PATCH v2 0/3] RTDM GPIO: Add API to set IRQ's CPU
	affinity.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, rpm@xenomai.org

This patch series adds an API to the RTDM GPIO layer to set a GPIO interrupt's
CPU affinity to Xenomai's next branch.

A Xenomai application can use this API with a code similar to this:

        cpu_set_t mask;
        CPU_ZERO(&mask);
        CPU_SET(4, &mask); //CPU 4 only

	rtdm_cpumask_t rtdm_mask;
	rtdm_mask.mask = &mask;
	rtdm_mask.size = sizeof(mask);

        ret = ioctl(fd, GPIO_RTIOC_IRQAFF, &rtdm_mask);
        if (ret) {
                fprintf(stderr, "Failed to set interrupt affinity.\n");
                return -1;
        }

Of course this only works, if the underlying GPIO driver supports setting
the IRQ affinity. I.e. the irq_set_affinity function needs to be set in the
struct irq_chip.

Changes to v1:

 * Adding new type rtdm_cpumask_t for passing CPU bitmasks
 * Changed affinity bitmask type from int to new rtdm_cpumask_t*
 * Added documentation of function rtdm_irq_affinity()

Tested on a RK3399 (arm64).

Christoph Muellner (3):
  cobalt: rtdm: Add function rtdm_irq_affinity().
  RTDM: uapi: Define ioctl code to set an IRQ affinity.
  kernel: rtdm: gpio: Add support for GPIO_RTIOC_IRQAFF.

 include/cobalt/kernel/rtdm/driver.h |  6 ++++++
 include/rtdm/uapi/gpio.h            |  6 ++++++
 kernel/cobalt/rtdm/drvlib.c         | 18 ++++++++++++++++++
 kernel/drivers/gpio/gpio-core.c     | 30 ++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+)

-- 
2.11.0


