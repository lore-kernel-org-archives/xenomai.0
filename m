Subject: Re: [Adeos-main] [PATCH+HACK] optimise root stalling
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <451B949B.4090602@domain.hid>
References: <451786B3.4020506@domain.hid> <1159434450.4949.7.camel@domain.hid>
	<451B92C8.9050802@domain.hid> <1159434997.4949.9.camel@domain.hid>
	<451B949B.4090602@domain.hid>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 12:07:14 +0200
Message-Id: <1159438034.4949.25.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

On Thu, 2006-09-28 at 11:23 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Thu, 2006-09-28 at 11:15 +0200, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> On Mon, 2006-09-25 at 09:35 +0200, Jan Kiszka wrote:
> >>>
> >>> This one won't work. We need to forcibly re-enable the hw IRQs upon root
> >>> unstall requests, regardless of the fact that interrupts are pending in
> >>> the log; some code rely on this. E.g. Adeos/ppc over 2.4 would remain
> >>> stuck in the delay calibration routine, but there are other more tricky
> >>> places where this would bite too.
> >> But this would be ok?
> >>
> >> #else  /* !CONFIG_SMP */
> >>         __clear_bit(IPIPE_STALL_FLAG,
> >>                     &ipipe_root_domain->cpudata[cpuid].status);
> >>
> >>        if (unlikely(ipipe_root_domain->cpudata[cpuid].irq_pending_hi !=
> >>            0)) {
> >>                local_irq_disable_hw();
> >>                __ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
> >>        }
> >>        local_irq_enable_hw();
> >> #endif /* CONFIG_SMP */
> >>
> >> So we can still save one disable IRQ in the fastpath.
> >>
> > 
> > But in such a case, you would have to use clear_bit() to keep atomicity.
> 
> This is for UP, not SMP.
> 

This is not a UP vs SMP issue, the stall bit is strictly CPU local
anyway. The issue is that some archs do _not_ have intrinsically atomic
bitops; they need to emulate them by masking interrupts around the bit
setting operation. Using __clear_bit() in this context would make this
code preemptible by an interrupt in the middle of the bitop. Disabling
hw IRQs on entry allows us to use non-atomic bitops.

> Jan
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 
Philippe.



