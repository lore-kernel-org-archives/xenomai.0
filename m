Message-ID: <4EB6CA3B.1040608@domain.hid>
Date: Sun, 06 Nov 2011 11:56:11 -0600
From: at91_enthus <nwromania@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010402040909010400000808"
Subject: [Xenomai-help] Xenomai 2.6.0 - kernel seg faults on AT91
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

This is a multi-part message in MIME format.
--------------010402040909010400000808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi.

I gave Xenomai 2.6.0 a try and installed a newly patched kernel on my
AT91SAM9G20 board.

Here is my setup:

proc:   AT91SAM9G20
kernel: 2.6.35.9
OS: embedded Debian Squeeze

The board boots fine up to stage 2 (user terminal). Sometimes, I am able
to get a login terminal, despite seg fault messages.

A similar behavior occurs in a Xenomai capable 2.6.37 kernel, only
without the fault messages. In this case the board simply freezes.

I included the files (.config and fault messages) in the attachments.

Thanks.

--------------010402040909010400000808
Content-Type: text/plain;
 name="config1-xenomai"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config1-xenomai"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.35.9
# Sun Nov  6 11:24:54 2011
#
CONFIG_ARM=y
CONFIG_SYS_SUPPORTS_APM_EMULATION=y
CONFIG_GENERIC_GPIO=y
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_TIME_VSYSCALL=y
# CONFIG_ARCH_USES_GETTIMEOFFSET is not set
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_HAVE_PROC_CPU=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
CONFIG_VECTORS_BASE=0xffff0000
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_CONSTRUCTORS=y

#
# General setup
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
CONFIG_LOCALVERSION="-xenomai"
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_LZO is not set
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
CONFIG_TREE_RCU=y
# CONFIG_TREE_PREEMPT_RCU is not set
# CONFIG_TINY_RCU is not set
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_FANOUT=32
# CONFIG_RCU_FANOUT_EXACT is not set
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_CGROUPS is not set
CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y
# CONFIG_RELAY is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
# CONFIG_NET_NS is not set
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
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
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y

#
# Kernel Performance Events And Counters
#
# CONFIG_PERF_EVENTS is not set
# CONFIG_PERF_COUNTERS is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_COMPAT_BRK=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
# CONFIG_PROFILING is not set
CONFIG_HAVE_OPROFILE=y
# CONFIG_KPROBES is not set
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_CLK=y

#
# GCOV-based kernel profiling
#
# CONFIG_SLOW_WORK is not set
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
CONFIG_LBDAF=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_BLK_DEV_INTEGRITY is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
# CONFIG_INLINE_SPIN_TRYLOCK is not set
# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
# CONFIG_INLINE_SPIN_LOCK is not set
# CONFIG_INLINE_SPIN_LOCK_BH is not set
# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
CONFIG_INLINE_SPIN_UNLOCK=y
# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
# CONFIG_INLINE_READ_TRYLOCK is not set
# CONFIG_INLINE_READ_LOCK is not set
# CONFIG_INLINE_READ_LOCK_BH is not set
# CONFIG_INLINE_READ_LOCK_IRQ is not set
# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
CONFIG_INLINE_READ_UNLOCK=y
# CONFIG_INLINE_READ_UNLOCK_BH is not set
CONFIG_INLINE_READ_UNLOCK_IRQ=y
# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
# CONFIG_INLINE_WRITE_TRYLOCK is not set
# CONFIG_INLINE_WRITE_LOCK is not set
# CONFIG_INLINE_WRITE_LOCK_BH is not set
# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
CONFIG_INLINE_WRITE_UNLOCK=y
# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
# CONFIG_MUTEX_SPIN_ON_OWNER is not set

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
CONFIG_XENO_OPT_VFILE=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_SYS_HEAPSZ=256
CONFIG_XENO_OPT_SYS_STACKPOOLSZ=128
CONFIG_XENO_OPT_SEM_HEAPSZ=12
CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ=12
CONFIG_XENO_OPT_STATS=y
CONFIG_XENO_OPT_DEBUG=y
# CONFIG_XENO_OPT_DEBUG_NUCLEUS is not set
# CONFIG_XENO_OPT_DEBUG_XNLOCK is not set
# CONFIG_XENO_OPT_DEBUG_QUEUES is not set
# CONFIG_XENO_OPT_DEBUG_REGISTRY is not set
# CONFIG_XENO_OPT_DEBUG_TIMERS is not set
# CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX is not set
CONFIG_XENO_OPT_WATCHDOG=y
CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=4
CONFIG_XENO_OPT_SHIRQ=y
CONFIG_XENO_OPT_SELECT=y
CONFIG_XENO_OPT_HOSTRT=y

