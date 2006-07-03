Sender: dv@domain.hid
Message-ID: <44A8D7A1.4E4E9D27@domain.hid>
Date: Mon, 03 Jul 2006 10:38:57 +0200
From: Detlef Vollmann <dv@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Some questions about the ARM port (Integrator
	vs.	PXA)
References: <44A3919C.596DFDAE@vollmann.ch>	<1151592402.19389.31.camel@domain.hid>	<44A4C4CB.5F24DA68@domain.hid>	<1151657621.3060.26.camel@domain.hid>
	<44A8B191.3DCC39C2@domain.hid> <44A8BA2E.9090106@domain.hid>
Content-Type: text/plain; charset=us-ascii
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> 
> Detlef Vollmann wrote:
> >>> Now I have another question on this: on the PXA I have a hardware
> >>> problem so that I must sometimes set the next match value to the
> >>> match value after the next one, so effectively loosing one
> >>> interrupt.
> 
> Just out of curiosity: What is the technical background of this issue?
> Does it mean that the hardware is not able to trigger a timer event over
> a certain period of time and you therefore have to defer the event until
> this is possible again? Do you know ahead of time when this will happen?
> Or only when you try to set the timer and the hardware tells you about
> it somehow?
Here's the original comment and code from
 linux/arch/arm/mach-pxa/time.c:

    /* Loop until we get ahead of the free running timer.
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
    do {
        timer_tick(regs);
        OSSR = OSSR_M0;  /* Clear match on timer 0 */
        next_match = (OSMR0 += LATCH);
    } while( (signed long)(next_match - OSCR) <= 8 );

> Looks like designing a real-time application around such a quirk isn't
> that easy.
It's not so difficult to work around the problem for a single system.
What's difficult is to find a solution in a framework that wasn't
built with such a problem in mind.

> But it's not a generic PXA issue, is it?
It seems it is...

 Detlef

-- 
Detlef Vollmann   vollmann engineering gmbh
Linux and C++ for Embedded Systems    http://www.vollmann.ch/
Linux for PXA270 Colibri module: http://www.vollmann.ch/en/colibri/

