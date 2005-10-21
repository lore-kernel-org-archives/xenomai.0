From: Romain Lenglet <rlenglet@domain.hid>
Date: Fri, 21 Oct 2005 16:41:40 +0900
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0uJWDCLeKjbbpdw"
Message-Id: <200510211641.40806.rlenglet@domain.hid>
Subject: [Xenomai-core] [packaging] Proposal of split source code
	organization
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--Boundary-00=_0uJWDCLeKjbbpdw
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Here is a proposal of reorganization of the files in Xenomai, to 
make packaging easier. I have moved all the files, and the 
resulting hierarchy of directories in in the attached dirs.txt, 
and the contained files in allfiles.txt.
The GNUmakefiles, etc. are still missing here.

What do you think about that?

The idea is to have a ksrc/ directory that is independent from 
all other directories (except include/), to contain all the 
kernel modules code (and only that). It would have its own 
independent configuration mechanism based on Kconfig and/or 
autotools (??).
I would help a lot to have such an independent ksrc/ directory 
for packaging, since in Debian packages this would directly 
become the content of the kernel source package 
(xenomai-source).

In addition, an independent and complete include/ directory would 
directly become the main content of the libxenomai-dev package.


The two non-trivial tasks to reach that organization of files is:
- modify most GNUmakefile.am files (that seems quite easy),
- modify the kernel code configuration mechanism.

If everybody agrees, I propose to adapt most GNUmakefile.am 
files...

-- 
Romain Lenglet

--Boundary-00=_0uJWDCLeKjbbpdw
Content-Type: text/plain;
  charset="us-ascii";
  name="allfiles.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="allfiles.txt"

