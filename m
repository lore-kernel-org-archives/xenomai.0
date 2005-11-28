Message-ID: <438B8472.50906@domain.hid>
Date: Mon, 28 Nov 2005 23:28:02 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] latency tracing
References: <438B6F43.4060104@domain.hid>
In-Reply-To: <438B6F43.4060104@domain.hid>
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
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> as I'm lazy, er busy, I'm pushing this idea into public instead of
> hacking a patch on my own: wouldn't it be nice to have something like
> the latency backtrace of PREEMPT_RT also in Xenomai?

Yes; we would had saved a lot of time with a precise debug 
instrumentation in place in the early fusion days. It's a lesson for the 
future.

  Even when the core
> is once optimised ;), there can still be drivers with long IRQ locks
> nuking the WCET.
> 
> I saw that there is already something for SMP spinlock debugging. Is it
> a lot of work to extend this to UP and maybe even all IRQ-off locks?

AFAICS, it's basically a matter of decoupling CONFIG_SMP and 
CONFIG_XENO_SPINLOCK_DEBUG, so that we'd allow a dummy spinlock to exist 
even in UP, just to carry on with the statistics collection.

  Did
> someone already look at the backtrace implementation of PREEMPT_RT in
> details?

There are different levels of support for this, but basically, mcount() 
support has been crafted for the kernel so that gcc can be asked to 
insert prologue/epilogue calls in every routine when -pg is passed. 
Additionally, a global trace function keeps a copy of internal timings 
and callers %eip when traversed.

  Is is complicated to port?

mcount() support should be fairly manageable to port.

  Does it require some changes at
> ADEOS level?
>

Don't think so. gcc would do the job for the whole kernel anyway using 
mcount(), and trace calls could be spreaded as needed otherwise.

> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

