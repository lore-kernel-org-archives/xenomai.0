Message-ID: <49E74B8A.2090909@domain.hid>
Date: Thu, 16 Apr 2009 17:15:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <37f89760904160447j7399b4ctced93a3e4956db6a@domain.hid>	<49E72BA8.20203@domain.hid>	<37f89760904160654g43fde4f0l6cd228faa65d6baf@domain.hid>	<49E73DE7.9020307@domain.hid>
	<37f89760904160755y2e056c3cq1b86d3adf2160b0b@domain.hid>
In-Reply-To: <37f89760904160755y2e056c3cq1b86d3adf2160b0b@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] driver: IOCTL command behavior
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marcel Soulot <msoulot@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Marcel Soulot wrote:
> Hi,
> here is the my ioctl function and the header file below.
> 
> 
> /*****************************************************************************************/
> int rt_gpio_ioctl(struct rtdm_dev_context *context,
>                   rtdm_user_info_t *user_info,
>                   unsigned int request, void *arg)
> {
>     struct rt_gpio_context *ctx_gpio;
>     int err = 0;
>     unsigned long base;
>     int mode;
> 
>     ctx_gpio = (struct rt_gpio_context *)context->dev_private;
>     base = ctx_gpio->base_addr;
>     mode = rt_gpio_io_mode_from_ctx_gpio(ctx_gpio);
> 
>     printk(KERN_INFO "IOCTL : request %x\n", request);
>     switch (request)
>     {
>     case RT_GPIO_RTIOC_GET_DIRECTION:
>         {
>             /*
>             ** 1 = input and 0 = output, by default all are inputs.
>             */
>             int gpio_dir;
> 
>             gpio_dir = rt_gpio_reg_in(mode, base, OFF_MPIOSEL);
>             printk(KERN_INFO "GET_DIRECTION %x\n", gpio_dir);
> 
>             if (user_info)
>             {
>                 err = rtdm_safe_copy_to_user(user_info, arg,
>                                              &gpio_dir, sizeof(int));
>             }
>             else
>             {
>                 *(int *)arg = gpio_dir;
>             }
> 
>             break;
>         }
> 
>     case RT_GPIO_RTIOC_SET_DIRECTION:
>         {
>             /*
>             ** 1 = input and 0 = output, by default all are inputs.
>             */
>             unsigned int gpio_dir = (unsigned int)arg;
> 
>             rt_gpio_reg_out(mode, base, OFF_MPIOSEL, gpio_dir);
>             printk(KERN_INFO "SET_DIRECTION %x\n", gpio_dir);
> 
>             break;
>         }
> 
>     default:
>         err = -ENOTTY;
>     }
> 
>     return err;
> }
> 
> 
> /**************************************************************************************************/
> header file
> /**************************************************************************************************/
> 
> #ifndef _RTGPIO_H
> #define _RTGPIO_H
> 
> #include <rtdm/rtdm.h>
> 
> #define RT_GPIO_PROFILE_VER        2
> 
> #define RTIOC_TYPE_GPIO                 RTDM_CLASS_GPIO
> #define RTDM_SUBCLASS_GPIO              0
> 
> #define RT_GPIO_RTIOC_GET_DIRECTION\
>     _IOR(RTIOC_TYPE_GPIO, 0x00, int)
> 
> #define RT_GPIO_RTIOC_SET_DIRECTION\
>     _IOR(RTIOC_TYPE_GPIO, 0x01, int)
> 
> #endif /* _RTGPIO_H */
> 
> /**************************************************************************************************/
> 
> So for the "RT_GPIO_RTIOC_SET_DIRECTION"  when I switch "_IOR(RTIOC_TYPE_GPIO,
> 0x01, int)" to "_IOW(RTIOC_TYPE_GPIO, 0x01, int)" or "_IOWR(RTIOC_TYPE_GPIO,
> 0x01, int)", the switch pass in "default".
> 
> Someone as an explanation ?

Did you cleanly rebuild both kernel and user space after fiddling with
_IO*? The numerical value of RT_GPIO_RTIOC_SET_DIRECTION changes each time.

BTW, _IO* are conventions between driver and user, nothing is checked or
enforced elsewhere.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