#
# Timing
#
# CONFIG_XENO_OPT_TIMING_PERIODIC is not set
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
# CONFIG_XENO_OPT_POSIX_SHM is not set
# CONFIG_XENO_OPT_POSIX_INTR is not set
CONFIG_XENO_OPT_POSIX_SELECT=y
CONFIG_XENO_OPT_DEBUG_POSIX=y
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
# CONFIG_XENO_OPT_NOWARN_DEPRECATED is not set
CONFIG_XENO_SKIN_RTDM=y
CONFIG_XENO_OPT_RTDM_PERIOD=0
CONFIG_XENO_OPT_RTDM_FILDES=128
CONFIG_XENO_OPT_RTDM_SELECT=y
# CONFIG_XENO_OPT_DEBUG_RTDM is not set
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
CONFIG_XENO_DRIVERS_TIMERBENCH=y
# CONFIG_XENO_DRIVERS_KLATENCY is not set
# CONFIG_XENO_DRIVERS_IRQBENCH is not set
CONFIG_XENO_DRIVERS_SWITCHTEST=y
# CONFIG_XENO_DRIVERS_RTDMTEST is not set

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
CONFIG_FREEZER=y

#
# System Type
#
CONFIG_MMU=y
# CONFIG_ARCH_AAEC2000 is not set
# CONFIG_ARCH_INTEGRATOR is not set
# CONFIG_ARCH_REALVIEW is not set
# CONFIG_ARCH_VERSATILE is not set
# CONFIG_ARCH_VEXPRESS is not set
CONFIG_ARCH_AT91=y
# CONFIG_ARCH_BCMRING is not set
# CONFIG_ARCH_CLPS711X is not set
# CONFIG_ARCH_CNS3XXX is not set
# CONFIG_ARCH_GEMINI is not set
# CONFIG_ARCH_EBSA110 is not set
# CONFIG_ARCH_EP93XX is not set
# CONFIG_ARCH_FOOTBRIDGE is not set
# CONFIG_ARCH_MXC is not set
# CONFIG_ARCH_STMP3XXX is not set
# CONFIG_ARCH_NETX is not set
# CONFIG_ARCH_H720X is not set
# CONFIG_ARCH_IOP13XX is not set
# CONFIG_ARCH_IOP32X is not set
# CONFIG_ARCH_IOP33X is not set
# CONFIG_ARCH_IXP23XX is not set
# CONFIG_ARCH_IXP2000 is not set
# CONFIG_ARCH_IXP4XX is not set
# CONFIG_ARCH_L7200 is not set
# CONFIG_ARCH_DOVE is not set
# CONFIG_ARCH_KIRKWOOD is not set
# CONFIG_ARCH_LOKI is not set
# CONFIG_ARCH_MV78XX0 is not set
# CONFIG_ARCH_ORION5X is not set
# CONFIG_ARCH_MMP is not set
# CONFIG_ARCH_KS8695 is not set
# CONFIG_ARCH_NS9XXX is not set
# CONFIG_ARCH_W90X900 is not set
# CONFIG_ARCH_NUC93X is not set
# CONFIG_ARCH_PNX4008 is not set
# CONFIG_ARCH_PXA is not set
# CONFIG_ARCH_MSM is not set
# CONFIG_ARCH_SHMOBILE is not set
# CONFIG_ARCH_RPC is not set
# CONFIG_ARCH_SA1100 is not set
# CONFIG_ARCH_S3C2410 is not set
# CONFIG_ARCH_S3C64XX is not set
# CONFIG_ARCH_S5P6440 is not set
# CONFIG_ARCH_S5P6442 is not set
# CONFIG_ARCH_S5PC100 is not set
# CONFIG_ARCH_S5PV210 is not set
# CONFIG_ARCH_SHARK is not set
# CONFIG_ARCH_LH7A40X is not set
# CONFIG_ARCH_U300 is not set
# CONFIG_ARCH_U8500 is not set
# CONFIG_ARCH_NOMADIK is not set
# CONFIG_ARCH_DAVINCI is not set
# CONFIG_ARCH_OMAP is not set
# CONFIG_PLAT_SPEAR is not set
CONFIG_HAVE_AT91_USART3=y
CONFIG_HAVE_AT91_USART4=y
CONFIG_HAVE_AT91_USART5=y

