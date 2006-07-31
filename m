From: Julien Heyman <bidsonux@domain.hid>
Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
Date: Mon, 31 Jul 2006 22:49:08 +0200
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>
	<17613.60380.820599.627459@domain.hid>
	<1154355564.5015.12.camel@domain.hid>
In-Reply-To: <1154355564.5015.12.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607312249.09615.bidsonux@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>

On Monday 31 July 2006 16:19, Philippe Gerum wrote:
> On Mon, 2006-07-31 at 13:39 +0200, Gilles Chanteperdrix wrote:
> > Philippe Gerum wrote:
> >  > > I rather think, also when looking at Julien's second trace, that we
> >  > > have some issue with X in user-space here, probably in combination
> >  > > with weird VIA hardware stalling IRQ delivery for a "few"
> >  > > microseconds. Let's see if the irqbench gives similar results.
> >  >
> >  > The problem is that I can reproduce X-related jittery (> 2 ms in a
> >  > row) on one of my test boxen when dragging windows over the screen,
> >  > without triggering the NMI watchdog set to 100 us (and guess what, the
> >  > chipset in question is from VIA).
> >
> > IMHO there are two reasons why the NMI watchdog may not trig:
> > - its code is broken (we already have an unsolved bug that shows us that
> >   maybe it does not work as we believe)
> > - the NMI watchdog only counts busy cycles, so maybe the CPU is not busy
> >   during these 2 ms, it is spinning, waiting for the GPU to finish the
> >   work using the rep; nop instruction in order to allow power
> >   saving. But with interrupts off.
> >
> > Maybe disabling hardware acceleration in your X server configuration
> > would help ?
>
> Yes it does. Option "NoAccel" in the Screen section fixes the latency on
> the test box. Still, reinitializing X while the latency test runs causes
> the latter to hang, albeit LOC is still flowing properly and the box
> keeps going normally. OTOH, switching from text mode to graphic mode
> does not perturbate the test anymore.

Some good news from my side :
I did the same on my EPIA box (added Option "NoAccel" in the Device section 
referring to the Trident video driver) and since then the latency test works 
like a charm. Zero overrun, and a stable max value (around 50 microseconds), 
even when I launch multiple heavy applications at the same time.
Display performance has obviously taken a bit hit, but this is not my main 
concern for now.
Thanks for the tip, there is no way I would have figured that one out by 
myself ;)
(Jan, Gilles, thx for all of your good advice too !)
It's time for me to play with Xenomai now.

Regards,
Julien Heyman

