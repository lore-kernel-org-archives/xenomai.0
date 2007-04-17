From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17957.2183.25570.823923@domain.hid>
Date: Tue, 17 Apr 2007 19:48:55 +0200
In-Reply-To: <899865CA54E4444DAF2E3639C04C5F4805EC70@domain.hid>
References: <899865CA54E4444DAF2E3639C04C5F4805EC70@domain.hid>
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
 > This patch adds Adeos support for the Intel IXP425 processor. It may
 > also work on the IXP465, but I only tested it on the 425. The patch
 > is against a vanilla 2.6.19 kernel.

Great.

 > +static irqreturn_t ixp4xx_timer_interrupt(int irq, void *dev_id)
 > +{
 > +	write_seqlock(&xtime_lock);
 > +	if (__ipipe_mach_timerstolen) {
 > +		/* If some other domain has taken over the timer, then
 > +		 * do nothing (ipipe has acked it, and the other
 > +		 * domain has reprogramed it)
 > +		 */
 > +	} else {
 > +		/* If Linux is running under ipipe, but it still has
 > +		 * the control over the timer (no Xenomai for
 > +		 * example), then reprogram the timer (ipipe has
 > +		 * already acked it)
 > +		 */
 > +		*IXP4XX_OSRT1 = LATCH | ONE_SHOT_ENABLE;
 > +	}
 > +	/*
 > +	 * Catch up with the real idea of time
 > +	 */
 > +	while ((signed long)(*IXP4XX_OSTS - last_jiffy_time) >= LATCH) {
 > +		timer_tick();
 > +		last_jiffy_time += LATCH;
 > +	}
 > +	write_sequnlock(&xtime_lock);
 > +	return IRQ_HANDLED;
 > +}

For reasons explained on the wiki, I would rather see
ixp4xx_timer_interrupt implemented as:

	if (__ipipe_mach_timerstolen) {
		/* If some other domain has taken over the timer, then
		 * do nothing (ipipe has acked it, and the other
		 * domain has reprogramed it)
		 */
		timer_tick();
		last_jiffy_time += LATCH;
	} else {
		/* If Linux is running under ipipe, but it still has
		 * the control over the timer (no Xenomai for
		 * example), then reprogram the timer (ipipe has
		 * already acked it)
		 */
	        while ((long)(*IXP4XX_OSTS - last_jiffy_time) >= LATCH) {
		        timer_tick();
		        last_jiffy_time += LATCH;
	        }
		*IXP4XX_OSRT1 = LATCH | ONE_SHOT_ENABLE;
	}

 > +void __ipipe_mach_set_dec(unsigned long delay)
 > +{
 > +	unsigned long flags;
 > +	if (delay > 8) {

Why 8 ? It looks suspiciously like you just copied the PXA code. 

-- 


					    Gilles Chanteperdrix.

