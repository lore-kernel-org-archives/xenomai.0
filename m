Message-ID: <47FA1515.2020702@domain.hid>
Date: Mon, 07 Apr 2008 14:35:33 +0200
From: Neil Armstrong <narmstrong@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3EE807098F0C68B42842BE7A"
Subject: [Xenomai-help] Xenomai 2.4.3 on Arm926 based SoC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3EE807098F0C68B42842BE7A
Content-Type: multipart/mixed;
 boundary="------------070307090800060707090101"

This is a multi-part message in MIME format.
--------------070307090800060707090101
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,
First of all, I'm quite new to linux real-time.
I'm trying to port the I-pipe patch for my company's arm926ejs based
Soc, i successfully run the 2.6.24 kernel with the I-pipe 1.9-01 patch
for arm.

While running the testsuite on the platform I have some negative values
(for latency for example), so I'm not sure of my patch.

I based my work on the integrator patch for a decrementer timer. The
timer available is a 16bit decrementer with a 256 ticks prescaler with
the ARM clock running at 144Mhz. (decrementer's initial value for 1ms is
5636 ticks).

I joined the full output and the board specific I-pipe functions.
Gilles Chanteperdrix told me it would be better to use an one-shot timer
instead of the autoreload feature, but the kernel stops right after
adeos takes control of the timer !

I read it could be useful to benchmark the Scheduling latency, but where
do I find the correct value ?

Thanks,
Neil Armstrong
--=20
Neil Armstrong
Neotion Sophia Antipolis
Stagiaire Mars-Septembre 2008 Polytech'Nice-Sophia
narmstrong@domain.hid (PGP:0x1166F485)

--------------070307090800060707090101
Content-Type: text/plain;
 name="linux-2.6.24-np5-ipipe.config"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="linux-2.6.24-np5-ipipe.config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.24-np5
# Mon Apr  7 11:10:39 2008
#
CONFIG_ARM=3Dy
CONFIG_SYS_SUPPORTS_APM_EMULATION=3Dy
# CONFIG_GENERIC_GPIO is not set
# CONFIG_GENERIC_TIME is not set
# CONFIG_GENERIC_CLOCKEVENTS is not set
CONFIG_MMU=3Dy
# CONFIG_NO_IOPORT is not set
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
CONFIG_HARDIRQS_SW_RESEND=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_ZONE_DMA=3Dy
CONFIG_VECTORS_BASE=3D0xffff0000
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_LOCK_KERNEL=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32
CONFIG_LOCALVERSION=3D""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SYSVIPC=3Dy
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
# CONFIG_AUDIT is not set
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=3D17
# CONFIG_CGROUPS is not set
CONFIG_FAIR_GROUP_SCHED=3Dy
CONFIG_FAIR_USER_SCHED=3Dy
# CONFIG_FAIR_CGROUP_SCHED is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_INITRAMFS_SOURCE=3D"initramfs.txt"
CONFIG_INITRAMFS_ROOT_UID=3D0
CONFIG_INITRAMFS_ROOT_GID=3D0
CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
CONFIG_EMBEDDED=3Dy
# CONFIG_UID16 is not set
# CONFIG_SYSCTL_SYSCALL is not set
# CONFIG_KALLSYMS is not set
# CONFIG_HOTPLUG is not set
CONFIG_PRINTK=3Dy
# CONFIG_BUG is not set
# CONFIG_ELF_CORE is not set
# CONFIG_BASE_FULL is not set
# CONFIG_FUTEX is not set
# CONFIG_EPOLL is not set
# CONFIG_SIGNALFD is not set
# CONFIG_EVENTFD is not set
# CONFIG_SHMEM is not set
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_SLAB=3Dy
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_SLABINFO=3Dy
CONFIG_TINY_SHMEM=3Dy
CONFIG_BASE_SMALL=3D1
# CONFIG_MODULES is not set
# CONFIG_BLOCK is not set

#
# Real-time sub-system
#
CONFIG_XENOMAI=3Dy
CONFIG_XENO_GENERIC_STACKPOOL=3Dy
CONFIG_XENO_OPT_NUCLEUS=3Dy
CONFIG_XENO_OPT_PERVASIVE=3Dy
# CONFIG_XENO_OPT_ISHIELD is not set
CONFIG_XENO_OPT_PRIOCPL=3Dy
CONFIG_XENO_OPT_PIPELINE_HEAD=3Dy
CONFIG_XENO_OPT_PIPE=3Dy
CONFIG_XENO_OPT_PIPE_NRDEV=3D32
CONFIG_XENO_OPT_REGISTRY=3Dy
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=3D512
CONFIG_XENO_OPT_SYS_HEAPSZ=3D128
CONFIG_XENO_OPT_SYS_STACKPOOLSZ=3D32
CONFIG_XENO_OPT_STATS=3Dy
# CONFIG_XENO_OPT_DEBUG is not set
# CONFIG_XENO_OPT_SHIRQ is not set

#
# Timing
#
# CONFIG_XENO_OPT_TIMING_PERIODIC is not set
CONFIG_XENO_OPT_TIMING_SCHEDLAT=3D0

#
# Scalability
#
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
CONFIG_XENO_OPT_TIMER_LIST=3Dy
# CONFIG_XENO_OPT_TIMER_HEAP is not set
# CONFIG_XENO_OPT_TIMER_WHEEL is not set

#
# Machine
#
# CONFIG_XENO_HW_FPU is not set

#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=3Dy
CONFIG_XENO_OPT_NATIVE_PERIOD=3D0
CONFIG_XENO_OPT_NATIVE_PIPE=3Dy
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=3D1024
CONFIG_XENO_OPT_NATIVE_REGISTRY=3Dy
CONFIG_XENO_OPT_NATIVE_SEM=3Dy
CONFIG_XENO_OPT_NATIVE_EVENT=3Dy
CONFIG_XENO_OPT_NATIVE_MUTEX=3Dy
CONFIG_XENO_OPT_NATIVE_COND=3Dy
CONFIG_XENO_OPT_NATIVE_QUEUE=3Dy
CONFIG_XENO_OPT_NATIVE_HEAP=3Dy
CONFIG_XENO_OPT_NATIVE_ALARM=3Dy
CONFIG_XENO_OPT_NATIVE_MPS=3Dy
# CONFIG_XENO_OPT_NATIVE_INTR is not set
CONFIG_XENO_SKIN_POSIX=3Dy
CONFIG_XENO_OPT_POSIX_PERIOD=3D0
# CONFIG_XENO_OPT_POSIX_SHM is not set
# CONFIG_XENO_OPT_POSIX_INTR is not set
# CONFIG_XENO_OPT_POSIX_SELECT is not set
CONFIG_XENO_OPT_DEBUG_POSIX=3Dy
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
# CONFIG_XENO_SKIN_RTAI is not set
CONFIG_XENO_SKIN_RTDM=3Dy
CONFIG_XENO_OPT_RTDM_PERIOD=3D0
CONFIG_XENO_OPT_RTDM_FILDES=3D128
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
CONFIG_XENO_DRIVERS_TIMERBENCH=3Dy
CONFIG_XENO_DRIVERS_KLATENCY=3Dy
CONFIG_XENO_DRIVERS_IRQBENCH=3Dy
CONFIG_XENO_DRIVERS_SWITCHTEST=3Dy

#
# CAN drivers
#
# CONFIG_XENO_DRIVERS_CAN is not set

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
# CONFIG_ARCH_MXC is not set
# CONFIG_ARCH_PNX4008 is not set
# CONFIG_ARCH_PXA is not set
# CONFIG_ARCH_RPC is not set
# CONFIG_ARCH_SA1100 is not set
# CONFIG_ARCH_S3C2410 is not set
# CONFIG_ARCH_SHARK is not set
# CONFIG_ARCH_LH7A40X is not set
# CONFIG_ARCH_DAVINCI is not set
# CONFIG_ARCH_OMAP is not set
CONFIG_ARCH_NP5=3Dy

#
# Boot options
#

#
# Power management
#

#
# Neotion NP4+/NP5 Boards
#
CONFIG_NP5_HZ=3D100
CONFIG_MACH_NP4PLUS=3Dy
# CONFIG_NP4_UART1 is not set
# CONFIG_NP5_CLOCK_108 is not set
CONFIG_NP5_CLOCK_144=3Dy
CONFIG_NP5_TIMER_AUTORELOAD=3Dy

#
# Processor Type
#
CONFIG_CPU_32=3Dy
CONFIG_CPU_ARM926T=3Dy
CONFIG_CPU_32v5=3Dy
CONFIG_CPU_ABRT_EV5TJ=3Dy
CONFIG_CPU_CACHE_VIVT=3Dy
CONFIG_CPU_COPY_V4WB=3Dy
CONFIG_CPU_TLB_V4WBI=3Dy
CONFIG_CPU_CP15=3Dy
CONFIG_CPU_CP15_MMU=3Dy

#
# Processor Features
#
# CONFIG_ARM_THUMB is not set
# CONFIG_CPU_ICACHE_DISABLE is not set
# CONFIG_CPU_DCACHE_DISABLE is not set
# CONFIG_CPU_DCACHE_WRITETHROUGH is not set
# CONFIG_CPU_CACHE_ROUND_ROBIN is not set
# CONFIG_OUTER_CACHE is not set

#
# Bus support
#
# CONFIG_PCI_SYSCALL is not set
# CONFIG_ARCH_SUPPORTS_MSI is not set

#
# Kernel Features
#
# CONFIG_TICK_ONESHOT is not set
CONFIG_IPIPE=3Dy
CONFIG_IPIPE_DOMAINS=3D4
CONFIG_IPIPE_COMPAT=3Dy
CONFIG_PREEMPT=3Dy
# CONFIG_NO_IDLE_HZ is not set
CONFIG_HZ=3D100
CONFIG_AEABI=3Dy
CONFIG_OABI_COMPAT=3Dy
# CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_FLATMEM_MANUAL=3Dy
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=3Dy
CONFIG_FLAT_NODE_MEM_MAP=3Dy
# CONFIG_SPARSEMEM_STATIC is not set
# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
CONFIG_SPLIT_PTLOCK_CPUS=3D4096
# CONFIG_RESOURCES_64BIT is not set
CONFIG_ZONE_DMA_FLAG=3D1
CONFIG_VIRT_TO_BUS=3Dy
CONFIG_ALIGNMENT_TRAP=3Dy

