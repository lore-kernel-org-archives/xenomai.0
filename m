Date: Thu, 7 Apr 2011 21:02:58 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110407190258.GA27879@domain.hid>
References: <20110407170855.GA22659@domain.hid>
	<4D9E0354.4010600@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D9E0354.4010600@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] ARM IXP: ipipe regression from
 2.6.31 to .33 and .35
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

On Thu, Apr 07, 2011 at 08:32:52PM +0200, Gilles Chanteperdrix wrote:
> Richard Cochran wrote:
> > I have been trying to bring my IXP425 based system up to date, and I
> > have found an apparent regression. Everything worked fine with ipipe
> > 2.6.30 and Xenomai 2.4. With 2.6.31 an ipipe kernel still boots, but
> > starting with 2.6.33 the trouble begins (see below).
> > 
> > I see that Gilles refactored the TSC emulation starting with
> > 2.6.33. I wonder whether this could be the cause?
> 
> What this modification does is that:
> - there is only one clocksource, which is now xenomai tsc, with a very
> high rating;
> - the tsc read code is written in assembly, and copied in the vectors
> page, the one at 0xffff0000.
> 
> I think the ixp is a 32 bits free-running counter with match register,
> wich is a configuration I tested. So, I would tend to think that the
> issue is rather in the clock_events implementation.

The IXP425 has one shot, count down timer (see below). Does that make
any difference?

(It might be that one of the other IXPxxx chips does have a match
register, but not this one.)

Thanks,
Richard

---
>From the 2.6.31 patch, in arch/arm/mach-ixp4xx/common.c

/*
 * Reprogram the timer
 *
 * The timer is aperiodic (most of the time) when running Xenomai, so
 * __ipipe_mach_set_dec is called for each timer tick and programs the
 * timer hardware for the next tick.
 *
 */
#define MIN_DELAY 333 /* 5 usec with the 66.66 MHz system clock */

void __ipipe_mach_set_dec(unsigned long delay)
{
	unsigned long flags;
	if (delay > MIN_DELAY) {
		local_irq_save_hw(flags);
		*IXP4XX_OSRT1 = delay | ONE_SHOT_ENABLE;
		local_irq_restore_hw(flags);
	} else {
	      	ipipe_trigger_irq(IRQ_IXP4XX_TIMER1);
	}
}

EXPORT_SYMBOL(__ipipe_mach_set_dec);

/*
 * This returns the number of clock ticks remaining.
 */
unsigned long __ipipe_mach_get_dec(void)
{
	return(*IXP4XX_OST1); /* remaining */
}

