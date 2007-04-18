MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17957.52367.369723.380241@domain.hid>
Date: Wed, 18 Apr 2007 09:45:19 +0200
In-Reply-To: <899865CA54E4444DAF2E3639C04C5F4805EC79@domain.hid>
References: <17957.2778.801915.659858@domain.hid>
	<899865CA54E4444DAF2E3639C04C5F4805EC79@domain.hid>
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
 > >> 		*IXP4XX_OSRT1 = LATCH | ONE_SHOT_ENABLE;
 > > 
 > > In fact, should not this be:
 > > 
 > >                 *IXP4XX_OSRT1 = 
 > >                   (last_jiffy_time + LATCH - *IXP4XX_OSTS) |
 > ONE_SHOT_ENABLE;
 > 
 > Nope, we are using GP Timer 1. It counts down from the dialed value and
 > then stops. It is _not_ a free running timer.

I understand, but my point is that if we want the next timer interrupt
to occur at last_jiffy_time + LATCH, we should reprogram the decrementer
with last_jiffy_time + LATCH - *IXP4XX_OSTS to account for the time
which passed since last_jiffy_time.

-- 


					    Gilles Chanteperdrix.

