From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Fri, 7 Dec 2007 23:47:07 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_r1cWHtcXvaBSi8M"
Message-Id: <200712072347.07847.niklaus.giger@domain.hid>
Subject: [Xenomai-help] Are these results running the xeno-test on a Sequoia
	board okay?
Reply-To: niklaus.giger@domain.hid
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

--Boundary-00=_r1cWHtcXvaBSi8M
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

I ran xeno-test on my sequoia board and am puzzled about three points:

1) When xeno-test was running the latency test, I loaded the system a little
bit by pinging, then doing a login on /dev/ttyS0 the numbers suddenly
changed to "inf"
RTD|      -0.862|      -0.816|      12.962|       0|      -1.236|      29.857
RTD|         inf|         inf|         inf|       0|         inf|         inf

2) Running switchtest I got
Error after context switch from task 8(rtup-8) to task 10(rtup_ufpp-10),
FPU registers were set to 1000 (maybe task sleeper_ufps-0)
RTT|  00:00:00
RTH|ctx switches|-------total
RTD|          28|          28

3) I had to recompile my C++-testsuite adding mhard-float to CXXFLAGS to
make it work correctly. Though it seems to me that setting CXX=ppc_4xxFP-g++
was not enough. I have no idea whether this has a something to do with the
problems spotted above.

I attach the used .config and xeno-test.log.

I built it like this using the DENX-kernel
cd /home/hcu/celsius/linux-2.6-xenomai
/home/hcu/celsius/xenomai-trunk/scripts/prepare-kernel.sh --linux=/home/hcu/celsius/linux-2.6-xenomai --adeos=/home/hcu/celsius/xenomai-trunk/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.23-powerpc-DENX-2.0-03.patch --arch=powerpc
make  ARCH=powerpc CROSS_COMPILE=ppc_4xxFP- O=/home/hcu/celsius/build-xeno-sequoia-powerpc-DENX-v2.6.23.9 oldconfig
make  ARCH=powerpc CROSS_COMPILE=ppc_4xxFP- O=/home/hcu/celsius/build-xeno-sequoia-powerpc-DENX-v2.6.23.9 zImage modules
sudo make  ARCH=powerpc CROSS_COMPILE=ppc_4xxFP- O=/home/hcu/celsius/build-xeno-sequoia-powerpc-DENX-v2.6.23.9 PATH=$/usr/local/bin:/opt/eldk/4_1/usr/bin:/usr/bin:/bin INSTALL_MOD_PATH=/opt/eldk/4_1/ppc_4xxFP modules_install
sudo cp -v /home/hcu/celsius/build-xeno-sequoia-powerpc-DENX-v2.6.23.9/arch/powerpc/boot/zImage /tftpboot/buildbot/zImage-sequoia
sudo cp -v /home/hcu/celsius/build-xeno-sequoia-powerpc-DENX-v2.6.23.9/arch/powerpc/boot/zImage /tftpboot/sequoia/zImage
cd /home/hcu/celsius/build-xeno-sequoia-powerpc-DENX-v2.6.23.9
/home/hcu/celsius/xenomai-trunk/configure --build=i686-linux --host=powerpc CROSS_COMPILE=ppc_4xxFP CC=ppc_4xxFP-gcc CXX=ppc_4xxFP-g++ LD=ppc_4xxFP-ld
make  clean
make
sudo make  PATH=/usr/local/bin:/opt/eldk/4_1/usr/bin:/usr/bin:/bin  DESTDIR=/opt/eldk/4_1/ppc_4xxFP install
cd /home/hcu/celsius

Best regards

-- 
Niklaus Giger

--Boundary-00=_r1cWHtcXvaBSi8M
Content-Type: text/plain;
  charset="iso-8859-1";
  name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.23.9
# Thu Dec  6 21:26:43 2007
#
# CONFIG_PPC64 is not set

#
# Processor support
#
# CONFIG_6xx is not set
# CONFIG_PPC_85xx is not set
# CONFIG_PPC_8xx is not set
# CONFIG_40x is not set
CONFIG_44x=y
# CONFIG_E200 is not set
CONFIG_PPC_FPU=y
CONFIG_4xx=y
CONFIG_BOOKE=y
CONFIG_PTE_64BIT=y
CONFIG_PHYS_64BIT=y
# CONFIG_PPC_MM_SLICES is not set
CONFIG_NOT_COHERENT_CACHE=y
CONFIG_PPC32=y
CONFIG_PPC_MERGE=y
CONFIG_MMU=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_IRQ_PER_CPU=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_ARCH_HAS_ILOG2_U32=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
CONFIG_PPC=y
CONFIG_EARLY_PRINTK=y
# CONFIG_SOFTDISABLE is not set
CONFIG_GENERIC_NVRAM=y
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_PPC_OF=y
CONFIG_OF=y
# CONFIG_PPC_UDBG_16550 is not set
# CONFIG_GENERIC_TBSYNC is not set
CONFIG_AUDIT_ARCH=y
CONFIG_GENERIC_BUG=y
# CONFIG_DEFAULT_UIMAGE is not set
CONFIG_PPC_DCR_NATIVE=y
# CONFIG_PPC_DCR_MMIO is not set
CONFIG_PPC_DCR=y
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
CONFIG_POSIX_MQUEUE=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_USER_NS is not set
# CONFIG_AUDIT is not set
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_SYSFS_DEPRECATED=y
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_EMBEDDED=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
# CONFIG_LOGBUFFER is not set
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
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_BLOCK=y
CONFIG_LBD=y
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
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Real-time sub-system
#
CONFIG_XENOMAI=y
CONFIG_XENO_OPT_NUCLEUS=y
CONFIG_XENO_OPT_PERVASIVE=y
# CONFIG_XENO_OPT_ISHIELD is not set
CONFIG_XENO_OPT_PRIOCPL=y
CONFIG_XENO_OPT_PIPELINE_HEAD=y
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_MAP=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_REGISTRY=y
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_SYS_HEAPSZ=128
CONFIG_XENO_OPT_STATS=y
# CONFIG_XENO_OPT_DEBUG is not set
# CONFIG_XENO_OPT_SHIRQ is not set

#
# Timing
#
CONFIG_XENO_OPT_TIMING_PERIODIC=y
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
CONFIG_XENO_HW_FPU=y

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
CONFIG_XENO_OPT_NATIVE_HEAP=y
CONFIG_XENO_OPT_NATIVE_ALARM=y
CONFIG_XENO_OPT_NATIVE_MPS=y
# CONFIG_XENO_OPT_NATIVE_INTR is not set
CONFIG_XENO_SKIN_POSIX=y
CONFIG_XENO_OPT_POSIX_PERIOD=0
# CONFIG_XENO_OPT_POSIX_SHM is not set
# CONFIG_XENO_OPT_POSIX_INTR is not set
CONFIG_XENO_OPT_DEBUG_POSIX=y
CONFIG_XENO_SKIN_PSOS=y
CONFIG_XENO_OPT_PSOS_PERIOD=1000
CONFIG_XENO_SKIN_UITRON=y
CONFIG_XENO_OPT_UITRON_PERIOD=1000
CONFIG_XENO_SKIN_VRTX=y
CONFIG_XENO_OPT_VRTX_PERIOD=1000
CONFIG_XENO_SKIN_VXWORKS=y
CONFIG_XENO_OPT_VXWORKS_PERIOD=1000
CONFIG_XENO_SKIN_RTAI=y
CONFIG_XENO_OPT_RTAI_PERIOD=0
CONFIG_XENO_OPT_RTAI_FIFO=y
CONFIG_XENO_OPT_RTAI_SEM=y
CONFIG_XENO_OPT_RTAI_SHM=y
CONFIG_XENO_SKIN_RTDM=y
CONFIG_XENO_OPT_RTDM_PERIOD=0
CONFIG_XENO_OPT_RTDM_FILDES=128

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
CONFIG_XENO_DRIVERS_TIMERBENCH=m
CONFIG_XENO_DRIVERS_IRQBENCH=m
CONFIG_XENO_DRIVERS_SWITCHTEST=m

#
# CAN drivers
#
# CONFIG_XENO_DRIVERS_CAN is not set

#
# Platform support
#
# CONFIG_PPC_MPC52xx is not set
# CONFIG_PPC_MPC5200 is not set
# CONFIG_PPC_CELL is not set
# CONFIG_PPC_CELL_NATIVE is not set
# CONFIG_PQ2ADS is not set
# CONFIG_BAMBOO is not set
# CONFIG_EBONY is not set
CONFIG_SEQUOIA=y
CONFIG_440EPX=y
CONFIG_440A=y
# CONFIG_MPIC is not set
# CONFIG_MPIC_WEIRD is not set
# CONFIG_PPC_I8259 is not set
# CONFIG_PPC_RTAS is not set
# CONFIG_MMIO_NVRAM is not set
# CONFIG_PPC_MPC106 is not set
# CONFIG_PPC_970_NAP is not set
# CONFIG_PPC_INDIRECT_IO is not set
# CONFIG_GENERIC_IOMAP is not set
# CONFIG_CPU_FREQ is not set
# CONFIG_CPM2 is not set
# CONFIG_FSL_ULI1575 is not set

