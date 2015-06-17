From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 17 Jun 2015 12:48:13 -0400
Message-ID: <20150617164813.GH17436@csclub.uwaterloo.ca>
References: <1649054.cG979aVMUy@soho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649054.cG979aVMUy@soho>
Subject: Re: [Xenomai] License Issues
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On Wed, Jun 17, 2015 at 06:25:05PM +0200, Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> using a debian tool to check the license of the package I have found that his 
> files:

Well here is my guess based on reading what is there.  And besides who
says all files have to mention the license themselves?  The directory
could have that info or the entire project.

>            examples/Makefile
>            examples/common/Makefile
>            examples/native/Makefile
>            examples/native/rtprint.c
>            examples/native/sigdebug.c
>            examples/native/trivial-periodic.c
>            examples/posix/Makefile
>            examples/posix/README
>            examples/rtdm/driver-api/Makefile
>            examples/rtdm/profiles/can/Makefile
>            examples/rtdm/profiles/ipc/Makefile
>            examples/rtdm/profiles/ipc/bufp-label.c
>            examples/rtdm/profiles/ipc/bufp-readwrite.c
>            examples/rtdm/profiles/ipc/iddp-label.c
>            examples/rtdm/profiles/ipc/iddp-sendrecv.c
>            examples/rtdm/profiles/ipc/xddp-echo.c
>            examples/rtdm/profiles/ipc/xddp-label.c
>            examples/rtdm/profiles/ipc/xddp-stream.c
>            examples/rtdm/profiles/serial/Makefile

No idea.

>            include/Makefile.am
>            include/analogy/Makefile.am
>            include/asm-arm/Makefile.am
>            include/asm-arm/bits/Makefile.am
>            include/asm-blackfin/Makefile.am
>            include/asm-blackfin/bits/Makefile.am
>            include/asm-blackfin/bits/bind.h
>            include/asm-blackfin/fptest.h
>            include/asm-generic/Makefile.am
>            include/asm-generic/bits/Makefile.am
>            include/asm-generic/pci_ids.h
>            include/asm-nios2/Makefile.am
>            include/asm-nios2/bits/Makefile.am
>            include/asm-nios2/bits/bind.h
>            include/asm-nios2/fptest.h
>            include/asm-powerpc/Makefile.am
>            include/asm-powerpc/bits/Makefile.am
>            include/asm-powerpc/bits/bind.h
>            include/asm-powerpc/fptest.h
>            include/asm-sh/Makefile.am
>            include/asm-sh/bits/Makefile.am
>            include/asm-sh/bits/bind.h
>            include/asm-sh/fptest.h
>            include/asm-sim/Makefile.am
>            include/asm-sim/bits/Makefile.am
>            include/asm-x86/Makefile.am
>            include/asm-x86/arith.h
>            include/asm-x86/bits/Makefile.am
>            include/asm-x86/bits/pod.h
>            include/asm-x86/features.h
>            include/asm-x86/switch.h
>            include/asm-x86/system.h
>            include/asm-x86/wrappers.h
>            include/compat/asm-i386/io_ports.h
>            include/compat/linux/calc64.h
>            include/native/Makefile.am
>            include/nucleus/Makefile.am
>            include/nucleus/seqlock.h
>            include/posix/Makefile.am
>            include/posix/sys/Makefile.am
>            include/psos+/Makefile.am
>            include/psos+/long_names.h
>            include/rtdm/Makefile.am
>            include/testing/sigtest_syscall.h
>            include/uitron/Makefile.am
>            include/vrtx/Makefile.am
>            include/vrtx/vrtx.h
>            include/vxworks/Makefile.am
>            include/vxworks/vxworks.h

Seems to be covered by include/COPYING

