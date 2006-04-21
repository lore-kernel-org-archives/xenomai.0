Message-ID: <4448FDD7.2060708@domain.hid>
Date: Fri, 21 Apr 2006 17:44:23 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai on Freescale i.MX21 (ARM926J)
References: <FDBBB5CC70676540B3EF7CFE83FD94E0043151@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0043151@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org


Hi Daniel,

Some comments about the Adeos patch for the i.MX21/CSB535FS board. The inlined patch
has been rebuilt by diff'ing the vanilla Adeos 1.2-00 support with yours.

 > --- linux-2.6.14/arch/arm/kernel/ipipe-core.c	2006-04-21 16:17:02.000000000 +0200
 > +++ linux-2.6.14-heig/arch/arm/kernel/ipipe-core.c	2006-04-21 15:33:47.000000000 +0200
 > @@ -22,6 +22,12 @@
 >   * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 >   *
 >   * Architecture-dependent I-PIPE core support for ARM.
 > + *
 > + * April 2006 :
 > + * Adapted to ARM9 i.MX21/CSB535FS board with Xenomai by S.Gerber, G.Boutillier and D.Rossier
 > + * University of Applied Sciences Western Switzerland
 > + * Reconfigurable & Embedded Digital Systems, REDS Institute
 > + *
 >   */
 >
 >  #include <linux/config.h>
 > @@ -320,11 +326,19 @@ static void __ipipe_set_decr(void)
 >  int ipipe_tune_timer(unsigned long ns, int flags)
 >  {
 >  	unsigned long x, ticks;
 > +	unsigned long us;
 >
 >  	if (flags & IPIPE_RESET_TIMER)
 >  		ticks = __ipipe_mach_ticks_per_jiffy;
 >  	else {
 > -		ticks = ns * __ipipe_mach_ticks_per_jiffy / (1000000000 / HZ);
 > +		
 > +		/*
 > +		 * FIXME : Temporary convert ns to us. With nanosecondes we have a problem
 > +                 *         with overflow.
 > +		 *         ticks = ns * __ipipe_mach_ticks_per_jiffy / (1000000000 / HZ);
 > +		 */
 > +		us = ns / 1000;
 > +		ticks = ((us * __ipipe_mach_ticks_per_jiffy) / 10000);
 >

This change is going to be wrong when CONFIG_HZ != 1000,
this is why HZ should remain in the picture. This said, the original expression looks
overly complicated, something like the following should do without risking the overflow:

-		ticks = ns * __ipipe_mach_ticks_per_jiffy / (1000000000 / HZ);
+		ticks = ns / (TICKS_PER_uSEC * 1000);

 >  		if (ticks > __ipipe_mach_ticks_per_jiffy)
 >  			return -EINVAL;

 > diff -uNrp linux-2.6.14/arch/arm/kernel/process.c linux-2.6.14-heig/arch/arm/kernel/process.c
 > --- linux-2.6.14/arch/arm/kernel/process.c	2006-04-21 16:17:02.000000000 +0200
 > +++ linux-2.6.14-heig/arch/arm/kernel/process.c	2006-04-21 15:33:47.000000000 +0200
 > @@ -7,6 +7,12 @@
 >   * This program is free software; you can redistribute it and/or modify
 >   * it under the terms of the GNU General Public License version 2 as
 >   * published by the Free Software Foundation.
 > + *
 > + * April 2006 :
 > + * Adapted to ARM9 i.MX21/CSB535FS board with Xenomai by S.Gerber, G.Boutillier and D.Rossier
 > + * University of Applied Sciences Western Switzerland
 > + * Reconfigurable & Embedded Digital Systems, REDS Institute
 > + *
 >   */
 >  #include <stdarg.h>
 >
 > @@ -111,7 +117,14 @@ void cpu_idle(void)
 >  		preempt_disable();
 >  		leds_event(led_idle_start);
 >  		while (!need_resched())
 > +/*
 > + * Width idle -> latenca of interrupts
 > + */
 > +#ifndef CONFIG_IPIPE
 >  			idle();
 > +#else
 > +			;
 > +#endif

Ouch. It would be saner to implement the idle mode switch one could pass
as a boot argument to the kernel (e.g. arch/i386/kernel/process.c),
accepting "poll" or "default", instead of hard-wiring the poll mode.

 >  		leds_event(led_idle_end);
 >  		preempt_enable();
 >  		schedule();
 > diff -uNrp linux-2.6.14/init/Kconfig linux-2.6.14-heig/init/Kconfig
 > --- linux-2.6.14/init/Kconfig	2006-04-21 16:17:02.000000000 +0200
 > +++ linux-2.6.14-heig/init/Kconfig	2006-04-21 15:34:01.000000000 +0200
 > @@ -502,3 +502,20 @@ config STOP_MACHINE
 >  	help
 >  	  Need stop_machine() primitive.
 >  endmenu
 > +
 > +menu "Real-time sub-system"
 > +

The Xenomai-related stuff does not belong to the Adeos patch.

-- 

Philippe.

