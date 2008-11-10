Message-ID: <217b7eb20811100238o4b7e9155lc3e74359ca795084@domain.hid>
Date: Mon, 10 Nov 2008 10:38:25 +0000
From: Hank <hank007@domain.hid>
In-Reply-To: <49175FB6.1020105@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_91970_31288934.1226313505318"
References: <mailman.10531.1226258953.25037.xenomai@xenomai.org>
	<217b7eb20811091134h77fbd77bm2e880708b21e5b06@domain.hid>
	<49175FB6.1020105@domain.hid>
Subject: Re: [Xenomai-help] Xenomai skins init errors
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

------=_Part_91970_31288934.1226313505318
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, Nov 9, 2008 at 10:09 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> Hank wrote:
> > Hi
> >
> > I'm Porting Xenomai to Freescale imx31 platform. Have previously been
> > using ipipe 1.7 + xenomai 2.4.4. <http://2.4.4.> Now migrated to ipipe
> > 1.9 and latest Xenomai snapshot. The kernel is 2.6.24. <http://2.6.24.>
> > Ipipe seems to OK but getting errors on xenomai skins initialization:
> >
> >
> > -----------------------------------------------------------
> > I-pipe: Domain Xenomai registered.
> >
> > Xenomai: hal/arm started.
> >
> > Xenomai: real-time nucleus v2.5-devel (Flying In A Blue Dream) loaded.
> >
> > Xenomai: native skin init failed, code -38.
> >
> > Xenomai: starting POSIX services.
> >
> > Xenomai: POSIX skin init failed, code -38.
> >
> > Xenomai: RTDM skin init failed, code -38.
> > ----------------------------------------------------------
> >
>
> A possible explanation could be that Xenomai does not ask for grabbing the
> right
> ARM timer. Sending your .config may help ARM folks here.
>

Here is the config:

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.24
#
CONFIG_ARM=y
CONFIG_SYS_SUPPORTS_APM_EMULATION=y
# CONFIG_GENERIC_GPIO is not set
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_MMU=y
# CONFIG_NO_IOPORT is not set
CONFIG_GENERIC_HARDIRQS=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ZONE_DMA=y
CONFIG_ARCH_MTD_XIP=y
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
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_CGROUPS is not set
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_FAIR_USER_SCHED=y
# CONFIG_FAIR_CGROUP_SCHED is not set
CONFIG_SYSFS_DEPRECATED=y
# CONFIG_RELAY is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_EMBEDDED=y
CONFIG_UID16=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_ANON_INODES=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_BLOCK=y
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set
# CONFIG_BLK_DEV_BSG is not set

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
CONFIG_XENO_FASTSEM=y
CONFIG_XENO_OPT_NUCLEUS=y
CONFIG_XENO_OPT_PERVASIVE=y
# CONFIG_XENO_OPT_ISHIELD is not set
CONFIG_XENO_OPT_PRIOCPL=y
CONFIG_XENO_OPT_PIPELINE_HEAD=y
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_REGISTRY=y
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_SYS_HEAPSZ=128
CONFIG_XENO_OPT_SYS_STACKPOOLSZ=32
CONFIG_XENO_OPT_SEM_HEAPSZ=12
CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ=12
CONFIG_XENO_OPT_STATS=y
# CONFIG_XENO_OPT_DEBUG is not set
# CONFIG_XENO_OPT_SHIRQ is not set

#
# Timing
#
# CONFIG_XENO_OPT_TIMING_PERIODIC is not set
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
# CONFIG_XENO_HW_FPU is not set

#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_OPT_NATIVE_PERIOD=0
CONFIG_XENO_OPT_NATIVE_PIPE=y
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=1024
CONFIG_XENO_OPT_NATIVE_REGISTRY=y
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
CONFIG_XENO_SKIN_POSIX=y
CONFIG_XENO_OPT_POSIX_PERIOD=0
# CONFIG_XENO_OPT_POSIX_SHM is not set
# CONFIG_XENO_OPT_POSIX_INTR is not set
# CONFIG_XENO_OPT_POSIX_SELECT is not set
CONFIG_XENO_OPT_DEBUG_POSIX=y
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
# CONFIG_XENO_SKIN_RTAI is not set
CONFIG_XENO_SKIN_RTDM=y
CONFIG_XENO_OPT_RTDM_PERIOD=0
CONFIG_XENO_OPT_RTDM_FILDES=128
# CONFIG_XENO_OPT_RTDM_SELECT is not set

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
CONFIG_XENO_KLATENCY_MODULE=m
# CONFIG_XENO_DRIVERS_TIMERBENCH is not set
# CONFIG_XENO_DRIVERS_IRQBENCH is not set
# CONFIG_XENO_DRIVERS_SWITCHTEST is not set

#
# CAN drivers
#
# CONFIG_XENO_DRIVERS_CAN is not set

#
# COMEDI drivers
#
# CONFIG_XENO_DRIVERS_COMEDI is not set

#
# System Type
#
# CONFIG_ARCH_AAEC2000 is not set
# CONFIG_ARCH_INTEGRATOR is not set
# CONFIG_ARCH_REALVIEW is not set
# CONFIG_ARCH_VERSATILE is not set
# CONFIG_ARCH_AT91 is not set
# CONFIG_ARCH_CLPS7500 is not set
# CONFIG_ARCH_CLPS711X is not set
# CONFIG_ARCH_CO285 is not set
# CONFIG_ARCH_EBSA110 is not set
# CONFIG_ARCH_EP93XX is not set
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
# CONFIG_ARCH_KS8695 is not set
# CONFIG_ARCH_NS9XXX is not set
CONFIG_ARCH_MXC=y
# CONFIG_ARCH_PNX4008 is not set
# CONFIG_ARCH_PXA is not set
# CONFIG_ARCH_RPC is not set
# CONFIG_ARCH_SA1100 is not set
# CONFIG_ARCH_S3C2410 is not set
# CONFIG_ARCH_SHARK is not set
# CONFIG_ARCH_LH7A40X is not set
# CONFIG_ARCH_DAVINCI is not set
# CONFIG_ARCH_OMAP is not set

#
# Boot options
#

#
# Power management
#

#
# Freescale MXC Implementations
#
# CONFIG_ARCH_MXC91321 is not set
# CONFIG_ARCH_MX37 is not set
# CONFIG_ARCH_MX35 is not set
CONFIG_ARCH_MX3=y
# CONFIG_ARCH_MX27 is not set
# CONFIG_ARCH_MX21 is not set
CONFIG_ARCH_MXC_HAS_NFC_V1=y
CONFIG_I2C_MXC_SELECT1=y
CONFIG_I2C_MXC_SELECT2=y

#
# MX3 Options
#
CONFIG_MACH_MX31LITE=y
# CONFIG_MACH_MX31ADS is not set
# CONFIG_MACH_MX31_3DS is not set
CONFIG_MX3_DOZE_DURING_IDLE=y
CONFIG_MXC_SDMA_API=y

#
# SDMA options
#
# CONFIG_SDMA_IRAM is not set
CONFIG_ARCH_MXC_HAS_NFC_V2=y

#
# Device options
#
# CONFIG_I2C_MXC_SELECT3 is not set
CONFIG_ARCH_HAS_EVTMON=y
CONFIG_DMA_ZONE_SIZE=24
# CONFIG_ISP1504_MXC is not set

#
# Processor Type
#
CONFIG_CPU_32=y
# CONFIG_CPU_ARM926T is not set
CONFIG_CPU_V6=y
# CONFIG_CPU_32v6K is not set
CONFIG_CPU_32v6=y
CONFIG_CPU_ABRT_EV6=y
CONFIG_CPU_CACHE_V6=y
CONFIG_CPU_CACHE_VIPT=y
CONFIG_CPU_COPY_V6=y
CONFIG_CPU_TLB_V6=y
CONFIG_CPU_HAS_ASID=y
CONFIG_CPU_CP15=y
CONFIG_CPU_CP15_MMU=y

#
# Processor Features
#
CONFIG_ARM_THUMB=y
# CONFIG_CPU_ICACHE_DISABLE is not set
# CONFIG_CPU_DCACHE_DISABLE is not set
# CONFIG_CPU_BPREDICT_DISABLE is not set
CONFIG_OUTER_CACHE=y
CONFIG_CACHE_L2X0=y

#
# Bus support
#
CONFIG_ISA=y
# CONFIG_PCI_SYSCALL is not set
# CONFIG_ARCH_SUPPORTS_MSI is not set
CONFIG_PCCARD=m
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
# CONFIG_PCMCIA_IOCTL is not set

#
# PC-card bridges
#
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y

#
# Kernel Features
#
# CONFIG_TICK_ONESHOT is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
CONFIG_IPIPE=y
CONFIG_IPIPE_DOMAINS=4
CONFIG_IPIPE_COMPAT=y
# CONFIG_PREEMPT is not set
CONFIG_HZ=100
CONFIG_AEABI=y
# CONFIG_OABI_COMPAT is not set
# CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_RESOURCES_64BIT is not set
CONFIG_ZONE_DMA_FLAG=1
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_LEDS is not set
CONFIG_ALIGNMENT_TRAP=y

#
# Boot options
#
CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0
CONFIG_CMDLINE="noinitrd console=ttymxc0 root=/dev/mtdblock2 rw ip=off"
# CONFIG_XIP_KERNEL is not set
# CONFIG_KEXEC is not set

#
# Floating point emulation
#

#
# At least one emulation must be selected
#
# CONFIG_VFP is not set

#
# Userspace binary formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Power management options
#
CONFIG_PM=y
# CONFIG_PM_LEGACY is not set
# CONFIG_PM_DEBUG is not set
CONFIG_PM_SLEEP=y
CONFIG_SUSPEND_UP_POSSIBLE=y
CONFIG_SUSPEND=y
# CONFIG_APM_EMULATION is not set

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
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
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set

