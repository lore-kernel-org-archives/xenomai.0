Date: Tue, 02 Sep 2008 00:20:45 -0700
From: Sam Ferguson <samf48@domain.hid>
Message-ID: <C4E2375D.857%samf48@domain.hid>
Mime-version: 1.0
Content-type: multipart/alternative;
	boundary="B_3303159646_612702"
Subject: [Xenomai-help] Xenomai kernel compile issue
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

> This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--B_3303159646_612702
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable

Hello, I=E2=80=99m trying to compile Xenomai by following the Xenomai Quick build
guide found on this page: <
http://www.xenomai.org/index.php/Xenomai_quick_build_quide> however I run
across a compiling error shown here:
igvc@domain.hid$ sudo cp /boot/config-2.6.25.11
.config
igvc@domain.hid$ sudo make menuconfig
scripts/kconfig/mconf arch/x86/Kconfig
#
# configuration written to .config
#


*** End of Linux kernel configuration.
*** Execute 'make' to build the kernel or try 'make help'.

igvc@domain.hid$ sudo make
scripts/kconfig/conf -s arch/x86/Kconfig
#
# configuration written to .config
#
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CC      arch/x86/kernel/asm-offsets.s
  GEN     include/asm-x86/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CC      init/main.o
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  CC      init/do_mounts.o
  CC      init/do_mounts_rd.o
  CC      init/do_mounts_initrd.o
  LD      init/mounts.o
  CC      init/initramfs.o
  CC      init/calibrate.o
  LD      init/built-in.o
  CC      arch/x86/kernel/process_32.o
  CC      arch/x86/kernel/signal_32.o
  AS      arch/x86/kernel/entry_32.o
  CC      arch/x86/kernel/traps_32.o
  CC      arch/x86/kernel/irq_32.o
  CC      arch/x86/kernel/time_32.o
  CC      arch/x86/kernel/ioport.o
  CC      arch/x86/kernel/ldt.o
  CC      arch/x86/kernel/setup_32.o
  CC      arch/x86/kernel/i8259_32.o
  CC      arch/x86/kernel/sys_i386_32.o
  CC      arch/x86/kernel/i386_ksyms_32.o
  CC      arch/x86/kernel/pci-dma_32.o
  CC      arch/x86/kernel/bootflag.o
  CC      arch/x86/kernel/e820_32.o
  CC      arch/x86/kernel/quirks.o
  CC      arch/x86/kernel/i8237.o
  CC      arch/x86/kernel/topology.o
  CC      arch/x86/kernel/kdebugfs.o
  CC      arch/x86/kernel/alternative.o
  CC      arch/x86/kernel/i8253.o
  CC      arch/x86/kernel/tsc_32.o
  CC      arch/x86/kernel/io_delay.o
  CC      arch/x86/kernel/rtc.o
  CC      arch/x86/kernel/i387.o
  CC      arch/x86/kernel/ptrace.o
  CC      arch/x86/kernel/ds.o
  CC      arch/x86/kernel/tls.o
  CC      arch/x86/kernel/step.o
  CC      arch/x86/kernel/cpu/intel_cacheinfo.o
  CC      arch/x86/kernel/cpu/addon_cpuid_features.o
  CC      arch/x86/kernel/cpu/feature_names.o
  CC      arch/x86/kernel/cpu/common.o
  CC      arch/x86/kernel/cpu/proc.o
  CC      arch/x86/kernel/cpu/bugs.o
  CC      arch/x86/kernel/cpu/amd.o
  CC      arch/x86/kernel/cpu/cyrix.o
  CC      arch/x86/kernel/cpu/centaur.o
  CC      arch/x86/kernel/cpu/transmeta.o
  CC      arch/x86/kernel/cpu/intel.o
  CC      arch/x86/kernel/cpu/nexgen.o
  CC      arch/x86/kernel/cpu/umc.o
  CC      arch/x86/kernel/cpu/mtrr/main.o
  CC      arch/x86/kernel/cpu/mtrr/if.o
  CC      arch/x86/kernel/cpu/mtrr/generic.o
  CC      arch/x86/kernel/cpu/mtrr/stateo
  CC      arch/x86/kernel/cpu/mtrr/amd.o
  CC      arch/x86/kernel/cpu/mtrr/cyrixo
  CC      arch/x86/kernel/cpu/mtrr/centaur.o
  LD      arch/x86/kernel/cpu/mtrr/built-in.o
  CC      arch/x86/kernel/cpu/perfctr-watchdog.o
  LD      arch/x86/kernel/cpu/built-in.o
  CC      arch/x86/kernel/reboot.o
  CC      arch/x86/kernel/mca_32.o
  CC      arch/x86/kernel/early-quirks.o
  CC      arch/x86/kernel/mpparse_32.o
  CC      arch/x86/kernel/apic_32.o
  CC      arch/x86/kernel/nmi_32.o
  CC      arch/x86/kernel/reboot_fixups_32.o
  CC      arch/x86/kernel/machine_kexec_32.o
  CC      arch/x86/kernel/crash.o
  CC      arch/x86/kernel/crash_dump_32.o
  CC      arch/x86/kernel/kprobes.o
  CC      arch/x86/kernel/module_32.o
  CC      arch/x86/kernel/doublefault_32o
  CC      arch/x86/kernel/vm86_32.o
  CC      arch/x86/kernel/early_printk.o
  CC      arch/x86/kernel/k8.o
  CC      arch/x86/kernel/vmi_32.o
  CC      arch/x86/kernel/vmiclock_32.o
  CC      arch/x86/kernel/paravirt.o
  CC      arch/x86/kernel/paravirt_patch_32.o
  CC      arch/x86/kernel/pcspeaker.o
  LD      arch/x86/kernel/built-in.o
  AS      arch/x86/kernel/head_32.o
  CC      arch/x86/kernel/init_task.o
  LDS     arch/x86/kernel/vmlinux.lds
  CC [M]  arch/x86/kernel/msr.o
  CC [M]  arch/x86/kernel/cpuid.o
  CC [M]  arch/x86/kernel/microcode.o
  CC [M]  arch/x86/kernel/scx200_32.o
  LD [M]  arch/x86/kernel/scx200.o
  CC      arch/x86/mm/init_32.o
  CC      arch/x86/mm/pgtable_32.o
  CC      arch/x86/mm/fault.o
  CC      arch/x86/mm/ioremap.o
  CC      arch/x86/mm/extable.o
  CC      arch/x86/mm/pageattr.o
  CC      arch/x86/mm/mmap.o
  CC      arch/x86/mm/highmem_32.o
  LD      arch/x86/mm/built-in.o
  CC      arch/x86/mach-default/setup.o
  LD      arch/x86/mach-default/built-ino
  AS [M]  arch/x86/crypto/aes-i586-asm_32.o
  CC [M]  arch/x86/crypto/aes_glue.o
  AS [M]  arch/x86/crypto/twofish-i586-asm_32.o
  CC [M]  arch/x86/crypto/twofish_glue.o
  LD [M]  arch/x86/crypto/aes-i586.o
  LD [M]  arch/x86/crypto/twofish-i586.o
  AS      arch/x86/vdso/vdso32/int80.o
  VDSO    arch/x86/vdso/vdso32-int80.so.dbg
  OBJCOPY arch/x86/vdso/vdso32-int80.so
  AS      arch/x86/vdso/vdso32/sysenter.o
  VDSO    arch/x86/vdso/vdso32-sysenter.so.dbg
  OBJCOPY arch/x86/vdso/vdso32-sysenter.so
  AS      arch/x86/vdso/vdso32.o
  CC      arch/x86/vdso/vdso32-setup.o
  VDSOSYM arch/x86/vdso/vdso32-int80-syms.lds
  VDSOSYM arch/x86/vdso/vdso32-sysenter-syms.lds
  VDSOSYM arch/x86/vdso/vdso32-syms.lds
  LD      arch/x86/vdso/built-in.o
  CC      kernel/sched.o