#
# Boot options
#
CONFIG_ZBOOT_ROM_TEXT=3D0x0
CONFIG_ZBOOT_ROM_BSS=3D0x0
CONFIG_CMDLINE=3D""
# CONFIG_XIP_KERNEL is not set
# CONFIG_KEXEC is not set

#
# Floating point emulation
#

#
# At least one emulation must be selected
#
# CONFIG_FPE_NWFPE is not set
# CONFIG_FPE_FASTFPE is not set
# CONFIG_VFP is not set

#
# Userspace binary formats
#
CONFIG_BINFMT_ELF=3Dy
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Power management options
#
# CONFIG_PM is not set
CONFIG_SUSPEND_UP_POSSIBLE=3Dy

#
# Networking
#
CONFIG_NET=3Dy

#
# Networking options
#
# CONFIG_NET_NS is not set
# CONFIG_PACKET is not set
CONFIG_UNIX=3Dy
# CONFIG_NET_KEY is not set
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=3Dy
# CONFIG_IP_PNP is not set
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
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=3Dy
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
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
# CONFIG_WIRELESS_EXT is not set
# CONFIG_MAC80211 is not set
# CONFIG_IEEE80211 is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
# CONFIG_PARPORT is not set
# CONFIG_MISC_DEVICES is not set

#
# SCSI device support
#
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
CONFIG_NETDEVICES=3Dy
# CONFIG_NETDEVICES_MULTIQUEUE is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
CONFIG_PHYLIB=3Dy

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
# CONFIG_FIXED_PHY is not set
# CONFIG_MDIO_BITBANG is not set
CONFIG_NET_ETHERNET=3Dy
# CONFIG_MII is not set
CONFIG_MACB=3Dy
# CONFIG_AX88796 is not set
# CONFIG_SMC91X is not set
# CONFIG_DM9000 is not set
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
# CONFIG_B44 is not set
# CONFIG_NETDEV_1000 is not set
# CONFIG_NETDEV_10000 is not set

#
# Wireless LAN
#
# CONFIG_WLAN_PRE80211 is not set
# CONFIG_WLAN_80211 is not set
# CONFIG_WAN is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=3Dy
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_SERIO_SERPORT=3Dy
# CONFIG_SERIO_LIBPS2 is not set
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
# CONFIG_VT is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_NP5=3Dy
CONFIG_SERIAL_NP5_CONSOLE=3Dy
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
# CONFIG_UNIX98_PTYS is not set
# CONFIG_LEGACY_PTYS is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_R3964 is not set
# CONFIG_TCG_TPM is not set
# CONFIG_I2C is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set
# CONFIG_WATCHDOG is not set

#
# Sonics Silicon Backplane
#
CONFIG_SSB_POSSIBLE=3Dy
# CONFIG_SSB is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_SM501 is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DVB_CORE is not set
# CONFIG_DAB is not set

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
# Sound
#
# CONFIG_SOUND is not set
# CONFIG_HID_SUPPORT is not set
# CONFIG_USB_SUPPORT is not set
# CONFIG_MMC is not set
# CONFIG_NEW_LEDS is not set
CONFIG_RTC_LIB=3Dy
# CONFIG_RTC_CLASS is not set

#
# File systems
#
# CONFIG_INOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_DNOTIFY is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
# CONFIG_PROC_SYSCTL is not set
# CONFIG_SYSFS is not set
# CONFIG_TMPFS is not set
# CONFIG_HUGETLB_PAGE is not set

#
# Miscellaneous filesystems
#
# CONFIG_NETWORK_FILESYSTEMS is not set
# CONFIG_NLS is not set
# CONFIG_INSTRUMENTATION is not set

#
# Kernel hacking
#
CONFIG_PRINTK_TIME=3Dy
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_HEADERS_CHECK is not set
# CONFIG_IPIPE_DEBUG is not set
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_SHIRQ is not set
# CONFIG_DETECT_SOFTLOCKUP is not set
# CONFIG_SCHED_DEBUG is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_TIMER_STATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=3Dy
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_FRAME_POINTER=3Dy
CONFIG_FORCED_INLINING=3Dy
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_SAMPLES is not set
# CONFIG_DEBUG_USER is not set
# CONFIG_DEBUG_ERRORS is not set
CONFIG_DEBUG_LL=3Dy
# CONFIG_DEBUG_ICEDCC is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY_FILE_CAPABILITIES is not set
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC_ITU_T is not set
# CONFIG_CRC32 is not set
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_HAS_IOMEM=3Dy
CONFIG_HAS_IOPORT=3Dy
CONFIG_HAS_DMA=3Dy

--------------070307090800060707090101
Content-Type: text/plain;
 name="linux-2.6.24-np5-ipipe-out.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="linux-2.6.24-np5-ipipe-out.txt"

[    0.000000] Linux version 2.6.24-np5 (narmstrong@domain.hid) (gcc version 4.=
2.1 (CodeSourcery Sourcery G++ Lite 2007q3-53)) #31 PREEMPT Mon Apr 7 11:=
10:56 CEST 2008
[    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D000=
53177
[    0.000000] Machine: Neotion NP4+/NP5
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 4096
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] np5: IO Mapping Init.
[    0.000000] CPU0: D VIVT write-back cache
[    0.000000] CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines=
, 128 sets
[    0.000000] CPU0: D cache: 16384 bytes, associativity 4, 32 byte lines=
, 128 sets
[    0.000000] Built 1 zonelists in Zone order, mobility grouping off.  T=
otal pages: 4064
[    0.000000] Kernel command line: init=3D/bin/init user_debug=3D31 debu=
g
[    0.000000] np5: IRQ Init: 32
[    0.000000] PID hash table entries: 64 (order: 6, 256 bytes)
[    0.000000] np5: Timer 0 Init. : Freq 144000000 Prescaler 256 Period 5=
626 HZ 100
[    0.000000] I-pipe 1.9-01: pipeline enabled.
[    0.000000] Dentry cache hash table entries: 2048 (order: 1, 8192 byte=
s)
[    0.000000] Inode-cache hash table entries: 1024 (order: 0, 4096 bytes=
)
[    0.010000] Memory: 16MB =3D 16MB total
[    0.010000] Memory: 12944KB available (1304K code, 412K data, 1540K in=
it)
[    0.020000] Calibrating delay loop... 71.68 BogoMIPS (lpj=3D358400)
[    0.210000] Mount-cache hash table entries: 512
[    0.210000] CPU: Testing write buffer coherency: ok
[    0.220000] net_namespace: 64 bytes
[    0.220000] NET: Registered protocol family 16
[    0.220000] np5: Neotion NP4+/NP5 (ASIC) Major 01 Minor 08
[    0.230000] np5: NP5 Devices Init.
[    0.230000] np5: Serial UART Init.
[    0.230000] np5: MACB Ethernet Controller Prototype MAC 00080600000118=

[    0.270000] NET: Registered protocol family 2
[    0.360000] IP route cache hash table entries: 1024 (order: 0, 4096 by=
tes)
[    0.360000] TCP established hash table entries: 512 (order: 0, 4096 by=
tes)
[    0.370000] TCP bind hash table entries: 512 (order: -1, 2048 bytes)
[    0.370000] TCP: Hash tables configured (established 512 bind 512)
[    0.380000] TCP reno registered
[    1.930000] I-pipe: Domain Xenomai registered.
[    1.930000] Xenomai: hal/arm started.
[    1.930000] Xenomai: real-time nucleus v2.4.3 (Back to Shalla-Bal) loa=
ded.
[    1.940000] Xenomai: starting native API services.
[    1.940000] Xenomai: starting POSIX services.
[    1.940000] Xenomai: starting RTDM services.
[    1.940000] np5_serial: Registered serial driver
[    1.940000] np5_serial.0: Port Request
[    1.940000] np5_serial.0: ttyS0 at MMIO 0xe0020000 (irq =3D 3) is a np=
5_serial
[    1.940000] console [ttyS0] enabled
[    1.940000] np5_serial: Registered serial line 0
[    1.940000] MACB_mii_bus: probed
[    1.940000] eth0: Atmel MACB at 0xe0050000 irq 8 (00:06:08:00:18:01)
[    1.940000] eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=3D=
ffffffff:1f, irq=3D-1)
[    1.940000] TCP cubic registered
[    1.940000] NET: Registered protocol family 1
[    1.940000] Freeing init memory: 1540K
[    1.940000] np5_serial.0: Port Startup : OK
init started: BusyBox v1.10.0 (2008-04-04 10:53:54 CEST)
command=3D'/etc/rc' action=3D1 tty=3D''

command=3D'/bin/sh' action=3D2 tty=3D'/dev/ttyS0'

 Welcome to
    _      _   ________
   / \    | | |  _____ \   _      _
   |  \   | | | |  _  \ | | |    | |        _
   |   \  | | | |  ___/ | | \    | |       | |
   | |\ \ | | | | |____/   \ \___| |_   ___| |___
   | | \ \| | | |           \____   _| |___   ___|
   |_|  \___/ |_|                | |       | |
   Neotion | Innovation Attitude |_|       |_|

# <6>eth0: link up (100/Full)
[    3.940000] eth0: link up (100/Full)

# cat /proc/cpuinfo
Processor       : ARM926EJ-S rev 5 (v5l)
BogoMIPS        : 71.68
Features        : swp half fastmult edsp java=20
CPU implementer : 0x41
CPU architecture: 5TEJ
CPU variant     : 0x0
CPU part        : 0x926
CPU revision    : 5
Cache type      : write-back
Cache clean     : cp15 c7 ops
Cache lockdown  : format C
Cache format    : Harvard
I size          : 16384
I assoc         : 4
I line length   : 32
I sets          : 128
D size          : 16384
D assoc         : 4
D line length   : 32
D sets          : 128

