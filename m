Message-ID: <444502A6.7020402@domain.hid>
Date: Tue, 18 Apr 2006 11:15:50 -0400
From: Sean McGranaghan <smm@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020506080807050900080907"
Subject: [Xenomai-help] Where did my interrupts go?
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

This is a multi-part message in MIME format.
--------------020506080807050900080907
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<font size="-1"><font face="Helvetica, Arial, sans-serif">Hello all,<br>
<br>
I have been writing an RTDM driver for an ISA (PC/104) based DAQ board.
I had the initial driver working under a very old trunk snapshot (Rev
464). This morning I upgraded to the latest trunk. I put a few small
fixes into my driver and test application to take care of some
deprecated functions and constants. (rt_queue_recv() and
RT_IRQ_ENABLED). It appears that my driver is no longer receiving
interrupts. I can see the irq line go active on the oscilloscope but it
is never cleared and it appears my interrupt handler is never called.<br>
<br>
I ran the test suite including xeno-test with no problems. Attached are
output files from dmesg, xeno-config and xeno-test outputs. My kernel
config file is also attached.<br>
<br>
At this point I think I need to turn on some debugging in the kernel.
Which debug options would be appropriate here?.<br>
<br>
Thanks,<br>
Sean<br>
</font></font>
</body>
</html>

--------------020506080807050900080907
Content-Type: text/plain;
 name="xeno-test.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xeno-test.txt"

Script started on Tue 18 Apr 2006 10:41:56 AM EDT
]0;root@domain.hid

