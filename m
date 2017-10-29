References: <20171023145944.11262-1-christoph.muellner@theobroma-systems.com>
 <20171023145944.11262-4-christoph.muellner@theobroma-systems.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d8476ff1-e996-b233-7922-90830aa08657@xenomai.org>
Date: Sun, 29 Oct 2017 18:36:55 +0100
MIME-Version: 1.0
In-Reply-To: <20171023145944.11262-4-christoph.muellner@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 3/3] kernel: rtdm: gpio: Add support for
 GPIO_RTIOC_IRQAFF.
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
> To set a GPIO interrupt's CPU affinity, we simply call
> rtdm_irq_affinity() with a proper bitmask.
> 
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> ---
>  kernel/drivers/gpio/gpio-core.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
> index 55594f6ae..84153a937 100644
> --- a/kernel/drivers/gpio/gpio-core.c
> +++ b/kernel/drivers/gpio/gpio-core.c
> @@ -118,6 +118,23 @@ static void release_gpio_irq(unsigned int gpio, struct rtdm_gpio_pin *pin,
>  	chan->requested = false;
>  }
>  
> +static int set_gpio_irq_affinity(struct rtdm_gpio_pin *pin, int val)
> +{
> +	cpumask_t tgt;
> +	unsigned int i = 0;
> +
> +	cpumask_clear(&tgt);
> +
> +	while (val) {
> +		if (val & (1 << i))
> +			cpumask_set_cpu(i, &tgt);
> +		val &= ~(1 << i);
> +		i++;
> +	}
> +
> +	return rtdm_irq_affinity(&pin->irqh, tgt);
> +}
> +

Reflecting the change from int -> cpu_set_t in the ABI, we could have
something along these lines instead:

static int set_gpio_irq_affinity(struct rtdm_gpio_pin *pin, unsigned
long __user *u_set, size_t setsize)
{
	cpumask_var_t mask;
	int ret;

	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
		return -ENOMEM;

	ret = get_user_cpu_mask(u_set, setsize, mask);
	if (ret == 0)
		ret = do_set_gpio_affinity(pin, mask);

	free_cpumask_var(mask);

	...
-- 
Philippe.