Hardware        : Neotion NP4+/NP5
Revision        : 0000
Serial          : 0000000000000000
# for f in /proc/ipipe/*; do cat $f; done
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
  32:  G...V
  33:  G...V
  35:  G...V
[Domain info]
id=3D0x00000000
priority=3D100
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
   0:  W..X.
  34:  W...V
[Domain info]
id=3D0x58454e4f
priority=3Dtopmost
1.9-01
# for f in /proc/xenomai/*;   do [ -f $f ] && cat $f; done
00000001
APC          CPU0
  0:            0    (pipe_wakeup)
  1:            0    (lostage_handler)
  2:            1    (registry_export)
  3:            0    (pse51_lostage_handler)
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
1.9-01
size=3D129536:used=3D80:pagesz=3D512  (main heap)
size=3D32256:used=3D4096:pagesz=3D512  (stack pool)
IRQ         CPU0
  0:     4924528         [timer]
 34:           1         [virtual]
10664
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT
  0  0        0      0          0          master    W          klat_srvr=

CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          104        0     00400080   25.3  ROOT
  0  0      0          104        0     00000082    0.0  klat_srvr
  0  0      0          4925285    0     00000000   74.7  IRQ0: [timer]
NAME       RESOLUTION     JIFFIES   STATUS
master              1         n/a   enabled,set
status=3Don:setup=3D1777:clock=3D58670568:timerdev=3DTIMER0:clockdev=3DTI=
MER
2.4.3
# for f in /proc/xenomai/*/*; do [ -f $f ] && cat $f; done
0
0
0
0
total=3D128:open=3D1:free=3D127
Hash    Name                            Driver          /proc
D6      rttest0                         xeno_timerbench rttest0
D7      rttest1                         xeno_irqbench   rttest1
D8      rttest2                         xeno_switchtest rttest2
Index   Locked  Device          Owner [PID]
0       1       rttest0         <kernel> [-1]
Hash    ProtocolFamily:SocketType       Driver          /proc
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME     =
     =20
0    10497       10496       376821     10000000   NULL         [host-tim=
er]  =20
0    1049655     1049654     74653      -          timer_proc   rttest0  =
     =20
# latency -sh -T 120 -t0
=3D=3D Sampling period: 100 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|      -8.888|      26.661|      56.878|       0|      -8.888|      56=
=2E878
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      58=
=2E656
RTD|     -10.665|      26.661|      60.433|       0|     -10.665|      60=
=2E433
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      60=
=2E433
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      60=
=2E433
RTD|     -10.665|      26.661|      60.433|       0|     -10.665|      60=
=2E433
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      60=
=2E433
RTD|      -3.555|      26.661|      58.656|       0|     -10.665|      60=
=2E433
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      60=
=2E433
RTD|      -8.888|      26.661|      58.656|       0|     -10.665|      60=
=2E433
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      60=
=2E433
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      60=
=2E433
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      60=
=2E433
RTD|      -8.888|      26.661|      58.656|       0|     -10.665|      60=
=2E433
RTD|      -8.888|      26.661|      58.656|       0|     -10.665|      60=
=2E433
RTD|     -10.665|      26.661|      60.433|       0|     -10.665|      60=
=2E433
RTD|      -8.888|      26.661|      58.656|       0|     -10.665|      60=
=2E433
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      60=
=2E433
RTD|     -10.665|      26.661|      60.433|       0|     -10.665|      60=
=2E433
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      60=
=2E433
RTD|      -8.888|      26.661|      58.656|       0|     -10.665|      60=
=2E433
RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      60=
=2E433
RTD|     -10.665|      26.661|      74.653|       0|     -10.665|      74=
=2E653
RTD|     -10.665|      26.661|      62.211|       0|     -10.665|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|     -10.665|      26.661|      60.433|       0|     -10.665|      74=
=2E653
RTD|     -10.665|      26.661|      60.433|       0|     -10.665|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTT|  00:00:43  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|      -8.888|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -10.665|      74=
=2E653
RTD|     -12.443|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      62.211|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      62.211|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      60.433|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      60.433|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTT|  00:01:04  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|      -8.888|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|      -8.888|      26.661|      62.211|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      65.766|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      60.433|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTT|  00:01:25  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|      -8.888|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      60.433|       0|     -12.443|      74=
=2E653
RTD|     -10.665|      26.661|      58.656|       0|     -12.443|      74=
=2E653
RTD|    -108.426|     -71.099|     -40.882|       0|    -108.426|      74=
=2E653
RTD|    -108.426|     -71.099|     -39.105|       0|    -108.426|      74=
=2E653
RTD|    -108.426|     -71.099|     -40.882|       0|    -108.426|      74=
=2E653
RTD|    -110.203|     -71.099|     -40.882|       0|    -110.203|      74=
=2E653
RTD|    -110.203|     -71.099|     -40.882|       0|    -110.203|      74=
=2E653
RTD|    -108.426|     -71.099|     -40.882|       0|    -110.203|      74=
=2E653
RTD|    -110.203|     -71.099|     -33.772|       0|    -110.203|      74=
=2E653
RTD|    -108.426|     -71.099|     -40.882|       0|    -110.203|      74=
=2E653
RTD|    -108.426|     -71.099|     -39.105|       0|    -110.203|      74=
=2E653
RTD|    -110.203|     -71.099|     -40.882|       0|    -110.203|      74=
=2E653
RTD|    -108.426|     -71.099|     -33.772|       0|    -110.203|      74=
=2E653
RTD|    -110.203|     -71.099|     -40.882|       0|    -110.203|      74=
=2E653
RTD|    -108.426|     -71.099|     -39.105|       0|    -110.203|      74=
=2E653
RTD|    -110.203|     -71.099|     -40.882|       0|    -110.203|      74=
=2E653
RTT|  00:01:45  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|    -110.203|     -71.099|     -40.882|       0|    -110.203|      74=
=2E653
RTD|    -110.203|     -71.099|     -35.550|       0|    -110.203|      74=
=2E653
RTD|    -110.203|     -71.099|     -40.882|       0|    -110.203|      74=
=2E653
RTD|    -110.203|     -71.099|     -39.105|       0|    -110.203|      74=
=2E653
RTD|    -108.426|     -71.099|     -40.882|       0|    -110.203|      74=
=2E653
RTD|    -110.203|     -71.099|     -40.882|       0|    -110.203|      74=
=2E653
RTD|    -110.203|     -71.099|     -40.882|       0|    -110.203|      74=
=2E653
RTD|    -108.426|     -71.099|     -40.882|       0|    -110.203|      74=
=2E653
RTD|    -110.203|     -71.099|     -40.882|       0|    -110.203|      74=
=2E653
RTD|    -110.203|     -71.099|     -39.105|       0|    -110.203|      74=
=2E653
RTD|    -110.203|     -71.099|     -40.882|       0|    -110.203|      74=
=2E653
RTD|    -110.203|     -71.099|     -40.882|       0|    -110.203|      74=
=2E653
RTD|    -110.203|     -71.099|     -39.105|       0|    -110.203|      74=
=2E653
RTD|    -110.203|     -71.099|     -40.882|       0|    -110.203|      74=
=2E653
RTD|    -108.426|     -71.099|     -40.882|       0|    -110.203|      74=
=2E653
---|--param|----range-|--samples
HSD|    min|   3 -  4 |        1
HSD|    min|   8 -  9 |       29
HSD|    min|  10 - 11 |       60
HSD|    min|  12 - 13 |        1
HSD|    min|  99 -100 |       29
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |     1143
HSD|    avg|   1 -  2 |     1810
HSD|    avg|   3 -  4 |     2205
HSD|    avg|   5 -  6 |     8926
HSD|    avg|   7 -  8 |    10611
HSD|    avg|   8 -  9 |     5872
HSD|    avg|  10 - 11 |     5351
HSD|    avg|  12 - 13 |    11235
HSD|    avg|  14 - 15 |     8827
HSD|    avg|  15 - 16 |    10314
HSD|    avg|  17 - 18 |    40962
HSD|    avg|  19 - 20 |    75296
HSD|    avg|  21 - 22 |   137864
HSD|    avg|  23 - 24 |    46343
HSD|    avg|  24 - 25 |    28760
HSD|    avg|  26 - 27 |    41005
HSD|    avg|  28 - 29 |   117321
HSD|    avg|  30 - 31 |   131224
HSD|    avg|  31 - 32 |    45805
HSD|    avg|  33 - 34 |    19978
HSD|    avg|  35 - 36 |    17632
HSD|    avg|  37 - 38 |    19682
HSD|    avg|  39 - 40 |    18149
HSD|    avg|  40 - 41 |    13098
HSD|    avg|  42 - 43 |    18559
HSD|    avg|  44 - 45 |    13933
HSD|    avg|  46 - 47 |    22148
HSD|    avg|  47 - 48 |    21927
HSD|    avg|  49 - 50 |    13242
HSD|    avg|  51 - 52 |    10037
HSD|    avg|  53 - 54 |     7620
HSD|    avg|  55 - 56 |     5182
HSD|    avg|  56 - 57 |     6542
HSD|    avg|  58 - 59 |     4856
HSD|    avg|  60 - 61 |     5823
HSD|    avg|  62 - 63 |     6509
HSD|    avg|  63 - 64 |     5500
HSD|    avg|  65 - 66 |     6837
HSD|    avg|  67 - 68 |    16764
HSD|    avg|  69 - 70 |    42230
HSD|    avg|  71 - 72 |    35997
HSD|    avg|  72 - 73 |    13227
HSD|    avg|  74 - 75 |     9262
HSD|    avg|  76 - 77 |    15794
HSD|    avg|  78 - 79 |    45447
HSD|    avg|  79 - 80 |    23787
HSD|    avg|  81 - 82 |    13220
HSD|    avg|  83 - 84 |     3372
HSD|    avg|  85 - 86 |     2804
HSD|    avg|  87 - 88 |     3596
HSD|    avg|  88 - 89 |     1663
HSD|    avg|  90 - 91 |     1809
HSD|    avg|  92 - 93 |     3480
HSD|    avg|  94 - 95 |     2967
HSD|    avg|  95 - 96 |      686
HSD|    avg|  97 - 98 |      396
HSD|    avg|  99 -100 |      804
---|--param|----range-|--samples
HSD|    max|  33 - 34 |        2
HSD|    max|  35 - 36 |        1
HSD|    max|  39 - 40 |        6
HSD|    max|  40 - 41 |       20
HSD|    max|  56 - 57 |        1
HSD|    max|  58 - 59 |       74
HSD|    max|  60 - 61 |       10
HSD|    max|  62 - 63 |        4
HSD|    max|  65 - 66 |        1
HSD|    max|  74 - 75 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|       120|     30.983|     38.571
HSS|    avg|   1205433|     37.907|     21.399
HSS|    max|       120|     53.917|      8.618
---|------------|------------|------------|--------|---------------------=
----
RTS|    -110.203|       1.777|      74.653|       0|    00:02:00/00:02:00=

