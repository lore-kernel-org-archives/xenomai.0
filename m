From: Kunal Anand <erkunalanand@domain.hid>
Date: Fri, 14 Oct 2011 16:32:41 +0000 (UTC)
Message-ID: <loom.20111014T181950-390@domain.hid>
References: <2157_1308732935_4E01AE07_2157_14293_1_ECB646CBB62FD044927FDEDF0252D3E701E388AD6F15@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Xenomai 2.5.6 and 2.6.38.8 kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

VEYSSIERE Nicolas <nicolas.veyssiere <at> thalesgroup.com> writes:


> Same thing here, I tried to patch linux 2.6.38 with the
> latest adeos patch
(http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.38.8-x86-2.10-00.patch)
> but the kernel compilation failed :
> 
>   LD      arch/x86/pci/built-in.o
> 
>   CC      arch/x86/power/cpu.o
> 
>   CC      arch/x86/power/hibernate_32.o
> 
>   AS      arch/x86/power/hibernate_asm_32.o
> 
>   LD      arch/x86/power/built-in.o
> 
>   CC      arch/x86/video/fbdev.o
> 
>   LD      arch/x86/video/built-in.o
> 
>   CC      arch/x86/xenomai/hal_32.o
> 
> arch/x86/xenomai/hal_32.c: In function 'rthal_arch_init':
> 
> arch/x86/xenomai/hal_32.c:341: error: 'nmi_watchdog'
> undeclared (first use in this function)
> 
> arch/x86/xenomai/hal_32.c:341: error: (Each undeclared
> identifier is reported only once
> 
> arch/x86/xenomai/hal_32.c:341: error: for each function it
> appears in.)
> 
> arch/x86/xenomai/hal_32.c:341: error: 'NMI_IO_APIC'
> undeclared (first use in this function)
> 
> At top level:
> 
> cc1: warning: unrecognized command line option
> "-Wno-unused-but-set-variable"
> 
> make[1]: *** [arch/x86/xenomai/hal_32.o] Error 1
> 
> make: *** [arch/x86/xenomai] Error 2
> 
>  
> 
>  

> Can someone tell me what to do ?
> Thanks.
> Regards,
> Nicolas VEYSSIERE
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help <at> gna.org
> https://mail.gna.org/listinfo/xenomai-help
> 


Hi Sir,

I have compiled the Kernel (>20) times now 
and have failed to successfully
implement it.

I desperately need help on it, can you help on it?

In both the cases I am using Linux OS
 Ubuntu 11.04 (kernel 2.6.38.8)
My laptop is Intel Dual 
and any other feature you req to know?

I am fairly new to Linux as well as kernel 
patching so be patient with me and
let me learn.


Case I:
Linux kernel Src tree 2.6.38.8
Xenomai Patch 2.5.6
adeos-ipipe-2.6.38.8-x86-2.10-00.patch

I first faced the error faced above of the 
UNDECLARED VARIABLES
So i declared it myself as 
"int nmi_watchdog =0" and same for the other.

[AS ABOVE]

It got compiled and installed but on boot-up it showed 
" system init fail, code -19
native skin init fail, code -19..." 
and same message for POSIX skin and RTDM skin.

NO IDEA HOW TO SOLVE THIS!!

CASE II:

I tried following Uwue and used a 
previous kernel and same xenomai patch with
the adeos patch for that particular
 kernel but now it is giving me error in the
same function but the error is 
concerning a ")" near the declaration of the
nmi_watchdog and NMI_IO_APIC.


ANY HELP WILL BE APPRECIATED!

Thanks in advance!


