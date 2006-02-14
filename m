Message-ID: <43F2161D.9000906@domain.hid>
Date: Tue, 14 Feb 2006 18:40:45 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] separate queue debugging switch
References: <43F1C095.8030805@domain.hid>
In-Reply-To: <43F1C095.8030805@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Jan Kiszka wrote:
> Hi,
> 
> while XENO_OPT_DEBUG is generally a useful switch for tracing potential
> issues in the core and the skins, it also introduces high latencies via
> the queue debugging feature (due to checks iterating over whole queues).
> 
> This patch introduces separate control over queue debugging so that you
> can have debug checks without too dramatic slowdowns.
> 

Maybe it's time to introduce debug levels, so that we could reuse them in order to
add more (selectable) debug instrumentation; queue debugging could then be given a
certain level (likely something like CONFIG_XENO_DEBUG_LEVEL=8712 for this 
one...), instead of going for a specific conditional each time we introduce new 
checks?

> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: ksrc/nucleus/Kconfig
> ===================================================================
> --- ksrc/nucleus/Kconfig	(revision 564)
> +++ ksrc/nucleus/Kconfig	(working copy)
> @@ -87,6 +87,15 @@
>  	Do not switch this option on unless you really know what you
>  	are doing.
>  
> +config XENO_OPT_DEBUG_QUEUES
> +	bool "Queue Debugging support"
> +	depends on XENO_OPT_DEBUG
> +	help
> +	
> +	This option activates debugging checks for all queueing
> +	operations of the Xenomai core. It adds even more runtime
> +	overhead then CONFIG_XENO_OPT_DEBUG, use with care.
> +
>  config XENO_OPT_WATCHDOG
>  	bool "Watchdog support"
>  	default n
> Index: include/nucleus/queue.h
> ===================================================================
> --- include/nucleus/queue.h	(revision 564)
> +++ include/nucleus/queue.h	(working copy)
> @@ -57,27 +57,27 @@
>  
>      xnholder_t head;
>      int elems;
> -#if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_DEBUG) && defined(CONFIG_SMP)
> +#if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_DEBUG_QUEUES) && defined(CONFIG_SMP)
>      xnlock_t lock;
> -#endif /* __KERNEL__ && CONFIG_XENO_OPT_DEBUG && CONFIG_SMP */
> +#endif /* __KERNEL__ && CONFIG_XENO_OPT_DEBUG_QUEUES && CONFIG_SMP */
>  
>  } xnqueue_t;
>  
> -#if defined(CONFIG_XENO_OPT_DEBUG) && defined(CONFIG_SMP)
> +#if defined(CONFIG_XENO_OPT_DEBUG_QUEUES) && defined(CONFIG_SMP)
>  #define DECLARE_XNQUEUE(q) xnqueue_t q = { { &(q).head, &(q).head }, 0, XNARCH_LOCK_UNLOCKED }
> -#else /* !(CONFIG_XENO_OPT_DEBUG && CONFIG_SMP) */
> +#else /* !(CONFIG_XENO_OPT_DEBUG_QUEUES && CONFIG_SMP) */
>  #define DECLARE_XNQUEUE(q) xnqueue_t q = { { &(q).head, &(q).head }, 0 }
> -#endif /* CONFIG_XENO_OPT_DEBUG && CONFIG_SMP */
> +#endif /* CONFIG_XENO_OPT_DEBUG_QUEUES && CONFIG_SMP */
>  
>  static inline void initq (xnqueue_t *qslot) {
>      inith(&qslot->head);
>      qslot->elems = 0;
> -#if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_DEBUG) && defined(CONFIG_SMP)
> +#if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_DEBUG_QUEUES) && defined(CONFIG_SMP)
>      xnlock_init(&qslot->lock);
> -#endif /* __KERNEL__ && CONFIG_XENO_OPT_DEBUG && CONFIG_SMP */
> +#endif /* __KERNEL__ && CONFIG_XENO_OPT_DEBUG_QUEUES && CONFIG_SMP */
>  }
>  
> -#ifdef CONFIG_XENO_OPT_DEBUG
> +#ifdef CONFIG_XENO_OPT_DEBUG_QUEUES
>  
>  #if defined(__KERNEL__) || defined(__XENO_UVM__) || defined(__XENO_SIM__)
>  
> @@ -172,7 +172,7 @@
>     dth(__holder);				\
>     --(__qslot)->elems; })
>  
> -#else /* !CONFIG_XENO_OPT_DEBUG */
> +#else /* !CONFIG_XENO_OPT_DEBUG_QUEUES */
>  
>  static inline int insertq (xnqueue_t *qslot,
>                             xnholder_t *head,
> @@ -206,7 +206,7 @@
>      return --qslot->elems;
>  }
>  
> -#endif /* CONFIG_XENO_OPT_DEBUG */
> +#endif /* CONFIG_XENO_OPT_DEBUG_QUEUES */
>  
>  static inline xnholder_t *getheadq (xnqueue_t *qslot)
>  {
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.