#
# Kernel options
#
CONFIG_IPIPE=y
CONFIG_IPIPE_DOMAINS=4
CONFIG_IPIPE_COMPAT=y
# CONFIG_HIGHMEM is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_MATH_EMULATION=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_RESOURCES_64BIT=y
CONFIG_ZONE_DMA_FLAG=1
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_PROC_DEVICETREE=y
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE=""
CONFIG_SECCOMP=y
CONFIG_WANT_DEVICE_TREE=y
CONFIG_DEVICE_TREE="sequoia.dts"
CONFIG_ISA_DMA_API=y

#
# Bus options
#
CONFIG_ZONE_DMA=y
CONFIG_PPC_INDIRECT_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_SYSCALL=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
CONFIG_ARCH_SUPPORTS_MSI=y
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_DEBUG is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set
# CONFIG_HOTPLUG_PCI is not set

#
# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set

#
# Default settings for advanced configuration options are used
#
CONFIG_HIGHMEM_START=0xfe000000
CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_KERNEL_START=0xc0000000
CONFIG_TASK_SIZE=0x80000000
CONFIG_CONSISTENT_START=0xff100000
CONFIG_CONSISTENT_SIZE=0x00200000
CONFIG_BOOT_LOAD=0x01000000

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
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

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
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
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
CONFIG_MTD=y
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_CONCAT=y
CONFIG_MTD_PARTITIONS=y
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=y
# CONFIG_MTD_BLKDEVS is not set
# CONFIG_MTD_BLOCK is not set
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
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
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
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
CONFIG_MTD_PHYSMAP_OF=y
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
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
CONFIG_MTD_NAND_ECC_SMC=y
# CONFIG_MTD_NAND_MUSEUM_IDS is not set
# CONFIG_MTD_NAND_RB500 is not set
CONFIG_MTD_NAND_IDS=y
CONFIG_MTD_NAND_NDFC=y
# CONFIG_MTD_NAND_DISKONCHIP is not set
# CONFIG_MTD_NAND_CAFE is not set
# CONFIG_MTD_NAND_NANDSIM is not set
CONFIG_MTD_NAND_PLATFORM=y
# CONFIG_MTD_ONENAND is not set

#
# UBI - Unsorted block images
#
# CONFIG_MTD_UBI is not set
CONFIG_OF_DEVICE=y
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=35000
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_XILINX_SYSACE is not set
CONFIG_MISC_DEVICES=y
# CONFIG_PHANTOM is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
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
# CONFIG_SCSI_MULTI_LUN is not set
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
CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_SRP is not set
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_SVW is not set
# CONFIG_ATA_PIIX is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SX4 is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_ULI is not set
CONFIG_SATA_VIA=y
# CONFIG_SATA_VITESSE is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_IEEE1394 is not set
# CONFIG_I2O is not set
CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
# CONFIG_WINDFARM is not set
CONFIG_NETDEVICES=y
# CONFIG_NETDEVICES_MULTIQUEUE is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ARCNET is not set
# CONFIG_PHYLIB is not set
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_IBM_NEW_EMAC=y
CONFIG_IBM_NEW_EMAC_RXB=128
CONFIG_IBM_NEW_EMAC_TXB=64
CONFIG_IBM_NEW_EMAC_POLL_WEIGHT=32
CONFIG_IBM_NEW_EMAC_RX_COPY_THRESHOLD=256
CONFIG_IBM_NEW_EMAC_RX_SKB_HEADROOM=0
# CONFIG_IBM_NEW_EMAC_DEBUG is not set
CONFIG_IBM_NEW_EMAC_ZMII=y
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
CONFIG_IBM_NEW_EMAC_EMAC4=y
# CONFIG_NET_PCI is not set
CONFIG_NETDEV_1000=y
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
# CONFIG_QLA3XXX is not set
# CONFIG_ATL1 is not set
CONFIG_NETDEV_10000=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_MYRI10GE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_MLX4_CORE is not set
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
# CONFIG_USB_USBNET_MII is not set
# CONFIG_USB_USBNET is not set
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_ISDN is not set
# CONFIG_PHONE is not set

#
# Input device support
#
# CONFIG_INPUT is not set

#
# Hardware I/O ports
#
# CONFIG_SERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
# CONFIG_VT is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_PCI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_OF_PLATFORM=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_IPMI_HANDLER is not set
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_GEN_RTC is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
CONFIG_DEVPORT=y
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_IBM_OF=y
# CONFIG_I2C_MPC is not set
# CONFIG_I2C_MPC8260 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_TINY_USB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_24C01A is not set
# CONFIG_SENSORS_AD7416 is not set
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_DS1682 is not set
CONFIG_SENSORS_EEPROM=y
# CONFIG_SENSORS_MAX6900 is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_M41T00 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_FM75 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1115 is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

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
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Display device support
#
# CONFIG_DISPLAY_SUPPORT is not set
# CONFIG_VGASTATE is not set
# CONFIG_VIDEO_OUTPUT_CONTROL is not set
# CONFIG_FB is not set
# CONFIG_FB_IBM_GXT4500 is not set

#
# Sound
#
# CONFIG_SOUND is not set
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_DEVICE_CLASS=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_BIG_ENDIAN_MMIO=y
CONFIG_USB_EHCI_BIG_ENDIAN_DESC=y
CONFIG_USB_EHCI_HCD_PPC_OF=y
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD is not set
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
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
CONFIG_USB_MON=y

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
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_SELECTED=y
# CONFIG_USB_GADGET_AMD5536UDC is not set
# CONFIG_USB_GADGET_FSL_USB2 is not set
# CONFIG_USB_GADGET_NET2280 is not set
# CONFIG_USB_GADGET_PXA2XX is not set
# CONFIG_USB_GADGET_M66592 is not set
# CONFIG_USB_GADGET_GOKU is not set
# CONFIG_USB_GADGET_LH7A40X is not set
# CONFIG_USB_GADGET_PD12 is not set
# CONFIG_USB_GADGET_OMAP is not set
# CONFIG_USB_GADGET_S3C2410 is not set
# CONFIG_USB_GADGET_AT91 is not set
CONFIG_USB_GADGET_MUSBHSFC=y
CONFIG_USB_MUSBHSFC=y
# CONFIG_USB_GADGET_DWC_OTG is not set
# CONFIG_USB_GADGET_DUMMY_HCD is not set
CONFIG_USB_GADGET_DUALSPEED=y
# CONFIG_USB_ZERO is not set
CONFIG_USB_ETH=y
CONFIG_USB_ETH_RNDIS=y
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FILE_STORAGE is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_MMC is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_INFINIBAND is not set
# CONFIG_EDAC is not set
# CONFIG_RTC_CLASS is not set

#
# DMA Engine support
#
# CONFIG_DMA_ENGINE is not set

#
# DMA Clients
#

#
# DMA Devices
#

#
# Userspace I/O
#
# CONFIG_UIO is not set

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
# CONFIG_AUTOFS4_FS is not set
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
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
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
# CONFIG_YAFFS_FS is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_FS_XATTR is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
CONFIG_CRAMFS=y
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
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

#
# Native Language Support
#
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
# CONFIG_NLS_UTF8 is not set

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set
# CONFIG_UCC_SLOW is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
# CONFIG_CRC_CCITT is not set
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

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_MAGIC_SYSRQ=y
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
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
CONFIG_FORCED_INLINING=y
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_DEBUGGER=y
# CONFIG_KGDB is not set
# CONFIG_XMON is not set
# CONFIG_BDI_SWITCH is not set
# CONFIG_PPC_EARLY_DEBUG is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set
CONFIG_CRYPTO=y
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_MANAGER=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_GF128MUL is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_PCBC=y
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_HW=y

--Boundary-00=_r1cWHtcXvaBSi8M
Content-Type: text/plain;
  charset="iso-8859-1";
  name="xeno-test.log.sequoia.orig"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xeno-test.log.sequoia.orig"

xeno-test: started 
withBusybox is 0
xeno-test: running tests

Thu Jan  1 00:00:59 UTC 1970
running: ./xeno-config --verbose
xeno-config --verbose
    --version="2.3.96"
    --cc="ppc_4xxFP-gcc"
    --arch="powerpc"
    --prefix="/usr/xenomai"
    --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__"
    --xeno-ldflags="-L/usr/xenomai/lib -lpthread "
    --posix-cflags="-I/usr/xenomai/include -I/usr/xenomai/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__"
    --posix-ldflags="-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt "
    --library-dir="/usr/xenomai/lib"

Thu Jan  1 00:00:59 UTC 1970
running: ./xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux sequoia 2.6.23.9-dirty #1 Thu Dec 6 21:33:27 CET 2007 ppc ppc ppc GNU/Linux
 
Gnu C                  4.0.0
Gnu make               3.80
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.38
pcmcia-cs              3.2.8
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    89:
Sh-utils               5.2.1
Modules Loaded         

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/cpuinfo
processor	: 0
cpu		: 440EPX
clock		: 533.333336MHz
revision	: 24.208 (pvr 2162 18d0)
bogomips	: 1064.96
timebase	: 533333336
platform	: Sequoia

Thu Jan  1 00:01:01 UTC 1970
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
f31a2ed2409a54ddea74217ab168daf2  /proc/cpuinfo

