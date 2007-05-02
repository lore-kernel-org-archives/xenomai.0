Message-ID: <46384A09.7000408@domain.hid>
Date: Wed, 02 May 2007 10:21:29 +0200
From: "CHABAL David" <david.chabal@domain.hid>
MIME-Version: 1.0
References: <bJZU8yAy.1178088859.4958920.dchabal@domain.hid>
	<46383422.50007@domain.hid>
In-Reply-To: <46383422.50007@domain.hid>
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai unstable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
Jan Kiszka a &eacute;crit&nbsp;:
<blockquote cite="mid46383422.50007@domain.hid" type="cite">
  <pre wrap="">CHABAL David wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hello everybody,

I have a problem of stability with Xenomai.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Well, you are running the unstable version of Xenomai, what do you
expect? ;)

  </pre>
</blockquote>
I hope to be lucky sometimes :-)<br>
<br>
<blockquote cite="mid46383422.50007@domain.hid" type="cite">
  <pre wrap="">There are two patches pending for x86_64. One is here [1], I think the
other is not yet publicly available, there is only an i386 version [2].
The latter could bite you if CONFIG_PCI_MSI is on. Is it? Your .config
may help us.

  </pre>
</blockquote>
CONFIG_PCI_MSI is not set. My .config is included in my first mail, I
post it again at the end of this mail.<br>
<blockquote cite="mid46383422.50007@domain.hid" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">When I run the program xenomai/examples/rtdm/profiles/serial/cross-link,
the first execution is correct, I quit with Ctrl-C, I launch again
and... my PC is frozen.

I have this behavior with my own dev and other binaries of the Xeno
distrib.
The PC either freeze or reboot.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
If above doesn't help, you could try to catch the last words of your box
via serial console.

  </pre>
</blockquote>
I will test it and the patch [1] this afternoon.<br>
<blockquote cite="mid46383422.50007@domain.hid" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">My box is a HP dc7700 with a Pentium D (dual core) 3.4Ghz.

