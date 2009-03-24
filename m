From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <CA6F6312-6598-4C76-A36A-CD465CB3236D@comcast.net>
References: <D0AF8C6A-CE07-4F45-A9E3-E82CB93F8500@domain.hid>
	<1237848861.13946.101.camel@domain.hid>
	<08A82EA4-797A-42C9-AE47-1A260D58E4DB@comcast.net>
	<1237850338.13946.117.camel@domain.hid>
	<CA6F6312-6598-4C76-A36A-CD465CB3236D@comcast.net>
Content-Type: text/plain
Date: Tue, 24 Mar 2009 09:59:12 +0100
Message-Id: <1237885152.6815.35.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] irq0 usage
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Seeger <steven.seeger@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2009-03-23 at 19:32 -0400, Steven Seeger wrote:
> > Ok, so we will agree that the 20%/60% ratios can't be compared, in  
> > fact.
> 
> Do you mean that this is not a fair comparison or that I should not be  
> this slow compared to RTAI?
> 

I mean that you were comparing apples to oranges. If you really want to
compare them in order to figure out if a significant loss of performance
happened, then run your application in an RTAI/LXRT context in userland.

> > The fact that the GX still has to use a crappy 8253 PIT for timing and
> > must emulate the TSC using one of the PIT channels is not helping at
> > all. Emulating the TSC costs 1 x time_of(outb) + 2 x time_of(inb),  
> > each
> > time a timestamp is read via the rdtsc emulation code. That is costly.
> 
> Do you agree that if I build with TSC on and disable suspend on halt  
> (or use idle=poll) that xenomai will use rdtsc?

Xenomai will use rdtsc as soon as the kernel wants to use it. And the
kernel will do that as soon as the CPU model you picked in your setup
does exhibit TSC support. This is not a matter of Xenomai choosing to
ignore TSC support when available to the kernel, this never happens.
I seem to remember that your target has a bad TSC and loses time, unless
idle=poll is given; at the same time, we don't handle the SCx200 hires
timer that is Geode-specific, so there is likely no fallback option to
this issue but using idle=poll.

> 
> > It switches to supervisor mode using an interrupt (0x80); that logic  
> > is
> > really costly compared to the SEP entry. I'd say ~800ns-1us vs 200ns  
> > on
> > average for your target.
> 
> This is bad, but since our fastest userspace period is 500us it is not  
> a dealbreaker. Just rt_task_wait_next_period() and one mutex lock/ 
> unlock is too much for it.
> 

2.4.x will issue 3 syscalls there, 2.5.x only 1 most of the time.
If you really want to understand what is going on your system, you
should definitely enable the I-pipe tracer, and have a look at the
processing that takes place.

In any case, 3 syscalls over a 2Khz loop are no big deal over a sane hw;
the problem I see is that your target is cumulating a lot of issues:
buggy TSC, no SEP, sluggish ISA bus, no local APIC, braindamage C3
state. It's a bit like that hw would want to prevent you from using it
in real-time mode, I mean.

Again, the best way to know what is going on is to get a trace snapshot
from the I-pipe tracer. You would get detailed timing information for
kernel space activity, on a per-routine basis.

> > Btw, did you fix your driver code regarding the unprotected usage of  
> > FPU
> > in pure Linux kernel context?
> 
> Yes in fact the new driver does not use floats at all. It's purely  
> integer math.
> 
> > Eh, no. TSC is always preferred when available.
> 
> I was looking at rthal_timer_program_shot().
> 

This is used to program the next aperiodic shot and this should not
happen more than once per sample. OTOH, getting the CPU time via the TSC
emulation occurs a few times per sample.

> > Frankly, those figures are really surprising. rdtsc() is about
> > 100-200ns, running rthal_get_8254_tsc() is a lot, lot more.
> 
> I asked above if what we did would really use the TSC or not. What do  
> you think?
> 

Do you have CONFIG_X86_TSC enabled in your kernel config? If so, then
you do use TSC with Xenomai as well.

> > No, when _your_ test runs.
> 
> So we should run latency -p and then our test and look at the output?
> 

Run latency -p 500 in the same load conditions than your app, and while
this is running:

- dump /proc/xenomai/timerstat; we will find out what timers are
outstanding. 
- dump /proc/xenomai/stat a few times; we will find out the typical CPU
consumption of the timer tick.

Then, do the same with your application, and send the outputs.

> Thanks,
> Steven
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



