From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C87BFA3.5040207@domain.hid>
References: <4C87BFA3.5040207@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 13 Sep 2010 09:51:50 +0200
Message-ID: <1284364310.24088.786.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] x86-32: Unpreemptible return from
	__ipipe_handle_irq
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Wed, 2010-09-08 at 18:53 +0200, Jan Kiszka wrote:
> Hi Philippe,
> 
> __ipipe_handle_irq:
> 
> #if defined(CONFIG_X86_32) && defined(CONFIG_SMP)
> 	/*
> 	 * Prevent a spurious rescheduling from being triggered on
> 	 * preemptible kernels along the way out through
> 	 * ret_from_intr.
> 	 */
> 	if ((long)regs->orig_ax < 0)
> 		__set_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status));
> #endif	/* CONFIG_SMP */
> 
> But this defeats any preemption of kernel contexts on CONFIG_PREEMPT,
> doesn't it? __ipipe_test_preemption should now always fail.
> 
> What kind of spurious rescheduling has to be prevented?

This hack was introduced in 2.6.9; disabling preemption on the IRQ
return path was working around a SMP issue causing a crash. I would not
be surprised if such code was only papering over a migration issue in
fact, which probably disappeared later in the pipeline implementation.
x86_64 never required this, and it is likely time to re-assess the need
for this hack, and fix the issue properly if ever it still makes sense.

> 
> Jan
> 

-- 
Philippe.



