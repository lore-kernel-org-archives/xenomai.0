Date: Fri, 12 Oct 2007 13:00:55 +0200
From: Stelian Pop <stelian@domain.hid>
Message-ID: <20071012110054.GA26325@domain.hid>
References: <470E8BFE.4070804@domain.hid> <1192179524.5149.23.camel@domain.hid>
	<470F3B03.1040501@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <470F3B03.1040501@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] fix hw-timer setup/cleanup for i386
Reply-To: Stelian Pop <stelian@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 12, 2007 at 11:14:43AM +0200, Jan Kiszka wrote:

> 
> Hmm, that's not too different from my own test setup.

I'm attaching the .config and dmesg in case you see something strange.

> /proc/xenomai/timerstat/master may provide further hints about the state
> of the host timer (please keep my patch applied for this).

/proc/xenomai/timerstat/master says:

CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME
0    1           1           -          -          NULL         [host-timer]

> Also, you
> could take an I-pipe trace around the timer takeover and the following
> few milliseconds, using the new trigger feature:
> 
> echo rthal_timer_request > /proc/ipipe/trace/trigger

It gives this:

root@domain.hid# cat /proc/ipipe/trace/max
I-pipe worst-case tracing service on 2.6.22.9-xeno/ipipe-1.10-07
------------------------------------------------------------
CPU: 0, Begin: 855580300596 cycles, Trace Points: 26 (-10/+10), Length: 37 us
Calibrated minimum trace-point overhead: 0.095 us

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- <unused>
 |||+-- Xenomai
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
 |   +func                 -18    0.095  __const_udelay+0x8 (rthal_timer_request+0xb7)
 |   +func                 -18   17.235  __delay+0x8 (__const_udelay+0x23)
 |   +end     0x80000001     0    0.130  rthal_timer_request+0x15a (xnpod_enable_timesource+0xcb)
     +func                   0    0.130  rthal_irq_request+0xc (rthal_timer_request+0xe5)
     +func                   0    0.110  ipipe_virtualize_irq+0xe (rthal_irq_request+0x45)
     +func                   0    0.095  __ipipe_spin_lock_irqsave+0x9 (ipipe_virtualize_irq+0x65)
 |   +begin   0x80000001     0    0.180  __ipipe_spin_lock_irqsave+0x4b (ipipe_virtualize_irq+0x65)
 |   #func                   0    0.100  __ipipe_enable_irqdesc+0x8 (ipipe_virtualize_irq+0x111)
 |   #func                   0    0.100  __ipipe_spin_unlock_irqrestore+0x9 (ipipe_virtualize_irq+0x97)
 |   +end     0x80000001     0    0.135  __ipipe_spin_unlock_irqrestore+0x36 (ipipe_virtualize_irq+0x97)
