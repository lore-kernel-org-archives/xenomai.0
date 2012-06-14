MIME-Version: 1.0
Date: Thu, 14 Jun 2012 02:30:42 -0400
Message-ID: <CAHyVJywn_UgeKtEpHaTs5Cn+x+GYE19bpPoh+jVb3dz-R8RAZA@mail.gmail.com>
From: Mohit Jandwani <mohitjandwani@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Error while compiling I-pipe for exynos4210
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai-help-request@gna.org, xenomai-help@gna.org, xenomai@xenomai.org

*H**ey I am trying to compile i-pipe core 3.2 for exynos 4210 board.When I
try to compile the code , this is what happens
**
ksh@ubuntu:~/xenomai$ cd ipipe
ksh@ubuntu:~/xenomai/ipipe$ make ARCH=arm exynos4_defconfig
 HOSTCC  scripts/basic/fixdep
 HOSTCC  scripts/kconfig/conf.o
 SHIPPED scripts/kconfig/zconf.tab.c
 SHIPPED scripts/kconfig/zconf.lex.c
 SHIPPED scripts/kconfig/zconf.hash.c
 HOSTCC  scripts/kconfig/zconf.tab.o
 HOSTLD  scripts/kconfig/conf
#
# configuration written to .config
#
ksh@ubuntu:~/xenomai/ipipe$ make ARCH=arm CROSS_COMPILE=arm-none-eabi-
scripts/kconfig/conf --silentoldconfig Kconfig
 WRAP    arch/arm/include/generated/asm/auxvec.h
 WRAP    arch/arm/include/generated/asm/bitsperlong.h
 WRAP    arch/arm/include/generated/asm/cputime.h
 WRAP    arch/arm/include/generated/asm/emergency-restart.h
 WRAP    arch/arm/include/generated/asm/errn

<some wrap and cc stuff>

arch/arm/kernel/return_address.c:62:2: warning: #warning "TODO:
return_address should use unwind tables" [-Wcpp]
 CC      arch/arm/kernel/setup.o
 CC      arch/arm/kernel/signal.o
 CC      arch/arm/kernel/sys_arm.o
 CC      arch/arm/kernel/stacktrace.o
 CC      arch/arm/kernel/time.o
 CC      arch/arm/kernel/traps.o
 CC      arch/arm/kernel/armksyms.o
 CC      arch/arm/kernel/module.o
 AS      arch/arm/kernel/sleep.o
 CC      arch/arm/kernel/suspend.o
 CC      arch/arm/kernel/smp.o
arch/arm/kernel/smp.c: In function 'ipi_timer':
arch/arm/kernel/smp.c:482:2: error: implicit declaration of function
'__ipipe_mach_update_tsc' [-Werror=implicit-function-declaration]
arch/arm/kernel/smp.c: In function '__ipipe_grab_ipi':
arch/arm/kernel/smp.c:517:3: error: implicit declaration of function
'__ipipe_mach_relay_ipi' [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors

make[1]: *** [arch/arm/kernel/smp.o] Error 1
make: *** [arch/arm/kernel] Error 2

*
