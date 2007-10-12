From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <470F42BE.9040105@domain.hid>
References: <470E8BFE.4070804@domain.hid> <1192180613.6499.57.camel@domain.hid>
	<470F42BE.9040105@domain.hid>
Content-Type: text/plain
Date: Fri, 12 Oct 2007 14:48:49 +0200
Message-Id: <1192193329.6499.112.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] fix hw-timer setup/cleanup for i386
Reply-To: rpm@xenomai.org
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
Cc: Xenomai-core@domain.hid

On Fri, 2007-10-12 at 11:47 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Thu, 2007-10-11 at 22:47 +0200, Jan Kiszka wrote:
> >> This patch for SVN trunk fixes most of the current bugs around hardware
> >> timer takeover and release from/to Linux. Tested and found working here
> >> (including SMP):
> >> - 2.6.22, APIC, highres=off, nohz=off
> >> - 2.6.22, APIC, highres=on, nohz=on
> >> - 2.6.20, APIC
> >>
> >> Tests to be done:
> >> - 2.6.22, PIT (currently building...)
> >> - 2.6.20, PIT
> >>
> >> Things became quite complex in i386/hal.c now. Some of this complexity
> >> might be avoidable if RTHAL_APIC_TIMER_VECTOR equalled
> >> LOCAL_TIMER_VECTOR. What's the reason for this? Is it something related
> >> to pre-highres times of Linux (ie. 2.6.20 and earlier)? Can we overcome
> >> it, at least for recent kernels?
> > 
> > The way it works resembles the way Linux works around an issue raised by
> > broken APIC hardware, whose timer bluntly stalls when entering C3. For
> > this reason, Linux keeps the i8253 as the master tick device, and
> > broadcasts the APIC-based local timer vector on all CPUs from the tick
> > handler. Not doing so would stop the timekeeping when entering a sleep
> > mode (this what the tick-broadcast mode is about with generic clock
> > events support in recent kernels).
> > 
> > This said, we do rely on the APIC timer to program the delivery of
> > RTHAL_APIC_TIMER interrupts in oneshot mode, so the above work around
> > does not help us a lot when it comes to C3 on broken hardware anyway.
> > (Not to speak of the TSC which may stop when entering C2 or get
> > corrupted in C3 in many cases too...)
> > 
> > Another issue to take into account is the cost of timekeeping through a
> > Xenomai host timer and explicit propagation of a faked LOCAL_TIMER
> > interrupt via the I-pipe, from the real-time domain to the root domain
> > (what we would have to do in order to recycle the local timer vector),
> > compared to the cost of letting the Linux timekeeping stuff live its own
> > life in parallel, without any intervention from the Xenomai side.
> > 
> > To sum up, I'd say that we could work the way we are already running in
> > PIT mode, and relay host ticks to Linux, freeing the local timer
> > interrupt for our own use. But this may also be more expensive for the
> 
> Sorry, I can't follow your argumentation at this point:

>  For 2.6.22, we
> are now already relaying the Linux ticks, for _all_ configurations. In
> the rare case that Linux decides to use the PIT (e.g. because the NMI
> watchdog is active), the APIC does not work for us right now anyway.

I will happily see this legacy code improved if we can do this without
adding too much complexity. The recent surge of bugs in this area pleads
for both sides.

So, yes, we do relay ticks when generic clock events are available, this
was a recent change of mine when porting over this infrastructure for
2.6.22. But as you know, this won't work for anything earlier, until we
move the whole damn thing under host tick emulation for everyone. And to
get to that point, we will first need to recycle the local timer for
every purpose, when the APIC is enabled, as you initially suggested.

Making this change is a no-brainer implementation-wise, I'm just
-reasonably- worried about the performance cost imposed on the real-time
side. Hence the open question I raised.

> So, if we are already relaying the host timer, my question remains why
> we need to use a different APIC timer vector in this case. If we may
> decide to enhance I-pipe in a way that it redirect Linux to the PIT
> clockevent driver in case we want to use the APIC, than this is a
> different discussion, of course.
> 
> > real-time side. We are lacking some benchmarks here, but this could be
> > tested quite easily (we would need to disable IRQ0 when the host ticking
> > service is handed over to Xenomai though).
> > 
> 
> Yeah, good question: What is cheaper latency-wise, timer separation in
> hardware or stacking in software? Performance-wise I think the
> switch-back to the PIT is not optimal for the overall system.

Except that in such a case, we don't need any non-preemptible real-time
code to be executed in order to schedule the interrupt for processing by
the kernel. Faking the interrupt through propagation to each CPU would
clearly add more pressure on the nklock too, even if we try hard to
stagger the per-CPU clocks to avoid obvious contentions. IOW, moving
everything on top of Xenomai's core timer would cause Xenomai to spend
some time in a non-preemptible way in order to relay the tick to Linux
for each CPU, and that could have an impact latency-wise, maybe.

We need benchmark figures to sort out this issue, at least to measure
the cost induced by host tick emulation on top of the Xenomai domain,
including in SMP mode.

> 
> Jan
> 
-- 
Philippe.



