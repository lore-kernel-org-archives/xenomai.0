Message-ID: <50154442.2060603@xenomai.org>
Date: Sun, 29 Jul 2012 16:10:10 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CE2E43470FE5444A811B580382FE5EDF2113D8D95A@KEMPMAIL2.woodward.com>	<5009A292.4060508@grandegger.com>	<CE2E43470FE5444A811B580382FE5EDF2113EA8DE7@KEMPMAIL2.woodward.com>
	<501028DC.8000803@xenomai.org> <50102E8D.1040004@xenomai.org>
In-Reply-To: <50102E8D.1040004@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai installation on P1020RDB
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 07/25/2012 07:36 PM, Gilles Chanteperdrix wrote:

> If the first two are on and the third is off, try the following patch:
>
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 3ca10829..a752ca7 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -469,6 +469,14 @@ void arch_irq_work_raise(void)
>
>   #endif /* CONFIG_IRQ_WORK */
>
> +static inline void timer_ack(void)
> +{
> +	/* Ensure a positive value is written to the decrementer, or else
> +	 * some CPUs will continue to take decrementer exceptions.
> +	 */
> +	set_dec(DECREMENTER_MAX);
> +}
> +
>   /*
>    * timer_interrupt - gets called when the decrementer overflows,
>    * with interrupts disabled.
> @@ -480,11 +488,8 @@ void timer_interrupt(struct pt_regs * regs)
>   	struct clock_event_device *evt = &__get_cpu_var(decrementers);
>   	u64 now;
>
> -	/* Ensure a positive value is written to the decrementer, or else
> -	 * some CPUs will continue to take decrementer exceptions.
> -	 */
>   	if (!clockevent_ipipe_stolen(evt))
> -		set_dec(DECREMENTER_MAX);
> +		timer_ack();
>
>   	/* Some implementations of hotplug will get timer interrupts while
>   	 * offline, just ignore these
> @@ -836,6 +841,7 @@ static void register_decrementer_clockevent(int cpu)
>   	dec->ipipe_timer = &per_cpu(itimers, cpu);
>   	dec->ipipe_timer->irq = IPIPE_TIMER_VIRQ;
>   	dec->ipipe_timer->set = itimer_set;
> +	dec->ipipe_timer->ack = timer_ack;
>   	dec->ipipe_timer->min_delay_ticks = 3;
>   #endif /* CONFIG_IPIPE */
>
>
>

Actually, we don't need this, __ipipe_grab_timer() does it early.

-- 
Philippe.

