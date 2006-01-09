Message-ID: <43C1C9F5.2050108@domain.hid>
Date: Mon, 09 Jan 2006 03:27:01 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <43C18FCB.9080404@domain.hid>
In-Reply-To: <43C18FCB.9080404@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [PATCH] fix tracer compilation issues
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
> Hi Philippe,
> 
> two minor updates I fixed since your last merge. The first one triggers
> if the tracer tries to warn of debugging switch related latencies. The
> second one when building very specific out-of-tree modules against the
> kernel (here: madwifi with its binary-only component), stumbling over
> -pg vs. -fomit-frame-pointer.
> 
> No need for a separate ipipe release from my POV, just apply for the
> next round.
>

Ok, queued. Thanks.

> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> --- ./kernel/ipipe/tracer.c.orig	2006-01-07 13:28:01.000000000 +0100
> +++ ./kernel/ipipe/tracer.c	2006-01-08 23:08:45.000000000 +0100
> @@ -821,7 +821,7 @@ static void *__ipipe_frozen_prtrace_star
>  			"------------------------------------------------------"
>  			"------\n",
>  			UTS_RELEASE, IPIPE_ARCH_STRING);
> -		__ipipe_print_dbgwarning();
> +		__ipipe_print_dbgwarning(m);
>  		seq_printf(m, "Freeze: %lld cycles, Trace Points: %d (+%d)\n\n",
>  			print_path->point[print_path->begin].timestamp,
>  			print_pre_trace+1, print_post_trace);
> --- ./kernel/ipipe/Kconfig.orig	2006-01-07 13:28:01.000000000 +0100
> +++ ./kernel/ipipe/Kconfig	2006-01-07 14:24:50.000000000 +0100
> @@ -17,6 +17,7 @@ config IPIPE_STATS
>  config IPIPE_TRACE
>   	bool "Latency Tracing"
>  	depends on IPIPE && PROC_FS
> +	select FRAME_POINTER
>  	default n
>  	---help---
>  	  Activate this option if you want to use per-function tracing of


-- 

Philippe.

