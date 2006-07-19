From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17598.1897.208601.381463@domain.hid>
Date: Wed, 19 Jul 2006 12:20:25 +0200
Subject: Re: [Xenomai-core] [PATCH 3/2] kill XN_INFINITE xntimer delays
In-Reply-To: <44BDD70F.8080401@domain.hid>
References: <44BDD70F.8080401@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > [Appendix to the xntimer cleanup series.]
 > 
 > Having to take care for infinite delays in xntimer_start (i.e. to NOT
 > start the timer...) is a bit suboptimal given that his service might be
 > used heavily to restart timers. This patch converts the only user
 > (xnpod_start_timer again) and cleans up the timer code.
 > 
 > Jan
 > ---
 >  ksrc/nucleus/pod.c   |   10 ++++++----
 >  ksrc/nucleus/timer.c |   34 ++++++++++++----------------------
 >  2 files changed, 18 insertions(+), 26 deletions(-)
 > 
 > Index: xenomai/ksrc/nucleus/pod.c
 > ===================================================================
 > --- xenomai.orig/ksrc/nucleus/pod.c
 > +++ xenomai/ksrc/nucleus/pod.c
 > @@ -3095,10 +3095,12 @@ int xnpod_start_timer(u_long nstick, xni
 >  
 >  	xntimer_set_sched(&nkpod->htimer, xnpod_sched_slot(XNTIMER_KEEPER_ID));
 >  
 > -	xnlock_get_irqsave(&nklock, s);
 > -	xntimer_start(&nkpod->htimer, delta,
 > -		      XNARCH_HOST_TICK / nkpod->tickvalue);
 > -	xnlock_put_irqrestore(&nklock, s);
 > +	if (delta) {

Should not this rather be if (XNARCH_HOST_TICK) ?

 > +		xnlock_get_irqsave(&nklock, s);
 > +		xntimer_start(&nkpod->htimer, delta,
 > +			      XNARCH_HOST_TICK / nkpod->tickvalue);
 > +		xnlock_put_irqrestore(&nklock, s);
 > +	}

-- 


					    Gilles Chanteperdrix.