Thu Jan  1 00:01:01 UTC 1970
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
  47:  A....
  48:  A....
  49:  A....
  50:  A....
  51:  A....
  52:  A....
  53:  A....
  54:  A....
  55:  A....
  56:  A....
  57:  A....
  58:  A....
  59:  A....
  60:  A....
  61:  A....
  62:  A....
  63:  A....
  64:  A....
  65:  A....
  66:  A....
  67:  A....
  68:  A....
  69:  A....
  70:  A....
  71:  A....
  72:  A....
  73:  A....
  74:  A....
  75:  A....
  76:  A....
  77:  A....
  78:  A....
  79:  A....
  80:  A....
  81:  A....
  82:  A....
  83:  A....
  84:  A....
  85:  A....
  86:  A....
  87:  A....
  88:  A....
  89:  A....
  90:  A....
  91:  A....
  92:  A....
  93:  A....
  94:  A....
  95:  A....
  96:  A....
  97:  A....
  98:  A....
  99:  A....
 100:  A....
 101:  A....
 102:  A....
 103:  A....
 104:  A....
 105:  A....
 106:  A....
 107:  A....
 108:  A....
 109:  A....
 110:  A....
 111:  A....
 112:  A....
 113:  A....
 114:  A....
 115:  A....
 116:  A....
 117:  A....
 118:  A....
 119:  A....
 120:  A....
 121:  A....
 122:  A....
 123:  A....
 124:  A....
 125:  A....
 126:  A....
 127:  A....
 128:  A....
 129:  A....
 130:  A....
 131:  A....
 132:  A....
 133:  A....
 134:  A....
 135:  A....
 136:  A....
 137:  A....
 138:  A....
 139:  A....
 140:  A....
 141:  A....
 142:  A....
 143:  A....
 144:  A....
 145:  A....
 146:  A....
 147:  A....
 148:  A....
 149:  A....
 150:  A....
 151:  A....
 152:  A....
 153:  A....
 154:  A....
 155:  A....
 156:  A....
 157:  A....
 158:  A....
 159:  A....
 160:  A....
 161:  A....
 162:  A....
 163:  A....
 164:  A....
 165:  A....
 166:  A....
 167:  A....
 168:  A....
 169:  A....
 170:  A....
 171:  A....
 172:  A....
 173:  A....
 174:  A....
 175:  A....
 176:  A....
 177:  A....
 178:  A....
 179:  A....
 180:  A....
 181:  A....
 182:  A....
 183:  A....
 184:  A....
 185:  A....
 186:  A....
 187:  A....
 188:  A....
 189:  A....
 190:  A....
 191:  A....
 192:  A....
 193:  A....
 194:  A....
 195:  A....
 196:  A....
 197:  A....
 198:  A....
 199:  A....
 200:  A....
 201:  A....
 202:  A....
 203:  A....
 204:  A....
 205:  A....
 206:  A....
 207:  A....
 208:  A....
 209:  A....
 210:  A....
 211:  A....
 212:  A....
 213:  A....
 214:  A....
 215:  A....
 216:  A....
 217:  A....
 218:  A....
 219:  A....
 220:  A....
 221:  A....
 222:  A....
 223:  A....
 224:  A....
 225:  A....
 226:  A....
 227:  A....
 228:  A....
 229:  A....
 230:  A....
 231:  A....
 232:  A....
 233:  A....
 234:  A....
 235:  A....
 236:  A....
 237:  A....
 238:  A....
 239:  A....
 240:  A....
 241:  A....
 242:  A....
 243:  A....
 244:  A....
 245:  A....
 246:  A....
 247:  A....
 248:  A....
 249:  A....
 250:  A....
 251:  A....
 252:  A....
 253:  A....
 254:  A....
 255:  A....
 256:  A....
 257:  A....
 258:  A....
 259:  A....
 260:  A....
 261:  A....
 262:  A....
 263:  A....
 264:  A....
 265:  A....
 266:  A....
 267:  A....
 268:  A....
 269:  A....
 270:  A....
 271:  A....
 272:  A....
 273:  A....
 274:  A....
 275:  A....
 276:  A....
 277:  A....
 278:  A....
 279:  A....
 280:  A....
 281:  A....
 282:  A....
 283:  A....
 284:  A....
 285:  A....
 286:  A....
 287:  A....
 288:  A....
 289:  A....
 290:  A....
 291:  A....
 292:  A....
 293:  A....
 294:  A....
 295:  A....
 296:  A....
 297:  A....
 298:  A....
 299:  A....
 300:  A....
 301:  A....
 302:  A....
 303:  A....
 304:  A....
 305:  A....
 306:  A....
 307:  A....
 308:  A....
 309:  A....
 310:  A....
 311:  A....
 312:  A....
 313:  A....
 314:  A....
 315:  A....
 316:  A....
 317:  A....
 318:  A....
 319:  A....
 320:  A....
 321:  A....
 322:  A....
 323:  A....
 324:  A....
 325:  A....
 326:  A....
 327:  A....
 328:  A....
 329:  A....
 330:  A....
 331:  A....
 332:  A....
 333:  A....
 334:  A....
 335:  A....
 336:  A....
 337:  A....
 338:  A....
 339:  A....
 340:  A....
 341:  A....
 342:  A....
 343:  A....
 344:  A....
 345:  A....
 346:  A....
 347:  A....
 348:  A....
 349:  A....
 350:  A....
 351:  A....
 352:  A....
 353:  A....
 354:  A....
 355:  A....
 356:  A....
 357:  A....
 358:  A....
 359:  A....
 360:  A....
 361:  A....
 362:  A....
 363:  A....
 364:  A....
 365:  A....
 366:  A....
 367:  A....
 368:  A....
 369:  A....
 370:  A....
 371:  A....
 372:  A....
 373:  A....
 374:  A....
 375:  A....
 376:  A....
 377:  A....
 378:  A....
 379:  A....
 380:  A....
 381:  A....
 382:  A....
 383:  A....
 384:  A....
 385:  A....
 386:  A....
 387:  A....
 388:  A....
 389:  A....
 390:  A....
 391:  A....
 392:  A....
 393:  A....
 394:  A....
 395:  A....
 396:  A....
 397:  A....
 398:  A....
 399:  A....
 400:  A....
 401:  A....
 402:  A....
 403:  A....
 404:  A....
 405:  A....
 406:  A....
 407:  A....
 408:  A....
 409:  A....
 410:  A....
 411:  A....
 412:  A....
 413:  A....
 414:  A....
 415:  A....
 416:  A....
 417:  A....
 418:  A....
 419:  A....
 420:  A....
 421:  A....
 422:  A....
 423:  A....
 424:  A....
 425:  A....
 426:  A....
 427:  A....
 428:  A....
 429:  A....
 430:  A....
 431:  A....
 432:  A....
 433:  A....
 434:  A....
 435:  A....
 436:  A....
 437:  A....
 438:  A....
 439:  A....
 440:  A....
 441:  A....
 442:  A....
 443:  A....
 444:  A....
 445:  A....
 446:  A....
 447:  A....
 448:  A....
 449:  A....
 450:  A....
 451:  A....
 452:  A....
 453:  A....
 454:  A....
 455:  A....
 456:  A....
 457:  A....
 458:  A....
 459:  A....
 460:  A....
 461:  A....
 462:  A....
 463:  A....
 464:  A....
 465:  A....
 466:  A....
 467:  A....
 468:  A....
 469:  A....
 470:  A....
 471:  A....
 472:  A....
 473:  A....
 474:  A....
 475:  A....
 476:  A....
 477:  A....
 478:  A....
 479:  A....
 480:  A....
 481:  A....
 482:  A....
 483:  A....
 484:  A....
 485:  A....
 486:  A....
 487:  A....
 488:  A....
 489:  A....
 490:  A....
 491:  A....
 492:  A....
 493:  A....
 494:  A....
 495:  A....
 496:  A....
 497:  A....
 498:  A....
 499:  A....
 500:  A....
 501:  A....
 502:  A....
 503:  A....
 504:  A....
 505:  A....
 506:  A....
 507:  A....
 508:  A....
 509:  A....
 510:  A....
 511:  A....
 512:  A...V
 513:  G...V
 514:  G...V
[Domain info]
id=0x00000000
priority=100

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/ipipe/Xenomai
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
 512:  W..XV
 515:  W...V
[Domain info]
id=0x58454e4f
priority=topmost

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/ipipe/version
2.0-03

Thu Jan  1 00:01:01 UTC 1970
running: generate_loads 1
dd workload started, pids 1121 stored in /var/lock/xeno-test.988.pids

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/interrupts
           CPU0       
 16:        207   UIC   Edge      serial
 20:          0   UIC   Level     musbhsfc_udc
 21:      14941   UIC   Edge      MAL TX EOB
 22:      24755   UIC   Edge      MAL RX EOB
 23:          0   UIC   Edge      MAL SERR
 24:          0   UIC   Edge      MAL TX DE
 25:          0   UIC   Edge      MAL RX DE
 26:          0   UIC   Edge      EMAC
 28:          0   UIC   Edge      UIC cascade
 30:          0   UIC   Edge      UIC cascade
 32:          0   UIC   Edge      ehci_hcd:usb1
 33:          0   UIC   Edge      IBM IIC
 34:          0   UIC   Edge      IBM IIC
