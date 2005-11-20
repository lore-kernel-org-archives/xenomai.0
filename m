Message-ID: <43804F2D.8010309@domain.hid>
Date: Sun, 20 Nov 2005 11:25:49 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] xenomai 2.1 ppc64 i-pipe support
References: <437E044E.1030503@domain.hid>
In-Reply-To: <437E044E.1030503@domain.hid>
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
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

Heikki Lindholm wrote:
> Xenomai 2.1:
> 
> - Add ppc64 I-pipe kernel support
> 

Applied, thanks.

> -- Heikki Lindholm
> 
> 
> ------------------------------------------------------------------------
> 
> diff -Nru xenomai/include/asm-powerpc/system.h xenomai-devel/include/asm-powerpc/system.h
> --- xenomai/include/asm-powerpc/system.h	2005-11-08 09:43:39.000000000 +0200
> +++ xenomai-devel/include/asm-powerpc/system.h	2005-11-17 12:51:47.000000000 +0200
> @@ -127,10 +127,17 @@
>  #endif /* CONFIG_PPC64 */
>  #else /* !CONFIG_ADEOS_CORE */
>  #define xnarch_fault_pf_p(fi)   ((fi)->exception == IPIPE_TRAP_ACCESS)
> +#ifdef CONFIG_PPC64
> +#define xnarch_fault_bp_p(fi)   ((current->ptrace & PT_PTRACED) && \
> +				 ((fi)->exception == IPIPE_TRAP_IABR || \
> +				  (fi)->exception == IPIPE_TRAP_SSTEP || \
> +				  (fi)->exception == IPIPE_TRAP_PERFMON))
> +#else /* !CONFIG_PPC64 */
>  #define xnarch_fault_bp_p(fi)   ((current->ptrace & PT_PTRACED) && \
>  				 ((fi)->exception == IPIPE_TRAP_IABR || \
>  				  (fi)->exception == IPIPE_TRAP_SSTEP || \
>  				  (fi)->exception == IPIPE_TRAP_DEBUG))
> +#endif /* CONFIG_PPC64 */
>  #endif /* CONFIG_ADEOS_CORE */
>  
>  #define xnarch_fault_notify(fi) (!xnarch_fault_bp_p(fi))
> diff -Nru xenomai/ksrc/arch/powerpc/switch_64.S xenomai-devel/ksrc/arch/powerpc/switch_64.S
> --- xenomai/ksrc/arch/powerpc/switch_64.S	2005-11-08 09:44:47.000000000 +0200
> +++ xenomai-devel/ksrc/arch/powerpc/switch_64.S	2005-11-17 12:52:06.000000000 +0200
> @@ -24,7 +24,6 @@
>  #include <asm/processor.h>
>  #include <asm/cputable.h>
>  #include <asm/page.h>
> -#include <asm/offsets.h>
>  #include <asm/ppc_asm.h>
>  
>  #define RTHAL_SAVEREG(reg, pos)	std reg,STACK_FRAME_OVERHEAD+8*(pos)(r1)
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

