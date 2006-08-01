Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1154355564.5015.12.camel@domain.hid>
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>
	<200607221152.34298.bidsonux@domain.hid> <44C25DB0.50601@domain.hid>
	<200607282317.34990.bidsonux@domain.hid> <44CB6EB3.5070707@domain.hid>
	<1154282619.4970.25.camel@domain.hid> <44CD099F.9010507@domain.hid>
	<1154294584.4970.49.camel@domain.hid>
	<17613.60380.820599.627459@domain.hid>
	<1154355564.5015.12.camel@domain.hid>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 16:30:26 +0200
Message-Id: <1154442627.4963.21.camel@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Mon, 2006-07-31 at 16:19 +0200, Philippe Gerum wrote:
> On Mon, 2006-07-31 at 13:39 +0200, Gilles Chanteperdrix wrote:
> > Philippe Gerum wrote:
> >  > > I rather think, also when looking at Julien's second trace, that we have
> >  > > some issue with X in user-space here, probably in combination with weird
> >  > > VIA hardware stalling IRQ delivery for a "few" microseconds. Let's see
> >  > > if the irqbench gives similar results.
> >  > > 
> >  > 
> >  > The problem is that I can reproduce X-related jittery (> 2 ms in a row)
> >  > on one of my test boxen when dragging windows over the screen, without
> >  > triggering the NMI watchdog set to 100 us (and guess what, the chipset
> >  > in question is from VIA).
> > 
> > IMHO there are two reasons why the NMI watchdog may not trig:
> > - its code is broken (we already have an unsolved bug that shows us that
> >   maybe it does not work as we believe)
> > - the NMI watchdog only counts busy cycles, so maybe the CPU is not busy
> >   during these 2 ms, it is spinning, waiting for the GPU to finish the
> >   work using the rep; nop instruction in order to allow power
> >   saving. But with interrupts off.
> 
> > Maybe disabling hardware acceleration in your X server configuration
> > would help ?
> > 
> 
> Still, reinitializing X while the latency test runs causes
> the latter to hang, albeit LOC is still flowing properly and the box
> keeps going normally.

This one was due to the nucleus watchdog which triggered right after the
graphic mode was fully initialized, due to the huge amount of
unpreemptible time spent doing this; this caused the sampling task to be
detected as a runaway thread. So the behaviour is ok, albeit a bit
frightening at first.

-- 
Philippe.