BAD:          0

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/loadavg
0.19 0.06 0.02 2/32 1127

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/meminfo
MemTotal:       256208 kB
MemFree:        236048 kB
Buffers:             0 kB
Cached:          14196 kB
SwapCached:          0 kB
Active:           7192 kB
Inactive:         9064 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:              24 kB
Writeback:           0 kB
AnonPages:        2072 kB
Mapped:           2200 kB
Slab:             2444 kB
SReclaimable:      504 kB
SUnreclaim:       1940 kB
PageTables:        296 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:    128104 kB
Committed_AS:     5460 kB
VmallocTotal:   736248 kB
VmallocUsed:     66044 kB
VmallocChunk:   670196 kB

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/xenomai/affinity
00000001

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:            0    (lostage_handler)
  2:            2    (registry_export)
  3:            0    (posix_signals_handler)

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/xenomai/faults
TRAP         CPU0
  0:            0    (Data or instruction access)
  1:            0    (Alignment)
  2:            0    (Altivec unavailable)
  3:            0    (Program check exception)
  4:            0    (Machine check exception)
  5:            0    (Unknown)
  6:            0    (Instruction breakpoint)
  7:            0    (Run mode exception)
  8:            0    (Single-step exception)
  9:            0    (Non-recoverable exception)
 10:            0    (Software emulation)
 11:            0    (Debug)
 12:            0    (SPE)
 13:            0    (Altivec assist)
 14:            0    (Cache-locking exception)
 15:            0    (Kernel FP unavailable)

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/xenomai/hal
2.0-03

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/xenomai/heap
size=129536:used=49952:pagesz=512

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/xenomai/irq
IRQ         CPU0
512:      260771         [virtual]
515:           0         [virtual]

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/xenomai/latency
3000

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          0          0     00500080   99.5  ROOT
  0  0      0          261205     0     00000000    0.5  IRQ512: [timer]

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/xenomai/timebases
NAME       RESOLUTION     JIFFIES   STATUS
master              1         n/a   enabled,set
psos          1000000       61492   disabled,unset,isolated
vrtx          1000000       61492   disabled,unset,isolated
vxworks       1000000       61492   disabled,unset,isolated
uitron        1000000       61492   disabled,unset,isolated

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/xenomai/timer
status=on:setup=1:clock=32932214231:timerdev=decrementer:clockdev=timebase

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/xenomai/version
2.4-rc7

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/xenomai/interfaces/native
0

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/xenomai/interfaces/posix
0

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/xenomai/interfaces/psos
0

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/xenomai/interfaces/rtai
0

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/xenomai/interfaces/rtdm
0

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/xenomai/interfaces/sys
0

Thu Jan  1 00:01:01 UTC 1970
running: cat /proc/xenomai/interfaces/uitron
0

Thu Jan  1 00:01:02 UTC 1970
running: cat /proc/xenomai/interfaces/vrtx
0

Thu Jan  1 00:01:02 UTC 1970
running: cat /proc/xenomai/interfaces/vxworks
0

Thu Jan  1 00:01:02 UTC 1970
running: cat /proc/xenomai/rtdm/fildes
total=128:open=0:free=128

Thu Jan  1 00:01:02 UTC 1970
running: cat /proc/xenomai/rtdm/named_devices
Hash	Name				Driver		/proc

Thu Jan  1 00:01:02 UTC 1970
running: cat /proc/xenomai/rtdm/open_fildes
Index	Locked	Device		Owner [PID]

Thu Jan  1 00:01:02 UTC 1970
running: cat /proc/xenomai/rtdm/protocol_devices
Hash	ProtocolFamily:SocketType	Driver		/proc

Thu Jan  1 00:01:02 UTC 1970
running: cat /proc/xenomai/timerstat/master
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           
0    15509       15508       1101772    4000000    NULL         [host-timer]   
0    62035       62034       197244     1000000    xntimer_tic  psos           
0    62035       62034       324551     1000000    xntimer_tic  vrtx           
0    62035       62034       477016     1000000    xntimer_tic  vxworks        
0    62035       62034       508303     1000000    xntimer_tic  uitron         

Thu Jan  1 00:01:02 UTC 1970
running: cat /proc/xenomai/timerstat/psos
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           

Thu Jan  1 00:01:02 UTC 1970
running: cat /proc/xenomai/timerstat/uitron
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           

Thu Jan  1 00:01:02 UTC 1970
running: cat /proc/xenomai/timerstat/vrtx
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           

Thu Jan  1 00:01:02 UTC 1970
running: cat /proc/xenomai/timerstat/vxworks
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           

Thu Jan  1 00:01:02 UTC 1970
running: top -bn1c
top - 00:01:03 up 1 min,  1 user,  load average: 0.19, 0.06, 0.02
Tasks:  34 total,   2 running,  32 sleeping,   0 stopped,   0 zombie
Cpu(s):  4.5% us, 17.8% sy,  0.0% ni, 68.9% id,  8.1% wa,  0.0% hi,  0.7% si
Mem:    256208k total,    20828k used,   235380k free,        0k buffers
Swap:        0k total,        0k used,        0k free,    14420k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
 1121 root      20   0  1648  424  344 R 95.4  0.2   0:01.06 dd if /dev/zero of 
    1 root      20   0  1644  572  500 S  0.0  0.2   0:06.68 init [3]           
    2 root      15  -5     0    0    0 S  0.0  0.0   0:00.00 [kthreadd]         

