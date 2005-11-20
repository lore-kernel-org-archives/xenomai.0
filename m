Message-ID: <43804F38.7090107@domain.hid>
Date: Sun, 20 Nov 2005 11:26:00 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] xenomai 2.1 ppc64 build fix
References: <437E0529.8030102@domain.hid>
In-Reply-To: <437E0529.8030102@domain.hid>
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
> - powerpc/atomic.h lost one 64-bit #ifdef during the merge - ppc64 
> defines its own atomic mask functions.

Applied, thanks.

> 
> -- Heikki Lindholm
> 
> 
> ------------------------------------------------------------------------
> 
> diff -Nru xenomai/include/asm-powerpc/atomic.h xenomai-devel/include/asm-powerpc/atomic.h
> --- xenomai/include/asm-powerpc/atomic.h	2005-11-08 09:43:39.000000000 +0200
> +++ xenomai-devel/include/asm-powerpc/atomic.h	2005-11-18 15:37:34.000000000 +0200
> @@ -210,6 +210,7 @@
>      return t;
>  }
>  
> +#ifndef __powerpc64__
>  static __inline__ void atomic_set_mask(unsigned long mask,
>  				       unsigned long *ptr)
>  {
> @@ -237,6 +238,7 @@
>  	: "r" (ptr), "r" (mask)
>  	: "r5", "cc", "memory");
>  }
> +#endif /* __powerpc64__ */
>  
>  #define xnarch_atomic_xchg(ptr,v)   atomic_xchg(ptr,v)
>  #define xnarch_memory_barrier()     __asm__ __volatile__("": : :"memory")
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