>|   +begin   0x80000000     0    0.135  xnpod_enable_timesource+0x18b (xnpod_init+0x36a)
:|  *+func                   0    0.125  xntimer_start_aperiodic+0xe (xnpod_enable_timesource+0x1b5)
:|  *+func                   0+   5.797  rthal_get_8254_tsc+0xe (xntimer_start_aperiodic+0x38)
:|  *+func                   6    0.285  xnarch_ns_to_tsc+0xe (xntimer_start_aperiodic+0x11d)
:|  *+func                   6    0.135  xntimer_next_local_shot+0xe (xntimer_start_aperiodic+0x13a)
:|  *+func                   6+   5.787  rthal_get_8254_tsc+0xe (xntimer_next_local_shot+0x35)
:|  *+func                  12    0.145  ipipe_trigger_irq+0xe (xntimer_next_local_shot+0x97)
:|  *+func                  12    0.130  __ipipe_handle_irq+0xe (ipipe_trigger_irq+0x8f)
:|  *+func                  12    0.110  __ipipe_dispatch_wired+0xb (__ipipe_handle_irq+0x51)
:|  *+func                  12    0.175  __ipipe_set_irq_pending+0xb (__ipipe_dispatch_wired+0xc9)
:|  *+func                  12    0.130  __ipipe_restore_pipeline_head+0xd (xnpod_enable_timesource+0x159)
:|   +func                  12    0.130  __ipipe_walk_pipeline+0xa (__ipipe_restore_pipeline_head+0xdc)
:|  + func                  13    0.110  ipipe_suspend_domain+0xe (__ipipe_walk_pipeline+0x78)
:|  + func                  13    0.230  __ipipe_sync_stage+0xe (ipipe_suspend_domain+0x84)
:|  # func                  13    0.135  xnintr_clock_handler+0xe (__ipipe_sync_stage+0x105)
:|  # func                  13+   5.782  rthal_get_8254_tsc+0xe (xnintr_clock_handler+0x1b)
:|  # func                  19    0.095  xntimer_tick_aperiodic+0xe (xnintr_clock_handler+0x2f)
:|  # func                  19+   5.797  rthal_get_8254_tsc+0xe (xntimer_tick_aperiodic+0x1d)
:|  # func                  25    0.380  xntimer_next_local_shot+0xe (xntimer_tick_aperiodic+0x164)
:|  # func                  25    0.190  rthal_irq_host_pend+0x8 (xnintr_clock_handler+0xa2)
:|  # func                  25    0.125  __ipipe_schedule_irq+0xe (rthal_irq_host_pend+0x16)
:|  # func                  25    0.120  __ipipe_set_irq_pending+0xb (__ipipe_schedule_irq+0x68)
:|  # func                  26+   5.772  rthal_get_8254_tsc+0xe (xnintr_clock_handler+0xb3)
:|  # func                  31+   5.832  rthal_get_8254_tsc+0xe (xnintr_clock_handler+0xce)
:|   +func                  37    0.125  __ipipe_sync_stage+0xe (ipipe_suspend_domain+0x84)
<|   #end     0x80000000    37    0.140  __ipipe_sync_stage+0x192 (ipipe_suspend_domain+0x84)
     #func                  37    0.095  do_IRQ+0xe (__ipipe_sync_stage+0x1dd)
     #func                  38    0.100  irq_enter+0x8 (do_IRQ+0x35)
     #func                  38    0.095  handle_level_irq+0xb (do_IRQ+0x3c)
     #func                  38    0.130  ipipe_check_context+0xc (handle_level_irq+0x19)
     #func                  38    0.090  ipipe_check_context+0xc (handle_level_irq+0x50)
     #func                  38    0.110  handle_IRQ_event+0xe (handle_level_irq+0x59)
     #func                  38    0.095  timer_interrupt+0x8 (handle_IRQ_event+0x31)
     #func                  38    0.075  tick_handle_periodic+0xe (timer_interrupt+0x13)
     #func                  38    0.080  tick_periodic+0x8 (tick_handle_periodic+0x17)
     #func                  38    0.000  ipipe_check_context+0xc (tick_periodic+0x4a)

> BTW, does the latency test of Xenomai work?

No. It hangs after "warming up". I'm able to interrupt with ^C and then
it prints a single line showing a max latency of 208983.492 ms (same value
on several invocations).

-- 
Stelian Pop <stelian@domain.hid>    

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.22.9-xeno
# Fri Oct 12 11:45:32 2007
#
CONFIG_X86_32=y
CONFIG_GENERIC_TIME=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_ZONE_DMA=y
CONFIG_QUICKLIST=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_IPC_NS is not set
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_UTS_NS is not set
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=17
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
# CONFIG_EMBEDDED is not set
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
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y

#
# Block layer
#
CONFIG_BLOCK=y
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set
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
CONFIG_XENO_HW_FPU=y

#
# NMI watchdog
#

#
# SMI workaround
#
CONFIG_XENO_HW_SMI_DETECT_DISABLE=y