#
# Atmel AT91 System-on-Chip
#
# CONFIG_ARCH_AT91RM9200 is not set
# CONFIG_ARCH_AT91SAM9260 is not set
# CONFIG_ARCH_AT91SAM9261 is not set
# CONFIG_ARCH_AT91SAM9G10 is not set
# CONFIG_ARCH_AT91SAM9263 is not set
# CONFIG_ARCH_AT91SAM9RL is not set
CONFIG_ARCH_AT91SAM9G20=y
# CONFIG_ARCH_AT91SAM9G45 is not set
# CONFIG_ARCH_AT91CAP9 is not set
# CONFIG_ARCH_AT572D940HF is not set
# CONFIG_ARCH_AT91X40 is not set
CONFIG_AT91_PMC_UNIT=y

#
# AT91SAM9G20 Board Type
#
# CONFIG_MACH_AT91SAM9G20EK is not set
# CONFIG_MACH_AT91SAM9G20EK_2MMC is not set
# CONFIG_MACH_CPU9G20 is not set
# CONFIG_MACH_PORTUXG20 is not set
# CONFIG_MACH_STAMP9G20 is not set
CONFIG_MACH_ELECTRUM_100=y

#
# Adeos I-pipe Options
#
CONFIG_IPIPE_AT91_TC=0

#
# AT91 Board Options
#

#
# AT91 Feature Selections
#
CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
# CONFIG_AT91_SLOW_CLOCK is not set
CONFIG_AT91_TIMER_HZ=1000
# CONFIG_AT91_EARLY_DBGU is not set
CONFIG_AT91_EARLY_USART0=y
# CONFIG_AT91_EARLY_USART1 is not set
# CONFIG_AT91_EARLY_USART2 is not set
# CONFIG_AT91_EARLY_USART3 is not set
# CONFIG_AT91_EARLY_USART4 is not set
# CONFIG_AT91_EARLY_USART5 is not set
CONFIG_IPIPE_ARM_KUSER_TSC=y

#
# Processor Type
#
CONFIG_CPU_ARM926T=y
CONFIG_CPU_32v5=y
CONFIG_CPU_ABRT_EV5TJ=y
CONFIG_CPU_PABRT_LEGACY=y
CONFIG_CPU_CACHE_VIVT=y
CONFIG_CPU_COPY_V4WB=y
CONFIG_CPU_TLB_V4WBI=y
CONFIG_CPU_CP15=y
CONFIG_CPU_CP15_MMU=y

#
# Processor Features
#
# CONFIG_ARM_THUMB is not set
# CONFIG_CPU_ICACHE_DISABLE is not set
# CONFIG_CPU_DCACHE_DISABLE is not set
# CONFIG_CPU_DCACHE_WRITETHROUGH is not set
CONFIG_CPU_CACHE_ROUND_ROBIN=y
CONFIG_ARM_L1_CACHE_SHIFT=5
CONFIG_ARM_FCSE=y
CONFIG_ARM_FCSE_GUARANTEED=y
# CONFIG_ARM_FCSE_BEST_EFFORT is not set
CONFIG_ARM_FCSE_PREEMPT_FLUSH=y
# CONFIG_ARM_FCSE_MESSAGES is not set
# CONFIG_ARM_FCSE_DEBUG is not set

#
# Bus support
#
# CONFIG_PCI_SYSCALL is not set
# CONFIG_ARCH_SUPPORTS_MSI is not set
# CONFIG_PCCARD is not set

#
# Kernel Features
#
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_IPIPE=y
CONFIG_IPIPE_DOMAINS=4
CONFIG_IPIPE_DELAYED_ATOMICSW=y
# CONFIG_IPIPE_UNMASKED_CONTEXT_SWITCH is not set
CONFIG_HAVE_IPIPE_HOSTRT=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_HZ=1000
CONFIG_AEABI=y
CONFIG_OABI_COMPAT=y
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
CONFIG_SPLIT_PTLOCK_CPUS=999999
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_ZONE_DMA_FLAG=0
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_LEDS is not set
CONFIG_ALIGNMENT_TRAP=y
# CONFIG_UACCESS_WITH_MEMCPY is not set

#
# Boot options
#
CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0
CONFIG_CMDLINE="mem=64M console=ttyS0,115200"
# CONFIG_CMDLINE_FORCE is not set
# CONFIG_XIP_KERNEL is not set
# CONFIG_KEXEC is not set

#
# CPU Power Management
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y

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
# CONFIG_BINFMT_MISC is not set

#
# Power management options
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_SLEEP=y
CONFIG_SUSPEND_NVS=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_APM_EMULATION=y
# CONFIG_PM_RUNTIME is not set
CONFIG_PM_OPS=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
# CONFIG_IP_PNP_DHCP is not set
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_INET_LRO is not set
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
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
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
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
# CONFIG_DEVTMPFS is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set