#
# Wireless
#
# CONFIG_CFG80211 is not set
CONFIG_WIRELESS_EXT=y
# CONFIG_MAC80211 is not set
CONFIG_IEEE80211=y
# CONFIG_IEEE80211_DEBUG is not set
# CONFIG_IEEE80211_CRYPT_WEP is not set
# CONFIG_IEEE80211_CRYPT_CCMP is not set
# CONFIG_IEEE80211_CRYPT_TKIP is not set
# CONFIG_IEEE80211_SOFTMAC is not set
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
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
CONFIG_MTD=y
# CONFIG_MTD_DEBUG is not set
# CONFIG_MTD_CONCAT is not set
CONFIG_MTD_PARTITIONS=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
CONFIG_MTD_CMDLINE_PARTS=y
# CONFIG_MTD_AFS_PARTS is not set

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
CONFIG_MTD_CFI_GEOMETRY=y
# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
CONFIG_MTD_MAP_BANK_WIDTH_2=y
# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
# CONFIG_MTD_CFI_I2 is not set
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_OTP is not set
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# CONFIG_MTD_XIP is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_ARM_INTEGRATOR is not set
# CONFIG_MTD_PLATRAM is not set
CONFIG_MTD_MXC=y

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_M25P80 is not set
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
CONFIG_MTD_NAND=y
# CONFIG_MTD_NAND_VERIFY_WRITE is not set
# CONFIG_MTD_NAND_ECC_SMC is not set
# CONFIG_MTD_NAND_MUSEUM_IDS is not set
CONFIG_MTD_NAND_IDS=y
# CONFIG_MTD_NAND_DISKONCHIP is not set
# CONFIG_MTD_NAND_NANDSIM is not set
CONFIG_MTD_NAND_MXC=y
CONFIG_MTD_NAND_MXC_V2=y
# CONFIG_MTD_NAND_MXC_SWECC is not set
# CONFIG_MTD_NAND_MXC_FORCE_CE is not set
# CONFIG_MTD_NAND_MXC_ECC_CORRECTION_OPTION2 is not set
# CONFIG_MXC_NAND_LOW_LEVEL_ERASE is not set
# CONFIG_MTD_NAND_PLATFORM is not set
# CONFIG_MTD_ALAUDA is not set
# CONFIG_MTD_ONENAND is not set

#
# UBI - Unsorted block images
#
# CONFIG_MTD_UBI is not set

#
# Voltage and Current regulators
#
CONFIG_REGULATOR_API=y
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_MC13783=y
# CONFIG_PARPORT is not set
# CONFIG_PNP is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_MISC_DEVICES=y
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_TGT is not set
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set
CONFIG_SCSI_WAIT_SCAN=m

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
# CONFIG_ATA is not set
# CONFIG_MD is not set
CONFIG_NETDEVICES=y
# CONFIG_NETDEVICES_MULTIQUEUE is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
# CONFIG_ARCNET is not set
# CONFIG_PHYLIB is not set
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_AX88796 is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_SMC91X is not set
# CONFIG_DM9000 is not set
# CONFIG_SMC911X is not set
CONFIG_SMSC911X=y
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
# CONFIG_NET_PCI is not set
# CONFIG_B44 is not set
# CONFIG_NETDEV_1000 is not set
# CONFIG_NETDEV_10000 is not set
# CONFIG_TR is not set

#
# Wireless LAN
#
# CONFIG_WLAN_PRE80211 is not set
# CONFIG_WLAN_80211 is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_NET_PCMCIA is not set
# CONFIG_WAN is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPP_MPPE is not set
# CONFIG_PPPOE is not set
# CONFIG_PPPOL2TP is not set
# CONFIG_SLIP is not set
CONFIG_SLHC=m
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
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
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
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
CONFIG_KEYBOARD_MXC=y
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
CONFIG_TOUCHSCREEN_MXC=y
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_UCB1400 is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
# CONFIG_SERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MXC=y
CONFIG_SERIAL_MXC_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_UNIX98_PTYS is not set
# CONFIG_LEGACY_PTYS is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
# CONFIG_NVRAM is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
CONFIG_DEVPORT=y
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ELEKTOR is not set
CONFIG_I2C_MXC=y
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_TINY_USB is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_DS1682 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_BITBANG=y
CONFIG_SPI_MXC=y
# CONFIG_SPI_MXC_TEST_LOOPBACK is not set
# CONFIG_SPI_MXC_SELECT1 is not set
CONFIG_SPI_MXC_SELECT2=y
CONFIG_SPI_MXC_SELECT3=y

#
# SPI Protocol Masters
#
# CONFIG_SPI_AT25 is not set
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_TLE62X0 is not set
CONFIG_W1=y
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_DS2490 is not set
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_MXC=y
# CONFIG_W1_MASTER_DS1WM is not set

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2751 is not set
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2760 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set
# CONFIG_WATCHDOG is not set

#
# Sonics Silicon Backplane
#
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_SM501 is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L1=y
CONFIG_VIDEO_V4L1_COMPAT=y
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_CAPTURE_DRIVERS is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set
# CONFIG_USB_DSBR is not set
# CONFIG_DVB_CORE is not set
CONFIG_DAB=y
# CONFIG_USB_DABUSB is not set

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
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_PCM_OSS_PLUGINS=y
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ALSA ARM devices
#
# CONFIG_SND_MXC_SPDIF is not set
CONFIG_SND_MXC_PMIC=y
# CONFIG_SND_MXC_PLAYBACK_MIXING is not set
# CONFIG_HEADSET_DETECT_ENABLE is not set

#
# SPI devices
#

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_CAIAQ is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_PDAUDIOCF is not set

#
# System on Chip audio support
#
# CONFIG_SND_SOC is not set

#
# SoC Audio support for SuperH
#
# CONFIG_SND_MXC_SOC is not set
# CONFIG_SND_MXC_SOC_IRAM is not set
# CONFIG_SND_SOC_IMX_3STACK_WM8350 is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
# CONFIG_HID_DEBUG is not set
# CONFIG_HIDRAW is not set

#
# USB Input Devices
#
CONFIG_USB_HID=m
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB_ARCH_HAS_OHCI is not set
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEVICEFS is not set
# CONFIG_USB_DEVICE_CLASS is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=y
# CONFIG_USB_PERSIST is not set
CONFIG_USB_OTG=y
CONFIG_USB_OTG_WHITELIST=y
# CONFIG_USB_OTG_BLACKLIST_HUB is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
CONFIG_USB_MON=y

#
# Belcarra USBLAN Networking for USB
#
# CONFIG_USB_USBLAN is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_BERRY_CHARGE is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGET is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# On-The-Go and USB Peripheral Support
#
CONFIG_OTG=m

#
#
#

#
# On-The-Go Support Platform Selection
#
# CONFIG_OTG_IMX31ADS is not set

#
#
#
CONFIG_MMC=y
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_UNSAFE_RESUME is not set

#
# MMC/SD Card Drivers
#
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_BOUNCE=y
# CONFIG_SDIO_UART is not set

#
# MMC/SD Host Controller Drivers
#
# CONFIG_MMC_SPI is not set
CONFIG_MMC_MXC=y
CONFIG_MMC_IMX_ESDHCI=y
# CONFIG_NEW_LEDS is not set
CONFIG_RTC_LIB=y
# CONFIG_RTC_CLASS is not set

#
# MXC support drivers
#
CONFIG_MXC_IPU=y
CONFIG_MXC_IPU_V1=y
CONFIG_MXC_IPU_PF=y

#
# MXC SSI support
#
CONFIG_MXC_SSI=y

#
# MXC Digital Audio Multiplexer support
#
CONFIG_MXC_DAM=y

#
# MXC PMIC support
#
CONFIG_MXC_SPI_PMIC_CORE=y
# CONFIG_MXC_I2C_MCU_PMIC_CORE is not set
CONFIG_MXC_PMIC=y
CONFIG_MXC_PMIC_CHARDEV=y

#
# MXC PMIC Client Drivers
#
CONFIG_MXC_PMIC_MC13783=y
CONFIG_MXC_MC13783_ADC=y
CONFIG_MXC_MC13783_AUDIO=y
CONFIG_MXC_MC13783_RTC=y
CONFIG_MXC_MC13783_LIGHT=y
CONFIG_MXC_MC13783_BATTERY=y
CONFIG_MXC_MC13783_CONNECTIVITY=y
CONFIG_MXC_MC13783_POWER=y

#
# Advanced Power Management devices
#
# CONFIG_MXC_DPTC is not set
# CONFIG_MXC_DVFS is not set

#
# MXC Security Drivers
#
CONFIG_MXC_SECURITY_SCC=y
# CONFIG_SCC_DEBUG is not set
CONFIG_MXC_SECURITY_RNG=y
# CONFIG_MXC_RNG_TEST_DRIVER is not set
# CONFIG_MXC_RNG_DEBUG is not set
CONFIG_MXC_SECURITY_RTIC=y
# CONFIG_MXC_RTIC_TEST_DEBUG is not set
CONFIG_MXC_SECURITY_CORE=y

#
# MXC MPEG4 Encoder Kernel module support
#
CONFIG_MXC_HMP4E=y
# CONFIG_MXC_HMP4E_DEBUG is not set

#
# MXC HARDWARE EVENT
#
CONFIG_MXC_HWEVENT=y

#
# MXC VPU(Video Processing Unit) support
#
CONFIG_MXC_VPU=y
# CONFIG_MXC_VPU_DEBUG is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4DEV_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
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
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_BIND34 is not set
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
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
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
CONFIG_NLS_ASCII=m
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
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
CONFIG_INSTRUMENTATION=y
CONFIG_PROFILING=y
CONFIG_OPROFILE=y
CONFIG_OPROFILE_ARMV6=y
CONFIG_OPROFILE_ARM11_CORE=y
CONFIG_OPROFILE_ARM11_EVTMON=y
# CONFIG_MARKERS is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
# CONFIG_IPIPE_DEBUG is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_TIMER_STATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_FRAME_POINTER=y
CONFIG_FORCED_INLINING=y
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_SAMPLES is not set
# CONFIG_DEBUG_USER is not set
# CONFIG_DEBUG_ERRORS is not set
# CONFIG_DEBUG_LL is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITY_FILE_CAPABILITIES is not set
# CONFIG_CRYPTO is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_CRC_CCITT=m
# CONFIG_CRC16 is not set
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_PLIST=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y

