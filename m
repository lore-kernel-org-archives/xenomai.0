Message-ID: <4FCDFB35.1050705@xenomai.org>
Date: Tue, 05 Jun 2012 14:27:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHue_TXhjY-74oUNzuuS=ygCEhcVFeiAB+4ZesjKX19B9WobaA@mail.gmail.com>
In-Reply-To: <CAHue_TXhjY-74oUNzuuS=ygCEhcVFeiAB+4ZesjKX19B9WobaA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] unsupported ARM9 machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?TWFyY2luIEt1xZtrYQ==?= <marckuska@gmail.com>
Cc: xenomai@xenomai.org

On 06/05/2012 02:20 PM, Marcin Kuśka wrote:
> Hi,
> 
> My name is Marcin Kuska and I'm new to this list.
> 
> Recently i have been trying to compile linux kernel v. 3.0.13 with a
> Xenomai real time subsystem extension on ARM versatile express board. I'm
> using buildroot-2012.05 to cross-compile the kernel. I patched linux source
> tree with adeos-ipipe-3.0.13-arm-1.18-09.patch. The problem is that
> buildroot cannot finish compilation and returns following errors:*
> 
> make[1]: Entering directory
> `/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13'
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[2]: `include/generated/mach-types.h' is up to date.
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   LD      vmlinux.o
> arch/arm/common/built-in.o: In function `gic_unmask_irq':
> /home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm/common/gic.c:106:
> multiple definition of `__ipipe_mach_ticks_per_jiffy'
> arch/arm/kernel/built-in.o:/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm/kernel/entry-armv.S:104:
> first defined here
> arch/arm/common/built-in.o: In function `__ipipe_mach_set_dec':
> /home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm/common/timer-sp.c:230:
> multiple definition of `__ipipe_mach_set_dec'
> arch/arm/kernel/built-in.o:/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm/kernel/smp_twd.c:59:
> first defined here
> arch/arm/common/built-in.o: In function `__ipipe_mach_release_timer':
> /home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm/common/timer-sp.c:239:
> multiple definition of `__ipipe_mach_release_timer'
> arch/arm/kernel/built-in.o:/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm/kernel/smp.c:509:
> first defined here
> arch/arm/common/built-in.o: In function `gic_unmask_irq':
> /home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm/common/gic.c:102:
> multiple definition of `__ipipe_mach_timerstolen'
> arch/arm/kernel/built-in.o:/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm/kernel/entry-armv.S:104:
> first defined here
> arch/arm/common/built-in.o: In function `__ipipe_mach_get_dec':
> /home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm/common/timer-sp.c:248:
> multiple definition of `__ipipe_mach_get_dec'
> arch/arm/kernel/built-in.o:/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm/kernel/smp_twd.c:70:
> first defined here
> arch/arm/common/built-in.o: In function `__ipipe_check_tickdev':
> /home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm/common/timer-sp.c:215:
> multiple definition of `__ipipe_check_tickdev'
> arch/arm/kernel/built-in.o:/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm/kernel/smp_twd.c:75:
> first defined here
> make[1]: *** [vmlinux.o] Error 1
> make[1]: Leaving directory
> `/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13'
> make: ***
> [/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/.stamp_built]
> Error 2
> *
> and also:
> 
> "unsupported ARM machine"
> 
> I have read that xenomai only supports integrator/cp board and any other
> board like versatile express have to be adapted by myself. So i went to:
> 
> http://www.xenomai.org/index.php/I-pipe:ArmPorting
> 
> and started adapting and cannot find files like time.c and irq.c. Moreover

As said in the following document, time.c and irq.c are just indicative
names, it is the files where the timer and irq controller are
implemented for your platform, you have to find the corresponding files
for your platform.

> I cannot find errors in file gic.c, timer-sp.c and so on (e.g. *gic.c:106:
> multiple definition of `__ipipe_mach_ticks_per_jiffy'* i cannot find any
> definition of __ipipe_mach_ticks_per_jiffy so even if I would want to
> comment one of the definitions to eliminate multipling it's impossible
> cause it's not there).
> 
> My description of the problem is very blurred i suppose, so if anybody may
> be knowing the solution, please ask for more specific details and i will
> post them.

This version of the I-pipe patch does not support kernels compiled for
multiple platforms. In the kernel configuration, you should only keep
configuration enabled for the only platform/board you use. Then you will
not get multiple definitions.

-- 
					    Gilles.

