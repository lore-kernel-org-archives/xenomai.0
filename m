Message-ID: <441A0DEE.2060702@domain.hid>
Date: Fri, 17 Mar 2006 02:16:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
References: <44172B67.2000609@domain.hid>
	<4417C14A.2010900@domain.hid>	<17432.6129.478721.712374@domain.hid>	<441845EA.3070602@domain.hid>
	<17433.33699.571482.467675@domain.hid>
In-Reply-To: <17433.33699.571482.467675@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
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
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Jan Kiszka wrote:
>  > >  > Likely too simple: The periodic IRQ seems to pop up on every CPU so that
>  > >  > the TSC could be recorded, but will this happen synchronously? At least
>  > >  > we will see (IRQ) jitters, and those jitters could already create in the
>  > >  > single-CPU case a non-monotonic clock...
>  > > 
>  > > I do not know how this issue is solved in Linux, but there seem to be a
>  > > simple solution: before adding the tsc offset to the last tick time,
>  > > this tsc offset should be compared with the tick duration in tsc
>  > > counts; if it is greater, then replace with the tick duration in tsc.
>  > > 
>  > 
>  > Hmm, I would rather express it in absolute tsc values, i.e. always save
>  > the tuple (absolute_tsc, jiffies):
>  > 
>  > [timer IRQ]
>  > new_tsc = read_rsc() - old_tsc;
>  > if (new_tsc < old_tsc + period_in_tsc_ticks)
>  > 	new_tsc = old_tsc + period_in_tsc;
>  > old_tsc = new_tsc;
>  > 
>  > Disclaimer: I haven't thought about potential accuracy side effects of
>  > this implementation, e.g. what would happen over the long term if the
>  > condition is always fulfilled and executed...
> 
> Here is what I meant:
> 
> [timer IRQ]
> irq_tsc = rdtsc();
> irq_jitter_ns = read_8254()
> 
> [xnpod_gettime_offset]
> offset_ns = tsc2ns(rdtsc() - irq_tsc()) + irq_jitter_ns
> if (offset_ns > period_ns)
>     offset_ns = period_ns; /* Avoid non monotonic clock. */
> 

Ah, I see. Hmm, wouldn't this create some "resolution hole" between the
time offset_ns exceeds a precise period and the time the next IRQ
actually strikes? The returned timestamps would then just stick to last
(irq_tsc + irq_jitter_ns) until the next update occurs.

Jan

