Message-ID: <44F75C54.90608@domain.hid>
Date: Thu, 31 Aug 2006 17:01:56 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
References: <44F6E774.2000701@domain.hid> <44F72F35.4070109@domain.hid>
In-Reply-To: <44F72F35.4070109@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Kernel panic with Xenomai SMP kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Hello Xenomai crew,

A few months ago, I tried out xenomai 2.1-rc3 and 2.1-rc4 on my Fedora Core 1 system.  (2.4 kernel / standard AMD Athlon XP machine.)  At that time, I was able to patch the kernel and install xenomai without too much trouble.

Now, I am setting up a new machine to start the more serious work of porting our existing rtlinux simulation to xenomai.  The new machine is an Athlon64 X2 processor running Fedora Core 5.  I realize that the x86_64 architecture is not supported, so I installed the 32-bit version of FC5 on a second partition for use with xenomai.  I attempted to compile a xenomai-patched SMP kernel using my 32-bit OS, but got a kernel panic when I tried to boot it.  After much fiddling with config options, I discovered that if I disable SMP, the kernel will boot fine, and the xenomai latency test appears to give good results.  This is a good sign, but I would obviously prefer to use my second processor, if possible.  I am hoping someone on this list will be able to help me track down the problem.

Here is my build procedure:

  Download linux-2.6.17.7 from kernel.org (tried 2.6.17.11 also)
  Run the xenomai-2.2.1 prepare-kernel.sh script:
    xenomai-2.2.1/scripts/prepare-kernel.sh --arch=i386
      --adeos=xenomai-2.2.1/ksrc/arch/i386/patches/adeos-ipipe-2.6.17-i386-1.3-09.patch
      --linux=linux-2.6.17.7
  Modify the linux-2.6.17.7/scripts/package/mkspec program to generate more fedora-like
    RPMS.  (uses mkinitrd when installing)
  Modify EXTRAVERSION in the top-level Makefile
  make xconfig
  Load the config from my default FC5 32-bit kernel:
    /boot/config-2.6.17-1.2174_FC5smp
  Modify the kernel config:
    Disable ACPI/processor
    Disable APM
    Disable CPU frequency scaling
    Enable ext3 (compiled-in support)
    Disable DVB (digital video drivers)
  Save the config
  make rpm
  rpm -i /usr/src/redhat/RPMS/i386/kernel-2.6.17.7xenomai2.2.1-3.i386.rpm
  Modify grub config
  reboot

This gives me a kernel panic.  I can't capture the output, but here is the gist of it (hand copied, so there may be some typos):

  Process: swapper (pid:1 threadinfo=f7e09000 task=f7e1f5b0)
  Call Trace:
    _spin_lock_irqsave
    vgacon_set_cursor_size
    __ipipe_stall_root
    set_cursor
    vt_console_print
    vt_console_print
    __ipipe_unstall_root
    release_console_sem
    vprintk
    delay_pmtmr
    print_cpu_info
    do_boot_cpu
    printk
    smp_prepare_cpus
    __ipipe_unstall_root
    set_cpus_allowed
    __might_sleep
    init
    __ipipe_unstall_iret_root
    restore_raw
    init
    init
    kernel_thread_helper
  EIP: [<c04e72d8>] setup_IO_APIC+0x76/0x116b SS:ESP 0068:f7e09d89

If I repeat the build procedure described above, but disable SMP as well, I get a kernel that boots and seems to work fine.


Here is my CPU information:

# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm)64 X2 Dual Core Processor  4400+
stepping        : 2
cpu MHz         : 2210.316
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm 3dnowext 3dnow up pni lahf_lm cmp_legacy ts fid vid ttp
bogomips        : 4425.43


The kernel config file is probably too long to send to the list, so here is the difference between a working UP and a broken SMP config file.  I can send the configs to anyone who wants to take a look at them.

# diff -y --suppress-common-lines -W72 config.smp.broken config.up.works

# Wed Aug 30 16:45:00 2006         |    # Thu Aug 31 14:29:28 2006
CONFIG_LOCK_KERNEL=y               |    CONFIG_BROKEN_ON_SMP=y
CONFIG_CPUSETS=y                   <
CONFIG_STOP_MACHINE=y              <
# CONFIG_XENO_HW_NMI_DEBUG_LATEN   <
CONFIG_SMP=y                       |    # CONFIG_SMP is not set
# CONFIG_X86_PC is not set         |    CONFIG_X86_PC=y
CONFIG_X86_GENERICARCH=y           |    # CONFIG_X86_GENERICARCH is not
CONFIG_X86_CYCLONE_TIMER=y         <
CONFIG_NR_CPUS=32                  <
CONFIG_SCHED_SMT=y                 <
CONFIG_SCHED_MC=y                  <
CONFIG_PREEMPT_BKL=y               <
CONFIG_X86_LOCAL_APIC=y            |    # CONFIG_X86_UP_APIC is not set
CONFIG_X86_IO_APIC=y               <
CONFIG_X86_MCE_P4THERMAL=y         <
# CONFIG_NUMA is not set           |    CONFIG_ARCH_FLATMEM_ENABLE=y
                                   >    CONFIG_ARCH_SPARSEMEM_ENABLE=y
                                   >    CONFIG_ARCH_SELECT_MEMORY_MODEL=
# CONFIG_SPARSEMEM_STATIC is not   |    CONFIG_SPARSEMEM_STATIC=y
# CONFIG_IRQBALANCE is not set     <
CONFIG_HOTPLUG_CPU=y               <
CONFIG_SUSPEND_SMP=y               <
CONFIG_PCI_MSI=y                   <
CONFIG_HOTPLUG_PCI_IBM=m           <
                                   >    # CONFIG_IRPORT_SIR is not set
                                   >    # CONFIG_PCMCIA_XIRTULIP is not
                                   >    # CONFIG_ISDN_DRV_LOOP is not se
                                   >    # CONFIG_HYSDN is not set
                                   >    # CONFIG_RISCOM8 is not set
                                   >    # CONFIG_FTAPE is not set
                                   >    # CONFIG_I2C_ELEKTOR is not set
CONFIG_X86_FIND_SMP_CONFIG=y       <
CONFIG_X86_MPPARSE=y               <
CONFIG_GENERIC_PENDING_IRQ=y       <
CONFIG_X86_SMP=y                   <
CONFIG_X86_HT=y                    <
CONFIG_X86_TRAMPOLINE=y            <


Thanks!

-Jeff

