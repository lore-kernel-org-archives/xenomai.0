Message-ID: <448E9E8B.70809@domain.hid>
Date: Tue, 13 Jun 2006 13:16:27 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] ns vs. tsc as internal timer base
References: <448E98A3.6080707@domain.hid>
In-Reply-To: <448E98A3.6080707@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> between some football half-times of the last days ;), I played a bit
> with a hand-optimised xnarch_tsc_to_ns() for x86. Using scaled math, I
> achieved between 3 (P-I 133 MHz) to 4 times (P-M 1.3 GHz) faster
> conversions than with the current variant. While this optimisation only
> saves a few ten nanoseconds on high-end, slow processors can gain
> several hundreds of nanos per conversion (my P-133: -600 ns).
> 

I did exactely the same a few weeks ago, based on Anzinger's scaled math 
from i386/kernel/timers/timer_tsc.c. And indeed, I had x 20 performance 
improvements in some cases.

> This does not come for free: accuracy of very large values is slightly
> worse, but that's likely negligible compared to the clock accuracy of
> TSCs (does anyone have any real numbers on the latter, BTW?).
> 

We do start losing significant precision for 2 ms delays and above, 
IIRC. This could be an issue for some events in aperiodic mode, albeit 
we could use a plain divide for those. The cost of conditionally doing 
this remains to be evaluated though.

> As we loose some bits the one way, converting back still requires "real"
> division (i.e. the use of the existing slower xnarch_ns_to_tsc).
> Otherwise, we would get significant errors already for small intervals.
> 
> To avoid loosing the optimisation again in ns_to_tsc, I thought about
> basing the whole internal timer arithmetics on nanoseconds instead of
> TSCs as it is now. Although I dug quite a lot in the current timer
> subsystem the last weeks, I may still oversee aspects and I'm
> x86-biased. Therefore my question before thinking or even patching
> further this way: What was the motivation to choose TSCs as internal
> time base?

TSC are not the whole nucleus time base, but only the timer management 
one. The motivation to use TSCs in nucleus/timer.c was to pick a unit 
which would not require any conversion beyond the initial one in 
xntimer_start.

> Any pitfalls down the road (except introducing regressions)?

Well, pitfalls expected from changing the core idea of time of the timer 
management code... :o>

> 
> Jan
> 
> 
> PS: All this would be 2.3-stuff, for sure.
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

