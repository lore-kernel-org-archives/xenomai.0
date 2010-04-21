MIME-Version: 1.0
In-Reply-To: <4BCEE8AC.4080101@domain.hid>
References: <k2xbfcfb7e81004210425l88dbbb99gb8b1ec4dd254300d@domain.hid>
	<4BCEE8AC.4080101@domain.hid>
Date: Wed, 21 Apr 2010 21:35:21 +0530
Message-ID: <w2kbfcfb7e81004210905v507fbcf4oe20e1f695ddfd1aa@domain.hid>
From: Nero Fernandez <grimlynch@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd0eaea7767640484c15c5e
Subject: Re: [Xenomai-core] [xeno_switchtest] missing linux-dev registration?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--000e0cd0eaea7767640484c15c5e
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Apr 21, 2010 at 5:29 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Nero Fernandez wrote:
> > This is regarding the pervasive error "Unable to open switchtest device"
> > while
>
> You are using Xenomai 2.5.2 right? switchtest is not working in Xenomai
> 2.5.2 because RTDM syscalls were switchted do __xn_exec_conforming. This
> gave birth to a long discussion, and finally a commit to fix the issue.
> Xenomai 2.5 current head contains this change.
>
> > trying to test context-switch timings using 'switchtest' testsuite
> > application.
>
> switchtest does not test context switch timing.
>
> >
> > Looking at the testsuite code, i found that
> >   - 'latency' (which can successfully operate the xeno_switchtest driver
> )
> >      uses rtdm_dev_xxx calls whereas
>
> No, latency uses the timerbench driver. The fact that the device almost
> has the same name is misleading and has been fixed in Xenomai 2.5
> current head too.
>
> >  - 'switchtest' application uses the posix 'open'/'close' system-calls
> >     for driver-interaction
> >
> > Looking at ksrc/drivers/testing/switchtest.c, i found that there is no
> > registration
> > of switchtest under linux-device-driver subsystem (even as a misc driver
> > like rtnet or rtheap do).
>
> True. But there is a registration as an RTDM device.
>
> > Thus, there doesnt seem to be a way through which a linux-process (non-RT
> > mode)
> > may access xeno_switchtest driver through /dev/rttest<x>
> > (or the new /dev/rttest-switchtst<x>
> >   ref: https://mail.gna.org/public/xenomai-git/2010-04/msg00073.html).
>
> No. It should work. The device is registered as an RTDM device, and the
> switchtest application opens the same device using open, which is turned
> into the corresponding rtdm syscall by the posix skin.
>
> >
> > In case there is such a registration required, i would be more than
> willing
> > to contribute.
> >
> > In case, the 'open' system-call is handled by one of the skins
> >  (i have native, posix,rtai and rtdm enabled in my kernel-config),
> > kindly point out the code and enlighten.
> >
> > Thanks for running this awesome project and all the help/pointers.
>
> It works here, are you sure you enabled the switchtest driver?
>
> --
>                                             Gilles.
>

Thanks, Jan, Gilles, for very prompt responses.

I concur with your comments on the posix call being
converted into RTDM call...
An open in 'switchtest' app directly goes to 'rtswitch_open' in
the driver (instead of normal misc-dev open that i hooked into
xeno_switchtest driver code)
Will look more closely into the posix skin, as you suggest....

The error is during the ioctl 'RTTST_RTIOC_SWTEST_SET_TASK_COUNT',
which fails as a 'Inappropriate ioctl for the driver'...
i will check the git-head, as you suggest.. and also my setup for any
mistakes....

i confirmed again for 'XENO_DRIVERS_SWITCHTEST' in kernel-config....
i enabled just this option (in loadable-module mode), so as not to have
conflicts
with other test-drivers....

Regarding the setup:
 - Xenomai - 2.5.2
 - linux-2.6.30.10
 - busybox 1.16
I am currently trying to validate my build and setup using a Qemu-emulation
of
ARM-Versatile, ARM926EJS board.

Thanks once again....

Following are my current kernel-config and output of xeno-test on my setup


Xeno-test output (mainly configuration info)
__________________________________________________________________________
# ./xeno-test
xeno-test: started
withBusybox is 1
xeno-test: running tests

Thu Jan  1 00:00:17 UTC 1970
running: ./xeno-config --verbose
xeno-config --verbose
        --version="2.5.2"
        --cc="arm-linux-gcc"
        --arch="arm"
        --prefix="/opt/xeno_utils"
        --xeno-cflags="-I/opt/xeno_utils/include -D_GNU_SOURCE -D_REENTRANT
-Wall -pipe -D__XENO__"
        --xeno-ldflags="-L/opt/xeno_utils/lib -lxenomai -lpthread "
        --posix-cflags=""
        --posix-ldflags="-Wl,@/opt/xeno_utils/lib/posix.wrappers
-L/opt/xeno_utils/lib -lpthread_rt -lxenomai -lpthread -lrt "
        --library-dir="/opt/xeno_utils/lib"

Thu Jan  1 00:00:17 UTC 1970
running: ./xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

BusyBox v1.14.0 (2010-03-30 00:20:14 IST) multi-call binary
Linux (none) 2.6.30.10-svn5 #11 Wed Apr 21 20:45:00 IST 2010 armv5tejl
GNU/Linux

module-init-tools      V
Modules Loaded         xeno_switchtest

Thu Jan  1 00:00:18 UTC 1970
running: cat /proc/cpuinfo
Processor    : ARM926EJ-S rev 5 (v5l)
BogoMIPS    : 2516.58
Features    : swp half thumb fastmult edsp java
CPU implementer    : 0x41
CPU architecture: 5TEJ
CPU variant    : 0x0
CPU part    : 0x926
CPU revision    : 5

Hardware    : ARM-IntegratorCP
Revision    : 0000
Serial        : 0000000000000000

Thu Jan  1 00:00:18 UTC 1970
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
2c240fd8e74c0d710cb55ad874f6c11a  /proc/cpuinfo
# CONFIG_PREEMPT_RCU is not set
# CONFIG_PREEMPT_RCU_TRACE is not set
CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH=y
CONFIG_IPIPE=y
CONFIG_IPIPE_DOMAINS=4
CONFIG_IPIPE_COMPAT=y
CONFIG_IPIPE_DELAYED_ATOMICSW=y
# CONFIG_PREEMPT is not set
# CONFIG_CPU_FREQ is not set
# CONFIG_PM is not set
CONFIG_IPIPE_DEBUG=y
CONFIG_IPIPE_DEBUG_CONTEXT=y
CONFIG_IPIPE_DEBUG_INTERNAL=y
CONFIG_IPIPE_TRACE=y
CONFIG_IPIPE_TRACE_ENABLE=y
CONFIG_IPIPE_TRACE_MCOUNT=y
CONFIG_IPIPE_TRACE_IRQSOFF=y
CONFIG_IPIPE_TRACE_SHIFT=14
CONFIG_IPIPE_TRACE_VMALLOC=y
CONFIG_IPIPE_TRACE_PANIC=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set

Thu Jan  1 00:00:18 UTC 1970
running: cat /proc/ipipe/Linux
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
   0:  A....
   1:  A....
   2:  A....
   3:  A....
   4:  A....
   5:  A....
   6:  A....
   7:  A....
   8:  A....
   9:  A....
  10:  A....
  11:  A....
  12:  A....
  13:  A....
  14:  A....
  15:  A....
  16:  A....
  17:  A....
  18:  A....
  19:  A....
  20:  A....
  21:  A....
  22:  A....
  23:  A....
  24:  A....
  25:  A....
  26:  A....
  27:  A....
  28:  A....
  29:  A....
  30:  A....
  31:  A....
  32:  A....
  33:  A....
  34:  A....
  35:  A....
  36:  A....
  37:  A....
  38:  A....
  39:  A....
  40:  A....
  41:  A....
  42:  A....
  43:  A....
  44:  A....
  45:  A....
  46:  A....
  64:  G...V
  65:  G...V
[Domain info]
id=0x00000000
priority=100

Thu Jan  1 00:00:18 UTC 1970
running: cat /proc/ipipe/Xenomai
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
   6:  W..X.
  66:  W...V
[Domain info]
id=0x58454e4f
priority=topmost

Thu Jan  1 00:00:18 UTC 1970
running: cat /proc/ipipe/trace
cat: read error: Is a directory

Thu Jan  1 00:00:18 UTC 1970
running: cat /proc/ipipe/version
1.15-01

Thu Jan  1 00:00:18 UTC 1970
running: generate_loads 1
dd workload started, pids 532 stored in /var/lock/xeno-test.421.pids

Thu Jan  1 00:00:18 UTC 1970
running: cat /proc/interrupts
           CPU0
  1:        706         PIC  uart-pl011
  4:         87         PIC  kmi-pl050
  6:       1813         PIC  Integrator Timer Tick
 27:          0         PIC  eth0
Err:          0

Thu Jan  1 00:00:18 UTC 1970
running: cat /proc/loadavg
0.00 0.00 0.00 3/28 538

Thu Jan  1 00:00:18 UTC 1970
running: cat /proc/meminfo
MemTotal:         124844 kB
MemFree:           96100 kB
Buffers:             136 kB
Cached:             1860 kB
SwapCached:            0 kB
Active:             1284 kB
Inactive:           1080 kB
Active(anon):        372 kB
Inactive(anon):        0 kB
Active(file):        912 kB
Inactive(file):     1080 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                36 kB
Writeback:             0 kB
AnonPages:           396 kB
Mapped:              520 kB
Slab:               1776 kB
SReclaimable:        832 kB
SUnreclaim:          944 kB
PageTables:           80 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:       62420 kB
Committed_AS:       1972 kB
VmallocTotal:     122880 kB
VmallocUsed:        2232 kB
VmallocChunk:     120432 kB

Thu Jan  1 00:00:18 UTC 1970
running: cat /proc/xenomai/acct
0 0 0 0 0 00500080 19196744000 501802000 501802000 ROOT
0 0 0 1790 0 00000000 19196744000 18693191000 18693191000 IRQ6: [timer]

Thu Jan  1 00:00:18 UTC 1970
running: cat /proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:            0    (xnselectors_destroy)
  2:            0    (lostage_handler)
  3:            0    (registry_export)
  4:            0    (pse51_lostage_handler)

Thu Jan  1 00:00:18 UTC 1970
running: cat /proc/xenomai/faults
TRAP         CPU0
  0:            0    (Data or instruction access)
  1:            0    (Section fault)
  2:            0    (Generic data abort)
  3:            0    (Unknown exception)
  4:            0    (Instruction breakpoint)
  5:            0    (Floating point exception)
  6:            0    (VFP Floating point exception)
  7:            0    (Undefined instruction)
  8:            0    (Unaligned access exception)

Thu Jan  1 00:00:18 UTC 1970
running: cat /proc/xenomai/hal
1.15-01

Thu Jan  1 00:00:18 UTC 1970
running: cat /proc/xenomai/heap
size=8192:used=8:pagesz=4096  (global sem heap)
size=259584:used=96:pagesz=512  (main heap)
size=129536:used=0:pagesz=512  (stack pool)

Thu Jan  1 00:00:18 UTC 1970
running: cat /proc/xenomai/irq
IRQ         CPU0
  6:        1796         [timer]
 66:           0         [virtual]

Thu Jan  1 00:00:18 UTC 1970
running: cat /proc/xenomai/latency
10000

Thu Jan  1 00:00:18 UTC 1970
running: cat /proc/xenomai/lock
CPU0:
  longest locked section: 18446744073644064616 ns
  spinning time: 1000 ns
  section entry: kernel/xenomai/nucleus/registry.c:160 (xnregistry_init)

Mem: 28924K used, 95920K free, 0K shrd, 136K buff, 1908K cached
CPU: 18.7% usr 81.2% sys  0.0% nic  0.0% idle  0.0% io  0.0% irq  0.0% sirq
Load average: 0.00 0.00 0.00 2/30 618

__________________________________________________________________________

Kernel-config:
_________________________________________________________________________________________
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.30.10
# Wed Apr 21 17:06:02 2010
#
CONFIG_ARM=y
CONFIG_SYS_SUPPORTS_APM_EMULATION=y
# CONFIG_GENERIC_GPIO is not set
# CONFIG_GENERIC_TIME is not set
# CONFIG_GENERIC_CLOCKEVENTS is not set
CONFIG_MMU=y
# CONFIG_NO_IOPORT is not set
CONFIG_GENERIC_HARDIRQS=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
CONFIG_VECTORS_BASE=0xffff0000
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_AUDIT is not set

#
# RCU Subsystem
#
CONFIG_CLASSIC_RCU=y
# CONFIG_TREE_RCU is not set
# CONFIG_PREEMPT_RCU is not set
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_PREEMPT_RCU_TRACE is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_GROUP_SCHED is not set
# CONFIG_CGROUPS is not set
CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y
# CONFIG_RELAY is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
# CONFIG_NET_NS is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
CONFIG_MARKERS=y
CONFIG_HAVE_OPROFILE=y
# CONFIG_KPROBES is not set
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_CLK=y
CONFIG_SLOW_WORK=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_BLOCK=y
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_BLK_DEV_INTEGRITY is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"

#
# Real-time sub-system
#
CONFIG_XENOMAI=y
CONFIG_XENO_GENERIC_STACKPOOL=y
CONFIG_XENO_FASTSYNCH_DEP=y
CONFIG_XENO_FASTSYNCH=y
CONFIG_XENO_OPT_NUCLEUS=y
CONFIG_XENO_OPT_PERVASIVE=y
CONFIG_XENO_OPT_PRIOCPL=y
CONFIG_XENO_OPT_PIPELINE_HEAD=y
# CONFIG_XENO_OPT_SCHED_CLASSES is not set
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_SYS_HEAPSZ=256
CONFIG_XENO_OPT_SYS_STACKPOOLSZ=128
CONFIG_XENO_OPT_SEM_HEAPSZ=12
CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ=12
CONFIG_XENO_OPT_STATS=y
CONFIG_XENO_OPT_DEBUG=y
CONFIG_XENO_OPT_DEBUG_NUCLEUS=y
CONFIG_XENO_OPT_DEBUG_XNLOCK=y
CONFIG_XENO_OPT_DEBUG_QUEUES=y
CONFIG_XENO_OPT_DEBUG_REGISTRY=y
CONFIG_XENO_OPT_DEBUG_TIMERS=y
CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX=y
CONFIG_XENO_OPT_WATCHDOG=y
CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=4
# CONFIG_XENO_OPT_SHIRQ is not set
CONFIG_XENO_OPT_SELECT=y

#
# Timing
#
CONFIG_XENO_OPT_TIMING_PERIODIC=y
CONFIG_XENO_OPT_TIMING_VIRTICK=1000
CONFIG_XENO_OPT_TIMING_SCHEDLAT=0

#
# Scalability
#
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
CONFIG_XENO_OPT_TIMER_LIST=y
# CONFIG_XENO_OPT_TIMER_HEAP is not set
# CONFIG_XENO_OPT_TIMER_WHEEL is not set

#
# Machine
#
CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH=y
CONFIG_XENO_HW_FPU=y
CONFIG_XENO_HW_UNLOCKED_SWITCH=y

#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_OPT_NATIVE_PERIOD=0
CONFIG_XENO_OPT_NATIVE_PIPE=y
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=1024
CONFIG_XENO_OPT_NATIVE_SEM=y
CONFIG_XENO_OPT_NATIVE_EVENT=y
CONFIG_XENO_OPT_NATIVE_MUTEX=y
CONFIG_XENO_OPT_NATIVE_COND=y
CONFIG_XENO_OPT_NATIVE_QUEUE=y
CONFIG_XENO_OPT_NATIVE_BUFFER=y
CONFIG_XENO_OPT_NATIVE_HEAP=y
CONFIG_XENO_OPT_NATIVE_ALARM=y
CONFIG_XENO_OPT_NATIVE_MPS=y
# CONFIG_XENO_OPT_NATIVE_INTR is not set
CONFIG_XENO_OPT_DEBUG_NATIVE=y
CONFIG_XENO_SKIN_POSIX=y
CONFIG_XENO_OPT_POSIX_PERIOD=0
CONFIG_XENO_OPT_POSIX_SHM=y
CONFIG_XENO_OPT_POSIX_INTR=y
CONFIG_XENO_OPT_POSIX_SELECT=y
CONFIG_XENO_OPT_DEBUG_POSIX=y
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
CONFIG_XENO_SKIN_RTAI=y
CONFIG_XENO_OPT_RTAI_PERIOD=0
CONFIG_XENO_OPT_RTAI_FIFO=y
CONFIG_XENO_OPT_RTAI_SEM=y
CONFIG_XENO_OPT_RTAI_SHM=y
# CONFIG_XENO_OPT_NOWARN_DEPRECATED is not set
CONFIG_XENO_SKIN_RTDM=y
CONFIG_XENO_OPT_RTDM_PERIOD=0
CONFIG_XENO_OPT_RTDM_FILDES=128
CONFIG_XENO_OPT_RTDM_SELECT=y
CONFIG_XENO_OPT_DEBUG_RTDM=y
CONFIG_XENO_OPT_DEBUG_RTDM_APPL=y

#
# Drivers
#

#
# Serial drivers
#
# CONFIG_XENO_DRIVERS_16550A is not set

#
# Testing drivers
#
CONFIG_XENO_TESTING_MODULE=m
# CONFIG_XENO_DRIVERS_TIMERBENCH is not set
# CONFIG_XENO_DRIVERS_IRQBENCH is not set
CONFIG_XENO_DRIVERS_SWITCHTEST=m
# CONFIG_XENO_DRIVERS_SIGTEST is not set

#
# CAN drivers
#
# CONFIG_XENO_DRIVERS_CAN is not set

#
# ANALOGY drivers
#
# CONFIG_XENO_DRIVERS_ANALOGY is not set

#
# Real-time IPC drivers
#
# CONFIG_XENO_DRIVERS_RTIPC is not set
# CONFIG_FREEZER is not set

#
# System Type
#
# CONFIG_ARCH_AAEC2000 is not set
CONFIG_ARCH_INTEGRATOR=y
# CONFIG_ARCH_REALVIEW is not set
# CONFIG_ARCH_VERSATILE is not set
# CONFIG_ARCH_AT91 is not set
# CONFIG_ARCH_CLPS711X is not set
# CONFIG_ARCH_EBSA110 is not set
# CONFIG_ARCH_EP93XX is not set
# CONFIG_ARCH_GEMINI is not set
# CONFIG_ARCH_FOOTBRIDGE is not set
# CONFIG_ARCH_NETX is not set
# CONFIG_ARCH_H720X is not set
# CONFIG_ARCH_IMX is not set
# CONFIG_ARCH_IOP13XX is not set
# CONFIG_ARCH_IOP32X is not set
# CONFIG_ARCH_IOP33X is not set
# CONFIG_ARCH_IXP23XX is not set
# CONFIG_ARCH_IXP2000 is not set
# CONFIG_ARCH_IXP4XX is not set
# CONFIG_ARCH_L7200 is not set
# CONFIG_ARCH_KIRKWOOD is not set
# CONFIG_ARCH_KS8695 is not set
# CONFIG_ARCH_NS9XXX is not set
# CONFIG_ARCH_LOKI is not set
# CONFIG_ARCH_MV78XX0 is not set
# CONFIG_ARCH_MXC is not set
# CONFIG_ARCH_ORION5X is not set
# CONFIG_ARCH_PNX4008 is not set
# CONFIG_ARCH_PXA is not set
# CONFIG_ARCH_MMP is not set
# CONFIG_ARCH_RPC is not set
# CONFIG_ARCH_SA1100 is not set
# CONFIG_ARCH_S3C2410 is not set
# CONFIG_ARCH_S3C64XX is not set
# CONFIG_ARCH_SHARK is not set
# CONFIG_ARCH_LH7A40X is not set
# CONFIG_ARCH_DAVINCI is not set
# CONFIG_ARCH_OMAP is not set
# CONFIG_ARCH_MSM is not set
# CONFIG_ARCH_W90X900 is not set

#
# Integrator Options
#
# CONFIG_ARCH_INTEGRATOR_AP is not set
CONFIG_ARCH_INTEGRATOR_CP=y
CONFIG_ARCH_CINTEGRATOR=y

#
# Processor Type
#
CONFIG_CPU_32=y
# CONFIG_CPU_ARM720T is not set
# CONFIG_CPU_ARM920T is not set
# CONFIG_CPU_ARM922T is not set
CONFIG_CPU_ARM926T=y
# CONFIG_CPU_ARM1020 is not set
# CONFIG_CPU_ARM1022 is not set
# CONFIG_CPU_ARM1026 is not set
# CONFIG_CPU_V6 is not set
# CONFIG_CPU_V7 is not set
CONFIG_CPU_32v5=y
CONFIG_CPU_ABRT_EV5TJ=y
CONFIG_CPU_PABRT_NOIFAR=y
CONFIG_CPU_CACHE_VIVT=y
CONFIG_CPU_COPY_V4WB=y
CONFIG_CPU_TLB_V4WBI=y
CONFIG_CPU_CP15=y
CONFIG_CPU_CP15_MMU=y

#
# Processor Features
#
CONFIG_ARM_THUMB=y
# CONFIG_CPU_ICACHE_DISABLE is not set
# CONFIG_CPU_DCACHE_DISABLE is not set
# CONFIG_CPU_DCACHE_WRITETHROUGH is not set
# CONFIG_CPU_CACHE_ROUND_ROBIN is not set
# CONFIG_OUTER_CACHE is not set
# CONFIG_ARM_FCSE is not set
CONFIG_ICST525=y
CONFIG_COMMON_CLKDEV=y

#
# Bus support
#
CONFIG_ARM_AMBA=y
# CONFIG_PCI_SYSCALL is not set
# CONFIG_ARCH_SUPPORTS_MSI is not set
CONFIG_PCCARD=y
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_PCMCIA_IOCTL=y

#
# PC-card bridges
#

#
# Kernel Features
#
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_IPIPE=y
CONFIG_IPIPE_DOMAINS=4
CONFIG_IPIPE_COMPAT=y
CONFIG_IPIPE_DELAYED_ATOMICSW=y
# CONFIG_PREEMPT is not set
CONFIG_HZ=100
CONFIG_AEABI=y
CONFIG_OABI_COMPAT=y
# CONFIG_ARCH_HAS_HOLES_MEMORYMODEL is not set
# CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
# CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
# CONFIG_HIGHMEM is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4096
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_ZONE_DMA_FLAG=0
CONFIG_VIRT_TO_BUS=y
CONFIG_UNEVICTABLE_LRU=y
CONFIG_HAVE_MLOCK=y
CONFIG_HAVE_MLOCKED_PAGE_BIT=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_LEDS=y
CONFIG_LEDS_TIMER=y
CONFIG_LEDS_CPU=y
CONFIG_ALIGNMENT_TRAP=y

#
# Boot options
#
CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0
CONFIG_CMDLINE=""
# CONFIG_XIP_KERNEL is not set
# CONFIG_KEXEC is not set

#
# CPU Power Management
#
# CONFIG_CPU_FREQ is not set
# CONFIG_CPU_IDLE is not set

#
# Floating point emulation
#

#
# At least one emulation must be selected
#
CONFIG_FPE_NWFPE=y
# CONFIG_FPE_NWFPE_XP is not set
# CONFIG_FPE_FASTFPE is not set
# CONFIG_VFP is not set

#
# Userspace binary formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=y

#
# Power management options
#
# CONFIG_PM is not set
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_LRO=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_PHONET is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
# CONFIG_MTD_DEBUG is not set
# CONFIG_MTD_CONCAT is not set
CONFIG_MTD_PARTITIONS=y
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_AFS_PARTS=y
# CONFIG_MTD_AR7_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_MTD_OOPS is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_OTP is not set
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_ARM_INTEGRATOR is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOC2001PLUS is not set
# CONFIG_MTD_NAND is not set
# CONFIG_MTD_ONENAND is not set

#
# LPDDR flash memory drivers
#
# CONFIG_MTD_LPDDR is not set

#
# UBI - Unsorted block images
#
# CONFIG_MTD_UBI is not set
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=20480
# CONFIG_BLK_DEV_XIP is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_MISC_DEVICES=y
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_93CX6 is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
# CONFIG_SCSI is not set
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_ATA is not set
# CONFIG_MD is not set
CONFIG_NETDEVICES=y
CONFIG_COMPAT_NET_DEV_OPS=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=y
# CONFIG_VETH is not set
# CONFIG_PHYLIB is not set
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_AX88796 is not set
CONFIG_SMC91X=y
# CONFIG_DM9000 is not set
# CONFIG_ETHOC is not set
# CONFIG_SMC911X is not set
# CONFIG_SMSC911X is not set
# CONFIG_DNET is not set
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
# CONFIG_B44 is not set
CONFIG_NETDEV_1000=y
CONFIG_NETDEV_10000=y

#
# Wireless LAN
#
# CONFIG_WLAN_PRE80211 is not set
# CONFIG_WLAN_80211 is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_NET_PCMCIA is not set
# CONFIG_WAN is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_NETCONSOLE=y
# CONFIG_NETCONSOLE_DYNAMIC is not set
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ATKBD is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_ATI_REMOTE is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_UINPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_AMBAKMI=y
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_DEVKMEM=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_AMBA_PL010 is not set
CONFIG_SERIAL_AMBA_PL011=y
CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=16
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
# CONFIG_R3964 is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
# CONFIG_IPWIRELESS is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_I2C is not set
# CONFIG_SPI is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_HWMON_DEBUG_CHIP is not set
# CONFIG_THERMAL is not set
# CONFIG_THERMAL_HWMON is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_T7L66XB is not set
# CONFIG_MFD_TC6387XB is not set

#
# Multimedia devices
#

#
# Multimedia core support
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DVB_CORE is not set
# CONFIG_VIDEO_MEDIA is not set

#
# Multimedia drivers
#
# CONFIG_DAB is not set

#
# Graphics support
#
# CONFIG_VGASTATE is not set
# CONFIG_VIDEO_OUTPUT_CONTROL is not set
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
# CONFIG_FB_DDC is not set
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_ARMCLCD=y
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Display device support
#
CONFIG_DISPLAY_SUPPORT=y

#
# Display hardware drivers
#

#
# Console display driver support
#
# CONFIG_VGA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
CONFIG_FONT_7x14=y
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
CONFIG_FONT_MINI_4x6=y
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_10x18 is not set
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_SOUND is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_DEBUG=y
# CONFIG_HIDRAW is not set
# CONFIG_HID_PID is not set

#
# Special HID drivers
#
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB_ARCH_HAS_OHCI is not set
# CONFIG_USB_ARCH_HAS_EHCI is not set
# CONFIG_USB is not set

#
# Enable Host or Gadget support to see Inventra options
#

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#
# CONFIG_USB_GADGET is not set

#
# OTG and related infrastructure
#
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_NEW_LEDS is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# SPI RTC drivers
#

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_PL030 is not set
# CONFIG_RTC_DRV_PL031 is not set
# CONFIG_DMADEVICES is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_REGULATOR is not set
# CONFIG_UIO is not set
# CONFIG_STAGING is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_FILE_LOCKING=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set
CONFIG_GENERIC_ACL=y

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=y
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_CONFIGFS_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_FS_XATTR is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
# CONFIG_JFFS2_LZO is not set
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
CONFIG_CRAMFS=y
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_NILFS2_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
CONFIG_ROOT_NFS=y
# CONFIG_NFS_FSCACHE is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
# CONFIG_NFSD_V4 is not set
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_NLS is not set
# CONFIG_DLM is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
CONFIG_MAGIC_SYSRQ=y
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
CONFIG_IPIPE_DEBUG=y
CONFIG_IPIPE_DEBUG_CONTEXT=y
CONFIG_IPIPE_DEBUG_INTERNAL=y
CONFIG_IPIPE_TRACE=y
CONFIG_IPIPE_TRACE_ENABLE=y
CONFIG_IPIPE_TRACE_MCOUNT=y
CONFIG_IPIPE_TRACE_IRQSOFF=y
CONFIG_IPIPE_TRACE_SHIFT=14
CONFIG_IPIPE_TRACE_VMALLOC=y
CONFIG_IPIPE_TRACE_PANIC=y
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_TIMER_STATS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_WRITECOUNT is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_FRAME_POINTER=y
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_CPU_STALL_DETECTOR is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
# CONFIG_SYSCTL_SYSCALL_CHECK is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_RING_BUFFER=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y

#
# Tracers
#
CONFIG_FUNCTION_TRACER=y
# CONFIG_SCHED_TRACER is not set
CONFIG_CONTEXT_SWITCH_TRACER=y
# CONFIG_EVENT_TRACER is not set
# CONFIG_BOOT_TRACER is not set
# CONFIG_TRACE_BRANCH_PROFILING is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_KMEMTRACE is not set
# CONFIG_WORKQUEUE_TRACER is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARM_UNWIND=y
# CONFIG_DEBUG_USER is not set
CONFIG_DEBUG_ERRORS=y
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_LL is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
# CONFIG_SECURITY_FILE_CAPABILITIES is not set
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
# CONFIG_CRYPTO_FIPS is not set
# CONFIG_CRYPTO_MANAGER is not set
# CONFIG_CRYPTO_MANAGER2 is not set
# CONFIG_CRYPTO_GF128MUL is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_SEQIV is not set

#
# Block modes
#
# CONFIG_CRYPTO_CBC is not set
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
# CONFIG_CRYPTO_ECB is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set

#
# Hash modes
#
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set

#
# Digest
#
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_ZLIB is not set
# CONFIG_CRYPTO_LZO is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_HW=y
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_GENERIC_FIND_LAST_BIT=y
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC_T10DIF is not set
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y
CONFIG_NLATTR=y
_________________________________________________________________________________________

--000e0cd0eaea7767640484c15c5e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">On Wed, Apr 21, 2010 at 5:29 PM, Gilles Chan=
teperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
mai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: =
1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">Nero Fernandez wrote:<br>
&gt; This is regarding the pervasive error &quot;Unable to open switchtest =
device&quot;<br>
&gt; while<br>
<br>
</div>You are using Xenomai 2.5.2 right? switchtest is not working in Xenom=
ai<br>
2.5.2 because RTDM syscalls were switchted do __xn_exec_conforming. This<br=
>
gave birth to a long discussion, and finally a commit to fix the issue.<br>
Xenomai 2.5 current head contains this change.<br>
<div class=3D"im"><br>
&gt; trying to test context-switch timings using &#39;switchtest&#39; tests=
uite<br>
&gt; application.<br>
<br>
</div>switchtest does not test context switch timing.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; Looking at the testsuite code, i found that<br>
&gt; =A0 - &#39;latency&#39; (which can successfully operate the xeno_switc=
htest driver )<br>
&gt; =A0 =A0 =A0uses rtdm_dev_xxx calls whereas<br>
<br>
</div>No, latency uses the timerbench driver. The fact that the device almo=
st<br>
has the same name is misleading and has been fixed in Xenomai 2.5<br>
current head too.<br>
<div class=3D"im"><br>
&gt; =A0- &#39;switchtest&#39; application uses the posix &#39;open&#39;/&#=
39;close&#39; system-calls<br>
&gt; =A0 =A0 for driver-interaction<br>
&gt;<br>
&gt; Looking at ksrc/drivers/testing/switchtest.c, i found that there is no=
<br>
&gt; registration<br>
&gt; of switchtest under linux-device-driver subsystem (even as a misc driv=
er<br>
&gt; like rtnet or rtheap do).<br>
<br>
</div>True. But there is a registration as an RTDM device.<br>
<div class=3D"im"><br>
&gt; Thus, there doesnt seem to be a way through which a linux-process (non=
-RT<br>
&gt; mode)<br>
&gt; may access xeno_switchtest driver through /dev/rttest&lt;x&gt;<br>
&gt; (or the new /dev/rttest-switchtst&lt;x&gt;<br>
&gt; =A0 ref: <a href=3D"https://mail.gna.org/public/xenomai-git/2010-04/ms=
g00073.html" target=3D"_blank">https://mail.gna.org/public/xenomai-git/2010=
-04/msg00073.html</a>).<br>
<br>
</div>No. It should work. The device is registered as an RTDM device, and t=
he<br>
switchtest application opens the same device using open, which is turned<br=
>
into the corresponding rtdm syscall by the posix skin.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; In case there is such a registration required, i would be more than wi=
lling<br>
&gt; to contribute.<br>
&gt;<br>
&gt; In case, the &#39;open&#39; system-call is handled by one of the skins=
<br>
&gt; =A0(i have native, posix,rtai and rtdm enabled in my kernel-config),<b=
r>
&gt; kindly point out the code and enlighten.<br>
&gt;<br>
&gt; Thanks for running this awesome project and all the help/pointers.<br>
<br>
</div>It works here, are you sure you enabled the switchtest driver?<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br></font></blockquote><div>=
<br>Thanks, Jan, Gilles, for very prompt responses.<br><br>I concur with yo=
ur comments on the posix call being <br>converted into RTDM call...<br>
An open in &#39;switchtest&#39; app directly goes to &#39;rtswitch_open&#39=
; in <br>the driver (instead of normal misc-dev open that i hooked into <br=
>xeno_switchtest driver code)<br>Will look more closely into the posix skin=
, as you suggest....<br>
<br>The error is during the ioctl &#39;RTTST_RTIOC_SWTEST_SET_TASK_COUNT&#3=
9;, <br>which fails as a &#39;Inappropriate ioctl for the driver&#39;... <b=
r>i will check the git-head, as you suggest.. and also my setup for any mis=
takes....<br>
<br>i confirmed again for &#39;XENO_DRIVERS_SWITCHTEST&#39; in kernel-confi=
g....<br>i enabled just this option (in loadable-module mode), so as not to=
 have conflicts <br>with other test-drivers....<br><br>Regarding the setup:=
