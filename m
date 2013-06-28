Message-ID: <51CDA46C.6040100@xenomai.org>
Date: Fri, 28 Jun 2013 16:57:48 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51CD99C6.2050409@mitrol.it>
In-Reply-To: <51CD99C6.2050409@mitrol.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Disable all iinterrupts on xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Cc: xenomai@xenomai.org

On 06/28/2013 04:12 PM, Paolo Minazzi wrote:
> Hi to all
>
> I have to disable completely interrupts on arm on xenomai 2.5.6
> I have a small piece of code that no one must interrupt.
>
> I have seen there are a lot of #define and I have tried all.
> 1) rthal_local_irq_save
> 2) local_irq_save_hw
> 3) rthal_irq_disable (this seems to work but I have to disable all irq
> lines)

Nope. rthal_irq_disable() is the strict equivalent of 
local_irq_disable() from a non-virtualized IRQ context. This masks out 
interrupts at CPU level.

> 4) inline asm on cpsr register with mask 0x40 and 0x80
>

This may not be what you need, as this does not account for the 
virtualized interrupt state the interrupt pipeline manages.

> I have tried all, but the best way seems
>
> #define my_local_irq_save(x)      ((x) =
> ipipe_test_and_stall_pipeline_head() & 1)
> #define my_local_irq_restore(x)   ipipe_restore_pipeline_head(x)
>
> but sometimes seems not works.

Certainly it does work, always. The entire house is built on top of 
this. You may want to check your test code again.

>
> I only need the simple concept of local_irq_save and local_irq restore
> of standard linux.
> Is there something similar on xenomai ?
>

Over Xenomai 2.x, rthal_local_irq_save()/restore() is a wrapper to the 
proper implementation, which depends on the underlying I-pipe code.

-- 
Philippe.