# latency -sh -T 120 -t1
=3D=3D Sampling period: 100 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|      -4.586|      14.141|      17.739|       0|      -4.586|      17=
=2E739
RTD|     -23.320|      14.160|      67.793|       0|     -23.320|      67=
=2E793
RTD|     -24.173|      14.144|      23.285|       0|     -24.173|      67=
=2E793
RTD|      -7.608|      14.162|      38.749|       0|     -24.173|      67=
=2E793
RTD|     -27.729|      14.157|      36.509|       0|     -27.729|      67=
=2E793
RTD|      -3.982|      14.182|      36.829|       0|     -27.729|      67=
=2E793
RTD|      -1.494|      14.117|      17.739|       0|     -27.729|      67=
=2E793
RTD|     -22.397|      14.143|      17.739|       0|     -27.729|      67=
=2E793
RTD|     -24.245|      14.163|      67.330|       0|     -27.729|      67=
=2E793
RTD|     -24.636|      14.167|      66.476|       0|     -27.729|      67=
=2E793
RTD|     -24.245|      14.152|      67.329|       0|     -27.729|      67=
=2E793
RTD|      -4.587|      14.124|      36.437|       0|     -27.729|      67=
=2E793
RTD|      -5.760|      14.151|      19.124|       0|     -27.729|      67=
=2E793
RTD|      -0.001|      14.127|      17.951|       0|     -27.729|      67=
=2E793
RTD|     -25.952|      14.123|      36.899|       0|     -27.729|      67=
=2E793
RTD|     -23.784|      14.178|      67.791|       0|     -27.729|      67=
=2E793
RTD|     -27.339|      14.161|      67.329|       0|     -27.729|      67=
=2E793
RTD|      -6.365|      14.107|      34.197|       0|     -27.729|      67=
=2E793
RTD|       0.105|      14.173|      38.214|       0|     -27.729|      67=
=2E793
RTD|     -24.175|      14.170|      37.289|       0|     -27.729|      67=
=2E793
RTD|     -23.784|      14.160|      67.790|       0|     -27.729|      67=
=2E793
RTT|  00:00:22  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|     -22.398|      14.158|      36.436|       0|     -27.729|      67=
=2E793
RTD|      -5.832|      14.117|      35.867|       0|     -27.729|      67=
=2E793
RTD|     -25.562|      14.142|      67.790|       0|     -27.729|      67=
=2E793
RTD|     -26.416|      14.189|      66.475|       0|     -27.729|      67=
=2E793
RTD|     -26.416|      14.142|      64.697|       0|     -27.729|      67=
=2E793
RTD|      -3.273|      14.121|      34.658|       0|     -27.729|      67=
=2E793
RTD|      -4.838|      14.165|      18.518|       0|     -27.729|      67=
=2E793
RTD|      -7.397|      14.130|      17.736|       0|     -27.729|      67=
=2E793
RTD|     -25.101|      14.165|      67.789|       0|     -27.729|      67=
=2E793
RTD|      -5.762|      14.150|      37.288|       0|     -27.729|      67=
=2E793
RTD|     -22.399|      14.106|      37.039|       0|     -27.729|      67=
=2E793
RTD|     -31.820|      14.205|      66.865|       0|     -31.820|      67=
=2E793
RTD|     -26.879|      14.136|      64.234|       0|     -31.820|      67=
=2E793
RTD|     -28.194|      14.147|      62.918|       0|     -31.820|      67=
=2E793
RTD|     -28.656|      14.152|      64.234|       0|     -31.820|      67=
=2E793
RTD|      -8.607|      14.151|      36.825|       0|     -31.820|      67=
=2E793
RTD|     -27.732|      14.111|      38.745|       0|     -31.820|      67=
=2E793
RTD|      -3.275|      14.134|      17.735|       0|     -31.820|      67=
=2E793
RTD|     -22.400|      14.138|      37.429|       0|     -31.820|      67=
=2E793
RTD|     -24.640|      14.142|      59.363|       0|     -31.820|      67=
=2E793
RTD|     -22.863|      14.099|      59.363|       0|     -31.820|      67=
=2E793
RTT|  00:00:43  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|      -4.591|      14.119|      36.042|       0|     -31.820|      67=
=2E793
RTD|     -25.103|      14.121|      67.788|       0|     -31.820|      67=
=2E793
RTD|     -22.401|      14.185|      36.575|       0|     -31.820|      67=
=2E793
RTD|     -26.880|      14.141|      66.010|       0|     -31.820|      67=
=2E793
RTD|     -28.658|      14.123|      64.232|       0|     -31.820|      67=
=2E793
RTD|     -24.179|      14.123|      35.971|       0|     -31.820|      67=
=2E793
RTD|      -5.160|      14.133|      19.120|       0|     -31.820|      67=
=2E793
RTD|      -5.160|      14.145|      44.147|       0|     -31.820|      67=
=2E793
RTD|     -24.179|      14.151|      17.733|       0|     -31.820|      67=
=2E793
RTD|     -26.881|      14.161|      64.232|       0|     -31.820|      67=
=2E793
RTD|     -24.250|      14.134|      67.324|       0|     -31.820|      67=
=2E793
RTD|     -23.788|      14.152|      67.324|       0|     -31.820|      67=
=2E793
RTD|     -26.419|      14.116|      66.471|       0|     -31.820|      67=
=2E793
RTD|     -24.642|      14.173|      59.361|       0|     -31.820|      67=
=2E793
RTD|     -26.419|      14.123|      66.471|       0|     -31.820|      67=
=2E793
RTD|     -24.251|      14.111|      67.324|       0|     -31.820|      67=
=2E793
RTD|     -27.344|      14.132|      67.324|       0|     -31.820|      67=
=2E793
RTD|     -22.403|      14.129|      36.431|       0|     -31.820|      67=
=2E793
RTD|     -23.327|      14.151|      67.786|       0|     -31.820|      67=
=2E793
RTD|     -24.180|      14.155|      35.969|       0|     -31.820|      67=
=2E793
RTD|      -3.278|      14.093|      19.367|       0|     -31.820|      67=
=2E793
RTT|  00:01:04  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|     -24.252|      14.156|      67.323|       0|     -31.820|      67=
=2E793
RTD|     -26.420|      14.140|      66.470|       0|     -31.820|      67=
=2E793
RTD|     -24.643|      14.141|      59.360|       0|     -31.820|      67=
=2E793
RTD|     -24.181|      14.153|      36.893|       0|     -31.820|      67=
=2E793
RTD|     -26.421|      14.116|      64.692|       0|     -31.820|      67=
=2E793
RTD|     -22.404|      14.140|      19.047|       0|     -31.820|      67=
=2E793
RTD|      -8.717|      14.143|      36.039|       0|     -31.820|      67=
=2E793
RTD|      -5.163|      14.096|      37.816|       0|     -31.820|      67=
=2E793
RTD|     -25.106|      14.093|      67.784|       0|     -31.820|      67=
=2E793
RTD|     -28.661|      14.135|      64.229|       0|     -31.820|      67=
=2E793
RTD|     -24.253|      14.172|      67.322|       0|     -31.820|      67=
=2E793
RTD|      -2.070|      14.126|      37.887|       0|     -31.820|      67=
=2E793
RTD|     -22.405|      14.141|      37.034|       0|     -31.820|      67=
=2E793
RTD|     -22.405|      14.110|      37.354|       0|     -31.820|      67=
=2E793
RTD|      -6.870|      14.153|      35.505|       0|     -31.820|      67=
=2E793
RTD|      -5.768|      14.134|      17.730|       0|     -31.820|      67=
=2E793
RTD|     -26.884|      14.155|      67.783|       0|     -31.820|      67=
=2E793
RTD|     -28.662|      14.160|      64.228|       0|     -31.820|      67=
=2E793
RTD|     -23.330|      14.162|      67.783|       0|     -31.820|      67=
=2E793
RTD|     -24.645|      14.122|      59.358|       0|     -31.820|      67=
=2E793
RTD|     -25.107|      14.135|      62.451|       0|     -31.820|      67=
=2E793
RTT|  00:01:25  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|      -0.187|      14.119|      36.962|       0|     -31.820|      67=
=2E793
RTD|      -3.991|      14.121|      35.859|       0|     -31.820|      67=
=2E793
RTD|     -26.423|      14.121|      66.467|       0|     -31.820|      67=
=2E793
RTD|     -26.885|      14.127|      67.782|       0|     -31.820|      67=
=2E793
RTD|     -24.646|      14.142|      66.467|       0|     -31.820|      67=
=2E793
RTD|     -27.739|      14.130|      36.961|       0|     -31.820|      67=
=2E793
RTD|     -26.885|      14.153|      64.227|       0|     -31.820|      67=
=2E793
RTD|     -26.423|      14.155|      59.357|       0|     -31.820|      67=
=2E793
RTD|      -5.165|      14.160|      36.819|       0|     -31.820|      67=
=2E793
RTD|     -20.629|      14.106|      36.498|       0|     -31.820|      67=
=2E793
RTD|     -26.886|      14.132|      67.782|       0|     -31.820|      67=
=2E793
RTD|     -24.184|      14.117|      18.048|       0|     -31.820|      67=
=2E793
RTD|     -26.424|      14.164|      66.466|       0|     -31.820|      67=
=2E793
RTD|     -31.294|      14.159|      38.666|       0|     -31.820|      67=
=2E793
RTD|     -24.256|      14.141|      67.319|       0|     -31.820|      67=
=2E793
RTD|      -3.282|      14.125|      18.510|       0|     -31.820|      67=
=2E793
RTD|     -26.887|      14.154|      66.003|       0|     -31.820|      67=
=2E793
RTD|     -24.185|      14.128|      37.884|       0|     -31.820|      67=
=2E793
RTD|      -4.598|      14.135|      17.727|       0|     -31.820|      67=
=2E793
RTD|     -23.794|      14.168|      67.781|       0|     -31.820|      67=
=2E793
RTD|      -4.847|      14.131|      17.727|       0|     -31.820|      67=
=2E793
RTT|  00:01:46  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|     -22.408|      14.143|      38.666|       0|     -31.820|      67=
=2E793
RTD|      -4.598|      14.130|      37.172|       0|     -31.820|      67=
=2E793
RTD|     -24.186|      14.092|      17.727|       0|     -31.820|      67=
=2E793
RTD|     -26.425|      14.107|      66.465|       0|     -31.820|      67=
=2E793
RTD|      -1.150|      14.100|      28.853|       0|     -31.820|      67=
=2E793
RTD|     -28.274|      14.116|      30.169|       0|     -31.820|      67=
=2E793
RTD|     -26.888|      14.157|      64.225|       0|     -31.820|      67=
=2E793
RTD|     -25.964|      14.136|      17.726|       0|     -31.820|      67=
=2E793
RTD|      -4.599|      14.116|      17.726|       0|     -31.820|      67=
=2E793
RTD|     -24.187|      14.128|      18.508|       0|     -31.820|      67=
=2E793
RTD|      -3.995|      14.100|      36.105|       0|     -31.820|      67=
=2E793
RTD|      -6.377|      14.159|      38.806|       0|     -31.820|      67=
=2E793
RTD|     -26.427|      14.079|      57.576|       0|     -31.820|      67=
=2E793
RTD|      -3.391|      14.121|      37.278|       0|     -31.820|      67=
=2E793
---|--param|----range-|--samples
HSD|    min|   0 -  1 |        3
HSD|    min|   1 -  2 |        2
HSD|    min|   2 -  3 |        1
HSD|    min|   3 -  4 |        8
HSD|    min|   4 -  5 |        8
HSD|    min|   5 -  6 |        8
HSD|    min|   6 -  7 |        3
HSD|    min|   7 -  8 |        2
HSD|    min|   8 -  9 |        2
HSD|    min|  20 - 21 |        1
HSD|    min|  22 - 23 |       11
HSD|    min|  23 - 24 |        7
HSD|    min|  24 - 25 |       23
HSD|    min|  25 - 26 |        7
HSD|    min|  26 - 27 |       20
HSD|    min|  27 - 28 |        5
HSD|    min|  28 - 29 |        6
HSD|    min|  31 - 32 |        2
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |     9608
HSD|    avg|   1 -  2 |    48287
HSD|    avg|   2 -  3 |     4805
HSD|    avg|   3 -  4 |      290
HSD|    avg|   4 -  5 |       88
HSD|    avg|   5 -  6 |      571
HSD|    avg|   6 -  7 |      164
HSD|    avg|   7 -  8 |       69
HSD|    avg|   8 -  9 |       79
HSD|    avg|   9 - 10 |     8103
HSD|    avg|  10 - 11 |      120
HSD|    avg|  11 - 12 |     6279
HSD|    avg|  12 - 13 |   103724
HSD|    avg|  13 - 14 |   268364
HSD|    avg|  14 - 15 |   255873
HSD|    avg|  15 - 16 |   242899
HSD|    avg|  16 - 17 |    89866
HSD|    avg|  17 - 18 |   160304
HSD|    avg|  18 - 19 |       23
HSD|    avg|  19 - 20 |       23
HSD|    avg|  20 - 21 |        3
HSD|    avg|  21 - 22 |        5
HSD|    avg|  22 - 23 |       14
HSD|    avg|  23 - 24 |       18
HSD|    avg|  24 - 25 |       25
HSD|    avg|  25 - 26 |        7
HSD|    avg|  26 - 27 |       21
HSD|    avg|  27 - 28 |        6
HSD|    avg|  28 - 29 |        8
HSD|    avg|  30 - 31 |        1
HSD|    avg|  31 - 32 |        4
HSD|    avg|  32 - 33 |        3
HSD|    avg|  33 - 34 |        5
HSD|    avg|  34 - 35 |        8
HSD|    avg|  35 - 36 |       17
HSD|    avg|  36 - 37 |       42
HSD|    avg|  37 - 38 |       25
HSD|    avg|  38 - 39 |       10
HSD|    avg|  40 - 41 |        1
HSD|    avg|  44 - 45 |        1
HSD|    avg|  57 - 58 |        3
HSD|    avg|  58 - 59 |        1
HSD|    avg|  59 - 60 |        8
HSD|    avg|  60 - 61 |        1
HSD|    avg|  61 - 62 |       11
HSD|    avg|  62 - 63 |       19
HSD|    avg|  63 - 64 |        2
HSD|    avg|  64 - 65 |       28
HSD|    avg|  65 - 66 |        1
HSD|    avg|  66 - 67 |       16
HSD|    avg|  67 - 68 |       23
---|--param|----range-|--samples
HSD|    max|  17 - 18 |       13
HSD|    max|  18 - 19 |        4
HSD|    max|  19 - 20 |        4
HSD|    max|  23 - 24 |        1
HSD|    max|  28 - 29 |        1
HSD|    max|  30 - 31 |        1
HSD|    max|  34 - 35 |        2
HSD|    max|  35 - 36 |        5
HSD|    max|  36 - 37 |       16
HSD|    max|  37 - 38 |       11
HSD|    max|  38 - 39 |        6
HSD|    max|  44 - 45 |        1
HSD|    max|  57 - 58 |        1
HSD|    max|  59 - 60 |        6
HSD|    max|  62 - 63 |        2
HSD|    max|  64 - 65 |       10
HSD|    max|  66 - 67 |       12
HSD|    max|  67 - 68 |       23
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|       119|     18.345|      9.887
HSS|    avg|   1199876|     13.622|      3.417
HSS|    max|       119|     45.849|     18.797
---|------------|------------|------------|--------|---------------------=
----
RTS|     -31.820|      14.138|      67.793|       0|    00:02:00/00:02:00=

