Message-ID: <48918B9E.6040407@domain.hid>
Date: Thu, 31 Jul 2008 11:53:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200807311144.19719@domain.hid>
In-Reply-To: <200807311144.19719@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] compile error: asm/mach_apic.h: No such file or
 directory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org

Petr Cervenka wrote:
> Hello,
> I tried to use kernel-2.6.26, xenomai-2.4.4 and adeos-ipipe-2.6.26-rc7-x86-2.0-09.patch.
> When I attempted to compile the kernel, i got the following error:
> 
>   CC      kernel/xenomai/arch/generic/hal.o
> In file included from include/asm/xenomai/hal.h:75,
>                  from kernel/xenomai/arch/generic/hal.c:47:
> include/asm/xenomai/hal_64.h:124:27: error: asm/mach_apic.h: No such file or directory
> make[4]: *** [kernel/xenomai/arch/generic/hal.o] Error 1
> make[3]: *** [kernel/xenomai/arch/generic] Error 2
> make[2]: *** [kernel/xenomai/arch] Error 2
> make[1]: *** [kernel/xenomai] Error 2
> make: *** [kernel] Error 2
> 
> my configuration:
> X86_64_SMP=y
> X86_LOCAL_APIC=y
> 
> Am I the first one who tried 2.6.26 on 64-bit PC? ;-)

I just compiled 2.6.26 on 64 bits PC yesterday, and the kernel runs just
fine. I would guess you have selected a type of machine that nobody else
selected. Could you post your full .config here ?

-- 
                                                 Gilles.