Thu Jan  1 00:01:03 UTC 1970
running: ./run -- -sh -T 120 -t0 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.056|       0.446|       8.634|       0|       0.056|       8.634
RTD|       0.406|       0.530|      25.449|       0|       0.056|      25.449
RTD|       0.406|       0.450|      26.482|       0|       0.056|      26.482
RTD|       0.035|       0.468|      27.172|       0|       0.035|      27.172
RTD|       0.191|       0.553|      20.645|       0|       0.035|      27.172
RTD|       0.406|       0.455|      19.672|       0|       0.035|      27.172
RTD|       0.015|       0.481|      23.023|       0|       0.015|      27.172
RTD|       0.367|       0.511|      24.881|       0|       0.015|      27.172
RTD|       0.373|       0.453|      29.161|       0|       0.015|      29.161
RTD|       0.373|       0.472|      27.540|       0|       0.015|      29.161
RTD|       0.373|       0.455|      21.525|       0|       0.015|      29.161
RTD|       0.373|       0.459|      21.690|       0|       0.015|      29.161
RTD|       0.373|       0.455|      18.605|       0|       0.015|      29.161
RTD|       0.373|       0.455|      21.731|       0|       0.015|      29.161
RTD|       0.373|       0.457|      20.238|       0|       0.015|      29.161
RTD|       0.367|       0.459|      21.643|       0|       0.015|      29.161
RTD|       0.020|       0.523|      20.040|       0|       0.015|      29.161
RTD|       0.373|       0.474|      22.117|       0|       0.015|      29.161
RTD|       0.054|       0.504|      17.197|       0|       0.015|      29.161
RTD|       0.406|       0.491|      27.562|       0|       0.015|      29.161
RTD|       0.123|       0.470|      16.466|       0|       0.015|      29.161
RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.039|       0.485|      17.660|       0|       0.015|      29.161
RTD|       0.410|       0.511|      19.501|       0|       0.015|      29.161
RTD|       0.401|       0.455|      26.156|       0|       0.015|      29.161
RTD|       0.013|       0.519|      20.975|       0|       0.013|      29.161
RTD|       0.373|       0.476|      19.522|       0|       0.013|      29.161
RTD|       0.373|       0.451|      25.680|       0|       0.013|      29.161
RTD|       0.373|       0.457|      19.856|       0|       0.013|      29.161
RTD|       0.373|       0.451|      18.305|       0|       0.013|      29.161
RTD|       0.373|       0.459|      27.712|       0|       0.013|      29.161
RTD|       0.373|       0.472|      29.266|       0|       0.013|      29.266
RTD|       0.373|       0.457|      17.143|       0|       0.013|      29.266
RTD|       0.373|       0.451|      20.274|       0|       0.013|      29.266
RTD|       0.373|       0.459|      23.415|       0|       0.013|      29.266
RTD|       0.046|       0.543|      21.553|       0|       0.013|      29.266
RTD|       0.373|       0.491|      32.214|       0|       0.013|      32.214
RTD|       0.076|       0.541|      17.458|       0|       0.013|      32.214
RTD|       0.373|       0.472|      23.754|       0|       0.013|      32.214
RTD|       0.373|       0.451|      22.593|       0|       0.013|      32.214
RTD|       0.018|       0.523|      21.515|       0|       0.013|      32.214
RTD|       0.406|       0.474|      17.398|       0|       0.013|      32.214
RTD|       0.406|       0.457|      24.570|       0|       0.013|      32.214
RTT|  00:00:43  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.018|       0.536|      19.897|       0|       0.013|      32.214
RTD|       0.376|       0.459|      17.443|       0|       0.013|      32.214
RTD|       0.373|       0.457|      22.055|       0|       0.013|      32.214
RTD|       0.373|       0.457|      20.362|       0|       0.013|      32.214
RTD|       0.373|       0.453|      18.575|       0|       0.013|      32.214
RTD|       0.367|       0.459|      23.660|       0|       0.013|      32.214
RTD|       0.373|       0.451|      17.409|       0|       0.013|      32.214
RTD|       0.376|       0.461|      19.250|       0|       0.013|      32.214
RTD|       0.376|       0.455|      15.845|       0|       0.013|      32.214
RTD|       0.046|       0.461|      22.980|       0|       0.013|      32.214
RTD|       0.373|       0.532|      21.583|       0|       0.013|      32.214
RTD|       0.118|       0.483|      24.026|       0|       0.013|      32.214
RTD|       0.088|       0.549|      23.338|       0|       0.013|      32.214
RTD|       0.376|       0.461|      28.753|       0|       0.013|      32.214
RTD|       0.373|       0.450|      24.292|       0|       0.013|      32.214
RTD|       0.016|       0.540|      21.097|       0|       0.013|      32.214
RTD|       0.406|       0.451|      18.054|       0|       0.013|      32.214
RTD|       0.009|       0.476|      26.700|       0|       0.009|      32.214
RTD|       0.337|       0.532|      20.776|       0|       0.009|      32.214
RTD|       0.373|       0.459|      17.608|       0|       0.009|      32.214
RTD|       0.376|       0.455|      18.150|       0|       0.009|      32.214
RTT|  00:01:04  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.367|       0.455|      20.182|       0|       0.009|      32.214
RTD|       0.376|       0.459|      20.103|       0|       0.009|      32.214
RTD|       0.373|       0.455|      18.810|       0|       0.009|      32.214
RTD|       0.373|       0.451|      17.767|       0|       0.009|      32.214
RTD|       0.376|       0.457|      17.272|       0|       0.009|      32.214
RTD|       0.376|       0.453|      14.799|       0|       0.009|      32.214
RTD|       0.031|       0.487|      20.377|       0|       0.009|      32.214
RTD|       0.376|       0.556|      20.223|       0|       0.009|      32.214
RTD|       0.061|       0.463|      23.703|       0|       0.009|      32.214
RTD|       0.373|       0.526|      18.791|       0|       0.009|      32.214
RTD|       0.373|       0.453|      19.590|       0|       0.009|      32.214
RTD|       0.020|       0.457|      15.337|       0|       0.009|      32.214
RTD|       0.348|       0.570|      28.560|       0|       0.009|      32.214
RTD|       0.406|       0.453|      22.597|       0|       0.009|      32.214
RTD|       0.020|       0.474|      19.813|       0|       0.009|      32.214
RTD|       0.373|       0.523|      18.425|       0|       0.009|      32.214
RTD|       0.371|       0.463|      20.364|       0|       0.009|      32.214
RTD|       0.376|       0.457|      20.985|       0|       0.009|      32.214
RTD|       0.376|       0.465|      24.103|       0|       0.009|      32.214
RTD|       0.193|       2.366|      41.731|       0|       0.009|      41.731
RTD|       0.196|       2.400|      36.245|       0|       0.009|      41.731
RTT|  00:01:25  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.376|       0.459|      23.390|       0|       0.009|      41.731
RTD|       0.373|       0.496|      19.295|       0|       0.009|      41.731
RTD|       0.120|       0.506|      22.584|       0|       0.009|      41.731
RTD|       0.018|       0.768|      30.388|       0|       0.009|      41.731
RTD|       0.365|       0.534|      24.971|       0|       0.009|      41.731
RTD|       0.058|       0.498|      20.446|       0|       0.009|      41.731
RTD|       0.376|       0.506|      23.516|       0|       0.009|      41.731
RTD|       0.376|       0.457|      19.777|       0|       0.009|      41.731
RTD|       0.058|       0.465|      20.876|       0|       0.009|      41.731
RTD|       0.410|       0.532|      21.750|       0|       0.009|      41.731
RTD|       0.410|       0.459|      23.302|       0|       0.009|      41.731
RTD|       0.039|       0.506|      23.615|       0|       0.009|      41.731
RTD|       0.373|       0.493|      25.278|       0|       0.009|      41.731
RTD|       0.376|       0.459|      22.953|       0|       0.009|      41.731
RTD|       0.376|       0.455|      19.681|       0|       0.009|      41.731
RTD|       0.376|       0.466|      23.253|       0|       0.009|      41.731
RTD|       0.376|       0.457|      24.315|       0|       0.009|      41.731
RTD|       0.376|       0.457|      22.513|       0|       0.009|      41.731
RTD|       0.131|       0.472|      23.516|       0|       0.009|      41.731
RTD|       0.376|       0.461|      20.698|       0|       0.009|      41.731
RTD|       0.371|       0.457|      23.913|       0|       0.009|      41.731
RTT|  00:01:46  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.020|       0.541|      18.491|       0|       0.009|      41.731
RTD|       0.373|       0.451|      16.301|       0|       0.009|      41.731
RTD|       0.069|       0.530|      23.413|       0|       0.009|      41.731
RTD|       0.376|       0.470|      22.430|       0|       0.009|      41.731
RTD|       0.376|       0.461|      23.385|       0|       0.009|      41.731
RTD|       0.030|       0.519|      23.083|       0|       0.009|      41.731
RTD|       0.410|       0.496|      20.623|       0|       0.009|      41.731
RTD|       0.390|       0.455|      20.431|       0|       0.009|      41.731
RTD|       0.015|       0.541|      21.120|       0|       0.009|      41.731
RTD|       0.373|       0.457|      20.315|       0|       0.009|      41.731
RTD|       0.373|       0.487|      24.075|       0|       0.009|      41.731
RTD|       0.373|       0.451|      19.010|       0|       0.009|      41.731
RTD|       0.373|       0.455|      21.071|       0|       0.009|      41.731
RTD|       0.131|       0.455|      18.825|       0|       0.009|      41.731
---|--param|----range-|--samples
HSD|    min|   0 -  1 |      119
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |  1177324
HSD|    avg|   1 -  2 |     7816
HSD|    avg|   2 -  3 |     8006
HSD|    avg|   3 -  4 |      459
HSD|    avg|   4 -  5 |      412
HSD|    avg|   5 -  6 |      411
HSD|    avg|   6 -  7 |      404
HSD|    avg|   7 -  8 |      456
HSD|    avg|   8 -  9 |      431
HSD|    avg|   9 - 10 |      455
HSD|    avg|  10 - 11 |      438
HSD|    avg|  11 - 12 |      405
HSD|    avg|  12 - 13 |      413
HSD|    avg|  13 - 14 |      403
HSD|    avg|  14 - 15 |      344
HSD|    avg|  15 - 16 |      324
HSD|    avg|  16 - 17 |      249
HSD|    avg|  17 - 18 |      215
HSD|    avg|  18 - 19 |      175
HSD|    avg|  19 - 20 |      139
HSD|    avg|  20 - 21 |       89
HSD|    avg|  21 - 22 |       64
HSD|    avg|  22 - 23 |       37
HSD|    avg|  23 - 24 |       33
HSD|    avg|  24 - 25 |       18
HSD|    avg|  25 - 26 |       12
HSD|    avg|  26 - 27 |       15
HSD|    avg|  27 - 28 |        9
HSD|    avg|  28 - 29 |        7
HSD|    avg|  29 - 30 |        5
HSD|    avg|  30 - 31 |        2
HSD|    avg|  31 - 32 |        4
HSD|    avg|  32 - 33 |        2
HSD|    avg|  35 - 36 |        1
HSD|    avg|  36 - 37 |        1
HSD|    avg|  38 - 39 |        1
HSD|    avg|  41 - 42 |        1
---|--param|----range-|--samples
HSD|    max|   8 -  9 |        1
HSD|    max|  14 - 15 |        1
HSD|    max|  15 - 16 |        2
HSD|    max|  16 - 17 |        2
HSD|    max|  17 - 18 |       10
HSD|    max|  18 - 19 |       10
HSD|    max|  19 - 20 |       12
HSD|    max|  20 - 21 |       19
HSD|    max|  21 - 22 |       11
HSD|    max|  22 - 23 |        9
HSD|    max|  23 - 24 |       16
HSD|    max|  24 - 25 |        8
HSD|    max|  25 - 26 |        3
HSD|    max|  26 - 27 |        3
HSD|    max|  27 - 28 |        4
HSD|    max|  28 - 29 |        2
HSD|    max|  29 - 30 |        2
HSD|    max|  30 - 31 |        1
HSD|    max|  32 - 33 |        1
HSD|    max|  36 - 37 |        1
HSD|    max|  41 - 42 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|       119|      0.000|      0.000
HSS|    avg|   1199580|      0.076|      0.869
HSS|    max|       119|     21.387|      4.223
---|------------|------------|------------|--------|-------------------------
RTS|       0.009|       0.513|      41.731|       0|    00:02:00/00:02:00