# latency -sh -T 120 -t2
=3D=3D Sampling period: 100 us
=3D=3D Test mode: in-kernel timer handler
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|     -16.104|      -5.006|       1.706|       0|     -16.104|       1=
=2E706
RTD|     -17.597|      -4.977|       1.706|       0|     -17.597|       1=
=2E706
RTD|     -16.104|      -4.963|       1.706|       0|     -17.597|       1=
=2E706
RTD|     -23.214|      -4.961|       1.706|       0|     -23.214|       1=
=2E706
RTD|     -16.104|      -5.004|       1.706|       0|     -23.214|       1=
=2E706
RTD|     -23.214|      -4.909|       1.706|       0|     -23.214|       1=
=2E706
RTD|     -16.105|      -4.951|       1.706|       0|     -23.214|       1=
=2E706
RTD|     -16.105|      -5.013|       1.705|       0|     -23.214|       1=
=2E706
RTD|     -23.215|      -5.046|       1.705|       0|     -23.215|       1=
=2E706
RTD|     -16.105|      -4.971|       1.705|       0|     -23.215|       1=
=2E706
RTD|     -16.105|      -5.003|       1.705|       0|     -23.215|       1=
=2E706
RTD|     -17.527|      -5.002|       1.705|       0|     -23.215|       1=
=2E706
RTD|     -23.215|      -4.929|       1.705|       0|     -23.215|       1=
=2E706
RTD|     -16.105|      -4.957|       1.705|       0|     -23.215|       1=
=2E706
RTD|     -16.106|      -4.917|       1.705|       0|     -23.215|       1=
=2E706
RTD|     -16.106|      -5.003|       1.704|       0|     -23.215|       1=
=2E706
RTD|     -16.106|      -5.014|       1.704|       0|     -23.215|       1=
=2E706
RTD|     -16.106|      -4.943|       1.704|       0|     -23.215|       1=
=2E706
RTD|     -23.216|      -4.943|       1.704|       0|     -23.216|       1=
=2E706
RTD|     -16.106|      -4.943|       1.704|       0|     -23.216|       1=
=2E706
RTD|     -16.106|      -4.982|       1.704|       0|     -23.216|       1=
=2E706
RTT|  00:00:22  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|     -16.106|      -4.948|       1.704|       0|     -23.216|       1=
=2E706
RTD|     -23.216|      -5.007|       1.704|       0|     -23.216|       1=
=2E706
RTD|     -16.107|      -4.939|       1.704|       0|     -23.216|       1=
=2E706
RTD|     -16.107|      -4.999|       1.703|       0|     -23.216|       1=
=2E706
RTD|     -16.213|      -4.966|       1.703|       0|     -23.216|       1=
=2E706
RTD|     -16.107|      -4.976|       1.703|       0|     -23.216|       1=
=2E706
RTD|     -16.107|      -4.940|       1.703|       0|     -23.216|       1=
=2E706
RTD|     -16.107|      -5.074|       1.703|       0|     -23.216|       1=
=2E706
RTD|     -16.107|      -4.982|       1.703|       0|     -23.216|       1=
=2E706
RTD|     -25.457|      -5.011|       1.703|       0|     -25.457|       1=
=2E706
RTD|     -16.108|      -4.913|       1.703|       0|     -25.457|       1=
=2E706
RTD|     -16.108|      -4.984|       1.702|       0|     -25.457|       1=
=2E706
RTD|     -23.218|      -4.995|       1.702|       0|     -25.457|       1=
=2E706
RTD|     -22.365|      -4.953|       1.702|       0|     -25.457|       1=
=2E706
RTD|     -16.108|      -4.988|       1.702|       0|     -25.457|       1=
=2E706
RTD|     -16.108|      -4.972|       1.702|       0|     -25.457|       1=
=2E706
RTD|     -23.218|      -4.969|       1.702|       0|     -25.457|       1=
=2E706
RTD|     -16.108|      -5.022|       1.702|       0|     -25.457|       1=
=2E706
RTD|     -17.033|      -4.931|       1.702|       0|     -25.457|       1=
=2E706
RTD|     -22.010|      -4.976|       1.702|       0|     -25.457|       1=
=2E706
RTD|     -16.109|      -4.976|       1.701|       0|     -25.457|       1=
=2E706
RTT|  00:00:43  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|     -16.109|      -4.899|       1.701|       0|     -25.457|       1=
=2E706
RTD|     -16.109|      -4.768|       1.701|       0|     -25.457|       1=
=2E706
RTD|     -25.459|      -4.689|       1.701|       0|     -25.459|       1=
=2E706
RTD|     -16.109|      -4.722|       1.701|       0|     -25.459|       1=
=2E706
RTD|     -16.109|      -4.731|       1.701|       0|     -25.459|       1=
=2E706
RTD|     -16.110|      -4.766|       1.701|       0|     -25.459|       1=
=2E706
RTD|     -19.309|      -4.785|       1.701|       0|     -25.459|       1=
=2E706
RTD|     -16.110|      -4.728|       1.700|       0|     -25.459|       1=
=2E706
RTD|     -20.838|      -4.733|       1.700|       0|     -25.459|       1=
=2E706
RTD|     -16.110|      -4.692|       1.700|       0|     -25.459|       1=
=2E706
RTD|     -16.110|      -4.780|       1.700|       0|     -25.459|       1=
=2E706
RTD|     -16.110|      -4.769|       1.700|       0|     -25.459|       1=
=2E706
RTD|     -16.110|      -4.698|       1.700|       0|     -25.459|       1=
=2E706
RTD|     -16.110|      -4.743|       1.700|       0|     -25.459|       1=
=2E706
RTD|     -16.110|      -4.744|       1.700|       0|     -25.459|       1=
=2E706
RTD|     -16.111|      -4.718|       1.700|       0|     -25.459|       1=
=2E706
RTD|     -16.111|      -4.781|       1.699|       0|     -25.459|       1=
=2E706
RTD|     -22.012|      -4.774|       1.699|       0|     -25.459|       1=
=2E706
RTD|     -16.111|      -4.762|       1.699|       0|     -25.459|       1=
=2E706
RTD|     -17.497|      -4.719|       1.699|       0|     -25.459|       1=
=2E706
RTD|     -16.111|      -4.798|       1.699|       0|     -25.459|       1=
=2E706
RTT|  00:01:04  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|     -17.533|      -4.769|       1.699|       0|     -25.459|       1=
=2E706
RTD|     -16.112|      -4.780|       1.699|       0|     -25.459|       1=
=2E706
RTD|     -16.112|      -4.694|       1.699|       0|     -25.459|       1=
=2E706
RTD|     -23.222|      -4.762|       1.698|       0|     -25.459|       1=
=2E706
RTD|     -16.112|      -4.781|       1.698|       0|     -25.459|       1=
=2E706
RTD|     -20.236|      -4.738|       1.698|       0|     -25.459|       1=
=2E706
RTD|     -16.574|      -4.766|       1.698|       0|     -25.459|       1=
=2E706
RTD|     -20.911|      -4.713|       1.698|       0|     -25.459|       1=
=2E706
RTD|     -16.112|      -4.789|       1.698|       0|     -25.459|       1=
=2E706
RTD|     -16.112|      -4.773|       1.698|       0|     -25.459|       1=
=2E706
RTD|     -25.462|      -4.744|       1.698|       0|     -25.462|       1=
=2E706
RTD|     -16.113|      -4.761|       1.698|       0|     -25.462|       1=
=2E706
RTD|     -16.113|      -4.759|       1.697|       0|     -25.462|       1=
=2E706
RTD|     -16.113|      -4.771|       1.697|       0|     -25.462|       1=
=2E706
RTD|     -16.113|      -4.802|       1.697|       0|     -25.462|       1=
=2E706
RTD|     -16.113|      -4.773|       1.697|       0|     -25.462|       1=
=2E706
RTD|     -16.113|      -4.700|       1.697|       0|     -25.462|       1=
=2E706
RTD|     -16.113|      -4.699|       1.697|       0|     -25.462|       1=
=2E706
RTD|     -16.113|      -4.722|       1.697|       0|     -25.462|       1=
=2E706
RTD|     -23.614|      -4.756|       1.697|       0|     -25.462|       1=
=2E706
RTD|     -16.114|      -4.704|       1.696|       0|     -25.462|       1=
=2E706
RTT|  00:01:25  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|     -16.114|      -4.750|       1.696|       0|     -25.462|       1=
=2E706
RTD|     -16.114|      -4.757|       1.696|       0|     -25.462|       1=
=2E706
RTD|     -16.221|      -4.771|       1.696|       0|     -25.462|       1=
=2E706
RTD|     -21.447|      -4.688|       1.696|       0|     -25.462|       1=
=2E706
RTD|     -16.114|      -4.762|       1.696|       0|     -25.462|       1=
=2E706
RTD|     -18.461|      -4.697|       1.696|       0|     -25.462|       1=
=2E706
RTD|     -16.114|      -4.779|       1.696|       0|     -25.462|       1=
=2E706
RTD|     -22.371|      -4.709|       1.696|       0|     -25.462|       1=
=2E706
RTD|     -16.115|      -4.717|       1.695|       0|     -25.462|       1=
=2E706
RTD|     -16.221|      -4.711|       1.695|       0|     -25.462|       1=
=2E706
RTD|     -16.115|      -4.761|       1.695|       0|     -25.462|       1=
=2E706
RTD|     -16.115|      -4.763|       1.695|       0|     -25.462|       1=
=2E706
RTD|     -16.115|      -4.733|       1.695|       0|     -25.462|       1=
=2E706
RTD|     -16.222|      -4.782|       1.695|       0|     -25.462|       1=
=2E706
RTD|     -16.116|      -4.719|       1.695|       0|     -25.462|       1=
=2E706
RTD|     -16.116|      -4.792|       1.695|       0|     -25.462|       1=
=2E706
RTD|     -16.116|      -4.704|       1.695|       0|     -25.462|       1=
=2E706
RTD|     -16.116|      -4.741|       1.694|       0|     -25.462|       1=
=2E706
RTD|     -16.116|      -4.714|       1.694|       0|     -25.462|       1=
=2E706
RTD|     -21.306|      -4.773|       1.694|       0|     -25.462|       1=
=2E706
RTD|     -16.116|      -4.790|       1.694|       0|     -25.462|       1=
=2E706
RTT|  00:01:46  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|     -16.116|      -4.788|       1.694|       0|     -25.462|       1=
=2E706
RTD|     -16.116|      -4.787|       1.694|       0|     -25.462|       1=
=2E706
RTD|     -25.466|      -4.722|       1.694|       0|     -25.466|       1=
=2E706
RTD|     -21.378|      -4.740|       1.694|       0|     -25.466|       1=
=2E706
RTD|     -16.117|      -4.731|       1.693|       0|     -25.466|       1=
=2E706
RTD|     -16.117|      -4.795|       1.693|       0|     -25.466|       1=
=2E706
RTD|     -16.117|      -4.783|       1.693|       0|     -25.466|       1=
=2E706
RTD|     -16.117|      -4.714|       1.693|       0|     -25.466|       1=
=2E706
RTD|     -16.117|      -4.751|       1.693|       0|     -25.466|       1=
=2E706
RTD|     -16.117|      -4.731|       1.693|       0|     -25.466|       1=
=2E706
RTD|     -18.997|      -4.795|       1.693|       0|     -25.466|       1=
=2E706
RTD|     -16.118|      -4.762|       1.693|       0|     -25.466|       1=
=2E706
RTD|     -16.118|      -4.749|       1.692|       0|     -25.466|       1=
=2E706
RTD|     -16.118|      -4.754|       1.692|       0|     -25.466|       1=
=2E706
---|--param|----range-|--samples
HSD|    min|  16 - 17 |       87
HSD|    min|  17 - 18 |        5
HSD|    min|  18 - 19 |        2
HSD|    min|  19 - 20 |        1
HSD|    min|  20 - 21 |        3
HSD|    min|  21 - 22 |        3
HSD|    min|  22 - 23 |        4
HSD|    min|  23 - 24 |       10
HSD|    min|  25 - 26 |        4
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |    71845
HSD|    avg|   1 -  2 |   167416
HSD|    avg|   2 -  3 |   205197
HSD|    avg|   3 -  4 |   119998
HSD|    avg|   4 -  5 |    23265
HSD|    avg|   5 -  6 |    76867
HSD|    avg|   6 -  7 |   201113
HSD|    avg|   7 -  8 |     6441
HSD|    avg|   8 -  9 |   319835
HSD|    avg|   9 - 10 |     2800
HSD|    avg|  10 - 11 |      120
HSD|    avg|  11 - 12 |      137
HSD|    avg|  12 - 13 |     2143
HSD|    avg|  13 - 14 |      105
HSD|    avg|  14 - 15 |     2160
HSD|    avg|  15 - 16 |       22
HSD|    avg|  16 - 17 |      370
HSD|    avg|  17 - 18 |        6
HSD|    avg|  18 - 19 |        2
HSD|    avg|  19 - 20 |        2
HSD|    avg|  20 - 21 |        5
HSD|    avg|  21 - 22 |        3
HSD|    avg|  22 - 23 |        4
HSD|    avg|  23 - 24 |       13
HSD|    avg|  25 - 26 |        4
---|--param|----range-|--samples
HSD|    max|   1 -  2 |      119
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|       119|     17.420|      2.704
HSS|    avg|   1199873|      4.432|      2.878
HSS|    max|       119|      1.000|      0.000
---|------------|------------|------------|--------|---------------------=
----
RTS|     -25.466|      -4.829|       1.706|       0|    00:02:00/00:02:00=