<br>
=A0- Xenomai - 2.5.2 <br>=A0- linux-2.6.30.10<br>=A0- busybox 1.16<br>I am =
currently trying to validate my build and setup using a Qemu-emulation of <=
br>ARM-Versatile, ARM926EJS board.<br><br>Thanks once again....<br><br>Foll=
owing are my current kernel-config and output of xeno-test on my setup<br>
<br><br>Xeno-test output (mainly configuration info)<br>___________________=
_______________________________________________________<br>#=A0./xeno-test<=
br>xeno-test: started <br>withBusybox is 1<br>xeno-test: running tests<br>
<br>Thu Jan=A0 1 00:00:17 UTC 1970<br>running: ./xeno-config --verbose<br>x=
eno-config --verbose<br>=A0=A0=A0=A0=A0=A0=A0 --version=3D&quot;2.5.2&quot;=
<br>=A0=A0=A0=A0=A0=A0=A0 --cc=3D&quot;arm-linux-gcc&quot;<br>=A0=A0=A0=A0=
=A0=A0=A0 --arch=3D&quot;arm&quot;<br>=A0=A0=A0=A0=A0=A0=A0 --prefix=3D&quo=
t;/opt/xeno_utils&quot;<br>
=A0=A0=A0=A0=A0=A0=A0 --xeno-cflags=3D&quot;-I/opt/xeno_utils/include -D_GN=
U_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__&quot;<br>=A0=A0=A0=A0=A0=A0=A0=
 --xeno-ldflags=3D&quot;-L/opt/xeno_utils/lib -lxenomai -lpthread &quot;<br=
