Content-Type: text/plain; charset="utf-8"
Date: Fri, 09 Nov 2007 15:40:45 +0100
From: "Matthias Frauendorf" <MAHAVIRA@gmx.net>
In-Reply-To: <4734661D.4010705@domain.hid>
Message-ID: <20071109144045.246910@domain.hid>
MIME-Version: 1.0
References: <20071108155600.149430@domain.hid>	<473335D0.1040502@domain.hid>
	<20071109104334.244480@domain.hid>	<473442D8.809@domain.hid>
	<4734661D.4010705@domain.hid>
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help]
 =?utf-8?q?Error_during_make=2C_error=3A_=E2=80=98s?=
 =?utf-8?q?truct_tss=5Fstruct=E2=80=99_has_no_member_named_=E2=80=98io=5Fb?=
 =?utf-8?b?aXRtYXBfYmFzZeKAmQ==?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


-------- Original-Nachricht --------
> Datum: Fri, 09 Nov 2007 14:52:29 +0100
> Von: Philippe Gerum <rpm@xenomai.org>
> An: Jan Kiszka <jan.kiszka@domain.hid>
> CC: xenomai-help <xenomai@xenomai.org>, MAHAVIRA@gmx.net
> Betreff: Re: [Xenomai-help] Error during make, error: ‘struct tss_struct’ has no member named ‘io_bitmap_base’

> Jan Kiszka wrote:
> > Please take care of all CCs.
> > 
> > MAHAVIRA@gmx.net wrote:
> >> -------- Original-Nachricht --------
> >>> Datum: Thu, 08 Nov 2007 17:14:08 +0100
> >>> Von: Jan Kiszka <jan.kiszka@domain.hid>
> >>> An: MAHAVIRA@gmx.net
> >>> CC: xenomai@xenomai.org
> >>> Betreff: Re: [Xenomai-help] Error during make, error: ‘struct
> tss_struct’ has no member named ‘io_bitmap_base’
> >>> MAHAVIRA@gmx.net wrote:
> >>>> Hello, 
> >>>>
> >>>> i get an error during make of the new linux kernel with xenomai
> >>>> support. i use
> >>>> /usr/src/linux-2.6.23
> >>>> /usr/src/adeos-ipipe-2.6.23-i386-1.10-11.patch
> >>>> /usr/src/xenomai-2.3.4
> >>>>
> >>>> i patched the kernel-source with ./prepare-kernel.sh and copy a
> config
> >>>> file from my old kernel (2.6.22-14-generic) to .config, use make
> >>> menuconfig
> >>>> and sudo make. i receive this error:
> >>>>
> >>>> CC      kernel/xenomai/arch/generic/hal.o
> >>>> In file included from include/asm/xenomai/hal.h:40,
> >>>>                  from kernel/xenomai/arch/generic/hal.c:42:
> >>>> include/asm/xenomai/wrappers.h: In function
> ‘wrap_switch_iobitmap’:
> >>>> include/asm/xenomai/wrappers.h:86: error: ‘struct tss_struct’ has
> no
> >>> member named ‘io_bitmap_base’
> >>>> include/asm/xenomai/wrappers.h:96: error: ‘struct tss_struct’ has
> no
> >>> member named ‘io_bitmap_base’
> >>>> make[4]: *** [kernel/xenomai/arch/generic/hal.o] Error 1
> >>>> make[3]: *** [kernel/xenomai/arch/generic] Error 2
> >>>> make[2]: *** [kernel/xenomai/arch] Error 2
> >>>> make[1]: *** [kernel/xenomai] Error 2
> >>>> make: *** [kernel] Error 2
> >>>>
> >>>> any help?
> >>> Use Xenomai 2.4-rc5. Regarding i386, Xenomai 2.3.x only supports
> kernels
> >>> up to 2.6.20.x.
> >>>
> >>> Jan
> >>
> >> ok, i use now 
> >>
> >> linux-2.6.23
> >> xenomai-2.4-rc5
> >> adeos-ipipe-2.6.23-i386-1.10-11.patch
> >>
> >> the error above disappears, but there is another error now:
> >>
> >>   CC      arch/i386/xenomai/hal.o
> >> arch/i386/xenomai/hal.c: In function ‘rthal_setup_8254_tsc’:
> >> arch/i386/xenomai/hal.c:551: error: ‘PIT_MODE’ undeclared (first
> use in this function)
> >> arch/i386/xenomai/hal.c:551: error: (Each undeclared identifier is
> reported only once
> >> arch/i386/xenomai/hal.c:551: error: for each function it appears in.)
> >> arch/i386/xenomai/hal.c:552: error: ‘PIT_CH0’ undeclared (first use
> in this function)
> >> arch/i386/xenomai/hal.c:555: error: ‘PIT_CH2’ undeclared (first use
> in this function)
> >> arch/i386/xenomai/hal.c: In function ‘rthal_get_8254_tsc’:
> >> arch/i386/xenomai/hal.c:573: error: ‘PIT_MODE’ undeclared (first
> use in this function)
> >> arch/i386/xenomai/hal.c:574: error: ‘PIT_CH2’ undeclared (first use
> in this function)
> >> make[1]: *** [arch/i386/xenomai/hal.o] Error 1
> >> make: *** [arch/i386/xenomai] Error 2
> >>
> >> any idea?
> > 
> > The above looks like a real build issue of latest Xenomai with oldish
> > CPU setups. Thanks for reporting, queued for a closer look later.
> > 
> > In the meantime you could select a CPU type that is closer to your
> > hardware, thus avoiding to use that suboptimal TSC emulation.
> 
> non-TSC + X86_LOCAL_APIC combination:
> 
> --- include/asm-i386/hal.h~	2007-10-27 15:43:15.000000000 +0200
> +++ include/asm-i386/hal.h	2007-11-09 14:50:23.000000000 +0100
> @@ -64,11 +64,10 @@
>  #ifdef CONFIG_X86_LOCAL_APIC
>  #include <asm/fixmap.h>
>  #include <asm/apic.h>
> -#else
> +#endif /* CONFIG_X86_LOCAL_APIC */
>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,23)
>  #include <asm/i8253.h>
>  #endif
> -#endif /* CONFIG_X86_LOCAL_APIC */
>  #include <asm/msr.h>
>  #include <asm/xenomai/atomic.h>
>  #include <asm/xenomai/smi.h>
> 
> 
> -- 
> Philippe.