>            ksrc/Config.in
>            ksrc/Makefile
>            ksrc/arch/Makefile
>            ksrc/arch/arm/Kconfig
>            ksrc/arch/arm/Makefile
>            ksrc/arch/arm/patches/README
>            ksrc/arch/arm/patches/beaglebone/ipipe-core-3.8.13-beaglebone-post.patch
>            ksrc/arch/arm/patches/beaglebone/ipipe-core-3.8.13-beaglebone-pre.patch
>            ksrc/arch/arm/patches/ipipe-core-3.10.32-arm-5.patch
>            ksrc/arch/arm/patches/ipipe-core-3.8.13-arm-4.patch
>            ksrc/arch/arm/patches/raspberry/ipipe-core-3.8.13-raspberry-post-2.patch
>            ksrc/arch/arm/patches/raspberry/ipipe-core-3.8.13-raspberry-pre-2.patch
>            ksrc/arch/arm/patches/zynq/ipipe-core-3.5.7-zynq-post.patch
>            ksrc/arch/arm/patches/zynq/ipipe-core-3.5.7-zynq-pre.patch
>            ksrc/arch/arm/patches/zynq/ipipe-core-3.8-zynq-post.patch
>            ksrc/arch/arm/patches/zynq/ipipe-core-3.8-zynq-pre.patch
>            ksrc/arch/blackfin/Config.in
>            ksrc/arch/blackfin/Kconfig
>            ksrc/arch/blackfin/Makefile
>            ksrc/arch/blackfin/patches/README
>            ksrc/arch/blackfin/patches/ipipe-core-3.10.32-blackfin-3.patch
>            ksrc/arch/blackfin/patches/ipipe-core-3.14.17-blackfin-4.patch
>            ksrc/arch/blackfin/patches/ipipe-core-3.8.13-blackfin-2.patch
>            ksrc/arch/generic/Makefile
>            ksrc/arch/generic/compat.c
>            ksrc/arch/nios2/Config.in
>            ksrc/arch/nios2/Kconfig
>            ksrc/arch/nios2/Makefile
>            ksrc/arch/nios2/patches/README
>            ksrc/arch/powerpc/Config.in
>            ksrc/arch/powerpc/Kconfig
>            ksrc/arch/powerpc/Makefile
>            ksrc/arch/powerpc/patches/README
>            ksrc/arch/powerpc/patches/ipipe-core-3.10.32-powerpc-4.patch
>            ksrc/arch/powerpc/patches/ipipe-core-3.14.17-powerpc-4.patch
>            ksrc/arch/powerpc/patches/ipipe-core-3.8.13-powerpc-2.patch
>            ksrc/arch/sh/Kconfig
>            ksrc/arch/sh/Makefile
>            ksrc/arch/sh/patches/README
>            ksrc/arch/x86/Config.in
>            ksrc/arch/x86/Kconfig
>            ksrc/arch/x86/Makefile
>            ksrc/arch/x86/patches/README
>            ksrc/arch/x86/patches/ipipe-core-3.10.32-x86-4.patch
>            ksrc/arch/x86/patches/ipipe-core-3.14.17-x86-4.patch
>            ksrc/arch/x86/patches/ipipe-core-3.8.13-x86-4.patch
>            ksrc/drivers/Config.in
>            ksrc/drivers/Kconfig
>            ksrc/drivers/Makefile
>            ksrc/drivers/analogy/Config.in
>            ksrc/drivers/analogy/Kconfig
>            ksrc/drivers/analogy/Makefile
>            ksrc/drivers/analogy/intel/Config.in
>            ksrc/drivers/analogy/intel/Kconfig
>            ksrc/drivers/analogy/intel/Makefile
>            ksrc/drivers/analogy/national_instruments/Config.in
>            ksrc/drivers/analogy/national_instruments/Kconfig
>            ksrc/drivers/analogy/national_instruments/Makefile
>            ksrc/drivers/analogy/sensoray/Config.in
>            ksrc/drivers/analogy/sensoray/Kconfig
>            ksrc/drivers/analogy/sensoray/Makefile
>            ksrc/drivers/analogy/testing/Config.in
>            ksrc/drivers/analogy/testing/Kconfig
>            ksrc/drivers/analogy/testing/Makefile
>            ksrc/drivers/analogy/testing/fake.c
>            ksrc/drivers/can/CREDITS
>            ksrc/drivers/can/Config.in
>            ksrc/drivers/can/Kconfig
>            ksrc/drivers/can/Makefile
>            ksrc/drivers/can/README
>            ksrc/drivers/can/mscan/Config.in
>            ksrc/drivers/can/mscan/Kconfig
>            ksrc/drivers/can/mscan/Makefile
>            ksrc/drivers/can/mscan/rtcan_mscan.c
>            ksrc/drivers/can/mscan/rtcan_mscan_mpc52xx.c
>            ksrc/drivers/can/rtcan_internal.h
>            ksrc/drivers/can/rtcan_module.c
>            ksrc/drivers/can/sja1000/Config.in
>            ksrc/drivers/can/sja1000/Kconfig
>            ksrc/drivers/can/sja1000/Makefile
>            ksrc/drivers/can/sja1000/rtcan_esd_pci.c
>            ksrc/drivers/can/sja1000/rtcan_peak_dng.c
>            ksrc/drivers/can/sja1000/rtcan_peak_pci.c
>            ksrc/drivers/can/sja1000/rtcan_plx_pci.c
>            ksrc/drivers/ipc/Config.in
>            ksrc/drivers/ipc/Kconfig
>            ksrc/drivers/ipc/Makefile
>            ksrc/drivers/serial/Config.in
>            ksrc/drivers/serial/Kconfig
>            ksrc/drivers/serial/Makefile
>            ksrc/drivers/testing/Config.in
>            ksrc/drivers/testing/Kconfig
>            ksrc/drivers/testing/Makefile
>            ksrc/drivers/testing/sigtest_module.c

