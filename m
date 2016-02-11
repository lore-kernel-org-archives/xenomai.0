MIME-Version: 1.0
In-Reply-To: <BLU436-SMTP19224EA9D306E8D8D6C553F01C0@phx.gbl>
References: <BLU436-SMTP19224EA9D306E8D8D6C553F01C0@phx.gbl>
From: Nicolas SCHURANDO <schurann@ext.essilor.com>
Date: Thu, 11 Feb 2016 18:03:09 +0100
Message-ID: <CA+CJOCxZe=0mBNaREuoi2K=48mOae+=sME-Cix+pO6NgDPOAQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] [PATCH] IPIPE patch for BCM2709/RPI2 (version #5)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi guys,

So I have been playing around with the Raspberry Pi 2 for a couple of days
now. And I keep noticing that at random times, but usually in a matter of
seconds / minutes when there is a couple of hundreds of ko/s ethernet
traffic, the device will freeze entirely.

I have tried a few things, and : cp-ing from a cifs mount or wget-ing from
a http server, from the console right after boot will do it. Apparently,
cp-ing a local file from and to the sd card doesn't seem to speed up the
freeze. This only happens when the Xenomai kernel is loaded, but without
explicitly using any of the Xenomai features.

I was thinking maybe this could be interrupt-related ? I have to admit my
knowledge is very limited here ..

Below are the versions I am currently using :
 - Raspberry Pi 3.18 kernel @ 1bb18c8
 - Xenomai 3.0 @ 4808e75
 - Post patch #5 by Mathieu
 - Raspbian Jessie rootfs 2016-02-09

Regards,

Nicolas

2015-11-18 2:01 GMT+01:00 Mathieu Rondonneau <mathieu_rondonneau@hotmail.com
>:

> From 6601af599128127850176e304cc76e5b15fab4a8 Mon Sep 17 00:00:00 2001
> From: Mathieu Rondonneau <mathieu.rondonneau@gmail.com>
> Date: Tue, 17 Nov 2015 16:55:04 -0800
> Subject: [PATCH] IPIPE patch for BCM2709/RPI2.
>
>  - kernel: https://github.com/raspberrypi/linux (rpi-3.18.y)
>    - 1bb18c8f721ef674a447f3622273f2e2de7a205c
>  - xenomai: git://git.xenomai.org/xenomai-3.git (stable-3.0.x)
>    - 5c88a11c11e9a2b13be4da91624dc3f3ff323e46
> ---
>  arch/arm/Kconfig                                 | 1 +
>  arch/arm/mach-bcm2709/armctrl.c                  | 4 ++++
>  arch/arm/mach-bcm2709/bcm2708_gpio.c             | 6 ++++--
>  arch/arm/mach-bcm2709/bcm2709.c                  | 9 +++++++++
>  arch/arm/mach-bcm2709/include/mach/entry-macro.S | 8 ++++++++
>  5 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 4860d5f..1194e5d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -829,6 +829,7 @@ config ARCH_BCM2709
>         select VC4
>         select FIQ
>  #      select ZONE_DMA
> +       select IPIPE_ARM_KUSER_TSC if IPIPE
>         help
>           This enables support for Broadcom BCM2709 boards.
>
> diff --git a/arch/arm/mach-bcm2709/armctrl.c
> b/arch/arm/mach-bcm2709/armctrl.c
> index fc6cb8b..c50b2cb 100644
> --- a/arch/arm/mach-bcm2709/armctrl.c
> +++ b/arch/arm/mach-bcm2709/armctrl.c
> @@ -333,6 +333,10 @@ static struct irq_chip armctrl_chip = {
>         .irq_mask = armctrl_mask_irq,
>         .irq_unmask = armctrl_unmask_irq,
>         .irq_set_wake = armctrl_set_wake,
> +#ifdef CONFIG_IPIPE
> +       .irq_hold = armctrl_mask_irq,
> +       .irq_release = armctrl_unmask_irq,
> +#endif
>  };
>
>  /**
> diff --git a/arch/arm/mach-bcm2709/bcm2708_gpio.c
> b/arch/arm/mach-bcm2709/bcm2708_gpio.c
> index c1e9254..7852129 100644
> --- a/arch/arm/mach-bcm2709/bcm2708_gpio.c
> +++ b/arch/arm/mach-bcm2709/bcm2708_gpio.c
> @@ -24,6 +24,7 @@
>  #include <linux/pinctrl/consumer.h>
>
>  #include <linux/platform_data/bcm2708.h>
> +#include <linux/ipipe.h>
>
>  #define BCM_GPIO_DRIVER_NAME "bcm2708_gpio"
>  #define DRIVER_NAME BCM_GPIO_DRIVER_NAME
> @@ -56,7 +57,8 @@ enum { GPIO_FSEL_INPUT, GPIO_FSEL_OUTPUT,
>          * the GPIO code. This also makes the case of a GPIO routine call
> from
>          * the IRQ code simpler.
>          */
> -static DEFINE_SPINLOCK(lock);  /* GPIO registers */
> +static IPIPE_DEFINE_SPINLOCK(lock); /* GPIO registers */
> +
>
>  struct bcm2708_gpio {
>         struct list_head list;
> @@ -294,7 +296,7 @@ static irqreturn_t bcm2708_gpio_interrupt(int irq,
> void *dev_id)
>                         if (!(level_bits & (1<<i)))
>                                 writel(1<<i,
>                                        __io_address(GPIO_BASE) +
> GPIOEDS(bank));
> -                       generic_handle_irq(gpio_to_irq(gpio));
> +                       ipipe_handle_demuxed_irq(gpio_to_irq(gpio));
>                         /* ack level triggered IRQ after handling them */
>                         if (level_bits & (1<<i))
>                                 writel(1<<i,
> diff --git a/arch/arm/mach-bcm2709/bcm2709.c
> b/arch/arm/mach-bcm2709/bcm2709.c
> index 6bfd99e..4dd796c 100644
> --- a/arch/arm/mach-bcm2709/bcm2709.c
> +++ b/arch/arm/mach-bcm2709/bcm2709.c
> @@ -1072,11 +1072,13 @@ static void __init bcm2709_timer_init(void)
>  static void __init bcm2709_timer_init(void)
>  {
>         extern void dc4_arch_timer_init(void);
> +#ifndef CONFIG_IPIPE
>         // timer control
>         writel(0, __io_address(ARM_LOCAL_CONTROL));
>         // timer pre_scaler
>         writel(0x80000000, __io_address(ARM_LOCAL_PRESCALER)); // 19.2MHz
>         //writel(0x06AAAAAB, __io_address(ARM_LOCAL_PRESCALER)); // 1MHz
> +#endif
>
>         if (use_dt)
>         {
> @@ -1085,6 +1087,13 @@ static void __init bcm2709_timer_init(void)
>         }
>         else
>                 dc4_arch_timer_init();
> +
> +#ifdef CONFIG_IPIPE
> +       // timer control
> +       writel(0, __io_address(ARM_LOCAL_CONTROL));
> +       // timer pre_scaler
> +       writel(0x80000000, __io_address(ARM_LOCAL_PRESCALER)); // 19.2MHz
> +#endif
>  }
>
>  #endif
> diff --git a/arch/arm/mach-bcm2709/include/mach/entry-macro.S
> b/arch/arm/mach-bcm2709/include/mach/entry-macro.S
> index 101d9f1..5cecbc0 100644
> --- a/arch/arm/mach-bcm2709/include/mach/entry-macro.S
> +++ b/arch/arm/mach-bcm2709/include/mach/entry-macro.S
> @@ -52,7 +52,11 @@
>         dsb
>         mov     r1, sp
>         adr     lr, BSYM(1b)
> +#ifdef CONFIG_IPIPE
> +       b       __ipipe_grab_ipi
> +#else
>         b       do_IPI
> +#endif
>
>  1030:
>         /* check gpu interrupt */
> @@ -107,7 +111,11 @@
>         @ routine called with r0 = irq number, r1 = struct pt_regs *
>         @
>         adr     lr, BSYM(1b)
> +#ifdef CONFIG_IPIPE
> +       b       __ipipe_grab_irq
> +#else
>         b       asm_do_IRQ
> +#endif
>
>  1020:  @ EQ will be set if no irqs pending
>         .endm
> --
> 2.6.3
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://xenomai.org/mailman/listinfo/xenomai
>
