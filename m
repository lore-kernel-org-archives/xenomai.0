References: <1440608463-31708-1-git-send-email-henning.schild@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <55DE0659.9050803@siemens.com>
Date: Wed, 26 Aug 2015 20:32:57 +0200
MIME-Version: 1.0
In-Reply-To: <1440608463-31708-1-git-send-email-henning.schild@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] x86/ipipe: reserve irq num we use for
 IRQ_MOVE_CLEANUP_VECTOR
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, xenomai@xenomai.org

On 2015-08-26 19:01, Henning Schild wrote:
> vector_irq must not contain the same irq number for two different
> vectors because ipipe dispatches based on irq numbers.
> For the special case of IRQ_MOVE_CLEANUP_VECTOR, the ipipe patch
> inserts a new entry in vector_irq. To ensure the required uniqueness
> we have to make sure Linux will never make a vector point to irq number
> IRQ_MOVE_CLEANUP_VECTOR.
> 
> Before that patch ipipe did dispatch device interrupts that happened to
> receive number 32 (IRQ_MOVE_CLEANUP_VECTOR) to the cleanup function, the
> device effectively lost its interrupts. Up to 3.18 that was no problem
> since the allocator did not hand out the number ipipe failed to reserve.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  arch/x86/kernel/irqinit.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
> index e850981..5ca0ec7 100644
> --- a/arch/x86/kernel/irqinit.c
> +++ b/arch/x86/kernel/irqinit.c
> @@ -143,9 +143,12 @@ static void __init smp_intr_init(void)
>  	/* Low priority IPI to cleanup after moving an irq */
>  	set_intr_gate(IRQ_MOVE_CLEANUP_VECTOR, irq_move_cleanup_interrupt);
>  	set_bit(IRQ_MOVE_CLEANUP_VECTOR, used_vectors);
> +#ifdef CONFIG_IPIPE
> +	BUG_ON(IRQ_MOVE_CLEANUP_VECTOR != irq_alloc_descs(IRQ_MOVE_CLEANUP_VECTOR, 0, 1, 0));
>  	for_each_possible_cpu(cpu)
>  		per_cpu(vector_irq, cpu)[IRQ_MOVE_CLEANUP_VECTOR] =
>  			IRQ_MOVE_CLEANUP_VECTOR;
> +#endif

Looks like you picked up the instrumentation hunk instead of the actual
fix. ;)

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

