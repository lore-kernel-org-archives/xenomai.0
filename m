MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18044.7995.598709.244609@domain.hid>
Date: Fri, 22 Jun 2007 21:12:59 +0200
In-Reply-To: <1182504330.467b958af1b87@domain.hid>
References: <1182504330.467b958af1b87@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Adeos-main] mach-imx support
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: garryt <garryt@domain.hid>
Cc: adeos-main@gna.org

garryt wrote:
 > Hello,
 > 
 > Please find attached an attempt of mach-imx board support. I have been able to
 > test it with xenomai and could make other tests if needed. Does someone else use
 > this kind of board ? Could any of the mailing list gurus have a quick look and
 > tell if there is something missing /nok ?

Comments follow within the patch.

 > 
 > This have been made with the support of the "Adapting ARM I-pipe patch to a new
 > board." document on the xenomai site, and the already available pxa support.
 > BTW the __ipipe_mach_get_tscinfo is missing in this doc.

Yes, I know, I will add this.

 > 
 > kernel used 2.6.20-12, adeos patch 1.7-03

> diff -aburN ./linux-2.6.20.12-imx1/arch/arm/mach-imx/imx_irq.h ./linux-2.6.20.12-ipipe/arch/arm/mach-imx/imx_irq.h
> --- ./linux-2.6.20.12-imx1/arch/arm/mach-imx/imx_irq.h	1970-01-01 01:00:00.000000000 +0100
> +++ ./linux-2.6.20.12-ipipe/arch/arm/mach-imx/imx_irq.h	2007-06-13 12:00:44.000000000 +0200
> @@ -0,0 +1,80 @@
> +/* 
> + *  linux/arch/arm/mach-imx/imx_irq.h
> + * 
> + * Author: garryt@domain.hid 
> + * Still exprimental
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <asm/arch/irqs.h> 
> +
> +void __init imx_init_priority(void);
> +
> +static unsigned int imx_default_irq_priority[IMX_IRQS] __initdata = {
> (snip)
> +	}; 
> diff -aburN ./linux-2.6.20.12-imx1/arch/arm/mach-imx/irq.c ./linux-2.6.20.12-ipipe/arch/arm/mach-imx/irq.c
> --- ./linux-2.6.20.12-imx1/arch/arm/mach-imx/irq.c	2007-06-22 09:54:30.000000000 +0200
> +++ ./linux-2.6.20.12-ipipe/arch/arm/mach-imx/irq.c	2007-06-22 09:51:38.000000000 +0200
> @@ -26,12 +26,19 @@
>  #include <linux/init.h>
>  #include <linux/list.h>
>  #include <linux/timer.h>
> +#include <linux/ipipe.h>
>  
>  #include <asm/hardware.h>
>  #include <asm/irq.h>
>  #include <asm/io.h>
>  
>  #include <asm/mach/irq.h>
> +#include <asm/arch/imx-regs.h>
> +
> +/* Used for IMX INTERRUPT priority: Still Experimental */ 
> +#ifdef CONFIG_IPIPE 
> +#include "imx_irq.h" 
> +#endif 

Here, I would put imx_default_irq_priority definition directly in irq.c,
since it is used only here, there is no reason to put it in a
header. Besides, imx_irq.h is not a good name, there is already an
include/asm-arm/mach-imx/irqs.h, what is the difference ?

> (...)
> -	.set_type = imx_irq_type,
> +	.set_type = imx_internal_irq_type,

What is the use of this renaming ?

>  };
>  
>  static struct irq_chip imx_gpio_chip = {
> @@ -222,6 +229,25 @@
>  	.set_type = imx_gpio_irq_type,
>  };
>  
> +#ifdef CONFIG_IPIPE 
> +void __init imx_init_priority(void)
> +{
> +        unsigned int irq; 
> +        IMX_PRIO0=0;   
> +        IMX_PRIO1=0;     
> +        IMX_PRIO2=0;
> +        IMX_PRIO3=0;   
> +        IMX_PRIO4=0;     
> +        IMX_PRIO5=0;  
> +        IMX_PRIO6=0;    
> +        IMX_PRIO7=0; 
> +        printk(KERN_INFO "Initializing imx interrupt priorities\n");
> +        for (irq = 0; irq < IMX_IRQS; irq++) {
> +        IMX_PRIO(irq)|=((imx_default_irq_priority[irq]&15)<<((irq%8)*4));
> +        }             

Coding style here. You do not need braces, and the indentation is
wrong.

> (...)
> +
> +#ifdef CONFIG_IPIPE
> +        imx_timer_initialized = 1;          
> +	tsc = (union tsc_reg *) __ipipe_tsc_area;
> +        barrier();                 

The aim of the barrier is to ensure that the "tsc" variable is
initialized before imx_timer_initialized is set to 1, so that
ipipe_mach_get_tsc will not dereference an uninitialized pointer.

Besides, tsc emulation in user-space can not work in the CONFIG_SMP
case, so this should be:

#ifdef CONFIG_SMP
       tsc = (union tsc_reg *) __ipipe_tsc_area;
       barrier();                 
#endif
       imx_timer_initialized = 1;          

> (...)
> +void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
> +{
> +        info->type = IPIPE_TSC_TYPE_FREERUNNING;
> +        info->u.fr.counter = (unsigned *) (0x10+IMX_TIM1_BASE);  
> +        info->u.fr.mask = 0xffffffff;
> +        info->u.fr.tsc = &tsc->full;
> +}

There should be some #ifdef CONFIG_SMP here too.

> (...)
> +#ifdef CONFIG_IPIPE
> +#define __ipipe_mach_irq_mux_p(irq) (((irq) == GPIO_INT_PORTA ) || ((irq) == GPIO_INT_PORTB  ) || ((irq) == GPIO_INT_PORTC ) || ((irq) == GPIO_INT_PORTD) ) 
> +#endif /* CONFIG_IPIPE */         

This test should be as fast as possible, so you should test a bit in a
mask, the way s3c2410 does it. Something like:

#define __ipipe_irqbit(irq) (1ULL << (irq))

#define __ipipe_muxed_irqmask (__ipipe_irqbit(GPIO_INT_PORTA) | \
                               __ipipe_irqbit(GPIO_INT_PORTB) | \
                               __ipipe_irqbit(GPIO_INT_PORTC) | \
                               __ipipe_irqbit(GPIO_INT_PORTD))

#define __ipipe_mach_irq_mux_p(irq) (__ipipe_irqbit(irq) \
                                     & __ipipe_muxed_irqmask)

-- 


					    Gilles Chanteperdrix.

