Subject: Re: [Adeos-main] [PATCH] x86: revert IRQs replay order
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4538A613.80606@domain.hid>
References: <4538A613.80606@domain.hid>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 15:21:18 +0200
Message-Id: <1161350478.4988.17.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Fri, 2006-10-20 at 12:33 +0200, Jan Kiszka wrote:
> While digging into a latency issue with multiple IRQs pending (patch
> will likely follow soon), I noticed that the replay order on x86 is the
> inverse of the hardware order. Instead of iterating from lowest IRQ
> number to highest, ipipe currently starts with the highest one. The
> attached patch fixes this.
> 

We want to give a priority boost to virtual IRQs over real ones, at
least for the root domain. Since virqs are high-numbered, bsrl has been
used on purpose to scan the pending IRQ mask. Additionally, low-numbered
IRQs have higher priority only if you consider the ISA ones as managed
by the 8259. Bringing the APIC into the picture, the APIC-based timer
IRQ used by RTOSes over Adeos is a high-numbered one.

> Jan
> plain text document attachment (fix-x86-irq-replay-order.patch)
> Index: linux-2.6.17.13/include/asm-i386/ipipe.h
> ===================================================================
> --- linux-2.6.17.13.orig/include/asm-i386/ipipe.h
> +++ linux-2.6.17.13/include/asm-i386/ipipe.h
> @@ -242,8 +242,7 @@ extern int __ipipe_tick_irq;
>  
>  static inline unsigned long __ipipe_ffnz(unsigned long ul)
>  {
> -      __asm__("bsrl %1, %0":"=r"(ul)
> -      :	"r"(ul));
> +	__asm__("bsfl %1, %0":"=r"(ul):"r"(ul));
>  	return ul;
>  }
>  
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 
Philippe.