#
# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
#
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=8192
# CONFIG_BLK_DEV_XIP is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_MG_DISK is not set
CONFIG_MISC_DEVICES=y
# CONFIG_AD525X_DPOT is not set
CONFIG_ATMEL_TCLIB=y
# CONFIG_ICS932S401 is not set
# CONFIG_ATMEL_SSC is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_ISL29003 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_DS1682 is not set
# CONFIG_TI_DAC7512 is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_IWMC3200TOP is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
# CONFIG_SCSI is not set
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_ATA is not set
# CONFIG_MD is not set
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
CONFIG_PHYLIB=y

#
# MII PHY device drivers
#
# CONFIG_MARVELL_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_FIXED_PHY is not set
# CONFIG_MDIO_BITBANG is not set
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_MACB=y
# CONFIG_AX88796 is not set
# CONFIG_SMC91X is not set
# CONFIG_DM9000 is not set
# CONFIG_ENC28J60 is not set
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
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_NETDEV_1000 is not set
# CONFIG_NETDEV_10000 is not set
# CONFIG_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_WAN is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_ISDN is not set
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=320
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=240
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ATKBD is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=y
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_DEVKMEM=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_ATMEL=y
CONFIG_SERIAL_ATMEL_CONSOLE=y
CONFIG_SERIAL_ATMEL_PDC=y
# CONFIG_SERIAL_ATMEL_TTYAT is not set
# CONFIG_SERIAL_MAX3100 is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=16
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
# CONFIG_R3964 is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_RAMOOPS is not set
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_HELPER_AUTO=y

#
# I2C Hardware Bus support
#

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_DESIGNWARE is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ATMEL=y
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_DESIGNWARE is not set

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
# CONFIG_SPI_TLE62X0 is not set

#
# PPS support
#
# CONFIG_PPS is not set
CONFIG_ARCH_REQUIRE_GPIOLIB=y
CONFIG_GPIOLIB=y
# CONFIG_GPIO_SYSFS is not set

#
# Memory mapped GPIO expanders:
#
# CONFIG_GPIO_IT8761E is not set

#
# I2C GPIO expanders:
#
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_ADP5588 is not set

#
# PCI GPIO expanders:
#

#
# SPI GPIO expanders:
#
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MCP23S08 is not set
# CONFIG_GPIO_MC33880 is not set

#
# AC97 GPIO expanders:
#

#
# MODULbus GPIO expanders:
#
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set
# CONFIG_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
CONFIG_SSB=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
# CONFIG_SSB_DEBUG is not set
CONFIG_MFD_SUPPORT=y
# CONFIG_MFD_CORE is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_ASIC3 is not set
# CONFIG_HTC_EGPIO is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_MFD_TC35892 is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_T7L66XB is not set
# CONFIG_MFD_TC6387XB is not set
# CONFIG_MFD_TC6393XB is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_MC13783 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_AB8500_CORE is not set
# CONFIG_REGULATOR is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_VGASTATE is not set
# CONFIG_VIDEO_OUTPUT_CONTROL is not set
# CONFIG_FB is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Display device support
#
# CONFIG_DISPLAY_SUPPORT is not set

#
# Console display driver support
#
# CONFIG_VGA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
# CONFIG_SOUND is not set
# CONFIG_HID_SUPPORT is not set
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
# CONFIG_USB_ARCH_HAS_EHCI is not set
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_DEVICE_CLASS is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_MON is not set
# CONFIG_USB_WUSB is not set
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1760_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_HCD_SSB is not set
# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HWA_HCD is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_GADGET_MUSB_HDRC is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
# CONFIG_USB_LIBUSUAL is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_SELECTED=y
CONFIG_USB_GADGET_AT91=y
CONFIG_USB_AT91=y
# CONFIG_USB_GADGET_ATMEL_USBA is not set
# CONFIG_USB_GADGET_FSL_USB2 is not set
# CONFIG_USB_GADGET_LH7A40X is not set
# CONFIG_USB_GADGET_OMAP is not set
# CONFIG_USB_GADGET_PXA25X is not set
# CONFIG_USB_GADGET_R8A66597 is not set
# CONFIG_USB_GADGET_PXA27X is not set
# CONFIG_USB_GADGET_S3C_HSOTG is not set
# CONFIG_USB_GADGET_IMX is not set
# CONFIG_USB_GADGET_S3C2410 is not set
# CONFIG_USB_GADGET_M66592 is not set
# CONFIG_USB_GADGET_AMD5536UDC is not set
# CONFIG_USB_GADGET_FSL_QE is not set
# CONFIG_USB_GADGET_CI13XXX is not set
# CONFIG_USB_GADGET_NET2280 is not set
# CONFIG_USB_GADGET_GOKU is not set
# CONFIG_USB_GADGET_LANGWELL is not set
# CONFIG_USB_GADGET_DUMMY_HCD is not set
# CONFIG_USB_GADGET_DUALSPEED is not set
CONFIG_USB_ZERO=m
# CONFIG_USB_AUDIO is not set
CONFIG_USB_ETH=m
CONFIG_USB_ETH_RNDIS=y
# CONFIG_USB_ETH_EEM is not set
CONFIG_USB_GADGETFS=m
# CONFIG_USB_FUNCTIONFS is not set
CONFIG_USB_FILE_STORAGE=m
# CONFIG_USB_FILE_STORAGE_TEST is not set
# CONFIG_USB_MASS_STORAGE is not set
CONFIG_USB_G_SERIAL=m
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_NOKIA is not set
# CONFIG_USB_G_MULTI is not set
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_WEBCAM is not set