Thu Jan  1 00:03:05 UTC 1970
running: ./run -- -sh -T 120 -t1 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel periodic task
== All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -0.869|      -0.846|      12.858|       0|      -0.869|      12.858
RTD|      -0.857|      -0.822|      29.857|       0|      -0.869|      29.857
RTD|      -0.857|      -0.817|      12.626|       0|      -0.869|      29.857
RTD|      -0.857|      -0.824|      14.368|       0|      -0.869|      29.857
RTD|      -0.857|      -0.823|      14.339|       0|      -0.869|      29.857
RTD|      -0.857|      -0.826|      27.702|       0|      -0.869|      29.857
RTD|      -0.857|      -0.823|      10.009|       0|      -0.869|      29.857
RTD|      -0.857|      -0.824|      24.702|       0|      -0.869|      29.857
RTD|      -0.857|      -0.823|      12.811|       0|      -0.869|      29.857
RTD|      -0.857|      -0.825|      14.213|       0|      -0.869|      29.857
RTD|      -0.858|      -0.823|      11.934|       0|      -0.869|      29.857
RTD|      -0.857|      -0.824|      10.478|       0|      -0.869|      29.857
RTD|      -0.857|      -0.821|      12.340|       0|      -0.869|      29.857
RTD|      -0.857|      -0.829|      11.900|       0|      -0.869|      29.857
RTD|      -0.857|      -0.824|      12.579|       0|      -0.869|      29.857
RTD|      -0.857|      -0.719|      12.653|       0|      -0.869|      29.857
RTD|      -0.857|      -0.671|      11.461|       0|      -0.869|      29.857
RTD|      -0.857|      -0.679|      12.792|       0|      -0.869|      29.857
RTD|      -0.857|      -0.783|      12.864|       0|      -0.869|      29.857
RTD|      -0.862|      -0.788|      14.282|       0|      -0.869|      29.857
RTD|      -1.035|      -0.818|      13.404|       0|      -1.035|      29.857
RTT|  00:00:22  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -1.236|      -0.787|      13.243|       0|      -1.236|      29.857
RTD|      -1.187|      -0.787|      12.511|       0|      -1.236|      29.857
RTD|      -1.138|      -0.822|      13.002|       0|      -1.236|      29.857
RTD|      -0.865|      -0.812|      15.347|       0|      -1.236|      29.857
RTD|      -0.862|      -0.816|      12.962|       0|      -1.236|      29.857
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTT|  00:00:43  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTT|  00:01:04  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTT|  00:01:25  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTT|  00:01:46  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
RTD|         inf|         inf|         inf|       0|         inf|         inf
---|--param|----range-|--samples
HSD|    min|   0 -  1 |      108
HSD|    min|   1 -  2 |       11
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |  1191956
HSD|    avg|   1 -  2 |     2653
HSD|    avg|   2 -  3 |      635
HSD|    avg|   3 -  4 |      590
HSD|    avg|   4 -  5 |      565
HSD|    avg|   5 -  6 |      531
HSD|    avg|   6 -  7 |      504
HSD|    avg|   7 -  8 |      461
HSD|    avg|   8 -  9 |      436
HSD|    avg|   9 - 10 |      339
HSD|    avg|  10 - 11 |      275
HSD|    avg|  11 - 12 |      203
HSD|    avg|  12 - 13 |      211
HSD|    avg|  13 - 14 |      121
HSD|    avg|  14 - 15 |       96
HSD|    avg|  15 - 16 |       67
HSD|    avg|  16 - 17 |       37
HSD|    avg|  17 - 18 |       25
HSD|    avg|  18 - 19 |       30
HSD|    avg|  19 - 20 |       23
HSD|    avg|  20 - 21 |       18
HSD|    avg|  21 - 22 |       14
HSD|    avg|  22 - 23 |       10
HSD|    avg|  23 - 24 |       11
HSD|    avg|  24 - 25 |        7
HSD|    avg|  25 - 26 |        6
HSD|    avg|  26 - 27 |        2
HSD|    avg|  27 - 28 |        1
HSD|    avg|  28 - 29 |        1
HSD|    avg|  29 - 30 |        2
---|--param|----range-|--samples
HSD|    max|  10 - 11 |        4
HSD|    max|  11 - 12 |        4
HSD|    max|  12 - 13 |       13
HSD|    max|  13 - 14 |       12
HSD|    max|  14 - 15 |       19
HSD|    max|  15 - 16 |       25
HSD|    max|  16 - 17 |        9
HSD|    max|  17 - 18 |        7
HSD|    max|  18 - 19 |        5
HSD|    max|  19 - 20 |        4
HSD|    max|  20 - 21 |        2
HSD|    max|  21 - 22 |        5
HSD|    max|  22 - 23 |        1
HSD|    max|  23 - 24 |        2
HSD|    max|  24 - 25 |        1
HSD|    max|  25 - 26 |        2
HSD|    max|  26 - 27 |        1
HSD|    max|  27 - 28 |        1
HSD|    max|  29 - 30 |        2
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|       119|      0.092|      0.291
HSS|    avg|   1199830|      0.032|      0.529
HSS|    max|       119|     15.664|      3.891
---|------------|------------|------------|--------|-------------------------
RTS|      -1.251|      -0.780|      29.857|       0|    00:02:00/00:02:00

