References: <20171023145944.11262-1-christoph.muellner@theobroma-systems.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5cefd502-8f58-6da1-08ee-d43283428d7a@xenomai.org>
Date: Sun, 29 Oct 2017 18:23:25 +0100
MIME-Version: 1.0
In-Reply-To: <20171023145944.11262-1-christoph.muellner@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 0/3] RTDM GPIO: Add API to set IRQ's CPU
 affinity.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Christoph Muellner <christoph.muellner@theobroma-systems.com>, xenomai@xenomai.org

On 10/23/2017 04:59 PM, Christoph Muellner wrote:
> This patch series adds an API to the RTDM GPIO layer to set a GPIO interrupt's
> CPU affinity to Xenomai's next branch.
> 
> A Xenomai application can use this API with a code similar to this:
> 
>         int mask = 1 << 4; //CPU4 only

cpu_set_t would be required here. We may have more than 32 CPU cores
only using a portion of them for rt duties.

>         ret = ioctl(gpio_in_fd, GPIO_RTIOC_IRQAFF, &mask);
>         if (ret) {
>                 fprintf(stderr, "Failed to set interrupt's CPU affinity.\n");
>                 return -1;
>         }
> 
> Of course this only works, if the underlying GPIO driver supports setting
> the IRQ affinity. I.e. the irq_set_affinity function needs to be set in the
> struct irq_chip.
> 
> Tested on a RK3399 (arm64).
> 
> Christoph Muellner (3):
>   cobalt: rtdm: Add function rtdm_irq_affinity().
>   RTDM: uapi: Define ioctl code to set an IRQ affinity.
>   kernel: rtdm: gpio: Add support for GPIO_RTIOC_IRQAFF.
> 
>  include/cobalt/kernel/rtdm/driver.h |  6 ++++++
>  include/rtdm/uapi/gpio.h            |  1 +
>  kernel/drivers/gpio/gpio-core.c     | 25 +++++++++++++++++++++++++
>  3 files changed, 32 insertions(+)
> 


-- 
Philippe.