No idea.  Although given it is applied as a patch to a linux kernel,
one would think GPLv2 is the only option it could be under.

>            ksrc/nucleus/Config.in
>            ksrc/nucleus/Kconfig
>            ksrc/nucleus/Makefile
>            ksrc/nucleus/udev/rtheap.rules
>            ksrc/nucleus/udev/rtpipe.rules

ksrc/nucleus/COPYING

>            ksrc/skins/Config.in
>            ksrc/skins/Kconfig
>            ksrc/skins/Makefile
>            ksrc/skins/native/API.CHANGES
>            ksrc/skins/native/Config.in
>            ksrc/skins/native/Kconfig
>            ksrc/skins/native/Makefile
>            ksrc/skins/native/demos/Makefile
>            ksrc/skins/native/demos/latency.c
>            ksrc/skins/native/demos/satch.c
>            ksrc/skins/native/snippets/bound_task.c
>            ksrc/skins/native/snippets/cond_var.c
>            ksrc/skins/native/snippets/event_flags.c
>            ksrc/skins/native/snippets/kernel_task.c
>            ksrc/skins/native/snippets/local_heap.c
>            ksrc/skins/native/snippets/msg_queue.c
>            ksrc/skins/native/snippets/mutex.c
>            ksrc/skins/native/snippets/pipe.c
>            ksrc/skins/native/snippets/semaphore.c
>            ksrc/skins/native/snippets/shared_mem.c
>            ksrc/skins/native/snippets/sigxcpu.c
>            ksrc/skins/native/snippets/user_alarm.c
>            ksrc/skins/native/snippets/user_irq.c
>            ksrc/skins/native/snippets/user_task.c

ksrc/skins/native/COPYING

