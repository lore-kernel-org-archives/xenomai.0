From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17618.12731.97405.118098@domain.hid>
Date: Thu, 3 Aug 2006 19:26:19 +0200
Subject: Re: [Xenomai-core] [RFC][PATCH 4/4] shorten overrun loops of periodic
	timers
In-Reply-To: <44D19F3D.9060700@domain.hid>
References: <44D19F3D.9060700@domain.hid>
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
 > A simple patch, just like suggested by Gilles, to avoid looping over
 > periodic xntimer handlers in case of overruns.
 > 
 > It saves the current TSC on loop entry and uses this value later when
 > forwarding the timer. Is is the overhead of re-reading the TSC on all
 > archs negligible and should we rather go that way?

 >(...)
 > -				xntimerh_date(&timer->aplink) +=
 > -				    nkpod->htimer.interval;
 > +				while ((xntimerh_date(&timer->aplink) +=
 > +				        nkpod->htimer.interval) < now);

I think you are patching the wrong addition, the one you are interested
in is most probably the one at the bottom of xntimer_do_tick_aperiodic.

-- 


					    Gilles Chanteperdrix.

