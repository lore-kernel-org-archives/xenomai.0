From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46D6633A.5010906@domain.hid>
References: <46D6633A.5010906@domain.hid>
Content-Type: text/plain
Date: Fri, 07 Sep 2007 09:17:27 +0200
Message-Id: <1189149447.26986.15.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] fix 2.4-kernel build warning
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

On Thu, 2007-08-30 at 08:27 +0200, Jan Kiszka wrote:
> I noticed some warning during a 2.4 build of trunk which may point out
> unexpected side effects:
> 

Merged, thanks.

> In file included from pod.c:45:
> /usr/src/linux-2.4.35.1/include/asm/xenomai/bits/pod.h:32:1: warning: "xnarch_tsc_to_ns" redefined
> In file included from /usr/src/linux-2.4.35.1/include/linux/modversions.h:275,
>                  from /usr/src/linux-2.4.35.1/include/linux/module.h:22,
>                  from /usr/src/linux-2.4.35.1/include/asm-generic/xenomai/system.h:30,
>                  from /usr/src/linux-2.4.35.1/include/asm/xenomai/system.h:28,
>                  from /usr/src/linux-2.4.35.1/include/xenomai/nucleus/types.h:39,
>                  from /usr/src/linux-2.4.35.1/include/xenomai/nucleus/queue.h:24,
>                  from /usr/src/linux-2.4.35.1/include/xenomai/nucleus/timebase.h:29,
>                  from /usr/src/linux-2.4.35.1/include/xenomai/nucleus/timer.h:26,
>                  from /usr/src/linux-2.4.35.1/include/xenomai/nucleus/thread.h:25,
>                  from /usr/src/linux-2.4.35.1/include/xenomai/nucleus/pod.h:34,
>                  from pod.c:36:
> /usr/src/linux-2.4.35.1/include/linux/modules/pod.ver:4:1: warning: this is the location of the previous definition
> 
> However, the attached patch fixes it.
> 
> Jan
> plain text document attachment (fix-2.4-redefine-warning.patch)
> ---
>  include/asm-arm/bits/pod.h      |    2 +-
>  include/asm-blackfin/bits/pod.h |    2 +-
>  include/asm-generic/bits/pod.h  |   10 ++++------
>  include/asm-i386/bits/pod.h     |    2 +-
>  include/asm-x86_64/bits/pod.h   |    2 +-
>  5 files changed, 8 insertions(+), 10 deletions(-)
> 
> Index: xenomai/include/asm-arm/bits/pod.h
> ===================================================================
> --- xenomai.orig/include/asm-arm/bits/pod.h
> +++ xenomai/include/asm-arm/bits/pod.h
> @@ -30,7 +30,7 @@ long long xnarch_tsc_to_ns(long long ts)
>  {
>  	return xnarch_llmulshft(ts, xnarch_tsc_scale, xnarch_tsc_shift);
>  }
> -#define xnarch_tsc_to_ns	xnarch_tsc_to_ns
> +#define XNARCH_TSC_TO_NS
>  
>  #include <asm-generic/xenomai/bits/pod.h>
>  
> Index: xenomai/include/asm-blackfin/bits/pod.h
> ===================================================================
> --- xenomai.orig/include/asm-blackfin/bits/pod.h
> +++ xenomai/include/asm-blackfin/bits/pod.h
> @@ -27,7 +27,7 @@ long long xnarch_tsc_to_ns(long long ts)
>  {
>  	return xnarch_llmulshft(ts, xnarch_tsc_scale, xnarch_tsc_shift);
>  }
> -#define xnarch_tsc_to_ns	xnarch_tsc_to_ns
> +#define XNARCH_TSC_TO_NS
>  
>  #include <asm-generic/xenomai/bits/pod.h>
>  
> Index: xenomai/include/asm-generic/bits/pod.h
> ===================================================================
> --- xenomai.orig/include/asm-generic/bits/pod.h
> +++ xenomai/include/asm-generic/bits/pod.h
> @@ -273,23 +273,21 @@ unsigned long long xnarch_get_host_time(
>  
>  EXPORT_SYMBOL(xnarch_get_host_time);
>  
> -#ifndef xnarch_tsc_to_ns
> +#ifndef XNARCH_TSC_TO_NS
>  long long xnarch_tsc_to_ns(long long ts)
>  {
>      return xnarch_llimd(ts,1000000000,RTHAL_CPU_FREQ);
>  }
> -#define xnarch_tsc_to_ns	xnarch_tsc_to_ns
> -#endif /* !xnarch_tsc_to_ns */
> +#endif /* !XNARCH_TSC_TO_NS */
>  
>  EXPORT_SYMBOL(xnarch_tsc_to_ns);
>  
> -#ifndef xnarch_ns_to_tsc
> +#ifndef XNARCH_NS_TO_TSC
>  long long xnarch_ns_to_tsc(long long ns)
>  {
>      return xnarch_llimd(ns,RTHAL_CPU_FREQ,1000000000);
>  }
> -#define xnarch_ns_to_tsc	xnarch_ns_to_tsc
> -#endif /* !xnarch_ns_to_tsc */
> +#endif /* !XNARCH_NS_TO_TSC */
>  
>  EXPORT_SYMBOL(xnarch_ns_to_tsc);
>  
> Index: xenomai/include/asm-i386/bits/pod.h
> ===================================================================
> --- xenomai.orig/include/asm-i386/bits/pod.h
> +++ xenomai/include/asm-i386/bits/pod.h
> @@ -29,7 +29,7 @@ long long xnarch_tsc_to_ns(long long ts)
>  {
>  	return xnarch_llmulshft(ts, xnarch_tsc_scale, xnarch_tsc_shift);
>  }
> -#define xnarch_tsc_to_ns	xnarch_tsc_to_ns
> +#define XNARCH_TSC_TO_NS
>  
>  #include <asm-generic/xenomai/bits/pod.h>
>  #include <asm/xenomai/switch.h>
> Index: xenomai/include/asm-x86_64/bits/pod.h
> ===================================================================
> --- xenomai.orig/include/asm-x86_64/bits/pod.h
> +++ xenomai/include/asm-x86_64/bits/pod.h
> @@ -28,7 +28,7 @@ long long xnarch_tsc_to_ns(long long ts)
>  {
>  	return xnarch_llmulshft(ts, xnarch_tsc_scale, xnarch_tsc_shift);
>  }
> -#define xnarch_tsc_to_ns	xnarch_tsc_to_ns
> +#define XNARCH_TSC_TO_NS
>  
>  #include <asm-generic/xenomai/bits/pod.h>
>  #include <asm/xenomai/switch.h>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