>=A0=A0=A0=A0=A0=A0=A0 --posix-cflags=3D&quot;&quot;<br>
=A0=A0=A0=A0=A0=A0=A0 --posix-ldflags=3D&quot;-Wl,@/opt/xeno_utils/lib/posi=
x.wrappers -L/opt/xeno_utils/lib -lpthread_rt -lxenomai -lpthread -lrt &quo=
t;<br>=A0=A0=A0=A0=A0=A0=A0 --library-dir=3D&quot;/opt/xeno_utils/lib&quot;=
<br><br>Thu Jan=A0 1 00:00:17 UTC 1970<br>
running: ./xeno-info<br>If some fields are empty or look unusual you may ha=
ve an old version.<br>Compare to the current minimal requirements in Docume=
ntation/Changes.<br>=A0<br>BusyBox v1.14.0 (2010-03-30 00:20:14 IST) multi-=
call binary<br>
Linux (none) 2.6.30.10-svn5 #11 Wed Apr 21 20:45:00 IST 2010 armv5tejl GNU/=
Linux<br>=A0<br>module-init-tools=A0=A0=A0=A0=A0 V<br>Modules Loaded=A0=A0=
=A0=A0=A0=A0=A0=A0 xeno_switchtest<br><br>Thu Jan=A0 1 00:00:18 UTC 1970<br=
>running: cat /proc/cpuinfo<br>
Processor=A0=A0=A0 : ARM926EJ-S rev 5 (v5l)<br>BogoMIPS=A0=A0=A0 : 2516.58<=
br>Features=A0=A0=A0 : swp half thumb fastmult edsp java <br>CPU implemente=
r=A0=A0=A0 : 0x41<br>CPU architecture: 5TEJ<br>CPU variant=A0=A0=A0 : 0x0<b=
r>CPU part=A0=A0=A0 : 0x926<br>CPU revision=A0=A0=A0 : 5<br>
<br>Hardware=A0=A0=A0 : ARM-IntegratorCP<br>Revision=A0=A0=A0 : 0000<br>Ser=
ial=A0=A0=A0 =A0=A0=A0 : 0000000000000000<br><br>Thu Jan=A0 1 00:00:18 UTC =
1970<br>running: md5sum /proc/cpuinfo # cpuinfo fingerprint<br>2c240fd8e74c=
0d710cb55ad874f6c11a=A0 /proc/cpuinfo<br>
# CONFIG_PREEMPT_RCU is not set<br># CONFIG_PREEMPT_RCU_TRACE is not set<br=
>CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH=3Dy<br>CONFIG_IPIPE=3Dy<br>CONFIG_IPI=
PE_DOMAINS=3D4<br>CONFIG_IPIPE_COMPAT=3Dy<br>CONFIG_IPIPE_DELAYED_ATOMICSW=
=3Dy<br>
# CONFIG_PREEMPT is not set<br># CONFIG_CPU_FREQ is not set<br># CONFIG_PM =
is not set<br>CONFIG_IPIPE_DEBUG=3Dy<br>CONFIG_IPIPE_DEBUG_CONTEXT=3Dy<br>C=
ONFIG_IPIPE_DEBUG_INTERNAL=3Dy<br>CONFIG_IPIPE_TRACE=3Dy<br>CONFIG_IPIPE_TR=
ACE_ENABLE=3Dy<br>
CONFIG_IPIPE_TRACE_MCOUNT=3Dy<br>CONFIG_IPIPE_TRACE_IRQSOFF=3Dy<br>CONFIG_I=
PIPE_TRACE_SHIFT=3D14<br>CONFIG_IPIPE_TRACE_VMALLOC=3Dy<br>CONFIG_IPIPE_TRA=
CE_PANIC=3Dy<br># CONFIG_DEBUG_SPINLOCK is not set<br># CONFIG_DEBUG_SPINLO=
CK_SLEEP is not set<br>
<br>Thu Jan=A0 1 00:00:18 UTC 1970<br>running: cat /proc/ipipe/Linux<br>=A0=
=A0=A0=A0=A0=A0 +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarde=
d)<br>=A0=A0=A0=A0=A0=A0 |+---- Sticky<br>=A0=A0=A0=A0=A0=A0 ||+--- Locked<=
br>=A0=A0=A0=A0=A0=A0 |||+-- Exclusive<br>=A0=A0=A0=A0=A0=A0 ||||+- Virtual=
<br>
[IRQ]=A0 |||||<br>=A0=A0 0:=A0 A....<br>=A0=A0 1:=A0 A....<br>=A0=A0 2:=A0 =
A....<br>=A0=A0 3:=A0 A....<br>=A0=A0 4:=A0 A....<br>=A0=A0 5:=A0 A....<br>=
=A0=A0 6:=A0 A....<br>=A0=A0 7:=A0 A....<br>=A0=A0 8:=A0 A....<br>=A0=A0 9:=
=A0 A....<br>=A0 10:=A0 A....<br>=A0 11:=A0 A....<br>=A0 12:=A0 A....<br>
=A0 13:=A0 A....<br>=A0 14:=A0 A....<br>=A0 15:=A0 A....<br>=A0 16:=A0 A...=
.<br>=A0 17:=A0 A....<br>=A0 18:=A0 A....<br>=A0 19:=A0 A....<br>=A0 20:=A0=
 A....<br>=A0 21:=A0 A....<br>=A0 22:=A0 A....<br>=A0 23:=A0 A....<br>=A0 2=
4:=A0 A....<br>=A0 25:=A0 A....<br>=A0 26:=A0 A....<br>
=A0 27:=A0 A....<br>=A0 28:=A0 A....<br>=A0 29:=A0 A....<br>=A0 30:=A0 A...=
.<br>=A0 31:=A0 A....<br>=A0 32:=A0 A....<br>=A0 33:=A0 A....<br>=A0 34:=A0=
 A....<br>=A0 35:=A0 A....<br>=A0 36:=A0 A....<br>=A0 37:=A0 A....<br>=A0 3=
8:=A0 A....<br>=A0 39:=A0 A....<br>=A0 40:=A0 A....<br>
=A0 41:=A0 A....<br>=A0 42:=A0 A....<br>=A0 43:=A0 A....<br>=A0 44:=A0 A...=
.<br>=A0 45:=A0 A....<br>=A0 46:=A0 A....<br>=A0 64:=A0 G...V<br>=A0 65:=A0=
 G...V<br>[Domain info]<br>id=3D0x00000000<br>priority=3D100<br><br>Thu Jan=
=A0 1 00:00:18 UTC 1970<br>running: cat /proc/ipipe/Xenomai<br>
=A0=A0=A0=A0=A0=A0 +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]isca=
rded)<br>=A0=A0=A0=A0=A0=A0 |+---- Sticky<br>=A0=A0=A0=A0=A0=A0 ||+--- Lock=
ed<br>=A0=A0=A0=A0=A0=A0 |||+-- Exclusive<br>=A0=A0=A0=A0=A0=A0 ||||+- Virt=
ual<br>[IRQ]=A0 |||||<br>=A0=A0 6:=A0 W..X.<br>=A0 66:=A0 W...V<br>[Domain =
info]<br>
id=3D0x58454e4f<br>priority=3Dtopmost<br><br>Thu Jan=A0 1 00:00:18 UTC 1970=
<br>running: cat /proc/ipipe/trace<br>cat: read error: Is a directory<br><b=
r>Thu Jan=A0 1 00:00:18 UTC 1970<br>running: cat /proc/ipipe/version<br>1.1=
5-01<br>
<br>Thu Jan=A0 1 00:00:18 UTC 1970<br>running: generate_loads 1<br>dd workl=
oad started, pids 532 stored in /var/lock/xeno-test.421.pids<br><br>Thu Jan=
=A0 1 00:00:18 UTC 1970<br>running: cat /proc/interrupts<br>=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 CPU0<br>
=A0 1:=A0=A0=A0=A0=A0=A0=A0 706=A0=A0=A0=A0=A0=A0=A0=A0 PIC=A0 uart-pl011<b=
r>=A0 4:=A0=A0=A0=A0=A0=A0=A0=A0 87=A0=A0=A0=A0=A0=A0=A0=A0 PIC=A0 kmi-pl05=
0<br>=A0 6:=A0=A0=A0=A0=A0=A0 1813=A0=A0=A0=A0=A0=A0=A0=A0 PIC=A0 Integrato=
r Timer Tick<br>=A027:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
 PIC=A0 eth0<br>Err:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0<br><br>Thu Jan=A0 1 00:00=
