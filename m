From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44D8C30D.4020400@domain.hid>
References: <44D8C30D.4020400@domain.hid>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 19:53:26 +0200
Message-Id: <1155059607.4319.31.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Adeos-main] [PATCH] start tracer disabled
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
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

On Tue, 2006-08-08 at 18:59 +0200, Jan Kiszka wrote:
> Hi,
> 
> this tiny patch adds a config option to I-pipe to allow starting the
> system with the tracer compiled in but disabled. You can then enabled it
> on demand via /proc/ipipe/tracer/enable. This saves a bit time when
> booting low-end boxes (I wonder why I didn't hacked this earlier...).
> 

Merged, thanks.

> Jan
> plain text document attachment (tracer-default-off.patch)
> Index: linux-2.6.17.8/kernel/ipipe/Kconfig
> ===================================================================
> --- linux-2.6.17.8.orig/kernel/ipipe/Kconfig
> +++ linux-2.6.17.8/kernel/ipipe/Kconfig
> @@ -6,7 +6,7 @@ config IPIPE
>  	  compiled in.
>  
>  config IPIPE_TRACE
> - 	bool "Latency Tracing"
> +	bool "Latency tracing"
>  	depends on IPIPE && PROC_FS
>  	select FRAME_POINTER
>  	default n
> @@ -18,6 +18,15 @@ config IPIPE_TRACE
>  	  in-kernel tracing API. The collected data and runtime control
>  	  is available via /proc/ipipe/trace/*.
>  
> +config IPIPE_TRACE_ENABLE
> +	bool "Enable tracing on boot"
> +	depends on IPIPE_TRACE
> +	default y
> +	---help---
> +	  Disable this option if you want to arm the tracer after booting
> +	  manually ("echo 1 > /proc/ipipe/tracer/enable"). This can reduce
> +	  boot time on slow embedded devices due to the tracer overhead.
> +
>  config IPIPE_TRACE_IRQSOFF
>  	bool "Trace IRQs-off times"
>  	depends on IPIPE_TRACE
> @@ -44,3 +53,8 @@ config IPIPE_TRACE_VMALLOC
>  	  enabled. This can help to start systems that are low on memory,
>  	  but it slightly degrades overall performance. Try this option
>  	  when a traced kernel hangs unexpectedly at boot time.
> +
> +config IPIPE_TRACE_ENABLE_VALUE
> +	int
> +	default 0 if !IPIPE_TRACE_ENABLE
> +	default 1 if IPIPE_TRACE_ENABLE
> Index: linux-2.6.17.8/kernel/ipipe/tracer.c
> ===================================================================
> --- linux-2.6.17.8.orig/kernel/ipipe/tracer.c
> +++ linux-2.6.17.8/kernel/ipipe/tracer.c
> @@ -105,7 +105,7 @@ enum ipipe_trace_type
>  static struct ipipe_trace_path *trace_paths[NR_CPUS];
>  
>  #else /* !CONFIG_IPIPE_TRACE_VMALLOC */
> -#define IPIPE_DEFAULT_TRACE_STATE   1
> +#define IPIPE_DEFAULT_TRACE_STATE   CONFIG_IPIPE_TRACE_ENABLE_VALUE
>  
>  static struct ipipe_trace_path trace_paths[NR_CPUS][IPIPE_TRACE_PATHS] =
>  	{ [0 ... NR_CPUS-1] =
> @@ -1217,7 +1217,7 @@ void __init __ipipe_init_tracer(void)
>  			trace_paths[cpu][path].end   = -1;
>  		}
>  	}
> -	ipipe_trace_enable = 1;
> +	ipipe_trace_enable = CONFIG_IPIPE_TRACE_ENABLE_VALUE;
>  #endif /* CONFIG_IPIPE_TRACE_VMALLOC */
>  
>  	trace_dir = create_proc_entry("trace", S_IFDIR, ipipe_proc_root);
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 
Philippe.



