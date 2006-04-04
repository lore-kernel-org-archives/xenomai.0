Message-ID: <44329929.2090905@domain.hid>
Date: Tue, 04 Apr 2006 18:04:57 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] (no subject)
References: <CC692F5386B0AA47A62B7484A7CA2B6D027A2D85@domain.hid>
In-Reply-To: <CC692F5386B0AA47A62B7484A7CA2B6D027A2D85@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Behre, Frederik - LT" <Behre.Frederik@domain.hid>
Cc: xenomai@xenomai.org

Behre, Frederik - LT wrote:
> Hello
> 
> I have following Problem when I Build my uImage from my kernel.
> 
> But first my configuration
> 
> Host system:
> ix86
> Suse Linux 10.0 32bit
> 
> Cross Compiler
> Denx eldk ver. 3.11
> (_www.denx.de_ <file://www.denx.de>)
> 
> Target System
> PPC (MPC8270) on Microsys PM827 Board.
> linuxppc_2_4_devel-2005-10-25-1440
> xenomai-2.1
> adeos-ipipe-2.4.25-ppc-denx-1.0-03.patch
> 
> I did following Steps
> 
> installing the eldk
> export Path to the Cross compiler to system Path
> extrakt linux and xenomai
> copy adeos
> 
> THEN
>  >./xenomai-2.1.0/scripts/prepare-kernel.sh --arch=powerpc \
>         --adeos=adeos-ipipe-2.4.25-ppc-denx-1.0-03patch  \
>         --linux=linuxppc_2_4_devel-2005-10-25-1440/
> patching file arch/ppc/config.in
> patching file arch/ppc/kernel/Makefile
> patching file arch/ppc/kernel/entry.S
> patching file arch/ppc/kernel/head.S
> patching file arch/ppc/kernel/head_440.S
> patching file arch/ppc/kernel/head_44x.S
> patching file arch/ppc/kernel/head_4xx.S
> patching file arch/ppc/kernel/head_8xx.S
> patching file arch/ppc/kernel/head_e500.S
> patching file arch/ppc/kernel/idle.c
> patching file arch/ppc/kernel/ipipe-core.c
> patching file arch/ppc/kernel/ipipe-root.c
> patching file arch/ppc/kernel/irq.c
> patching file arch/ppc/kernel/ppc_ksyms.c
> patching file arch/ppc/kernel/traps.c
> patching file arch/ppc/mm/fault.c
> patching file include/asm-ppc/hw_irq.h
> patching file include/asm-ppc/ipipe.h
> patching file include/asm-ppc/mmu_context.h
> patching file include/asm-ppc/system.h
> patching file include/linux/ipipe.h
> patching file include/linux/sched.h
> patching file init/main.c
> patching file kernel/Makefile
> patching file kernel/exit.c
> patching file kernel/fork.c
> patching file kernel/ipipe/Makefile
> patching file kernel/ipipe/core.c
> patching file kernel/ipipe/generic.c
> patching file kernel/printk.c
> patching file kernel/sched.c
> patching file kernel/signal.c
> 
> # I think I is ok ???
> 

Yes.

>  >cd linuxppc_2_4_devel-2005-10-25-1440
>  >make ARCH=ppc CROSS_COMPILE=ppc_82xx- PM825config
> /bin/sh: ppc-82xx-gcc: command not found
> make: *** No rule to make target `PM825config'.  Stop.
> 
> # default settings for my board
> 
>  >make ARCH=ppc CROSS_COMPILE=ppc_82xx- menuconfig
> #
> # Turn off PCI because my targetboard does not support PCI
> # activate Xenomai and Nucleus
> # nothing more, the rest I leave in default settings
> #
> # Exit and Save
> #
>  >make ARCH=ppc CROSS_COMPILE=ppc_82xx- uImage
> 
> make[5]: Entering directory 
> `/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenomai/arch/generic' 
> 
> ppc_82xx-gcc -D__KERNEL__ 
> -I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include 
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
> -fno-common -fomit-frame-pointer 
> -I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/arch/ppc 
> -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized 
> -mmultiple -mstring  
> -I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/xenomai 
> -I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/xenomai/compat 
> -nostdinc -I /root/eldk/311/usr/lib/gcc-lib/ppc-linux/3.3.3/include 
> -DKBUILD_BASENAME=hal  -c -o hal.o hal.c
> 
> In file included from 
> /root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm/xenomai/hal.h:32, 
>

You did not switch on the I-pipe support in your kernel configuration, 
see "General setup".

>                  from hal.c:43:
> /eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm-generic/xenomai/hal.h:60:2: 
> #error "Adeos kernel support is required to run this software."
> 
> /eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm-generic/xenomai/hal.h:61:2: 
> #error "See _http://download.gna.org/adeos/patches/_"
> 
> In file included from 
> /root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm/xenomai/hal.h:32, 
> 
>                  from hal.c:43:
> /eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm-generic/xenomai/hal.h: 
> In function `rthal_get_cpufreq':
> 
> /eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm-generic/xenomai/hal.h:171: 
> error: storage size of `sysinfo' isn't known
> 
> ...
> ...
> ...ect...
> ...
> ...
> make[5]: *** [hal.o] Error 1
> make[5]: Leaving directory 
> `/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenomai/arch/generic' 
> 
> make[4]: *** [first_rule] Error 2
> make[4]: Leaving directory 
> `/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenomai/arch/generic' 
> 
> make[3]: *** [_subdir_generic] Error 2
> make[3]: Leaving directory 
> `/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenomai/arch' 
> 
> make[2]: *** [_subdir_arch] Error 2
> make[2]: Leaving directory 
> `/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenomai'
> make[1]: *** [_subdir_xenomai] Error 2
> make[1]: Leaving directory 
> `/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel'
> make: *** [_dir_kernel] Error 2
> 
> #
> # and here is my problem
> # what did I make wrong ??
> 
> 
> Thanks a lot for Helping me.
> 
> Greetz Freddy'xenomai@xenomai.org'
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 

Philippe.

