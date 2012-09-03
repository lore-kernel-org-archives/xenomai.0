MIME-Version: 1.0
In-Reply-To: <504503DC.4040908@xenomai.org>
References: <CAHue_TVRdTsre3E7NxHtb=6XfxkL7_36nsLLxSkiF3kUJAJ5Vw@mail.gmail.com>
	<5022B5E4.7040101@xenomai.org>
	<CAHue_TWodrVNxhsxXZ6_xcOGWHDqVGe41qbY0=R3RhFjBedG+g@mail.gmail.com>
	<50339840.1070202@xenomai.org>
	<CAHue_TVSGuatTqL4fRFoOABo4KTm8dFPmRFp7QJNmpk=ZU7NtQ@mail.gmail.com>
	<CAHue_TUKTiusLqfXK59O+PVoxONKAE2xQyBYOgjDh=dZZ2-b3w@mail.gmail.com>
	<504503DC.4040908@xenomai.org>
Date: Tue, 4 Sep 2012 01:04:02 +0200
Message-ID: <CAHue_TX3+pr39Mso1SXA83NWVRNoeocD-zDcLPk5mKn-XCkQKQ@mail.gmail.com>
From: =?ISO-8859-2?Q?Marcin_Ku=B6ka?= <marckuska@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Cortex-a9 - please fix xenomai-fix-lfs-issue.patch
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

> (...)

>
> > I-pipe, 1.000 MHz clocksource\
>

I was so concentrated on making work kernel on hardware that I somehow
ignored it.


> A Cortex-A9 (in MP mode) should use the "global timer" clock source,
>

That's good news because I decided to switch off SMP option and systems
works only with one CPU


>
> > smsc911x smsc911x: eth0: MAC Address: 00:02:f7:00:40:9c
> > ------------[ cut here ]------------
> > WARNING: at mm/slab.c:2264 kmem_cache_create+0x690/0x6dc()
>

> I would investigate this first. This looks scary.
>

What do you mean by investigate - try other options? SLUB e.g.?


> > worst
> > RTD|     61.000|     63.000|     74.000|       0|     0|     61.000|
> > 74.000
>
>
> High latencies for a cortex-A9. Maybe you enabled all xenomai debug
> options?


That's right - all debug options are on.


> > Xenomai: RTDM: closing file descriptor 0.
> > Segmentation fault
>
> Well without a disassembly of the faulting code and the values of the
> the registers, we have no idea. Could you post your kernel configuration?
>

I attached my kernel config with my previous mail, but here it is:


*#*
*# Automatically generated file; DO NOT EDIT.*
*# Linux/arm 3.2.21 Kernel Configuration*
*#*
*CONFIG_ARM=3Dy*
*CONFIG_SYS_SUPPORTS_APM_EMULATION=3Dy*
*CONFIG_HAVE_SCHED_CLOCK=3Dy*
*CONFIG_GENERIC_TIME_VSYSCALL=3Dy*
*# CONFIG_ARCH_USES_GETTIMEOFFSET is not set*
*CONFIG_GENERIC_CLOCKEVENTS=3Dy*
*CONFIG_KTIME_SCALAR=3Dy*
*CONFIG_HAVE_PROC_CPU=3Dy*
*CONFIG_STACKTRACE_SUPPORT=3Dy*
*CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy*
*CONFIG_LOCKDEP_SUPPORT=3Dy*
*CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy*
*CONFIG_HARDIRQS_SW_RESEND=3Dy*
*CONFIG_GENERIC_IRQ_PROBE=3Dy*
*CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy*
*CONFIG_ARCH_HAS_CPU_IDLE_WAIT=3Dy*
*CONFIG_GENERIC_HWEIGHT=3Dy*
*CONFIG_GENERIC_CALIBRATE_DELAY=3Dy*
*CONFIG_NEED_DMA_MAP_STATE=3Dy*
*CONFIG_VECTORS_BASE=3D0xffff0000*
*CONFIG_ARM_PATCH_PHYS_VIRT=3Dy*
*CONFIG_GENERIC_BUG=3Dy*
*CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"*
*CONFIG_HAVE_IRQ_WORK=3Dy*
*CONFIG_IRQ_WORK=3Dy*
*
*
*#*
*# General setup*
*#*
*CONFIG_EXPERIMENTAL=3Dy*
*CONFIG_BROKEN_ON_SMP=3Dy*
*CONFIG_INIT_ENV_ARG_LIMIT=3D32*
*CONFIG_CROSS_COMPILE=3D"arm-cortex_a9-linux-gnueabi-"*
*CONFIG_LOCALVERSION=3D"-ipipe"*
*# CONFIG_LOCALVERSION_AUTO is not set*
*CONFIG_HAVE_KERNEL_GZIP=3Dy*
*CONFIG_HAVE_KERNEL_LZMA=3Dy*
*CONFIG_HAVE_KERNEL_LZO=3Dy*
*CONFIG_KERNEL_GZIP=3Dy*
*# CONFIG_KERNEL_LZMA is not set*
*# CONFIG_KERNEL_LZO is not set*
*CONFIG_DEFAULT_HOSTNAME=3D"MarcinKuska 0.0.2"*
*CONFIG_SWAP=3Dy*
*CONFIG_SYSVIPC=3Dy*
*CONFIG_SYSVIPC_SYSCTL=3Dy*
*# CONFIG_POSIX_MQUEUE is not set*
*# CONFIG_BSD_PROCESS_ACCT is not set*
*# CONFIG_FHANDLE is not set*
*# CONFIG_TASKSTATS is not set*
*# CONFIG_AUDIT is not set*
*CONFIG_HAVE_GENERIC_HARDIRQS=3Dy*
*
*
*#*
*# IRQ subsystem*
*#*
*CONFIG_GENERIC_HARDIRQS=3Dy*
*CONFIG_HAVE_SPARSE_IRQ=3Dy*
*CONFIG_GENERIC_IRQ_SHOW=3Dy*
*CONFIG_IRQ_DOMAIN=3Dy*
*# CONFIG_SPARSE_IRQ is not set*
*
*
*#*
*# RCU Subsystem*
*#*
*CONFIG_TINY_RCU=3Dy*
*# CONFIG_PREEMPT_RCU is not set*
*# CONFIG_RCU_TRACE is not set*
*# CONFIG_TREE_RCU_TRACE is not set*
*CONFIG_IKCONFIG=3Dy*
*CONFIG_IKCONFIG_PROC=3Dy*
*CONFIG_LOG_BUF_SHIFT=3D14*
*CONFIG_CGROUPS=3Dy*
*# CONFIG_CGROUP_DEBUG is not set*
*# CONFIG_CGROUP_FREEZER is not set*
*# CONFIG_CGROUP_DEVICE is not set*
*CONFIG_CPUSETS=3Dy*
*CONFIG_PROC_PID_CPUSET=3Dy*
*# CONFIG_CGROUP_CPUACCT is not set*
*# CONFIG_RESOURCE_COUNTERS is not set*
*# CONFIG_CGROUP_PERF is not set*
*# CONFIG_CGROUP_SCHED is not set*
*# CONFIG_BLK_CGROUP is not set*
*CONFIG_NAMESPACES=3Dy*
*# CONFIG_UTS_NS is not set*
*# CONFIG_IPC_NS is not set*
*# CONFIG_USER_NS is not set*
*# CONFIG_PID_NS is not set*
*# CONFIG_NET_NS is not set*
*# CONFIG_SCHED_AUTOGROUP is not set*
*# CONFIG_SYSFS_DEPRECATED is not set*
*# CONFIG_RELAY is not set*
*CONFIG_BLK_DEV_INITRD=3Dy*
*CONFIG_INITRAMFS_SOURCE=3D"/home/marcin/arm/rootfs.cpio"*
*CONFIG_INITRAMFS_ROOT_UID=3D0*
*CONFIG_INITRAMFS_ROOT_GID=3D0*
*CONFIG_RD_GZIP=3Dy*
*# CONFIG_RD_BZIP2 is not set*
*# CONFIG_RD_LZMA is not set*
*# CONFIG_RD_XZ is not set*
*# CONFIG_RD_LZO is not set*
*CONFIG_INITRAMFS_COMPRESSION_NONE=3Dy*
*# CONFIG_INITRAMFS_COMPRESSION_GZIP is not set*
*# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set*
*CONFIG_SYSCTL=3Dy*
*CONFIG_ANON_INODES=3Dy*
*CONFIG_EXPERT=3Dy*
*CONFIG_UID16=3Dy*
*# CONFIG_SYSCTL_SYSCALL is not set*
*CONFIG_KALLSYMS=3Dy*
*CONFIG_KALLSYMS_ALL=3Dy*
*CONFIG_HOTPLUG=3Dy*
*CONFIG_PRINTK=3Dy*
*CONFIG_BUG=3Dy*
*CONFIG_ELF_CORE=3Dy*
*CONFIG_BASE_FULL=3Dy*
*CONFIG_FUTEX=3Dy*
*CONFIG_EPOLL=3Dy*
*CONFIG_SIGNALFD=3Dy*
*CONFIG_TIMERFD=3Dy*
*CONFIG_EVENTFD=3Dy*
*CONFIG_SHMEM=3Dy*
*CONFIG_AIO=3Dy*
*CONFIG_EMBEDDED=3Dy*
*CONFIG_HAVE_PERF_EVENTS=3Dy*
*CONFIG_PERF_USE_VMALLOC=3Dy*
*
*
*#*
*# Kernel Performance Events And Counters*
*#*
*CONFIG_PERF_EVENTS=3Dy*
*# CONFIG_PERF_COUNTERS is not set*
*# CONFIG_DEBUG_PERF_USE_VMALLOC is not set*
*CONFIG_VM_EVENT_COUNTERS=3Dy*
*CONFIG_COMPAT_BRK=3Dy*
*CONFIG_SLAB=3Dy*
*# CONFIG_SLUB is not set*
*# CONFIG_SLOB is not set*
*CONFIG_PROFILING=3Dy*
*CONFIG_TRACEPOINTS=3Dy*
*CONFIG_OPROFILE=3Dy*
*CONFIG_HAVE_OPROFILE=3Dy*
*# CONFIG_KPROBES is not set*
*CONFIG_HAVE_KPROBES=3Dy*
*CONFIG_HAVE_KRETPROBES=3Dy*
*CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy*
*CONFIG_HAVE_CLK=3Dy*
*CONFIG_HAVE_DMA_API_DEBUG=3Dy*
*CONFIG_HAVE_HW_BREAKPOINT=3Dy*
*
*
*#*
*# GCOV-based kernel profiling*
*#*
*# CONFIG_GCOV_KERNEL is not set*
*CONFIG_HAVE_GENERIC_DMA_COHERENT=3Dy*
*CONFIG_SLABINFO=3Dy*
*CONFIG_RT_MUTEXES=3Dy*
*CONFIG_BASE_SMALL=3D0*
*CONFIG_MODULES=3Dy*
*# CONFIG_MODULE_FORCE_LOAD is not set*
*CONFIG_MODULE_UNLOAD=3Dy*
*# CONFIG_MODULE_FORCE_UNLOAD is not set*
*# CONFIG_MODVERSIONS is not set*
*# CONFIG_MODULE_SRCVERSION_ALL is not set*
*CONFIG_BLOCK=3Dy*
*# CONFIG_LBDAF is not set*
*# CONFIG_BLK_DEV_BSG is not set*
*# CONFIG_BLK_DEV_BSGLIB is not set*
*# CONFIG_BLK_DEV_INTEGRITY is not set*
*
*
*#*
*# IO Schedulers*
*#*
*CONFIG_IOSCHED_NOOP=3Dy*
*# CONFIG_IOSCHED_DEADLINE is not set*
*# CONFIG_IOSCHED_CFQ is not set*
*CONFIG_DEFAULT_NOOP=3Dy*
*CONFIG_DEFAULT_IOSCHED=3D"noop"*
*# CONFIG_INLINE_SPIN_TRYLOCK is not set*
*# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set*
*# CONFIG_INLINE_SPIN_LOCK is not set*
*# CONFIG_INLINE_SPIN_LOCK_BH is not set*
*# CONFIG_INLINE_SPIN_LOCK_IRQ is not set*
*# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set*
*# CONFIG_INLINE_SPIN_UNLOCK is not set*
*# CONFIG_INLINE_SPIN_UNLOCK_BH is not set*
*# CONFIG_INLINE_SPIN_UNLOCK_IRQ is not set*
*# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set*
*# CONFIG_INLINE_READ_TRYLOCK is not set*
*# CONFIG_INLINE_READ_LOCK is not set*
*# CONFIG_INLINE_READ_LOCK_BH is not set*
*# CONFIG_INLINE_READ_LOCK_IRQ is not set*
*# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set*
*# CONFIG_INLINE_READ_UNLOCK is not set*
*# CONFIG_INLINE_READ_UNLOCK_BH is not set*
*# CONFIG_INLINE_READ_UNLOCK_IRQ is not set*
*# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set*
*# CONFIG_INLINE_WRITE_TRYLOCK is not set*
*# CONFIG_INLINE_WRITE_LOCK is not set*
*# CONFIG_INLINE_WRITE_LOCK_BH is not set*
*# CONFIG_INLINE_WRITE_LOCK_IRQ is not set*
*# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set*
*# CONFIG_INLINE_WRITE_UNLOCK is not set*
*# CONFIG_INLINE_WRITE_UNLOCK_BH is not set*
*# CONFIG_INLINE_WRITE_UNLOCK_IRQ is not set*
*# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set*
*# CONFIG_MUTEX_SPIN_ON_OWNER is not set*
*
*
*#*
*# Real-time sub-system*
*#*
*CONFIG_XENOMAI=3Dy*
*CONFIG_XENO_GENERIC_STACKPOOL=3Dy*
*CONFIG_XENO_FASTSYNCH_DEP=3Dy*
*CONFIG_XENO_FASTSYNCH=3Dy*
*CONFIG_XENO_OPT_NUCLEUS=3Dy*
*CONFIG_XENO_OPT_PERVASIVE=3Dy*
*# CONFIG_XENO_OPT_PRIOCPL is not set*
*CONFIG_XENO_OPT_PIPELINE_HEAD=3Dy*
*# CONFIG_XENO_OPT_SCHED_CLASSES is not set*
*CONFIG_XENO_OPT_PIPE=3Dy*
*CONFIG_XENO_OPT_VFILE=3Dy*
*CONFIG_XENO_OPT_PIPE_NRDEV=3D32*
*CONFIG_XENO_OPT_REGISTRY_NRSLOTS=3D512*
*CONFIG_XENO_OPT_SYS_HEAPSZ=3D256*
*CONFIG_XENO_OPT_SYS_STACKPOOLSZ=3D128*
*CONFIG_XENO_OPT_SEM_HEAPSZ=3D12*
*CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ=3D12*
*CONFIG_XENO_OPT_STATS=3Dy*
*CONFIG_XENO_OPT_DEBUG=3Dy*
*# CONFIG_XENO_OPT_DEBUG_NUCLEUS is not set*
*CONFIG_XENO_OPT_DEBUG_XNLOCK=3Dy*
*# CONFIG_XENO_OPT_DEBUG_QUEUES is not set*
*# CONFIG_XENO_OPT_DEBUG_REGISTRY is not set*
*# CONFIG_XENO_OPT_DEBUG_TIMERS is not set*
*CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX=3Dy*
*CONFIG_XENO_OPT_WATCHDOG=3Dy*
*CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=3D4*
*# CONFIG_XENO_OPT_SHIRQ is not set*
*CONFIG_XENO_OPT_SELECT=3Dy*
*CONFIG_XENO_OPT_HOSTRT=3Dy*
*
*
*#*
*# Timing*
*#*
*# CONFIG_XENO_OPT_TIMING_PERIODIC is not set*
*CONFIG_XENO_OPT_TIMING_VIRTICK=3D1000*
*CONFIG_XENO_OPT_TIMING_SCHEDLAT=3D0*
*
*
*#*
*# Scalability*
*#*
*# CONFIG_XENO_OPT_SCALABLE_SCHED is not set*
*CONFIG_XENO_OPT_TIMER_LIST=3Dy*
*# CONFIG_XENO_OPT_TIMER_HEAP is not set*
*# CONFIG_XENO_OPT_TIMER_WHEEL is not set*
*
*
*#*
*# Machine*
*#*
*CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH=3Dy*
*CONFIG_XENO_HW_FPU=3Dy*
*CONFIG_XENO_HW_UNLOCKED_SWITCH=3Dy*
*
*
*#*
*# Interfaces*
*#*
*CONFIG_XENO_SKIN_NATIVE=3Dy*
*CONFIG_XENO_OPT_NATIVE_PERIOD=3D0*
*CONFIG_XENO_OPT_NATIVE_PIPE=3Dy*
*CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=3D1024*
*CONFIG_XENO_OPT_NATIVE_SEM=3Dy*
*CONFIG_XENO_OPT_NATIVE_EVENT=3Dy*
*CONFIG_XENO_OPT_NATIVE_MUTEX=3Dy*
*CONFIG_XENO_OPT_NATIVE_COND=3Dy*
*CONFIG_XENO_OPT_NATIVE_QUEUE=3Dy*
*CONFIG_XENO_OPT_NATIVE_BUFFER=3Dy*
*CONFIG_XENO_OPT_NATIVE_HEAP=3Dy*
*CONFIG_XENO_OPT_NATIVE_ALARM=3Dy*
*CONFIG_XENO_OPT_NATIVE_MPS=3Dy*
*# CONFIG_XENO_OPT_NATIVE_INTR is not set*
*CONFIG_XENO_OPT_DEBUG_NATIVE=3Dy*
*CONFIG_XENO_SKIN_POSIX=3Dy*
*CONFIG_XENO_OPT_POSIX_PERIOD=3D0*
*# CONFIG_XENO_OPT_POSIX_SHM is not set*
*# CONFIG_XENO_OPT_POSIX_INTR is not set*
*CONFIG_XENO_OPT_POSIX_SELECT=3Dy*
*CONFIG_XENO_OPT_DEBUG_POSIX=3Dy*
*# CONFIG_XENO_SKIN_PSOS is not set*
*# CONFIG_XENO_SKIN_UITRON is not set*
*# CONFIG_XENO_SKIN_VRTX is not set*
*# CONFIG_XENO_SKIN_VXWORKS is not set*
*# CONFIG_XENO_OPT_NOWARN_DEPRECATED is not set*
*CONFIG_XENO_SKIN_RTDM=3Dy*
*CONFIG_XENO_OPT_RTDM_PERIOD=3D0*
*CONFIG_XENO_OPT_RTDM_FILDES=3D128*
*CONFIG_XENO_OPT_RTDM_SELECT=3Dy*
*# CONFIG_XENO_OPT_DEBUG_RTDM is not set*
*CONFIG_XENO_OPT_DEBUG_RTDM_APPL=3Dy*
*
*
*#*
*# Drivers*
*#*
*
*
*#*
*# Serial drivers*
*#*
*# CONFIG_XENO_DRIVERS_16550A is not set*
*
*
*#*
*# Testing drivers*
*#*
*CONFIG_XENO_DRIVERS_TIMERBENCH=3Dy*
*# CONFIG_XENO_DRIVERS_KLATENCY is not set*
*# CONFIG_XENO_DRIVERS_IRQBENCH is not set*
*CONFIG_XENO_DRIVERS_SWITCHTEST=3Dy*
*# CONFIG_XENO_DRIVERS_RTDMTEST is not set*
*
*
*#*
*# CAN drivers*
*#*
*# CONFIG_XENO_DRIVERS_CAN is not set*
*
*
*#*
*# ANALOGY drivers*
*#*
*# CONFIG_XENO_DRIVERS_ANALOGY is not set*
*
*
*#*
*# Real-time IPC drivers*
*#*
*# CONFIG_XENO_DRIVERS_RTIPC is not set*
*CONFIG_FREEZER=3Dy*
*
*
*#*
*# System Type*
*#*
*CONFIG_MMU=3Dy*
*# CONFIG_ARCH_INTEGRATOR is not set*
*# CONFIG_ARCH_REALVIEW is not set*
*# CONFIG_ARCH_VERSATILE is not set*
*CONFIG_ARCH_VEXPRESS=3Dy*
*# CONFIG_ARCH_AT91 is not set*
*# CONFIG_ARCH_BCMRING is not set*
*# CONFIG_ARCH_HIGHBANK is not set*
*# CONFIG_ARCH_CLPS711X is not set*
*# CONFIG_ARCH_CNS3XXX is not set*
*# CONFIG_ARCH_GEMINI is not set*
*# CONFIG_ARCH_PRIMA2 is not set*
*# CONFIG_ARCH_EBSA110 is not set*
*# CONFIG_ARCH_EP93XX is not set*
*# CONFIG_ARCH_FOOTBRIDGE is not set*
*# CONFIG_ARCH_MXC is not set*
*# CONFIG_ARCH_MXS is not set*
*# CONFIG_ARCH_NETX is not set*
*# CONFIG_ARCH_H720X is not set*
*# CONFIG_ARCH_IOP13XX is not set*
*# CONFIG_ARCH_IOP32X is not set*
*# CONFIG_ARCH_IOP33X is not set*
*# CONFIG_ARCH_IXP23XX is not set*
*# CONFIG_ARCH_IXP2000 is not set*
*# CONFIG_ARCH_IXP4XX is not set*
*# CONFIG_ARCH_DOVE is not set*
*# CONFIG_ARCH_KIRKWOOD is not set*
*# CONFIG_ARCH_LPC32XX is not set*
*# CONFIG_ARCH_MV78XX0 is not set*
*# CONFIG_ARCH_ORION5X is not set*
*# CONFIG_ARCH_MMP is not set*
*# CONFIG_ARCH_KS8695 is not set*
*# CONFIG_ARCH_W90X900 is not set*
*# CONFIG_ARCH_TEGRA is not set*
*# CONFIG_ARCH_PICOXCELL is not set*
*# CONFIG_ARCH_PNX4008 is not set*
*# CONFIG_ARCH_PXA is not set*
*# CONFIG_ARCH_MSM is not set*
*# CONFIG_ARCH_SHMOBILE is not set*
*# CONFIG_ARCH_RPC is not set*
*# CONFIG_ARCH_SA1100 is not set*
*# CONFIG_ARCH_S3C2410 is not set*
*# CONFIG_ARCH_S3C64XX is not set*
*# CONFIG_ARCH_S5P64X0 is not set*
*# CONFIG_ARCH_S5PC100 is not set*
*# CONFIG_ARCH_S5PV210 is not set*
*# CONFIG_ARCH_EXYNOS is not set*
*# CONFIG_ARCH_SHARK is not set*
*# CONFIG_ARCH_TCC_926 is not set*
*# CONFIG_ARCH_U300 is not set*
*# CONFIG_ARCH_U8500 is not set*
*# CONFIG_ARCH_NOMADIK is not set*
*# CONFIG_ARCH_DAVINCI is not set*
*# CONFIG_ARCH_OMAP is not set*
*# CONFIG_PLAT_SPEAR is not set*
*# CONFIG_ARCH_VT8500 is not set*
*# CONFIG_ARCH_ZYNQ is not set*
*
*
*#*
*# System MMU*
*#*
*
*
*#*
*# Versatile Express platform type*
*#*
*CONFIG_ARCH_VEXPRESS_CA9X4=3Dy*
*CONFIG_PLAT_VERSATILE_CLCD=3Dy*
*CONFIG_PLAT_VERSATILE_SCHED_CLOCK=3Dy*
*CONFIG_PLAT_VERSATILE=3Dy*
*CONFIG_ARM_TIMER_SP804=3Dy*
*CONFIG_IPIPE_ARM_KUSER_TSC=3Dy*
*
*
*#*
*# Processor Type*
*#*
*CONFIG_CPU_V7=3Dy*
*CONFIG_CPU_32v6K=3Dy*
*CONFIG_CPU_32v7=3Dy*
*CONFIG_CPU_ABRT_EV7=3Dy*
*CONFIG_CPU_PABRT_V7=3Dy*
*CONFIG_CPU_CACHE_V7=3Dy*
*CONFIG_CPU_CACHE_VIPT=3Dy*
*CONFIG_CPU_COPY_V6=3Dy*
*CONFIG_CPU_TLB_V7=3Dy*
*CONFIG_CPU_HAS_ASID=3Dy*
*CONFIG_CPU_CP15=3Dy*
*CONFIG_CPU_CP15_MMU=3Dy*
*CONFIG_CPU_USE_DOMAINS=3Dy*
*
*
*#*
*# Processor Features*
*#*
*CONFIG_ARM_THUMB=3Dy*
*# CONFIG_ARM_THUMBEE is not set*
*# CONFIG_CPU_ICACHE_DISABLE is not set*
*# CONFIG_CPU_DCACHE_DISABLE is not set*
*# CONFIG_CPU_BPREDICT_DISABLE is not set*
*CONFIG_OUTER_CACHE=3Dy*
*CONFIG_OUTER_CACHE_SYNC=3Dy*
*CONFIG_CACHE_L2X0=3Dy*
*CONFIG_CACHE_PL310=3Dy*
*CONFIG_ARM_L1_CACHE_SHIFT=3D5*
*CONFIG_ARM_DMA_MEM_BUFFERABLE=3Dy*
*CONFIG_CPU_HAS_PMU=3Dy*
*# CONFIG_ARM_ERRATA_430973 is not set*
*# CONFIG_ARM_ERRATA_458693 is not set*
*# CONFIG_ARM_ERRATA_460075 is not set*
*# CONFIG_PL310_ERRATA_588369 is not set*
*CONFIG_ARM_ERRATA_720789=3Dy*
*# CONFIG_PL310_ERRATA_727915 is not set*
*# CONFIG_ARM_ERRATA_743622 is not set*
*CONFIG_ARM_ERRATA_751472=3Dy*
*# CONFIG_PL310_ERRATA_753970 is not set*
*# CONFIG_ARM_ERRATA_754322 is not set*
*# CONFIG_PL310_ERRATA_769419 is not set*
*CONFIG_ARM_GIC=3Dy*
*CONFIG_ICST=3Dy*
*
*
*#*
*# Bus support*
*#*
*CONFIG_ARM_AMBA=3Dy*
*# CONFIG_PCI_SYSCALL is not set*
*# CONFIG_ARCH_SUPPORTS_MSI is not set*
*# CONFIG_PCCARD is not set*
*
*
*#*
*# Kernel Features*
*#*
*CONFIG_TICK_ONESHOT=3Dy*
*# CONFIG_NO_HZ is not set*
*CONFIG_HIGH_RES_TIMERS=3Dy*
*CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy*
*# CONFIG_SMP is not set*
*# CONFIG_VMSPLIT_3G is not set*
*CONFIG_VMSPLIT_2G=3Dy*
*# CONFIG_VMSPLIT_1G is not set*
*CONFIG_PAGE_OFFSET=3D0x80000000*
*CONFIG_IPIPE=3Dy*
*CONFIG_IPIPE_CORE=3Dy*
*CONFIG_IPIPE_LEGACY=3Dy*
*CONFIG_IPIPE_HAVE_HOSTRT=3Dy*
*CONFIG_IPIPE_DELAYED_ATOMICSW=3Dy*
*CONFIG_PREEMPT_NONE=3Dy*
*# CONFIG_PREEMPT_VOLUNTARY is not set*
*# CONFIG_PREEMPT is not set*
*CONFIG_HZ=3D100*
*# CONFIG_THUMB2_KERNEL is not set*
*CONFIG_AEABI=3Dy*
*# CONFIG_OABI_COMPAT is not set*
*# CONFIG_ARCH_SPARSEMEM_DEFAULT is not set*
*# CONFIG_ARCH_SELECT_MEMORY_MODEL is not set*
*CONFIG_HAVE_ARCH_PFN_VALID=3Dy*
*# CONFIG_HIGHMEM is not set*
*CONFIG_HW_PERF_EVENTS=3Dy*
*CONFIG_SELECT_MEMORY_MODEL=3Dy*
*CONFIG_FLATMEM_MANUAL=3Dy*
*CONFIG_FLATMEM=3Dy*
*CONFIG_FLAT_NODE_MEM_MAP=3Dy*
*CONFIG_HAVE_MEMBLOCK=3Dy*
*CONFIG_PAGEFLAGS_EXTENDED=3Dy*
*CONFIG_SPLIT_PTLOCK_CPUS=3D999999*
*# CONFIG_COMPACTION is not set*
*# CONFIG_PHYS_ADDR_T_64BIT is not set*
*CONFIG_ZONE_DMA_FLAG=3D0*
*CONFIG_VIRT_TO_BUS=3Dy*
*# CONFIG_KSM is not set*
*CONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096*
*CONFIG_NEED_PER_CPU_KM=3Dy*
*# CONFIG_CLEANCACHE is not set*
*CONFIG_FORCE_MAX_ZONEORDER=3D11*
*CONFIG_ALIGNMENT_TRAP=3Dy*
*# CONFIG_UACCESS_WITH_MEMCPY is not set*
*# CONFIG_SECCOMP is not set*
*# CONFIG_CC_STACKPROTECTOR is not set*
*# CONFIG_DEPRECATED_PARAM_STRUCT is not set*
*
*
*#*
*# Boot options*
*#*
*# CONFIG_USE_OF is not set*
*CONFIG_ZBOOT_ROM_TEXT=3D0x0*
*CONFIG_ZBOOT_ROM_BSS=3D0x0*
*CONFIG_CMDLINE=3D"earlyprintk debug console=3DttyAMA0 kgdwait mem=3D256M
rootwait"*
*CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy*
*# CONFIG_CMDLINE_EXTEND is not set*
*# CONFIG_CMDLINE_FORCE is not set*
*# CONFIG_XIP_KERNEL is not set*
*# CONFIG_KEXEC is not set*
*# CONFIG_CRASH_DUMP is not set*
*# CONFIG_AUTO_ZRELADDR is not set*
*
*
*#*
*# CPU Power Management*
*#*
*# CONFIG_CPU_IDLE is not set*
*
*
*#*
*# Floating point emulation*
*#*
*
*
*#*
*# At least one emulation must be selected*
*#*
*CONFIG_VFP=3Dy*
*CONFIG_VFPv3=3Dy*
*CONFIG_NEON=3Dy*
*
*
*#*
*# Userspace binary formats*
*#*
*CONFIG_BINFMT_ELF=3Dy*
*# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set*
*CONFIG_HAVE_AOUT=3Dy*
*# CONFIG_BINFMT_AOUT is not set*
*# CONFIG_BINFMT_MISC is not set*
*
*
*#*
*# Power management options*
*#*
*CONFIG_SUSPEND=3Dy*
*CONFIG_SUSPEND_FREEZER=3Dy*
*CONFIG_PM_SLEEP=3Dy*
*# CONFIG_PM_RUNTIME is not set*
*CONFIG_PM=3Dy*
*# CONFIG_PM_DEBUG is not set*
*# CONFIG_APM_EMULATION is not set*
*CONFIG_PM_CLK=3Dy*
*CONFIG_CPU_PM=3Dy*
*CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy*
*CONFIG_ARM_CPU_SUSPEND=3Dy*
*CONFIG_NET=3Dy*
*
*
*#*
*# Networking options*
*#*
*CONFIG_PACKET=3Dy*
*CONFIG_UNIX=3Dy*
*CONFIG_XFRM=3Dy*
*# CONFIG_XFRM_USER is not set*
*# CONFIG_XFRM_SUB_POLICY is not set*
*# CONFIG_XFRM_MIGRATE is not set*
*# CONFIG_XFRM_STATISTICS is not set*
*# CONFIG_NET_KEY is not set*
*CONFIG_INET=3Dy*
*# CONFIG_IP_MULTICAST is not set*
*# CONFIG_IP_ADVANCED_ROUTER is not set*
*CONFIG_IP_PNP=3Dy*
*CONFIG_IP_PNP_DHCP=3Dy*
*CONFIG_IP_PNP_BOOTP=3Dy*
*# CONFIG_IP_PNP_RARP is not set*
*# CONFIG_NET_IPIP is not set*
*# CONFIG_NET_IPGRE_DEMUX is not set*
*# CONFIG_ARPD is not set*
*# CONFIG_SYN_COOKIES is not set*
*# CONFIG_INET_AH is not set*
*# CONFIG_INET_ESP is not set*
*# CONFIG_INET_IPCOMP is not set*
*# CONFIG_INET_XFRM_TUNNEL is not set*
*# CONFIG_INET_TUNNEL is not set*
*CONFIG_INET_XFRM_MODE_TRANSPORT=3Dy*
*CONFIG_INET_XFRM_MODE_TUNNEL=3Dy*
*CONFIG_INET_XFRM_MODE_BEET=3Dy*
*# CONFIG_INET_LRO is not set*
*CONFIG_INET_DIAG=3Dy*
*CONFIG_INET_TCP_DIAG=3Dy*
*# CONFIG_TCP_CONG_ADVANCED is not set*
*CONFIG_TCP_CONG_CUBIC=3Dy*
*CONFIG_DEFAULT_TCP_CONG=3D"cubic"*
*# CONFIG_TCP_MD5SIG is not set*
*# CONFIG_IPV6 is not set*
*# CONFIG_NETWORK_SECMARK is not set*
*# CONFIG_NETWORK_PHY_TIMESTAMPING is not set*
*# CONFIG_NETFILTER is not set*
*# CONFIG_IP_DCCP is not set*
*# CONFIG_IP_SCTP is not set*
*# CONFIG_RDS is not set*
*# CONFIG_TIPC is not set*
*# CONFIG_ATM is not set*
*# CONFIG_L2TP is not set*
*# CONFIG_BRIDGE is not set*
*# CONFIG_NET_DSA is not set*
*# CONFIG_VLAN_8021Q is not set*
*# CONFIG_DECNET is not set*
*# CONFIG_LLC2 is not set*
*# CONFIG_IPX is not set*
*# CONFIG_ATALK is not set*
*# CONFIG_X25 is not set*
*# CONFIG_LAPB is not set*
*# CONFIG_ECONET is not set*
*# CONFIG_WAN_ROUTER is not set*
*# CONFIG_PHONET is not set*
*# CONFIG_IEEE802154 is not set*
*# CONFIG_NET_SCHED is not set*
*# CONFIG_DCB is not set*
*# CONFIG_BATMAN_ADV is not set*
*
*
*#*
*# Network testing*
*#*
*# CONFIG_NET_PKTGEN is not set*
*# CONFIG_NET_DROP_MONITOR is not set*
*# CONFIG_HAMRADIO is not set*
*# CONFIG_CAN is not set*
*# CONFIG_IRDA is not set*
*# CONFIG_BT is not set*
*# CONFIG_AF_RXRPC is not set*
*# CONFIG_WIRELESS is not set*
*# CONFIG_WIMAX is not set*
*# CONFIG_RFKILL is not set*
*# CONFIG_NET_9P is not set*
*# CONFIG_CAIF is not set*
*# CONFIG_CEPH_LIB is not set*
*# CONFIG_NFC is not set*
*
*
*#*
*# Device Drivers*
*#*
*
*
*#*
*# Generic Driver Options*
*#*
*CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"*
*# CONFIG_DEVTMPFS is not set*
*CONFIG_STANDALONE=3Dy*
*CONFIG_PREVENT_FIRMWARE_BUILD=3Dy*
*CONFIG_FW_LOADER=3Dy*
*CONFIG_FIRMWARE_IN_KERNEL=3Dy*
*CONFIG_EXTRA_FIRMWARE=3D""*
*# CONFIG_DEBUG_DRIVER is not set*
*# CONFIG_DEBUG_DEVRES is not set*
*# CONFIG_SYS_HYPERVISOR is not set*
*# CONFIG_CONNECTOR is not set*
*CONFIG_MTD=3Dy*
*# CONFIG_MTD_TESTS is not set*
*# CONFIG_MTD_REDBOOT_PARTS is not set*
*CONFIG_MTD_CMDLINE_PARTS=3Dy*
*# CONFIG_MTD_AFS_PARTS is not set*
*# CONFIG_MTD_AR7_PARTS is not set*
*
*
*#*
*# User Modules And Translation Layers*
*#*
*CONFIG_MTD_CHAR=3Dy*
*CONFIG_MTD_BLKDEVS=3Dy*
*CONFIG_MTD_BLOCK=3Dy*
*# CONFIG_FTL is not set*
*# CONFIG_NFTL is not set*
*# CONFIG_INFTL is not set*
*# CONFIG_RFD_FTL is not set*
*# CONFIG_SSFDC is not set*
*# CONFIG_SM_FTL is not set*
*# CONFIG_MTD_OOPS is not set*
*# CONFIG_MTD_SWAP is not set*
*
*
*#*
*# RAM/ROM/Flash chip drivers*
*#*
*CONFIG_MTD_CFI=3Dy*
*# CONFIG_MTD_JEDECPROBE is not set*
*CONFIG_MTD_GEN_PROBE=3Dy*
*# CONFIG_MTD_CFI_ADV_OPTIONS is not set*
*CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy*
*CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy*
*CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy*
*# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set*
*# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set*
*# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set*
*CONFIG_MTD_CFI_I1=3Dy*
*CONFIG_MTD_CFI_I2=3Dy*
*# CONFIG_MTD_CFI_I4 is not set*
*# CONFIG_MTD_CFI_I8 is not set*
*CONFIG_MTD_CFI_INTELEXT=3Dy*
*CONFIG_MTD_CFI_AMDSTD=3Dy*
*# CONFIG_MTD_CFI_STAA is not set*
*CONFIG_MTD_CFI_UTIL=3Dy*
*# CONFIG_MTD_RAM is not set*
*# CONFIG_MTD_ROM is not set*
*# CONFIG_MTD_ABSENT is not set*
*
*
*#*
*# Mapping drivers for chip access*
*#*
*# CONFIG_MTD_COMPLEX_MAPPINGS is not set*
*# CONFIG_MTD_PHYSMAP is not set*
*# CONFIG_MTD_PLATRAM is not set*
*
*
*#*
*# Self-contained MTD device drivers*
*#*
*# CONFIG_MTD_SLRAM is not set*
*# CONFIG_MTD_PHRAM is not set*
*# CONFIG_MTD_MTDRAM is not set*
*# CONFIG_MTD_BLOCK2MTD is not set*
*
*
*#*
*# Disk-On-Chip Device Drivers*
*#*
*# CONFIG_MTD_DOC2000 is not set*
*# CONFIG_MTD_DOC2001 is not set*
*# CONFIG_MTD_DOC2001PLUS is not set*
*# CONFIG_MTD_DOCG3 is not set*
*# CONFIG_MTD_NAND is not set*
*# CONFIG_MTD_ONENAND is not set*
*
*
*#*
*# LPDDR flash memory drivers*
*#*
*# CONFIG_MTD_LPDDR is not set*
*# CONFIG_MTD_UBI is not set*
*# CONFIG_PARPORT is not set*
*CONFIG_BLK_DEV=3Dy*
*# CONFIG_BLK_DEV_COW_COMMON is not set*
*# CONFIG_BLK_DEV_LOOP is not set*
*
*
*#*
*# DRBD disabled because PROC_FS, INET or CONNECTOR not selected*
*#*
*# CONFIG_BLK_DEV_NBD is not set*
*# CONFIG_BLK_DEV_UB is not set*
*# CONFIG_BLK_DEV_RAM is not set*
*# CONFIG_CDROM_PKTCDVD is not set*
*# CONFIG_ATA_OVER_ETH is not set*
*# CONFIG_BLK_DEV_RBD is not set*
*# CONFIG_SENSORS_LIS3LV02D is not set*
*CONFIG_MISC_DEVICES=3Dy*
*# CONFIG_ATMEL_PWM is not set*
*# CONFIG_ENCLOSURE_SERVICES is not set*
*# CONFIG_ARM_CHARLCD is not set*
*# CONFIG_C2PORT is not set*
*
*
*#*
*# EEPROM support*
*#*
*# CONFIG_EEPROM_93CX6 is not set*
*# CONFIG_IWMC3200TOP is not set*
*
*
*#*
*# Texas Instruments shared transport line discipline*
*#*
*
*
*#*
*# Altera FPGA firmware download module*
*#*
*
*
*#*
*# SCSI device support*
*#*
*CONFIG_SCSI_MOD=3Dy*
*# CONFIG_RAID_ATTRS is not set*
*CONFIG_SCSI=3Dy*
*CONFIG_SCSI_DMA=3Dy*
*# CONFIG_SCSI_TGT is not set*
*# CONFIG_SCSI_NETLINK is not set*
*# CONFIG_SCSI_PROC_FS is not set*
*
*
*#*
*# SCSI support type (disk, tape, CD-ROM)*
*#*
*CONFIG_BLK_DEV_SD=3Dy*
*# CONFIG_CHR_DEV_ST is not set*
*# CONFIG_CHR_DEV_OSST is not set*
*# CONFIG_BLK_DEV_SR is not set*
*# CONFIG_CHR_DEV_SG is not set*
*# CONFIG_CHR_DEV_SCH is not set*
*# CONFIG_SCSI_MULTI_LUN is not set*
*# CONFIG_SCSI_CONSTANTS is not set*
*# CONFIG_SCSI_LOGGING is not set*
*# CONFIG_SCSI_SCAN_ASYNC is not set*
*CONFIG_SCSI_WAIT_SCAN=3Dm*
*
*
*#*
*# SCSI Transports*
*#*
*# CONFIG_SCSI_SPI_ATTRS is not set*
*# CONFIG_SCSI_FC_ATTRS is not set*
*# CONFIG_SCSI_ISCSI_ATTRS is not set*
*# CONFIG_SCSI_SAS_ATTRS is not set*
*# CONFIG_SCSI_SAS_LIBSAS is not set*
*# CONFIG_SCSI_SRP_ATTRS is not set*
*# CONFIG_SCSI_LOWLEVEL is not set*
*# CONFIG_SCSI_DH is not set*
*# CONFIG_SCSI_OSD_INITIATOR is not set*
*CONFIG_HAVE_PATA_PLATFORM=3Dy*
*CONFIG_ATA=3Dy*
*# CONFIG_ATA_NONSTANDARD is not set*
*CONFIG_ATA_VERBOSE_ERROR=3Dy*
*# CONFIG_SATA_PMP is not set*
*
*
*#*
*# Controllers with non-SFF native interface*
*#*
*# CONFIG_SATA_AHCI_PLATFORM is not set*
*CONFIG_ATA_SFF=3Dy*
*
*
*#*
*# SFF controllers with custom DMA interface*
*#*
*CONFIG_ATA_BMDMA=3Dy*
*
*
*#*
*# SATA SFF controllers with BMDMA*
*#*
*# CONFIG_SATA_MV is not set*
*
*
*#*
*# PATA SFF controllers with BMDMA*
*#*
*
*
*#*
*# PIO-only SFF controllers*
*#*
*# CONFIG_PATA_PLATFORM is not set*
*
*
*#*
*# Generic fallback / legacy drivers*
*#*
*# CONFIG_MD is not set*
*# CONFIG_TARGET_CORE is not set*
*CONFIG_NETDEVICES=3Dy*
*CONFIG_NET_CORE=3Dy*
*# CONFIG_BONDING is not set*
*# CONFIG_DUMMY is not set*
*# CONFIG_EQUALIZER is not set*
*CONFIG_MII=3Dy*
*# CONFIG_MACVLAN is not set*
*# CONFIG_NETCONSOLE is not set*
*# CONFIG_NETPOLL is not set*
*# CONFIG_NET_POLL_CONTROLLER is not set*
*# CONFIG_TUN is not set*
*# CONFIG_VETH is not set*
*
*
*#*
*# CAIF transport drivers*
*#*
*CONFIG_ETHERNET=3Dy*
*CONFIG_NET_VENDOR_BROADCOM=3Dy*
*# CONFIG_B44 is not set*
*CONFIG_NET_VENDOR_CHELSIO=3Dy*
*# CONFIG_DM9000 is not set*
*# CONFIG_DNET is not set*
*CONFIG_NET_VENDOR_FARADAY=3Dy*
*# CONFIG_FTMAC100 is not set*
*# CONFIG_FTGMAC100 is not set*
*CONFIG_NET_VENDOR_INTEL=3Dy*
*CONFIG_NET_VENDOR_I825XX=3Dy*
*CONFIG_NET_VENDOR_MARVELL=3Dy*
*CONFIG_NET_VENDOR_MICREL=3Dy*
*# CONFIG_KS8851_MLL is not set*
*CONFIG_NET_VENDOR_NATSEMI=3Dy*
*CONFIG_NET_VENDOR_8390=3Dy*
*# CONFIG_AX88796 is not set*
*# CONFIG_ETHOC is not set*
*CONFIG_NET_VENDOR_SEEQ=3Dy*
*# CONFIG_SEEQ8005 is not set*
*CONFIG_NET_VENDOR_SMSC=3Dy*
*# CONFIG_SMC91X is not set*
*# CONFIG_SMC911X is not set*
*CONFIG_SMSC911X=3Dy*
*# CONFIG_SMSC911X_ARCH_HOOKS is not set*
*CONFIG_NET_VENDOR_STMICRO=3Dy*
*# CONFIG_STMMAC_ETH is not set*
*CONFIG_PHYLIB=3Dy*
*
*
*#*
*# MII PHY device drivers*
*#*
*# CONFIG_MARVELL_PHY is not set*
*# CONFIG_DAVICOM_PHY is not set*
*# CONFIG_QSEMI_PHY is not set*
*# CONFIG_LXT_PHY is not set*
*# CONFIG_CICADA_PHY is not set*
*# CONFIG_VITESSE_PHY is not set*
*# CONFIG_SMSC_PHY is not set*
*# CONFIG_BROADCOM_PHY is not set*
*# CONFIG_ICPLUS_PHY is not set*
*# CONFIG_REALTEK_PHY is not set*
*# CONFIG_NATIONAL_PHY is not set*
*# CONFIG_STE10XP is not set*
*# CONFIG_LSI_ET1011C_PHY is not set*
*# CONFIG_MICREL_PHY is not set*
*# CONFIG_FIXED_PHY is not set*
*# CONFIG_MDIO_BITBANG is not set*
*# CONFIG_PPP is not set*
*# CONFIG_SLIP is not set*
*
*
*#*
*# USB Network Adapters*
*#*
*# CONFIG_USB_CATC is not set*
*# CONFIG_USB_KAWETH is not set*
*# CONFIG_USB_PEGASUS is not set*
*# CONFIG_USB_RTL8150 is not set*
*# CONFIG_USB_USBNET is not set*
*# CONFIG_USB_IPHETH is not set*
*# CONFIG_WLAN is not set*
*
*
*#*
*# Enable WiMAX (Networking options) to see the WiMAX drivers*
*#*
*# CONFIG_WAN is not set*
*# CONFIG_ISDN is not set*
*# CONFIG_PHONE is not set*
*
*
*#*
*# Input device support*
*#*
*CONFIG_INPUT=3Dy*
*# CONFIG_INPUT_FF_MEMLESS is not set*
*# CONFIG_INPUT_POLLDEV is not set*
*# CONFIG_INPUT_SPARSEKMAP is not set*
*
*
*#*
*# Userland interfaces*
*#*
*CONFIG_INPUT_MOUSEDEV=3Dy*
*CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy*
*CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024*
*CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768*
*# CONFIG_INPUT_JOYDEV is not set*
*CONFIG_INPUT_EVDEV=3Dy*
*# CONFIG_INPUT_EVBUG is not set*
*
*
*#*
*# Input Device Drivers*
*#*
*CONFIG_INPUT_KEYBOARD=3Dy*
*CONFIG_KEYBOARD_ATKBD=3Dy*
*# CONFIG_KEYBOARD_LKKBD is not set*
*# CONFIG_KEYBOARD_NEWTON is not set*
*# CONFIG_KEYBOARD_OPENCORES is not set*
*# CONFIG_KEYBOARD_STOWAWAY is not set*
*# CONFIG_KEYBOARD_SUNKBD is not set*
*# CONFIG_KEYBOARD_XTKBD is not set*
*CONFIG_INPUT_MOUSE=3Dy*
*CONFIG_MOUSE_PS2=3Dy*
*CONFIG_MOUSE_PS2_ALPS=3Dy*
*CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy*
*CONFIG_MOUSE_PS2_SYNAPTICS=3Dy*
*CONFIG_MOUSE_PS2_TRACKPOINT=3Dy*
*# CONFIG_MOUSE_PS2_ELANTECH is not set*
*# CONFIG_MOUSE_PS2_SENTELIC is not set*
*# CONFIG_MOUSE_PS2_TOUCHKIT is not set*
*# CONFIG_MOUSE_SERIAL is not set*
*# CONFIG_MOUSE_APPLETOUCH is not set*
*# CONFIG_MOUSE_BCM5974 is not set*
*# CONFIG_MOUSE_VSXXXAA is not set*
*# CONFIG_INPUT_JOYSTICK is not set*
*# CONFIG_INPUT_TABLET is not set*
*# CONFIG_INPUT_TOUCHSCREEN is not set*
*# CONFIG_INPUT_MISC is not set*
*
*
*#*
*# Hardware I/O ports*
*#*
*CONFIG_SERIO=3Dy*
*# CONFIG_SERIO_SERPORT is not set*
*CONFIG_SERIO_AMBAKMI=3Dy*
*CONFIG_SERIO_LIBPS2=3Dy*
*# CONFIG_SERIO_RAW is not set*
*# CONFIG_SERIO_ALTERA_PS2 is not set*
*# CONFIG_SERIO_PS2MULT is not set*
*# CONFIG_GAMEPORT is not set*
*
*
*#*
*# Character devices*
*#*
*CONFIG_VT=3Dy*
*CONFIG_CONSOLE_TRANSLATIONS=3Dy*
*CONFIG_VT_CONSOLE=3Dy*
*CONFIG_VT_CONSOLE_SLEEP=3Dy*
*CONFIG_HW_CONSOLE=3Dy*
*# CONFIG_VT_HW_CONSOLE_BINDING is not set*
*CONFIG_UNIX98_PTYS=3Dy*
*# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set*
*CONFIG_LEGACY_PTYS=3Dy*
*CONFIG_LEGACY_PTY_COUNT=3D16*
*# CONFIG_SERIAL_NONSTANDARD is not set*
*# CONFIG_N_GSM is not set*
*# CONFIG_TRACE_SINK is not set*
*CONFIG_DEVKMEM=3Dy*
*
*
*#*
*# Serial drivers*
*#*
*# CONFIG_SERIAL_8250 is not set*
*
*
*#*
*# Non-8250 serial port support*
*#*
*# CONFIG_SERIAL_AMBA_PL010 is not set*
*CONFIG_SERIAL_AMBA_PL011=3Dy*
*CONFIG_SERIAL_AMBA_PL011_CONSOLE=3Dy*
*CONFIG_SERIAL_CORE=3Dy*
*CONFIG_SERIAL_CORE_CONSOLE=3Dy*
*# CONFIG_SERIAL_TIMBERDALE is not set*
*# CONFIG_SERIAL_ALTERA_JTAGUART is not set*
*# CONFIG_SERIAL_ALTERA_UART is not set*
*# CONFIG_SERIAL_XILINX_PS_UART is not set*
*# CONFIG_TTY_PRINTK is not set*
*# CONFIG_HVC_DCC is not set*
*# CONFIG_IPMI_HANDLER is not set*
*# CONFIG_HW_RANDOM is not set*
*# CONFIG_R3964 is not set*
*# CONFIG_RAW_DRIVER is not set*
*# CONFIG_TCG_TPM is not set*
*# CONFIG_RAMOOPS is not set*
*# CONFIG_I2C is not set*
*# CONFIG_SPI is not set*
*
*
*#*
*# PPS support*
*#*
*# CONFIG_PPS is not set*
*
*
*#*
*# PPS generators support*
*#*
*
*
*#*
*# PTP clock support*
*#*
*
*
*#*
*# Enable Device Drivers -> PPS to see the PTP clock options.*
*#*
*CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=3Dy*
*# CONFIG_GPIOLIB is not set*
*# CONFIG_W1 is not set*
*# CONFIG_POWER_SUPPLY is not set*
*# CONFIG_HWMON is not set*
*# CONFIG_THERMAL is not set*
*# CONFIG_WATCHDOG is not set*
*CONFIG_SSB_POSSIBLE=3Dy*
*
*
*#*
*# Sonics Silicon Backplane*
*#*
*# CONFIG_SSB is not set*
*CONFIG_BCMA_POSSIBLE=3Dy*
*
*
*#*
*# Broadcom specific AMBA*
*#*
*# CONFIG_BCMA is not set*
*
*
*#*
*# Multifunction device drivers*
*#*
*# CONFIG_MFD_CORE is not set*
*# CONFIG_MFD_SM501 is not set*
*# CONFIG_HTC_PASIC3 is not set*
*# CONFIG_MFD_TMIO is not set*
*# CONFIG_MFD_T7L66XB is not set*
*# CONFIG_MFD_TC6387XB is not set*
*# CONFIG_ABX500_CORE is not set*
*# CONFIG_REGULATOR is not set*
*# CONFIG_MEDIA_SUPPORT is not set*
*
*
*#*
*# Graphics support*
*#*
*# CONFIG_DRM is not set*
*# CONFIG_VGASTATE is not set*
*# CONFIG_VIDEO_OUTPUT_CONTROL is not set*
*# CONFIG_FB is not set*
*# CONFIG_BACKLIGHT_LCD_SUPPORT is not set*
*
*
*#*
*# Display device support*
*#*
*# CONFIG_DISPLAY_SUPPORT is not set*
*
*
*#*
*# Console display driver support*
*#*
*CONFIG_DUMMY_CONSOLE=3Dy*
*CONFIG_SOUND=3Dy*
*CONFIG_SOUND_OSS_CORE=3Dy*
*CONFIG_SOUND_OSS_CORE_PRECLAIM=3Dy*
*CONFIG_SND=3Dy*
*CONFIG_SND_TIMER=3Dy*
*CONFIG_SND_PCM=3Dy*
*# CONFIG_SND_SEQUENCER is not set*
*CONFIG_SND_OSSEMUL=3Dy*
*CONFIG_SND_MIXER_OSS=3Dy*
*CONFIG_SND_PCM_OSS=3Dy*
*CONFIG_SND_PCM_OSS_PLUGINS=3Dy*
*# CONFIG_SND_HRTIMER is not set*
*# CONFIG_SND_DYNAMIC_MINORS is not set*
*CONFIG_SND_SUPPORT_OLD_API=3Dy*
*CONFIG_SND_VERBOSE_PROCFS=3Dy*
*# CONFIG_SND_VERBOSE_PRINTK is not set*
*# CONFIG_SND_DEBUG is not set*
*CONFIG_SND_VMASTER=3Dy*
*# CONFIG_SND_RAWMIDI_SEQ is not set*
*# CONFIG_SND_OPL3_LIB_SEQ is not set*
*# CONFIG_SND_OPL4_LIB_SEQ is not set*
*# CONFIG_SND_SBAWE_SEQ is not set*
*# CONFIG_SND_EMU10K1_SEQ is not set*
*CONFIG_SND_AC97_CODEC=3Dy*
*# CONFIG_SND_DRIVERS is not set*
*CONFIG_SND_ARM=3Dy*
*CONFIG_SND_ARMAACI=3Dy*
*CONFIG_SND_USB=3Dy*
*# CONFIG_SND_USB_AUDIO is not set*
*# CONFIG_SND_USB_UA101 is not set*
*# CONFIG_SND_USB_CAIAQ is not set*
*# CONFIG_SND_USB_6FIRE is not set*
*# CONFIG_SND_SOC is not set*
*# CONFIG_SOUND_PRIME is not set*
*CONFIG_AC97_BUS=3Dy*
*CONFIG_HID_SUPPORT=3Dy*
*CONFIG_HID=3Dy*
*# CONFIG_HIDRAW is not set*
*
*
*#*
*# USB Input Devices*
*#*
*CONFIG_USB_HID=3Dy*
*# CONFIG_HID_PID is not set*
*# CONFIG_USB_HIDDEV is not set*
*
*
*#*
*# Special HID drivers*
*#*
*# CONFIG_HID_A4TECH is not set*
*# CONFIG_HID_ACRUX is not set*
*# CONFIG_HID_APPLE is not set*
*# CONFIG_HID_BELKIN is not set*
*# CONFIG_HID_CHERRY is not set*
*# CONFIG_HID_CHICONY is not set*
*# CONFIG_HID_PRODIKEYS is not set*
*# CONFIG_HID_CYPRESS is not set*
*CONFIG_HID_DRAGONRISE=3Dy*
*# CONFIG_DRAGONRISE_FF is not set*
*# CONFIG_HID_EMS_FF is not set*
*# CONFIG_HID_EZKEY is not set*
*# CONFIG_HID_HOLTEK is not set*
*# CONFIG_HID_KEYTOUCH is not set*
*# CONFIG_HID_KYE is not set*
*# CONFIG_HID_UCLOGIC is not set*
*# CONFIG_HID_WALTOP is not set*
*CONFIG_HID_GYRATION=3Dy*
*CONFIG_HID_TWINHAN=3Dy*
*# CONFIG_HID_KENSINGTON is not set*
*# CONFIG_HID_LCPOWER is not set*
*# CONFIG_HID_LOGITECH is not set*
*# CONFIG_HID_MICROSOFT is not set*
*# CONFIG_HID_MONTEREY is not set*
*# CONFIG_HID_MULTITOUCH is not set*
*CONFIG_HID_NTRIG=3Dy*
*# CONFIG_HID_ORTEK is not set*
*CONFIG_HID_PANTHERLORD=3Dy*
*# CONFIG_PANTHERLORD_FF is not set*
*CONFIG_HID_PETALYNX=3Dy*
*# CONFIG_HID_PICOLCD is not set*
*# CONFIG_HID_PRIMAX is not set*
*# CONFIG_HID_QUANTA is not set*
*# CONFIG_HID_ROCCAT is not set*
*CONFIG_HID_SAMSUNG=3Dy*
*CONFIG_HID_SONY=3Dy*
*# CONFIG_HID_SPEEDLINK is not set*
*CONFIG_HID_SUNPLUS=3Dy*
*CONFIG_HID_GREENASIA=3Dy*
*# CONFIG_GREENASIA_FF is not set*
*CONFIG_HID_SMARTJOYPLUS=3Dy*
*# CONFIG_SMARTJOYPLUS_FF is not set*
*CONFIG_HID_TOPSEED=3Dy*
*CONFIG_HID_THRUSTMASTER=3Dy*
*# CONFIG_THRUSTMASTER_FF is not set*
*CONFIG_HID_ZEROPLUS=3Dy*
*# CONFIG_ZEROPLUS_FF is not set*
*# CONFIG_HID_ZYDACRON is not set*
*CONFIG_USB_SUPPORT=3Dy*
*CONFIG_USB_COMMON=3Dy*
*CONFIG_USB_ARCH_HAS_HCD=3Dy*
*# CONFIG_USB_ARCH_HAS_OHCI is not set*
*# CONFIG_USB_ARCH_HAS_EHCI is not set*
*# CONFIG_USB_ARCH_HAS_XHCI is not set*
*CONFIG_USB=3Dy*
*# CONFIG_USB_DEBUG is not set*
*CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy*
*
*
*#*
*# Miscellaneous USB options*
*#*
*CONFIG_USB_DEVICEFS=3Dy*
*# CONFIG_USB_DEVICE_CLASS is not set*
*# CONFIG_USB_DYNAMIC_MINORS is not set*
*# CONFIG_USB_OTG_WHITELIST is not set*
*# CONFIG_USB_OTG_BLACKLIST_HUB is not set*
*# CONFIG_USB_DWC3 is not set*
*CONFIG_USB_MON=3Dy*
*# CONFIG_USB_WUSB is not set*
*# CONFIG_USB_WUSB_CBAF is not set*
*
*
*#*
*# USB Host Controller Drivers*
*#*
*# CONFIG_USB_C67X00_HCD is not set*
*# CONFIG_USB_OXU210HP_HCD is not set*
*# CONFIG_USB_ISP116X_HCD is not set*
*CONFIG_USB_ISP1760_HCD=3Dy*
*# CONFIG_USB_ISP1362_HCD is not set*
*# CONFIG_USB_SL811_HCD is not set*
*# CONFIG_USB_R8A66597_HCD is not set*
*# CONFIG_USB_HWA_HCD is not set*
*
*
*#*
*# USB Device Class drivers*
*#*
*# CONFIG_USB_ACM is not set*
*# CONFIG_USB_PRINTER is not set*
*# CONFIG_USB_WDM is not set*
*# CONFIG_USB_TMC is not set*
*
*
*#*
*# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may*
*#*
*
*
*#*
*# also be needed; see USB_STORAGE Help for more info*
*#*
*CONFIG_USB_STORAGE=3Dy*
*# CONFIG_USB_STORAGE_DEBUG is not set*
*# CONFIG_USB_STORAGE_REALTEK is not set*
*# CONFIG_USB_STORAGE_DATAFAB is not set*
*# CONFIG_USB_STORAGE_FREECOM is not set*
*# CONFIG_USB_STORAGE_ISD200 is not set*
*# CONFIG_USB_STORAGE_USBAT is not set*
*# CONFIG_USB_STORAGE_SDDR09 is not set*
*# CONFIG_USB_STORAGE_SDDR55 is not set*
*# CONFIG_USB_STORAGE_JUMPSHOT is not set*
*# CONFIG_USB_STORAGE_ALAUDA is not set*
*# CONFIG_USB_STORAGE_ONETOUCH is not set*
*# CONFIG_USB_STORAGE_KARMA is not set*
*# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set*
*# CONFIG_USB_STORAGE_ENE_UB6250 is not set*
*# CONFIG_USB_UAS is not set*
*# CONFIG_USB_LIBUSUAL is not set*
*
*
*#*
*# USB Imaging devices*
*#*
*# CONFIG_USB_MDC800 is not set*
*# CONFIG_USB_MICROTEK is not set*
*
*
*#*
*# USB port drivers*
*#*
*# CONFIG_USB_SERIAL is not set*
*
*
*#*
*# USB Miscellaneous drivers*
*#*
*# CONFIG_USB_EMI62 is not set*
*# CONFIG_USB_EMI26 is not set*
*# CONFIG_USB_ADUTUX is not set*
*# CONFIG_USB_SEVSEG is not set*
*# CONFIG_USB_RIO500 is not set*
*# CONFIG_USB_LEGOTOWER is not set*
*# CONFIG_USB_LCD is not set*
*# CONFIG_USB_LED is not set*
*# CONFIG_USB_CYPRESS_CY7C63 is not set*
*# CONFIG_USB_CYTHERM is not set*
*# CONFIG_USB_IDMOUSE is not set*
*# CONFIG_USB_FTDI_ELAN is not set*
*# CONFIG_USB_APPLEDISPLAY is not set*
*# CONFIG_USB_LD is not set*
*# CONFIG_USB_TRANCEVIBRATOR is not set*
*# CONFIG_USB_IOWARRIOR is not set*
*# CONFIG_USB_TEST is not set*
*# CONFIG_USB_ISIGHTFW is not set*
*# CONFIG_USB_YUREX is not set*
*# CONFIG_USB_GADGET is not set*
*
*
*#*
*# OTG and related infrastructure*
*#*
*# CONFIG_USB_ULPI is not set*
*# CONFIG_NOP_USB_XCEIV is not set*
*CONFIG_MMC=3Dy*
*CONFIG_MMC_DEBUG=3Dy*
*# CONFIG_MMC_UNSAFE_RESUME is not set*
*# CONFIG_MMC_CLKGATE is not set*
*
*
*#*
*# MMC/SD/SDIO Card Drivers*
*#*
*CONFIG_MMC_BLOCK=3Dy*
*CONFIG_MMC_BLOCK_MINORS=3D8*
*CONFIG_MMC_BLOCK_BOUNCE=3Dy*
*# CONFIG_SDIO_UART is not set*
*# CONFIG_MMC_TEST is not set*
*
*
*#*
*# MMC/SD/SDIO Host Controller Drivers*
*#*
*CONFIG_MMC_ARMMMCI=3Dy*
*CONFIG_MMC_SDHCI=3Dy*
*CONFIG_MMC_SDHCI_PLTFM=3Dy*
*# CONFIG_MMC_SDHCI_PXAV3 is not set*
*# CONFIG_MMC_SDHCI_PXAV2 is not set*
*# CONFIG_MMC_DW is not set*
*# CONFIG_MMC_VUB300 is not set*
*# CONFIG_MMC_USHC is not set*
*# CONFIG_MEMSTICK is not set*
*# CONFIG_NEW_LEDS is not set*
*# CONFIG_ACCESSIBILITY is not set*
*CONFIG_RTC_LIB=3Dy*
*CONFIG_RTC_CLASS=3Dy*
*CONFIG_RTC_HCTOSYS=3Dy*
*CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"*
*# CONFIG_RTC_DEBUG is not set*
*
*
*#*
*# RTC interfaces*
*#*
*CONFIG_RTC_INTF_SYSFS=3Dy*
*CONFIG_RTC_INTF_PROC=3Dy*
*CONFIG_RTC_INTF_DEV=3Dy*
*# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set*
*# CONFIG_RTC_DRV_TEST is not set*
*
*
*#*
*# SPI RTC drivers*
*#*
*
*
*#*
*# Platform RTC drivers*
*#*
*# CONFIG_RTC_DRV_CMOS is not set*
*# CONFIG_RTC_DRV_DS1286 is not set*
*# CONFIG_RTC_DRV_DS1511 is not set*
*# CONFIG_RTC_DRV_DS1553 is not set*
*# CONFIG_RTC_DRV_DS1742 is not set*
*# CONFIG_RTC_DRV_STK17TA8 is not set*
*# CONFIG_RTC_DRV_M48T86 is not set*
*# CONFIG_RTC_DRV_M48T35 is not set*
*# CONFIG_RTC_DRV_M48T59 is not set*
*# CONFIG_RTC_DRV_MSM6242 is not set*
*# CONFIG_RTC_DRV_BQ4802 is not set*
*# CONFIG_RTC_DRV_RP5C01 is not set*
*# CONFIG_RTC_DRV_V3020 is not set*
*
*
*#*
*# on-CPU RTC drivers*
*#*
*# CONFIG_RTC_DRV_PL030 is not set*
*CONFIG_RTC_DRV_PL031=3Dy*
*# CONFIG_DMADEVICES is not set*
*# CONFIG_AUXDISPLAY is not set*
*# CONFIG_UIO is not set*
*
*
*#*
*# Virtio drivers*
*#*
*# CONFIG_VIRTIO_BALLOON is not set*
*# CONFIG_VIRTIO_MMIO is not set*
*# CONFIG_STAGING is not set*
*CONFIG_CLKDEV_LOOKUP=3Dy*
*CONFIG_HAVE_MACH_CLKDEV=3Dy*
*
*
*#*
*# Hardware Spinlock drivers*
*#*
*CONFIG_CLKSRC_MMIO=3Dy*
*CONFIG_IOMMU_SUPPORT=3Dy*
*# CONFIG_VIRT_DRIVERS is not set*
*# CONFIG_PM_DEVFREQ is not set*
*
*
*#*
*# File systems*
*#*
*CONFIG_EXT2_FS=3Dy*
*# CONFIG_EXT2_FS_XATTR is not set*
*# CONFIG_EXT2_FS_XIP is not set*
*CONFIG_EXT3_FS=3Dy*
*# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set*
*# CONFIG_EXT3_FS_XATTR is not set*
*CONFIG_EXT4_FS=3Dy*
*CONFIG_EXT4_FS_XATTR=3Dy*
*# CONFIG_EXT4_FS_POSIX_ACL is not set*
*# CONFIG_EXT4_FS_SECURITY is not set*
*# CONFIG_EXT4_DEBUG is not set*
*CONFIG_JBD=3Dy*
*# CONFIG_JBD_DEBUG is not set*
*CONFIG_JBD2=3Dy*
*# CONFIG_JBD2_DEBUG is not set*
*CONFIG_FS_MBCACHE=3Dy*
*# CONFIG_REISERFS_FS is not set*
*# CONFIG_JFS_FS is not set*
*# CONFIG_XFS_FS is not set*
*# CONFIG_BTRFS_FS is not set*
*# CONFIG_NILFS2_FS is not set*
*# CONFIG_FS_POSIX_ACL is not set*
*CONFIG_FILE_LOCKING=3Dy*
*CONFIG_FSNOTIFY=3Dy*
*CONFIG_DNOTIFY=3Dy*
*CONFIG_INOTIFY_USER=3Dy*
*# CONFIG_FANOTIFY is not set*
*# CONFIG_QUOTA is not set*
*# CONFIG_QUOTACTL is not set*
*# CONFIG_AUTOFS4_FS is not set*
*# CONFIG_FUSE_FS is not set*
*
*
*#*
*# Caches*
*#*
*# CONFIG_FSCACHE is not set*
*
*
*#*
*# CD-ROM/DVD Filesystems*
*#*
*# CONFIG_ISO9660_FS is not set*
*# CONFIG_UDF_FS is not set*
*
*
*#*
*# DOS/FAT/NT Filesystems*
*#*
*CONFIG_FAT_FS=3Dy*
*# CONFIG_MSDOS_FS is not set*
*CONFIG_VFAT_FS=3Dy*
*CONFIG_FAT_DEFAULT_CODEPAGE=3D437*
*CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"*
*# CONFIG_NTFS_FS is not set*
*
*
*#*
*# Pseudo filesystems*
*#*
*CONFIG_PROC_FS=3Dy*
*CONFIG_PROC_SYSCTL=3Dy*
*CONFIG_PROC_PAGE_MONITOR=3Dy*
*CONFIG_SYSFS=3Dy*
*CONFIG_TMPFS=3Dy*
*# CONFIG_TMPFS_POSIX_ACL is not set*
*# CONFIG_TMPFS_XATTR is not set*
*# CONFIG_HUGETLB_PAGE is not set*
*# CONFIG_CONFIGFS_FS is not set*
*CONFIG_MISC_FILESYSTEMS=3Dy*
*# CONFIG_ADFS_FS is not set*
*# CONFIG_AFFS_FS is not set*
*# CONFIG_HFS_FS is not set*
*# CONFIG_HFSPLUS_FS is not set*
*# CONFIG_BEFS_FS is not set*
*# CONFIG_BFS_FS is not set*
*# CONFIG_EFS_FS is not set*
*CONFIG_JFFS2_FS=3Dy*
*CONFIG_JFFS2_FS_DEBUG=3D0*
*CONFIG_JFFS2_FS_WRITEBUFFER=3Dy*
*# CONFIG_JFFS2_FS_WBUF_VERIFY is not set*
*# CONFIG_JFFS2_SUMMARY is not set*
*# CONFIG_JFFS2_FS_XATTR is not set*
*# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set*
*CONFIG_JFFS2_ZLIB=3Dy*
*# CONFIG_JFFS2_LZO is not set*
*CONFIG_JFFS2_RTIME=3Dy*
*# CONFIG_JFFS2_RUBIN is not set*
*# CONFIG_LOGFS is not set*
*CONFIG_CRAMFS=3Dy*
*# CONFIG_SQUASHFS is not set*
*# CONFIG_VXFS_FS is not set*
*# CONFIG_MINIX_FS is not set*
*# CONFIG_OMFS_FS is not set*
*# CONFIG_HPFS_FS is not set*
*# CONFIG_QNX4FS_FS is not set*
*# CONFIG_ROMFS_FS is not set*
*# CONFIG_PSTORE is not set*
*# CONFIG_SYSV_FS is not set*
*# CONFIG_UFS_FS is not set*
*# CONFIG_NETWORK_FILESYSTEMS is not set*
*
*
*#*
*# Partition Types*
*#*
*# CONFIG_PARTITION_ADVANCED is not set*
*CONFIG_MSDOS_PARTITION=3Dy*
*CONFIG_NLS=3Dy*
*CONFIG_NLS_DEFAULT=3D"iso8859-1"*
*CONFIG_NLS_CODEPAGE_437=3Dy*
*# CONFIG_NLS_CODEPAGE_737 is not set*
*# CONFIG_NLS_CODEPAGE_775 is not set*
*# CONFIG_NLS_CODEPAGE_850 is not set*
*# CONFIG_NLS_CODEPAGE_852 is not set*
*# CONFIG_NLS_CODEPAGE_855 is not set*
*# CONFIG_NLS_CODEPAGE_857 is not set*
*# CONFIG_NLS_CODEPAGE_860 is not set*
*# CONFIG_NLS_CODEPAGE_861 is not set*
*# CONFIG_NLS_CODEPAGE_862 is not set*
*# CONFIG_NLS_CODEPAGE_863 is not set*
*# CONFIG_NLS_CODEPAGE_864 is not set*
*# CONFIG_NLS_CODEPAGE_865 is not set*
*# CONFIG_NLS_CODEPAGE_866 is not set*
*# CONFIG_NLS_CODEPAGE_869 is not set*
*# CONFIG_NLS_CODEPAGE_936 is not set*
*# CONFIG_NLS_CODEPAGE_950 is not set*
*# CONFIG_NLS_CODEPAGE_932 is not set*
*# CONFIG_NLS_CODEPAGE_949 is not set*
*# CONFIG_NLS_CODEPAGE_874 is not set*
*# CONFIG_NLS_ISO8859_8 is not set*
*# CONFIG_NLS_CODEPAGE_1250 is not set*
*# CONFIG_NLS_CODEPAGE_1251 is not set*
*# CONFIG_NLS_ASCII is not set*
*CONFIG_NLS_ISO8859_1=3Dy*
*# CONFIG_NLS_ISO8859_2 is not set*
*# CONFIG_NLS_ISO8859_3 is not set*
*# CONFIG_NLS_ISO8859_4 is not set*
*# CONFIG_NLS_ISO8859_5 is not set*
*# CONFIG_NLS_ISO8859_6 is not set*
*# CONFIG_NLS_ISO8859_7 is not set*
*# CONFIG_NLS_ISO8859_9 is not set*
*# CONFIG_NLS_ISO8859_13 is not set*
*# CONFIG_NLS_ISO8859_14 is not set*
*# CONFIG_NLS_ISO8859_15 is not set*
*# CONFIG_NLS_KOI8_R is not set*
*# CONFIG_NLS_KOI8_U is not set*
*# CONFIG_NLS_UTF8 is not set*
*
*
*#*
*# Kernel hacking*
*#*
*# CONFIG_PRINTK_TIME is not set*
*CONFIG_DEFAULT_MESSAGE_LOGLEVEL=3D4*
*CONFIG_ENABLE_WARN_DEPRECATED=3Dy*
*CONFIG_ENABLE_MUST_CHECK=3Dy*
*CONFIG_FRAME_WARN=3D1024*
*CONFIG_MAGIC_SYSRQ=3Dy*
*# CONFIG_STRIP_ASM_SYMS is not set*
*# CONFIG_UNUSED_SYMBOLS is not set*
*CONFIG_DEBUG_FS=3Dy*
*# CONFIG_HEADERS_CHECK is not set*
*# CONFIG_DEBUG_SECTION_MISMATCH is not set*
*CONFIG_IPIPE_DEBUG=3Dy*
*CONFIG_IPIPE_DEBUG_CONTEXT=3Dy*
*CONFIG_IPIPE_DEBUG_INTERNAL=3Dy*
*CONFIG_IPIPE_TRACE=3Dy*
*CONFIG_IPIPE_TRACE_ENABLE=3Dy*
*CONFIG_IPIPE_TRACE_MCOUNT=3Dy*
*CONFIG_IPIPE_TRACE_IRQSOFF=3Dy*
*CONFIG_IPIPE_TRACE_SHIFT=3D14*
*CONFIG_IPIPE_TRACE_VMALLOC=3Dy*
*CONFIG_IPIPE_TRACE_PANIC=3Dy*
*CONFIG_DEBUG_KERNEL=3Dy*
*CONFIG_DEBUG_SHIRQ=3Dy*
*CONFIG_LOCKUP_DETECTOR=3Dy*
*# CONFIG_HARDLOCKUP_DETECTOR is not set*
*# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set*
*CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=3D0*
*# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set*
*CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0*
*CONFIG_DETECT_HUNG_TASK=3Dy*
*CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D120*
*# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set*
*CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0*
*# CONFIG_SCHED_DEBUG is not set*
*# CONFIG_SCHEDSTATS is not set*
*# CONFIG_TIMER_STATS is not set*
*CONFIG_DEBUG_OBJECTS=3Dy*
*CONFIG_DEBUG_OBJECTS_SELFTEST=3Dy*
*CONFIG_DEBUG_OBJECTS_FREE=3Dy*
*CONFIG_DEBUG_OBJECTS_TIMERS=3Dy*
*CONFIG_DEBUG_OBJECTS_WORK=3Dy*
*CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy*
*CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=3Dy*
*CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=3D1*
*CONFIG_DEBUG_SLAB=3Dy*
*CONFIG_DEBUG_SLAB_LEAK=3Dy*
*CONFIG_DEBUG_KMEMLEAK=3Dy*
*CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=3D400*
*# CONFIG_DEBUG_KMEMLEAK_TEST is not set*
*# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set*
*CONFIG_DEBUG_RT_MUTEXES=3Dy*
*CONFIG_DEBUG_PI_LIST=3Dy*
*# CONFIG_RT_MUTEX_TESTER is not set*
*CONFIG_DEBUG_SPINLOCK=3Dy*
*CONFIG_DEBUG_MUTEXES=3Dy*
*CONFIG_DEBUG_LOCK_ALLOC=3Dy*
*CONFIG_PROVE_LOCKING=3Dy*
*CONFIG_PROVE_RCU=3Dy*
*CONFIG_PROVE_RCU_REPEATEDLY=3Dy*
*CONFIG_SPARSE_RCU_POINTER=3Dy*
*CONFIG_LOCKDEP=3Dy*
*# CONFIG_LOCK_STAT is not set*
*# CONFIG_DEBUG_LOCKDEP is not set*
*CONFIG_TRACE_IRQFLAGS=3Dy*
*# CONFIG_DEBUG_ATOMIC_SLEEP is not set*
*# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set*
*CONFIG_STACKTRACE=3Dy*
*# CONFIG_DEBUG_STACK_USAGE is not set*
*# CONFIG_DEBUG_KOBJECT is not set*
*CONFIG_DEBUG_BUGVERBOSE=3Dy*
*CONFIG_DEBUG_INFO=3Dy*
*# CONFIG_DEBUG_INFO_REDUCED is not set*
*CONFIG_DEBUG_VM=3Dy*
*CONFIG_DEBUG_WRITECOUNT=3Dy*
*CONFIG_DEBUG_MEMORY_INIT=3Dy*
*CONFIG_DEBUG_LIST=3Dy*
*# CONFIG_TEST_LIST_SORT is not set*
*CONFIG_DEBUG_SG=3Dy*
*CONFIG_DEBUG_NOTIFIERS=3Dy*
*CONFIG_DEBUG_CREDENTIALS=3Dy*
*CONFIG_ARCH_WANT_FRAME_POINTERS=3Dy*
*CONFIG_FRAME_POINTER=3Dy*
*# CONFIG_BOOT_PRINTK_DELAY is not set*
*# CONFIG_RCU_TORTURE_TEST is not set*
*# CONFIG_BACKTRACE_SELF_TEST is not set*
*# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set*
*# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set*
*# CONFIG_LKDTM is not set*
*# CONFIG_FAULT_INJECTION is not set*
*# CONFIG_LATENCYTOP is not set*
*# CONFIG_SYSCTL_SYSCALL_CHECK is not set*
*CONFIG_DEBUG_PAGEALLOC=3Dy*
*CONFIG_WANT_PAGE_DEBUG_FLAGS=3Dy*
*CONFIG_PAGE_POISONING=3Dy*
*CONFIG_NOP_TRACER=3Dy*
*CONFIG_HAVE_FUNCTION_TRACER=3Dy*
*CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy*
*CONFIG_HAVE_DYNAMIC_FTRACE=3Dy*
*CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy*
*CONFIG_HAVE_C_RECORDMCOUNT=3Dy*
*CONFIG_RING_BUFFER=3Dy*
*CONFIG_EVENT_TRACING=3Dy*
*CONFIG_EVENT_POWER_TRACING_DEPRECATED=3Dy*
*CONFIG_CONTEXT_SWITCH_TRACER=3Dy*
*CONFIG_RING_BUFFER_ALLOW_SWAP=3Dy*
*CONFIG_TRACING=3Dy*
*CONFIG_GENERIC_TRACER=3Dy*
*CONFIG_TRACING_SUPPORT=3Dy*
*CONFIG_FTRACE=3Dy*
*CONFIG_FUNCTION_TRACER=3Dy*
*CONFIG_FUNCTION_GRAPH_TRACER=3Dy*
*# CONFIG_IRQSOFF_TRACER is not set*
*# CONFIG_SCHED_TRACER is not set*
*CONFIG_BRANCH_PROFILE_NONE=3Dy*
*# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set*
*# CONFIG_PROFILE_ALL_BRANCHES is not set*
*# CONFIG_STACK_TRACER is not set*
*# CONFIG_BLK_DEV_IO_TRACE is not set*
*# CONFIG_FUNCTION_PROFILER is not set*
*# CONFIG_FTRACE_STARTUP_TEST is not set*
*# CONFIG_RING_BUFFER_BENCHMARK is not set*
*# CONFIG_DYNAMIC_DEBUG is not set*
*# CONFIG_DMA_API_DEBUG is not set*
*# CONFIG_ATOMIC64_SELFTEST is not set*
*# CONFIG_SAMPLES is not set*
*CONFIG_HAVE_ARCH_KGDB=3Dy*
*# CONFIG_KGDB is not set*
*# CONFIG_TEST_KSTRTOX is not set*
*# CONFIG_STRICT_DEVMEM is not set*
*CONFIG_ARM_UNWIND=3Dy*
*CONFIG_OLD_MCOUNT=3Dy*
*CONFIG_DEBUG_USER=3Dy*
*CONFIG_DEBUG_LL=3Dy*
*CONFIG_DEBUG_LL_UART_NONE=3Dy*
*# CONFIG_DEBUG_ICEDCC is not set*
*CONFIG_EARLY_PRINTK=3Dy*
*# CONFIG_OC_ETM is not set*
*
*
*#*
*# Security options*
*#*
*# CONFIG_KEYS is not set*
*# CONFIG_SECURITY_DMESG_RESTRICT is not set*
*# CONFIG_SECURITY is not set*
*# CONFIG_SECURITYFS is not set*
*CONFIG_DEFAULT_SECURITY_DAC=3Dy*
*CONFIG_DEFAULT_SECURITY=3D""*
*CONFIG_CRYPTO=3Dy*
*
*
*#*
*# Crypto core or helper*
*#*
*# CONFIG_CRYPTO_MANAGER is not set*
*# CONFIG_CRYPTO_MANAGER2 is not set*
*# CONFIG_CRYPTO_USER is not set*
*# CONFIG_CRYPTO_GF128MUL is not set*
*# CONFIG_CRYPTO_NULL is not set*
*# CONFIG_CRYPTO_CRYPTD is not set*
*# CONFIG_CRYPTO_AUTHENC is not set*
*# CONFIG_CRYPTO_TEST is not set*
*
*
*#*
*# Authenticated Encryption with Associated Data*
*#*
*# CONFIG_CRYPTO_CCM is not set*
*# CONFIG_CRYPTO_GCM is not set*
*# CONFIG_CRYPTO_SEQIV is not set*
*
*
*#*
*# Block modes*
*#*
*# CONFIG_CRYPTO_CBC is not set*
*# CONFIG_CRYPTO_CTR is not set*
*# CONFIG_CRYPTO_CTS is not set*
*# CONFIG_CRYPTO_ECB is not set*
*# CONFIG_CRYPTO_LRW is not set*
*# CONFIG_CRYPTO_PCBC is not set*
*# CONFIG_CRYPTO_XTS is not set*
*
*
*#*
*# Hash modes*
*#*
*# CONFIG_CRYPTO_HMAC is not set*
*# CONFIG_CRYPTO_XCBC is not set*
*# CONFIG_CRYPTO_VMAC is not set*
*
*
*#*
*# Digest*
*#*
*# CONFIG_CRYPTO_CRC32C is not set*
*# CONFIG_CRYPTO_GHASH is not set*
*# CONFIG_CRYPTO_MD4 is not set*
*# CONFIG_CRYPTO_MD5 is not set*
*# CONFIG_CRYPTO_MICHAEL_MIC is not set*
*# CONFIG_CRYPTO_RMD128 is not set*
*# CONFIG_CRYPTO_RMD160 is not set*
*# CONFIG_CRYPTO_RMD256 is not set*
*# CONFIG_CRYPTO_RMD320 is not set*
*# CONFIG_CRYPTO_SHA1 is not set*
*# CONFIG_CRYPTO_SHA256 is not set*
*# CONFIG_CRYPTO_SHA512 is not set*
*# CONFIG_CRYPTO_TGR192 is not set*
*# CONFIG_CRYPTO_WP512 is not set*
*
*
*#*
*# Ciphers*
*#*
*# CONFIG_CRYPTO_AES is not set*
*# CONFIG_CRYPTO_ANUBIS is not set*
*# CONFIG_CRYPTO_ARC4 is not set*
*# CONFIG_CRYPTO_BLOWFISH is not set*
*# CONFIG_CRYPTO_CAMELLIA is not set*
*# CONFIG_CRYPTO_CAST5 is not set*
*# CONFIG_CRYPTO_CAST6 is not set*
*# CONFIG_CRYPTO_DES is not set*
*# CONFIG_CRYPTO_FCRYPT is not set*
*# CONFIG_CRYPTO_KHAZAD is not set*
*# CONFIG_CRYPTO_SALSA20 is not set*
*# CONFIG_CRYPTO_SEED is not set*
*# CONFIG_CRYPTO_SERPENT is not set*
*# CONFIG_CRYPTO_TEA is not set*
*# CONFIG_CRYPTO_TWOFISH is not set*
*
*
*#*
*# Compression*
*#*
*# CONFIG_CRYPTO_DEFLATE is not set*
*# CONFIG_CRYPTO_ZLIB is not set*
*# CONFIG_CRYPTO_LZO is not set*
*
*
*#*
*# Random Number Generation*
*#*
*# CONFIG_CRYPTO_ANSI_CPRNG is not set*
*# CONFIG_CRYPTO_USER_API_HASH is not set*
*# CONFIG_CRYPTO_USER_API_SKCIPHER is not set*
*# CONFIG_CRYPTO_HW is not set*
*CONFIG_BINARY_PRINTF=3Dy*
*
*
*#*
*# Library routines*
*#*
*CONFIG_BITREVERSE=3Dy*
*# CONFIG_CRC_CCITT is not set*
*CONFIG_CRC16=3Dy*
*# CONFIG_CRC_T10DIF is not set*
*# CONFIG_CRC_ITU_T is not set*
*CONFIG_CRC32=3Dy*
*# CONFIG_CRC7 is not set*
*# CONFIG_LIBCRC32C is not set*
*# CONFIG_CRC8 is not set*
*CONFIG_ZLIB_INFLATE=3Dy*
*CONFIG_ZLIB_DEFLATE=3Dy*
*CONFIG_XZ_DEC=3Dy*
*CONFIG_XZ_DEC_X86=3Dy*
*CONFIG_XZ_DEC_POWERPC=3Dy*
*CONFIG_XZ_DEC_IA64=3Dy*
*CONFIG_XZ_DEC_ARM=3Dy*
*CONFIG_XZ_DEC_ARMTHUMB=3Dy*
*CONFIG_XZ_DEC_SPARC=3Dy*
*CONFIG_XZ_DEC_BCJ=3Dy*
*# CONFIG_XZ_DEC_TEST is not set*
*CONFIG_DECOMPRESS_GZIP=3Dy*
*CONFIG_HAS_IOMEM=3Dy*
*CONFIG_HAS_IOPORT=3Dy*
*CONFIG_HAS_DMA=3Dy*
*CONFIG_NLATTR=3Dy*
*# CONFIG_AVERAGE is not set*
*# CONFIG_CORDIC is not set*


> Also, if you have all Xenomai and I-pipe debug options enabled, could
> you try disabling them?
>
> I will, first thing in the morning.

> Xenomai: suspending kernel thread 82922908 ('rtk5/0') at 0x8005bbc8
> after exception #0x0
>
> This looks like the same bug as in the previous mail. We desperately
> would like to know what is at 0x8005bbc8
>

But I don't have j-tag available to use - at least for now.
KGDB as far as I know doesn't correspond to xenomai 2.6.1, am I right? Or
maybe it is worth trying to use kgdb to specify the value of those
addresses?


Looking forward to hearing from you tomorrow,
I appreciate your help,

--=20
Marcin Ku=B6ka
