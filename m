Sender: dv@domain.hid
Message-ID: <44B34343.9F56F13@domain.hid>
Date: Tue, 11 Jul 2006 08:20:51 +0200
From: Detlef Vollmann <dv@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai on PXA
References: <200607071703.10700.vagninu@domain.hid>
	<17582.50372.830923.414981@domain.hid>
Content-Type: multipart/mixed; boundary="------------3A32E969689B8F4F3662F0"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.

--------------3A32E969689B8F4F3662F0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Danilo Levantesi wrote:
>  > So what is the status of the port? Is anything working on a pxa arch?
> 
> More recently, Detlef Vollmann seem also to have begun a port to
> PXA.
Unfortunately my priorities were shifted, so I'm not able to
work on it for the next few weeks.

What I've done so far is attached.
IT'S UNTESTED!!!
So it's nothing you can just use, but something that you can build
on (possibly).
I'd be happy to hear about any experience with this.

What is missing is a look at entry-macro.S.
Stelian Pop has done something for the Integrator that I don't
really understand and therefore I can't say whether the PXA needs
something similar.

 Detlef

-- 
Detlef Vollmann   vollmann engineering gmbh
Linux and C++ for Embedded Systems    http://www.vollmann.ch/
Linux for PXA270 Colibri module: http://www.vollmann.ch/en/colibri/

--------------3A32E969689B8F4F3662F0
Content-Type: text/plain; charset=us-ascii; name="time.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="time.c"

/*
 * arch/arm/mach-pxa/time.c
 *
 * Author:	Nicolas Pitre
 * Created:	Jun 15, 2001
 * Copyright:	MontaVista Software Inc.
 *
 * Preliminary support for I-PIPE  !!! COMPLETELY UNTESTED !!!
 * Copyright (c) 2006 Detlef Vollmann <dv@domain.hid>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/delay.h>
#include <linux/interrupt.h>
#include <linux/time.h>
#include <linux/signal.h>
#include <linux/errno.h>
#include <linux/sched.h>

#include <asm/system.h>
#include <asm/hardware.h>
#include <asm/io.h>
#include <asm/leds.h>
#include <asm/irq.h>
#include <asm/mach/irq.h>
#include <asm/mach/time.h>
#include <asm/arch/pxa-regs.h>

#ifdef CONFIG_IPIPE
#ifdef CONFIG_NO_IDLE_HZ
#error "dynamic tick timer not yet supported with IPIPE"
#endif
int __ipipe_mach_timerint = IRQ_OST0;
static DEFINE_SPINLOCK(timer_lock);

int __ipipe_mach_timerstolen = 0;
EXPORT_SYMBOL(__ipipe_mach_timerstolen);

unsigned int __ipipe_mach_ticks_per_jiffy = CLOCK_TICK_RATE / HZ;
EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);

#endif

static unsigned long timer_reload = LATCH;
static int timer_initialized = 0;

static inline unsigned long pxa_get_rtc_time(void)
{
	return RCNR;
}

static int pxa_set_rtc(void)
{
	unsigned long current_time = xtime.tv_sec;

	if (RTSR & RTSR_ALE) {
		/* make sure not to forward the clock over an alarm */
		unsigned long alarm = RTAR;
		if (current_time >= alarm && alarm >= RCNR)
			return -ERESTARTSYS;
	}
	RCNR = current_time;
	return 0;
}

/* IRQs are disabled before entering here from do_gettimeofday() */
static unsigned long pxa_gettimeoffset (void)
{
	long ticks_to_match, elapsed, usec;

    if (!timer_initialized)
        return 0;

	/* Get ticks before next timer match */
	ticks_to_match = OSMR0 - OSCR;

	/* We need elapsed ticks since last match */
	elapsed = LATCH - ticks_to_match;

	/* don't get fooled by the workaround in pxa_timer_interrupt() */
	if (elapsed <= 0)
		return 0;

	/* Now convert them to usec */
	usec = (unsigned long)(elapsed * (tick_nsec / 1000))/LATCH;

	return usec;
}

#ifdef CONFIG_NO_IDLE_HZ
static unsigned long initial_match;
static int match_posponed;
#endif

static irqreturn_t
pxa_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
	int next_match;

	write_seqlock(&xtime_lock);

#ifdef CONFIG_NO_IDLE_HZ
	if (match_posponed) {
		match_posponed = 0;
		OSMR0 = initial_match;
	}
#endif

	/* Loop until we get ahead of the free running timer.
	 * This ensures an exact clock tick count and time accuracy.
	 * Since IRQs are disabled at this point, coherence between
	 * lost_ticks(updated in do_timer()) and the match reg value is
	 * ensured, hence we can use do_gettimeofday() from interrupt
	 * handlers.
	 *
	 * HACK ALERT: it seems that the PXA timer regs aren't updated right
	 * away in all cases when a write occurs.  We therefore compare with
	 * 8 instead of 0 in the while() condition below to avoid missing a
	 * match if OSCR has already reached the next OSMR value.
	 * Experience has shown that up to 6 ticks are needed to work around
	 * this problem, but let's use 8 to be conservative.  Note that this
	 * affect things only when the timer IRQ has been delayed by nearly
	 * exactly one tick period which should be a pretty rare event.
	 */
#ifdef CONFIG_IPIPE
    /*
     * - if Linux is running natively (no ipipe), ack and reprogram the timer
     * - if Linux is running under ipipe, but it still has the control over
     *   the timer (no Xenomai for example), then reprogram the timer (ipipe
     *   has already acked it)
     * - if some other domain has taken over the timer, then do nothing
     *   (ipipe has acked it, and the other domain has reprogramed it)
     */
    if (!__ipipe_mach_timerstolen) {
#endif
        do {
            timer_tick(regs);
#ifndef CONFIG_IPIPE
            OSSR = OSSR_M0;  /* Clear match on timer 0 */
#endif
            next_match = (OSMR0 += timer_reload);
        } while( (signed long)(next_match - OSCR) <= 8 );
#ifdef CONFIG_IPIPE
    } else {
        timer_tick(regs);
    }