Thu Jan  1 00:05:06 UTC 1970
running: ./run -- -sh -T 120 -t2 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel timer handler
== All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -2.290|      -2.267|       0.400|       0|      -2.290|       0.400
RTD|      -2.290|      -2.264|       2.275|       0|      -2.290|       2.275
RTD|      -2.290|      -2.262|       3.696|       0|      -2.290|       3.696
RTD|      -2.290|      -2.263|       3.006|       0|      -2.290|       3.696
RTD|      -2.290|      -2.260|       2.665|       0|      -2.290|       3.696
RTD|      -2.290|      -2.264|       1.715|       0|      -2.290|       3.696
RTD|      -2.290|      -2.264|       1.711|       0|      -2.290|       3.696
RTD|      -2.290|      -2.264|       1.076|       0|      -2.290|       3.696
RTD|      -2.290|      -2.263|       1.513|       0|      -2.290|       3.696
RTD|      -2.290|      -2.263|       1.803|       0|      -2.290|       3.696
RTD|      -2.290|      -2.265|       1.787|       0|      -2.290|       3.696
RTD|      -2.290|      -2.262|       1.636|       0|      -2.290|       3.696
RTD|      -2.290|      -2.262|       2.394|       0|      -2.290|       3.696
RTD|      -2.290|      -2.264|       1.753|       0|      -2.290|       3.696
RTD|      -2.290|      -2.263|       2.001|       0|      -2.290|       3.696
RTD|      -2.290|      -2.265|       1.740|       0|      -2.290|       3.696
RTD|      -2.290|      -2.259|       3.275|       0|      -2.290|       3.696
RTD|      -2.292|      -2.137|      13.045|       0|      -2.292|      13.045
RTD|      -2.292|      -1.686|      15.122|       0|      -2.292|      15.122
RTD|      -2.290|      -2.130|      17.956|       0|      -2.292|      17.956
RTD|      -2.290|      -2.262|       3.497|       0|      -2.292|      17.956
RTT|  00:00:22  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -2.290|      -2.263|       6.120|       0|      -2.292|      17.956
RTD|      -2.290|      -2.264|       2.267|       0|      -2.292|      17.956
RTD|      -2.290|      -2.262|       2.238|       0|      -2.292|      17.956
RTD|      -2.290|      -2.263|       1.419|       0|      -2.292|      17.956
RTD|      -2.290|      -2.264|       3.281|       0|      -2.292|      17.956
RTD|      -2.290|      -2.263|       1.360|       0|      -2.292|      17.956
RTD|      -2.290|      -2.254|       2.083|       0|      -2.292|      17.956
RTD|      -2.505|      -2.259|       2.739|       0|      -2.505|      17.956
RTD|      -2.679|      -2.224|       1.963|       0|      -2.679|      17.956
RTD|      -2.640|      -2.230|       2.754|       0|      -2.679|      17.956
RTD|      -2.553|      -2.261|       2.606|       0|      -2.679|      17.956
RTD|      -2.290|      -2.261|       9.097|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       1.600|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       2.225|       0|      -2.679|      17.956
RTD|      -2.290|      -2.266|       3.088|       0|      -2.679|      17.956
RTD|      -2.290|      -2.263|       1.580|       0|      -2.679|      17.956
RTD|      -2.290|      -2.263|       2.803|       0|      -2.679|      17.956
RTD|      -2.290|      -2.263|       1.110|       0|      -2.679|      17.956
RTD|      -2.290|      -2.265|       2.413|       0|      -2.679|      17.956
RTD|      -2.290|      -2.260|       3.967|       0|      -2.679|      17.956
RTD|      -2.290|      -2.142|      12.272|       0|      -2.679|      17.956
RTT|  00:00:43  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -2.290|      -1.588|      14.171|       0|      -2.679|      17.956
RTD|      -2.290|      -2.265|       3.028|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       1.453|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       1.736|       0|      -2.679|      17.956
RTD|      -2.290|      -2.263|       2.266|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       1.548|       0|      -2.679|      17.956
RTD|      -2.290|      -2.261|       1.922|       0|      -2.679|      17.956
RTD|      -2.290|      -2.261|       3.438|       0|      -2.679|      17.956
RTD|      -2.290|      -2.262|       2.690|       0|      -2.679|      17.956
RTD|      -2.290|      -2.263|       2.330|       0|      -2.679|      17.956
RTD|      -2.290|      -2.261|       2.162|       0|      -2.679|      17.956
RTD|      -2.290|      -2.246|       2.178|       0|      -2.679|      17.956
RTD|      -2.671|      -2.264|       2.881|       0|      -2.679|      17.956
RTD|      -2.638|      -2.209|       1.903|       0|      -2.679|      17.956
RTD|      -2.450|      -2.254|       4.027|       0|      -2.679|      17.956
RTD|      -2.290|      -2.267|       2.341|       0|      -2.679|      17.956
RTD|      -2.290|      -2.263|       2.954|       0|      -2.679|      17.956
RTD|      -2.290|      -2.263|       2.450|       0|      -2.679|      17.956
RTD|      -2.290|      -2.265|       2.480|       0|      -2.679|      17.956
RTD|      -2.290|      -2.266|       2.891|       0|      -2.679|      17.956
RTD|      -2.290|      -2.265|       2.182|       0|      -2.679|      17.956
RTT|  00:01:04  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -2.290|      -2.263|       2.118|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       2.559|       0|      -2.679|      17.956
RTD|      -2.290|      -2.268|       2.331|       0|      -2.679|      17.956
RTD|      -2.290|      -2.256|       4.411|       0|      -2.679|      17.956
RTD|      -2.290|      -2.262|       8.165|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       2.724|       0|      -2.679|      17.956
RTD|      -2.290|      -2.266|       3.309|       0|      -2.679|      17.956
RTD|      -2.290|      -2.266|       4.924|       0|      -2.679|      17.956
RTD|      -2.290|      -2.257|       2.788|       0|      -2.679|      17.956
RTD|      -2.290|      -2.263|       8.109|       0|      -2.679|      17.956
RTD|      -2.290|      -2.266|       2.923|       0|      -2.679|      17.956
RTD|      -2.290|      -2.260|       3.301|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       3.003|       0|      -2.679|      17.956
RTD|      -2.290|      -2.263|       2.724|       0|      -2.679|      17.956
RTD|      -2.290|      -2.265|       2.201|       0|      -2.679|      17.956
RTD|      -2.290|      -2.265|       1.995|       0|      -2.679|      17.956
RTD|      -2.290|      -2.266|       2.308|       0|      -2.679|      17.956
RTD|      -2.290|      -2.262|       2.694|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       2.593|       0|      -2.679|      17.956
RTD|      -2.290|      -2.266|       3.967|       0|      -2.679|      17.956
RTD|      -2.290|      -2.266|       2.458|       0|      -2.679|      17.956
RTT|  00:01:25  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -2.290|      -2.262|       2.105|       0|      -2.679|      17.956
RTD|      -2.290|      -2.265|       1.730|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       2.430|       0|      -2.679|      17.956
RTD|      -2.290|      -2.266|       4.353|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       2.782|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       3.215|       0|      -2.679|      17.956
RTD|      -2.290|      -2.265|       3.405|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       2.913|       0|      -2.679|      17.956
RTD|      -2.290|      -2.265|       0.825|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       2.261|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       3.570|       0|      -2.679|      17.956
RTD|      -2.290|      -2.269|       2.825|       0|      -2.679|      17.956
RTD|      -2.290|      -2.266|       2.330|       0|      -2.679|      17.956
RTD|      -2.290|      -2.263|       1.638|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       2.540|       0|      -2.679|      17.956
RTD|      -2.290|      -2.266|       2.308|       0|      -2.679|      17.956
RTD|      -2.290|      -2.266|       3.369|       0|      -2.679|      17.956
RTD|      -2.290|      -2.263|       2.806|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       1.867|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       2.666|       0|      -2.679|      17.956
RTD|      -2.290|      -2.268|       2.611|       0|      -2.679|      17.956
RTT|  00:01:46  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -2.290|      -2.265|       2.393|       0|      -2.679|      17.956
RTD|      -2.290|      -2.259|       2.259|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|      11.705|       0|      -2.679|      17.956
RTD|      -2.290|      -2.267|       4.020|       0|      -2.679|      17.956
RTD|      -2.290|      -2.266|       2.630|       0|      -2.679|      17.956
RTD|      -2.290|      -2.265|       2.437|       0|      -2.679|      17.956
RTD|      -2.290|      -2.259|       4.565|       0|      -2.679|      17.956
RTD|      -2.290|      -2.266|       9.315|       0|      -2.679|      17.956
RTD|      -2.290|      -2.267|       3.290|       0|      -2.679|      17.956
RTD|      -2.290|      -2.263|       2.394|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       2.345|       0|      -2.679|      17.956
RTD|      -2.290|      -2.265|       4.209|       0|      -2.679|      17.956
RTD|      -2.290|      -2.267|       4.088|       0|      -2.679|      17.956
RTD|      -2.290|      -2.264|       2.529|       0|      -2.679|      17.956
---|--param|----range-|--samples
HSD|    min|   2 -  3 |      119
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |     4243
HSD|    avg|   1 -  2 |     6714
HSD|    avg|   2 -  3 |  1188711
HSD|    avg|   3 -  4 |       81
HSD|    avg|   4 -  5 |       18
HSD|    avg|   5 -  6 |        5
HSD|    avg|   6 -  7 |        6
HSD|    avg|   7 -  8 |        9
HSD|    avg|   8 -  9 |        7
HSD|    avg|   9 - 10 |       10
HSD|    avg|  10 - 11 |        3
HSD|    avg|  11 - 12 |        5
HSD|    avg|  12 - 13 |        7
HSD|    avg|  13 - 14 |        8
HSD|    avg|  14 - 15 |        1
HSD|    avg|  15 - 16 |        1
HSD|    avg|  17 - 18 |        1
---|--param|----range-|--samples
HSD|    max|   0 -  1 |        2
HSD|    max|   1 -  2 |       24
HSD|    max|   2 -  3 |       56
HSD|    max|   3 -  4 |       18
HSD|    max|   4 -  5 |        8
HSD|    max|   6 -  7 |        1
HSD|    max|   8 -  9 |        2
HSD|    max|   9 - 10 |        2
HSD|    max|  11 - 12 |        1
HSD|    max|  12 - 13 |        1
HSD|    max|  13 - 14 |        1
HSD|    max|  14 - 15 |        1
HSD|    max|  15 - 16 |        1
HSD|    max|  17 - 18 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|       119|      2.000|      0.000
HSS|    avg|   1199830|      1.988|      0.152
HSS|    max|       119|      2.891|      2.931
---|------------|------------|------------|--------|-------------------------
RTS|      -2.679|      -2.248|      17.956|       0|    00:02:00/00:02:00

Thu Jan  1 00:07:08 UTC 1970
running: ./run -- -T 120 # switchtest
*
*
* Type ^C to stop this application.
*
*
== Testing FPU check routines...
r0: 1 != 2
r1: 1 != 2
r2: 1 != 2
r3: 1 != 2
r4: 1 != 2
r5: 1 != 2
r6: 1 != 2
r7: 1 != 2
r8: 1 != 2
r9: 1 != 2
r10: 1 != 2
r11: 1 != 2
r12: 1 != 2
r13: 1 != 2
r14: 1 != 2
r15: 1 != 2
r16: 1 != 2
r17: 1 != 2
r18: 1 != 2
r19: 1 != 2
r20: 1 != 2
r21: 1 != 2
r22: 1 != 2
r23: 1 != 2
r24: 1 != 2
r25: 1 != 2
r26: 1 != 2
r27: 1 != 2
r28: 1 != 2
r29: 1 != 2
r30: 1 != 2
r31: 1 != 2
== FPU check routines: OK.
== Threads: sleeper_ufps-0 rtk-1 rtk-2 rtk_fp-3 rtk_fp-4 rtk_fp_ufpp-5 rtk_fp_ufpp-6 rtup-7 rtup-8 rtup_ufpp-9 rtup_ufpp-10 rtus-11 rtus-12 rtus_ufps-13 rtus_ufps-14 rtuo-15 rtuo-16 rtuo_ufpp-17 rtuo_ufpp-18 rtuo_ufps-19 rtuo_ufps-20 rtuo_ufpp_ufps-21 rtuo_ufpp_ufps-22
r0: 1000 != 10
r1: 1000 != 10
r2: 1000 != 10
r3: 1000 != 10
r4: 1000 != 10
r5: 1000 != 10
r6: 1000 != 10
r7: 1000 != 10
r8: 1000 != 10
r9: 1000 != 10
r10: 1000 != 10
r11: 1000 != 10
r12: 1000 != 10
r13: 1000 != 10
r14: 1000 != 10
r15: 1000 != 10
r16: 1000 != 10
r17: 1000 != 10
r18: 1000 != 10
r19: 1000 != 10
r20: 1000 != 10
r21: 1000 != 10
r22: 1000 != 10
r23: 1000 != 10
r24: 1000 != 10
r25: 1000 != 10
r26: 1000 != 10
r27: 1000 != 10
r28: 1000 != 10
r29: 1000 != 10
r30: 1000 != 10
r31: 1000 != 10
Error after context switch from task 8(rtup-8) to task 10(rtup_ufpp-10),
FPU registers were set to 1000 (maybe task sleeper_ufps-0)
RTT|  00:00:00
RTH|ctx switches|-------total
RTD|          28|          28

Thu Jan  1 00:07:09 UTC 1970
running: ./run -- -h # switchbench
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|       4.942|       5.041|      21.485|           0
---|---range-|---samples
HSD| 4 - 5 |      55883
HSD| 5 - 6 |      41395
HSD| 6 - 7 |       2631
HSD| 7 - 8 |         17
HSD| 8 - 9 |         11
HSD| 9 - 10 |         13
HSD| 10 - 11 |         24
HSD| 11 - 12 |          5
HSD| 12 - 13 |          6
HSD| 13 - 14 |          3
HSD| 14 - 15 |          5
HSD| 15 - 16 |          1
HSD| 17 - 18 |          1
HSD| 21 - 22 |          1
HSS|     99996|      4.472|      0.576

