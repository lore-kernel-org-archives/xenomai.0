Subject: Re: [dovetail][PATCH] x86: pipeline: Fix vector stall after vector
 error handling
References: <20211108060011.612786-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <587c03cd-64dc-fd28-8bf8-12d6b0f3ee5d@siemens.com>
Date: Mon, 8 Nov 2021 07:54:14 +0100
MIME-Version: 1.0
In-Reply-To: <20211108060011.612786-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org, rpm@xenomai.org

On 08.11.21 07:00, Florian Bezdeka wrote:
> Whenever an IRQ was handled for a vector being NULL or in one of the
> error states the interrupt was not acknowledged at the APIC. That can
> happen if a vector is cleaned up by one of the device drivers while
> there is still one IRQ in flight.
> 
> This has two effects:
>   - If the affected vector is re-assigned later, it does not work, the
>     IRQ never makes its way to the CPU
>   - Interrupts with lower priority are no longer delivered to the CPU
> 
> The problem was observed on a quite big Intel XEON machine where some
> vectors / irqs were temporary used and cleaned up and re-assigned
> later.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/x86/kernel/irq_pipeline.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
> index 48d9959bc11a..63de68141b21 100644
> --- a/arch/x86/kernel/irq_pipeline.c
> +++ b/arch/x86/kernel/irq_pipeline.c
> @@ -239,6 +239,8 @@ void arch_handle_irq(struct pt_regs *regs, u8 vector, bool irq_movable)
>  	} else {
>  		desc = __this_cpu_read(vector_irq[vector]);
>  		if (unlikely(IS_ERR_OR_NULL(desc))) {
> +			__ack_APIC_irq();
> +
>  			if (desc == VECTOR_UNUSED) {
>  				pr_emerg_ratelimited("%s: %d.%u No irq handler for vector\n",
>  						__func__, smp_processor_id(),
> 

Nice catch! And very hard work to get there - well done!

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

