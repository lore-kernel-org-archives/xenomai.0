Date: Tue, 9 Feb 2010 11:46:14 +0100
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20100209104614.GA26894@domain.hid>
References: <1257328464.2210.66.camel@domain.hid>
	<20091104111536.GA14614@domain.hid>
	<1257334005.2210.86.camel@domain.hid>
	<20091104140832.GA32220@domain.hid>
	<20091104181907.GA24561@domain.hid>
	<1257372981.2210.160.camel@domain.hid>
	<20091106081033.GA5306@domain.hid>
	<1257496018.2210.243.camel@domain.hid>
	<20091106092018.GB5306@domain.hid>
	<1257499920.2210.247.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257499920.2210.247.camel@domain.hid>
Subject: Re: [Xenomai-core] [Xenomai core] Freeze on MPC8572 and P2020 with
	SMP
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, Nov 06, 2009 at 10:32:00AM +0100, Philippe Gerum wrote:
> On Fri, 2009-11-06 at 10:20 +0100, Richard Cochran wrote:
> > Yes, works fine now. Thanks for your help.

I am working again on PowerPC, and I now notice that I spoke too
soon. I had fixed the problem for myself, in a different way.

The fix you gave is still not quite right.

> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 8968b24..a4fe229 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -164,16 +164,16 @@ int smp_request_message_ipi(int virq, int msg)
>  	if (msg < 0 || msg > PPC_MSG_DEBUGGER_BREAK) {
>  		return -EINVAL;
>  	}

Even if this block...

> -#if !defined(CONFIG_DEBUGGER) && !defined(CONFIG_KEXEC)
> -	if (msg == PPC_MSG_DEBUGGER_BREAK) {
> -		return 1;
> -	}
> -#endif

>  #ifdef CONFIG_IPIPE
>  	if (msg == PPC_MSG_DEBUGGER_BREAK)
>  		/* Piggyback the debugger IPI for the I-pipe. */
>  		__ipipe_register_ipi(virq);
>  #endif

appears here...

> +#if !defined(CONFIG_DEBUGGER) && !defined(CONFIG_KEXEC)
> +	if (msg == PPC_MSG_DEBUGGER_BREAK) {
> +		return 1;
> +	}
> +#endif

it still prevents the following call...

>  	err = request_irq(virq, smp_ipi_action[msg], IRQF_DISABLED|IRQF_PERCPU,
>  			  smp_ipi_name[msg], 0);

The function, smp_request_message_ipi(), is called unconditionally
with virq=0,1,2,3, and 3=PPC_MSG_DEBUGGER_BREAK. AFAICT, ipipe needs
the call to request_irq() to go through.

I suggest:

#ifdef CONFIG_IPIPE
	if (msg == PPC_MSG_DEBUGGER_BREAK)
		/* Piggyback the debugger IPI for the I-pipe. */
		__ipipe_register_ipi(virq);
#else
#if !defined(CONFIG_DEBUGGER) && !defined(CONFIG_KEXEC)
	if (msg == PPC_MSG_DEBUGGER_BREAK) {
		return 1;
	}
#endif
#endif

Richard