#
# OTG and related infrastructure
#
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ULPI is not set
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_MMC=y
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_UNSAFE_RESUME is not set

#
# MMC/SD/SDIO Card Drivers
#
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_BOUNCE=y
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_AT91=y
# CONFIG_MMC_ATMELMCI is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
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
# I2C RTC drivers
#
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_DS3234 is not set
# CONFIG_RTC_DRV_PCF2123 is not set

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
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_AT91SAM9=y
CONFIG_RTC_DRV_AT91SAM9_RTT=0
CONFIG_RTC_DRV_AT91SAM9_GPBR=0
# CONFIG_DMADEVICES is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_STAGING is not set

#
# File systems
#
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT23=y
# CONFIG_EXT4_FS_XATTR is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
CONFIG_FILE_LOCKING=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
# CONFIG_FUSE_FS is not set
CONFIG_GENERIC_ACL=y

#
# Caches
#
# CONFIG_FSCACHE is not set

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
# CONFIG_CONFIGFS_FS is not set
# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
# CONFIG_IPIPE_DEBUG is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_RCU_CPU_STALL_DETECTOR is not set
# CONFIG_LATENCYTOP is not set
# CONFIG_SYSCTL_SYSCALL_CHECK is not set
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
CONFIG_ARM_UNWIND=y
# CONFIG_DEBUG_USER is not set
# CONFIG_OC_ETM is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
# CONFIG_DEFAULT_SECURITY_SELINUX is not set
# CONFIG_DEFAULT_SECURITY_SMACK is not set
# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
# CONFIG_CRYPTO is not set
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_GENERIC_FIND_LAST_BIT=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y
CONFIG_NLATTR=y
CONFIG_GENERIC_ATOMIC64=y

--------------010402040909010400000808
Content-Type: text/plain;
 name="messages-2.6.0"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="messages-2.6.0"

   Image Name:   Linux-2.6.35.9-xenomai
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1499760 Bytes = 1.4 MiB
   Load Address: 20008000
   Entry Point:  20008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.35.9-xenomai (user@domain.hid) (gcc version 4.3.2 (Debian 4.3.2-1.1) ) #2 Sun Nov 6 11:28:59 CST 2011
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00057177
CPU: VIVT data cache, VIVT instruction cache
Machine: Micromint Electrum 100
Memory policy: ECC disabled, Data cache writeback
Clocks: CPU 396 MHz, master 132 MHz, main 18.432 MHz
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: console=ttyS0,115200 root=/dev/mmcblk0p2 rootwait lpj=98304 noswap
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB = 64MB total
Memory: 61848k/61848k available, 3688k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xc4800000 - 0xfee00000   ( 934 MB)
    lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .init : 0xc0008000 - 0xc0020000   (  96 kB)
      .text : 0xc0020000 - 0xc02b5000   (2644 kB)
      .data : 0xc02ca000 - 0xc02e3ca0   ( 104 kB)
Hierarchical RCU implementation.
	RCU-based detection of stalled CPUs is disabled.
	Verbose stalled-CPUs detection is disabled.