:18 UTC 1970<br>
running: cat /proc/loadavg<br>0.00 0.00 0.00 3/28 538<br><br>Thu Jan=A0 1 0=
0:00:18 UTC 1970<br>running: cat /proc/meminfo<br>MemTotal:=A0=A0=A0=A0=A0=
=A0=A0=A0 124844 kB<br>MemFree:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 96100 kB<br>B=
uffers:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 136 kB<br>Cached:=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 1860 kB<br>
SwapCached:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 kB<br>Active:=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 1284 kB<br>Inactive:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 10=
80 kB<br>Active(anon):=A0=A0=A0=A0=A0=A0=A0 372 kB<br>Inactive(anon):=A0=A0=
=A0=A0=A0=A0=A0 0 kB<br>Active(file):=A0=A0=A0=A0=A0=A0=A0 912 kB<br>Inacti=
ve(file):=A0=A0=A0=A0 1080 kB<br>Unevictable:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 0 kB<br>
Mlocked:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 kB<br>SwapTotal:=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 kB<br>SwapFree:=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0 kB<br>Dirty:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 36=
 kB<br>Writeback:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 kB<br>AnonPages:=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 396 kB<br>Mapped:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 520 kB<br>Slab:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1776 kB=
<br>
SReclaimable:=A0=A0=A0=A0=A0=A0=A0 832 kB<br>SUnreclaim:=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 944 kB<br>PageTables:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 80 kB<br>NFS_=
Unstable:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 kB<br>Bounce:=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0 kB<br>WritebackTmp:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
 kB<br>CommitLimit:=A0=A0=A0=A0=A0=A0 62420 kB<br>Committed_AS:=A0=A0=A0=A0=
=A0=A0 1972 kB<br>
VmallocTotal:=A0=A0=A0=A0 122880 kB<br>VmallocUsed:=A0=A0=A0=A0=A0=A0=A0 22=
32 kB<br>VmallocChunk:=A0=A0=A0=A0 120432 kB<br><br>Thu Jan=A0 1 00:00:18 U=
TC 1970<br>running: cat /proc/xenomai/acct<br>0 0 0 0 0 00500080 1919674400=
0 501802000 501802000 ROOT<br>
0 0 0 1790 0 00000000 19196744000 18693191000 18693191000 IRQ6: [timer]<br>=
<br>Thu Jan=A0 1 00:00:18 UTC 1970<br>running: cat /proc/xenomai/apc<br>APC=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 CPU0<br>=A0 0:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 0=A0=A0=A0 (pipe_wakeup)<br>=A0 1:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=
=A0=A0 (xnselectors_destroy)<br>
=A0 2:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (lostage_handler)<br>=A0=
 3:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (registry_export)<br>=A0 4:=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (pse51_lostage_handler)<br><br=
>Thu Jan=A0 1 00:00:18 UTC 1970<br>running: cat /proc/xenomai/faults<br>TRA=
P=A0=A0=A0=A0=A0=A0=A0=A0 CPU0<br>
=A0 0:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (Data or instruction acc=
ess)<br>=A0 1:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (Section fault)<=
br>=A0 2:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (Generic data abort)<=
br>=A0 3:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (Unknown exception)<b=
r>=A0 4:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (Instruction breakpoin=
t)<br>
=A0 5:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (Floating point exceptio=
n)<br>=A0 6:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (VFP Floating poin=
t exception)<br>=A0 7:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (Undefin=
ed instruction)<br>=A0 8:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (Unal=
igned access exception)<br><br>Thu Jan=A0 1 00:00:18 UTC 1970<br>
running: cat /proc/xenomai/hal<br>1.15-01<br><br>Thu Jan=A0 1 00:00:18 UTC =
1970<br>running: cat /proc/xenomai/heap<br>size=3D8192:used=3D8:pagesz=3D40=
96=A0 (global sem heap)<br>size=3D259584:used=3D96:pagesz=3D512=A0 (main he=
ap)<br>size=3D129536:used=3D0:pagesz=3D512=A0 (stack pool)<br>
<br>Thu Jan=A0 1 00:00:18 UTC 1970<br>running: cat /proc/xenomai/irq<br>IRQ=
=A0=A0=A0=A0=A0=A0=A0=A0 CPU0<br>=A0 6:=A0=A0=A0=A0=A0=A0=A0 1796=A0=A0=A0=
=A0=A0=A0=A0=A0 [timer]<br>=A066:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0 [virtual]<br><br>Thu Jan=A0 1 00:00:18 UTC 1970<br>running:=
 cat /proc/xenomai/latency<br>
10000<br><br>Thu Jan=A0 1 00:00:18 UTC 1970<br>running: cat /proc/xenomai/l=
ock<br>CPU0:<br>=A0 longest locked section: 18446744073644064616 ns<br>=A0 =
spinning time: 1000 ns<br>=A0 section entry: kernel/xenomai/nucleus/registr=
y.c:160 (xnregistry_init)<br>
<br>Mem: 28924K used, 95920K free, 0K shrd, 136K buff, 1908K cached<br>CPU:=
 18.7% usr 81.2% sys=A0 0.0% nic=A0 0.0% idle=A0 0.0% io=A0 0.0% irq=A0 0.0=
% sirq<br>Load average: 0.00 0.00 0.00 2/30 618<br><br>____________________=
______________________________________________________<br>
<br>Kernel-config:<br>_____________________________________________________=
____________________________________<br>#<br># Automatically generated make=
 config: don&#39;t edit<br># Linux kernel version: 2.6.30.10<br># Wed Apr 2=
1 17:06:02 2010<br>
#<br>CONFIG_ARM=3Dy<br>CONFIG_SYS_SUPPORTS_APM_EMULATION=3Dy<br># CONFIG_GE=
NERIC_GPIO is not set<br># CONFIG_GENERIC_TIME is not set<br># CONFIG_GENER=
IC_CLOCKEVENTS is not set<br>CONFIG_MMU=3Dy<br># CONFIG_NO_IOPORT is not se=
t<br>
CONFIG_GENERIC_HARDIRQS=3Dy<br>CONFIG_STACKTRACE_SUPPORT=3Dy<br>CONFIG_HAVE=
_LATENCYTOP_SUPPORT=3Dy<br>CONFIG_LOCKDEP_SUPPORT=3Dy<br>CONFIG_TRACE_IRQFL=
AGS_SUPPORT=3Dy<br>CONFIG_HARDIRQS_SW_RESEND=3Dy<br>CONFIG_GENERIC_IRQ_PROB=
E=3Dy<br>CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy<br>
# CONFIG_ARCH_HAS_ILOG2_U32 is not set<br># CONFIG_ARCH_HAS_ILOG2_U64 is no=
t set<br>CONFIG_GENERIC_HWEIGHT=3Dy<br>CONFIG_GENERIC_CALIBRATE_DELAY=3Dy<b=
r>CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=3Dy<br>CONFIG_VECTORS_BASE=3D0xffff000=
0<br>
CONFIG_DEFCONFIG_LIST=3D&quot;/lib/modules/$UNAME_RELEASE/.config&quot;<br>=
<br>#<br># General setup<br>#<br>CONFIG_EXPERIMENTAL=3Dy<br>CONFIG_BROKEN_O=
N_SMP=3Dy<br>CONFIG_INIT_ENV_ARG_LIMIT=3D32<br>CONFIG_LOCALVERSION=3D&quot;=
&quot;<br>
CONFIG_LOCALVERSION_AUTO=3Dy<br>CONFIG_SWAP=3Dy<br>CONFIG_SYSVIPC=3Dy<br>CO=
NFIG_SYSVIPC_SYSCTL=3Dy<br># CONFIG_POSIX_MQUEUE is not set<br># CONFIG_BSD=
_PROCESS_ACCT is not set<br># CONFIG_TASKSTATS is not set<br># CONFIG_AUDIT=
 is not set<br>
<br>#<br># RCU Subsystem<br>#<br>CONFIG_CLASSIC_RCU=3Dy<br># CONFIG_TREE_RC=
U is not set<br># CONFIG_PREEMPT_RCU is not set<br># CONFIG_TREE_RCU_TRACE =
is not set<br># CONFIG_PREEMPT_RCU_TRACE is not set<br>CONFIG_IKCONFIG=3Dy<=
br>
CONFIG_IKCONFIG_PROC=3Dy<br>CONFIG_LOG_BUF_SHIFT=3D14<br># CONFIG_GROUP_SCH=
ED is not set<br># CONFIG_CGROUPS is not set<br>CONFIG_SYSFS_DEPRECATED=3Dy=
<br>CONFIG_SYSFS_DEPRECATED_V2=3Dy<br># CONFIG_RELAY is not set<br>CONFIG_N=
AMESPACES=3Dy<br>
# CONFIG_UTS_NS is not set<br># CONFIG_IPC_NS is not set<br># CONFIG_USER_N=
S is not set<br># CONFIG_PID_NS is not set<br># CONFIG_NET_NS is not set<br=
>CONFIG_BLK_DEV_INITRD=3Dy<br>CONFIG_INITRAMFS_SOURCE=3D&quot;&quot;<br>CON=
FIG_RD_GZIP=3Dy<br>
CONFIG_RD_BZIP2=3Dy<br>CONFIG_RD_LZMA=3Dy<br>CONFIG_CC_OPTIMIZE_FOR_SIZE=3D=
y<br>CONFIG_SYSCTL=3Dy<br>CONFIG_ANON_INODES=3Dy<br># CONFIG_EMBEDDED is no=
t set<br>CONFIG_UID16=3Dy<br>CONFIG_SYSCTL_SYSCALL=3Dy<br>CONFIG_KALLSYMS=
=3Dy<br># CONFIG_KALLSYMS_ALL is not set<br>
# CONFIG_KALLSYMS_EXTRA_PASS is not set<br># CONFIG_STRIP_ASM_SYMS is not s=
et<br>CONFIG_HOTPLUG=3Dy<br>CONFIG_PRINTK=3Dy<br>CONFIG_BUG=3Dy<br>CONFIG_E=
LF_CORE=3Dy<br>CONFIG_BASE_FULL=3Dy<br>CONFIG_FUTEX=3Dy<br>CONFIG_EPOLL=3Dy=
<br>CONFIG_SIGNALFD=3Dy<br>
CONFIG_TIMERFD=3Dy<br>CONFIG_EVENTFD=3Dy<br>CONFIG_SHMEM=3Dy<br>CONFIG_AIO=
=3Dy<br>CONFIG_VM_EVENT_COUNTERS=3Dy<br>CONFIG_SLUB_DEBUG=3Dy<br>CONFIG_COM=
PAT_BRK=3Dy<br># CONFIG_SLAB is not set<br>CONFIG_SLUB=3Dy<br># CONFIG_SLOB=
 is not set<br>
# CONFIG_PROFILING is not set<br>CONFIG_TRACEPOINTS=3Dy<br>CONFIG_MARKERS=
=3Dy<br>CONFIG_HAVE_OPROFILE=3Dy<br># CONFIG_KPROBES is not set<br>CONFIG_H=
AVE_KPROBES=3Dy<br>CONFIG_HAVE_KRETPROBES=3Dy<br>CONFIG_HAVE_CLK=3Dy<br>CON=
FIG_SLOW_WORK=3Dy<br>
CONFIG_HAVE_GENERIC_DMA_COHERENT=3Dy<br>CONFIG_SLABINFO=3Dy<br>CONFIG_RT_MU=
TEXES=3Dy<br>CONFIG_BASE_SMALL=3D0<br>CONFIG_MODULES=3Dy<br># CONFIG_MODULE=
_FORCE_LOAD is not set<br>CONFIG_MODULE_UNLOAD=3Dy<br># CONFIG_MODULE_FORCE=
_UNLOAD is not set<br>
# CONFIG_MODVERSIONS is not set<br># CONFIG_MODULE_SRCVERSION_ALL is not se=
t<br>CONFIG_BLOCK=3Dy<br># CONFIG_LBD is not set<br># CONFIG_BLK_DEV_BSG is=
 not set<br># CONFIG_BLK_DEV_INTEGRITY is not set<br><br>#<br># IO Schedule=
rs<br>
#<br>CONFIG_IOSCHED_NOOP=3Dy<br>CONFIG_IOSCHED_AS=3Dy<br>CONFIG_IOSCHED_DEA=
DLINE=3Dy<br>CONFIG_IOSCHED_CFQ=3Dy<br># CONFIG_DEFAULT_AS is not set<br># =
CONFIG_DEFAULT_DEADLINE is not set<br>CONFIG_DEFAULT_CFQ=3Dy<br># CONFIG_DE=
FAULT_NOOP is not set<br>
CONFIG_DEFAULT_IOSCHED=3D&quot;cfq&quot;<br><br>#<br># Real-time sub-system=
<br>#<br>CONFIG_XENOMAI=3Dy<br>CONFIG_XENO_GENERIC_STACKPOOL=3Dy<br>CONFIG_=
XENO_FASTSYNCH_DEP=3Dy<br>CONFIG_XENO_FASTSYNCH=3Dy<br>CONFIG_XENO_OPT_NUCL=
EUS=3Dy<br>
CONFIG_XENO_OPT_PERVASIVE=3Dy<br>CONFIG_XENO_OPT_PRIOCPL=3Dy<br>CONFIG_XENO=
_OPT_PIPELINE_HEAD=3Dy<br># CONFIG_XENO_OPT_SCHED_CLASSES is not set<br>CON=
FIG_XENO_OPT_PIPE=3Dy<br>CONFIG_XENO_OPT_PIPE_NRDEV=3D32<br>CONFIG_XENO_OPT=
_REGISTRY_NRSLOTS=3D512<br>
CONFIG_XENO_OPT_SYS_HEAPSZ=3D256<br>CONFIG_XENO_OPT_SYS_STACKPOOLSZ=3D128<b=
r>CONFIG_XENO_OPT_SEM_HEAPSZ=3D12<br>CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ=3D12=
<br>CONFIG_XENO_OPT_STATS=3Dy<br>CONFIG_XENO_OPT_DEBUG=3Dy<br>CONFIG_XENO_O=
PT_DEBUG_NUCLEUS=3Dy<br>
CONFIG_XENO_OPT_DEBUG_XNLOCK=3Dy<br>CONFIG_XENO_OPT_DEBUG_QUEUES=3Dy<br>CON=
FIG_XENO_OPT_DEBUG_REGISTRY=3Dy<br>CONFIG_XENO_OPT_DEBUG_TIMERS=3Dy<br>CONF=
IG_XENO_OPT_DEBUG_SYNCH_RELAX=3Dy<br>CONFIG_XENO_OPT_WATCHDOG=3Dy<br>CONFIG=
_XENO_OPT_WATCHDOG_TIMEOUT=3D4<br>
# CONFIG_XENO_OPT_SHIRQ is not set<br>CONFIG_XENO_OPT_SELECT=3Dy<br><br>#<b=
r># Timing<br>#<br>CONFIG_XENO_OPT_TIMING_PERIODIC=3Dy<br>CONFIG_XENO_OPT_T=
IMING_VIRTICK=3D1000<br>CONFIG_XENO_OPT_TIMING_SCHEDLAT=3D0<br><br>#<br># S=
calability<br>
#<br># CONFIG_XENO_OPT_SCALABLE_SCHED is not set<br>CONFIG_XENO_OPT_TIMER_L=
IST=3Dy<br># CONFIG_XENO_OPT_TIMER_HEAP is not set<br># CONFIG_XENO_OPT_TIM=
ER_WHEEL is not set<br><br>#<br># Machine<br>#<br>CONFIG_IPIPE_WANT_PREEMPT=
IBLE_SWITCH=3Dy<br>
CONFIG_XENO_HW_FPU=3Dy<br>CONFIG_XENO_HW_UNLOCKED_SWITCH=3Dy<br><br>#<br># =
Interfaces<br>#<br>CONFIG_XENO_SKIN_NATIVE=3Dy<br>CONFIG_XENO_OPT_NATIVE_PE=
RIOD=3D0<br>CONFIG_XENO_OPT_NATIVE_PIPE=3Dy<br>CONFIG_XENO_OPT_NATIVE_PIPE_=
BUFSZ=3D1024<br>
CONFIG_XENO_OPT_NATIVE_SEM=3Dy<br>CONFIG_XENO_OPT_NATIVE_EVENT=3Dy<br>CONFI=
G_XENO_OPT_NATIVE_MUTEX=3Dy<br>CONFIG_XENO_OPT_NATIVE_COND=3Dy<br>CONFIG_XE=
NO_OPT_NATIVE_QUEUE=3Dy<br>CONFIG_XENO_OPT_NATIVE_BUFFER=3Dy<br>CONFIG_XENO=
_OPT_NATIVE_HEAP=3Dy<br>
CONFIG_XENO_OPT_NATIVE_ALARM=3Dy<br>CONFIG_XENO_OPT_NATIVE_MPS=3Dy<br># CON=
FIG_XENO_OPT_NATIVE_INTR is not set<br>CONFIG_XENO_OPT_DEBUG_NATIVE=3Dy<br>=
CONFIG_XENO_SKIN_POSIX=3Dy<br>CONFIG_XENO_OPT_POSIX_PERIOD=3D0<br>CONFIG_XE=
NO_OPT_POSIX_SHM=3Dy<br>
CONFIG_XENO_OPT_POSIX_INTR=3Dy<br>CONFIG_XENO_OPT_POSIX_SELECT=3Dy<br>CONFI=
G_XENO_OPT_DEBUG_POSIX=3Dy<br># CONFIG_XENO_SKIN_PSOS is not set<br># CONFI=
G_XENO_SKIN_UITRON is not set<br># CONFIG_XENO_SKIN_VRTX is not set<br># CO=
NFIG_XENO_SKIN_VXWORKS is not set<br>
CONFIG_XENO_SKIN_RTAI=3Dy<br>CONFIG_XENO_OPT_RTAI_PERIOD=3D0<br>CONFIG_XENO=
_OPT_RTAI_FIFO=3Dy<br>CONFIG_XENO_OPT_RTAI_SEM=3Dy<br>CONFIG_XENO_OPT_RTAI_=
SHM=3Dy<br># CONFIG_XENO_OPT_NOWARN_DEPRECATED is not set<br>CONFIG_XENO_SK=
IN_RTDM=3Dy<br>
CONFIG_XENO_OPT_RTDM_PERIOD=3D0<br>CONFIG_XENO_OPT_RTDM_FILDES=3D128<br>CON=
FIG_XENO_OPT_RTDM_SELECT=3Dy<br>CONFIG_XENO_OPT_DEBUG_RTDM=3Dy<br>CONFIG_XE=
NO_OPT_DEBUG_RTDM_APPL=3Dy<br><br>#<br># Drivers<br>#<br><br>#<br># Serial =
drivers<br>
#<br># CONFIG_XENO_DRIVERS_16550A is not set<br><br>#<br># Testing drivers<=
br>#<br>CONFIG_XENO_TESTING_MODULE=3Dm<br># CONFIG_XENO_DRIVERS_TIMERBENCH =
is not set<br># CONFIG_XENO_DRIVERS_IRQBENCH is not set<br>CONFIG_XENO_DRIV=
ERS_SWITCHTEST=3Dm<br>
# CONFIG_XENO_DRIVERS_SIGTEST is not set<br><br>#<br># CAN drivers<br>#<br>=
# CONFIG_XENO_DRIVERS_CAN is not set<br><br>#<br># ANALOGY drivers<br>#<br>=
# CONFIG_XENO_DRIVERS_ANALOGY is not set<br><br>#<br># Real-time IPC driver=
s<br>
#<br># CONFIG_XENO_DRIVERS_RTIPC is not set<br># CONFIG_FREEZER is not set<=
br><br>#<br># System Type<br>#<br># CONFIG_ARCH_AAEC2000 is not set<br>CONF=
IG_ARCH_INTEGRATOR=3Dy<br># CONFIG_ARCH_REALVIEW is not set<br># CONFIG_ARC=
H_VERSATILE is not set<br>
# CONFIG_ARCH_AT91 is not set<br># CONFIG_ARCH_CLPS711X is not set<br># CON=
FIG_ARCH_EBSA110 is not set<br># CONFIG_ARCH_EP93XX is not set<br># CONFIG_=
ARCH_GEMINI is not set<br># CONFIG_ARCH_FOOTBRIDGE is not set<br># CONFIG_A=
RCH_NETX is not set<br>
# CONFIG_ARCH_H720X is not set<br># CONFIG_ARCH_IMX is not set<br># CONFIG_=
ARCH_IOP13XX is not set<br># CONFIG_ARCH_IOP32X is not set<br># CONFIG_ARCH=
_IOP33X is not set<br># CONFIG_ARCH_IXP23XX is not set<br># CONFIG_ARCH_IXP=
2000 is not set<br>
# CONFIG_ARCH_IXP4XX is not set<br># CONFIG_ARCH_L7200 is not set<br># CONF=
IG_ARCH_KIRKWOOD is not set<br># CONFIG_ARCH_KS8695 is not set<br># CONFIG_=
ARCH_NS9XXX is not set<br># CONFIG_ARCH_LOKI is not set<br># CONFIG_ARCH_MV=
78XX0 is not set<br>
# CONFIG_ARCH_MXC is not set<br># CONFIG_ARCH_ORION5X is not set<br># CONFI=
G_ARCH_PNX4008 is not set<br># CONFIG_ARCH_PXA is not set<br># CONFIG_ARCH_=
MMP is not set<br># CONFIG_ARCH_RPC is not set<br># CONFIG_ARCH_SA1100 is n=
ot set<br>
# CONFIG_ARCH_S3C2410 is not set<br># CONFIG_ARCH_S3C64XX is not set<br># C=
ONFIG_ARCH_SHARK is not set<br># CONFIG_ARCH_LH7A40X is not set<br># CONFIG=
_ARCH_DAVINCI is not set<br># CONFIG_ARCH_OMAP is not set<br># CONFIG_ARCH_=
MSM is not set<br>
# CONFIG_ARCH_W90X900 is not set<br><br>#<br># Integrator Options<br>#<br>#=
 CONFIG_ARCH_INTEGRATOR_AP is not set<br>CONFIG_ARCH_INTEGRATOR_CP=3Dy<br>C=
ONFIG_ARCH_CINTEGRATOR=3Dy<br><br>#<br># Processor Type<br>#<br>CONFIG_CPU_=
32=3Dy<br>
# CONFIG_CPU_ARM720T is not set<br># CONFIG_CPU_ARM920T is not set<br># CON=
FIG_CPU_ARM922T is not set<br>CONFIG_CPU_ARM926T=3Dy<br># CONFIG_CPU_ARM102=
0 is not set<br># CONFIG_CPU_ARM1022 is not set<br># CONFIG_CPU_ARM1026 is =
not set<br>
# CONFIG_CPU_V6 is not set<br># CONFIG_CPU_V7 is not set<br>CONFIG_CPU_32v5=
=3Dy<br>CONFIG_CPU_ABRT_EV5TJ=3Dy<br>CONFIG_CPU_PABRT_NOIFAR=3Dy<br>CONFIG_=
CPU_CACHE_VIVT=3Dy<br>CONFIG_CPU_COPY_V4WB=3Dy<br>CONFIG_CPU_TLB_V4WBI=3Dy<=
br>CONFIG_CPU_CP15=3Dy<br>
CONFIG_CPU_CP15_MMU=3Dy<br><br>#<br># Processor Features<br>#<br>CONFIG_ARM=
_THUMB=3Dy<br># CONFIG_CPU_ICACHE_DISABLE is not set<br># CONFIG_CPU_DCACHE=
_DISABLE is not set<br># CONFIG_CPU_DCACHE_WRITETHROUGH is not set<br># CON=
FIG_CPU_CACHE_ROUND_ROBIN is not set<br>
# CONFIG_OUTER_CACHE is not set<br># CONFIG_ARM_FCSE is not set<br>CONFIG_I=
CST525=3Dy<br>CONFIG_COMMON_CLKDEV=3Dy<br><br>#<br># Bus support<br>#<br>CO=
NFIG_ARM_AMBA=3Dy<br># CONFIG_PCI_SYSCALL is not set<br># CONFIG_ARCH_SUPPO=
RTS_MSI is not set<br>
CONFIG_PCCARD=3Dy<br># CONFIG_PCMCIA_DEBUG is not set<br>CONFIG_PCMCIA=3Dy<=
br>CONFIG_PCMCIA_LOAD_CIS=3Dy<br>CONFIG_PCMCIA_IOCTL=3Dy<br><br>#<br># PC-c=
ard bridges<br>#<br><br>#<br># Kernel Features<br>#<br>CONFIG_VMSPLIT_3G=3D=
y<br># CONFIG_VMSPLIT_2G is not set<br>
# CONFIG_VMSPLIT_1G is not set<br>CONFIG_PAGE_OFFSET=3D0xC0000000<br>CONFIG=
_IPIPE=3Dy<br>CONFIG_IPIPE_DOMAINS=3D4<br>CONFIG_IPIPE_COMPAT=3Dy<br>CONFIG=
_IPIPE_DELAYED_ATOMICSW=3Dy<br># CONFIG_PREEMPT is not set<br>CONFIG_HZ=3D1=
00<br>CONFIG_AEABI=3Dy<br>
CONFIG_OABI_COMPAT=3Dy<br># CONFIG_ARCH_HAS_HOLES_MEMORYMODEL is not set<br=
># CONFIG_ARCH_SPARSEMEM_DEFAULT is not set<br># CONFIG_ARCH_SELECT_MEMORY_=
MODEL is not set<br># CONFIG_HIGHMEM is not set<br>CONFIG_SELECT_MEMORY_MOD=
EL=3Dy<br>
CONFIG_FLATMEM_MANUAL=3Dy<br># CONFIG_DISCONTIGMEM_MANUAL is not set<br># C=
ONFIG_SPARSEMEM_MANUAL is not set<br>CONFIG_FLATMEM=3Dy<br>CONFIG_FLAT_NODE=
_MEM_MAP=3Dy<br>CONFIG_PAGEFLAGS_EXTENDED=3Dy<br>CONFIG_SPLIT_PTLOCK_CPUS=
=3D4096<br>
# CONFIG_PHYS_ADDR_T_64BIT is not set<br>CONFIG_ZONE_DMA_FLAG=3D0<br>CONFIG=
_VIRT_TO_BUS=3Dy<br>CONFIG_UNEVICTABLE_LRU=3Dy<br>CONFIG_HAVE_MLOCK=3Dy<br>=
CONFIG_HAVE_MLOCKED_PAGE_BIT=3Dy<br>CONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096<br>=
CONFIG_LEDS=3Dy<br>
CONFIG_LEDS_TIMER=3Dy<br>CONFIG_LEDS_CPU=3Dy<br>CONFIG_ALIGNMENT_TRAP=3Dy<b=
r><br>#<br># Boot options<br>#<br>CONFIG_ZBOOT_ROM_TEXT=3D0x0<br>CONFIG_ZBO=
OT_ROM_BSS=3D0x0<br>CONFIG_CMDLINE=3D&quot;&quot;<br># CONFIG_XIP_KERNEL is=
 not set<br>
# CONFIG_KEXEC is not set<br><br>#<br># CPU Power Management<br>#<br># CONF=
IG_CPU_FREQ is not set<br># CONFIG_CPU_IDLE is not set<br><br>#<br># Floati=
ng point emulation<br>#<br><br>#<br># At least one emulation must be select=
ed<br>
#<br>CONFIG_FPE_NWFPE=3Dy<br># CONFIG_FPE_NWFPE_XP is not set<br># CONFIG_F=
PE_FASTFPE is not set<br># CONFIG_VFP is not set<br><br>#<br># Userspace bi=
nary formats<br>#<br>CONFIG_BINFMT_ELF=3Dy<br># CONFIG_CORE_DUMP_DEFAULT_EL=
F_HEADERS is not set<br>
CONFIG_HAVE_AOUT=3Dy<br># CONFIG_BINFMT_AOUT is not set<br>CONFIG_BINFMT_MI=
SC=3Dy<br><br>#<br># Power management options<br>#<br># CONFIG_PM is not se=
t<br>CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy<br>CONFIG_NET=3Dy<br><br>#<br># Netwo=
rking options<br>
#<br>CONFIG_PACKET=3Dy<br>CONFIG_PACKET_MMAP=3Dy<br>CONFIG_UNIX=3Dy<br>CONF=
IG_XFRM=3Dy<br># CONFIG_XFRM_USER is not set<br># CONFIG_XFRM_SUB_POLICY is=
 not set<br># CONFIG_XFRM_MIGRATE is not set<br># CONFIG_XFRM_STATISTICS is=
 not set<br>
# CONFIG_NET_KEY is not set<br>CONFIG_INET=3Dy<br>CONFIG_IP_MULTICAST=3Dy<b=
r># CONFIG_IP_ADVANCED_ROUTER is not set<br>CONFIG_IP_FIB_HASH=3Dy<br>CONFI=
G_IP_PNP=3Dy<br>CONFIG_IP_PNP_DHCP=3Dy<br>CONFIG_IP_PNP_BOOTP=3Dy<br># CONF=
IG_IP_PNP_RARP is not set<br>
CONFIG_NET_IPIP=3Dy<br># CONFIG_NET_IPGRE is not set<br># CONFIG_IP_MROUTE =
is not set<br># CONFIG_ARPD is not set<br># CONFIG_SYN_COOKIES is not set<b=
r># CONFIG_INET_AH is not set<br># CONFIG_INET_ESP is not set<br># CONFIG_I=
NET_IPCOMP is not set<br>
# CONFIG_INET_XFRM_TUNNEL is not set<br>CONFIG_INET_TUNNEL=3Dy<br>CONFIG_IN=
ET_XFRM_MODE_TRANSPORT=3Dy<br>CONFIG_INET_XFRM_MODE_TUNNEL=3Dy<br>CONFIG_IN=
ET_XFRM_MODE_BEET=3Dy<br>CONFIG_INET_LRO=3Dy<br>CONFIG_INET_DIAG=3Dy<br>CON=
FIG_INET_TCP_DIAG=3Dy<br>
# CONFIG_TCP_CONG_ADVANCED is not set<br>CONFIG_TCP_CONG_CUBIC=3Dy<br>CONFI=
G_DEFAULT_TCP_CONG=3D&quot;cubic&quot;<br># CONFIG_TCP_MD5SIG is not set<br=
># CONFIG_IPV6 is not set<br># CONFIG_NETWORK_SECMARK is not set<br># CONFI=
G_NETFILTER is not set<br>
# CONFIG_IP_DCCP is not set<br># CONFIG_IP_SCTP is not set<br># CONFIG_TIPC=
 is not set<br># CONFIG_ATM is not set<br># CONFIG_BRIDGE is not set<br># C=
ONFIG_NET_DSA is not set<br># CONFIG_VLAN_8021Q is not set<br># CONFIG_DECN=
ET is not set<br>
# CONFIG_LLC2 is not set<br># CONFIG_IPX is not set<br># CONFIG_ATALK is no=
t set<br># CONFIG_X25 is not set<br># CONFIG_LAPB is not set<br># CONFIG_EC=
ONET is not set<br># CONFIG_WAN_ROUTER is not set<br># CONFIG_PHONET is not=
 set<br>
# CONFIG_NET_SCHED is not set<br># CONFIG_DCB is not set<br><br>#<br># Netw=
ork testing<br>#<br># CONFIG_NET_PKTGEN is not set<br># CONFIG_NET_DROP_MON=
ITOR is not set<br># CONFIG_HAMRADIO is not set<br># CONFIG_CAN is not set<=
br>
# CONFIG_IRDA is not set<br># CONFIG_BT is not set<br># CONFIG_AF_RXRPC is =
not set<br># CONFIG_WIRELESS is not set<br># CONFIG_WIMAX is not set<br># C=
ONFIG_RFKILL is not set<br># CONFIG_NET_9P is not set<br><br>#<br># Device =
Drivers<br>
#<br><br>#<br># Generic Driver Options<br>#<br>CONFIG_UEVENT_HELPER_PATH=3D=
&quot;/sbin/hotplug&quot;<br>CONFIG_STANDALONE=3Dy<br>CONFIG_PREVENT_FIRMWA=
RE_BUILD=3Dy<br>CONFIG_FW_LOADER=3Dy<br>CONFIG_FIRMWARE_IN_KERNEL=3Dy<br>CO=
NFIG_EXTRA_FIRMWARE=3D&quot;&quot;<br>
# CONFIG_DEBUG_DRIVER is not set<br># CONFIG_DEBUG_DEVRES is not set<br># C=
ONFIG_SYS_HYPERVISOR is not set<br># CONFIG_CONNECTOR is not set<br>CONFIG_=
MTD=3Dy<br># CONFIG_MTD_DEBUG is not set<br># CONFIG_MTD_CONCAT is not set<=
br>
CONFIG_MTD_PARTITIONS=3Dy<br># CONFIG_MTD_TESTS is not set<br># CONFIG_MTD_=
REDBOOT_PARTS is not set<br>CONFIG_MTD_CMDLINE_PARTS=3Dy<br>CONFIG_MTD_AFS_=
PARTS=3Dy<br># CONFIG_MTD_AR7_PARTS is not set<br><br>#<br># User Modules A=
nd Translation Layers<br>
#<br>CONFIG_MTD_CHAR=3Dy<br>CONFIG_MTD_BLKDEVS=3Dy<br>CONFIG_MTD_BLOCK=3Dy<=
br># CONFIG_FTL is not set<br># CONFIG_NFTL is not set<br># CONFIG_INFTL is=
 not set<br># CONFIG_RFD_FTL is not set<br># CONFIG_SSFDC is not set<br># C=
ONFIG_MTD_OOPS is not set<br>
<br>#<br># RAM/ROM/Flash chip drivers<br>#<br>CONFIG_MTD_CFI=3Dy<br># CONFI=
G_MTD_JEDECPROBE is not set<br>CONFIG_MTD_GEN_PROBE=3Dy<br>CONFIG_MTD_CFI_A=
DV_OPTIONS=3Dy<br>CONFIG_MTD_CFI_NOSWAP=3Dy<br># CONFIG_MTD_CFI_BE_BYTE_SWA=
P is not set<br>
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set<br># CONFIG_MTD_CFI_GEOMETRY is no=
t set<br>CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy<br>CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy=
<br>CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy<br># CONFIG_MTD_MAP_BANK_WIDTH_8 is not=
 set<br>
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set<br># CONFIG_MTD_MAP_BANK_WIDTH_32=
 is not set<br>CONFIG_MTD_CFI_I1=3Dy<br>CONFIG_MTD_CFI_I2=3Dy<br># CONFIG_M=
TD_CFI_I4 is not set<br># CONFIG_MTD_CFI_I8 is not set<br># CONFIG_MTD_OTP =
is not set<br>
CONFIG_MTD_CFI_INTELEXT=3Dy<br># CONFIG_MTD_CFI_AMDSTD is not set<br># CONF=
IG_MTD_CFI_STAA is not set<br>CONFIG_MTD_CFI_UTIL=3Dy<br># CONFIG_MTD_RAM i=
s not set<br># CONFIG_MTD_ROM is not set<br># CONFIG_MTD_ABSENT is not set<=
br>
<br>#<br># Mapping drivers for chip access<br>#<br># CONFIG_MTD_COMPLEX_MAP=
PINGS is not set<br># CONFIG_MTD_PHYSMAP is not set<br># CONFIG_MTD_ARM_INT=
EGRATOR is not set<br># CONFIG_MTD_PLATRAM is not set<br><br>#<br># Self-co=
ntained MTD device drivers<br>
#<br># CONFIG_MTD_SLRAM is not set<br># CONFIG_MTD_PHRAM is not set<br># CO=
NFIG_MTD_MTDRAM is not set<br># CONFIG_MTD_BLOCK2MTD is not set<br><br>#<br=
># Disk-On-Chip Device Drivers<br>#<br># CONFIG_MTD_DOC2000 is not set<br>
# CONFIG_MTD_DOC2001 is not set<br># CONFIG_MTD_DOC2001PLUS is not set<br>#=
 CONFIG_MTD_NAND is not set<br># CONFIG_MTD_ONENAND is not set<br><br>#<br>=
# LPDDR flash memory drivers<br>#<br># CONFIG_MTD_LPDDR is not set<br><br>
#<br># UBI - Unsorted block images<br>#<br># CONFIG_MTD_UBI is not set<br>#=
 CONFIG_PARPORT is not set<br>CONFIG_BLK_DEV=3Dy<br># CONFIG_BLK_DEV_COW_CO=
MMON is not set<br>CONFIG_BLK_DEV_LOOP=3Dy<br># CONFIG_BLK_DEV_CRYPTOLOOP i=
s not set<br>
# CONFIG_BLK_DEV_NBD is not set<br>CONFIG_BLK_DEV_RAM=3Dy<br>CONFIG_BLK_DEV=
_RAM_COUNT=3D16<br>CONFIG_BLK_DEV_RAM_SIZE=3D20480<br># CONFIG_BLK_DEV_XIP =
is not set<br># CONFIG_CDROM_PKTCDVD is not set<br># CONFIG_ATA_OVER_ETH is=
 not set<br>
CONFIG_MISC_DEVICES=3Dy<br># CONFIG_ENCLOSURE_SERVICES is not set<br># CONF=
IG_C2PORT is not set<br><br>#<br># EEPROM support<br>#<br># CONFIG_EEPROM_9=
3CX6 is not set<br>CONFIG_HAVE_IDE=3Dy<br># CONFIG_IDE is not set<br><br>#<=
br>
# SCSI device support<br>#<br># CONFIG_RAID_ATTRS is not set<br># CONFIG_SC=
SI is not set<br># CONFIG_SCSI_DMA is not set<br># CONFIG_SCSI_NETLINK is n=
ot set<br># CONFIG_ATA is not set<br># CONFIG_MD is not set<br>CONFIG_NETDE=
VICES=3Dy<br>
CONFIG_COMPAT_NET_DEV_OPS=3Dy<br># CONFIG_DUMMY is not set<br># CONFIG_BOND=
ING is not set<br># CONFIG_MACVLAN is not set<br># CONFIG_EQUALIZER is not =
set<br>CONFIG_TUN=3Dy<br># CONFIG_VETH is not set<br># CONFIG_PHYLIB is not=
 set<br>
CONFIG_NET_ETHERNET=3Dy<br>CONFIG_MII=3Dy<br># CONFIG_AX88796 is not set<br=
>CONFIG_SMC91X=3Dy<br># CONFIG_DM9000 is not set<br># CONFIG_ETHOC is not s=
et<br># CONFIG_SMC911X is not set<br># CONFIG_SMSC911X is not set<br># CONF=
IG_DNET is not set<br>
# CONFIG_IBM_NEW_EMAC_ZMII is not set<br># CONFIG_IBM_NEW_EMAC_RGMII is not=
 set<br># CONFIG_IBM_NEW_EMAC_TAH is not set<br># CONFIG_IBM_NEW_EMAC_EMAC4=
 is not set<br># CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set<br># CONFIG_IB=
M_NEW_EMAC_MAL_CLR_ICINTSTAT is not set<br>
# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set<br># CONFIG_B44 is not set<=
br>CONFIG_NETDEV_1000=3Dy<br>CONFIG_NETDEV_10000=3Dy<br><br>#<br># Wireless=
 LAN<br>#<br># CONFIG_WLAN_PRE80211 is not set<br># CONFIG_WLAN_80211 is no=
t set<br>
<br>#<br># Enable WiMAX (Networking options) to see the WiMAX drivers<br>#<=
br># CONFIG_NET_PCMCIA is not set<br># CONFIG_WAN is not set<br># CONFIG_PP=
P is not set<br># CONFIG_SLIP is not set<br>CONFIG_NETCONSOLE=3Dy<br># CONF=
IG_NETCONSOLE_DYNAMIC is not set<br>
CONFIG_NETPOLL=3Dy<br># CONFIG_NETPOLL_TRAP is not set<br>CONFIG_NET_POLL_C=
ONTROLLER=3Dy<br># CONFIG_ISDN is not set<br><br>#<br># Input device suppor=
t<br>#<br>CONFIG_INPUT=3Dy<br># CONFIG_INPUT_FF_MEMLESS is not set<br># CON=
FIG_INPUT_POLLDEV is not set<br>
<br>#<br># Userland interfaces<br>#<br>CONFIG_INPUT_MOUSEDEV=3Dy<br>CONFIG_=
INPUT_MOUSEDEV_PSAUX=3Dy<br>CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024<br>CONFIG=
_INPUT_MOUSEDEV_SCREEN_Y=3D768<br># CONFIG_INPUT_JOYDEV is not set<br># CON=
FIG_INPUT_EVDEV is not set<br>
# CONFIG_INPUT_EVBUG is not set<br><br>#<br># Input Device Drivers<br>#<br>=
CONFIG_INPUT_KEYBOARD=3Dy<br># CONFIG_KEYBOARD_ATKBD is not set<br># CONFIG=
_KEYBOARD_SUNKBD is not set<br># CONFIG_KEYBOARD_LKKBD is not set<br># CONF=
IG_KEYBOARD_XTKBD is not set<br>
# CONFIG_KEYBOARD_NEWTON is not set<br># CONFIG_KEYBOARD_STOWAWAY is not se=
t<br>CONFIG_INPUT_MOUSE=3Dy<br>CONFIG_MOUSE_PS2=3Dy<br>CONFIG_MOUSE_PS2_ALP=
S=3Dy<br>CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy<br>CONFIG_MOUSE_PS2_SYNAPTICS=3Dy<b=
r>CONFIG_MOUSE_PS2_TRACKPOINT=3Dy<br>
# CONFIG_MOUSE_PS2_ELANTECH is not set<br># CONFIG_MOUSE_PS2_TOUCHKIT is no=
t set<br># CONFIG_MOUSE_SERIAL is not set<br># CONFIG_MOUSE_APPLETOUCH is n=
ot set<br># CONFIG_MOUSE_BCM5974 is not set<br># CONFIG_MOUSE_VSXXXAA is no=
t set<br>
# CONFIG_INPUT_JOYSTICK is not set<br># CONFIG_INPUT_TABLET is not set<br>#=
 CONFIG_INPUT_TOUCHSCREEN is not set<br>CONFIG_INPUT_MISC=3Dy<br># CONFIG_I=
