Subject: Re: Xenomai 2.6.4 + ipipe to xenomai 3.x
References: <VI1PR08MB3375EF5789AC530E75E08E07F5C10@VI1PR08MB3375.eurprd08.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2157756a-02a1-6266-4ce6-1c73103d3ad0@xenomai.org>
Date: Thu, 25 Jul 2019 13:43:32 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR08MB3375EF5789AC530E75E08E07F5C10@VI1PR08MB3375.eurprd08.prod.outlook.com>
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
To: Johann Obermayr <johann.obermayr@sigmatek.at>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 7/25/19 12:41 PM, Johann Obermayr via Xenomai wrote:
> Hello,
> 
> We are now migrate from Xenomai 2.6.4 + Kernel 3.10.53 to Xenomai 3.x + Kernel 4.14.89 (88).
> 
> Now I have found follow commit in the old kernel + ipipe
> 
> * ipipe/arm: fix system lockup on reboot
> 
> This fixes the problem of the system being stuck in an infinite loop at
> LDREX/STREX at the late stage of the reboot sequence.
> 
> At this stage the mmu is set into a state so that soft boot works, but causing
> a LDREX/STREX loop to fail. So we have to also disable Xenomai interrupts.
> 
> The local_irq_disable() is changed for hard_local_irq_disable() to switch off all
> irq's.
> 
> arch/arm/kernel/process.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 0707d004ac79..0e725c76a777 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -98,8 +98,13 @@ void soft_restart(unsigned long addr)
>       u64 *stack = soft_restart_stack + ARRAY_SIZE(soft_restart_stack);
>        /* Disable interrupts first */
> +#ifdef CONFIG_IPIPE
> +      hard_local_irq_disable();
> +      hard_local_fiq_disable_notrace();
> +#else
>       local_irq_disable();
>       local_fiq_disable();
> +#endif
>        /* Disable the L2 if we're the last man standing. */
>       if (num_online_cpus() == 1)
> @@ -241,7 +246,11 @@ void machine_halt(void)
> {
>       smp_send_stop();
> +#ifdef CONFIG_IPIPE
> +      hard_local_irq_disable();
> +#else
>       local_irq_disable();
> +#endif
>       while (1);
> }
> @@ -281,7 +290,11 @@ void machine_restart(char *cmd)
>        /* Whoops - the platform was unable to reboot. Tell the user! */
>       printk("Reboot failed -- System halted\n");
> +#ifdef CONFIG_IPIPE
> +      hard_local_irq_disable();
> +#else
>       local_irq_disable();
> +#endif
>       while (1);
> }
> 
> 
> And i don't known, if this patch is also needed for the new version.
> 

It does, but now this code lives in arch/arm/kernel/reboot.c.
local_irq_disable() can be replaced by hard_local_irq_disable() without
any conditional ifdeffery. raw_local_irq_disable() is a different beast
that does not map exactely to the hard_* API, so you still need
conditional blocks to set hard_local_irq_disable() when pipelining.


-- 
Philippe.

