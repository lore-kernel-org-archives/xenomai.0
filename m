Message-Id: <CA6F6312-6598-4C76-A36A-CD465CB3236D@comcast.net>
From: Steven Seeger <steven.seeger@domain.hid>
In-Reply-To: <1237850338.13946.117.camel@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Mon, 23 Mar 2009 19:32:44 -0400
References: <D0AF8C6A-CE07-4F45-A9E3-E82CB93F8500@domain.hid>
	<1237848861.13946.101.camel@domain.hid>
	<08A82EA4-797A-42C9-AE47-1A260D58E4DB@comcast.net>
	<1237850338.13946.117.camel@domain.hid>
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
To: xenomai@xenomai.org

> Ok, so we will agree that the 20%/60% ratios can't be compared, in  
> fact.

Do you mean that this is not a fair comparison or that I should not be  
this slow compared to RTAI?

> The fact that the GX still has to use a crappy 8253 PIT for timing and
> must emulate the TSC using one of the PIT channels is not helping at
> all. Emulating the TSC costs 1 x time_of(outb) + 2 x time_of(inb),  
> each
> time a timestamp is read via the rdtsc emulation code. That is costly.

Do you agree that if I build with TSC on and disable suspend on halt  
(or use idle=poll) that xenomai will use rdtsc?

> It switches to supervisor mode using an interrupt (0x80); that logic  
> is
> really costly compared to the SEP entry. I'd say ~800ns-1us vs 200ns  
> on
> average for your target.

This is bad, but since our fastest userspace period is 500us it is not  
a dealbreaker. Just rt_task_wait_next_period() and one mutex lock/ 
unlock is too much for it.

> Btw, did you fix your driver code regarding the unprotected usage of  
> FPU
> in pure Linux kernel context?

Yes in fact the new driver does not use floats at all. It's purely  
integer math.

> Eh, no. TSC is always preferred when available.

I was looking at rthal_timer_program_shot().

> Frankly, those figures are really surprising. rdtsc() is about
> 100-200ns, running rthal_get_8254_tsc() is a lot, lot more.

I asked above if what we did would really use the TSC or not. What do  
you think?

> No, when _your_ test runs.

So we should run latency -p and then our test and look at the output?

Thanks,
Steven