kernel/sched.c:1027: warning: =E2=80=9A=C3=84=C3=B2init_hrtick=E2=80=9A=C3=84=C3=B4 defined but not use=
d
  CC      kernel/fork.o
  CC      kernel/exec_domain.o
  CC      kernel/panic.o
  CC      kernel/printk.o
  CC      kernel/profile.o
  CC      kernel/exit.o
  CC      kernel/itimer.o
  CC      kernel/time.o
  CC      kernel/softirq.o
  CC      kernel/resource.o
  CC      kernel/sysctl.o
  CC      kernel/capability.o
  CC      kernel/ptrace.o
  CC      kernel/timer.o
  CC      kernel/user.o
  CC      kernel/signal.o
  CC      kernel/sys.o
  CC      kernel/kmod.o
  CC      kernel/workqueue.o
  CC      kernel/pid.o
  CC      kernel/rcupdate.o
  CC      kernel/extable.o
  CC      kernel/params.o
  CC      kernel/posix-timers.o
  CC      kernel/kthread.o
  CC      kernel/wait.o
  CC      kernel/kfifo.o
  CC      kernel/posix-cpu-timers.o
  CC      kernel/mutex.o
  CC      kernel/hrtimer.o
  CC      kernel/rwsem.o
  CC      kernel/nsproxy.o
  CC      kernel/srcu.o
  CC      kernel/notifier.o
  CC      kernel/ksysfs.o
  CC      kernel/pm_qos_params.o
  CC      kernel/sysctl_check.o
  CC      kernel/irq/handle.o
  CC      kernel/irq/manage.o
  CC      kernel/irq/spurious.o
  CC      kernel/irq/resend.o
  CC      kernel/irq/chip.o
  CC      kernel/irq/devres.o
  CC      kernel/irq/autoprobe.o
  CC      kernel/irq/proc.o
  LD      kernel/irq/built-in.o
  CC      kernel/time/timekeeping.o
  CC      kernel/time/ntp.o
  CC      kernel/time/clocksource.o
  CC      kernel/time/jiffies.o
  CC      kernel/time/timer_list.o
  CC      kernel/time/clockevents.o
  CC      kernel/time/tick-common.o
  CC      kernel/time/tick-broadcast.o
  CC      kernel/time/tick-oneshot.o
  CC      kernel/time/tick-sched.o
  CC      kernel/time/timer_stats.o
  LD      kernel/time/built-in.o
  CC      kernel/xenomai/arch/generic/hal.o
In file included from kernel/xenomai/arch/generic/hal.c:47:
include/asm/xenomai/hal.h:65: warning: =E2=80=9A=C3=84=C3=B2struct ipipe_tick_device=E2=80=9A=C3=84=
=C3=B4
declared inside parameter list
include/asm/xenomai/hal.h:65: warning: its scope is only this definition or
declaration, which is probably not what you want
include/asm/xenomai/hal.h:65: warning: =E2=80=9A=C3=84=C3=B2enum clock_event_mode=E2=80=9A=C3=84=C3=B4 =
declared
inside parameter list
include/asm/xenomai/hal.h:67: warning: =E2=80=9A=C3=84=C3=B2struct ipipe_tick_device=E2=80=9A=C3=84=
=C3=B4
declared inside parameter list
In file included from include/asm/xenomai/hal_32.h:54,
                 from include/asm/xenomai/hal.h:73,
                 from kernel/xenomai/arch/generic/hal.c:47:
include/asm-generic/xenomai/hal.h: In function =E2=80=9A=C3=84=C3=B2rthal_get_cpufreq=E2=80=9A=C3=
=84=C3=B4:
include/asm-generic/xenomai/hal.h:166: error: storage size of =E2=80=9A=C3=84=C3=B2sysinf=
o=E2=80=9A=C3=84=C3=B4
isn=E2=80=9A=C3=84=C3=B4t known
include/asm-generic/xenomai/hal.h:167: error: implicit declaration of
function =E2=80=9A=C3=84=C3=B2ipipe_get_sysinfo=E2=80=9A=C3=84=C3=B4
include/asm-generic/xenomai/hal.h:166: warning: unused variable
=E2=80=9A=C3=84=C3=B2sysinfo=E2=80=9A=C3=84=C3=B4
include/asm-generic/xenomai/hal.h: In function =E2=80=9A=C3=84=C3=B2rthal_get_timerfreq=E2=80=
=9A=C3=84=C3=B4:
include/asm-generic/xenomai/hal.h:173: error: storage size of =E2=80=9A=C3=84=C3=B2sysinf=
o=E2=80=9A=C3=84=C3=B4
isn=E2=80=9A=C3=84=C3=B4t known
include/asm-generic/xenomai/hal.h:173: warning: unused variable
=E2=80=9A=C3=84=C3=B2sysinfo=E2=80=9A=C3=84=C3=B4
include/asm-generic/xenomai/hal.h: In function =E2=80=9A=C3=84=C3=B2set_task_nowakeup=E2=80=9A=C3=
=84=C3=B4:
include/asm-generic/xenomai/hal.h:240: error: =E2=80=9A=C3=84=C3=B2TASK_NOWAKEUP=E2=80=9A=C3=84=C3=B4 u=
ndeclared
(first use in this function)
include/asm-generic/xenomai/hal.h:240: error: (Each undeclared identifier i=
s
reported only once
include/asm-generic/xenomai/hal.h:240: error: for each function it appears
in.)
include/asm-generic/xenomai/hal.h: In function =E2=80=9A=C3=84=C3=B2clear_task_nowakeup=E2=80=
=9A=C3=84=C3=B4:
include/asm-generic/xenomai/hal.h:245: error: =E2=80=9A=C3=84=C3=B2TASK_NOWAKEUP=E2=80=9A=C3=84=C3=B4 u=
ndeclared
(first use in this function)
include/asm-generic/xenomai/hal.h: At top level:
include/asm-generic/xenomai/hal.h:328: error: expected =E2=80=9A=C3=84=C3=B2=3D=E2=80=9A=C3=84=C3=B4, =E2=80=9A=
=C3=84=C3=B2,=E2=80=9A=C3=84=C3=B4,
=E2=80=9A=C3=84=C3=B2;=E2=80=9A=C3=84=C3=B4, =E2=80=9A=C3=84=C3=B2asm=E2=80=9A=C3=84=C3=B4 or =E2=80=9A=C3=84=C3=B2__attribute__=E2=80=9A=C3=84=C3=B4 before =E2=80=
=9A=C3=84=C3=B2rthal_irq_handler_t=E2=80=9A=C3=84=C3=B4
include/asm-generic/xenomai/hal.h:329: error: expected =E2=80=9A=C3=84=C3=B2=3D=E2=80=9A=C3=84=C3=B4, =E2=80=9A=
=C3=84=C3=B2,=E2=80=9A=C3=84=C3=B4,
=E2=80=9A=C3=84=C3=B2;=E2=80=9A=C3=84=C3=B4, =E2=80=9A=C3=84=C3=B2asm=E2=80=9A=C3=84=C3=B4 or =E2=80=9A=C3=84=C3=B2__attribute__=E2=80=9A=C3=84=C3=B4 before =E2=80=
=9A=C3=84=C3=B2rthal_irq_ackfn_t=E2=80=9A=C3=84=C3=B4
include/asm-generic/xenomai/hal.h:353: error: =E2=80=9A=C3=84=C3=B2IPIPE_NR_CPUS=E2=80=9A=C3=84=C3=B4 u=
ndeclared
here (not in a function)
include/asm-generic/xenomai/hal.h:353: error: =E2=80=9A=C3=84=C3=B2IPIPE_NR_FAULTS=E2=80=9A=C3=84=C3=B4
undeclared here (not in a function)
include/asm-generic/xenomai/hal.h:403: error: expected declaration
specifiers or =E2=80=9A=C3=84=C3=B2...=E2=80=9A=C3=84=C3=B4 before =E2=80=9A=C3=84=C3=B2rthal_irq_handler_t=E2=80=9A=C3=84=C3=B4
include/asm-generic/xenomai/hal.h:404: error: expected declaration
specifiers or =E2=80=9A=C3=84=C3=B2...=E2=80=9A=C3=84=C3=B4 before =E2=80=9A=C3=84=C3=B2rthal_irq_ackfn_t=E2=80=9A=C3=84=C3=B4
include/asm-generic/xenomai/hal.h:443: warning: =E2=80=9A=C3=84=C3=B2enum clock_event_mod=
e=E2=80=9A=C3=84=C3=B4
declared inside parameter list
include/asm-generic/xenomai/hal.h:448: warning: =E2=80=9A=C3=84=C3=B2enum clock_event_mod=
e=E2=80=9A=C3=84=C3=B4
declared inside parameter list
In file included from include/asm/xenomai/hal.h:73,
                 from kernel/xenomai/arch/generic/hal.c:47:
include/asm/xenomai/hal_32.h: In function =E2=80=9A=C3=84=C3=B2rthal_rdtsc=E2=80=9A=C3=84=C3=B4:
include/asm/xenomai/hal_32.h:128: error: implicit declaration of function
=E2=80=9A=C3=84=C3=B2ipipe_read_tsc=E2=80=9A=C3=84=C3=B4
include/asm/xenomai/hal_32.h: In function =E2=80=9A=C3=84=C3=B2rthal_timer_program_shot=E2=80=
=9A=C3=84=C3=B4:
include/asm/xenomai/hal_32.h:150: error: implicit declaration of function
=E2=80=9A=C3=84=C3=B2ipipe_trigger_irq=E2=80=9A=C3=84=C3=B4
include/asm/xenomai/hal_32.h:150: error: =E2=80=9A=C3=84=C3=B2IPIPE_SERVICE_IPI3=E2=80=9A=C3=84=C3=B4 u=
ndeclared
(first use in this function)
kernel/xenomai/arch/generic/hal.c: In function =E2=80=9A=C3=84=C3=B2rthal_critical_enter=E2=
=80=9A=C3=84=C3=B4:
kernel/xenomai/arch/generic/hal.c:94: error: implicit declaration of
function =E2=80=9A=C3=84=C3=B2ipipe_critical_enter=E2=80=9A=C3=84=C3=B4
kernel/xenomai/arch/generic/hal.c: In function =E2=80=9A=C3=84=C3=B2rthal_critical_exit=E2=80=
=9A=C3=84=C3=B4:
kernel/xenomai/arch/generic/hal.c:107: error: implicit declaration of
function =E2=80=9A=C3=84=C3=B2ipipe_critical_exit=E2=80=9A=C3=84=C3=B4
kernel/xenomai/arch/generic/hal.c: At top level:
kernel/xenomai/arch/generic/hal.c:159: error: expected declaration
specifiers or =E2=80=9A=C3=84=C3=B2...=E2=80=9A=C3=84=C3=B4 before =E2=80=9A=C3=84=C3=B2rthal_irq_handler_t=E2=80=9A=C3=84=C3=B4
kernel/xenomai/arch/generic/hal.c:160: error: expected declaration
specifiers or =E2=80=9A=C3=84=C3=B2...=E2=80=9A=C3=84=C3=B4 before =E2=80=9A=C3=84=C3=B2rthal_irq_ackfn_t=E2=80=9A=C3=84=C3=B4
kernel/xenomai/arch/generic/hal.c: In function =E2=80=9A=C3=84=C3=B2rthal_irq_request=E2=80=9A=C3=
=84=C3=B4:
kernel/xenomai/arch/generic/hal.c:162: error: =E2=80=9A=C3=84=C3=B2handler=E2=80=9A=C3=84=C3=B4 undecla=
red
(first use in this function)
kernel/xenomai/arch/generic/hal.c:162: error: =E2=80=9A=C3=84=C3=B2IPIPE_NR_IRQS=E2=80=9A=C3=84=C3=B4 u=
ndeclared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:165: error: implicit declaration of
function =E2=80=9A=C3=84=C3=B2ipipe_virtualize_irq=E2=80=9A=C3=84=C3=B4
kernel/xenomai/arch/generic/hal.c:165: error: =E2=80=9A=C3=84=C3=B2ackfn=E2=80=9A=C3=84=C3=B4 undeclare=
d (first
use in this function)
kernel/xenomai/arch/generic/hal.c:165: error: =E2=80=9A=C3=84=C3=B2IPIPE_HANDLE_MASK=E2=80=9A=C3=84=
=C3=B4
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:165: error: =E2=80=9A=C3=84=C3=B2IPIPE_WIRED_MASK=E2=80=9A=C3=84=C3=
=B4
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:165: error: =E2=80=9A=C3=84=C3=B2IPIPE_EXCLUSIVE_MASK=E2=80=
=9A=C3=84=C3=B4
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c: In function =E2=80=9A=C3=84=C3=B2rthal_irq_release=E2=80=9A=C3=
=84=C3=B4:
kernel/xenomai/arch/generic/hal.c:202: error: =E2=80=9A=C3=84=C3=B2IPIPE_NR_IRQS=E2=80=9A=C3=84=C3=B4 u=
ndeclared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:205: error: =E2=80=9A=C3=84=C3=B2IPIPE_PASS_MASK=E2=80=9A=C3=84=C3=B4
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c: In function =E2=80=9A=C3=84=C3=B2rthal_irq_host_pend=E2=80=
=9A=C3=84=C3=B4:
kernel/xenomai/arch/generic/hal.c:302: error: implicit declaration of
function =E2=80=9A=C3=84=C3=B2ipipe_propagate_irq=E2=80=9A=C3=84=C3=B4
kernel/xenomai/arch/generic/hal.c: In function =E2=80=9A=C3=84=C3=B2rthal_apc_handler=E2=80=9A=C3=
=84=C3=B4:
kernel/xenomai/arch/generic/hal.c:401: error: implicit declaration of
function =E2=80=9A=C3=84=C3=B2ipipe_processor_id=E2=80=9A=C3=84=C3=B4
kernel/xenomai/arch/generic/hal.c: In function =E2=80=9A=C3=84=C3=B2rthal_apc_alloc=E2=80=9A=C3=84=C3=
=B4:
kernel/xenomai/arch/generic/hal.c:525: error: implicit declaration of
function =E2=80=9A=C3=84=C3=B2ipipe_test_and_stall_pipeline_head=E2=80=9A=C3=84=C3=B4
kernel/xenomai/arch/generic/hal.c:536: error: implicit declaration of
function =E2=80=9A=C3=84=C3=B2ipipe_restore_pipeline_head=E2=80=9A=C3=84=C3=B4
kernel/xenomai/arch/generic/hal.c: In function =E2=80=9A=C3=84=C3=B2rthal_apc_schedule=E2=80=9A=
=C3=84=C3=B4:
kernel/xenomai/arch/generic/hal.c:610: error: implicit declaration of
function =E2=80=9A=C3=84=C3=B2ipipe_schedule_irq=E2=80=9A=C3=84=C3=B4
kernel/xenomai/arch/generic/hal.c: In function =E2=80=9A=C3=84=C3=B2hal_read_proc=E2=80=9A=C3=84=C3=B4:
kernel/xenomai/arch/generic/hal.c:627: error: =E2=80=9A=C3=84=C3=B2IPIPE_MAJOR_NUMBER=E2=80=9A=C3=
=84=C3=B4
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:628: error: =E2=80=9A=C3=84=C3=B2IPIPE_MINOR_NUMBER=E2=80=9A=C3=
=84=C3=B4
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:629: error: =E2=80=9A=C3=84=C3=B2IPIPE_PATCH_NUMBER=E2=80=9A=C3=
=84=C3=B4
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c: In function =E2=80=9A=C3=84=C3=B2rthal_init=E2=80=9A=C3=84=C3=B4:
kernel/xenomai/arch/generic/hal.c:798: error: implicit declaration of
function =E2=80=9A=C3=84=C3=B2ipipe_alloc_virq=E2=80=9A=C3=84=C3=B4
kernel/xenomai/arch/generic/hal.c:806: error: =E2=80=9A=C3=84=C3=B2ipipe_current_domain=E2=80=
=9A=C3=84=C3=B4
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:806: error: =E2=80=9A=C3=84=C3=B2IPIPE_HANDLE_MASK=E2=80=9A=C3=84=
=C3=B4
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:832: error: storage size of =E2=80=9A=C3=84=C3=B2attr=E2=80=
=9A=C3=84=C3=B4
isn=E2=80=9A=C3=84=C3=B4t known
kernel/xenomai/arch/generic/hal.c:832: error: implicit declaration of
function =E2=80=9A=C3=84=C3=B2ipipe_init_attr=E2=80=9A=C3=84=C3=B4
kernel/xenomai/arch/generic/hal.c:832: error: =E2=80=9A=C3=84=C3=B2IPIPE_HEAD_PRIORITY=E2=80=9A=
=C3=84=C3=B4
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:832: error: implicit declaration of
function =E2=80=9A=C3=84=C3=B2ipipe_register_domain=E2=80=9A=C3=84=C3=B4
kernel/xenomai/arch/generic/hal.c:832: warning: unused variable =E2=80=9A=C3=84=C3=B2attr=
=E2=80=9A=C3=84=C3=B4
kernel/xenomai/arch/generic/hal.c:873: error: implicit declaration of
function =E2=80=9A=C3=84=C3=B2ipipe_free_virq=E2=80=9A=C3=84=C3=B4
kernel/xenomai/arch/generic/hal.c: In function =E2=80=9A=C3=84=C3=B2rthal_exit=E2=80=9A=C3=84=C3=B4:
kernel/xenomai/arch/generic/hal.c:889: error: =E2=80=9A=C3=84=C3=B2ipipe_current_domain=E2=80=
=9A=C3=84=C3=B4
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:903: error: implicit declaration of
function =E2=80=9A=C3=84=C3=B2ipipe_unregister_domain=E2=80=9A=C3=84=C3=B4
make[4]: *** [kernel/xenomai/arch/generic/hal.o] Error 1
make[3]: *** [kernel/xenomai/arch/generic] Error 2
make[2]: *** [kernel/xenomai/arch] Error 2
make[1]: *** [kernel/xenomai] Error 2
make: *** [kernel] Error 2
igvc@domain.hid$







