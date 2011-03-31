From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <il5a9u$hss$1@domain.hid>
References: <il5a9u$hss$1@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 31 Mar 2011 10:32:16 +0200
Message-ID: <1301560336.2155.35.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [RFC] PPC 85xx: Support for doorbell-based IPIs
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Florian Boelstler <kernel@domain.hid>
Cc: adeos-main@gna.org

On Tue, 2011-03-08 at 14:17 +0100, Florian Boelstler wrote:
> Hi,
> 
> (repost from xenomai-core)

[snip]

> diff --git a/arch/powerpc/kernel/ipipe.c b/arch/powerpc/kernel/ipipe.c
> index 825dc26..1cfc918 100644
> --- a/arch/powerpc/kernel/ipipe.c
> +++ b/arch/powerpc/kernel/ipipe.c
> @@ -467,11 +467,35 @@ static int __ipipe_exit_irq(struct pt_regs *regs)
>       return 0;
>   }
> 
> +void __ipipe_grab_ipi(struct pt_regs *regs, int irq)
> +{
> +    //printk(KERN_INFO "%s(): I-pipe: irq %d\n", __func__, irq);
> +
> +    if (likely(irq != NO_IRQ_IGNORE)) {

AFAIU, this test will always match.

> +        ipipe_trace_irq_entry(irq);
> +#ifdef CONFIG_SMP
> +        /* Check for cascaded I-pipe IPIs */
> +        if (irq == __ipipe_ipi_irq)

__ipipe_ipi_virq normally matches the virq number of the debugger IPI
which is piggybacked for multiplexing more IPIs internally. I fail to
see how any doorbell IPI could ever match this test. I suspect that
everything gets channeled through __ipipe_handle_irq() here.

> +        {
> +            //printk(KERN_INFO "I-pipe: grabbed ipi irq %d\n", irq);
> +            __ipipe_ipi_demux(irq, regs);
> +        }
> +        else
> +#endif /* CONFIG_SMP */
> +            __ipipe_handle_irq(irq, regs);
> +    }
> +
> +    ipipe_trace_irq_exit(irq);
> +
> +    __ipipe_exit_irq(regs);
> +}
> +
>   asmlinkage int __ipipe_grab_irq(struct pt_regs *regs)
>   {
>       int irq;
> 
>       irq = ppc_md.get_irq();
> +    //printk(KERN_INFO "I-pipe: grabbed irq %d\n", irq);
>       if (unlikely(irq == NO_IRQ)) {
>           __get_cpu_var(irq_stat).spurious_irqs++;
>           return __ipipe_exit_irq(regs);
> @@ -482,7 +506,10 @@ asmlinkage int __ipipe_grab_irq(struct pt_regs *regs)
>   #ifdef CONFIG_SMP
>           /* Check for cascaded I-pipe IPIs */
>           if (irq == __ipipe_ipi_irq)
> +        {
> +            printk(KERN_INFO "I-pipe: ipi irq %d\n", irq);
>               __ipipe_ipi_demux(irq, regs);
> +        }
>           else
>   #endif /* CONFIG_SMP */
>               __ipipe_handle_irq(irq, regs);
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 5f7d048..2dc860c 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -113,6 +113,7 @@ void smp_message_recv(int msg)
>   #endif /* CONFIG_DEBUGGER */
>           /* FALLTHROUGH */
>       default:
> +        dump_stack();
>           printk("SMP %d: smp_message_recv(): unknown msg %d\n",
>                  smp_processor_id(), msg);
>           break;
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 2866cf0..344bc7a 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1386,6 +1386,7 @@ void vsx_assist_exception(struct pt_regs *regs)
>   void doorbell_exception(struct pt_regs *regs)
>   {
>   #ifdef CONFIG_SMP
> +    extern void __ipipe_grab_ipi(struct pt_regs *regs, int irq);

arch/powerpc/include/asm/ipipe.h

>       int cpu = smp_processor_id();
>       int msg;
> 
> @@ -1394,7 +1395,8 @@ void doorbell_exception(struct pt_regs *regs)
> 
>       for (msg = 0; msg < 4; msg++)
>           if (test_and_clear_bit(msg, &dbell_smp_message[cpu]))
> -            smp_message_recv(msg);
> +            //smp_message_recv(msg);
> +            __ipipe_grab_ipi(regs,255-(4-msg));

Some hint in the code about the way you determine the doorbell IRQ
number would be useful.

This patch is missing a critical piece for stability.
In the regular Adeos/powerpc support (head_32.S), check why this:
EXCEPTION(0x500, HardwareInterrupt, do_IRQ, EXC_XFER_LITE)
is replaced by that:
EXCEPTION(0x500, HardwareInterrupt, __ipipe_grab_irq, EXC_XFER_IPIPE)

The logic should be the same for the doorbell intercept code, albeit
adapted for full transfer with all GPRS being restored upon exit.

Hint: because the interrupt mask is virtualized, we may receive a
doorbell while linux _thinks_ it has disabled IRQ, it just happens that
the interrupt pipeline won't deliver it immediately, but will wait for
the kernel to unstall the root stage. __ipipe_ret_from_except makes sure
that linux is accepting IRQs before running the regular return path from
interrupt, i.e. looking for pending rescheduling, signals etc.

OTOH, if we allow any interrupt to take the normal linux return path
even in cases where linux was not supposed to accept IRQs (e.g. between
local_irq_enable/disable sections), then things are likely to go wrong
shortly after.

>   #else
>       printk(KERN_WARNING "Received doorbell on non-smp system\n");
>   #endif
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main

-- 
Philippe.