NR_IRQS:192
AT91: 96 gpio irqs in 3 banks
AT91 I-pipe timer: div: 128, freq: 1.032000 MHz, wrap: 63.503875 ms
I-pipe, 1.032 MHz clocksource
I-pipe 1.18-03: pipeline enabled.
Console: colour dummy device 80x30
Calibrating delay loop (skipped) preset value.. 196.60 BogoMIPS (lpj=98304)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
AT91: Power Management
AT91: Starting after user reset
bio: create slab <bio-0> at 0
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Switching to clocksource ipipe_tsc
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
NetWinder Floating Point Emulator V0.97 (double precision)
I-pipe: Domain Xenomai registered.
Xenomai: hal/arm started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.6.0 (Movin' On) loaded.
Xenomai: debug mode enabled.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
msgmni has been set to 120
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered (default)
atmel_usart.0: ttyS0 at MMIO 0xfffb0000 (irq = 6) is a ATMEL_SERIAL
console [ttyS0] enabled
atmel_usart.1: ttyS1 at MMIO 0xfefff200 (irq = 1) is a ATMEL_SERIAL
brd: module loaded
loop: module loaded
atmel_spi atmel_spi.0: Atmel SPI Controller at 0xfffc8000 (irq 12)
atmel_spi atmel_spi.1: Atmel SPI Controller at 0xfffcc000 (irq 13)
MACB_mii_bus: probed
eth0: Atmel MACB at 0xfffc4000 irq 21 (00:21:a3:00:02:89)
eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=ffffffff:00, irq=-1)
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
at91_ohci at91_ohci: AT91 OHCI
at91_ohci at91_ohci: new USB bus registered, assigned bus number 1
at91_ohci at91_ohci: irq 20, io mem 0x00500000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
udc: at91_udc version 3 May 2006
mice: PS/2 mouse device common for all mice
rtc-at91sam9 at91_rtt.0: rtc core: registered at91_rtt as rtc0
i2c /dev entries driver
cpuidle: using governor ladder
TCP cubic registered
NET: Registered protocol family 17
rtc-at91sam9 at91_rtt.0: setting system clock to 2011-11-06 12:37:42 UTC (1320583062)
Waiting for root device /dev/mmcblk0p2...
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new SD card at address 3375
mmcblk0: mmc0:3375 SD02G 1.83 GiB 
 mmcblk0: p1 p2 p3 p4