hi, we do so, but unfortunately a new error appears:

with: hal.h

#ifndef __cplusplus
#include <asm/system.h>
#include <asm/io.h>
#include <asm/timex.h>
#include <asm/processor.h>
#include <io_ports.h>
#ifdef CONFIG_X86_LOCAL_APIC
#include <asm/fixmap.h>
#include <asm/apic.h>
//#else
#endif
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,23)
#include <asm/i8253.h>
#endif
//#endif /* CONFIG_X86_LOCAL_APIC */

  CC      kernel/xenomai/arch/generic/hal.o
In file included from kernel/xenomai/arch/generic/hal.c:47:
include/asm/xenomai/hal.h:2: error: stray ‘@’ in program
include/asm/xenomai/hal.h:2: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘hal’
include/asm/xenomai/hal.h:3: error: stray ‘@’ in program
include/asm/xenomai/hal.h:7: error: stray ‘\’ in program
include/asm/xenomai/hal.h:8: error: expected identifier or ‘(’ before numeric constant
include/asm/xenomai/hal.h:8: error: stray ‘\’ in program
include/asm/xenomai/hal.h:9: error: expected identifier or ‘(’ before numeric constant
include/asm/xenomai/hal.h:9: error: stray ‘\’ in program
include/asm/xenomai/hal.h:10: error: expected identifier or ‘(’ before numeric constant
include/asm/xenomai/hal.h:10: error: stray ‘\’ in program
include/asm/xenomai/hal.h:13: error: stray ‘\’ in program
include/asm/xenomai/hal.h:14: error: expected identifier or ‘(’ before numeric constant
include/asm/xenomai/hal.h:15: error: stray ‘\’ in program
include/asm/xenomai/hal.h:16: error: expected identifier or ‘(’ before numeric constant
include/asm/xenomai/hal.h:17: error: stray ‘\’ in program
include/asm/xenomai/hal.h:18: error: expected identifier or ‘(’ before numeric constant
include/asm/xenomai/hal.h:20: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘can’
In file included from kernel/xenomai/arch/generic/hal.c:47:
include/asm/xenomai/hal.h:23:19: error: invalid digit "9" in octal constant
include/asm/xenomai/hal.h:23: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘version’
include/asm/xenomai/hal.h:27: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘even’
include/asm/xenomai/hal.h:32: error: expected identifier or ‘(’ before ‘if’
make[4]: *** [kernel/xenomai/arch/generic/hal.o] Error 1
make[3]: *** [kernel/xenomai/arch/generic] Error 2
make[2]: *** [kernel/xenomai/arch] Error 2
make[1]: *** [kernel/xenomai] Error 2
make: *** [kernel] Error 2

new idea?

Karl+Mat








-- 
GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail

