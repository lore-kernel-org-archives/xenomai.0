Message-ID: <43E4C851.9070308@domain.hid>
Date: Sat, 04 Feb 2006 16:29:21 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] xeno_panic_trace-v2
References: <43E4BEF6.7040502@domain.hid>
In-Reply-To: <43E4BEF6.7040502@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
> Hi Philippe,
> 
> now I finally found the bug in my first version of this patch: some UVM
> skin builds complained about an unknown symbol. Fixed now in this
> version, please apply.

Applied, thanks.

> 
> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: include/asm-uvm/system.h
> ===================================================================
> --- include/asm-uvm/system.h	(Revision 528)
> +++ include/asm-uvm/system.h	(Arbeitskopie)
> @@ -767,4 +767,7 @@
>  #define xnarch_post_graph(obj,state)
>  #define xnarch_post_graph_if(obj,state,cond)
>  
> +/* Ipipe-tracer */
> +#define ipipe_trace_panic_freeze()
> +
>  #endif /* !_XENO_ASM_UVM_SYSTEM_H */
> Index: include/asm-generic/system.h
> ===================================================================
> --- include/asm-generic/system.h	(Revision 528)
> +++ include/asm-generic/system.h	(Arbeitskopie)
> @@ -39,6 +39,13 @@
>  #include <asm/xenomai/atomic.h>
>  #include <nucleus/shadow.h>
>  
> +#ifdef CONFIG_IPIPE_TRACE
> +#include <linux/ipipe_trace.h>
> +#else /* !CONFIG_IPIPE_TRACE */
> +#define ipipe_trace_panic_freeze()
> +#define ipipe_trace_panic_dump()
> +#endif /* CONFIG_IPIPE_TRACE */
> +
>  #define module_param_value(parm) (parm)
>  
>  typedef unsigned long spl_t;
> @@ -185,6 +192,7 @@
>      rthal_emergency_console(); \
>      xnarch_logerr("fatal: %s\n",emsg); \
>      show_stack(NULL,NULL);			\
> +    ipipe_trace_panic_dump();			\
>      for (;;) cpu_relax();			\
>  } while(0)
>  
> Index: include/nucleus/types.h
> ===================================================================
> --- include/nucleus/types.h	(Revision 528)
> +++ include/nucleus/types.h	(Arbeitskopie)
> @@ -107,8 +107,10 @@
>  
>  #define xnpod_fatal(format,args...) \
>  do { \
> -   const char *panic = xnpod_fatal_helper(format,##args); \
> -   xnarch_halt(panic); \
> +    const char *panic; \
> +    ipipe_trace_panic_freeze(); \
> +    panic = xnpod_fatal_helper(format,##args); \
> +    xnarch_halt(panic); \
>  } while (0)
>  
>  #if defined(__XENO_SIM__) || defined(__XENO_UVM__)
> Index: ksrc/nucleus/shadow.c
> ===================================================================
> --- ksrc/nucleus/shadow.c	(Revision 528)
> +++ ksrc/nucleus/shadow.c	(Arbeitskopie)
> @@ -1563,6 +1563,7 @@
>  	    testbits(status,XNSTARTED) &&
>  	    testbits(status,XNPEND))
>  	    {
> +	    ipipe_trace_panic_freeze();
>  	    show_stack(xnthread_user_task(threadin),NULL);
>              xnpod_fatal("blocked thread %s[%d] rescheduled?! (status=0x%lx, sig=%d, prev=%s[%d])",
>  			threadin->name,
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