xenomai/
xenomai/ksrc
xenomai/ksrc/test
xenomai/ksrc/test/klatency
xenomai/ksrc/test/klatency/latency.h
xenomai/ksrc/test/klatency/latency-module.c
xenomai/ksrc/arch
xenomai/ksrc/arch/generic
xenomai/ksrc/arch/generic/hal
xenomai/ksrc/arch/generic/hal/generic.c
xenomai/ksrc/arch/i386
xenomai/ksrc/arch/i386/hal
xenomai/ksrc/arch/i386/hal/nmi.c
xenomai/ksrc/arch/i386/hal/smi.c
xenomai/ksrc/arch/i386/hal/smi.h
xenomai/ksrc/arch/i386/hal/usercopy.c
xenomai/ksrc/arch/i386/hal/x86.c
xenomai/ksrc/arch/ppc
xenomai/ksrc/arch/ppc/arch
xenomai/ksrc/arch/ppc/arch/ppc.c
xenomai/ksrc/arch/ppc/arch/switch.S
xenomai/ksrc/arch/ppc/arch/fpu.S
xenomai/ksrc/arch/ia64
xenomai/ksrc/arch/ia64/hal
xenomai/ksrc/arch/ia64/hal/ia64.c
xenomai/ksrc/arch/ia64/hal/switch.S
xenomai/ksrc/arch/ppc64
xenomai/ksrc/arch/ppc64/hal
xenomai/ksrc/arch/ppc64/hal/fpu.S
xenomai/ksrc/arch/ppc64/hal/ppc64.c
xenomai/ksrc/arch/ppc64/hal/switch.S
xenomai/ksrc/drivers
xenomai/ksrc/drivers/16550A
xenomai/ksrc/drivers/16550A/16550A.c
xenomai/ksrc/nucleus
xenomai/ksrc/nucleus/heap.c
xenomai/ksrc/nucleus/intr.c
xenomai/ksrc/nucleus/module.c
xenomai/ksrc/nucleus/pod.c
xenomai/ksrc/nucleus/synch.c
xenomai/ksrc/nucleus/thread.c
xenomai/ksrc/nucleus/timer.c
xenomai/ksrc/nucleus/shadow.c
xenomai/ksrc/nucleus/core.c
xenomai/ksrc/nucleus/pipe.c
xenomai/ksrc/nucleus/ltt.c
xenomai/ksrc/nucleus/config.c
xenomai/ksrc/native
xenomai/ksrc/native/syscall.h
xenomai/ksrc/native/module.c
xenomai/ksrc/native/task.c
xenomai/ksrc/native/timer.c
xenomai/ksrc/native/syscall.c
xenomai/ksrc/native/pipe.c
xenomai/ksrc/native/sem.c
xenomai/ksrc/native/event.c
xenomai/ksrc/native/mutex.c
xenomai/ksrc/native/registry.c
xenomai/ksrc/native/cond.c
xenomai/ksrc/native/queue.c
xenomai/ksrc/native/heap.c
xenomai/ksrc/native/alarm.c
xenomai/ksrc/native/intr.c
xenomai/ksrc/psos+
xenomai/ksrc/psos+/module.c
xenomai/ksrc/psos+/asr.c
xenomai/ksrc/psos+/event.c
xenomai/ksrc/psos+/pt.c
xenomai/ksrc/psos+/queue.c
xenomai/ksrc/psos+/rn.c
xenomai/ksrc/psos+/task.c
xenomai/ksrc/psos+/tm.c
xenomai/ksrc/psos+/sem.c
xenomai/ksrc/psos+/asr.h
xenomai/ksrc/psos+/defs.h
xenomai/ksrc/psos+/event.h
xenomai/ksrc/psos+/pt.h
xenomai/ksrc/psos+/queue.h
xenomai/ksrc/psos+/rn.h
xenomai/ksrc/psos+/sem.h
xenomai/ksrc/psos+/task.h
xenomai/ksrc/psos+/tm.h
xenomai/ksrc/psos+/doc
xenomai/ksrc/psos+/doc/psos.txt
xenomai/ksrc/posix
xenomai/ksrc/posix/cancel.c
xenomai/ksrc/posix/clock.c
xenomai/ksrc/posix/cond_attr.c
xenomai/ksrc/posix/cond.c
xenomai/ksrc/posix/intr.c
xenomai/ksrc/posix/module.c
xenomai/ksrc/posix/mq.c
xenomai/ksrc/posix/mutex_attr.c
xenomai/ksrc/posix/mutex.c
xenomai/ksrc/posix/once.c
xenomai/ksrc/posix/registry.c
xenomai/ksrc/posix/sched.c
xenomai/ksrc/posix/sem.c
xenomai/ksrc/posix/signal.c
xenomai/ksrc/posix/syscall.c
xenomai/ksrc/posix/thread_attr.c
xenomai/ksrc/posix/thread.c
xenomai/ksrc/posix/timer.c
xenomai/ksrc/posix/tsd.c
xenomai/ksrc/posix/cancel.h
xenomai/ksrc/posix/cond.h
xenomai/ksrc/posix/internal.h
xenomai/ksrc/posix/intr.h
xenomai/ksrc/posix/jhash.h
xenomai/ksrc/posix/mq.h
xenomai/ksrc/posix/mutex.h
xenomai/ksrc/posix/registry.h
xenomai/ksrc/posix/sem.h
xenomai/ksrc/posix/signal.h
xenomai/ksrc/posix/syscall.h
xenomai/ksrc/posix/thread.h
xenomai/ksrc/posix/timer.h
xenomai/ksrc/posix/tsd.h
xenomai/ksrc/posix/doc
xenomai/ksrc/posix/doc/pse51.txt
xenomai/ksrc/rtai
xenomai/ksrc/rtai/syscall.h
xenomai/ksrc/rtai/fifo.c
xenomai/ksrc/rtai/intr.c
xenomai/ksrc/rtai/module.c
xenomai/ksrc/rtai/sem.c
xenomai/ksrc/rtai/shm.c
xenomai/ksrc/rtai/syscall.c
xenomai/ksrc/rtai/task.c
xenomai/ksrc/rtai/timer.c
xenomai/ksrc/rtai/doc
xenomai/ksrc/rtai/doc/rtai.txt
xenomai/ksrc/rtdm
xenomai/ksrc/rtdm/core.h
xenomai/ksrc/rtdm/device.h
xenomai/ksrc/rtdm/proc.h
xenomai/ksrc/rtdm/syscall.h
xenomai/ksrc/rtdm/core.c
xenomai/ksrc/rtdm/device.c
xenomai/ksrc/rtdm/drvlib.c
xenomai/ksrc/rtdm/module.c
xenomai/ksrc/rtdm/proc.c
xenomai/ksrc/rtdm/syscall.c
xenomai/ksrc/uitron
xenomai/ksrc/uitron/defs.h
xenomai/ksrc/uitron/flag.h
xenomai/ksrc/uitron/mbx.h
xenomai/ksrc/uitron/sem.h
xenomai/ksrc/uitron/task.h
xenomai/ksrc/uitron/flag.c
xenomai/ksrc/uitron/mbx.c
xenomai/ksrc/uitron/module.c
xenomai/ksrc/uitron/sem.c
xenomai/ksrc/uitron/task.c
xenomai/ksrc/uitron/doc
xenomai/ksrc/uitron/doc/mitron3.02.txt
xenomai/ksrc/uitron/doc/uITRON.txt
xenomai/ksrc/uvm
xenomai/ksrc/uvm/syscall.h
xenomai/ksrc/uvm/module.c
xenomai/ksrc/uvm/syscall.c
xenomai/ksrc/vrtx
xenomai/ksrc/vrtx/event.c
xenomai/ksrc/vrtx/heap.c
xenomai/ksrc/vrtx/mb.c
xenomai/ksrc/vrtx/module.c
xenomai/ksrc/vrtx/mx.c
xenomai/ksrc/vrtx/pt.c
xenomai/ksrc/vrtx/queue.c
xenomai/ksrc/vrtx/sem.c
xenomai/ksrc/vrtx/task.c
xenomai/ksrc/vrtx/time.c
xenomai/ksrc/vrtx/defs.h
xenomai/ksrc/vrtx/event.h
xenomai/ksrc/vrtx/heap.h
xenomai/ksrc/vrtx/mb.h
xenomai/ksrc/vrtx/mx.h
xenomai/ksrc/vrtx/pt.h
xenomai/ksrc/vrtx/queue.h
xenomai/ksrc/vrtx/sem.h
xenomai/ksrc/vrtx/task.h
xenomai/ksrc/vrtx/doc
xenomai/ksrc/vrtx/doc/vrtx.txt
xenomai/ksrc/vxworks
xenomai/ksrc/vxworks/defs.h
xenomai/ksrc/vxworks/doc
xenomai/ksrc/vxworks/doc/vxworks.txt
xenomai/ksrc/vxworks/errnoLib.c
xenomai/ksrc/vxworks/intLib.c
xenomai/ksrc/vxworks/kernelLib.c
xenomai/ksrc/vxworks/module.c
xenomai/ksrc/vxworks/msgQLib.c
xenomai/ksrc/vxworks/semLib.c
xenomai/ksrc/vxworks/sysLib.c
xenomai/ksrc/vxworks/taskHookLib.c
xenomai/ksrc/vxworks/taskInfo.c
xenomai/ksrc/vxworks/taskLib.c
xenomai/ksrc/vxworks/tickLib.c
xenomai/ksrc/vxworks/wdLib.c
xenomai/src
xenomai/src/test
xenomai/src/test/cruncher
xenomai/src/test/cruncher/cruncher.c
xenomai/src/test/cruncher/runinfo
xenomai/src/test/klatency
xenomai/src/test/klatency/latency.c
xenomai/src/test/klatency/runinfo
xenomai/src/test/latency
xenomai/src/test/latency/latency.c
xenomai/src/test/latency/runinfo
xenomai/src/test/switch
xenomai/src/test/switch/runinfo
xenomai/src/test/switch/switch.c
xenomai/src/nucleus
xenomai/src/native
xenomai/src/native/alarm.c
xenomai/src/native/cond.c
xenomai/src/native/event.c
xenomai/src/native/heap.c
xenomai/src/native/init.c
xenomai/src/native/intr.c
xenomai/src/native/misc.c
xenomai/src/native/mutex.c
xenomai/src/native/pipe.c
xenomai/src/native/queue.c
xenomai/src/native/sem.c
xenomai/src/native/task.c
xenomai/src/native/timer.c
xenomai/src/posix
xenomai/src/posix/clock.c
xenomai/src/posix/cond.c
xenomai/src/posix/init.c
xenomai/src/posix/interrupt.c
xenomai/src/posix/mq.c
xenomai/src/posix/mutex.c
xenomai/src/posix/rtdm.c
xenomai/src/posix/semaphore.c
xenomai/src/posix/thread.c
xenomai/src/posix/timer.c
xenomai/src/posix/wrappers.c
xenomai/src/posix/posix.wrappers
xenomai/src/posix/pse51.txt
xenomai/src/psos+
xenomai/src/rtai
xenomai/src/rtai/init.c
xenomai/src/rtdm
xenomai/src/rtdm/core.c
xenomai/src/rtdm/init.c
xenomai/src/uvm
xenomai/src/uvm/init.c
xenomai/src/uvm/uvm.c
xenomai/src/uitron
xenomai/include
xenomai/include/nucleus
xenomai/include/nucleus/core.h
xenomai/include/nucleus/heap.h
xenomai/include/nucleus/intr.h
xenomai/include/nucleus/ltt.h
xenomai/include/nucleus/module.h
xenomai/include/nucleus/pipe.h
xenomai/include/nucleus/pod.h
xenomai/include/nucleus/queue.h
xenomai/include/nucleus/shadow.h
xenomai/include/nucleus/synch.h
xenomai/include/nucleus/system.h
xenomai/include/nucleus/thread.h
xenomai/include/nucleus/timer.h
xenomai/include/nucleus/types.h
xenomai/include/nucleus/version.h
xenomai/include/nucleus/xenomai.h
xenomai/include/nucleus/asm-generic
xenomai/include/nucleus/asm-generic/hal.h
xenomai/include/nucleus/asm-generic/syscall.h
xenomai/include/nucleus/asm-generic/system.h
xenomai/include/nucleus/asm-i386
xenomai/include/nucleus/asm-i386/atomic.h
xenomai/include/nucleus/asm-i386/calibration.h
xenomai/include/nucleus/asm-i386/hal.h
xenomai/include/nucleus/asm-i386/syscall.h
xenomai/include/nucleus/asm-i386/system.h
xenomai/include/nucleus/asm-i386/uart.h
xenomai/include/nucleus/asm-ia64
xenomai/include/nucleus/asm-ia64/atomic.h
xenomai/include/nucleus/asm-ia64/calibration.h
xenomai/include/nucleus/asm-ia64/hal.h
xenomai/include/nucleus/asm-ia64/syscall.h
xenomai/include/nucleus/asm-ia64/system.h
xenomai/include/nucleus/asm-ppc
xenomai/include/nucleus/asm-ppc/atomic.h
xenomai/include/nucleus/asm-ppc/calibration.h
xenomai/include/nucleus/asm-ppc/hal.h
xenomai/include/nucleus/asm-ppc/syscall.h
xenomai/include/nucleus/asm-ppc/system.h
xenomai/include/nucleus/asm-ppc/uart.h
xenomai/include/nucleus/asm-ppc64
xenomai/include/nucleus/asm-ppc64/atomic.h
xenomai/include/nucleus/asm-ppc64/calibration.h
xenomai/include/nucleus/asm-ppc64/hal.h
xenomai/include/nucleus/asm-ppc64/syscall.h
xenomai/include/nucleus/asm-ppc64/system.h
xenomai/include/nucleus/asm-uvm
xenomai/include/nucleus/asm-uvm/system.h
xenomai/include/native
xenomai/include/native/alarm.c
xenomai/include/native/cond.h
xenomai/include/native/event.h
xenomai/include/native/heap.h
xenomai/include/native/intr.h
xenomai/include/native/misc.h
xenomai/include/native/mutex.h
xenomai/include/native/pipe.h
xenomai/include/native/queue.h
xenomai/include/native/registry.h
xenomai/include/native/sem.h
xenomai/include/native/task.h
xenomai/include/native/timer.h
xenomai/include/native/types.h
xenomai/include/posix
xenomai/include/posix/mqueue.h
xenomai/include/posix/posix.h
xenomai/include/posix/pthread.h
xenomai/include/posix/semaphore.h
xenomai/include/psos+
xenomai/include/psos+/psos.h
xenomai/include/rtai
xenomai/include/rtai/fifo.h
xenomai/include/rtai/intr.h
xenomai/include/rtai/rtai_fifos.h
xenomai/include/rtai/rtai.h
xenomai/include/rtai/rtai_hal.h
xenomai/include/rtai/rtai_nam2num.h
xenomai/include/rtai/rtai_proc_fs.h
xenomai/include/rtai/rtai_sched.h
xenomai/include/rtai/rtai_sem.h
xenomai/include/rtai/rtai_shm.h
xenomai/include/rtai/rtai_types.h
xenomai/include/rtai/rt_mem_mgr.h
xenomai/include/rtai/sem.h
xenomai/include/rtai/shm.h
xenomai/include/rtai/task.h
xenomai/include/rtai/timer.h
xenomai/include/rtai/types.h
xenomai/include/rtdm
xenomai/include/rtdm/rtdm_driver.h
xenomai/include/rtdm/rtdm.h
xenomai/include/rtdm/rtserial.h
xenomai/include/uitron
xenomai/include/uitron/uitron.h
xenomai/include/uvm
xenomai/include/uvm/uvm.h
xenomai/include/vrtx
xenomai/include/vrtx/vrtx.h
xenomai/include/vxworks
xenomai/include/vxworks/vxworks.h
xenomai/doc
xenomai/doc/snippets
xenomai/doc/snippets/native
xenomai/doc/snippets/native/bound_task.c
xenomai/doc/snippets/native/cond_var.c
xenomai/doc/snippets/native/event_flags.c
xenomai/doc/snippets/native/kernel_task.c
xenomai/doc/snippets/native/local_heap.c
xenomai/doc/snippets/native/msg_queue.c
xenomai/doc/snippets/native/mutex.c
xenomai/doc/snippets/native/pipe.c
xenomai/doc/snippets/native/semaphore.c
xenomai/doc/snippets/native/shared_mem.c
xenomai/doc/snippets/native/sigxcpu.c
xenomai/doc/snippets/native/user_alarm.c
xenomai/doc/snippets/native/user_irq.c
xenomai/doc/snippets/native/user_task.c
xenomai/doc/demos
xenomai/doc/demos/posix
xenomai/doc/demos/posix/accuracy.c
xenomai/doc/demos/posix/satch.c
xenomai/doc/demos/native
xenomai/doc/demos/native/latency.c
xenomai/doc/demos/native/satch.c
xenomai/doc/demos/psos+
xenomai/doc/demos/psos+/satch.c
xenomai/doc/demos/vxworks
xenomai/doc/demos/vxworks/koan.c
xenomai/doc/demos/vxworks/satch.c
xenomai/doc/docbook
xenomai/doc/doxygen
xenomai/doc/man
xenomai/doc/nodist
xenomai/doc/generated
xenomai/etc
xenomai/etc/udev
xenomai/etc/udev/rtheap.rules
xenomai/etc/udev/rtpipe.rules
xenomai/scripts
xenomai/scripts/xeno-config.in
xenomai/scripts/xeno-info
xenomai/scripts/xeno-load.in
xenomai/scripts/xeno-test.in
xenomai/build
xenomai/build/bootstrap
xenomai/build/generate-doc
xenomai/README.QUICKINSTALL
xenomai/README.INSTALL
xenomai/TROUBLESHOOTING
xenomai/CREDITS
xenomai/ChangeLog

