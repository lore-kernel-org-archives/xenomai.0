From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <D0AF8C6A-CE07-4F45-A9E3-E82CB93F8500@domain.hid>
References: <D0AF8C6A-CE07-4F45-A9E3-E82CB93F8500@domain.hid>
Content-Type: text/plain
Date: Mon, 23 Mar 2009 23:54:21 +0100
Message-Id: <1237848861.13946.101.camel@domain.hid>
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

On Mon, 2009-03-23 at 15:59 -0400, Steven Seeger wrote:
> We are still running into issues where irq0 is using a lot of CPU  
> time. The same threads on an RTAi system on the same hardware used  
> about 13% of the CPU but are using closer to 60% on Xenomai.

What are you comparing, I mean, exactly?
All kernel RTAI vs all userland Xenomai?

The timer handler is charged for the callbacks it runs, so it really
boils down to what code is attached to Xenomai timers, aside of the
built-in scheduler tick.

When you measure that load, what does /proc/xenomai/timerstat say?

>  I know  
> there is some overhead with userspace calls but hte irq0 handler alone  
> accounts for 20% of it. Are there any options that can speed things up?
> 

Yeah, but you won't like it: buy a Geode that has SEP support for
syscalls and a working TSC, then switch on --enable-x86-sep. Ok,
granted, that is _not_ funny.

What would be interesting is to get the value reported for the timer
interrupt when the standard latency test runs at the same frequency than
your application does (use -p option).

> We've tried both one shot and periodic modes. I confirmed that the ISA  
> i/o timing is 1.3usec per outb as expected.
> 
> Steven
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



