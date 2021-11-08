References: <879cd51a-f969-8710-0089-3871654aa2e3@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Minor dovetail x86 oddity
Date: Mon, 08 Nov 2021 08:58:09 +0100
In-reply-to: <879cd51a-f969-8710-0089-3871654aa2e3@siemens.com>
Message-ID: <87cznbt6vm.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>, "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>


Hi Jan,

Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> in this code
>
> (arch/x86/kernel/apic/vector.c)
> #ifdef CONFIG_SMP
>
> static struct irq_desc *__setup_vector_irq(int vector)
> {
> 	int isairq = vector - ISA_IRQ_VECTOR(0);
>
> 	/* Copy the cleanup vector if irqs are pipelined. */
> 	if (IS_ENABLED(CONFIG_SMP) &&
> 		vector == IRQ_MOVE_CLEANUP_VECTOR)
> 		return irq_to_desc(IRQ_MOVE_CLEANUP_VECTOR); /* 1:1 mapping */
>
> should it be "IS_ENABLED(CONFIG_IRQ_PIPELINE)"? Would only affect 
> !CONFIG_IRQ_PIPELINE in practice then, I suppose.
>
> Jan

Correct, the current conditional is definitely wrong. Thanks for
reviewing.

-- 
Philippe.