#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=m
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
CONFIG_XENO_OPT_NATIVE_INTR=y
CONFIG_XENO_SKIN_POSIX=m
CONFIG_XENO_OPT_POSIX_PERIOD=0
CONFIG_XENO_OPT_POSIX_SHM=y
CONFIG_XENO_OPT_POSIX_INTR=y
CONFIG_XENO_OPT_DEBUG_POSIX=y
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
# CONFIG_XENO_SKIN_RTAI is not set
CONFIG_XENO_SKIN_RTDM=m
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
# Processor type and features
#
# CONFIG_TICK_ONESHOT is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
# CONFIG_SMP is not set
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
CONFIG_M486=y
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MCORE2 is not set
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
# CONFIG_MVIAC7 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_X86_XADD=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_BUG=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_MINIMUM_CPU_MODEL=4
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_IPIPE=y
CONFIG_IPIPE_DOMAINS=4
CONFIG_IPIPE_COMPAT=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
CONFIG_VM86=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=m
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_RESOURCES_64BIT is not set
CONFIG_ZONE_DMA_FLAG=1
CONFIG_NR_QUICK=1
CONFIG_HIGHPTE=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x100000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x100000
CONFIG_COMPAT_VDSO=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set
# CONFIG_PM_SYSFS_DEPRECATED is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_PROCFS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_SBS is not set
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
# CONFIG_ARCH_SUPPORTS_MSI is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

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
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
CONFIG_NET_KEY=m
# CONFIG_NET_KEY_MIGRATE is not set
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
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=y
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
# CONFIG_NETFILTER_NETLINK_LOG is not set
CONFIG_NF_CONNTRACK_ENABLED=y
CONFIG_NF_CONNTRACK=y
CONFIG_NF_CT_ACCT=y
CONFIG_NF_CONNTRACK_MARK=y
# CONFIG_NF_CONNTRACK_EVENTS is not set
# CONFIG_NF_CT_PROTO_SCTP is not set
# CONFIG_NF_CONNTRACK_AMANDA is not set
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
# CONFIG_NF_CONNTRACK_PPTP is not set
# CONFIG_NF_CONNTRACK_SANE is not set
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
# CONFIG_NF_CT_NETLINK is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=y
CONFIG_NETFILTER_XT_TARGET_CONNMARK=y
CONFIG_NETFILTER_XT_TARGET_DSCP=y
CONFIG_NETFILTER_XT_TARGET_MARK=y
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=y
CONFIG_NETFILTER_XT_TARGET_NFLOG=y
CONFIG_NETFILTER_XT_TARGET_NOTRACK=y
CONFIG_NETFILTER_XT_TARGET_TCPMSS=y
CONFIG_NETFILTER_XT_MATCH_COMMENT=y
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=y
CONFIG_NETFILTER_XT_MATCH_CONNMARK=y
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
CONFIG_NETFILTER_XT_MATCH_DCCP=y
CONFIG_NETFILTER_XT_MATCH_DSCP=y
CONFIG_NETFILTER_XT_MATCH_ESP=y
CONFIG_NETFILTER_XT_MATCH_HELPER=y
CONFIG_NETFILTER_XT_MATCH_LENGTH=y
CONFIG_NETFILTER_XT_MATCH_LIMIT=y
CONFIG_NETFILTER_XT_MATCH_MAC=y
CONFIG_NETFILTER_XT_MATCH_MARK=y
CONFIG_NETFILTER_XT_MATCH_POLICY=y
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=y
CONFIG_NETFILTER_XT_MATCH_QUOTA=y
CONFIG_NETFILTER_XT_MATCH_REALM=y
CONFIG_NETFILTER_XT_MATCH_SCTP=y
CONFIG_NETFILTER_XT_MATCH_STATE=y
CONFIG_NETFILTER_XT_MATCH_STATISTIC=y
CONFIG_NETFILTER_XT_MATCH_STRING=y
CONFIG_NETFILTER_XT_MATCH_TCPMSS=y
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=y

