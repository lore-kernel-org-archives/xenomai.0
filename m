Message-ID: <441FF539.5050704@domain.hid>
Date: Tue, 21 Mar 2006 13:44:41 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
References: <44172B67.2000609@domain.hid>	<4417C14A.2010900@domain.hid>	<44180FB8.7080200@domain.hid>	<17432.5656.591747.248941@domain.hid>	<44189C13.3010301@domain.hid>
	<441E9698.5080506@domain.hid> <441EAD78.3030007@domain.hid>
	<441EC03B.9000809@domain.hid>
In-Reply-To: <441EC03B.9000809@domain.hid>
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
> Philippe Gerum wrote:
>>Given the description above, just that some skin might return either
>>nucleus ticks or corrected timestamps to the applications, which would
>>in turn do some arithmetics for converting values they got from the skin
>>between both scales internally, and mistakenly use the result while
>>assuming that both scales are always in sync. In this situation, and
>>during a fraction of the time (i.e. the jitter), both scales might not
>>be in sync, and the result would be unusable. This said, this kind of
>>issue could be solved by big fat warnings in documentation, explicitely
>>saying that conversions between both scales might be meaningless.
> 
> 
> So the worst-case is when a user derives some relative times from two
> different time sources, one purely tick-base, the other improved by
> inter-tick TSC (when available on that arch)?
> 
> Let's say the user takes timestamp t1 = rtdm_clock_read() (via some
> driver) and a bit later t2 = rt_timer_tick2ns(rt_timer_read()). t1 was
> set to the last tick Tn + the number of TSC ticks since then:
> 
>     t1 = Tn * tick_period + TSC_offset
> 
> With, e.g., Tn=1001, tick_period = 1000 us, and TSC_offset = 589 us:
> 
>     t1 = 1001 * 1000 us + 589 us = 1001569 us
> 
> As the next tick may have not stroke yet when taking t2, that value
> converted to us can be smaller:
> 
>     t2 = Tn * tick_period = 1001000
> 
> Now the difference between t2 and t1 becomes negative (-589 us),
> although the user may expect it t2-t1 >= 0. Is this non-monotony your
> concern?
>

No, because both are sourced from xnpod_get_time(). My concern is that
the offset correction is going to cause situations where actual count of
ticks kept by the nucleus might be different from corrected_time /
period, due to the jitter issue, albeit the corrected timestamp is
expected to depend on the count of ticks. So you end up having two time
scales which are expected to be in sync, albeit there might not under
certain conditions.

> 
> On the other hand, the advantage of TSC-based synchronised inter-tick
> timestamps is that you can do things like
> 
>     sleep_until(rt_timer_ns2ticks(rtdm_clock_read() + 1000000))
> 
> without risking an error beyond +/- 1 tick (+jitter). With current
> jiffies vs. TSC in periodic mode, this is not easily possible. You have
> to sync in the application, creating another error source when the delay
> between acquiring the TSC and sync'ing the TSC on jiffies is too long.
> 

The proper way to solve this is rather to emulate the periodic mode over
the oneshot machinery, so that we stop having this +/- 1 tick error
margin. The periodic mode as it is now is purely a x86 legacy; even on
some ppc boards where the auto-reload feature is available from the
decrementer, Xeno doesn't use it.

The more I think of the x86 situation, the more I find it quite silly. I
mean, picking the periodic mode means that 1) all delays can be
expressed as multiples of a given constant interval, 2) the constant
interval must be large enough so that you don't put your board on its
knees, by processing useless ticks most of the time. What one saves here
- using periodic mode - is a couple of outb's per tick on the ISA bus,
since the PIT handles this automatically without software intervention
once set up properly. We already know that the programming overhead
(i.e. introduced by those outb's) is perfectly bearable even for high
frequency sampling like 10Khz loops in aperiodic mode. So why on earth
do we care about saving two outb's and get a lousy timing accuracy in
the same move, for constant interval delays which are necessarily going
to be much larger than those already supported by the aperiodic mode? Er...

This is a shift in the underlying logic of the periodic mode we are
discussing here actually. It used to be a mode where timing accuracy was
only approximate, mostly to deal with timeouts, in the watchdog sense.
Now, it is becoming a way to rely on a constant interval unit, while
still keeping a high timing accuracy. I'm ok with this, since we don't
rely on true PIT (except for x86, which is fixable) when running in
periodic mode, so I see no problem in raising the level of timing
accuracy of such mode. Existing stuff would not break because of such
change, but improve instead for people who care for exact durations in
periodic mode.

> 
>>And what would prevent us from improving the accuracy of other
>>
>>>timestamping API functions beyond RTDM as well, e.g. on converting from
>>>ticks to nanos in rt_timer_ticks2ns()?
>>>
>>
>>I don't understand why rt_timer_ticks2ns() should be impacted by such
>>extension. This service must keep a constant behaviour, regardless of
>>any outstanding timing issue. I mean, 3 ticks from a 1Khz clock rate
>>must always return 3,000,000 nanos, unless you stop passing count of
>>ticks but fractional/compound values instead.
> 
> 
> Forget about this, it was (pre-lunch) nonsense.
> 
> 
>>The bottom-line is that we should not blur the line between periodic and
>>aperiodic timing modes, just for getting precise timestamps in the
>>former case. Additionally, and x86-wise, when no TSC is available on the
>>target system, rt_timer_tsc() already returns a timestamp obtained from
>>the 8254's channel #2 we use as a free running counter, which is the
>>most precise source we have at hand to do so.
>>
>>Periodic mode bears its own limitation, which is basically a loss of
>>accuracy we trade against a lower overhead (even if that does not mean
>>much except perhaps on x86). What we could do is reducing the jittery
>>involved in periodic ticks, by always emulating periodic mode over
>>aperiodic shots instead of using e.g. the 8254 in PIT mode (and remove
>>the need for the double scale on x86, tsc + 8254 channel #1), but not
>>change the basic meaning of periodic timing.
> 
> 
> Hmm, interesting, and it also reminds of a long pending (slightly OT)
> question I have: why not creating the infrastructure (a dedicated
> periodic timer) for providing round-robin scheduling even in aperiodic mode?
> 

To do that, we would need to decouple the timing policy from any
particular scheduling policy. Therefore, we would need to remove the
round-robin management from the timer code, and move it to a particular
scheduling policy implementation. Which in turn would require to
implement a pluggable scheduler infrastructure, in the first place.

> 
>>But maybe we are still discussing different issues actually, so it would
>>be useful that the core issue that triggered the discussion about
>>periodic mode precision be exposed again.
> 
> 
> Yep, Rodrigo...?
> 
> Jan
> 


-- 

Philippe.



