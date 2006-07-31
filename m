Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44CD2C0C.3@domain.hid>
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>
	<200607221152.34298.bidsonux@domain.hid> <44C25DB0.50601@domain.hid>
	<200607282317.34990.bidsonux@domain.hid>  <44CB6EB3.5070707@domain.hid>
	<1154282619.4970.25.camel@domain.hid>  <44CD099F.9010507@domain.hid>
	<1154294584.4970.49.camel@domain.hid>  <44CD2C0C.3@domain.hid>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 11:57:32 +0200
Message-Id: <1154339852.4977.22.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-07-31 at 00:00 +0200, Jan Kiszka wrote:

<snip>

> > I'd like to explain why we don't we see any other routines than
> > xnthread_aperiodic_handler called from xntimer_do_tick_aperiodic in the
> > call frame? Even in case of massive jittery (e.g. > 300 us late) in one
> > shot, we should not spin in this code, due to the resync done in
> > xnpod_wait_thread_timeout - assuming we only have a single outstanding
> > timer (+ the host tick, but this should not be an issue).
> 
> xnpod_wait_thread_timeout? Do you mean xnpod_wait_thread_period? How
> should it help us as long as we are in the tick handler?
> 

Yes, I meant xnpod_wait_thread_period; forget about this, brain is
missing ECC feature. I misread the tracer output.

> > 
> >> I rather think, also when looking at Julien's second trace, that we have
> >> some issue with X in user-space here, probably in combination with weird
> >> VIA hardware stalling IRQ delivery for a "few" microseconds. Let's see
> >> if the irqbench gives similar results.
> >>
> > 
> > The problem is that I can reproduce X-related jittery (> 2 ms in a row)
> > on one of my test boxen when dragging windows over the screen, without
> > triggering the NMI watchdog set to 100 us (and guess what, the chipset
> > in question is from VIA).
> 
> Does NMI management happen in the CPU or has the chipset any influence
> as well?

I was referring to something like SMI# -> SMM which disables IRQs _and_
the NMI# and INIT# lines, in which case, the chipset would be at the
root of the problem. Since we cannot guarantee that our existing SMI
work-around blocks all potential SMI sources/events (hence the name), we
cannot exclude such possibility.

>  If yes, I could imagine what VIA does here... Have you already
> checked what irqbench records?
> 

Not yet.

> Jan
> 
-- 
Philippe.



