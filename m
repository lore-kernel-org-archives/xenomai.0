Message-ID: <4DFB3346.6000405@domain.hid>
Date: Fri, 17 Jun 2011 12:58:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DFB1E0B.1070903@domain.hid>
In-Reply-To: <4DFB1E0B.1070903@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH] nucleus: Prevent rescheduling while
 in	xntbase_tick
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 06/17/2011 11:27 AM, Jan Kiszka wrote:
> Based on code inspection, it looks like a timer handler triggering a
> reschedule in the path xntbase_tick -> xntimer_tick_aperiodic /
> xntimer_tick_periodic_inner -> handler can cause problems, e.g. a
> reschedule before all expired timers were processed. The timer core is
> usually run atomically from an interrupt handler, so better emulate an
> IRQ context inside xntbase_tick by setting XNINIRQ.

I do not understand this one either: if we are inside
xntimer_tick_aperiodic, XNINIRQ is already set.


-- 
                                                                Gilles.

