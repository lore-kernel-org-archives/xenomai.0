Message-ID: <49799B02.1010202@domain.hid>
Date: Fri, 23 Jan 2009 11:25:06 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4979727E.6060304@domain.hid>
In-Reply-To: <4979727E.6060304@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] PowerPC irq unmask
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: federico.ridolfo@domain.hid
Cc: xenomai@xenomai.org

Federico Ridolfo wrote:
> Hi all,
> my platform is a mpc5200b based one. I wrote
> some rtdm driver for that platform on linux-2.6.18
> kernel. Some info:
> - ARCH=ppc
> - no fdt (so no dts)
> - u-boot
> - xenomai 2.3.2,
> - adeos-ipipe-2.6.18-ppc-1.5-01.patch
> All works fine.
> 
> Now i want to use:
> - ARCH = powerpc
> - linux kernel from denx: ipipe-2.6-26-powerpc-2.4-03
> - fdt (so i have a dts file)
> - xenomai-2.4.6.1
> - u-boot
> Ok. My board boots, all peripheral s work. Xenomai works, but
> my rtdm drivers don't work. The problem is that the rtdm_irq_request
> returns -ENODEV coming from line 166 in wrappers.h:
> ...
> #else /* > 2.6.19 */
> #define rthal_irq_chip_enable(irq)                    \
>     ({                                \
>         int __err__ = 0;                    \
>         if (unlikely(rthal_irq_handlerp(irq)->unmask == NULL))    \
>             __err__ = -ENODEV;     \
>         else                            \
>             rthal_irq_handlerp(irq)->unmask(irq);        \
>         __err__;                        \
>     })
> ...
> Seems that adeos doesn't not set the unmask function. In the linux kernel
> the right functions for my pic in in
> arch/powerpc/platforms/52xx/mpc52xx_pic.c
> I thing i have to add some code in mpc52xx_pic.c in order to match
> device tree table

To complete my previous answer: unless you have a very particular hw design, it
is unlikely that the PIC code is missing anything to support your board.

> and also something in my dts file.

However, a too generic device tree description may not reflect all the
peripherals you have on your board, so yes, updating it may be needed so that
the platform code maps the hw interrupt sources you want.

I suspect you will have no regular drivers on these IRQs, so /proc/interrupts
should not list them.

The point is: are those interrupts sources known from the kernel? Enabling the
debug switch in arch/powerpc/kernel/irq.c should give you some hints about which
hw IRQ sources are actually enumerated then mapped on your board (remember to
increase the console_loglevel or set ignore_loglevel to get this ouput). If you
don't find those you need, then you will likely want to fix the dts file.

 Any help is very usefull!!!
> Thanks
> 
> 
> --
> chicco
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