# switchtest -T 120
=3D=3D Testing FPU check routines...
=3D=3D FPU check routines: unimplemented, skipping FPU switches tests.
=3D=3D Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-7 =
rtuo-8
RTT|  00:00:01
RTH|ctx switches|-------total
RTD|         900|         900
RTD|         900|        1800
RTD|         909|        2709
RTD|         909|        3618
RTD|         909|        4527
RTD|         909|        5436
RTD|         909|        6345
RTD|         903|        7248
RTD|         909|        8157
RTD|         906|        9063
RTD|         909|        9972
RTD|         909|       10881
RTD|         900|       11781
RTD|         909|       12690
RTD|         894|       13584
RTD|         909|       14493
RTD|         915|       15408
RTD|         909|       16317
RTD|         909|       17226
RTD|         909|       18135
RTD|         909|       19044
RTT|  00:00:22
RTH|ctx switches|-------total
RTD|         909|       19953
RTD|         903|       20856
RTD|         909|       21765
RTD|         915|       22680
RTD|         909|       23589
RTD|         909|       24498
RTD|         909|       25407
RTD|         894|       26301
RTD|         906|       27207
RTD|         894|       28101
RTD|         915|       29016
RTD|         900|       29916
RTD|         909|       30825
RTD|         903|       31728
RTD|         906|       32634
RTD|         909|       33543
RTD|         894|       34437
RTD|         915|       35352
RTD|         900|       36252
RTD|         909|       37161
RTD|         903|       38064
RTT|  00:00:43
RTH|ctx switches|-------total
RTD|         909|       38973
RTD|         915|       39888
RTD|         909|       40797
RTD|         909|       41706
RTD|         909|       42615
RTD|         909|       43524
RTD|         900|       44424
RTD|         909|       45333
RTD|         900|       46233
RTD|         903|       47136
RTD|         906|       48042
RTD|         894|       48936
RTD|         909|       49845
RTD|         915|       50760
RTD|         900|       51660
RTD|         909|       52569
RTD|         900|       53469
RTD|         909|       54378
RTD|         894|       55272
RTD|         906|       56178
RTD|         894|       57072
RTT|  00:01:04
RTH|ctx switches|-------total
RTD|         906|       57978
RTD|         909|       58887
RTD|         909|       59796
RTD|         909|       60705
RTD|         903|       61608
RTD|         909|       62517
RTD|         915|       63432
RTD|         900|       64332
RTD|         909|       65241
RTD|         900|       66141
RTD|         909|       67050
RTD|         909|       67959
RTD|         894|       68853
RTD|         906|       69759
RTD|         909|       70668
RTD|         900|       71568
RTD|         909|       72477
RTD|         900|       73377
RTD|         903|       74280
RTD|         909|       75189
RTD|         915|       76104
RTT|  00:01:25
RTH|ctx switches|-------total
RTD|         909|       77013
RTD|         900|       77913
RTD|         903|       78816
RTD|         906|       79722
RTD|         909|       80631
RTD|         894|       81525
RTD|         915|       82440
RTD|         909|       83349
RTD|         909|       84258
RTD|         894|       85152
RTD|         906|       86058
RTD|         909|       86967
RTD|         894|       87861
RTD|         906|       88767
RTD|         909|       89676
RTD|         909|       90585
RTD|         903|       91488
RTD|         909|       92397
RTD|         915|       93312
RTD|         909|       94221
RTD|         909|       95130
RTT|  00:01:46
RTH|ctx switches|-------total
RTD|         909|       96039
RTD|         909|       96948
RTD|         900|       97848
RTD|         900|       98748
RTD|         900|       99648
RTD|         900|      100548
RTD|         909|      101457
RTD|         903|      102360
RTD|         906|      103266
RTD|         909|      104175
RTD|         894|      105069
RTD|         915|      105984
RTD|         909|      106893
RTD|         900|      107793
RTD|         216|      108009
[  858.080000] Xenomai: POSIX: destroyed thread c0f00810
# switchbench -h
=3D=3D Sampling period: 100 us
=3D=3D Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|     -31.995|      23.107|      62.211|           0
---|---range-|---samples
HSD| 0 - 1 |       1781
HSD| 1 - 2 |       3538
HSD| 3 - 4 |       3085
HSD| 5 - 6 |       3930
HSD| 7 - 8 |       4199
HSD| 8 - 9 |       4524
HSD| 10 - 11 |       4083
HSD| 12 - 13 |       3135
HSD| 14 - 15 |       2823
HSD| 15 - 16 |        834
HSD| 17 - 18 |        296
HSD| 19 - 20 |        467
HSD| 21 - 22 |        560
HSD| 23 - 24 |        615
HSD| 24 - 25 |        649
HSD| 26 - 27 |        464
HSD| 28 - 29 |        417
HSD| 30 - 31 |        620
HSD| 31 - 32 |        662
HSD| 33 - 34 |      30678
HSD| 35 - 36 |      27789
HSD| 37 - 38 |       2946
HSD| 39 - 40 |        753
HSD| 40 - 41 |        564
HSD| 42 - 43 |        335
HSD| 44 - 45 |        125
HSD| 46 - 47 |         28
HSD| 47 - 48 |         19
HSD| 49 - 50 |         12
HSD| 51 - 52 |          5
HSD| 53 - 54 |          8
HSD| 55 - 56 |         33
HSD| 56 - 57 |         10
HSD| 58 - 59 |          7
HSD| 60 - 61 |          1
HSD| 62 - 63 |          1
HSS|     99996|     25.187|     12.852
# cyclictest -p 10 -n -l 1000
0.00 0.00 0.00 1/14 92         =20
0.00 0.00 0.00 1/14 92         =20
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92                0 Min: 1000000 Act:       0 Avg:
0.00 0.00 0.00 1/14 92               16 Min:       4 Act:      24 Avg:
0.00 0.00 0.00 1/14 92               36 Min:       2 Act:      10 Avg:
0.00 0.00 0.00 1/14 92               56 Min:      -1 Act:      21 Avg:
0.00 0.00 0.00 1/14 92               76 Min:      -1 Act:       7 Avg:
0.00 0.00 0.00 1/14 92               96 Min:      -1 Act:       8 Avg:
0.00 0.00 0.00 1/14 92              116 Min:      -1 Act:      19 Avg:
0.00 0.00 0.00 1/14 92              136 Min:      -1 Act:      23 Avg:
0.00 0.00 0.00 1/14 92              156 Min:      -1 Act:      21 Avg:
0.00 0.00 0.00 1/14 92              176 Min:      -1 Act:       8 Avg:
0.00 0.00 0.00 1/14 92              196 Min:      -1 Act:      19 Avg:
0.00 0.00 0.00 1/14 92              216 Min:      -1 Act:       8 Avg:
0.00 0.00 0.00 1/14 92              236 Min:      -1 Act:      19 Avg:
0.00 0.00 0.00 1/14 92              256 Min:      -1 Act:       8 Avg:
0.00 0.00 0.00 1/14 92              276 Min:     -13 Act:      21 Avg:
0.00 0.00 0.00 1/14 92              296 Min:     -13 Act:      21 Avg:
0.00 0.00 0.00 1/14 92              316 Min:     -13 Act:      21 Avg:
0.00 0.00 0.00 1/14 92              336 Min:     -13 Act:      17 Avg:
0.00 0.00 0.00 1/14 92              356 Min:     -13 Act:      19 Avg:
0.00 0.00 0.00 1/14 92              376 Min:     -13 Act:      10 Avg:
0.00 0.00 0.00 1/14 92              396 Min:     -13 Act:      21 Avg:
0.00 0.00 0.00 1/14 92              416 Min:     -13 Act:      19 Avg:
0.00 0.00 0.00 1/14 92              436 Min:     -13 Act:      21 Avg:
0.00 0.00 0.00 1/14 92              456 Min:     -13 Act:      21 Avg:
0.00 0.00 0.00 1/14 92              476 Min:     -13 Act:      19 Avg:
0.00 0.00 0.00 1/14 92              496 Min:     -13 Act:      12 Avg:
0.00 0.00 0.00 1/14 92              516 Min:     -13 Act:      19 Avg:
0.00 0.00 0.00 1/14 92              536 Min:     -13 Act:      21 Avg:
0.00 0.00 0.00 1/14 92              556 Min:     -13 Act:      19 Avg:
0.00 0.00 0.00 1/14 92              576 Min:     -13 Act:      19 Avg:
0.00 0.00 0.00 1/14 92              596 Min:     -13 Act:      14 Avg:
0.00 0.00 0.00 1/14 92              616 Min:     -13 Act:       7 Avg:
0.00 0.00 0.00 1/14 92              636 Min:     -13 Act:      17 Avg:
0.00 0.00 0.00 1/14 92              656 Min:     -13 Act:      21 Avg:
0.00 0.00 0.00 1/14 92              676 Min:     -13 Act:      21 Avg:
0.00 0.00 0.00 1/14 92              696 Min:     -13 Act:      21 Avg:
0.00 0.00 0.00 1/14 92              716 Min:     -13 Act:      19 Avg:
0.00 0.00 0.00 1/14 92              736 Min:     -13 Act:      21 Avg:
0.00 0.00 0.00 1/14 92              756 Min:     -13 Act:      21 Avg:
0.00 0.00 0.00 1/14 92              776 Min:     -13 Act:      17 Avg:
0.00 0.00 0.00 1/14 92              796 Min:     -13 Act:      14 Avg:
0.00 0.00 0.00 1/14 92              816 Min:     -13 Act:      19 Avg:
0.00 0.00 0.00 1/14 92              836 Min:     -13 Act:      19 Avg:
0.00 0.00 0.00 1/14 92              856 Min:     -13 Act:      19 Avg:
0.00 0.00 0.00 1/14 92              876 Min:     -13 Act:       8 Avg:
0.00 0.00 0.00 1/14 92              896 Min:     -13 Act:      21 Avg:
0.00 0.00 0.00 1/14 92              916 Min:     -13 Act:      19 Avg:
0.00 0.00 0.00 1/14 92              936 Min:     -13 Act:      -8 Avg:
0.00 0.00 0.00 1/14 92              956 Min:     -13 Act:       5 Avg:
0.00 0.00 0.00 1/13 92              976 Min:     -13 Act:      23 Avg:
T: 0 (   92) P:10 I:    1000 C:     996 Min:     -13 Act:      10 Avg:
T: 0 (   92) P:10 I:    1000 C:    1000 Min:     -13 Act:      15 Avg:
15 Max:      70
[ 2648.180000] Xenomai: POSIX: destroyed thread c0f00810
# for f in /proc/xenomai/*;   do [ -f $f ] && cat $f; done
00000001
APC          CPU0
  0:            0    (pipe_wakeup)
  1:        12392    (lostage_handler)
  2:            5    (registry_export)
  3:            0    (pse51_lostage_handler)
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
1.9-01
size=3D129536:used=3D80:pagesz=3D512  (main heap)
size=3D32256:used=3D4096:pagesz=3D512  (stack pool)
IRQ         CPU0
  0:   142631771         [timer]
 34:       72335         [virtual]
