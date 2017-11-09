References: <20171106094646.28769-1-christoph.muellner@theobroma-systems.com>
 <20171106094646.28769-3-christoph.muellner@theobroma-systems.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <813c4cb9-86e3-d13d-a52e-c13a9cd0380c@xenomai.org>
Date: Thu, 9 Nov 2017 11:04:41 +0100
MIME-Version: 1.0
In-Reply-To: <20171106094646.28769-3-christoph.muellner@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v2 2/3] RTDM: uapi: Define ioctl code to set
 an IRQ affinity.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Christoph Muellner <christoph.muellner@theobroma-systems.com>, xenomai@xenomai.org

On 11/06/2017 10:46 AM, Christoph Muellner wrote:
> This patch adds an ioctl code to set a GPIO IRQ's CPU affinity
> to the RTDM user space API.
> 
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> ---
>  include/rtdm/uapi/gpio.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/rtdm/uapi/gpio.h b/include/rtdm/uapi/gpio.h
> index f846f48b2..e70da2621 100644
> --- a/include/rtdm/uapi/gpio.h
> +++ b/include/rtdm/uapi/gpio.h
> @@ -18,10 +18,16 @@
>  #ifndef _RTDM_UAPI_GPIO_H
>  #define _RTDM_UAPI_GPIO_H
>  
> +typedef struct {
> +	void* mask;

Asking explicitly for unsigned long * may give a better hint about what
is expected.

> +	size_t size;
> +} rtdm_cpumask_t;
> +
>  #define GPIO_RTIOC_DIR_OUT		_IOW(RTDM_CLASS_GPIO, 0, int)
>  #define GPIO_RTIOC_DIR_IN		_IO(RTDM_CLASS_GPIO, 1)
>  #define GPIO_RTIOC_IRQEN		_IOW(RTDM_CLASS_GPIO, 2, int) /* GPIO trigger */
>  #define GPIO_RTIOC_IRQDIS		_IO(RTDM_CLASS_GPIO, 3)
> +#define GPIO_RTIOC_IRQAFF		_IOW(RTDM_CLASS_GPIO, 4, rtdm_cpumask_t*)
>  
>  #define GPIO_TRIGGER_NONE		0x0 /* unspecified */
>  #define GPIO_TRIGGER_EDGE_RISING	0x1
> 


-- 
Philippe.

