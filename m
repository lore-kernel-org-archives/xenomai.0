Subject: Re: [Patch] Allow selection of timestamp source for GPIO timestamps
References: <1202-610c0080-1db-1ab27320@266372836>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7c7d51d6-b118-4eba-6dff-59dec1f613b7@siemens.com>
Date: Fri, 6 Aug 2021 07:54:01 +0200
MIME-Version: 1.0
In-Reply-To: <1202-610c0080-1db-1ab27320@266372836>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>, xenomai@xenomai.org

Please tag the patch with the subsystem, in this case "drivers/gpio:".

On 05.08.21 17:15, François Legal via Xenomai wrote:
> This patch allows to select which time source (monotonic/realtime) is used to timestamp GPIO events.
> The time source used to be monotonic which is the opposite of what other drivers do. Now default changed to realtime, plus new API added to go back to monotonic.
> 
> 
> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
> ---
> 
> diff --git a/include/rtdm/uapi/gpio.h b/include/rtdm/uapi/gpio.h
> index 2839f7d51..f8a93b7f7 100644
> --- a/include/rtdm/uapi/gpio.h
> +++ b/include/rtdm/uapi/gpio.h
> @@ -30,6 +30,8 @@ struct rtdm_gpio_readout {
>  #define GPIO_RTIOC_REQS		_IO(RTDM_CLASS_GPIO, 4)
>  #define GPIO_RTIOC_RELS		_IO(RTDM_CLASS_GPIO, 5)
>  #define GPIO_RTIOC_TS		_IOR(RTDM_CLASS_GPIO, 7, int)
> +#define GPIO_RTIOC_TS_REAL  _IOR(RTDM_CLASS_GPIO, 8, int)
> +#define GPIO_RTIOC_TS_MONO  _IOR(RTDM_CLASS_GPIO, 9, int)

Only one of them needs to be a new define, the other can be an alias (or
GPIO_RTIOC_TS can be that).

>  
>  #define GPIO_TRIGGER_NONE		0x0 /* unspecified */
>  #define GPIO_TRIGGER_EDGE_RISING	0x1
> diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
> index bc283064b..3eaf425c6 100644
> --- a/kernel/drivers/gpio/gpio-core.c
> +++ b/kernel/drivers/gpio/gpio-core.c
> @@ -36,13 +36,15 @@ static LIST_HEAD(rtdm_gpio_chips);
>  
>  static DEFINE_MUTEX(chip_lock);
>  
> +static nanosecs_abs_t (*timestamp_get_func_ptr)(void) = rtdm_clock_read;
> +

This must be controlled per device instance, not globally for all GPIO
devices.

>  static int gpio_pin_interrupt(rtdm_irq_t *irqh)
>  {
>  	struct rtdm_gpio_pin *pin;
>  
>  	pin = rtdm_irq_get_arg(irqh, struct rtdm_gpio_pin);
>  
> -	pin->timestamp = rtdm_clock_read_monotonic();
> +	pin->timestamp = timestamp_get_func_ptr();
>  	rtdm_event_signal(&pin->event);
>  
>  	return RTDM_IRQ_HANDLED;
> @@ -192,9 +194,18 @@ static int gpio_pin_ioctl_nrt(struct rtdm_fd *fd,
>  		chan->requested = false;
>  		break;
>  	case GPIO_RTIOC_TS:
> +	case GPIO_RTIOC_TS_REAL:

This changes the default of GPIO_RTIOC_TS in way that does not allow to
back-port the patch to stable.

> +		ret = rtdm_safe_copy_from_user(fd, &val, arg, sizeof(val));
> +		if (ret)
> +			return ret;
> +		timestamp_get_func_ptr = rtdm_clock_read;
> +		chan->want_timestamp = !!val;
> +		break;
> +	case GPIO_RTIOC_TS_MONO:
>  		ret = rtdm_safe_copy_from_user(fd, &val, arg, sizeof(val));
>  		if (ret)
>  			return ret;
> +		timestamp_get_func_ptr = rtdm_clock_read_monotonic;
>  		chan->want_timestamp = !!val;
>  		break;
>  	default:
> 
> 

Thanks for the patch, but some bits still need tuning.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