10664
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT
  0  0        0      0          0          master    W          klat_srvr=

CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          2571162    0     00400080   24.1  ROOT
  0  0      0          2911       0     00000082    0.0  klat_srvr
  0  0      0          142632251  0     00000000   73.8  IRQ0: [timer]
NAME       RESOLUTION     JIFFIES   STATUS
master              1         n/a   enabled,set
status=3Don:setup=3D1777:clock=3D1610574647:timerdev=3DTIMER0:clockdev=3D=
TIMER
2.4.3
# for f in /proc/xenomai/*/*; do [ -f $f ] && cat $f; done
0
0
0
0
total=3D128:open=3D1:free=3D127
Hash    Name                            Driver          /proc
D6      rttest0                         xeno_timerbench rttest0
D7      rttest1                         xeno_irqbench   rttest1
D8      rttest2                         xeno_switchtest rttest2
Index   Locked  Device          Owner [PID]
0       1       rttest0         <kernel> [-1]
Hash    ProtocolFamily:SocketType       Driver          /proc
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME     =
     =20
0    287566      287565      394596     10000000   NULL         [host-tim=
er]  =20
0    28756555    28756554    19552      -          timer_proc   rttest0  =
     =20

--------------070307090800060707090101
Content-Type: text/x-csrc;
 name="time.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="time.c"