------=_Part_91970_31288934.1226313505318
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, Nov 9, 2008 at 10:09 PM, Philippe Gerum <span dir="ltr">&lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt;</span> wrote:<br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">Hank wrote:<br>
&gt; Hi<br>
&gt;<br>
&gt; I&#39;m Porting Xenomai to Freescale imx31 platform. Have previously been<br>
</div>&gt; using ipipe 1.7 + xenomai <a href="http://2.4.4." target="_blank">2.4.4.</a> &lt;<a href="http://2.4.4" target="_blank">http://2.4.4</a>.&gt; Now migrated to ipipe<br>
&gt; 1.9 and latest Xenomai snapshot. The kernel is <a href="http://2.6.24." target="_blank">2.6.24.</a> &lt;<a href="http://2.6.24" target="_blank">http://2.6.24</a>.&gt;<br>
<div class="Ih2E3d">&gt; Ipipe seems to OK but getting errors on xenomai skins initialization:<br>
&gt;<br>
&gt;<br>
&gt; -----------------------------------------------------------<br>
&gt; I-pipe: Domain Xenomai registered.<br>
&gt;<br>
&gt; Xenomai: hal/arm started.<br>
&gt;<br>
&gt; Xenomai: real-time nucleus v2.5-devel (Flying In A Blue Dream) loaded.<br>
&gt;<br>
&gt; Xenomai: native skin init failed, code -38.<br>
&gt;<br>
&gt; Xenomai: starting POSIX services.<br>
&gt;<br>
&gt; Xenomai: POSIX skin init failed, code -38.<br>
&gt;<br>
&gt; Xenomai: RTDM skin init failed, code -38.<br>
&gt; ----------------------------------------------------------<br>
&gt;<br>
<br>
</div>A possible explanation could be that Xenomai does not ask for grabbing the right<br>
ARM timer. Sending your .config may help ARM folks here.<br></blockquote><div><br>Here is the config:<br><br>#<br># Automatically generated make config: don&#39;t edit<br># Linux kernel version: 2.6.24<br>#<br>CONFIG_ARM=y<br>
CONFIG_SYS_SUPPORTS_APM_EMULATION=y<br># CONFIG_GENERIC_GPIO is not set<br>CONFIG_GENERIC_TIME=y<br>CONFIG_GENERIC_CLOCKEVENTS=y<br>CONFIG_MMU=y<br># CONFIG_NO_IOPORT is not set<br>CONFIG_GENERIC_HARDIRQS=y<br>CONFIG_STACKTRACE_SUPPORT=y<br>
CONFIG_LOCKDEP_SUPPORT=y<br>CONFIG_TRACE_IRQFLAGS_SUPPORT=y<br>CONFIG_HARDIRQS_SW_RESEND=y<br>CONFIG_GENERIC_IRQ_PROBE=y<br>CONFIG_RWSEM_GENERIC_SPINLOCK=y<br># CONFIG_ARCH_HAS_ILOG2_U32 is not set<br># CONFIG_ARCH_HAS_ILOG2_U64 is not set<br>
CONFIG_GENERIC_HWEIGHT=y<br>CONFIG_GENERIC_CALIBRATE_DELAY=y<br>CONFIG_ZONE_DMA=y<br>CONFIG_ARCH_MTD_XIP=y<br>CONFIG_VECTORS_BASE=0xffff0000<br>CONFIG_DEFCONFIG_LIST=&quot;/lib/modules/$UNAME_RELEASE/.config&quot;<br><br>
#<br># General setup<br>#<br>CONFIG_EXPERIMENTAL=y<br>CONFIG_BROKEN_ON_SMP=y<br>CONFIG_INIT_ENV_ARG_LIMIT=32<br>CONFIG_LOCALVERSION=&quot;&quot;<br>CONFIG_LOCALVERSION_AUTO=y<br>CONFIG_SWAP=y<br>CONFIG_SYSVIPC=y<br>CONFIG_SYSVIPC_SYSCTL=y<br>
# CONFIG_POSIX_MQUEUE is not set<br># CONFIG_BSD_PROCESS_ACCT is not set<br># CONFIG_TASKSTATS is not set<br># CONFIG_USER_NS is not set<br># CONFIG_PID_NS is not set<br># CONFIG_AUDIT is not set<br>CONFIG_IKCONFIG=y<br>CONFIG_IKCONFIG_PROC=y<br>
CONFIG_LOG_BUF_SHIFT=14<br># CONFIG_CGROUPS is not set<br>CONFIG_FAIR_GROUP_SCHED=y<br>CONFIG_FAIR_USER_SCHED=y<br># CONFIG_FAIR_CGROUP_SCHED is not set<br>CONFIG_SYSFS_DEPRECATED=y<br># CONFIG_RELAY is not set<br># CONFIG_BLK_DEV_INITRD is not set<br>
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set<br>CONFIG_SYSCTL=y<br>CONFIG_EMBEDDED=y<br>CONFIG_UID16=y<br>CONFIG_SYSCTL_SYSCALL=y<br>CONFIG_KALLSYMS=y<br># CONFIG_KALLSYMS_ALL is not set<br># CONFIG_KALLSYMS_EXTRA_PASS is not set<br>
CONFIG_HOTPLUG=y<br>CONFIG_PRINTK=y<br>CONFIG_BUG=y<br>CONFIG_ELF_CORE=y<br>CONFIG_BASE_FULL=y<br>CONFIG_FUTEX=y<br>CONFIG_ANON_INODES=y<br>CONFIG_EPOLL=y<br>CONFIG_SIGNALFD=y<br>CONFIG_EVENTFD=y<br>CONFIG_SHMEM=y<br>CONFIG_VM_EVENT_COUNTERS=y<br>
CONFIG_SLAB=y<br># CONFIG_SLUB is not set<br># CONFIG_SLOB is not set<br>CONFIG_SLABINFO=y<br>CONFIG_RT_MUTEXES=y<br># CONFIG_TINY_SHMEM is not set<br>CONFIG_BASE_SMALL=0<br>CONFIG_MODULES=y<br>CONFIG_MODULE_UNLOAD=y<br>CONFIG_MODULE_FORCE_UNLOAD=y<br>
CONFIG_MODVERSIONS=y<br># CONFIG_MODULE_SRCVERSION_ALL is not set<br>CONFIG_KMOD=y<br>CONFIG_BLOCK=y<br># CONFIG_LBD is not set<br># CONFIG_BLK_DEV_IO_TRACE is not set<br># CONFIG_LSF is not set<br># CONFIG_BLK_DEV_BSG is not set<br>
<br>#<br># IO Schedulers<br>#<br>CONFIG_IOSCHED_NOOP=y<br>CONFIG_IOSCHED_AS=y<br>CONFIG_IOSCHED_DEADLINE=y<br>CONFIG_IOSCHED_CFQ=y<br># CONFIG_DEFAULT_AS is not set<br># CONFIG_DEFAULT_DEADLINE is not set<br>CONFIG_DEFAULT_CFQ=y<br>
# CONFIG_DEFAULT_NOOP is not set<br>CONFIG_DEFAULT_IOSCHED=&quot;cfq&quot;<br><br>#<br># Real-time sub-system<br>#<br>CONFIG_XENOMAI=y<br>CONFIG_XENO_GENERIC_STACKPOOL=y<br>CONFIG_XENO_FASTSEM=y<br>CONFIG_XENO_OPT_NUCLEUS=y<br>
CONFIG_XENO_OPT_PERVASIVE=y<br># CONFIG_XENO_OPT_ISHIELD is not set<br>CONFIG_XENO_OPT_PRIOCPL=y<br>CONFIG_XENO_OPT_PIPELINE_HEAD=y<br>CONFIG_XENO_OPT_PIPE=y<br>CONFIG_XENO_OPT_PIPE_NRDEV=32<br>CONFIG_XENO_OPT_REGISTRY=y<br>
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512<br>CONFIG_XENO_OPT_SYS_HEAPSZ=128<br>CONFIG_XENO_OPT_SYS_STACKPOOLSZ=32<br>CONFIG_XENO_OPT_SEM_HEAPSZ=12<br>CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ=12<br>CONFIG_XENO_OPT_STATS=y<br># CONFIG_XENO_OPT_DEBUG is not set<br>
# CONFIG_XENO_OPT_SHIRQ is not set<br><br>#<br># Timing<br>#<br># CONFIG_XENO_OPT_TIMING_PERIODIC is not set<br>CONFIG_XENO_OPT_TIMING_SCHEDLAT=0<br><br>#<br># Scalability<br>#<br># CONFIG_XENO_OPT_SCALABLE_SCHED is not set<br>
CONFIG_XENO_OPT_TIMER_LIST=y<br># CONFIG_XENO_OPT_TIMER_HEAP is not set<br># CONFIG_XENO_OPT_TIMER_WHEEL is not set<br><br>#<br># Machine<br>#<br># CONFIG_XENO_HW_FPU is not set<br><br>#<br># Interfaces<br>#<br>CONFIG_XENO_SKIN_NATIVE=y<br>
CONFIG_XENO_OPT_NATIVE_PERIOD=0<br>CONFIG_XENO_OPT_NATIVE_PIPE=y<br>CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=1024<br>CONFIG_XENO_OPT_NATIVE_REGISTRY=y<br>CONFIG_XENO_OPT_NATIVE_SEM=y<br>CONFIG_XENO_OPT_NATIVE_EVENT=y<br>CONFIG_XENO_OPT_NATIVE_MUTEX=y<br>
CONFIG_XENO_OPT_NATIVE_COND=y<br>CONFIG_XENO_OPT_NATIVE_QUEUE=y<br>CONFIG_XENO_OPT_NATIVE_BUFFER=y<br>CONFIG_XENO_OPT_NATIVE_HEAP=y<br>CONFIG_XENO_OPT_NATIVE_ALARM=y<br>CONFIG_XENO_OPT_NATIVE_MPS=y<br># CONFIG_XENO_OPT_NATIVE_INTR is not set<br>
CONFIG_XENO_SKIN_POSIX=y<br>CONFIG_XENO_OPT_POSIX_PERIOD=0<br># CONFIG_XENO_OPT_POSIX_SHM is not set<br># CONFIG_XENO_OPT_POSIX_INTR is not set<br># CONFIG_XENO_OPT_POSIX_SELECT is not set<br>CONFIG_XENO_OPT_DEBUG_POSIX=y<br>
# CONFIG_XENO_SKIN_PSOS is not set<br># CONFIG_XENO_SKIN_UITRON is not set<br># CONFIG_XENO_SKIN_VRTX is not set<br># CONFIG_XENO_SKIN_VXWORKS is not set<br># CONFIG_XENO_SKIN_RTAI is not set<br>CONFIG_XENO_SKIN_RTDM=y<br>
CONFIG_XENO_OPT_RTDM_PERIOD=0<br>CONFIG_XENO_OPT_RTDM_FILDES=128<br># CONFIG_XENO_OPT_RTDM_SELECT is not set<br><br>#<br># Drivers<br>#<br><br>#<br># Serial drivers<br>#<br># CONFIG_XENO_DRIVERS_16550A is not set<br><br>#<br>
# Testing drivers<br>#<br>CONFIG_XENO_KLATENCY_MODULE=m<br># CONFIG_XENO_DRIVERS_TIMERBENCH is not set<br># CONFIG_XENO_DRIVERS_IRQBENCH is not set<br># CONFIG_XENO_DRIVERS_SWITCHTEST is not set<br><br>#<br># CAN drivers<br>
#<br># CONFIG_XENO_DRIVERS_CAN is not set<br><br>#<br># COMEDI drivers<br>#<br># CONFIG_XENO_DRIVERS_COMEDI is not set<br><br>#<br># System Type<br>#<br># CONFIG_ARCH_AAEC2000 is not set<br># CONFIG_ARCH_INTEGRATOR is not set<br>
# CONFIG_ARCH_REALVIEW is not set<br># CONFIG_ARCH_VERSATILE is not set<br># CONFIG_ARCH_AT91 is not set<br># CONFIG_ARCH_CLPS7500 is not set<br># CONFIG_ARCH_CLPS711X is not set<br># CONFIG_ARCH_CO285 is not set<br># CONFIG_ARCH_EBSA110 is not set<br>
# CONFIG_ARCH_EP93XX is not set<br># CONFIG_ARCH_FOOTBRIDGE is not set<br># CONFIG_ARCH_NETX is not set<br># CONFIG_ARCH_H720X is not set<br># CONFIG_ARCH_IMX is not set<br># CONFIG_ARCH_IOP13XX is not set<br># CONFIG_ARCH_IOP32X is not set<br>
# CONFIG_ARCH_IOP33X is not set<br># CONFIG_ARCH_IXP23XX is not set<br># CONFIG_ARCH_IXP2000 is not set<br># CONFIG_ARCH_IXP4XX is not set<br># CONFIG_ARCH_L7200 is not set<br># CONFIG_ARCH_KS8695 is not set<br># CONFIG_ARCH_NS9XXX is not set<br>
CONFIG_ARCH_MXC=y<br># CONFIG_ARCH_PNX4008 is not set<br># CONFIG_ARCH_PXA is not set<br># CONFIG_ARCH_RPC is not set<br># CONFIG_ARCH_SA1100 is not set<br># CONFIG_ARCH_S3C2410 is not set<br># CONFIG_ARCH_SHARK is not set<br>
# CONFIG_ARCH_LH7A40X is not set<br># CONFIG_ARCH_DAVINCI is not set<br># CONFIG_ARCH_OMAP is not set<br><br>#<br># Boot options<br>#<br><br>#<br># Power management<br>#<br><br>#<br># Freescale MXC Implementations<br>#<br>
# CONFIG_ARCH_MXC91321 is not set<br># CONFIG_ARCH_MX37 is not set<br># CONFIG_ARCH_MX35 is not set<br>CONFIG_ARCH_MX3=y<br># CONFIG_ARCH_MX27 is not set<br># CONFIG_ARCH_MX21 is not set<br>CONFIG_ARCH_MXC_HAS_NFC_V1=y<br>
CONFIG_I2C_MXC_SELECT1=y<br>CONFIG_I2C_MXC_SELECT2=y<br><br>#<br># MX3 Options<br>#<br>CONFIG_MACH_MX31LITE=y<br># CONFIG_MACH_MX31ADS is not set<br># CONFIG_MACH_MX31_3DS is not set<br>CONFIG_MX3_DOZE_DURING_IDLE=y<br>CONFIG_MXC_SDMA_API=y<br>
<br>#<br># SDMA options<br>#<br># CONFIG_SDMA_IRAM is not set<br>CONFIG_ARCH_MXC_HAS_NFC_V2=y<br><br>#<br># Device options<br>#<br># CONFIG_I2C_MXC_SELECT3 is not set<br>CONFIG_ARCH_HAS_EVTMON=y<br>CONFIG_DMA_ZONE_SIZE=24<br>
# CONFIG_ISP1504_MXC is not set<br><br>#<br># Processor Type<br>#<br>CONFIG_CPU_32=y<br># CONFIG_CPU_ARM926T is not set<br>CONFIG_CPU_V6=y<br># CONFIG_CPU_32v6K is not set<br>CONFIG_CPU_32v6=y<br>CONFIG_CPU_ABRT_EV6=y<br>
CONFIG_CPU_CACHE_V6=y<br>CONFIG_CPU_CACHE_VIPT=y<br>CONFIG_CPU_COPY_V6=y<br>CONFIG_CPU_TLB_V6=y<br>CONFIG_CPU_HAS_ASID=y<br>CONFIG_CPU_CP15=y<br>CONFIG_CPU_CP15_MMU=y<br><br>#<br># Processor Features<br>#<br>CONFIG_ARM_THUMB=y<br>
# CONFIG_CPU_ICACHE_DISABLE is not set<br># CONFIG_CPU_DCACHE_DISABLE is not set<br># CONFIG_CPU_BPREDICT_DISABLE is not set<br>CONFIG_OUTER_CACHE=y<br>CONFIG_CACHE_L2X0=y<br><br>#<br># Bus support<br>#<br>CONFIG_ISA=y<br>
# CONFIG_PCI_SYSCALL is not set<br># CONFIG_ARCH_SUPPORTS_MSI is not set<br>CONFIG_PCCARD=m<br># CONFIG_PCMCIA_DEBUG is not set<br>CONFIG_PCMCIA=m<br>CONFIG_PCMCIA_LOAD_CIS=y<br># CONFIG_PCMCIA_IOCTL is not set<br><br>#<br>
# PC-card bridges<br>#<br># CONFIG_I82365 is not set<br># CONFIG_TCIC is not set<br>CONFIG_PCMCIA_PROBE=y<br><br>#<br># Kernel Features<br>#<br># CONFIG_TICK_ONESHOT is not set<br># CONFIG_NO_HZ is not set<br># CONFIG_HIGH_RES_TIMERS is not set<br>
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y<br>CONFIG_IPIPE=y<br>CONFIG_IPIPE_DOMAINS=4<br>CONFIG_IPIPE_COMPAT=y<br># CONFIG_PREEMPT is not set<br>CONFIG_HZ=100<br>CONFIG_AEABI=y<br># CONFIG_OABI_COMPAT is not set<br># CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set<br>
CONFIG_SELECT_MEMORY_MODEL=y<br>CONFIG_FLATMEM_MANUAL=y<br># CONFIG_DISCONTIGMEM_MANUAL is not set<br># CONFIG_SPARSEMEM_MANUAL is not set<br>CONFIG_FLATMEM=y<br>CONFIG_FLAT_NODE_MEM_MAP=y<br># CONFIG_SPARSEMEM_STATIC is not set<br>
# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set<br>CONFIG_SPLIT_PTLOCK_CPUS=4<br># CONFIG_RESOURCES_64BIT is not set<br>CONFIG_ZONE_DMA_FLAG=1<br>CONFIG_BOUNCE=y<br>CONFIG_VIRT_TO_BUS=y<br># CONFIG_LEDS is not set<br>CONFIG_ALIGNMENT_TRAP=y<br>
<br>#<br># Boot options<br>#<br>CONFIG_ZBOOT_ROM_TEXT=0x0<br>CONFIG_ZBOOT_ROM_BSS=0x0<br>CONFIG_CMDLINE=&quot;noinitrd console=ttymxc0 root=/dev/mtdblock2 rw ip=off&quot;<br># CONFIG_XIP_KERNEL is not set<br># CONFIG_KEXEC is not set<br>
<br>#<br># Floating point emulation<br>#<br><br>#<br># At least one emulation must be selected<br>#<br># CONFIG_VFP is not set<br><br>#<br># Userspace binary formats<br>#<br>CONFIG_BINFMT_ELF=y<br># CONFIG_BINFMT_AOUT is not set<br>
# CONFIG_BINFMT_MISC is not set<br><br>#<br># Power management options<br>#<br>CONFIG_PM=y<br># CONFIG_PM_LEGACY is not set<br># CONFIG_PM_DEBUG is not set<br>CONFIG_PM_SLEEP=y<br>CONFIG_SUSPEND_UP_POSSIBLE=y<br>CONFIG_SUSPEND=y<br>
# CONFIG_APM_EMULATION is not set<br><br>#<br># Networking<br>#<br>CONFIG_NET=y<br><br>#<br># Networking options<br>#<br>CONFIG_PACKET=y<br>CONFIG_PACKET_MMAP=y<br>CONFIG_UNIX=y<br># CONFIG_NET_KEY is not set<br>CONFIG_INET=y<br>
CONFIG_IP_MULTICAST=y<br># CONFIG_IP_ADVANCED_ROUTER is not set<br>CONFIG_IP_FIB_HASH=y<br>CONFIG_IP_PNP=y<br>CONFIG_IP_PNP_DHCP=y<br>CONFIG_IP_PNP_BOOTP=y<br># CONFIG_IP_PNP_RARP is not set<br># CONFIG_NET_IPIP is not set<br>
# CONFIG_NET_IPGRE is not set<br># CONFIG_IP_MROUTE is not set<br># CONFIG_ARPD is not set<br># CONFIG_SYN_COOKIES is not set<br># CONFIG_INET_AH is not set<br># CONFIG_INET_ESP is not set<br># CONFIG_INET_IPCOMP is not set<br>
# CONFIG_INET_XFRM_TUNNEL is not set<br># CONFIG_INET_TUNNEL is not set<br># CONFIG_INET_XFRM_MODE_TRANSPORT is not set<br># CONFIG_INET_XFRM_MODE_TUNNEL is not set<br># CONFIG_INET_XFRM_MODE_BEET is not set<br># CONFIG_INET_LRO is not set<br>
CONFIG_INET_DIAG=y<br>CONFIG_INET_TCP_DIAG=y<br># CONFIG_TCP_CONG_ADVANCED is not set<br>CONFIG_TCP_CONG_CUBIC=y<br>CONFIG_DEFAULT_TCP_CONG=&quot;cubic&quot;<br># CONFIG_TCP_MD5SIG is not set<br># CONFIG_IPV6 is not set<br>
# CONFIG_INET6_XFRM_TUNNEL is not set<br># CONFIG_INET6_TUNNEL is not set<br># CONFIG_NETWORK_SECMARK is not set<br># CONFIG_NETFILTER is not set<br># CONFIG_IP_DCCP is not set<br># CONFIG_IP_SCTP is not set<br># CONFIG_TIPC is not set<br>
# CONFIG_ATM is not set<br># CONFIG_BRIDGE is not set<br># CONFIG_VLAN_8021Q is not set<br># CONFIG_DECNET is not set<br># CONFIG_LLC2 is not set<br># CONFIG_IPX is not set<br># CONFIG_ATALK is not set<br># CONFIG_X25 is not set<br>
# CONFIG_LAPB is not set<br># CONFIG_ECONET is not set<br># CONFIG_WAN_ROUTER is not set<br># CONFIG_NET_SCHED is not set<br><br>#<br># Network testing<br>#<br># CONFIG_NET_PKTGEN is not set<br># CONFIG_HAMRADIO is not set<br>
# CONFIG_IRDA is not set<br># CONFIG_BT is not set<br># CONFIG_AF_RXRPC is not set<br><br>#<br># Wireless<br>#<br># CONFIG_CFG80211 is not set<br>CONFIG_WIRELESS_EXT=y<br># CONFIG_MAC80211 is not set<br>CONFIG_IEEE80211=y<br>
# CONFIG_IEEE80211_DEBUG is not set<br># CONFIG_IEEE80211_CRYPT_WEP is not set<br># CONFIG_IEEE80211_CRYPT_CCMP is not set<br># CONFIG_IEEE80211_CRYPT_TKIP is not set<br># CONFIG_IEEE80211_SOFTMAC is not set<br># CONFIG_RFKILL is not set<br>
# CONFIG_NET_9P is not set<br><br>#<br># Device Drivers<br>#<br><br>#<br># Generic Driver Options<br>#<br>CONFIG_UEVENT_HELPER_PATH=&quot;/sbin/hotplug&quot;<br>CONFIG_STANDALONE=y<br>CONFIG_PREVENT_FIRMWARE_BUILD=y<br>CONFIG_FW_LOADER=m<br>
# CONFIG_DEBUG_DRIVER is not set<br># CONFIG_DEBUG_DEVRES is not set<br># CONFIG_SYS_HYPERVISOR is not set<br>CONFIG_CONNECTOR=y<br>CONFIG_PROC_EVENTS=y<br>CONFIG_MTD=y<br># CONFIG_MTD_DEBUG is not set<br># CONFIG_MTD_CONCAT is not set<br>
CONFIG_MTD_PARTITIONS=y<br>CONFIG_MTD_REDBOOT_PARTS=y<br>CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1<br># CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set<br># CONFIG_MTD_REDBOOT_PARTS_READONLY is not set<br>CONFIG_MTD_CMDLINE_PARTS=y<br>
# CONFIG_MTD_AFS_PARTS is not set<br><br>#<br># User Modules And Translation Layers<br>#<br>CONFIG_MTD_CHAR=y<br>CONFIG_MTD_BLKDEVS=y<br>CONFIG_MTD_BLOCK=y<br># CONFIG_FTL is not set<br># CONFIG_NFTL is not set<br># CONFIG_INFTL is not set<br>
# CONFIG_RFD_FTL is not set<br># CONFIG_SSFDC is not set<br># CONFIG_MTD_OOPS is not set<br><br>#<br># RAM/ROM/Flash chip drivers<br>#<br>CONFIG_MTD_CFI=y<br># CONFIG_MTD_JEDECPROBE is not set<br>CONFIG_MTD_GEN_PROBE=y<br>
CONFIG_MTD_CFI_ADV_OPTIONS=y<br>CONFIG_MTD_CFI_NOSWAP=y<br># CONFIG_MTD_CFI_BE_BYTE_SWAP is not set<br># CONFIG_MTD_CFI_LE_BYTE_SWAP is not set<br>CONFIG_MTD_CFI_GEOMETRY=y<br># CONFIG_MTD_MAP_BANK_WIDTH_1 is not set<br>CONFIG_MTD_MAP_BANK_WIDTH_2=y<br>
# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set<br># CONFIG_MTD_MAP_BANK_WIDTH_8 is not set<br># CONFIG_MTD_MAP_BANK_WIDTH_16 is not set<br># CONFIG_MTD_MAP_BANK_WIDTH_32 is not set<br>CONFIG_MTD_CFI_I1=y<br># CONFIG_MTD_CFI_I2 is not set<br>
# CONFIG_MTD_CFI_I4 is not set<br># CONFIG_MTD_CFI_I8 is not set<br># CONFIG_MTD_OTP is not set<br>CONFIG_MTD_CFI_INTELEXT=y<br># CONFIG_MTD_CFI_AMDSTD is not set<br>CONFIG_MTD_CFI_STAA=y<br>CONFIG_MTD_CFI_UTIL=y<br>CONFIG_MTD_RAM=y<br>
# CONFIG_MTD_ROM is not set<br># CONFIG_MTD_ABSENT is not set<br># CONFIG_MTD_XIP is not set<br><br>#<br># Mapping drivers for chip access<br>#<br># CONFIG_MTD_COMPLEX_MAPPINGS is not set<br># CONFIG_MTD_PHYSMAP is not set<br>
# CONFIG_MTD_ARM_INTEGRATOR is not set<br># CONFIG_MTD_PLATRAM is not set<br>CONFIG_MTD_MXC=y<br><br>#<br># Self-contained MTD device drivers<br>#<br># CONFIG_MTD_DATAFLASH is not set<br># CONFIG_MTD_M25P80 is not set<br>
# CONFIG_MTD_SLRAM is not set<br># CONFIG_MTD_PHRAM is not set<br># CONFIG_MTD_MTDRAM is not set<br># CONFIG_MTD_BLOCK2MTD is not set<br><br>#<br># Disk-On-Chip Device Drivers<br>#<br># CONFIG_MTD_DOC2000 is not set<br># CONFIG_MTD_DOC2001 is not set<br>
# CONFIG_MTD_DOC2001PLUS is not set<br>CONFIG_MTD_NAND=y<br># CONFIG_MTD_NAND_VERIFY_WRITE is not set<br># CONFIG_MTD_NAND_ECC_SMC is not set<br># CONFIG_MTD_NAND_MUSEUM_IDS is not set<br>CONFIG_MTD_NAND_IDS=y<br># CONFIG_MTD_NAND_DISKONCHIP is not set<br>
# CONFIG_MTD_NAND_NANDSIM is not set<br>CONFIG_MTD_NAND_MXC=y<br>CONFIG_MTD_NAND_MXC_V2=y<br># CONFIG_MTD_NAND_MXC_SWECC is not set<br># CONFIG_MTD_NAND_MXC_FORCE_CE is not set<br># CONFIG_MTD_NAND_MXC_ECC_CORRECTION_OPTION2 is not set<br>
# CONFIG_MXC_NAND_LOW_LEVEL_ERASE is not set<br># CONFIG_MTD_NAND_PLATFORM is not set<br># CONFIG_MTD_ALAUDA is not set<br># CONFIG_MTD_ONENAND is not set<br><br>#<br># UBI - Unsorted block images<br>#<br># CONFIG_MTD_UBI is not set<br>
<br>#<br># Voltage and Current regulators<br>#<br>CONFIG_REGULATOR_API=y<br>CONFIG_REGULATOR=y<br># CONFIG_REGULATOR_DEBUG is not set<br>CONFIG_REGULATOR_MC13783=y<br># CONFIG_PARPORT is not set<br># CONFIG_PNP is not set<br>
CONFIG_BLK_DEV=y<br># CONFIG_BLK_DEV_COW_COMMON is not set<br>CONFIG_BLK_DEV_LOOP=y<br># CONFIG_BLK_DEV_CRYPTOLOOP is not set<br># CONFIG_BLK_DEV_NBD is not set<br># CONFIG_BLK_DEV_UB is not set<br>CONFIG_BLK_DEV_RAM=y<br>
CONFIG_BLK_DEV_RAM_COUNT=16<br>CONFIG_BLK_DEV_RAM_SIZE=4096<br>CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024<br># CONFIG_CDROM_PKTCDVD is not set<br># CONFIG_ATA_OVER_ETH is not set<br>CONFIG_MISC_DEVICES=y<br># CONFIG_EEPROM_93CX6 is not set<br>
# CONFIG_IDE is not set<br><br>#<br># SCSI device support<br>#<br># CONFIG_RAID_ATTRS is not set<br>CONFIG_SCSI=y<br>CONFIG_SCSI_DMA=y<br># CONFIG_SCSI_TGT is not set<br># CONFIG_SCSI_NETLINK is not set<br>CONFIG_SCSI_PROC_FS=y<br>
<br>#<br># SCSI support type (disk, tape, CD-ROM)<br>#<br>CONFIG_BLK_DEV_SD=y<br># CONFIG_CHR_DEV_ST is not set<br># CONFIG_CHR_DEV_OSST is not set<br># CONFIG_BLK_DEV_SR is not set<br># CONFIG_CHR_DEV_SG is not set<br># CONFIG_CHR_DEV_SCH is not set<br>
<br>#<br># Some SCSI devices (e.g. CD jukebox) support multiple LUNs<br>#<br>CONFIG_SCSI_MULTI_LUN=y<br># CONFIG_SCSI_CONSTANTS is not set<br># CONFIG_SCSI_LOGGING is not set<br># CONFIG_SCSI_SCAN_ASYNC is not set<br>CONFIG_SCSI_WAIT_SCAN=m<br>
<br>#<br># SCSI Transports<br>#<br># CONFIG_SCSI_SPI_ATTRS is not set<br># CONFIG_SCSI_FC_ATTRS is not set<br># CONFIG_SCSI_ISCSI_ATTRS is not set<br># CONFIG_SCSI_SAS_LIBSAS is not set<br># CONFIG_SCSI_SRP_ATTRS is not set<br>
CONFIG_SCSI_LOWLEVEL=y<br># CONFIG_ISCSI_TCP is not set<br># CONFIG_SCSI_AHA152X is not set<br># CONFIG_SCSI_AIC7XXX_OLD is not set<br># CONFIG_SCSI_ADVANSYS is not set<br># CONFIG_SCSI_IN2000 is not set<br># CONFIG_SCSI_DTC3280 is not set<br>
# CONFIG_SCSI_FUTURE_DOMAIN is not set<br># CONFIG_SCSI_GENERIC_NCR5380 is not set<br># CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set<br># CONFIG_SCSI_NCR53C406A is not set<br># CONFIG_SCSI_PAS16 is not set<br># CONFIG_SCSI_PSI240I is not set<br>
# CONFIG_SCSI_QLOGIC_FAS is not set<br># CONFIG_SCSI_SYM53C416 is not set<br># CONFIG_SCSI_T128 is not set<br># CONFIG_SCSI_DEBUG is not set<br># CONFIG_SCSI_LOWLEVEL_PCMCIA is not set<br># CONFIG_ATA is not set<br># CONFIG_MD is not set<br>
CONFIG_NETDEVICES=y<br># CONFIG_NETDEVICES_MULTIQUEUE is not set<br># CONFIG_DUMMY is not set<br># CONFIG_BONDING is not set<br># CONFIG_MACVLAN is not set<br># CONFIG_EQUALIZER is not set<br># CONFIG_TUN is not set<br># CONFIG_VETH is not set<br>
# CONFIG_ARCNET is not set<br># CONFIG_PHYLIB is not set<br>CONFIG_NET_ETHERNET=y<br>CONFIG_MII=y<br># CONFIG_AX88796 is not set<br># CONFIG_NET_VENDOR_3COM is not set<br># CONFIG_NET_VENDOR_SMC is not set<br># CONFIG_SMC91X is not set<br>
# CONFIG_DM9000 is not set<br># CONFIG_SMC911X is not set<br>CONFIG_SMSC911X=y<br># CONFIG_NET_VENDOR_RACAL is not set<br># CONFIG_AT1700 is not set<br># CONFIG_DEPCA is not set<br># CONFIG_HP100 is not set<br># CONFIG_NET_ISA is not set<br>
# CONFIG_IBM_NEW_EMAC_ZMII is not set<br># CONFIG_IBM_NEW_EMAC_RGMII is not set<br># CONFIG_IBM_NEW_EMAC_TAH is not set<br># CONFIG_IBM_NEW_EMAC_EMAC4 is not set<br># CONFIG_NET_PCI is not set<br># CONFIG_B44 is not set<br>
# CONFIG_NETDEV_1000 is not set<br># CONFIG_NETDEV_10000 is not set<br># CONFIG_TR is not set<br><br>#<br># Wireless LAN<br>#<br># CONFIG_WLAN_PRE80211 is not set<br># CONFIG_WLAN_80211 is not set<br><br>#<br># USB Network Adapters<br>
#<br># CONFIG_USB_CATC is not set<br># CONFIG_USB_KAWETH is not set<br># CONFIG_USB_PEGASUS is not set<br># CONFIG_USB_RTL8150 is not set<br># CONFIG_USB_USBNET is not set<br># CONFIG_NET_PCMCIA is not set<br># CONFIG_WAN is not set<br>
CONFIG_PPP=m<br># CONFIG_PPP_MULTILINK is not set<br># CONFIG_PPP_FILTER is not set<br>CONFIG_PPP_ASYNC=m<br>CONFIG_PPP_SYNC_TTY=m<br>CONFIG_PPP_DEFLATE=m<br># CONFIG_PPP_BSDCOMP is not set<br># CONFIG_PPP_MPPE is not set<br>
# CONFIG_PPPOE is not set<br># CONFIG_PPPOL2TP is not set<br># CONFIG_SLIP is not set<br>CONFIG_SLHC=m<br># CONFIG_SHAPER is not set<br># CONFIG_NETCONSOLE is not set<br># CONFIG_NETPOLL is not set<br># CONFIG_NET_POLL_CONTROLLER is not set<br>
# CONFIG_ISDN is not set<br><br>#<br># Input device support<br>#<br>CONFIG_INPUT=y<br># CONFIG_INPUT_FF_MEMLESS is not set<br># CONFIG_INPUT_POLLDEV is not set<br><br>#<br># Userland interfaces<br>#<br># CONFIG_INPUT_MOUSEDEV is not set<br>
# CONFIG_INPUT_JOYDEV is not set<br>CONFIG_INPUT_EVDEV=y<br># CONFIG_INPUT_EVBUG is not set<br><br>#<br># Input Device Drivers<br>#<br>CONFIG_INPUT_KEYBOARD=y<br># CONFIG_KEYBOARD_ATKBD is not set<br># CONFIG_KEYBOARD_SUNKBD is not set<br>
# CONFIG_KEYBOARD_LKKBD is not set<br># CONFIG_KEYBOARD_XTKBD is not set<br># CONFIG_KEYBOARD_NEWTON is not set<br># CONFIG_KEYBOARD_STOWAWAY is not set<br>CONFIG_KEYBOARD_MXC=y<br># CONFIG_INPUT_MOUSE is not set<br># CONFIG_INPUT_JOYSTICK is not set<br>
# CONFIG_INPUT_TABLET is not set<br>CONFIG_INPUT_TOUCHSCREEN=y<br># CONFIG_TOUCHSCREEN_ADS7846 is not set<br># CONFIG_TOUCHSCREEN_FUJITSU is not set<br># CONFIG_TOUCHSCREEN_GUNZE is not set<br># CONFIG_TOUCHSCREEN_ELO is not set<br>
# CONFIG_TOUCHSCREEN_MTOUCH is not set<br># CONFIG_TOUCHSCREEN_MK712 is not set<br>CONFIG_TOUCHSCREEN_MXC=y<br># CONFIG_TOUCHSCREEN_PENMOUNT is not set<br># CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set<br># CONFIG_TOUCHSCREEN_TOUCHWIN is not set<br>
# CONFIG_TOUCHSCREEN_UCB1400 is not set<br># CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set<br># CONFIG_INPUT_MISC is not set<br><br>#<br># Hardware I/O ports<br>#<br># CONFIG_SERIO is not set<br># CONFIG_GAMEPORT is not set<br>
<br>#<br># Character devices<br>#<br>CONFIG_VT=y<br>CONFIG_VT_CONSOLE=y<br>CONFIG_HW_CONSOLE=y<br># CONFIG_VT_HW_CONSOLE_BINDING is not set<br># CONFIG_SERIAL_NONSTANDARD is not set<br><br>#<br># Serial drivers<br>#<br># CONFIG_SERIAL_8250 is not set<br>
<br>#<br># Non-8250 serial port support<br>#<br>CONFIG_SERIAL_MXC=y<br>CONFIG_SERIAL_MXC_CONSOLE=y<br>CONFIG_SERIAL_CORE=y<br>CONFIG_SERIAL_CORE_CONSOLE=y<br># CONFIG_UNIX98_PTYS is not set<br># CONFIG_LEGACY_PTYS is not set<br>
# CONFIG_IPMI_HANDLER is not set<br>CONFIG_HW_RANDOM=y<br># CONFIG_NVRAM is not set<br># CONFIG_DTLK is not set<br># CONFIG_R3964 is not set<br><br>#<br># PCMCIA character devices<br>#<br># CONFIG_SYNCLINK_CS is not set<br>
# CONFIG_CARDMAN_4000 is not set<br># CONFIG_CARDMAN_4040 is not set<br># CONFIG_RAW_DRIVER is not set<br># CONFIG_TCG_TPM is not set<br>CONFIG_DEVPORT=y<br>CONFIG_I2C=y<br>CONFIG_I2C_BOARDINFO=y<br>CONFIG_I2C_CHARDEV=y<br>
<br>#<br># I2C Algorithms<br>#<br># CONFIG_I2C_ALGOBIT is not set<br># CONFIG_I2C_ALGOPCF is not set<br># CONFIG_I2C_ALGOPCA is not set<br><br>#<br># I2C Hardware Bus support<br>#<br># CONFIG_I2C_ELEKTOR is not set<br>CONFIG_I2C_MXC=y<br>
# CONFIG_I2C_OCORES is not set<br># CONFIG_I2C_PARPORT_LIGHT is not set<br># CONFIG_I2C_SIMTEC is not set<br># CONFIG_I2C_TAOS_EVM is not set<br># CONFIG_I2C_STUB is not set<br># CONFIG_I2C_TINY_USB is not set<br># CONFIG_I2C_PCA_ISA is not set<br>
<br>#<br># Miscellaneous I2C Chip support<br>#<br># CONFIG_SENSORS_DS1337 is not set<br># CONFIG_SENSORS_DS1374 is not set<br># CONFIG_DS1682 is not set<br># CONFIG_SENSORS_EEPROM is not set<br># CONFIG_SENSORS_PCF8574 is not set<br>
# CONFIG_SENSORS_PCA9539 is not set<br># CONFIG_SENSORS_PCF8591 is not set<br># CONFIG_SENSORS_MAX6875 is not set<br># CONFIG_SENSORS_TSL2550 is not set<br># CONFIG_I2C_DEBUG_CORE is not set<br># CONFIG_I2C_DEBUG_ALGO is not set<br>
# CONFIG_I2C_DEBUG_BUS is not set<br># CONFIG_I2C_DEBUG_CHIP is not set<br><br>#<br># SPI support<br>#<br>CONFIG_SPI=y<br># CONFIG_SPI_DEBUG is not set<br>CONFIG_SPI_MASTER=y<br><br>#<br># SPI Master Controller Drivers<br>
#<br>CONFIG_SPI_BITBANG=y<br>CONFIG_SPI_MXC=y<br># CONFIG_SPI_MXC_TEST_LOOPBACK is not set<br># CONFIG_SPI_MXC_SELECT1 is not set<br>CONFIG_SPI_MXC_SELECT2=y<br>CONFIG_SPI_MXC_SELECT3=y<br><br>#<br># SPI Protocol Masters<br>
#<br># CONFIG_SPI_AT25 is not set<br># CONFIG_SPI_SPIDEV is not set<br># CONFIG_SPI_TLE62X0 is not set<br>CONFIG_W1=y<br>CONFIG_W1_CON=y<br><br>#<br># 1-wire Bus Masters<br>#<br># CONFIG_W1_MASTER_DS2490 is not set<br># CONFIG_W1_MASTER_DS2482 is not set<br>
CONFIG_W1_MASTER_MXC=y<br># CONFIG_W1_MASTER_DS1WM is not set<br><br>#<br># 1-wire Slaves<br>#<br># CONFIG_W1_SLAVE_THERM is not set<br># CONFIG_W1_SLAVE_SMEM is not set<br># CONFIG_W1_SLAVE_DS2751 is not set<br>CONFIG_W1_SLAVE_DS2433=y<br>
# CONFIG_W1_SLAVE_DS2433_CRC is not set<br># CONFIG_W1_SLAVE_DS2760 is not set<br># CONFIG_POWER_SUPPLY is not set<br># CONFIG_HWMON is not set<br># CONFIG_WATCHDOG is not set<br><br>#<br># Sonics Silicon Backplane<br>#<br>
CONFIG_SSB_POSSIBLE=y<br># CONFIG_SSB is not set<br><br>#<br># Multifunction device drivers<br>#<br># CONFIG_MFD_SM501 is not set<br><br>#<br># Multimedia devices<br>#<br>CONFIG_VIDEO_DEV=y<br>CONFIG_VIDEO_V4L1=y<br>CONFIG_VIDEO_V4L1_COMPAT=y<br>
CONFIG_VIDEO_V4L2=y<br># CONFIG_VIDEO_CAPTURE_DRIVERS is not set<br>CONFIG_RADIO_ADAPTERS=y<br># CONFIG_RADIO_CADET is not set<br># CONFIG_RADIO_RTRACK is not set<br># CONFIG_RADIO_RTRACK2 is not set<br># CONFIG_RADIO_AZTECH is not set<br>
# CONFIG_RADIO_GEMTEK is not set<br># CONFIG_RADIO_SF16FMI is not set<br># CONFIG_RADIO_SF16FMR2 is not set<br># CONFIG_RADIO_TERRATEC is not set<br># CONFIG_RADIO_TRUST is not set<br># CONFIG_RADIO_TYPHOON is not set<br>
# CONFIG_RADIO_ZOLTRIX is not set<br># CONFIG_USB_DSBR is not set<br># CONFIG_DVB_CORE is not set<br>CONFIG_DAB=y<br># CONFIG_USB_DABUSB is not set<br><br>#<br># Graphics support<br>#<br># CONFIG_VGASTATE is not set<br># CONFIG_VIDEO_OUTPUT_CONTROL is not set<br>
# CONFIG_FB is not set<br># CONFIG_BACKLIGHT_LCD_SUPPORT is not set<br><br>#<br># Display device support<br>#<br># CONFIG_DISPLAY_SUPPORT is not set<br><br>#<br># Console display driver support<br>#<br># CONFIG_VGA_CONSOLE is not set<br>
# CONFIG_MDA_CONSOLE is not set<br>CONFIG_DUMMY_CONSOLE=y<br><br>#<br># Sound<br>#<br>CONFIG_SOUND=y<br><br>#<br># Advanced Linux Sound Architecture<br>#<br>CONFIG_SND=y<br>CONFIG_SND_TIMER=y<br>CONFIG_SND_PCM=y<br># CONFIG_SND_SEQUENCER is not set<br>
CONFIG_SND_OSSEMUL=y<br>CONFIG_SND_MIXER_OSS=y<br>CONFIG_SND_PCM_OSS=y<br>CONFIG_SND_PCM_OSS_PLUGINS=y<br># CONFIG_SND_DYNAMIC_MINORS is not set<br>CONFIG_SND_SUPPORT_OLD_API=y<br>CONFIG_SND_VERBOSE_PROCFS=y<br># CONFIG_SND_VERBOSE_PRINTK is not set<br>
# CONFIG_SND_DEBUG is not set<br><br>#<br># Generic devices<br>#<br># CONFIG_SND_DUMMY is not set<br># CONFIG_SND_MTPAV is not set<br># CONFIG_SND_SERIAL_U16550 is not set<br># CONFIG_SND_MPU401 is not set<br><br>#<br># ALSA ARM devices<br>
#<br># CONFIG_SND_MXC_SPDIF is not set<br>CONFIG_SND_MXC_PMIC=y<br># CONFIG_SND_MXC_PLAYBACK_MIXING is not set<br># CONFIG_HEADSET_DETECT_ENABLE is not set<br><br>#<br># SPI devices<br>#<br><br>#<br># USB devices<br>#<br>
# CONFIG_SND_USB_AUDIO is not set<br># CONFIG_SND_USB_CAIAQ is not set<br><br>#<br># PCMCIA devices<br>#<br># CONFIG_SND_VXPOCKET is not set<br># CONFIG_SND_PDAUDIOCF is not set<br><br>#<br># System on Chip audio support<br>
#<br># CONFIG_SND_SOC is not set<br><br>#<br># SoC Audio support for SuperH<br>#<br># CONFIG_SND_MXC_SOC is not set<br># CONFIG_SND_MXC_SOC_IRAM is not set<br># CONFIG_SND_SOC_IMX_3STACK_WM8350 is not set<br><br>#<br># Open Sound System<br>
#<br># CONFIG_SOUND_PRIME is not set<br>CONFIG_HID_SUPPORT=y<br>CONFIG_HID=y<br># CONFIG_HID_DEBUG is not set<br># CONFIG_HIDRAW is not set<br><br>#<br># USB Input Devices<br>#<br>CONFIG_USB_HID=m<br># CONFIG_USB_HIDINPUT_POWERBOOK is not set<br>
# CONFIG_HID_FF is not set<br># CONFIG_USB_HIDDEV is not set<br><br>#<br># USB HID Boot Protocol drivers<br>#<br># CONFIG_USB_KBD is not set<br># CONFIG_USB_MOUSE is not set<br>CONFIG_USB_SUPPORT=y<br>CONFIG_USB_ARCH_HAS_HCD=y<br>
# CONFIG_USB_ARCH_HAS_OHCI is not set<br>CONFIG_USB_ARCH_HAS_EHCI=y<br>CONFIG_USB=m<br># CONFIG_USB_DEBUG is not set<br><br>#<br># Miscellaneous USB options<br>#<br># CONFIG_USB_DEVICEFS is not set<br># CONFIG_USB_DEVICE_CLASS is not set<br>
# CONFIG_USB_DYNAMIC_MINORS is not set<br>CONFIG_USB_SUSPEND=y<br># CONFIG_USB_PERSIST is not set<br>CONFIG_USB_OTG=y<br>CONFIG_USB_OTG_WHITELIST=y<br># CONFIG_USB_OTG_BLACKLIST_HUB is not set<br><br>#<br># USB Host Controller Drivers<br>
#<br># CONFIG_USB_EHCI_HCD is not set<br># CONFIG_USB_ISP116X_HCD is not set<br># CONFIG_USB_SL811_HCD is not set<br># CONFIG_USB_R8A66597_HCD is not set<br><br>#<br># USB Device Class drivers<br>#<br># CONFIG_USB_ACM is not set<br>
# CONFIG_USB_PRINTER is not set<br><br>#<br># NOTE: USB_STORAGE enables SCSI, and &#39;SCSI disk support&#39;<br>#<br><br>#<br># may also be needed; see USB_STORAGE Help for more information<br>#<br># CONFIG_USB_STORAGE is not set<br>
# CONFIG_USB_LIBUSUAL is not set<br><br>#<br># USB Imaging devices<br>#<br># CONFIG_USB_MDC800 is not set<br># CONFIG_USB_MICROTEK is not set<br>CONFIG_USB_MON=y<br><br>#<br># Belcarra USBLAN Networking for USB<br>#<br># CONFIG_USB_USBLAN is not set<br>
<br>#<br># USB port drivers<br>#<br><br>#<br># USB Serial Converter support<br>#<br># CONFIG_USB_SERIAL is not set<br><br>#<br># USB Miscellaneous drivers<br>#<br># CONFIG_USB_EMI62 is not set<br># CONFIG_USB_EMI26 is not set<br>
# CONFIG_USB_ADUTUX is not set<br># CONFIG_USB_AUERSWALD is not set<br># CONFIG_USB_RIO500 is not set<br># CONFIG_USB_LEGOTOWER is not set<br># CONFIG_USB_LCD is not set<br># CONFIG_USB_BERRY_CHARGE is not set<br># CONFIG_USB_LED is not set<br>
# CONFIG_USB_CYPRESS_CY7C63 is not set<br># CONFIG_USB_CYTHERM is not set<br># CONFIG_USB_PHIDGET is not set<br># CONFIG_USB_IDMOUSE is not set<br># CONFIG_USB_FTDI_ELAN is not set<br># CONFIG_USB_APPLEDISPLAY is not set<br>
# CONFIG_USB_LD is not set<br># CONFIG_USB_TRANCEVIBRATOR is not set<br># CONFIG_USB_IOWARRIOR is not set<br><br>#<br># USB DSL modem support<br>#<br><br>#<br># USB Gadget Support<br>#<br># CONFIG_USB_GADGET is not set<br>
<br>#<br># On-The-Go and USB Peripheral Support<br>#<br>CONFIG_OTG=m<br><br>#<br># <br>#<br><br>#<br># On-The-Go Support Platform Selection<br>#<br># CONFIG_OTG_IMX31ADS is not set<br><br>#<br># <br>#<br>CONFIG_MMC=y<br># CONFIG_MMC_DEBUG is not set<br>
# CONFIG_MMC_UNSAFE_RESUME is not set<br><br>#<br># MMC/SD Card Drivers<br>#<br>CONFIG_MMC_BLOCK=y<br>CONFIG_MMC_BLOCK_BOUNCE=y<br># CONFIG_SDIO_UART is not set<br><br>#<br># MMC/SD Host Controller Drivers<br>#<br># CONFIG_MMC_SPI is not set<br>
CONFIG_MMC_MXC=y<br>CONFIG_MMC_IMX_ESDHCI=y<br># CONFIG_NEW_LEDS is not set<br>CONFIG_RTC_LIB=y<br># CONFIG_RTC_CLASS is not set<br><br>#<br># MXC support drivers<br>#<br>CONFIG_MXC_IPU=y<br>CONFIG_MXC_IPU_V1=y<br>CONFIG_MXC_IPU_PF=y<br>
<br>#<br># MXC SSI support<br>#<br>CONFIG_MXC_SSI=y<br><br>#<br># MXC Digital Audio Multiplexer support<br>#<br>CONFIG_MXC_DAM=y<br><br>#<br># MXC PMIC support<br>#<br>CONFIG_MXC_SPI_PMIC_CORE=y<br># CONFIG_MXC_I2C_MCU_PMIC_CORE is not set<br>
CONFIG_MXC_PMIC=y<br>CONFIG_MXC_PMIC_CHARDEV=y<br><br>#<br># MXC PMIC Client Drivers<br>#<br>CONFIG_MXC_PMIC_MC13783=y<br>CONFIG_MXC_MC13783_ADC=y<br>CONFIG_MXC_MC13783_AUDIO=y<br>CONFIG_MXC_MC13783_RTC=y<br>CONFIG_MXC_MC13783_LIGHT=y<br>
CONFIG_MXC_MC13783_BATTERY=y<br>CONFIG_MXC_MC13783_CONNECTIVITY=y<br>CONFIG_MXC_MC13783_POWER=y<br><br>#<br># Advanced Power Management devices<br>#<br># CONFIG_MXC_DPTC is not set<br># CONFIG_MXC_DVFS is not set<br><br>#<br>
# MXC Security Drivers<br>#<br>CONFIG_MXC_SECURITY_SCC=y<br># CONFIG_SCC_DEBUG is not set<br>CONFIG_MXC_SECURITY_RNG=y<br># CONFIG_MXC_RNG_TEST_DRIVER is not set<br># CONFIG_MXC_RNG_DEBUG is not set<br>CONFIG_MXC_SECURITY_RTIC=y<br>
# CONFIG_MXC_RTIC_TEST_DEBUG is not set<br>CONFIG_MXC_SECURITY_CORE=y<br><br>#<br># MXC MPEG4 Encoder Kernel module support<br>#<br>CONFIG_MXC_HMP4E=y<br># CONFIG_MXC_HMP4E_DEBUG is not set<br><br>#<br># MXC HARDWARE EVENT<br>
#<br>CONFIG_MXC_HWEVENT=y<br><br>#<br># MXC VPU(Video Processing Unit) support<br>#<br>CONFIG_MXC_VPU=y<br># CONFIG_MXC_VPU_DEBUG is not set<br><br>#<br># File systems<br>#<br>CONFIG_EXT2_FS=y<br># CONFIG_EXT2_FS_XATTR is not set<br>
# CONFIG_EXT2_FS_XIP is not set<br># CONFIG_EXT3_FS is not set<br># CONFIG_EXT4DEV_FS is not set<br># CONFIG_REISERFS_FS is not set<br># CONFIG_JFS_FS is not set<br># CONFIG_FS_POSIX_ACL is not set<br># CONFIG_XFS_FS is not set<br>
# CONFIG_GFS2_FS is not set<br># CONFIG_OCFS2_FS is not set<br># CONFIG_MINIX_FS is not set<br># CONFIG_ROMFS_FS is not set<br>CONFIG_INOTIFY=y<br>CONFIG_INOTIFY_USER=y<br># CONFIG_QUOTA is not set<br>CONFIG_DNOTIFY=y<br>
# CONFIG_AUTOFS_FS is not set<br>CONFIG_AUTOFS4_FS=m<br># CONFIG_FUSE_FS is not set<br><br>#<br># CD-ROM/DVD Filesystems<br>#<br># CONFIG_ISO9660_FS is not set<br># CONFIG_UDF_FS is not set<br><br>#<br># DOS/FAT/NT Filesystems<br>
#<br>CONFIG_FAT_FS=y<br>CONFIG_MSDOS_FS=y<br>CONFIG_VFAT_FS=y<br>CONFIG_FAT_DEFAULT_CODEPAGE=437<br>CONFIG_FAT_DEFAULT_IOCHARSET=&quot;iso8859-1&quot;<br># CONFIG_NTFS_FS is not set<br><br>#<br># Pseudo filesystems<br>#<br>
CONFIG_PROC_FS=y<br>CONFIG_PROC_SYSCTL=y<br>CONFIG_SYSFS=y<br>CONFIG_TMPFS=y<br># CONFIG_TMPFS_POSIX_ACL is not set<br># CONFIG_HUGETLB_PAGE is not set<br># CONFIG_CONFIGFS_FS is not set<br><br>#<br># Miscellaneous filesystems<br>
#<br># CONFIG_ADFS_FS is not set<br># CONFIG_AFFS_FS is not set<br># CONFIG_HFS_FS is not set<br># CONFIG_HFSPLUS_FS is not set<br># CONFIG_BEFS_FS is not set<br># CONFIG_BFS_FS is not set<br># CONFIG_EFS_FS is not set<br>
CONFIG_JFFS2_FS=y<br>CONFIG_JFFS2_FS_DEBUG=0<br>CONFIG_JFFS2_FS_WRITEBUFFER=y<br># CONFIG_JFFS2_FS_WBUF_VERIFY is not set<br># CONFIG_JFFS2_SUMMARY is not set<br># CONFIG_JFFS2_FS_XATTR is not set<br># CONFIG_JFFS2_COMPRESSION_OPTIONS is not set<br>
CONFIG_JFFS2_ZLIB=y<br># CONFIG_JFFS2_LZO is not set<br>CONFIG_JFFS2_RTIME=y<br># CONFIG_JFFS2_RUBIN is not set<br>CONFIG_CRAMFS=y<br># CONFIG_VXFS_FS is not set<br># CONFIG_HPFS_FS is not set<br># CONFIG_QNX4FS_FS is not set<br>
# CONFIG_SYSV_FS is not set<br># CONFIG_UFS_FS is not set<br>CONFIG_NETWORK_FILESYSTEMS=y<br>CONFIG_NFS_FS=y<br>CONFIG_NFS_V3=y<br># CONFIG_NFS_V3_ACL is not set<br># CONFIG_NFS_V4 is not set<br># CONFIG_NFS_DIRECTIO is not set<br>
# CONFIG_NFSD is not set<br>CONFIG_ROOT_NFS=y<br>CONFIG_LOCKD=y<br>CONFIG_LOCKD_V4=y<br>CONFIG_NFS_COMMON=y<br>CONFIG_SUNRPC=y<br># CONFIG_SUNRPC_BIND34 is not set<br># CONFIG_RPCSEC_GSS_KRB5 is not set<br># CONFIG_RPCSEC_GSS_SPKM3 is not set<br>
# CONFIG_SMB_FS is not set<br># CONFIG_CIFS is not set<br># CONFIG_NCP_FS is not set<br># CONFIG_CODA_FS is not set<br># CONFIG_AFS_FS is not set<br><br>#<br># Partition Types<br>#<br># CONFIG_PARTITION_ADVANCED is not set<br>
CONFIG_MSDOS_PARTITION=y<br>CONFIG_NLS=y<br>CONFIG_NLS_DEFAULT=&quot;iso8859-1&quot;<br>CONFIG_NLS_CODEPAGE_437=y<br># CONFIG_NLS_CODEPAGE_737 is not set<br># CONFIG_NLS_CODEPAGE_775 is not set<br># CONFIG_NLS_CODEPAGE_850 is not set<br>
# CONFIG_NLS_CODEPAGE_852 is not set<br># CONFIG_NLS_CODEPAGE_855 is not set<br># CONFIG_NLS_CODEPAGE_857 is not set<br># CONFIG_NLS_CODEPAGE_860 is not set<br># CONFIG_NLS_CODEPAGE_861 is not set<br># CONFIG_NLS_CODEPAGE_862 is not set<br>
# CONFIG_NLS_CODEPAGE_863 is not set<br># CONFIG_NLS_CODEPAGE_864 is not set<br># CONFIG_NLS_CODEPAGE_865 is not set<br># CONFIG_NLS_CODEPAGE_866 is not set<br># CONFIG_NLS_CODEPAGE_869 is not set<br># CONFIG_NLS_CODEPAGE_936 is not set<br>
# CONFIG_NLS_CODEPAGE_950 is not set<br># CONFIG_NLS_CODEPAGE_932 is not set<br># CONFIG_NLS_CODEPAGE_949 is not set<br># CONFIG_NLS_CODEPAGE_874 is not set<br># CONFIG_NLS_ISO8859_8 is not set<br># CONFIG_NLS_CODEPAGE_1250 is not set<br>
# CONFIG_NLS_CODEPAGE_1251 is not set<br>CONFIG_NLS_ASCII=m<br>CONFIG_NLS_ISO8859_1=y<br># CONFIG_NLS_ISO8859_2 is not set<br># CONFIG_NLS_ISO8859_3 is not set<br># CONFIG_NLS_ISO8859_4 is not set<br># CONFIG_NLS_ISO8859_5 is not set<br>
# CONFIG_NLS_ISO8859_6 is not set<br># CONFIG_NLS_ISO8859_7 is not set<br># CONFIG_NLS_ISO8859_9 is not set<br># CONFIG_NLS_ISO8859_13 is not set<br># CONFIG_NLS_ISO8859_14 is not set<br># CONFIG_NLS_ISO8859_15 is not set<br>
# CONFIG_NLS_KOI8_R is not set<br># CONFIG_NLS_KOI8_U is not set<br>CONFIG_NLS_UTF8=m<br># CONFIG_DLM is not set<br>CONFIG_INSTRUMENTATION=y<br>CONFIG_PROFILING=y<br>CONFIG_OPROFILE=y<br>CONFIG_OPROFILE_ARMV6=y<br>CONFIG_OPROFILE_ARM11_CORE=y<br>
CONFIG_OPROFILE_ARM11_EVTMON=y<br># CONFIG_MARKERS is not set<br><br>#<br># Kernel hacking<br>#<br># CONFIG_PRINTK_TIME is not set<br>CONFIG_ENABLE_WARN_DEPRECATED=y<br>CONFIG_ENABLE_MUST_CHECK=y<br># CONFIG_MAGIC_SYSRQ is not set<br>
# CONFIG_UNUSED_SYMBOLS is not set<br># CONFIG_DEBUG_FS is not set<br># CONFIG_HEADERS_CHECK is not set<br># CONFIG_IPIPE_DEBUG is not set<br>CONFIG_DEBUG_KERNEL=y<br># CONFIG_DEBUG_SHIRQ is not set<br>CONFIG_DETECT_SOFTLOCKUP=y<br>
CONFIG_SCHED_DEBUG=y<br># CONFIG_SCHEDSTATS is not set<br># CONFIG_TIMER_STATS is not set<br># CONFIG_DEBUG_SLAB is not set<br># CONFIG_DEBUG_RT_MUTEXES is not set<br># CONFIG_RT_MUTEX_TESTER is not set<br># CONFIG_DEBUG_SPINLOCK is not set<br>
# CONFIG_DEBUG_MUTEXES is not set<br># CONFIG_DEBUG_LOCK_ALLOC is not set<br># CONFIG_PROVE_LOCKING is not set<br># CONFIG_LOCK_STAT is not set<br># CONFIG_DEBUG_SPINLOCK_SLEEP is not set<br># CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set<br>
# CONFIG_DEBUG_KOBJECT is not set<br>CONFIG_DEBUG_BUGVERBOSE=y<br># CONFIG_DEBUG_INFO is not set<br># CONFIG_DEBUG_VM is not set<br># CONFIG_DEBUG_LIST is not set<br># CONFIG_DEBUG_SG is not set<br>CONFIG_FRAME_POINTER=y<br>
CONFIG_FORCED_INLINING=y<br># CONFIG_BOOT_PRINTK_DELAY is not set<br># CONFIG_RCU_TORTURE_TEST is not set<br># CONFIG_FAULT_INJECTION is not set<br># CONFIG_SAMPLES is not set<br># CONFIG_DEBUG_USER is not set<br># CONFIG_DEBUG_ERRORS is not set<br>
# CONFIG_DEBUG_LL is not set<br><br>#<br># Security options<br>#<br># CONFIG_KEYS is not set<br># CONFIG_SECURITY is not set<br># CONFIG_SECURITY_FILE_CAPABILITIES is not set<br># CONFIG_CRYPTO is not set<br><br>#<br># Library routines<br>
#<br>CONFIG_BITREVERSE=y<br>CONFIG_CRC_CCITT=m<br># CONFIG_CRC16 is not set<br># CONFIG_CRC_ITU_T is not set<br>CONFIG_CRC32=y<br># CONFIG_CRC7 is not set<br># CONFIG_LIBCRC32C is not set<br>CONFIG_ZLIB_INFLATE=y<br>CONFIG_ZLIB_DEFLATE=y<br>
CONFIG_PLIST=y<br>CONFIG_HAS_IOMEM=y<br>CONFIG_HAS_IOPORT=y<br>CONFIG_HAS_DMA=y<br>&nbsp;<br></div></div><br>

------=_Part_91970_31288934.1226313505318--

