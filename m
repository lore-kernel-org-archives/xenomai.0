Message-ID: <4932742F.30803@domain.hid>
Date: Sun, 30 Nov 2008 12:08:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <af29ce600811170122q83ee743ic771a6f07a70e9b9@domain.hid>		<492143DF.8040508@domain.hid>		<af29ce600811170328v79cfa0f0k46d1491c46046f5e@domain.hid>		<49217095.7080902@domain.hid>		<af29ce600811210417u3fcb07b9kbdc2fde3e1451f74@domain.hid>		<4926B3DB.9090100@domain.hid>	<af29ce600811210730n5272bb11naa94eac6630d716f@domain.hid>
	<4926D775.8010102@domain.hid> <493114A5.4060702@domain.hid>
In-Reply-To: <493114A5.4060702@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] NETDEV WATCHDOG on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: koansoftware@domain.hid
Cc: Xenomai help <xenomai@xenomai.org>

Marco Cavallini wrote:
> Gilles Chanteperdrix ha scritto:
>> Stefano Gafforelli wrote:
>>> With additional patch...do you think that the problem is due to the relation
>>> between additional patch and xenomai?
>> Yes, that is something possible. Normally, we try to test that Xenomai
>> is compatible with the AT91 patch, but some error may escape, and we
>> never tested the ronetix patch, which I do not know. So, please test
>> without these additional patches.
>>
>> P.S: please always CC the mailing list.
>>
> 
> Working with Stefano we pointed out some issues.
> 
> 1. we successfully build linux-2.6.26 with xenomai-2.4.6.1 adding a
> little patch.

What little patch ?

> 2. we tested it on an AT91SAM9261 board and noticed that latency freezes
> at "warming up..."

This is a known issue: the default period of 100us is too short on ARM.
So, you need to run latency with the -p 1000 option. If you enable FCSE,
you may be able to run latency -p 100, but will observer overruns under
load.

> 3. so we returned to the 'stable' linux-2.6.25 with xenomai-2.4.4
> 4. testing latency with this version succeeded
> 5. unfortunately network is not working so after debugging Stefano
> dicovered that executing irq_finish(irq) in asm_do_IRQ()
> [arch/arm/kernel/irq.c] made network working.
> 
> 
> asmlinkage void __exception asm_do_IRQ(unsigned int irq, struct pt_regs
> *regs)
> {
>         struct pt_regs *old_regs = set_irq_regs(regs);
>         struct irq_desc *desc = irq_desc + irq;
> 
>         /*
>          * Some hardware gives randomly wrong interrupts.  Rather
>          * than crashing, do something sensible.
>          */
>         if (irq >= NR_IRQS)
>                 desc = &bad_irq_desc;
> 
>         irq_enter();
> 
>         desc_handle_irq(irq, desc);
> 
> //#ifndef CONFIG_IPIPE
>         /* AT91 specific workaround */
>         irq_finish(irq);
> //#endif /* !CONFIG_IPIPE */
> 
>         irq_exit();
>         set_irq_regs(old_regs);
> }
> 
> 
> We wonder why irq_finish() is not executed here when using IPIPE mode in
> this asm_do_IRQ(().
> 
> Any hint will be greatly appreciated :-)

This has been discussed both on Xenomai mailing list and linux arm
kernel mailing list: running irq_finish here is very wrong, since it
means that only higher priority interrupts may be run before the current
interrupt has finished running (so, for instance, a high priority non
real-time interrupt may prevent low priority real-time interrupt from
runing). The proper place to run irq_finish is as soon as the interrupt
has been masked and acked.

Now, what we have to wonder is why irq_finish is not run for the
ethernet driver interrupt. Is it a multiplexed interrupt ?

> 
> 
> /marco & stefano
> 


-- 
					    Gilles.

