From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 18 Nov 2015 09:57:48 -0500
Message-ID: <20151118145748.GA21923@csclub.uwaterloo.ca>
References: <BLU436-SMTP14366D8D519BC2A3A82E3DBF01D0@phx.gbl>
 <20151117150222.GZ21923@csclub.uwaterloo.ca>
 <BLU436-SMTP2110EF3B4A3AE39C749468EF01C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLU436-SMTP2110EF3B4A3AE39C749468EF01C0@phx.gbl>
Subject: Re: [Xenomai] [PATCH] IPIPE patch for BCM2709/RPI2 (version #4)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On Tue, Nov 17, 2015 at 04:45:23PM -0800, Mathieu Rondonneau wrote:
> On 15-11-17 07:02 AM, Lennart Sorensen wrote:
> > On Mon, Nov 16, 2015 at 08:05:57PM -0800, Mathieu Rondonneau wrote:
> >> From fae80ca1c28b6a9e34f597fe63bfce768123337f Mon Sep 17 00:00:00 2001
> >> From: Mathieu Rondonneau <mathieu.rondonneau@gmail.com>
> >> Date: Mon, 16 Nov 2015 20:03:28 -0800
> >> Subject: [PATCH] IPIPE patch for BCM2709/RPI2.
> >>
> >>  - kernel: https://github.com/raspberrypi/linux (rpi-3.18.y)
> >>    - 1bb18c8f721ef674a447f3622273f2e2de7a205c
> >>  - xenomai: git://git.xenomai.org/xenomai-3.git (stable-3.0.x)
> >>    - cb72996a06ae4f29e403e3397324069f1983145e
> >> ---
> >>  arch/arm/Kconfig                                 |  2 +-
> >>  arch/arm/mach-bcm2709/armctrl.c                  |  4 ++++
> >>  arch/arm/mach-bcm2709/bcm2708_gpio.c             |  6 ++++--
> >>  arch/arm/mach-bcm2709/bcm2709.c                  |  9 +++++++++
> >>  arch/arm/mach-bcm2709/include/mach/entry-macro.S | 12 ++++++++++--
> >>  5 files changed, 28 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index 4860d5f..ed45f63 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -1058,7 +1058,7 @@ config IPIPE_ARM_KUSER_TSC
> >>         bool
> >>         select GENERIC_TIME_VSYSCALL
> >>         select IPIPE_HAVE_HOSTRT if IPIPE
> >> -       default y if ARCH_AT91 || ARM_TIMER_SP804 || ARCH_MXC ||
> >> ARCH_OMAP || PLAT_PXA || PLAT_S3C24XX || ARCH_SA1100
> >> +       default y if ARCH_AT91 || ARM_TIMER_SP804 || ARCH_MXC ||
> >> ARCH_OMAP || PLAT_PXA || PLAT_S3C24XX || ARCH_SA1100 || ARCH_BCM2709
> >>  endif
> >>
> >>  source "arch/arm/firmware/Kconfig"
> >> diff --git a/arch/arm/mach-bcm2709/armctrl.c
> >> b/arch/arm/mach-bcm2709/armctrl.c
> >> index fc6cb8b..c50b2cb 100644
> >> --- a/arch/arm/mach-bcm2709/armctrl.c
> >> +++ b/arch/arm/mach-bcm2709/armctrl.c
> >> @@ -333,6 +333,10 @@ static struct irq_chip armctrl_chip = {
> >>  	.irq_mask = armctrl_mask_irq,
> >>  	.irq_unmask = armctrl_unmask_irq,
> >>  	.irq_set_wake = armctrl_set_wake,
> >> +#ifdef CONFIG_IPIPE
> >> +	.irq_hold = armctrl_mask_irq,
> >> +	.irq_release = armctrl_unmask_irq,
> >> +#endif
> >>  };
> >>
> >>  /**
> >> diff --git a/arch/arm/mach-bcm2709/bcm2708_gpio.c
> >> b/arch/arm/mach-bcm2709/bcm2708_gpio.c
> >> index c1e9254..7852129 100644
> >> --- a/arch/arm/mach-bcm2709/bcm2708_gpio.c
> >> +++ b/arch/arm/mach-bcm2709/bcm2708_gpio.c
> >> @@ -24,6 +24,7 @@
> >>  #include <linux/pinctrl/consumer.h>
> >>
> >>  #include <linux/platform_data/bcm2708.h>
> >> +#include <linux/ipipe.h>
> >>
> >>  #define BCM_GPIO_DRIVER_NAME "bcm2708_gpio"
> >>  #define DRIVER_NAME BCM_GPIO_DRIVER_NAME
> >> @@ -56,7 +57,8 @@ enum { GPIO_FSEL_INPUT, GPIO_FSEL_OUTPUT,
> >>  	 * the GPIO code. This also makes the case of a GPIO routine call from
> >>  	 * the IRQ code simpler.
> >>  	 */
> >> -static DEFINE_SPINLOCK(lock);	/* GPIO registers */
> >> +static IPIPE_DEFINE_SPINLOCK(lock); /* GPIO registers */
> >> +
> >>
> >>  struct bcm2708_gpio {
> >>  	struct list_head list;
> >> @@ -294,7 +296,7 @@ static irqreturn_t bcm2708_gpio_interrupt(int irq,
> >> void *dev_id)
> >>  			if (!(level_bits & (1<<i)))
> >>  				writel(1<<i,
> >>  				       __io_address(GPIO_BASE) + GPIOEDS(bank));
> >> -			generic_handle_irq(gpio_to_irq(gpio));
> >> +			ipipe_handle_demuxed_irq(gpio_to_irq(gpio));
> >>  			/* ack level triggered IRQ after handling them */
> >>  			if (level_bits & (1<<i))
> >>  				writel(1<<i,
> >> diff --git a/arch/arm/mach-bcm2709/bcm2709.c
> >> b/arch/arm/mach-bcm2709/bcm2709.c
> >> index 6bfd99e..4dd796c 100644
> >> --- a/arch/arm/mach-bcm2709/bcm2709.c
> >> +++ b/arch/arm/mach-bcm2709/bcm2709.c
> >> @@ -1072,11 +1072,13 @@ static void __init bcm2709_timer_init(void)
> >>  static void __init bcm2709_timer_init(void)
> >>  {
> >>  	extern void dc4_arch_timer_init(void);
> >> +#ifndef CONFIG_IPIPE
> >>  	// timer control
> >>  	writel(0, __io_address(ARM_LOCAL_CONTROL));
> >>  	// timer pre_scaler
> >>  	writel(0x80000000, __io_address(ARM_LOCAL_PRESCALER)); // 19.2MHz
> >>  	//writel(0x06AAAAAB, __io_address(ARM_LOCAL_PRESCALER)); // 1MHz
> >> +#endif
> >>
> >>  	if (use_dt)
> >>  	{
> >> @@ -1085,6 +1087,13 @@ static void __init bcm2709_timer_init(void)
> >>  	}
> >>  	else
> >>  		dc4_arch_timer_init();
> >> +
> >> +#ifdef CONFIG_IPIPE
> >> +	// timer control
> >> +	writel(0, __io_address(ARM_LOCAL_CONTROL));
> >> +	// timer pre_scaler
> >> +	writel(0x80000000, __io_address(ARM_LOCAL_PRESCALER)); // 19.2MHz
> >> +#endif
> >>  }
> >>
> >>  #endif
> >> diff --git a/arch/arm/mach-bcm2709/include/mach/entry-macro.S
> >> b/arch/arm/mach-bcm2709/include/mach/entry-macro.S
> >> index 101d9f1..9e089c8 100644
> >> --- a/arch/arm/mach-bcm2709/include/mach/entry-macro.S
> >> +++ b/arch/arm/mach-bcm2709/include/mach/entry-macro.S
> >> @@ -52,7 +52,11 @@
> >>  	dsb
> >>  	mov	r1, sp
> >>  	adr	lr, BSYM(1b)
> >> -	b	do_IPI
> >> +#ifdef CONFIG_IPIPE
> >> +        b	__ipipe_grab_ipi
> >> +#else
> >> +        b	do_IPI
> >> +#endif
> >>
> >>  1030:
> >>  	/* check gpu interrupt */
> >> @@ -107,7 +111,11 @@
> >>  	@ routine called with r0 = irq number, r1 = struct pt_regs *
> >>  	@
> >>  	adr	lr, BSYM(1b)
> >> -	b	asm_do_IRQ
> >> +#ifdef CONFIG_IPIPE
> >> +        b	__ipipe_grab_irq
> >> +#else
> >> +        b	asm_do_IRQ
> >> +#endif
> > 
> > Wrong indentation.
> > 
> Good catch!
> will fix in next patch,
> Thanks for reviewing,

No problem.  It just jumped out at me for looking wrong on the screen.

Surprisingly short patch for adding support for a new CPU.  I guess a
lot of ARM designs being pretty generic helps.

-- 
Len Sorensen