--Boundary-00=_0uJWDCLeKjbbpdw
Content-Type: text/plain;
  charset="us-ascii";
  name="dirs.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dirs.txt"

xenomai/
xenomai/ksrc
xenomai/ksrc/test
xenomai/ksrc/test/klatency
xenomai/ksrc/arch
xenomai/ksrc/arch/generic
xenomai/ksrc/arch/generic/hal
xenomai/ksrc/arch/i386
xenomai/ksrc/arch/i386/hal
xenomai/ksrc/arch/ppc
xenomai/ksrc/arch/ppc/arch
xenomai/ksrc/arch/ia64
xenomai/ksrc/arch/ia64/hal
xenomai/ksrc/arch/ppc64
xenomai/ksrc/arch/ppc64/hal
xenomai/ksrc/drivers
xenomai/ksrc/drivers/16550A
xenomai/ksrc/nucleus
xenomai/ksrc/native
xenomai/ksrc/psos+
xenomai/ksrc/psos+/doc
xenomai/ksrc/posix
xenomai/ksrc/posix/doc
xenomai/ksrc/rtai
xenomai/ksrc/rtai/doc
xenomai/ksrc/rtdm
xenomai/ksrc/uitron
xenomai/ksrc/uitron/doc
xenomai/ksrc/uvm
xenomai/ksrc/vrtx
xenomai/ksrc/vrtx/doc
xenomai/ksrc/vxworks
xenomai/ksrc/vxworks/doc
xenomai/src
xenomai/src/test
xenomai/src/test/cruncher
xenomai/src/test/klatency
xenomai/src/test/latency
xenomai/src/test/switch
xenomai/src/nucleus
xenomai/src/native
xenomai/src/posix
xenomai/src/psos+
xenomai/src/rtai
xenomai/src/rtdm
xenomai/src/uvm
xenomai/src/uitron
xenomai/include
xenomai/include/nucleus
xenomai/include/nucleus/asm-generic
xenomai/include/nucleus/asm-i386
xenomai/include/nucleus/asm-ia64
xenomai/include/nucleus/asm-ppc
xenomai/include/nucleus/asm-ppc64
xenomai/include/nucleus/asm-uvm
xenomai/include/native
xenomai/include/posix
xenomai/include/psos+
xenomai/include/rtai
xenomai/include/rtdm
xenomai/include/uitron
xenomai/include/uvm
xenomai/include/vrtx
xenomai/include/vxworks
xenomai/doc
xenomai/doc/snippets
xenomai/doc/snippets/native
xenomai/doc/demos
xenomai/doc/demos/posix
xenomai/doc/demos/native
xenomai/doc/demos/psos+
xenomai/doc/demos/vxworks
xenomai/doc/docbook
xenomai/doc/doxygen
xenomai/doc/man
xenomai/doc/nodist
xenomai/doc/generated
xenomai/etc
xenomai/etc/udev
xenomai/scripts
xenomai/build

--Boundary-00=_0uJWDCLeKjbbpdw--