#endif

	write_sequnlock(&xtime_lock);

	return IRQ_HANDLED;
}

static struct irqaction pxa_timer_irq = {
	.name		= "PXA Timer Tick",
	.flags		= SA_INTERRUPT | SA_TIMER,
	.handler	= pxa_timer_interrupt,
};

static void __init pxa_timer_init(void)
{
	struct timespec tv;

	set_rtc = pxa_set_rtc;

	tv.tv_nsec = 0;
	tv.tv_sec = pxa_get_rtc_time();
	do_settimeofday(&tv);

	OIER = 0;		/* disable any timer interrupts */
	OSCR = LATCH*2;		/* push OSCR out of the way */
	OSMR0 = LATCH;		/* set initial match */
	OSSR = 0xf;		/* clear status on all timers */
	setup_irq(IRQ_OST0, &pxa_timer_irq);
	OIER = OIER_E0;		/* enable match on timer 0 to cause interrupts */
	OSCR = 0;		/* initialize free-running timer */
    timer_initialized = 1;
}

#ifdef CONFIG_NO_IDLE_HZ
static int pxa_dyn_tick_enable_disable(void)
{
	/* nothing to do */
	return 0;
}

static void pxa_dyn_tick_reprogram(unsigned long ticks)
{
	if (ticks > 1) {
		initial_match = OSMR0;
		OSMR0 = initial_match + ticks * LATCH;
		match_posponed = 1;
	}
}

static irqreturn_t
pxa_dyn_tick_handler(int irq, void *dev_id, struct pt_regs *regs)
{
	if (match_posponed) {
		match_posponed = 0;
		OSMR0 = initial_match;
		if ( (signed long)(initial_match - OSCR) <= 8 )
			return pxa_timer_interrupt(irq, dev_id, regs);
	}
	return IRQ_NONE;
}

static struct dyn_tick_timer pxa_dyn_tick = {
	.enable		= pxa_dyn_tick_enable_disable,
	.disable	= pxa_dyn_tick_enable_disable,
	.reprogram	= pxa_dyn_tick_reprogram,
	.handler	= pxa_dyn_tick_handler,
};
#endif

#ifdef CONFIG_PM
static unsigned long osmr[4], oier;

static void pxa_timer_suspend(void)
{
	osmr[0] = OSMR0;
	osmr[1] = OSMR1;
	osmr[2] = OSMR2;
	osmr[3] = OSMR3;
	oier = OIER;
}

static void pxa_timer_resume(void)
{
	OSMR0 = osmr[0];
	OSMR1 = osmr[1];
	OSMR2 = osmr[2];
	OSMR3 = osmr[3];
	OIER = oier;

	/*
	 * OSMR0 is the system timer: make sure OSCR is sufficiently behind
	 */
	OSCR = OSMR0 - LATCH;
}
#else
#define pxa_timer_suspend NULL
#define pxa_timer_resume NULL
#endif

struct sys_timer pxa_timer = {
	.init		= pxa_timer_init,
	.suspend	= pxa_timer_suspend,
	.resume		= pxa_timer_resume,
	.offset		= pxa_gettimeoffset,
#ifdef CONFIG_NO_IDLE_HZ
	.dyn_tick	= &pxa_dyn_tick,
#endif
};



#ifdef CONFIG_IPIPE
void __ipipe_mach_acktimer(void)
{
    OSSR = OSSR_M0;  /* Clear match on timer 0 */
}

unsigned long long __ipipe_mach_get_tsc(void)
{
    if (!timer_initialized)
        return 0;
    else
        return OSCR;
}
EXPORT_SYMBOL(__ipipe_mach_get_tsc);

/*
 * Reprogram the timer
 */
#if 0
/* old nonsense code, left here for reference */
static inline void  set_dec(unsigned long delay)
{
    int next_match = OSCR + delay;

	timer_reload = delay;

    if (delay < 8) {
        OSSR = OSSR_M0;  /* Ack the timer in case it fired in the meantime */
        ipipe_trigger_irq(__ipipe_mach_timerint);
        return;
    }
    else
        OSMR0 = next_match;

    if (OSCR < OSMR0)
        return;         /* everything is fine, we'll get an interrupt */

    if ((signed long)(next_match - OSCR) <= 6) {
        /* two ticks are gone, so we got interrupted */
        /* we do a busy wait here, just to play save */
        while (OSCR < next_match) {
            if (OSCR < OSMR0)
                return;
        }
        OSSR = OSSR_M0;  /* Ack the timer in case it fired in the meantime */
        ipipe_trigger_irq(__ipipe_mach_timerint);
    }

}
#endif

void __ipipe_mach_set_dec(unsigned long delay)
{
	unsigned long flags;
    int next_match = OSCR + delay;

	spin_lock_irqsave_hw(&timer_lock, flags);

	timer_reload = delay;

    if (delay < 8) {
        OSSR = OSSR_M0;  /* Ack the timer in case it fired in the meantime */
        ipipe_trigger_irq(__ipipe_mach_timerint);
        return;
    }
    else
        OSMR0 = next_match;

	spin_unlock_irqrestore_hw(&timer_lock, flags);
}
EXPORT_SYMBOL(__ipipe_mach_set_dec);

unsigned long __ipipe_mach_get_dec(void)
{
	return OSMR0 - OSCR;
}
#endif /* CONFIG_IPIPE */

--------------3A32E969689B8F4F3662F0--