NPUT_ATI_REMOTE is not set<br># CONFIG_INPUT_ATI_REMOTE2 is not set<br># CO=
NFIG_INPUT_KEYSPAN_REMOTE is not set<br>
# CONFIG_INPUT_POWERMATE is not set<br># CONFIG_INPUT_YEALINK is not set<br=
># CONFIG_INPUT_CM109 is not set<br># CONFIG_INPUT_UINPUT is not set<br><br=
>#<br># Hardware I/O ports<br>#<br>CONFIG_SERIO=3Dy<br>CONFIG_SERIO_SERPORT=
=3Dy<br>
CONFIG_SERIO_AMBAKMI=3Dy<br>CONFIG_SERIO_LIBPS2=3Dy<br># CONFIG_SERIO_RAW i=
s not set<br># CONFIG_GAMEPORT is not set<br><br>#<br># Character devices<b=
r>#<br>CONFIG_VT=3Dy<br>CONFIG_CONSOLE_TRANSLATIONS=3Dy<br>CONFIG_VT_CONSOL=
E=3Dy<br>
CONFIG_HW_CONSOLE=3Dy<br>CONFIG_VT_HW_CONSOLE_BINDING=3Dy<br>CONFIG_DEVKMEM=
=3Dy<br># CONFIG_SERIAL_NONSTANDARD is not set<br><br>#<br># Serial drivers=
<br>#<br># CONFIG_SERIAL_8250 is not set<br><br>#<br># Non-8250 serial port=
 support<br>
#<br># CONFIG_SERIAL_AMBA_PL010 is not set<br>CONFIG_SERIAL_AMBA_PL011=3Dy<=
br>CONFIG_SERIAL_AMBA_PL011_CONSOLE=3Dy<br>CONFIG_SERIAL_CORE=3Dy<br>CONFIG=
_SERIAL_CORE_CONSOLE=3Dy<br>CONFIG_UNIX98_PTYS=3Dy<br>CONFIG_DEVPTS_MULTIPL=
E_INSTANCES=3Dy<br>
CONFIG_LEGACY_PTYS=3Dy<br>CONFIG_LEGACY_PTY_COUNT=3D16<br># CONFIG_IPMI_HAN=
DLER is not set<br>CONFIG_HW_RANDOM=3Dy<br># CONFIG_HW_RANDOM_TIMERIOMEM is=
 not set<br># CONFIG_R3964 is not set<br><br>#<br># PCMCIA character device=
s<br>
#<br># CONFIG_SYNCLINK_CS is not set<br># CONFIG_CARDMAN_4000 is not set<br=
># CONFIG_CARDMAN_4040 is not set<br># CONFIG_IPWIRELESS is not set<br># CO=
NFIG_RAW_DRIVER is not set<br># CONFIG_TCG_TPM is not set<br># CONFIG_I2C i=
s not set<br>
# CONFIG_SPI is not set<br># CONFIG_W1 is not set<br># CONFIG_POWER_SUPPLY =
is not set<br>CONFIG_HWMON=3Dy<br># CONFIG_HWMON_VID is not set<br># CONFIG=
_SENSORS_F71805F is not set<br># CONFIG_SENSORS_F71882FG is not set<br># CO=
NFIG_SENSORS_IT87 is not set<br>
# CONFIG_SENSORS_PC87360 is not set<br># CONFIG_SENSORS_PC87427 is not set<=
br># CONFIG_SENSORS_SMSC47M1 is not set<br># CONFIG_SENSORS_SMSC47B397 is n=
ot set<br># CONFIG_SENSORS_VT1211 is not set<br># CONFIG_SENSORS_W83627HF i=
s not set<br>
# CONFIG_SENSORS_W83627EHF is not set<br># CONFIG_HWMON_DEBUG_CHIP is not s=
et<br># CONFIG_THERMAL is not set<br># CONFIG_THERMAL_HWMON is not set<br>#=
 CONFIG_WATCHDOG is not set<br>CONFIG_SSB_POSSIBLE=3Dy<br><br>#<br># Sonics=
 Silicon Backplane<br>
#<br># CONFIG_SSB is not set<br><br>#<br># Multifunction device drivers<br>=
#<br># CONFIG_MFD_CORE is not set<br># CONFIG_MFD_SM501 is not set<br># CON=
FIG_HTC_PASIC3 is not set<br># CONFIG_MFD_TMIO is not set<br># CONFIG_MFD_T=
7L66XB is not set<br>
# CONFIG_MFD_TC6387XB is not set<br><br>#<br># Multimedia devices<br>#<br><=
br>#<br># Multimedia core support<br>#<br># CONFIG_VIDEO_DEV is not set<br>=
# CONFIG_DVB_CORE is not set<br># CONFIG_VIDEO_MEDIA is not set<br><br>
#<br># Multimedia drivers<br>#<br># CONFIG_DAB is not set<br><br>#<br># Gra=
phics support<br>#<br># CONFIG_VGASTATE is not set<br># CONFIG_VIDEO_OUTPUT=
_CONTROL is not set<br>CONFIG_FB=3Dy<br># CONFIG_FIRMWARE_EDID is not set<b=
r>
# CONFIG_FB_DDC is not set<br># CONFIG_FB_BOOT_VESA_SUPPORT is not set<br>C=
ONFIG_FB_CFB_FILLRECT=3Dy<br>CONFIG_FB_CFB_COPYAREA=3Dy<br>CONFIG_FB_CFB_IM=
AGEBLIT=3Dy<br># CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set<br>CONFIG_FB_S=
YS_FILLRECT=3Dy<br>
CONFIG_FB_SYS_COPYAREA=3Dy<br>CONFIG_FB_SYS_IMAGEBLIT=3Dy<br># CONFIG_FB_FO=
REIGN_ENDIAN is not set<br>CONFIG_FB_SYS_FOPS=3Dy<br># CONFIG_FB_SVGALIB is=
 not set<br># CONFIG_FB_MACMODES is not set<br># CONFIG_FB_BACKLIGHT is not=
 set<br>
CONFIG_FB_MODE_HELPERS=3Dy<br>CONFIG_FB_TILEBLITTING=3Dy<br><br>#<br># Fram=
e buffer hardware drivers<br>#<br>CONFIG_FB_ARMCLCD=3Dy<br># CONFIG_FB_S1D1=
3XXX is not set<br>CONFIG_FB_VIRTUAL=3Dy<br># CONFIG_FB_METRONOME is not se=
t<br>
# CONFIG_FB_MB862XX is not set<br># CONFIG_FB_BROADSHEET is not set<br># CO=
NFIG_BACKLIGHT_LCD_SUPPORT is not set<br><br>#<br># Display device support<=
br>#<br>CONFIG_DISPLAY_SUPPORT=3Dy<br><br>#<br># Display hardware drivers<b=
r>
#<br><br>#<br># Console display driver support<br>#<br># CONFIG_VGA_CONSOLE=
 is not set<br>CONFIG_DUMMY_CONSOLE=3Dy<br>CONFIG_FRAMEBUFFER_CONSOLE=3Dy<b=
r>CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy<br># CONFIG_FRAMEBUFFER_CON=
SOLE_ROTATION is not set<br>
CONFIG_FONTS=3Dy<br>CONFIG_FONT_8x8=3Dy<br>CONFIG_FONT_8x16=3Dy<br># CONFIG=
_FONT_6x11 is not set<br>CONFIG_FONT_7x14=3Dy<br># CONFIG_FONT_PEARL_8x8 is=
 not set<br># CONFIG_FONT_ACORN_8x8 is not set<br>CONFIG_FONT_MINI_4x6=3Dy<=
br># CONFIG_FONT_SUN8x16 is not set<br>
# CONFIG_FONT_SUN12x22 is not set<br># CONFIG_FONT_10x18 is not set<br>CONF=
IG_LOGO=3Dy<br>CONFIG_LOGO_LINUX_MONO=3Dy<br>CONFIG_LOGO_LINUX_VGA16=3Dy<br=
>CONFIG_LOGO_LINUX_CLUT224=3Dy<br># CONFIG_SOUND is not set<br>CONFIG_HID_S=
UPPORT=3Dy<br>
CONFIG_HID=3Dy<br>CONFIG_HID_DEBUG=3Dy<br># CONFIG_HIDRAW is not set<br># C=
ONFIG_HID_PID is not set<br><br>#<br># Special HID drivers<br>#<br>CONFIG_U=
SB_SUPPORT=3Dy<br>CONFIG_USB_ARCH_HAS_HCD=3Dy<br># CONFIG_USB_ARCH_HAS_OHCI=
 is not set<br>
# CONFIG_USB_ARCH_HAS_EHCI is not set<br># CONFIG_USB is not set<br><br>#<b=
r># Enable Host or Gadget support to see Inventra options<br>#<br><br>#<br>=
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may<br>#<br># CONFIG_USB=
_GADGET is not set<br>
<br>#<br># OTG and related infrastructure<br>#<br># CONFIG_MMC is not set<b=
r># CONFIG_MEMSTICK is not set<br># CONFIG_ACCESSIBILITY is not set<br># CO=
NFIG_NEW_LEDS is not set<br>CONFIG_RTC_LIB=3Dy<br>CONFIG_RTC_CLASS=3Dy<br>C=
ONFIG_RTC_HCTOSYS=3Dy<br>
CONFIG_RTC_HCTOSYS_DEVICE=3D&quot;rtc0&quot;<br># CONFIG_RTC_DEBUG is not s=
et<br><br>#<br># RTC interfaces<br>#<br>CONFIG_RTC_INTF_SYSFS=3Dy<br>CONFIG=
_RTC_INTF_PROC=3Dy<br>CONFIG_RTC_INTF_DEV=3Dy<br># CONFIG_RTC_INTF_DEV_UIE_=
EMUL is not set<br>
# CONFIG_RTC_DRV_TEST is not set<br><br>#<br># SPI RTC drivers<br>#<br><br>=
#<br># Platform RTC drivers<br>#<br># CONFIG_RTC_DRV_CMOS is not set<br># C=
ONFIG_RTC_DRV_DS1286 is not set<br># CONFIG_RTC_DRV_DS1511 is not set<br>
# CONFIG_RTC_DRV_DS1553 is not set<br># CONFIG_RTC_DRV_DS1742 is not set<br=
># CONFIG_RTC_DRV_STK17TA8 is not set<br># CONFIG_RTC_DRV_M48T86 is not set=
<br># CONFIG_RTC_DRV_M48T35 is not set<br># CONFIG_RTC_DRV_M48T59 is not se=
t<br>
# CONFIG_RTC_DRV_BQ4802 is not set<br># CONFIG_RTC_DRV_V3020 is not set<br>=
<br>#<br># on-CPU RTC drivers<br>#<br># CONFIG_RTC_DRV_PL030 is not set<br>=
# CONFIG_RTC_DRV_PL031 is not set<br># CONFIG_DMADEVICES is not set<br>
# CONFIG_AUXDISPLAY is not set<br># CONFIG_REGULATOR is not set<br># CONFIG=
_UIO is not set<br># CONFIG_STAGING is not set<br><br>#<br># File systems<b=
r>#<br>CONFIG_EXT2_FS=3Dy<br># CONFIG_EXT2_FS_XATTR is not set<br># CONFIG_=
EXT2_FS_XIP is not set<br>
# CONFIG_EXT3_FS is not set<br># CONFIG_EXT4_FS is not set<br># CONFIG_REIS=
ERFS_FS is not set<br># CONFIG_JFS_FS is not set<br>CONFIG_FS_POSIX_ACL=3Dy=
<br># CONFIG_XFS_FS is not set<br># CONFIG_OCFS2_FS is not set<br># CONFIG_=
BTRFS_FS is not set<br>
CONFIG_FILE_LOCKING=3Dy<br>CONFIG_DNOTIFY=3Dy<br>CONFIG_INOTIFY=3Dy<br>CONF=
IG_INOTIFY_USER=3Dy<br># CONFIG_QUOTA is not set<br># CONFIG_AUTOFS_FS is n=
ot set<br># CONFIG_AUTOFS4_FS is not set<br># CONFIG_FUSE_FS is not set<br>=
CONFIG_GENERIC_ACL=3Dy<br>
<br>#<br># Caches<br>#<br>CONFIG_FSCACHE=3Dy<br># CONFIG_FSCACHE_STATS is n=
ot set<br># CONFIG_FSCACHE_HISTOGRAM is not set<br># CONFIG_FSCACHE_DEBUG i=
s not set<br>CONFIG_CACHEFILES=3Dy<br># CONFIG_CACHEFILES_DEBUG is not set<=
br>
# CONFIG_CACHEFILES_HISTOGRAM is not set<br><br>#<br># CD-ROM/DVD Filesyste=
ms<br>#<br># CONFIG_ISO9660_FS is not set<br># CONFIG_UDF_FS is not set<br>=
<br>#<br># DOS/FAT/NT Filesystems<br>#<br># CONFIG_MSDOS_FS is not set<br>
# CONFIG_VFAT_FS is not set<br># CONFIG_NTFS_FS is not set<br><br>#<br># Ps=
eudo filesystems<br>#<br>CONFIG_PROC_FS=3Dy<br>CONFIG_PROC_SYSCTL=3Dy<br>CO=
NFIG_PROC_PAGE_MONITOR=3Dy<br>CONFIG_SYSFS=3Dy<br>CONFIG_TMPFS=3Dy<br>CONFI=
G_TMPFS_POSIX_ACL=3Dy<br>
# CONFIG_HUGETLB_PAGE is not set<br>CONFIG_CONFIGFS_FS=3Dy<br>CONFIG_MISC_F=
ILESYSTEMS=3Dy<br># CONFIG_ADFS_FS is not set<br># CONFIG_AFFS_FS is not se=
t<br># CONFIG_HFS_FS is not set<br># CONFIG_HFSPLUS_FS is not set<br># CONF=
IG_BEFS_FS is not set<br>
# CONFIG_BFS_FS is not set<br># CONFIG_EFS_FS is not set<br>CONFIG_JFFS2_FS=
=3Dy<br>CONFIG_JFFS2_FS_DEBUG=3D0<br>CONFIG_JFFS2_FS_WRITEBUFFER=3Dy<br># C=
ONFIG_JFFS2_FS_WBUF_VERIFY is not set<br># CONFIG_JFFS2_SUMMARY is not set<=
br>
# CONFIG_JFFS2_FS_XATTR is not set<br># CONFIG_JFFS2_COMPRESSION_OPTIONS is=
 not set<br>CONFIG_JFFS2_ZLIB=3Dy<br># CONFIG_JFFS2_LZO is not set<br>CONFI=
