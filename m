Subject: Re: [Adeos-main] [PATCH+HACK] optimise root stalling
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <451786B3.4020506@domain.hid>
References: <451786B3.4020506@domain.hid>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 11:07:29 +0200
Message-Id: <1159434450.4949.7.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

On Mon, 2006-09-25 at 09:35 +0200, Jan Kiszka wrote:

This one won't work. We need to forcibly re-enable the hw IRQs upon root
unstall requests, regardless of the fact that interrupts are pending in
the log; some code rely on this. E.g. Adeos/ppc over 2.4 would remain
stuck in the delay calibration routine, but there are other more tricky
places where this would bite too.

> @@ -166,6 +158,7 @@ void __ipipe_unstall_root(void)
>  {
>         ipipe_declare_cpuid;
>  
> +#ifdef CONFIG_SMP
>         local_irq_disable_hw();
>  
>         ipipe_load_cpuid();
> @@ -176,6 +169,15 @@ void __ipipe_unstall_root(void)
>                 __ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
>  
>         local_irq_enable_hw();
> +#else  /* !CONFIG_SMP */
> +       __clear_bit(IPIPE_STALL_FLAG,
> &ipipe_root_domain->cpudata[cpuid].status);
> +
> +       if
> (unlikely(ipipe_root_domain->cpudata[cpuid].irq_pending_hi != 0)) {
> +               local_irq_disable_hw();
> +               __ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
> +               local_irq_enable_hw();
> +       }
> +#endif /* CONFIG_SMP */
>  }
>   
-- 
Philippe.