#
# IP: Netfilter Configuration
#
CONFIG_NF_CONNTRACK_IPV4=y
# CONFIG_NF_CONNTRACK_PROC_COMPAT is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_IPRANGE=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_RECENT=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_AH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_MATCH_ADDRTYPE=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_NF_NAT=y
CONFIG_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_TARGET_NETMAP=y
CONFIG_IP_NF_TARGET_SAME=y
CONFIG_NF_NAT_SNMP_BASIC=y
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_TFTP=m
# CONFIG_NF_NAT_AMANDA is not set
# CONFIG_NF_NAT_PPTP is not set
CONFIG_NF_NAT_H323=m
CONFIG_NF_NAT_SIP=m
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_TTL=y
CONFIG_IP_NF_TARGET_CLUSTERIP=y
CONFIG_IP_NF_RAW=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y
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
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
CONFIG_BT=y
CONFIG_BT_L2CAP=y
# CONFIG_BT_SCO is not set
CONFIG_BT_RFCOMM=y
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
# CONFIG_BT_BNEP_MC_FILTER is not set
# CONFIG_BT_BNEP_PROTO_FILTER is not set
CONFIG_BT_HIDP=y

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=y
# CONFIG_BT_HCIUSB_SCO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
# CONFIG_BT_HCIVHCI is not set
# CONFIG_AF_RXRPC is not set

#
# Wireless
#
# CONFIG_CFG80211 is not set
CONFIG_WIRELESS_EXT=y
# CONFIG_MAC80211 is not set
# CONFIG_IEEE80211 is not set
# CONFIG_RFKILL is not set

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

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=8192
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_SONY_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_IDEDISK is not set
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_IDEACPI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_IDEPCI_PCIBUS_ORDER=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
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
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT8213 is not set
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
# CONFIG_BLK_DEV_TC86C001 is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
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
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set
CONFIG_SCSI_WAIT_SCAN=m

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set

#
# SCSI low-level drivers
#
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
# CONFIG_SCSI_ADVANSYS is not set
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
CONFIG_ATA_ACPI=y
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_SVW is not set
CONFIG_ATA_PIIX=y
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
# CONFIG_SATA_VIA is not set
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
# CONFIG_PATA_CS5535 is not set
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

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_DEBUG is not set
# CONFIG_DM_CRYPT is not set
CONFIG_DM_SNAPSHOT=y
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set
# CONFIG_DM_DELAY is not set

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
CONFIG_IEEE1394=y

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set

#
# Controllers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=m

#
# Protocols
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
# CONFIG_IEEE1394_ETH1394_ROM_ENTRY is not set
# CONFIG_IEEE1394_ETH1394 is not set
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m

#
# I2O device support
#
# CONFIG_I2O is not set
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_NET_SB1000 is not set
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set
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
CONFIG_SKY2=m
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
# CONFIG_QLA3XXX is not set
# CONFIG_ATL1 is not set
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
# CONFIG_USB_USBNET_MII is not set
# CONFIG_USB_USBNET is not set
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPP_MPPE is not set
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set
CONFIG_SLHC=m
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
CONFIG_NETCONSOLE=m
CONFIG_NETPOLL=y
CONFIG_NETPOLL_TRAP=y
CONFIG_NET_POLL_CONTROLLER=y

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
# CONFIG_INPUT_FF_MEMLESS is not set
CONFIG_INPUT_POLLDEV=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
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
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
CONFIG_MOUSE_APPLETOUCH=m
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_WISTRON_BTNS is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
CONFIG_INPUT_UINPUT=m

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
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
# CONFIG_VT_HW_CONSOLE_BINDING is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_PCI=m
CONFIG_SERIAL_8250_PNP=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_GEODE is not set
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=m
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=m

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
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
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_TINY_USB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set
CONFIG_HWMON=m
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_CORETEMP=m
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
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_HDAPS is not set
CONFIG_SENSORS_APPLESMC=m
# CONFIG_HWMON_DEBUG_CHIP is not set

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
CONFIG_VIDEO_CAPTURE_DRIVERS=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_HELPER_CHIPS_AUTO is not set

#
# Encoders/decoders and other helper chips
#

#
# Audio decoders
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TDA9875 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set

#
# Video decoders
#
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA7111 is not set
# CONFIG_VIDEO_SAA7114 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_SAA7191 is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_CX25840 is not set