/*
 *  linux/arch/arm/mach-np5/time.c
 *
 *  Copyright (C) 2008 Neotion
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA
 */

#include <linux/types.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/spinlock.h>
#include <linux/interrupt.h>
#include <linux/irq.h>
#include <linux/sched.h>
#include <linux/termios.h>
#include <linux/timex.h>

#include <asm/hardware.h>
#include <asm/irq.h>
#include <asm/io.h>
#include <asm/mach/time.h>

#include <asm/arch/platform.h>

#include "time.h"

static unsigned long timer_period;

static void set_np5_timer(unsigned long delay)
{
    //Set the static delay
    timer_period =3D delay;
    //First stop the timer
    WRITE_REG(IO_ADDRESS(TMR0_CTRL_REG), TMR_STOP);
    //Configure in autoreload mode with a prescaler of 256
#ifdef CONFIG_NP5_TIMER_AUTORELOAD
    WRITE_REG(IO_ADDRESS(TMR0_SETTINGS_REG), TMR_AUTORELOAD | TMR_PRESCAL=
ER_256);
#else
    WRITE_REG(IO_ADDRESS(TMR0_SETTINGS_REG), TMR_PRESCALER_256);
#endif
    //Configure period of timer
    WRITE_REG(IO_ADDRESS(TMR0_PERIOD_REG), delay);
    //Clear pending interrupt
    WRITE_REG(IO_ADDRESS(TMR0_IRQ_CLEAR_REG), TMR_IRQ_CLEAR);
    //Enable timer interrupt
    WRITE_REG(IO_ADDRESS(TMR0_IRQ_CTRL_REG), TMR_IRQ_ENABLE);
    //Start the timer
    WRITE_REG(IO_ADDRESS(TMR0_CTRL_REG), TMR_START);
}

#ifdef CONFIG_IPIPE
static unsigned long timer_lxlost;
static unsigned long long __ipipe_mach_tsc;

int __ipipe_mach_timerint =3D TMR0_IRQ;
EXPORT_SYMBOL(__ipipe_mach_timerint);

int __ipipe_mach_timerstolen =3D 0;
EXPORT_SYMBOL(__ipipe_mach_timerstolen);

unsigned __ipipe_mach_ticks_per_jiffy =3D NP5_PERIOD;
EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);

/* IPIPE timer lock */
static IPIPE_DEFINE_SPINLOCK(timer_lock);

static inline unsigned long np5_getticksoffset(void)
{
    return (timer_period - (READ_REG(IO_ADDRESS(TMR0_TMR_REG)) & 0xFFFF))=
;
}

/* Acknoledge the hardware timer interrupt at hardware timer level. */
void __ipipe_mach_acktimer(void)
{
    WRITE_REG(IO_ADDRESS(TMR0_IRQ_CLEAR_REG), TMR_IRQ_CLEAR);
}

/* High resolution counter, or its emulation using the hardware decrement=
er or free-running counter */
notrace unsigned long long __ipipe_mach_get_tsc(void)
{
    unsigned long long result;
    unsigned long flags;

    local_irq_save_hw_notrace(flags);
    spin_lock(&timer_lock);
    result =3D __ipipe_mach_tsc + np5_getticksoffset();
    spin_unlock(&timer_lock);
    local_irq_restore_hw_notrace(flags);
    return result;
}
EXPORT_SYMBOL(__ipipe_mach_get_tsc);

/* Fills a structure which will be used in user-space to emulate the tsc.=
*/
void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
{
    info->type =3D IPIPE_TSC_TYPE_NONE;
}

/* Program the hardware timer to trig an interrupt in 'delay' hardware ti=
mer ticks. */
void __ipipe_mach_set_dec(unsigned long delay)
{
    unsigned long ticks;
    unsigned long flags;

    //spin_lock_irqsave(&timer_lock, flags);
    local_irq_save_hw(flags);
    ticks =3D np5_getticksoffset();
    __ipipe_mach_tsc +=3D ticks;
    timer_lxlost +=3D ticks;

    set_np5_timer(delay);
    local_irq_restore_hw(flags);
    //spin_unlock_irqrestore(&timer_lock, flags);
}
EXPORT_SYMBOL(__ipipe_mach_set_dec);

/* Called when Xenomai stops handling the hardware timer. */
void __ipipe_mach_release_timer(void)
{
    __ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
}
EXPORT_SYMBOL(__ipipe_mach_release_timer);

/* Returns the count of hardware timer ticks remaining before the next ti=
mer interrupt. */
unsigned long __ipipe_mach_get_dec(void)
{
    return  READ_REG(IO_ADDRESS(TMR0_TMR_REG)) & 0xFFFF;
}
#endif

static irqreturn_t np5_timer_interrupt(int irq, void *dev_id)
{
    write_seqlock(&xtime_lock);

#ifndef CONFIG_IPIPE
    //Clear pending interrupt
    WRITE_REG(IO_ADDRESS(TMR0_IRQ_CLEAR_REG), TMR_IRQ_CLEAR);
#else
    timer_lxlost =3D 0;
    if (!__ipipe_mach_timerstolen)
        __ipipe_mach_tsc +=3D np5_getticksoffset();
#endif

#ifndef CONFIG_NP5_TIMER_AUTORELOAD
    //Write back delay
    WRITE_REG(IO_ADDRESS(TMR0_PERIOD_REG), timer_period);
    //Start the timer
    WRITE_REG(IO_ADDRESS(TMR0_CTRL_REG), TMR_START);
#endif

    timer_tick();

    write_sequnlock(&xtime_lock);

    return IRQ_HANDLED;
}

static struct irqaction np5_timer_irq =3D {
    .name       =3D "NP5 Timer Tick",
    .flags      =3D IRQF_DISABLED | IRQF_TIMER,
    .handler    =3D np5_timer_interrupt,
};

void __init np5_timer_init(void)
{
    printk("np5: Timer 0 Init. : Freq %d Prescaler %d Period %d HZ %d\n",=
 NP5_FREQ, NP5_PRESCALER, NP5_PERIOD, HZ);

    //Set timer period
    set_np5_timer(NP5_PERIOD);

    // Configure IRQ Handler
    setup_irq(TMR0_IRQ, &np5_timer_irq);
}

unsigned long np5_gettimeoffset(void)
{
    unsigned int value;
    unsigned long elapsed, usec;

    value =3D READ_REG(IO_ADDRESS(TMR0_TMR_REG));
    value &=3D 0xFFFF; //Select only 16bits
    elapsed =3D timer_period - value;
#ifdef CONFIG_IPIPE
    elapsed +=3D timer_lxlost;
#endif

    usec =3D (unsigned long)((elapsed * (1000000/HZ)) / NP5_PERIOD);

    return usec;
}

--------------070307090800060707090101
Content-Type: text/x-vcard; charset=utf-8;
 name="narmstrong.vcf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="narmstrong.vcf"

begin:vcard
fn:Neil Armstrong
n:Armstrong;Neil
org:Neotion;Neotion Sophia Antipolis
email;internet:narmstrong@domain.hid
title;quoted-printable:Ing=3DC3=3DA9nieur Software Embarqu=3DC3=3DA9
tel;cell:0667474169
note:PGP 0x1166F485
version:2.1
end:vcard


--------------070307090800060707090101--

--------------enig3EE807098F0C68B42842BE7A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH+hUYb5rmahFm9IURArxQAKCZHKrOY6oLyM3UtlNbiAbgClGIqgCeKf62
gpBVXlHoIND2MHy/n9T4ELA=
=WGYA
-----END PGP SIGNATURE-----

--------------enig3EE807098F0C68B42842BE7A--

