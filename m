Message-ID: <4422B9E6.6000907@domain.hid>
Date: Thu, 23 Mar 2006 16:08:22 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] IRQ latency with the ARM-9 based i.MXL/i.MX21
	from	Freescale
References: <FDBBB5CC70676540B3EF7CFE83FD94E0043100@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0043100@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

ROSSIER Daniel wrote:
> Hello,
> 
> We are still about to fix some timing issues with our Freescale i.MXL/i.MX21.
> 
> With our current port, we measured a delay between 6-7us between the timer IRQ and
> its reprogramming; this actually corresponds more or less to the IRQ latency which is inherent to the 
> IRQ handling layer. However, with a simple Linux without Xenomai, we got a latency of 5 us.
> 
> Having a deep look at the IRQ entry point in ipipe-root.c - the patch we used comes from 
> the patch for ARM available in the CVS - we discovered that __ipipe_handle_irq is performed before
> the timer reprogramming (i.e., before __ipipe_mach_set_dec()).
> We moved the call to __ipipe_handle_irq() at the end of the function, and we then got a latency of 2us; this is great, but....
> 

This is more a matter of accuracy in programming the timer shot than 
mere latency, since the code you are currently hacking is only used when 
Adeos helps emulating a periodic clock at a frequency different from the 
regular Linux one. IOW, this code is not used when running over Xenomai 
in oneshot mode, but only in periodic timing mode.
Since the delay is constant and does not account for the drift caused by 
the additional work done before reprogramming the next periodic shot, 
the loss of timing accuracy is explainable.

> Does this change have an impact on the upper layers of Adeos? Timer reprogramming at this level shouldn't be affected
> by other tasks, right? Can anybody confirm or not this?
> 

This is going to work, and this seems to be a correct fix. Any plans to 
post the full code of this port?

> I attached the function below.
> 
> Thanks a lot for your inputs.
> 
> Daniel
> 
> ----------------
> 
> asmlinkage int __ipipe_grab_irq(int irq, struct pt_regs *regs)
> {
> 	ipipe_declare_cpuid;
> 
> 	if (irq == __ipipe_mach_timerint) {
> 
> 		__ipipe_tick_regs[cpuid].ARM_cpsr = regs->ARM_cpsr;
> 		__ipipe_tick_regs[cpuid].ARM_pc = regs->ARM_pc;
> 
> 		__ipipe_handle_irq(irq, regs);
> 
> 		ipipe_load_cpuid();
> 
> 		if (__ipipe_decr_ticks != __ipipe_mach_ticks_per_jiffy) {
> 			unsigned long long next_date, now;
> 
> 			next_date = __ipipe_decr_next[cpuid];
> 
> 			while ((now = __ipipe_read_timebase()) >= next_date)
> 				next_date += __ipipe_decr_ticks;
> 
> 			__ipipe_mach_set_dec(next_date - now);
> 
> 			__ipipe_decr_next[cpuid] = next_date;
> 		}
> 	}
> 	else {
> 		__ipipe_handle_irq(irq, regs);
> 
> 		ipipe_load_cpuid();
> 	}
> 
> 	return (ipipe_percpu_domain[cpuid] == ipipe_root_domain &&
> 		!test_bit(IPIPE_STALL_FLAG,
> 			  &ipipe_root_domain->cpudata[cpuid].status));
> }
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 

Philippe.

