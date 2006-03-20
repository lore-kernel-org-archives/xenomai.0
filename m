Message-ID: <441EAD78.3030007@domain.hid>
Date: Mon, 20 Mar 2006 14:26:16 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
References: <44172B67.2000609@domain.hid>	<4417C14A.2010900@domain.hid>	<44180FB8.7080200@domain.hid>	<17432.5656.591747.248941@domain.hid>
	<44189C13.3010301@domain.hid> <441E9698.5080506@domain.hid>
In-Reply-To: <441E9698.5080506@domain.hid>
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
> 
>>...
>>The issue that worries me - provided that we bound the adjustment offset
>>to the duration of one tick after some jittery - is that any attempt to
>>get intra-tick precision would lead to a possible discrepancy regarding
>>the elapsed time according to those two different scales, between the
>>actual count of jiffies tracked by the timer ISR on the timekeeper CPU,
>>and the corrected time value returned by rtdm_read_clock. And this
>>discrepancy would last for the total duration of the jitter. E.g., for a
>>100 us period, xnpod_get_time() could return 2 albeit rtdm_read_clock
>>returns 300, instead of 200. Spuriously mixing both units in
>>applications would lead to some funky chaos.
>>
> 
> 
> Trying to pick up this thread again, I just tried to understand your
> concerns, but failed so far to imagine a concrete scenario. Could you
> sketch such a "funky chaotic" situation from the application point of
> view?

Given the description above, just that some skin might return either 
nucleus ticks or corrected timestamps to the applications, which would 
in turn do some arithmetics for converting values they got from the skin 
between both scales internally, and mistakenly use the result while 
assuming that both scales are always in sync. In this situation, and 
during a fraction of the time (i.e. the jitter), both scales might not 
be in sync, and the result would be unusable. This said, this kind of 
issue could be solved by big fat warnings in documentation, explicitely 
saying that conversions between both scales might be meaningless.

And what would prevent us from improving the accuracy of other
> timestamping API functions beyond RTDM as well, e.g. on converting from
> ticks to nanos in rt_timer_ticks2ns()?
>

I don't understand why rt_timer_ticks2ns() should be impacted by such 
extension. This service must keep a constant behaviour, regardless of 
any outstanding timing issue. I mean, 3 ticks from a 1Khz clock rate 
must always return 3,000,000 nanos, unless you stop passing count of 
ticks but fractional/compound values instead.

The bottom-line is that we should not blur the line between periodic and 
aperiodic timing modes, just for getting precise timestamps in the 
former case. Additionally, and x86-wise, when no TSC is available on the 
target system, rt_timer_tsc() already returns a timestamp obtained from 
the 8254's channel #2 we use as a free running counter, which is the 
most precise source we have at hand to do so.

Periodic mode bears its own limitation, which is basically a loss of 
accuracy we trade against a lower overhead (even if that does not mean 
much except perhaps on x86). What we could do is reducing the jittery 
involved in periodic ticks, by always emulating periodic mode over 
aperiodic shots instead of using e.g. the 8254 in PIT mode (and remove 
the need for the double scale on x86, tsc + 8254 channel #1), but not 
change the basic meaning of periodic timing.

But maybe we are still discussing different issues actually, so it would 
be useful that the core issue that triggered the discussion about 
periodic mode precision be exposed again.


-- 

Philippe.