G_JFFS2_RTIME=3Dy<br># CONFIG_JFFS2_RUBIN is not set<br>CONFIG_CRAMFS=3Dy<b=
r>
# CONFIG_SQUASHFS is not set<br># CONFIG_VXFS_FS is not set<br># CONFIG_MIN=
IX_FS is not set<br># CONFIG_OMFS_FS is not set<br># CONFIG_HPFS_FS is not =
set<br># CONFIG_QNX4FS_FS is not set<br># CONFIG_ROMFS_FS is not set<br>
# CONFIG_SYSV_FS is not set<br># CONFIG_UFS_FS is not set<br># CONFIG_NILFS=
2_FS is not set<br>CONFIG_NETWORK_FILESYSTEMS=3Dy<br>CONFIG_NFS_FS=3Dy<br>C=
ONFIG_NFS_V3=3Dy<br># CONFIG_NFS_V3_ACL is not set<br># CONFIG_NFS_V4 is no=
t set<br>
CONFIG_ROOT_NFS=3Dy<br># CONFIG_NFS_FSCACHE is not set<br>CONFIG_NFSD=3Dy<b=
r>CONFIG_NFSD_V3=3Dy<br># CONFIG_NFSD_V3_ACL is not set<br># CONFIG_NFSD_V4=
 is not set<br>CONFIG_LOCKD=3Dy<br>CONFIG_LOCKD_V4=3Dy<br>CONFIG_EXPORTFS=
=3Dy<br>CONFIG_NFS_COMMON=3Dy<br>
CONFIG_SUNRPC=3Dy<br># CONFIG_RPCSEC_GSS_KRB5 is not set<br># CONFIG_RPCSEC=
_GSS_SPKM3 is not set<br># CONFIG_SMB_FS is not set<br># CONFIG_CIFS is not=
 set<br># CONFIG_NCP_FS is not set<br># CONFIG_CODA_FS is not set<br># CONF=
IG_AFS_FS is not set<br>
<br>#<br># Partition Types<br>#<br>CONFIG_PARTITION_ADVANCED=3Dy<br># CONFI=
G_ACORN_PARTITION is not set<br># CONFIG_OSF_PARTITION is not set<br># CONF=
IG_AMIGA_PARTITION is not set<br># CONFIG_ATARI_PARTITION is not set<br># C=
ONFIG_MAC_PARTITION is not set<br>
CONFIG_MSDOS_PARTITION=3Dy<br># CONFIG_BSD_DISKLABEL is not set<br># CONFIG=
_MINIX_SUBPARTITION is not set<br># CONFIG_SOLARIS_X86_PARTITION is not set=
<br># CONFIG_UNIXWARE_DISKLABEL is not set<br># CONFIG_LDM_PARTITION is not=
 set<br>
# CONFIG_SGI_PARTITION is not set<br># CONFIG_ULTRIX_PARTITION is not set<b=
r># CONFIG_SUN_PARTITION is not set<br># CONFIG_KARMA_PARTITION is not set<=
br># CONFIG_EFI_PARTITION is not set<br># CONFIG_SYSV68_PARTITION is not se=
t<br>
# CONFIG_NLS is not set<br># CONFIG_DLM is not set<br><br>#<br># Kernel hac=
king<br>#<br># CONFIG_PRINTK_TIME is not set<br>CONFIG_ENABLE_WARN_DEPRECAT=
ED=3Dy<br>CONFIG_ENABLE_MUST_CHECK=3Dy<br>CONFIG_FRAME_WARN=3D1024<br>CONFI=
G_MAGIC_SYSRQ=3Dy<br>
# CONFIG_UNUSED_SYMBOLS is not set<br>CONFIG_DEBUG_FS=3Dy<br># CONFIG_HEADE=
RS_CHECK is not set<br>CONFIG_IPIPE_DEBUG=3Dy<br>CONFIG_IPIPE_DEBUG_CONTEXT=
=3Dy<br>CONFIG_IPIPE_DEBUG_INTERNAL=3Dy<br>CONFIG_IPIPE_TRACE=3Dy<br>CONFIG=
_IPIPE_TRACE_ENABLE=3Dy<br>
CONFIG_IPIPE_TRACE_MCOUNT=3Dy<br>CONFIG_IPIPE_TRACE_IRQSOFF=3Dy<br>CONFIG_I=
PIPE_TRACE_SHIFT=3D14<br>CONFIG_IPIPE_TRACE_VMALLOC=3Dy<br>CONFIG_IPIPE_TRA=
CE_PANIC=3Dy<br>CONFIG_DEBUG_KERNEL=3Dy<br># CONFIG_DEBUG_SHIRQ is not set<=
br>CONFIG_DETECT_SOFTLOCKUP=3Dy<br>
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set<br>CONFIG_BOOTPARAM_SOFTLOCK=
UP_PANIC_VALUE=3D0<br>CONFIG_DETECT_HUNG_TASK=3Dy<br># CONFIG_BOOTPARAM_HUN=
G_TASK_PANIC is not set<br>CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0<br>CO=
NFIG_SCHED_DEBUG=3Dy<br>
# CONFIG_SCHEDSTATS is not set<br># CONFIG_TIMER_STATS is not set<br># CONF=
IG_DEBUG_OBJECTS is not set<br># CONFIG_SLUB_DEBUG_ON is not set<br># CONFI=
G_SLUB_STATS is not set<br># CONFIG_DEBUG_RT_MUTEXES is not set<br># CONFIG=
_RT_MUTEX_TESTER is not set<br>
# CONFIG_DEBUG_SPINLOCK is not set<br># CONFIG_DEBUG_MUTEXES is not set<br>=
# CONFIG_DEBUG_LOCK_ALLOC is not set<br># CONFIG_PROVE_LOCKING is not set<b=
r># CONFIG_LOCK_STAT is not set<br># CONFIG_DEBUG_SPINLOCK_SLEEP is not set=
<br>
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set<br>CONFIG_STACKTRACE=3Dy<br=
># CONFIG_DEBUG_KOBJECT is not set<br>CONFIG_DEBUG_BUGVERBOSE=3Dy<br># CONF=
IG_DEBUG_INFO is not set<br># CONFIG_DEBUG_VM is not set<br># CONFIG_DEBUG_=
WRITECOUNT is not set<br>
CONFIG_DEBUG_MEMORY_INIT=3Dy<br># CONFIG_DEBUG_LIST is not set<br># CONFIG_=
DEBUG_SG is not set<br># CONFIG_DEBUG_NOTIFIERS is not set<br>CONFIG_FRAME_=
POINTER=3Dy<br># CONFIG_BOOT_PRINTK_DELAY is not set<br># CONFIG_RCU_TORTUR=
E_TEST is not set<br>
# CONFIG_RCU_CPU_STALL_DETECTOR is not set<br># CONFIG_BACKTRACE_SELF_TEST =
is not set<br># CONFIG_DEBUG_BLOCK_EXT_DEVT is not set<br># CONFIG_FAULT_IN=
JECTION is not set<br># CONFIG_LATENCYTOP is not set<br># CONFIG_SYSCTL_SYS=
CALL_CHECK is not set<br>
# CONFIG_PAGE_POISONING is not set<br>CONFIG_NOP_TRACER=3Dy<br>CONFIG_HAVE_=
FUNCTION_TRACER=3Dy<br>CONFIG_RING_BUFFER=3Dy<br>CONFIG_TRACING=3Dy<br>CONF=
IG_TRACING_SUPPORT=3Dy<br><br>#<br># Tracers<br>#<br>CONFIG_FUNCTION_TRACER=
=3Dy<br>
# CONFIG_SCHED_TRACER is not set<br>CONFIG_CONTEXT_SWITCH_TRACER=3Dy<br># C=
ONFIG_EVENT_TRACER is not set<br># CONFIG_BOOT_TRACER is not set<br># CONFI=
G_TRACE_BRANCH_PROFILING is not set<br># CONFIG_STACK_TRACER is not set<br>
# CONFIG_KMEMTRACE is not set<br># CONFIG_WORKQUEUE_TRACER is not set<br># =
CONFIG_BLK_DEV_IO_TRACE is not set<br># CONFIG_FTRACE_STARTUP_TEST is not s=
et<br># CONFIG_DYNAMIC_DEBUG is not set<br># CONFIG_SAMPLES is not set<br>
CONFIG_HAVE_ARCH_KGDB=3Dy<br># CONFIG_KGDB is not set<br>CONFIG_ARM_UNWIND=
=3Dy<br># CONFIG_DEBUG_USER is not set<br>CONFIG_DEBUG_ERRORS=3Dy<br># CONF=
IG_DEBUG_STACK_USAGE is not set<br># CONFIG_DEBUG_LL is not set<br><br>#<br=
># Security options<br>
#<br># CONFIG_KEYS is not set<br># CONFIG_SECURITY is not set<br># CONFIG_S=
ECURITYFS is not set<br># CONFIG_SECURITY_FILE_CAPABILITIES is not set<br>C=
ONFIG_CRYPTO=3Dy<br><br>#<br># Crypto core or helper<br>#<br># CONFIG_CRYPT=
O_FIPS is not set<br>
# CONFIG_CRYPTO_MANAGER is not set<br># CONFIG_CRYPTO_MANAGER2 is not set<b=
r># CONFIG_CRYPTO_GF128MUL is not set<br># CONFIG_CRYPTO_NULL is not set<br=
># CONFIG_CRYPTO_CRYPTD is not set<br># CONFIG_CRYPTO_AUTHENC is not set<br=
>
# CONFIG_CRYPTO_TEST is not set<br><br>#<br># Authenticated Encryption with=
 Associated Data<br>#<br># CONFIG_CRYPTO_CCM is not set<br># CONFIG_CRYPTO_=
GCM is not set<br># CONFIG_CRYPTO_SEQIV is not set<br><br>#<br># Block mode=
s<br>
#<br># CONFIG_CRYPTO_CBC is not set<br># CONFIG_CRYPTO_CTR is not set<br># =
CONFIG_CRYPTO_CTS is not set<br># CONFIG_CRYPTO_ECB is not set<br># CONFIG_=
CRYPTO_LRW is not set<br># CONFIG_CRYPTO_PCBC is not set<br># CONFIG_CRYPTO=
_XTS is not set<br>
<br>#<br># Hash modes<br>#<br># CONFIG_CRYPTO_HMAC is not set<br># CONFIG_C=
RYPTO_XCBC is not set<br><br>#<br># Digest<br>#<br># CONFIG_CRYPTO_CRC32C i=
s not set<br># CONFIG_CRYPTO_MD4 is not set<br># CONFIG_CRYPTO_MD5 is not s=
et<br>
# CONFIG_CRYPTO_MICHAEL_MIC is not set<br># CONFIG_CRYPTO_RMD128 is not set=
<br># CONFIG_CRYPTO_RMD160 is not set<br># CONFIG_CRYPTO_RMD256 is not set<=
br># CONFIG_CRYPTO_RMD320 is not set<br># CONFIG_CRYPTO_SHA1 is not set<br>
# CONFIG_CRYPTO_SHA256 is not set<br># CONFIG_CRYPTO_SHA512 is not set<br>#=
 CONFIG_CRYPTO_TGR192 is not set<br># CONFIG_CRYPTO_WP512 is not set<br><br=
>#<br># Ciphers<br>#<br># CONFIG_CRYPTO_AES is not set<br># CONFIG_CRYPTO_A=
NUBIS is not set<br>
# CONFIG_CRYPTO_ARC4 is not set<br># CONFIG_CRYPTO_BLOWFISH is not set<br>#=
 CONFIG_CRYPTO_CAMELLIA is not set<br># CONFIG_CRYPTO_CAST5 is not set<br>#=
 CONFIG_CRYPTO_CAST6 is not set<br># CONFIG_CRYPTO_DES is not set<br># CONF=
IG_CRYPTO_FCRYPT is not set<br>
# CONFIG_CRYPTO_KHAZAD is not set<br># CONFIG_CRYPTO_SALSA20 is not set<br>=
# CONFIG_CRYPTO_SEED is not set<br># CONFIG_CRYPTO_SERPENT is not set<br># =
CONFIG_CRYPTO_TEA is not set<br># CONFIG_CRYPTO_TWOFISH is not set<br><br>
#<br># Compression<br>#<br># CONFIG_CRYPTO_DEFLATE is not set<br># CONFIG_C=
RYPTO_ZLIB is not set<br># CONFIG_CRYPTO_LZO is not set<br><br>#<br># Rando=
m Number Generation<br>#<br># CONFIG_CRYPTO_ANSI_CPRNG is not set<br>CONFIG=
_CRYPTO_HW=3Dy<br>
CONFIG_BINARY_PRINTF=3Dy<br><br>#<br># Library routines<br>#<br>CONFIG_BITR=
EVERSE=3Dy<br>CONFIG_GENERIC_FIND_LAST_BIT=3Dy<br># CONFIG_CRC_CCITT is not=
 set<br># CONFIG_CRC16 is not set<br># CONFIG_CRC_T10DIF is not set<br># CO=
NFIG_CRC_ITU_T is not set<br>
CONFIG_CRC32=3Dy<br># CONFIG_CRC7 is not set<br># CONFIG_LIBCRC32C is not s=
et<br>CONFIG_ZLIB_INFLATE=3Dy<br>CONFIG_ZLIB_DEFLATE=3Dy<br>CONFIG_DECOMPRE=
SS_GZIP=3Dy<br>CONFIG_DECOMPRESS_BZIP2=3Dy<br>CONFIG_DECOMPRESS_LZMA=3Dy<br=
>CONFIG_HAS_IOMEM=3Dy<br>
CONFIG_HAS_IOPORT=3Dy<br>CONFIG_HAS_DMA=3Dy<br>CONFIG_NLATTR=3Dy<br>
___________________________________________________________________________=
______________<br><br><br></div></div><br>

--000e0cd0eaea7767640484c15c5e--

