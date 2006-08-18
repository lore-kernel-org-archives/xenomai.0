Subject: Re: [Xenomai-core] [rfc, patch] allow timer interrupt to be shared.
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17637.50791.966458.220636@domain.hid>
References: <17636.56428.140050.265677@domain.hid>
	<1155898533.4326.50.camel@domain.hid>
	<17637.41333.124122.921988@domain.hid>
	<1155904566.4326.65.camel@domain.hid> <1155904794.4326.69.camel@domain.hid>
	<17637.50791.966458.220636@domain.hid>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 16:21:22 +0200
Message-Id: <1155910883.4326.89.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, 2006-08-18 at 15:53 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > On Fri, 2006-08-18 at 14:36 +0200, Philippe Gerum wrote:
>  > > On Fri, 2006-08-18 at 13:16 +0200, Gilles Chanteperdrix wrote:
>  > > > Philippe Gerum wrote:
>  > > >  > I'd rather keep the number of obscure conditional macros as low as
>  > > >  > possible; we should actually try to reduce them since we have a growing
>  > > >  > number of real and pseudo-archs to support, and those macros tend to
>  > > >  > obfuscate the generic code.
>  > > >  > 
>  > > >  > In the same vein, is there anything we could use in the compatible Adeos
>  > > >  > patch that would unambiguously identify the presence of such support
>  > > >  > without resorting to yet-another-macro like IPIPE_HAVE_SHARED_TIMER_IRQ?
>  > > > 
>  > > > We could decide that ipipe_timer_irq_p() must be implemented as a macro,
>  > > > and use #ifdef ipipe_timer_irq_p but I thought that #ifdef
>  > > > IPIPE_HAVE_SHARED_TIMER_IRQ was easier to understand.
>  > > > 
>  > > 
>  > > It is, but the point is that we should not define a normalized
>  > > interface; older ARM patches are obsoleted by the very existence of the
>  > > new one adding a required feature for PXA.
>  > 
>  > AT91.
>  > 
>  > >  Therefore, at some point in
>  > > time, we are going to deprecate them, removing the conditional from the
>  > > Xenomai codebase. In other words, this code is aimed at transitioning
>  > > internally between two Adeos patch series, not at providing a stable
>  > > interface.
> 
> Here is a new version of the patch.
> 

Applied, thanks.

> plain text document attachment (xeno-shared-timer-irq.2.diff)
> Index: include/asm-generic/hal.h
> ===================================================================
> --- include/asm-generic/hal.h	(revision 1451)
> +++ include/asm-generic/hal.h	(working copy)
> @@ -679,6 +679,15 @@
>  
>  #endif /* CONFIG_IPIPE_TRACE */
>  
> +#ifdef ipipe_timer_irq_p
> +/* Timer IRQ is shared. */
> +#define rthal_timer_irq_p()         ipipe_timer_irq_p()
> +#define rthal_mark_root_timer_irq() ipipe_mark_root_timer_irq()
> +#else /* !IPIPE_SHARED_TIMER_IRQ */
> +#define rthal_timer_irq_p()         1
> +#define rthal_mark_root_timer_irq() do { } while(0)
> +#endif /* IPIPE_SHARED_TIMER_IRQ */
> +
>  #ifdef __cplusplus
>  }
>  #endif /* __cplusplus */
> Index: include/asm-generic/system.h
> ===================================================================
> --- include/asm-generic/system.h	(revision 1451)
> +++ include/asm-generic/system.h	(working copy)
> @@ -487,4 +487,6 @@
>  #define xnarch_post_graph(obj,state)
>  #define xnarch_post_graph_if(obj,state,cond)
>  
> +#define xnarch_timer_irq_p()         rthal_timer_irq_p()
> +
>  #endif /* !_XENO_ASM_GENERIC_SYSTEM_H */
> Index: include/asm-arm/bits/intr.h
> ===================================================================
> --- include/asm-arm/bits/intr.h	(revision 1451)
> +++ include/asm-arm/bits/intr.h	(working copy)
> @@ -27,6 +27,7 @@
>  
>  static inline void xnarch_relay_tick(void)
>  {
> +	rthal_mark_root_timer_irq();
>  	rthal_irq_host_pend(RTHAL_TIMER_IRQ);
>  }
>  
> Index: ksrc/skins/vxworks/sysLib.c
> ===================================================================
> --- ksrc/skins/vxworks/sysLib.c	(revision 1451)
> +++ ksrc/skins/vxworks/sysLib.c	(working copy)
> @@ -24,19 +24,20 @@
>  
>  static wind_tick_handler_t tick_handler;
>  static long tick_handler_arg;
> +static int tick_status [XNARCH_NR_CPUS];
>  
>  void tickAnnounce(void)
>  {
>  	if (tick_handler != NULL)
>  		tick_handler(tick_handler_arg);
>  
> -	xnpod_announce_tick(&nkclock);
> +	tick_status[xnarch_current_cpu()] = xnpod_announce_tick(&nkclock);
>  }
>  
>  static int __tickAnnounce(xnintr_t *intr)
>  {
>  	tickAnnounce();
> -	return XN_ISR_HANDLED | XN_ISR_NOENABLE;
> +	return tick_status[xnarch_current_cpu()];
>  }
>  
>  int wind_sysclk_init(u_long init_rate)
> Index: ksrc/nucleus/pod.c
> ===================================================================
> --- ksrc/nucleus/pod.c	(revision 1451)
> +++ ksrc/nucleus/pod.c	(working copy)
> @@ -3249,6 +3249,9 @@
>  {
>  	xnsched_t *sched;
>  
> +	if (!xnarch_timer_irq_p())
> +		return XN_ISR_NONE | XN_ISR_NOENABLE | XN_ISR_PROPAGATE;
> +	
>  	sched = xnpod_current_sched();
>  
>  	xnlock_get(&nklock);
-- 
Philippe.