#
# MPEG video encoders
#
# CONFIG_VIDEO_CX2341X is not set

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# CONFIG_VIDEO_VIVI is not set
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_CPIA2 is not set
# CONFIG_VIDEO_SAA5246A is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_CX88 is not set
# CONFIG_VIDEO_IVTV is not set
# CONFIG_VIDEO_CAFE_CCIC is not set
CONFIG_V4L_USB_DRIVERS=y
# CONFIG_VIDEO_PVRUSB2 is not set
# CONFIG_VIDEO_EM28XX is not set
# CONFIG_VIDEO_USBVISION is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_QUICKCAM_MESSENGER is not set
# CONFIG_USB_ET61X251 is not set
# CONFIG_VIDEO_OVCAMCHIP is not set
# CONFIG_USB_W9968CF is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_SN9C102 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_ZC0301 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_ZR364XX is not set
# CONFIG_RADIO_ADAPTERS is not set
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
# CONFIG_FB is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
# CONFIG_VIDEO_SELECT is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
# CONFIG_SND_PCM_OSS_PLUGINS is not set
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
CONFIG_SND_DYNAMIC_MINORS=y
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDA_INTEL=m
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# USB devices
#
CONFIG_SND_USB_AUDIO=m
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SND_USB_CAIAQ is not set

#
# System on Chip audio support
#
# CONFIG_SND_SOC is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# HID Devices
#
CONFIG_HID=y
# CONFIG_HID_DEBUG is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT_POWERBOOK=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB support
#
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
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
# CONFIG_USB_EHCI_BIG_ENDIAN_MMIO is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

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
CONFIG_USB_STORAGE=m
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
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_MON is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_AIRPRIME is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP2101 is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_FUNSOFT is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_HP4X is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_DEBUG is not set

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
# CONFIG_USB_GADGET is not set
# CONFIG_MMC is not set

#
# LED devices
#
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y

#
# LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#
# CONFIG_EDAC is not set

#
# Real Time Clock
#
# CONFIG_RTC_CLASS is not set

#
# DMA Engine support
#
CONFIG_DMA_ENGINE=y

#
# DMA Clients
#
CONFIG_NET_DMA=y

#
# DMA Devices
#
CONFIG_INTEL_IOATDMA=m

#
# Virtualization
#
# CONFIG_KVM is not set

#
# File systems
#
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
# CONFIG_EXT4DEV_FS is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_MINIX_FS=m
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
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
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
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=y
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=y
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
# CONFIG_SUNRPC_BIND34 is not set
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
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
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

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
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
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
CONFIG_IPIPE_DEBUG=y
CONFIG_IPIPE_DEBUG_CONTEXT=y
CONFIG_IPIPE_TRACE=y
# CONFIG_IPIPE_TRACE_ENABLE is not set
CONFIG_IPIPE_TRACE_MCOUNT=y
CONFIG_IPIPE_TRACE_IRQSOFF=y
CONFIG_IPIPE_TRACE_SHIFT=14
# CONFIG_IPIPE_TRACE_VMALLOC is not set
CONFIG_IPIPE_TRACE_PANIC=y
CONFIG_IPIPE_TRACE_ENABLE_VALUE=0
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_TIMER_STATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
CONFIG_FRAME_POINTER=y
# CONFIG_FORCED_INLINING is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_4KSTACKS is not set
CONFIG_DOUBLEFAULT=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_ALGAPI=m
CONFIG_CRYPTO_BLKCIPHER=m
CONFIG_CRYPTO_HASH=m
CONFIG_CRYPTO_MANAGER=m
CONFIG_CRYPTO_HMAC=m
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_GF128MUL is not set
CONFIG_CRYPTO_ECB=m
CONFIG_CRYPTO_CBC=m
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_586 is not set
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_AES=m
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set
# CONFIG_CRYPTO_DEV_GEODE is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_CRC_CCITT=m
# CONFIG_CRC16 is not set
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=y
CONFIG_TEXTSEARCH_BM=y
CONFIG_TEXTSEARCH_FSM=y
CONFIG_PLIST=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_KTIME_SCALAR=y

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.6.22.9-xeno (tiniou@domain.hid) (gcc version 4.1.2 (Ubuntu 4.1.2-0ubuntu4)) #7 Fri Oct 12 11:51:48 CEST 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007eef3000 (usable)
 BIOS-e820: 000000007eef3000 - 000000007f0f4000 (ACPI NVS)
 BIOS-e820: 000000007f0f4000 - 000000007feb9000 (ACPI data)
 BIOS-e820: 000000007feb9000 - 000000007febf000 (reserved)
 BIOS-e820: 000000007febf000 - 000000007fed2000 (ACPI data)
 BIOS-e820: 000000007fed2000 - 000000007fed4000 (ACPI NVS)
 BIOS-e820: 000000007fed4000 - 000000007fed7000 (ACPI data)
 BIOS-e820: 000000007fed7000 - 000000007feda000 (ACPI NVS)
 BIOS-e820: 000000007feda000 - 000000007fedb000 (ACPI data)
 BIOS-e820: 000000007fedb000 - 000000007feef000 (ACPI NVS)
 BIOS-e820: 000000007feef000 - 000000007ff00000 (ACPI data)
 BIOS-e820: 000000007ff00000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
