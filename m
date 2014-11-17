Date: Mon, 17 Nov 2014 17:59:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141117165924.GM26613@sisyphus.hd.free.fr>
References: <20141110201409.GS17476@sisyphus.hd.free.fr>
 <54611D4E.6090308@web.de>
 <20141110202326.GU17476@sisyphus.hd.free.fr>
 <54612002.6010102@web.de>
 <20141110203747.GV17476@sisyphus.hd.free.fr>
 <5461232E.5000006@web.de>
 <20141110205512.GW17476@sisyphus.hd.free.fr>
 <20141110215846.GX17476@sisyphus.hd.free.fr>
 <20141112172738.GD17476@sisyphus.hd.free.fr>
 <546A26C0.1050309@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <546A26C0.1050309@siemens.com>
Subject: Re: [Xenomai] "inconsistent lock state" on boot-up
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Nov 17, 2014 at 05:48:00PM +0100, Jan Kiszka wrote:
> On 2014-11-12 18:27, Gilles Chanteperdrix wrote:
> > We do not need trace_hardirqs_on and trace_hardirqs_off for the
> > particular case of IRQs: they are already handled by
> > __ipipe_do_sync_stage. 
> 
> That was the key: Simply disabling the instrumentations in the
> CONFIG_IPIPE removes all lock state inconsistencies, at least this far:
> 
> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
> index d32f8bd..d8e0b2c 100644
> --- a/arch/arm/kernel/entry-header.S
> +++ b/arch/arm/kernel/entry-header.S
> @@ -195,7 +195,7 @@
>  #ifdef CONFIG_IPIPE_DEBUG_INTERNAL
>  	bl	__ipipe_bugon_irqs_enabled
>  #endif
> -#ifdef CONFIG_TRACE_IRQFLAGS
> +#if defined(CONFIG_TRACE_IRQFLAGS) && !defined(CONFIG_IPIPE)
>  	@ The parent context IRQs must have been enabled to get here in
>  	@ the first place, so there's no point checking the PSR I bit.
>  	bl	trace_hardirqs_on
> @@ -203,7 +203,7 @@
>  	.else
>  	@ IRQs off again before pulling preserved data off the stack
>  	disable_irq_notrace
> -#ifdef CONFIG_TRACE_IRQFLAGS
> +#if defined(CONFIG_TRACE_IRQFLAGS) && !defined(CONFIG_IPIPE)
>  	tst	\rpsr, #PSR_I_BIT
>  	bleq	trace_hardirqs_on
>  	tst	\rpsr, #PSR_I_BIT
> 
> Will send a patch.

Will this work for other paths in entry.S, such as exceptions or
syscalls?

-- 
					    Gilles.