>            ksrc/skins/posix/Config.in
>            ksrc/skins/posix/Kconfig
>            ksrc/skins/posix/Makefile
>            ksrc/skins/posix/apc.h
>            ksrc/skins/posix/cancel.c
>            ksrc/skins/posix/cancel.h
>            ksrc/skins/posix/cb_lock.h
>            ksrc/skins/posix/clock.c
>            ksrc/skins/posix/cond.c
>            ksrc/skins/posix/cond.h
>            ksrc/skins/posix/cond_attr.c
>            ksrc/skins/posix/demos/Kbuild
>            ksrc/skins/posix/demos/Makefile
>            ksrc/skins/posix/demos/accuracy.c
>            ksrc/skins/posix/internal.h
>            ksrc/skins/posix/module.c
>            ksrc/skins/posix/mq.c
>            ksrc/skins/posix/mq.h
>            ksrc/skins/posix/mutex.c
>            ksrc/skins/posix/mutex.h
>            ksrc/skins/posix/mutex_attr.c
>            ksrc/skins/posix/once.c
>            ksrc/skins/posix/registry.c
>            ksrc/skins/posix/registry.h
>            ksrc/skins/posix/sched.c
>            ksrc/skins/posix/sem.c
>            ksrc/skins/posix/sem.h
>            ksrc/skins/posix/shm.h
>            ksrc/skins/posix/sig.h
>            ksrc/skins/posix/signal.c
>            ksrc/skins/posix/thread.c
>            ksrc/skins/posix/thread.h
>            ksrc/skins/posix/thread_attr.c
>            ksrc/skins/posix/tsd.c
>            ksrc/skins/posix/tsd.h

ksrc/skins/posix/COPYING

>            ksrc/skins/psos+/API.CHANGES
>            ksrc/skins/psos+/Config.in
>            ksrc/skins/psos+/Kconfig
>            ksrc/skins/psos+/Makefile
>            ksrc/skins/psos+/demos/Makefile

ksrc/skins/psos+/COPYING

>            ksrc/skins/rtdm/API.CHANGES
>            ksrc/skins/rtdm/Config.in
>            ksrc/skins/rtdm/Kconfig
>            ksrc/skins/rtdm/Makefile

ksrc/skins/rtdm/COPYING

>            ksrc/skins/uitron/Config.in
>            ksrc/skins/uitron/Kconfig
>            ksrc/skins/uitron/Makefile

ksrc/skins/uitron/COPYING

>            ksrc/skins/vrtx/Config.in
>            ksrc/skins/vrtx/Kconfig
>            ksrc/skins/vrtx/Makefile
>            ksrc/skins/vrtx/defs.h
>            ksrc/skins/vrtx/event.c
>            ksrc/skins/vrtx/event.h
>            ksrc/skins/vrtx/heap.c
>            ksrc/skins/vrtx/heap.h
>            ksrc/skins/vrtx/mb.c
>            ksrc/skins/vrtx/mb.h
>            ksrc/skins/vrtx/module.c
>            ksrc/skins/vrtx/mx.c
>            ksrc/skins/vrtx/mx.h
>            ksrc/skins/vrtx/pt.c
>            ksrc/skins/vrtx/pt.h
>            ksrc/skins/vrtx/queue.c
>            ksrc/skins/vrtx/queue.h
>            ksrc/skins/vrtx/sem.c
>            ksrc/skins/vrtx/sem.h
>            ksrc/skins/vrtx/task.c
>            ksrc/skins/vrtx/task.h
>            ksrc/skins/vrtx/time.c

ksrc/skins/vrtx/COPyING

>            ksrc/skins/vxworks/Config.in
>            ksrc/skins/vxworks/Kconfig
>            ksrc/skins/vxworks/Makefile
>            ksrc/skins/vxworks/defs.h
>            ksrc/skins/vxworks/demos/Makefile
>            ksrc/skins/vxworks/errnoLib.c
>            ksrc/skins/vxworks/intLib.c
>            ksrc/skins/vxworks/kernelLib.c
>            ksrc/skins/vxworks/module.c
>            ksrc/skins/vxworks/msgQLib.c
>            ksrc/skins/vxworks/semLib.c
>            ksrc/skins/vxworks/sysLib.c
>            ksrc/skins/vxworks/taskHookLib.c
>            ksrc/skins/vxworks/taskInfo.c
>            ksrc/skins/vxworks/taskLib.c
>            ksrc/skins/vxworks/tickLib.c
>            ksrc/skins/vxworks/wdLib.c