Thu Jan  1 00:07:19 UTC 1970
running: ./run -- -p 10 -n -l 1000 # cyclictest
*
*
* Type ^C to stop this application.
*
*
1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:      14 Min:       0 Act:       0 Avg:       1 Max:      25
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:      30 Min:       0 Act:       0 Avg:       1 Max:      25
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:      46 Min:       0 Act:       0 Avg:       1 Max:      25
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:      62 Min:       0 Act:       0 Avg:       1 Max:      25
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:      78 Min:       0 Act:       0 Avg:       1 Max:      25
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:      94 Min:       0 Act:       0 Avg:       1 Max:      25
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     110 Min:       0 Act:       0 Avg:       1 Max:      25
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     126 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     142 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     158 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     174 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     190 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     206 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     222 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     238 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     254 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     270 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     286 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     302 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     318 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     334 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     350 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     366 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     382 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     398 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     414 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     430 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     446 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     462 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     478 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     494 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     510 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     526 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     542 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     558 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     574 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 3/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     590 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     606 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     622 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     638 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     654 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     670 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     686 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     702 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     718 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     734 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     750 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     766 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     782 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     798 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     814 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     830 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     846 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     862 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     878 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     894 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     910 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     926 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     942 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     958 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     974 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/38 1845          

T: 0 ( 1845) P:10 I:    1000 C:     990 Min:       0 Act:       0 Avg:       1 Max:      34
[3A1.08 0.75 0.34 2/37 1845          

T: 0 ( 1845) P:10 I:    1000 C:    1000 Min:       0 Act:       0 Avg:       1 Max:      34

Thu Jan  1 00:07:22 UTC 1970
running: cat /proc/interrupts
           CPU0       
 16:        587   UIC   Edge      serial
 20:          0   UIC   Level     musbhsfc_udc
 21:      22623   UIC   Edge      MAL TX EOB
 22:      33717   UIC   Edge      MAL RX EOB
 23:          0   UIC   Edge      MAL SERR
 24:          0   UIC   Edge      MAL TX DE
 25:          0   UIC   Edge      MAL RX DE
 26:          0   UIC   Edge      EMAC
 28:          0   UIC   Edge      UIC cascade
 30:          0   UIC   Edge      UIC cascade
 32:          0   UIC   Edge      ehci_hcd:usb1
 33:          0   UIC   Edge      IBM IIC
 34:          0   UIC   Edge      IBM IIC
BAD:          0

Thu Jan  1 00:07:22 UTC 1970
running: cat /proc/loadavg
1.08 0.75 0.34 2/33 1857

Thu Jan  1 00:07:22 UTC 1970
running: cat /proc/meminfo
MemTotal:       256208 kB
MemFree:        234164 kB
Buffers:             0 kB
Cached:          15460 kB
SwapCached:          0 kB
Active:           9240 kB
Inactive:         8712 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:              40 kB
Writeback:           0 kB
AnonPages:        2504 kB
Mapped:           2188 kB
Slab:             2508 kB
SReclaimable:      564 kB
SUnreclaim:       1944 kB
PageTables:        328 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:    128104 kB
Committed_AS:     6192 kB
VmallocTotal:   736248 kB
VmallocUsed:     66044 kB
VmallocChunk:   670196 kB

Thu Jan  1 00:07:22 UTC 1970
running: cat /proc/xenomai/affinity
00000001

Thu Jan  1 00:07:22 UTC 1970
running: cat /proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:          413    (lostage_handler)
  2:            6    (registry_export)
  3:            0    (posix_signals_handler)

Thu Jan  1 00:07:22 UTC 1970
running: cat /proc/xenomai/faults
TRAP         CPU0
  0:           14    (Data or instruction access)
  1:            0    (Alignment)
  2:            0    (Altivec unavailable)
  3:            0    (Program check exception)
  4:            0    (Machine check exception)
  5:            0    (Unknown)
  6:            0    (Instruction breakpoint)
  7:            0    (Run mode exception)
  8:            0    (Single-step exception)
  9:            0    (Non-recoverable exception)
 10:            0    (Software emulation)
 11:            0    (Debug)
 12:            0    (SPE)
 13:            0    (Altivec assist)
 14:            0    (Cache-locking exception)
 15:            0    (Kernel FP unavailable)

Thu Jan  1 00:07:22 UTC 1970
running: cat /proc/xenomai/hal
2.0-03

Thu Jan  1 00:07:22 UTC 1970
running: cat /proc/xenomai/heap
size=129536:used=54048:pagesz=512

Thu Jan  1 00:07:22 UTC 1970
running: cat /proc/xenomai/irq
IRQ         CPU0
512:     5566633         [virtual]
515:         515         [virtual]

Thu Jan  1 00:07:22 UTC 1970
running: cat /proc/xenomai/latency
3000

Thu Jan  1 00:07:22 UTC 1970
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT

Thu Jan  1 00:07:22 UTC 1970
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          2520737    0     00500080   94.9  ROOT
  0  0      0          5567067    0     00000000    2.2  IRQ512: [timer]

Thu Jan  1 00:07:22 UTC 1970
running: cat /proc/xenomai/timebases
NAME       RESOLUTION     JIFFIES   STATUS
master              1         n/a   enabled,set
psos          1000000      442732   disabled,unset,isolated
vrtx          1000000      442732   disabled,unset,isolated
vxworks       1000000      442732   disabled,unset,isolated
uitron        1000000      442732   disabled,unset,isolated

Thu Jan  1 00:07:22 UTC 1970
running: cat /proc/xenomai/timer
status=on:setup=1:clock=236258322751:timerdev=decrementer:clockdev=timebase

Thu Jan  1 00:07:23 UTC 1970
running: cat /proc/xenomai/version
2.4-rc7

Thu Jan  1 00:07:23 UTC 1970
running: cat /proc/xenomai/interfaces/native
0

Thu Jan  1 00:07:23 UTC 1970
running: cat /proc/xenomai/interfaces/posix
0

Thu Jan  1 00:07:23 UTC 1970
running: cat /proc/xenomai/interfaces/psos
0

Thu Jan  1 00:07:23 UTC 1970
running: cat /proc/xenomai/interfaces/rtai
0

Thu Jan  1 00:07:23 UTC 1970
running: cat /proc/xenomai/interfaces/rtdm
0

Thu Jan  1 00:07:23 UTC 1970
running: cat /proc/xenomai/interfaces/sys
0

Thu Jan  1 00:07:23 UTC 1970
running: cat /proc/xenomai/interfaces/uitron
0

Thu Jan  1 00:07:23 UTC 1970
running: cat /proc/xenomai/interfaces/vrtx
0

Thu Jan  1 00:07:23 UTC 1970
running: cat /proc/xenomai/interfaces/vxworks
0

Thu Jan  1 00:07:23 UTC 1970
running: cat /proc/xenomai/rtdm/fildes
total=128:open=0:free=128

Thu Jan  1 00:07:23 UTC 1970
running: cat /proc/xenomai/rtdm/named_devices
Hash	Name				Driver		/proc

Thu Jan  1 00:07:23 UTC 1970
running: cat /proc/xenomai/rtdm/open_fildes
Index	Locked	Device		Owner [PID]

Thu Jan  1 00:07:23 UTC 1970
running: cat /proc/xenomai/rtdm/protocol_devices
Hash	ProtocolFamily:SocketType	Driver		/proc

Thu Jan  1 00:07:23 UTC 1970
running: cat /proc/xenomai/timerstat/master
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           
0    110816      110815      3201786    4000000    NULL         [host-timer]   
0    443261      443260      118805     1000000    xntimer_tic  psos           
0    443261      443260      246180     1000000    xntimer_tic  vrtx           
0    443261      443260      398769     1000000    xntimer_tic  vxworks        
0    443261      443260      429969     1000000    xntimer_tic  uitron         

Thu Jan  1 00:07:23 UTC 1970
running: cat /proc/xenomai/timerstat/psos
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           

Thu Jan  1 00:07:23 UTC 1970
running: cat /proc/xenomai/timerstat/uitron
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           

Thu Jan  1 00:07:23 UTC 1970
running: cat /proc/xenomai/timerstat/vrtx
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           

Thu Jan  1 00:07:23 UTC 1970
running: cat /proc/xenomai/timerstat/vxworks
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           

Thu Jan  1 00:07:23 UTC 1970
running: top -bn1c
top - 00:07:24 up 7 min,  2 users,  load average: 1.08, 0.75, 0.34
Tasks:  35 total,   2 running,  33 sleeping,   0 stopped,   0 zombie
Cpu(s): 33.3% us, 55.6% sy,  0.0% ni,  9.8% id,  1.2% wa,  0.0% hi,  0.1% si
Mem:    256208k total,    22396k used,   233812k free,        0k buffers
Swap:        0k total,        0k used,        0k free,    15476k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
 1121 root      20   0  1648  424  344 R 92.5  0.2   6:16.66 dd if /dev/zero of 
 1955 root      20   0  2656 1068  852 R  3.7  0.4   0:00.04 top -bn1c          
    1 root      20   0  1644  572  500 S  0.0  0.2   0:06.74 init [3]           
 1121 ttyp0    00:06:16 dd
xeno-test: finished

--Boundary-00=_r1cWHtcXvaBSi8M--

