Date: Sun, 24 May 2009 14:52:18 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <1242727683.17138.72.camel@domain.hid>
Message-ID: <Pine.LNX.4.64.0905241445410.32184@domain.hid>
References: <b131c9f0904230220j3f0a7d7ej9172ee4fb48aa69c@domain.hid> 
	<1240479431.6990.30.camel@domain.hid>
	<1240482629.7599.45.camel@domain.hid>
	<1240487288.6990.71.camel@domain.hid>
	<Pine.LNX.4.64.0904271229410.719@domain.hid>
	<49F640A0.4010904@domain.hid> <49F64500.50901@domain.hid> 
	<Pine.LNX.4.64.0904271720580.6463@domain.hid>
	<49F69187.9030402@domain.hid>
	<Pine.LNX.4.64.0904291204500.15719@domain.hid>
	<1242727683.17138.72.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Lockups on a new Celeron-430 system detected and
 resolved.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>


On Tue, 19 May 2009, Philippe Gerum wrote:
>...
> Could you try the following patch against 2.6.29.1-x86-2.3-01? TIA,

I've just tried this, and I'm happy to report that it appears to have
fixed the problem. With the patch in place, and with both HPET_TIMER
and X86_PM_TIMER enabled, I no longer see any lockups when running "dd
if=/dev/zero of=/dev/null". Thank you for fixing this.

> diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
> index 44378f8..7879469 100644
> --- a/arch/x86/kernel/ipipe.c
> +++ b/arch/x86/kernel/ipipe.c
> @@ -512,14 +512,14 @@ asmlinkage void __ipipe_unstall_iret_root(struct pt_regs regs)
> 			trace_hardirqs_on();
> 			__clear_bit(IPIPE_STALL_FLAG, &p->status);
> 		}
> -
> 		/*
> -		 * Only sync virtual IRQs here, so that we don't
> -		 * recurse indefinitely in case of an external
> -		 * interrupt flood.
> +		 * We could have received and logged interrupts while
> +		 * stalled in the syscall path: play the log now to
> +		 * release any pending event. The SYNC_BIT prevents
> +		 * infinite recursion in case of flooding.
> 		 */
> -		if ((p->irqpend_himask & IPIPE_IRQMASK_VIRT) != 0)
> -			__ipipe_sync_pipeline(IPIPE_IRQMASK_VIRT);
> +		if (p->irqpend_himask != 0)
> +			__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
> 	}
> #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
> 	ipipe_trace_end(0x8000000D);


