From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <08A82EA4-797A-42C9-AE47-1A260D58E4DB@comcast.net>
References: <D0AF8C6A-CE07-4F45-A9E3-E82CB93F8500@domain.hid>
	<1237848861.13946.101.camel@domain.hid>
	<08A82EA4-797A-42C9-AE47-1A260D58E4DB@comcast.net>
Content-Type: text/plain
Date: Tue, 24 Mar 2009 00:18:58 +0100
Message-Id: <1237850338.13946.117.camel@domain.hid>
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

On Mon, 2009-03-23 at 19:03 -0400, Steven Seeger wrote:
> > What are you comparing, I mean, exactly?
> > All kernel RTAI vs all userland Xenomai?
> 
> Yes.
> 

Ok, so we will agree that the 20%/60% ratios can't be compared, in fact.

> >
> >
> > The timer handler is charged for the callbacks it runs, so it really
> > boils down to what code is attached to Xenomai timers, aside of the
> > built-in scheduler tick.
> 
> In this case we have only a single RTDM timer that fires ever 125 us  
> and does nothing (as a test.) It will be easy to remove this and  
> compare the amount of usage irq0 handler uses without it. I know it'll  
> be at least 14 or 15.

Let's check this anyway.

The fact that the GX still has to use a crappy 8253 PIT for timing and
must emulate the TSC using one of the PIT channels is not helping at
all. Emulating the TSC costs 1 x time_of(outb) + 2 x time_of(inb), each
time a timestamp is read via the rdtsc emulation code. That is costly.

> 
> >
> >
> > When you measure that load, what does /proc/xenomai/timerstat say?
> >
> >> I know
> >> there is some overhead with userspace calls but hte irq0 handler  
> >> alone
> >> accounts for 20% of it. Are there any options that can speed things  
> >> up?
> >>
> >
> > Yeah, but you won't like it: buy a Geode that has SEP support for
> > syscalls and a working TSC, then switch on --enable-x86-sep. Ok,
> > granted, that is _not_ funny.
> 
> We have a new Geode that has SEP and yes, things are faster. Just how  
> much overhead does syscall create?

It switches to supervisor mode using an interrupt (0x80); that logic is
really costly compared to the SEP entry. I'd say ~800ns-1us vs 200ns on
average for your target.

>  Is there no better option other  
> than SEP? If we could have kernel threads work without corrupting  
> userland FPU contexts then we could use our two higher priority  
> drivers in a kernel module to save overhead.

Btw, did you fix your driver code regarding the unprotected usage of FPU
in pure Linux kernel context? 

> 
> Is TSC really going to make that much of a difference? It seems that  
> xenomai uses PIT anyway.

Eh, no. TSC is always preferred when available.

>  We can build with TSC if we disable suspend  
> on halt and it works. If we do this the usage stays the same. It may  
> drop a couple tenths of a percent.

Frankly, those figures are really surprising. rdtsc() is about
100-200ns, running rthal_get_8254_tsc() is a lot, lot more.

> 
> > What would be interesting is to get the value reported for the timer
> > interrupt when the standard latency test runs at the same frequency  
> > than
> > your application does (use -p option).
> 
> So you mean look at cat /proc/stat/xenomai while running latency test - 
> p?
> 

No, when _your_ test runs.

> Steven
> 
-- 
Philippe.



