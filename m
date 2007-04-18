MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17957.52859.203341.949031@domain.hid>
Date: Wed, 18 Apr 2007 09:53:31 +0200
In-Reply-To: <899865CA54E4444DAF2E3639C04C5F4805EC78@domain.hid>
References: <17957.2183.25570.823923@domain.hid>
	<899865CA54E4444DAF2E3639C04C5F4805EC78@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [Adeos-main] [PATCH] Adeos support for IXP4xx
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richard.cochran@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

Richard Cochran wrote:
 > > -----Original Message----- From: Gilles Chanteperdrix
 > > 
 > > For reasons explained on the wiki, I would rather see
 > > ixp4xx_timer_interrupt implemented as:
 > > 
 > > 	if (__ipipe_mach_timerstolen) {
 > > 		/* If some other domain has taken over the timer, then
 > > 		 * do nothing (ipipe has acked it, and the other
 > > 		 * domain has reprogramed it)
 > > 		 */
 > > 		timer_tick();
 > > 		last_jiffy_time += LATCH;
 > 
 > Okay, I see. This comment, which I copied from other ARM code, is
 > misleading. In general, Linux cannot be sure that the "other domain"
 > will never lose interrupts. If there is only one other domain, and
 > that domain is Xenomai, then we trust it.
 > 
 > Even if Xenomai never loses a timer interrupt, is there some harm in
 > leaving the loop in?
 > 
 > IMHO, it makes the code more clear to leave the loop, since:
 > 
 > 1. You see the connection to the unmodified Linux ISR.
 > 
 > 2. The reason for _not_ looping is "invisible" knowledge.

The reason for not looping is that Adeos never looses interrupts. If we
leave the loop and Linux gets delayed, then the lost ticks will be
accounted for twice: one time because Xenomai will have posted the
missed timer interrupts, one time because of the loop. So, we remove the
loop.

 > 
 > > Why 8 ? It looks suspiciously like you just copied the PXA code. 
 > 
 > Yes, indeed, it is copied. I put the question back to you: why 8 in
 > the PXA code?
 > 
 > If I know what 8 means, then I can put the right value for the
 > IXP4xx ;^)
 > 
 > (Probably this 8 really should be expressed as a macro-ized time
 > value)

It's explained in the wiki. The PXA timer does not tick if programmed
with too short delays. To see if IXP4XX has the same problem, remove the
"if" and run latency with a tight period, so that the timer is
reprogrammed with short delays. If latency misteriously hangs, then you
have the same problem as PXA, and you should look for the minimum delay
by trial and errors.

-- 


					    Gilles Chanteperdrix.

