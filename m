From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44E0AB77.3080705@domain.hid>
References: <44E0AB77.3080705@domain.hid>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 16:46:18 +0200
Message-Id: <1155912378.4326.102.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [PATCH] fix 2.4 build of mksound workaround
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

On Mon, 2006-08-14 at 18:57 +0200, Jan Kiszka wrote:
> Hi Philippe,
> 
> various issues with the new mksound workaround for x86-2.4 kernels
> popped up here during test builds (wrong dependency on
> CONFIG_XENO_HW_NMI_DEBUG_LATENCY, missing dep on CONFIG_VT, missing
> linux/vt_kern.h). The attached patch aims at fixing them. Compile-tested
> over 2.4.33.

Applied, thanks.

> 
> Additionally, you may remove the EXPORT_SYMBOL(kd_mksound) from the
> latest ipipe patch. A) it's broken in case of !CONFIG_VT, B) it should
> not be required given that kd_mksound is only needed by the hal, and
> that's built-in anyway. Or do you have non-Xenomai users in mind here?
> 

Nope. This export is indeed useless and will be removed, thanks.

> Jan
> plain text document attachment (fix-mksound-workaround.patch)
> Index: ksrc/arch/i386/hal.c
> ===================================================================
> --- ksrc/arch/i386/hal.c	(revision 1435)
> +++ ksrc/arch/i386/hal.c	(working copy)
> @@ -62,6 +62,16 @@
>  #include <asm/xenomai/hal.h>
>  #include <stdarg.h>
>  
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0) && !defined(CONFIG_X86_TSC) && defined(CONFIG_VT)
> +#include <linux/vt_kern.h>
> +
> +static void (*old_mksound)(unsigned int hz, unsigned int ticks);
> +
> +static void dummy_mksound (unsigned int hz, unsigned int ticks)
> +{
> +}
> +#endif /* Linux < 2.6 && !CONFIG_X86_TSC && CONFIG_VT */
> +
>  extern struct desc_struct idt_table[];
>  
>  static struct {
> @@ -206,12 +216,6 @@ void die_nmi(struct pt_regs *regs, const
>      do_exit(SIGSEGV);
>  }
>  
> -static void (*old_mksound)(unsigned int hz, unsigned int ticks);
> -
> -static void dummy_mksound (unsigned int hz, unsigned int ticks)
> -{
> -}
> -
>  #else /* Linux >= 2.6 */
>  #include <asm/nmi.h>
>  #endif /* Linux < 2.6 */
> @@ -601,13 +605,13 @@ int rthal_arch_init(void)
>          rthal_smi_restore();
>          return -ENODEV;
>      }
> -#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0) && !defined(CONFIG_X86_TSC)
> +#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0) && !defined(CONFIG_X86_TSC) && defined(CONFIG_VT)
>      /* Prevent the speaker code from bugging our TSC emulation, also
>         based on PIT channel 2. kd_mksound is exported by the Adeos
>         patch. */
>      old_mksound = kd_mksound;
>      kd_mksound = &dummy_mksound;
> -#endif /* !CONFIG_X86_LOCAL_APIC && Linux < 2.6 && !CONFIG_X86_TSC */
> +#endif /* !CONFIG_X86_LOCAL_APIC && Linux < 2.6 && !CONFIG_X86_TSC && CONFIG_VT */
>  
>      if (rthal_cpufreq_arg == 0)
>  #ifdef CONFIG_X86_TSC
> @@ -631,10 +635,10 @@ int rthal_arch_init(void)
>  
>  void rthal_arch_cleanup(void)
>  {
> -#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0) && !defined(CONFIG_X86_TSC)
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0) && !defined(CONFIG_X86_TSC) && defined(CONFIG_VT)
>      /* Restore previous PC speaker code. */
>      kd_mksound = old_mksound;
> -#endif /* Linux < 2.6 && !CONFIG_X86_TSC */
> +#endif /* Linux < 2.6 && !CONFIG_X86_TSC && CONFIG_VT */
>      printk(KERN_INFO "Xenomai: hal/x86 stopped.\n");
>  }
>  
-- 
Philippe.