EXT4-fs (mmcblk0p2): warning: mounting fs with errors, running e2fsck is recommended
EXT4-fs (mmcblk0p2): recovery complete
EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext2 filesystem) on device 179:2.
Freeing init memory: 96K
INIT: version 2.88 booting
INIT: Entering runlevel: 2
Unable to handle kernel paging request at virtual address c4000000
fcse pid: 5, 0x0a000000
pgd = c3dac000
[c4000000] *pgd=00000000
Internal error: Oops: 805 [#1]
last sysfs file: 
Modules linked in:
CPU: 0    Not tainted  (2.6.35.9-xenomai #2)
PC is at __memzero+0x30/0x80
LR is at 0x0
pc : [<c0152090>]    lr : [<00000000>]    psr: 20000013
sp : c3da9ec8  ip : 00000000  fp : 0001c50c
r10: 00000000  r9 : c3da8000  r8 : 7ffff000
r7 : 00028248  r6 : c3da9f1c  r5 : c3da9ee4  r4 : 00000000
r3 : 00000000  r2 : 00000000  r1 : 7fda8ee0  r0 : c3fffff4
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005717f  Table: 23dac000  DAC: 00000015
Process rc.local (pid: 432, stack limit = 0xc3da8270)
Stack: (0xc3da9ec8 to 0xc3daa000)
9ec0:                   c02271fc 7fffe260 7ffff000 c0079ae0 c02d7a78 c0079b10
9ee0: ffffff9c 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9f00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9f20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9f40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9f60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9f80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fa0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[<c0152090>] (__memzero+0x30/0x80) from [<7fffe260>] (0x7fffe260)
Code: e2511040 a8a0500c a8a0500c a8a0500c (a8a0500c) 
---[ end trace 3b1f3a5dcf6fd7ae ]---
Unable to handle kernel NULL pointer dereference at virtual address 00000000
fcse pid: 0, 0x00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#2]
last sysfs file: 
Modules linked in:
CPU: 0    Tainted: G      D      (2.6.35.9-xenomai #2)
PC is at unlink_anon_vmas+0x10/0xb0
LR is at free_pgtables+0x2c/0xa4
pc : [<c00b9760>]    lr : [<c00b32ec>]    psr: a0000013
sp : c3da9bf0  ip : c0302ad0  fp : 00000001
r10: 00001000  r9 : c02ce334  r8 : 00100100
r7 : 00000000  r6 : 00000000  r5 : c3daa948  r4 : 00000000
r3 : 00000000  r2 : 00001000  r1 : c3daa910  r0 : c3daa910
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005717f  Table: 23dac000  DAC: 00000015
Process rc.local (pid: 432, stack limit = 0xc3da8270)
Stack: (0xc3da9bf0 to 0xc3daa000)
9be0:                                     00000144 c3daa910 00000000 00000000
9c00: 00000000 c02ce334 00001000 c00b32ec c3d71c94 00000000 00000144 00000000
9c20: c3daa910 00000000 c3d71c60 c0281924 c028191e c00b4f64 c3da9c40 00000000
9c40: 00000000 c02ce334 c3d71c60 c3d71c60 c3ccd9e0 c3d71c94 00000000 c00367f8
9c60: 00000000 c003a4cc c3da9ce7 c3ccd9e0 bf000000 0000000b c3da9ce7 c3ccd9e0
9c80: bf000000 c003bc44 c3da9ce7 c0152094 bf000000 00000001 c3da9ce7 c0152094
9ca0: bf000000 00000000 c0281924 c028191e 00000000 c00249a0 c3da8270 0000000b
9cc0: 65000013 31313532 20303430 30613861 63303035 61386120 30303530 38612063
9ce0: 30353061 28206330 30613861 63303035 00002029 c4000000 c3da9e80 c4000000
9d00: c3da9e80 c3d71c60 00000805 00000000 20000013 00000000 0001c50c c0027fd0
9d20: c3da9e80 00000003 c4000000 00000805 c4000000 c00282cc fffdffff ffffffff
9d40: c3da9de8 00000000 000f4240 00000000 c3da9d80 c3ccd9e0 c02d03a0 c3ccda10
9d60: c3ccd9e0 c02d03a0 c02d67ec c02ef584 c3da9d9c c3da9d80 c00327b4 c0032528
9d80: b149806a 0000037b 00000400 000003ff c3da9dc4 c3da9da0 c0036288 c003279c
9da0: c3da9da0 c3da9da0 c3ccd9e0 00000000 00000011 c02d02b0 00000000 23dac000
9dc0: c3da9e80 c00284a0 c02d67ec c02ce0c0 c3da9eb4 00000805 c3da9e80 c0020288
9de0: c3da9de0 00000100 c3da8000 00000024 00000001 00000009 c02ecbc8 0000000a
9e00: 00000000 c006447c 00000000 c003dba4 c02d28b8 00000011 00000000 00000011
9e20: 00000000 00000000 00000002 c02ef580 c02d67ec c02ef584 00000011 c0020074
9e40: c02f1280 00000011 00000014 c00655a0 c02d67d8 c3da9e80 fefff000 00000011
9e60: 00028248 7ffff000 ffffffff c3da9eb4 c3da9f1c 00028248 7ffff000 c0020afc
9e80: c3fffff4 7fda8ee0 00000000 00000000 00000000 c3da9ee4 c3da9f1c 00028248
9ea0: 7ffff000 c3da8000 00000000 0001c50c 00000000 c3da9ec8 00000000 c0152090
9ec0: 20000013 ffffffff c02271fc 7fffe260 7ffff000 c0079ae0 c02d7a78 c0079b10
9ee0: ffffff9c 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9f00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9f20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9f40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9f60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9f80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fa0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[<c00b9760>] (unlink_anon_vmas+0x10/0xb0) from [<c00b32ec>] (free_pgtables+0x2c/0xa4)
[<c00b32ec>] (free_pgtables+0x2c/0xa4) from [<c00b4f64>] (exit_mmap+0x100/0x170)
[<c00b4f64>] (exit_mmap+0x100/0x170) from [<c00367f8>] (mmput+0x38/0x120)
[<c00367f8>] (mmput+0x38/0x120) from [<c003a4cc>] (exit_mm+0x114/0x120)
[<c003a4cc>] (exit_mm+0x114/0x120) from [<c003bc44>] (do_exit+0x170/0x610)
[<c003bc44>] (do_exit+0x170/0x610) from [<c00249a0>] (die+0x260/0x2a4)
[<c00249a0>] (die+0x260/0x2a4) from [<c0027fd0>] (__do_kernel_fault+0x64/0x84)
[<c0027fd0>] (__do_kernel_fault+0x64/0x84) from [<c00282cc>] (do_bad_area+0x6c/0x78)
[<c00282cc>] (do_bad_area+0x6c/0x78) from [<c00284a0>] (do_translation_fault+0x114/0x130)
[<c00284a0>] (do_translation_fault+0x114/0x130) from [<c0020288>] (do_DataAbort+0x34/0x120)
[<c0020288>] (do_DataAbort+0x34/0x120) from [<c0020afc>] (__dabt_svc+0x5c/0x80)
Exception stack(0xc3da9e80 to 0xc3da9ec8)
9e80: c3fffff4 7fda8ee0 00000000 00000000 00000000 c3da9ee4 c3da9f1c 00028248
9ea0: 7ffff000 c3da8000 00000000 0001c50c 00000000 c3da9ec8 00000000 c0152090
9ec0: 20000013 ffffffff
[<c0020afc>] (__dabt_svc+0x5c/0x80) from [<c0152090>] (__memzero+0x30/0x80)
[<c0152090>] (__memzero+0x30/0x80) from [<7fffe260>] (0x7fffe260)
Code: e92d47f0 e1a05000 e5b54038 e59f808c (e4143008) 
---[ end trace 3b1f3a5dcf6fd7af ]---
Fixing recursive fault but reboot is needed!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
fcse pid: 0, 0x00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 805 [#3]
last sysfs file: 
Modules linked in:
CPU: 0    Tainted: G      D      (2.6.35.9-xenomai #2)
PC is at free_block+0x7c/0x14c
LR is at drain_array+0xb8/0xe4
pc : [<c00c1344>]    lr : [<c00c1618>]    psr: 00000013
sp : c3c25f28  ip : c3dd0000  fp : 00100100
r10: c3c43a90  r9 : 00200200  r8 : 00000005
r7 : c3c103cc  r6 : c3c10380  r5 : 00000000  r4 : c3c511a0
r3 : 00000000  r2 : 00000000  r1 : 00000080  r0 : c3dd0040
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005717f  Table: 23dac000  DAC: 00000017
Process events/0 (pid: 4, stack limit = 0xc3c24270)
Stack: (0xc3c25f28 to 0xc3c26000)
5f20:                   c02d03a0 c3c43a90 00000005 c3c43a80 00000000 c3c10380
5f40: c0302bac 00000005 c3c25f94 c00c1618 c3c511a0 c3c10380 00000000 c02d9620
5f60: c02d15b8 c00c1754 00000000 c3c018e0 c02d9624 c02d9620 c3c018e0 c3c24000
5f80: c00c1704 c3c018e8 c02d67e8 c0049890 c3c25fcc 00000000 c3c15320 c004cf24
5fa0: c3c25fa0 c3c25fa0 c3c19f5c c3c25fd4 c3c19f5c c3c018e0 c0049724 00000000
5fc0: 00000000 00000000 00000000 c004cd1c 00000000 00000000 c3c25fd8 c3c25fd8
5fe0: 00000000 c3c19f5c c004cca4 c0022008 00000013 c0022008 00000000 00000000
[<c00c1344>] (free_block+0x7c/0x14c) from [<c00c1618>] (drain_array+0xb8/0xe4)
[<c00c1618>] (drain_array+0xb8/0xe4) from [<c00c1754>] (cache_reap+0x50/0x118)
[<c00c1754>] (cache_reap+0x50/0x118) from [<c0049890>] (worker_thread+0x16c/0x204)
[<c0049890>] (worker_thread+0x16c/0x204) from [<c004cd1c>] (kthread+0x78/0x80)
[<c004cd1c>] (kthread+0x78/0x80) from [<c0022008>] (kernel_thread_exit+0x0/0x8)
Code: e592c01c e5974000 e59c2004 e59c3000 (e5823000) 
---[ end trace 3b1f3a5dcf6fd7b0 ]---
Unable to handle kernel NULL pointer dereference at virtual address 0000001c
fcse pid: 0, 0x00000000
pgd = c0004000
[0000001c] *pgd=00000000
Internal error: Oops: 5 [#4]
last sysfs file: 
Modules linked in:
CPU: 0    Tainted: G      D      (2.6.35.9-xenomai #2)
PC is at sync_supers+0x28/0xb0
LR is at bdi_sync_supers+0x34/0x4c
pc : [<c00c67b4>]    lr : [<c00ade44>]    psr: 00000013
sp : c3c45fb0  ip : c3c45f90  fp : 00000000
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : c00ade10  r6 : c02d965c  r5 : 00000000  r4 : c3dc3e00
r3 : 00000000  r2 : c3dc3e90  r1 : 00000000  r0 : 00000000
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005717f  Table: 23dac000  DAC: 00000017
Process sync_supers (pid: 81, stack limit = 0xc3c44270)
Stack: (0xc3c45fb0 to 0xc3c46000)
5fa0:                                     c3c44000 00000001 00000000 c00ade44
5fc0: 00000000 c3c45fd4 c3c19f7c c004cd1c 00000000 00000000 c3c45fd8 c3c45fd8
5fe0: 00000000 c3c19f7c c004cca4 c0022008 00000013 c0022008 00000000 00000000
[<c00c67b4>] (sync_supers+0x28/0xb0) from [<c00ade44>] (bdi_sync_supers+0x34/0x4c)
[<c00ade44>] (bdi_sync_supers+0x34/0x4c) from [<c004cd1c>] (kthread+0x78/0x80)
[<c004cd1c>] (kthread+0x78/0x80) from [<c0022008>] (kernel_thread_exit+0x0/0x8)
Code: e5943090 e1530002 0a00001b e5943024 (e593301c) 
---[ end trace 3b1f3a5dcf6fd7b1 ]---


--------------010402040909010400000808--