I use the Mandriva free 2007.0 (64 bits) patched with:
- adeos-ipipe-2.6.20-x86_64-1.0-06.patch
and
- a version of Xenomai checkouted from the trunk, revision 2381 (because
the 2.3.1 doesn't support the x86_64 arch in prepare-kernel.sh).

I boot with the "noapic" option, otherwise the Linux kernel doesn't
boot (dark screen, common problem with the dc7700). A Moxa PCI card with
    </pre>
  </blockquote>
  <pre wrap=""><!---->
common == also with vanilla Linux?

  </pre>
</blockquote>
Yes<br>
<br>
<span class="Text">"[dc7700 desktops] don't run Redhat RHEL4,
RHEL5beta2, Fedora Core 6, Fedora Core 5, Fedora Core 4, Ubuntu 6.10,
... "</span><br>
extracted from:<br>
<a class="moz-txt-link-freetext" href="http://forums1.itrc.hp.com/service/forums/questionanswer.do?threadId=1081719&admit=-682735245+1178090444287+28353475">http://forums1.itrc.hp.com/service/forums/questionanswer.do?threadId=1081719&amp;admit=-682735245+1178090444287+28353475</a><br>
<br>
It was very hard to install Linux on.<br>
<br>
<blockquote cite="mid46383422.50007@domain.hid" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">8 serial ports is also installed.

I've tried a lot of things with my .config:
- compiling for generic x86_64
- enable/disable HPET/MTRR/Nucleus Debug support
- fire the SMP support but the box doesn't boot anymore
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I.e. !CONFIG_SMP doesn't boot at all when CONFIG_IPIPE is enabled? Same
here: try the patch and !CONFIG_PCI_MSI, then catch the console output.

Thanks for reporting!
Jan

[1] <a class="moz-txt-link-freetext" href="https://mail.gna.org/public/adeos-main/2007-04/msg00075.html">https://mail.gna.org/public/adeos-main/2007-04/msg00075.html</a>
[2] <a class="moz-txt-link-freetext" href="https://mail.gna.org/public/xenomai-help/2007-04/msg00213.html">https://mail.gna.org/public/xenomai-help/2007-04/msg00213.html</a>

  </pre>
</blockquote>
#<br>
# Automatically generated make config: don't edit<br>
# Linux kernel version: 2.6.20.6<br>
# Mon Apr 30 17:49:55 2007<br>
#<br>
CONFIG_X86_64=y<br>
CONFIG_64BIT=y<br>
CONFIG_X86=y<br>
CONFIG_ZONE_DMA32=y<br>
CONFIG_LOCKDEP_SUPPORT=y<br>
CONFIG_STACKTRACE_SUPPORT=y<br>
CONFIG_SEMAPHORE_SLEEPERS=y<br>
CONFIG_MMU=y<br>
CONFIG_RWSEM_GENERIC_SPINLOCK=y<br>
CONFIG_GENERIC_HWEIGHT=y<br>
CONFIG_GENERIC_CALIBRATE_DELAY=y<br>
CONFIG_X86_CMPXCHG=y<br>
CONFIG_EARLY_PRINTK=y<br>
CONFIG_GENERIC_ISA_DMA=y<br>
CONFIG_GENERIC_IOMAP=y<br>
CONFIG_ARCH_MAY_HAVE_PC_FDC=y<br>
CONFIG_ARCH_POPULATES_NODE_MAP=y<br>
CONFIG_DMI=y<br>
CONFIG_AUDIT_ARCH=y<br>
CONFIG_GENERIC_BUG=y<br>
# CONFIG_ARCH_HAS_ILOG2_U32 is not set<br>
# CONFIG_ARCH_HAS_ILOG2_U64 is not set<br>
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"<br>
<br>
#<br>
# Code maturity level options<br>
#<br>
CONFIG_EXPERIMENTAL=y<br>
CONFIG_LOCK_KERNEL=y<br>
CONFIG_INIT_ENV_ARG_LIMIT=32<br>
<br>
#<br>
# General setup<br>
#<br>
CONFIG_LOCALVERSION=""<br>
# CONFIG_LOCALVERSION_AUTO is not set<br>
CONFIG_SWAP=y<br>
CONFIG_SYSVIPC=y<br>
# CONFIG_IPC_NS is not set<br>
CONFIG_POSIX_MQUEUE=y<br>
CONFIG_BSD_PROCESS_ACCT=y<br>
CONFIG_BSD_PROCESS_ACCT_V3=y<br>
# CONFIG_TASKSTATS is not set<br>
# CONFIG_UTS_NS is not set<br>
CONFIG_AUDIT=y<br>
CONFIG_AUDITSYSCALL=y<br>
CONFIG_IKCONFIG=y<br>
CONFIG_IKCONFIG_PROC=y<br>
# CONFIG_CPUSETS is not set<br>
CONFIG_SYSFS_DEPRECATED=y<br>
CONFIG_RELAY=y<br>
CONFIG_INITRAMFS_SOURCE=""<br>
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set<br>
CONFIG_SYSCTL=y<br>
CONFIG_EMBEDDED=y<br>
CONFIG_UID16=y<br>
CONFIG_SYSCTL_SYSCALL=y<br>
CONFIG_KALLSYMS=y<br>
# CONFIG_KALLSYMS_ALL is not set<br>
CONFIG_KALLSYMS_EXTRA_PASS=y<br>
CONFIG_HOTPLUG=y<br>
CONFIG_PRINTK=y<br>
CONFIG_BUG=y<br>
CONFIG_ELF_CORE=y<br>
CONFIG_BASE_FULL=y<br>
CONFIG_FUTEX=y<br>
CONFIG_EPOLL=y<br>
CONFIG_SHMEM=y<br>
CONFIG_SLAB=y<br>
CONFIG_VM_EVENT_COUNTERS=y<br>
CONFIG_RT_MUTEXES=y<br>
# CONFIG_TINY_SHMEM is not set<br>
CONFIG_BASE_SMALL=0<br>
# CONFIG_SLOB is not set<br>
<br>
#<br>
# Loadable module support<br>
#<br>
CONFIG_MODULES=y<br>
CONFIG_MODULE_UNLOAD=y<br>
CONFIG_MODULE_FORCE_UNLOAD=y<br>
# CONFIG_MODVERSIONS is not set<br>
# CONFIG_MODULE_SRCVERSION_ALL is not set<br>
CONFIG_KMOD=y<br>
CONFIG_STOP_MACHINE=y<br>
<br>
#<br>
# Block layer<br>
#<br>
CONFIG_BLOCK=y<br>
CONFIG_BLK_DEV_IO_TRACE=y<br>
<br>
#<br>
# IO Schedulers<br>
#<br>
CONFIG_IOSCHED_NOOP=y<br>
CONFIG_IOSCHED_AS=y<br>
CONFIG_IOSCHED_DEADLINE=y<br>
CONFIG_IOSCHED_CFQ=y<br>
CONFIG_DEFAULT_AS=y<br>
# CONFIG_DEFAULT_DEADLINE is not set<br>
# CONFIG_DEFAULT_CFQ is not set<br>
# CONFIG_DEFAULT_NOOP is not set<br>
CONFIG_DEFAULT_IOSCHED="anticipatory"<br>
<br>
#<br>
# Real-time sub-system<br>
#<br>
CONFIG_XENOMAI=y<br>
CONFIG_XENO_OPT_NUCLEUS=y<br>
CONFIG_XENO_OPT_PERVASIVE=y<br>
# CONFIG_XENO_OPT_ISHIELD is not set<br>
CONFIG_XENO_OPT_PRIOCPL=y<br>
# CONFIG_XENO_OPT_SECURITY_ACCESS is not set<br>
CONFIG_XENO_OPT_PIPELINE_HEAD=y<br>
CONFIG_XENO_OPT_PIPE=y<br>
CONFIG_XENO_OPT_PIPE_NRDEV=32<br>
CONFIG_XENO_OPT_REGISTRY=y<br>
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512<br>
CONFIG_XENO_OPT_SYS_HEAPSZ=2048<br>
CONFIG_XENO_OPT_STATS=y<br>
CONFIG_XENO_OPT_DEBUG=y<br>
CONFIG_XENO_OPT_DEBUG_NUCLEUS=y<br>
# CONFIG_XENO_OPT_DEBUG_QUEUES is not set<br>
CONFIG_XENO_OPT_WATCHDOG=y<br>
<br>
#<br>
# Timing<br>
#<br>
CONFIG_XENO_OPT_TIMING_PERIODIC=y<br>
CONFIG_XENO_OPT_TIMING_TIMERLAT=0<br>
CONFIG_XENO_OPT_TIMING_SCHEDLAT=0<br>
<br>
#<br>
# Scalability<br>
#<br>
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set<br>
CONFIG_XENO_OPT_TIMER_LIST=y<br>
# CONFIG_XENO_OPT_TIMER_HEAP is not set<br>
# CONFIG_XENO_OPT_TIMER_WHEEL is not set<br>
<br>
#<br>
# Shared interrupts<br>
#<br>
CONFIG_XENO_OPT_SHIRQ_LEVEL=y<br>
CONFIG_XENO_OPT_SHIRQ_EDGE=y<br>
<br>
#<br>
# Machine<br>
#<br>
CONFIG_XENO_HW_FPU=y<br>
<br>
#<br>
# SMI workaround<br>
#<br>
# CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set<br>
CONFIG_XENO_HW_SMI_DETECT=y<br>
CONFIG_XENO_HW_SMI_WORKAROUND=y<br>
CONFIG_XENO_HW_SMI_ALL=y<br>
<br>
#<br>
# Interfaces<br>
#<br>
CONFIG_XENO_SKIN_NATIVE=y<br>
CONFIG_XENO_OPT_NATIVE_PERIOD=0<br>
CONFIG_XENO_OPT_NATIVE_PIPE=y<br>
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=4096<br>
CONFIG_XENO_OPT_NATIVE_REGISTRY=y<br>
CONFIG_XENO_OPT_NATIVE_SEM=y<br>
CONFIG_XENO_OPT_NATIVE_EVENT=y<br>
CONFIG_XENO_OPT_NATIVE_MUTEX=y<br>
CONFIG_XENO_OPT_NATIVE_COND=y<br>
CONFIG_XENO_OPT_NATIVE_QUEUE=y<br>
CONFIG_XENO_OPT_NATIVE_HEAP=y<br>
CONFIG_XENO_OPT_NATIVE_ALARM=y<br>
CONFIG_XENO_OPT_NATIVE_MPS=y<br>
# CONFIG_XENO_OPT_NATIVE_INTR is not set<br>
CONFIG_XENO_OPT_DEBUG_NATIVE=y<br>
CONFIG_XENO_SKIN_POSIX=y<br>
CONFIG_XENO_OPT_POSIX_PERIOD=0<br>
# CONFIG_XENO_OPT_POSIX_SHM is not set<br>
# CONFIG_XENO_OPT_POSIX_INTR is not set<br>
CONFIG_XENO_OPT_DEBUG_POSIX=y<br>
# CONFIG_XENO_SKIN_PSOS is not set<br>
# CONFIG_XENO_SKIN_UITRON is not set<br>
# CONFIG_XENO_SKIN_VRTX is not set<br>
# CONFIG_XENO_SKIN_VXWORKS is not set<br>
# CONFIG_XENO_SKIN_RTAI is not set<br>
CONFIG_XENO_SKIN_RTDM=y<br>
CONFIG_XENO_OPT_RTDM_PERIOD=0<br>
CONFIG_XENO_OPT_RTDM_FILDES=128<br>
CONFIG_XENO_OPT_DEBUG_RTDM=y<br>
<br>
#<br>
# Drivers<br>
#<br>
<br>
#<br>
# Serial drivers<br>
#<br>
CONFIG_XENO_DRIVERS_16550A=y<br>
# CONFIG_XENO_DRIVERS_16550A_PIO is not set<br>
# CONFIG_XENO_DRIVERS_16550A_MMIO is not set<br>
CONFIG_XENO_DRIVERS_16550A_ANY=y<br>
<br>
#<br>
# Testing drivers<br>
#<br>
CONFIG_XENO_DRIVERS_TIMERBENCH=y<br>
CONFIG_XENO_DRIVERS_IRQBENCH=y<br>
CONFIG_XENO_DRIVERS_SWITCHTEST=y<br>
<br>
#<br>
# CAN drivers<br>
#<br>
# CONFIG_XENO_DRIVERS_CAN is not set<br>
<br>
#<br>
# Processor type and features<br>
#<br>
CONFIG_X86_PC=y<br>
# CONFIG_X86_VSMP is not set<br>
# CONFIG_MK8 is not set<br>
# CONFIG_MPSC is not set<br>
CONFIG_MCORE2=y<br>
# CONFIG_GENERIC_CPU is not set<br>
CONFIG_X86_L1_CACHE_BYTES=64<br>
CONFIG_X86_L1_CACHE_SHIFT=6<br>
CONFIG_X86_INTERNODE_CACHE_BYTES=64<br>
CONFIG_X86_TSC=y<br>
CONFIG_X86_GOOD_APIC=y<br>
CONFIG_MICROCODE=m<br>
CONFIG_MICROCODE_OLD_INTERFACE=y<br>
CONFIG_X86_MSR=m<br>
CONFIG_X86_CPUID=m<br>
CONFIG_X86_HT=y<br>
CONFIG_X86_IO_APIC=y<br>
CONFIG_X86_LOCAL_APIC=y<br>
CONFIG_MTRR=y<br>
CONFIG_SMP=y<br>
# CONFIG_SCHED_SMT is not set<br>
CONFIG_SCHED_MC=y<br>
# CONFIG_PREEMPT_NONE is not set<br>
# CONFIG_PREEMPT_VOLUNTARY is not set<br>
CONFIG_PREEMPT=y<br>
CONFIG_PREEMPT_BKL=y<br>
CONFIG_IPIPE=y<br>
# CONFIG_NUMA is not set<br>
CONFIG_ARCH_SPARSEMEM_ENABLE=y<br>
CONFIG_ARCH_FLATMEM_ENABLE=y<br>
CONFIG_SELECT_MEMORY_MODEL=y<br>
CONFIG_FLATMEM_MANUAL=y<br>
# CONFIG_DISCONTIGMEM_MANUAL is not set<br>
# CONFIG_SPARSEMEM_MANUAL is not set<br>
CONFIG_FLATMEM=y<br>
CONFIG_FLAT_NODE_MEM_MAP=y<br>
# CONFIG_SPARSEMEM_STATIC is not set<br>
CONFIG_SPLIT_PTLOCK_CPUS=4<br>
CONFIG_RESOURCES_64BIT=y<br>
CONFIG_NR_CPUS=2<br>
# CONFIG_HOTPLUG_CPU is not set<br>
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y<br>
CONFIG_HPET_TIMER=y<br>
CONFIG_HPET_EMULATE_RTC=y<br>
CONFIG_IOMMU=y<br>
# CONFIG_CALGARY_IOMMU is not set<br>
CONFIG_SWIOTLB=y<br>
CONFIG_X86_MCE=y<br>
CONFIG_X86_MCE_INTEL=y<br>
# CONFIG_X86_MCE_AMD is not set<br>
CONFIG_KEXEC=y<br>
CONFIG_CRASH_DUMP=y<br>
CONFIG_PHYSICAL_START=0x100000<br>
CONFIG_SECCOMP=y<br>
# CONFIG_CC_STACKPROTECTOR is not set<br>
# CONFIG_HZ_100 is not set<br>
CONFIG_HZ_250=y<br>
# CONFIG_HZ_300 is not set<br>
# CONFIG_HZ_1000 is not set<br>
CONFIG_HZ=250<br>
# CONFIG_REORDER is not set<br>
CONFIG_K8_NB=y<br>
CONFIG_GENERIC_HARDIRQS=y<br>
CONFIG_GENERIC_IRQ_PROBE=y<br>
CONFIG_ISA_DMA_API=y<br>
CONFIG_GENERIC_PENDING_IRQ=y<br>
<br>
#<br>
# Power management options<br>
#<br>
# CONFIG_PM is not set<br>
<br>
#<br>
# ACPI (Advanced Configuration and Power Interface) Support<br>
#<br>
<br>
#<br>
# CPU Frequency scaling<br>
#<br>
# CONFIG_CPU_FREQ is not set<br>
<br>
#<br>
# Bus options (PCI etc.)<br>
#<br>
CONFIG_PCI=y<br>
CONFIG_PCI_DIRECT=y<br>
CONFIG_PCIEPORTBUS=y<br>
# CONFIG_PCI_MSI is not set<br>
# CONFIG_PCI_DEBUG is not set<br>
CONFIG_HT_IRQ=y<br>
<br>
#<br>
# PCCARD (PCMCIA/CardBus) support<br>
#<br>
# CONFIG_PCCARD is not set<br>
<br>
#<br>
# PCI Hotplug Support<br>
#<br>
# CONFIG_HOTPLUG_PCI is not set<br>
<br>
#<br>
# Executable file formats / Emulations<br>
#<br>
CONFIG_BINFMT_ELF=y<br>
CONFIG_BINFMT_MISC=m<br>
CONFIG_IA32_EMULATION=y<br>
CONFIG_IA32_AOUT=y<br>
CONFIG_COMPAT=y<br>
CONFIG_SYSVIPC_COMPAT=y<br>
<br>
#<br>
# Networking<br>
#<br>
CONFIG_NET=y<br>
<br>
#<br>
# Networking options<br>
#<br>
# CONFIG_NETDEBUG is not set<br>
CONFIG_PACKET=m<br>
CONFIG_PACKET_MMAP=y<br>
CONFIG_UNIX=y<br>
CONFIG_XFRM=y<br>
CONFIG_XFRM_USER=m<br>
# CONFIG_XFRM_SUB_POLICY is not set<br>
CONFIG_NET_KEY=m<br>
CONFIG_INET=y<br>
CONFIG_IP_MULTICAST=y<br>
CONFIG_IP_ADVANCED_ROUTER=y<br>
CONFIG_ASK_IP_FIB_HASH=y<br>
# CONFIG_IP_FIB_TRIE is not set<br>
CONFIG_IP_FIB_HASH=y<br>
CONFIG_IP_MULTIPLE_TABLES=y<br>
CONFIG_IP_ROUTE_MULTIPATH=y<br>
# CONFIG_IP_ROUTE_MULTIPATH_CACHED is not set<br>
CONFIG_IP_ROUTE_VERBOSE=y<br>
# CONFIG_IP_PNP is not set<br>
CONFIG_NET_IPIP=m<br>
CONFIG_NET_IPGRE=m<br>
CONFIG_NET_IPGRE_BROADCAST=y<br>
CONFIG_IP_MROUTE=y<br>
CONFIG_IP_PIMSM_V1=y<br>
CONFIG_IP_PIMSM_V2=y<br>
# CONFIG_ARPD is not set<br>
CONFIG_SYN_COOKIES=y<br>
CONFIG_INET_AH=m<br>
CONFIG_INET_ESP=m<br>
CONFIG_INET_IPCOMP=m<br>
CONFIG_INET_XFRM_TUNNEL=m<br>
CONFIG_INET_TUNNEL=m<br>
CONFIG_INET_XFRM_MODE_TRANSPORT=y<br>
CONFIG_INET_XFRM_MODE_TUNNEL=y<br>
CONFIG_INET_XFRM_MODE_BEET=y<br>
CONFIG_INET_DIAG=y<br>
CONFIG_INET_TCP_DIAG=y<br>
# CONFIG_TCP_CONG_ADVANCED is not set<br>
CONFIG_TCP_CONG_CUBIC=y<br>
CONFIG_DEFAULT_TCP_CONG="cubic"<br>
# CONFIG_TCP_MD5SIG is not set<br>
# CONFIG_IPV6 is not set<br>
# CONFIG_INET6_XFRM_TUNNEL is not set<br>
# CONFIG_INET6_TUNNEL is not set<br>
# CONFIG_NETWORK_SECMARK is not set<br>
# CONFIG_NETFILTER is not set<br>
<br>
#<br>
# DCCP Configuration (EXPERIMENTAL)<br>
#<br>
CONFIG_IP_DCCP=m<br>
CONFIG_INET_DCCP_DIAG=m<br>
CONFIG_IP_DCCP_ACKVEC=y<br>
<br>
#<br>
# DCCP CCIDs Configuration (EXPERIMENTAL)<br>
#<br>
CONFIG_IP_DCCP_CCID2=m<br>
# CONFIG_IP_DCCP_CCID2_DEBUG is not set<br>
CONFIG_IP_DCCP_CCID3=m<br>
CONFIG_IP_DCCP_TFRC_LIB=m<br>
# CONFIG_IP_DCCP_CCID3_DEBUG is not set<br>
CONFIG_IP_DCCP_CCID3_RTO=100<br>
<br>
#<br>
# DCCP Kernel Hacking<br>
#<br>
# CONFIG_IP_DCCP_DEBUG is not set<br>
<br>
#<br>
# SCTP Configuration (EXPERIMENTAL)<br>
#<br>
CONFIG_IP_SCTP=m<br>
# CONFIG_SCTP_DBG_MSG is not set<br>
# CONFIG_SCTP_DBG_OBJCNT is not set<br>
CONFIG_SCTP_HMAC_NONE=y<br>
# CONFIG_SCTP_HMAC_SHA1 is not set<br>
# CONFIG_SCTP_HMAC_MD5 is not set<br>
<br>
#<br>
# TIPC Configuration (EXPERIMENTAL)<br>
#<br>
# CONFIG_TIPC is not set<br>
# CONFIG_ATM is not set<br>
# CONFIG_BRIDGE is not set<br>
# CONFIG_VLAN_8021Q is not set<br>
# CONFIG_DECNET is not set<br>
# CONFIG_LLC2 is not set<br>
# CONFIG_IPX is not set<br>
# CONFIG_ATALK is not set<br>
# CONFIG_X25 is not set<br>
# CONFIG_LAPB is not set<br>
# CONFIG_ECONET is not set<br>
# CONFIG_WAN_ROUTER is not set<br>
<br>
#<br>
# QoS and/or fair queueing<br>
#<br>
# CONFIG_NET_SCHED is not set<br>
<br>
#<br>
# Network testing<br>
#<br>
# CONFIG_NET_PKTGEN is not set<br>
# CONFIG_HAMRADIO is not set<br>
# CONFIG_IRDA is not set<br>
# CONFIG_BT is not set<br>
# CONFIG_IEEE80211 is not set<br>
CONFIG_FIB_RULES=y<br>
<br>
#<br>
# Device Drivers<br>
#<br>
<br>
#<br>
# Generic Driver Options<br>
#<br>
# CONFIG_STANDALONE is not set<br>
CONFIG_PREVENT_FIRMWARE_BUILD=y<br>
CONFIG_FW_LOADER=y<br>
# CONFIG_DEBUG_DRIVER is not set<br>
# CONFIG_SYS_HYPERVISOR is not set<br>
<br>
#<br>
# Connector - unified userspace &lt;-&gt; kernelspace linker<br>
#<br>
CONFIG_CONNECTOR=m<br>
<br>
#<br>
# Memory Technology Devices (MTD)<br>
#<br>
CONFIG_MTD=m<br>
# CONFIG_MTD_DEBUG is not set<br>
CONFIG_MTD_CONCAT=m<br>
CONFIG_MTD_PARTITIONS=y<br>
CONFIG_MTD_REDBOOT_PARTS=m<br>
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1<br>
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set<br>
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set<br>
<br>
#<br>
# User Modules And Translation Layers<br>
#<br>
CONFIG_MTD_CHAR=m<br>
CONFIG_MTD_BLKDEVS=m<br>
CONFIG_MTD_BLOCK=m<br>
CONFIG_MTD_BLOCK_RO=m<br>
CONFIG_FTL=m<br>
CONFIG_NFTL=m<br>
# CONFIG_NFTL_RW is not set<br>
CONFIG_INFTL=m<br>
CONFIG_RFD_FTL=m<br>
# CONFIG_SSFDC is not set<br>
<br>
#<br>
# RAM/ROM/Flash chip drivers<br>
#<br>
CONFIG_MTD_CFI=m<br>
CONFIG_MTD_JEDECPROBE=m<br>
CONFIG_MTD_GEN_PROBE=m<br>
# CONFIG_MTD_CFI_ADV_OPTIONS is not set<br>
CONFIG_MTD_MAP_BANK_WIDTH_1=y<br>
CONFIG_MTD_MAP_BANK_WIDTH_2=y<br>
CONFIG_MTD_MAP_BANK_WIDTH_4=y<br>
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set<br>
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set<br>
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set<br>
CONFIG_MTD_CFI_I1=y<br>
CONFIG_MTD_CFI_I2=y<br>
# CONFIG_MTD_CFI_I4 is not set<br>
# CONFIG_MTD_CFI_I8 is not set<br>
CONFIG_MTD_CFI_INTELEXT=m<br>
CONFIG_MTD_CFI_AMDSTD=m<br>
CONFIG_MTD_CFI_STAA=m<br>
CONFIG_MTD_CFI_UTIL=m<br>
CONFIG_MTD_RAM=m<br>
# CONFIG_MTD_ROM is not set<br>
CONFIG_MTD_ABSENT=m<br>
# CONFIG_MTD_OBSOLETE_CHIPS is not set<br>
<br>
#<br>
# Mapping drivers for chip access<br>
#<br>
# CONFIG_MTD_COMPLEX_MAPPINGS is not set<br>
CONFIG_MTD_PHYSMAP=m<br>
CONFIG_MTD_PHYSMAP_START=0x8000000<br>
CONFIG_MTD_PHYSMAP_LEN=0x4000000<br>
CONFIG_MTD_PHYSMAP_BANKWIDTH=2<br>
CONFIG_MTD_PNC2000=m<br>
CONFIG_MTD_SC520CDP=m<br>
CONFIG_MTD_NETSC520=m<br>
CONFIG_MTD_TS5500=m<br>
CONFIG_MTD_AMD76XROM=m<br>
CONFIG_MTD_ICHXROM=m<br>
# CONFIG_MTD_ESB2ROM is not set<br>
# CONFIG_MTD_CK804XROM is not set<br>
CONFIG_MTD_SCB2_FLASH=m<br>
CONFIG_MTD_NETtel=m<br>
CONFIG_MTD_DILNETPC=m<br>
CONFIG_MTD_DILNETPC_BOOTSIZE=0x80000<br>
# CONFIG_MTD_L440GX is not set<br>
CONFIG_MTD_PLATRAM=m<br>
<br>
#<br>
# Self-contained MTD device drivers<br>
#<br>
CONFIG_MTD_PMC551=m<br>
# CONFIG_MTD_PMC551_BUGFIX is not set<br>
# CONFIG_MTD_PMC551_DEBUG is not set<br>
CONFIG_MTD_SLRAM=m<br>
CONFIG_MTD_PHRAM=m<br>
CONFIG_MTD_MTDRAM=m<br>
CONFIG_MTDRAM_TOTAL_SIZE=4096<br>
CONFIG_MTDRAM_ERASE_SIZE=128<br>
# CONFIG_MTD_BLOCK2MTD is not set<br>
<br>
#<br>
# Disk-On-Chip Device Drivers<br>
#<br>
CONFIG_MTD_DOC2000=m<br>
CONFIG_MTD_DOC2001=m<br>
CONFIG_MTD_DOC2001PLUS=m<br>
CONFIG_MTD_DOCPROBE=m<br>
CONFIG_MTD_DOCECC=m<br>
CONFIG_MTD_DOCPROBE_ADVANCED=y<br>
CONFIG_MTD_DOCPROBE_ADDRESS=0x0000<br>
CONFIG_MTD_DOCPROBE_HIGH=y<br>
CONFIG_MTD_DOCPROBE_55AA=y<br>
<br>
#<br>
# NAND Flash Device Drivers<br>
#<br>
CONFIG_MTD_NAND=m<br>
# CONFIG_MTD_NAND_VERIFY_WRITE is not set<br>
# CONFIG_MTD_NAND_ECC_SMC is not set<br>
CONFIG_MTD_NAND_IDS=m<br>
CONFIG_MTD_NAND_DISKONCHIP=m<br>
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set<br>
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0<br>
# CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set<br>
# CONFIG_MTD_NAND_CAFE is not set<br>
# CONFIG_MTD_NAND_NANDSIM is not set<br>
<br>
#<br>
# OneNAND Flash Device Drivers<br>
#<br>
# CONFIG_MTD_ONENAND is not set<br>
<br>
#<br>
# Parallel port support<br>
#<br>
CONFIG_PARPORT=m<br>
CONFIG_PARPORT_PC=m<br>
CONFIG_PARPORT_SERIAL=m<br>
CONFIG_PARPORT_PC_FIFO=y<br>
# CONFIG_PARPORT_PC_SUPERIO is not set<br>
# CONFIG_PARPORT_GSC is not set<br>
# CONFIG_PARPORT_AX88796 is not set<br>
CONFIG_PARPORT_1284=y<br>
<br>
#<br>
# Plug and Play support<br>
#<br>
<br>
#<br>
# Block devices<br>
#<br>
CONFIG_BLK_DEV_FD=m<br>
# CONFIG_PARIDE is not set<br>
# CONFIG_BLK_CPQ_DA is not set<br>
# CONFIG_BLK_CPQ_CISS_DA is not set<br>
# CONFIG_BLK_DEV_DAC960 is not set<br>
# CONFIG_BLK_DEV_UMEM is not set<br>
# CONFIG_BLK_DEV_COW_COMMON is not set<br>
CONFIG_BLK_DEV_LOOP=m<br>
CONFIG_BLK_DEV_CRYPTOLOOP=m<br>
CONFIG_BLK_DEV_NBD=m<br>
CONFIG_BLK_DEV_SX8=m<br>
# CONFIG_BLK_DEV_UB is not set<br>
CONFIG_BLK_DEV_RAM=y<br>
CONFIG_BLK_DEV_RAM_COUNT=16<br>
CONFIG_BLK_DEV_RAM_SIZE=32000<br>
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024<br>
CONFIG_BLK_DEV_INITRD=y<br>
CONFIG_CDROM_PKTCDVD=y<br>
CONFIG_CDROM_PKTCDVD_BUFFERS=8<br>
# CONFIG_CDROM_PKTCDVD_WCACHE is not set<br>
# CONFIG_ATA_OVER_ETH is not set<br>
<br>
#<br>
# Misc devices<br>
#<br>
# CONFIG_IBM_ASM is not set<br>
# CONFIG_SGI_IOC4 is not set<br>
# CONFIG_TIFM_CORE is not set<br>
<br>
#<br>
# ATA/ATAPI/MFM/RLL support<br>
#<br>
CONFIG_IDE=m<br>
CONFIG_IDE_MAX_HWIFS=4<br>
CONFIG_BLK_DEV_IDE=m<br>
<br>
#<br>
# Please see Documentation/ide.txt for help/info on IDE drives<br>
#<br>
# CONFIG_BLK_DEV_IDE_SATA is not set<br>
# CONFIG_BLK_DEV_HD_IDE is not set<br>
CONFIG_BLK_DEV_IDEDISK=m<br>
CONFIG_IDEDISK_MULTI_MODE=y<br>
CONFIG_BLK_DEV_IDECD=m<br>
# CONFIG_BLK_DEV_IDETAPE is not set<br>
CONFIG_BLK_DEV_IDEFLOPPY=m<br>
CONFIG_BLK_DEV_IDESCSI=m<br>
CONFIG_IDE_TASK_IOCTL=y<br>
<br>
#<br>
# IDE chipset support/bugfixes<br>
#<br>
CONFIG_IDE_GENERIC=m<br>
CONFIG_BLK_DEV_CMD640=y<br>
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set<br>
CONFIG_BLK_DEV_IDEPCI=y<br>
CONFIG_IDEPCI_SHARE_IRQ=y<br>
CONFIG_BLK_DEV_OFFBOARD=y<br>
CONFIG_BLK_DEV_GENERIC=m<br>
# CONFIG_BLK_DEV_OPTI621 is not set<br>
CONFIG_BLK_DEV_RZ1000=m<br>
CONFIG_BLK_DEV_IDEDMA_PCI=y<br>
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set<br>
CONFIG_IDEDMA_PCI_AUTO=y<br>
# CONFIG_IDEDMA_ONLYDISK is not set<br>
CONFIG_BLK_DEV_AEC62XX=m<br>
CONFIG_BLK_DEV_ALI15X3=m<br>
# CONFIG_WDC_ALI15X3 is not set<br>
CONFIG_BLK_DEV_AMD74XX=m<br>
CONFIG_BLK_DEV_ATIIXP=m<br>
CONFIG_BLK_DEV_CMD64X=m<br>
CONFIG_BLK_DEV_TRIFLEX=m<br>
# CONFIG_BLK_DEV_CY82C693 is not set<br>
CONFIG_BLK_DEV_CS5520=m<br>
CONFIG_BLK_DEV_CS5530=m<br>
CONFIG_BLK_DEV_HPT34X=m<br>
CONFIG_HPT34X_AUTODMA=y<br>
CONFIG_BLK_DEV_HPT366=m<br>
# CONFIG_BLK_DEV_JMICRON is not set<br>
# CONFIG_BLK_DEV_SC1200 is not set<br>
CONFIG_BLK_DEV_PIIX=m<br>
CONFIG_BLK_DEV_IT821X=m<br>
# CONFIG_BLK_DEV_NS87415 is not set<br>
CONFIG_BLK_DEV_PDC202XX_OLD=m<br>
# CONFIG_PDC202XX_BURST is not set<br>
CONFIG_BLK_DEV_PDC202XX_NEW=m<br>
CONFIG_BLK_DEV_SVWKS=m<br>
CONFIG_BLK_DEV_SIIMAGE=m<br>
CONFIG_BLK_DEV_SIS5513=m<br>
CONFIG_BLK_DEV_SLC90E66=m<br>
CONFIG_BLK_DEV_TRM290=m<br>
CONFIG_BLK_DEV_VIA82CXXX=m<br>
# CONFIG_IDE_ARM is not set<br>
CONFIG_BLK_DEV_IDEDMA=y<br>
# CONFIG_IDEDMA_IVB is not set<br>
CONFIG_IDEDMA_AUTO=y<br>
# CONFIG_BLK_DEV_HD is not set<br>
<br>
#<br>
# SCSI device support<br>
#<br>
# CONFIG_RAID_ATTRS is not set<br>
CONFIG_SCSI=y<br>
# CONFIG_SCSI_TGT is not set<br>
CONFIG_SCSI_NETLINK=y<br>
# CONFIG_SCSI_PROC_FS is not set<br>
<br>
#<br>
# SCSI support type (disk, tape, CD-ROM)<br>
#<br>
CONFIG_BLK_DEV_SD=m<br>
# CONFIG_CHR_DEV_ST is not set<br>
# CONFIG_CHR_DEV_OSST is not set<br>
# CONFIG_BLK_DEV_SR is not set<br>
# CONFIG_CHR_DEV_SG is not set<br>
# CONFIG_CHR_DEV_SCH is not set<br>
<br>
#<br>
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs<br>
#<br>
# CONFIG_SCSI_MULTI_LUN is not set<br>
# CONFIG_SCSI_CONSTANTS is not set<br>
# CONFIG_SCSI_LOGGING is not set<br>
# CONFIG_SCSI_SCAN_ASYNC is not set<br>
<br>
#<br>
# SCSI Transports<br>
#<br>
CONFIG_SCSI_SPI_ATTRS=m<br>
CONFIG_SCSI_FC_ATTRS=m<br>
CONFIG_SCSI_ISCSI_ATTRS=m<br>
CONFIG_SCSI_SAS_ATTRS=m<br>
# CONFIG_SCSI_SAS_LIBSAS is not set<br>
<br>
#<br>
# SCSI low-level drivers<br>
#<br>
CONFIG_ISCSI_TCP=m<br>
CONFIG_BLK_DEV_3W_XXXX_RAID=m<br>
CONFIG_SCSI_3W_9XXX=m<br>
CONFIG_SCSI_ACARD=m<br>
CONFIG_SCSI_AACRAID=m<br>
CONFIG_SCSI_AIC7XXX=m<br>
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253<br>
CONFIG_AIC7XXX_RESET_DELAY_MS=15000<br>
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set<br>
CONFIG_AIC7XXX_DEBUG_MASK=0<br>
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y<br>
CONFIG_SCSI_AIC7XXX_OLD=m<br>
CONFIG_SCSI_AIC79XX=m<br>
CONFIG_AIC79XX_CMDS_PER_DEVICE=32<br>
CONFIG_AIC79XX_RESET_DELAY_MS=15000<br>
# CONFIG_AIC79XX_ENABLE_RD_STRM is not set<br>
# CONFIG_AIC79XX_DEBUG_ENABLE is not set<br>
CONFIG_AIC79XX_DEBUG_MASK=0<br>
CONFIG_AIC79XX_REG_PRETTY_PRINT=y<br>
# CONFIG_SCSI_AIC94XX is not set<br>
# CONFIG_SCSI_ARCMSR is not set<br>
CONFIG_MEGARAID_NEWGEN=y<br>
CONFIG_MEGARAID_MM=m<br>
CONFIG_MEGARAID_MAILBOX=m<br>
CONFIG_MEGARAID_LEGACY=m<br>
CONFIG_MEGARAID_SAS=m<br>
# CONFIG_SCSI_HPTIOP is not set<br>
CONFIG_SCSI_BUSLOGIC=m<br>
# CONFIG_SCSI_OMIT_FLASHPOINT is not set<br>
CONFIG_SCSI_DMX3191D=m<br>
CONFIG_SCSI_EATA=m<br>
CONFIG_SCSI_EATA_TAGGED_QUEUE=y<br>
# CONFIG_SCSI_EATA_LINKED_COMMANDS is not set<br>
CONFIG_SCSI_EATA_MAX_TAGS=16<br>
CONFIG_SCSI_FUTURE_DOMAIN=m<br>
CONFIG_SCSI_GDTH=m<br>
CONFIG_SCSI_IPS=m<br>
CONFIG_SCSI_INITIO=m<br>
CONFIG_SCSI_INIA100=m<br>
CONFIG_SCSI_PPA=m<br>
CONFIG_SCSI_IMM=m<br>
# CONFIG_SCSI_IZIP_EPP16 is not set<br>
# CONFIG_SCSI_IZIP_SLOW_CTR is not set<br>
# CONFIG_SCSI_STEX is not set<br>
CONFIG_SCSI_SYM53C8XX_2=m<br>
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0<br>
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16<br>
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64<br>
CONFIG_SCSI_SYM53C8XX_MMIO=y<br>
# CONFIG_SCSI_IPR is not set<br>
CONFIG_SCSI_QLOGIC_1280=m<br>
CONFIG_SCSI_QLA_FC=m<br>
# CONFIG_SCSI_QLA_ISCSI is not set<br>
CONFIG_SCSI_LPFC=m<br>
CONFIG_SCSI_DC395x=m<br>
CONFIG_SCSI_DC390T=m<br>
CONFIG_SCSI_DEBUG=m<br>
# CONFIG_SCSI_SRP is not set<br>
<br>
#<br>
# Serial ATA (prod) and Parallel ATA (experimental) drivers<br>
#<br>
CONFIG_ATA=y<br>
# CONFIG_ATA_NONSTANDARD is not set<br>
CONFIG_SATA_AHCI=m<br>
# CONFIG_SATA_SVW is not set<br>
CONFIG_ATA_PIIX=m<br>
# CONFIG_SATA_MV is not set<br>
# CONFIG_SATA_NV is not set<br>
# CONFIG_PDC_ADMA is not set<br>
# CONFIG_SATA_QSTOR is not set<br>
# CONFIG_SATA_PROMISE is not set<br>
# CONFIG_SATA_SX4 is not set<br>
# CONFIG_SATA_SIL is not set<br>
# CONFIG_SATA_SIL24 is not set<br>
# CONFIG_SATA_SIS is not set<br>
# CONFIG_SATA_ULI is not set<br>
# CONFIG_SATA_VIA is not set<br>
# CONFIG_SATA_VITESSE is not set<br>
# CONFIG_PATA_ALI is not set<br>
# CONFIG_PATA_AMD is not set<br>
# CONFIG_PATA_ARTOP is not set<br>
# CONFIG_PATA_ATIIXP is not set<br>
# CONFIG_PATA_CMD64X is not set<br>
# CONFIG_PATA_CS5520 is not set<br>
# CONFIG_PATA_CS5530 is not set<br>
# CONFIG_PATA_CYPRESS is not set<br>
# CONFIG_PATA_EFAR is not set<br>
CONFIG_ATA_GENERIC=m<br>
# CONFIG_PATA_HPT366 is not set<br>
# CONFIG_PATA_HPT37X is not set<br>
# CONFIG_PATA_HPT3X2N is not set<br>
# CONFIG_PATA_HPT3X3 is not set<br>
# CONFIG_PATA_IT821X is not set<br>
CONFIG_PATA_JMICRON=m<br>
# CONFIG_PATA_TRIFLEX is not set<br>
# CONFIG_PATA_MARVELL is not set<br>
CONFIG_PATA_MPIIX=m<br>
# CONFIG_PATA_OLDPIIX is not set<br>
# CONFIG_PATA_NETCELL is not set<br>
# CONFIG_PATA_NS87410 is not set<br>
# CONFIG_PATA_OPTI is not set<br>
# CONFIG_PATA_OPTIDMA is not set<br>
# CONFIG_PATA_PDC_OLD is not set<br>
# CONFIG_PATA_RADISYS is not set<br>
# CONFIG_PATA_RZ1000 is not set<br>
# CONFIG_PATA_SC1200 is not set<br>
# CONFIG_PATA_SERVERWORKS is not set<br>
# CONFIG_PATA_PDC2027X is not set<br>
# CONFIG_PATA_SIL680 is not set<br>
# CONFIG_PATA_SIS is not set<br>
# CONFIG_PATA_VIA is not set<br>
# CONFIG_PATA_WINBOND is not set<br>
# CONFIG_PATA_PLATFORM is not set<br>
<br>
#<br>
# Multi-device support (RAID and LVM)<br>
#<br>
# CONFIG_MD is not set<br>
<br>
#<br>
# Fusion MPT device support<br>
#<br>
# CONFIG_FUSION is not set<br>
# CONFIG_FUSION_SPI is not set<br>
# CONFIG_FUSION_FC is not set<br>
# CONFIG_FUSION_SAS is not set<br>
<br>
#<br>
# IEEE 1394 (FireWire) support<br>
#<br>
# CONFIG_IEEE1394 is not set<br>
<br>
#<br>
# I2O device support<br>
#<br>
# CONFIG_I2O is not set<br>
<br>
#<br>
# Macintosh device drivers<br>
#<br>
# CONFIG_MAC_EMUMOUSEBTN is not set<br>
<br>
#<br>
# Network device support<br>
#<br>
CONFIG_NETDEVICES=y<br>
CONFIG_DUMMY=m<br>
CONFIG_BONDING=m<br>
# CONFIG_EQUALIZER is not set<br>
# CONFIG_TUN is not set<br>
<br>
#<br>
# ARCnet devices<br>
#<br>
# CONFIG_ARCNET is not set<br>
<br>
#<br>
# PHY device support<br>
#<br>
<br>
#<br>
# Ethernet (10 or 100Mbit)<br>
#<br>
# CONFIG_NET_ETHERNET is not set<br>
CONFIG_MII=m<br>
<br>
#<br>
# Ethernet (1000 Mbit)<br>
#<br>
# CONFIG_ACENIC is not set<br>
# CONFIG_DL2K is not set<br>
CONFIG_E1000=m<br>
# CONFIG_E1000_NAPI is not set<br>
# CONFIG_E1000_DISABLE_PACKET_SPLIT is not set<br>
# CONFIG_NS83820 is not set<br>
# CONFIG_HAMACHI is not set<br>
# CONFIG_YELLOWFIN is not set<br>
# CONFIG_R8169 is not set<br>
# CONFIG_SIS190 is not set<br>
# CONFIG_SKGE is not set<br>
# CONFIG_SKY2 is not set<br>
# CONFIG_SK98LIN is not set<br>
# CONFIG_TIGON3 is not set<br>
# CONFIG_BNX2 is not set<br>
# CONFIG_QLA3XXX is not set<br>
<br>
#<br>
# Ethernet (10000 Mbit)<br>
#<br>
# CONFIG_CHELSIO_T1 is not set<br>
# CONFIG_IXGB is not set<br>
# CONFIG_S2IO is not set<br>
# CONFIG_MYRI10GE is not set<br>
# CONFIG_NETXEN_NIC is not set<br>
<br>
#<br>
# Token Ring devices<br>
#<br>
# CONFIG_TR is not set<br>
<br>
#<br>
# Wireless LAN (non-hamradio)<br>
#<br>
# CONFIG_NET_RADIO is not set<br>
<br>
#<br>
# Wan interfaces<br>
#<br>
# CONFIG_WAN is not set<br>
# CONFIG_FDDI is not set<br>
# CONFIG_HIPPI is not set<br>
# CONFIG_PLIP is not set<br>
# CONFIG_PPP is not set<br>
# CONFIG_SLIP is not set<br>
# CONFIG_NET_FC is not set<br>
# CONFIG_SHAPER is not set<br>
# CONFIG_NETCONSOLE is not set<br>
# CONFIG_NETPOLL is not set<br>
# CONFIG_NET_POLL_CONTROLLER is not set<br>
<br>
#<br>
# ISDN subsystem<br>
#<br>
# CONFIG_ISDN is not set<br>
<br>
#<br>
# Telephony Support<br>
#<br>
# CONFIG_PHONE is not set<br>
<br>
#<br>
# Input device support<br>
#<br>
CONFIG_INPUT=y<br>
# CONFIG_INPUT_FF_MEMLESS is not set<br>
<br>
#<br>
# Userland interfaces<br>
#<br>
CONFIG_INPUT_MOUSEDEV=y<br>
CONFIG_INPUT_MOUSEDEV_PSAUX=y<br>
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024<br>
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768<br>
# CONFIG_INPUT_JOYDEV is not set<br>
# CONFIG_INPUT_TSDEV is not set<br>
CONFIG_INPUT_EVDEV=m<br>
# CONFIG_INPUT_EVBUG is not set<br>
<br>
#<br>
# Input Device Drivers<br>
#<br>
CONFIG_INPUT_KEYBOARD=y<br>
CONFIG_KEYBOARD_ATKBD=y<br>
# CONFIG_KEYBOARD_SUNKBD is not set<br>
# CONFIG_KEYBOARD_LKKBD is not set<br>
CONFIG_KEYBOARD_XTKBD=m<br>
# CONFIG_KEYBOARD_NEWTON is not set<br>
# CONFIG_KEYBOARD_STOWAWAY is not set<br>
CONFIG_INPUT_MOUSE=y<br>
CONFIG_MOUSE_PS2=y<br>
CONFIG_MOUSE_SERIAL=m<br>
# CONFIG_MOUSE_VSXXXAA is not set<br>
# CONFIG_INPUT_JOYSTICK is not set<br>
# CONFIG_INPUT_TOUCHSCREEN is not set<br>
# CONFIG_INPUT_MISC is not set<br>
<br>
#<br>
# Hardware I/O ports<br>
#<br>
CONFIG_SERIO=y<br>
CONFIG_SERIO_I8042=y<br>
CONFIG_SERIO_SERPORT=m<br>
CONFIG_SERIO_CT82C710=m<br>
CONFIG_SERIO_PARKBD=m<br>
CONFIG_SERIO_PCIPS2=m<br>
CONFIG_SERIO_LIBPS2=y<br>
CONFIG_SERIO_RAW=m<br>
# CONFIG_GAMEPORT is not set<br>
<br>
#<br>
# Character devices<br>
#<br>
CONFIG_VT=y<br>
CONFIG_VT_CONSOLE=y<br>
CONFIG_HW_CONSOLE=y<br>
# CONFIG_VT_HW_CONSOLE_BINDING is not set<br>
CONFIG_SERIAL_NONSTANDARD=y<br>
# CONFIG_COMPUTONE is not set<br>
# CONFIG_ROCKETPORT is not set<br>
# CONFIG_CYCLADES is not set<br>
# CONFIG_DIGIEPCA is not set<br>
# CONFIG_MOXA_INTELLIO is not set<br>
CONFIG_MOXA_SMARTIO=m<br>
# CONFIG_MOXA_SMARTIO_NEW is not set<br>
# CONFIG_ISI is not set<br>
# CONFIG_SYNCLINK is not set<br>
# CONFIG_SYNCLINKMP is not set<br>
# CONFIG_SYNCLINK_GT is not set<br>
CONFIG_N_HDLC=m<br>
# CONFIG_SPECIALIX is not set<br>
# CONFIG_SX is not set<br>
# CONFIG_RIO is not set<br>
# CONFIG_STALDRV is not set<br>
<br>
#<br>
# Serial drivers<br>
#<br>
CONFIG_SERIAL_8250=y<br>
CONFIG_SERIAL_8250_CONSOLE=y<br>
CONFIG_SERIAL_8250_PCI=y<br>
CONFIG_SERIAL_8250_NR_UARTS=16<br>
CONFIG_SERIAL_8250_RUNTIME_UARTS=16<br>
CONFIG_SERIAL_8250_EXTENDED=y<br>
# CONFIG_SERIAL_8250_MANY_PORTS is not set<br>
CONFIG_SERIAL_8250_SHARE_IRQ=y<br>
# CONFIG_SERIAL_8250_DETECT_IRQ is not set<br>
# CONFIG_SERIAL_8250_RSA is not set<br>
<br>
#<br>
# Non-8250 serial port support<br>
#<br>
CONFIG_SERIAL_CORE=y<br>
CONFIG_SERIAL_CORE_CONSOLE=y<br>
CONFIG_SERIAL_JSM=m<br>
CONFIG_UNIX98_PTYS=y<br>
CONFIG_LEGACY_PTYS=y<br>
CONFIG_LEGACY_PTY_COUNT=256<br>
CONFIG_PRINTER=m<br>
CONFIG_LP_CONSOLE=y<br>
CONFIG_PPDEV=m<br>
# CONFIG_TIPAR is not set<br>
<br>
#<br>
# IPMI<br>
#<br>
# CONFIG_IPMI_HANDLER is not set<br>
<br>
#<br>
# Watchdog Cards<br>
#<br>
CONFIG_WATCHDOG=y<br>
CONFIG_WATCHDOG_NOWAYOUT=y<br>
<br>
#<br>
# Watchdog Device Drivers<br>
#<br>
CONFIG_SOFT_WATCHDOG=m<br>
CONFIG_ACQUIRE_WDT=m<br>
CONFIG_ADVANTECH_WDT=m<br>
CONFIG_ALIM1535_WDT=m<br>
CONFIG_ALIM7101_WDT=m<br>
CONFIG_SC520_WDT=m<br>
CONFIG_EUROTECH_WDT=m<br>
CONFIG_IB700_WDT=m<br>
CONFIG_IBMASR=m<br>
CONFIG_WAFER_WDT=m<br>
CONFIG_I6300ESB_WDT=m<br>
CONFIG_I8XX_TCO=m<br>
# CONFIG_ITCO_WDT is not set<br>
# CONFIG_SC1200_WDT is not set<br>
# CONFIG_PC87413_WDT is not set<br>
CONFIG_60XX_WDT=m<br>
CONFIG_SBC8360_WDT=m<br>
CONFIG_CPU5_WDT=m<br>
# CONFIG_SMSC37B787_WDT is not set<br>
CONFIG_W83627HF_WDT=m<br>
# CONFIG_W83697HF_WDT is not set<br>
CONFIG_W83877F_WDT=m<br>
CONFIG_W83977F_WDT=m<br>
CONFIG_MACHZ_WDT=m<br>
CONFIG_SBC_EPX_C3_WATCHDOG=m<br>
<br>
#<br>
# PCI-based Watchdog Cards<br>
#<br>
CONFIG_PCIPCWATCHDOG=m<br>
CONFIG_WDTPCI=m<br>
CONFIG_WDT_501_PCI=y<br>
<br>
#<br>
# USB-based Watchdog Cards<br>
#<br>
CONFIG_USBPCWATCHDOG=m<br>
CONFIG_HW_RANDOM=m<br>
CONFIG_HW_RANDOM_INTEL=m<br>
# CONFIG_HW_RANDOM_AMD is not set<br>
# CONFIG_HW_RANDOM_GEODE is not set<br>
CONFIG_NVRAM=m<br>
CONFIG_RTC=y<br>
CONFIG_DTLK=m<br>
CONFIG_R3964=m<br>
CONFIG_APPLICOM=m<br>
CONFIG_AGP=y<br>
CONFIG_AGP_AMD64=y<br>
CONFIG_AGP_INTEL=m<br>
# CONFIG_AGP_SIS is not set<br>
# CONFIG_AGP_VIA is not set<br>
CONFIG_DRM=m<br>
# CONFIG_DRM_TDFX is not set<br>
# CONFIG_DRM_R128 is not set<br>
# CONFIG_DRM_RADEON is not set<br>
CONFIG_DRM_I810=m<br>
CONFIG_DRM_I830=m<br>
CONFIG_DRM_I915=m<br>
# CONFIG_DRM_MGA is not set<br>
# CONFIG_DRM_SIS is not set<br>
# CONFIG_DRM_VIA is not set<br>
# CONFIG_DRM_SAVAGE is not set<br>
# CONFIG_MWAVE is not set<br>
# CONFIG_PC8736x_GPIO is not set<br>
CONFIG_RAW_DRIVER=m<br>
CONFIG_MAX_RAW_DEVS=256<br>
CONFIG_HANGCHECK_TIMER=m<br>
<br>
#<br>
# TPM devices<br>
#<br>
# CONFIG_TCG_TPM is not set<br>
# CONFIG_TELCLOCK is not set<br>
<br>
#<br>
# I2C support<br>
#<br>
CONFIG_I2C=m<br>
CONFIG_I2C_CHARDEV=m<br>
<br>
#<br>
# I2C Algorithms<br>
#<br>
CONFIG_I2C_ALGOBIT=m<br>
CONFIG_I2C_ALGOPCF=m<br>
CONFIG_I2C_ALGOPCA=m<br>
<br>
#<br>
# I2C Hardware Bus support<br>
#<br>
CONFIG_I2C_ALI1535=m<br>
CONFIG_I2C_ALI1563=m<br>
CONFIG_I2C_ALI15X3=m<br>
CONFIG_I2C_AMD756=m<br>
CONFIG_I2C_AMD756_S4882=m<br>
CONFIG_I2C_AMD8111=m<br>
CONFIG_I2C_I801=m<br>
CONFIG_I2C_I810=m<br>
CONFIG_I2C_PIIX4=m<br>
CONFIG_I2C_NFORCE2=m<br>
# CONFIG_I2C_OCORES is not set<br>
CONFIG_I2C_PARPORT=m<br>
CONFIG_I2C_PARPORT_LIGHT=m<br>
CONFIG_I2C_PROSAVAGE=m<br>
CONFIG_I2C_SAVAGE4=m<br>
CONFIG_I2C_SIS5595=m<br>
CONFIG_I2C_SIS630=m<br>
CONFIG_I2C_SIS96X=m<br>
CONFIG_I2C_STUB=m<br>
CONFIG_I2C_VIA=m<br>
CONFIG_I2C_VIAPRO=m<br>
CONFIG_I2C_VOODOO3=m<br>
CONFIG_I2C_PCA_ISA=m<br>
<br>
#<br>
# Miscellaneous I2C Chip support<br>
#<br>
CONFIG_SENSORS_DS1337=m<br>
CONFIG_SENSORS_DS1374=m<br>
CONFIG_SENSORS_EEPROM=m<br>
CONFIG_SENSORS_PCF8574=m<br>
CONFIG_SENSORS_PCA9539=m<br>
CONFIG_SENSORS_PCF8591=m<br>
CONFIG_SENSORS_MAX6875=m<br>
# CONFIG_I2C_DEBUG_CORE is not set<br>
# CONFIG_I2C_DEBUG_ALGO is not set<br>
# CONFIG_I2C_DEBUG_BUS is not set<br>
# CONFIG_I2C_DEBUG_CHIP is not set<br>
<br>
#<br>
# SPI support<br>
#<br>
# CONFIG_SPI is not set<br>
# CONFIG_SPI_MASTER is not set<br>
<br>
#<br>
# Dallas's 1-wire bus<br>
#<br>
# CONFIG_W1 is not set<br>
<br>
#<br>
# Hardware Monitoring support<br>
#<br>
# CONFIG_HWMON is not set<br>
# CONFIG_HWMON_VID is not set<br>
<br>
#<br>
# Multimedia devices<br>
#<br>
# CONFIG_VIDEO_DEV is not set<br>
<br>
#<br>
# Digital Video Broadcasting Devices<br>
#<br>
# CONFIG_DVB is not set<br>
# CONFIG_USB_DABUSB is not set<br>
<br>
#<br>
# Graphics support<br>
#<br>
CONFIG_FIRMWARE_EDID=y<br>
CONFIG_FB=y<br>
# CONFIG_FB_DDC is not set<br>
CONFIG_FB_CFB_FILLRECT=y<br>
CONFIG_FB_CFB_COPYAREA=y<br>
CONFIG_FB_CFB_IMAGEBLIT=y<br>
# CONFIG_FB_MACMODES is not set<br>
# CONFIG_FB_BACKLIGHT is not set<br>
CONFIG_FB_MODE_HELPERS=y<br>
CONFIG_FB_TILEBLITTING=y<br>
# CONFIG_FB_CIRRUS is not set<br>
# CONFIG_FB_PM2 is not set<br>
# CONFIG_FB_CYBER2000 is not set<br>
# CONFIG_FB_ARC is not set<br>
# CONFIG_FB_ASILIANT is not set<br>
# CONFIG_FB_IMSTT is not set<br>
CONFIG_FB_VGA16=m<br>
CONFIG_FB_VESA=y<br>
# CONFIG_FB_HGA is not set<br>
# CONFIG_FB_S1D13XXX is not set<br>
# CONFIG_FB_NVIDIA is not set<br>
# CONFIG_FB_RIVA is not set<br>
CONFIG_FB_INTEL=m<br>
# CONFIG_FB_INTEL_DEBUG is not set<br>
CONFIG_FB_INTEL_I2C=y<br>
# CONFIG_FB_MATROX is not set<br>
# CONFIG_FB_RADEON is not set<br>
# CONFIG_FB_ATY128 is not set<br>
# CONFIG_FB_ATY is not set<br>
# CONFIG_FB_SAVAGE is not set<br>
# CONFIG_FB_SIS is not set<br>
# CONFIG_FB_NEOMAGIC is not set<br>
# CONFIG_FB_KYRO is not set<br>
# CONFIG_FB_3DFX is not set<br>
# CONFIG_FB_VOODOO1 is not set<br>
# CONFIG_FB_TRIDENT is not set<br>
# CONFIG_FB_GEODE is not set<br>
# CONFIG_FB_VIRTUAL is not set<br>
<br>
#<br>
# Console display driver support<br>
#<br>
CONFIG_VGA_CONSOLE=y<br>
# CONFIG_VGACON_SOFT_SCROLLBACK is not set<br>
CONFIG_VIDEO_SELECT=y<br>
CONFIG_DUMMY_CONSOLE=y<br>
CONFIG_FRAMEBUFFER_CONSOLE=y<br>
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set<br>
CONFIG_FONTS=y<br>
CONFIG_FONT_8x8=y<br>
CONFIG_FONT_8x16=y<br>
# CONFIG_FONT_6x11 is not set<br>
# CONFIG_FONT_7x14 is not set<br>
# CONFIG_FONT_PEARL_8x8 is not set<br>
# CONFIG_FONT_ACORN_8x8 is not set<br>
# CONFIG_FONT_MINI_4x6 is not set<br>
# CONFIG_FONT_SUN8x16 is not set<br>
# CONFIG_FONT_SUN12x22 is not set<br>
# CONFIG_FONT_10x18 is not set<br>
<br>
#<br>
# Logo configuration<br>
#<br>
CONFIG_LOGO=y<br>
CONFIG_LOGO_LINUX_MONO=y<br>
CONFIG_LOGO_LINUX_VGA16=y<br>
CONFIG_LOGO_LINUX_CLUT224=y<br>
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set<br>
<br>
#<br>
# Sound<br>
#<br>
CONFIG_SOUND=m<br>
<br>
#<br>
# Advanced Linux Sound Architecture<br>
#<br>
CONFIG_SND=m<br>
CONFIG_SND_TIMER=m<br>
CONFIG_SND_PCM=m<br>
CONFIG_SND_RAWMIDI=m<br>
CONFIG_SND_SEQUENCER=m<br>
CONFIG_SND_SEQ_DUMMY=m<br>
CONFIG_SND_OSSEMUL=y<br>
CONFIG_SND_MIXER_OSS=m<br>
CONFIG_SND_PCM_OSS=m<br>
CONFIG_SND_PCM_OSS_PLUGINS=y<br>
CONFIG_SND_SEQUENCER_OSS=y<br>
CONFIG_SND_RTCTIMER=m<br>
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y<br>
# CONFIG_SND_DYNAMIC_MINORS is not set<br>
CONFIG_SND_SUPPORT_OLD_API=y<br>
CONFIG_SND_VERBOSE_PROCFS=y<br>
# CONFIG_SND_VERBOSE_PRINTK is not set<br>
# CONFIG_SND_DEBUG is not set<br>
<br>
#<br>
# Generic devices<br>
#<br>
CONFIG_SND_DUMMY=m<br>
CONFIG_SND_VIRMIDI=m<br>
# CONFIG_SND_MTPAV is not set<br>
# CONFIG_SND_MTS64 is not set<br>
# CONFIG_SND_SERIAL_U16550 is not set<br>
# CONFIG_SND_MPU401 is not set<br>
<br>
#<br>
# PCI devices<br>
#<br>
# CONFIG_SND_AD1889 is not set<br>
# CONFIG_SND_ALS300 is not set<br>
# CONFIG_SND_ALS4000 is not set<br>
# CONFIG_SND_ALI5451 is not set<br>
# CONFIG_SND_ATIIXP is not set<br>
# CONFIG_SND_ATIIXP_MODEM is not set<br>
# CONFIG_SND_AU8810 is not set<br>
# CONFIG_SND_AU8820 is not set<br>
# CONFIG_SND_AU8830 is not set<br>
# CONFIG_SND_AZT3328 is not set<br>
# CONFIG_SND_BT87X is not set<br>
# CONFIG_SND_CA0106 is not set<br>
# CONFIG_SND_CMIPCI is not set<br>
# CONFIG_SND_CS4281 is not set<br>
# CONFIG_SND_CS46XX is not set<br>
# CONFIG_SND_DARLA20 is not set<br>
# CONFIG_SND_GINA20 is not set<br>
# CONFIG_SND_LAYLA20 is not set<br>
# CONFIG_SND_DARLA24 is not set<br>
# CONFIG_SND_GINA24 is not set<br>
# CONFIG_SND_LAYLA24 is not set<br>
# CONFIG_SND_MONA is not set<br>
# CONFIG_SND_MIA is not set<br>
# CONFIG_SND_ECHO3G is not set<br>
# CONFIG_SND_INDIGO is not set<br>
# CONFIG_SND_INDIGOIO is not set<br>
# CONFIG_SND_INDIGODJ is not set<br>
# CONFIG_SND_EMU10K1 is not set<br>
# CONFIG_SND_EMU10K1X is not set<br>
# CONFIG_SND_ENS1370 is not set<br>
# CONFIG_SND_ENS1371 is not set<br>
# CONFIG_SND_ES1938 is not set<br>
# CONFIG_SND_ES1968 is not set<br>
# CONFIG_SND_FM801 is not set<br>
CONFIG_SND_HDA_INTEL=m<br>
# CONFIG_SND_HDSP is not set<br>
# CONFIG_SND_HDSPM is not set<br>
# CONFIG_SND_ICE1712 is not set<br>
# CONFIG_SND_ICE1724 is not set<br>
# CONFIG_SND_INTEL8X0 is not set<br>
# CONFIG_SND_INTEL8X0M is not set<br>
# CONFIG_SND_KORG1212 is not set<br>
# CONFIG_SND_MAESTRO3 is not set<br>
# CONFIG_SND_MIXART is not set<br>
# CONFIG_SND_NM256 is not set<br>
# CONFIG_SND_PCXHR is not set<br>
# CONFIG_SND_RIPTIDE is not set<br>
# CONFIG_SND_RME32 is not set<br>
# CONFIG_SND_RME96 is not set<br>
# CONFIG_SND_RME9652 is not set<br>
# CONFIG_SND_SONICVIBES is not set<br>
# CONFIG_SND_TRIDENT is not set<br>
# CONFIG_SND_VIA82XX is not set<br>
# CONFIG_SND_VIA82XX_MODEM is not set<br>
# CONFIG_SND_VX222 is not set<br>
# CONFIG_SND_YMFPCI is not set<br>
<br>
#<br>
# USB devices<br>
#<br>
# CONFIG_SND_USB_AUDIO is not set<br>
# CONFIG_SND_USB_USX2Y is not set<br>
<br>
#<br>
# Open Sound System<br>
#<br>
# CONFIG_SOUND_PRIME is not set<br>
<br>
#<br>
# HID Devices<br>
#<br>
CONFIG_HID=y<br>
<br>
#<br>
# USB support<br>
#<br>
CONFIG_USB_ARCH_HAS_HCD=y<br>
CONFIG_USB_ARCH_HAS_OHCI=y<br>
CONFIG_USB_ARCH_HAS_EHCI=y<br>
CONFIG_USB=m<br>
# CONFIG_USB_DEBUG is not set<br>
<br>
#<br>
# Miscellaneous USB options<br>
#<br>
CONFIG_USB_DEVICEFS=y<br>
# CONFIG_USB_BANDWIDTH is not set<br>
CONFIG_USB_DYNAMIC_MINORS=y<br>
# CONFIG_USB_OTG is not set<br>
<br>
#<br>
# USB Host Controller Drivers<br>
#<br>
CONFIG_USB_EHCI_HCD=m<br>
CONFIG_USB_EHCI_SPLIT_ISO=y<br>
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set<br>
# CONFIG_USB_EHCI_TT_NEWSCHED is not set<br>
# CONFIG_USB_ISP116X_HCD is not set<br>
CONFIG_USB_OHCI_HCD=m<br>
# CONFIG_USB_OHCI_BIG_ENDIAN is not set<br>
CONFIG_USB_OHCI_LITTLE_ENDIAN=y<br>
CONFIG_USB_UHCI_HCD=m<br>
# CONFIG_USB_SL811_HCD is not set<br>
<br>
#<br>
# USB Device Class drivers<br>
#<br>
# CONFIG_USB_ACM is not set<br>
# CONFIG_USB_PRINTER is not set<br>
<br>
#<br>
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'<br>
#<br>
<br>
#<br>
# may also be needed; see USB_STORAGE Help for more information<br>
#<br>
# CONFIG_USB_STORAGE is not set<br>
# CONFIG_USB_LIBUSUAL is not set<br>
<br>
#<br>
# USB Input Devices<br>
#<br>
# CONFIG_USB_HID is not set<br>
<br>
#<br>
# USB HID Boot Protocol drivers<br>
#<br>
CONFIG_USB_KBD=m<br>
CONFIG_USB_MOUSE=m<br>
# CONFIG_USB_AIPTEK is not set<br>
# CONFIG_USB_WACOM is not set<br>
# CONFIG_USB_ACECAD is not set<br>
# CONFIG_USB_KBTAB is not set<br>
# CONFIG_USB_POWERMATE is not set<br>
# CONFIG_USB_TOUCHSCREEN is not set<br>
# CONFIG_USB_YEALINK is not set<br>
# CONFIG_USB_XPAD is not set<br>
# CONFIG_USB_ATI_REMOTE is not set<br>
# CONFIG_USB_ATI_REMOTE2 is not set<br>
# CONFIG_USB_KEYSPAN_REMOTE is not set<br>
# CONFIG_USB_APPLETOUCH is not set<br>
<br>
#<br>
# USB Imaging devices<br>
#<br>
# CONFIG_USB_MDC800 is not set<br>
# CONFIG_USB_MICROTEK is not set<br>
<br>
#<br>
# USB Network Adapters<br>
#<br>
CONFIG_USB_CATC=m<br>
CONFIG_USB_KAWETH=m<br>
CONFIG_USB_PEGASUS=m<br>
CONFIG_USB_RTL8150=m<br>
# CONFIG_USB_USBNET_MII is not set<br>
CONFIG_USB_USBNET=m<br>
CONFIG_USB_NET_CDCETHER=m<br>
CONFIG_USB_NET_GL620A=m<br>
CONFIG_USB_NET_NET1080=m<br>
CONFIG_USB_NET_PLUSB=m<br>
# CONFIG_USB_NET_MCS7830 is not set<br>
CONFIG_USB_NET_RNDIS_HOST=m<br>
CONFIG_USB_NET_CDC_SUBSET=m<br>
CONFIG_USB_ALI_M5632=y<br>
CONFIG_USB_AN2720=y<br>
CONFIG_USB_BELKIN=y<br>
CONFIG_USB_ARMLINUX=y<br>
CONFIG_USB_EPSON2888=y<br>
CONFIG_USB_NET_ZAURUS=m<br>
# CONFIG_USB_MON is not set<br>
<br>
#<br>
# USB port drivers<br>
#<br>
# CONFIG_USB_USS720 is not set<br>
<br>
#<br>
# USB Serial Converter support<br>
#<br>
CONFIG_USB_SERIAL=m<br>
CONFIG_USB_SERIAL_GENERIC=y<br>
# CONFIG_USB_SERIAL_AIRCABLE is not set<br>
CONFIG_USB_SERIAL_AIRPRIME=m<br>
CONFIG_USB_SERIAL_ARK3116=m<br>
CONFIG_USB_SERIAL_BELKIN=m<br>
CONFIG_USB_SERIAL_WHITEHEAT=m<br>
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m<br>
CONFIG_USB_SERIAL_CP2101=m<br>
CONFIG_USB_SERIAL_CYPRESS_M8=m<br>
CONFIG_USB_SERIAL_EMPEG=m<br>
CONFIG_USB_SERIAL_FTDI_SIO=m<br>
CONFIG_USB_SERIAL_FUNSOFT=m<br>
CONFIG_USB_SERIAL_VISOR=m<br>
CONFIG_USB_SERIAL_IPAQ=m<br>
CONFIG_USB_SERIAL_IR=m<br>
CONFIG_USB_SERIAL_EDGEPORT=m<br>
CONFIG_USB_SERIAL_EDGEPORT_TI=m<br>
CONFIG_USB_SERIAL_GARMIN=m<br>
CONFIG_USB_SERIAL_IPW=m<br>
CONFIG_USB_SERIAL_KEYSPAN_PDA=m<br>
CONFIG_USB_SERIAL_KEYSPAN=m<br>
CONFIG_USB_SERIAL_KEYSPAN_MPR=y<br>
CONFIG_USB_SERIAL_KEYSPAN_USA28=y<br>
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y<br>
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y<br>
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y<br>
CONFIG_USB_SERIAL_KEYSPAN_USA19=y<br>
CONFIG_USB_SERIAL_KEYSPAN_USA18X=y<br>
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y<br>
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y<br>
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y<br>
CONFIG_USB_SERIAL_KEYSPAN_USA49W=y<br>
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y<br>
CONFIG_USB_SERIAL_KLSI=m<br>
CONFIG_USB_SERIAL_KOBIL_SCT=m<br>
CONFIG_USB_SERIAL_MCT_U232=m<br>
# CONFIG_USB_SERIAL_MOS7720 is not set<br>
# CONFIG_USB_SERIAL_MOS7840 is not set<br>
CONFIG_USB_SERIAL_NAVMAN=m<br>
CONFIG_USB_SERIAL_PL2303=m<br>
CONFIG_USB_SERIAL_HP4X=m<br>
CONFIG_USB_SERIAL_SAFE=m<br>
CONFIG_USB_SERIAL_SAFE_PADDED=y<br>
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set<br>
CONFIG_USB_SERIAL_TI=m<br>
CONFIG_USB_SERIAL_CYBERJACK=m<br>
CONFIG_USB_SERIAL_XIRCOM=m<br>
CONFIG_USB_SERIAL_OPTION=m<br>
CONFIG_USB_SERIAL_OMNINET=m<br>
# CONFIG_USB_SERIAL_DEBUG is not set<br>
CONFIG_USB_EZUSB=y<br>
<br>
#<br>
# USB Miscellaneous drivers<br>
#<br>
# CONFIG_USB_EMI62 is not set<br>
# CONFIG_USB_EMI26 is not set<br>
# CONFIG_USB_ADUTUX is not set<br>
# CONFIG_USB_AUERSWALD is not set<br>
# CONFIG_USB_RIO500 is not set<br>
# CONFIG_USB_LEGOTOWER is not set<br>
# CONFIG_USB_LCD is not set<br>
# CONFIG_USB_LED is not set<br>
# CONFIG_USB_CYPRESS_CY7C63 is not set<br>
# CONFIG_USB_CYTHERM is not set<br>
# CONFIG_USB_PHIDGET is not set<br>
# CONFIG_USB_IDMOUSE is not set<br>
# CONFIG_USB_FTDI_ELAN is not set<br>
# CONFIG_USB_APPLEDISPLAY is not set<br>
# CONFIG_USB_SISUSBVGA is not set<br>
# CONFIG_USB_LD is not set<br>
# CONFIG_USB_TRANCEVIBRATOR is not set<br>
# CONFIG_USB_TEST is not set<br>
<br>
#<br>
# USB DSL modem support<br>
#<br>
<br>
#<br>
# USB Gadget Support<br>
#<br>
# CONFIG_USB_GADGET is not set<br>
<br>
#<br>
# MMC/SD Card support<br>
#<br>
# CONFIG_MMC is not set<br>
<br>
#<br>
# LED devices<br>
#<br>
# CONFIG_NEW_LEDS is not set<br>
<br>
#<br>
# LED drivers<br>
#<br>
<br>
#<br>
# LED Triggers<br>
#<br>
<br>
#<br>
# InfiniBand support<br>
#<br>
# CONFIG_INFINIBAND is not set<br>
<br>
#<br>
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)<br>
#<br>
# CONFIG_EDAC is not set<br>
<br>
#<br>
# Real Time Clock<br>
#<br>
CONFIG_RTC_LIB=m<br>
CONFIG_RTC_CLASS=m<br>
<br>
#<br>
# RTC interfaces<br>
#<br>
CONFIG_RTC_INTF_SYSFS=m<br>
CONFIG_RTC_INTF_PROC=m<br>
CONFIG_RTC_INTF_DEV=m<br>
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set<br>
<br>
#<br>
# RTC drivers<br>
#<br>
CONFIG_RTC_DRV_X1205=m<br>
# CONFIG_RTC_DRV_DS1307 is not set<br>
# CONFIG_RTC_DRV_DS1553 is not set<br>
# CONFIG_RTC_DRV_ISL1208 is not set<br>
CONFIG_RTC_DRV_DS1672=m<br>
# CONFIG_RTC_DRV_DS1742 is not set<br>
CONFIG_RTC_DRV_PCF8563=m<br>
# CONFIG_RTC_DRV_PCF8583 is not set<br>
CONFIG_RTC_DRV_RS5C372=m<br>
CONFIG_RTC_DRV_M48T86=m<br>
CONFIG_RTC_DRV_TEST=m<br>
# CONFIG_RTC_DRV_V3020 is not set<br>
<br>
#<br>
# DMA Engine support<br>
#<br>
# CONFIG_DMA_ENGINE is not set<br>
<br>
#<br>
# DMA Clients<br>
#<br>
<br>
#<br>
# DMA Devices<br>
#<br>
<br>
#<br>
# Virtualization<br>
#<br>
# CONFIG_KVM is not set<br>
<br>
#<br>
# Firmware Drivers<br>
#<br>
CONFIG_EDD=y<br>
# CONFIG_DELL_RBU is not set<br>
# CONFIG_DCDBAS is not set<br>
<br>
#<br>
# File systems<br>
#<br>
CONFIG_EXT2_FS=y<br>
CONFIG_EXT2_FS_XATTR=y<br>
CONFIG_EXT2_FS_POSIX_ACL=y<br>
CONFIG_EXT2_FS_SECURITY=y<br>
# CONFIG_EXT2_FS_XIP is not set<br>
CONFIG_EXT3_FS=m<br>
CONFIG_EXT3_FS_XATTR=y<br>
CONFIG_EXT3_FS_POSIX_ACL=y<br>
CONFIG_EXT3_FS_SECURITY=y<br>
# CONFIG_EXT4DEV_FS is not set<br>
CONFIG_JBD=m<br>
# CONFIG_JBD_DEBUG is not set<br>
CONFIG_FS_MBCACHE=y<br>
# CONFIG_REISERFS_FS is not set<br>
# CONFIG_JFS_FS is not set<br>
CONFIG_FS_POSIX_ACL=y<br>
# CONFIG_XFS_FS is not set<br>
# CONFIG_GFS2_FS is not set<br>
# CONFIG_OCFS2_FS is not set<br>
CONFIG_MINIX_FS=m<br>
CONFIG_ROMFS_FS=m<br>
CONFIG_INOTIFY=y<br>
CONFIG_INOTIFY_USER=y<br>
# CONFIG_QUOTA is not set<br>
# CONFIG_DNOTIFY is not set<br>
# CONFIG_AUTOFS_FS is not set<br>
CONFIG_AUTOFS4_FS=m<br>
CONFIG_FUSE_FS=m<br>
<br>
#<br>
# CD-ROM/DVD Filesystems<br>
#<br>
CONFIG_ISO9660_FS=m<br>
CONFIG_JOLIET=y<br>
CONFIG_ZISOFS=y<br>
CONFIG_ZISOFS_FS=m<br>
CONFIG_UDF_FS=m<br>
CONFIG_UDF_NLS=y<br>
<br>
#<br>
# DOS/FAT/NT Filesystems<br>
#<br>
CONFIG_FAT_FS=m<br>
CONFIG_MSDOS_FS=m<br>
CONFIG_VFAT_FS=m<br>
CONFIG_FAT_DEFAULT_CODEPAGE=437<br>
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"<br>
CONFIG_NTFS_FS=m<br>
# CONFIG_NTFS_DEBUG is not set<br>
CONFIG_NTFS_RW=y<br>
<br>
#<br>
# Pseudo filesystems<br>
#<br>
CONFIG_PROC_FS=y<br>
CONFIG_PROC_KCORE=y<br>
CONFIG_PROC_VMCORE=y<br>
CONFIG_PROC_SYSCTL=y<br>
CONFIG_SYSFS=y<br>
CONFIG_TMPFS=y<br>
# CONFIG_TMPFS_POSIX_ACL is not set<br>
CONFIG_HUGETLBFS=y<br>
CONFIG_HUGETLB_PAGE=y<br>
CONFIG_RAMFS=y<br>
CONFIG_CONFIGFS_FS=m<br>
<br>
#<br>
# Miscellaneous filesystems<br>
#<br>
# CONFIG_ADFS_FS is not set<br>
# CONFIG_AFFS_FS is not set<br>
# CONFIG_ECRYPT_FS is not set<br>
# CONFIG_HFS_FS is not set<br>
# CONFIG_HFSPLUS_FS is not set<br>
# CONFIG_BEFS_FS is not set<br>
# CONFIG_BFS_FS is not set<br>
# CONFIG_EFS_FS is not set<br>
# CONFIG_JFFS2_FS is not set<br>
# CONFIG_CRAMFS is not set<br>
# CONFIG_VXFS_FS is not set<br>
# CONFIG_HPFS_FS is not set<br>
# CONFIG_QNX4FS_FS is not set<br>
# CONFIG_SYSV_FS is not set<br>
# CONFIG_UFS_FS is not set<br>
<br>
#<br>
# Network File Systems<br>
#<br>
CONFIG_NFS_FS=m<br>
CONFIG_NFS_V3=y<br>
CONFIG_NFS_V3_ACL=y<br>
CONFIG_NFS_V4=y<br>
CONFIG_NFS_DIRECTIO=y<br>
CONFIG_NFSD=m<br>
CONFIG_NFSD_V2_ACL=y<br>
CONFIG_NFSD_V3=y<br>
CONFIG_NFSD_V3_ACL=y<br>
CONFIG_NFSD_V4=y<br>
CONFIG_NFSD_TCP=y<br>
CONFIG_LOCKD=m<br>
CONFIG_LOCKD_V4=y<br>
CONFIG_EXPORTFS=m<br>
CONFIG_NFS_ACL_SUPPORT=m<br>
CONFIG_NFS_COMMON=y<br>
CONFIG_SUNRPC=m<br>
CONFIG_SUNRPC_GSS=m<br>
CONFIG_RPCSEC_GSS_KRB5=m<br>
CONFIG_RPCSEC_GSS_SPKM3=m<br>
CONFIG_SMB_FS=m<br>
CONFIG_SMB_NLS_DEFAULT=y<br>
CONFIG_SMB_NLS_REMOTE="cp437"<br>
CONFIG_CIFS=m<br>
CONFIG_CIFS_STATS=y<br>
# CONFIG_CIFS_STATS2 is not set<br>
# CONFIG_CIFS_WEAK_PW_HASH is not set<br>
# CONFIG_CIFS_XATTR is not set<br>
# CONFIG_CIFS_DEBUG2 is not set<br>
# CONFIG_CIFS_EXPERIMENTAL is not set<br>
CONFIG_NCP_FS=m<br>
CONFIG_NCPFS_PACKET_SIGNING=y<br>
# CONFIG_NCPFS_IOCTL_LOCKING is not set<br>
CONFIG_NCPFS_STRONG=y<br>
CONFIG_NCPFS_NFS_NS=y<br>
# CONFIG_NCPFS_OS2_NS is not set<br>
CONFIG_NCPFS_SMALLDOS=y<br>
CONFIG_NCPFS_NLS=y<br>
CONFIG_NCPFS_EXTRAS=y<br>
CONFIG_CODA_FS=m<br>
# CONFIG_CODA_FS_OLD_API is not set<br>
# CONFIG_AFS_FS is not set<br>
CONFIG_9P_FS=m<br>
<br>
#<br>
# Partition Types<br>
#<br>
# CONFIG_PARTITION_ADVANCED is not set<br>
CONFIG_MSDOS_PARTITION=y<br>
<br>
#<br>
# Native Language Support<br>
#<br>
CONFIG_NLS=y<br>
CONFIG_NLS_DEFAULT="iso8859-1"<br>
# CONFIG_NLS_CODEPAGE_437 is not set<br>
# CONFIG_NLS_CODEPAGE_737 is not set<br>
# CONFIG_NLS_CODEPAGE_775 is not set<br>
CONFIG_NLS_CODEPAGE_850=m<br>
# CONFIG_NLS_CODEPAGE_852 is not set<br>
# CONFIG_NLS_CODEPAGE_855 is not set<br>
# CONFIG_NLS_CODEPAGE_857 is not set<br>
# CONFIG_NLS_CODEPAGE_860 is not set<br>
# CONFIG_NLS_CODEPAGE_861 is not set<br>
# CONFIG_NLS_CODEPAGE_862 is not set<br>
# CONFIG_NLS_CODEPAGE_863 is not set<br>
# CONFIG_NLS_CODEPAGE_864 is not set<br>
# CONFIG_NLS_CODEPAGE_865 is not set<br>
# CONFIG_NLS_CODEPAGE_866 is not set<br>
# CONFIG_NLS_CODEPAGE_869 is not set<br>
# CONFIG_NLS_CODEPAGE_936 is not set<br>
# CONFIG_NLS_CODEPAGE_950 is not set<br>
# CONFIG_NLS_CODEPAGE_932 is not set<br>
# CONFIG_NLS_CODEPAGE_949 is not set<br>
# CONFIG_NLS_CODEPAGE_874 is not set<br>
# CONFIG_NLS_ISO8859_8 is not set<br>
CONFIG_NLS_CODEPAGE_1250=m<br>
# CONFIG_NLS_CODEPAGE_1251 is not set<br>
CONFIG_NLS_ASCII=m<br>
CONFIG_NLS_ISO8859_1=m<br>
# CONFIG_NLS_ISO8859_2 is not set<br>
# CONFIG_NLS_ISO8859_3 is not set<br>
# CONFIG_NLS_ISO8859_4 is not set<br>
# CONFIG_NLS_ISO8859_5 is not set<br>
# CONFIG_NLS_ISO8859_6 is not set<br>
# CONFIG_NLS_ISO8859_7 is not set<br>
# CONFIG_NLS_ISO8859_9 is not set<br>
# CONFIG_NLS_ISO8859_13 is not set<br>
# CONFIG_NLS_ISO8859_14 is not set<br>
CONFIG_NLS_ISO8859_15=m<br>
# CONFIG_NLS_KOI8_R is not set<br>
# CONFIG_NLS_KOI8_U is not set<br>
CONFIG_NLS_UTF8=m<br>
<br>
#<br>
# Distributed Lock Manager<br>
#<br>
# CONFIG_DLM is not set<br>
<br>
#<br>
# Instrumentation Support<br>
#<br>
# CONFIG_PROFILING is not set<br>
# CONFIG_KPROBES is not set<br>
<br>
#<br>
# Kernel hacking<br>
#<br>
CONFIG_TRACE_IRQFLAGS_SUPPORT=y<br>
# CONFIG_PRINTK_TIME is not set<br>
CONFIG_ENABLE_MUST_CHECK=y<br>
CONFIG_MAGIC_SYSRQ=y<br>
CONFIG_UNUSED_SYMBOLS=y<br>
CONFIG_DEBUG_FS=y<br>
# CONFIG_HEADERS_CHECK is not set<br>
# CONFIG_IPIPE_DEBUG is not set<br>
CONFIG_IPIPE_TRACE_ENABLE_VALUE=0<br>
CONFIG_DEBUG_KERNEL=y<br>
CONFIG_LOG_BUF_SHIFT=17<br>
# CONFIG_DETECT_SOFTLOCKUP is not set<br>
# CONFIG_SCHEDSTATS is not set<br>
# CONFIG_DEBUG_SLAB is not set<br>
CONFIG_DEBUG_PREEMPT=y<br>
# CONFIG_DEBUG_RT_MUTEXES is not set<br>
# CONFIG_RT_MUTEX_TESTER is not set<br>
# CONFIG_DEBUG_SPINLOCK is not set<br>
# CONFIG_DEBUG_MUTEXES is not set<br>
# CONFIG_DEBUG_RWSEMS is not set<br>
# CONFIG_DEBUG_LOCK_ALLOC is not set<br>
# CONFIG_PROVE_LOCKING is not set<br>
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set<br>
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set<br>
# CONFIG_DEBUG_KOBJECT is not set<br>
# CONFIG_DEBUG_BUGVERBOSE is not set<br>
# CONFIG_DEBUG_INFO is not set<br>
# CONFIG_DEBUG_VM is not set<br>
# CONFIG_DEBUG_LIST is not set<br>
CONFIG_FRAME_POINTER=y<br>
CONFIG_FORCED_INLINING=y<br>
# CONFIG_RCU_TORTURE_TEST is not set<br>
# CONFIG_FAULT_INJECTION is not set<br>
# CONFIG_DEBUG_RODATA is not set<br>
# CONFIG_IOMMU_DEBUG is not set<br>
# CONFIG_DEBUG_STACKOVERFLOW is not set<br>
# CONFIG_DEBUG_STACK_USAGE is not set<br>
<br>
#<br>
# Security options<br>
#<br>
CONFIG_KEYS=y<br>
CONFIG_KEYS_DEBUG_PROC_KEYS=y<br>
# CONFIG_SECURITY is not set<br>
<br>
#<br>
# Cryptographic options<br>
#<br>
CONFIG_CRYPTO=y<br>
CONFIG_CRYPTO_ALGAPI=y<br>
CONFIG_CRYPTO_BLKCIPHER=m<br>
CONFIG_CRYPTO_HASH=y<br>
CONFIG_CRYPTO_MANAGER=y<br>
CONFIG_CRYPTO_HMAC=y<br>
# CONFIG_CRYPTO_XCBC is not set<br>
CONFIG_CRYPTO_NULL=m<br>
CONFIG_CRYPTO_MD4=m<br>
CONFIG_CRYPTO_MD5=y<br>
CONFIG_CRYPTO_SHA1=m<br>
CONFIG_CRYPTO_SHA256=m<br>
CONFIG_CRYPTO_SHA512=m<br>
CONFIG_CRYPTO_WP512=m<br>
CONFIG_CRYPTO_TGR192=m<br>
# CONFIG_CRYPTO_GF128MUL is not set<br>
CONFIG_CRYPTO_ECB=m<br>
CONFIG_CRYPTO_CBC=m<br>
# CONFIG_CRYPTO_LRW is not set<br>
CONFIG_CRYPTO_DES=m<br>
CONFIG_CRYPTO_BLOWFISH=m<br>
CONFIG_CRYPTO_TWOFISH=m<br>
CONFIG_CRYPTO_TWOFISH_COMMON=m<br>
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set<br>
CONFIG_CRYPTO_SERPENT=m<br>
CONFIG_CRYPTO_AES=m<br>
# CONFIG_CRYPTO_AES_X86_64 is not set<br>
CONFIG_CRYPTO_CAST5=m<br>
CONFIG_CRYPTO_CAST6=m<br>
CONFIG_CRYPTO_TEA=m<br>
CONFIG_CRYPTO_ARC4=m<br>
CONFIG_CRYPTO_KHAZAD=m<br>
CONFIG_CRYPTO_ANUBIS=m<br>
CONFIG_CRYPTO_DEFLATE=m<br>
CONFIG_CRYPTO_MICHAEL_MIC=m<br>
CONFIG_CRYPTO_CRC32C=m<br>
CONFIG_CRYPTO_TEST=m<br>
<br>
#<br>
# Hardware crypto devices<br>
#<br>
<br>
#<br>
# Library routines<br>
#<br>
CONFIG_BITREVERSE=y<br>
CONFIG_CRC_CCITT=m<br>
CONFIG_CRC16=m<br>
CONFIG_CRC32=y<br>
CONFIG_LIBCRC32C=m<br>
CONFIG_ZLIB_INFLATE=m<br>
CONFIG_ZLIB_DEFLATE=m<br>
CONFIG_REED_SOLOMON=m<br>
CONFIG_REED_SOLOMON_DEC16=y<br>
CONFIG_PLIST=y<br>
CONFIG_IOMAP_COPY=y<br>
<br>
</body>
</html>