ksrc/skins/vxworks/COPYING

>            scripts/Kconfig.frag
>            scripts/Makefile.am
>            scripts/Modules.frag
>            scripts/bootstrap
>            scripts/defconfig.frag
>            scripts/help_from_kconfig.pl
>            scripts/histo.gp
>            scripts/prepare-kernel.sh
>            scripts/wrap-link.sh
>            scripts/xeno-config.in
>            scripts/xeno.in

No idea

>            src/Makefile.am
>            src/drvlib/Makefile.am
>            src/drvlib/analogy/Makefile.am
>            src/include/Makefile.am
>            src/include/xeno_config.h.in
>            src/skins/Makefile.am
>            src/skins/common/Makefile.am

No idea

>            src/skins/native/Makefile.am
>            src/skins/native/libxenomai_native.pc.in
>            src/skins/native/wrappers.h

src/skins/native/COPYING

>            src/skins/posix/Makefile.am
>            src/skins/posix/libxenomai_posix.pc.in
>            src/skins/posix/posix.wrappers

src/skins/posix/COPYING

>            src/skins/psos+/Makefile.am
>            src/skins/psos+/libxenomai_psos+.pc.in

No idea

>            src/skins/rtdm/Makefile.am
>            src/skins/rtdm/libxenomai_rtdm.pc.in

src/skins/rtdm/COPYING

>            src/skins/uitron/Makefile.am
>            src/skins/uitron/libxenomai_uitron.pc.in

No idea

>            src/skins/vrtx/Makefile.am
>            src/skins/vrtx/libxenomai_vrtx.pc.in
>            src/skins/vrtx/wrappers.h

src/skins/vrtx/COPYING

>            src/skins/vxworks/Makefile.am
>            src/skins/vxworks/libxenomai_vxworks.pc.in
>            src/skins/vxworks/wrappers.h

src/skins/vxworks/COPYING

>            src/testsuite/Makefile.am
>            src/testsuite/clocktest/Makefile.am
>            src/testsuite/cyclic/Makefile.am
>            src/testsuite/irqbench/Makefile.am
>            src/testsuite/klatency/Makefile.am
>            src/testsuite/latency/Makefile.am
>            src/testsuite/latency/latency.c
>            src/testsuite/regression/Makefile.am
>            src/testsuite/regression/native+posix/Makefile.am
>            src/testsuite/regression/native/Makefile.am
>            src/testsuite/regression/posix/Makefile.am
>            src/testsuite/regression/posix/xddp_test.c
>            src/testsuite/regression/xeno-regression-test.in
>            src/testsuite/switchtest/Makefile.am
>            src/testsuite/unit/Makefile.am
>            src/testsuite/unit/check-vdso.c
>            src/testsuite/unit/wakeup-time.c
>            src/testsuite/xeno-test/Makefile.am
>            src/testsuite/xeno-test/dohell
>            src/testsuite/xeno-test/xeno-test-run-wrapper
>            src/testsuite/xeno-test/xeno-test.in
>            src/utils/Makefile.am
>            src/utils/analogy/Makefile.am
>            src/utils/analogy/wf_facilities.c
>            src/utils/analogy/wf_facilities.h
>            src/utils/can/Makefile.am
>            src/utils/can/README
>            src/utils/ps/Makefile.am
>            src/utils/ps/rtps.c

No idea.

> Have no license defined or i have not found it. Please, could you put some 
> lines to clarify that?

Well clearly a lot of the directories have a COPYING file, but a few
do not.

So I see 163 files that I have no idea out of 342 files, so 179 do seem
to have a clear license stated.  That seems to solve about half the
question just by looking in the directories.  Doesn't answer the other
half though.

-- 
Len Sorensen

