Message-ID: <470F42BE.9040105@domain.hid>
Date: Fri, 12 Oct 2007 11:47:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <470E8BFE.4070804@domain.hid> <1192180613.6499.57.camel@domain.hid>
In-Reply-To: <1192180613.6499.57.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] fix hw-timer setup/cleanup for i386
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai-core@domain.hid

Philippe Gerum wrote:
> On Thu, 2007-10-11 at 22:47 +0200, Jan Kiszka wrote:
>> This patch for SVN trunk fixes most of the current bugs around hardware
>> timer takeover and release from/to Linux. Tested and found working here
>> (including SMP):
>> - 2.6.22, APIC, highres=off, nohz=off
>> - 2.6.22, APIC, highres=on, nohz=on
>> - 2.6.20, APIC
>>
>> Tests to be done:
>> - 2.6.22, PIT (currently building...)
>> - 2.6.20, PIT
>>
>> Things became quite complex in i386/hal.c now. Some of this complexity
>> might be avoidable if RTHAL_APIC_TIMER_VECTOR equalled
>> LOCAL_TIMER_VECTOR. What's the reason for this? Is it something related
>> to pre-highres times of Linux (ie. 2.6.20 and earlier)? Can we overcome
>> it, at least for recent kernels?
> 
> The way it works resembles the way Linux works around an issue raised by
> broken APIC hardware, whose timer bluntly stalls when entering C3. For
> this reason, Linux keeps the i8253 as the master tick device, and
> broadcasts the APIC-based local timer vector on all CPUs from the tick
> handler. Not doing so would stop the timekeeping when entering a sleep
> mode (this what the tick-broadcast mode is about with generic clock
> events support in recent kernels).
> 
> This said, we do rely on the APIC timer to program the delivery of
> RTHAL_APIC_TIMER interrupts in oneshot mode, so the above work around
> does not help us a lot when it comes to C3 on broken hardware anyway.
> (Not to speak of the TSC which may stop when entering C2 or get
> corrupted in C3 in many cases too...)
> 
> Another issue to take into account is the cost of timekeeping through a
> Xenomai host timer and explicit propagation of a faked LOCAL_TIMER
> interrupt via the I-pipe, from the real-time domain to the root domain
> (what we would have to do in order to recycle the local timer vector),
> compared to the cost of letting the Linux timekeeping stuff live its own
> life in parallel, without any intervention from the Xenomai side.
> 
> To sum up, I'd say that we could work the way we are already running in
> PIT mode, and relay host ticks to Linux, freeing the local timer
> interrupt for our own use. But this may also be more expensive for the

Sorry, I can't follow your argumentation at this point: For 2.6.22, we
are now already relaying the Linux ticks, for _all_ configurations. In
the rare case that Linux decides to use the PIT (e.g. because the NMI
watchdog is active), the APIC does not work for us right now anyway.

So, if we are already relaying the host timer, my question remains why
we need to use a different APIC timer vector in this case. If we may
decide to enhance I-pipe in a way that it redirect Linux to the PIT
clockevent driver in case we want to use the APIC, than this is a
different discussion, of course.

> real-time side. We are lacking some benchmarks here, but this could be
> tested quite easily (we would need to disable IRQ0 when the host ticking
> service is handed over to Xenomai though).
> 

Yeah, good question: What is cheaper latency-wise, timer separation in
hardware or stacking in software? Performance-wise I think the
switch-back to the PIT is not optimal for the overall system.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

