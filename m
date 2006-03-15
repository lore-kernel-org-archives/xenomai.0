Message-ID: <44189C13.3010301@domain.hid>
Date: Wed, 15 Mar 2006 23:58:27 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
References: <44172B67.2000609@domain.hid>	<4417C14A.2010900@domain.hid>	<44180FB8.7080200@domain.hid>
	<17432.5656.591747.248941@domain.hid>
In-Reply-To: <17432.5656.591747.248941@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > At worst, you would see an old timestamp from a previous shot while the timer IRQ 
>  > announcing the most accurate one is still outstanding but untaken, but I think 
>  > that you would still have something behaving in a monotonic way though.
>  > 
>  > > Does anyone ever studied if and how Linux synchronises across CPUs?
>  > > There was some activity around the problematic AMD64 multicores, but I
>  > > haven't looked at the details and if it's actually solved now.
>  > > 
>  > 
>  > Only once during boot AFAICT, see arch/i386/kernel/smpboot.c. This said, TSC 
>  > synchronization would not work on NUMA boxen.
> 
> I think Jan is talking about using TSC to get intra-ticks precise clock,
> by adding tsc offsets to the time derived from the clock irqs count.
> This would allow, for example, to run the "latency" test with the timer
> set in periodic mode.
> 
> The issue with non-monotonic values happens if two clock interrupts are
> distant from a bit more than one tick, because of the jitter. Reading
> the time just before the second irq then yield a greater value than the
> one read just after the second irq.
> 

The issue that worries me - provided that we bound the adjustment offset to the 
duration of one tick after some jittery - is that any attempt to get intra-tick 
precision would lead to a possible discrepancy regarding the elapsed time 
according to those two different scales, between the actual count of jiffies 
tracked by the timer ISR on the timekeeper CPU, and the corrected time value 
returned by rtdm_read_clock. And this discrepancy would last for the total 
duration of the jitter. E.g., for a 100 us period, xnpod_get_time() could return 2 
albeit rtdm_read_clock returns 300, instead of 200. Spuriously mixing both units 
in applications would lead to some funky chaos.

-- 

Philippe.