1134MB HIGHMEM available.
896MB LOWMEM available.
Entering add_active_range(0, 0, 519923) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   519923
early_node_map[1] active PFN ranges
    0:        0 ->   519923
On node 0 totalpages: 519923
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 2269 pages used for memmap
  HighMem zone: 288278 pages, LIFO batch:31
DMI 2.4 present.
ACPI: RSDP 000FE020, 0024 (r2 APPLE )
ACPI: XSDT 7FEFE1C0, 0084 (r1 APPLE   Apple00       70       1000013)
ACPI: FACP 7FEFC000, 00F4 (r3 APPLE   Apple00       70 Loki       5F)
ACPI: DSDT 7FEF1000, 48AD (r1 APPLE  MacBookP    30001 INTL 20061109)
ACPI: FACS 7FEDB000, 0040
ACPI: HPET 7FEFB000, 0038 (r1 APPLE   Apple00        1 Loki       5F)
ACPI: APIC 7FEFA000, 0068 (r1 APPLE   Apple00        1 Loki       5F)
ACPI: MCFG 7FEF9000, 003C (r1 APPLE   Apple00        1 Loki       5F)
ACPI: ASF! 7FEF8000, 00A5 (r32 APPLE   Apple00        1 Loki       5F)
ACPI: SBST 7FEF7000, 0030 (r1 APPLE   Apple00        1 Loki       5F)
ACPI: ECDT 7FEF6000, 0053 (r1 APPLE   Apple00        1 Loki       5F)
ACPI: SSDT 7FED6000, 04DC (r1  APPLE    CpuPm     3000 INTL 20061109)
ACPI: SSDT 7FED5000, 025F (r1  APPLE  Cpu0Tst     3000 INTL 20061109)
ACPI: SSDT 7FED4000, 00A6 (r1  APPLE  Cpu1Tst     3000 INTL 20061109)
ACPI: SSDT 7FEF0000, 0544 (r1 SataRe  SataPri     1000 INTL 20061109)
ACPI: SSDT 7FEEF000, 0477 (r1 SataRe  SataSec     1000 INTL 20061109)
ACPI: PM-Timer IO Port: 0x408
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Allocating PCI resources starting at 88000000 (gap: 80000000:70000000)
Built 1 zonelists.  Total pages: 515862
Kernel command line: root=UUID=e2703a16-a6c6-4ebd-9de6-840934c45dc1 ro nmi_watchdog=1
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2394.167 MHz processor.
I-pipe 1.10-07: pipeline enabled.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2052904k/2079692k available (2447k kernel code, 25516k reserved, 2344k data, 204k init, 1162188k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffea000 - 0xfffff000   (  84 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc05b2000 - 0xc05e5000   ( 204 kB)
      .data : 0xc0363fad - 0xc05ae284   (2344 kB)
      .text : 0xc0100000 - 0xc0363fad   (2447 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
Calibrating delay using timer specific routine.. 4790.37 BogoMIPS (lpj=9580740)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000e3bd 00000000 00000001
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: After all inits, caps: bfebfbff 20100000 00000000 00003940 0000e3bd 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: Intel(R) Core(TM)2 Duo CPU     T7700  @ 2.40GHz stepping 0a
Checking 'hlt' instruction... OK.
ACPI: Core revision 20070126
ACPI: setting ELCR to 0200 (from 0ea0)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@domain.hid
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP05._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 *7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 9 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 2.21 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 5 of device 0000:00:1f.2
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
pnp: 00:01: iomem range 0xfed1c000-0xfed1ffff could not be reserved
pnp: 00:01: iomem range 0xfed14000-0xfed17fff could not be reserved
pnp: 00:01: iomem range 0xfed18000-0xfed18fff could not be reserved
pnp: 00:01: iomem range 0xfed19000-0xfed19fff could not be reserved
pnp: 00:05: iomem range 0xfed00000-0xfed003ff has been reserved
Time: tsc clocksource has been installed.
PCI: Bridge: 0000:00:01.0
  IO window: 5000-5fff
  MEM window: 90000000-930fffff
  PREFETCH window: 80000000-8fffffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: 9b400000-9b4fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.2
  IO window: 4000-4fff
  MEM window: 97400000-9b3fffff
  PREFETCH window: 93100000-970fffff
PCI: Bridge: 0000:00:1c.4
  IO window: disabled.
  MEM window: 97300000-973fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.5
  IO window: 3000-3fff
  MEM window: 97200000-972fffff
  PREFETCH window: 9b600000-9b6fffff
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: 97100000-971fffff
  PREFETCH window: disabled.
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:01.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Enabling device 0000:00:1c.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:00:1c.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Enabling device 0000:00:1c.2 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:1c.2[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1c.2 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1c.4 to 64
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI Interrupt 0000:00:1c.5[B] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1c.5 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 2946k freed
I-pipe: Domain Xenomai registered.
Xenomai: hal/x86 started.
Xenomai: real-time nucleus v2.4-rc3 (Bells Of Lal) loaded.
highmem bounce pool size: 64 pages
io scheduler noop registered
io scheduler anticipatory registered (default)
Boot video device is 0000:01:00.0
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Lid Switch as /class/input/input1
ACPI: Lid Switch [LID0]
input: Power Button (CM) as /class/input/input2
ACPI: Power Button (CM) [PWRB]
input: Sleep Button (CM) as /class/input/input3
ACPI: Sleep Button (CM) [SLPB]
Real Time Clock Driver v1.12ac
hpet_resources: 0xfed00000 is busy
Non-volatile memory driver v1.2
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: module loaded
Linux video capture interface: v2.00
input: Macintosh mouse button emulation as /class/input/input4
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH8M: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKF] -> GSI 11 (level, low) -> IRQ 11
ICH8M: chipset revision 3
ICH8M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x60e0-0x60e7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x60e8-0x60ef, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: HL-DT-ST DVDRW GSA-S10N, ATAPI CD/DVD-ROM drive
hda: selected mode 0x42
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ata_piix 0000:00:1f.2: version 2.11
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: SATA max UDMA/133 cmd 0x000160f8 ctl 0x00016116 bmdma 0x00016020 irq 5
ata2: SATA max UDMA/133 cmd 0x000160f0 ctl 0x00016112 bmdma 0x00016028 irq 5
ata1.00: ATA-8: FUJITSU MHW2160BHPL, 0081001C, max UDMA/100
ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/100
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHW2160B 0081 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
PNP: No PS/2 controller found. Probing ports directly.
i8042.c: No controller found.
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@domain.hid
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new interface driver hci_usb
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (8192 buckets, 65536 max)
ip_tables: (C) 2000-2006 Netfilter Core Team
ClusterIP Version 0.8 loaded successfully
arp_tables: (C) 2002 David S. Miller
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
Using IPI Shortcut mode
Freeing unused kernel memory: 204k freed
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1a.0[A] -> Link [LNKE] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1a.0 to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1a.0: irq 10, io base 0x000060c0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1a.1[B] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1a.1 to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1a.1: irq 10, io base 0x000060a0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.0: irq 10, io base 0x00006080
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.1: irq 5, io base 0x00006060
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-1: new full speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKF] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.2: irq 11, io base 0x00006040
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
device-mapper: table: 254:3: linear: Invalid argument count
device-mapper: ioctl: error adding target to table
device-mapper: table: 254:4: linear: Invalid argument count
device-mapper: ioctl: error adding target to table
usb 1-1: configuration #1 chosen from 1 choice
device-mapper: table: 254:5: linear: Invalid argument count
device-mapper: ioctl: error adding target to table
ACPI: PCI Interrupt 0000:00:1a.7[C] -> Link [LNKF] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1a.7 to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 6
ehci_hcd 0000:00:1a.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1a.7
ehci_hcd 0000:00:1a.7: irq 11, io mem 0x9b504c00
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKE] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 7
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 10, io mem 0x9b504800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 6 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:0d:03.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[97104000-971047ff]  Max Packet=[4096]  IR/IT contexts=[4/8]
usb 1-1: USB disconnect, address 2
usb 7-4: new high speed USB device using ehci_hcd and address 2
usb 7-4: configuration #1 chosen from 1 choice
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[001cb3fffe862bcc]
usb 1-1: new full speed USB device using uhci_hcd and address 3
usb 1-1: configuration #1 chosen from 1 choice
drivers/hid/usbhid/hid-core.c: couldn't find an input interrupt endpoint
Linux agpgart interface v0.102 (c) Dave Jones
usb 5-1: new low speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt 0000:0c:00.0[A] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:0c:00.0 to 64
sky2 0000:0c:00.0: v1.14 addr 0x97200000 irq 7 Yukon-EC Ultra (0xb4) rev 3
sky2 eth0: addr 00:1b:63:94:3e:34
usb 5-1: configuration #1 chosen from 1 choice
input: Apple Computer, Inc. IR Receiver as /class/input/input5
input: USB HID v1.11 Device [Apple Computer, Inc. IR Receiver] on usb-0000:00:1d.2-1
usb 5-2: new full speed USB device using uhci_hcd and address 3
ACPI: PCI Interrupt 0000:00:1b.0[A] -> Link [LNKE] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1b.0 to 64
usb 5-2: configuration #1 chosen from 1 choice
input: Apple Computer Apple Internal Keyboard / Trackpad as /class/input/input6
input: USB HID v1.11 Keyboard [Apple Computer Apple Internal Keyboard / Trackpad] on usb-0000:00:1d.2-2
input: Apple Computer Apple Internal Keyboard / Trackpad as /class/input/input7
input: USB HID v1.11 Device [Apple Computer Apple Internal Keyboard / Trackpad] on usb-0000:00:1d.2-2
hda_codec: Unknown model for ALC882, trying auto-probe from BIOS...
appletouch Geyser 3 inited.
input: appletouch as /class/input/input8
usbcore: registered new interface driver appletouch
applesmc: Apple MacBook Pro detected:
applesmc:  - Model with accelerometer
applesmc:  - Model with light sensors and backlight
applesmc:  - Model with 12 temperature sensors
applesmc: device has already been initialized (0xe0, 0xf8).
applesmc: device successfully initialized.
applesmc: 2 fans found.
input: applesmc as /class/input/input9
Registered led device: smc:kbd_backlight
applesmc: driver successfully loaded.
EXT3 FS on sda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2097144k swap on /dev/mapper/macbookpro-swap.  Priority:-1 extents:1 across:2097144k
NET: Registered protocol family 15
Initializing XFRM netlink socket
sky2 eth0: enabling interface
sky2 eth0: ram buffer 0K
sky2 eth0: Link is up at 100 Mbps, full duplex, flow control both
Installing knfsd (copyright (C) 1996 okir@domain.hid).
usb 1-1: usbfs: USBDEVFS_CONTROL failed cmd hid2hci rqt 64 rq 0 len 0 ret -84
INPUT:IN=eth0 OUT= MAC= SRC=192.168.6.7 DST=224.0.0.251 LEN=248 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=228 
usb 1-1: USB disconnect, address 3

--gKMricLos+KVdGMg--