--B_3303159646_612702
Content-type: text/html;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable

<HTML>
<HEAD>
<TITLE>Xenomai kernel compile issue</TITLE>
</HEAD>
<BODY>
<FONT SIZE=3D"4"><FONT FACE=3D"Calibri, Verdana, Helvetica, Arial"><SPAN STYLE=3D=
'font-size:11pt'>Hello, I&#8217;m trying to compile Xenomai by following the=
 Xenomai Quick build guide found on this page: &lt; <FONT COLOR=3D"#0000FF"><U=
><a href=3D"http://www.xenomai.org/index.php/Xenomai_quick_build_quide">http:/=
/www.xenomai.org/index.php/Xenomai_quick_build_quide</a></U></FONT>&gt; howe=
ver I run across a compiling error shown here:<BR>
igvc@domain.hid$ sudo cp /boot/config-2.6.25.11 .=
config<BR>
igvc@domain.hid$ sudo make menuconfig<BR>
scripts/kconfig/mconf arch/x86/Kconfig<BR>
#<BR>
# configuration written to .config<BR>
#<BR>
<BR>
<BR>
*** End of Linux kernel configuration.<BR>
*** Execute 'make' to build the kernel or try 'make help'.<BR>
<BR>
igvc@domain.hid$ sudo make<BR>
scripts/kconfig/conf -s arch/x86/Kconfig<BR>
#<BR>
# configuration written to .config<BR>
#<BR>
&nbsp;&nbsp;CHK &nbsp;&nbsp;&nbsp;&nbsp;include/linux/version.h<BR>
&nbsp;&nbsp;CHK &nbsp;&nbsp;&nbsp;&nbsp;include/linux/utsrelease.h<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/asm-offsets.s<=
BR>
&nbsp;&nbsp;GEN &nbsp;&nbsp;&nbsp;&nbsp;include/asm-x86/asm-offsets.h<BR>
&nbsp;&nbsp;CALL &nbsp;&nbsp;&nbsp;scripts/checksyscalls.sh<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;init/main.o<BR>
&nbsp;&nbsp;CHK &nbsp;&nbsp;&nbsp;&nbsp;include/linux/compile.h<BR>
&nbsp;&nbsp;UPD &nbsp;&nbsp;&nbsp;&nbsp;include/linux/compile.h<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;init/version.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;init/do_mounts.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;init/do_mounts_rd.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;init/do_mounts_initrd.o<BR>
&nbsp;&nbsp;LD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;init/mounts.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;init/initramfs.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;init/calibrate.o<BR>
&nbsp;&nbsp;LD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;init/built-in.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/process_32.o<B=
R>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/signal_32.o<BR=
>
&nbsp;&nbsp;AS &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/entry_32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/traps_32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/irq_32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/time_32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/ioport.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/ldt.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/setup_32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/i8259_32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/sys_i386_32.o<=
BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/i386_ksyms_32.=
o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/pci-dma_32.o<B=
R>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/bootflag.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/e820_32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/quirks.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/i8237.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/topology.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/kdebugfs.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/alternative.o<=
BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/i8253.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/tsc_32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/io_delay.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/rtc.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/i387.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/ptrace.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/ds.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/tls.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/step.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/intel_cach=
einfo.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/addon_cpui=
d_features.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/feature_na=
mes.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/common.o<B=
R>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/proc.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/bugs.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/amd.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/cyrix.o<BR=
>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/centaur.o<=
BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/transmeta.=
o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/intel.o<BR=
>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/nexgen.o<B=
R>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/umc.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/mtrr/main.=
o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/mtrr/if.o<=
BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/mtrr/gener=
ic.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/mtrr/state=
o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/mtrr/amd.o=
<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/mtrr/cyrix=
o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/mtrr/centa=
ur.o<BR>
&nbsp;&nbsp;LD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/mtrr/built=
-in.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/perfctr-wa=
tchdog.o<BR>
&nbsp;&nbsp;LD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/cpu/built-in.o=
<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/reboot.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/mca_32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/early-quirks.o=
<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/mpparse_32.o<B=
R>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/apic_32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/nmi_32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/reboot_fixups_=
32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/machine_kexec_=
32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/crash.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/crash_dump_32.=
o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/kprobes.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/module_32.o<BR=
>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/doublefault_32=
o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/vm86_32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/early_printk.o=
<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/k8.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/vmi_32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/vmiclock_32.o<=
BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/paravirt.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/paravirt_patch=
_32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/pcspeaker.o<BR=
>
&nbsp;&nbsp;LD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/built-in.o<BR>
&nbsp;&nbsp;AS &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/head_32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/init_task.o<BR=
>
&nbsp;&nbsp;LDS &nbsp;&nbsp;&nbsp;&nbsp;arch/x86/kernel/vmlinux.lds<BR>
&nbsp;&nbsp;CC [M] &nbsp;arch/x86/kernel/msr.o<BR>
&nbsp;&nbsp;CC [M] &nbsp;arch/x86/kernel/cpuid.o<BR>
&nbsp;&nbsp;CC [M] &nbsp;arch/x86/kernel/microcode.o<BR>
&nbsp;&nbsp;CC [M] &nbsp;arch/x86/kernel/scx200_32.o<BR>
&nbsp;&nbsp;LD [M] &nbsp;arch/x86/kernel/scx200.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/mm/init_32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/mm/pgtable_32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/mm/fault.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/mm/ioremap.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/mm/extable.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/mm/pageattr.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/mm/mmap.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/mm/highmem_32.o<BR>
&nbsp;&nbsp;LD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/mm/built-in.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/mach-default/setup.o<=
BR>
&nbsp;&nbsp;LD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/mach-default/built-in=
o<BR>
&nbsp;&nbsp;AS [M] &nbsp;arch/x86/crypto/aes-i586-asm_32.o<BR>
&nbsp;&nbsp;CC [M] &nbsp;arch/x86/crypto/aes_glue.o<BR>
&nbsp;&nbsp;AS [M] &nbsp;arch/x86/crypto/twofish-i586-asm_32.o<BR>
&nbsp;&nbsp;CC [M] &nbsp;arch/x86/crypto/twofish_glue.o<BR>
&nbsp;&nbsp;LD [M] &nbsp;arch/x86/crypto/aes-i586.o<BR>
&nbsp;&nbsp;LD [M] &nbsp;arch/x86/crypto/twofish-i586.o<BR>
&nbsp;&nbsp;AS &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/vdso/vdso32/int80.o<B=
R>
&nbsp;&nbsp;VDSO &nbsp;&nbsp;&nbsp;arch/x86/vdso/vdso32-int80.so.dbg<BR>
&nbsp;&nbsp;OBJCOPY arch/x86/vdso/vdso32-int80.so<BR>
&nbsp;&nbsp;AS &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/vdso/vdso32/sysenter.=
o<BR>
&nbsp;&nbsp;VDSO &nbsp;&nbsp;&nbsp;arch/x86/vdso/vdso32-sysenter.so.dbg<BR>
&nbsp;&nbsp;OBJCOPY arch/x86/vdso/vdso32-sysenter.so<BR>
&nbsp;&nbsp;AS &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/vdso/vdso32.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/vdso/vdso32-setup.o<B=
R>
&nbsp;&nbsp;VDSOSYM arch/x86/vdso/vdso32-int80-syms.lds<BR>
&nbsp;&nbsp;VDSOSYM arch/x86/vdso/vdso32-sysenter-syms.lds<BR>
&nbsp;&nbsp;VDSOSYM arch/x86/vdso/vdso32-syms.lds<BR>
&nbsp;&nbsp;LD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86/vdso/built-in.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/sched.o<BR>
kernel/sched.c:1027: warning: &#8218;&Auml;&ograve;init_hrtick&#8218;&Auml;=
&ocirc; defined but not used<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/fork.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/exec_domain.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/panic.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/printk.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/profile.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/exit.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/itimer.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/time.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/softirq.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/resource.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/sysctl.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/capability.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/ptrace.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/timer.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/user.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/signal.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/sys.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/kmod.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/workqueue.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/pid.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/rcupdate.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/extable.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/params.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/posix-timers.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/kthread.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/wait.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/kfifo.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/posix-cpu-timers.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/mutex.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/hrtimer.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/rwsem.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/nsproxy.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/srcu.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/notifier.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/ksysfs.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/pm_qos_params.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/sysctl_check.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/irq/handle.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/irq/manage.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/irq/spurious.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/irq/resend.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/irq/chip.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/irq/devres.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/irq/autoprobe.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/irq/proc.o<BR>
&nbsp;&nbsp;LD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/irq/built-in.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/time/timekeeping.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/time/ntp.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/time/clocksource.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/time/jiffies.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/time/timer_list.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/time/clockevents.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/time/tick-common.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/time/tick-broadcast.o<B=
R>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/time/tick-oneshot.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/time/tick-sched.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/time/timer_stats.o<BR>
&nbsp;&nbsp;LD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/time/built-in.o<BR>
&nbsp;&nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/xenomai/arch/generic/ha=
l.o<BR>
In file included from kernel/xenomai/arch/generic/hal.c:47:<BR>
include/asm/xenomai/hal.h:65: warning: &#8218;&Auml;&ograve;struct ipipe_ti=
ck_device&#8218;&Auml;&ocirc; declared inside parameter list<BR>
include/asm/xenomai/hal.h:65: warning: its scope is only this definition or=
 declaration, which is probably not what you want<BR>
