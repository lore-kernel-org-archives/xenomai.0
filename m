Subject: Re: [Adeos-main] [PATCH] armnommu compile fix
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20040127000022.GA17036@domain.hid>
References: <20040127000022.GA17036@domain.hid>
Content-Type: text/plain
Message-Id: <1075195744.639.30.camel@domain.hid>
Mime-Version: 1.0
Date: Tue, 27 Jan 2004 10:29:04 +0100
Content-Transfer-Encoding: 7bit
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Paul Mundt <lethal@domain.hid>
Cc: adeos-main@gna.org

On Tue, 2004-01-27 at 01:00, Paul Mundt wrote:
> Hi,
> 
> The current kernel-2.4/adeos-common/include/asm-armnommu/adeos.h has a broken
> __adeos_clear_irq(). This looks like it was copied from an SMP-able adeos.h
> and cleaned up, with only this one line being left over and subsequently
> causing the build to fail.
> 

Indeed it was. Applied, thanks.

> Against current CVS HEAD.
> 
>  kernel-2.4/adeos-common/include/asm-armnommu/adeos.h |    1 -
>  1 files changed, 1 deletion(-)
> 
> Index: kernel-2.4/adeos-common/include/asm-armnommu/adeos.h
> ===================================================================
> RCS file: /cvsroot/adeos/adeos/platforms/linux/kernel-2.4/adeos-common/include/asm-armnommu/adeos.h,v
> retrieving revision 1.20
> diff -u -r1.20 adeos.h
> --- kernel-2.4/adeos-common/include/asm-armnommu/adeos.h	9 Jan 2004 10:06:15 -0000	1.20
> +++ kernel-2.4/adeos-common/include/asm-armnommu/adeos.h	26 Jan 2004 23:59:04 -0000
> @@ -204,7 +204,6 @@
>      clear_bit(IPIPE_LOCK_FLAG,&(adp)->irqs[irq].control); \
>      (adp)->cpudata[0].irq_hits[irq] = 0; \
>      __adeos_clear_pend(adp,irq); \
> -    } \
>  } while(0)
>  
>  #define adeos_virtual_irq_p(irq) ((irq) >= IPIPE_VIRQ_BASE && \
> 
> ______________________________________________________________________
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> http://mail.nongnu.org/mailman/listinfo/adeos-main
-- 

Philippe.



