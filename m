From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A267591.2060301@domain.hid>
References: <20090603104015.13268.34073.stgit@domain.hid>
	<20090603104015.13268.59718.stgit@domain.hid>
	<4A267036.8010507@domain.hid>  <4A267591.2060301@domain.hid>
Content-Type: text/plain
Date: Wed, 03 Jun 2009 15:34:04 +0200
Message-Id: <1244036044.5329.12.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 2/3] RTDM: Instrument rtdm_lock_get for
 proper use
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2009-06-03 at 15:07 +0200, Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> > Jan Kiszka wrote:
> >> In case the user thinks rtdm_lock_get could be used like spin_lock or
> >> messes up the IRQ protection for other reasons, catch this with a
> >> XENO_BUGON.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> >> ---
> >>
> >>  include/rtdm/rtdm_driver.h |    8 ++++++++
> >>  1 files changed, 8 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
> >> index 058a9f8..fe42eea 100644
> >> --- a/include/rtdm/rtdm_driver.h
> >> +++ b/include/rtdm/rtdm_driver.h
> >> @@ -655,7 +655,15 @@ typedef unsigned long rtdm_lockctx_t;
> >>   *
> >>   * Rescheduling: never.
> >>   */
> >> +#ifdef DOXYGEN_CPP /* Beautify doxygen output */
> >>  #define rtdm_lock_get(lock)	rthal_spin_lock(lock)
> >> +#else /* This is how it really works */
> >> +#define rtdm_lock_get(lock)					\
> >> +	do {							\
> >> +		XENO_BUGON(RTDM, rthal_local_irq_test());	\
> >> +		rthal_spin_lock(lock);				\
> >> +	} while (0)
> >> +#endif
> > 
> > Why is it a problem to call rthal_spin_lock with irqs off?
> 
> Did I messed it up again? I meant it is a problem to call it with irqs
> *on*. Checking what rthal_local_irq_test() actually means...

It means "is the stall bit set for the Xenomai pipeline stage", so your
test is inverted.

>  Hmm, I
> still think it's correct. Maybe we should rename rthal_local_irq_test to
> rthal_local_irq_enabled to clarify the usage.
> 

No, because this is aligned on the I-pipe internal logic, but we could
define rthal_local_irq_disabled() as an alias.

> > 
> > I also belived that you can avoid the #ifdef DOXYGEN_CPP.
> 
> Haven't tried recently, but so far doxygen pulled the whole definition
> into its documents, and I don't when the BUGON to appear there.
> 
> Jan
> 
-- 
Philippe.



