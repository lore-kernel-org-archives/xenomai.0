Subject: Re: [Xenomai-core] [PATCH] rework xnintr locking, enhance proc output
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <451914C5.10008@domain.hid>
References: <451914C5.10008@domain.hid>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 18:48:57 +0200
Message-Id: <1159375738.7595.13.camel@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2006-09-26 at 13:53 +0200, Jan Kiszka wrote:
> This patch series reworks the locking of xnintr_attach and xnintr_detach
> with respect to xnintr_irq_proc. So far the locking during proc output
> contains a risk of deadlock when an IRQ was detached concurrently.
> 
> The new version also introduces IRQ names for the non-shared case so
> that drivers or other IRQ registering instances are always made visible.
> 
> The series consists of the functional changes in the first patch
> (xnintr-locking-v4.patch) and a code reordering in the second one
> (xnintr-reorder-v2.patch). Apply in that order.
> 
> Credits definitely go to Dmitry as well who helped a lot with cleaning
> up and reordering my first patch version.
> 

Nice, this stuff manages to give good looking to ugly IRQ implementation
issues. Merged, thanks.

> Jan
> 
> PS: This series also paves the way for upcoming patches to add (almost)
> perfectly fair IRQ CPU load statistics. Stay tuned! 8)
> plain text document attachment (xnintr-locking-v4.patch)
> ---
>  ChangeLog           |    7 +
>  ksrc/nucleus/intr.c |  201 +++++++++++++++++++++++++---------------------------
>  2 files changed, 104 insertions(+), 104 deletions(-)
> 
> Index: xenomai/ksrc/nucleus/intr.c
> ===================================================================
> --- xenomai.orig/ksrc/nucleus/intr.c
> +++ xenomai/ksrc/nucleus/intr.c
> @@ -3,6 +3,7 @@
>   * \author Philippe Gerum
>   *
>   * Copyright (C) 2001,2002,2003 Philippe Gerum <rpm@xenomai.org>.
> + * Copyright (C) 2005,2006 Dmitry Adamushko <dmitry.adamushko@domain.hid>.
>   *
>   * Xenomai is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published
> @@ -35,19 +36,19 @@
>  #include <nucleus/ltt.h>
>  #include <asm/xenomai/bits/intr.h>
>  
> +#ifdef CONFIG_SMP
> +xnlock_t intrlock;
> +#endif /* CONFIG_SMP */
> +
>  xnintr_t nkclock;
>  
>  static void xnintr_irq_handler(unsigned irq, void *cookie);
>  
> -#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
> -
> -/* Helper functions. */
> -static int xnintr_shirq_attach(xnintr_t *intr, void *cookie);
> -static int xnintr_shirq_detach(xnintr_t *intr);
> -
> -#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
> +static int xnintr_irq_attach(xnintr_t *intr);
> +static int xnintr_irq_detach(xnintr_t *intr);
> +static void xnintr_synchronize(xnintr_t *intr);
>  
> -/*! 
> +/*!
>   * \fn int xnintr_init (xnintr_t *intr,const char *name,unsigned irq,xnisr_t isr,xniack_t iack,xnflags_t flags)
>   * \brief Initialize an interrupt object.
>   *
> @@ -198,7 +199,7 @@ int xnintr_destroy(xnintr_t *intr)
>  	return 0;
>  }
>  
> -/*! 
> +/*!
>   * \fn int xnintr_attach (xnintr_t *intr, void *cookie);
>   * \brief Attach an interrupt object.
>   *
> @@ -234,14 +235,19 @@ int xnintr_destroy(xnintr_t *intr)
>  
>  int xnintr_attach(xnintr_t *intr, void *cookie)
>  {
> +	int err;
> +	spl_t s;
> +
>  	intr->hits = 0;
>  	intr->cookie = cookie;
> -#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
> -	return xnintr_shirq_attach(intr, cookie);
> -#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
> -	return xnarch_hook_irq(intr->irq, &xnintr_irq_handler, intr->iack,
> -			       intr);
> -#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
> +
> +	xnlock_get_irqsave(&intrlock, s);
> +
> +	err = xnintr_irq_attach(intr);
> +
> +	xnlock_put_irqrestore(&intrlock, s);
> +
> +	return err;
>  }
>  
>  /*! 
> @@ -275,11 +281,22 @@ int xnintr_attach(xnintr_t *intr, void *
>  
>  int xnintr_detach(xnintr_t *intr)
>  {
> -#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
> -	return xnintr_shirq_detach(intr);
> -#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
> -	return xnarch_release_irq(intr->irq);
> -#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
> +	int err;
> +	spl_t s;
> +
> +	xnlock_get_irqsave(&intrlock, s);
> +
> +	err = xnintr_irq_detach(intr);
> +
> +	xnlock_put_irqrestore(&intrlock, s);
> +
> +	/* The idea here is to keep a detached interrupt object valid as long
> +	   as the corresponding irq handler is running. This is one of the
> +	   requirements to iterate over the xnintr_shirq_t::handlers list in
> +	   xnintr_irq_handler() in a lockless way. */
> +	xnintr_synchronize(intr);
> +
> +	return err;
>  }
>  
>  /*! 
> @@ -436,42 +453,37 @@ typedef struct xnintr_shirq {
>  	int unhandled;
>  #ifdef CONFIG_SMP
>  	atomic_counter_t active;
> -#endif				/* CONFIG_SMP */
> +#endif
>  
>  } xnintr_shirq_t;
>  
>  static xnintr_shirq_t xnshirqs[RTHAL_NR_IRQS];
>  
> -#ifdef CONFIG_SMP
>  static inline void xnintr_shirq_lock(xnintr_shirq_t *shirq)
>  {
> +#ifdef CONFIG_SMP
>  	xnarch_atomic_inc(&shirq->active);
> +#endif
>  }
>  
>  static inline void xnintr_shirq_unlock(xnintr_shirq_t *shirq)
>  {
> +#ifdef CONFIG_SMP
>  	xnarch_atomic_dec(&shirq->active);
> +#endif
>  }
>  
> -static inline void xnintr_shirq_spin(xnintr_shirq_t *shirq)
> +void xnintr_synchronize(xnintr_t *intr)
>  {
> +#ifdef CONFIG_SMP
> +	xnintr_shirq_t *shirq = &xnshirqs[intr->irq];
> +
>  	while (xnarch_atomic_get(&shirq->active))
>  		cpu_relax();
> +#endif
>  }
> -#else /* !CONFIG_SMP */
> -static inline void xnintr_shirq_lock(xnintr_shirq_t *shirq)
> -{
> -}
> -static inline void xnintr_shirq_unlock(xnintr_shirq_t *shirq)
> -{
> -}
> -static inline void xnintr_shirq_spin(xnintr_shirq_t *shirq)
> -{
> -}
> -#endif /* CONFIG_SMP */
>  
>  #if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL)
> -
>  /*
>   * Low-level interrupt handler dispatching the user-defined ISRs for
>   * shared interrupts -- Called with interrupts off.
> @@ -524,7 +536,6 @@ static void xnintr_shirq_handler(unsigne
>  #endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL */
>  
>  #if defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
> -
>  /*
>   * Low-level interrupt handler dispatching the user-defined ISRs for
>   * shared edge-triggered interrupts -- Called with interrupts off.
> @@ -597,32 +608,25 @@ static void xnintr_edge_shirq_handler(un
>  
>  #endif /* CONFIG_XENO_OPT_SHIRQ_EDGE */
>  
> -static int xnintr_shirq_attach(xnintr_t *intr, void *cookie)
> +int xnintr_irq_attach(xnintr_t *intr)
>  {
>  	xnintr_shirq_t *shirq = &xnshirqs[intr->irq];
>  	xnintr_t *prev, **p = &shirq->handlers;
> -	int err = 0;
> -	spl_t s;
> +	int err;
>  
>  	if (intr->irq >= RTHAL_NR_IRQS)
>  		return -EINVAL;
>  
> -	xnlock_get_irqsave(&nklock, s);
> -
> -	if (__testbits(intr->flags, XN_ISR_ATTACHED)) {
> -		err = -EPERM;
> -		goto unlock_and_exit;
> -	}
> +	if (__testbits(intr->flags, XN_ISR_ATTACHED))
> +		return -EPERM;
>  
>  	if ((prev = *p) != NULL) {
>  		/* Check on whether the shared mode is allowed. */
>  		if (!(prev->flags & intr->flags & XN_ISR_SHARED) ||
>  		    (prev->iack != intr->iack)
>  		    || ((prev->flags & XN_ISR_EDGE) !=
> -			(intr->flags & XN_ISR_EDGE))) {
> -			err = -EBUSY;
> -			goto unlock_and_exit;
> -		}
> +			(intr->flags & XN_ISR_EDGE)))
> +			return -EBUSY;
>  
>  		/* Get a position at the end of the list to insert the new element. */
>  		while (prev) {
> @@ -647,7 +651,7 @@ static int xnintr_shirq_attach(xnintr_t 
>  
>  		err = xnarch_hook_irq(intr->irq, handler, intr->iack, intr);
>  		if (err)
> -			goto unlock_and_exit;
> +			return err;
>  	}
>  
>  	__setbits(intr->flags, XN_ISR_ATTACHED);
> @@ -656,28 +660,20 @@ static int xnintr_shirq_attach(xnintr_t 
>  	intr->next = NULL;
>  	*p = intr;
>  
> -      unlock_and_exit:
> -
> -	xnlock_put_irqrestore(&nklock, s);
> -	return err;
> +	return 0;
>  }
>  
> -int xnintr_shirq_detach(xnintr_t *intr)
> +int xnintr_irq_detach(xnintr_t *intr)
>  {
>  	xnintr_shirq_t *shirq = &xnshirqs[intr->irq];
>  	xnintr_t *e, **p = &shirq->handlers;
>  	int err = 0;
> -	spl_t s;
>  
>  	if (intr->irq >= RTHAL_NR_IRQS)
>  		return -EINVAL;
>  
> -	xnlock_get_irqsave(&nklock, s);
> -
> -	if (!__testbits(intr->flags, XN_ISR_ATTACHED)) {
> -		xnlock_put_irqrestore(&nklock, s);
> +	if (!__testbits(intr->flags, XN_ISR_ATTACHED))
>  		return -EPERM;
> -	}
>  
>  	__clrbits(intr->flags, XN_ISR_ATTACHED);
>  
> @@ -690,23 +686,13 @@ int xnintr_shirq_detach(xnintr_t *intr)
>  			if (shirq->handlers == NULL)
>  				err = xnarch_release_irq(intr->irq);
>  
> -			xnlock_put_irqrestore(&nklock, s);
> -
> -			/* The idea here is to keep a detached interrupt object valid as long
> -			   as the corresponding irq handler is running. This is one of the requirements
> -			   to iterate over the xnintr_shirq_t::handlers list in xnintr_irq_handler()
> -			   in a lockless way. */
> -
> -			xnintr_shirq_spin(shirq);
>  			return err;
>  		}
>  		p = &e->next;
>  	}
>  
> -	xnlock_put_irqrestore(&nklock, s);
> -
> -	xnlogerr
> -	    ("attempted to detach a non previously attached interrupt object.\n");
> +	xnlogerr("attempted to detach a non previously attached interrupt "
> +		 "object.\n");
>  	return err;
>  }
>  
> @@ -717,16 +703,33 @@ int xnintr_mount(void)
>  		xnshirqs[i].handlers = NULL;
>  #ifdef CONFIG_SMP
>  		atomic_set(&xnshirqs[i].active, 0);
> -#endif /* CONFIG_SMP */
> +#endif
>  	}
>  	return 0;
>  }
>  
> +#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
> +
> +int xnintr_irq_attach(xnintr_t *intr)
> +{
> +	return xnarch_hook_irq(intr->irq, &xnintr_irq_handler, intr->iack, intr);
> +}
> +
> +int xnintr_irq_detach(xnintr_t *intr)
> +{
> +	return xnarch_release_irq(intr->irq);
> +}
> +
> +void xnintr_synchronize(xnintr_t *intr) {}
> +int xnintr_mount(void) { return 0; }
> +
> +#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
> +
>  int xnintr_irq_proc(unsigned int irq, char *str)
>  {
> -	xnintr_shirq_t *shirq;
>  	xnintr_t *intr;
>  	char *p = str;
> +	spl_t s;
>  
>  	if (rthal_virtual_irq_p(irq)) {
>  		p += sprintf(p, "         [virtual]");
> @@ -736,43 +739,33 @@ int xnintr_irq_proc(unsigned int irq, ch
>  		return p - str;
>  	}
>  
> -	shirq = &xnshirqs[irq];
> +	xnlock_get_irqsave(&intrlock, s);
>  
> -	xnintr_shirq_lock(shirq);
> -	intr = shirq->handlers;
> -
> -	if (intr)
> -		p += sprintf(p, "        ");
> -
> -	while (intr) {
> -		if (*(intr->name))
> -			p += sprintf(p, " %s,", intr->name);
> +#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
> +	intr = xnshirqs[irq].handlers;
> +	if (intr) {
> +		strcpy(p, "        "); p += 8;
> +
> +		do {
> +			*p = ' '; p += 1;
> +			strcpy(p, intr->name); p += strlen(intr->name);
>  
> -		intr = intr->next;
> +			intr = intr->next;
> +		} while (intr);
>  	}
> -
> -	xnintr_shirq_unlock(shirq);
> -
> -	if (p != str)
> -		--p;
> -
> -	return p - str;
> -}
> -
>  #else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
> +	intr = rthal_irq_cookie(&rthal_domain, irq);
> +	if (intr) {
> +		strcpy(p, "         "); p += 9;
> +		strcpy(p, intr->name); p += strlen(intr->name);
> +	}
> +#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
>  
> -int xnintr_mount(void)
> -{
> -	return 0;
> -}
> +	xnlock_put_irqrestore(&intrlock, s);
>  
> -int xnintr_irq_proc(unsigned int irq, char *str)
> -{
> -	return 0;
> +	return p - str;
>  }
>  
> -#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
> -
>  EXPORT_SYMBOL(xnintr_attach);
>  EXPORT_SYMBOL(xnintr_destroy);
>  EXPORT_SYMBOL(xnintr_detach);
> Index: xenomai/ChangeLog
> ===================================================================
> --- xenomai.orig/ChangeLog
> +++ xenomai/ChangeLog
> @@ -1,3 +1,10 @@
> +2006-09-26  Jan Kiszka  <jan.kiszka@domain.hid>
> +            Dmitry Adamushko  <dmitry.adamushko@domain.hid>
> +
> +	* ksrc/nucleus/intr.c: Reorganise locking around xnintr_attach,
> +	and xnintr_detach in order to avoid races with xnintr_irq_proc,
> +	provide IRQ owner names also for non-shared setups, refactor code.
> +
>  2006-09-25  Niklaus Giger <niklaus.giger@domain.hid>
>  
>  	* ksrc/arch/powerpc/hal.c (rthal_set_cpu_timers_unsafe): Fix
> plain text document attachment (xnintr-reorder-v2.patch)
> ---
>  ksrc/nucleus/intr.c |  883 +++++++++++++++++++++++++---------------------------
>  1 file changed, 439 insertions(+), 444 deletions(-)
> 
> Index: xenomai/ksrc/nucleus/intr.c
> ===================================================================
> --- xenomai.orig/ksrc/nucleus/intr.c
> +++ xenomai/ksrc/nucleus/intr.c
> @@ -36,363 +36,14 @@
>  #include <nucleus/ltt.h>
>  #include <asm/xenomai/bits/intr.h>
>  
> +#define XNINTR_MAX_UNHANDLED	1000
> +
>  #ifdef CONFIG_SMP
>  xnlock_t intrlock;
>  #endif /* CONFIG_SMP */
>  
>  xnintr_t nkclock;
>  
> -static void xnintr_irq_handler(unsigned irq, void *cookie);
> -
> -static int xnintr_irq_attach(xnintr_t *intr);
> -static int xnintr_irq_detach(xnintr_t *intr);
> -static void xnintr_synchronize(xnintr_t *intr);
> -
> -/*!
> - * \fn int xnintr_init (xnintr_t *intr,const char *name,unsigned irq,xnisr_t isr,xniack_t iack,xnflags_t flags)
> - * \brief Initialize an interrupt object.
> - *
> - * Associates an interrupt object with an IRQ line.
> - *
> - * When an interrupt occurs on the given @a irq line, the ISR is fired
> - * in order to deal with the hardware event. The interrupt service
> - * code may call any non-suspensive service from the nucleus.
> - *
> - * Upon receipt of an IRQ, the ISR is immediately called on behalf of
> - * the interrupted stack context, the rescheduling procedure is
> - * locked, and the interrupt source is masked at hardware level. The
> - * status value returned by the ISR is then checked for the following
> - * values:
> - *
> - * - XN_ISR_HANDLED indicates that the interrupt request has been fulfilled
> - * by the ISR.
> - *
> - * - XN_ISR_NONE indicates the opposite to XN_ISR_HANDLED. The ISR must always
> - * return this value when it determines that the interrupt request has not been
> - * issued by the dedicated hardware device.
> - *
> - * In addition, one of the following bits may be set by the ISR :
> - *
> - * NOTE: use these bits with care and only when you do understand their effect
> - * on the system.
> - * The ISR is not encouraged to use these bits in case it shares the IRQ line
> - * with other ISRs in the real-time domain.
> - *
> - * - XN_ISR_PROPAGATE tells the nucleus to require the real-time control
> - * layer to forward the IRQ. For instance, this would cause the Adeos
> - * control layer to propagate the interrupt down the interrupt
> - * pipeline to other Adeos domains, such as Linux. This is the regular
> - * way to share interrupts between the nucleus and the host system.
> - *
> - * - XN_ISR_NOENABLE causes the nucleus to ask the real-time control
> - * layer _not_ to re-enable the IRQ line (read the following section).
> - * xnarch_end_irq() must be called to re-enable the IRQ line later.
> - *
> - * The nucleus re-enables the IRQ line by default. Over some real-time
> - * control layers which mask and acknowledge IRQs, this operation is
> - * necessary to revalidate the interrupt channel so that more interrupts
> - * can be notified.
> - *
> - * A count of interrupt receipts is tracked into the interrupt
> - * descriptor, and reset to zero each time the interrupt object is
> - * attached. Since this count could wrap around, it should be used as
> - * an indication of interrupt activity only.
> - *
> - * @param intr The address of a interrupt object descriptor the
> - * nucleus will use to store the object-specific data.  This
> - * descriptor must always be valid while the object is active
> - * therefore it must be allocated in permanent memory.
> - *
> - * @param name An ASCII string standing for the symbolic name of the
> - * interrupt object.
> - *
> - * @param irq The hardware interrupt channel associated with the
> - * interrupt object. This value is architecture-dependent. An
> - * interrupt object must then be attached to the hardware interrupt
> - * vector using the xnintr_attach() service for the associated IRQs
> - * to be directed to this object.
> - *
> - * @param isr The address of a valid low-level interrupt service
> - * routine if this parameter is non-zero. This handler will be called
> - * each time the corresponding IRQ is delivered on behalf of an
> - * interrupt context.  When called, the ISR is passed the descriptor
> - * address of the interrupt object.
> - *
> - * @param iack The address of an optional interrupt acknowledge
> - * routine, aimed at replacing the default one. Only very specific
> - * situations actually require to override the default setting for
> - * this parameter, like having to acknowledge non-standard PIC
> - * hardware. @a iack should return a non-zero value to indicate that
> - * the interrupt has been properly acknowledged. If @a iack is NULL,
> - * the default routine will be used instead.
> - *
> - * @param flags A set of creation flags affecting the operation. The
> - * valid flags are:
> - *
> - * - XN_ISR_SHARED enables IRQ-sharing with other interrupt objects.
> - *
> - * - XN_ISR_EDGE is an additional flag need to be set together with XN_ISR_SHARED
> - * to enable IRQ-sharing of edge-triggered interrupts.
> - *
> - * @return No error condition being defined, 0 is always returned.
> - *
> - * Environments:
> - *
> - * This service can be called from:
> - *
> - * - Kernel module initialization/cleanup code
> - * - Kernel-based task
> - * - User-space task
> - *
> - * Rescheduling: never.
> - */
> -
> -int xnintr_init(xnintr_t *intr,
> -		const char *name,
> -		unsigned irq, xnisr_t isr, xniack_t iack, xnflags_t flags)
> -{
> -	intr->irq = irq;
> -	intr->isr = isr;
> -	intr->iack = iack;
> -	intr->cookie = NULL;
> -	intr->hits = 0;
> -	intr->name = name;
> -	intr->flags = flags;
> -	intr->unhandled = 0;
> -#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
> -	intr->next = NULL;
> -#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
> -
> -	return 0;
> -}
> -
> -/*! 
> - * \fn int xnintr_destroy (xnintr_t *intr)
> - * \brief Destroy an interrupt object.
> - *
> - * Destroys an interrupt object previously initialized by
> - * xnintr_init(). The interrupt object is automatically detached by a
> - * call to xnintr_detach(). No more IRQs will be dispatched by this
> - * object after this service has returned.
> - *
> - * @param intr The descriptor address of the interrupt object to
> - * destroy.
> - *
> - * @return 0 is returned on success. Otherwise, -EBUSY is returned if
> - * an error occurred while detaching the interrupt (see
> - * xnintr_detach()).
> - *
> - * Environments:
> - *
> - * This service can be called from:
> - *
> - * - Kernel module initialization/cleanup code
> - * - Kernel-based task
> - * - User-space task
> - *
> - * Rescheduling: never.
> - */
> -
> -int xnintr_destroy(xnintr_t *intr)
> -{
> -	xnintr_detach(intr);
> -	return 0;
> -}
> -
> -/*!
> - * \fn int xnintr_attach (xnintr_t *intr, void *cookie);
> - * \brief Attach an interrupt object.
> - *
> - * Attach an interrupt object previously initialized by
> - * xnintr_init(). After this operation is completed, all IRQs received
> - * from the corresponding interrupt channel are directed to the
> - * object's ISR.
> - *
> - * @param intr The descriptor address of the interrupt object to
> - * attach.
> - *
> - * @param cookie A user-defined opaque value which is stored into the
> - * interrupt object descriptor for further retrieval by the ISR/ISR
> - * handlers.
> - *
> - * @return 0 is returned on success. Otherwise, -EINVAL is returned if
> - * a low-level error occurred while attaching the interrupt. -EBUSY is
> - * specifically returned if the interrupt object was already attached.
> - *
> - * Environments:
> - *
> - * This service can be called from:
> - *
> - * - Kernel module initialization/cleanup code
> - * - Kernel-based task
> - * - User-space task
> - *
> - * Rescheduling: never.
> - *
> - * @note Attaching an interrupt resets the tracked number of receipts
> - * to zero.
> - */
> -
> -int xnintr_attach(xnintr_t *intr, void *cookie)
> -{
> -	int err;
> -	spl_t s;
> -
> -	intr->hits = 0;
> -	intr->cookie = cookie;
> -
> -	xnlock_get_irqsave(&intrlock, s);
> -
> -	err = xnintr_irq_attach(intr);
> -
> -	xnlock_put_irqrestore(&intrlock, s);
> -
> -	return err;
> -}
> -
> -/*! 
> - * \fn int xnintr_detach (xnintr_t *intr)
> - * \brief Detach an interrupt object.
> - *
> - * Detach an interrupt object previously attached by
> - * xnintr_attach(). After this operation is completed, no more IRQs
> - * are directed to the object's ISR, but the interrupt object itself
> - * remains valid. A detached interrupt object can be attached again by
> - * a subsequent call to xnintr_attach().
> - *
> - * @param intr The descriptor address of the interrupt object to
> - * detach.
> - *
> - * @return 0 is returned on success. Otherwise, -EINVAL is returned if
> - * a low-level error occurred while detaching the interrupt. Detaching
> - * a non-attached interrupt object leads to a null-effect and returns
> - * 0.
> - *
> - * Environments:
> - *
> - * This service can be called from:
> - *
> - * - Kernel module initialization/cleanup code
> - * - Kernel-based task
> - * - User-space task
> - *
> - * Rescheduling: never.
> - */
> -
> -int xnintr_detach(xnintr_t *intr)
> -{
> -	int err;
> -	spl_t s;
> -
> -	xnlock_get_irqsave(&intrlock, s);
> -
> -	err = xnintr_irq_detach(intr);
> -
> -	xnlock_put_irqrestore(&intrlock, s);
> -
> -	/* The idea here is to keep a detached interrupt object valid as long
> -	   as the corresponding irq handler is running. This is one of the
> -	   requirements to iterate over the xnintr_shirq_t::handlers list in
> -	   xnintr_irq_handler() in a lockless way. */
> -	xnintr_synchronize(intr);
> -
> -	return err;
> -}
> -
> -/*! 
> - * \fn int xnintr_enable (xnintr_t *intr)
> - * \brief Enable an interrupt object.
> - *
> - * Enables the hardware interrupt line associated with an interrupt
> - * object. Over real-time control layers which mask and acknowledge
> - * IRQs, this operation is necessary to revalidate the interrupt
> - * channel so that more interrupts can be notified.
> -
> - * @param intr The descriptor address of the interrupt object to
> - * enable.
> - *
> - * @return 0 is returned on success. Otherwise, -EINVAL is returned if
> - * a low-level error occurred while enabling the interrupt.
> - *
> - * Environments:
> - *
> - * This service can be called from:
> - *
> - * - Kernel module initialization/cleanup code
> - * - Kernel-based task
> - * - User-space task
> - *
> - * Rescheduling: never.
> - */
> -
> -int xnintr_enable(xnintr_t *intr)
> -{
> -	return xnarch_enable_irq(intr->irq);
> -}
> -
> -/*! 
> - * \fn int xnintr_disable (xnintr_t *intr)
> - * \brief Disable an interrupt object.
> - *
> - * Disables the hardware interrupt line associated with an interrupt
> - * object. This operation invalidates further interrupt requests from
> - * the given source until the IRQ line is re-enabled anew.
> - *
> - * @param intr The descriptor address of the interrupt object to
> - * disable.
> - *
> - * @return 0 is returned on success. Otherwise, -EINVAL is returned if
> - * a low-level error occurred while disabling the interrupt.
> - *
> - * Environments:
> - *
> - * This service can be called from:
> - *
> - * - Kernel module initialization/cleanup code
> - * - Kernel-based task
> - * - User-space task
> - *
> - * Rescheduling: never.
> - */
> -
> -int xnintr_disable(xnintr_t *intr)
> -{
> -	return xnarch_disable_irq(intr->irq);
> -}
> -
> -/*! 
> - * \fn xnarch_cpumask_t xnintr_affinity (xnintr_t *intr, xnarch_cpumask_t cpumask)
> - * \brief Set interrupt's processor affinity.
> - *
> - * Causes the IRQ associated with the interrupt object @a intr to be
> - * received only on processors which bits are set in @a cpumask.
> - *
> - * @param intr The descriptor address of the interrupt object which
> - * affinity is to be changed.
> - *
> - * @param cpumask The new processor affinity of the interrupt object.
> - *
> - * @return the previous cpumask on success, or an empty mask on
> - * failure.
> - *
> - * @note Depending on architectures, setting more than one bit in @a
> - * cpumask could be meaningless.
> - */
> -
> -xnarch_cpumask_t xnintr_affinity(xnintr_t *intr, xnarch_cpumask_t cpumask)
> -{
> -	return xnarch_set_irq_affinity(intr->irq, cpumask);
> -}
> -
> -/* Low-level clock irq handler. */
> -
> -void xnintr_clock_handler(void)
> -{
> -	xnarch_announce_tick();
> -	xnintr_irq_handler(nkclock.irq, &nkclock);
> -}
> -
> -#define XNINTR_MAX_UNHANDLED	1000
>  /*
>   * Low-level interrupt handler dispatching the ISRs -- Called with
>   * interrupts off.
> @@ -441,8 +92,14 @@ static void xnintr_irq_handler(unsigned 
>  	xnltt_log_event(xeno_ev_iexit, irq);
>  }
>  
> -/*@}*/
> -
> +/* Low-level clock irq handler. */
> +
> +void xnintr_clock_handler(void)
> +{
> +	xnarch_announce_tick();
> +	xnintr_irq_handler(nkclock.irq, &nkclock);
> +}
> +
>  /* Optional support for shared interrupts. */
>  
>  #if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
> @@ -603,128 +260,465 @@ static void xnintr_edge_shirq_handler(un
>  	if (--sched->inesting == 0 && xnsched_resched_p())
>  		xnpod_schedule();
>  
> -	xnltt_log_event(xeno_ev_iexit, irq);
> +	xnltt_log_event(xeno_ev_iexit, irq);
> +}
> +
> +#endif /* CONFIG_XENO_OPT_SHIRQ_EDGE */
> +
> +static inline int xnintr_irq_attach(xnintr_t *intr)
> +{
> +	xnintr_shirq_t *shirq = &xnshirqs[intr->irq];
> +	xnintr_t *prev, **p = &shirq->handlers;
> +	int err;
> +
> +	if (intr->irq >= RTHAL_NR_IRQS)
> +		return -EINVAL;
> +
> +	if (__testbits(intr->flags, XN_ISR_ATTACHED))
> +		return -EPERM;
> +
> +	if ((prev = *p) != NULL) {
> +		/* Check on whether the shared mode is allowed. */
> +		if (!(prev->flags & intr->flags & XN_ISR_SHARED) ||
> +		    (prev->iack != intr->iack)
> +		    || ((prev->flags & XN_ISR_EDGE) !=
> +			(intr->flags & XN_ISR_EDGE)))
> +			return -EBUSY;
> +
> +		/* Get a position at the end of the list to insert the new element. */
> +		while (prev) {
> +			p = &prev->next;
> +			prev = *p;
> +		}
> +	} else {
> +		/* Initialize the corresponding interrupt channel */
> +		void (*handler) (unsigned, void *) = &xnintr_irq_handler;
> +
> +		if (intr->flags & XN_ISR_SHARED) {
> +#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL)
> +			handler = &xnintr_shirq_handler;
> +#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL */
> +
> +#if defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
> +			if (intr->flags & XN_ISR_EDGE)
> +				handler = &xnintr_edge_shirq_handler;
> +#endif /* CONFIG_XENO_OPT_SHIRQ_EDGE */
> +		}
> +		shirq->unhandled = 0;
> +
> +		err = xnarch_hook_irq(intr->irq, handler, intr->iack, intr);
> +		if (err)
> +			return err;
> +	}
> +
> +	__setbits(intr->flags, XN_ISR_ATTACHED);
> +
> +	/* Add a given interrupt object. */
> +	intr->next = NULL;
> +	*p = intr;
> +
> +	return 0;
> +}
> +
> +static inline int xnintr_irq_detach(xnintr_t *intr)
> +{
> +	xnintr_shirq_t *shirq = &xnshirqs[intr->irq];
> +	xnintr_t *e, **p = &shirq->handlers;
> +	int err = 0;
> +
> +	if (intr->irq >= RTHAL_NR_IRQS)
> +		return -EINVAL;
> +
> +	if (!__testbits(intr->flags, XN_ISR_ATTACHED))
> +		return -EPERM;
> +
> +	__clrbits(intr->flags, XN_ISR_ATTACHED);
> +
> +	while ((e = *p) != NULL) {
> +		if (e == intr) {
> +			/* Remove a given interrupt object from the list. */
> +			*p = e->next;
> +
> +			/* Release the IRQ line if this was the last user */
> +			if (shirq->handlers == NULL)
> +				err = xnarch_release_irq(intr->irq);
> +
> +			return err;
> +		}
> +		p = &e->next;
> +	}
> +
> +	xnlogerr("attempted to detach a non previously attached interrupt "
> +		 "object.\n");
> +	return err;
> +}
> +
> +int xnintr_mount(void)
> +{
> +	int i;
> +	for (i = 0; i < RTHAL_NR_IRQS; ++i) {
> +		xnshirqs[i].handlers = NULL;
> +#ifdef CONFIG_SMP
> +		atomic_set(&xnshirqs[i].active, 0);
> +#endif
> +	}
> +	return 0;
> +}
> +
> +#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
> +
> +static inline int xnintr_irq_attach(xnintr_t *intr)
> +{
> +	return xnarch_hook_irq(intr->irq, &xnintr_irq_handler, intr->iack, intr);
> +}
> +
> +static inline int xnintr_irq_detach(xnintr_t *intr)
> +{
> +	return xnarch_release_irq(intr->irq);
> +}
> +
> +void xnintr_synchronize(xnintr_t *intr) {}
> +int xnintr_mount(void) { return 0; }
> +
> +#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
> +
> +/*!
> + * \fn int xnintr_init (xnintr_t *intr,const char *name,unsigned irq,xnisr_t isr,xniack_t iack,xnflags_t flags)
> + * \brief Initialize an interrupt object.
> + *
> + * Associates an interrupt object with an IRQ line.
> + *
> + * When an interrupt occurs on the given @a irq line, the ISR is fired
> + * in order to deal with the hardware event. The interrupt service
> + * code may call any non-suspensive service from the nucleus.
> + *
> + * Upon receipt of an IRQ, the ISR is immediately called on behalf of
> + * the interrupted stack context, the rescheduling procedure is
> + * locked, and the interrupt source is masked at hardware level. The
> + * status value returned by the ISR is then checked for the following
> + * values:
> + *
> + * - XN_ISR_HANDLED indicates that the interrupt request has been fulfilled
> + * by the ISR.
> + *
> + * - XN_ISR_NONE indicates the opposite to XN_ISR_HANDLED. The ISR must always
> + * return this value when it determines that the interrupt request has not been
> + * issued by the dedicated hardware device.
> + *
> + * In addition, one of the following bits may be set by the ISR :
> + *
> + * NOTE: use these bits with care and only when you do understand their effect
> + * on the system.
> + * The ISR is not encouraged to use these bits in case it shares the IRQ line
> + * with other ISRs in the real-time domain.
> + *
> + * - XN_ISR_PROPAGATE tells the nucleus to require the real-time control
> + * layer to forward the IRQ. For instance, this would cause the Adeos
> + * control layer to propagate the interrupt down the interrupt
> + * pipeline to other Adeos domains, such as Linux. This is the regular
> + * way to share interrupts between the nucleus and the host system.
> + *
> + * - XN_ISR_NOENABLE causes the nucleus to ask the real-time control
> + * layer _not_ to re-enable the IRQ line (read the following section).
> + * xnarch_end_irq() must be called to re-enable the IRQ line later.
> + *
> + * The nucleus re-enables the IRQ line by default. Over some real-time
> + * control layers which mask and acknowledge IRQs, this operation is
> + * necessary to revalidate the interrupt channel so that more interrupts
> + * can be notified.
> + *
> + * A count of interrupt receipts is tracked into the interrupt
> + * descriptor, and reset to zero each time the interrupt object is
> + * attached. Since this count could wrap around, it should be used as
> + * an indication of interrupt activity only.
> + *
> + * @param intr The address of a interrupt object descriptor the
> + * nucleus will use to store the object-specific data.  This
> + * descriptor must always be valid while the object is active
> + * therefore it must be allocated in permanent memory.
> + *
> + * @param name An ASCII string standing for the symbolic name of the
> + * interrupt object.
> + *
> + * @param irq The hardware interrupt channel associated with the
> + * interrupt object. This value is architecture-dependent. An
> + * interrupt object must then be attached to the hardware interrupt
> + * vector using the xnintr_attach() service for the associated IRQs
> + * to be directed to this object.
> + *
> + * @param isr The address of a valid low-level interrupt service
> + * routine if this parameter is non-zero. This handler will be called
> + * each time the corresponding IRQ is delivered on behalf of an
> + * interrupt context.  When called, the ISR is passed the descriptor
> + * address of the interrupt object.
> + *
> + * @param iack The address of an optional interrupt acknowledge
> + * routine, aimed at replacing the default one. Only very specific
> + * situations actually require to override the default setting for
> + * this parameter, like having to acknowledge non-standard PIC
> + * hardware. @a iack should return a non-zero value to indicate that
> + * the interrupt has been properly acknowledged. If @a iack is NULL,
> + * the default routine will be used instead.
> + *
> + * @param flags A set of creation flags affecting the operation. The
> + * valid flags are:
> + *
> + * - XN_ISR_SHARED enables IRQ-sharing with other interrupt objects.
> + *
> + * - XN_ISR_EDGE is an additional flag need to be set together with XN_ISR_SHARED
> + * to enable IRQ-sharing of edge-triggered interrupts.
> + *
> + * @return No error condition being defined, 0 is always returned.
> + *
> + * Environments:
> + *
> + * This service can be called from:
> + *
> + * - Kernel module initialization/cleanup code
> + * - Kernel-based task
> + * - User-space task
> + *
> + * Rescheduling: never.
> + */
> +
> +int xnintr_init(xnintr_t *intr,
> +		const char *name,
> +		unsigned irq, xnisr_t isr, xniack_t iack, xnflags_t flags)
> +{
> +	intr->irq = irq;
> +	intr->isr = isr;
> +	intr->iack = iack;
> +	intr->cookie = NULL;
> +	intr->hits = 0;
> +	intr->name = name;
> +	intr->flags = flags;
> +	intr->unhandled = 0;
> +#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
> +	intr->next = NULL;
> +#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
> +
> +	return 0;
> +}
> +
> +/*!
> + * \fn int xnintr_destroy (xnintr_t *intr)
> + * \brief Destroy an interrupt object.
> + *
> + * Destroys an interrupt object previously initialized by
> + * xnintr_init(). The interrupt object is automatically detached by a
> + * call to xnintr_detach(). No more IRQs will be dispatched by this
> + * object after this service has returned.
> + *
> + * @param intr The descriptor address of the interrupt object to
> + * destroy.
> + *
> + * @return 0 is returned on success. Otherwise, -EBUSY is returned if
> + * an error occurred while detaching the interrupt (see
> + * xnintr_detach()).
> + *
> + * Environments:
> + *
> + * This service can be called from:
> + *
> + * - Kernel module initialization/cleanup code
> + * - Kernel-based task
> + * - User-space task
> + *
> + * Rescheduling: never.
> + */
> +
> +int xnintr_destroy(xnintr_t *intr)
> +{
> +	xnintr_detach(intr);
> +	return 0;
>  }
>  
> -#endif /* CONFIG_XENO_OPT_SHIRQ_EDGE */
> +/*!
> + * \fn int xnintr_attach (xnintr_t *intr, void *cookie);
> + * \brief Attach an interrupt object.
> + *
> + * Attach an interrupt object previously initialized by
> + * xnintr_init(). After this operation is completed, all IRQs received
> + * from the corresponding interrupt channel are directed to the
> + * object's ISR.
> + *
> + * @param intr The descriptor address of the interrupt object to
> + * attach.
> + *
> + * @param cookie A user-defined opaque value which is stored into the
> + * interrupt object descriptor for further retrieval by the ISR/ISR
> + * handlers.
> + *
> + * @return 0 is returned on success. Otherwise, -EINVAL is returned if
> + * a low-level error occurred while attaching the interrupt. -EBUSY is
> + * specifically returned if the interrupt object was already attached.
> + *
> + * Environments:
> + *
> + * This service can be called from:
> + *
> + * - Kernel module initialization/cleanup code
> + * - Kernel-based task
> + * - User-space task
> + *
> + * Rescheduling: never.
> + *
> + * @note Attaching an interrupt resets the tracked number of receipts
> + * to zero.
> + */
>  
> -int xnintr_irq_attach(xnintr_t *intr)
> +int xnintr_attach(xnintr_t *intr, void *cookie)
>  {
> -	xnintr_shirq_t *shirq = &xnshirqs[intr->irq];
> -	xnintr_t *prev, **p = &shirq->handlers;
>  	int err;
> +	spl_t s;
>  
> -	if (intr->irq >= RTHAL_NR_IRQS)
> -		return -EINVAL;
> -
> -	if (__testbits(intr->flags, XN_ISR_ATTACHED))
> -		return -EPERM;
> -
> -	if ((prev = *p) != NULL) {
> -		/* Check on whether the shared mode is allowed. */
> -		if (!(prev->flags & intr->flags & XN_ISR_SHARED) ||
> -		    (prev->iack != intr->iack)
> -		    || ((prev->flags & XN_ISR_EDGE) !=
> -			(intr->flags & XN_ISR_EDGE)))
> -			return -EBUSY;
> -
> -		/* Get a position at the end of the list to insert the new element. */
> -		while (prev) {
> -			p = &prev->next;
> -			prev = *p;
> -		}
> -	} else {
> -		/* Initialize the corresponding interrupt channel */
> -		void (*handler) (unsigned, void *) = &xnintr_irq_handler;
> -
> -		if (intr->flags & XN_ISR_SHARED) {
> -#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL)
> -			handler = &xnintr_shirq_handler;
> -#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL */
> -
> -#if defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
> -			if (intr->flags & XN_ISR_EDGE)
> -				handler = &xnintr_edge_shirq_handler;
> -#endif /* CONFIG_XENO_OPT_SHIRQ_EDGE */
> -		}
> -		shirq->unhandled = 0;
> +	intr->hits = 0;
> +	intr->cookie = cookie;
>  
> -		err = xnarch_hook_irq(intr->irq, handler, intr->iack, intr);
> -		if (err)
> -			return err;
> -	}
> +	xnlock_get_irqsave(&intrlock, s);
>  
> -	__setbits(intr->flags, XN_ISR_ATTACHED);
> +	err = xnintr_irq_attach(intr);
>  
> -	/* Add a given interrupt object. */
> -	intr->next = NULL;
> -	*p = intr;
> +	xnlock_put_irqrestore(&intrlock, s);
>  
> -	return 0;
> +	return err;
>  }
>  
> -int xnintr_irq_detach(xnintr_t *intr)
> -{
> -	xnintr_shirq_t *shirq = &xnshirqs[intr->irq];
> -	xnintr_t *e, **p = &shirq->handlers;
> -	int err = 0;
> -
> -	if (intr->irq >= RTHAL_NR_IRQS)
> -		return -EINVAL;
> +/*!
> + * \fn int xnintr_detach (xnintr_t *intr)
> + * \brief Detach an interrupt object.
> + *
> + * Detach an interrupt object previously attached by
> + * xnintr_attach(). After this operation is completed, no more IRQs
> + * are directed to the object's ISR, but the interrupt object itself
> + * remains valid. A detached interrupt object can be attached again by
> + * a subsequent call to xnintr_attach().
> + *
> + * @param intr The descriptor address of the interrupt object to
> + * detach.
> + *
> + * @return 0 is returned on success. Otherwise, -EINVAL is returned if
> + * a low-level error occurred while detaching the interrupt. Detaching
> + * a non-attached interrupt object leads to a null-effect and returns
> + * 0.
> + *
> + * Environments:
> + *
> + * This service can be called from:
> + *
> + * - Kernel module initialization/cleanup code
> + * - Kernel-based task
> + * - User-space task
> + *
> + * Rescheduling: never.
> + */
>  
> -	if (!__testbits(intr->flags, XN_ISR_ATTACHED))
> -		return -EPERM;
> +int xnintr_detach(xnintr_t *intr)
> +{
> +	int err;
> +	spl_t s;
>  
> -	__clrbits(intr->flags, XN_ISR_ATTACHED);
> +	xnlock_get_irqsave(&intrlock, s);
>  
> -	while ((e = *p) != NULL) {
> -		if (e == intr) {
> -			/* Remove a given interrupt object from the list. */
> -			*p = e->next;
> +	err = xnintr_irq_detach(intr);
>  
> -			/* Release the IRQ line if this was the last user */
> -			if (shirq->handlers == NULL)
> -				err = xnarch_release_irq(intr->irq);
> +	xnlock_put_irqrestore(&intrlock, s);
>  
> -			return err;
> -		}
> -		p = &e->next;
> -	}
> +	/* The idea here is to keep a detached interrupt object valid as long
> +	   as the corresponding irq handler is running. This is one of the
> +	   requirements to iterate over the xnintr_shirq_t::handlers list in
> +	   xnintr_irq_handler() in a lockless way. */
> +	xnintr_synchronize(intr);
>  
> -	xnlogerr("attempted to detach a non previously attached interrupt "
> -		 "object.\n");
>  	return err;
>  }
>  
> -int xnintr_mount(void)
> -{
> -	int i;
> -	for (i = 0; i < RTHAL_NR_IRQS; ++i) {
> -		xnshirqs[i].handlers = NULL;
> -#ifdef CONFIG_SMP
> -		atomic_set(&xnshirqs[i].active, 0);
> -#endif
> -	}
> -	return 0;
> -}
> +/*!
> + * \fn int xnintr_enable (xnintr_t *intr)
> + * \brief Enable an interrupt object.
> + *
> + * Enables the hardware interrupt line associated with an interrupt
> + * object. Over real-time control layers which mask and acknowledge
> + * IRQs, this operation is necessary to revalidate the interrupt
> + * channel so that more interrupts can be notified.
>  
> -#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
> + * @param intr The descriptor address of the interrupt object to
> + * enable.
> + *
> + * @return 0 is returned on success. Otherwise, -EINVAL is returned if
> + * a low-level error occurred while enabling the interrupt.
> + *
> + * Environments:
> + *
> + * This service can be called from:
> + *
> + * - Kernel module initialization/cleanup code
> + * - Kernel-based task
> + * - User-space task
> + *
> + * Rescheduling: never.
> + */
>  
> -int xnintr_irq_attach(xnintr_t *intr)
> +int xnintr_enable(xnintr_t *intr)
>  {
> -	return xnarch_hook_irq(intr->irq, &xnintr_irq_handler, intr->iack, intr);
> +	return xnarch_enable_irq(intr->irq);
>  }
>  
> -int xnintr_irq_detach(xnintr_t *intr)
> +/*!
> + * \fn int xnintr_disable (xnintr_t *intr)
> + * \brief Disable an interrupt object.
> + *
> + * Disables the hardware interrupt line associated with an interrupt
> + * object. This operation invalidates further interrupt requests from
> + * the given source until the IRQ line is re-enabled anew.
> + *
> + * @param intr The descriptor address of the interrupt object to
> + * disable.
> + *
> + * @return 0 is returned on success. Otherwise, -EINVAL is returned if
> + * a low-level error occurred while disabling the interrupt.
> + *
> + * Environments:
> + *
> + * This service can be called from:
> + *
> + * - Kernel module initialization/cleanup code
> + * - Kernel-based task
> + * - User-space task
> + *
> + * Rescheduling: never.
> + */
> +
> +int xnintr_disable(xnintr_t *intr)
>  {
> -	return xnarch_release_irq(intr->irq);
> +	return xnarch_disable_irq(intr->irq);
>  }
>  
> -void xnintr_synchronize(xnintr_t *intr) {}
> -int xnintr_mount(void) { return 0; }
> +/*!
> + * \fn xnarch_cpumask_t xnintr_affinity (xnintr_t *intr, xnarch_cpumask_t cpumask)
> + * \brief Set interrupt's processor affinity.
> + *
> + * Causes the IRQ associated with the interrupt object @a intr to be
> + * received only on processors which bits are set in @a cpumask.
> + *
> + * @param intr The descriptor address of the interrupt object which
> + * affinity is to be changed.
> + *
> + * @param cpumask The new processor affinity of the interrupt object.
> + *
> + * @return the previous cpumask on success, or an empty mask on
> + * failure.
> + *
> + * @note Depending on architectures, setting more than one bit in @a
> + * cpumask could be meaningless.
> + */
>  
> -#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
> +xnarch_cpumask_t xnintr_affinity(xnintr_t *intr, xnarch_cpumask_t cpumask)
> +{
> +	return xnarch_set_irq_affinity(intr->irq, cpumask);
> +}
>  
> +#ifdef CONFIG_PROC_FS
>  int xnintr_irq_proc(unsigned int irq, char *str)
>  {
>  	xnintr_t *intr;
> @@ -765,6 +759,7 @@ int xnintr_irq_proc(unsigned int irq, ch
>  
>  	return p - str;
>  }
> +#endif /* CONFIG_PROC_FS */
>  
>  EXPORT_SYMBOL(xnintr_attach);
>  EXPORT_SYMBOL(xnintr_destroy);
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