[1m/usr/xenomai/bin[m(B

# xeno-test
running /usr/xenomai/bin/xeno-test

Tue Apr 18 10:42:04 EDT 2006
running: cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 350.861
cache size	: 512 KB
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 702.59


Tue Apr 18 10:42:04 EDT 2006
running: cat /proc/meminfo
MemTotal:       515664 kB
MemFree:        314496 kB
Buffers:         18080 kB
Cached:         111772 kB
SwapCached:          0 kB
Active:          96972 kB
Inactive:        88364 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       515664 kB
LowFree:        314496 kB
SwapTotal:     1044216 kB
SwapFree:      1044216 kB
Dirty:              52 kB
Writeback:           0 kB
Mapped:          78256 kB
Slab:            12392 kB
CommitLimit:   1302048 kB
Committed_AS:   124848 kB
PageTables:       1568 kB
VmallocTotal:   516056 kB
VmallocUsed:       976 kB
VmallocChunk:   515004 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB

Tue Apr 18 10:42:04 EDT 2006
running: cat /proc/ipipe/Linux
Priority=100, Id=0x00000000
irq0-15: accepted
irq32-33: grabbed, virtual
irq34: passed, virtual

Tue Apr 18 10:42:04 EDT 2006
running: cat /proc/ipipe/version
1.2-02

Tue Apr 18 10:42:04 EDT 2006
running: cat /proc/ipipe/Xenomai
Priority=200, Id=0x58454e4f
irq0: grabbed
irq1-31: passed
irq32-33: passed, virtual
irq34: grabbed, virtual

Tue Apr 18 10:42:05 EDT 2006
running: generate_loads 1
dd workload started, pids 2662

Tue Apr 18 10:42:05 EDT 2006
running: cat /proc/interrupts
           CPU0       
  0:     137646          XT-PIC  timer
  1:        247          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:         11          XT-PIC  serial
  5:          0          XT-PIC  uhci_hcd:usb1
  9:        324          XT-PIC  eth0
 12:        422          XT-PIC  i8042
 14:       7509          XT-PIC  ide0
 15:        900          XT-PIC  ide1
NMI:          0 
ERR:          0

Tue Apr 18 10:42:05 EDT 2006
running: cat /proc/loadavg
1.03 0.57 0.21 2/97 2666

Tue Apr 18 10:42:06 EDT 2006
running: top -bn1c
top - 10:42:07 up 2 min,  3 users,  load average: 1.03, 0.57, 0.21
Tasks:  89 total,   2 running,  87 sleeping,   0 stopped,   0 zombie
Cpu(s): 28.5% us, 12.0% sy,  0.0% ni, 34.0% id, 25.6% wa,  0.0% hi,  0.0% si
Mem:    515664k total,   202164k used,   313500k free,    18084k buffers
Swap:  1044216k total,        0k used,  1044216k free,   111860k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND                                                
 2662 root      25   0  3608  416  352 R 93.2  0.1   0:00.66 dd if /dev/zero of /dev/null                           
 2669 root      15   0  2008  900  700 R  3.7  0.2   0:00.06 top -bn1c                                              
    1 root      16   0  1740  600  512 S  0.0  0.1   0:00.71 init [5]                                               

Tue Apr 18 10:42:07 EDT 2006
running: ./run -- -q -s -T 10 -t0
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
running quietly for 10 seconds
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|         9|      7.889|      0.333
HSS|    avg|     98948|      9.675|      0.832
HSS|    max|         9|     17.556|      0.527
---|------------|------------|------------|--------|-------------------------
RTS|       7.971|      10.183|      18.904|       0|    00:00:10/00:00:10

Tue Apr 18 10:42:22 EDT 2006
running: ./run -- -q -s -T 10 -t1
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel periodic task
== All results in microseconds
warming up...
running quietly for 10 seconds
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|         6|      2.833|      0.408
HSS|    avg|     69578|      4.725|      1.256
HSS|    max|         6|     13.167|      3.125
---|------------|------------|------------|--------|-------------------------
RTS|       2.812|       5.267|      19.091|       0|    00:00:10/00:00:10

Tue Apr 18 10:42:36 EDT 2006
running: ./run -- -q -s -T 10 -t2
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel timer handler
== All results in microseconds
warming up...
running quietly for 10 seconds
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|         9|      2.000|      0.000
HSS|    avg|     99963|      0.981|      0.589
HSS|    max|         9|      2.667|      0.707
---|------------|------------|------------|--------|-------------------------
RTS|      -2.708|      -1.486|       4.565|       0|    00:00:10/00:00:10

Tue Apr 18 10:42:51 EDT 2006
running: cat /proc/interrupts
           CPU0       
  0:     183346          XT-PIC  timer
  1:        247          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:         11          XT-PIC  serial
  5:          0          XT-PIC  uhci_hcd:usb1
  9:        336          XT-PIC  eth0
 12:       2286          XT-PIC  i8042
 14:       7701          XT-PIC  ide0
 15:       1314          XT-PIC  ide1
NMI:          0 
ERR:          0

Tue Apr 18 10:42:51 EDT 2006
running: cat /proc/loadavg
1.48 0.76 0.30 2/97 2937

Tue Apr 18 10:42:52 EDT 2006
running: top -bn1c
top - 10:42:52 up 3 min,  3 users,  load average: 1.48, 0.76, 0.30
Tasks:  89 total,   2 running,  87 sleeping,   0 stopped,   0 zombie
Cpu(s): 30.8% us, 24.4% sy,  0.0% ni, 25.6% id, 19.2% wa,  0.0% hi,  0.0% si
Mem:    515664k total,   202928k used,   312736k free,    18304k buffers
Swap:  1044216k total,        0k used,  1044216k free,   112084k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND                                                
 2662 root      25   0  3608  416  352 R 73.0  0.1   0:37.40 dd if /dev/zero of /dev/null                           
 2391 root      15   0 45084  16m 4808 S 15.0  3.3   0:11.85 /usr/X11R6/bin/X :0 -audit 0 -auth /var/gdm/:0.Xauth -n
 2941 root      15   0  2008  900  700 R  5.6  0.2   0:00.06 top -bn1c                                              
]0;root@domain.hid

[1m/usr/xenomai/bin[m(B

# exit

Script done on Tue 18 Apr 2006 10:42:54 AM EDT

--------------020506080807050900080907
Content-Type: text/plain;
 name="_config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="_config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.16.5
# Tue Apr 18 09:05:44 2006
#
CONFIG_X86_32=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION="-ipipe"
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
# CONFIG_IKCONFIG is not set
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
CONFIG_VM86=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_SLAB=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Block layer
#
CONFIG_LBD=y

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
CONFIG_XENO_OPT_SECURITY_ACCESS=y
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_REGISTRY=y
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_SYS_HEAPSZ=128
# CONFIG_XENO_OPT_ISHIELD is not set
CONFIG_XENO_OPT_STATS=y
# CONFIG_XENO_OPT_DEBUG is not set
# CONFIG_XENO_OPT_WATCHDOG is not set

#
# Timing
#
CONFIG_XENO_OPT_TIMING_PERIODIC=y
CONFIG_XENO_OPT_TIMING_PERIOD=0
CONFIG_XENO_OPT_TIMING_TIMERLAT=0
CONFIG_XENO_OPT_TIMING_SCHEDLAT=0

#
# Scalability
#
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
CONFIG_XENO_OPT_TIMER_LIST=y
# CONFIG_XENO_OPT_TIMER_HEAP is not set

#
# Shared interrupts
#
# CONFIG_XENO_OPT_SHIRQ_LEVEL is not set
# CONFIG_XENO_OPT_SHIRQ_EDGE is not set

#
# Machine
#
CONFIG_XENO_HW_FPU=y

#
# NMI watchdog
#

#
# SMI workaround
#
# CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
CONFIG_XENO_HW_SMI_DETECT=y
# CONFIG_XENO_HW_SMI_WORKAROUND is not set

#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_OPT_NATIVE_PIPE=y
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=4096
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
# CONFIG_XENO_SKIN_POSIX is not set
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set

#
# RTAI emulator unavailable, disable native API or build it as module
#
CONFIG_XENO_SKIN_RTDM=y
CONFIG_XENO_OPT_RTDM_FILDES=128
# CONFIG_XENO_SKIN_UVM is not set

#
# Drivers
#
CONFIG_XENO_DRIVERS_16550A=m
CONFIG_XENO_DRIVERS_TIMERBENCH=m

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMII=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_HPET_TIMER=y
# CONFIG_SMP is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_IPIPE=y
# CONFIG_IPIPE_STATS is not set
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
# CONFIG_REGPARM is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
# CONFIG_KEXEC is not set
CONFIG_PHYSICAL_START=0x100000
CONFIG_DOUBLEFAULT=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=2001
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_LEGACY_PROC=y
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_NETLINK is not set
# CONFIG_NETFILTER_XTABLES is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
# CONFIG_IP_NF_FTP is not set
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_NETBIOS_NS is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_PPTP is not set
CONFIG_IP_NF_QUEUE=y

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
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
# CONFIG_NET_DIVERT is not set
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
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
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
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_BLK_DEV_INITRD=y
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
CONFIG_SCSI_DPT_I2O=m
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
CONFIG_SCSI_ATA_PIIX=y
# CONFIG_SCSI_SATA_MV is not set
# CONFIG_SCSI_SATA_NV is not set
# CONFIG_SCSI_PDC_ADMA is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_SATA_PROMISE is not set
CONFIG_SCSI_SATA_SX4=m
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIL24 is not set
CONFIG_SCSI_SATA_SIS=m
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
CONFIG_SCSI_SATA_INTEL_COMBINED=y
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
# CONFIG_SCSI_IPR_TRACE is not set
# CONFIG_SCSI_IPR_DUMP is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
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
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL1=m
CONFIG_EL2=m
CONFIG_ELPLUS=m
CONFIG_EL16=m
CONFIG_EL3=m
CONFIG_3C515=m
CONFIG_VORTEX=m
CONFIG_TYPHOON=m
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
# CONFIG_DM9102 is not set
# CONFIG_ULI526X is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
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

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_MWAVE is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y

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
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
CONFIG_USB_EGALAX=m
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
CONFIG_USB_MON=y

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
CONFIG_USB_CYTHERM=m
# CONFIG_USB_PHIDGETKIT is not set
CONFIG_USB_PHIDGETSERVO=m
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#
# CONFIG_EDAC is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
# CONFIG_RELAYFS_FS is not set
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
# CONFIG_CRAMFS is not set
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
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
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
# CONFIG_9P_FS is not set

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
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Instrumentation Support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=y
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
CONFIG_FRAME_POINTER=y
CONFIG_FORCED_INLINING=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_4KSTACKS is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Hardware crypto devices
#

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_KTIME_SCALAR=y

--------------020506080807050900080907
Content-Type: text/plain;
 name="dmesg.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.out"

Linux version 2.6.16.5-ipipe (root@domain.hid) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #6 Tue Apr 18 09:06:51 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffd000 (usable)
 BIOS-e820: 000000001fffd000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131069
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 126973 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.0 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f7e00
ACPI: RSDT (v001 ASUS   P2B      0x00000000  0x00000000) @ 0x1fffd000
ACPI: FADT (v001 ASUS   P2B      0x00000000  0x00000000) @ 0x1fffd080
ACPI: BOOT (v001 ASUS   P2B      0x00000000  0x00000000) @ 0x1fffd040
ACPI: DSDT (v001   ASUS P2B      0x00001000 MSFT 0x01000001) @ 0x00000000
ACPI: BIOS age (1998) fails cutoff (2001), acpi=force is required to enable ACPI
ACPI: Disabling ACPI support
Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
Built 1 zonelists
Kernel command line: ro root=LABEL=/
Enabling fast FPU save and restore... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 350.861 MHz processor.
Using tsc for high-res timesource
I-pipe 1.2-02: pipeline enabled.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514284k/524276k available (2386k kernel code, 9448k reserved, 684k data, 164k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 702.59 BogoMIPS (lpj=351299)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0183f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0183f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium II (Deschutes) stepping 02
Checking 'hlt' instruction... OK.
checking if image is initramfs... it is
Freeing initrd memory: 1059k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI quirk: region e400-e43f claimed by PIIX4 ACPI
PCI quirk: region e800-e80f claimed by PIIX4 SMB
PIIX4 devres B PIO at 0290-0297
Boot video device is 0000:01:00.0
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:04.0
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: e0000000-e1dfffff
  PREFETCH window: e1f00000-e3ffffff
Simple Boot Flag at 0x46 set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1145356789.047:1): initialized
I-pipe: Domain Xenomai registered.
Xenomai: hal/x86 started.
Xenomai: real-time nucleus v2.2-dev (Engines Of Creation) loaded.
Xenomai: starting native API services.
Xenomai: starting RTDM services.
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@domain.hid).
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Limiting direct PCI/PCI transfers.
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: AGP aperture is 64M @ 0xe4000000
[drm] Initialized drm 1.0.1 20051102
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: WDC WD300AB-22BTA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-ST GCE-8483B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=58168/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdc: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.20 loaded.
usbmon: debugfs is not available
USB Universal Host Controller Interface driver v2.3
PCI: setting IRQ 5 as level-triggered
PCI: Assigned IRQ 5 for device 0000:00:04.2
uhci_hcd 0000:00:04.2: UHCI Host Controller
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:04.2: irq 5, io base 0x0000d400
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
oprofile: using timer interrupt.
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 5, 131072 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
ip_conntrack version 2.4 (4095 buckets, 32760 max) - 172 bytes per conntrack
input: AT Translated Set 2 keyboard as /class/input/input0
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
Freeing unused kernel memory: 164k freed
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
input: ImPS/2 Logitech Wheel Mouse as /class/input/input1
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Found IRQ 9 for device 0000:00:0a.0
tulip0:  MII transceiver #1 config 1000 status 786d advertising 01e1.
eth0: ADMtek Comet rev 17 at e0832000, 00:20:78:05:A5:A0, IRQ 9.
EXT3 FS on hda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1044216k swap on /dev/hda3.  Priority:-1 extents:1 across:1044216k
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).

--------------020506080807050900080907
Content-Type: text/plain;
 name="xeno-config.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xeno-config.txt"

xeno-config --verbose
    --version="2.1.50"
    --cc="gcc"
    --arch="i386"
    --prefix="/usr/xenomai"
    --xeno-cflags="-I. -I/usr/xenomai/include -O2 -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -Wall -pipe -fstrict-aliasing -Wno-strict-aliasing"
    --xeno-ldflags="-L/usr/xenomai/lib -lpthread "
    --posix-cflags="-I. -I/usr/xenomai/include -I/usr/xenomai/include/posix -O2 -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -Wall -pipe -fstrict-aliasing -Wno-strict-aliasing"
    --posix-ldflags="-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt "
    --uvm-cflags="-I. -I/usr/xenomai/include -O2 -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -Wall -pipe -fstrict-aliasing -Wno-strict-aliasing -D__XENO_UVM__ "
    --uvm-ldflags="-u__xeno_skin_init -L/usr/xenomai/lib -luvm -lnucleus_uvm -lpthread"
    --library-dir="/usr/xenomai/lib"

--------------020506080807050900080907--

