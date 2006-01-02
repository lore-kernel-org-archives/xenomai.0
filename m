Message-ID: <43B976EC.2000802@domain.hid>
Date: Mon, 02 Jan 2006 19:54:36 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <43B970CD.4020005@domain.hid>
In-Reply-To: <43B970CD.4020005@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Adeos-main] [PATCH] fix ipipe for !CONFIG_PRINTK
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> this patch lets ipipe compile even if someone is annoyed of all the
> babbling on the kernel console. ;)

Applied in my tree, thanks. This will show up later in the repository 
since GNA seems to encounter some space problems with the CVS server.

> 
> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux-2.6.14.3/kernel/ipipe/core.c.orig	2005-12-17 14:08:23.000000000 +0100
> +++ linux-2.6.14.3/kernel/ipipe/core.c	2006-01-01 18:58:18.000000000 +0100
> @@ -43,7 +43,9 @@
>  
>  unsigned long __ipipe_virtual_irq_map = 0;
>  
> +#ifdef CONFIG_PRINTK
>  unsigned __ipipe_printk_virq;
> +#endif /* CONFIG_PRINTK */
>  
>  int __ipipe_event_monitors[IPIPE_NR_EVENTS];
>  
> @@ -76,10 +78,12 @@
>  
>  	__ipipe_init_platform();
>  
> +#ifdef CONFIG_PRINTK
>  	__ipipe_printk_virq = ipipe_alloc_virq();	/* Cannot fail here. */
>  	ipd->irqs[__ipipe_printk_virq].handler = &__ipipe_flush_printk;
>  	ipd->irqs[__ipipe_printk_virq].acknowledge = NULL;
>  	ipd->irqs[__ipipe_printk_virq].control = IPIPE_HANDLE_MASK;
> +#endif /* CONFIG_PRINTK */
>  
>  	__ipipe_enable_pipeline();
>  
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 

Philippe.

