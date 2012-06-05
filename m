MIME-Version: 1.0
In-Reply-To: <4FCDFB35.1050705@xenomai.org>
References: <CAHue_TXhjY-74oUNzuuS=ygCEhcVFeiAB+4ZesjKX19B9WobaA@mail.gmail.com>
	<4FCDFB35.1050705@xenomai.org>
Date: Tue, 5 Jun 2012 17:34:47 +0200
Message-ID: <CAHue_TUB-6nufH_O-PRojDPVfpDom+DCv1-_ERV4-xOfEzu2Dg@mail.gmail.com>
From: =?ISO-8859-2?Q?Marcin_Ku=B6ka?= <marckuska@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] unsupported ARM9 machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

 Thank you for quick response.

Again I tried to compile it using buildroot but this time I used following
commands:
*
*
*# cd /home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13
# make ARCH=3Darm vexpress_defconfig // i suppose this sets kernel
configuration only for versatile express (ommiting multiple definitions)?
# cd ..
# xenomai/scripts/prepare-kernel.sh --linux=3Dlinux-3.0.13
--adeos=3Dadeos-ipipe-3.0.13-arm-1.18-09.patch --arch=3Darm
# cd /home/marcin/Documents/buildroot-2012.05
# make all
*

and i received this list of errors

  *    kernel/xenomai/arch/generic/**hal.o
In file included from include/asm-generic/xenomai/hal.h:40:0,
                 from
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:32,
                 from kernel/xenomai/arch/generic/hal.c:45:
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/wrappers.h:90:5:
warning: "IPIPE_MAJOR_NUMBER" is not defined
In file included from
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:32:0,
                 from kernel/xenomai/arch/generic/hal.c:45:
include/asm-generic/xenomai/hal.h: In function 'rthal_get_cpufreq':
include/asm-generic/xenomai/hal.h:227:23: error: storage size of 'sysinfo'
isn't known
include/asm-generic/xenomai/hal.h:228:2: error: implicit declaration of
function 'ipipe_get_sysinfo'
include/asm-generic/xenomai/hal.h:227:23: warning: unused variable 'sysinfo=
'
include/asm-generic/xenomai/hal.h: In function 'rthal_get_timerfreq':
include/asm-generic/xenomai/hal.h:234:23: error: storage size of 'sysinfo'
isn't known
include/asm-generic/xenomai/hal.h:234:23: warning: unused variable 'sysinfo=
'
include/asm-generic/xenomai/hal.h: In function 'set_task_nowakeup':
include/asm-generic/xenomai/hal.h:324:3: error: 'TASK_NOWAKEUP' undeclared
(first use in this function)
include/asm-generic/xenomai/hal.h:324:3: note: each undeclared identifier
is reported only once for each function it appears in
include/asm-generic/xenomai/hal.h: In function 'clear_task_nowakeup':
include/asm-generic/xenomai/hal.h:329:2: error: 'TASK_NOWAKEUP' undeclared
(first use in this function)
include/asm-generic/xenomai/hal.h: In function 'rthal_enable_notifier':
include/asm-generic/xenomai/hal.h:347:14: error: 'PF_EVNOTIFY' undeclared
(first use in this function)
include/asm-generic/xenomai/hal.h: At top level:
include/asm-generic/xenomai/hal.h:426:29: error: expected '=3D', ',', ';',
'asm' or '__attribute__' before 'rthal_irq_handler_t'
include/asm-generic/xenomai/hal.h:427:29: error: expected '=3D', ',', ';',
'asm' or '__attribute__' before 'rthal_irq_ackfn_t'
include/asm-generic/xenomai/hal.h:439:21: error: 'IPIPE_NR_CPUS' undeclared
here (not in a function)
include/asm-generic/xenomai/hal.h:460:58: error: 'IPIPE_NR_FAULTS'
undeclared here (not in a function)
include/asm-generic/xenomai/hal.h:495:9: error: expected declaration
specifiers or '...' before 'rthal_irq_handler_t'
include/asm-generic/xenomai/hal.h:496:9: error: expected declaration
specifiers or '...' before 'rthal_irq_ackfn_t'
include/asm-generic/xenomai/hal.h: In function 'rthal_irq_host_pend':
include/asm-generic/xenomai/hal.h:517:2: error: implicit declaration of
function 'ipipe_propagate_irq'
include/asm-generic/xenomai/hal.h: In function '__rthal_apc_schedule':
include/asm-generic/xenomai/hal.h:530:3: error: implicit declaration of
function 'ipipe_schedule_irq'
include/asm-generic/xenomai/hal.h: In function 'rthal_apc_schedule':
include/asm-generic/xenomai/hal.h:537:2: error: implicit declaration of
function 'ipipe_test_and_stall_pipeline_head'
include/asm-generic/xenomai/hal.h:539:2: error: implicit declaration of
function 'ipipe_restore_pipeline_head'
include/asm-generic/xenomai/hal.h: At top level:
include/asm-generic/xenomai/hal.h:548:57: warning: 'struct
clock_event_device' declared inside parameter list
include/asm-generic/xenomai/hal.h:548:57: warning: its scope is only this
definition or declaration, which is probably not what you want
include/asm-generic/xenomai/hal.h:548:57: warning: 'enum clock_event_mode'
declared inside parameter list
include/asm-generic/xenomai/hal.h:549:50: warning: 'struct
clock_event_device' declared inside parameter list
include/asm-generic/xenomai/hal.h:553:18: warning: 'struct
clock_event_device' declared inside parameter list
include/asm-generic/xenomai/hal.h:553:18: warning: 'enum clock_event_mode'
declared inside parameter list
In file included from kernel/xenomai/arch/generic/hal.c:45:0:
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:36:37:
warning: "__IPIPE_FEATURE_VFP_SAFE" is not defined
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:37:2:
error: #error "Xenomai requires a more recent I-pipe patch to use VFP
hardware"
In file included from kernel/xenomai/arch/generic/hal.c:45:0:
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:
In function 'rthal_rdtsc':
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:176:5:
error: implicit declaration of function 'ipipe_read_tsc'
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:
In function 'rthal_timer_program_shot':
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:188:2:
error: '__ipipe_mach_timerint' undeclared (first use in this function)
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:190:2:
error: implicit declaration of function '__ipipe_mach_set_dec'
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:
At top level:
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:334:6:
error: 'IPIPE_TRAP_ACCESS' undeclared here (not in a function)
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:334:5:
error: array index in initializer not of integer type
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:334:5:
error: (near initialization for 'rthal_fault_labels')
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:335:6:
error: 'IPIPE_TRAP_SECTION' undeclared here (not in a function)
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:335:5:
error: array index in initializer not of integer type
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:335:5:
error: (near initialization for 'rthal_fault_labels')
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:336:6:
error: 'IPIPE_TRAP_DABT' undeclared here (not in a function)
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:336:5:
error: array index in initializer not of integer type
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:336:5:
error: (near initialization for 'rthal_fault_labels')
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:337:6:
error: 'IPIPE_TRAP_UNKNOWN' undeclared here (not in a function)
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:337:5:
error: array index in initializer not of integer type
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:337:5:
error: (near initialization for 'rthal_fault_labels')
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:338:6:
error: 'IPIPE_TRAP_BREAK' undeclared here (not in a function)
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:338:5:
error: array index in initializer not of integer type
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:338:5:
error: (near initialization for 'rthal_fault_labels')
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:339:6:
error: 'IPIPE_TRAP_FPU' undeclared here (not in a function)
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:339:5:
error: array index in initializer not of integer type
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:339:5:
error: (near initialization for 'rthal_fault_labels')
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:340:6:
error: 'IPIPE_TRAP_VFP' undeclared here (not in a function)
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:340:5:
error: array index in initializer not of integer type
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:340:5:
error: (near initialization for 'rthal_fault_labels')
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:341:6:
error: 'IPIPE_TRAP_UNDEFINSTR' undeclared here (not in a function)
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:341:5:
error: array index in initializer not of integer type
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:341:5:
error: (near initialization for 'rthal_fault_labels')
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:345:5:
error: array index in initializer not of integer type
/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/arm=
/include/asm/xenomai/hal.h:345:5:
error: (near initialization for 'rthal_fault_labels')
kernel/xenomai/arch/generic/hal.c:69:42: error: 'SPIN_LOCK_UNLOCKED'
undeclared here (not in a function)
kernel/xenomai/arch/generic/hal.c:80:1: warning: type defaults to 'int' in
declaration of 'rthal_realtime_faults'
kernel/xenomai/arch/generic/hal.c: In function 'rthal_critical_enter':
kernel/xenomai/arch/generic/hal.c:96:5: error: implicit declaration of
function 'ipipe_critical_enter'
kernel/xenomai/arch/generic/hal.c: In function 'rthal_critical_exit':
kernel/xenomai/arch/generic/hal.c:109:5: error: implicit declaration of
function 'ipipe_critical_exit'
kernel/xenomai/arch/generic/hal.c: At top level:
kernel/xenomai/arch/generic/hal.c:160:9: error: expected declaration
specifiers or '...' before 'rthal_irq_handler_t'
kernel/xenomai/arch/generic/hal.c:161:9: error: expected declaration
specifiers or '...' before 'rthal_irq_ackfn_t'
kernel/xenomai/arch/generic/hal.c: In function 'rthal_irq_request':
kernel/xenomai/arch/generic/hal.c:163:9: error: 'handler' undeclared (first
use in this function)
kernel/xenomai/arch/generic/hal.c:163:35: error: 'IPIPE_NR_IRQS' undeclared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:166:5: error: implicit declaration of
function 'ipipe_virtualize_irq'
kernel/xenomai/arch/generic/hal.c:166:12: error: 'ackfn' undeclared (first
use in this function)
kernel/xenomai/arch/generic/hal.c:166:12: error: 'IPIPE_HANDLE_MASK'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:166:12: error: 'IPIPE_WIRED_MASK'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:166:12: error: 'IPIPE_EXCLUSIVE_MASK'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c: In function 'rthal_irq_release':
kernel/xenomai/arch/generic/hal.c:203:16: error: 'IPIPE_NR_IRQS' undeclared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:206:12: error: 'IPIPE_PASS_MASK'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c: In function 'rthal_init':
kernel/xenomai/arch/generic/hal.c:534:5: error: implicit declaration of
function 'ipipe_alloc_virq'
kernel/xenomai/arch/generic/hal.c:542:11: error: 'ipipe_current_domain'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:542:11: error: 'IPIPE_HANDLE_MASK'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:551:11: error: storage size of 'attr'
isn't known
kernel/xenomai/arch/generic/hal.c:551:11: error: implicit declaration of
function 'ipipe_init_attr'
kernel/xenomai/arch/generic/hal.c:551:11: error: 'IPIPE_HEAD_PRIORITY'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:551:11: error: implicit declaration of
function 'ipipe_register_domain'
kernel/xenomai/arch/generic/hal.c:551:11: warning: unused variable 'attr'
kernel/xenomai/arch/generic/hal.c:579:5: error: implicit declaration of
function 'ipipe_free_virq'
kernel/xenomai/arch/generic/hal.c: In function 'rthal_exit':
kernel/xenomai/arch/generic/hal.c:591:2: error: 'ipipe_current_domain'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:597:2: error: implicit declaration of
function 'ipipe_unregister_domain'
kernel/xenomai/arch/generic/hal.c: At top level:
kernel/xenomai/arch/generic/hal.c:804:1: warning: type defaults to 'int' in
declaration of 'rthal_apc_pending'
kernel/xenomai/arch/generic/hal.c: In function 'rthal_irq_release':
kernel/xenomai/arch/generic/hal.c:208:1: warning: control reaches end of
non-void function
kernel/xenomai/arch/generic/hal.c: In function 'rthal_irq_request':
kernel/xenomai/arch/generic/hal.c:173:1: warning: control reaches end of
non-void function
make[5]: *** [kernel/xenomai/arch/generic/hal.*

I have no clue what could possibly be wrong with setting. So I decided to
compile my own toolchain as follows:

1. crosstool-ng-1.15.2
2. linux-3.0.13:
*# make ARCH=3Darm vexpress_defconfig
   [*] use the ARM EABI to compile the kernel
# make ARCH=3Darm CROSS_COMPILE=3Darm-unknown-linux-gnueabi- modules
# make ARCH=3Darm INSTALL_MOD_PATH=3D/home/marcin/Documents/arm/target
modules_install*
3. busybox-1.20.0
4. ramdisk:
*# cd /home/marcin/Documents/arm/target
# find . | sudo cpio -o -H newc > /home/marcin/Documents/arm/rootfs.cpio*
5. Kernel:
*# cd linux-3.0.15
**# ../xenomai/scripts/prepare-kernel.sh --linux=3Dlinux-3.0.13
--adeos=3Dadeos-ipipe-3.0.13-arm-1.18-09.patch --arch=3Darm
# make ARCH=3Darm CROSS_COMPILE=3Darm-unknown-linux-gnueabi- zImage*

and the result is

*  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
make[1]: `include/generated/mach-types.h' is up to date.
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CC      kernel/xenomai/arch/generic/hal.o
In file included from kernel/xenomai/arch/generic/hal.c:45:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/xenomai/hal.h:91:2=
:
error: #error "Unsupported ARM machine"
make[4]: *** [kernel/xenomai/arch/generic/hal.o] Error 1
make[3]: *** [kernel/xenomai/arch/generic] Error 2
make[2]: *** [kernel/xenomai/arch] Error 2
make[1]: *** [kernel/xenomai] Error 2
make: *** [kernel] Error 2

*"Unsupported ARM machine" - any suggestions to this?*

*regards*
*qsiek*
*

2012/6/5 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 06/05/2012 02:20 PM, Marcin Ku=B6ka wrote:
> > Hi,
> >
> > My name is Marcin Kuska and I'm new to this list.
> >
> > Recently i have been trying to compile linux kernel v. 3.0.13 with a
> > Xenomai real time subsystem extension on ARM versatile express board. I=
'm
> > using buildroot-2012.05 to cross-compile the kernel. I patched linux
> source
> > tree with adeos-ipipe-3.0.13-arm-1.18-09.patch. The problem is that
> > buildroot cannot finish compilation and returns following errors:*
> >
> > make[1]: Entering directory
> > `/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13'
> >   CHK     include/linux/version.h
> >   CHK     include/generated/utsrelease.h
> > make[2]: `include/generated/mach-types.h' is up to date.
> >   CALL    scripts/checksyscalls.sh
> >   CHK     include/generated/compile.h
> >   LD      vmlinux.o
> > arch/arm/common/built-in.o: In function `gic_unmask_irq':
> >
> /home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/a=
rm/common/gic.c:106:
> > multiple definition of `__ipipe_mach_ticks_per_jiffy'
> >
> arch/arm/kernel/built-in.o:/home/marcin/Documents/buildroot-2012.05/outpu=
t/build/linux-3.0.13/arch/arm/kernel/entry-armv.S:104:
> > first defined here
> > arch/arm/common/built-in.o: In function `__ipipe_mach_set_dec':
> >
> /home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/a=
rm/common/timer-sp.c:230:
> > multiple definition of `__ipipe_mach_set_dec'
> >
> arch/arm/kernel/built-in.o:/home/marcin/Documents/buildroot-2012.05/outpu=
t/build/linux-3.0.13/arch/arm/kernel/smp_twd.c:59:
> > first defined here
> > arch/arm/common/built-in.o: In function `__ipipe_mach_release_timer':
> >
> /home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/a=
rm/common/timer-sp.c:239:
> > multiple definition of `__ipipe_mach_release_timer'
> >
> arch/arm/kernel/built-in.o:/home/marcin/Documents/buildroot-2012.05/outpu=
t/build/linux-3.0.13/arch/arm/kernel/smp.c:509:
> > first defined here
> > arch/arm/common/built-in.o: In function `gic_unmask_irq':
> >
> /home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/a=
rm/common/gic.c:102:
> > multiple definition of `__ipipe_mach_timerstolen'
> >
> arch/arm/kernel/built-in.o:/home/marcin/Documents/buildroot-2012.05/outpu=
t/build/linux-3.0.13/arch/arm/kernel/entry-armv.S:104:
> > first defined here
> > arch/arm/common/built-in.o: In function `__ipipe_mach_get_dec':
> >
> /home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/a=
rm/common/timer-sp.c:248:
> > multiple definition of `__ipipe_mach_get_dec'
> >
> arch/arm/kernel/built-in.o:/home/marcin/Documents/buildroot-2012.05/outpu=
t/build/linux-3.0.13/arch/arm/kernel/smp_twd.c:70:
> > first defined here
> > arch/arm/common/built-in.o: In function `__ipipe_check_tickdev':
> >
> /home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/arch/a=
rm/common/timer-sp.c:215:
> > multiple definition of `__ipipe_check_tickdev'
> >
> arch/arm/kernel/built-in.o:/home/marcin/Documents/buildroot-2012.05/outpu=
t/build/linux-3.0.13/arch/arm/kernel/smp_twd.c:75:
> > first defined here
> > make[1]: *** [vmlinux.o] Error 1
> > make[1]: Leaving directory
> > `/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13'
> > make: ***
> >
> [/home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13/.stam=
p_built]
> > Error 2
> > *
> > and also:
> >
> > "unsupported ARM machine"
> >
> > I have read that xenomai only supports integrator/cp board and any othe=
r
> > board like versatile express have to be adapted by myself. So i went to=
:
> >
> > http://www.xenomai.org/index.php/I-pipe:ArmPorting
> >
> > and started adapting and cannot find files like time.c and irq.c.
> Moreover
>
> As said in the following document, time.c and irq.c are just indicative
> names, it is the files where the timer and irq controller are
> implemented for your platform, you have to find the corresponding files
> for your platform.
>
> > I cannot find errors in file gic.c, timer-sp.c and so on (e.g.
> *gic.c:106:
> > multiple definition of `__ipipe_mach_ticks_per_jiffy'* i cannot find an=
y
> > definition of __ipipe_mach_ticks_per_jiffy so even if I would want to
> > comment one of the definitions to eliminate multipling it's impossible
> > cause it's not there).
> >
> > My description of the problem is very blurred i suppose, so if anybody
> may
> > be knowing the solution, please ask for more specific details and i wil=
l
> > post them.
>
> This version of the I-pipe patch does not support kernels compiled for
> multiple platforms. In the kernel configuration, you should only keep
> configuration enabled for the only platform/board you use. Then you will
> not get multiple definitions.
>
> --
>                                            Gilles.
>



--=20
Marcin Ku=B6ka
