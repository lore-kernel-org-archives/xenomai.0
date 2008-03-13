Message-ID: <d6c8ef150803131013p152b79fah70d97ee1429e86e9@domain.hid>
Date: Thu, 13 Mar 2008 18:13:44 +0100
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <d6c8ef150803130409g2a618d30gbede878d6a09e470@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0803120923m76f75bder857abac049c22e4d@domain.hid>
	<d6c8ef150803130409g2a618d30gbede878d6a09e470@domain.hid>
Subject: Re: [Xenomai-help] [Adeos-main] New I-pipe patch for ARM.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

Hi Gilles,

I booted similar board, but without additional Eths, only "built-in"
MACB Ethernet controller (part of AT91SAM9260). Networking here works
ok.

It seems that we have problem with GPIO interrupt handling/dispatching.

# cat /proc/interrupts
           CPU0
  1:        651         AIC  atmel_serial
 12:          2         AIC  atmel_spi.0
 17:     178884         AIC  at91_tick
 21:         15         AIC  eth0
Err:          0

# cat /proc/xenomai/irq
IRQ         CPU0
 17:      199337         [timer]
194:           0         [virtual]

On Thu, Mar 13, 2008 at 12:09 PM, Bosko Radivojevic
<bosko.radivojevic@domain.hid> wrote:
> Hi Gilles,
>
>  I have a quite strange problem. I successfully compiled kernel
>  (2.6.24.3+at91 patch) with Xenomai-trunk (2.4.2 wont compile with the
>  new ipipe patch). Kernel boots OK on At91SAM9260 based board (but with
>  DM9000 on it). Strange problem is that Ethernet communication is not
>  working, I'm getting following error on console (after trying some
>  pings):
>  NETDEV WATCHDOG: eth0: transmit timed out
>
>  If I disable Xenomai in kernel config (but leave IPIPE), system
>  completely hangs with any Eth transmit. (OK, maybe it is not a
>  complete hang, but for sure console is not responding anymore)
>
>  If I disable IPIPE, Ethernet works fine.
>
>  Here is my .config:
>  CONFIG_ARM=y
>  CONFIG_SYS_SUPPORTS_APM_EMULATION=y
>  CONFIG_GENERIC_GPIO=y
>  CONFIG_GENERIC_TIME=y
>  CONFIG_GENERIC_CLOCKEVENTS=y
>  CONFIG_MMU=y
>  # CONFIG_NO_IOPORT is not set
>  CONFIG_GENERIC_HARDIRQS=y
>  CONFIG_STACKTRACE_SUPPORT=y
>  CONFIG_LOCKDEP_SUPPORT=y
>  CONFIG_TRACE_IRQFLAGS_SUPPORT=y
>  CONFIG_HARDIRQS_SW_RESEND=y
>  CONFIG_GENERIC_IRQ_PROBE=y
>  CONFIG_RWSEM_GENERIC_SPINLOCK=y
>  # CONFIG_ARCH_HAS_ILOG2_U32 is not set
>  # CONFIG_ARCH_HAS_ILOG2_U64 is not set
>  CONFIG_GENERIC_HWEIGHT=y
>  CONFIG_GENERIC_CALIBRATE_DELAY=y
>  CONFIG_ZONE_DMA=y
>  CONFIG_VECTORS_BASE=0xffff0000
>  CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
>  CONFIG_EXPERIMENTAL=y
>  CONFIG_BROKEN_ON_SMP=y
>  CONFIG_INIT_ENV_ARG_LIMIT=32
>  CONFIG_LOCALVERSION=""
>  CONFIG_LOCALVERSION_AUTO=y
>  # CONFIG_SWAP is not set
>  CONFIG_SYSVIPC=y
>  CONFIG_SYSVIPC_SYSCTL=y
>  # CONFIG_POSIX_MQUEUE is not set
>  # CONFIG_BSD_PROCESS_ACCT is not set
>  # CONFIG_TASKSTATS is not set
>  # CONFIG_USER_NS is not set
>  # CONFIG_PID_NS is not set
>  # CONFIG_AUDIT is not set
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_LOG_BUF_SHIFT=14
>  # CONFIG_CGROUPS is not set
>  CONFIG_FAIR_GROUP_SCHED=y
>  CONFIG_FAIR_USER_SCHED=y
>  # CONFIG_FAIR_CGROUP_SCHED is not set
>  # CONFIG_SYSFS_DEPRECATED is not set
>  CONFIG_RELAY=y
>  # CONFIG_BLK_DEV_INITRD is not set
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_SYSCTL=y
>  # CONFIG_EMBEDDED is not set
>  CONFIG_UID16=y
>  CONFIG_SYSCTL_SYSCALL=y
>  CONFIG_KALLSYMS=y
>  # CONFIG_KALLSYMS_EXTRA_PASS is not set
>  CONFIG_HOTPLUG=y
>  CONFIG_PRINTK=y
>  CONFIG_BUG=y
>  CONFIG_ELF_CORE=y
>  CONFIG_BASE_FULL=y
>  CONFIG_FUTEX=y
>  CONFIG_ANON_INODES=y
>  CONFIG_EPOLL=y
>  CONFIG_SIGNALFD=y
>  CONFIG_EVENTFD=y
>  CONFIG_SHMEM=y
>  CONFIG_VM_EVENT_COUNTERS=y
>  CONFIG_SLAB=y
>  # CONFIG_SLUB is not set
>  # CONFIG_SLOB is not set
>  CONFIG_SLABINFO=y
>  CONFIG_RT_MUTEXES=y
>  # CONFIG_TINY_SHMEM is not set
>  CONFIG_BASE_SMALL=0
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
>  # CONFIG_MODULE_FORCE_UNLOAD is not set
>  # CONFIG_MODVERSIONS is not set
>  # CONFIG_MODULE_SRCVERSION_ALL is not set
>  CONFIG_KMOD=y
>  CONFIG_BLOCK=y
>  # CONFIG_LBD is not set
>  # CONFIG_BLK_DEV_IO_TRACE is not set
>  # CONFIG_LSF is not set
>  # CONFIG_BLK_DEV_BSG is not set
>
>  #
>  # IO Schedulers
>  #
>  CONFIG_IOSCHED_NOOP=y
>  CONFIG_IOSCHED_AS=y
>  # CONFIG_IOSCHED_DEADLINE is not set
>  # CONFIG_IOSCHED_CFQ is not set
>  CONFIG_DEFAULT_AS=y
>  # CONFIG_DEFAULT_DEADLINE is not set
>  # CONFIG_DEFAULT_CFQ is not set
>  # CONFIG_DEFAULT_NOOP is not set
>  CONFIG_DEFAULT_IOSCHED="anticipatory"
>
>  #
>  # Real-time sub-system
>  #
>  CONFIG_XENOMAI=y
>  CONFIG_XENO_OPT_NUCLEUS=y
>  CONFIG_XENO_OPT_PERVASIVE=y
>  # CONFIG_XENO_OPT_ISHIELD is not set
>  CONFIG_XENO_OPT_PRIOCPL=y
>  CONFIG_XENO_OPT_PIPELINE_HEAD=y
>  CONFIG_XENO_OPT_PIPE=y
>  CONFIG_XENO_OPT_PIPE_NRDEV=32
>  CONFIG_XENO_OPT_REGISTRY=y
>  CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
>  CONFIG_XENO_OPT_SYS_HEAPSZ=128
>  CONFIG_XENO_OPT_STATS=y
>  # CONFIG_XENO_OPT_DEBUG is not set
>  # CONFIG_XENO_OPT_SHIRQ is not set
>
>  #
>  # Timing
>  #
>  # CONFIG_XENO_OPT_TIMING_PERIODIC is not set
>  CONFIG_XENO_OPT_TIMING_SCHEDLAT=0
>
>  #
>  # Scalability
>  #
>  # CONFIG_XENO_OPT_SCALABLE_SCHED is not set
>  CONFIG_XENO_OPT_TIMER_LIST=y
>  # CONFIG_XENO_OPT_TIMER_HEAP is not set
>  # CONFIG_XENO_OPT_TIMER_WHEEL is not set
>
>  #
>  # Machine
>  #
>  # CONFIG_XENO_HW_FPU is not set
>
>  #
>  # Interfaces
>  #
>  CONFIG_XENO_SKIN_NATIVE=y
>  CONFIG_XENO_OPT_NATIVE_PERIOD=0
>  CONFIG_XENO_OPT_NATIVE_PIPE=y
>  CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=1024
>  CONFIG_XENO_OPT_NATIVE_REGISTRY=y
>  CONFIG_XENO_OPT_NATIVE_SEM=y
>  CONFIG_XENO_OPT_NATIVE_EVENT=y
>  CONFIG_XENO_OPT_NATIVE_MUTEX=y
>  CONFIG_XENO_OPT_NATIVE_COND=y
>  CONFIG_XENO_OPT_NATIVE_QUEUE=y
>  CONFIG_XENO_OPT_NATIVE_HEAP=y
>  CONFIG_XENO_OPT_NATIVE_ALARM=y
>  CONFIG_XENO_OPT_NATIVE_MPS=y
>  # CONFIG_XENO_OPT_NATIVE_INTR is not set
>  CONFIG_XENO_SKIN_POSIX=y
>  CONFIG_XENO_OPT_POSIX_PERIOD=0
>  # CONFIG_XENO_OPT_POSIX_SHM is not set
>  # CONFIG_XENO_OPT_POSIX_INTR is not set
>  # CONFIG_XENO_OPT_POSIX_SELECT is not set
>  CONFIG_XENO_OPT_DEBUG_POSIX=y
>  # CONFIG_XENO_SKIN_PSOS is not set
>  # CONFIG_XENO_SKIN_UITRON is not set
>  # CONFIG_XENO_SKIN_VRTX is not set
>  # CONFIG_XENO_SKIN_VXWORKS is not set
>  # CONFIG_XENO_SKIN_RTAI is not set
>  CONFIG_XENO_SKIN_RTDM=y
>  CONFIG_XENO_OPT_RTDM_PERIOD=0
>  CONFIG_XENO_OPT_RTDM_FILDES=128
>  # CONFIG_XENO_OPT_RTDM_SELECT is not set
>
>  #
>  # Drivers
>  #
>
>  #
>  # Serial drivers
>  #
>  # CONFIG_XENO_DRIVERS_16550A is not set
>
>  #
>  # Testing drivers
>  #
>  CONFIG_XENO_DRIVERS_TIMERBENCH=y
>  # CONFIG_XENO_DRIVERS_KLATENCY is not set
>  CONFIG_XENO_DRIVERS_IRQBENCH=y
>  CONFIG_XENO_DRIVERS_SWITCHTEST=y
>
>  #
>  # CAN drivers
>  #
>  # CONFIG_XENO_DRIVERS_CAN is not set
>
>  #
>  # System Type
>  #
>  # CONFIG_ARCH_AAEC2000 is not set
>  # CONFIG_ARCH_INTEGRATOR is not set
>  # CONFIG_ARCH_REALVIEW is not set
>  # CONFIG_ARCH_VERSATILE is not set
>  CONFIG_ARCH_AT91=y
>  # CONFIG_ARCH_CLPS7500 is not set
>  # CONFIG_ARCH_CLPS711X is not set
>  # CONFIG_ARCH_CO285 is not set
>  # CONFIG_ARCH_EBSA110 is not set
>  # CONFIG_ARCH_EP93XX is not set
>  # CONFIG_ARCH_FOOTBRIDGE is not set
>  # CONFIG_ARCH_NETX is not set
>  # CONFIG_ARCH_H720X is not set
>  # CONFIG_ARCH_IMX is not set
>  # CONFIG_ARCH_IOP13XX is not set
>  # CONFIG_ARCH_IOP32X is not set
>  # CONFIG_ARCH_IOP33X is not set
>  # CONFIG_ARCH_IXP23XX is not set
>  # CONFIG_ARCH_IXP2000 is not set
>  # CONFIG_ARCH_IXP4XX is not set
>  # CONFIG_ARCH_L7200 is not set
>  # CONFIG_ARCH_KS8695 is not set
>  # CONFIG_ARCH_NS9XXX is not set
>  # CONFIG_ARCH_MXC is not set
>  # CONFIG_ARCH_PNX4008 is not set
>  # CONFIG_ARCH_PXA is not set
>  # CONFIG_ARCH_RPC is not set
>  # CONFIG_ARCH_SA1100 is not set
>  # CONFIG_ARCH_S3C2410 is not set
>  # CONFIG_ARCH_SHARK is not set
>  # CONFIG_ARCH_LH7A40X is not set
>  # CONFIG_ARCH_DAVINCI is not set
>  # CONFIG_ARCH_OMAP is not set
>
>  #
>  # Boot options
>  #
>
>  #
>  # Power management
>  #
>
>  #
>  # Atmel AT91 System-on-Chip
>  #
>  # CONFIG_ARCH_AT91RM9200 is not set
>  CONFIG_ARCH_AT91SAM9260=y
>  # CONFIG_ARCH_AT91SAM9261 is not set
>  # CONFIG_ARCH_AT91SAM9263 is not set
>  # CONFIG_ARCH_AT91SAM9RL is not set
>  # CONFIG_ARCH_AT91CAP9 is not set
>  # CONFIG_ARCH_AT91X40 is not set
>  CONFIG_AT91_PMC_UNIT=y
>  #
>  # AT91SAM9260 Variants
>  #
>  # CONFIG_ARCH_AT91SAM9260_SAM9XE is not set
>
>  #
>  # AT91SAM9260 / AT91SAM9XE Board Type
>  #
>  CONFIG_MACH_AT91SAM9260EK=y
>  # CONFIG_MACH_CAM60 is not set
>  # CONFIG_MACH_SAM9_L9260 is not set
>
>  #
>  # Adeos I-pipe Options
>  #
>  CONFIG_IPIPE_AT91_TC=0
>  CONFIG_IPIPE_AT91_MCK=99328000
>
>  #
>  # AT91 Board Options
>  #
>  # CONFIG_MTD_AT91_DATAFLASH_CARD is not set
>  CONFIG_MTD_NAND_AT91=y
>  # CONFIG_MTD_NAND_AT91_BUSWIDTH_16 is not set
>
>  #
>  # AT91 Feature Selections
>  #
>  CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
>  CONFIG_AT91_TIMER_HZ=1000
>  CONFIG_AT91_EARLY_DBGU=y
>  # CONFIG_AT91_EARLY_USART0 is not set
>  # CONFIG_AT91_EARLY_USART1 is not set
>  # CONFIG_AT91_EARLY_USART2 is not set
>  # CONFIG_AT91_EARLY_USART3 is not set
>  # CONFIG_AT91_EARLY_USART4 is not set
>  # CONFIG_AT91_EARLY_USART5 is not set
>
>  #
>  # Processor Type
>  #
>  CONFIG_CPU_32=y
>  CONFIG_CPU_ARM926T=y
>  CONFIG_CPU_32v5=y
>  CONFIG_CPU_ABRT_EV5TJ=y
>  CONFIG_CPU_CACHE_VIVT=y
>  CONFIG_CPU_COPY_V4WB=y
>  CONFIG_CPU_TLB_V4WBI=y
>  CONFIG_CPU_CP15=y
>  CONFIG_CPU_CP15_MMU=y
>
>  #
>  # Processor Features
>  #
>  # CONFIG_ARM_THUMB is not set
>  # CONFIG_CPU_ICACHE_DISABLE is not set
>  # CONFIG_CPU_DCACHE_DISABLE is not set
>  # CONFIG_CPU_DCACHE_WRITETHROUGH is not set
>  # CONFIG_CPU_CACHE_ROUND_ROBIN is not set
>  # CONFIG_OUTER_CACHE is not set
>
>  #
>  # Bus support
>  #
>  # CONFIG_PCI_SYSCALL is not set
>  # CONFIG_ARCH_SUPPORTS_MSI is not set
>  # CONFIG_PCCARD is not set
>
>  #
>  # Kernel Features
>  #
>  # CONFIG_TICK_ONESHOT is not set
>  # CONFIG_NO_HZ is not set
>  # CONFIG_HIGH_RES_TIMERS is not set
>  CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
>  CONFIG_IPIPE=y
>  CONFIG_IPIPE_DOMAINS=4
>  CONFIG_IPIPE_COMPAT=y
>  # CONFIG_PREEMPT is not set
>  CONFIG_HZ=1000
>  # CONFIG_AEABI is not set
>  # CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
>  CONFIG_SELECT_MEMORY_MODEL=y
>  CONFIG_FLATMEM_MANUAL=y
>  # CONFIG_DISCONTIGMEM_MANUAL is not set
>  # CONFIG_SPARSEMEM_MANUAL is not set
>  CONFIG_FLATMEM=y
>  CONFIG_FLAT_NODE_MEM_MAP=y
>  # CONFIG_SPARSEMEM_STATIC is not set
>  # CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
>  CONFIG_SPLIT_PTLOCK_CPUS=4096
>  # CONFIG_RESOURCES_64BIT is not set
>  CONFIG_ZONE_DMA_FLAG=1
>  CONFIG_BOUNCE=y
>  CONFIG_VIRT_TO_BUS=y
>  # CONFIG_LEDS is not set
>  CONFIG_ALIGNMENT_TRAP=y
>
>  #
>  # Boot options
>  #
>  CONFIG_ZBOOT_ROM_TEXT=0x0
>  CONFIG_ZBOOT_ROM_BSS=0x0
>  CONFIG_CMDLINE="mem=64M console=ttyS0,115200 root=/dev/mtdblock1 rw"
>  # CONFIG_XIP_KERNEL is not set
>  # CONFIG_KEXEC is not set
>
>  #
>  # Floating point emulation
>  #
>
>  #
>  # At least one emulation must be selected
>  #
>  CONFIG_FPE_NWFPE=y
>  # CONFIG_FPE_NWFPE_XP is not set
>  # CONFIG_FPE_FASTFPE is not set
>  # CONFIG_VFP is not set
>
>  #
>  # Userspace binary formats
>  #
>  CONFIG_BINFMT_ELF=y
>  # CONFIG_BINFMT_AOUT is not set
>  # CONFIG_BINFMT_MISC is not set
>  # CONFIG_ARTHUR is not set
>
>  #
>  # Power management options
>  #
>  # CONFIG_PM is not set
>  CONFIG_SUSPEND_UP_POSSIBLE=y
>
>  #
>  # Networking
>  #
>  CONFIG_NET=y
>
>  #
>  # Networking options
>  #
>  CONFIG_PACKET=y
>  # CONFIG_PACKET_MMAP is not set
>  CONFIG_UNIX=y
>  # CONFIG_NET_KEY is not set
>  CONFIG_INET=y
>  # CONFIG_IP_MULTICAST is not set
>  # CONFIG_IP_ADVANCED_ROUTER is not set
>  CONFIG_IP_FIB_HASH=y
>  # CONFIG_IP_PNP is not set
>  # CONFIG_NET_IPIP is not set
>  # CONFIG_NET_IPGRE is not set
>  # CONFIG_ARPD is not set
>  # CONFIG_SYN_COOKIES is not set
>  # CONFIG_INET_AH is not set
>  # CONFIG_INET_ESP is not set
>  # CONFIG_INET_IPCOMP is not set
>  # CONFIG_INET_XFRM_TUNNEL is not set
>  # CONFIG_INET_TUNNEL is not set
>  # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
>  # CONFIG_INET_XFRM_MODE_TUNNEL is not set
>  # CONFIG_INET_XFRM_MODE_BEET is not set
>  # CONFIG_INET_LRO is not set
>  # CONFIG_INET_DIAG is not set
>  # CONFIG_TCP_CONG_ADVANCED is not set
>  CONFIG_TCP_CONG_CUBIC=y
>  CONFIG_DEFAULT_TCP_CONG="cubic"
>  # CONFIG_TCP_MD5SIG is not set
>  # CONFIG_IPV6 is not set
>  # CONFIG_INET6_XFRM_TUNNEL is not set
>  # CONFIG_INET6_TUNNEL is not set
>  # CONFIG_NETWORK_SECMARK is not set
>  # CONFIG_NETFILTER is not set
>  # CONFIG_IP_DCCP is not set
>  # CONFIG_IP_SCTP is not set
>  # CONFIG_TIPC is not set
>  # CONFIG_ATM is not set
>  # CONFIG_BRIDGE is not set
>  # CONFIG_VLAN_8021Q is not set
>  # CONFIG_DECNET is not set
>  # CONFIG_LLC2 is not set
>  # CONFIG_IPX is not set
>  # CONFIG_ATALK is not set
>  # CONFIG_X25 is not set
>  # CONFIG_LAPB is not set
>  # CONFIG_ECONET is not set
>  # CONFIG_WAN_ROUTER is not set
>  # CONFIG_NET_SCHED is not set
>
>  #
>  # Network testing
>  #
>  # CONFIG_NET_PKTGEN is not set
>  # CONFIG_HAMRADIO is not set
>  # CONFIG_IRDA is not set
>  # CONFIG_BT is not set
>  # CONFIG_AF_RXRPC is not set
>
>  #
>  # Wireless
>  #
>  # CONFIG_CFG80211 is not set
>  # CONFIG_WIRELESS_EXT is not set
>  # CONFIG_MAC80211 is not set
>  # CONFIG_IEEE80211 is not set
>  # CONFIG_RFKILL is not set
>  # CONFIG_NET_9P is not set
>
>  #
>  # Device Drivers
>  #
>
>  #
>  # Generic Driver Options
>  #
>  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_STANDALONE=y
>  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
>  # CONFIG_FW_LOADER is not set
>  # CONFIG_SYS_HYPERVISOR is not set
>  # CONFIG_CONNECTOR is not set
>  CONFIG_MTD=y
>  # CONFIG_MTD_DEBUG is not set
>  # CONFIG_MTD_CONCAT is not set
>  CONFIG_MTD_PARTITIONS=y
>  # CONFIG_MTD_REDBOOT_PARTS is not set
>  CONFIG_MTD_CMDLINE_PARTS=y
>  CONFIG_MTD_AFS_PARTS=y
>
>  #
>  # User Modules And Translation Layers
>  #
>  CONFIG_MTD_CHAR=y
>  CONFIG_MTD_BLKDEVS=y
>  CONFIG_MTD_BLOCK=y
>  # CONFIG_FTL is not set
>  # CONFIG_NFTL is not set
>  # CONFIG_INFTL is not set
>  # CONFIG_RFD_FTL is not set
>  # CONFIG_SSFDC is not set
>  # CONFIG_MTD_OOPS is not set
>
>  #
>  # RAM/ROM/Flash chip drivers
>  #
>  # CONFIG_MTD_CFI is not set
>  # CONFIG_MTD_JEDECPROBE is not set
>  CONFIG_MTD_MAP_BANK_WIDTH_1=y
>  CONFIG_MTD_MAP_BANK_WIDTH_2=y
>  CONFIG_MTD_MAP_BANK_WIDTH_4=y
>  # CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
>  # CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
>  # CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
>  CONFIG_MTD_CFI_I1=y
>  CONFIG_MTD_CFI_I2=y
>  # CONFIG_MTD_CFI_I4 is not set
>  # CONFIG_MTD_CFI_I8 is not set
>  # CONFIG_MTD_RAM is not set
>  # CONFIG_MTD_ROM is not set
>  # CONFIG_MTD_ABSENT is not set
>
>  #
>  # Mapping drivers for chip access
>  #
>  # CONFIG_MTD_COMPLEX_MAPPINGS is not set
>  # CONFIG_MTD_PLATRAM is not set
>
>  #
>  # Self-contained MTD device drivers
>  #
>  CONFIG_MTD_DATAFLASH=y
>  # CONFIG_MTD_M25P80 is not set
>  # CONFIG_MTD_SLRAM is not set
>  # CONFIG_MTD_PHRAM is not set
>  # CONFIG_MTD_MTDRAM is not set
>  # CONFIG_MTD_BLOCK2MTD is not set
>
>  #
>  # Disk-On-Chip Device Drivers
>  #
>  # CONFIG_MTD_DOC2000 is not set
>  # CONFIG_MTD_DOC2001 is not set
>  # CONFIG_MTD_DOC2001PLUS is not set
>  CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_VERIFY_WRITE=y
>  CONFIG_MTD_NAND_ECC_SMC=y
>  # CONFIG_MTD_NAND_MUSEUM_IDS is not set
>  CONFIG_MTD_NAND_IDS=y
>  # CONFIG_MTD_NAND_DISKONCHIP is not set
>  CONFIG_MTD_NAND_AT91_ECC_SOFT=y
>  # CONFIG_MTD_NAND_AT91_ECC_HW is not set
>  # CONFIG_MTD_NAND_AT91_ECC_NONE is not set
>  # CONFIG_MTD_NAND_NANDSIM is not set
>  # CONFIG_MTD_NAND_PLATFORM is not set
>  # CONFIG_MTD_ONENAND is not set
>
>  #
>  # UBI - Unsorted block images
>  #
>  # CONFIG_MTD_UBI is not set
>  # CONFIG_PARPORT is not set
>  CONFIG_BLK_DEV=y
>  # CONFIG_BLK_DEV_COW_COMMON is not set
>  # CONFIG_BLK_DEV_LOOP is not set
>  # CONFIG_BLK_DEV_NBD is not set
>  # CONFIG_BLK_DEV_RAM is not set
>  # CONFIG_CDROM_PKTCDVD is not set
>  # CONFIG_ATA_OVER_ETH is not set
>  # CONFIG_MISC_DEVICES is not set
>
>  #
>  # SCSI device support
>  #
>  # CONFIG_RAID_ATTRS is not set
>  # CONFIG_SCSI is not set
>  # CONFIG_SCSI_DMA is not set
>  # CONFIG_SCSI_NETLINK is not set
>  # CONFIG_ATA is not set
>  # CONFIG_MD is not set
>  CONFIG_NETDEVICES=y
>  # CONFIG_NETDEVICES_MULTIQUEUE is not set
>  # CONFIG_DUMMY is not set
>  # CONFIG_BONDING is not set
>  # CONFIG_MACVLAN is not set
>  # CONFIG_EQUALIZER is not set
>  # CONFIG_TUN is not set
>  # CONFIG_VETH is not set
>  # CONFIG_PHYLIB is not set
>  CONFIG_NET_ETHERNET=y
>  CONFIG_MII=y
>  # CONFIG_MACB is not set
>  # CONFIG_AX88796 is not set
>  # CONFIG_SMC91X is not set
>  CONFIG_DM9000=y
>  # CONFIG_IBM_NEW_EMAC_ZMII is not set
>  # CONFIG_IBM_NEW_EMAC_RGMII is not set
>  # CONFIG_IBM_NEW_EMAC_TAH is not set
>  # CONFIG_IBM_NEW_EMAC_EMAC4 is not set
>  # CONFIG_B44 is not set
>  # CONFIG_NETDEV_1000 is not set
>  # CONFIG_NETDEV_10000 is not set
>
>  #
>  # Wireless LAN
>  #
>  # CONFIG_WLAN_PRE80211 is not set
>  # CONFIG_WLAN_80211 is not set
>  # CONFIG_WAN is not set
>  # CONFIG_PPP is not set
>  # CONFIG_SLIP is not set
>  # CONFIG_SHAPER is not set
>  # CONFIG_NETCONSOLE is not set
>  # CONFIG_NETPOLL is not set
>  # CONFIG_NET_POLL_CONTROLLER is not set
>  # CONFIG_ISDN is not set
>
>  #
>  # Input device support
>  #
>  CONFIG_INPUT=y
>  # CONFIG_INPUT_FF_MEMLESS is not set
>  # CONFIG_INPUT_POLLDEV is not set
>
>  #
>  # Userland interfaces
>  #
>  CONFIG_INPUT_MOUSEDEV=y
>  # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
>  CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
>  CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
>  # CONFIG_INPUT_JOYDEV is not set
>  # CONFIG_INPUT_EVDEV is not set
>  # CONFIG_INPUT_EVBUG is not set
>
>  #
>  # Input Device Drivers
>  #
>  # CONFIG_INPUT_KEYBOARD is not set
>  # CONFIG_INPUT_MOUSE is not set
>  # CONFIG_INPUT_JOYSTICK is not set
>  # CONFIG_INPUT_TABLET is not set
>  # CONFIG_INPUT_TOUCHSCREEN is not set
>  # CONFIG_INPUT_MISC is not set
>
>  #
>  # Hardware I/O ports
>  #
>  # CONFIG_SERIO is not set
>  # CONFIG_GAMEPORT is not set
>
>  #
>  # Character devices
>  #
>  CONFIG_VT=y
>  CONFIG_VT_CONSOLE=y
>  CONFIG_HW_CONSOLE=y
>  # CONFIG_VT_HW_CONSOLE_BINDING is not set
>  # CONFIG_SERIAL_NONSTANDARD is not set
>
>  #
>  # Serial drivers
>  #
>  # CONFIG_SERIAL_8250 is not set
>
>  #
>  # Non-8250 serial port support
>  #
>  CONFIG_SERIAL_ATMEL=y
>  CONFIG_SERIAL_ATMEL_CONSOLE=y
>  # CONFIG_SERIAL_ATMEL_TTYAT is not set
>  CONFIG_SERIAL_CORE=y
>  CONFIG_SERIAL_CORE_CONSOLE=y
>  CONFIG_UNIX98_PTYS=y
>  # CONFIG_LEGACY_PTYS is not set
>  # CONFIG_IPMI_HANDLER is not set
>  # CONFIG_HW_RANDOM is not set
>  # CONFIG_NVRAM is not set
>  # CONFIG_R3964 is not set
>  # CONFIG_RAW_DRIVER is not set
>  # CONFIG_TCG_TPM is not set
>  # CONFIG_I2C is not set
>
>  #
>  # SPI support
>  #
>  CONFIG_SPI=y
>  CONFIG_SPI_MASTER=y
>
>  #
>  # SPI Master Controller Drivers
>  #
>  CONFIG_SPI_ATMEL=y
>  # CONFIG_SPI_BITBANG is not set
>
>  #
>  # SPI Protocol Masters
>  #
>  # CONFIG_SPI_AT25 is not set
>  # CONFIG_SPI_SPIDEV is not set
>  # CONFIG_SPI_TLE62X0 is not set
>  # CONFIG_W1 is not set
>  # CONFIG_POWER_SUPPLY is not set
>  # CONFIG_HWMON is not set
>  # CONFIG_WATCHDOG is not set
>
>  #
>  # Sonics Silicon Backplane
>  #
>  CONFIG_SSB_POSSIBLE=y
>  # CONFIG_SSB is not set
>
>  #
>  # Multifunction device drivers
>  #
>  # CONFIG_MFD_SM501 is not set
>
>  #
>  # Multimedia devices
>  #
>  # CONFIG_VIDEO_DEV is not set
>  # CONFIG_DVB_CORE is not set
>  # CONFIG_DAB is not set
>
>  #
>  # Graphics support
>  #
>  # CONFIG_VGASTATE is not set
>  # CONFIG_VIDEO_OUTPUT_CONTROL is not set
>  # CONFIG_FB is not set
>  # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
>
>  #
>  # Display device support
>  #
>  # CONFIG_DISPLAY_SUPPORT is not set
>
>  #
>  # Console display driver support
>  #
>  # CONFIG_VGA_CONSOLE is not set
>  CONFIG_DUMMY_CONSOLE=y
>
>  #
>  # Sound
>  #
>  # CONFIG_SOUND is not set
>  # CONFIG_HID_SUPPORT is not set
>  # CONFIG_USB_SUPPORT is not set
>  # CONFIG_MMC is not set
>  # CONFIG_NEW_LEDS is not set
>  CONFIG_RTC_LIB=y
>  # CONFIG_RTC_CLASS is not set
>
>  #
>  # File systems
>  #
>  # CONFIG_EXT2_FS is not set
>  # CONFIG_EXT3_FS is not set
>  # CONFIG_EXT4DEV_FS is not set
>  # CONFIG_REISERFS_FS is not set
>  # CONFIG_JFS_FS is not set
>  # CONFIG_FS_POSIX_ACL is not set
>  # CONFIG_XFS_FS is not set
>  # CONFIG_GFS2_FS is not set
>  # CONFIG_OCFS2_FS is not set
>  # CONFIG_MINIX_FS is not set
>  # CONFIG_ROMFS_FS is not set
>  # CONFIG_INOTIFY is not set
>  # CONFIG_QUOTA is not set
>  CONFIG_DNOTIFY=y
>  # CONFIG_AUTOFS_FS is not set
>  # CONFIG_AUTOFS4_FS is not set
>  # CONFIG_FUSE_FS is not set
>
>  #
>  # CD-ROM/DVD Filesystems
>  #
>  # CONFIG_ISO9660_FS is not set
>  # CONFIG_UDF_FS is not set
>
>  #
>  # DOS/FAT/NT Filesystems
>  #
>  # CONFIG_MSDOS_FS is not set
>  # CONFIG_VFAT_FS is not set
>  # CONFIG_NTFS_FS is not set
>
>  #
>  # Pseudo filesystems
>  #
>  CONFIG_PROC_FS=y
>  CONFIG_PROC_SYSCTL=y
>  CONFIG_SYSFS=y
>  CONFIG_TMPFS=y
>  # CONFIG_TMPFS_POSIX_ACL is not set
>  # CONFIG_HUGETLB_PAGE is not set
>  # CONFIG_CONFIGFS_FS is not set
>
>  #
>  # Miscellaneous filesystems
>  #
>  # CONFIG_ADFS_FS is not set
>  # CONFIG_AFFS_FS is not set
>  # CONFIG_HFS_FS is not set
>  # CONFIG_HFSPLUS_FS is not set
>  # CONFIG_BEFS_FS is not set
>  # CONFIG_BFS_FS is not set
>  # CONFIG_EFS_FS is not set
>  CONFIG_YAFFS_FS=y
>  CONFIG_YAFFS_YAFFS1=y
>  # CONFIG_YAFFS_9BYTE_TAGS is not set
>  # CONFIG_YAFFS_DOES_ECC is not set
>  CONFIG_YAFFS_YAFFS2=y
>  CONFIG_YAFFS_AUTO_YAFFS2=y
>  # CONFIG_YAFFS_DISABLE_LAZY_LOAD is not set
>  # CONFIG_YAFFS_DISABLE_WIDE_TNODES is not set
>  # CONFIG_YAFFS_ALWAYS_CHECK_CHUNK_ERASED is not set
>  CONFIG_YAFFS_SHORT_NAMES_IN_RAM=y
>  CONFIG_JFFS2_FS=y
>  CONFIG_JFFS2_FS_DEBUG=0
>  CONFIG_JFFS2_FS_WRITEBUFFER=y
>  # CONFIG_JFFS2_FS_WBUF_VERIFY is not set
>  # CONFIG_JFFS2_SUMMARY is not set
>  # CONFIG_JFFS2_FS_XATTR is not set
>  CONFIG_JFFS2_COMPRESSION_OPTIONS=y
>  # CONFIG_JFFS2_ZLIB is not set
>  # CONFIG_JFFS2_LZO is not set
>  # CONFIG_JFFS2_RTIME is not set
>  # CONFIG_JFFS2_RUBIN is not set
>  CONFIG_JFFS2_CMODE_NONE=y
>  # CONFIG_JFFS2_CMODE_PRIORITY is not set
>  # CONFIG_JFFS2_CMODE_SIZE is not set
>  # CONFIG_JFFS2_CMODE_FAVOURLZO is not set
>  # CONFIG_CRAMFS is not set
>  # CONFIG_VXFS_FS is not set
>  # CONFIG_HPFS_FS is not set
>  # CONFIG_QNX4FS_FS is not set
>  # CONFIG_SYSV_FS is not set
>  # CONFIG_UFS_FS is not set
>  CONFIG_NETWORK_FILESYSTEMS=y
>  # CONFIG_NFS_FS is not set
>  # CONFIG_NFSD is not set
>  # CONFIG_SMB_FS is not set
>  # CONFIG_CIFS is not set
>  # CONFIG_NCP_FS is not set
>  # CONFIG_CODA_FS is not set
>  # CONFIG_AFS_FS is not set
>
>  #
>  # Partition Types
>  #
>  # CONFIG_PARTITION_ADVANCED is not set
>  CONFIG_MSDOS_PARTITION=y
>  # CONFIG_NLS is not set
>  # CONFIG_DLM is not set
>  CONFIG_INSTRUMENTATION=y
>  # CONFIG_PROFILING is not set
>  # CONFIG_MARKERS is not set
>
>  #
>  # Kernel hacking
>  #
>  # CONFIG_PRINTK_TIME is not set
>  CONFIG_ENABLE_WARN_DEPRECATED=y
>  # CONFIG_ENABLE_MUST_CHECK is not set
>  # CONFIG_MAGIC_SYSRQ is not set
>  # CONFIG_UNUSED_SYMBOLS is not set
>  CONFIG_DEBUG_FS=y
>  # CONFIG_HEADERS_CHECK is not set
>  # CONFIG_IPIPE_DEBUG is not set
>  # CONFIG_DEBUG_KERNEL is not set
>  CONFIG_DEBUG_BUGVERBOSE=y
>  CONFIG_FRAME_POINTER=y
>  # CONFIG_SAMPLES is not set
>  # CONFIG_DEBUG_USER is not set
>
>  #
>  # Security options
>  #
>  # CONFIG_KEYS is not set
>  # CONFIG_SECURITY is not set
>  # CONFIG_SECURITY_FILE_CAPABILITIES is not set
>  # CONFIG_CRYPTO is not set
>
>  #
>  # Library routines
>  #
>  CONFIG_BITREVERSE=y
>  # CONFIG_CRC_CCITT is not set
>  # CONFIG_CRC16 is not set
>  # CONFIG_CRC_ITU_T is not set
>  CONFIG_CRC32=y
>  # CONFIG_CRC7 is not set
>  # CONFIG_LIBCRC32C is not set
>  CONFIG_PLIST=y
>  CONFIG_HAS_IOMEM=y
>  CONFIG_HAS_IOPORT=y
>  CONFIG_HAS_DMA=y
>