include/asm/xenomai/hal.h:65: warning: &#8218;&Auml;&ograve;enum clock_even=
t_mode&#8218;&Auml;&ocirc; declared inside parameter list<BR>
include/asm/xenomai/hal.h:67: warning: &#8218;&Auml;&ograve;struct ipipe_ti=
ck_device&#8218;&Auml;&ocirc; declared inside parameter list<BR>
In file included from include/asm/xenomai/hal_32.h:54,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;from include/asm/xenomai/hal.h:73,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;from kernel/xenomai/arch/generic/hal.c:47:<BR>
include/asm-generic/xenomai/hal.h: In function &#8218;&Auml;&ograve;rthal_g=
et_cpufreq&#8218;&Auml;&ocirc;:<BR>
include/asm-generic/xenomai/hal.h:166: error: storage size of &#8218;&Auml;=
&ograve;sysinfo&#8218;&Auml;&ocirc; isn&#8218;&Auml;&ocirc;t known<BR>
include/asm-generic/xenomai/hal.h:167: error: implicit declaration of funct=
ion &#8218;&Auml;&ograve;ipipe_get_sysinfo&#8218;&Auml;&ocirc;<BR>
include/asm-generic/xenomai/hal.h:166: warning: unused variable &#8218;&Aum=
l;&ograve;sysinfo&#8218;&Auml;&ocirc;<BR>
include/asm-generic/xenomai/hal.h: In function &#8218;&Auml;&ograve;rthal_g=
et_timerfreq&#8218;&Auml;&ocirc;:<BR>
include/asm-generic/xenomai/hal.h:173: error: storage size of &#8218;&Auml;=
&ograve;sysinfo&#8218;&Auml;&ocirc; isn&#8218;&Auml;&ocirc;t known<BR>
include/asm-generic/xenomai/hal.h:173: warning: unused variable &#8218;&Aum=
l;&ograve;sysinfo&#8218;&Auml;&ocirc;<BR>
include/asm-generic/xenomai/hal.h: In function &#8218;&Auml;&ograve;set_tas=
k_nowakeup&#8218;&Auml;&ocirc;:<BR>
include/asm-generic/xenomai/hal.h:240: error: &#8218;&Auml;&ograve;TASK_NOW=
AKEUP&#8218;&Auml;&ocirc; undeclared (first use in this function)<BR>
include/asm-generic/xenomai/hal.h:240: error: (Each undeclared identifier i=
s reported only once<BR>
include/asm-generic/xenomai/hal.h:240: error: for each function it appears =
in.)<BR>
include/asm-generic/xenomai/hal.h: In function &#8218;&Auml;&ograve;clear_t=
ask_nowakeup&#8218;&Auml;&ocirc;:<BR>
include/asm-generic/xenomai/hal.h:245: error: &#8218;&Auml;&ograve;TASK_NOW=
AKEUP&#8218;&Auml;&ocirc; undeclared (first use in this function)<BR>
include/asm-generic/xenomai/hal.h: At top level:<BR>
include/asm-generic/xenomai/hal.h:328: error: expected &#8218;&Auml;&ograve=
;=3D&#8218;&Auml;&ocirc;, &#8218;&Auml;&ograve;,&#8218;&Auml;&ocirc;, &#8218;&=
Auml;&ograve;;&#8218;&Auml;&ocirc;, &#8218;&Auml;&ograve;asm&#8218;&Auml;&oc=
irc; or &#8218;&Auml;&ograve;__attribute__&#8218;&Auml;&ocirc; before &#8218=
;&Auml;&ograve;rthal_irq_handler_t&#8218;&Auml;&ocirc;<BR>
include/asm-generic/xenomai/hal.h:329: error: expected &#8218;&Auml;&ograve=
;=3D&#8218;&Auml;&ocirc;, &#8218;&Auml;&ograve;,&#8218;&Auml;&ocirc;, &#8218;&=
Auml;&ograve;;&#8218;&Auml;&ocirc;, &#8218;&Auml;&ograve;asm&#8218;&Auml;&oc=
irc; or &#8218;&Auml;&ograve;__attribute__&#8218;&Auml;&ocirc; before &#8218=
;&Auml;&ograve;rthal_irq_ackfn_t&#8218;&Auml;&ocirc;<BR>
include/asm-generic/xenomai/hal.h:353: error: &#8218;&Auml;&ograve;IPIPE_NR=
_CPUS&#8218;&Auml;&ocirc; undeclared here (not in a function)<BR>
include/asm-generic/xenomai/hal.h:353: error: &#8218;&Auml;&ograve;IPIPE_NR=
_FAULTS&#8218;&Auml;&ocirc; undeclared here (not in a function)<BR>
include/asm-generic/xenomai/hal.h:403: error: expected declaration specifie=
rs or &#8218;&Auml;&ograve;...&#8218;&Auml;&ocirc; before &#8218;&Auml;&ogra=
ve;rthal_irq_handler_t&#8218;&Auml;&ocirc;<BR>
include/asm-generic/xenomai/hal.h:404: error: expected declaration specifie=
rs or &#8218;&Auml;&ograve;...&#8218;&Auml;&ocirc; before &#8218;&Auml;&ogra=
ve;rthal_irq_ackfn_t&#8218;&Auml;&ocirc;<BR>
include/asm-generic/xenomai/hal.h:443: warning: &#8218;&Auml;&ograve;enum c=
lock_event_mode&#8218;&Auml;&ocirc; declared inside parameter list<BR>
include/asm-generic/xenomai/hal.h:448: warning: &#8218;&Auml;&ograve;enum c=
lock_event_mode&#8218;&Auml;&ocirc; declared inside parameter list<BR>
In file included from include/asm/xenomai/hal.h:73,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;from kernel/xenomai/arch/generic/hal.c:47:<BR>
include/asm/xenomai/hal_32.h: In function &#8218;&Auml;&ograve;rthal_rdtsc&=
#8218;&Auml;&ocirc;:<BR>
include/asm/xenomai/hal_32.h:128: error: implicit declaration of function &=
#8218;&Auml;&ograve;ipipe_read_tsc&#8218;&Auml;&ocirc;<BR>
include/asm/xenomai/hal_32.h: In function &#8218;&Auml;&ograve;rthal_timer_=
program_shot&#8218;&Auml;&ocirc;:<BR>
include/asm/xenomai/hal_32.h:150: error: implicit declaration of function &=
#8218;&Auml;&ograve;ipipe_trigger_irq&#8218;&Auml;&ocirc;<BR>
include/asm/xenomai/hal_32.h:150: error: &#8218;&Auml;&ograve;IPIPE_SERVICE=
_IPI3&#8218;&Auml;&ocirc; undeclared (first use in this function)<BR>
kernel/xenomai/arch/generic/hal.c: In function &#8218;&Auml;&ograve;rthal_c=
ritical_enter&#8218;&Auml;&ocirc;:<BR>
kernel/xenomai/arch/generic/hal.c:94: error: implicit declaration of functi=
on &#8218;&Auml;&ograve;ipipe_critical_enter&#8218;&Auml;&ocirc;<BR>
kernel/xenomai/arch/generic/hal.c: In function &#8218;&Auml;&ograve;rthal_c=
ritical_exit&#8218;&Auml;&ocirc;:<BR>
kernel/xenomai/arch/generic/hal.c:107: error: implicit declaration of funct=
ion &#8218;&Auml;&ograve;ipipe_critical_exit&#8218;&Auml;&ocirc;<BR>
kernel/xenomai/arch/generic/hal.c: At top level:<BR>
kernel/xenomai/arch/generic/hal.c:159: error: expected declaration specifie=
rs or &#8218;&Auml;&ograve;...&#8218;&Auml;&ocirc; before &#8218;&Auml;&ogra=
ve;rthal_irq_handler_t&#8218;&Auml;&ocirc;<BR>
kernel/xenomai/arch/generic/hal.c:160: error: expected declaration specifie=
rs or &#8218;&Auml;&ograve;...&#8218;&Auml;&ocirc; before &#8218;&Auml;&ogra=
ve;rthal_irq_ackfn_t&#8218;&Auml;&ocirc;<BR>
kernel/xenomai/arch/generic/hal.c: In function &#8218;&Auml;&ograve;rthal_i=
rq_request&#8218;&Auml;&ocirc;:<BR>
kernel/xenomai/arch/generic/hal.c:162: error: &#8218;&Auml;&ograve;handler&=
#8218;&Auml;&ocirc; undeclared (first use in this function)<BR>
kernel/xenomai/arch/generic/hal.c:162: error: &#8218;&Auml;&ograve;IPIPE_NR=
_IRQS&#8218;&Auml;&ocirc; undeclared (first use in this function)<BR>
kernel/xenomai/arch/generic/hal.c:165: error: implicit declaration of funct=
ion &#8218;&Auml;&ograve;ipipe_virtualize_irq&#8218;&Auml;&ocirc;<BR>
kernel/xenomai/arch/generic/hal.c:165: error: &#8218;&Auml;&ograve;ackfn&#8=
218;&Auml;&ocirc; undeclared (first use in this function)<BR>
kernel/xenomai/arch/generic/hal.c:165: error: &#8218;&Auml;&ograve;IPIPE_HA=
NDLE_MASK&#8218;&Auml;&ocirc; undeclared (first use in this function)<BR>
kernel/xenomai/arch/generic/hal.c:165: error: &#8218;&Auml;&ograve;IPIPE_WI=
RED_MASK&#8218;&Auml;&ocirc; undeclared (first use in this function)<BR>
kernel/xenomai/arch/generic/hal.c:165: error: &#8218;&Auml;&ograve;IPIPE_EX=
CLUSIVE_MASK&#8218;&Auml;&ocirc; undeclared (first use in this function)<BR>
kernel/xenomai/arch/generic/hal.c: In function &#8218;&Auml;&ograve;rthal_i=
rq_release&#8218;&Auml;&ocirc;:<BR>
kernel/xenomai/arch/generic/hal.c:202: error: &#8218;&Auml;&ograve;IPIPE_NR=
_IRQS&#8218;&Auml;&ocirc; undeclared (first use in this function)<BR>
kernel/xenomai/arch/generic/hal.c:205: error: &#8218;&Auml;&ograve;IPIPE_PA=
SS_MASK&#8218;&Auml;&ocirc; undeclared (first use in this function)<BR>
kernel/xenomai/arch/generic/hal.c: In function &#8218;&Auml;&ograve;rthal_i=
rq_host_pend&#8218;&Auml;&ocirc;:<BR>
kernel/xenomai/arch/generic/hal.c:302: error: implicit declaration of funct=
ion &#8218;&Auml;&ograve;ipipe_propagate_irq&#8218;&Auml;&ocirc;<BR>
kernel/xenomai/arch/generic/hal.c: In function &#8218;&Auml;&ograve;rthal_a=
pc_handler&#8218;&Auml;&ocirc;:<BR>
kernel/xenomai/arch/generic/hal.c:401: error: implicit declaration of funct=
ion &#8218;&Auml;&ograve;ipipe_processor_id&#8218;&Auml;&ocirc;<BR>
kernel/xenomai/arch/generic/hal.c: In function &#8218;&Auml;&ograve;rthal_a=
pc_alloc&#8218;&Auml;&ocirc;:<BR>
kernel/xenomai/arch/generic/hal.c:525: error: implicit declaration of funct=
ion &#8218;&Auml;&ograve;ipipe_test_and_stall_pipeline_head&#8218;&Auml;&oci=
rc;<BR>
kernel/xenomai/arch/generic/hal.c:536: error: implicit declaration of funct=
ion &#8218;&Auml;&ograve;ipipe_restore_pipeline_head&#8218;&Auml;&ocirc;<BR>
kernel/xenomai/arch/generic/hal.c: In function &#8218;&Auml;&ograve;rthal_a=
pc_schedule&#8218;&Auml;&ocirc;:<BR>
kernel/xenomai/arch/generic/hal.c:610: error: implicit declaration of funct=
ion &#8218;&Auml;&ograve;ipipe_schedule_irq&#8218;&Auml;&ocirc;<BR>
kernel/xenomai/arch/generic/hal.c: In function &#8218;&Auml;&ograve;hal_rea=
d_proc&#8218;&Auml;&ocirc;:<BR>
kernel/xenomai/arch/generic/hal.c:627: error: &#8218;&Auml;&ograve;IPIPE_MA=
JOR_NUMBER&#8218;&Auml;&ocirc; undeclared (first use in this function)<BR>
kernel/xenomai/arch/generic/hal.c:628: error: &#8218;&Auml;&ograve;IPIPE_MI=
NOR_NUMBER&#8218;&Auml;&ocirc; undeclared (first use in this function)<BR>
kernel/xenomai/arch/generic/hal.c:629: error: &#8218;&Auml;&ograve;IPIPE_PA=
TCH_NUMBER&#8218;&Auml;&ocirc; undeclared (first use in this function)<BR>
kernel/xenomai/arch/generic/hal.c: In function &#8218;&Auml;&ograve;rthal_i=
nit&#8218;&Auml;&ocirc;:<BR>
kernel/xenomai/arch/generic/hal.c:798: error: implicit declaration of funct=
ion &#8218;&Auml;&ograve;ipipe_alloc_virq&#8218;&Auml;&ocirc;<BR>
kernel/xenomai/arch/generic/hal.c:806: error: &#8218;&Auml;&ograve;ipipe_cu=
rrent_domain&#8218;&Auml;&ocirc; undeclared (first use in this function)<BR>
kernel/xenomai/arch/generic/hal.c:806: error: &#8218;&Auml;&ograve;IPIPE_HA=
NDLE_MASK&#8218;&Auml;&ocirc; undeclared (first use in this function)<BR>
kernel/xenomai/arch/generic/hal.c:832: error: storage size of &#8218;&Auml;=
&ograve;attr&#8218;&Auml;&ocirc; isn&#8218;&Auml;&ocirc;t known<BR>
kernel/xenomai/arch/generic/hal.c:832: error: implicit declaration of funct=
ion &#8218;&Auml;&ograve;ipipe_init_attr&#8218;&Auml;&ocirc;<BR>
kernel/xenomai/arch/generic/hal.c:832: error: &#8218;&Auml;&ograve;IPIPE_HE=
AD_PRIORITY&#8218;&Auml;&ocirc; undeclared (first use in this function)<BR>
kernel/xenomai/arch/generic/hal.c:832: error: implicit declaration of funct=
ion &#8218;&Auml;&ograve;ipipe_register_domain&#8218;&Auml;&ocirc;<BR>
kernel/xenomai/arch/generic/hal.c:832: warning: unused variable &#8218;&Aum=
l;&ograve;attr&#8218;&Auml;&ocirc;<BR>
kernel/xenomai/arch/generic/hal.c:873: error: implicit declaration of funct=
ion &#8218;&Auml;&ograve;ipipe_free_virq&#8218;&Auml;&ocirc;<BR>
kernel/xenomai/arch/generic/hal.c: In function &#8218;&Auml;&ograve;rthal_e=
xit&#8218;&Auml;&ocirc;:<BR>
kernel/xenomai/arch/generic/hal.c:889: error: &#8218;&Auml;&ograve;ipipe_cu=
rrent_domain&#8218;&Auml;&ocirc; undeclared (first use in this function)<BR>
kernel/xenomai/arch/generic/hal.c:903: error: implicit declaration of funct=
ion &#8218;&Auml;&ograve;ipipe_unregister_domain&#8218;&Auml;&ocirc;<BR>
make[4]: *** [kernel/xenomai/arch/generic/hal.o] Error 1<BR>
make[3]: *** [kernel/xenomai/arch/generic] Error 2<BR>
make[2]: *** [kernel/xenomai/arch] Error 2<BR>
make[1]: *** [kernel/xenomai] Error 2<BR>
make: *** [kernel] Error 2<BR>
igvc@domain.hid$ <BR>
<BR>
<BR>
<BR>
<BR>
<BR>
</SPAN></FONT></FONT>
</BODY>
</HTML>


--B_3303159646_612702--



