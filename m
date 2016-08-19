Date: Fri, 19 Aug 2016 19:03:28 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160819190328.5320035d@md1em3qc>
In-Reply-To: <CANBp=-gOizmyMC0jEGAnd2TLEOuuRiiMSLPon8SKo4eGOdxJ4Q@mail.gmail.com>
References: <CANBp=-gOizmyMC0jEGAnd2TLEOuuRiiMSLPon8SKo4eGOdxJ4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Installation of Xenomai 2.6.4 - Kernel panic on SCSI
 after reboot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michele Belotti <miki.belotti@gmail.com>
Cc: xenomai@xenomai.org

Michele,

that is a lot of information, most of it does not seem too useful. What
exactly is the error message you get and you are working on?

I can only assume it is the usual "my root partition does not exist"
and you really just miss the module.

When building an essential driver as an external module you will need
an initrd. Consult documentation of your distribution to figure out how
to best update a kernel and create/update the initrd for it.
I would even suggest you just try that with a "regular" linux kernel,
because from what you wrote you might have missed a step or two in
installing that new ipipe-kernel.

Find some comments as inline replies in you mail below.

Henning

Am Fri, 19 Aug 2016 17:55:09 +0200
schrieb Michele Belotti <miki.belotti@gmail.com>:

> I have already installed the Xenomai 2.6.4 on several machine with
> Red Hat 6.7 successfully (kernel linux  linux-3.8.13
> ipipe-core-3.10.32-x86-6) on the machine HP described in the Purchase
> details. The installation seems correct except to the fact the
> probably the SCSI driver are not correctly
> installed. The configuration is the one described in the
> xenomai_kernel.config file
>=20
> We make a lot of test different that I try to summarize hereafter...
>=20
>=20
>=20
> As suggested, we added our SCSI model in the .config but it doesn=E2=80=
=99t
> resolve the problem, we still have the core dump.
>=20
> Googling, we found that
> (https://bugzilla.kernel.org/show_bug.cgi?id=3D60758) to solve our
> problem (scsi_wait_scan not found) we should enable
> CONFIG_SCSI_SCAN_ASYN =C3=A0 Y  in the .config file.
>=20
> We did it, but it still does not work.
>=20
> Now, there is something strange.
>=20
> If i run the following command:
>=20
>=20
>=20
> lsinitrd | grep wait
>=20
>=20
>=20
> I can see the wait module in the following folder:
>=20
> /lib/modules/2.6.32-573.el6.x86-64/kernel/drivers/scsi/scsi_wait_scan.ko

Well lsinitrd shows the content of the initrd, not the content of your
rootfs. Even though for the kernel specific modules you probably want
that to be the same.
Does that initrd contain /lib/modules/linux-3.8.13-xenomai-2.6.4 as
well?

>=20
>=20
> but if I look in the following folder:
> /usr/src/kernls/linux-3.8.13-xenomai-2.6.4/drivers/scsi I=E2=80=99m not a=
ble
> to find it.

That is a totally different path. Did you forget "make modules_install"?
You want all relevant modules to be in /lib/modules/3.8.13-xeno.. and
after creating/updating the initrd you also want to find them in there.

And you want to make sure the initrd is actually used. It needs to be
mentioned in the bootloader config.

>=20
> If my understanding is correct, the scsi_wait_scan module is needed to
> =E2=80=9Cwait=E2=80=9D the scan of the scsi drivers before they are mount=
ed.
>=20
>=20
> In order to speed up the different tests, I created the
> ./usr/src/kernels/linux-3.8.13-xenomai-2.6.4 following manually the
> build_install_xenomai_kernel.sh and then, instead of mv this version
> to $FIN_DIR (raw 140) I just
>=20
> cp  ./usr/src/kernels/linux-3.8.13-xenomai-2.6.4  /usr/src/kernels/
> and I update the .config inside with my config every time I want to
> perform a new test; then I compile and I update the grub.
>=20
>=20
>=20
>=20
>=20
> 1)            In order to create a new config file I always use the
> make menuconfig. Please find attached two version of the config files
> (the most significative) I used to compile the software (of course I
> renamed in .config before recompiling).
>=20
> Using config_1 I have the following messages after the make:
>=20
> ERROR: modinfo: could not find module cpufreq_ondemand
>=20
> ERROR: modinfo: could not find module freq_table
>=20
> ERROR: modinfo: could not find module pcc_cpufreq
>=20
> ERROR: modinfo: could not find module power_meter
>=20
> ERROR: modinfo: could not find module acpi_ipmi
>=20
> ERROR: modinfo: could not find module sb_edac
>=20
> ERROR: modinfo: could not find module hpsa
>=20
> ERROR: modinfo: could not find module wmi
>=20
>=20
>=20
> Using configure_2 I have the following messages after the make:
>=20
>                 ERROR: modinfo: could not find module cpufreq_ondemand
>=20
> ERROR: modinfo: could not find module freq_table
>=20
> ERROR: modinfo: could not find module pcc_cpufreq
>=20
> ERROR: modinfo: could not find module sg
>=20
> ERROR: modinfo: could not find module mdio
>=20
> ERROR: modinfo: could not find module power_meter
>=20
> ERROR: modinfo: could not find module acpi_ipmi
>=20
> ERROR: modinfo: could not find module sb_edac
>=20
> ERROR: modinfo: could not find module lpc_ich
>=20
> ERROR: modinfo: could not find module mfd_core
>=20
> ERROR: modinfo: could not find module sd_mod
>=20
> ERROR: modinfo: could not find module crc_t10dif
>=20
> ERROR: modinfo: could not find module hpsa
>=20
> ERROR: modinfo: could not find module wmi
>=20
>                 as you know I cannot add some modules as they have
> conficts with Xenomay.
>=20
> 2)            For the scsi_module_wait error I found on internet the
> following links:
>=20
> a.            https://bugzilla.kernel.org/show_bug.cgi?id=3D60758
>=20
> b.
> http://linuxaleph.blogspot.de/2014/06/kernel-panic-scsiwaitscan-on-centos=
.html
>=20
> For this problem they have an explanation at least for kernel 3.13,
> an idea can be this kernel for PGD instead of 3.8. Anyway, they say
> that the problem is linked with
>=20
>                 the fact that the version introduces multi queue
> block i/o for virtio_blk, which in turn does not any more call
> blk_init_queue() but blk_mq_init_queue() instead.
>=20
> Dracut matches against symbol blk_init_queue but not yet against
> symbol blk_mq_init_queue. As you can see in the config file I added
> the virtio and also I performed the suggested procedure to fix the
> problem, i.e. :
>=20
> I listed the /boot directory and the I executed:
>=20
>=20
>=20
> echo 'add_drivers+=3D"virtio_blk" ' >
> /etc/dracut.conf.d/force-vitio_blk-to-ensure-boot.conf
>=20
> cp /boot/initramfs-3.8.13_xenomai-2.6.4.img
> /boot/initramfs-3.8.13_xenomai-2.6.4.img.bak
>=20
> dracut -f /boot/initramfs-3.8.13_xenomai-2.6.4.img
> 3.8.13_xenomai-2.6.4
>=20
>=20
>=20
> But the error is still there. I did the same also for
> initramfs-2.6.32-573.el6.x86_64.img, but the error is still there. By
> the way, I can confirm that the initramfs  is updated after each make.
>=20
> 3)            The scsi_wait_scan driver is apparently an old driver
> that indeed is not present in the driver/scsi folder of the linux
> distribution we used during the xenomai patching. But it is present in
>=20
> /lib/modules/2.6.32-573.el6.x86_64/kernel/drivers/scsi/.
>=20
> As during the make different drivers/scsi are installed (e.g.
> scsi_transport etc) I downloaded an older linux version and I copied
> the scsi_wait_scan.c in drivers/scsi
>=20
> cp
> scsi_wait_scan.c /usr/src/kernels/linux-3.8.13-xenomai-2.6.4/drivers/scsi
>=20
> Unfortunately at the end the scsi_wait_scan.o was not present in
> /lib/modules/3.8.13_xenomai-2.6.4/kernel/drivers/scsi/ , therefore it
> has not been installed. I think that if we manage to install this
> driver together with all the others we may solve the problem.
>=20
> Of course I also tried to cp scsi_wait_scan.o :
>=20
> cp /lib/modules/2.6.32-573.el6.x86_64/kernel/drivers/scsi/scsi_wait_scan.=
ko
> /lib/modules/3.8.13_xenomai-2.6.4/kernel/drivers/scsi/
>=20
> but it does not solve the problem. The strange thing is that I was
> not able to insert the scsi_wait_scan using the make menuconfig.
>=20
> I also tried the =E2=80=9Cinsmod scsi_wait_scan=E2=80=9D, but no success.
>=20
>=20
>=20
> In conclusion I think that there are at least two possibility (on top
> of the VM installation using full machine power):
>=20
> 1)            To install properly the scsi_wait_scan as it is done
> for the other modules
>=20
> 2)            To try to patch and recompile the xenomai using a
> different linux core.
>=20
>=20
>=20
>=20
> 1)            I copied the scsi_wait_scan.c in
> linux-3.8.13-xenomai-2.6.4/drivers/scsi before performing the xenomai
> patching. Then I copiled the kernel, but the error is still there.
>=20
> 2)            As I copied the scsi_wait_scan.c from linux-3.4, I tried
> directly to patch the linux-3.4, using the
> ipipe-core-3.4.6-x86-2.patch and ipipe-core-3.4.6-x86-4.patch, but I
> was not able to patch the xenomai, or, better, with
> ipipe-core-3.4.6-x86-2.patch it was not possible to patch xenomay,
> with ipipe-core-3.4.6-x86-4.patch it was possible to patch the
> xenomai but then I was not able to recompile the kernel.
>=20
>=20
>=20
>=20
>=20
> As explained one possible solution (in my opinion) is to add the
> scsi_wait_scan to the modules that are compiled and installed during
> the make. if done in the correct way, the:
>=20
>=20
>=20
> CC [M] drivers/scsi/scsi_wait_scan.o           should be shown after
> CC [M] drivers/scsi/scsi_transport_srp.o
>=20
> and
>=20
> INSTALL drivers/scsi/scsi_wait_scan.ko       should be shown after
> INSTALL drivers/scsi/scsi_transport_srp.ko
>=20
>=20
>=20
> during the kernel compilation.
>=20
>=20
>=20
> I don't know how it is possible to add scsi_wait_scan at the list of
> modules to be compiled. I tried to  modifiyng the
>=20
> make clean && make -j 24 && make modules -j 24 && make
> modules_install && make install but I was not able to add the
> scsi_wait_scan.
>=20
>=20
>=20
>=20
> Cpould you please give me some hint on how to solve the problem? Any
> suggestion will be very welcome.
> If you need additional information, please let me know
>=20
> Thanks a lot in advance.
>=20
> Michele
>=20
>=20
>=20
>   [image: Immagine incorporata 2]
>=20
> Michele
>=20
> [image: Immagine incorporata 1]
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: PDG HW Purchase details.jpg
> Type: image/jpeg
> Size: 58022 bytes
> Desc: not available
> URL:
> <http://xenomai.org/pipermail/xenomai/attachments/20160819/81148731/attac=
hment.jpg>
> -------------- next part -------------- A non-text attachment was
> scrubbed... Name: IMAG1932.jpg
> Type: image/jpeg
> Size: 2609075 bytes
> Desc: not available
> URL:
> <http://xenomai.org/pipermail/xenomai/attachments/20160819/81148731/attac=
hment-0001.jpg>
> -------------- next part
> -------------- ./build_install_xenomai_kernel_noquestions.sh: line
> 1: =EF=BB=BF#!/bin/bash: No such file or directory
> **************************************************
> * Greetings from TAS-Deutschland!                *
> **************************************************
> *This script will install the Xenomai version:   *
> * xenomai-2.6.4                               *
> * The kernel host version is: linux-3.8.13    *
> **************************************************
> ...
> mkdir: cannot create directory `usr/': File exists
> mkdir: cannot create directory `usr/src/': File exists
> mkdir: cannot create directory `usr/src/kernels/': File exists
>=20
> Next step: prepare the kernel
> patching file arch/x86/Kconfig
> patching file arch/x86/Kconfig.debug
> patching file arch/x86/include/asm/apic.h
> patching file arch/x86/include/asm/apicdef.h
> patching file arch/x86/include/asm/debugreg.h
> patching file arch/x86/include/asm/desc.h
> patching file arch/x86/include/asm/fpu-internal.h
> patching file arch/x86/include/asm/hw_irq.h
> patching file arch/x86/include/asm/i8259.h
> patching file arch/x86/include/asm/ipi.h
> patching file arch/x86/include/asm/ipipe.h
> patching file arch/x86/include/asm/ipipe_32.h
> patching file arch/x86/include/asm/ipipe_64.h
> patching file arch/x86/include/asm/ipipe_base.h
> patching file arch/x86/include/asm/irq_vectors.h
> patching file arch/x86/include/asm/irqflags.h
> patching file arch/x86/include/asm/mmu_context.h
> patching file arch/x86/include/asm/page_64_types.h
> patching file arch/x86/include/asm/processor.h
> patching file arch/x86/include/asm/special_insns.h
> patching file arch/x86/include/asm/switch_to.h
> patching file arch/x86/include/asm/thread_info.h
> patching file arch/x86/include/asm/traps.h
> patching file arch/x86/include/asm/tsc.h
> patching file arch/x86/kernel/Makefile
> patching file arch/x86/kernel/apic/apic.c
> patching file arch/x86/kernel/apic/apic_flat_64.c
> patching file arch/x86/kernel/apic/io_apic.c
> patching file arch/x86/kernel/apic/ipi.c
> patching file arch/x86/kernel/apic/x2apic_cluster.c
> patching file arch/x86/kernel/apic/x2apic_phys.c
> patching file arch/x86/kernel/cpu/common.c
> patching file arch/x86/kernel/cpu/mtrr/cyrix.c
> patching file arch/x86/kernel/cpu/mtrr/generic.c
> patching file arch/x86/kernel/dumpstack_32.c
> patching file arch/x86/kernel/dumpstack_64.c
> patching file arch/x86/kernel/entry_32.S
> patching file arch/x86/kernel/entry_64.S
> patching file arch/x86/kernel/hpet.c
> patching file arch/x86/kernel/i387.c
> patching file arch/x86/kernel/i8253.c
> patching file arch/x86/kernel/i8259.c
> patching file arch/x86/kernel/ipipe.c
> patching file arch/x86/kernel/irq.c
> patching file arch/x86/kernel/irqinit.c
> patching file arch/x86/kernel/kgdb.c
> patching file arch/x86/kernel/pcspeaker.c
> patching file arch/x86/kernel/process.c
> patching file arch/x86/kernel/process_32.c
> patching file arch/x86/kernel/process_64.c
> patching file arch/x86/kernel/ptrace.c
> patching file arch/x86/kernel/smp.c
> patching file arch/x86/kernel/smpboot.c
> patching file arch/x86/kernel/traps.c
> patching file arch/x86/kernel/tsc.c
> patching file arch/x86/kernel/vm86_32.c
> patching file arch/x86/kernel/vsyscall_64.c
> patching file arch/x86/kernel/xsave.c
> patching file arch/x86/kvm/svm.c
> patching file arch/x86/kvm/vmx.c
> patching file arch/x86/kvm/x86.c
> patching file arch/x86/lib/mmx_32.c
> patching file arch/x86/lib/thunk_64.S
> patching file arch/x86/lib/usercopy.c
> patching file arch/x86/mm/fault.c
> patching file arch/x86/mm/tlb.c
> patching file arch/x86/platform/uv/tlb_uv.c
> patching file drivers/clocksource/Makefile
> patching file drivers/clocksource/i8253.c
> patching file drivers/clocksource/ipipe_i486_tsc_emu.S
> patching file drivers/gpu/drm/i915/i915_gem.c
> patching file drivers/pci/htirq.c
> patching file drivers/cpuidle/Kconfig
> patching file drivers/tty/serial/8250/8250.c
> patching file fs/exec.c
> patching file fs/proc/array.c
> patching file include/asm-generic/atomic.h
> patching file include/asm-generic/bitops/atomic.h
> patching file include/asm-generic/cmpxchg-local.h
> patching file include/asm-generic/percpu.h
> patching file include/ipipe/setup.h
> patching file include/ipipe/thread_info.h
> patching file include/linux/clockchips.h
> patching file include/linux/clocksource.h
> patching file include/linux/ftrace.h
> patching file include/linux/hardirq.h
> patching file include/linux/i8253.h
> patching file include/linux/ipipe.h
> patching file include/linux/ipipe_base.h
> patching file include/linux/ipipe_compat.h
> patching file include/linux/ipipe_debug.h
> patching file include/linux/ipipe_domain.h
> patching file include/linux/ipipe_lock.h
> patching file include/linux/ipipe_tickdev.h
> patching file include/linux/ipipe_trace.h
> patching file include/linux/irq.h
> patching file include/linux/irqdesc.h
> patching file include/linux/irqnr.h
> patching file include/linux/kernel.h
> patching file include/linux/kvm_host.h
> patching file include/linux/preempt.h
> patching file include/linux/rwlock.h
> patching file include/linux/rwlock_api_smp.h
> patching file include/linux/sched.h
> patching file include/linux/spinlock.h
> patching file include/linux/spinlock_api_smp.h
> patching file include/linux/spinlock_up.h
> patching file include/uapi/asm-generic/mman-common.h
> patching file include/uapi/asm-generic/resource.h
> patching file include/uapi/linux/resource.h
> patching file init/Kconfig
> patching file init/main.c
> patching file kernel/Makefile
> patching file kernel/debug/debug_core.c
> patching file kernel/debug/gdbstub.c
> patching file kernel/exit.c
> patching file kernel/fork.c
> patching file kernel/ipipe/Kconfig
> patching file kernel/ipipe/Kconfig.debug
> patching file kernel/ipipe/Makefile
> patching file kernel/ipipe/compat.c
> patching file kernel/ipipe/core.c
> patching file kernel/ipipe/timer.c
> patching file kernel/ipipe/tracer.c
> patching file kernel/irq/chip.c
> patching file kernel/irq/generic-chip.c
> patching file kernel/irq/irqdesc.c
> patching file kernel/irq/manage.c
> patching file kernel/lockdep.c
> patching file kernel/panic.c
> patching file kernel/power/hibernate.c
> patching file kernel/printk.c
> patching file kernel/sched/clock.c
> patching file kernel/sched/core.c
> patching file kernel/signal.c
> patching file kernel/spinlock.c
> patching file kernel/time/clockevents.c
> patching file kernel/time/clocksource.c
> patching file kernel/time/tick-common.c
> patching file kernel/time/tick-sched.c
> patching file kernel/timer.c
> patching file kernel/trace/Kconfig
> patching file kernel/trace/ftrace.c
> patching file kernel/trace/trace.c
> patching file kernel/trace/trace_clock.c
> patching file kernel/trace/trace_functions.c
> patching file kernel/trace/trace_functions_graph.c
> patching file lib/Kconfig.debug
> patching file lib/atomic64.c
> patching file lib/bust_spinlocks.c
> patching file lib/ioremap.c
> patching file lib/smp_processor_id.c
> patching file mm/Kconfig
> patching file mm/memory.c
> patching file mm/mlock.c
> patching file mm/mmap.c
> patching file mm/mmu_context.c
> patching file mm/mprotect.c
> patching file mm/vmalloc.c
>=20
> Next step: move to /usr/src/kernel/
> mv: inter-device move failed:
> `./usr/src/kernels/linux-3.8.13-xenomai-2.6.4/' to
> `/usr/src/kernels/linux-3.8.13-xenomai-2.6.4'; unable to remove
> target: Directory not empty total 39916 drwxrwxr-x  31 root root
> 4096 Jul 27 12:01 arch drwxrwxr-x   3 root root     4096 Jul 27 11:59
> block -rw-rw-r--   1 root root    18693 May 11  2013 COPYING
> -rw-rw-r--   1 root root    95054 May 11  2013 CREDITS drwxrwxr-x   4
> root root    20480 Jul 27 12:01 crypto drwxrwxr-x  99 root root
> 12288 Jul 27 12:01 Documentation drwxrwxr-x 109 root root     4096
> Jul 27 12:01 drivers -rw-r--r--   1 root root        0 Jul 27 12:00
> extra_certificates drwxrwxr-x  36 root root     4096 Jul 27 12:01
> firmware drwxrwxr-x  72 root root    12288 Jul 27 12:01 fs
> drwxrwxr-x  29 root root     4096 Jul 27 11:59 include
> drwxrwxr-x   2 root root     4096 Jul 27 12:01 init
> drwxrwxr-x   2 root root     4096 Jul 27 11:59 ipc
> -rw-rw-r--   1 root root     2536 May 11  2013 Kbuild
> -rw-rw-r--   1 root root      252 May 11  2013 Kconfig
> drwxrwxr-x  12 root root    12288 Jul 27 12:00 kernel
> drwxrwxr-x   9 root root    20480 Jul 27 12:01 lib
> -rw-rw-r--   1 root root   239609 May 11  2013 MAINTAINERS
> -rwxr--r--   1 root root    48040 Jul 27 11:59 Makefile
> drwxrwxr-x   2 root root    12288 Jul 27 11:59 mm
> -rw-r--r--   1 root root     5849 Jul 27 11:59 modules.builtin
> -rw-r--r--   1 root root    56319 Jul 27 12:01 modules.order
> -rw-r--r--   1 root root   710577 Jul 27 12:01 Module.symvers
> drwxrwxr-x  55 root root     4096 Jul 27 12:00 net
> -rw-rw-r--   1 root root    18736 May 11  2013 README
> -rw-rw-r--   1 root root     3371 May 11  2013 REPORTING-BUGS
> drwxrwxr-x  13 root root     4096 May 11  2013 samples
> drwxrwxr-x  13 root root     4096 Jul 27 12:01 scripts
> drwxrwxr-x   9 root root     4096 Jul 27 11:59 security
> -rw-r--r--   1 root root     3272 Jul 27 12:00 signing_key.priv
> -rw-r--r--   1 root root     1446 Jul 27 12:00 signing_key.x509
> drwxrwxr-x  22 root root     4096 Jul 27 12:01 sound
> -rw-r--r--   1 root root  2617524 Jul 27 12:01 System.map
> drwxrwxr-x  15 root root     4096 May 11  2013 tools
> drwxrwxr-x   3 root root     4096 Jul 27 12:01 usr
> drwxrwxr-x   3 root root     4096 May 11  2013 virt
> -rwxr-xr-x   1 root root 17905357 Jul 27 12:01 vmlinux
> -rw-r--r--   1 root root 23146092 Jul 27 12:01 vmlinux.o
> -rw-r--r--   1 root root      372 Jul 27 12:00 x509.genkey
>=20
> Next step: Build and install the kernel with xenomai-2.6.4.
>=20
>   CLEAN   .
>   CLEAN   arch/x86/kernel/cpu
>   CLEAN   arch/x86/kernel
>   CLEAN   arch/x86/realmode/rm
>   CLEAN   arch/x86/vdso
>   CLEAN   arch/x86/lib
>   CLEAN   crypto/asymmetric_keys
>   CLEAN   drivers/gpu/drm/radeon
>   CLEAN   drivers/scsi/aic7xxx
>   CLEAN   drivers/tty/vt
>   CLEAN   drivers/video/logo
>   CLEAN   firmware
>   CLEAN   kernel
>   CLEAN   lib/raid6
>   CLEAN   lib
>   CLEAN   security/selinux
>   CLEAN   usr
>   CLEAN   Documentation/accounting
>   CLEAN   Documentation/auxdisplay
>   CLEAN   Documentation/connector
>   CLEAN   Documentation/filesystems
>   CLEAN   Documentation/ia64
>   CLEAN   Documentation/laptops
>   CLEAN   Documentation/misc-devices/mei
>   CLEAN   Documentation/networking/timestamping
>   CLEAN   Documentation/networking
>   CLEAN   Documentation/pcmcia
>   CLEAN   Documentation/spi
>   CLEAN   Documentation/timers
>   CLEAN   Documentation/watchdog/src
>   CLEAN   arch/x86/boot/compressed
>   CLEAN   arch/x86/boot
>   CLEAN   arch/x86/tools
>   CLEAN   .tmp_versions
> make[1]: Nothing to be done for `all'.
>   HOSTCC  scripts/basic/fixdep
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
>   HOSTCC  arch/x86/tools/relocs
>   HOSTCC  scripts/kallsyms
>   HOSTCC  scripts/pnmtologo
>   HOSTCC  scripts/conmakehash
>   HOSTCC  scripts/recordmcount
>   HOSTCC  scripts/sortextable
>   HOSTCC  scripts/asn1_compiler
>   HOSTCC  scripts/mod/mk_elfconfig
>   CC      scripts/mod/empty.o
>   HOSTCC  scripts/genksyms/genksyms.o
>   HOSTCC  scripts/genksyms/lex.lex.o
>   HOSTCC  scripts/genksyms/parse.tab.o
>   HOSTCC  scripts/selinux/genheaders/genheaders
>   HOSTCC  scripts/selinux/mdp/mdp
>   MKELF   scripts/mod/elfconfig.h
>   HOSTCC  scripts/mod/file2alias.o
>   HOSTCC  scripts/mod/modpost.o
>   HOSTCC  scripts/mod/sumversion.o
>   CC      kernel/bounds.s
>   GEN     include/generated/bounds.h
>   CC      arch/x86/kernel/asm-offsets.s
>   HOSTLD  scripts/genksyms/genksyms
>   GEN     include/generated/asm-offsets.h
>   CALL    scripts/checksyscalls.sh
>   HOSTLD  scripts/mod/modpost
>   CHK     include/generated/compile.h
>   CC      init/main.o
>   CC      init/do_mounts.o
>   CC      init/do_mounts_rd.o
>   CC      init/do_mounts_initrd.o
>   CC      init/do_mounts_md.o
>   CC      init/initramfs.o
>   CC      init/calibrate.o
>   CC      init/init_task.o
>   CC      init/version.o
>   HOSTCC  usr/gen_init_cpio
>   AS      arch/x86/ia32/ia32entry.o
>   LD      arch/x86/crypto/built-in.o
>   CC      arch/x86/kernel/process_64.o
>   LD      arch/x86/net/built-in.o
>   CC      arch/x86/kernel/signal.o
>   AS      arch/x86/kernel/entry_64.o
>   CC      arch/x86/ia32/sys_ia32.o
>   LD      arch/x86/kvm/built-in.o
>   CC      arch/x86/realmode/init.o
>   CC [M]  arch/x86/kvm/svm.o
>   CC [M]  arch/x86/crypto/ablk_helper.o
>   LD      arch/x86/platform/ce4100/built-in.o
>   AS [M]  arch/x86/crypto/aes-x86_64-asm_64.o
>   CC      arch/x86/mm/init.o
>   CC      arch/x86/platform/efi/efi.o
>   CC      arch/x86/vdso/vma.o
>   CC      kernel/fork.o
>   LDS     arch/x86/vdso/vdso.lds
>   CC      arch/x86/platform/efi/efi_64.o
>   AS      arch/x86/platform/efi/efi_stub_64.o
>   CC      arch/x86/ia32/ia32_signal.o
>   CC      arch/x86/ia32/nosyscall.o
>   AS      arch/x86/vdso/vdso-note.o
>   AS      arch/x86/realmode/rm/header.o
>   AS      arch/x86/realmode/rm/trampoline_64.o
>   AS      arch/x86/realmode/rm/stack.o
>   LD      arch/x86/platform/geode/built-in.o
>   CC [M]  arch/x86/kvm/vmx.o
>   CC      arch/x86/vdso/vclock_gettime.o
>   AS      arch/x86/realmode/rm/reboot.o
>   GEN     usr/initramfs_data.cpio
>   AS      arch/x86/realmode/rm/wakeup_asm.o
>   AS      usr/initramfs_data.o
>   CC [M]  arch/x86/kvm/../../../virt/kvm/kvm_main.o
>   CC      arch/x86/realmode/rm/wakemain.o
>   LD      usr/built-in.o
>   CC [M]  arch/x86/kvm/../../../virt/kvm/ioapic.o
>   CC      mm/filemap.o
>   CC [M]  arch/x86/kvm/../../../virt/kvm/coalesced_mmio.o
>   CC      mm/mempool.o
>   CC      fs/open.o
>   CC      fs/read_write.o
>   CC      arch/x86/realmode/rm/video-mode.o
>   AS      arch/x86/realmode/rm/copy.o
>   CC      kernel/exec_domain.o
>   CC      kernel/panic.o
>   CC      kernel/printk.o
>   CC      arch/x86/mm/init_64.o
>   CC      arch/x86/mm/fault.o
>   AS      arch/x86/realmode/rm/bioscall.o
>   CC      arch/x86/realmode/rm/regs.o
>   CC      arch/x86/realmode/rm/video-vga.o
>   CC      arch/x86/vdso/vgetcpu.o
>   CC [M]  arch/x86/crypto/aes_glue.o
>   LDS     arch/x86/vdso/vdso32/vdso32.lds
>   CC      arch/x86/ia32/syscall_ia32.o
>   AS [M]  arch/x86/crypto/aesni-intel_asm.o
>   CC      arch/x86/ia32/ipc32.o
>   LD      init/mounts.o
>   LD      init/built-in.o
>   CC      arch/x86/realmode/rm/video-vesa.o
>   CC      arch/x86/realmode/rm/video-bios.o
>   CC [M]  arch/x86/kvm/../../../virt/kvm/irq_comm.o
>   AS      arch/x86/vdso/vdso32/note.o
>   AS      arch/x86/vdso/vdso32/int80.o
>   CC      arch/x86/kernel/traps.o
>   AS      arch/x86/vdso/vdso32/syscall.o
>   LD      arch/x86/platform/efi/built-in.o
>   CC      arch/x86/kernel/irq.o
>   CC      arch/x86/kernel/irq_64.o
>   PASYMS  arch/x86/realmode/rm/pasyms.h
>   CC      arch/x86/kernel/dumpstack_64.o
>   AS      arch/x86/vdso/vdso32/sysenter.o
>   LDS     arch/x86/realmode/rm/realmode.lds
>   LD      arch/x86/platform/iris/built-in.o
>   LD      arch/x86/realmode/rm/realmode.elf
>   LD      arch/x86/platform/mrst/built-in.o
>   CC      arch/x86/vdso/vdso32-setup.o
>   RELOCS  arch/x86/realmode/rm/realmode.relocs
>   CC [M]  arch/x86/crypto/aesni-intel_glue.o
>   OBJCOPY arch/x86/realmode/rm/realmode.bin
>   LD      arch/x86/platform/olpc/built-in.o
>   AS      arch/x86/realmode/rmpiggy.o
>   LD      arch/x86/platform/scx200/built-in.o
>   LD      arch/x86/realmode/built-in.o
>   CC [M]  arch/x86/kvm/../../../virt/kvm/eventfd.o
>   CC      arch/x86/platform/sfi/sfi.o
>   LD      arch/x86/platform/uv/built-in.o
>   CC      arch/x86/kernel/time.o
>   CC [M]  arch/x86/kvm/../../../virt/kvm/assigned-dev.o
>   LD      arch/x86/platform/visws/built-in.o
>   CC [M]  arch/x86/kvm/../../../virt/kvm/iommu.o
>   CC      arch/x86/ia32/audit.o
>   LD      arch/x86/ia32/built-in.o
>   CC [M]  arch/x86/kvm/../../../virt/kvm/async_pf.o
>   CC [M]  arch/x86/crypto/fpu.o
>   CC [M]  arch/x86/crypto/crc32c-intel_glue.o
>   AS [M]  arch/x86/crypto/crc32c-pcl-intel-asm_64.o
>   CC [M]  arch/x86/kvm/x86.o
>   CC [M]  arch/x86/kvm/mmu.o
>   CC      arch/x86/mm/ioremap.o
>   VDSO    arch/x86/vdso/vdso.so.dbg
>   CC [M]  arch/x86/kvm/emulate.o
>   CC      arch/x86/mm/extable.o
>   CC      mm/oom_kill.o
>   LD      arch/x86/platform/sfi/built-in.o
>   LD      arch/x86/platform/built-in.o
>   CC [M]  arch/x86/kvm/i8259.o
>   CC      ipc/compat.o
>   CC [M]  arch/x86/kvm/irq.o
>   VDSO    arch/x86/vdso/vdso32-int80.so.dbg
>   CC      fs/file_table.o
>   CC      fs/super.o
>   CC      ipc/util.o
>   CC      fs/char_dev.o
>   CC      ipc/msgutil.o
>   VDSO    arch/x86/vdso/vdso32-syscall.so.dbg
>   CC      ipc/msg.o
>   CC      fs/stat.o
>   CC      arch/x86/kernel/ioport.o
>   AS [M]  arch/x86/crypto/ghash-clmulni-intel_asm.o
>   VDSO    arch/x86/vdso/vdso32-sysenter.so.dbg
>   CC [M]  arch/x86/crypto/ghash-clmulni-intel_glue.o
>   VDSOSYM arch/x86/vdso/vdso-syms.lds
>   CC [M]  arch/x86/kvm/lapic.o
>   VDSOSYM arch/x86/vdso/vdso32-int80-syms.lds
>   VDSOSYM arch/x86/vdso/vdso32-syscall-syms.lds
>   VDSOSYM arch/x86/vdso/vdso32-sysenter-syms.lds
>   OBJCOPY arch/x86/vdso/vdso.so
>   OBJCOPY arch/x86/vdso/vdso32-int80.so
>   OBJCOPY arch/x86/vdso/vdso32-syscall.so
>   OBJCOPY arch/x86/vdso/vdso32-sysenter.so
>   VDSOSYM arch/x86/vdso/vdso32-syms.lds
>   AS      arch/x86/vdso/vdso.o
>   AS      arch/x86/vdso/vdso32.o
>   CC      kernel/cpu.o
>   LD      arch/x86/vdso/built-in.o
>   CC [M]  arch/x86/kvm/i8254.o
>   CC [M]  arch/x86/kvm/cpuid.o
>   CC      kernel/exit.o
>   CC      ipc/sem.o
>   CC      kernel/itimer.o
>   CC      arch/x86/mm/pageattr.o
>   CC      arch/x86/mm/mmap.o
>   TIMEC   kernel/timeconst.h
>   CC      arch/x86/kernel/ldt.o
>   CC      kernel/softirq.o
>   CC      mm/fadvise.o
>   CC      mm/maccess.o
>   CC      arch/x86/kernel/dumpstack.o
>   CC      kernel/resource.o
> arch/x86/kvm/mmu.c: In function =E2=80=98kvm_test_age_rmapp=E2=80=99:
> arch/x86/kvm/mmu.c:1386: warning: =E2=80=98iter.desc=E2=80=99 may be used
> uninitialized in this function AS [M]
> arch/x86/crypto/salsa20-x86_64-asm_64.o CC [M]
> arch/x86/crypto/salsa20_glue.o AS [M]
> arch/x86/crypto/twofish-x86_64-asm_64.o CC      arch/x86/kernel/nmi.o
>   CC      ipc/shm.o
>   CC      mm/page_alloc.o
>   CC      mm/page-writeback.o
>   CC      arch/x86/kernel/setup.o
>   CC      ipc/ipcns_notifier.o
>   CC      ipc/syscall.o
>   CC      fs/exec.o
>   CC      arch/x86/kernel/x86_init.o
>   CC      arch/x86/kernel/i8259.o
>   CC      arch/x86/kernel/irqinit.o
>   CC [M]  arch/x86/crypto/twofish_glue.o
>   CC      arch/x86/kernel/jump_label.o
>   CC      arch/x86/kernel/irq_work.o
>   CC      ipc/ipc_sysctl.o
>   CC      arch/x86/kernel/probe_roms.o
>   CC      arch/x86/kernel/sys_x86_64.o
>   CC      fs/pipe.o
>   CC      fs/namei.o
>   CC      mm/readahead.o
>   CC      mm/swap.o
>   CC [M]  arch/x86/kvm/pmu.o
>   CC      arch/x86/mm/pat.o
>   LD [M]  arch/x86/crypto/aes-x86_64.o
>   LD [M]  arch/x86/crypto/twofish-x86_64.o
>   LD [M]  arch/x86/crypto/salsa20-x86_64.o
>   LD [M]  arch/x86/crypto/aesni-intel.o
>   CC      ipc/mqueue.o
>   CC      arch/x86/kernel/x8664_ksyms_64.o
>   LD [M]  arch/x86/crypto/ghash-clmulni-intel.o
>   LD [M]  arch/x86/crypto/crc32c-intel.o
>   CC      arch/x86/kernel/syscall_64.o
>   CC      kernel/sysctl.o
>   CC      arch/x86/mm/pgtable.o
>   CC      kernel/sysctl_binary.o
>   CC      arch/x86/mm/physaddr.o
>   CC      arch/x86/mm/gup.o
>   CC      arch/x86/mm/setup_nx.o
>   CC      arch/x86/mm/pat_rbtree.o
>   CC      arch/x86/mm/tlb.o
>   CC      mm/truncate.o
>   CC      mm/vmscan.o
>   CC      mm/shmem.o
>   CC      mm/util.o
>   CC      arch/x86/kernel/vsyscall_64.o
>   AS      arch/x86/kernel/vsyscall_emu_64.o
>   CC      mm/mmzone.o
>   CC      fs/fcntl.o
>   CC      mm/vmstat.o
>   CC      kernel/capability.o
>   CC      mm/backing-dev.o
>   CC      security/integrity/iint.o
>   CC      crypto/api.o
>   CC      crypto/cipher.o
>   CC      crypto/compress.o
>   CC      crypto/algapi.o
>   CC      ipc/compat_mq.o
>   CC      arch/x86/mm/hugetlbpage.o
>   CC      security/integrity/ima/ima_fs.o
>   CC      security/integrity/ima/ima_queue.o
>   CC      security/integrity/ima/ima_init.o
>   CC      arch/x86/kernel/bootflag.o
>   LD      security/integrity/integrity.o
>   CC      arch/x86/mm/numa.o
>   CC      arch/x86/mm/numa_64.o
>   CC      arch/x86/kernel/e820.o
>   CC      arch/x86/kernel/pci-dma.o
>   CC      arch/x86/kernel/quirks.o
>   CC      arch/x86/kernel/topology.o
>   CC      arch/x86/mm/amdtopology.o
>   CC      ipc/namespace.o
>   CC      ipc/mq_sysctl.o
>   CC      arch/x86/kernel/kdebugfs.o
>   CC      mm/mm_init.o
>   CC      mm/mmu_context.o
>   CC      security/integrity/ima/ima_main.o
>   CC      kernel/ptrace.o
>   CC      security/integrity/ima/ima_crypto.o
>   CC      security/integrity/ima/ima_api.o
>   CC      security/integrity/ima/ima_policy.o
>   CC      kernel/timer.o
>   CC      kernel/user.o
>   CC      security/integrity/ima/ima_audit.o
>   LD      ipc/built-in.o
>   CC      kernel/signal.o
>   CC      kernel/sys.o
>   CC      kernel/kmod.o
>   CC      kernel/workqueue.o
>   CC      block/elevator.o
>   CC      block/blk-core.o
>   CC      block/blk-tag.o
>   CC      block/blk-sysfs.o
>   CC      block/blk-flush.o
>   CC      block/blk-settings.o
>   CC      drivers/acpi/tables.o
>   CC      arch/x86/mm/srat.o
>   LD      sound/built-in.o
>   CC      fs/ioctl.o
>   CC [M]  sound/sound_core.o
>   CC      crypto/scatterwalk.o
>   LD      security/integrity/ima/ima.o
>   CC      crypto/proc.o
>   LD      security/integrity/ima/built-in.o
>   LD      security/integrity/built-in.o
>   CC      crypto/ablkcipher.o
>   CC      security/keys/gc.o
>   CC      security/keys/key.o
>   CC      security/keys/keyring.o
>   CC      arch/x86/kernel/alternative.o
>   LD      arch/x86/mm/built-in.o
>   CC      arch/x86/kernel/i8253.o
>   CC      security/keys/keyctl.o
>   CC      drivers/acpi/blacklist.o
>   CC      drivers/acpi/osl.o
>   CC      arch/x86/kernel/pci-nommu.o
>   CC      arch/x86/kernel/hw_breakpoint.o
>   CC      security/keys/permission.o
>   CC      mm/percpu.o
>   CC [M]  sound/ac97_bus.o
>   LD [M]  arch/x86/kvm/kvm.o
>   LD [M]  arch/x86/kvm/kvm-intel.o
>   LD [M]  arch/x86/kvm/kvm-amd.o
>   CC      drivers/acpi/utils.o
>   CC      kernel/pid.o
>   CC      kernel/task_work.o
>   CC      kernel/rcupdate.o
>   LD      drivers/amba/built-in.o
>   CC      kernel/extable.o
>   CC      block/blk-ioc.o
>   CC      block/blk-map.o
>   CC      kernel/params.o
>   CC      kernel/posix-timers.o
>   LD      sound/arm/built-in.o
>   CC      block/blk-exec.o
>   CC      block/blk-merge.o
>   CC      fs/readdir.o
>   CC      fs/select.o
>   CC      block/blk-softirq.o
>   CC      drivers/acpi/reboot.o
>   CC      drivers/acpi/nvs.o
>   CC      crypto/blkcipher.o
>   CC      drivers/acpi/wakeup.o
>   CC      security/keys/process_keys.o
>   LD      sound/atmel/built-in.o
>   CC      security/keys/request_key.o
>   LD      sound/core/oss/built-in.o
>   CC      arch/x86/kernel/tsc.o
>   CC [M]  sound/core/oss/mixer_oss.o
>   CC [M]  sound/core/oss/pcm_oss.o
>   CC      security/keys/request_key_auth.o
>   CC      security/keys/user_defined.o
>   CC      security/keys/compat.o
>   CC      drivers/acpi/sleep.o
>   CC      security/keys/proc.o
>   CC      arch/x86/kernel/io_delay.o
>   CC      arch/x86/kernel/rtc.o
>   LD      sound/core/seq/built-in.o
>   CC [M]  sound/core/seq/seq_device.o
>   CC [M]  sound/core/seq/seq_dummy.o
>   CC [M]  sound/core/seq/seq_midi_emul.o
>   CC      kernel/kthread.o
>   CC      kernel/wait.o
>   CC      kernel/kfifo.o
>   CC      kernel/sys_ni.o
>   CC      kernel/posix-cpu-timers.o
>   CC      mm/slab_common.o
>   CC [M]  sound/core/oss/pcm_plugin.o
>   CC      mm/compaction.o
>   CC      mm/balloon_compaction.o
>   CC      mm/interval_tree.o
>   CC      block/blk-timeout.o
>   CC      block/blk-iopoll.o
>   CC      block/blk-lib.o
>   CC      security/keys/sysctl.o
>   CC      fs/fifo.o
>   CC      crypto/ahash.o
>   CC      fs/dcache.o
>   CC      fs/inode.o
>   LD      security/keys/built-in.o
>   CC      arch/x86/kernel/pci-iommu_table.o
>   GEN     security/selinux/flask.h security/selinux/av_permissions.h
>   CC      drivers/acpi/device_pm.o
>   CC      security/selinux/avc.o
>   CC      drivers/acpi/proc.o
>   CC      drivers/acpi/bus.o
>   CC      security/selinux/hooks.o
>   CC      crypto/shash.o
>   CC      security/selinux/selinuxfs.o
>   CC [M]  sound/core/seq/seq_midi_event.o
>   CC      security/selinux/netlink.o
>   CC      kernel/mutex.o
>   CC [M]  sound/core/hrtimer.o
>   CC [M]  sound/core/hwdep.o
>   CC [M]  sound/core/memalloc.o
>   CC      security/selinux/nlmsgtab.o
>   CC      arch/x86/kernel/resource.o
>   CC      arch/x86/kernel/process.o
>   CC      arch/x86/kernel/i387.o
>   CC      security/selinux/netif.o
>   CC      security/selinux/netnode.o
>   CC      block/ioctl.o
>   CC      security/selinux/netport.o
>   CC      arch/x86/kernel/xsave.o
>   CC      mm/fremap.o
>   CC      mm/highmem.o
>   CC [M]  sound/core/oss/io.o
>   CC [M]  sound/core/oss/copy.o
>   CC      kernel/hrtimer.o
>   CC      kernel/rwsem.o
>   CC [M]  sound/core/seq/seq_midi.o
>   CC [M]  sound/core/seq/seq_virmidi.o
>   CC [M]  sound/core/seq/seq.o
>   CC [M]  sound/core/seq/seq_lock.o
>   CC [M]  sound/core/seq/seq_clientmgr.o
>   CC      drivers/acpi/glue.o
>   CC      drivers/acpi/scan.o
>   CC [M]  sound/core/seq/seq_memory.o
>   CC [M]  sound/core/seq/seq_queue.o
>   CC [M]  sound/core/oss/linear.o
>   CC [M]  sound/core/seq/seq_fifo.o
>   CC [M]  sound/core/seq/seq_prioq.o
>   CC      crypto/algboss.o
>   CC [M]  sound/core/seq/seq_timer.o
>   CC [M]  sound/core/seq/seq_system.o
>   CC      security/selinux/exports.o
>   CC      mm/madvise.o
>   CC      security/selinux/ss/ebitmap.o
>   CC      block/genhd.o
>   CC      block/scsi_ioctl.o
>   CC      block/partition-generic.o
>   CC      block/partitions/check.o
>   CC      block/partitions/amiga.o
>   CC      block/partitions/mac.o
>   CC      block/bsg.o
>   CC      block/partitions/msdos.o
>   CC      arch/x86/kernel/ptrace.o
>   CC      arch/x86/kernel/tls.o
>   CC      block/partitions/osf.o
>   CC [M]  sound/core/oss/mulaw.o
>   CC      block/partitions/sgi.o
>   CC      fs/attr.o
>   CC      fs/bad_inode.o
>   CC      fs/file.o
>   CC      fs/filesystems.o
>   CC      mm/memory.o
>   CC      mm/mincore.o
>   CC      crypto/testmgr.o
>   CC      crypto/crypto_wq.o
>   CC      crypto/aead.o
>   CC      crypto/chainiv.o
>   CC      security/commoncap.o
>   CC      drivers/acpi/resource.o
>   CC      security/min_addr.o
>   CC      kernel/nsproxy.o
>   CC      kernel/srcu.o
>   CC      security/security.o
>   CC [M]  sound/core/oss/route.o
>   CC      security/capability.o
>   LD      sound/drivers/built-in.o
>   CC [M]  sound/drivers/aloop.o
>   CC [M]  sound/drivers/dummy.o
>   CC      block/partitions/sun.o
>   CC      block/partitions/efi.o
>   CC      block/partitions/karma.o
>   CC      security/inode.o
>   CC [M]  sound/drivers/mtpav.o
>   CC [M]  sound/drivers/virmidi.o
>   CC      crypto/eseqiv.o
>   LD      crypto/crypto_hash.o
>   CC [M]  sound/core/oss/rate.o
>   CC [M]  sound/core/seq/seq_ports.o
>   CC      kernel/semaphore.o
>   CC [M]  sound/core/seq/seq_info.o
>   LD      sound/core/seq/oss/built-in.o
>   CC [M]  sound/core/seq/oss/seq_oss.o
>   CC      fs/namespace.o
>   CC      drivers/acpi/processor_core.o
>   CC      fs/seq_file.o
>   CC      fs/xattr.o
>   CC      arch/x86/kernel/step.o
>   CC      security/selinux/ss/hashtab.o
>   CC      security/selinux/ss/symtab.o
>   CC      security/selinux/ss/sidtab.o
>   CC      mm/mlock.o
>   CC      security/selinux/ss/avtab.o
>   CC      security/selinux/ss/policydb.o
>   CC      kernel/notifier.o
>   LD      block/partitions/built-in.o
>   CC      block/bsg-lib.o
>   CC      kernel/ksysfs.o
>   CC [M]  sound/core/seq/oss/seq_oss_init.o
>   CC      kernel/cred.o
>   CC      crypto/pcompress.o
>   LD      firmware/built-in.o
>   LD      crypto/cryptomgr.o
>   LD [M]  sound/core/oss/snd-mixer-oss.o
>   CC      kernel/async.o
>   CC      kernel/range.o
>   LD [M]  sound/core/oss/snd-pcm-oss.o
>   CC      kernel/groups.o
>   CC      drivers/ata/libata-core.o
>   CC      block/blk-cgroup.o
>   CC      arch/x86/kernel/i8237.o
>   LD      sound/drivers/mpu401/built-in.o
>   CC [M]  sound/drivers/mpu401/mpu401_uart.o
>   CC [M]  sound/drivers/mpu401/mpu401.o
>   CC      drivers/acpi/ec.o
>   LD [M]  sound/core/seq/snd-seq.o
>   CC [M]  sound/core/seq/oss/seq_oss_timer.o
>   CC      arch/x86/kernel/stacktrace.o
>   CC      arch/x86/kernel/acpi/boot.o
>   CC      arch/x86/kernel/acpi/sleep.o
>   AS      arch/x86/kernel/acpi/wakeup_64.o
>   CC [M]  sound/core/seq/oss/seq_oss_ioctl.o
>   CC [M]  sound/core/sgbuf.o
>   CC      arch/x86/kernel/apic/apic.o
>   CC      arch/x86/kernel/apic/apic_noop.o
>   CC      arch/x86/kernel/apic/ipi.o
>   CC      arch/x86/kernel/apic/hw_nmi.o
>   CC [M]  sound/core/pcm.o
>   CC [M]  sound/core/pcm_native.o
>   LD      sound/drivers/opl3/built-in.o
>   CC [M]  sound/drivers/opl3/opl3_lib.o
>   LD      sound/drivers/opl4/built-in.o
>   CC      crypto/hmac.o
>   LD      drivers/atm/built-in.o
>   CC [M]  drivers/atm/atmtcp.o
>   CC      arch/x86/kernel/reboot.o
>   LD [M]  sound/drivers/mpu401/snd-mpu401-uart.o
>   CC      mm/mmap.o
>   LD [M]  sound/drivers/mpu401/snd-mpu401.o
>   CC      arch/x86/kernel/cpu/intel_cacheinfo.o
>   CC      arch/x86/kernel/cpu/scattered.o
>   CC      arch/x86/kernel/cpu/topology.o
>   CC      drivers/ata/libata-scsi.o
>   CC [M]  sound/core/seq/oss/seq_oss_event.o
>   CC [M]  sound/core/seq/oss/seq_oss_rw.o
>   CC      drivers/ata/libata-eh.o
>   CC      drivers/ata/libata-transport.o
>   CC      block/blk-throttle.o
>   CC      kernel/lglock.o
>   CC      block/noop-iosched.o
>   CC      security/lsm_audit.o
>   CC [M]  sound/drivers/opl3/opl3_synth.o
>   CC      drivers/acpi/dock.o
>   CC      fs/libfs.o
>   CC      crypto/md5.o
>   CC      crypto/sha1_generic.o
>   CC [M]  sound/core/seq/oss/seq_oss_synth.o
>   LD      arch/x86/kernel/acpi/built-in.o
>   CC [M]  sound/core/seq/oss/seq_oss_midi.o
>   CC      crypto/sha256_generic.o
>   CC      kernel/smpboot.o
>   CC      kernel/events/core.o
>   CC      kernel/events/ring_buffer.o
>   CC      arch/x86/kernel/cpu/proc.o
>   CC      kernel/events/callchain.o
>   CC      kernel/events/hw_breakpoint.o
>   CC [M]  sound/drivers/opl3/opl3_seq.o
>   CC      security/selinux/ss/services.o
>   CC      fs/fs-writeback.o
>   CC      fs/pnode.o
>   MKCAP   arch/x86/kernel/cpu/capflags.c
>   CC      arch/x86/kernel/cpu/powerflags.o
>   CC      arch/x86/kernel/cpu/common.o
>   LD      sound/drivers/pcsp/built-in.o
>   CC [M]  sound/drivers/pcsp/pcsp.o
>   CC      block/deadline-iosched.o
>   CC [M]  sound/drivers/pcsp/pcsp_lib.o
>   CC [M]  sound/drivers/pcsp/pcsp_mixer.o
>   CC      arch/x86/kernel/apic/io_apic.o
>   CC      arch/x86/kernel/apic/apic_flat_64.o
>   CC [M]  sound/drivers/pcsp/pcsp_input.o
>   CC [M]  sound/core/seq/oss/seq_oss_readq.o
>   LD      drivers/auxdisplay/built-in.o
>   CC [M]  drivers/auxdisplay/ks0108.o
>   CC      drivers/acpi/pci_root.o
>   CC [M]  sound/drivers/opl3/opl3_midi.o
>   CC      crypto/aes_generic.o
>   CC [M]  sound/drivers/opl3/opl3_drums.o
>   CC      crypto/crc32c.o
>   CC [M]  sound/drivers/opl3/opl3_oss.o
>   CC [M]  sound/core/seq/oss/seq_oss_writeq.o
>   CC      mm/mprotect.o
>   LD      sound/firewire/built-in.o
>   LD [M]  sound/drivers/pcsp/snd-pcsp.o
>   CC      security/selinux/ss/conditional.o
>   LD      sound/i2c/built-in.o
>   CC      security/selinux/ss/mls.o
>   CC [M]  sound/i2c/cs8427.o
>   CC      security/selinux/ss/status.o
>   CC      block/cfq-iosched.o
>   CC [M]  drivers/auxdisplay/cfag12864b.o
>   CC      block/compat_ioctl.o
>   CC      arch/x86/kernel/cpu/vmware.o
>   CC      arch/x86/kernel/cpu/hypervisor.o
>   LD [M]  sound/core/seq/oss/snd-seq-oss.o
>   LD [M]  sound/core/seq/snd-seq-device.o
>   LD [M]  sound/core/seq/snd-seq-midi-event.o
>   CC      arch/x86/kernel/cpu/mshyperv.o
>   LD [M]  sound/core/seq/snd-seq-dummy.o
>   CC      arch/x86/kernel/cpu/rdrand.o
>   LD [M]  sound/core/seq/snd-seq-virmidi.o
>   LD [M]  sound/core/seq/snd-seq-midi.o
>   CC      block/blk-integrity.o
>   LD [M]  sound/core/seq/snd-seq-midi-emul.o
>   CC [M]  sound/core/pcm_lib.o
>   LD [M]  sound/drivers/opl3/snd-opl3-lib.o
>   LD [M]  sound/drivers/opl3/snd-opl3-synth.o
>   LD      sound/drivers/vx/built-in.o
>   CC [M]  sound/drivers/vx/vx_core.o
>   CC [M]  sound/drivers/vx/vx_hwdep.o
>   CC      drivers/ata/libata-sff.o
>   CC [M]  sound/drivers/vx/vx_pcm.o
>   CC [M]  sound/drivers/vx/vx_mixer.o
>   CC      drivers/ata/libata-pmp.o
>   CC      drivers/ata/libata-acpi.o
>   CC      drivers/acpi/pci_link.o
>   CC      mm/mremap.o
>   CC [M]  drivers/auxdisplay/cfag12864bfb.o
>   CC      arch/x86/kernel/cpu/match.o
>   CC      arch/x86/kernel/cpu/bugs_64.o
>   CC      arch/x86/kernel/apic/probe_64.o
>   CC      crypto/rng.o
>   CC      drivers/base/core.o
>   CC [M]  sound/i2c/i2c.o
>   CC      security/selinux/xfrm.o
>   CC      security/selinux/netlabel.o
>   LD      drivers/bcma/built-in.o
>   CC [M]  drivers/bcma/main.o
>   CC      arch/x86/kernel/cpu/intel.o
>   CC      arch/x86/kernel/cpu/amd.o
>   CC      arch/x86/kernel/cpu/centaur.o
>   CC [M]  drivers/ata/ahci.o
>   CC [M]  drivers/ata/libahci.o
>   CC      fs/drop_caches.o
>   CC [M]  drivers/ata/sata_inic162x.o
>   CC      drivers/acpi/pci_irq.o
>   CC      mm/msync.o
>   CC      mm/rmap.o
>   CC [M]  sound/drivers/vx/vx_cmd.o
>   LD      arch/x86/kernel/apic/built-in.o
>   CC [M]  sound/drivers/vx/vx_uer.o
>   CC      crypto/krng.o
>   LD      sound/i2c/other/built-in.o
>   CC [M]  sound/i2c/other/ak4113.o
>   CC [M]  sound/i2c/other/ak4114.o
>   CC [M]  sound/i2c/other/ak4xxx-adda.o
>   CC [M]  sound/i2c/other/pt2258.o
>   CC      fs/splice.o
>   CC      fs/sync.o
>   CC      fs/utimes.o
>   CC      drivers/block/brd.o
>   LD      security/selinux/selinux.o
>   LD      drivers/block/aoe/built-in.o
>   CC      arch/x86/kernel/cpu/perf_event.o
>   LD      security/selinux/built-in.o
>   CC [M]  drivers/block/aoe/aoeblk.o
>   CC      security/device_cgroup.o
>   CC [M]  drivers/bcma/scan.o
>   CC [M]  drivers/bcma/core.o
>   CC      crypto/asymmetric_keys/asymmetric_type.o
>   CC      drivers/acpi/pci_bind.o
>   LD [M]  sound/drivers/vx/snd-vx-lib.o
>   LD [M]  sound/drivers/snd-dummy.o
>   LD [M]  sound/drivers/snd-aloop.o
>   LD [M]  sound/drivers/snd-virmidi.o
>   LD [M]  sound/drivers/snd-mtpav.o
>   CC [M]  sound/core/pcm_timer.o
>   CC [M]  sound/core/pcm_misc.o
>   CC      drivers/acpi/acpi_platform.o
>   LD      block/built-in.o
>   CC      drivers/acpi/power.o
>   CC      drivers/acpi/event.o
>   CC      drivers/acpi/sysfs.o
>   CC      crypto/asymmetric_keys/signature.o
>   ASN.1   crypto/asymmetric_keys/x509-asn1.c
> Extracted 200 tokens
> Extracted 14 types
> Extracted 11 actions
> Pass 1
> Pass 2
>   CC      arch/x86/kernel/msr.o
>   CC [M]  drivers/ata/sata_sil24.o
>   CC      drivers/acpi/debugfs.o
>   LD      drivers/bluetooth/built-in.o
>   CC [M]  drivers/bluetooth/hci_vhci.o
>   LD      kernel/events/built-in.o
>   CC [M]  drivers/bluetooth/btmrvl_main.o
>   CC      drivers/base/bus.o
>   LD      security/built-in.o
>   CC [M]  drivers/bcma/sprom.o
>   CC      kernel/ipipe/core.o
>   LD [M]  sound/i2c/other/snd-ak4xxx-adda.o
>   LD [M]  sound/i2c/other/snd-ak4114.o
>   LD [M]  sound/i2c/other/snd-ak4113.o
>   LD [M]  sound/i2c/other/snd-pt2258.o
>   LD      drivers/bus/built-in.o
>   CC      drivers/block/loop.o
>   LD      drivers/cdrom/built-in.o
>   LD [M]  sound/i2c/snd-cs8427.o
>   CC [M]  drivers/cdrom/cdrom.o
>   LD [M]  sound/i2c/snd-i2c.o
>   CC [M]  drivers/ata/pdc_adma.o
>   CC [M]  drivers/block/floppy.o
>   CC      drivers/base/dd.o
>   CC      mm/vmalloc.o
>   CC [M]  drivers/block/aoe/aoechr.o
>   CC [M]  drivers/block/aoe/aoecmd.o
>   ASN.1   crypto/asymmetric_keys/x509_rsakey-asn1.c
> Extracted 16 tokens
> Extracted 1 types
> Extracted 1 actions
> Pass 1
> Pass 2
>   CC      crypto/asymmetric_keys/x509_public_key.o
>   CC [M]  sound/core/pcm_memory.o
>   CC [M]  sound/core/rawmidi.o
>   CC [M]  sound/core/timer.o
>   CC [M]  drivers/block/aoe/aoedev.o
>   CC      kernel/ipipe/timer.o
>   CC [M]  drivers/block/aoe/aoemain.o
>   CC [M]  drivers/bcma/driver_chipcommon.o
>   CC      drivers/acpi/numa.o
>   CC      crypto/asymmetric_keys/public_key.o
>   CC      crypto/asymmetric_keys/rsa.o
>   CC [M]  sound/core/sound.o
>   CC [M]  sound/core/init.o
>   CC      fs/stack.o
>   CC      fs/fs_struct.o
>   CC [M]  drivers/ata/sata_qstor.o
>   CC      drivers/base/syscore.o
>   CC      arch/x86/kernel/cpu/perf_event_amd.o
>   CC      drivers/base/driver.o
>   CC      arch/x86/kernel/cpu/perf_event_p6.o
>   CC      arch/x86/kernel/cpu/perf_event_knc.o
>   CC      crypto/asymmetric_keys/x509-asn1.o
>   CC      crypto/asymmetric_keys/x509_rsakey-asn1.o
>   CC      drivers/base/class.o
>   CC [M]  drivers/bcma/driver_chipcommon_pmu.o
>   CC      crypto/asymmetric_keys/x509_cert_parser.o
>   CC      drivers/acpi/cm_sbs.o
>   CC      kernel/ipipe/compat.o
>   CC      drivers/acpi/video_detect.o
>   CC [M]  drivers/bluetooth/btmrvl_debugfs.o
>   CC [M]  drivers/bluetooth/hci_ldisc.o
>   CC      fs/statfs.o
>   CC [M]  drivers/bluetooth/hci_h4.o
>   CC      fs/buffer.o
>   CC      fs/bio.o
>   CC [M]  sound/core/memory.o
>   CC [M]  sound/core/info.o
>   LD      crypto/asymmetric_keys/asymmetric_keys.o
>   LD      crypto/asymmetric_keys/x509_key_parser.o
>   LD      crypto/asymmetric_keys/built-in.o
>   LD      crypto/async_tx/built-in.o
>   CC [M]  crypto/async_tx/async_tx.o
>   CC [M]  crypto/async_tx/async_memcpy.o
>   CC [M]  drivers/block/aoe/aoenet.o
>   CC [M]  crypto/async_tx/async_xor.o
>   CC      drivers/base/platform.o
>   CC      arch/x86/kernel/cpu/perf_event_p4.o
>   LD      kernel/ipipe/built-in.o
>   CC      drivers/base/cpu.o
>   CC      kernel/irq/irqdesc.o
>   CC      drivers/base/firmware.o
>   CC      mm/pagewalk.o
>   CC      mm/pgtable-generic.o
>   CC      mm/process_vm_access.o
>   CC      drivers/acpi/acpica/dsargs.o
>   CC [M]  drivers/bcma/driver_pci.o
>   CC [M]  drivers/bcma/driver_gmac_cmn.o
>   CC [M]  drivers/ata/sata_sx4.o
>   CC      drivers/acpi/acpica/dscontrol.o
>   CC [M]  drivers/ata/ata_piix.o
>   CC      drivers/char/mem.o
>   CC [M]  drivers/bluetooth/hci_bcsp.o
>   CC [M]  drivers/bluetooth/hci_ll.o
>   CC [M]  drivers/bluetooth/bcm203x.o
>   CC [M]  drivers/bluetooth/bpa10x.o
>   CC      drivers/char/random.o
>   CC [M]  sound/core/control.o
>   CC      drivers/char/misc.o
>   CC [M]  crypto/async_tx/async_pq.o
>   CC      drivers/char/raw.o
>   LD [M]  drivers/block/aoe/aoe.o
>   CC [M]  crypto/async_tx/async_raid6_recov.o
>   CC [M]  crypto/async_tx/raid6test.o
>   CC      kernel/irq/handle.o
>   CC      arch/x86/kernel/cpu/perf_event_intel_lbr.o
>   CC      drivers/acpi/acpica/dsfield.o
>   CC      drivers/acpi/acpica/dsinit.o
>   CC      mm/init-mm.o
>   CC [M]  drivers/bcma/driver_gpio.o
>   CC      mm/nobootmem.o
>   CC      mm/memblock.o
>   CC      mm/bounce.o
>   CC      mm/page_io.o
>   CC      kernel/irq/manage.o
>   CC      drivers/acpi/acpica/dsmethod.o
>   CC      kernel/irq/spurious.o
>   CC      kernel/irq/resend.o
>   LD      drivers/char/ipmi/built-in.o
>   CC [M]  drivers/block/cciss.o
>   CC [M]  drivers/char/ipmi/ipmi_msghandler.o
>   CC [M]  drivers/ata/sata_mv.o
>   CC [M]  drivers/char/ipmi/ipmi_devintf.o
>   CC [M]  drivers/bcma/host_pci.o
>   CC      drivers/base/init.o
>   CC      drivers/base/map.o
>   CC      drivers/base/devres.o
>   CC      drivers/base/attribute_container.o
>   CC      drivers/base/transport_class.o
>   CC      arch/x86/kernel/cpu/perf_event_intel_ds.o
>   CC      arch/x86/kernel/cpu/perf_event_intel.o
>   CC      arch/x86/kernel/cpu/perf_event_intel_uncore.o
>   CC      arch/x86/kernel/cpu/mcheck/mce.o
>   CC      drivers/acpi/acpica/dsmthdat.o
>   CC      drivers/acpi/acpica/dsobject.o
>   CC [M]  drivers/bluetooth/bfusb.o
>   CC [M]  crypto/seqiv.o
>   CC [M]  crypto/vmac.o
>   CC      fs/block_dev.o
>   CC      fs/direct-io.o
>   CC      fs/mpage.o
>   LD [M]  drivers/bcma/bcma.o
>   CC      fs/ioprio.o
>   CC      drivers/char/hpet.o
>   CC      fs/proc_namespace.o
>   CC      mm/swap_state.o
>   CC      mm/swapfile.o
>   CC      drivers/base/topology.o
>   CC      drivers/base/devtmpfs.o
>   CC      drivers/base/power/sysfs.o
>   CC      drivers/acpi/acpica/dsopcode.o
>   CC      drivers/acpi/acpica/dsutils.o
>   CC [M]  sound/core/misc.o
>   CC      drivers/acpi/acpica/dswexec.o
>   CC      kernel/irq/chip.o
>   CC      kernel/irq/dummychip.o
>   CC      kernel/irq/devres.o
>   CC      kernel/irq/autoprobe.o
>   CC      kernel/irq/irqdomain.o
>   CC      drivers/base/power/generic_ops.o
>   CC [M]  drivers/bluetooth/dtl1_cs.o
>   CC      drivers/base/power/common.o
>   CC      drivers/char/nvram.o
>   CC      drivers/acpi/acpica/dswload.o
>   CC      drivers/char/agp/backend.o
>   CC      drivers/char/hw_random/core.o
>   CC      drivers/char/agp/frontend.o
>   CC      drivers/char/agp/generic.o
>   CC      drivers/char/hw_random/tpm-rng.o
>   CC [M]  crypto/xcbc.o
>   CC [M]  sound/core/device.o
>   CC [M]  sound/core/isadma.o
>   CC [M]  drivers/char/hw_random/timeriomem-rng.o
>   LD      drivers/char/pcmcia/built-in.o
>   CC [M]  drivers/char/pcmcia/cm4000_cs.o
>   CC      drivers/base/power/qos.o
>   CC      drivers/base/power/main.o
>   CC [M]  drivers/char/pcmcia/cm4040_cs.o
>   CC      drivers/acpi/acpica/dswload2.o
>   CC      drivers/acpi/acpica/dswscope.o
>   CC      fs/bio-integrity.o
>   CC [M]  drivers/ata/sata_nv.o
>   CC      arch/x86/kernel/cpu/mcheck/mce-severity.o
>   LD      fs/autofs4/built-in.o
>   CC [M]  crypto/crypto_null.o
>   CC [M]  fs/autofs4/init.o
>   CC      kernel/irq/proc.o
>   CC      kernel/irq/migration.o
>   CC [M]  drivers/char/hw_random/intel-rng.o
>   CC [M]  drivers/char/hw_random/amd-rng.o
>   CC [M]  drivers/char/hw_random/via-rng.o
>   CC [M]  fs/autofs4/inode.o
>   CC [M]  drivers/bluetooth/bt3c_cs.o
>   CC [M]  sound/core/sound_oss.o
>   CC [M]  drivers/char/ipmi/ipmi_si_intf.o
>   CC [M]  drivers/bluetooth/bluecard_cs.o
>   CC [M]  drivers/char/hw_random/virtio-rng.o
>   CC      arch/x86/kernel/cpu/mcheck/mce_intel.o
>   CC      drivers/acpi/acpica/dswstate.o
>   CC      drivers/base/dma-mapping.o
>   CC      drivers/base/regmap/regmap.o
>   CC      drivers/base/regmap/regcache.o
>   CC [M]  crypto/md4.o
>   CC [M]  crypto/rmd128.o
>   CC [M]  crypto/rmd160.o
>   CC      kernel/irq/pm.o
>   CC      mm/dmapool.o
>   CC      mm/hugetlb.o
>   LD      drivers/char/hw_random/rng-core.o
>   LD      drivers/char/hw_random/built-in.o
>   CC      mm/mempolicy.o
>   CC      mm/sparse.o
>   CC      arch/x86/kernel/cpu/mcheck/mce_amd.o
>   CC [M]  sound/core/info_oss.o
>   CC [M]  fs/autofs4/root.o
>   CC      drivers/acpi/acpica/evevent.o
>   CC      drivers/acpi/acpica/evgpe.o
>   CC      drivers/acpi/acpica/evgpeblk.o
>   CC      drivers/acpi/acpica/evgpeinit.o
>   CC      drivers/char/agp/isoch.o
>   LD      kernel/irq/built-in.o
>   CC      kernel/power/qos.o
>   CC      kernel/sched/core.o
>   CC      drivers/base/power/wakeup.o
>   CC      drivers/base/power/runtime.o
>   CC      kernel/sched/clock.o
>   CC      mm/sparse-vmemmap.o
>   CC      mm/mmu_notifier.o
>   CC [M]  drivers/bluetooth/btuart_cs.o
>   CC [M]  drivers/bluetooth/btusb.o
>   CC [M]  drivers/ata/sata_promise.o
>   CC [M]  drivers/ata/sata_sil.o
>   CC [M]  drivers/ata/sata_sis.o
>   CC      drivers/acpi/acpica/evgpeutil.o
>   CC      drivers/acpi/acpica/evglock.o
>   CC [M]  sound/core/vmaster.o
>   CC [M]  crypto/rmd256.o
>   CC [M]  drivers/block/pktcdvd.o
>   CC      arch/x86/kernel/cpu/mcheck/threshold.o
>   CC      drivers/char/agp/compat_ioctl.o
>   CC [M]  fs/autofs4/symlink.o
>   CC [M]  drivers/char/ipmi/ipmi_kcs_sm.o
>   CC [M]  drivers/char/ipmi/ipmi_smic_sm.o
>   CC      arch/x86/kernel/cpu/mcheck/therm_throt.o
>   CC      kernel/power/main.o
>   CC      kernel/power/console.o
>   CC      drivers/acpi/acpica/evmisc.o
>   CC      kernel/power/process.o
>   CC      drivers/base/regmap/regcache-rbtree.o
>   CC      drivers/base/regmap/regcache-lzo.o
>   CC [M]  fs/autofs4/waitq.o
>   CC [M]  fs/autofs4/expire.o
>   CC [M]  crypto/rmd320.o
>   CC [M]  fs/autofs4/dev-ioctl.o
>   CC [M]  crypto/sha512_generic.o
>   CC [M]  sound/core/ctljack.o
>   CC      arch/x86/kernel/cpu/mtrr/main.o
>   LD      drivers/base/power/built-in.o
>   CC [M]  drivers/char/ipmi/ipmi_bt_sm.o
>   CC      drivers/char/agp/amd64-agp.o
>   CC      drivers/char/agp/intel-agp.o
>   CC      drivers/acpi/acpica/evregion.o
>   CC      drivers/char/agp/intel-gtt.o
>   CC      drivers/char/agp/sis-agp.o
>   CC      drivers/char/agp/via-agp.o
>   CC      arch/x86/kernel/cpu/mcheck/mce-apei.o
>   CC      drivers/base/regmap/regmap-debugfs.o
>   CC [M]  drivers/ata/sata_svw.o
>   CC [M]  drivers/bluetooth/btsdio.o
>   LD [M]  drivers/bluetooth/btmrvl.o
>   CC [M]  drivers/ata/sata_uli.o
>   CC      arch/x86/kernel/cpuid.o
>   CC [M]  drivers/base/regmap/regmap-i2c.o
>   CC      arch/x86/kernel/cpu/perfctr-watchdog.o
>   CC [M]  drivers/char/ipmi/ipmi_watchdog.o
>   CC [M]  sound/core/jack.o
>   CC      kernel/power/suspend.o
>   CC      mm/ksm.o
>   CC      mm/slab.o
>   CC      drivers/base/dma-buf.o
>   LD      drivers/clk/built-in.o
> drivers/base/regmap/regmap-debugfs.c: In function
> =E2=80=98regmap_debugfs_get_dump_start=E2=80=99:
> drivers/base/regmap/regmap-debugfs.c:83: warning: =E2=80=98ret=E2=80=99 m=
ay be used
> uninitialized in this function CC      drivers/clocksource/acpi_pm.o
> LD [M]  fs/autofs4/autofs4.o CC      drivers/base/firmware_class.o
>   CC      drivers/acpi/acpica/evrgnini.o
>   LD      fs/btrfs/built-in.o
>   CC [M]  fs/btrfs/super.o
>   CC [M]  crypto/wp512.o
>   CC [M]  crypto/tgr192.o
>   CC [M]  crypto/gf128mul.o
>   CC [M]  arch/x86/kernel/cpu/mcheck/mce-inject.o
>   CC      kernel/time/timekeeping.o
>   LD      drivers/base/regmap/built-in.o
>   CC      kernel/trace/trace_clock.o
>   CC [M]  drivers/ata/sata_via.o
>   CC [M]  drivers/ata/sata_vsc.o
>   CC [M]  drivers/bluetooth/btmrvl_sdio.o
>   CC      drivers/clocksource/i8253.o
>   CC [M]  drivers/block/nvme.o
>   CC      kernel/xenomai/arch/generic/hal.o
>   CC      drivers/acpi/acpica/evsci.o
>   LD      sound/core/built-in.o
>   CC      arch/x86/kernel/cpu/mtrr/if.o
>   LD [M]  sound/core/snd.o
>   LD [M]  sound/core/snd-hwdep.o
>   LD      drivers/char/agp/agpgart.o
>   LD [M]  sound/core/snd-timer.o
>   LD      drivers/char/agp/built-in.o
>   LD [M]  sound/core/snd-hrtimer.o
>   LD [M]  sound/core/snd-pcm.o
>   CC      drivers/char/tpm/tpm.o
>   LD [M]  sound/core/snd-page-alloc.o
>   CC [M]  drivers/char/ipmi/ipmi_poweroff.o
>   CC      kernel/power/hibernate.o
>   LD [M]  sound/core/snd-rawmidi.o
>   CC      kernel/power/snapshot.o
>   LD      sound/isa/built-in.o
>   LD      sound/isa/ad1816a/built-in.o
>   LD      arch/x86/kernel/cpu/mcheck/built-in.o
>   CC [M]  drivers/char/virtio_console.o
>   LD      sound/isa/cs423x/built-in.o
>   LD      sound/isa/ad1848/built-in.o
>   CC [M]  drivers/char/lp.o
>   LD      sound/isa/es1688/built-in.o
>   CC      kernel/power/swap.o
>   LD      sound/isa/galaxy/built-in.o
>   CC      kernel/trace/ftrace.o
>   LD      sound/isa/gus/built-in.o
>   LD      drivers/clocksource/built-in.o
>   LD      sound/isa/msnd/built-in.o
>   CC      kernel/freezer.o
>   LD      sound/isa/opti9xx/built-in.o
>   CC [M]  crypto/ecb.o
>   CC      drivers/acpi/acpica/evxface.o
>   LD      sound/isa/sb/built-in.o
>   CC [M]  sound/isa/sb/sb_common.o
>   CC [M]  sound/isa/sb/sb_mixer.o
>   CC [M]  sound/isa/sb/sb16_main.o
>   CC [M]  drivers/ata/pata_ali.o
>   CC      arch/x86/kernel/cpu/mtrr/generic.o
>   LD [M]  drivers/char/ipmi/ipmi_si.o
>   CC      arch/x86/kernel/cpu/mtrr/cleanup.o
>   LD      kernel/xenomai/arch/generic/xeno_hal.o
>   LD      kernel/xenomai/arch/generic/built-in.o
>   LD      kernel/xenomai/arch/built-in.o
>   CC [M]  crypto/cbc.o
>   CC      kernel/xenomai/nucleus/bufd.o
>   CC      drivers/base/node.o
>   CC      kernel/time/ntp.o
>   CC      drivers/base/memory.o
>   LD [M]  drivers/bluetooth/hci_uart.o
>   CC      drivers/base/module.o
>   CC      drivers/acpi/acpica/evxfevnt.o
>   CC      drivers/acpi/acpica/evxfgpe.o
>   CC      drivers/acpi/acpica/evxfregn.o
>   CC      drivers/acpi/acpica/exconfig.o
>   CC      drivers/acpi/acpica/exconvrt.o
>   CC [M]  drivers/ata/pata_amd.o
>   CC [M]  crypto/pcbc.o
>   CC      drivers/char/tpm/tpm_eventlog.o
>   CC      drivers/char/tpm/tpm_acpi.o
>   CC [M]  drivers/char/i8k.o
>   CC      kernel/power/user.o
>   CC      kernel/time/clocksource.o
>   LD [M]  sound/isa/sb/snd-sb-common.o
>   CC [M]  drivers/block/osdblk.o
>   LD [M]  sound/isa/sb/snd-sb16-dsp.o
>   LD      sound/isa/wavefront/built-in.o
>   LD      sound/isa/wss/built-in.o
>   CC [M]  drivers/block/cryptoloop.o
>   CC [M]  drivers/char/ppdev.o
>   LD      arch/x86/kernel/cpu/mtrr/built-in.o
>   CC      drivers/char/tpm/tpm_ppi.o
>   CC      arch/x86/kernel/cpu/perf_event_amd_ibs.o
>   LD      sound/mips/built-in.o
>   LD      sound/parisc/built-in.o
>   LD      sound/pci/built-in.o
>   CC [M]  sound/pci/ad1889.o
>   LD      sound/pcmcia/built-in.o
>   LD      sound/pcmcia/pdaudiocf/built-in.o
>   CC      kernel/xenomai/nucleus/heap.o
>   LD      sound/pcmcia/vx/built-in.o
>   CC [M]  sound/pci/atiixp_modem.o
>   CC      kernel/xenomai/nucleus/intr.o
>   CC [M]  sound/pci/atiixp.o
>   LD      drivers/base/built-in.o
>   CC      kernel/xenomai/skins/native/module.o
>   CC      kernel/xenomai/skins/native/task.o
>   CC      drivers/acpi/acpica/excreate.o
>   CC      drivers/acpi/acpica/exdebug.o
>   CC [M]  crypto/cts.o
>   CC [M]  fs/btrfs/ctree.o
>   CC [M]  crypto/lrw.o
>   CC [M]  crypto/xts.o
>   CC [M]  drivers/ata/pata_artop.o
>   CC [M]  fs/btrfs/extent-tree.o
>   CC [M]  drivers/block/virtio_blk.o
>   CC      kernel/power/block_io.o
>   CC      mm/memory_hotplug.o
>   CC      kernel/power/poweroff.o
>   CC      kernel/time/jiffies.o
>   CC      kernel/time/timer_list.o
>   CC      drivers/acpi/acpica/exdump.o
>   CC      drivers/char/tpm/tpm_tis.o
>   CC      drivers/acpi/acpica/exfield.o
>   CC      drivers/acpi/acpica/exfldio.o
>   CC      drivers/acpi/acpica/exmutex.o
>   CC      drivers/acpi/acpica/exnames.o
>   CC      kernel/trace/ring_buffer.o
>   CC      kernel/trace/trace.o
>   CC      arch/x86/kernel/cpu/capflags.o
>   CC      kernel/sched/cputime.o
>   CC      kernel/xenomai/nucleus/pod.o
>   CC [M]  drivers/ata/pata_atiixp.o
>   LD      kernel/power/built-in.o
>   CC      kernel/xenomai/nucleus/registry.o
>   LD      arch/x86/kernel/cpu/built-in.o
>   CC      kernel/xenomai/nucleus/synch.o
>   CC [M]  drivers/ata/pata_atp867x.o
>   CC [M]  crypto/ctr.o
>   CC [M]  sound/pci/bt87x.o
>   CC [M]  sound/pci/cmipci.o
>   CC      arch/x86/kernel/early-quirks.o
>   CC      kernel/time/timeconv.o
>   CC [M]  sound/pci/cs5530.o
>   CC [M]  drivers/block/sx8.o
>   LD      drivers/block/mtip32xx/built-in.o
>   CC [M]  drivers/block/mtip32xx/mtip32xx.o
>   CC [M]  sound/pci/ens1370.o
>   CC [M]  drivers/char/tpm/tpm_nsc.o
>   CC      mm/filemap_xip.o
>   CC      drivers/acpi/acpica/exoparg1.o
>   CC      kernel/sched/idle_task.o
>   CC      kernel/sched/fair.o
>   CC [M]  crypto/gcm.o
>   CC      kernel/time/posix-clock.o
>   CC      arch/x86/kernel/ipipe.o
>   CC      arch/x86/kernel/smp.o
>   CC      kernel/xenomai/skins/native/timer.o
>   CC [M]  drivers/ata/pata_cmd64x.o
>   CC [M]  drivers/ata/pata_hpt366.o
>   CC      drivers/acpi/acpica/exoparg2.o
>   CC [M]  drivers/char/tpm/tpm_atmel.o
>   CC      kernel/profile.o
>   CC      kernel/stacktrace.o
>   CC      mm/migrate.o
>   CC      drivers/acpi/acpica/exoparg3.o
>   CC      kernel/time/alarmtimer.o
>   CC      kernel/time/clockevents.o
>   CC [M]  drivers/char/tpm/tpm_infineon.o
>   CC      kernel/sched/rt.o
>   CC      kernel/sched/stop_task.o
>   CC [M]  drivers/ata/pata_hpt37x.o
>   CC      kernel/sched/cpupri.o
>   CC      kernel/sched/auto_group.o
>   CC      kernel/trace/trace_output.o
>   CC      kernel/trace/trace_stat.o
>   CC [M]  crypto/ccm.o
>   CC      arch/x86/kernel/smpboot.o
>   CC      drivers/acpi/acpica/exoparg6.o
>   CC      kernel/xenomai/skins/native/syscall.o
>   CC      drivers/acpi/acpica/exprep.o
>   CC [M]  sound/pci/ak4531_codec.o
>   CC [M]  sound/pci/ens1371.o
>   CC      drivers/acpi/acpica/exmisc.o
>   CC      drivers/acpi/acpica/exregion.o
>   CC      kernel/time/tick-common.o
>   CC      drivers/acpi/acpica/exresnte.o
>   CC      drivers/acpi/acpica/exresolv.o
>   CC      arch/x86/kernel/tsc_sync.o
>   LD      drivers/char/tpm/tpm_bios.o
>   CC      arch/x86/kernel/setup_percpu.o
>   LD      drivers/char/tpm/built-in.o
>   CC [M]  drivers/char/tlclk.o
>   CC      arch/x86/kernel/mpparse.o
>   CC      arch/x86/kernel/ftrace.o
>   CC [M]  drivers/ata/pata_hpt3x2n.o
>   CC      arch/x86/kernel/trace_clock.o
>   CC      arch/x86/kernel/machine_kexec_64.o
>   AS      arch/x86/kernel/relocate_kernel_64.o
>   LD      drivers/block/built-in.o
>   CC      arch/x86/kernel/crash.o
>   CC      arch/x86/kernel/crash_dump_64.o
>   CC [M]  crypto/cryptd.o
>   CC [M]  crypto/des_generic.o
>   CC      arch/x86/kernel/kprobes.o
>   CC      kernel/xenomai/skins/native/pipe.o
>   CC      kernel/time/tick-broadcast.o
>   CC      drivers/acpi/acpica/exresop.o
>   CC      drivers/acpi/acpica/exstore.o
>   CC      kernel/xenomai/nucleus/thread.o
>   CC      kernel/xenomai/nucleus/timebase.o
>   CC      kernel/trace/trace_printk.o
>   CC      mm/memory-failure.o
>   CC      kernel/trace/trace_sched_switch.o
>   CC      kernel/trace/trace_functions.o
>   CC      mm/page_isolation.o
>   CC      kernel/futex.o
>   CC      drivers/acpi/acpica/exstoren.o
>   CC      kernel/time/tick-oneshot.o
>   CC [M]  drivers/char/hangcheck-timer.o
>   CC      kernel/time/tick-sched.o
>   CC [M]  drivers/ata/pata_hpt3x3.o
>   CC [M]  drivers/ata/pata_it8213.o
>   LD      drivers/char/built-in.o
>   CC [M]  sound/pci/es1968.o
>   CC [M]  drivers/ata/pata_it821x.o
>   CC [M]  drivers/ata/pata_jmicron.o
>   CC [M]  sound/pci/intel8x0.o
>   CC [M]  drivers/ata/pata_marvell.o
>   CC      arch/x86/kernel/kprobes-opt.o
>   CC [M]  drivers/ata/pata_netcell.o
>   CC      drivers/acpi/apei/apei-base.o
>   CC      drivers/acpi/acpica/exstorob.o
>   CC      drivers/acpi/acpica/exsystem.o
>   LD      kernel/sched/built-in.o
>   CC [M]  fs/btrfs/print-tree.o
>   CC [M]  crypto/fcrypt.o
>   CC [M]  fs/btrfs/root-tree.o
>   CC [M]  fs/btrfs/dir-item.o
>   CC [M]  fs/btrfs/file-item.o
>   CC      kernel/xenomai/nucleus/timer.o
>   CC      kernel/trace/trace_sched_wakeup.o
>   CC      kernel/trace/trace_nop.o
>   CC      kernel/trace/trace_stack.o
>   CC      kernel/trace/trace_functions_graph.o
>   CC      drivers/acpi/acpica/exutils.o
>   CC      kernel/trace/blktrace.o
>   LD      kernel/time/built-in.o
>   CC [M]  crypto/blowfish_generic.o
>   CC      arch/x86/pci/i386.o
>   CC      arch/x86/pci/init.o
>   CC      arch/x86/pci/mmconfig_64.o
>   CC      drivers/connector/cn_queue.o
>   CC [M]  drivers/ata/pata_ninja32.o
>   CC      arch/x86/kernel/module.o
>   CC      arch/x86/kernel/early_printk.o
>   LD      mm/built-in.o
>   CC      arch/x86/kernel/hpet.o
>   CC      arch/x86/kernel/amd_nb.o
>   CC      kernel/xenomai/nucleus/sched.o
>   CC      arch/x86/pci/direct.o
>   CC      arch/x86/pci/mmconfig-shared.o
>   CC      drivers/acpi/acpica/hwacpi.o
>   CC      arch/x86/pci/fixup.o
>   CC      arch/x86/kernel/pcspeaker.o
>   CC      drivers/acpi/apei/hest.o
>   CC      drivers/acpi/apei/cper.o
>   CC [M]  crypto/blowfish_common.o
>   CC [M]  crypto/twofish_common.o
>   CC      arch/x86/kernel/pci-swiotlb.o
>   CC [M]  crypto/serpent_generic.o
>   CC [M]  crypto/camellia_generic.o
>   CC [M]  crypto/cast_common.o
>   CC [M]  crypto/cast5_generic.o
>   CC      drivers/acpi/acpica/hwesleep.o
>   CC [M]  drivers/ata/pata_oldpiix.o
>   CC [M]  fs/btrfs/inode-item.o
>   CC [M]  drivers/ata/pata_pdc2027x.o
>   CC [M]  drivers/ata/pata_pdc202xx_old.o
>   CC      kernel/xenomai/skins/native/sem.o
>   CC [M]  sound/pci/intel8x0m.o
>   CC      drivers/connector/connector.o
>   CC      drivers/connector/cn_proc.o
>   CC [M]  fs/btrfs/inode-map.o
>   CC      kernel/futex_compat.o
>   CC [M]  fs/btrfs/disk-io.o
>   CC      drivers/acpi/acpica/hwgpe.o
>   CC [M]  fs/btrfs/transaction.o
>   CC [M]  fs/btrfs/inode.o
>   CC      arch/x86/pci/acpi.o
>   CC      arch/x86/pci/legacy.o
>   CC      drivers/acpi/apei/erst.o
>   CC      kernel/trace/trace_events.o
>   CC      arch/x86/kernel/perf_regs.o
>   CC      kernel/trace/trace_export.o
>   CC [M]  drivers/ata/pata_rdc.o
>   CC      kernel/trace/trace_syscalls.o
>   CC      kernel/trace/trace_event_perf.o
>   CC      drivers/acpi/acpica/hwpci.o
>   CC      drivers/acpi/acpica/hwregs.o
>   CC      kernel/trace/trace_events_filter.o
>   CC      drivers/acpi/acpica/hwsleep.o
>   CC      kernel/xenomai/nucleus/sched-idle.o
>   CC      drivers/acpi/acpica/hwvalid.o
>   CC      drivers/acpi/acpica/hwxface.o
>   CC      drivers/acpi/acpica/hwxfsleep.o
>   CC [M]  drivers/ata/pata_sch.o
>   CC      arch/x86/kernel/audit_64.o
>   CC [M]  sound/pci/maestro3.o
>   LD      drivers/connector/cn.o
>   LD      drivers/connector/built-in.o
>   CC      arch/x86/kernel/amd_gart_64.o
>   CC      arch/x86/kernel/aperture_64.o
>   CC      arch/x86/pci/irq.o
>   CC      kernel/xenomai/skins/native/event.o
>   CC      arch/x86/pci/common.o
>   CC      kernel/xenomai/skins/native/mutex.o
>   CC      arch/x86/pci/early.o
>   CC      arch/x86/pci/bus_numa.o
>   CC      arch/x86/pci/amd_bus.o
>   CC      kernel/xenomai/skins/native/cond.o
>   CC      kernel/xenomai/nucleus/sched-rt.o
>   CC      kernel/xenomai/skins/native/queue.o
>   CC      kernel/xenomai/skins/native/heap.o
>   CC      kernel/xenomai/skins/native/alarm.o
>   CC      drivers/acpi/acpica/nsaccess.o
>   CC      drivers/acpi/apei/ghes.o
>   CC [M]  drivers/acpi/apei/einj.o
>   CC [M]  drivers/ata/pata_serverworks.o
>   CC [M]  drivers/acpi/apei/erst-dbg.o
>   CC      drivers/acpi/acpica/nsalloc.o
>   CC      drivers/acpi/acpica/nsdump.o
>   CC      drivers/acpi/acpica/nseval.o
>   CC      kernel/trace/trace_kprobe.o
>   CC      arch/x86/power/cpu.o
>   CC      arch/x86/power/hibernate_64.o
>   LD      arch/x86/pci/built-in.o
>   CC      arch/x86/kernel/pci-calgary_64.o
>   CC      arch/x86/kernel/tce_64.o
>   AS      arch/x86/power/hibernate_asm_64.o
>   CC      arch/x86/kernel/mmconf-fam10h_64.o
>   CC [M]  sound/pci/rme32.o
>   CC [M]  sound/pci/rme96.o
>   CC      arch/x86/video/fbdev.o
>   CC      drivers/acpi/acpica/nsinit.o
>   CC [M]  drivers/ata/pata_sil680.o
>   CC      kernel/xenomai/nucleus/shadow.o
>   LD      drivers/acpi/apei/apei.o
>   CC      arch/x86/kernel/vsmp_64.o
>   AS      arch/x86/kernel/head_64.o
>   LD      drivers/acpi/apei/built-in.o
>   CC      arch/x86/kernel/head64.o
>   CC      kernel/rtmutex.o
>   CC      kernel/dma.o
>   CC      kernel/smp.o
>   CC      arch/x86/xenomai/hal_64.o
>   CC      arch/x86/xenomai/hal-common.o
>   CC      arch/x86/xenomai/usercopy_64.o
>   CC      arch/x86/xenomai/smi.o
>   CC      kernel/xenomai/nucleus/pipe.o
>   CC      kernel/xenomai/nucleus/map.o
>   CC      drivers/acpi/acpica/nsload.o
>   CC      drivers/acpi/acpica/nsnames.o
>   CC      drivers/acpi/acpica/nsobject.o
>   LD      arch/x86/power/built-in.o
>   CC      drivers/acpi/ac.o
>   CC      kernel/trace/power-traces.o
>   CC      kernel/xenomai/skins/native/buffer.o
>   CC      kernel/trace/rpm-traces.o
>   LD      arch/x86/video/built-in.o
>   CC      kernel/trace/trace_probe.o
>   CC [M]  kernel/trace/ring_buffer_benchmark.o
>   CC [M]  drivers/ata/pata_sis.o
>   CC      kernel/xenomai/skins/posix/sched.o
>   LD      kernel/xenomai/skins/psos+/built-in.o
>   CC      kernel/xenomai/skins/posix/thread_attr.o
>   CC      kernel/xenomai/skins/posix/thread.o
>   CC      drivers/acpi/acpica/nsparse.o
>   CC      kernel/xenomai/skins/posix/mutex_attr.o
>   CC      arch/x86/xenomai/c1e.o
>   CC      arch/x86/kernel/head.o
>   CC [M]  drivers/ata/pata_via.o
>   LD      arch/x86/oprofile/built-in.o
>   CC [M]  arch/x86/oprofile/../../../drivers/oprofile/oprof.o
>   CC      net/socket.o
>   CC      drivers/acpi/acpica/nspredef.o
>   CC      net/802/fc.o
>   CC [M]  sound/pci/via82xx_modem.o
>   CC [M]  sound/pci/via82xx.o
>   CC      net/802/fddi.o
>   LDS     arch/x86/kernel/vmlinux.lds
>   CC [M]  arch/x86/kernel/microcode_core.o
>   CC [M]  crypto/cast6_generic.o
>   CC [M]  arch/x86/oprofile/../../../drivers/oprofile/cpu_buffer.o
>   CC [M]  arch/x86/oprofile/../../../drivers/oprofile/buffer_sync.o
>   CC [M]  arch/x86/oprofile/../../../drivers/oprofile/event_buffer.o
>   LD      arch/x86/xenomai/xeno_hal.o
>   LD      arch/x86/xenomai/built-in.o
>   CC [M]  arch/x86/oprofile/../../../drivers/oprofile/oprofile_files.o
>   CC [M]  fs/btrfs/file.o
>   CC [M]  arch/x86/oprofile/../../../drivers/oprofile/oprofilefs.o
>   LD      kernel/trace/libftrace.o
>   LD      kernel/trace/built-in.o
>   CC [M]  arch/x86/oprofile/../../../drivers/oprofile/oprofile_stats.o
>   CC [M]  arch/x86/oprofile/../../../drivers/oprofile/timer_int.o
>   CC [M]  drivers/ata/pata_pcmcia.o
>   CC      drivers/acpi/acpica/nsrepair.o
>   LD      kernel/xenomai/skins/native/xeno_native.o
>   LD      kernel/xenomai/skins/native/built-in.o
>   CC      drivers/acpi/acpica/nsrepair2.o
>   CC [M]  drivers/ata/pata_acpi.o
>   CC [M]  drivers/ata/ata_generic.o
>   CC [M]  fs/btrfs/tree-defrag.o
>   CC [M]  fs/btrfs/extent_map.o
>   CC      drivers/acpi/button.o
>   LD      drivers/ata/libata.o
>   CC      drivers/acpi/fan.o
>   CC      drivers/acpi/pci_slot.o
>   CC [M]  fs/btrfs/sysfs.o
>   CC [M]  fs/btrfs/struct-funcs.o
>   CC [M]  fs/btrfs/xattr.o
>   CC [M]  arch/x86/kernel/microcode_intel.o
>   CC [M]  arch/x86/kernel/microcode_amd.o
>   CC      lib/bcd.o
>   CC [M]  arch/x86/oprofile/../../../drivers/oprofile/nmi_timer_int.o
>   CC [M]  arch/x86/oprofile/init.o
>   CC      kernel/xenomai/skins/posix/mutex.o
>   CC      lib/div64.o
>   CC [M]  crypto/arc4.o
>   CC [M]  net/802/p8022.o
>   CC      lib/sort.o
>   CC      drivers/acpi/acpica/nssearch.o
>   CC [M]  crypto/tea.o
>   CC      drivers/acpi/acpica/nsutils.o
>   CC      kernel/xenomai/nucleus/select.o
>   CC      drivers/acpi/acpica/nswalk.o
>   LD      drivers/ata/built-in.o
>   CC      drivers/acpi/acpica/nsxfeval.o
>   CC      drivers/acpi/acpica/nsxfname.o
>   CC [M]  arch/x86/oprofile/backtrace.o
>   CC [M]  arch/x86/oprofile/nmi_int.o
>   CC      drivers/acpi/acpica/nsxfobj.o
>   LD      sound/pci/ac97/built-in.o
>   LD      sound/pci/ali5451/built-in.o
>   CC [M]  sound/pci/ac97/ac97_codec.o
>   CC [M]  sound/pci/ali5451/ali5451.o
>   CC [M]  sound/pci/ac97/ac97_pcm.o
>   CC [M]  sound/pci/ac97/ac97_proc.o
>   CC      lib/parser.o
>   CC      lib/halfmd4.o
>   LD      sound/pci/asihpi/built-in.o
>   CC      lib/debug_locks.o
>   LD      arch/x86/kernel/built-in.o
>   CC      kernel/xenomai/skins/rtdm/core.o
>   CC [M]  crypto/khazad.o
>   CC      kernel/xenomai/skins/rtdm/device.o
>   CC [M]  crypto/anubis.o
>   CC      kernel/xenomai/skins/rtdm/drvlib.o
>   CC      kernel/xenomai/skins/rtdm/module.o
>   LD [M]  arch/x86/kernel/microcode.o
>   CC      kernel/xenomai/skins/rtdm/syscall.o
>   LD      arch/x86/built-in.o
>   CC      kernel/xenomai/skins/rtdm/proc.o
>   CC      drivers/acpi/acpica/psargs.o
>   CC [M]  fs/btrfs/ordered-data.o
>   CC [M]  fs/btrfs/extent_io.o
>   CC      drivers/acpi/acpica/psloop.o
>   CC [M]  net/802/psnap.o
>   CC      lib/random32.o
>   CC      lib/bust_spinlocks.o
>   LD      sound/pci/au88x0/built-in.o
>   CC [M]  sound/pci/au88x0/au8810.o
>   CC      lib/hexdump.o
>   CC [M]  arch/x86/oprofile/op_model_amd.o
>   CC [M]  arch/x86/oprofile/op_model_ppro.o
>   CC [M]  crypto/seed.o
>   CC [M]  crypto/deflate.o
>   CC      kernel/xenomai/skins/posix/cond_attr.o
>   CC [M]  crypto/zlib.o
>   LD      sound/sh/built-in.o
>   LD      sound/ppc/built-in.o
>   CC [M]  net/802/stp.o
>   CC [M]  crypto/michael_mic.o
>   LD      sound/soc/built-in.o
>   CC [M]  crypto/authenc.o
>   CC [M]  net/802/garp.o
>   CC      lib/kasprintf.o
>   CC      drivers/acpi/acpica/psopcode.o
>   CC      drivers/acpi/acpica/psparse.o
>   LD [M]  sound/pci/ali5451/snd-ali5451.o
>   CC      drivers/acpi/acpica/psscope.o
>   CC      kernel/xenomai/nucleus/vfile.o
>   CC      kernel/xenomai/nucleus/module.o
>   CC [M]  arch/x86/oprofile/op_model_p4.o
>   LD      fs/cachefiles/built-in.o
>   CC [M]  fs/cachefiles/bind.o
>   LD      fs/cifs/built-in.o
>   CC [M]  fs/cifs/cifsfs.o
>   CC      lib/bitmap.o
>   CC      lib/scatterlist.o
>   CC [M]  fs/cifs/cifssmb.o
>   CC [M]  fs/cifs/cifs_debug.o
>   CC [M]  fs/cifs/connect.o
>   CC      drivers/acpi/acpica/pstree.o
>   CC [M]  fs/cifs/dir.o
>   CC [M]  fs/cifs/file.o
>   LD      kernel/xenomai/skins/uitron/built-in.o
>   CC [M]  fs/cifs/inode.o
>   CC [M]  fs/cifs/link.o
>   CC [M]  fs/cifs/misc.o
>   CC      drivers/acpi/acpica/psutils.o
>   LD      fs/configfs/built-in.o
>   CC [M]  fs/configfs/inode.o
>   LD [M]  arch/x86/oprofile/oprofile.o
>   LD      fs/cramfs/built-in.o
>   CC      kernel/xenomai/skins/posix/cond.o
>   CC [M]  fs/cramfs/inode.o
>   LD      kernel/xenomai/skins/rtdm/xeno_rtdm.o
>   CC [M]  crypto/authencesn.o
>   LD      kernel/xenomai/skins/rtdm/built-in.o
>   CC [M]  crypto/lzo.o
>   CC [M]  fs/cachefiles/daemon.o
>   LD      net/802/built-in.o
>   CC      net/8021q/vlan_core.o
>   LD      net/9p/built-in.o
>   CC [M]  net/9p/mod.o
>   CC      drivers/acpi/acpica/pswalk.o
>   CC [M]  net/9p/client.o
>   LD      kernel/xenomai/nucleus/xeno_nucleus.o
>   CC      lib/string_helpers.o
>   CC [M]  net/9p/error.o
>   LD      kernel/xenomai/nucleus/built-in.o
>   CC [M]  net/9p/util.o
>   CC [M]  net/9p/protocol.o
>   CC [M]  net/9p/trans_fd.o
>   CC      lib/gcd.o
>   CC [M]  fs/configfs/file.o
>   CC      drivers/acpi/acpica/psxface.o
>   CC      drivers/acpi/acpica/rsaddr.o
>   CC      drivers/acpi/acpica/rscalc.o
>   CC      lib/lcm.o
>   CC [M]  fs/cramfs/uncompress.o
>   CC      lib/list_sort.o
>   CC [M]  fs/cachefiles/interface.o
>   CC      lib/uuid.o
>   CC [M]  fs/cachefiles/key.o
>   CC [M]  fs/cachefiles/main.o
>   LD [M]  fs/cramfs/cramfs.o
>   CC [M]  fs/cachefiles/namei.o
>   CC [M]  crypto/ansi_cprng.o
>   CC [M]  fs/configfs/dir.o
>   CC [M]  fs/configfs/symlink.o
>   CC [M]  crypto/tcrypt.o
>   CC [M]  fs/configfs/mount.o
>   CC [M]  fs/configfs/item.o
>   CC      drivers/acpi/acpica/rscreate.o
>   CC      drivers/acpi/acpica/rsinfo.o
>   CC      lib/flex_array.o
>   CC      drivers/acpi/acpica/rsio.o
>   CC [M]  sound/pci/au88x0/au8820.o
>   CC [M]  net/8021q/vlan.o
>   CC [M]  net/8021q/vlan_dev.o
>   CC [M]  net/8021q/vlan_netlink.o
>   CC      drivers/acpi/acpica/rsirq.o
>   LD [M]  sound/pci/ac97/snd-ac97-codec.o
>   LD      sound/pci/aw2/built-in.o
>   LD      sound/pci/ca0106/built-in.o
>   CC      drivers/acpi/acpica/rslist.o
>   CC [M]  fs/btrfs/volumes.o
>   CC [M]  sound/pci/ca0106/ca0106_main.o
>   CC [M]  sound/pci/ca0106/ca0106_proc.o
>   CC [M]  sound/pci/ca0106/ca0106_mixer.o
>   CC [M]  sound/pci/ca0106/ca_midi.o
>   CC      kernel/xenomai/skins/posix/sem.o
>   CC      kernel/xenomai/skins/posix/cancel.o
>   CC      fs/debugfs/inode.o
>   CC      kernel/xenomai/skins/posix/once.o
>   CC      lib/bsearch.o
>   CC      kernel/xenomai/skins/posix/signal.o
>   CC      kernel/xenomai/skins/posix/tsd.o
>   CC      lib/find_last_bit.o
>   CC      kernel/xenomai/skins/posix/clock.o
>   CC [M]  fs/cachefiles/rdwr.o
>   CC      drivers/acpi/acpica/rsmemory.o
>   CC      lib/find_next_bit.o
>   LD [M]  fs/configfs/configfs.o
>   CC      drivers/acpi/acpica/rsmisc.o
>   CC [M]  fs/cachefiles/security.o
>   CC [M]  fs/cachefiles/xattr.o
>   CC      lib/llist.o
>   CC      lib/memweight.o
>   CC      lib/kstrtox.o
>   CC      fs/debugfs/file.o
>   CC      kernel/spinlock.o
>   CC      kernel/xenomai/skins/posix/timer.o
>   CC [M]  crypto/ghash-generic.o
>   CC [M]  net/9p/trans_common.o
>   CC [M]  net/8021q/vlan_gvrp.o
>   CC [M]  net/9p/trans_rdma.o
>   CC [M]  net/8021q/vlanproc.o
>   CC [M]  crypto/xor.o
>   CC      drivers/acpi/acpica/rsserial.o
>   CC      lib/iomap.o
>   LD [M]  sound/pci/ca0106/snd-ca0106.o
>   CC      lib/pci_iomap.o
>   CC      lib/iomap_copy.o
>   CC      drivers/acpi/acpica/rsutils.o
>   CC      drivers/acpi/acpica/rsxface.o
>   LD [M]  fs/cachefiles/cachefiles.o
>   CC [M]  fs/btrfs/async-thread.o
>   CC [M]  fs/btrfs/ioctl.o
>   CC [M]  fs/btrfs/locking.o
>   CC [M]  fs/btrfs/orphan.o
>   CC [M]  fs/btrfs/export.o
>   CC      drivers/acpi/acpica/tbfadt.o
>   CC [M]  fs/btrfs/tree-log.o
>   CC [M]  fs/btrfs/free-space-cache.o
>   CC [M]  fs/btrfs/zlib.o
>   LD      fs/debugfs/debugfs.o
>   CC [M]  fs/btrfs/lzo.o
>   CC [M]  fs/cifs/netmisc.o
>   LD      fs/debugfs/built-in.o
>   CC [M]  fs/cifs/smbencrypt.o
>   CC      drivers/acpi/acpica/tbfind.o
>   LD      sound/sparc/built-in.o
>   CC      drivers/acpi/acpica/tbinstal.o
>   CC [M]  fs/btrfs/compression.o
>   LD      crypto/crypto.o
>   LD      net/8021q/built-in.o
>   LD      crypto/crypto_algapi.o
>   LD [M]  net/8021q/8021q.o
>   LD      crypto/crypto_blkcipher.o
>   LD      crypto/built-in.o
>   CC [M]  fs/btrfs/delayed-ref.o
>   CC      kernel/uid16.o
>   CC      lib/devres.o
>   CC [M]  sound/pci/au88x0/au8830.o
>   LD      net/atm/built-in.o
>   CC [M]  net/atm/addr.o
>   LD      net/bluetooth/built-in.o
>   CC [M]  net/bluetooth/af_bluetooth.o
>   CC [M]  net/9p/trans_virtio.o
>   CC [M]  net/atm/pvc.o
>   CC      arch/x86/lib/msr-smp.o
>   CC [M]  net/atm/signaling.o
>   CC [M]  net/atm/svc.o
>   LD      net/can/built-in.o
>   LD      net/bridge/built-in.o
>   CC [M]  net/can/bcm.o
>   CC [M]  net/bridge/br.o
>   CC      kernel/xenomai/skins/posix/registry.o
>   CC      drivers/acpi/acpica/tbutils.o
>   CC [M]  net/bridge/br_device.o
>   CC [M]  net/bridge/br_fdb.o
>   CC [M]  net/bridge/br_forward.o
>   CC      arch/x86/lib/cache-smp.o
>   CC [M]  fs/cifs/transport.o
>   CC      lib/check_signature.o
>   CC      lib/hweight.o
>   CC      drivers/acpi/acpica/tbxface.o
>   CC      arch/x86/lib/msr.o
>   AS      arch/x86/lib/msr-reg.o
>   CC      arch/x86/lib/msr-reg-export.o
>   AS      arch/x86/lib/iomap_copy_64.o
>   AS      arch/x86/lib/clear_page_64.o
>   AS      arch/x86/lib/cmpxchg16b_emu.o
>   CC [M]  fs/cifs/asn1.o
>   CC [M]  net/bridge/br_if.o
>   CC [M]  net/bridge/br_input.o
>   CC [M]  fs/cifs/cifs_unicode.o
>   CC [M]  fs/cifs/nterr.o
>   CC [M]  fs/cifs/xattr.o
>   CC      lib/bitrev.o
>   LD [M]  net/9p/9pnet.o
>   LD [M]  net/9p/9pnet_virtio.o
>   LD [M]  net/9p/9pnet_rdma.o
>   CC      lib/crc16.o
>   HOSTCC  lib/gen_crc32table
>   CC [M]  net/atm/ioctl.o
>   CC      lib/genalloc.o
>   CC      lib/lzo/lzo1x_compress.o
>   CC      lib/mpi/generic_mpih-lshift.o
>   CC      kernel/xenomai/skins/posix/mq.o
>   AS      arch/x86/lib/copy_page_64.o
>   AS      arch/x86/lib/copy_user_64.o
>   CC      lib/lzo/lzo1x_decompress.o
>   AS      arch/x86/lib/copy_user_nocache_64.o
>   CC [M]  net/bluetooth/hci_core.o
>   CC      drivers/acpi/acpica/tbxfload.o
>   AS      arch/x86/lib/csum-copy_64.o
>   CC      arch/x86/lib/csum-partial_64.o
>   CC      drivers/acpi/acpica/tbxfroot.o
>   CC      drivers/acpi/acpica/utaddress.o
>   LD      lib/raid6/built-in.o
>   LD      lib/reed_solomon/built-in.o
>   CC [M]  net/can/raw.o
>   CC [M]  lib/reed_solomon/reed_solomon.o
>   CC [M]  lib/raid6/algos.o
>   CC [M]  lib/raid6/recov.o
>   CC      lib/mpi/generic_mpih-mul1.o
>   CC      lib/mpi/generic_mpih-mul2.o
>   CC [M]  net/bridge/br_ioctl.o
>   CC [M]  net/bridge/br_notify.o
>   CC [M]  net/bridge/br_stp.o
>   CC [M]  net/can/af_can.o
>   CC [M]  fs/btrfs/relocation.o
>   CC [M]  net/bluetooth/hci_conn.o
>   CC [M]  fs/btrfs/delayed-inode.o
>   CC [M]  fs/btrfs/scrub.o
>   CC      drivers/acpi/acpica/utalloc.o
>   CC      arch/x86/lib/csum-wrappers_64.o
>   LD      lib/lzo/lzo_compress.o
>   LD      kernel/xenomai/skins/vrtx/built-in.o
>   LD      lib/lzo/lzo_decompress.o
>   LD      lib/lzo/built-in.o
>   CC      arch/x86/lib/delay.o
>   CC      drivers/acpi/acpica/utcopy.o
>   CC      lib/mpi/generic_mpih-mul3.o
>   AS      arch/x86/lib/getuser.o
>   CC      lib/mpi/generic_mpih-rshift.o
>   CC      lib/mpi/generic_mpih-sub1.o
>   CC [M]  fs/cifs/cifsencrypt.o
>   CC      lib/mpi/generic_mpih-add1.o
>   CC [M]  net/bridge/br_stp_bpdu.o
>   CC [M]  net/atm/common.o
>   CC [M]  net/atm/atm_misc.o
>   CC [M]  net/atm/raw.o
>   CC [M]  net/bridge/br_stp_if.o
>   HOSTCC  lib/raid6/mktables
>   CC      net/core/sock.o
>   CC      net/dcb/dcbnl.o
>   CC      drivers/acpi/acpica/utexcep.o
>   GEN     arch/x86/lib/inat-tables.c
>   CC      lib/mpi/mpicoder.o
>   CC      lib/mpi/mpi-bit.o
>   CC      drivers/acpi/container.o
>   CC      arch/x86/lib/insn.o
>   CC      drivers/acpi/acpi_memhotplug.o
>   UNROLL  lib/raid6/int1.c
>   UNROLL  lib/raid6/int2.c
>   UNROLL  lib/raid6/int4.c
>   UNROLL  lib/raid6/int8.c
>   UNROLL  lib/raid6/int16.c
>   UNROLL  lib/raid6/int32.c
>   CC [M]  lib/raid6/recov_ssse3.o
>   CC [M]  lib/raid6/recov_avx2.o
> lib/raid6/recov_avx2.c:11:5: warning: "CONFIG_AS_AVX2" is not defined
> lib/raid6/recov_avx2.c:322:2: warning: #warning "your version of
> binutils lacks AVX2 support" AS      arch/x86/lib/memcpy_64.o
>   LD      kernel/xenomai/skins/vxworks/built-in.o
>   CC      drivers/acpi/battery.o
>   AS      arch/x86/lib/memmove_64.o
>   LD [M]  sound/pci/au88x0/snd-au8810.o
>   LD [M]  sound/pci/au88x0/snd-au8820.o
>   LD      sound/spi/built-in.o
>   LD [M]  sound/pci/au88x0/snd-au8830.o
>   CC [M]  net/can/proc.o
>   AS      arch/x86/lib/memset_64.o
>   LD      sound/pci/cs46xx/built-in.o
>   CC [M]  sound/pci/cs46xx/cs46xx.o
>   AS      arch/x86/lib/putuser.o
>   CC      lib/mpi/mpi-cmp.o
>   CC      drivers/acpi/acpica/utdebug.o
>   AS      arch/x86/lib/rwlock.o
>   CC      kernel/xenomai/skins/posix/module.o
>   CC      drivers/acpi/acpica/utdecode.o
>   CC      drivers/acpi/acpica/utdelete.o
>   AS      arch/x86/lib/rwsem.o
>   LD      sound/synth/built-in.o
>   LD      sound/usb/built-in.o
>   CC [M]  sound/synth/util_mem.o
>   CC [M]  sound/usb/card.o
>   CC [M]  fs/cifs/readdir.o
>   AS      arch/x86/lib/thunk_64.o
>   CC [M]  net/bridge/br_stp_timer.o
>   CC      arch/x86/lib/usercopy.o
>   CC [M]  net/bridge/br_netlink.o
>   CC [M]  net/bridge/br_sysfs_if.o
>   CC [M]  lib/raid6/mmx.o
>   CC [M]  lib/raid6/sse1.o
>   CC [M]  lib/raid6/sse2.o
>   CC [M]  lib/raid6/avx2.o
>   CC      lib/mpi/mpih-cmp.o
>   CC      lib/mpi/mpih-div.o
>   CC      lib/mpi/mpih-mul.o
>   CC      drivers/acpi/acpica/uteval.o
>   CC [M]  sound/usb/clock.o
>   CC      lib/mpi/mpi-pow.o
>   CC [M]  sound/pci/cs46xx/cs46xx_lib.o
>   CC [M]  sound/pci/cs46xx/dsp_spos.o
>   CC      drivers/acpi/hed.o
>   CC      kernel/xenomai/skins/posix/apc.o
>   LD      sound/synth/emux/built-in.o
>   LD [M]  net/can/can.o
>   CC [M]  sound/synth/emux/emux.o
>   LD [M]  net/can/can-raw.o
>   LD [M]  net/can/can-bcm.o
>   CC [M]  sound/synth/emux/emux_synth.o
>   CC      drivers/acpi/acpica/utglobal.o
>   CC [M]  net/atm/resources.o
>   CC [M]  net/atm/atm_sysfs.o
>   CC      drivers/acpi/acpica/utids.o
>   CC      arch/x86/lib/usercopy_64.o
>   CC      drivers/acpi/acpica/utinit.o
>   TABLE   lib/raid6/tables.c
>   CC [M]  lib/raid6/int1.o
>   CC [M]  drivers/acpi/acpi_ipmi.o
>   CC      drivers/acpi/acpica/utlock.o
>   CC [M]  sound/usb/endpoint.o
>   CC [M]  net/bluetooth/hci_event.o
>   CC      lib/mpi/mpiutil.o
>   LD      drivers/crypto/built-in.o
>   CC [M]  fs/cifs/ioctl.o
>   CC [M]  drivers/crypto/padlock-aes.o
>   CC [M]  net/bridge/br_sysfs_br.o
>   CC [M]  net/bridge/br_netfilter.o
>   CC [M]  net/bridge/br_multicast.o
>   CC      net/dcb/dcbevent.o
>   LD      arch/x86/lib/built-in.o
>   CC      arch/x86/lib/inat.o
>   CC [M]  fs/btrfs/reada.o
>   CC      drivers/acpi/acpica/utmath.o
>   CC      fs/devpts/inode.o
>   CC      drivers/acpi/acpica/utmisc.o
>   AR      arch/x86/lib/lib.a
>   CC [M]  lib/raid6/int2.o
>   CC [M]  lib/raid6/int4.o
>   CC      kernel/xenomai/skins/posix/syscall.o
>   LD      lib/mpi/mpi.o
>   LD      lib/mpi/built-in.o
>   CC [M]  lib/raid6/int8.o
>   LD      fs/dlm/built-in.o
>   CC [M]  fs/dlm/ast.o
>   CC [M]  fs/dlm/config.o
>   LD      net/dccp/built-in.o
>   CC [M]  net/dccp/ccid.o
>   CC [M]  sound/synth/emux/emux_seq.o
>   CC [M]  sound/synth/emux/emux_nrpn.o
>   CC [M]  sound/synth/emux/emux_effect.o
>   CC      drivers/acpi/acpica/utmutex.o
>   CC [M]  drivers/crypto/padlock-sha.o
>   CC [M]  sound/synth/emux/emux_proc.o
>   CC [M]  fs/cifs/sess.o
>   CC [M]  sound/usb/format.o
>   CC [M]  net/atm/proc.o
>   LD      fs/devpts/devpts.o
>   LD      fs/devpts/built-in.o
>   CC [M]  net/atm/clip.o
>   CC [M]  net/atm/br2684.o
>   CC [M]  lib/raid6/int16.o
>   CC      net/core/request_sock.o
>   CC      net/core/skbuff.o
>   CC      net/core/iovec.o
>   CC      net/core/datagram.o
>   LD      net/dcb/built-in.o
>   CC [M]  drivers/acpi/video.o
>   CC [M]  sound/pci/cs46xx/dsp_spos_scb_lib.o
>   CC [M]  drivers/acpi/sbshc.o
>   CC [M]  fs/btrfs/backref.o
>   CC [M]  sound/synth/emux/emux_hwdep.o
>   CC      drivers/acpi/acpica/utobject.o
>   CC      drivers/acpi/acpica/utosi.o
>   CC      drivers/acpi/acpica/utresrc.o
>   CC [M]  lib/raid6/int32.o
>   CC [M]  net/dccp/feat.o
>   CC      drivers/acpi/acpica/utstate.o
>   CC [M]  sound/usb/helper.o
>   CC [M]  fs/dlm/dir.o
>   CC [M]  sound/synth/emux/soundfont.o
>   CC [M]  sound/synth/emux/emux_oss.o
>   CC [M]  net/bridge/br_mdb.o
>   LD      net/bridge/netfilter/built-in.o
>   CC [M]  net/bridge/netfilter/ebtables.o
>   CC      drivers/acpi/acpica/utxface.o
>   CC      drivers/acpi/acpica/utxfinit.o
>   CC [M]  sound/usb/mixer.o
>   CC [M]  lib/raid6/tables.o
>   CC [M]  sound/usb/mixer_quirks.o
>   CC [M]  fs/cifs/export.o
>   CC [M]  drivers/acpi/sbs.o
>   CC [M]  fs/cifs/smb1ops.o
>   CC [M]  net/atm/lec.o
>   CC [M]  net/atm/pppoatm.o
>   CC [M]  fs/dlm/lock.o
>   CC [M]  fs/dlm/lockspace.o
>   LD [M]  sound/pci/cs46xx/snd-cs46xx.o
>   LD      sound/pci/cs5535audio/built-in.o
>   CC [M]  sound/pci/cs5535audio/cs5535audio.o
>   CC [M]  sound/pci/cs5535audio/cs5535audio_pcm.o
>   CC [M]  sound/pci/cs5535audio/cs5535audio_pm.o
>   LD [M]  net/atm/atm.o
>   CC [M]  drivers/acpi/acpi_i2c.o
>   CC      drivers/acpi/acpica/utxferror.o
>   CC      drivers/acpi/acpica/utxfmutex.o
>   CC [M]  fs/btrfs/ulist.o
>   LD [M]  sound/synth/emux/snd-emux-synth.o
>   LD [M]  sound/synth/snd-util-mem.o
>   LD      net/dns_resolver/built-in.o
>   CC [M]  net/dns_resolver/dns_key.o
>   CC      net/dsa/dsa.o
>   CC      net/dsa/slave.o
>   LD [M]  net/bridge/bridge.o
>   LD [M]  sound/soundcore.o
>   CC      net/dsa/tag_dsa.o
>   CC [M]  net/dns_resolver/dns_query.o
>   LD      drivers/acpi/acpi.o
>   CC [M]  net/bluetooth/mgmt.o
>   CC [M]  net/bluetooth/hci_sock.o
>   LD      sound/pci/ctxfi/built-in.o
>   CC [M]  sound/pci/ctxfi/xfi.o
>   LD      sound/pci/echoaudio/built-in.o
>   CC [M]  sound/pci/echoaudio/darla20.o
>   LD [M]  sound/pci/cs5535audio/snd-cs5535audio.o
>   CC [M]  sound/pci/echoaudio/darla24.o
>   CC [M]  sound/pci/echoaudio/echo3g.o
>   LD      kernel/xenomai/skins/posix/xeno_posix.o
>   CC [M]  fs/btrfs/qgroup.o
>   CC [M]  fs/cifs/cifsacl.o
>   CC [M]  fs/btrfs/send.o
>   LD      kernel/xenomai/skins/posix/built-in.o
>   LD [M]  lib/raid6/raid6_pq.o
>   CC      lib/xz/xz_dec_syms.o
>   LD      kernel/xenomai/skins/built-in.o
>   CC [M]  net/dccp/input.o
>   LD      kernel/xenomai/built-in.o
>   LD      drivers/acpi/acpica/acpi.o
>   CC [M]  net/dccp/minisocks.o
>   LD      drivers/acpi/acpica/built-in.o
>   CC [M]  net/dccp/options.o
>   LD      drivers/acpi/built-in.o
>   CC      kernel/module.o
>   LD [M]  net/dns_resolver/dns_resolver.o
>   LD      drivers/dca/built-in.o
>   CC [M]  drivers/dca/dca-core.o
>   CC      drivers/dma/dmaengine.o
>   CC      drivers/dma/iovlock.o
>   CC [M]  sound/usb/pcm.o
>   CC      lib/xz/xz_dec_stream.o
>   CC [M]  sound/pci/ctxfi/ctatc.o
>   CC      lib/xz/xz_dec_lzma2.o
>   CC      net/dsa/tag_edsa.o
>   CC      net/dsa/tag_trailer.o
>   CC      net/core/stream.o
>   CC      net/core/scm.o
>   CC [M]  drivers/dca/dca-sysfs.o
>   CC      drivers/edac/edac_stub.o
>   CC [M]  fs/cifs/cifs_spnego.o
>   CC [M]  net/bridge/netfilter/ebtable_broute.o
>   CC [M]  net/bridge/netfilter/ebtable_filter.o
>   CC [M]  net/bridge/netfilter/ebtable_nat.o
>   CC [M]  net/bridge/netfilter/ebt_802_3.o
>   CC      lib/xz/xz_dec_bcj.o
>   CC [M]  fs/cifs/dns_resolve.o
>   LD [M]  drivers/dca/dca.o
>   LD      drivers/dma/ioat/built-in.o
>   LD      net/dsa/dsa_core.o
>   CC [M]  drivers/dma/ioat/pci.o
>   CC [M]  drivers/dma/ioat/dma.o
>   CC [M]  sound/usb/proc.o
>   LD      net/dsa/built-in.o
>   CC [M]  drivers/dma/ioat/dma_v2.o
>   CC [M]  sound/usb/quirks.o
>   CC [M]  drivers/dma/ioat/dma_v3.o
>   CC [M]  drivers/edac/amd64_edac.o
>   CC [M]  net/dccp/output.o
>   CC [M]  net/dccp/proto.o
>   LD      lib/xz/xz_dec.o
>   LD      lib/xz/built-in.o
>   CC [M]  net/dccp/timer.o
>   LD      lib/zlib_deflate/built-in.o
>   CC [M]  lib/zlib_deflate/deflate.o
>   CC [M]  sound/pci/ctxfi/ctvmem.o
>   CC [M]  lib/zlib_deflate/deftree.o
>   CC [M]  sound/pci/ctxfi/ctpcm.o
>   CC [M]  sound/pci/ctxfi/ctmixer.o
>   CC      net/core/gen_stats.o
>   CC [M]  fs/btrfs/dev-replace.o
>   CC [M]  sound/pci/echoaudio/gina20.o
>   CC [M]  sound/pci/echoaudio/gina24.o
>   CC [M]  net/bridge/netfilter/ebt_among.o
>   CC      net/core/gen_estimator.o
>   CC [M]  fs/cifs/cifs_dfs_ref.o
>   CC [M]  sound/usb/stream.o
>   CC [M]  sound/usb/midi.o
>   CC [M]  net/bluetooth/hci_sysfs.o
>   CC [M]  fs/dlm/main.o
>   CC [M]  fs/dlm/member.o
>   CC [M]  fs/dlm/memory.o
>   CC [M]  net/bluetooth/l2cap_core.o
>   CC [M]  lib/zlib_deflate/deflate_syms.o
>   CC      kernel/module_signing.o
>   CC      kernel/modsign_pubkey.o
>   CC [M]  sound/pci/ctxfi/ctresource.o
>   CC [M]  sound/pci/ctxfi/ctsrc.o
>   CC [M]  net/bluetooth/l2cap_sock.o
>   CC [M]  net/bluetooth/smp.o
>   CC [M]  net/bridge/netfilter/ebt_arp.o
>   CC [M]  sound/pci/echoaudio/indigo.o
>   CC [M]  fs/btrfs/acl.o
>   LD [M]  fs/cifs/cifs.o
>   CC [M]  drivers/dma/ioat/dca.o
>   CC [M]  sound/pci/echoaudio/indigodj.o
>   CC [M]  fs/dlm/midcomms.o
>   CC [M]  fs/dlm/netlink.o
>   LD [M]  lib/zlib_deflate/zlib_deflate.o
>   CC [M]  sound/pci/echoaudio/indigodjx.o
>   CC      lib/zlib_inflate/inffast.o
>   CC      lib/textsearch.o
>   CC      net/core/net_namespace.o
>   CC [M]  drivers/edac/edac_mc.o
>   AS      kernel/modsign_certificate.o
>   CC      kernel/kallsyms.o
>   CC [M]  net/dccp/qpolicy.o
>   CC      kernel/acct.o
>   CC      kernel/kexec.o
>   CC      lib/zlib_inflate/inflate.o
>   CC      lib/zlib_inflate/infutil.o
>   CC      lib/zlib_inflate/inftrees.o
>   CC      lib/zlib_inflate/inflate_syms.o
>   CC      kernel/compat.o
>   CC [M]  sound/pci/ctxfi/ctamixer.o
>   CC [M]  fs/dlm/lowcomms.o
>   CC [M]  sound/pci/ctxfi/ctdaio.o
>   CC [M]  sound/pci/ctxfi/ctimap.o
>   LD [M]  fs/btrfs/btrfs.o
>   LD      sound/usb/6fire/built-in.o
>   CC [M]  sound/usb/6fire/chip.o
>   LD      sound/usb/caiaq/built-in.o
>   CC [M]  sound/usb/caiaq/device.o
>   CC [M]  net/bridge/netfilter/ebt_ip.o
>   CC [M]  sound/usb/caiaq/audio.o
>   CC [M]  sound/usb/caiaq/midi.o
>   CC [M]  sound/usb/caiaq/control.o
>   LD [M]  drivers/dma/ioat/ioatdma.o
>   LD      drivers/dma/built-in.o
>   CC [M]  sound/usb/caiaq/input.o
>   LD      fs/ecryptfs/built-in.o
>   CC [M]  net/dccp/ccids/ccid2.o
>   CC [M]  net/dccp/ackvec.o
>   LD      lib/zlib_inflate/zlib_inflate.o
>   CC [M]  fs/ecryptfs/dentry.o
>   LD      lib/zlib_inflate/built-in.o
>   CC      net/ethernet/eth.o
>   CC      lib/percpu_counter.o
>   CC      lib/swiotlb.o
>   CC      lib/iommu-helper.o
>   CC [M]  sound/usb/6fire/comm.o
>   CC [M]  sound/usb/6fire/midi.o
>   CC [M]  sound/pci/ctxfi/cthardware.o
>   CC [M]  sound/pci/ctxfi/cttimer.o
>   CC [M]  sound/usb/6fire/control.o
>   CC [M]  sound/pci/ctxfi/cthw20k2.o
>   CC      net/core/secure_seq.o
>   CC      net/core/flow_dissector.o
>   CC [M]  sound/pci/echoaudio/indigoio.o
>   CC [M]  drivers/edac/edac_device.o
>   CC [M]  drivers/edac/edac_mc_sysfs.o
>   CC [M]  sound/pci/echoaudio/indigoiox.o
>   CC [M]  net/bridge/netfilter/ebt_ip6.o
>   CC [M]  fs/ecryptfs/file.o
>   CC [M]  net/bridge/netfilter/ebt_limit.o
>   CC [M]  fs/ecryptfs/inode.o
>   CC [M]  fs/ecryptfs/main.o
>   CC [M]  fs/ecryptfs/super.o
>   CC [M]  sound/pci/ctxfi/cthw20k1.o
>   LD      net/ieee802154/built-in.o
>   CC [M]  net/ieee802154/af_ieee802154.o
>   CC [M]  sound/usb/6fire/firmware.o
>   CC [M]  fs/dlm/plock.o
>   CC [M]  sound/usb/6fire/pcm.o
>   LD [M]  sound/usb/caiaq/snd-usb-caiaq.o
>   CC      kernel/cgroup.o
>   CC      kernel/cgroup_freezer.o
>   CC      kernel/cpuset.o
>   CC [M]  net/dccp/ccids/ccid3.o
>   CC [M]  net/bridge/netfilter/ebt_mark_m.o
>   LD      net/ethernet/built-in.o
>   CC      lib/syscall.o
>   CC      lib/dynamic_debug.o
>   CC      net/ipv4/route.o
>   CC      net/ipv4/inetpeer.o
>   CC [M]  drivers/edac/edac_pci_sysfs.o
>   LD      net/ipv6/netfilter/built-in.o
>   CC [M]  net/ipv6/netfilter/ip6_tables.o
>   CC      net/core/sysctl_net_core.o
>   CC      kernel/utsname.o
>   CC      drivers/firewire/init_ohci1394_dma.o
>   CC [M]  drivers/firewire/core-card.o
>   CC [M]  drivers/firewire/core-cdev.o
>   CC [M]  fs/ecryptfs/mmap.o
>   CC [M]  drivers/firewire/core-device.o
>   CC [M]  net/ieee802154/raw.o
>   CC [M]  drivers/firewire/core-iso.o
>   LD [M]  sound/usb/6fire/snd-usb-6fire.o
>   LD      sound/usb/misc/built-in.o
>   CC [M]  sound/usb/misc/ua101.o
>   LD      sound/usb/usx2y/built-in.o
>   CC [M]  sound/usb/usx2y/us122l.o
>   CC [M]  sound/usb/usx2y/usbusx2y.o
>   CC [M]  fs/dlm/rcom.o
>   CC [M]  sound/usb/usx2y/usX2Yhwdep.o
>   CC [M]  net/bridge/netfilter/ebt_pkttype.o
>   LD [M]  sound/pci/ctxfi/snd-ctxfi.o
>   CC [M]  sound/usb/usx2y/usx2yhwdeppcm.o
>   CC [M]  sound/pci/echoaudio/layla20.o
>   CC      net/core/dev.o
>   CC [M]  fs/ecryptfs/read_write.o
>   CC [M]  fs/ecryptfs/crypto.o
>   CC [M]  drivers/edac/edac_module.o
>   CC [M]  net/bluetooth/sco.o
>   CC [M]  net/dccp/ccids/lib/tfrc.o
>   CC [M]  drivers/edac/edac_device_sysfs.o
>   CC [M]  drivers/firewire/core-topology.o
>   CC [M]  net/dccp/ccids/lib/tfrc_equation.o
>   CC      lib/nlattr.o
>   CC [M]  net/ieee802154/dgram.o
>   CC      lib/average.o
>   CC [M]  fs/dlm/recover.o
>   CC [M]  fs/dlm/recoverd.o
>   CC [M]  net/bridge/netfilter/ebt_stp.o
>   CC [M]  fs/dlm/requestqueue.o
>   CC [M]  net/bridge/netfilter/ebt_vlan.o
>   CC [M]  net/bridge/netfilter/ebt_arpreply.o
>   CC [M]  fs/ecryptfs/keystore.o
>   CC [M]  fs/dlm/user.o
>   LD [M]  sound/usb/misc/snd-ua101.o
>   CC [M]  fs/dlm/util.o
>   LD [M]  sound/usb/snd-usb-audio.o
>   CC [M]  fs/dlm/debug_fs.o
>   CC [M]  drivers/edac/edac_pci.o
>   CC [M]  drivers/edac/mce_amd.o
>   CC [M]  fs/ecryptfs/messaging.o
>   CC [M]  fs/ecryptfs/miscdev.o
>   CC [M]  drivers/firewire/core-transaction.o
>   CC [M]  fs/ecryptfs/kthread.o
>   LD [M]  sound/usb/usx2y/snd-usb-usx2y.o
>   CC [M]  net/dccp/ccids/lib/packet_history.o
>   CC [M]  net/ieee802154/netlink.o
>   LD [M]  sound/usb/usx2y/snd-usb-us122l.o
>   LD [M]  sound/usb/snd-usbmidi-lib.o
>   CC [M]  net/ieee802154/nl-mac.o
>   CC      net/ipv4/protocol.o
>   CC [M]  net/ipv6/netfilter/ip6table_filter.o
>   CC [M]  net/ipv6/netfilter/ip6table_mangle.o
>   CC [M]  net/bluetooth/lib.o
>   CC      net/ipv4/ip_input.o
>   CC [M]  net/bridge/netfilter/ebt_mark.o
>   CC      net/ipv4/ip_fragment.o
>   CC      lib/cpu_rmap.o
>   CC      lib/dynamic_queue_limits.o
>   CC [M]  net/bridge/netfilter/ebt_dnat.o
>   CC      lib/clz_tab.o
>   CC      lib/strncpy_from_user.o
>   CC [M]  net/bridge/netfilter/ebt_redirect.o
>   CC [M]  fs/ecryptfs/debug.o
>   CC [M]  net/bridge/netfilter/ebt_snat.o
>   LD [M]  fs/dlm/dlm.o
>   CC [M]  net/bridge/netfilter/ebt_log.o
>   CC [M]  net/bluetooth/a2mp.o
>   CC [M]  drivers/edac/i5000_edac.o
>   CC [M]  sound/pci/echoaudio/layla24.o
>   CC [M]  drivers/edac/i5100_edac.o
>   CC [M]  drivers/edac/i5400_edac.o
>   CC [M]  sound/pci/echoaudio/mia.o
>   CC      net/core/ethtool.o
>   CC [M]  net/ipv6/netfilter/ip6table_raw.o
>   CC      lib/strnlen_user.o
>   CC [M]  net/ipv6/netfilter/ip6table_security.o
>   LD [M]  fs/ecryptfs/ecryptfs.o
>   CC [M]  drivers/firewire/net.o
>   CC [M]  net/dccp/ccids/lib/loss_interval.o
>   CC      kernel/pid_namespace.o
>   LD      fs/exofs/built-in.o
>   CC [M]  fs/exofs/ore.o
>   CC [M]  fs/exofs/ore_raid.o
>   CC      kernel/res_counter.o
>   CC      lib/asn1_decoder.o
>   GEN     lib/oid_registry_data.c
> Compiling 49 OIDs
>   CC [M]  drivers/firewire/ohci.o
>   CC      drivers/firmware/dmi_scan.o
>   CC [M]  drivers/firewire/sbp2.o
>   CC [M]  net/ieee802154/nl-phy.o
>   LD      net/key/built-in.o
>   CC [M]  net/bridge/netfilter/ebt_ulog.o
>   CC [M]  net/key/af_key.o
>   CC [M]  net/ieee802154/nl_policy.o
>   CC      lib/argv_split.o
>   CC [M]  drivers/edac/i7300_edac.o
>   CC [M]  drivers/edac/i7core_edac.o
>   CC [M]  drivers/edac/sb_edac.o
>   CC      drivers/gpio/gpiolib.o
>   CC [M]  net/dccp/sysctl.o
>   CC [M]  net/bluetooth/amp.o
>   CC [M]  net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.o
>   CC      net/ipv4/ip_forward.o
>   CC      kernel/stop_machine.o
>   CC      lib/bug.o
>   CC      lib/cmdline.o
>   CC [M]  net/ieee802154/wpan-class.o
>   CC      drivers/firmware/efivars.o
>   CC      net/ipv4/ip_options.o
>   LD      net/bluetooth/bnep/built-in.o
>   CC [M]  net/bluetooth/bnep/core.o
>   CC [M]  net/bridge/netfilter/ebt_nflog.o
>   CC [M]  net/bluetooth/bnep/sock.o
>   CC [M]  net/bluetooth/bnep/netdev.o
>   CC      lib/cpumask.o
>   CC      lib/ctype.o
>   CC [M]  drivers/edac/e752x_edac.o
>   CC [M]  drivers/edac/i82975x_edac.o
>   CC [M]  drivers/edac/i3000_edac.o
>   CC [M]  sound/pci/echoaudio/mona.o
>   CC      kernel/audit.o
>   CC      kernel/auditfilter.o
>   CC [M]  net/dccp/diag.o
>   CC [M]  net/ipv6/netfilter/nf_conntrack_proto_icmpv6.o
>   CC      lib/dec_and_lock.o
>   LD [M]  fs/exofs/libore.o
>   LD      fs/exportfs/built-in.o
>   CC [M]  fs/exportfs/expfs.o
>   LD      fs/ext2/built-in.o
>   CC [M]  fs/ext2/balloc.o
>   LD      fs/ext3/built-in.o
>   CC [M]  fs/ext3/balloc.o
>   CC [M]  fs/ext3/bitmap.o
>   CC [M]  fs/ext2/dir.o
>   CC      lib/decompress.o
>   CC      lib/decompress_bunzip2.o
>   CC [M]  fs/ext2/file.o
>   CC      drivers/gpio/devres.o
>   CC [M]  fs/ext2/ialloc.o
>   CC      net/core/dev_addr_lists.o
>   CC      net/core/dst.o
>   LD [M]  net/ieee802154/ieee802154.o
>   LD      drivers/firewire/built-in.o
>   LD [M]  drivers/firewire/firewire-core.o
>   LD [M]  net/ieee802154/af_802154.o
>   LD [M]  drivers/firewire/firewire-ohci.o
>   CC      net/core/netevent.o
>   LD [M]  drivers/firewire/firewire-sbp2.o
>   CC      net/core/neighbour.o
>   LD [M]  drivers/firewire/firewire-net.o
>   CC      net/core/rtnetlink.o
>   LD [M]  net/bluetooth/bnep/bnep.o
>   CC [M]  drivers/edac/i3200_edac.o
>   LD      net/bluetooth/cmtp/built-in.o
>   CC [M]  net/bluetooth/cmtp/core.o
>   CC [M]  net/bluetooth/cmtp/sock.o
>   CC [M]  net/dccp/ipv4.o
>   CC [M]  net/bluetooth/cmtp/capi.o
>   CC      drivers/gpio/gpiolib-acpi.o
>   CC [M]  net/ipv6/netfilter/nf_defrag_ipv6_hooks.o
>   CC      lib/decompress_inflate.o
>   LD [M]  fs/exportfs/exportfs.o
>   CC      lib/decompress_unlzma.o
>   CC      net/ipv4/ip_output.o
>   CC      net/ipv4/ip_sockglue.o
>   CC      kernel/auditsc.o
>   CC      drivers/firmware/dmi-id.o
>   CC      drivers/firmware/iscsi_ibft_find.o
>   CC [M]  fs/ext2/inode.o
>   CC [M]  fs/ext2/ioctl.o
>   CC [M]  fs/ext2/namei.o
>   CC      net/ipv4/inet_hashtables.o
>   CC      net/ipv4/inet_timewait_sock.o
>   CC [M]  drivers/edac/x38_edac.o
>   CC      drivers/gpio/gpio-langwell.o
>   CC      lib/decompress_unlzo.o
>   CC [M]  drivers/gpio/gpio-sch.o
>   CC [M]  net/ipv6/netfilter/nf_conntrack_reasm.o
>   LD [M]  sound/pci/echoaudio/snd-darla20.o
>   LD [M]  sound/pci/echoaudio/snd-gina20.o
>   LD [M]  sound/pci/echoaudio/snd-layla20.o
>   LD [M]  sound/pci/echoaudio/snd-darla24.o
>   LD [M]  sound/pci/echoaudio/snd-gina24.o
>   CC [M]  net/ipv6/netfilter/ip6t_ah.o
>   LD [M]  sound/pci/echoaudio/snd-layla24.o
>   LD [M]  sound/pci/echoaudio/snd-mona.o
>   LD [M]  sound/pci/echoaudio/snd-mia.o
>   LD [M]  sound/pci/echoaudio/snd-echo3g.o
>   LD [M]  sound/pci/echoaudio/snd-indigo.o
>   CC [M]  net/ipv6/netfilter/ip6t_eui64.o
>   LD [M]  sound/pci/echoaudio/snd-indigoio.o
>   LD [M]  sound/pci/echoaudio/snd-indigodj.o
>   CC [M]  fs/ext3/dir.o
>   LD [M]  sound/pci/echoaudio/snd-indigoiox.o
>   LD [M]  sound/pci/echoaudio/snd-indigodjx.o
>   LD      sound/pci/emu10k1/built-in.o
>   CC [M]  sound/pci/emu10k1/emu10k1_synth.o
>   CC      lib/decompress_unxz.o
>   CC      lib/dump_stack.o
>   CC [M]  sound/pci/emu10k1/emu10k1_callback.o
>   LD [M]  net/bluetooth/cmtp/cmtp.o
>   CC      lib/earlycpio.o
>   CC      lib/extable.o
>   LD      net/bluetooth/hidp/built-in.o
>   CC [M]  net/bluetooth/hidp/core.o
>   CC [M]  net/bluetooth/hidp/sock.o
>   CC      drivers/firmware/memmap.o
>   CC [M]  drivers/firmware/edd.o
>   LD      drivers/gpio/built-in.o
>   CC [M]  drivers/firmware/dell_rbu.o
>   CC [M]  fs/ext3/file.o
>   LD [M]  drivers/edac/amd64_edac_mod.o
>   LD      drivers/edac/built-in.o
>   LD [M]  drivers/edac/edac_core.o
>   CC      lib/flex_proportions.o
>   CC [M]  fs/ext3/fsync.o
>   LD [M]  drivers/edac/edac_mce_amd.o
>   CC [M]  fs/ext3/ialloc.o
>   CC [M]  fs/ext2/super.o
>   CC [M]  fs/ext3/inode.o
>   CC [M]  fs/ext3/ioctl.o
>   CC [M]  fs/ext3/namei.o
>   CC [M]  fs/ext3/super.o
>   CC [M]  sound/pci/emu10k1/emu10k1_patch.o
>   CC [M]  net/ipv6/netfilter/ip6t_frag.o
>   LD      drivers/gpu/drm/i2c/built-in.o
>   CC [M]  drivers/gpu/drm/i2c/ch7006_drv.o
>   CC [M]  drivers/gpu/drm/i2c/ch7006_mode.o
>   CC      lib/idr.o
>   CC      lib/int_sqrt.o
>   CC [M]  drivers/gpu/drm/i2c/sil164_drv.o
>   LD      fs/ext4/built-in.o
>   CC [M]  fs/ext4/balloc.o
>   CC      kernel/audit_watch.o
>   CC      kernel/audit_tree.o
>   CC [M]  fs/ext4/bitmap.o
>   CC [M]  net/dccp/ipv6.o
>   CC [M]  fs/ext4/dir.o
>   CC [M]  fs/ext4/file.o
>   CC      net/ipv4/inet_connection_sock.o
>   CC [M]  drivers/firmware/dcdbas.o
>   LD      drivers/gpu/drm/i915/built-in.o
>   CC [M]  drivers/gpu/drm/i915/i915_drv.o
>   CC [M]  drivers/gpu/drm/i915/i915_dma.o
>   CC [M]  sound/pci/emu10k1/emu10k1.o
>   CC      net/core/utils.o
>   CC      net/core/link_watch.o
>   CC      lib/ioremap.o
>   CC      net/ipv4/tcp.o
>   CC [M]  net/ipv6/netfilter/ip6t_ipv6header.o
>   LD [M]  net/bluetooth/hidp/hidp.o
>   LD      net/bluetooth/rfcomm/built-in.o
>   CC [M]  fs/ext2/symlink.o
>   CC [M]  net/bluetooth/rfcomm/core.o
>   CC [M]  net/bluetooth/rfcomm/sock.o
>   LD [M]  drivers/gpu/drm/i2c/ch7006.o
>   CC [M]  sound/pci/emu10k1/emu10k1_main.o
>   LD [M]  drivers/gpu/drm/i2c/sil164.o
>   CC [M]  sound/pci/emu10k1/irq.o
>   CC [M]  sound/pci/emu10k1/memory.o
>   CC [M]  fs/ext3/symlink.o
>   CC [M]  fs/ext3/hash.o
>   CC [M]  fs/ext2/xattr.o
>   CC [M]  fs/ext2/xattr_user.o
>   CC      kernel/kprobes.o
>   CC [M]  fs/ext4/fsync.o
>   CC      lib/irq_regs.o
>   CC [M]  drivers/firmware/iscsi_ibft.o
>   CC      lib/is_single_threaded.o
>   CC [M]  net/ipv6/netfilter/ip6t_mh.o
>   LD      drivers/firmware/built-in.o
>   CC      lib/klist.o
>   CC [M]  sound/pci/emu10k1/voice.o
>   CC      lib/kobject.o
>   LD [M]  net/dccp/dccp.o
>   LD [M]  net/dccp/dccp_ipv4.o
>   LD [M]  net/dccp/dccp_ipv6.o
>   LD [M]  net/dccp/dccp_diag.o
>   CC      net/core/filter.o
>   CC      lib/kobject_uevent.o
>   LD      drivers/gpu/drm/mga/built-in.o
>   CC [M]  drivers/gpu/drm/mga/mga_drv.o
>   LD      drivers/gpu/stub/built-in.o
>   CC [M]  drivers/gpu/drm/mga/mga_dma.o
>   LD      drivers/gpu/drm/nouveau/built-in.o
>   CC [M]  drivers/gpu/drm/nouveau/core/core/client.o
>   CC [M]  drivers/gpu/drm/nouveau/core/core/engctx.o
>   CC [M]  drivers/gpu/drm/nouveau/core/core/engine.o
>   CC [M]  drivers/gpu/drm/mga/mga_state.o
>   CC [M]  drivers/gpu/drm/mga/mga_warp.o
>   CC [M]  fs/ext2/xattr_trusted.o
>   CC [M]  fs/ext4/ialloc.o
>   CC [M]  fs/ext4/inode.o
>   CC      net/core/sock_diag.o
>   CC [M]  fs/ext4/page-io.o
>   CC [M]  drivers/gpu/drm/i915/i915_irq.o
>   CC      net/core/flow.o
>   CC      net/core/net-sysfs.o
>   CC      net/core/netpoll.o
>   CC [M]  net/ipv6/netfilter/ip6t_hbh.o
>   CC [M]  fs/ext2/acl.o
>   CC [M]  net/ipv6/netfilter/ip6t_rt.o
>   CC [M]  sound/pci/emu10k1/emumpu401.o
>   CC [M]  net/ipv6/netfilter/ip6t_REJECT.o
>   CC [M]  sound/pci/emu10k1/emupcm.o
>   CC [M]  drivers/gpu/drm/nouveau/core/core/enum.o
>   CC [M]  sound/pci/emu10k1/io.o
>   CC [M]  net/bluetooth/rfcomm/tty.o
>   CC      lib/md5.o
>   CC      lib/percpu-rwsem.o
>   CC [M]  fs/ext2/xattr_security.o
>   CC      kernel/rcutree.o
>   CC      lib/plist.o
>   LD      net/llc/built-in.o
>   LD      net/mac80211/built-in.o
>   CC [M]  net/llc/llc_core.o
>   CC [M]  net/mac80211/main.o
>   CC [M]  net/mac80211/status.o
>   CC [M]  drivers/gpu/drm/nouveau/core/core/falcon.o
>   CC [M]  drivers/gpu/drm/nouveau/core/core/gpuobj.o
>   CC      net/ipv6/addrconf_core.o
>   CC [M]  drivers/gpu/drm/nouveau/core/core/handle.o
>   CC      net/netfilter/core.o
>   CC [M]  drivers/gpu/drm/nouveau/core/core/mm.o
>   LD [M]  net/ipv6/netfilter/nf_conntrack_ipv6.o
>   CC [M]  drivers/gpu/drm/mga/mga_irq.o
>   CC      net/netlabel/netlabel_user.o
>   LD [M]  net/ipv6/netfilter/nf_defrag_ipv6.o
>   CC      net/netlabel/netlabel_kapi.o
>   CC      lib/prio_heap.o
>   CC [M]  fs/ext2/xip.o
>   CC [M]  fs/ext3/resize.o
>   CC      lib/proportions.o
>   CC [M]  fs/ext3/ext3_jbd.o
>   CC [M]  fs/ext3/xattr.o
>   CC [M]  fs/ext4/ioctl.o
>   LD [M]  fs/ext2/ext2.o
>   CC [M]  sound/pci/emu10k1/emuproc.o
>   CC [M]  fs/ext4/namei.o
>   CC [M]  fs/ext4/super.o
>   CC [M]  drivers/gpu/drm/nouveau/core/core/namedb.o
>   CC      net/ipv4/tcp_input.o
>   CC [M]  net/llc/llc_input.o
>   CC [M]  net/llc/llc_output.o
>   CC      lib/radix-tree.o
>   CC      net/ipv4/tcp_output.o
>   CC      net/ipv6/exthdrs_core.o
>   CC [M]  drivers/gpu/drm/mga/mga_ioc32.o
>   CC [M]  drivers/gpu/drm/i915/i915_debugfs.o
>   LD [M]  net/bluetooth/rfcomm/rfcomm.o
>   LD [M]  net/bluetooth/bluetooth.o
>   CC [M]  sound/pci/emu10k1/emumixer.o
>   CC      net/netlabel/netlabel_domainhash.o
>   CC      net/core/user_dma.o
>   CC      net/core/fib_rules.o
>   CC      net/core/net-traces.o
>   CC [M]  fs/ext3/xattr_user.o
>   CC [M]  drivers/gpu/drm/nouveau/core/core/object.o
>   CC [M]  drivers/gpu/drm/nouveau/core/core/option.o
>   CC      net/netfilter/nf_log.o
>   CC      net/netfilter/nf_queue.o
>   CC      kernel/relay.o
>   CC [M]  net/mac80211/sta_info.o
>   CC [M]  net/mac80211/wep.o
>   CC [M]  net/mac80211/wpa.o
>   CC [M]  fs/ext3/xattr_trusted.o
>   LD [M]  drivers/gpu/drm/mga/mga.o
>   CC [M]  fs/ext3/acl.o
>   CC      lib/ratelimit.o
>   CC      lib/rbtree.o
>   CC      lib/reciprocal_div.o
>   LD [M]  net/llc/llc.o
>   CC [M]  net/mac80211/scan.o
>   CC [M]  net/mac80211/offchannel.o
>   CC [M]  drivers/gpu/drm/nouveau/core/core/parent.o
>   CC      net/ipv6/output_core.o
>   CC      net/netlabel/netlabel_addrlist.o
>   CC      net/ipv6/protocol.o
>   CC      net/ipv6/ip6_offload.o
>   CC      lib/rwsem.o
>   CC [M]  sound/pci/emu10k1/emufx.o
>   CC [M]  sound/pci/emu10k1/timer.o
>   CC [M]  sound/pci/emu10k1/p16v.o
>   CC      net/netfilter/nf_sockopt.o
>   CC [M]  sound/pci/emu10k1/emu10k1x.o
>   CC [M]  fs/ext3/xattr_security.o
>   CC [M]  drivers/gpu/drm/i915/i915_suspend.o
>   CC      net/netfilter/x_tables.o
>   CC [M]  drivers/gpu/drm/nouveau/core/core/printk.o
>   CC [M]  drivers/gpu/drm/nouveau/core/core/ramht.o
>   CC      net/core/drop_monitor.o
>   CC      net/core/netprio_cgroup.o
>   CC      kernel/utsname_sysctl.o
>   CC      lib/sha1.o
>   CC      net/netlabel/netlabel_mgmt.o
>   CC      net/netlabel/netlabel_unlabeled.o
>   CC      net/netlabel/netlabel_cipso_v4.o
>   CC      lib/show_mem.o
>   LD [M]  fs/ext3/ext3.o
>   CC      lib/string.o
>   CC      net/ipv6/tcpv6_offload.o
>   CC      kernel/delayacct.o
>   CC      kernel/taskstats.o
>   CC [M]  drivers/gpu/drm/nouveau/core/core/subdev.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/bar/base.o
>   CC      kernel/tsacct.o
>   CC      kernel/tracepoint.o
>   LD      drivers/gpu/drm/r128/built-in.o
>   CC [M]  drivers/gpu/drm/r128/r128_drv.o
>   CC [M]  drivers/gpu/drm/r128/r128_cce.o
>   CC [M]  net/mac80211/ht.o
>   CC [M]  net/mac80211/agg-tx.o
>   CC      net/netlink/af_netlink.o
>   CC      net/netlink/genetlink.o
>   CC [M]  net/core/pktgen.o
>   CC      lib/timerqueue.o
>   CC [M]  drivers/gpu/drm/i915/i915_gem.o
>   CC      lib/vsprintf.o
>   CC [M]  lib/crc-ccitt.o
>   CC [M]  lib/crc-t10dif.o
>   CC      drivers/hid/hid-lg.o
>   CC      drivers/gpu/vga/vgaarb.o
>   CC      drivers/gpu/vga/vga_switcheroo.o
>   CC [M]  drivers/gpu/drm/r128/r128_state.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/bar/nv50.o
>   CC      net/ipv6/udp_offload.o
>   CC      net/ipv6/exthdrs_offload.o
>   CC      net/ipv6/inet6_hashtables.o
>   LD      net/netlabel/built-in.o
>   CC [M]  net/ipv6/af_inet6.o
>   CC [M]  net/ipv6/anycast.o
>   LD      sound/pci/hda/built-in.o
>   CC [M]  sound/pci/hda/patch_analog.o
>   CC      kernel/elfcore.o
>   CC      kernel/irq_work.o
>   CC      net/netfilter/xt_tcpudp.o
>   CC      drivers/hid/hid-debug.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/bar/nvc0.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/bios/base.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/bios/bit.o
>   CC      drivers/hid/hid-core.o
>   LD [M]  sound/pci/emu10k1/snd-emu10k1.o
>   LD [M]  sound/pci/emu10k1/snd-emu10k1-synth.o
>   LD [M]  sound/pci/emu10k1/snd-emu10k1x.o
>   CC      drivers/hid/hid-input.o
>   CC      kernel/user-return-notifier.o
>   CC      drivers/hid/hidraw.o
>   CC [M]  net/mac80211/agg-rx.o
>   CC      net/ipv4/tcp_timer.o
>   CC      net/ipv4/tcp_ipv4.o
>   CC [M]  sound/pci/hda/patch_ca0110.o
>   LD      drivers/gpu/vga/built-in.o
>   CC [M]  sound/pci/hda/patch_ca0132.o
>   LD      drivers/gpu/drm/radeon/built-in.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_drv.o
>   LD      drivers/gpu/drm/savage/built-in.o
>   CC [M]  drivers/gpu/drm/savage/savage_drv.o
>   LD      drivers/gpu/drm/sis/built-in.o
>   CC [M]  drivers/gpu/drm/sis/sis_drv.o
>   LD      drivers/gpu/drm/ttm/built-in.o
>   CC [M]  drivers/gpu/drm/ttm/ttm_agp_backend.o
>   CC      kernel/crash_dump.o
>   CC [M]  net/netfilter/nfnetlink.o
>   CC [M]  net/netfilter/nf_conntrack_core.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/bios/conn.o
>   LD      net/netlink/built-in.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/bios/dcb.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/bios/disp.o
>   CC [M]  net/ipv6/ip6_output.o
>   CC      kernel/time.o
>   CC [M]  drivers/gpu/drm/r128/r128_irq.o
>   CC [M]  net/ipv6/ip6_input.o
>   CC [M]  drivers/gpu/drm/savage/savage_bci.o
>   CC [M]  drivers/gpu/drm/sis/sis_mm.o
>   CC [M]  lib/crc-itu-t.o
>   CC      drivers/hid/hid-generic.o
>   CC [M]  drivers/gpu/drm/ttm/ttm_memory.o
>   CC [M]  sound/pci/hda/patch_cirrus.o
>   CC [M]  drivers/gpu/drm/ttm/ttm_tt.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_cp.o
>   LD      net/core/built-in.o
>   CC [M]  drivers/gpu/drm/ttm/ttm_bo.o
>   CC [M]  drivers/gpu/drm/ttm/ttm_bo_util.o
>   CC [M]  drivers/gpu/drm/ttm/ttm_bo_vm.o
>   CC      drivers/hid/hid-a4tech.o
>   CC      drivers/hid/hid-apple.o
>   CC [M]  net/mac80211/vht.o
>   CC [M]  drivers/gpu/drm/i915/i915_gem_context.o
>   CC [M]  lib/crc7.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/bios/dp.o
>   CC [M]  drivers/gpu/drm/r128/r128_ioc32.o
>   LD [M]  drivers/gpu/drm/sis/sis.o
>   CC [M]  net/netfilter/nf_conntrack_standalone.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/bios/extdev.o
>   LD      drivers/hsi/clients/built-in.o
>   LD      drivers/hsi/built-in.o
>   LD      drivers/gpu/drm/via/built-in.o
>   CC [M]  drivers/gpu/drm/drm_auth.o
>   CC [M]  drivers/gpu/drm/via/via_irq.o
>   LD      kernel/built-in.o
>   CC [M]  lib/libcrc32c.o
>   CC [M]  drivers/gpu/drm/via/via_drv.o
>   CC      drivers/hid/hid-belkin.o
>   CC [M]  fs/ext4/symlink.o
>   CC [M]  drivers/gpu/drm/savage/savage_state.o
>   LD      drivers/hv/built-in.o
>   CC [M]  drivers/hv/hv_util.o
>   CC      drivers/hwmon/hwmon.o
>   CC      drivers/i2c/i2c-boardinfo.o
>   CC [M]  net/mac80211/ibss.o
>   CC [M]  drivers/hwmon/hwmon-vid.o
>   CC [M]  net/mac80211/iface.o
>   LD [M]  drivers/gpu/drm/r128/r128.o
>   CC [M]  net/mac80211/rate.o
>   CC      net/ipv4/tcp_minisocks.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/bios/gpio.o
>   CC      drivers/hid/hid-cherry.o
>   CC [M]  lib/crc8.o
>   CC [M]  drivers/gpu/drm/i915/i915_gem_debug.o
>   CC [M]  sound/pci/hda/patch_cmedia.o
>   CC [M]  sound/pci/hda/patch_conexant.o
>   CC [M]  drivers/hv/hv_kvp.o
>   CC [M]  drivers/hv/vmbus_drv.o
>   CC [M]  fs/ext4/hash.o
>   CC [M]  fs/ext4/resize.o
>   LD      drivers/i2c/algos/built-in.o
>   CC [M]  drivers/i2c/algos/i2c-algo-bit.o
>   CC [M]  drivers/hwmon/asus_atk0110.o
>   CC [M]  drivers/hwmon/asb100.o
>   CC      drivers/hid/hid-chicony.o
>   CC [M]  drivers/gpu/drm/via/via_map.o
>   CC [M]  drivers/gpu/drm/ttm/ttm_module.o
>   CC [M]  net/netfilter/nf_conntrack_expect.o
>   CC [M]  lib/ts_kmp.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/bios/i2c.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_state.o
>   CC [M]  drivers/gpu/drm/i915/i915_gem_evict.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_mem.o
>   CC      drivers/hid/hid-cypress.o
>   CC [M]  drivers/gpu/drm/ttm/ttm_object.o
>   CC [M]  drivers/gpu/drm/ttm/ttm_lock.o
>   CC [M]  drivers/gpu/drm/ttm/ttm_execbuf_util.o
>   CC [M]  lib/ts_bm.o
>   CC [M]  lib/ts_fsm.o
>   LD [M]  drivers/gpu/drm/savage/savage.o
>   CC [M]  lib/cordic.o
>   CC [M]  drivers/gpu/drm/via/via_mm.o
>   CC [M]  drivers/i2c/algos/i2c-algo-pca.o
>   CC [M]  drivers/gpu/drm/via/via_dma.o
>   CC      drivers/hid/hid-dr.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/bios/init.o
>   CC [M]  drivers/hwmon/w83627hf.o
>   CC      drivers/hid/hid-ezkey.o
>   CC [M]  drivers/hv/hv.o
>   CC [M]  drivers/hv/connection.o
>   CC [M]  drivers/hv/channel.o
>   CC      net/ipv4/tcp_cong.o
>   CC [M]  net/ipv6/addrconf.o
>   CC [M]  drivers/gpu/drm/i915/i915_gem_execbuffer.o
>   CC [M]  drivers/gpu/drm/i915/i915_gem_gtt.o
>   CC [M]  drivers/gpu/drm/i915/i915_gem_stolen.o
>   CC [M]  fs/ext4/extents.o
>   GEN     lib/crc32table.h
>   CC      lib/oid_registry.o
>   CC [M]  net/mac80211/michael.o
>   CC [M]  fs/ext4/ext4_jbd2.o
>   CC [M]  fs/ext4/migrate.o
>   CC [M]  net/mac80211/tkip.o
>   CC [M]  net/mac80211/aes_ccm.o
>   CC      drivers/hid/hid-gyration.o
>   CC [M]  drivers/hv/channel_mgmt.o
>   CC      drivers/hid/hid-kensington.o
>   CC [M]  drivers/gpu/drm/ttm/ttm_page_alloc.o
>   CC [M]  net/netfilter/nf_conntrack_helper.o
>   LD      drivers/i2c/busses/built-in.o
>   CC [M]  drivers/i2c/busses/i2c-scmi.o
>   CC [M]  drivers/i2c/busses/i2c-amd756.o
>   AR      lib/lib.a
>   CC      lib/crc32.o
>   CC [M]  sound/pci/hda/patch_hdmi.o
> drivers/gpu/drm/i915/i915_gem_gtt.c: In function
> =E2=80=98gen6_ggtt_bind_object=E2=80=99: drivers/gpu/drm/i915/i915_gem_gt=
t.c:438:
> warning: =E2=80=98addr=E2=80=99 may be used uninitialized in this functio=
n CC [M]
> sound/pci/hda/hda_eld.o CC      drivers/hid/hid-kye.o
>   CC [M]  sound/pci/hda/patch_sigmatel.o
>   CC [M]  drivers/gpu/drm/via/via_verifier.o
>   CC [M]  sound/pci/hda/patch_realtek.o
>   CC [M]  drivers/gpu/drm/ttm/ttm_bo_manager.o
>   CC [M]  drivers/gpu/drm/ttm/ttm_page_alloc_dma.o
>   LD      fs/fat/built-in.o
>   CC [M]  fs/fat/cache.o
>   CC [M]  drivers/hwmon/w83792d.o
>   CC [M]  fs/fat/dir.o
>   CC [M]  fs/fat/fatent.o
>   CC [M]  drivers/hv/ring_buffer.o
>   LD      drivers/hid/hid-logitech.o
>   CC [M]  drivers/gpu/drm/i915/i915_gem_tiling.o
>   CC      drivers/hid/hid-microsoft.o
>   CC [M]  drivers/i2c/busses/i2c-amd756-s4882.o
>   LD      lib/built-in.o
>   CC [M]  drivers/i2c/busses/i2c-amd8111.o
>   CC [M]  drivers/hwmon/w83793.o
>   CC      net/ipv4/tcp_metrics.o
>   CC      net/ipv4/tcp_fastopen.o
>   CC      net/ipv4/datagram.o
>   CC [M]  drivers/hv/hv_balloon.o
>   CC [M]  net/mac80211/aes_cmac.o
>   CC [M]  net/mac80211/cfg.o
>   CC [M]  net/netfilter/nf_conntrack_proto.o
>   CC      drivers/hid/hid-monterey.o
>   CC [M]  drivers/gpu/drm/via/via_video.o
>   CC [M]  drivers/gpu/drm/via/via_dmablit.o
>   LD      drivers/i2c/muxes/built-in.o
>   CC [M]  drivers/gpu/drm/i915/i915_sysfs.o
>   CC      net/ipv4/raw.o
>   LD      fs/fscache/built-in.o
>   CC [M]  fs/fscache/cache.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/bios/mxm.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_irq.o
>   CC [M]  drivers/i2c/busses/i2c-i801.o
>   LD [M]  drivers/gpu/drm/ttm/ttm.o
>   CC [M]  drivers/i2c/busses/i2c-isch.o
>   CC      drivers/hid/hid-ntrig.o
>   LD [M]  drivers/hv/hv_vmbus.o
>   LD [M]  drivers/hv/hv_utils.o
>   CC      drivers/hid/hid-pl.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/bios/perf.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/bios/pll.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/bios/therm.o
>   CC [M]  fs/ext4/mballoc.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/clock/nv04.o
>   CC [M]  fs/ext4/block_validity.o
>   CC [M]  drivers/hwmon/w83781d.o
>   CC [M]  drivers/gpu/drm/i915/i915_trace_points.o
>   CC [M]  drivers/gpu/drm/i915/intel_display.o
>   CC [M]  drivers/hwmon/w83791d.o
>   CC [M]  fs/fat/file.o
>   CC [M]  fs/fat/inode.o
>   CC [M]  net/netfilter/nf_conntrack_l3proto_generic.o
>   CC [M]  fs/fat/misc.o
>   CC [M]  fs/fscache/cookie.o
>   CC [M]  drivers/gpu/drm/radeon/r300_cmdbuf.o
>   LD [M]  drivers/gpu/drm/via/via.o
>   CC [M]  drivers/gpu/drm/radeon/r600_cp.o
>   CC      drivers/hid/hid-petalynx.o
>   CC      drivers/hid/hid-samsung.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_device.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_asic.o
>   CC [M]  drivers/i2c/busses/i2c-nforce2.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/clock/nv40.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/clock/nv50.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/clock/nva3.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/clock/nvc0.o
>   CC [M]  net/ipv6/addrlabel.o
>   CC      net/ipv4/udp.o
>   CC      net/ipv4/udplite.o
>   CC [M]  sound/pci/hda/patch_si3054.o
>   CC      net/ipv4/arp.o
>   CC [M]  drivers/hwmon/abituguru.o
>   CC      drivers/hid/hid-sjoy.o
>   CC [M]  fs/fscache/fsdef.o
>   CC [M]  fs/fscache/main.o
>   CC [M]  net/ipv6/route.o
>   CC [M]  net/mac80211/rx.o
>   CC [M]  net/ipv6/ip6_fib.o
>   CC [M]  net/ipv6/ipv6_sockglue.o
>   CC [M]  net/mac80211/spectmgmt.o
>   CC [M]  net/netfilter/nf_conntrack_proto_generic.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/clock/pllnv04.o
>   CC [M]  sound/pci/hda/patch_via.o
>   CC      drivers/hid/hid-sony.o
>   CC [M]  drivers/i2c/busses/i2c-nforce2-s4985.o
>   CC      drivers/hid/hid-sunplus.o
>   CC [M]  drivers/hwmon/abituguru3.o
>   CC [M]  sound/pci/hda/hda_codec.o
>   CC [M]  fs/fat/nfs.o
>   CC [M]  sound/pci/hda/hda_jack.o
>   CC [M]  fs/fat/namei_msdos.o
>   CC [M]  fs/fscache/netfs.o
>   CC [M]  fs/fscache/object.o
>   CC [M]  fs/fscache/operation.o
>   CC [M]  fs/fscache/page.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_kms.o
>   CC      drivers/hid/hid-gaff.o
>   CC [M]  drivers/i2c/busses/i2c-piix4.o
>   CC [M]  net/mac80211/tx.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/clock/pllnva3.o
>   CC [M]  net/netfilter/nf_conntrack_proto_tcp.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/device/base.o
>   CC [M]  drivers/hwmon/ad7414.o
>   CC      drivers/hid/hid-tmff.o
>   CC [M]  fs/fat/namei_vfat.o
>   CC      drivers/hid/hid-topseed.o
>   CC      drivers/hid/hid-twinhan.o
>   CC      drivers/hid/hid-zpff.o
>   CC [M]  drivers/hwmon/ad7418.o
>   CC      drivers/hid/usbhid/hid-core.o
>   CC [M]  drivers/hid/hid-multitouch.o
>   CC [M]  drivers/i2c/busses/i2c-sis96x.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_atombios.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_agp.o
>   CC [M]  drivers/i2c/busses/i2c-via.o
>   CC [M]  drivers/i2c/busses/i2c-viapro.o
>   CC [M]  drivers/i2c/busses/i2c-pca-platform.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/device/nv04.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/device/nv10.o
>   CC [M]  fs/ext4/move_extent.o
>   CC [M]  fs/fscache/proc.o
>   CC [M]  fs/fscache/stats.o
>   CC [M]  drivers/gpu/drm/drm_buffer.o
>   CC [M]  drivers/hwmon/adm1021.o
>   CC [M]  drivers/hwmon/adm1025.o
>   CC      net/ipv4/icmp.o
>   CC      drivers/hid/usbhid/hid-quirks.o
>   CC      net/ipv4/devinet.o
>   CC      net/ipv4/af_inet.o
>   LD      sound/pci/ice1712/built-in.o
>   CC [M]  sound/pci/ice1712/ice1712.o
>   CC [M]  net/mac80211/key.o
>   LD      fs/gfs2/built-in.o
>   LD      fs/fuse/built-in.o
>   CC      fs/hugetlbfs/inode.o
>   CC [M]  fs/gfs2/acl.o
>   CC [M]  fs/fuse/dev.o
>   CC [M]  net/ipv6/ndisc.o
>   LD [M]  fs/fat/fat.o
>   LD [M]  fs/fat/vfat.o
>   LD [M]  fs/fat/msdos.o
>   CC [M]  drivers/i2c/busses/i2c-simtec.o
>   CC [M]  net/ipv6/udp.o
>   LD [M]  fs/fscache/fscache.o
>   CC [M]  drivers/i2c/busses/i2c-parport.o
> net/mac80211/tx.c: In function =E2=80=98ieee80211_subif_start_xmit=E2=80=
=99:
> net/mac80211/tx.c:1752: warning: =E2=80=98chanctx_conf=E2=80=99 may be us=
ed
> uninitialized in this function CC [M]
> drivers/gpu/drm/nouveau/core/subdev/device/nv20.o CC [M]
> drivers/gpu/drm/nouveau/core/subdev/device/nv30.o CC [M]
> drivers/hwmon/adm1026.o CC [M]  net/netfilter/nf_conntrack_proto_udp.o
>   CC [M]  net/netfilter/nf_conntrack_extend.o
>   CC [M]  drivers/hwmon/adm1029.o
>   CC [M]  fs/gfs2/bmap.o
>   CC      drivers/hid/usbhid/hiddev.o
>   CC [M]  fs/ext4/mmp.o
>   CC [M]  fs/ext4/indirect.o
>   CC [M]  fs/ext4/extents_status.o
>   CC [M]  drivers/i2c/busses/i2c-parport-light.o
>   CC [M]  fs/ext4/xattr.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/device/nv40.o
>   LD      fs/hugetlbfs/hugetlbfs.o
>   CC [M]  drivers/gpu/drm/i915/intel_crt.o
>   LD      fs/hugetlbfs/built-in.o
>   CC [M]  drivers/gpu/drm/i915/intel_lvds.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/device/nv50.o
>   CC [M]  drivers/gpu/drm/radeon/atombios_crtc.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_combios.o
>   CC [M]  drivers/i2c/busses/i2c-tiny-usb.o
>   CC [M]  sound/pci/hda/hda_auto_parser.o
>   CC [M]  net/mac80211/util.o
>   CC [M]  net/mac80211/wme.o
>   CC [M]  fs/fuse/dir.o
>   CC [M]  fs/fuse/file.o
>   CC [M]  net/netfilter/nf_conntrack_acct.o
>   CC [M]  drivers/hwmon/adm1031.o
>   CC [M]  drivers/hwmon/adm9240.o
>   CC [M]  drivers/hwmon/ads7828.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/device/nvc0.o
>   CC [M]  sound/pci/ice1712/delta.o
>   CC [M]  sound/pci/ice1712/hoontech.o
>   CC      drivers/hid/usbhid/hid-pidff.o
>   CC [M]  drivers/i2c/i2c-core.o
>   CC [M]  net/netfilter/nf_conntrack_ecache.o
>   CC [M]  drivers/gpu/drm/drm_bufs.o
>   CC      net/ipv4/igmp.o
>   CC [M]  drivers/gpu/drm/i915/intel_bios.o
>   CC [M]  fs/gfs2/dir.o
>   CC [M]  fs/gfs2/xattr.o
>   CC [M]  drivers/gpu/drm/i915/intel_ddi.o
>   CC [M]  fs/ext4/xattr_user.o
>   CC [M]  fs/ext4/xattr_trusted.o
>   CC [M]  drivers/gpu/drm/drm_cache.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/device/nve0.o
>   CC [M]  net/ipv6/udplite.o
>   CC [M]  drivers/gpu/drm/drm_context.o
>   CC [M]  net/ipv6/raw.o
>   CC [M]  sound/pci/hda/hda_generic.o
>   CC [M]  drivers/hwmon/adt7462.o
>   CC [M]  drivers/hwmon/adt7470.o
>   CC [M]  drivers/hwmon/adt7475.o
>   CC [M]  sound/pci/ice1712/ews.o
>   LD      drivers/hid/usbhid/usbhid.o
>   LD      drivers/hid/usbhid/built-in.o
>   CC [M]  drivers/hid/hid-wacom.o
>   CC [M]  sound/pci/ice1712/ice1724.o
>   CC [M]  net/netfilter/nf_conntrack_h323_main.o
>   CC [M]  sound/pci/ice1712/amp.o
>   CC [M]  fs/ext4/inline.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/devinit/base.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/devinit/nv04.o
>   CC [M]  drivers/i2c/i2c-smbus.o
>   CC [M]  drivers/i2c/i2c-dev.o
>   CC [M]  drivers/i2c/i2c-stub.o
>   CC [M]  drivers/gpu/drm/i915/intel_dp.o
>   CC [M]  drivers/gpu/drm/i915/intel_hdmi.o
>   CC [M]  drivers/gpu/drm/radeon/atom.o
>   CC [M]  fs/gfs2/glock.o
>   CC [M]  fs/fuse/inode.o
>   CC [M]  fs/gfs2/glops.o
>   CC [M]  fs/gfs2/log.o
>   CC [M]  fs/gfs2/lops.o
>   LD      drivers/hid/hid.o
>   CC [M]  fs/gfs2/main.o
>   LD      drivers/hid/built-in.o
>   CC [M]  fs/gfs2/meta_io.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/devinit/nv05.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_fence.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_ttm.o
>   CC [M]  sound/pci/hda/hda_proc.o
>   CC [M]  drivers/hwmon/applesmc.o
>   CC [M]  drivers/hwmon/atxp1.o
>   CC [M]  drivers/hwmon/coretemp.o
>   LD      drivers/i2c/built-in.o
>   CC [M]  net/ipv6/icmp.o
>   CC [M]  net/mac80211/event.o
>   CC [M]  net/mac80211/chan.o
>   CC [M]  net/mac80211/trace.o
>   CC [M]  drivers/hwmon/dme1737.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/devinit/nv10.o
>   CC [M]  net/mac80211/mlme.o
>   CC [M]  fs/ext4/acl.o
>   CC      net/ipv4/fib_frontend.o
>   CC [M]  fs/ext4/xattr_security.o
>   CC      fs/isofs/namei.o
>   CC [M]  sound/pci/hda/hda_hwdep.o
>   CC [M]  sound/pci/hda/hda_beep.o
>   CC      fs/isofs/inode.o
>   CC [M]  sound/pci/hda/hda_intel.o
>   CC [M]  drivers/hwmon/ds1621.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/devinit/nv1a.o
>   CC [M]  fs/fuse/control.o
>   CC [M]  fs/fuse/cuse.o
>   LD      drivers/idle/built-in.o
>   CC [M]  drivers/idle/i7300_idle.o
>   CC [M]  sound/pci/ice1712/revo.o
>   CC [M]  sound/pci/ice1712/aureon.o
>   CC [M]  net/netfilter/nf_conntrack_h323_asn1.o
>   CC [M]  net/netfilter/nfnetlink_queue_core.o
>   CC [M]  sound/pci/ice1712/vt1720_mobo.o
>   CC [M]  drivers/gpu/drm/i915/intel_sdvo.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_object.o
>   LD [M]  fs/ext4/ext4.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_gart.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_legacy_crtc.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/devinit/nv20.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_legacy_encoders.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_connectors.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_encoders.o
>   LD [M]  fs/fuse/fuse.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_display.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/devinit/nv50.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/fb/base.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/fb/nv04.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_cursor.o
>   CC [M]  net/ipv6/mcast.o
>   CC      fs/isofs/dir.o
>   CC [M]  drivers/hwmon/f71805f.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/fb/nv10.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/fb/nv1a.o
>   CC [M]  fs/gfs2/aops.o
>   CC [M]  fs/gfs2/dentry.o
>   CC      net/ipv4/fib_semantics.o
>   CC      net/ipv4/fib_trie.o
>   LD      fs/jbd/built-in.o
>   CC [M]  drivers/gpu/drm/drm_dma.o
>   CC [M]  fs/jbd/transaction.o
>   CC [M]  fs/jbd/commit.o
>   CC [M]  drivers/gpu/drm/i915/intel_modes.o
>   CC      fs/isofs/util.o
>   CC [M]  net/netfilter/nfnetlink_log.o
>   CC [M]  sound/pci/ice1712/pontis.o
>   CC [M]  sound/pci/ice1712/prodigy192.o
>   LD [M]  net/netfilter/nf_conntrack.o
>   CC [M]  sound/pci/ice1712/prodigy_hifi.o
>   CC [M]  sound/pci/ice1712/juli.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/fb/nv20.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/fb/nv25.o
>   LD [M]  sound/pci/hda/snd-hda-codec.o
>   CC      fs/isofs/rock.o
>   LD [M]  sound/pci/hda/snd-hda-codec-realtek.o
>   LD [M]  sound/pci/hda/snd-hda-codec-cmedia.o
>   CC      fs/isofs/export.o
>   LD [M]  sound/pci/hda/snd-hda-codec-analog.o
>   CC      fs/isofs/joliet.o
>   LD [M]  sound/pci/hda/snd-hda-codec-idt.o
>   LD [M]  sound/pci/hda/snd-hda-codec-si3054.o
>   LD [M]  sound/pci/hda/snd-hda-codec-cirrus.o
>   LD [M]  sound/pci/hda/snd-hda-codec-ca0110.o
>   LD [M]  sound/pci/hda/snd-hda-codec-ca0132.o
>   LD [M]  sound/pci/hda/snd-hda-codec-conexant.o
>   CC      fs/isofs/compress.o
>   LD [M]  sound/pci/hda/snd-hda-codec-via.o
>   CC [M]  drivers/hwmon/f71882fg.o
>   LD [M]  sound/pci/hda/snd-hda-codec-hdmi.o
>   LD [M]  sound/pci/hda/snd-hda-intel.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_i2c.o
>   CC [M]  drivers/hwmon/f75375s.o
>   CC [M]  fs/gfs2/export.o
>   CC [M]  fs/gfs2/file.o
>   CC [M]  sound/pci/ice1712/phase.o
>   CC [M]  drivers/gpu/drm/i915/intel_panel.o
>   CC [M]  fs/gfs2/ops_fstype.o
>   CC [M]  fs/gfs2/inode.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/fb/nv30.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_clocks.o
>   CC [M]  drivers/gpu/drm/i915/intel_pm.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_fb.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_gem.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_ring.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_irq_kms.o
>   CC [M]  fs/jbd/recovery.o
>   CC [M]  fs/jbd/checkpoint.o
>   LD      fs/isofs/isofs.o
>   LD      fs/isofs/built-in.o
>   CC [M]  fs/jbd/revoke.o
>   CC [M]  fs/jbd/journal.o
>   CC [M]  net/mac80211/led.o
>   CC [M]  net/mac80211/pm.o
>   CC [M]  net/netfilter/nf_conntrack_proto_dccp.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/fb/nv35.o
>   CC [M]  sound/pci/ice1712/wtm.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/fb/nv36.o
>   CC [M]  net/netfilter/nf_conntrack_proto_gre.o
>   CC [M]  net/netfilter/nf_conntrack_proto_sctp.o
>   CC [M]  sound/pci/ice1712/se.o
>   CC [M]  sound/pci/ice1712/maya44.o
>   CC [M]  sound/pci/ice1712/quartet.o
>   CC [M]  net/netfilter/nf_conntrack_proto_udplite.o
>   CC [M]  net/netfilter/nf_conntrack_netlink.o
>   CC [M]  net/ipv6/reassembly.o
>   CC [M]  net/netfilter/nf_conntrack_amanda.o
>   CC [M]  drivers/hwmon/fam15h_power.o
>   CC [M]  net/netfilter/nf_conntrack_ftp.o
>   LD [M]  net/netfilter/nf_conntrack_h323.o
>   CC [M]  drivers/gpu/drm/i915/intel_i2c.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_cs.o
>   CC [M]  fs/gfs2/quota.o
>   CC [M]  fs/gfs2/recovery.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/fb/nv40.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/fb/nv41.o
>   CC [M]  drivers/hwmon/fschmd.o
>   CC [M]  drivers/hwmon/g760a.o
>   CC      net/ipv4/inet_fragment.o
>   CC      net/ipv4/ping.o
>   CC [M]  drivers/hwmon/gl518sm.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/fb/nv44.o
>   CC [M]  net/netfilter/nf_conntrack_irc.o
>   CC [M]  drivers/hwmon/gl520sm.o
>   CC [M]  drivers/hwmon/i5k_amb.o
>   CC [M]  sound/pci/ice1712/psc724.o
>   CC [M]  net/mac80211/rc80211_minstrel.o
>   CC [M]  sound/pci/ice1712/wm8766.o
>   CC [M]  sound/pci/ice1712/wm8776.o
>   CC [M]  sound/pci/ice1712/ak4xxx.o
>   LD      net/openvswitch/built-in.o
>   CC [M]  net/openvswitch/actions.o
>   CC [M]  net/openvswitch/datapath.o
>   CC      net/packet/af_packet.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_bios.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/fb/nv46.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/fb/nv47.o
>   LD [M]  fs/jbd/jbd.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/fb/nv49.o
>   CC [M]  net/mac80211/rc80211_minstrel_ht.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/fb/nv4e.o
>   CC [M]  net/ipv6/tcp_ipv6.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/fb/nv50.o
>   CC [M]  drivers/hwmon/ibmaem.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/fb/nvc0.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_benchmark.o
>   HOSTCC  drivers/gpu/drm/radeon/mkregtable
>   CC [M]  drivers/gpu/drm/i915/intel_fb.o
>   CC [M]  drivers/gpu/drm/i915/intel_tv.o
>   CC [M]  drivers/gpu/drm/i915/intel_dvo.o
>   CC [M]  fs/gfs2/rgrp.o
>   LD [M]  sound/pci/ice1712/snd-ice1712.o
>   LD [M]  sound/pci/ice1712/snd-ice17xx-ak4xxx.o
>   LD [M]  sound/pci/ice1712/snd-ice1724.o
>   CC [M]  drivers/gpu/drm/drm_drv.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/gpio/base.o
>   LD      sound/pci/korg1212/built-in.o
>   LD      sound/pci/lola/built-in.o
>   CC [M]  sound/pci/korg1212/korg1212.o
>   LD      sound/pci/lx6464es/built-in.o
>   CC [M]  sound/pci/lx6464es/lx6464es.o
>   CC [M]  net/netfilter/nf_conntrack_broadcast.o
>   LD      drivers/infiniband/built-in.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/gpio/nv10.o
>   LD      drivers/infiniband/hw/cxgb3/built-in.o
>   LD      drivers/infiniband/core/built-in.o
>   CC [M]  drivers/infiniband/hw/cxgb3/iwch_cm.o
>   CC [M]  drivers/infiniband/core/addr.o
>   CC [M]  drivers/infiniband/core/cm.o
>   CC [M]  drivers/gpu/drm/i915/intel_ringbuffer.o
>   CC [M]  drivers/gpu/drm/i915/intel_overlay.o
>   CC [M]  drivers/gpu/drm/i915/intel_sprite.o
>   CC [M]  drivers/hwmon/ibmpex.o
>   CC [M]  drivers/gpu/drm/radeon/rs400.o
>   CC      net/ipv4/sysctl_net_ipv4.o
>   CC [M]  drivers/infiniband/core/packer.o
>   CC [M]  drivers/hwmon/it87.o
>   CC [M]  drivers/infiniband/core/ud_header.o
>   CC [M]  drivers/hwmon/k8temp.o
>   CC [M]  drivers/infiniband/core/verbs.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/gpio/nv50.o
>   CC [M]  net/openvswitch/dp_notify.o
>   LD [M]  net/mac80211/mac80211.o
>   CC [M]  drivers/infiniband/core/sysfs.o
>   CC      net/ipv4/proc.o
>   CC [M]  sound/pci/lx6464es/lx_core.o
>   CC      net/ipv4/fib_rules.o
>   CC [M]  net/netfilter/nf_conntrack_netbios_ns.o
>   CC      net/ipv4/ipmr.o
>   CC [M]  drivers/gpu/drm/drm_fops.o
>   LD [M]  sound/pci/korg1212/snd-korg1212.o
>   CC [M]  drivers/gpu/drm/i915/intel_opregion.o
>   CC [M]  drivers/gpu/drm/drm_gem.o
>   CC [M]  drivers/gpu/drm/i915/dvo_ch7xxx.o
>   CC [M]  drivers/gpu/drm/i915/dvo_ch7017.o
>   MKREGTABLE drivers/gpu/drm/radeon/rs600_reg_safe.h
>   CC [M]  drivers/gpu/drm/radeon/rs690.o
>   MKREGTABLE drivers/gpu/drm/radeon/rv515_reg_safe.h
>   CC [M]  net/openvswitch/flow.o
>   CC [M]  drivers/infiniband/core/device.o
>   CC [M]  net/openvswitch/vport.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/gpio/nvd0.o
>   CC [M]  fs/gfs2/super.o
>   LD      net/packet/built-in.o
>   CC [M]  net/openvswitch/vport-internal_dev.o
>   LD      net/phonet/built-in.o
>   CC [M]  net/ipv6/exthdrs.o
>   CC [M]  net/phonet/pn_dev.o
>   LD      net/rds/built-in.o
>   CC [M]  net/rds/af_rds.o
>   CC [M]  net/rds/bind.o
>   CC [M]  net/netfilter/nf_conntrack_snmp.o
>   CC [M]  drivers/hwmon/k10temp.o
>   CC [M]  drivers/hwmon/lm63.o
>   LD [M]  sound/pci/lx6464es/snd-lx6464es.o
>   LD      sound/pci/mixart/built-in.o
>   CC [M]  drivers/gpu/drm/drm_ioctl.o
>   CC [M]  sound/pci/mixart/mixart.o
>   LD      sound/pci/nm256/built-in.o
>   CC [M]  sound/pci/mixart/mixart_core.o
>   CC [M]  drivers/gpu/drm/i915/dvo_ivch.o
>   CC [M]  drivers/gpu/drm/i915/dvo_tfp410.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/i2c/base.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/i2c/aux.o
>   CC [M]  drivers/gpu/drm/i915/dvo_sil164.o
>   CC [M]  drivers/gpu/drm/i915/dvo_ns2501.o
>   CC [M]  drivers/gpu/drm/i915/i915_gem_dmabuf.o
>   CC [M]  drivers/infiniband/hw/cxgb3/iwch_ev.o
>   CC [M]  drivers/infiniband/hw/cxgb3/iwch_cq.o
>   CC      net/ipv4/gre.o
>   CC [M]  drivers/gpu/drm/radeon/r520.o
>   CC [M]  net/phonet/pn_netlink.o
>   CC [M]  drivers/gpu/drm/radeon/r600.o
>   CC [M]  net/netfilter/nf_conntrack_pptp.o
>   CC [M]  drivers/hwmon/lm75.o
>   CC [M]  net/openvswitch/vport-netdev.o
>   CC [M]  drivers/gpu/drm/drm_irq.o
>   CC [M]  drivers/gpu/drm/i915/i915_ioc32.o
>   CC [M]  fs/gfs2/sys.o
>   CC [M]  drivers/infiniband/core/fmr_pool.o
>   CC [M]  net/rds/cong.o
>   CC [M]  net/rds/connection.o
>   CC [M]  net/rds/info.o
>   CC [M]  net/rds/message.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/i2c/bit.o
>   CC [M]  sound/pci/mixart/mixart_hwdep.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/ibus/nvc0.o
>   CC [M]  sound/pci/mixart/mixart_mixer.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/ibus/nve0.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/instmem/base.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/instmem/nv04.o
>   CC [M]  drivers/infiniband/hw/cxgb3/iwch_qp.o
>   CC [M]  net/phonet/socket.o
>   CC [M]  net/phonet/datagram.o
>   CC [M]  drivers/hwmon/lm77.o
>   CC [M]  net/ipv6/datagram.o
>   LD [M]  net/openvswitch/openvswitch.o
>   CC [M]  net/ipv6/ip6_flowlabel.o
>   CC      net/ipv4/syncookies.o
>   CC      net/ipv4/inet_lro.o
>   CC [M]  drivers/gpu/drm/i915/intel_acpi.o
>   CC [M]  drivers/infiniband/core/cache.o
>   CC [M]  drivers/infiniband/core/netlink.o
>   CC      net/ipv4/netfilter.o
>   CC [M]  net/rds/recv.o
>   CC [M]  fs/gfs2/trans.o
>   CC [M]  fs/gfs2/util.o
>   LD [M]  sound/pci/mixart/snd-mixart.o
>   LD      sound/pci/oxygen/built-in.o
>   CC [M]  sound/pci/oxygen/oxygen_io.o
>   CC [M]  drivers/hwmon/lm78.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/instmem/nv40.o
>   CC [M]  net/netfilter/nf_conntrack_sane.o
>   CC [M]  net/netfilter/nf_conntrack_sip.o
>   CC [M]  drivers/hwmon/lm80.o
>   CC [M]  net/netfilter/nf_conntrack_tftp.o
>   CC [M]  net/netfilter/nf_tproxy_core.o
>   CC [M]  drivers/hwmon/lm83.o
>   LD [M]  drivers/gpu/drm/i915/i915.o
>   CC [M]  drivers/hwmon/lm85.o
>   CC [M]  drivers/hwmon/lm87.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/instmem/nv50.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/ltcg/nvc0.o
>   CC [M]  net/netfilter/xt_mark.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/mc/base.o
>   CC [M]  sound/pci/oxygen/oxygen_lib.o
>   CC [M]  fs/gfs2/lock_dlm.o
>   CC [M]  drivers/infiniband/hw/cxgb3/iwch_mem.o
>   CC [M]  drivers/infiniband/hw/cxgb3/iwch_provider.o
>   CC [M]  net/phonet/sysctl.o
>   CC [M]  drivers/infiniband/core/umem.o
>   CC [M]  net/phonet/af_phonet.o
>   CC [M]  drivers/infiniband/core/mad.o
>   CC [M]  drivers/infiniband/hw/cxgb3/iwch.o
>   CC [M]  drivers/gpu/drm/radeon/rv770.o
>   CC [M]  drivers/infiniband/core/smi.o
>   LD      drivers/infiniband/hw/cxgb4/built-in.o
>   CC [M]  drivers/infiniband/hw/cxgb4/device.o
>   CC [M]  net/ipv6/inet6_connection_sock.o
>   LD      net/ipv4/netfilter/built-in.o
>   CC [M]  net/rds/send.o
>   CC [M]  net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.o
>   CC [M]  net/netfilter/xt_connmark.o
>   CC [M]  net/rds/stats.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_test.o
>   CC [M]  drivers/infiniband/hw/cxgb4/cm.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/mc/nv04.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/mc/nv44.o
>   CC [M]  drivers/infiniband/hw/cxgb4/provider.o
>   CC [M]  net/phonet/pep.o
>   CC [M]  net/phonet/pep-gprs.o
>   LD      net/rfkill/built-in.o
>   CC [M]  net/rfkill/core.o
>   LD [M]  fs/gfs2/gfs2.o
>   CC [M]  drivers/hwmon/lm90.o
>   LD      fs/jbd2/built-in.o
>   CC [M]  fs/jbd2/transaction.o
>   CC [M]  sound/pci/oxygen/oxygen_mixer.o
>   CC [M]  sound/pci/oxygen/oxygen_pcm.o
>   CC [M]  drivers/infiniband/hw/cxgb3/cxio_hal.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/mc/nv50.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/mc/nv98.o
>   CC [M]  fs/jbd2/commit.o
>   CC [M]  fs/jbd2/recovery.o
>   MKREGTABLE drivers/gpu/drm/radeon/r200_reg_safe.h
>   CC [M]  drivers/gpu/drm/radeon/radeon_legacy_tv.o
>   MKREGTABLE drivers/gpu/drm/radeon/r600_reg_safe.h
>   CC [M]  drivers/infiniband/core/agent.o
>   CC [M]  drivers/infiniband/core/mad_rmpp.o
>   CC [M]  net/ipv6/sysctl_net_ipv6.o
>   CC [M]  net/ipv6/ip6mr.o
>   CC [M]  net/netfilter/xt_set.o
>   CC [M]  net/ipv4/netfilter/nf_conntrack_proto_icmp.o
>   CC [M]  net/netfilter/xt_AUDIT.o
>   CC [M]  net/netfilter/xt_CHECKSUM.o
>   CC [M]  net/ipv4/netfilter/nf_defrag_ipv4.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/mc/nvc0.o
>   CC [M]  net/ipv4/netfilter/ip_tables.o
>   CC [M]  drivers/hwmon/lm92.o
>   CC [M]  drivers/hwmon/lm93.o
>   CC [M]  net/ipv4/netfilter/iptable_filter.o
>   CC [M]  net/rds/sysctl.o
>   CC [M]  sound/pci/oxygen/oxygen.o
>   CC [M]  sound/pci/oxygen/xonar_dg.o
>   CC [M]  sound/pci/oxygen/virtuoso.o
>   LD [M]  net/phonet/phonet.o
>   LD [M]  net/phonet/pn_pep.o
>   CC [M]  net/rds/threads.o
>   CC [M]  net/ipv6/xfrm6_policy.o
>   CC [M]  drivers/infiniband/core/sa_query.o
>   CC [M]  net/rfkill/input.o
>   CC [M]  drivers/gpu/drm/radeon/r600_blit.o
>   CC      drivers/input/input.o
>   CC      drivers/input/input-compat.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/mxm/base.o
>   CC      drivers/input/input-mt.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/mxm/mxms.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/mxm/nv50.o
>   CC [M]  net/netfilter/xt_CLASSIFY.o
>   CC [M]  fs/jbd2/checkpoint.o
>   CC [M]  net/netfilter/xt_CONNSECMARK.o
>   CC [M]  net/netfilter/xt_CT.o
>   LD [M]  net/rfkill/rfkill.o
>   CC [M]  net/netfilter/xt_DSCP.o
>   CC [M]  fs/jbd2/revoke.o
>   CC [M]  fs/jbd2/journal.o
>   CC [M]  drivers/hwmon/lm95241.o
>   CC [M]  sound/pci/oxygen/xonar_lib.o
>   CC [M]  sound/pci/oxygen/xonar_pcm179x.o
>   CC [M]  sound/pci/oxygen/xonar_cs43xx.o
>   CC [M]  drivers/infiniband/hw/cxgb3/cxio_resource.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/therm/base.o
>   LD      sound/pci/pcxhr/built-in.o
>   CC [M]  drivers/infiniband/core/multicast.o
>   CC      net/sched/sch_generic.o
>   CC [M]  sound/pci/pcxhr/pcxhr.o
>   CC [M]  sound/pci/pcxhr/pcxhr_hwdep.o
>   CC [M]  sound/pci/pcxhr/pcxhr_mixer.o
>   CC [M]  drivers/hwmon/ltc4215.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/therm/fan.o
>   CC [M]  net/rds/transport.o
>   CC [M]  drivers/infiniband/hw/cxgb4/mem.o
>   CC [M]  net/ipv6/xfrm6_state.o
>   CC [M]  net/ipv6/xfrm6_input.o
>   CC [M]  net/netfilter/xt_HL.o
>   CC [M]  net/ipv6/xfrm6_output.o
>   LD      drivers/infiniband/hw/ipath/built-in.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_cq.o
>   LD      drivers/infiniband/hw/mlx4/built-in.o
>   CC [M]  drivers/infiniband/hw/mlx4/ah.o
>   CC [M]  drivers/gpu/drm/radeon/r600_blit_shaders.o
>   CC [M]  drivers/gpu/drm/radeon/r600_blit_kms.o
>   CC      drivers/input/ff-core.o
>   CC      drivers/input/ff-memless.o
>   CC [M]  drivers/hwmon/ltc4245.o
>   CC [M]  drivers/hwmon/max1619.o
>   CC [M]  drivers/hwmon/max6650.o
>   CC [M]  sound/pci/oxygen/xonar_wm87x6.o
>   LD [M]  drivers/infiniband/hw/cxgb3/iw_cxgb3.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/therm/ic.o
>   CC [M]  sound/pci/oxygen/xonar_hdmi.o
>   CC [M]  net/ipv4/netfilter/iptable_mangle.o
>   CC      net/sched/sch_mq.o
>   CC [M]  drivers/infiniband/core/ucm.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_diag.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_dma.o
>   CC [M]  sound/pci/pcxhr/pcxhr_core.o
>   CC [M]  net/netfilter/xt_LED.o
>   CC [M]  sound/pci/pcxhr/pcxhr_mix22.o
>   CC [M]  drivers/infiniband/hw/mlx4/cq.o
>   CC [M]  net/netfilter/xt_NFLOG.o
>   CC [M]  net/netfilter/xt_NFQUEUE.o
>   CC [M]  net/rds/loop.o
>   CC      drivers/input/mousedev.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_pm.o
>   CC [M]  drivers/gpu/drm/radeon/atombios_dp.o
>   CC [M]  drivers/hwmon/pc87360.o
>   CC [M]  drivers/hwmon/pc87427.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/therm/nv40.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/therm/nv50.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/therm/temp.o
>   CC [M]  net/ipv4/netfilter/iptable_raw.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/timer/base.o
>   CC [M]  drivers/infiniband/hw/cxgb4/cq.o
>   CC      net/sched/sch_api.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_driver.o
>   CC [M]  net/ipv6/netfilter.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_eeprom.o
>   LD [M]  sound/pci/oxygen/snd-oxygen-lib.o
>   LD [M]  sound/pci/oxygen/snd-oxygen.o
>   LD [M]  sound/pci/oxygen/snd-virtuoso.o
>   CC [M]  net/ipv6/fib6_rules.o
>   CC      net/sched/sch_blackhole.o
>   CC [M]  net/ipv4/netfilter/iptable_security.o
>   CC [M]  net/netfilter/xt_RATEEST.o
>   LD [M]  sound/pci/pcxhr/snd-pcxhr.o
>   CC [M]  net/rds/page.o
>   LD      sound/pci/riptide/built-in.o
>   CC [M]  drivers/infiniband/hw/mlx4/doorbell.o
>   CC [M]  drivers/infiniband/core/user_mad.o
>   LD      sound/pci/rme9652/built-in.o
>   CC [M]  sound/pci/rme9652/hdsp.o
>   CC [M]  net/ipv4/netfilter/ipt_ah.o
>   CC [M]  net/ipv4/netfilter/ipt_CLUSTERIP.o
>   CC [M]  drivers/gpu/drm/radeon/r600_audio.o
>   LD [M]  fs/jbd2/jbd2.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/timer/nv04.o
>   LD      fs/jffs2/built-in.o
>   CC [M]  fs/jffs2/compr.o
>   CC [M]  fs/jffs2/dir.o
>   CC [M]  fs/jffs2/file.o
>   CC      drivers/input/evdev.o
>   CC [M]  fs/jffs2/ioctl.o
>   CC [M]  fs/jffs2/nodelist.o
>   CC [M]  drivers/infiniband/hw/mlx4/mad.o
>   CC [M]  fs/jffs2/malloc.o
>   CC [M]  drivers/hwmon/pcf8591.o
>   CC [M]  fs/jffs2/read.o
>   CC [M]  drivers/hwmon/sht15.o
>   CC [M]  fs/jffs2/nodemgmt.o
>   CC      net/sched/cls_api.o
>   LD      net/sctp/built-in.o
>   LD      net/sunrpc/built-in.o
>   CC [M]  net/sctp/sm_statetable.o
>   CC [M]  net/sunrpc/clnt.o
>   CC [M]  net/sunrpc/xprt.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/vm/base.o
>   CC [M]  net/ipv6/proc.o
>   CC [M]  drivers/gpu/drm/radeon/r600_hdmi.o
>   CC [M]  drivers/gpu/drm/radeon/evergreen.o
>   MKREGTABLE drivers/gpu/drm/radeon/evergreen_reg_safe.h
>   CC [M]  drivers/infiniband/hw/ipath/ipath_file_ops.o
>   CC [M]  net/netfilter/xt_SECMARK.o
>   CC [M]  drivers/infiniband/hw/cxgb4/qp.o
>   CC [M]  net/rds/rdma.o
>   CC [M]  drivers/infiniband/hw/cxgb4/resource.o
>   CC [M]  net/ipv4/netfilter/ipt_ECN.o
>   CC [M]  drivers/infiniband/core/uverbs_main.o
>   CC [M]  drivers/infiniband/core/uverbs_cmd.o
>   CC      drivers/input/keyboard/atkbd.o
>   LD      drivers/input/misc/built-in.o
>   CC [M]  drivers/input/misc/apanel.o
>   CC [M]  fs/jffs2/readinode.o
>   CC [M]  drivers/hwmon/sis5595.o
>   CC [M]  net/sctp/sm_statefuns.o
>   CC [M]  net/sctp/sm_sideeffect.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/vm/nv04.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/vm/nv41.o
>   CC [M]  drivers/input/misc/ati_remote2.o
>   CC [M]  net/netfilter/xt_TPROXY.o
>   CC [M]  net/ipv4/netfilter/ipt_REJECT.o
>   CC [M]  net/netfilter/xt_TCPMSS.o
>   CC [M]  net/ipv6/syncookies.o
>   CC      net/sched/act_api.o
>   CC [M]  net/ipv6/ah6.o
>   CC [M]  drivers/input/keyboard/adp5588-keys.o
>   CC [M]  net/rds/rdma_transport.o
>   CC [M]  net/rds/ib.o
>   CC [M]  drivers/infiniband/hw/mlx4/main.o
>   CC [M]  net/rds/ib_cm.o
>   CC [M]  drivers/hwmon/smsc47b397.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/vm/nv44.o
>   CC [M]  fs/jffs2/write.o
>   CC [M]  sound/pci/rme9652/hdspm.o
>   CC [M]  sound/pci/rme9652/rme9652.o
>   CC [M]  drivers/input/misc/atlas_btns.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_fs.o
>   CC [M]  net/sunrpc/socklib.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_init_chip.o
>   CC [M]  drivers/infiniband/core/uverbs_marshall.o
>   CC [M]  drivers/infiniband/core/iwcm.o
>   CC [M]  net/netfilter/xt_TCPOPTSTRIP.o
>   CC [M]  drivers/infiniband/core/cma.o
>   CC [M]  drivers/infiniband/hw/cxgb4/ev.o
>   CC [M]  drivers/infiniband/core/ucma.o
>   CC [M]  net/ipv4/netfilter/ipt_ULOG.o
>   CC [M]  drivers/hwmon/smsc47m1.o
>   CC [M]  drivers/input/keyboard/max7359_keypad.o
>   MKREGTABLE drivers/gpu/drm/radeon/cayman_reg_safe.h
>   CC [M]  net/ipv6/esp6.o
>   CC [M]  drivers/gpu/drm/radeon/evergreen_blit_shaders.o
>   CC [M]  drivers/input/misc/cm109.o
>   CC [M]  fs/jffs2/scan.o
>   CC [M]  drivers/gpu/drm/radeon/evergreen_blit_kms.o
>   CC [M]  fs/jffs2/gc.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/vm/nv50.o
>   CC [M]  drivers/gpu/drm/nouveau/core/subdev/vm/nvc0.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/dmaobj/base.o
>   CC [M]  net/rds/ib_recv.o
>   CC [M]  drivers/input/keyboard/opencores-kbd.o
>   CC      net/sched/sch_fifo.o
>   CC [M]  drivers/infiniband/hw/cxgb4/id_table.o
>   CC [M]  drivers/hwmon/smsc47m192.o
>   CC [M]  net/netfilter/xt_TRACE.o
>   CC [M]  net/sunrpc/xprtsock.o
>   CC [M]  drivers/input/misc/keyspan_remote.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_intr.o
>   CC [M]  drivers/infiniband/hw/mlx4/mr.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_keys.o
>   LD      drivers/input/keyboard/built-in.o
>   CC [M]  drivers/infiniband/hw/mlx4/qp.o
>   CC [M]  net/ipv4/netfilter/arp_tables.o
>   CC [M]  net/sunrpc/sched.o
>   CC [M]  drivers/gpu/drm/radeon/evergreen_hdmi.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_trace_points.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/dmaobj/nv04.o
>   CC [M]  net/ipv6/ipcomp6.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/dmaobj/nv50.o
>   CC [M]  net/sunrpc/auth.o
>   CC [M]  net/sctp/protocol.o
>   CC [M]  net/netfilter/xt_cluster.o
>   CC [M]  drivers/hwmon/thmc50.o
>   CC [M]  net/sctp/endpointola.o
>   CC [M]  fs/jffs2/symlink.o
>   LD [M]  drivers/infiniband/hw/cxgb4/iw_cxgb4.o
>   CC [M]  fs/jffs2/build.o
>   CC [M]  fs/jffs2/erase.o
>   CC [M]  drivers/input/misc/pcspkr.o
>   CC      net/sched/cls_cgroup.o
>   CC      net/sched/ematch.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_mad.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/dmaobj/nvc0.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_mmap.o
>   CC [M]  net/rds/ib_ring.o
>   LD      drivers/infiniband/hw/mthca/built-in.o
>   CC [M]  drivers/infiniband/hw/mthca/mthca_main.o
>   LD [M]  sound/pci/rme9652/snd-rme9652.o
>   LD [M]  sound/pci/rme9652/snd-hdsp.o
>   LD [M]  sound/pci/rme9652/snd-hdspm.o
>   CC [M]  drivers/gpu/drm/radeon/ni.o
>   LD      sound/pci/trident/built-in.o
>   CC [M]  sound/pci/trident/trident.o
>   CC [M]  drivers/input/misc/powermate.o
>   CC [M]  drivers/hwmon/tmp401.o
>   CC [M]  net/ipv6/xfrm6_tunnel.o
>   CC [M]  drivers/hwmon/tmp421.o
>   CC [M]  fs/jffs2/background.o
>   CC [M]  fs/jffs2/fs.o
>   CC [M]  fs/jffs2/writev.o
>   CC [M]  fs/jffs2/super.o
>   CC [M]  net/netfilter/xt_comment.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/dmaobj/nvd0.o
> drivers/infiniband/hw/mlx4/qp.c: In function =E2=80=98build_mlx_header=E2=
=80=99:
> drivers/infiniband/hw/mlx4/qp.c:1752: warning: =E2=80=98vlan=E2=80=99 may=
 be used
> uninitialized in this function CC [M]
> drivers/gpu/drm/nouveau/core/engine/bsp/nv84.o CC [M]
> sound/pci/trident/trident_main.o CC [M]
> sound/pci/trident/trident_memory.o CC [M]
> drivers/gpu/drm/nouveau/core/engine/bsp/nvc0.o CC [M]
> net/rds/ib_send.o CC [M]  net/rds/ib_stats.o
>   CC [M]  drivers/input/misc/rotary_encoder.o
>   CC [M]  drivers/infiniband/hw/mthca/mthca_cmd.o
>   CC [M]  net/sctp/associola.o
>   CC [M]  net/sctp/transport.o
>   CC [M]  drivers/hwmon/via-cputemp.o
>   CC [M]  drivers/hwmon/via686a.o
>   CC [M]  net/sched/act_police.o
>   CC [M]  net/ipv4/netfilter/arpt_mangle.o
>   LD [M]  drivers/infiniband/core/ib_core.o
>   LD [M]  drivers/infiniband/core/ib_mad.o
>   LD [M]  drivers/infiniband/core/ib_sa.o
>   CC [M]  net/ipv4/netfilter/arptable_filter.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_mr.o
>   CC [M]  net/sunrpc/auth_null.o
>   LD [M]  drivers/infiniband/core/ib_cm.o
>   CC      net/unix/af_unix.o
>   LD [M]  drivers/infiniband/core/iw_cm.o
>   CC [M]  fs/jffs2/debug.o
>   LD [M]  drivers/infiniband/core/ib_addr.o
>   LD [M]  drivers/infiniband/core/rdma_cm.o
>   CC [M]  net/netfilter/xt_connbytes.o
>   LD [M]  drivers/infiniband/core/ib_umad.o
>   LD [M]  drivers/infiniband/core/ib_uverbs.o
>   LD [M]  drivers/infiniband/core/ib_ucm.o
>   CC [M]  net/netfilter/xt_connlimit.o
>   LD [M]  drivers/infiniband/core/rdma_ucm.o
>   CC [M]  net/netfilter/xt_conntrack.o
>   CC [M]  fs/jffs2/wbuf.o
>   CC [M]  drivers/input/misc/uinput.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/bsp/nve0.o
>   CC [M]  fs/jffs2/xattr.o
>   CC [M]  net/ipv6/tunnel6.o
>   CC [M]  net/ipv6/xfrm6_mode_transport.o
>   CC [M]  drivers/infiniband/hw/mlx4/srq.o
>   CC [M]  drivers/gpu/drm/radeon/cayman_blit_shaders.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_qp.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_rc.o
>   CC [M]  drivers/gpu/drm/radeon/atombios_encoders.o
>   CC [M]  drivers/gpu/drm/drm_lock.o
>   CC [M]  drivers/hwmon/vt1211.o
>   CC [M]  drivers/hwmon/vt8231.o
>   LD [M]  net/ipv4/netfilter/nf_conntrack_ipv4.o
>   CC      net/ipv4/tcp_cubic.o
>   CC [M]  net/sunrpc/auth_unix.o
>   CC [M]  net/sunrpc/auth_generic.o
>   CC [M]  net/sched/act_gact.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/copy/nva3.o
>   CC [M]  net/rds/ib_sysctl.o
>   CC [M]  net/rds/ib_rdma.o
>   CC [M]  drivers/input/misc/yealink.o
>   CC [M]  net/netfilter/xt_dccp.o
>   CC [M]  net/sctp/chunk.o
> net/unix/af_unix.c: In function =E2=80=98unix_bind=E2=80=99:
> net/unix/af_unix.c:894: warning: =E2=80=98path.dentry=E2=80=99 may be used
> uninitialized in this function net/unix/af_unix.c:894: warning:
> =E2=80=98path.mnt=E2=80=99 may be used uninitialized in this function CC =
[M]
> drivers/infiniband/hw/mthca/mthca_profile.o CC [M]
> net/sctp/sm_make_chunk.o CC [M]  drivers/infiniband/hw/mlx4/mcg.o
>   CC [M]  net/sctp/ulpevent.o
>   CC [M]  fs/jffs2/xattr_trusted.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/copy/nvc0.o
>   CC [M]  net/sched/act_mirred.o
>   CC [M]  net/ipv6/xfrm6_mode_tunnel.o
>   CC [M]  net/sched/act_ipt.o
>   CC [M]  drivers/infiniband/hw/mthca/mthca_reset.o
>   LD      sound/pci/vx222/built-in.o
>   CC [M]  sound/pci/vx222/vx222.o
>   LD [M]  sound/pci/trident/snd-trident.o
>   CC [M]  sound/pci/vx222/vx222_ops.o
>   CC [M]  drivers/infiniband/hw/mthca/mthca_allocator.o
>   CC [M]  drivers/hwmon/w83627ehf.o
>   CC [M]  drivers/infiniband/hw/mthca/mthca_eq.o
>   CC      drivers/input/serio/serio.o
>   CC      net/ipv4/cipso_ipv4.o
>   CC [M]  net/netfilter/xt_dscp.o
>   CC [M]  fs/jffs2/xattr_user.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_ruc.o
>   CC [M]  fs/jffs2/security.o
>   CC [M]  net/sunrpc/svc.o
>   CC      drivers/input/mouse/psmouse-base.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/copy/nve0.o
>   CC [M]  net/rds/iw.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/crypt/nv84.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/crypt/nv98.o
>   CC [M]  drivers/infiniband/hw/mlx4/cm.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_semaphore.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/disp/nv04.o
>   CC      net/unix/garbage.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/disp/nv50.o
>   CC      net/unix/sysctl_net_unix.o
>   CC [M]  drivers/gpu/drm/drm_memory.o
>   CC [M]  net/sched/act_nat.o
>   CC [M]  fs/jffs2/acl.o
>   LD [M]  sound/pci/vx222/snd-vx222.o
>   CC [M]  net/ipv6/xfrm6_mode_ro.o
>   LD      sound/pci/ymfpci/built-in.o
>   LD [M]  sound/pci/snd-ad1889.o
>   LD [M]  sound/pci/snd-atiixp.o
>   LD [M]  sound/pci/snd-atiixp-modem.o
>   LD [M]  sound/pci/snd-bt87x.o
>   CC [M]  drivers/infiniband/hw/mthca/mthca_pd.o
>   LD [M]  sound/pci/snd-cmipci.o
>   LD [M]  sound/pci/snd-cs5530.o
>   CC [M]  drivers/infiniband/hw/mthca/mthca_cq.o
>   LD [M]  sound/pci/snd-ens1370.o
>   CC [M]  net/netfilter/xt_ecn.o
> net/sunrpc/svc.c: In function =E2=80=98svc_printk=E2=80=99:
> net/sunrpc/svc.c:1041: warning: unused variable =E2=80=98buf=E2=80=99
>   LD [M]  sound/pci/snd-ens1371.o
>   LD [M]  sound/pci/snd-es1968.o
>   LD [M]  sound/pci/snd-intel8x0.o
>   LD [M]  sound/pci/snd-intel8x0m.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_sdma.o
>   LD [M]  sound/pci/snd-maestro3.o
>   LD [M]  sound/pci/snd-rme32.o
>   LD [M]  sound/pci/snd-rme96.o
>   LD [M]  sound/pci/snd-via82xx.o
>   LD [M]  sound/pci/snd-via82xx-modem.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_srq.o
>   CC      drivers/input/serio/i8042.o
>   CC      net/ipv4/xfrm4_policy.o
>   CC [M]  drivers/infiniband/hw/mlx4/alias_GUID.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_stats.o
>   CC [M]  net/sched/act_pedit.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_sa.o
>   CC [M]  net/rds/iw_cm.o
>   CC [M]  net/rds/iw_recv.o
>   CC [M]  net/netfilter/xt_esp.o
>   CC      drivers/input/mouse/synaptics.o
>   CC [M]  fs/jffs2/compr_rtime.o
>   CC [M]  net/sctp/inqueue.o
>   LD      net/unix/unix.o
>   LD      net/unix/built-in.o
>   CC [M]  net/sctp/outqueue.o
>   CC [M]  net/ipv6/xfrm6_mode_beet.o
>   CC [M]  net/sctp/ulpqueue.o
>   CC [M]  net/ipv6/mip6.o
>   CC [M]  drivers/gpu/drm/radeon/atombios_i2c.o
>   CC [M]  drivers/hwmon/w83l785ts.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/disp/nv84.o
>   CC [M]  drivers/hwmon/w83l786ng.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/disp/nv94.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/disp/nva0.o
>   CC [M]  drivers/infiniband/hw/mthca/mthca_mr.o
>   CC [M]  fs/jffs2/compr_zlib.o
>   CC [M]  net/sunrpc/svcsock.o
>   CC [M]  net/sched/act_simple.o
>   CC [M]  drivers/infiniband/hw/mlx4/sysfs.o
>   CC      net/ipv4/xfrm4_state.o
>   CC [M]  net/netfilter/xt_hashlimit.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_sysfs.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_uc.o
>   CC      drivers/input/serio/serport.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_ud.o
>   CC      drivers/input/mouse/alps.o
>   CC      drivers/input/mouse/elantech.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_user_pages.o
>   CC      drivers/input/mouse/logips2pp.o
>   CC [M]  fs/jffs2/summary.o
>   CC [M]  net/rds/iw_ring.o
>   CC [M]  drivers/gpu/drm/radeon/si.o
>   CC [M]  net/rds/iw_send.o
>   CC [M]  drivers/gpu/drm/radeon/si_blit_shaders.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/disp/nva3.o
>   LD      drivers/hwmon/built-in.o
>   CC [M]  net/rds/iw_stats.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/disp/nvd0.o
>   CC [M]  net/ipv6/sit.o
>   CC      drivers/input/serio/libps2.o
>   CC [M]  drivers/infiniband/hw/mthca/mthca_qp.o
>   CC [M]  drivers/infiniband/hw/mthca/mthca_av.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/disp/nve0.o
>   LD [M]  drivers/infiniband/hw/mlx4/mlx4_ib.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/disp/dacnv50.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/disp/hdanva3.o
>   CC      drivers/input/mouse/lifebook.o
>   CC [M]  net/sched/act_skbedit.o
>   CC      net/ipv4/xfrm4_input.o
>   CC      net/ipv4/xfrm4_output.o
>   CC [M]  net/sched/sch_cbq.o
>   CC [M]  net/sctp/command.o
>   LD [M]  fs/jffs2/jffs2.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_user_sdma.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_verbs_mcast.o
>   LD      fs/lockd/built-in.o
>   CC [M]  fs/lockd/clntlock.o
>   CC [M]  fs/lockd/clntproc.o
>   CC [M]  fs/lockd/clntxdr.o
>   CC [M]  fs/lockd/host.o
>   CC [M]  fs/lockd/svc.o
>   CC      drivers/input/mouse/sentelic.o
>   CC [M]  net/netfilter/xt_helper.o
>   CC      drivers/input/mouse/trackpoint.o
>   CC [M]  drivers/input/mouse/appletouch.o
>   CC [M]  drivers/input/mouse/bcm5974.o
>   CC [M]  drivers/input/serio/serio_raw.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/disp/hdanvd0.o
>   CC [M]  net/rds/iw_sysctl.o
>   CC [M]  net/sunrpc/svcauth.o
>   LD      fs/nfs/built-in.o
>   CC [M]  fs/nfs/client.o
>   CC [M]  fs/nfs/dir.o
>   CC [M]  net/sctp/tsnmap.o
>   CC [M]  fs/nfs/file.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/disp/hdminv84.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_verbs.o
>   CC [M]  net/ipv4/ipip.o
>   CC [M]  net/ipv4/ip_gre.o
>   CC [M]  net/ipv4/ah4.o
>   CC [M]  net/ipv6/ip6_tunnel.o
>   CC [M]  net/ipv4/esp4.o
>   CC [M]  net/ipv4/ipcomp.o
>   CC [M]  net/netfilter/xt_hl.o
>   CC [M]  drivers/input/mouse/sermouse.o
>   LD      drivers/input/serio/built-in.o
>   CC [M]  drivers/input/mouse/synaptics_i2c.o
>   CC [M]  net/sunrpc/svcauth_unix.o
>   LD      fs/nfs_common/built-in.o
>   CC [M]  fs/nfs_common/nfsacl.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_prime.o
>   CC [M]  net/rds/iw_rdma.o
>   CC [M]  drivers/infiniband/hw/mthca/mthca_mcg.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/disp/hdminva3.o
>   CC [M]  net/sched/sch_htb.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_ioc32.o
>   CC [M]  net/sctp/bind_addr.o
>   CC [M]  net/sctp/socket.o
>   CC [M]  fs/lockd/svclock.o
>   CC [M]  fs/lockd/svcshare.o
>   CC [M]  drivers/input/mouse/vsxxxaa.o
>   CC [M]  net/netfilter/xt_iprange.o
>   CC [M]  net/netfilter/xt_length.o
>   CC [M]  drivers/infiniband/hw/mthca/mthca_mad.o
>   LD [M]  fs/nfs_common/nfs_acl.o
>   CC [M]  net/netfilter/xt_limit.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/disp/hdminvd0.o
>   LD      drivers/infiniband/hw/nes/built-in.o
>   CC [M]  drivers/infiniband/hw/nes/nes.o
>   CC [M]  drivers/infiniband/hw/nes/nes_hw.o
>   CC [M]  drivers/infiniband/hw/nes/nes_nic.o
>   LD      drivers/input/mouse/psmouse.o
>   LD      drivers/input/mouse/built-in.o
>   LD      drivers/infiniband/hw/ocrdma/built-in.o
>   LD      drivers/input/tablet/built-in.o
>   CC [M]  drivers/infiniband/hw/ocrdma/ocrdma_main.o
>   CC [M]  drivers/input/tablet/acecad.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_atpx_handler.o
>   CC [M]  drivers/infiniband/hw/mthca/mthca_provider.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_iba6110.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/disp/sornv50.o
>   CC [M]  drivers/infiniband/hw/ipath/ipath_wc_x86_64.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/disp/sornv94.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/disp/sornvd0.o
>   CC [M]  net/rds/tcp.o
>   CC [M]  net/rds/tcp_connect.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/disp/vga.o
>   CC [M]  net/ipv4/xfrm4_tunnel.o
>   CC [M]  net/ipv4/xfrm4_mode_beet.o
>   CC [M]  net/netfilter/xt_mac.o
>   CC [M]  net/sunrpc/addr.o
>   CC [M]  fs/nfs/getroot.o
>   CC [M]  fs/lockd/svcproc.o
>   CC [M]  net/sched/sch_hfsc.o
>   CC [M]  drivers/input/tablet/aiptek.o
>   LD      net/ipv6/built-in.o
>   LD [M]  net/ipv6/ipv6.o
>   CC [M]  drivers/gpu/drm/radeon/radeon_acpi.o
>   CC [M]  net/sched/sch_red.o
>   CC [M]  drivers/input/tablet/gtco.o
>   CC [M]  drivers/input/tablet/kbtab.o
>   CC [M]  net/sched/sch_gred.o
>   CC [M]  net/sched/sch_ingress.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/fifo/base.o
>   CC [M]  net/sched/sch_dsmark.o
>   CC [M]  net/sched/sch_sfq.o
>   LD [M]  drivers/infiniband/hw/ipath/ib_ipath.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/fifo/nv04.o
>   CC [M]  drivers/infiniband/hw/ocrdma/ocrdma_verbs.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/fifo/nv10.o
>   CC [M]  net/ipv4/tunnel4.o
>   CC [M]  fs/nfs/inode.o
>   CC [M]  net/netfilter/xt_multiport.o
>   CC [M]  net/netfilter/xt_osf.o
>   CC [M]  drivers/infiniband/hw/mthca/mthca_memfree.o
>   CC [M]  fs/lockd/svcsubs.o
>   CC [M]  net/rds/tcp_listen.o
>   CC [M]  net/rds/tcp_recv.o
>   CC [M]  net/sunrpc/rpcb_clnt.o
>   CC [M]  net/rds/tcp_send.o
>   MKREGTABLE drivers/gpu/drm/radeon/r100_reg_safe.h
>   CC [M]  drivers/input/tablet/wacom_wac.o
>   MKREGTABLE drivers/gpu/drm/radeon/rn50_reg_safe.h
>   MKREGTABLE drivers/gpu/drm/radeon/r300_reg_safe.h
>   MKREGTABLE drivers/gpu/drm/radeon/r420_reg_safe.h
>   CC [M]  drivers/gpu/drm/radeon/rs600.o
>   CC [M]  drivers/input/tablet/wacom_sys.o
>   CC [M]  drivers/gpu/drm/drm_proc.o
>   CC [M]  drivers/infiniband/hw/ocrdma/ocrdma_hw.o
>   CC [M]  drivers/infiniband/hw/ocrdma/ocrdma_ah.o
>   CC [M]  drivers/gpu/drm/drm_stub.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/fifo/nv17.o
>   CC [M]  drivers/gpu/drm/drm_vm.o
>   CC [M]  drivers/gpu/drm/drm_agpsupport.o
>   CC [M]  drivers/gpu/drm/drm_scatter.o
>   CC [M]  net/netfilter/xt_owner.o
>   CC [M]  net/sched/sch_tbf.o
>   CC [M]  drivers/infiniband/hw/mthca/mthca_uar.o
>   CC [M]  net/netfilter/xt_physdev.o
>   CC [M]  drivers/infiniband/hw/mthca/mthca_srq.o
>   CC [M]  drivers/infiniband/hw/mthca/mthca_catas.o
>   CC [M]  net/ipv4/xfrm4_mode_transport.o
>   CC [M]  net/rds/tcp_stats.o
>   CC [M]  drivers/infiniband/hw/nes/nes_utils.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/fifo/nv40.o
>   CC [M]  drivers/infiniband/hw/nes/nes_verbs.o
>   CC [M]  drivers/infiniband/hw/nes/nes_cm.o
>   CC [M]  drivers/gpu/drm/radeon/rv515.o
>   CC [M]  fs/lockd/mon.o
>   CC [M]  drivers/infiniband/hw/nes/nes_mgt.o
>   CC [M]  net/sctp/primitive.o
>   LD [M]  drivers/input/tablet/wacom.o
>   LD      drivers/input/touchscreen/built-in.o
>   CC [M]  drivers/input/input-polldev.o
>   CC [M]  drivers/input/touchscreen/ad7879.o
>   CC [M]  drivers/input/touchscreen/ad7879-i2c.o
>   CC [M]  drivers/input/touchscreen/gunze.o
>   CC [M]  drivers/input/touchscreen/eeti_ts.o
>   CC [M]  drivers/input/touchscreen/elo.o
>   CC [M]  net/netfilter/xt_pkttype.o
>   CC [M]  net/sunrpc/timer.o
>   CC [M]  net/ipv4/xfrm4_mode_tunnel.o
>   CC [M]  net/sched/sch_teql.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/fifo/nv50.o
>   LD [M]  net/rds/rds.o
>   LD [M]  net/rds/rds_rdma.o
>   LD [M]  net/rds/rds_tcp.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/fifo/nv84.o
>   CC [M]  drivers/gpu/drm/drm_pci.o
>   CC [M]  drivers/gpu/drm/drm_platform.o
>   LD [M]  drivers/infiniband/hw/mthca/ib_mthca.o
>   CC [M]  drivers/gpu/drm/drm_sysfs.o
>   CC [M]  fs/nfs/super.o
>   CC [M]  fs/nfs/direct.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/fifo/nvc0.o
>   LD      fs/nfsd/built-in.o
>   CC [M]  fs/nfsd/nfssvc.o
>   CC [M]  fs/nfsd/nfsctl.o
>   CC [M]  fs/lockd/xdr.o
>   CC [M]  fs/nfsd/nfsproc.o
>   CC [M]  drivers/input/touchscreen/fujitsu_ts.o
>   LD [M]  drivers/infiniband/hw/ocrdma/ocrdma.o
>   CC [M]  net/netfilter/xt_policy.o
>   CC [M]  net/sctp/output.o
>   CC [M]  net/sctp/input.o
>   LD      drivers/infiniband/hw/qib/built-in.o
>   CC [M]  drivers/infiniband/hw/qib/qib_cq.o
>   CC [M]  drivers/gpu/drm/radeon/r200.o
>   CC [M]  drivers/infiniband/hw/qib/qib_diag.o
>   CC [M]  drivers/input/sparse-keymap.o
>   CC [M]  drivers/input/touchscreen/inexio.o
>   CC [M]  net/sunrpc/xdr.o
>   CC [M]  net/sunrpc/sunrpc_syms.o
>   CC [M]  net/sched/sch_prio.o
>   CC [M]  net/sched/sch_multiq.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/fifo/nve0.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/graph/ctxnv40.o
>   CC [M]  net/sched/sch_atm.o
>   CC [M]  net/sched/sch_netem.o
>   CC [M]  net/sctp/debug.o
>   CC [M]  net/ipv4/inet_diag.o
>   CC [M]  net/ipv4/tcp_diag.o
>   CC [M]  drivers/input/touchscreen/mcs5000_ts.o
>   CC [M]  net/netfilter/xt_quota.o
>   CC [M]  fs/lockd/grace.o
>   CC [M]  fs/lockd/clnt4xdr.o
>   CC [M]  fs/lockd/xdr4.o
>   CC [M]  fs/lockd/svc4proc.o
>   CC [M]  drivers/infiniband/hw/qib/qib_dma.o
>   CC [M]  drivers/gpu/drm/radeon/r600_cs.o
>   CC [M]  fs/nfsd/nfsfh.o
>   CC [M]  drivers/input/touchscreen/mtouch.o
>   CC [M]  drivers/input/touchscreen/usbtouchscreen.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/graph/ctxnv50.o
>   CC [M]  drivers/input/touchscreen/penmount.o
>   CC [M]  drivers/input/touchscreen/touchit213.o
>   CC [M]  drivers/input/touchscreen/touchright.o
>   CC [M]  net/sctp/ssnmap.o
>   CC [M]  net/sctp/auth.o
>   CC [M]  net/netfilter/xt_rateest.o
>   CC [M]  drivers/infiniband/hw/qib/qib_driver.o
>   CC [M]  net/netfilter/xt_realm.o
>   CC [M]  drivers/infiniband/hw/qib/qib_eeprom.o
>   CC [M]  net/sunrpc/cache.o
>   CC [M]  net/sunrpc/rpc_pipe.o
>   CC [M]  drivers/infiniband/hw/qib/qib_file_ops.o
>   LD [M]  drivers/infiniband/hw/nes/iw_nes.o
>   CC [M]  drivers/infiniband/hw/qib/qib_fs.o
>   CC [M]  drivers/infiniband/hw/qib/qib_init.o
>   CC [M]  net/sunrpc/svc_xprt.o
>   CC [M]  net/sunrpc/backchannel_rqst.o
>   CC [M]  drivers/infiniband/hw/qib/qib_intr.o
>   CC [M]  fs/nfs/pagelist.o
>   CC [M]  fs/nfsd/vfs.o
>   CC [M]  fs/nfs/read.o
>   CC [M]  net/sched/sch_drr.o
>   LD [M]  fs/lockd/lockd.o
>   CC [M]  net/sched/sch_mqprio.o
>   CC [M]  net/sched/sch_qfq.o
>   CC [M]  net/sched/cls_u32.o
>   CC [M]  drivers/input/touchscreen/touchwin.o
>   CC [M]  drivers/input/touchscreen/tsc2007.o
>   CC [M]  net/netfilter/xt_recent.o
>   CC [M]  drivers/input/touchscreen/wacom_w8001.o
>   CC [M]  net/sched/cls_route.o
>   CC [M]  net/sctp/proc.o
>   CC [M]  net/sctp/sysctl.o
>   CC [M]  net/sctp/ipv6.o
>   CC [M]  net/ipv4/tcp_bic.o
>   CC [M]  net/ipv4/tcp_westwood.o
>   CC [M]  net/ipv4/tcp_highspeed.o
>   CC [M]  net/ipv4/tcp_hybla.o
>   CC [M]  drivers/gpu/drm/radeon/evergreen_cs.o
>   CC [M]  net/ipv4/tcp_htcp.o
>   CC [M]  net/ipv4/tcp_vegas.o
>   CC [M]  drivers/input/joydev.o
>   CC [M]  net/ipv4/tcp_veno.o
>   LD      drivers/input/input-core.o
>   CC [M]  net/ipv4/tcp_scalable.o
>   CC [M]  net/ipv4/tcp_lp.o
>   CC [M]  drivers/infiniband/hw/qib/qib_keys.o
>   CC [M]  net/netfilter/xt_sctp.o
>   CC [M]  net/netfilter/xt_socket.o
>   CC [M]  drivers/infiniband/hw/qib/qib_mad.o
>   CC [M]  drivers/infiniband/hw/qib/qib_mmap.o
>   CC [M]  net/netfilter/xt_state.o
>   CC [M]  net/sunrpc/bc_svc.o
>   CC [M]  fs/nfs/symlink.o
>   CC [M]  fs/nfs/unlink.o
>   LD      drivers/input/built-in.o
>   CC      fs/nls/nls_base.o
>   CC      fs/nls/nls_cp437.o
>   CC [M]  fs/nfsd/export.o
>   CC [M]  net/sched/cls_fw.o
>   LD [M]  net/sctp/sctp.o
>   CC [M]  net/sched/cls_rsvp.o
>   CC [M]  net/sched/cls_tcindex.o
>   CC [M]  net/sched/cls_rsvp6.o
>   CC [M]  net/sched/cls_basic.o
>   CC [M]  fs/nfsd/auth.o
>   CC [M]  fs/nfsd/lockd.o
>   CC [M]  fs/nfsd/nfscache.o
>   CC [M]  net/sunrpc/stats.o
>   CC [M]  fs/nfsd/nfsxdr.o
>   CC [M]  fs/nfsd/stats.o
>   LD      drivers/infiniband/ulp/ipoib/built-in.o
>   CC [M]  drivers/infiniband/ulp/ipoib/ipoib_main.o
>   CC      fs/nls/nls_ascii.o
>   CC [M]  net/ipv4/tcp_yeah.o
>   LD      drivers/infiniband/ulp/iser/built-in.o
>   CC [M]  drivers/infiniband/ulp/iser/iser_verbs.o
>   CC [M]  drivers/infiniband/ulp/iser/iser_initiator.o
>   CC [M]  drivers/infiniband/ulp/iser/iser_memory.o
>   CC [M]  drivers/infiniband/ulp/iser/iscsi_iser.o
>   CC [M]  fs/nfsd/nfs2acl.o
>   CC [M]  net/sunrpc/sysctl.o
>   CC [M]  fs/nls/nls_cp737.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/graph/ctxnvc0.o
>   CC [M]  fs/nls/nls_cp775.o
>   CC [M]  fs/nfs/write.o
>   CC [M]  fs/nfs/namespace.o
>   CC [M]  fs/nfs/mount_clnt.o
>   CC [M]  net/netfilter/xt_statistic.o
>   CC [M]  net/netfilter/xt_string.o
>   CC [M]  fs/nfs/dns_resolve.o
>   CC [M]  fs/nfs/cache_lib.o
>   CC [M]  net/netfilter/xt_tcpmss.o
>   CC [M]  fs/nls/nls_cp850.o
>   CC [M]  fs/nls/nls_cp852.o
>   CC [M]  net/sched/cls_flow.o
>   CC [M]  net/ipv4/tcp_illinois.o
>   CC [M]  drivers/gpu/drm/drm_hashtab.o
>   CC [M]  net/sched/em_cmp.o
>   CC      fs/notify/fsnotify.o
>   CC [M]  fs/nls/nls_cp855.o
>   CC [M]  fs/nfsd/nfs3proc.o
>   CC [M]  drivers/infiniband/hw/qib/qib_mr.o
>   CC [M]  drivers/gpu/drm/radeon/r100.o
>   LD      net/sunrpc/auth_gss/built-in.o
>   LD      net/sunrpc/xprtrdma/built-in.o
>   CC [M]  net/sunrpc/auth_gss/auth_gss.o
>   CC [M]  net/sunrpc/xprtrdma/svc_rdma.o
>   CC [M]  net/sunrpc/xprtrdma/svc_rdma_transport.o
>   CC [M]  net/sunrpc/auth_gss/gss_generic_token.o
>   CC [M]  net/sunrpc/xprtrdma/svc_rdma_marshal.o
>   CC [M]  net/sunrpc/xprtrdma/svc_rdma_sendto.o
>   LD [M]  drivers/infiniband/ulp/iser/ib_iser.o
>   CC [M]  fs/nls/nls_cp857.o
>   CC [M]  net/sunrpc/xprtrdma/svc_rdma_recvfrom.o
>   CC [M]  net/sunrpc/xprtrdma/transport.o
>   CC [M]  net/sunrpc/xprtrdma/rpc_rdma.o
>   CC [M]  fs/nls/nls_cp860.o
>   CC [M]  net/sunrpc/xprtrdma/verbs.o
>   CC [M]  drivers/infiniband/ulp/ipoib/ipoib_ib.o
>   CC [M]  drivers/gpu/drm/drm_mm.o
>   LD      net/ipv4/built-in.o
>   CC [M]  fs/nfsd/nfs3xdr.o
>   CC [M]  net/netfilter/xt_time.o
>   CC [M]  net/netfilter/xt_u32.o
>   CC      fs/notify/notification.o
>   CC [M]  drivers/infiniband/hw/qib/qib_pcie.o
>   CC [M]  drivers/infiniband/hw/qib/qib_pio_copy.o
>   CC [M]  fs/nls/nls_cp861.o
>   CC [M]  drivers/infiniband/hw/qib/qib_qp.o
>   CC [M]  net/sched/em_nbyte.o
>   CC [M]  net/sched/em_u32.o
>   CC      fs/notify/group.o
>   LD      drivers/infiniband/ulp/srp/built-in.o
>   CC [M]  drivers/infiniband/ulp/srp/ib_srp.o
>   CC [M]  fs/nls/nls_cp862.o
>   CC [M]  drivers/infiniband/hw/qib/qib_qsfp.o
>   CC [M]  drivers/infiniband/hw/qib/qib_rc.o
>   LD      net/wimax/built-in.o
>   CC [M]  net/wimax/id-table.o
>   CC      net/wireless/wext-core.o
>   CC      net/xfrm/xfrm_policy.o
>   CC      net/xfrm/xfrm_state.o
>   CC      net/wireless/wext-proc.o
>   CC      net/xfrm/xfrm_hash.o
>   CC [M]  fs/nls/nls_cp863.o
>   LD      net/netfilter/ipset/built-in.o
>   CC [M]  net/netfilter/ipset/ip_set_core.o
>   CC      fs/notify/inode_mark.o
>   CC [M]  fs/nfs/sysctl.o
>   CC [M]  net/sunrpc/auth_gss/gss_mech_switch.o
>   CC [M]  net/sunrpc/auth_gss/svcauth_gss.o
>   CC [M]  net/sched/em_meta.o
>   CC [M]  net/sched/em_text.o
>   CC [M]  fs/nls/nls_cp864.o
>   CC [M]  net/sunrpc/auth_gss/gss_krb5_mech.o
>   CC [M]  fs/nls/nls_cp865.o
>   CC [M]  fs/nfsd/nfs3acl.o
>   CC [M]  fs/nls/nls_cp866.o
>   CC [M]  fs/nls/nls_cp869.o
>   CC [M]  drivers/infiniband/ulp/ipoib/ipoib_multicast.o
>   CC [M]  drivers/gpu/drm/drm_crtc.o
>   CC      fs/notify/mark.o
>   CC [M]  net/wimax/op-msg.o
>   CC [M]  net/wimax/op-reset.o
>   LD [M]  net/sunrpc/xprtrdma/xprtrdma.o
>   CC      fs/proc/mmu.o
>   LD [M]  net/sunrpc/xprtrdma/svcrdma.o
>   CC      fs/proc/task_mmu.o
>   LD [M]  net/sunrpc/sunrpc.o
>   CC      fs/proc/inode.o
>   CC [M]  fs/nfs/fscache.o
>   CC [M]  fs/nls/nls_cp874.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/graph/ctxnve0.o
>   CC [M]  fs/nfsd/nfs4proc.o
>   CC [M]  fs/nfsd/nfs4xdr.o
>   CC      fs/notify/vfsmount_mark.o
>   CC [M]  fs/nls/nls_cp932.o
>   CC      net/wireless/wext-spy.o
>   CC [M]  fs/nls/nls_euc-jp.o
>   CC [M]  drivers/infiniband/hw/qib/qib_ruc.o
>   CC      net/wireless/wext-priv.o
>   CC [M]  drivers/gpu/drm/radeon/r300.o
>   CC [M]  net/wireless/core.o
>   CC [M]  drivers/gpu/drm/radeon/r420.o
>   CC [M]  net/wireless/sysfs.o
>   LD      net/sched/built-in.o
>   CC      fs/notify/fdinfo.o
>   CC      fs/notify/dnotify/dnotify.o
>   LD      fs/notify/fanotify/built-in.o
>   CC [M]  drivers/gpu/drm/drm_modes.o
>   CC [M]  drivers/gpu/drm/drm_edid.o
>   CC [M]  fs/nls/nls_cp936.o
>   CC [M]  net/sunrpc/auth_gss/gss_krb5_seal.o
>   CC [M]  net/wimax/op-rfkill.o
>   CC [M]  drivers/infiniband/ulp/ipoib/ipoib_verbs.o
>   CC      fs/proc/root.o
>   CC [M]  drivers/infiniband/ulp/ipoib/ipoib_vlan.o
>   CC [M]  net/netfilter/ipset/ip_set_getport.o
>   CC [M]  drivers/infiniband/ulp/ipoib/ipoib_ethtool.o
>   LD      fs/notify/dnotify/built-in.o
>   CC [M]  drivers/infiniband/hw/qib/qib_sdma.o
>   CC      fs/notify/inotify/inotify_fsnotify.o
>   CC      fs/notify/inotify/inotify_user.o
>   CC [M]  drivers/infiniband/hw/qib/qib_srq.o
>   CC [M]  net/sunrpc/auth_gss/gss_krb5_unseal.o
>   CC [M]  net/sunrpc/auth_gss/gss_krb5_seqnum.o
>   CC [M]  fs/nfs/fscache-index.o
>   CC [M]  net/sunrpc/auth_gss/gss_krb5_wrap.o
>   CC [M]  fs/nls/nls_cp949.o
>   CC [M]  fs/nls/nls_cp950.o
>   LD [M]  drivers/gpu/drm/radeon/radeon.o
>   CC [M]  fs/nls/nls_cp1250.o
>   CC [M]  net/sunrpc/auth_gss/gss_krb5_crypto.o
>   CC      fs/proc/base.o
>   CC [M]  fs/nls/nls_cp1251.o
>   CC [M]  net/netfilter/ipset/pfxlen.o
>   CC [M]  net/netfilter/ipset/ip_set_bitmap_ip.o
>   CC [M]  drivers/infiniband/ulp/ipoib/ipoib_netlink.o
>   CC [M]  net/netfilter/ipset/ip_set_bitmap_ipmac.o
>   CC [M]  net/netfilter/ipset/ip_set_bitmap_port.o
>   LD      fs/notify/inotify/built-in.o
>   LD      fs/notify/built-in.o
>   CC [M]  net/netfilter/ipset/ip_set_hash_ip.o
>   CC [M]  fs/nls/nls_iso8859-1.o
>   LD      net/netfilter/ipvs/built-in.o
>   CC [M]  net/netfilter/ipvs/ip_vs_conn.o
>   CC [M]  net/netfilter/ipvs/ip_vs_core.o
>   CC [M]  net/wimax/op-state-get.o
>   CC [M]  net/netfilter/ipvs/ip_vs_ctl.o
>   CC [M]  net/wimax/stack.o
>   CC      fs/proc/generic.o
>   CC [M]  drivers/infiniband/hw/qib/qib_sysfs.o
>   CC      fs/proc/array.o
>   CC [M]  net/wimax/debugfs.o
>   CC [M]  fs/nfs/nfs4filelayout.o
>   CC [M]  net/wireless/radiotap.o
>   CC [M]  fs/nls/nls_iso8859-2.o
>   CC      net/xfrm/xfrm_input.o
>   CC [M]  drivers/infiniband/ulp/ipoib/ipoib_cm.o
>   CC [M]  net/sunrpc/auth_gss/gss_krb5_keys.o
>   CC [M]  fs/nls/nls_iso8859-3.o
>   CC [M]  fs/nls/nls_iso8859-4.o
>   CC [M]  fs/nls/nls_iso8859-5.o
>   CC [M]  fs/nls/nls_iso8859-6.o
>   CC [M]  fs/nls/nls_iso8859-7.o
>   CC [M]  fs/nfsd/nfs4state.o
>   CC [M]  drivers/infiniband/hw/qib/qib_twsi.o
>   CC [M]  drivers/infiniband/hw/qib/qib_tx.o
>   CC [M]  fs/nfsd/nfs4idmap.o
>   CC [M]  fs/nfsd/nfs4acl.o
>   CC      drivers/iommu/iommu.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/graph/nv04.o
>   LD [M]  net/sunrpc/auth_gss/auth_rpcgss.o
>   LD [M]  net/sunrpc/auth_gss/rpcsec_gss_krb5.o
>   CC      fs/pstore/inode.o
>   CC      fs/quota/dquot.o
>   CC      fs/quota/quota_v2.o
>   CC      fs/quota/quota_tree.o
>   CC [M]  fs/nfs/nfs4filelayoutdev.o
>   CC [M]  fs/nfs/nfs2super.o
>   CC      fs/proc/proc_tty.o
>   CC [M]  net/wireless/util.o
>   CC [M]  fs/nls/nls_cp1255.o
>   LD [M]  net/wimax/wimax.o
>   CC      fs/proc/fd.o
>   CC      fs/proc/cmdline.o
>   CC [M]  fs/nls/nls_iso8859-9.o
>   CC [M]  fs/nls/nls_iso8859-13.o
> fs/nfsd/nfs4state.c: In function =E2=80=98free_client=E2=80=99:
> fs/nfsd/nfs4state.c:1045: warning: unused variable =E2=80=98nn=E2=80=99
>   CC      drivers/iommu/amd_iommu.o
>   CC      drivers/iommu/amd_iommu_init.o
>   CC      fs/proc/consoles.o
>   CC      net/xfrm/xfrm_output.o
>   CC      fs/pstore/platform.o
>   CC [M]  drivers/infiniband/hw/qib/qib_uc.o
>   CC [M]  drivers/infiniband/hw/qib/qib_ud.o
>   CC [M]  drivers/infiniband/hw/qib/qib_user_pages.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/graph/nv10.o
>   CC [M]  fs/nls/nls_iso8859-14.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/graph/nv20.o
>   CC [M]  drivers/infiniband/hw/qib/qib_user_sdma.o
>   CC [M]  drivers/infiniband/hw/qib/qib_verbs_mcast.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/graph/nv25.o
>   CC      fs/quota/quota.o
>   CC      fs/proc/cpuinfo.o
>   CC      fs/proc/devices.o
>   CC [M]  fs/nls/nls_iso8859-15.o
>   CC [M]  net/netfilter/ipvs/ip_vs_sched.o
>   CC [M]  fs/nfs/proc.o
>   LD      fs/pstore/pstore.o
>   CC [M]  drivers/infiniband/ulp/ipoib/ipoib_fs.o
>   CC [M]  net/netfilter/ipset/ip_set_hash_ipport.o
>   LD      fs/pstore/built-in.o
>   CC [M]  net/netfilter/ipset/ip_set_hash_ipportip.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/graph/nv2a.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/graph/nv30.o
>   CC      net/compat.o
>   CC      fs/proc/interrupts.o
>   CC      fs/proc/loadavg.o
>   CC [M]  fs/nls/nls_koi8-r.o
>   CC [M]  fs/nls/nls_koi8-u.o
>   CC [M]  fs/nls/nls_koi8-ru.o
>   CC [M]  net/netfilter/ipset/ip_set_hash_ipportnet.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/graph/nv34.o
>   CC [M]  net/netfilter/ipset/ip_set_hash_net.o
>   CC      net/xfrm/xfrm_sysctl.o
>   CC      net/xfrm/xfrm_replay.o
>   CC [M]  drivers/infiniband/hw/qib/qib_iba7220.o
>   CC [M]  drivers/infiniband/hw/qib/qib_sd7220.o
>   CC      fs/proc/meminfo.o
>   CC [M]  fs/nls/nls_utf8.o
>   LD [M]  drivers/infiniband/ulp/ipoib/ib_ipoib.o
>   CC [M]  drivers/gpu/drm/drm_info.o
>   CC [M]  drivers/infiniband/hw/qib/qib_iba7322.o
>   CC [M]  net/netfilter/ipvs/ip_vs_xmit.o
>   CC [M]  net/wireless/reg.o
>   CC [M]  net/wireless/scan.o
>   CC      fs/quota/kqid.o
>   CC      fs/quota/compat.o
>   LD      fs/nls/built-in.o
>   CC      fs/quota/netlink.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/graph/nv35.o
>   CC [M]  net/wireless/nl80211.o
>   CC [M]  net/wireless/mlme.o
>   CC [M]  fs/nfs/nfs2xdr.o
>   CC [M]  net/wireless/ibss.o
>   CC      fs/proc/stat.o
>   CC      fs/proc/uptime.o
>   CC      fs/proc/version.o
>   CC      fs/proc/softirqs.o
>   LD      drivers/iommu/built-in.o
> WARNING: drivers/iommu/built-in.o(.text+0x631c): Section mismatch in
> reference from the function iommu_init_pci() to the
> function .init.text:amd_iommu_erratum_746_workaround() The function
> iommu_init_pci() references the function __init
> amd_iommu_erratum_746_workaround(). This is often because
> iommu_init_pci lacks a __init annotation or the annotation of
> amd_iommu_erratum_746_workaround is wrong.
>=20
>   CC      fs/proc/namespaces.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/graph/nv40.o
>   CC      fs/proc/self.o
>   CC [M]  net/netfilter/ipset/ip_set_hash_netport.o
>   CC [M]  fs/nfs/nfs3super.o
>   CC [M]  drivers/infiniband/hw/qib/qib_verbs.o
>   LD      fs/quota/built-in.o
>   CC      net/xfrm/xfrm_proc.o
>   CC      net/xfrm/xfrm_algo.o
>   CC [M]  drivers/infiniband/hw/qib/qib_iba6120.o
>   CC [M]  drivers/infiniband/hw/qib/qib_wc_x86_64.o
>   CC [M]  fs/nfsd/nfs4callback.o
>   CC [M]  net/wireless/sme.o
>   CC [M]  net/wireless/chan.o
>   CC      net/xfrm/xfrm_user.o
>   CC [M]  net/netfilter/ipvs/ip_vs_app.o
>   CC      fs/proc/proc_sysctl.o
>   CC      fs/proc/proc_net.o
>   CC      fs/proc/kcore.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/graph/nv50.o
>   CC [M]  fs/nfs/nfs3client.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/graph/nvc0.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/graph/nve0.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/mpeg/nv31.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/mpeg/nv40.o
>   CC [M]  fs/nfs/nfs3proc.o
>   CC [M]  fs/nfs/nfs3xdr.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/mpeg/nv50.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/mpeg/nv84.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/ppp/nv98.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/ppp/nvc0.o
>   CC [M]  fs/nfsd/nfs4recover.o
>   CC      fs/proc/vmcore.o
>   CC      fs/proc/kmsg.o
>   CC [M]  net/wireless/ethtool.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/software/nv04.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/software/nv10.o
>   CC [M]  net/wireless/mesh.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/software/nv50.o
>   CC [M]  fs/nfs/nfs3acl.o
>   CC [M]  net/netfilter/ipvs/ip_vs_sync.o
>   CC [M]  net/netfilter/ipvs/ip_vs_est.o
>   CC [M]  net/netfilter/ipvs/ip_vs_proto.o
>   CC      fs/ramfs/inode.o
>   CC      fs/ramfs/file-mmu.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/software/nvc0.o
>   CC [M]  net/wireless/ap.o
>   CC [M]  net/wireless/trace.o
>   LD      fs/squashfs/built-in.o
>   CC [M]  fs/squashfs/block.o
>   CC      fs/sysfs/inode.o
>   CC [M]  fs/squashfs/cache.o
>   CC [M]  fs/squashfs/dir.o
>   CC [M]  fs/squashfs/export.o
>   CC      fs/sysfs/file.o
>   CC      fs/sysfs/dir.o
>   CC [M]  net/xfrm/xfrm_ipcomp.o
>   CC      fs/proc/page.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/vp/nv84.o
>   LD      net/xfrm/built-in.o
>   LD      fs/ramfs/ramfs.o
>   LD      fs/ramfs/built-in.o
>   CC [M]  net/netfilter/ipset/ip_set_list_set.o
>   CC [M]  fs/squashfs/file.o
>   CC      net/sysctl_net.o
>   CC [M]  drivers/gpu/drm/drm_debugfs.o
>   CC [M]  drivers/gpu/drm/drm_encoder_slave.o
>   LD [M]  net/netfilter/ipset/ip_set.o
>   CC [M]  net/netfilter/ipvs/ip_vs_pe.o
>   CC      fs/sysfs/symlink.o
>   CC      fs/sysfs/mount.o
>   CC [M]  fs/nfs/nfs4proc.o
>   CC      fs/sysfs/bin.o
>   CC [M]  fs/nfs/nfs4xdr.o
>   LD [M]  fs/nfsd/nfsd.o
>   CC [M]  fs/nfs/nfs4state.o
>   LD [M]  drivers/infiniband/hw/qib/ib_qib.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/vp/nvc0.o
>   CC [M]  fs/nfs/nfs4renewd.o
>   CC [M]  fs/nfs/nfs4super.o
>   CC [M]  fs/nfs/nfs4file.o
>   LD      fs/proc/proc.o
>   LD      fs/proc/built-in.o
>   CC [M]  fs/nfs/delegation.o
>   LD      fs/ubifs/built-in.o
>   CC [M]  fs/ubifs/shrinker.o
>   CC [M]  fs/squashfs/fragment.o
>   LD      fs/udf/built-in.o
>   CC [M]  fs/udf/balloc.o
>   CC [M]  fs/squashfs/id.o
>   CC [M]  fs/squashfs/inode.o
>   CC [M]  fs/udf/dir.o
>   CC [M]  fs/udf/file.o
>   CC [M]  fs/udf/ialloc.o
>   CC      fs/sysfs/group.o
>   CC [M]  fs/udf/inode.o
>   CC [M]  drivers/gpu/drm/nouveau/core/engine/vp/nve0.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_drm.o
>   CC [M]  fs/udf/lowlevel.o
>   LD      net/netfilter/netfilter.o
>   CC [M]  net/wireless/wext-compat.o
>   LD      drivers/irqchip/built-in.o
>   LD [M]  net/netfilter/nfnetlink_queue.o
>   CC [M]  fs/udf/namei.o
>   CC [M]  fs/squashfs/namei.o
>   CC [M]  fs/udf/partition.o
>   CC [M]  net/netfilter/ipvs/ip_vs_proto_tcp.o
>   CC [M]  fs/udf/super.o
>   CC [M]  fs/ubifs/journal.o
>   CC [M]  net/netfilter/ipvs/ip_vs_proto_udp.o
>   CC [M]  fs/ubifs/file.o
>   CC [M]  fs/ubifs/dir.o
>   LD      drivers/isdn/capi/built-in.o
>   CC [M]  drivers/isdn/capi/kcapi.o
>   LD      fs/sysfs/built-in.o
>   CC [M]  drivers/isdn/capi/capiutil.o
>   CC [M]  drivers/isdn/capi/capilib.o
>   CC [M]  fs/squashfs/super.o
>   CC [M]  fs/squashfs/symlink.o
>   CC [M]  drivers/isdn/capi/kcapi_proc.o
>   CC [M]  drivers/isdn/capi/capi.o
>   CC [M]  drivers/isdn/capi/capidrv.o
>   CC [M]  fs/udf/truncate.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_chan.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_dma.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_fence.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_irq.o
>   CC [M]  fs/udf/symlink.o
>   CC [M]  fs/squashfs/decompressor.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_vga.o
>   CC [M]  fs/squashfs/zlib_wrapper.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_agp.o
>   CC [M]  net/wireless/wext-sme.o
>   CC [M]  fs/ubifs/super.o
>   CC [M]  fs/ubifs/sb.o
>   CC [M]  net/netfilter/ipvs/ip_vs_proto_ah_esp.o
>   CC [M]  net/netfilter/ipvs/ip_vs_proto_sctp.o
>   CC [M]  fs/ubifs/io.o
>   CC [M]  fs/ubifs/tnc.o
>   LD      net/netfilter/built-in.o
>   CC [M]  fs/ubifs/master.o
>   CC [M]  fs/ubifs/scan.o
>   CC [M]  fs/udf/directory.o
>   LD [M]  drivers/isdn/capi/kernelcapi.o
>   CC [M]  fs/udf/misc.o
>   CC [M]  fs/udf/udftime.o
>   LD [M]  fs/squashfs/squashfs.o
>   CC [M]  fs/udf/unicode.o
>   CC [M]  fs/nfs/idmap.o
>   CC [M]  fs/nfs/callback.o
>   CC [M]  fs/nfs/callback_xdr.o
>   CC [M]  fs/ubifs/replay.o
>   CC [M]  net/netfilter/ipvs/ip_vs_rr.o
>   CC [M]  net/netfilter/ipvs/ip_vs_wrr.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_ttm.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_sgdma.o
>   CC [M]  fs/ubifs/log.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_bo.o
>   CC [M]  net/wireless/lib80211.o
>   CC [M]  net/wireless/lib80211_crypt_wep.o
>   CC [M]  net/wireless/lib80211_crypt_ccmp.o
>   CC [M]  net/wireless/lib80211_crypt_tkip.o
>   LD      fs/xfs/built-in.o
>   CC [M]  fs/xfs/xfs_trace.o
>   LD      drivers/isdn/divert/built-in.o
>   CC [M]  drivers/isdn/divert/isdn_divert.o
>   LD [M]  fs/udf/udf.o
>   CC [M]  drivers/isdn/divert/divert_procfs.o
>   CC [M]  drivers/gpu/drm/drm_trace_points.o
>   CC [M]  net/netfilter/ipvs/ip_vs_lc.o
>   CC [M]  drivers/gpu/drm/drm_global.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_gem.o
>   CC      drivers/leds/led-core.o
>   CC      drivers/leds/led-class.o
>   CC [M]  net/netfilter/ipvs/ip_vs_wlc.o
>   CC [M]  net/netfilter/ipvs/ip_vs_lblc.o
>   CC [M]  fs/nfs/callback_proc.o
>   CC [M]  fs/nfs/nfs4namespace.o
>   CC [M]  fs/nfs/nfs4getroot.o
>   CC [M]  fs/nfs/nfs4client.o
>   CC [M]  fs/ubifs/commit.o
>   CC [M]  fs/ubifs/gc.o
>   CC [M]  fs/ubifs/orphan.o
>   LD      drivers/lguest/built-in.o
>   CC [M]  fs/ubifs/budget.o
>   CC      drivers/leds/led-triggers.o
>   CC      drivers/macintosh/mac_hid.o
>   CC [M]  drivers/leds/leds-lp3944.o
>   CC [M]  drivers/leds/leds-clevo-mail.o
>   CC [M]  drivers/isdn/divert/divert_init.o
>   CC [M]  drivers/leds/ledtrig-timer.o
>   CC [M]  drivers/leds/ledtrig-heartbeat.o
>   CC [M]  net/netfilter/ipvs/ip_vs_lblcr.o
>   CC [M]  net/netfilter/ipvs/ip_vs_dh.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_prime.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_abi16.o
>   CC [M]  drivers/gpu/drm/drm_prime.o
>   CC [M]  drivers/gpu/drm/drm_ioc32.o
>   CC [M]  drivers/gpu/drm/ati_pcigart.o
>   LD [M]  drivers/isdn/divert/dss1_divert.o
>   CC [M]  fs/xfs/xfs_aops.o
>   LD      drivers/macintosh/built-in.o
>   LD      drivers/isdn/gigaset/built-in.o
>   CC [M]  fs/xfs/xfs_bit.o
>   CC [M]  drivers/isdn/gigaset/bas-gigaset.o
>   CC [M]  drivers/leds/ledtrig-backlight.o
>   CC [M]  drivers/isdn/gigaset/isocdata.o
>   CC [M]  fs/xfs/xfs_buf.o
>   CC [M]  drivers/isdn/gigaset/common.o
>   CC [M]  fs/xfs/xfs_dfrag.o
>   CC [M]  fs/xfs/xfs_discard.o
>   CC [M]  fs/ubifs/find.o
>   CC [M]  fs/ubifs/tnc_commit.o
>   CC [M]  fs/nfs/nfs4sysctl.o
>   CC      fs/eventpoll.o
>   CC [M]  fs/nfs/nfs4session.o
>   CC [M]  drivers/leds/ledtrig-default-on.o
>   CC [M]  fs/nfs/pnfs.o
>   CC [M]  fs/nfs/pnfs_dev.o
>   CC [M]  net/netfilter/ipvs/ip_vs_sh.o
>   LD      fs/nfs/blocklayout/built-in.o
>   CC [M]  fs/nfs/blocklayout/blocklayout.o
>   LD      drivers/leds/built-in.o
>   CC [M]  fs/nfs/blocklayout/extents.o
>   CC [M]  drivers/gpu/drm/nouveau/nv04_fence.o
>   CC [M]  drivers/gpu/drm/nouveau/nv10_fence.o
>   CC [M]  drivers/gpu/drm/nouveau/nv50_fence.o
>   CC [M]  drivers/gpu/drm/nouveau/nv84_fence.o
>   CC [M]  drivers/gpu/drm/nouveau/nvc0_fence.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_bios.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_fbcon.o
>   CC [M]  fs/ubifs/compress.o
>   CC [M]  fs/ubifs/lpt.o
>   CC [M]  fs/xfs/xfs_error.o
>   LD      net/wireless/built-in.o
>   LD [M]  net/wireless/cfg80211.o
>   CC [M]  fs/xfs/xfs_export.o
>   CC [M]  fs/ubifs/lprops.o
>   CC      drivers/md/md.o
>   CC [M]  net/netfilter/ipvs/ip_vs_sed.o
>   CC [M]  net/netfilter/ipvs/ip_vs_nq.o
>   CC [M]  net/netfilter/ipvs/ip_vs_pe_sip.o
>   CC      drivers/md/bitmap.o
>   CC [M]  drivers/md/linear.o
>   CC [M]  drivers/md/raid0.o
>   CC [M]  drivers/isdn/gigaset/interface.o
>   CC [M]  drivers/md/raid1.o
>   CC [M]  drivers/md/raid10.o
>   CC [M]  drivers/md/dm-log-userspace-base.o
>   LD      drivers/media/common/b2c2/built-in.o
>   LD      drivers/media/common/saa7146/built-in.o
>   LD      drivers/media/common/siano/built-in.o
>   LD      drivers/media/common/built-in.o
>   LD      drivers/memstick/built-in.o
>   LD [M]  net/netfilter/ipvs/ip_vs.o
>   LD      drivers/memstick/core/built-in.o
>   LD      drivers/media/firewire/built-in.o
>   CC [M]  drivers/memstick/core/memstick.o
>   LD      drivers/message/fusion/built-in.o
>   CC [M]  drivers/message/fusion/mptbase.o
>   LD      drivers/mfd/built-in.o
>   CC [M]  drivers/message/fusion/mptscsih.o
>   CC [M]  drivers/mfd/sm501.o
>   LD      drivers/media/i2c/soc_camera/built-in.o
>   LD      drivers/media/i2c/built-in.o
>   LD      drivers/media/mmc/siano/built-in.o
>   LD      drivers/media/parport/built-in.o
>   CC [M]  drivers/mfd/rtsx_pcr.o
>   LD      drivers/media/mmc/built-in.o
>   CC [M]  drivers/mfd/rts5209.o
>   LD      drivers/media/pci/b2c2/built-in.o
>   LD      drivers/media/pci/ddbridge/built-in.o
>   LD      drivers/media/pci/dm1105/built-in.o
>   LD      drivers/media/pci/mantis/built-in.o
>   CC [M]  fs/xfs/xfs_extent_busy.o
>   CC [M]  fs/nfs/blocklayout/blocklayoutdev.o
>   CC [M]  drivers/gpu/drm/drm_fb_helper.o
>   LD      drivers/media/pci/ngene/built-in.o
>   LD      drivers/media/pci/pluto2/built-in.o
>   CC [M]  drivers/gpu/drm/drm_crtc_helper.o
>   LD      drivers/media/pci/pt1/built-in.o
>   LD      drivers/media/pci/saa7146/built-in.o
>   LD      drivers/media/pci/ttpci/built-in.o
>   LD      drivers/media/pci/built-in.o
>   CC [M]  fs/nfs/blocklayout/blocklayoutdm.o
>   LD      drivers/media/platform/davinci/built-in.o
>   LD      drivers/media/platform/built-in.o
>   LD      net/built-in.o
>   CC [M]  drivers/mfd/rts5229.o
>   LD      drivers/media/rc/keymaps/built-in.o
>   LD      drivers/media/rc/built-in.o
>   LD      fs/nfs/objlayout/built-in.o
>   CC [M]  fs/nfs/objlayout/objio_osd.o
>   CC [M]  fs/ubifs/recovery.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_display.o
>   LD      drivers/media/tuners/built-in.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_connector.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_dp.o
>   LD      drivers/media/usb/b2c2/built-in.o
>   LD      drivers/media/usb/dvb-usb/built-in.o
>   CC [M]  drivers/gpu/drm/nouveau/nv04_fbcon.o
>   LD      drivers/media/usb/dvb-usb-v2/built-in.o
>   CC [M]  drivers/isdn/gigaset/proc.o
>   LD      drivers/media/usb/s2255/built-in.o
>   LD      drivers/media/usb/siano/built-in.o
>   LD      drivers/media/usb/stkwebcam/built-in.o
>   CC [M]  drivers/memstick/core/mspro_block.o
>   LD      drivers/media/usb/ttusb-budget/built-in.o
>   LD      drivers/media/usb/ttusb-dec/built-in.o
>   LD      drivers/media/usb/zr364xx/built-in.o
>   LD      drivers/media/usb/built-in.o
>   CC [M]  drivers/mfd/rtl8411.o
>   LD      drivers/media/built-in.o
>   CC [M]  drivers/mfd/mfd-core.o
>   CC [M]  fs/ubifs/ioctl.o
>   CC [M]  fs/xfs/xfs_file.o
>   CC [M]  fs/xfs/xfs_filestream.o
>   LD [M]  fs/nfs/blocklayout/blocklayoutdriver.o
>   CC [M]  fs/xfs/xfs_fsops.o
>   CC [M]  fs/xfs/xfs_globals.o
>   CC [M]  drivers/isdn/gigaset/ev-layer.o
>   CC [M]  drivers/isdn/gigaset/asyncdata.o
>   CC [M]  drivers/isdn/gigaset/i4l.o
>   CC [M]  drivers/isdn/gigaset/ser-gigaset.o
>   CC      fs/anon_inodes.o
>   CC      fs/signalfd.o
>   CC [M]  fs/nfs/objlayout/pnfs_osd_xdr_cli.o
>   CC [M]  fs/nfs/objlayout/objlayout.o
>   CC [M]  drivers/gpu/drm/nouveau/nv50_fbcon.o
>   CC [M]  drivers/gpu/drm/nouveau/nvc0_fbcon.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_hw.o
>   CC [M]  drivers/mfd/lpc_sch.o
>   CC [M]  fs/ubifs/lpt_commit.o
>   CC [M]  fs/ubifs/tnc_misc.o
>   CC [M]  fs/ubifs/xattr.o
>   CC [M]  fs/ubifs/debug.o
>   LD      drivers/memstick/host/built-in.o
>   CC [M]  drivers/memstick/host/tifm_ms.o
>   CC [M]  drivers/memstick/host/jmb38x_ms.o
>   LD      drivers/isdn/hardware/avm/built-in.o
>   CC [M]  drivers/isdn/hardware/avm/b1pci.o
>   CC [M]  fs/xfs/xfs_icache.o
>   LD      drivers/isdn/hardware/mISDN/built-in.o
>   CC [M]  drivers/isdn/hardware/mISDN/hfcpci.o
>   CC [M]  drivers/mfd/lpc_ich.o
>   CC [M]  drivers/gpu/drm/drm_dp_helper.o
>   CC [M]  drivers/gpu/drm/drm_edid_load.o
>   CC [M]  fs/xfs/xfs_ioctl.o
>   LD [M]  drivers/mfd/rtsx_pci.o
>   CC [M]  drivers/isdn/gigaset/usb-gigaset.o
>   CC [M]  drivers/isdn/hardware/avm/b1.o
>   CC [M]  drivers/isdn/hardware/avm/b1dma.o
>   CC [M]  drivers/isdn/hardware/avm/b1pcmcia.o
>   CC [M]  drivers/isdn/hardware/avm/avm_cs.o
>   CC [M]  drivers/isdn/hardware/avm/t1pci.o
>   CC [M]  drivers/isdn/hardware/avm/c4.o
>   LD [M]  fs/nfs/objlayout/objlayoutdriver.o
>   CC [M]  fs/xfs/xfs_iomap.o
>   LD [M]  fs/nfs/nfs.o
>   LD [M]  fs/nfs/nfsv2.o
>   LD [M]  fs/nfs/nfsv3.o
>   CC [M]  fs/xfs/xfs_iops.o
>   LD [M]  fs/nfs/nfsv4.o
>   CC [M]  fs/xfs/xfs_itable.o
>   LD [M]  fs/nfs/nfs_layout_nfsv41_files.o
> drivers/isdn/hardware/mISDN/hfcpci.c: In function =E2=80=98hfcpci_softirq=
=E2=80=99:
> drivers/isdn/hardware/mISDN/hfcpci.c:2298: warning: ignoring return
> value of =E2=80=98driver_for_each_device=E2=80=99, declared with attribute
> warn_unused_result LD      drivers/misc/carma/built-in.o LD
> drivers/misc/cb710/built-in.o CC [M]  drivers/misc/cb710/core.o
>   LD      drivers/misc/eeprom/built-in.o
>   CC [M]  drivers/misc/eeprom/at24.o
>   CC [M]  drivers/memstick/host/r592.o
>   LD      drivers/misc/lis3lv02d/built-in.o
>   CC [M]  drivers/memstick/host/rtsx_pci_ms.o
> drivers/gpu/drm/drm_edid_load.c: In function =E2=80=98edid_load=E2=80=99:
> drivers/gpu/drm/drm_edid_load.c:122: warning: =E2=80=98edid=E2=80=99 may =
be used
> uninitialized in this function CC [M]  drivers/misc/cb710/sgbuf2.o
>   LD      drivers/misc/ti-st/built-in.o
>   CC [M]  drivers/misc/ics932s401.o
>   CC [M]  drivers/isdn/hardware/mISDN/hfcmulti.o
>   CC [M]  drivers/isdn/hardware/mISDN/hfcsusb.o
>   CC      fs/timerfd.o
>   LD [M]  drivers/isdn/gigaset/gigaset.o
>   LD [M]  drivers/isdn/gigaset/usb_gigaset.o
>   LD [M]  drivers/isdn/gigaset/bas_gigaset.o
>   LD [M]  drivers/isdn/gigaset/ser_gigaset.o
>   CC      fs/eventfd.o
>   CC      fs/aio.o
>   LD [M]  fs/ubifs/ubifs.o
>   CC      fs/locks.o
>   CC [M]  drivers/misc/eeprom/eeprom.o
>   LD [M]  drivers/gpu/drm/drm_kms_helper.o
>   CC      fs/compat.o
>   CC      fs/compat_ioctl.o
>   CC [M]  drivers/message/fusion/mptspi.o
>   CC [M]  drivers/message/fusion/mptfc.o
>   CC      fs/binfmt_misc.o
>   CC      fs/binfmt_script.o
>   CC      fs/binfmt_elf.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_calc.o
>   LD [M]  drivers/misc/cb710/cb710.o
>   CC [M]  drivers/gpu/drm/nouveau/nv04_dac.o
>   CC      fs/compat_binfmt_elf.o
>   CC [M]  drivers/isdn/hardware/mISDN/avmfritz.o
>   CC [M]  drivers/isdn/hardware/mISDN/speedfax.o
>   CC [M]  drivers/isdn/hardware/mISDN/mISDNinfineon.o
>   CC [M]  drivers/isdn/hardware/mISDN/w6692.o
>   CC [M]  fs/xfs/xfs_message.o
>   CC [M]  drivers/misc/eeprom/max6875.o
>   CC [M]  drivers/isdn/hardware/mISDN/netjet.o
>   CC [M]  drivers/isdn/hardware/mISDN/mISDNipac.o
>   CC [M]  drivers/isdn/hardware/mISDN/mISDNisar.o
>   LD      drivers/isdn/hisax/built-in.o
>   LD      drivers/isdn/hysdn/built-in.o
>   CC [M]  drivers/isdn/hisax/config.o
>   CC [M]  drivers/isdn/hysdn/hysdn_procconf.o
>   CC [M]  drivers/misc/eeprom/eeprom_93cx6.o
>   CC [M]  drivers/md/dm-log-userspace-transfer.o
>   CC [M]  fs/xfs/xfs_mru_cache.o
>   CC [M]  fs/xfs/xfs_super.o
>   CC [M]  drivers/gpu/drm/nouveau/nv04_dfp.o
>   CC [M]  drivers/gpu/drm/nouveau/nv04_tv.o
>   CC [M]  drivers/gpu/drm/nouveau/nv17_tv.o
>   CC [M]  drivers/isdn/hisax/isdnl1.o
>   LD      drivers/isdn/i4l/built-in.o
>   CC [M]  drivers/isdn/i4l/isdn_net.o
>   CC [M]  drivers/message/fusion/mptsas.o
>   CC [M]  drivers/misc/tifm_core.o
>   CC [M]  drivers/isdn/i4l/isdn_tty.o
>   CC [M]  drivers/misc/tifm_7xx1.o
>   CC [M]  drivers/misc/ioc4.o
>   CC [M]  drivers/isdn/i4l/isdn_v110.o
>   CC [M]  drivers/isdn/i4l/isdn_common.o
>   CC [M]  drivers/isdn/hysdn/hysdn_proclog.o
>   CC [M]  drivers/isdn/hysdn/boardergo.o
>   LD      drivers/isdn/mISDN/built-in.o
>   CC [M]  drivers/isdn/mISDN/l1oip_core.o
>   CC [M]  drivers/isdn/mISDN/l1oip_codec.o
>   CC [M]  drivers/isdn/mISDN/core.o
>   CC [M]  drivers/md/dm-raid1.o
>   CC [M]  drivers/isdn/mISDN/fsm.o
>   CC [M]  drivers/isdn/mISDN/socket.o
>   LD      drivers/mmc/card/built-in.o
>   CC [M]  drivers/mmc/card/block.o
>   CC [M]  drivers/mmc/card/queue.o
>   LD      drivers/mmc/core/built-in.o
>   CC [M]  drivers/mmc/core/core.o
>   CC [M]  drivers/mmc/card/sdio_uart.o
>   CC      drivers/mmc/host/sdhci-pci-data.o
>   CC [M]  drivers/misc/enclosure.o
>   CC [M]  drivers/misc/hpilo.o
>   CC [M]  drivers/gpu/drm/nouveau/nv17_tv_modes.o
>   CC [M]  drivers/isdn/hysdn/hysdn_boot.o
>   CC [M]  drivers/isdn/hisax/tei.o
>   CC [M]  drivers/isdn/hisax/isdnl2.o
>   CC [M]  drivers/isdn/hisax/isdnl3.o
>   CC [M]  drivers/mmc/host/sdhci.o
>   CC [M]  drivers/isdn/hisax/lmgr.o
>   CC [M]  drivers/mmc/host/sdhci-pci.o
>   LD      drivers/isdn/hardware/built-in.o
>   CC [M]  fs/xfs/xfs_xattr.o
>   CC [M]  fs/xfs/xfs_rename.o
>   CC [M]  drivers/mmc/host/tifm_sd.o
>   CC [M]  drivers/gpu/drm/nouveau/nv04_crtc.o
>   CC [M]  drivers/isdn/hysdn/hysdn_sched.o
>   CC [M]  drivers/isdn/hysdn/hysdn_net.o
>   CC [M]  drivers/gpu/drm/nouveau/nv04_display.o
>   CC [M]  drivers/misc/isl29003.o
>   CC [M]  drivers/isdn/mISDN/clock.o
>   CC [M]  drivers/md/dm-uevent.o
>   CC [M]  drivers/md/dm.o
>   CC [M]  drivers/md/dm-table.o
>   CC [M]  drivers/md/dm-target.o
>   LD [M]  drivers/mmc/card/mmc_block.o
>   CC [M]  drivers/md/dm-linear.o
>   CC [M]  drivers/md/dm-stripe.o
>   CC [M]  drivers/md/dm-ioctl.o
>   CC [M]  drivers/isdn/hisax/q931.o
>   CC [M]  drivers/isdn/hisax/callc.o
>   CC [M]  drivers/message/fusion/mptctl.o
>   LD [M]  drivers/gpu/drm/drm.o
>   CC [M]  drivers/misc/tsl2550.o
>   CC [M]  drivers/misc/vmw_balloon.o
>   CC [M]  drivers/isdn/i4l/isdn_ppp.o
>   CC [M]  fs/xfs/xfs_utils.o
>   CC [M]  fs/xfs/xfs_vnodeops.o
>   CC [M]  drivers/isdn/hysdn/hysdn_init.o
>   CC [M]  drivers/isdn/hysdn/hycapi.o
>   CC [M]  fs/xfs/kmem.o
>   CC [M]  fs/xfs/uuid.o
>   CC [M]  drivers/gpu/drm/nouveau/nv04_cursor.o
>   CC [M]  drivers/mmc/core/bus.o
>   CC      fs/posix_acl.o
>   CC      fs/xattr_acl.o
>   CC      fs/generic_acl.o
>   CC [M]  drivers/mmc/core/host.o
>   CC [M]  drivers/isdn/mISDN/hwchannel.o
>   CC [M]  drivers/isdn/mISDN/stack.o
>   CC [M]  drivers/isdn/mISDN/layer1.o
>   CC [M]  drivers/isdn/mISDN/layer2.o
>   LD      drivers/misc/built-in.o
>   CC [M]  drivers/isdn/mISDN/tei.o
>   CC      fs/coredump.o
>   CC      fs/dcookies.o
>   CC [M]  fs/mbcache.o
>   CC [M]  fs/xfs/xfs_alloc.o
>   CC [M]  drivers/isdn/hisax/fsm.o
>   CC [M]  drivers/isdn/hisax/l3dss1.o
>   CC [M]  drivers/isdn/hisax/l3ni1.o
>   CC [M]  fs/xfs/xfs_alloc_btree.o
>   CC [M]  drivers/gpu/drm/nouveau/nv50_display.o
>   CC [M]  fs/xfs/xfs_attr.o
>   CC [M]  drivers/mmc/host/sdricoh_cs.o
>   LD [M]  drivers/isdn/hysdn/hysdn.o
>   CC [M]  fs/xfs/xfs_attr_leaf.o
>   CC [M]  drivers/mmc/core/mmc.o
>   CC [M]  fs/xfs/xfs_bmap.o
>   CC [M]  drivers/md/dm-io.o
>   CC [M]  drivers/md/dm-kcopyd.o
>   CC [M]  drivers/isdn/hisax/l3_1tr6.o
>   CC [M]  drivers/mmc/core/mmc_ops.o
>   CC [M]  drivers/mmc/core/sd.o
>   CC [M]  drivers/message/fusion/mptlan.o
>   CC [M]  drivers/isdn/hisax/teles3.o
>   CC [M]  drivers/isdn/i4l/isdn_audio.o
>   CC [M]  drivers/isdn/i4l/isdn_ttyfax.o
>   CC [M]  drivers/isdn/i4l/isdnhdlc.o
>   CC [M]  drivers/mmc/host/cb710-mmc.o
>   CC [M]  drivers/isdn/hisax/isac.o
>   CC [M]  drivers/isdn/hisax/arcofi.o
>   CC [M]  drivers/isdn/hisax/hscx.o
>   CC [M]  drivers/md/dm-sysfs.o
>   CC [M]  drivers/md/dm-path-selector.o
>   CC [M]  drivers/md/dm-mpath.o
>   CC [M]  drivers/isdn/hisax/telespci.o
>   CC [M]  drivers/mmc/core/sd_ops.o
>   CC [M]  drivers/md/dm-snap.o
>   CC [M]  drivers/isdn/hisax/s0box.o
>   CC [M]  drivers/md/dm-exception-store.o
>   CC [M]  drivers/md/dm-snap-transient.o
>   CC [M]  drivers/md/dm-snap-persistent.o
>   CC [M]  fs/xfs/xfs_bmap_btree.o
>   CC [M]  drivers/mmc/host/via-sdmmc.o
>   CC [M]  fs/xfs/xfs_btree.o
>   CC [M]  drivers/isdn/mISDN/timerdev.o
>   CC [M]  drivers/isdn/mISDN/dsp_core.o
>   CC [M]  drivers/isdn/mISDN/dsp_cmx.o
>   CC [M]  fs/xfs/xfs_da_btree.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_pm.o
>   LD      drivers/message/built-in.o
>   LD [M]  drivers/isdn/i4l/isdn.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_volt.o
>   CC [M]  drivers/mmc/host/rtsx_pci_sdmmc.o
>   CC [M]  drivers/mmc/host/sdhci-pltfm.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_perf.o
>   CC [M]  drivers/gpu/drm/nouveau/nv04_pm.o
>   LD      drivers/mmc/host/built-in.o
>   CC [M]  drivers/gpu/drm/nouveau/nv40_pm.o
>   CC [M]  drivers/gpu/drm/nouveau/nv50_pm.o
>   CC [M]  drivers/mmc/core/sdio.o
>   CC [M]  drivers/mmc/core/sdio_ops.o
>   CC [M]  drivers/mmc/core/sdio_bus.o
>   CC [M]  drivers/mmc/core/sdio_cis.o
>   CC [M]  drivers/mmc/core/sdio_io.o
>   CC [M]  drivers/mmc/core/sdio_irq.o
>   CC [M]  drivers/isdn/hisax/avm_a1p.o
>   CC [M]  drivers/mmc/core/quirks.o
>   CC [M]  drivers/isdn/hisax/avm_pci.o
>   CC      drivers/mtd/mtdcore.o
>   CC      drivers/mtd/mtdsuper.o
>   CC      drivers/net/Space.o
>   CC      drivers/mtd/mtdconcat.o
>   CC      drivers/mtd/mtdpart.o
>   CC      drivers/mtd/cmdlinepart.o
>   CC [M]  drivers/mmc/core/slot-gpio.o
>   CC [M]  drivers/mmc/core/debugfs.o
>   CC      drivers/mtd/chips/chipreg.o
>   CC [M]  drivers/mtd/chips/cfi_probe.o
>   CC [M]  drivers/mtd/chips/cfi_util.o
>   LD      drivers/mtd/devices/built-in.o
>   CC [M]  drivers/mtd/devices/pmc551.o
>   LD      drivers/mtd/lpddr/built-in.o
>   CC [M]  drivers/md/dm-thin.o
>   CC [M]  drivers/mtd/lpddr/qinfo_probe.o
>   CC [M]  drivers/isdn/mISDN/dsp_tones.o
>   CC [M]  drivers/isdn/mISDN/dsp_dtmf.o
>   CC [M]  drivers/isdn/mISDN/dsp_audio.o
>   CC [M]  drivers/mtd/lpddr/lpddr_cmds.o
>   CC      drivers/mtd/maps/map_funcs.o
>   CC [M]  drivers/mtd/maps/esb2rom.o
>   LD      drivers/nfc/built-in.o
>   CC [M]  drivers/gpu/drm/nouveau/nva3_pm.o
>   CC [M]  drivers/gpu/drm/nouveau/nvc0_pm.o
>   CC      drivers/net/loopback.o
>   CC [M]  drivers/mtd/maps/ck804xrom.o
>   CC [M]  drivers/mtd/maps/sc520cdp.o
>   LD [M]  drivers/mmc/core/mmc_core.o
>   CC [M]  drivers/mtd/maps/netsc520.o
>   LD      drivers/mmc/built-in.o
>   LD      drivers/net/bonding/built-in.o
>   CC [M]  drivers/net/bonding/bond_main.o
>   LD      drivers/net/can/sja1000/built-in.o
>   CC      drivers/net/dsa/mv88e6060.o
>   CC [M]  drivers/net/can/sja1000/sja1000.o
>   CC [M]  drivers/net/can/sja1000/sja1000_platform.o
>   CC [M]  drivers/net/can/sja1000/ems_pci.o
>   CC [M]  drivers/mtd/devices/mtdram.o
>   CC [M]  drivers/mtd/devices/block2mtd.o
>   CC [M]  drivers/isdn/hisax/elsa.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_mem.o
>   CC [M]  drivers/isdn/hisax/diva.o
>   CC [M]  drivers/isdn/hisax/ipacx.o
>   CC [M]  drivers/isdn/hisax/sedlbauer.o
>   CC [M]  drivers/mtd/chips/cfi_cmdset_0020.o
>   CC [M]  drivers/mtd/chips/cfi_cmdset_0002.o
>   CC [M]  fs/xfs/xfs_dir2.o
>   LD      drivers/parport/built-in.o
>   CC [M]  drivers/parport/share.o
>   CC      drivers/pci/access.o
>   CC [M]  drivers/parport/ieee1284.o
>   CC [M]  drivers/mtd/maps/ts5500_flash.o
>   CC [M]  drivers/mtd/maps/pci.o
>   CC      drivers/net/dsa/mv88e6xxx.o
>   CC [M]  drivers/mtd/maps/scb2_flash.o
>   CC      drivers/net/dsa/mv88e6123_61_65.o
>   CC      drivers/net/dsa/mv88e6131.o
>   LD      drivers/mtd/maps/built-in.o
>   CC [M]  drivers/isdn/hisax/isar.o
>   CC [M]  drivers/isdn/mISDN/dsp_blowfish.o
>   CC [M]  drivers/isdn/mISDN/dsp_pipeline.o
>   CC [M]  drivers/isdn/hisax/nj_s.o
>   CC [M]  drivers/md/dm-thin-metadata.o
>   CC [M]  drivers/md/raid5.o
>   CC [M]  drivers/md/faulty.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_ioc32.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_acpi.o
>   CC [M]  drivers/net/can/sja1000/kvaser_pci.o
>   CC [M]  drivers/gpu/drm/nouveau/nouveau_backlight.o
>   CC [M]  drivers/parport/ieee1284_ops.o
>   CC [M]  drivers/net/bonding/bond_3ad.o
>   CC [M]  drivers/mtd/chips/cfi_cmdset_0001.o
>   CC [M]  fs/xfs/xfs_dir2_block.o
>   CC [M]  fs/xfs/xfs_dir2_data.o
>   CC [M]  drivers/isdn/mISDN/dsp_hwec.o
>   CC      drivers/pci/bus.o
>   LD      drivers/net/dsa/mv88e6xxx_drv.o
>   LD      drivers/net/dsa/built-in.o
>   CC      drivers/pci/probe.o
>   LD      drivers/net/fddi/built-in.o
>   LD      drivers/net/ethernet/3com/built-in.o
>   CC      drivers/pci/host-bridge.o
>   CC [M]  drivers/net/ethernet/3com/3c589_cs.o
>   CC [M]  drivers/net/ethernet/3com/3c574_cs.o
>   LD      drivers/mtd/nand/built-in.o
>   CC [M]  drivers/mtd/nand/nand_base.o
>   CC [M]  drivers/net/ethernet/3com/3c59x.o
>   CC [M]  drivers/net/ethernet/3com/typhoon.o
>   CC [M]  drivers/mtd/nand/nand_bbt.o
>   CC [M]  drivers/mtd/chips/gen_probe.o
>   CC [M]  drivers/md/dm-bufio.o
>   CC [M]  drivers/mtd/chips/jedec_probe.o
>   LD [M]  drivers/gpu/drm/nouveau/nouveau.o
>   LD      drivers/net/can/softing/built-in.o
>   LD      drivers/net/can/usb/built-in.o
>   CC [M]  drivers/net/can/usb/ems_usb.o
>   LD [M]  drivers/isdn/mISDN/mISDN_core.o
>   LD [M]  drivers/isdn/mISDN/mISDN_dsp.o
>   LD [M]  drivers/isdn/mISDN/l1oip.o
>   CC [M]  drivers/parport/procfs.o
>   CC [M]  drivers/net/can/vcan.o
>   LD      drivers/gpu/drm/built-in.o
>   CC [M]  drivers/isdn/hisax/netjet.o
>   LD      drivers/gpu/built-in.o
>   CC [M]  drivers/md/dm-bio-prison.o
>   CC [M]  drivers/md/dm-crypt.o
>   CC [M]  drivers/net/bonding/bond_alb.o
>   CC [M]  drivers/net/bonding/bond_sysfs.o
>   CC [M]  drivers/isdn/hisax/nj_u.o
>   CC [M]  drivers/net/bonding/bond_debugfs.o
>   CC [M]  drivers/parport/daisy.o
>   CC [M]  drivers/net/bonding/bond_procfs.o
>   CC [M]  fs/xfs/xfs_dir2_leaf.o
>   CC [M]  drivers/isdn/hisax/icc.o
>   CC [M]  fs/xfs/xfs_dir2_node.o
>   CC [M]  fs/xfs/xfs_dir2_sf.o
>   CC      drivers/pci/remove.o
>   CC [M]  fs/xfs/xfs_ialloc.o
>   CC      drivers/pci/pci.o
>   CC [M]  drivers/net/can/dev.o
>   CC      drivers/pci/pci-driver.o
>   CC      drivers/pci/search.o
>   CC      drivers/pci/pci-sysfs.o
>   CC [M]  drivers/parport/probe.o
>   CC [M]  drivers/parport/parport_pc.o
>   CC      drivers/pci/rom.o
>   CC      drivers/pci/setup-res.o
>   CC      drivers/pcmcia/ds.o
>   CC      drivers/pcmcia/pcmcia_resource.o
>   CC      drivers/pci/irq.o
>   CC [M]  drivers/mtd/nand/nand_ecc.o
>   CC      drivers/pci/vpd.o
>   CC [M]  drivers/mtd/chips/map_ram.o
>   CC      drivers/pci/setup-bus.o
>   CC [M]  drivers/mtd/nand/nand_ids.o
>   CC [M]  drivers/isdn/hisax/hfc_pci.o
>   LD [M]  drivers/net/bonding/bonding.o
>   CC [M]  drivers/isdn/hisax/hfc_sx.o
>   CC [M]  drivers/mtd/nand/diskonchip.o
>   LD      drivers/net/ethernet/8390/built-in.o
>   CC [M]  drivers/net/ethernet/8390/ne2k-pci.o
>   CC [M]  drivers/net/ethernet/8390/8390.o
>   CC [M]  drivers/mtd/nand/nandsim.o
>   CC [M]  drivers/mtd/nand/alauda.o
>   CC [M]  drivers/mtd/chips/map_rom.o
>   CC [M]  drivers/net/ethernet/8390/axnet_cs.o
>   CC [M]  drivers/net/ethernet/8390/pcnet_cs.o
>   CC [M]  drivers/mtd/chips/map_absent.o
>   LD      drivers/mtd/onenand/built-in.o
>   CC [M]  drivers/parport/parport_serial.o
>   CC [M]  drivers/parport/parport_cs.o
>   LD [M]  drivers/mtd/nand/nand.o
>   LD      drivers/net/ethernet/adaptec/built-in.o
>   LD      drivers/mtd/chips/built-in.o
>   LD      drivers/net/can/built-in.o
>   LD [M]  drivers/net/can/can-dev.o
>   CC [M]  drivers/net/ethernet/adaptec/starfire.o
>   CC [M]  drivers/isdn/hisax/niccy.o
>   CC [M]  fs/xfs/xfs_ialloc_btree.o
>   CC [M]  drivers/isdn/hisax/bkm_a4t.o
>   LD      drivers/net/hyperv/built-in.o
>   CC [M]  drivers/net/hyperv/netvsc_drv.o
>   CC [M]  drivers/net/hyperv/netvsc.o
>   CC [M]  drivers/net/hyperv/rndis_filter.o
>   CC      drivers/pcmcia/cistpl.o
>   CC [M]  drivers/isdn/hisax/jade.o
>   CC [M]  drivers/isdn/hisax/bkm_a8.o
>   CC [M]  drivers/isdn/hisax/gazel.o
>   CC [M]  drivers/isdn/hisax/w6692.o
>   CC      drivers/pcmcia/pcmcia_cis.o
>   LD      drivers/mtd/tests/built-in.o
>   CC [M]  drivers/isdn/hisax/enternow_pci.o
>   LD      drivers/net/ethernet/alteon/built-in.o
>   CC [M]  drivers/net/ethernet/alteon/acenic.o
>   CC      drivers/pci/proc.o
>   LD [M]  drivers/parport/parport.o
>   CC      drivers/pci/slot.o
>   CC      drivers/pci/quirks.o
>   CC [M]  fs/xfs/xfs_inode.o
>   LD      drivers/mtd/ubi/built-in.o
>   CC [M]  drivers/mtd/ubi/vtbl.o
>   CC      drivers/pci/hotplug/acpiphp_core.o
>   CC      drivers/pci/hotplug/acpiphp_glue.o
>   CC      drivers/pci/hotplug/pci_hotplug_core.o
>   CC      drivers/pci/hotplug/pcihp_slot.o
>   CC      drivers/pci/hotplug/acpi_pcihp.o
>   LD [M]  drivers/net/hyperv/hv_netvsc.o
>   CC      drivers/pci/hotplug/pciehp_core.o
>   LD      drivers/net/ethernet/amd/built-in.o
>   CC [M]  drivers/net/ethernet/amd/amd8111e.o
>   LD      drivers/net/ethernet/atheros/built-in.o
>   CC [M]  drivers/net/ethernet/amd/nmclan_cs.o
>   LD      drivers/net/ethernet/broadcom/built-in.o
>   LD      drivers/net/ethernet/atheros/atl1c/built-in.o
>   CC [M]  drivers/md/dm-delay.o
>   CC [M]  drivers/net/ethernet/broadcom/b44.o
>   CC [M]  drivers/net/ethernet/atheros/atl1c/atl1c_main.o
>   CC [M]  drivers/md/dm-flakey.o
>   LD [M]  drivers/md/dm-multipath.o
>   CC [M]  drivers/net/ethernet/atheros/atl1c/atl1c_hw.o
>   CC [M]  drivers/net/ethernet/atheros/atl1c/atl1c_ethtool.o
>   CC [M]  drivers/mtd/redboot.o
>   CC [M]  fs/xfs/xfs_log_recover.o
>   CC [M]  fs/xfs/xfs_mount.o
>   CC [M]  drivers/mtd/ubi/vmt.o
>   CC [M]  drivers/mtd/ubi/upd.o
>   CC [M]  drivers/isdn/hisax/amd7930_fn.o
>   CC [M]  drivers/isdn/hisax/st5481_init.o
>   CC [M]  drivers/mtd/ubi/build.o
>   CC [M]  drivers/isdn/hisax/st5481_usb.o
>   CC [M]  drivers/md/dm-round-robin.o
>   CC [M]  drivers/isdn/hisax/st5481_d.o
>   CC [M]  drivers/md/dm-queue-length.o
>   CC [M]  drivers/md/dm-service-time.o
>   CC [M]  drivers/isdn/hisax/st5481_b.o
>   CC      drivers/pcmcia/cs.o
>   CC      drivers/pci/hotplug/pciehp_ctrl.o
>   CC      drivers/pci/hotplug/pciehp_pci.o
>   CC      drivers/pci/hotplug/pciehp_hpc.o
>   CC [M]  drivers/net/ethernet/amd/pcnet32.o
>   CC [M]  drivers/mtd/ubi/cdev.o
>   LD [M]  drivers/md/dm-snapshot.o
>   CC      drivers/pcmcia/socket_sysfs.o
>   CC [M]  drivers/mtd/ubi/kapi.o
>   CC [M]  drivers/net/ethernet/broadcom/bnx2.o
>   LD      drivers/net/ieee802154/built-in.o
>   CC [M]  drivers/net/ieee802154/fakehard.o
>   CC      drivers/pci/pcie/aspm.o
>   CC      drivers/net/phy/phy.o
>   LD [M]  drivers/md/dm-mirror.o
>   CC      drivers/pci/pcie/portdrv_core.o
>   CC [M]  drivers/md/dm-log.o
>   CC      drivers/pci/pcie/portdrv_pci.o
>   CC      drivers/pci/pcie/portdrv_bus.o
>   CC      drivers/pci/pcie/portdrv_acpi.o
>   CC      drivers/pci/pcie/aer/aerdrv_errprint.o
>   CC [M]  drivers/isdn/hisax/sedlbauer_cs.o
>   CC      drivers/pci/pcie/aer/aerdrv_core.o
>   CC      drivers/pci/pcie/aer/aerdrv.o
>   CC      drivers/pci/pcie/aer/aerdrv_acpi.o
>   CC      drivers/pci/pcie/aer/ecrc.o
>   CC [M]  drivers/pci/pcie/aer/aer_inject.o
>   CC [M]  drivers/md/dm-region-hash.o
>   LD [M]  drivers/net/ethernet/atheros/atl1c/atl1c.o
>   CC [M]  drivers/isdn/hisax/elsa_cs.o
>   CC      drivers/pci/hotplug/pciehp_acpi.o
>   CC      drivers/pcmcia/cardbus.o
>   LD      drivers/net/ethernet/atheros/atl1e/built-in.o
>   CC [M]  drivers/net/ethernet/atheros/atl1e/atl1e_main.o
>   CC      drivers/pcmcia/rsrc_mgr.o
>   CC      drivers/pcmcia/rsrc_nonstatic.o
>   CC [M]  drivers/pcmcia/yenta_socket.o
>   CC [M]  drivers/pcmcia/pd6729.o
>   CC [M]  drivers/mtd/ubi/eba.o
>   CC [M]  drivers/isdn/hisax/avma1_cs.o
>   CC [M]  drivers/isdn/hisax/teles_cs.o
>   LD [M]  drivers/isdn/hisax/hisax_st5481.o
>   CC [M]  fs/xfs/xfs_trans.o
>   CC [M]  drivers/isdn/hisax/hfc4s8s_l1.o
>   CC      drivers/pci/pcie/pme.o
>   CC [M]  drivers/isdn/hisax/hisax_isac.o
>   LD      drivers/net/ethernet/atheros/atlx/built-in.o
>   CC [M]  drivers/net/ethernet/atheros/atlx/atl1.o
>   CC [M]  drivers/net/ethernet/atheros/atlx/atl2.o
>   CC [M]  drivers/mtd/ubi/io.o
>   CC      drivers/pci/hotplug-pci.o
>   CC      drivers/pci/msi.o
>   CC [M]  drivers/pci/hotplug/shpchp_core.o
>   CC [M]  drivers/pci/hotplug/shpchp_ctrl.o
>   CC      drivers/pci/htirq.o
>   CC      drivers/pci/ats.o
>   LD      drivers/pci/pcie/aer/aerdriver.o
>   LD      drivers/pci/pcie/aer/built-in.o
>   CC      drivers/net/phy/phy_device.o
>   CC      drivers/net/phy/mdio_bus.o
>   CC      drivers/pci/iov.o
>   LD      drivers/pci/pcie/pcieportdrv.o
>   CC      drivers/pci/pci-acpi.o
>   LD      drivers/pci/pcie/built-in.o
>   CC      drivers/net/phy/fixed.o
>   CC [M]  drivers/mtd/ubi/wl.o
>   LD [M]  drivers/md/dm-log-userspace.o
>   CC      drivers/pci/pci-label.o
>   CC [M]  drivers/md/dm-zero.o
>   CC      drivers/pci/pci-stub.o
>   LD      drivers/pinctrl/built-in.o
>   LD      drivers/pcmcia/pcmcia_core.o
>   LD      drivers/platform/x86/built-in.o
>   CC [M]  drivers/platform/x86/asus-laptop.o
>   CC      drivers/pnp/core.o
>   CC      drivers/pnp/card.o
>   CC      drivers/pnp/driver.o
>   CC [M]  drivers/pci/hotplug/shpchp_pci.o
>   CC [M]  drivers/isdn/hisax/hisax_fcpcipnp.o
>   CC [M]  fs/xfs/xfs_log.o
>   CC [M]  drivers/pci/hotplug/shpchp_sysfs.o
>   CC [M]  fs/xfs/xfs_log_cil.o
>   CC [M]  fs/xfs/xfs_buf_item.o
>   CC [M]  fs/xfs/xfs_extfree_item.o
>   CC [M]  fs/xfs/xfs_inode_item.o
>   CC [M]  fs/xfs/xfs_trans_ail.o
>   CC [M]  fs/xfs/xfs_trans_buf.o
>   CC [M]  drivers/net/ethernet/atheros/atl1e/atl1e_hw.o
>   CC [M]  drivers/net/ethernet/atheros/atl1e/atl1e_ethtool.o
>   CC [M]  drivers/md/dm-raid.o
>   CC [M]  fs/xfs/xfs_trans_extfree.o
>   CC [M]  fs/xfs/xfs_trans_inode.o
>   LD      drivers/pcmcia/pcmcia.o
>   LD      drivers/pcmcia/pcmcia_rsrc.o
>   LD      drivers/pcmcia/built-in.o
>   CC [M]  drivers/net/phy/marvell.o
>   CC [M]  drivers/net/phy/davicom.o
>   CC [M]  drivers/net/phy/cicada.o
>   CC [M]  fs/xfs/xfs_dquot.o
>   CC      drivers/pnp/resource.o
>   CC      drivers/pnp/manager.o
>   CC [M]  drivers/pci/hotplug/shpchp_hpc.o
>   CC      drivers/pnp/support.o
>   CC [M]  drivers/mtd/ubi/attach.o
>   CC [M]  drivers/platform/x86/eeepc-laptop.o
>   LD [M]  drivers/isdn/hisax/hisax.o
>   CC      drivers/pnp/interface.o
>   CC      drivers/pnp/quirks.o
>   LD      drivers/isdn/built-in.o
>   CC      drivers/pnp/system.o
>   CC      drivers/pnp/pnpacpi/core.o
>   CC      drivers/power/power_supply_core.o
>   CC      drivers/power/power_supply_sysfs.o
>   CC      drivers/pnp/pnpacpi/rsparser.o
>   CC      drivers/power/power_supply_leds.o
>   LD [M]  drivers/md/dm-thin-pool.o
>   CC [M]  drivers/net/ethernet/atheros/atl1e/atl1e_param.o
>   CC [M]  drivers/net/phy/lxt.o
>   LD      drivers/md/persistent-data/built-in.o
>   CC [M]  drivers/md/persistent-data/dm-block-manager.o
>   LD      drivers/md/md-mod.o
>   CC [M]  drivers/md/persistent-data/dm-space-map-common.o
>   CC [M]  drivers/platform/x86/msi-laptop.o
>   CC [M]  drivers/platform/x86/compal-laptop.o
>   CC [M]  drivers/platform/x86/dell-laptop.o
>   CC [M]  drivers/md/persistent-data/dm-space-map-disk.o
>   CC [M]  drivers/md/persistent-data/dm-space-map-metadata.o
>   CC [M]  drivers/md/persistent-data/dm-transaction-manager.o
>   CC [M]  drivers/platform/x86/dell-wmi.o
>   CC [M]  drivers/platform/x86/acer-wmi.o
>   LD      drivers/pnp/pnp.o
>   LD [M]  drivers/md/raid456.o
>   CC [M]  drivers/platform/x86/hp-wmi.o
>   CC [M]  drivers/md/persistent-data/dm-btree.o
>   CC [M]  drivers/md/persistent-data/dm-btree-remove.o
>   CC [M]  drivers/pci/hotplug/acpiphp_ibm.o
>   CC [M]  drivers/power/bq27x00_battery.o
>   CC [M]  drivers/power/max17040_battery.o
>   CC [M]  drivers/net/phy/qsemi.o
>   CC [M]  drivers/net/ethernet/broadcom/cnic.o
>   CC [M]  drivers/net/ethernet/broadcom/tg3.o
>   LD      drivers/net/ethernet/broadcom/bnx2x/built-in.o
>   CC [M]  drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o
>   LD      drivers/pnp/pnpacpi/pnp.o
>   CC [M]  drivers/net/phy/smsc.o
>   LD      drivers/pnp/pnpacpi/built-in.o
>   LD      drivers/power/power_supply.o
>   LD [M]  drivers/net/ethernet/atheros/atl1e/atl1e.o
>   LD      drivers/pnp/built-in.o
>   LD      drivers/power/built-in.o
>   LD      drivers/pps/clients/built-in.o
>   LD      drivers/pps/generators/built-in.o
>   CC [M]  drivers/net/phy/vitesse.o
>   CC [M]  drivers/net/phy/broadcom.o
>   CC [M]  drivers/mtd/ubi/misc.o
>   CC [M]  drivers/pps/pps.o
>   CC [M]  drivers/mtd/ubi/debug.o
>   CC [M]  drivers/pps/kapi.o
>   CC [M]  fs/xfs/xfs_dquot_item.o
>   CC [M]  fs/xfs/xfs_trans_dquot.o
>   CC [M]  fs/xfs/xfs_qm_syscalls.o
>   CC [M]  fs/xfs/xfs_qm_bhv.o
>   CC [M]  fs/xfs/xfs_qm.o
>   CC [M]  drivers/platform/x86/sony-laptop.o
>   CC [M]  drivers/platform/x86/thinkpad_acpi.o
>   LD      drivers/pci/hotplug/pci_hotplug.o
>   LD      drivers/pci/hotplug/pciehp.o
>   CC [M]  fs/xfs/xfs_quotaops.o
>   LD      drivers/pci/hotplug/acpiphp.o
>   LD [M]  drivers/pci/hotplug/shpchp.o
>   LD      drivers/pci/hotplug/built-in.o
>   LD      drivers/pci/built-in.o
>   CC [M]  fs/xfs/xfs_acl.o
>   CC [M]  drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.o
>   CC [M]  drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o
>   CC [M]  fs/xfs/xfs_stats.o
>   CC [M]  drivers/pps/sysfs.o
>   CC [M]  drivers/md/persistent-data/dm-btree-spine.o
>   LD      drivers/ptp/built-in.o
>   CC [M]  drivers/ptp/ptp_clock.o
>   CC [M]  fs/xfs/xfs_sysctl.o
>   LD [M]  drivers/mtd/ubi/ubi.o
>   CC [M]  fs/xfs/xfs_ioctl32.o
>   CC [M]  drivers/mtd/ar7part.o
>   LD      drivers/pps/built-in.o
>   LD      drivers/pwm/built-in.o
>   CC [M]  drivers/mtd/mtdchar.o
>   CC [M]  drivers/mtd/mtd_blkdevs.o
>   CC [M]  drivers/mtd/mtdblock.o
>   LD [M]  drivers/pps/pps_core.o
>   CC [M]  drivers/mtd/mtdblock_ro.o
>   CC [M]  drivers/ptp/ptp_chardev.o
>   CC [M]  drivers/net/phy/icplus.o
>   CC [M]  drivers/ptp/ptp_sysfs.o
>   CC [M]  drivers/mtd/ftl.o
>   CC      drivers/regulator/core.o
>   CC      drivers/regulator/dummy.o
>   LD [M]  drivers/md/persistent-data/dm-persistent-data.o
>   LD [M]  drivers/md/dm-mod.o
>   CC      drivers/regulator/fixed-helper.o
>   CC [M]  drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.o
>   LD      drivers/md/built-in.o
>   CC [M]  drivers/regulator/fixed.o
>   CC [M]  drivers/regulator/userspace-consumer.o
>   CC      drivers/rtc/rtc-lib.o
>   LD      drivers/scsi/aacraid/built-in.o
>   CC [M]  drivers/scsi/aacraid/linit.o
>   CC [M]  drivers/scsi/aacraid/aachba.o
>   CC [M]  drivers/scsi/aacraid/commctrl.o
>   CC [M]  drivers/ptp/ptp_pch.o
>   CC [M]  drivers/net/phy/realtek.o
>   CC [M]  drivers/net/phy/et1011c.o
>   LD      drivers/net/ppp/built-in.o
>   CC [M]  drivers/net/ppp/ppp_generic.o
>   CC [M]  drivers/net/ppp/ppp_async.o
>   CC [M]  drivers/net/ppp/ppp_deflate.o
>   CC [M]  drivers/net/ppp/ppp_mppe.o
>   LD [M]  fs/xfs/xfs.o
>   CC [M]  drivers/net/ppp/ppp_synctty.o
>   CC [M]  drivers/net/ppp/pppox.o
>   LD      fs/built-in.o
>   CC [M]  drivers/mtd/inftlcore.o
>   CC      drivers/rtc/hctosys.o
>   CC      drivers/rtc/class.o
>   CC      drivers/rtc/interface.o
>   CC [M]  drivers/mtd/inftlmount.o
>   LD [M]  drivers/ptp/ptp.o
>   CC [M]  drivers/mtd/nftlcore.o
>   CC      drivers/rtc/rtc-dev.o
>   CC [M]  drivers/mtd/nftlmount.o
>   CC [M]  drivers/net/phy/mdio-bitbang.o
>   CC [M]  drivers/mtd/rfd_ftl.o
>   CC [M]  drivers/mtd/ssfdc.o
>   CC      drivers/sfi/sfi_acpi.o
>   CC      drivers/sfi/sfi_core.o
>   CC [M]  drivers/mtd/mtdoops.o
>   LD      drivers/ssb/built-in.o
>   CC [M]  drivers/ssb/main.o
>   LD      drivers/net/ethernet/brocade/built-in.o
>   LD      drivers/net/ethernet/brocade/bna/built-in.o
>   CC [M]  drivers/net/ethernet/brocade/bna/bnad.o
>   LD      drivers/net/ethernet/cadence/built-in.o
>   LD      drivers/net/ethernet/chelsio/built-in.o
>   CC      drivers/rtc/rtc-proc.o
>   LD      drivers/net/ethernet/chelsio/cxgb/built-in.o
>   LD      drivers/net/ethernet/cisco/built-in.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb/cxgb2.o
>   LD      drivers/net/ethernet/cisco/enic/built-in.o
>   CC [M]  drivers/net/ethernet/cisco/enic/enic_main.o
>   CC [M]  drivers/net/ethernet/cisco/enic/vnic_cq.o
>   CC [M]  drivers/net/ethernet/cisco/enic/vnic_intr.o
>   LD      drivers/net/slip/built-in.o
>   CC [M]  drivers/net/slip/slip.o
>   LD      drivers/net/usb/built-in.o
>   CC [M]  drivers/net/usb/catc.o
>   CC [M]  drivers/net/usb/kaweth.o
>   CC [M]  drivers/net/slip/slhc.o
>   CC [M]  drivers/net/phy/national.o
>   CC      drivers/rtc/rtc-sysfs.o
>   LD      drivers/net/vmxnet3/built-in.o
>   CC [M]  drivers/scsi/aacraid/comminit.o
>   CC [M]  drivers/net/vmxnet3/vmxnet3_drv.o
>   CC [M]  drivers/platform/x86/hdaps.o
>   LD      drivers/mtd/mtd.o
>   LD [M]  drivers/mtd/nftl.o
>   LD [M]  drivers/mtd/inftl.o
>   LD      drivers/mtd/built-in.o
>   LD      drivers/net/ethernet/dec/tulip/built-in.o
>   CC [M]  drivers/net/ethernet/dec/tulip/xircom_cb.o
>   CC [M]  drivers/net/ethernet/dec/tulip/dmfe.o
>   CC [M]  drivers/net/ethernet/dec/tulip/winbond-840.o
>   CC [M]  drivers/regulator/lp3971.o
>   LD      drivers/sfi/built-in.o
>   CC [M]  drivers/regulator/max1586.o
>   CC      drivers/rtc/rtc-cmos.o
>   CC [M]  drivers/platform/x86/fujitsu-laptop.o
>   CC [M]  drivers/rtc/rtc-bq4802.o
>   CC [M]  drivers/net/phy/ste10Xp.o
>   CC [M]  drivers/net/ppp/pppoe.o
>   CC [M]  drivers/regulator/tps65023-regulator.o
>   CC [M]  drivers/net/ethernet/dec/tulip/de2104x.o
>   CC [M]  drivers/scsi/aacraid/commsup.o
>   CC [M]  drivers/net/usb/pegasus.o
>   CC [M]  drivers/scsi/aacraid/dpcsup.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb/espi.o
>   CC [M]  drivers/net/ethernet/dec/tulip/eeprom.o
>   CC      drivers/staging/staging.o
>   LD      drivers/staging/media/built-in.o
>   CC [M]  drivers/net/ethernet/brocade/bna/bnad_ethtool.o
>   CC [M]  drivers/ssb/scan.o
>   CC [M]  drivers/ssb/sprom.o
>   LD      drivers/net/phy/libphy.o
>   LD      drivers/net/phy/built-in.o
>   LD      drivers/staging/net/built-in.o
>   CC [M]  drivers/ssb/pci.o
>   LD      drivers/staging/silicom/built-in.o
>   CC [M]  drivers/rtc/rtc-ds1286.o
>   CC [M]  drivers/platform/x86/panasonic-laptop.o
>   LD      drivers/staging/built-in.o
>   CC [M]  drivers/platform/x86/wmi.o
>   CC [M]  drivers/platform/x86/topstar-laptop.o
>   CC [M]  drivers/regulator/tps6507x-regulator.o
>   CC [M]  drivers/net/usb/rtl8150.o
>   CC [M]  drivers/platform/x86/toshiba_acpi.o
>   CC [M]  drivers/platform/x86/intel_ips.o
>   LD      drivers/scsi/aic7xxx/built-in.o
>   SHIPPED drivers/scsi/aic7xxx/aic79xx_seq.h
>   SHIPPED drivers/scsi/aic7xxx/aic79xx_reg.h
>   SHIPPED drivers/scsi/aic7xxx/aic7xxx_seq.h
>   SHIPPED drivers/scsi/aic7xxx/aic7xxx_reg.h
>   CC [M]  drivers/scsi/aic7xxx/aic79xx_core.o
>   CC [M]  drivers/platform/x86/mxm-wmi.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb/tp.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb/pm3393.o
>   CC [M]  drivers/rtc/rtc-ds1307.o
>   CC [M]  drivers/rtc/rtc-ds1374.o
>   CC [M]  drivers/rtc/rtc-ds1511.o
>   LD      drivers/regulator/built-in.o
>   CC [M]  drivers/rtc/rtc-ds1553.o
>   CC [M]  drivers/rtc/rtc-ds1672.o
>   CC [M]  drivers/ssb/pcihost_wrapper.o
>   CC [M]  drivers/ssb/pcmcia.o
>   CC [M]  drivers/scsi/aacraid/rx.o
>   CC [M]  drivers/net/ethernet/cisco/enic/vnic_wq.o
>   CC [M]  drivers/scsi/aacraid/sa.o
>   CC [M]  drivers/net/ethernet/brocade/bna/bnad_debugfs.o
>   CC [M]  drivers/net/ethernet/brocade/bna/bna_enet.o
>   CC [M]  drivers/net/ethernet/brocade/bna/bna_tx_rx.o
>   CC [M]  drivers/net/ethernet/cisco/enic/enic_res.o
>   CC [M]  drivers/net/ethernet/dec/tulip/interrupt.o
>   CC [M]  drivers/scsi/aacraid/rkt.o
>   CC [M]  drivers/scsi/aacraid/nark.o
>   CC [M]  drivers/scsi/aacraid/src.o
>   CC [M]  drivers/rtc/rtc-ds1742.o
>   CC [M]  drivers/rtc/rtc-fm3130.o
>   CC [M]  drivers/net/ethernet/cisco/enic/enic_dev.o
>   LD      drivers/net/ethernet/chelsio/cxgb3/built-in.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.o
>   CC [M]  drivers/net/vmxnet3/vmxnet3_ethtool.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb/sge.o
>   LD      drivers/scsi/aic94xx/built-in.o
>   CC [M]  drivers/scsi/aic94xx/aic94xx_init.o
>   CC [M]  drivers/net/usb/hso.o
>   LD      drivers/platform/built-in.o
>   CC [M]  drivers/scsi/aic94xx/aic94xx_hwi.o
>   CC [M]  drivers/scsi/aic94xx/aic94xx_reg.o
>   CC [M]  drivers/scsi/aic94xx/aic94xx_sds.o
>   CC [M]  drivers/scsi/aic94xx/aic94xx_seq.o
>   CC [M]  drivers/rtc/rtc-isl1208.o
>   CC [M]  drivers/scsi/aic94xx/aic94xx_dump.o
>   CC [M]  drivers/scsi/aic94xx/aic94xx_scb.o
>   CC [M]  drivers/ssb/sdio.o
>   CC [M]  drivers/ssb/driver_chipcommon.o
>   CC [M]  drivers/net/ethernet/dec/tulip/media.o
>   LD [M]  drivers/scsi/aacraid/aacraid.o
>   CC [M]  drivers/net/ethernet/dec/tulip/timer.o
>   CC [M]  drivers/ssb/driver_chipcommon_pmu.o
>   CC [M]  drivers/net/ethernet/cisco/enic/enic_pp.o
>   CC [M]  drivers/ssb/driver_pcicore.o
>   LD [M]  drivers/net/vmxnet3/vmxnet3.o
>   CC [M]  drivers/net/ethernet/cisco/enic/vnic_dev.o
> drivers/scsi/aic94xx/aic94xx_sds.c: In function
> =E2=80=98asd_process_ctrl_a_user=E2=80=99: drivers/scsi/aic94xx/aic94xx_s=
ds.c:985:
> warning: =E2=80=98offs=E2=80=99 may be used uninitialized in this functio=
n LD
> drivers/scsi/arcmsr/built-in.o CC [M]
> drivers/scsi/arcmsr/arcmsr_attr.o CC [M]  drivers/rtc/rtc-m41t80.o
>   CC [M]  drivers/rtc/rtc-m48t35.o
>   CC [M]  drivers/rtc/rtc-m48t59.o
>   CC [M]  drivers/scsi/arcmsr/arcmsr_hba.o
>   CC [M]  drivers/net/ethernet/brocade/bna/bfa_msgq.o
>   CC [M]  drivers/net/ethernet/brocade/bna/bfa_ioc.o
>   CC [M]  drivers/net/ethernet/brocade/bna/bfa_ioc_ct.o
>   CC [M]  drivers/rtc/rtc-max6900.o
>   CC [M]  drivers/rtc/rtc-pcf8563.o
>   CC [M]  drivers/rtc/rtc-pcf8583.o
>   LD      drivers/net/wan/built-in.o
>   CC [M]  drivers/net/wan/hdlc.o
>   CC [M]  drivers/net/ethernet/brocade/bna/bfa_cee.o
>   CC [M]  drivers/scsi/aic94xx/aic94xx_dev.o
>   CC [M]  drivers/net/ethernet/dec/tulip/tulip_core.o
>   CC [M]  drivers/scsi/aic94xx/aic94xx_tmf.o
>   CC [M]  drivers/ssb/b43_pci_bridge.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb/subr.o
>   CC [M]  drivers/scsi/aic94xx/aic94xx_task.o
>   LD      drivers/net/ethernet/chelsio/cxgb4/built-in.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb4/l2t.o
>   CC [M]  drivers/net/wan/hdlc_raw.o
>   CC [M]  drivers/net/wan/hdlc_cisco.o
>   CC [M]  drivers/net/usb/asix_devices.o
>   CC [M]  drivers/net/ethernet/cisco/enic/vnic_rq.o
>   CC [M]  drivers/net/ethernet/cisco/enic/vnic_vic.o
>   CC [M]  drivers/rtc/rtc-rs5c372.o
>   LD [M]  drivers/ssb/ssb.o
>   CC [M]  drivers/rtc/rtc-rx8025.o
>   CC [M]  drivers/scsi/aic7xxx/aic79xx_pci.o
>   CC [M]  drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.o
>   CC [M]  drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb3/ael1002.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb3/vsc8211.o
>   CC [M]  drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb3/t3_hw.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb3/mc5.o
>   LD [M]  drivers/net/ethernet/cisco/enic/enic.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb3/xgmac.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb3/sge.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb3/l2t.o
>   LD [M]  drivers/scsi/aic94xx/aic94xx.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.o
>   CC [M]  drivers/net/wan/hdlc_fr.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb3/aq100x.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb/mv88x201x.o
>   CC [M]  drivers/rtc/rtc-rx8581.o
>   LD [M]  drivers/scsi/arcmsr/arcmsr.o
>   CC [M]  drivers/rtc/rtc-stk17ta8.o
>   CC [M]  drivers/scsi/aic7xxx/aic79xx_osm.o
>   CC [M]  drivers/net/ethernet/brocade/bna/cna_fwimg.o
>   CC [M]  drivers/net/usb/asix_common.o
>   CC [M]  drivers/net/ethernet/dec/tulip/21142.o
>   CC [M]  drivers/net/ethernet/dec/tulip/pnic.o
>   LD      drivers/target/built-in.o
>   CC [M]  drivers/target/target_core_configfs.o
>   CC [M]  drivers/net/usb/ax88172a.o
>   CC [M]  drivers/net/usb/cdc_ether.o
>   CC [M]  drivers/net/usb/cdc_eem.o
>   LD      drivers/net/ethernet/chelsio/cxgb4vf/built-in.o
>   CC [M]  drivers/net/usb/dm9601.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.o
>   CC [M]  drivers/rtc/rtc-v3020.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb/my3126.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb/mv88e1xxx.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb/vsc7326.o
>   LD [M]  drivers/net/ethernet/brocade/bna/bna.o
>   CC [M]  drivers/net/ethernet/dec/tulip/pnic2.o
>   CC [M]  drivers/net/ethernet/dec/tulip/de4x5.o
>   CC [M]  drivers/net/ethernet/dec/tulip/uli526x.o
>   CC [M]  drivers/rtc/rtc-x1205.o
>   CC [M]  drivers/net/wan/hdlc_ppp.o
>   CC [M]  drivers/net/wan/dlci.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb4vf/t4vf_hw.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb4vf/sge.o
>   LD      drivers/net/wimax/built-in.o
>   LD      drivers/net/wimax/i2400m/built-in.o
>   CC [M]  drivers/net/wimax/i2400m/usb-fw.o
>   CC [M]  drivers/net/wimax/i2400m/usb-notif.o
>   LD      drivers/net/wireless/ath/built-in.o
>   CC [M]  drivers/net/wireless/ath/main.o
>   CC [M]  drivers/net/wireless/ath/regd.o
>   CC [M]  drivers/net/wireless/ath/hw.o
>   CC [M]  drivers/net/usb/smsc95xx.o
>   CC [M]  drivers/net/usb/gl620a.o
>   CC [M]  drivers/net/usb/net1080.o
>   LD [M]  drivers/net/ethernet/chelsio/cxgb/cxgb.o
>   CC [M]  drivers/net/usb/plusb.o
>   CC [M]  drivers/net/usb/rndis_host.o
>   CC [M]  drivers/scsi/aic7xxx/aic79xx_proc.o
>   LD      drivers/rtc/rtc-core.o
>   LD      drivers/rtc/built-in.o
>   CC [M]  drivers/net/usb/cdc_subset.o
>   CC [M]  drivers/net/usb/zaurus.o
>   CC [M]  drivers/net/wimax/i2400m/usb-tx.o
>   CC [M]  drivers/net/wimax/i2400m/usb-rx.o
>   CC [M]  drivers/net/usb/mcs7830.o
>   LD [M]  drivers/net/ethernet/chelsio/cxgb3/cxgb3.o
>   CC [M]  drivers/net/usb/usbnet.o
>   LD      drivers/net/wireless/b43/built-in.o
>   CC [M]  drivers/net/wireless/b43/main.o
>   CC [M]  drivers/net/wireless/b43/bus.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb4/t4_hw.o
>   CC [M]  drivers/net/ethernet/chelsio/cxgb4/sge.o
>   CC [M]  drivers/net/wimax/i2400m/usb.o
>   CC [M]  drivers/net/wimax/i2400m/control.o
>   CC [M]  drivers/net/wireless/b43/tables.o
>   CC [M]  drivers/net/wireless/b43/phy_common.o
>   CC [M]  drivers/scsi/aic7xxx/aic79xx_osm_pci.o
>   CC [M]  drivers/scsi/aic7xxx/aic7xxx_core.o
>   CC [M]  drivers/net/wireless/b43/phy_g.o
>   CC [M]  drivers/net/wireless/b43/phy_a.o
>   CC [M]  drivers/net/wireless/ath/key.o
>   LD      drivers/net/wireless/ath/ath5k/built-in.o
>   CC [M]  drivers/net/wireless/ath/ath5k/caps.o
>   LD [M]  drivers/net/ethernet/broadcom/bnx2x/bnx2x.o
>   LD      drivers/net/wireless/ath/ath9k/built-in.o
>   CC [M]  drivers/net/wireless/ath/ath9k/beacon.o
>   LD      drivers/net/wireless/ath/carl9170/built-in.o
>   CC [M]  drivers/net/wireless/ath/carl9170/main.o
>   CC [M]  drivers/target/target_core_device.o
>   CC [M]  drivers/target/target_core_fabric_configfs.o
>   CC [M]  drivers/net/wireless/ath/carl9170/usb.o
>   CC [M]  drivers/net/wireless/ath/carl9170/cmd.o
>   CC [M]  drivers/net/wireless/ath/carl9170/mac.o
>   CC [M]  drivers/net/wireless/ath/carl9170/phy.o
>   CC [M]  drivers/net/wireless/ath/carl9170/led.o
>   LD      drivers/scsi/be2iscsi/built-in.o
>   CC [M]  drivers/scsi/be2iscsi/be_iscsi.o
>   CC [M]  drivers/scsi/be2iscsi/be_main.o
>   CC [M]  drivers/net/wireless/ath/ath5k/initvals.o
>   LD [M]  drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf.o
>   CC [M]  drivers/scsi/be2iscsi/be_mgmt.o
>   CC [M]  drivers/scsi/be2iscsi/be_cmds.o
>   CC [M]  drivers/net/wireless/ath/carl9170/fw.o
>   CC [M]  drivers/net/wireless/ath/ath9k/gpio.o
>   CC [M]  drivers/net/wimax/i2400m/driver.o
>   CC [M]  drivers/net/wireless/b43/phy_lp.o
>   CC [M]  drivers/net/wireless/b43/tables_lpphy.o
>   CC [M]  drivers/net/wireless/b43/sysfs.o
>   LD      drivers/net/wireless/b43legacy/built-in.o
>   CC [M]  drivers/net/wireless/b43legacy/main.o
>   CC [M]  drivers/net/wireless/b43legacy/ilt.o
>   CC [M]  drivers/net/wireless/ath/ath5k/eeprom.o
>   LD [M]  drivers/net/ethernet/dec/tulip/tulip.o
>   LD      drivers/net/ethernet/dec/built-in.o
>   CC [M]  drivers/net/usb/int51x1.o
>   CC [M]  drivers/net/wireless/ath/ath5k/gpio.o
>   CC [M]  drivers/net/wireless/ath/ath5k/desc.o
>   CC [M]  drivers/net/wireless/b43legacy/phy.o
>   LD      drivers/net/ethernet/dlink/built-in.o
>   CC [M]  drivers/net/ethernet/dlink/dl2k.o
>   CC [M]  drivers/net/ethernet/dlink/sundance.o
>   LD [M]  drivers/net/wireless/ath/ath.o
>   CC [M]  drivers/net/dummy.o
>   CC [M]  drivers/net/ifb.o
>   CC [M]  drivers/net/wireless/ath/carl9170/tx.o
>   CC [M]  drivers/net/wireless/ath/ath9k/init.o
>   CC [M]  drivers/net/wireless/ath/ath9k/main.o
>   CC [M]  drivers/net/wireless/ath/ath9k/recv.o
>   CC [M]  drivers/net/wireless/ath/ath9k/xmit.o
>   CC      drivers/thermal/thermal_sys.o
>   CC      drivers/thermal/step_wise.o
>   CC [M]  drivers/net/usb/cdc-phonet.o
>   CC [M]  drivers/target/target_core_fabric_lib.o
>   CC [M]  drivers/net/usb/sierra_net.o
>   CC [M]  drivers/net/usb/cdc_ncm.o
>   LD [M]  drivers/net/ethernet/chelsio/cxgb4/cxgb4.o
>   CC [M]  drivers/net/wireless/b43/xmit.o
>   CC [M]  drivers/net/wireless/b43/lo.o
>   CC [M]  drivers/net/wireless/b43/wa.o
>   CC [M]  drivers/net/wimax/i2400m/fw.o
>   CC [M]  drivers/net/wimax/i2400m/op-rfkill.o
>   CC [M]  drivers/net/wimax/i2400m/sysfs.o
>   CC [M]  drivers/scsi/aic7xxx/aic7xxx_93cx6.o
>   CC [M]  drivers/net/wimax/i2400m/netdev.o
>   CC [M]  drivers/net/wimax/i2400m/tx.o
>   CC [M]  drivers/net/wireless/b43/dma.o
>   CC [M]  drivers/net/wireless/ath/ath5k/dma.o
>   CC [M]  drivers/net/wireless/ath/ath5k/qcu.o
>   CC [M]  drivers/net/wireless/b43/pio.o
>   LD      drivers/net/ethernet/emulex/built-in.o
>   CC [M]  drivers/net/wireless/b43/rfkill.o
>   LD      drivers/net/ethernet/emulex/benet/built-in.o
>   CC [M]  drivers/net/ethernet/emulex/benet/be_main.o
>   CC [M]  drivers/net/wireless/b43/leds.o
>   CC [M]  drivers/net/wireless/b43/pcmcia.o
>   CC [M]  drivers/net/wireless/ath/carl9170/rx.o
>   LD [M]  drivers/net/usb/asix.o
>   CC [M]  drivers/net/wireless/b43/sdio.o
>   LD      drivers/net/wireless/brcm80211/built-in.o
>   LD      drivers/net/wireless/brcm80211/brcmsmac/built-in.o
>   LD      drivers/net/wireless/hostap/built-in.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/mac80211_if.o
>   CC [M]  drivers/net/wireless/hostap/hostap_80211_rx.o
>   CC [M]  drivers/target/target_core_hba.o
>   CC [M]  drivers/target/target_core_pr.o
>   CC [M]  drivers/scsi/aic7xxx/aic7xxx_pci.o
>   CC [M]  drivers/target/target_core_alua.o
>   LD [M]  drivers/scsi/be2iscsi/be2iscsi.o
>   LD      drivers/thermal/built-in.o
>   CC [M]  drivers/target/target_core_tmr.o
>   CC [M]  drivers/target/target_core_tpg.o
>   CC [M]  drivers/target/target_core_transport.o
>   CC [M]  drivers/net/wireless/b43legacy/radio.o
>   CC [M]  drivers/target/target_core_sbc.o
>   CC [M]  drivers/target/target_core_spc.o
>   CC [M]  drivers/target/target_core_ua.o
>   CC [M]  drivers/net/wireless/ath/ath9k/link.o
>   CC [M]  drivers/net/wireless/ath/ath9k/antenna.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/ucode_loader.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/ampdu.o
>   CC [M]  drivers/net/wireless/ath/ath5k/pcu.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/antsel.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/channel.o
>   CC [M]  drivers/net/wimax/i2400m/rx.o
>   CC [M]  drivers/net/wireless/ath/ath5k/phy.o
>   LD [M]  drivers/net/wireless/ath/carl9170/carl9170.o
>   CC [M]  drivers/net/wireless/b43/debugfs.o
>   CC [M]  drivers/net/wireless/ath/ath5k/reset.o
>   CC      drivers/tty/tty_io.o
>   CC      drivers/tty/n_tty.o
>   CC [M]  drivers/net/wireless/hostap/hostap_80211_tx.o
>   CC [M]  drivers/scsi/aic7xxx/aic7xxx_osm.o
>   CC [M]  drivers/scsi/aic7xxx/aic7xxx_proc.o
>   CC [M]  drivers/scsi/aic7xxx/aic7xxx_osm_pci.o
>   LD      drivers/net/wireless/brcm80211/brcmutil/built-in.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmutil/utils.o
>   CC [M]  drivers/net/wireless/ath/ath9k/mci.o
>   CC [M]  drivers/net/wireless/ath/ath9k/rc.o
>   CC [M]  drivers/net/wireless/ath/ath9k/pci.o
>   CC [M]  drivers/net/wireless/ath/ath9k/wow.o
>   LD      drivers/net/wireless/ipw2x00/built-in.o
>   CC [M]  drivers/net/wireless/ipw2x00/ipw2100.o
>   LD      drivers/net/wireless/iwlegacy/built-in.o
>   CC [M]  drivers/net/wireless/iwlegacy/3945-mac.o
>   CC [M]  drivers/net/wireless/b43legacy/sysfs.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/main.o
>   LD [M]  drivers/net/wireless/b43/b43.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/phy_shim.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/pmu.o
>   CC [M]  drivers/net/wireless/b43legacy/xmit.o
>   CC [M]  drivers/net/wireless/b43legacy/rfkill.o
>   CC [M]  drivers/net/wireless/b43legacy/leds.o
>   CC [M]  drivers/net/wireless/b43legacy/debugfs.o
>   CC [M]  drivers/net/wimax/i2400m/debugfs.o
>   CC [M]  drivers/net/wireless/hostap/hostap_ap.o
>   LD      drivers/scsi/bfa/built-in.o
>   CC [M]  drivers/scsi/bfa/bfad.o
>   CC [M]  drivers/scsi/bfa/bfad_im.o
>   CC [M]  drivers/scsi/bfa/bfad_attr.o
>   LD [M]  drivers/net/wireless/brcm80211/brcmutil/brcmutil.o
>   CC [M]  drivers/scsi/bfa/bfad_debugfs.o
>   CC [M]  drivers/scsi/bfa/bfad_bsg.o
>   CC [M]  drivers/scsi/bfa/bfa_ioc.o
>   CC [M]  drivers/net/wireless/ath/ath5k/attach.o
>   CC [M]  drivers/target/target_core_rd.o
>   CC [M]  drivers/net/macvlan.o
>   CC [M]  drivers/net/macvtap.o
>   CC [M]  drivers/net/mii.o
>   CC [M]  drivers/net/mdio.o
>   CC [M]  drivers/net/wireless/ath/ath5k/base.o
>   CC [M]  drivers/net/wireless/ath/ath9k/common.o
>   LD [M]  drivers/scsi/aic7xxx/aic7xxx.o
>   CC [M]  drivers/net/wireless/ath/ath5k/led.o
>   CC [M]  drivers/net/ethernet/emulex/benet/be_cmds.o
>   LD [M]  drivers/scsi/aic7xxx/aic79xx.o
>   CC [M]  drivers/net/wireless/b43legacy/dma.o
>   CC [M]  drivers/net/wireless/b43legacy/pio.o
>   LD [M]  drivers/net/wimax/i2400m/i2400m.o
>   LD [M]  drivers/net/wimax/i2400m/i2400m-usb.o
>   LD      drivers/scsi/bnx2fc/built-in.o
>   CC [M]  drivers/scsi/bnx2fc/bnx2fc_els.o
>   CC      drivers/tty/tty_ioctl.o
>   CC      drivers/tty/tty_ldisc.o
>   CC      drivers/tty/tty_buffer.o
>   CC [M]  drivers/target/target_core_stat.o
>   CC      drivers/tty/tty_port.o
>   CC [M]  drivers/target/target_core_iblock.o
>   CC [M]  drivers/target/target_core_file.o
>   CC [M]  drivers/target/target_core_pscsi.o
>   LD      drivers/target/loopback/built-in.o
>   CC [M]  drivers/target/loopback/tcm_loop.o
>   CC [M]  drivers/net/wireless/ath/ath9k/htc_hst.o
>   CC [M]  drivers/net/wireless/ath/ath9k/hif_usb.o
>   CC [M]  drivers/net/wireless/iwlegacy/3945.o
>   CC [M]  drivers/net/wireless/iwlegacy/3945-rs.o
>   CC [M]  drivers/net/wireless/iwlegacy/4965.o
>   CC [M]  drivers/net/wireless/iwlegacy/4965-mac.o
>   CC [M]  drivers/scsi/bnx2fc/bnx2fc_fcoe.o
>   CC [M]  drivers/scsi/bnx2fc/bnx2fc_hwi.o
>   LD [M]  drivers/net/wireless/b43legacy/b43legacy.o
>   CC [M]  drivers/scsi/bnx2fc/bnx2fc_io.o
>   CC [M]  drivers/net/wireless/iwlegacy/4965-rs.o
>   CC      drivers/tty/tty_mutex.o
>   CC      drivers/tty/pty.o
>   CC [M]  drivers/net/wireless/hostap/hostap_info.o
>   CC [M]  drivers/net/wireless/ath/ath5k/rfkill.o
>   CC [M]  drivers/net/wireless/ath/ath5k/ani.o
>   CC [M]  drivers/net/wireless/hostap/hostap_ioctl.o
>   CC [M]  drivers/net/wireless/hostap/hostap_main.o
>   CC [M]  drivers/net/wireless/ath/ath5k/sysfs.o
>   CC [M]  drivers/net/wireless/ath/ath5k/mac80211-ops.o
>   CC [M]  drivers/net/wireless/ath/ath5k/pci.o
>   CC [M]  drivers/net/wireless/ath/ath9k/wmi.o
>   LD      drivers/target/tcm_fc/built-in.o
>   CC [M]  drivers/target/tcm_fc/tfc_cmd.o
>   CC [M]  drivers/target/tcm_fc/tfc_conf.o
>   CC      drivers/tty/tty_audit.o
>   CC      drivers/tty/sysrq.o
>   CC [M]  drivers/net/wireless/iwlegacy/4965-calib.o
>   CC      drivers/tty/hvc/hvc_console.o
>   CC [M]  drivers/net/ethernet/emulex/benet/be_ethtool.o
>   CC [M]  drivers/net/wireless/ipw2x00/ipw2200.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/rate.o
>   CC [M]  drivers/net/wireless/ipw2x00/libipw_module.o
>   CC [M]  drivers/net/wireless/ipw2x00/libipw_tx.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/stf.o
>   CC [M]  drivers/net/ethernet/emulex/benet/be_roce.o
>   LD      drivers/net/ethernet/fujitsu/built-in.o
>   CC [M]  drivers/net/ethernet/fujitsu/fmvj18x_cs.o
>   CC [M]  drivers/target/tcm_fc/tfc_io.o
>   CC [M]  drivers/scsi/bnx2fc/bnx2fc_tgt.o
>   CC [M]  drivers/net/wireless/ath/ath9k/htc_drv_txrx.o
>   CC [M]  drivers/net/wireless/ath/ath9k/htc_drv_main.o
>   LD [M]  drivers/net/wireless/ath/ath5k/ath5k.o
>   CC [M]  drivers/net/wireless/ath/ath9k/htc_drv_beacon.o
>   CC [M]  drivers/net/wireless/ath/ath9k/htc_drv_init.o
>   CC [M]  drivers/target/tcm_fc/tfc_sess.o
>   CC [M]  drivers/net/wireless/ath/ath9k/htc_drv_gpio.o
>   CC [M]  drivers/net/wireless/ath/ath9k/ar9002_hw.o
>   CC [M]  drivers/net/wireless/ath/ath9k/ar9003_hw.o
>   CC [M]  drivers/net/wireless/ath/ath9k/hw.o
>   CC [M]  drivers/net/wireless/ipw2x00/libipw_rx.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/aiutils.o
>   CC [M]  drivers/net/wireless/ipw2x00/libipw_wx.o
>   LD      drivers/tty/hvc/built-in.o
>   LD      drivers/tty/ipwireless/built-in.o
>   CC [M]  drivers/tty/ipwireless/hardware.o
>   CC [M]  drivers/tty/ipwireless/main.o
>   CC [M]  drivers/net/wireless/hostap/hostap_proc.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/phy/phy_cmn.o
>   CC [M]  drivers/scsi/bfa/bfa_ioc_cb.o
>   CC [M]  drivers/scsi/bfa/bfa_ioc_ct.o
>   CC [M]  drivers/scsi/bfa/bfa_hw_cb.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/phy/phy_lcn.o
>   LD [M]  drivers/net/ethernet/emulex/benet/be2net.o
>   LD      drivers/net/ethernet/hp/built-in.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/phy/phy_n.o
>   LD      drivers/net/ethernet/i825xx/built-in.o
>   LD      drivers/net/ethernet/icplus/built-in.o
>   CC [M]  drivers/net/ethernet/icplus/ipg.o
>   CC [M]  drivers/net/netconsole.o
>   LD [M]  drivers/target/tcm_fc/tcm_fc.o
>   LD      drivers/scsi/bnx2i/built-in.o
>   LD [M]  drivers/target/target_core_mod.o
>   LD      drivers/scsi/cxgbi/built-in.o
>   CC [M]  drivers/scsi/bnx2i/bnx2i_init.o
>   CC [M]  drivers/scsi/cxgbi/libcxgbi.o
>   LD      drivers/scsi/cxgbi/cxgb3i/built-in.o
>   CC [M]  drivers/scsi/cxgbi/cxgb3i/cxgb3i.o
>   LD      drivers/net/wireless/iwlwifi/built-in.o
>   LD      drivers/scsi/cxgbi/cxgb4i/built-in.o
>   CC [M]  drivers/scsi/cxgbi/cxgb4i/cxgb4i.o
>   CC [M]  drivers/net/wireless/iwlwifi/iwl-io.o
>   CC      drivers/scsi/device_handler/scsi_dh.o
>   CC [M]  drivers/scsi/bnx2fc/bnx2fc_debug.o
>   CC [M]  drivers/scsi/device_handler/scsi_dh_rdac.o
>   CC [M]  drivers/scsi/device_handler/scsi_dh_hp_sw.o
>   CC [M]  drivers/scsi/device_handler/scsi_dh_emc.o
>   CC [M]  drivers/tty/ipwireless/network.o
>   CC [M]  drivers/tty/ipwireless/tty.o
>   CC [M]  drivers/net/wireless/iwlegacy/common.o
>   CC [M]  drivers/net/wireless/hostap/hostap_cs.o
>   CC [M]  drivers/scsi/bfa/bfa_hw_ct.o
>   CC [M]  drivers/scsi/bfa/bfa_fcs.o
>   CC [M]  drivers/scsi/bfa/bfa_fcs_lport.o
>   LD [M]  drivers/scsi/bnx2fc/bnx2fc.o
>   CC [M]  drivers/scsi/bnx2i/bnx2i_hwi.o
>   CC [M]  drivers/scsi/bfa/bfa_fcs_rport.o
>   CC [M]  drivers/net/wireless/hostap/hostap_plx.o
>   CC [M]  drivers/net/wireless/hostap/hostap_pci.o
>   CC [M]  drivers/net/tun.o
>   CC [M]  drivers/net/veth.o
>   LD [M]  drivers/net/wireless/hostap/hostap.o
>   LD      drivers/net/ethernet/intel/built-in.o
>   CC [M]  drivers/net/ethernet/intel/e100.o
>   LD [M]  drivers/tty/ipwireless/ipwireless.o
>   LD      drivers/net/wireless/libertas/built-in.o
>   CC [M]  drivers/net/wireless/libertas/cfg.o
>   CC      drivers/tty/serial/serial_core.o
>   CC [M]  drivers/scsi/device_handler/scsi_dh_alua.o
>   CC [M]  drivers/net/wireless/iwlwifi/iwl-drv.o
>   CC [M]  drivers/net/wireless/iwlwifi/iwl-debug.o
>   CC [M]  drivers/net/wireless/iwlwifi/iwl-notif-wait.o
>   CC [M]  drivers/net/wireless/ath/ath9k/ar9003_phy.o
>   CC [M]  drivers/net/wireless/ath/ath9k/ar9002_phy.o
>   CC [M]  drivers/net/wireless/ath/ath9k/ar5008_phy.o
>   CC [M]  drivers/net/wireless/ath/ath9k/ar9002_calib.o
>   CC [M]  drivers/net/wireless/iwlwifi/iwl-eeprom-read.o
>   LD      drivers/scsi/device_handler/built-in.o
>   CC [M]  drivers/net/wireless/iwlwifi/iwl-eeprom-parse.o
>   CC [M]  drivers/net/wireless/ath/ath9k/ar9003_calib.o
>   CC [M]  drivers/net/wireless/ath/ath9k/ar9003_rtt.o
>   CC [M]  drivers/scsi/bnx2i/bnx2i_iscsi.o
>   CC [M]  drivers/scsi/bnx2i/bnx2i_sysfs.o
>   CC [M]  drivers/net/wireless/iwlwifi/pcie/drv.o
>   CC [M]  drivers/net/wireless/iwlwifi/pcie/rx.o
>   CC [M]  drivers/net/wireless/libertas/cmd.o
>   CC      drivers/tty/serial/8250/8250.o
>   LD      drivers/tty/serial/jsm/built-in.o
>   CC [M]  drivers/tty/serial/jsm/jsm_driver.o
>   CC [M]  drivers/tty/serial/jsm/jsm_neo.o
>   CC [M]  drivers/tty/serial/jsm/jsm_tty.o
>   CC      drivers/tty/serial/8250/8250_pnp.o
>   CC [M]  drivers/net/wireless/ath/ath9k/calib.o
>   LD      drivers/net/ethernet/intel/e1000/built-in.o
>   CC [M]  drivers/net/ethernet/intel/e1000/e1000_main.o
>   CC [M]  drivers/net/ethernet/intel/e1000/e1000_hw.o
>   CC [M]  drivers/net/ethernet/intel/e1000/e1000_ethtool.o
>   CC [M]  drivers/net/ethernet/intel/e1000/e1000_param.o
>   CC [M]  drivers/net/wireless/ath/ath9k/eeprom.o
>   LD      drivers/uio/built-in.o
>   LD      drivers/usb/atm/built-in.o
>   CC [M]  drivers/uio/uio.o
>   CC [M]  drivers/usb/atm/cxacru.o
>   CC [M]  drivers/usb/atm/speedtch.o
>   CC [M]  drivers/usb/atm/ueagle-atm.o
>   CC [M]  drivers/uio/uio_cif.o
>   CC [M]  drivers/uio/uio_pdrv.o
>   CC [M]  drivers/usb/atm/usbatm.o
>   CC [M]  drivers/net/wireless/iwlwifi/pcie/tx.o
>   CC [M]  drivers/net/wireless/iwlwifi/pcie/trans.o
>   CC [M]  drivers/net/wireless/iwlwifi/pcie/1000.o
>   CC [M]  drivers/net/wireless/ipw2x00/libipw_geo.o
>   LD [M]  drivers/tty/serial/jsm/jsm.o
>   CC [M]  drivers/net/wireless/iwlwifi/pcie/2000.o
>   CC [M]  drivers/usb/atm/xusbatm.o
>   CC [M]  drivers/net/wireless/iwlwifi/pcie/5000.o
>   CC [M]  drivers/net/wireless/iwlwifi/pcie/6000.o
>   LD [M]  drivers/scsi/bnx2i/bnx2i.o
>   LD      drivers/net/wireless/iwlwifi/dvm/built-in.o
>   CC [M]  drivers/scsi/bfa/bfa_fcs_fcpim.o
>   CC [M]  drivers/net/wireless/iwlwifi/dvm/main.o
>   CC [M]  drivers/net/wireless/ath/ath9k/eeprom_def.o
>   CC [M]  drivers/uio/uio_pdrv_genirq.o
>   LD [M]  drivers/net/wireless/iwlegacy/iwlegacy.o
>   LD [M]  drivers/net/wireless/iwlegacy/iwl4965.o
>   LD [M]  drivers/net/wireless/iwlegacy/iwl3945.o
>   CC [M]  drivers/net/wireless/ath/ath9k/eeprom_4k.o
>   LD      drivers/uwb/built-in.o
>   CC [M]  drivers/uwb/umc-bus.o
>   CC [M]  drivers/uwb/umc-dev.o
>   CC [M]  drivers/net/wireless/ath/ath9k/eeprom_9287.o
>   LD      drivers/vhost/built-in.o
>   CC [M]  drivers/vhost/vhost.o
>   CC [M]  drivers/vhost/net.o
>   CC [M]  drivers/uio/uio_aec.o
>   CC [M]  drivers/uio/uio_sercos3.o
>   CC      drivers/tty/serial/8250/8250_pci.o
>   CC [M]  drivers/net/wireless/libertas/cmdresp.o
>   CC [M]  drivers/net/wireless/libertas/debugfs.o
>   CC [M]  drivers/net/wireless/libertas/ethtool.o
>   CC [M]  drivers/net/wireless/libertas/main.o
>   LD [M]  drivers/net/wireless/ipw2x00/libipw.o
>   CC [M]  drivers/net/wireless/libertas/rx.o
>   CC [M]  drivers/net/wireless/libertas/tx.o
>   CC [M]  drivers/uwb/umc-drv.o
>   CC [M]  drivers/scsi/bfa/bfa_fcbuild.o
>   CC [M]  drivers/uio/uio_pci_generic.o
>   CC      drivers/tty/serial/8250/8250_early.o
>   CC [M]  drivers/tty/serial/8250/serial_cs.o
>   LD      drivers/net/ethernet/intel/e1000e/built-in.o
>   CC [M]  drivers/net/ethernet/intel/e1000e/82571.o
>   LD      drivers/usb/class/built-in.o
>   CC [M]  drivers/usb/class/cdc-acm.o
>   CC [M]  drivers/net/wireless/ath/ath9k/ani.o
>   CC [M]  drivers/net/wireless/ath/ath9k/mac.o
>   CC [M]  drivers/net/wireless/iwlwifi/dvm/rs.o
>   CC [M]  drivers/net/wireless/iwlwifi/dvm/mac80211.o
>   LD      drivers/net/ethernet/marvell/built-in.o
>   CC [M]  drivers/net/ethernet/marvell/skge.o
>   CC [M]  drivers/uwb/address.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/phy/phytbl_lcn.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/phy/phytbl_n.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/phy/phy_qmath.o
>   CC [M]  drivers/uwb/allocator.o
>   LD      drivers/net/ethernet/intel/igb/built-in.o
>   CC [M]  drivers/net/ethernet/intel/igb/igb_main.o
>   CC [M]  drivers/uwb/beacon.o
>   CC [M]  drivers/net/wireless/libertas/firmware.o
>   CC [M]  drivers/net/wireless/libertas/if_cs.o
>   LD [M]  drivers/vhost/vhost_net.o
>   CC [M]  drivers/net/wireless/libertas/if_sdio.o
>   CC [M]  drivers/net/ethernet/intel/igb/igb_ethtool.o
>   CC [M]  drivers/net/ethernet/intel/igb/e1000_82575.o
>   LD      drivers/net/ethernet/mellanox/built-in.o
>   LD      drivers/tty/serial/8250/8250_core.o
>   LD      drivers/net/ethernet/micrel/built-in.o
>   LD      drivers/tty/serial/8250/built-in.o
>   CC [M]  drivers/net/ethernet/intel/igb/e1000_mac.o
>   LD      drivers/net/ethernet/mellanox/mlx4/built-in.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/alloc.o
>   LD      drivers/tty/serial/built-in.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/dma.o
>   CC      drivers/tty/vt/vt_ioctl.o
>   CC      drivers/tty/vt/vc_screen.o
>   LD [M]  drivers/net/ethernet/intel/e1000/e1000.o
>   CC      drivers/tty/vt/selection.o
>   CC      drivers/tty/vt/keyboard.o
>   CC      drivers/tty/vt/consolemap.o
>   CC [M]  drivers/scsi/bfa/bfa_port.o
>   CC [M]  drivers/scsi/bfa/bfa_fcpim.o
>   CC [M]  drivers/scsi/bfa/bfa_core.o
>   CC [M]  drivers/uwb/driver.o
>   CC [M]  drivers/usb/class/usblp.o
>   CC [M]  drivers/usb/class/cdc-wdm.o
>   CC [M]  drivers/usb/class/usbtmc.o
>   CC      drivers/usb/core/usb.o
>   CC [M]  drivers/net/wireless/ath/ath9k/ar9002_mac.o
>   CC [M]  drivers/net/ethernet/intel/e1000e/ich8lan.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/catas.o
>   CC [M]  drivers/uwb/drp.o
>   CC [M]  drivers/net/ethernet/intel/e1000e/80003es2lan.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/cmd.o
>   CC [M]  drivers/net/ethernet/intel/e1000e/mac.o
>   CC [M]  drivers/net/wireless/libertas/if_usb.o
>   CC [M]  drivers/net/wireless/iwlwifi/dvm/ucode.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/brcms_trace_events.o
>   CC [M]  drivers/net/wireless/iwlwifi/dvm/tx.o
>   CC [M]  drivers/net/wireless/brcm80211/brcmsmac/debug.o
>   LD      drivers/net/ethernet/intel/igbvf/built-in.o
>   CC [M]  drivers/net/ethernet/intel/igbvf/vf.o
>   CC [M]  drivers/net/ethernet/intel/igbvf/mbx.o
>   LD      drivers/net/ethernet/intel/ixgb/built-in.o
>   CC [M]  drivers/net/ethernet/intel/ixgb/ixgb_main.o
>   CC [M]  drivers/uwb/drp-avail.o
>   LD      drivers/net/ethernet/intel/ixgbe/built-in.o
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_main.o
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_common.o
>   CC [M]  drivers/uwb/drp-ie.o
>   CC [M]  drivers/uwb/est.o
>   CC      drivers/usb/core/hub.o
>   CC [M]  drivers/net/ethernet/marvell/sky2.o
>   CONMK   drivers/tty/vt/consolemap_deftbl.c
>   CC      drivers/tty/vt/vt.o
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.o
>   CC [M]  drivers/net/wireless/ath/ath9k/ar9003_mac.o
>   CC [M]  drivers/net/ethernet/intel/igbvf/ethtool.o
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.o
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_82598.o
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.o
>   CC [M]  drivers/net/ethernet/intel/e1000e/manage.o
>   CC [M]  drivers/net/ethernet/intel/e1000e/nvm.o
>   LD [M]  drivers/net/wireless/brcm80211/brcmsmac/brcmsmac.o
>   CC      drivers/usb/early/ehci-dbgp.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/cq.o
>   CC [M]  drivers/uwb/ie.o
>   CC [M]  drivers/uwb/ie-rcv.o
>   LD [M]  drivers/net/wireless/libertas/libertas.o
>   LD [M]  drivers/net/wireless/libertas/usb8xxx.o
>   LD [M]  drivers/net/wireless/libertas/libertas_cs.o
>   LD [M]  drivers/net/wireless/libertas/libertas_sdio.o
>   CC      drivers/usb/host/pci-quirks.o
>   CC [M]  drivers/net/wireless/iwlwifi/dvm/lib.o
>   CC      drivers/usb/host/ehci-hcd.o
>   CC      drivers/usb/host/ehci-pci.o
>   CC [M]  drivers/net/ethernet/intel/igbvf/netdev.o
>   LD      drivers/net/wireless/libertas_tf/built-in.o
>   CC [M]  drivers/net/wireless/libertas_tf/main.o
>   CC [M]  drivers/uwb/lc-dev.o
>   CC [M]  drivers/uwb/lc-rc.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/eq.o
>   CC [M]  drivers/uwb/neh.o
>   CC [M]  drivers/net/ethernet/intel/e1000e/phy.o
>   CC [M]  drivers/net/ethernet/intel/igb/e1000_nvm.o
>   CC [M]  drivers/net/wireless/ath/ath9k/ar9003_eeprom.o
>   LD      drivers/usb/early/built-in.o
>   CC [M]  drivers/net/ethernet/intel/e1000e/param.o
>   CC      drivers/usb/core/hcd.o
>   LD      drivers/usb/image/built-in.o
>   CC [M]  drivers/net/ethernet/intel/ixgb/ixgb_hw.o
>   CC [M]  drivers/usb/image/mdc800.o
>   CC [M]  drivers/usb/image/microtek.o
>   CC      drivers/usb/host/ohci-hcd.o
>   CC      drivers/usb/host/uhci-hcd.o
>   CC [M]  drivers/tty/n_hdlc.o
>   CC [M]  drivers/usb/host/isp1362-hcd.o
>   CC [M]  drivers/net/wireless/iwlwifi/dvm/calib.o
>   CC [M]  drivers/scsi/bfa/bfa_svc.o
>   CC [M]  drivers/net/wireless/iwlwifi/dvm/tt.o
>   CC [M]  drivers/net/wireless/iwlwifi/dvm/sta.o
>   CC [M]  drivers/net/wireless/iwlwifi/dvm/rx.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/fw.o
>   CC [M]  drivers/net/wireless/libertas_tf/cmd.o
>   CC [M]  drivers/net/ethernet/intel/igb/e1000_phy.o
>   CC [M]  drivers/uwb/pal.o
>   CC [M]  drivers/net/ethernet/intel/ixgb/ixgb_ee.o
>   CC [M]  drivers/net/ethernet/intel/ixgb/ixgb_ethtool.o
>   CC [M]  drivers/uwb/radio.o
>   CC [M]  drivers/uwb/reset.o
>   SHIPPED drivers/tty/vt/defkeymap.c
>   CC      drivers/tty/vt/consolemap_deftbl.o
>   LD [M]  drivers/net/wireless/iwlwifi/iwlwifi.o
>   CC [M]  drivers/uwb/rsv.o
>   CC      drivers/tty/vt/defkeymap.o
>   CC [M]  drivers/net/wireless/iwlwifi/dvm/power.o
>   CC [M]  drivers/net/wireless/libertas_tf/if_usb.o
>   CC [M]  drivers/net/ethernet/intel/e1000e/ethtool.o
>   LD [M]  drivers/net/ethernet/intel/igbvf/igbvf.o
>   CC [M]  drivers/net/ethernet/intel/e1000e/netdev.o
>   LD      drivers/tty/vt/built-in.o
>   CC [M]  drivers/net/wireless/iwlwifi/dvm/scan.o
>   CC [M]  drivers/tty/cyclades.o
>   CC [M]  drivers/tty/nozomi.o
>   CC      drivers/video/fb_notify.o
>   CC      drivers/usb/core/urb.o
>   CC      drivers/usb/core/message.o
>   CC      drivers/video/fbmem.o
>   CC      drivers/video/fbmon.o
>   CC      drivers/usb/core/driver.o
>   CC [M]  drivers/net/ethernet/intel/ixgb/ixgb_param.o
>   CC      drivers/video/fbcmap.o
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.o
>   CC [M]  drivers/uwb/scan.o
>   CC [M]  drivers/uwb/uwb-debug.o
>   CC [M]  drivers/net/ethernet/intel/igb/e1000_mbx.o
>   CC [M]  drivers/uwb/uwbd.o
>   CC [M]  drivers/net/ethernet/intel/igb/e1000_i210.o
>   CC [M]  drivers/net/ethernet/intel/igb/igb_ptp.o
>   CC      drivers/video/fbsysfs.o
>   CC [M]  drivers/usb/host/xhci.o
>   CC [M]  drivers/uwb/whci.o
>   CC      drivers/video/modedb.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/icm.o
>   LD [M]  drivers/net/wireless/libertas_tf/libertas_tf.o
>   LD [M]  drivers/net/wireless/libertas_tf/libertas_tf_usb.o
>   CC [M]  drivers/net/wireless/iwlwifi/dvm/led.o
>   CC [M]  drivers/net/wireless/iwlwifi/dvm/rxon.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/intf.o
>   CC [M]  drivers/net/wireless/ath/ath9k/ar9003_paprd.o
>   LD [M]  drivers/net/ethernet/intel/ixgb/ixgb.o
>   CC [M]  drivers/net/wireless/ath/ath9k/btcoex.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/main.o
>   CC [M]  drivers/net/wireless/ath/ath9k/ar9003_mci.o
>   CC [M]  drivers/net/wireless/iwlwifi/dvm/devices.o
>   LD      drivers/net/wireless/orinoco/built-in.o
>   LD      drivers/virtio/built-in.o
>   CC [M]  drivers/net/wireless/orinoco/main.o
>   CC [M]  drivers/virtio/virtio.o
>   CC [M]  drivers/virtio/virtio_ring.o
>   CC [M]  drivers/uwb/whc-rc.o
>   LD [M]  drivers/net/ethernet/intel/igb/igb.o
>   CC      drivers/usb/core/config.o
>   CC      drivers/usb/core/file.o
>   CC      drivers/usb/core/buffer.o
>   CC      drivers/usb/core/sysfs.o
>   CC [M]  drivers/net/virtio_net.o
>   CC [M]  drivers/net/vxlan.o
>   CC [M]  drivers/net/sungem_phy.o
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.o
>   LD      drivers/net/ethernet/myricom/built-in.o
>   LD      drivers/net/ethernet/myricom/myri10ge/built-in.o
>   CC [M]  drivers/net/ethernet/myricom/myri10ge/myri10ge.o
>   CC      drivers/video/fbcvt.o
>   CC [M]  drivers/usb/host/xhci-mem.o
>   LD      drivers/video/aty/built-in.o
>   CC [M]  drivers/video/aty/atyfb_base.o
>   CC [M]  drivers/uwb/hwa-rc.o
>   CC [M]  drivers/tty/synclink_gt.o
>   CC [M]  drivers/virtio/virtio_pci.o
>   CC [M]  drivers/virtio/virtio_balloon.o
>   LD      drivers/uwb/i1480/built-in.o
>   CC [M]  drivers/uwb/i1480/i1480-est.o
>   LD      drivers/uwb/i1480/dfu/built-in.o
>   CC [M]  drivers/uwb/i1480/dfu/dfu.o
>   CC [M]  drivers/uwb/i1480/dfu/mac.o
>   LD [M]  drivers/net/wireless/iwlwifi/dvm/iwldvm.o
>   LD      drivers/net/ethernet/intel/ixgbevf/built-in.o
>   CC [M]  drivers/net/ethernet/intel/ixgbevf/vf.o
>   CC [M]  drivers/net/ethernet/intel/ixgbevf/mbx.o
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_x540.o
>   CC [M]  drivers/net/ethernet/intel/ixgbevf/ethtool.o
>   CC      drivers/usb/core/endpoint.o
>   LD [M]  drivers/net/wireless/ath/ath9k/ath9k.o
>   LD [M]  drivers/net/wireless/ath/ath9k/ath9k_hw.o
>   CC      drivers/usb/core/devio.o
>   LD [M]  drivers/net/wireless/ath/ath9k/ath9k_common.o
>   LD [M]  drivers/net/wireless/ath/ath9k/ath9k_htc.o
>   CC      drivers/usb/core/notify.o
>   CC [M]  drivers/uwb/i1480/dfu/phy.o
>   CC      drivers/usb/core/generic.o
>   CC [M]  drivers/uwb/i1480/dfu/usb.o
>   CC      drivers/usb/core/quirks.o
>   CC      drivers/usb/core/devices.o
>   CC      drivers/usb/core/hcd-pci.o
>   CC      drivers/video/backlight/backlight.o
>   CC      drivers/video/console/dummycon.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/mcg.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/mr.o
>   CC      drivers/usb/core/usb-acpi.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/pd.o
>   CC      drivers/watchdog/watchdog_core.o
>   CC [M]  drivers/net/wireless/orinoco/fw.o
>   CC      drivers/watchdog/watchdog_dev.o
>   CC [M]  drivers/net/wireless/orinoco/hw.o
>   CC [M]  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.o
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.o
>   LD [M]  drivers/scsi/bfa/bfa.o
>   CC [M]  drivers/video/aty/mach64_accel.o
>   LD      drivers/scsi/fcoe/built-in.o
>   CC [M]  drivers/scsi/fcoe/fcoe.o
>   CC [M]  drivers/scsi/fcoe/fcoe_ctlr.o
>   LD [M]  drivers/uwb/i1480/dfu/i1480-dfu-usb.o
>   LD      drivers/scsi/fnic/built-in.o
>   LD [M]  drivers/uwb/uwb.o
>   CC [M]  drivers/scsi/fnic/fnic_attrs.o
>   CC      drivers/video/console/vgacon.o
>   LD [M]  drivers/uwb/umc.o
>   CC [M]  drivers/scsi/fcoe/fcoe_transport.o
>   LD      drivers/scsi/isci/built-in.o
>   CC [M]  drivers/scsi/isci/init.o
>   LD [M]  drivers/net/ethernet/intel/e1000e/e1000e.o
>   CC [M]  drivers/scsi/isci/phy.o
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.o
>   CC [M]  drivers/usb/host/xhci-ring.o
>   CC [M]  drivers/watchdog/pcwd_pci.o
>   CC [M]  drivers/video/backlight/lcd.o
>   CC [M]  drivers/watchdog/wdt_pci.o
>   CC [M]  drivers/watchdog/pcwd_usb.o
>   CC      drivers/video/logo/logo.o
>   LD      drivers/video/nvidia/built-in.o
>   CC [M]  drivers/video/nvidia/nvidia.o
>   CC [M]  drivers/video/aty/mach64_cursor.o
>   CC [M]  drivers/video/nvidia/nv_hw.o
>   CC [M]  drivers/scsi/fnic/fnic_isr.o
>   LD      drivers/usb/core/usbcore.o
>   CC [M]  drivers/video/nvidia/nv_setup.o
>   LD      drivers/usb/core/built-in.o
>   LOGO    drivers/video/logo/logo_linux_clut224.c
>   LOGO    drivers/video/logo/logo_linux_mono.c
>   LOGO    drivers/video/logo/logo_superh_mono.c
>   CC [M]  drivers/video/backlight/platform_lcd.o
>   LOGO    drivers/video/logo/clut_vga16.c
>   LOGO    drivers/video/logo/logo_blackfin_vga16.c
>   LOGO    drivers/video/logo/logo_linux_vga16.c
>   LOGO    drivers/video/logo/logo_superh_vga16.c
>   LOGO    drivers/video/logo/logo_blackfin_clut224.c
>   LOGO    drivers/video/logo/logo_dec_clut224.c
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.o
>   LOGO    drivers/video/logo/logo_m32r_clut224.c
>   LOGO    drivers/video/logo/logo_mac_clut224.c
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.o
>   LOGO    drivers/video/logo/logo_parisc_clut224.c
>   LOGO    drivers/video/logo/logo_sgi_clut224.c
>   LOGO    drivers/video/logo/logo_spe_clut224.c
>   LOGO    drivers/video/logo/logo_sun_clut224.c
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.o
>   LOGO    drivers/video/logo/logo_superh_clut224.c
>   LD      drivers/scsi/libfc/built-in.o
>   CC [M]  drivers/video/aty/mach64_gx.o
>   CC      drivers/video/logo/logo_linux_clut224.o
>   CC [M]  drivers/scsi/libfc/fc_libfc.o
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.o
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_sysfs.o
>   CC      drivers/video/console/fbcon.o
>   CC [M]  drivers/net/wireless/orinoco/mic.o
>   LD      drivers/video/logo/built-in.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/port.o
>   CC [M]  drivers/scsi/isci/request.o
>   CC [M]  drivers/net/wireless/orinoco/scan.o
>   CC [M]  drivers/watchdog/alim1535_wdt.o
>   LD      drivers/video/backlight/built-in.o
>   CC [M]  drivers/watchdog/alim7101_wdt.o
>   CC [M]  drivers/watchdog/sbc_fitpc2_wdt.o
>   CC [M]  drivers/tty/synclinkmp.o
>   CC [M]  drivers/net/wireless/orinoco/wext.o
>   CC [M]  drivers/tty/synclink.o
>   CC [M]  drivers/scsi/fnic/fnic_main.o
>   CC [M]  drivers/video/nvidia/nv_accel.o
>   CC [M]  drivers/scsi/fnic/fnic_res.o
>   CC [M]  drivers/scsi/fnic/fnic_fcs.o
>   CC [M]  drivers/video/nvidia/nv_i2c.o
>   CC [M]  drivers/video/nvidia/nv_backlight.o
>   CC      drivers/video/console/bitblit.o
>   LD      drivers/scsi/libsas/built-in.o
>   LD      drivers/scsi/lpfc/built-in.o
>   CC [M]  drivers/scsi/libsas/sas_init.o
>   CC [M]  drivers/scsi/lpfc/lpfc_mem.o
>   LD [M]  drivers/net/ethernet/intel/ixgbevf/ixgbevf.o
>   CC [M]  drivers/video/aty/mach64_ct.o
>   CC [M]  drivers/scsi/lpfc/lpfc_sli.o
>   CC [M]  drivers/scsi/lpfc/lpfc_ct.o
>   CC [M]  drivers/video/aty/radeon_base.o
>   CC [M]  drivers/usb/host/xhci-hub.o
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.o
>   CC [M]  drivers/watchdog/ib700wdt.o
>   CC [M]  drivers/scsi/libfc/fc_disc.o
>   CC [M]  drivers/scsi/fcoe/fcoe_sysfs.o
>   CC [M]  drivers/scsi/libfc/fc_exch.o
>   CC [M]  drivers/scsi/isci/remote_device.o
>   LD [M]  drivers/video/nvidia/nvidiafb.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/profile.o
>   CC [M]  drivers/scsi/libfc/fc_elsct.o
>   CC [M]  drivers/watchdog/ibmasr.o
>   CC [M]  drivers/watchdog/i6300esb.o
>   CC [M]  drivers/scsi/libfc/fc_frame.o
>   CC [M]  drivers/scsi/libfc/fc_lport.o
>   CC [M]  drivers/scsi/libfc/fc_rport.o
>   CC [M]  drivers/watchdog/ie6xx_wdt.o
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.o
>   CC [M]  drivers/net/wireless/orinoco/hermes_dld.o
>   LD      drivers/xenomai/analogy/built-in.o
>   LD      drivers/xenomai/can/built-in.o
>   CC      drivers/xenomai/ipc/rtipc.o
>   CC [M]  drivers/scsi/fnic/fnic_scsi.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/qp.o
>   CC [M]  drivers/usb/host/xhci-dbg.o
>   CC [M]  drivers/usb/host/xhci-pci.o
>   CC [M]  drivers/scsi/libsas/sas_phy.o
>   CC [M]  drivers/scsi/libsas/sas_port.o
>   CC [M]  drivers/watchdog/iTCO_wdt.o
>   CC      drivers/video/console/fonts.o
>   CC      drivers/video/console/font_8x8.o
>   CC [M]  drivers/net/wireless/orinoco/hermes.o
>   CC [M]  drivers/watchdog/iTCO_vendor_support.o
>   LD [M]  drivers/scsi/fcoe/libfcoe.o
>   CC [M]  drivers/watchdog/it8712f_wdt.o
>   CC [M]  drivers/net/wireless/orinoco/cfg.o
>   CC [M]  drivers/net/wireless/orinoco/orinoco_cs.o
>   CC [M]  drivers/watchdog/it87_wdt.o
>   CC      drivers/xenomai/ipc/xddp.o
>   CC [M]  drivers/usb/host/sl811-hcd.o
>   CC      drivers/xenomai/ipc/iddp.o
>   CC [M]  drivers/scsi/isci/port.o
>   CC      drivers/video/console/font_8x16.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/reset.o
>   CC      drivers/video/console/softcursor.o
>   CC [M]  drivers/video/aty/radeon_pm.o
>   LD      drivers/net/ethernet/natsemi/built-in.o
>   LD      drivers/video/omap2/displays/built-in.o
>   CC [M]  drivers/net/ethernet/natsemi/natsemi.o
>   LD      drivers/video/omap2/built-in.o
>   CC [M]  drivers/net/ethernet/natsemi/ns83820.o
>   CC [M]  drivers/scsi/libsas/sas_event.o
>   LD      drivers/video/riva/built-in.o
>   CC [M]  drivers/video/riva/fbdev.o
>   LD [M]  drivers/net/ethernet/intel/ixgbe/ixgbe.o
>   CC [M]  drivers/video/riva/riva_hw.o
>   CC [M]  drivers/watchdog/hpwdt.o
>   CC [M]  drivers/watchdog/sch311x_wdt.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/sense.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/srq.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/resource_tracker.o
>   CC [M]  drivers/net/wireless/orinoco/orinoco_plx.o
>   CC [M]  drivers/scsi/fnic/vnic_cq.o
>   CC [M]  drivers/net/wireless/orinoco/orinoco_pci.o
>   CC [M]  drivers/net/wireless/orinoco/orinoco_tmd.o
>   CC [M]  drivers/net/wireless/orinoco/orinoco_nortel.o
>   CC [M]  drivers/net/wireless/orinoco/spectrum_cs.o
>   CC [M]  drivers/scsi/libfc/fc_fcp.o
>   CC [M]  drivers/scsi/libfc/fc_npiv.o
>   LD      drivers/usb/misc/built-in.o
>   CC [M]  drivers/usb/misc/adutux.o
>   CC [M]  drivers/watchdog/w83627hf_wdt.o
>   CC      drivers/xenomai/ipc/bufp.o
>   CC      drivers/video/console/tileblit.o
>   CC [M]  drivers/scsi/fnic/vnic_dev.o
>   LD      drivers/tty/built-in.o
>   CC      drivers/video/console/fbcon_rotate.o
>   CC [M]  drivers/usb/host/u132-hcd.o
>   CC [M]  drivers/usb/host/hwa-hc.o
>   LD      drivers/usb/host/whci/built-in.o
>   CC [M]  drivers/usb/host/whci/asl.o
>   CC [M]  drivers/scsi/libsas/sas_dump.o
>   CC [M]  drivers/scsi/isci/host.o
>   CC [M]  drivers/scsi/libsas/sas_discover.o
>   CC [M]  drivers/scsi/libsas/sas_expander.o
>   CC [M]  drivers/scsi/isci/task.o
>   CC [M]  drivers/watchdog/w83697hf_wdt.o
>   CC [M]  drivers/watchdog/w83697ug_wdt.o
>   LD [M]  drivers/net/wireless/orinoco/orinoco.o
>   CC [M]  drivers/watchdog/w83877f_wdt.o
>   LD      drivers/net/wireless/p54/built-in.o
>   CC [M]  drivers/net/wireless/p54/eeprom.o
>   CC [M]  drivers/video/riva/nv_driver.o
>   CC [M]  drivers/usb/misc/appledisplay.o
>   CC [M]  drivers/usb/misc/emi26.o
>   CC [M]  drivers/scsi/fnic/vnic_intr.o
>   CC      drivers/video/console/fbcon_cw.o
>   CC [M]  drivers/scsi/fnic/vnic_rq.o
>   CC      drivers/video/console/fbcon_ud.o
>   CC [M]  drivers/usb/host/whci/debug.o
>   CC      drivers/video/console/fbcon_ccw.o
>   CC [M]  drivers/scsi/lpfc/lpfc_els.o
>   CC [M]  drivers/watchdog/w83977f_wdt.o
>   CC [M]  drivers/scsi/lpfc/lpfc_hbadisc.o
>   CC [M]  drivers/scsi/lpfc/lpfc_init.o
>   LD      drivers/xenomai/ipc/xeno_rtipc.o
>   CC [M]  drivers/scsi/lpfc/lpfc_mbox.o
>   LD      drivers/xenomai/ipc/built-in.o
>   LD      drivers/xenomai/serial/built-in.o
>   LD      drivers/scsi/megaraid/built-in.o
>   CC      drivers/xenomai/testing/switchtest.o
>   CC [M]  drivers/scsi/megaraid/megaraid_mm.o
>   CC [M]  drivers/scsi/megaraid/megaraid_mbox.o
>   CC [M]  drivers/scsi/fnic/vnic_wq_copy.o
>   LD [M]  drivers/video/riva/rivafb.o
>   CC [M]  drivers/usb/misc/emi62.o
>   CC [M]  drivers/scsi/fnic/vnic_wq.o
>   CC [M]  drivers/net/wireless/p54/fwio.o
>   CC [M]  drivers/usb/host/whci/hcd.o
>   CC [M]  drivers/video/aty/radeon_monitor.o
>   CC [M]  drivers/watchdog/machzwd.o
>   CC [M]  drivers/watchdog/softdog.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/en_main.o
>   CC [M]  drivers/usb/misc/ezusb.o
>   CC [M]  drivers/scsi/isci/probe_roms.o
>   LD [M]  drivers/scsi/libfc/libfc.o
>   LD [M]  drivers/scsi/fnic/fnic.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/en_tx.o
>   CC [M]  drivers/scsi/isci/remote_node_context.o
>   CC [M]  drivers/scsi/isci/remote_node_table.o
>   LD      drivers/net/ethernet/neterion/built-in.o
>   CC [M]  drivers/net/ethernet/neterion/s2io.o
>   LD      drivers/video/console/font.o
>   LD      drivers/video/console/built-in.o
>   LD      drivers/net/ethernet/neterion/vxge/built-in.o
>   CC [M]  drivers/net/ethernet/neterion/vxge/vxge-config.o
>   CC [M]  drivers/usb/host/whci/hw.o
>   LD      drivers/usb/host/built-in.o
>   LD      drivers/watchdog/watchdog.o
>   LD      drivers/watchdog/built-in.o
>   CC [M]  drivers/usb/host/whci/init.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/en_rx.o
>   CC [M]  drivers/usb/host/whci/int.o
>   CC [M]  drivers/scsi/libsas/sas_scsi_host.o
>   CC [M]  drivers/scsi/lpfc/lpfc_nportdisc.o
>   CC      drivers/xenomai/testing/timerbench.o
>   CC [M]  drivers/scsi/megaraid/megaraid_sas_base.o
>   CC      drivers/usb/mon/mon_main.o
>   CC [M]  drivers/usb/misc/ftdi-elan.o
>   CC [M]  drivers/video/aty/radeon_accel.o
>   CC [M]  drivers/video/aty/radeon_i2c.o
>   CC      drivers/usb/mon/mon_stat.o
>   CC [M]  drivers/scsi/isci/unsolicited_frame_control.o
>   CC [M]  drivers/scsi/isci/port_config.o
>   CC      drivers/usb/mon/mon_text.o
>   CC [M]  drivers/net/wireless/p54/txrx.o
>   CC [M]  drivers/usb/host/whci/pzl.o
>   CC [M]  drivers/usb/host/whci/qset.o
>   CC [M]  drivers/scsi/lpfc/lpfc_scsi.o
>   CC [M]  drivers/usb/host/whci/wusb.o
>   LD [M]  drivers/usb/host/xhci-hcd.o
>   CC [M]  drivers/scsi/megaraid/megaraid_sas_fusion.o
>   CC [M]  drivers/scsi/lpfc/lpfc_attr.o
>   LD      drivers/xenomai/testing/xeno_timerbench.o
>   CC [M]  drivers/scsi/megaraid/megaraid_sas_fp.o
>   LD      drivers/xenomai/testing/xeno_switchtest.o
>   LD      drivers/xenomai/testing/built-in.o
>   LD      drivers/xenomai/built-in.o
>   CC      drivers/usb/mon/mon_bin.o
>   LD      drivers/video/savage/built-in.o
>   CC [M]  drivers/video/savage/savagefb_driver.o
>   CC [M]  drivers/video/aty/radeon_backlight.o
>   CC [M]  drivers/video/aty/aty128fb.o
>   CC [M]  drivers/scsi/lpfc/lpfc_vport.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/en_ethtool.o
>   LD      drivers/net/wireless/rt2x00/built-in.o
>   CC [M]  drivers/net/wireless/rt2x00/rt2x00dev.o
>   CC [M]  drivers/net/wireless/rt2x00/rt2x00mac.o
>   LD [M]  drivers/scsi/isci/isci.o
>   CC [M]  drivers/scsi/libsas/sas_task.o
>   CC [M]  drivers/net/wireless/rt2x00/rt2x00config.o
>   LD [M]  drivers/usb/host/whci/whci-hcd.o
>   CC [M]  drivers/scsi/libsas/sas_ata.o
>   CC [M]  drivers/scsi/libsas/sas_host_smp.o
>   CC [M]  drivers/net/ethernet/neterion/vxge/vxge-traffic.o
>   CC [M]  drivers/net/ethernet/neterion/vxge/vxge-ethtool.o
>   CC [M]  drivers/net/ethernet/neterion/vxge/vxge-main.o
>   CC [M]  drivers/net/wireless/p54/main.o
>   LD      drivers/usb/mon/usbmon.o
>   LD      drivers/usb/mon/built-in.o
>   CC [M]  drivers/net/wireless/p54/led.o
>   CC [M]  drivers/net/wireless/p54/p54usb.o
>   CC [M]  drivers/net/wireless/p54/p54pci.o
>   CC [M]  drivers/usb/misc/idmouse.o
>   LD      drivers/net/wireless/rtl818x/built-in.o
>   CC [M]  drivers/video/savage/savagefb-i2c.o
>   LD      drivers/net/wireless/rtl818x/rtl8180/built-in.o
>   LD [M]  drivers/video/aty/atyfb.o
>   CC [M]  drivers/net/wireless/rtl818x/rtl8180/dev.o
>   LD [M]  drivers/video/aty/radeonfb.o
>   CC [M]  drivers/net/wireless/rtl818x/rtl8180/rtl8225.o
>   CC [M]  drivers/video/savage/savagefb_accel.o
>   LD      drivers/video/via/built-in.o
>   CC [M]  drivers/video/via/viafbdev.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/en_port.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/en_cq.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/en_resources.o
>   LD [M]  drivers/scsi/megaraid/megaraid_sas.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/en_netdev.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/en_selftest.o
>   CC [M]  drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.o
>   CC [M]  drivers/usb/misc/iowarrior.o
>   CC [M]  drivers/usb/misc/isight_firmware.o
>   CC [M]  drivers/usb/misc/usblcd.o
>   LD [M]  drivers/scsi/libsas/libsas.o
>   LD [M]  drivers/video/savage/savagefb.o
>   LD      drivers/net/wireless/rtl818x/rtl8187/built-in.o
>   CC [M]  drivers/net/wireless/rtl818x/rtl8187/dev.o
>   CC [M]  drivers/net/wireless/rt2x00/rt2x00queue.o
>   CC      drivers/video/cfbfillrect.o
>   LD      drivers/net/ethernet/nvidia/built-in.o
>   CC [M]  drivers/net/ethernet/nvidia/forcedeth.o
>   LD [M]  drivers/net/wireless/p54/p54common.o
>   LD      drivers/net/ethernet/oki-semi/built-in.o
>   LD      drivers/net/ethernet/oki-semi/pch_gbe/built-in.o
>   LD      drivers/net/ethernet/packetengines/built-in.o
>   CC [M]  drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_phy.o
>   CC [M]  drivers/net/wireless/rtl818x/rtl8180/sa2400.o
>   LD      drivers/net/ethernet/qlogic/built-in.o
>   CC [M]  drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_ethtool.o
>   CC [M]  drivers/net/ethernet/qlogic/qla3xxx.o
>   CC [M]  drivers/usb/misc/ldusb.o
>   CC [M]  drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_param.o
>   LD      drivers/net/ethernet/qlogic/netxen/built-in.o
>   CC [M]  drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.o
>   CC [M]  drivers/usb/misc/usbled.o
>   LD      drivers/net/ethernet/rdc/built-in.o
>   CC [M]  drivers/net/ethernet/rdc/r6040.o
>   CC [M]  drivers/scsi/lpfc/lpfc_debugfs.o
>   CC [M]  drivers/scsi/lpfc/lpfc_bsg.o
>   CC [M]  drivers/net/ethernet/qlogic/netxen/netxen_nic_main.o
>   CC [M]  drivers/net/ethernet/qlogic/netxen/netxen_nic_init.o
>   CC [M]  drivers/net/ethernet/qlogic/netxen/netxen_nic_ethtool.o
>   CC [M]  drivers/video/via/hw.o
>   CC [M]  drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.o
>   LD      drivers/net/ethernet/qlogic/qlcnic/built-in.o
>   CC [M]  drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.o
>   CC [M]  drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.o
>   CC [M]  drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.o
>   CC [M]  drivers/net/wireless/rtl818x/rtl8180/max2820.o
>   CC [M]  drivers/usb/misc/legousbtower.o
>   CC [M]  drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.o
>   CC [M]  drivers/net/ethernet/qlogic/qlcnic/qlcnic_ctx.o
>   LD [M]  drivers/net/ethernet/mellanox/mlx4/mlx4_core.o
>   LD [M]  drivers/net/ethernet/mellanox/mlx4/mlx4_en.o
>   LD [M]  drivers/net/ethernet/neterion/vxge/vxge.o
>   CC [M]  drivers/net/wireless/rt2x00/rt2x00link.o
>   CC [M]  drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_api.o
>   CC [M]  drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.o
>   CC [M]  drivers/net/wireless/rt2x00/rt2x00crypto.o
>   CC [M]  drivers/net/wireless/rtl818x/rtl8187/rtl8225.o
>   CC [M]  drivers/net/wireless/rtl818x/rtl8187/leds.o
>   LD      drivers/net/ethernet/realtek/built-in.o
>   CC [M]  drivers/net/ethernet/realtek/8139cp.o
>   CC [M]  drivers/net/wireless/rtl818x/rtl8180/grf5101.o
>   CC [M]  drivers/video/via/via_i2c.o
>   CC [M]  drivers/net/ethernet/realtek/8139too.o
>   CC [M]  drivers/net/ethernet/realtek/r8169.o
>   CC [M]  drivers/usb/misc/uss720.o
>   LD      drivers/net/ethernet/qlogic/qlge/built-in.o
>   CC [M]  drivers/net/ethernet/qlogic/qlge/qlge_main.o
>   LD      drivers/net/ethernet/seeq/built-in.o
>   LD      drivers/net/ethernet/silan/built-in.o
>   LD      drivers/net/ethernet/sfc/built-in.o
>   CC [M]  drivers/net/ethernet/silan/sc92031.o
>   CC [M]  drivers/net/wireless/rt2x00/rt2x00firmware.o
>   LD      drivers/scsi/mpt2sas/built-in.o
>   CC [M]  drivers/net/ethernet/sfc/efx.o
>   CC [M]  drivers/scsi/mpt2sas/mpt2sas_base.o
>   CC [M]  drivers/scsi/mpt2sas/mpt2sas_config.o
>   CC [M]  drivers/net/wireless/rt2x00/rt2x00leds.o
>   CC [M]  drivers/net/wireless/rt2x00/rt2x00pci.o
>   LD [M]  drivers/net/ethernet/qlogic/netxen/netxen_nic.o
>   CC [M]  drivers/net/wireless/rt2x00/rt2x00usb.o
>   LD [M]  drivers/net/wireless/rtl818x/rtl8180/rtl8180.o
>   CC [M]  drivers/net/wireless/rt2x00/rt2800lib.o
>   CC [M]  drivers/net/wireless/rtl818x/rtl8187/rfkill.o
>   CC [M]  drivers/video/via/dvi.o
>   CC [M]  drivers/video/via/lcd.o
>   CC [M]  drivers/video/via/ioctl.o
>   CC [M]  drivers/video/via/accel.o
>   CC [M]  drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.o
>   CC [M]  drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.o
>   CC [M]  drivers/usb/misc/usbsevseg.o
>   CC [M]  drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.o
>   LD [M]  drivers/scsi/lpfc/lpfc.o
>   CC [M]  drivers/video/via/via_utility.o
>   CC [M]  drivers/video/via/vt1636.o
>   CC [M]  drivers/scsi/mpt2sas/mpt2sas_scsih.o
>   CC [M]  drivers/net/ethernet/qlogic/qlge/qlge_dbg.o
>   CC [M]  drivers/net/ethernet/qlogic/qlge/qlge_mpi.o
>   LD [M]  drivers/net/wireless/rtl818x/rtl8187/rtl8187.o
>   CC [M]  drivers/net/ethernet/qlogic/qlge/qlge_ethtool.o
>   CC [M]  drivers/net/ethernet/sfc/nic.o
>   CC [M]  drivers/net/ethernet/sfc/falcon.o
>   CC [M]  drivers/net/wireless/rt2x00/rt2400pci.o
>   CC [M]  drivers/net/wireless/rt2x00/rt2500pci.o
>   LD      drivers/usb/misc/sisusbvga/built-in.o
>   CC [M]  drivers/usb/misc/sisusbvga/sisusb.o
>   CC      drivers/usb/otg/otg.o
>   CC [M]  drivers/usb/otg/nop-usb-xceiv.o
>   LD      drivers/usb/phy/built-in.o
>   LD [M]  drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.o
>   CC [M]  drivers/net/ethernet/sfc/siena.o
>   CC [M]  drivers/video/via/global.o
>   CC [M]  drivers/net/ethernet/sfc/tx.o
>   LD      drivers/usb/serial/built-in.o
>   CC [M]  drivers/usb/serial/usb-serial.o
>   CC [M]  drivers/usb/serial/generic.o
>   CC [M]  drivers/usb/serial/bus.o
>   CC [M]  drivers/net/ethernet/sfc/rx.o
>   CC [M]  drivers/usb/serial/aircable.o
>   CC [M]  drivers/video/via/tblDPASetting.o
>   LD      drivers/usb/otg/built-in.o
>   CC [M]  drivers/usb/serial/ark3116.o
>   CC [M]  drivers/video/via/viamode.o
>   LD      drivers/scsi/mpt3sas/built-in.o
>   CC [M]  drivers/scsi/mpt3sas/mpt3sas_base.o
>   CC [M]  drivers/net/ethernet/sfc/filter.o
>   CC      drivers/video/cfbcopyarea.o
>   CC      drivers/video/cfbimgblt.o
>   CC      drivers/video/vesafb.o
>   LD [M]  drivers/net/ethernet/qlogic/qlcnic/qlcnic.o
>   LD      drivers/usb/storage/built-in.o
>   CC      drivers/video/efifb.o
>   CC [M]  drivers/usb/storage/alauda.o
>   CC [M]  drivers/usb/storage/cypress_atacb.o
>   CC [M]  drivers/usb/storage/datafab.o
>   CC [M]  drivers/usb/storage/freecom.o
>   CC [M]  drivers/video/via/via-core.o
>   CC [M]  drivers/usb/storage/isd200.o
>   CC [M]  drivers/usb/storage/jumpshot.o
>   CC [M]  drivers/usb/storage/karma.o
>   CC [M]  drivers/usb/storage/onetouch.o
>   CC [M]  drivers/usb/storage/sddr09.o
>   CC [M]  drivers/video/vgastate.o
>   CC [M]  drivers/video/sysfillrect.o
>   CC [M]  drivers/usb/serial/belkin_sa.o
>   CC [M]  drivers/usb/serial/ch341.o
>   LD      drivers/usb/wusbcore/built-in.o
>   CC [M]  drivers/usb/wusbcore/cbaf.o
>   CC [M]  drivers/usb/wusbcore/wa-hc.o
>   CC [M]  drivers/usb/serial/cp210x.o
>   CC [M]  drivers/usb/misc/sisusbvga/sisusb_init.o
>   CC [M]  drivers/usb/misc/sisusbvga/sisusb_con.o
>   CC [M]  drivers/video/syscopyarea.o
>   CC [M]  drivers/video/sysimgblt.o
>   CC [M]  drivers/usb/wusbcore/wa-nep.o
>   CC [M]  drivers/usb/wusbcore/wa-rpipe.o
>   CC [M]  drivers/net/ethernet/sfc/falcon_xmac.o
>   CC [M]  drivers/net/ethernet/sfc/mcdi_mac.o
>   CC [M]  drivers/net/ethernet/sfc/selftest.o
>   LD [M]  drivers/net/ethernet/qlogic/qlge/qlge.o
>   CC [M]  drivers/net/ethernet/sfc/ethtool.o
>   CC [M]  drivers/net/ethernet/sfc/qt202x_phy.o
>   CC [M]  drivers/usb/wusbcore/wa-xfer.o
>   CC [M]  drivers/video/via/via-gpio.o
>   CC [M]  drivers/video/fb_sys_fops.o
>   CC [M]  drivers/video/fb_ddc.o
>   CC [M]  drivers/video/macmodes.o
>   CC [M]  drivers/video/via/via_modesetting.o
>   CC [M]  drivers/video/via/via_clock.o
>   CC      drivers/usb/usb-common.o
>   CC [M]  drivers/usb/serial/cyberjack.o
>   CC [M]  drivers/video/via/via_aux.o
>   CC [M]  drivers/usb/serial/cypress_m8.o
>   CC [M]  drivers/usb/storage/sddr55.o
>   CC [M]  drivers/usb/wusbcore/crypto.o
>   CC [M]  drivers/usb/wusbcore/devconnect.o
>   CC [M]  drivers/usb/wusbcore/dev-sysfs.o
>   CC [M]  drivers/usb/wusbcore/mmc.o
>   LD [M]  drivers/usb/misc/sisusbvga/sisusbvga.o
>   CC [M]  drivers/scsi/mpt2sas/mpt2sas_transport.o
>   CC [M]  drivers/usb/wusbcore/pal.o
>   CC [M]  drivers/usb/wusbcore/rh.o
>   CC [M]  drivers/usb/serial/usb_debug.o
>   CC [M]  drivers/scsi/mpt2sas/mpt2sas_ctl.o
>   CC [M]  drivers/net/wireless/rt2x00/rt61pci.o
>   CC [M]  drivers/net/wireless/rt2x00/rt2800pci.o
>   CC [M]  drivers/net/wireless/rt2x00/rt2500usb.o
>   CC [M]  drivers/net/wireless/rt2x00/rt73usb.o
>   CC [M]  drivers/net/wireless/rt2x00/rt2800usb.o
>   CC [M]  drivers/scsi/mpt3sas/mpt3sas_config.o
>   CC [M]  drivers/scsi/mpt3sas/mpt3sas_scsih.o
>   CC [M]  drivers/video/via/via_aux_edid.o
>   LD      drivers/net/wireless/ti/wl1251/built-in.o
>   CC [M]  drivers/net/wireless/ti/wl1251/main.o
>   CC [M]  drivers/net/wireless/ti/wl1251/event.o
>   CC [M]  drivers/net/ethernet/sfc/mdio_10g.o
>   CC [M]  drivers/net/ethernet/sfc/tenxpress.o
>   CC [M]  drivers/video/via/via_aux_vt1636.o
>   CC [M]  drivers/video/via/via_aux_vt1632.o
>   CC [M]  drivers/video/via/via_aux_vt1631.o
>   CC [M]  drivers/video/via/via_aux_vt1625.o
>   CC [M]  drivers/net/ethernet/sfc/txc43128_phy.o
>   CC [M]  drivers/usb/storage/shuttle_usbat.o
>   CC [M]  drivers/usb/serial/digi_acceleport.o
>   CC [M]  drivers/usb/serial/io_edgeport.o
>   CC [M]  drivers/usb/serial/io_ti.o
>   CC [M]  drivers/usb/storage/scsiglue.o
>   CC [M]  drivers/usb/storage/protocol.o
>   CC [M]  drivers/usb/wusbcore/reservation.o
>   CC [M]  drivers/usb/wusbcore/security.o
>   CC [M]  drivers/usb/wusbcore/wusbhc.o
>   CC [M]  drivers/video/via/via_aux_vt1622.o
>   CC [M]  drivers/video/via/via_aux_vt1621.o
>   CC [M]  drivers/video/via/via_aux_sii164.o
>   LD      drivers/net/wireless/ti/wl12xx/built-in.o
>   CC [M]  drivers/net/wireless/ti/wl12xx/main.o
>   CC [M]  drivers/net/wireless/ti/wl12xx/cmd.o
>   CC [M]  drivers/net/ethernet/sfc/falcon_boards.o
>   LD      drivers/net/ethernet/sis/built-in.o
>   LD      drivers/net/ethernet/smsc/built-in.o
>   CC [M]  drivers/net/ethernet/sis/sis190.o
>   LD      drivers/net/wireless/zd1211rw/built-in.o
>   CC [M]  drivers/net/ethernet/smsc/smc91c92_cs.o
>   CC [M]  drivers/net/wireless/zd1211rw/zd_chip.o
>   CC [M]  drivers/net/wireless/zd1211rw/zd_mac.o
>   CC [M]  drivers/net/ethernet/smsc/epic100.o
>   CC [M]  drivers/net/ethernet/smsc/smsc9420.o
>   LD [M]  drivers/net/wireless/rt2x00/rt2x00lib.o
>   LD [M]  drivers/scsi/mpt2sas/mpt2sas.o
>   CC [M]  drivers/video/cirrusfb.o
>   CC [M]  drivers/net/ethernet/sis/sis900.o
>   CC [M]  drivers/net/wireless/ti/wl1251/tx.o
>   CC [M]  drivers/net/wireless/ti/wl12xx/acx.o
>   CC      drivers/net/wireless/ti/wlcore/wl12xx_platform_data.o
>   CC [M]  drivers/video/via/via_aux_ch7301.o
>   CC [M]  drivers/net/wireless/ti/wlcore/main.o
>   CC [M]  drivers/net/wireless/ti/wlcore/cmd.o
>   LD [M]  drivers/usb/wusbcore/wusbcore.o
>   LD [M]  drivers/usb/wusbcore/wusb-wa.o
>   CC [M]  drivers/usb/storage/transport.o
>   LD [M]  drivers/usb/wusbcore/wusb-cbaf.o
>   CC [M]  drivers/usb/storage/usb.o
>   CC [M]  drivers/net/wireless/ti/wlcore/io.o
>   LD      drivers/net/ethernet/stmicro/built-in.o
>   CC [M]  drivers/scsi/mpt3sas/mpt3sas_transport.o
>   LD [M]  drivers/video/via/viafb.o
>   CC [M]  drivers/scsi/mpt3sas/mpt3sas_ctl.o
>   CC [M]  drivers/net/ethernet/sfc/mcdi.o
>   CC [M]  drivers/video/sm501fb.o
>   CC [M]  drivers/net/ethernet/sfc/mcdi_phy.o
>   CC [M]  drivers/net/ethernet/sfc/mcdi_mon.o
>   CC [M]  drivers/video/vga16fb.o
>   CC [M]  drivers/net/wireless/ti/wl12xx/debugfs.o
>   CC [M]  drivers/net/wireless/ti/wl1251/rx.o
>   CC [M]  drivers/net/wireless/ti/wl1251/ps.o
>   CC [M]  drivers/net/wireless/zd1211rw/zd_rf_al2230.o
>   CC [M]  drivers/usb/serial/empeg.o
>   CC [M]  drivers/net/wireless/zd1211rw/zd_rf_rf2959.o
>   CC [M]  drivers/net/wireless/airo.o
>   CC [M]  drivers/net/wireless/zd1211rw/zd_rf_al7230b.o
>   CC [M]  drivers/net/wireless/zd1211rw/zd_rf_uw2453.o
>   CC [M]  drivers/usb/storage/initializers.o
>   CC [M]  drivers/usb/storage/sierra_ms.o
>   CC [M]  drivers/net/wireless/airo_cs.o
>   CC [M]  drivers/net/wireless/atmel.o
>   CC [M]  drivers/net/wireless/atmel_pci.o
>   CC [M]  drivers/usb/storage/option_ms.o
>   CC [M]  drivers/net/wireless/ti/wl1251/cmd.o
>   CC [M]  drivers/usb/serial/ftdi_sio.o
>   CC [M]  drivers/usb/serial/funsoft.o
>   CC [M]  drivers/usb/serial/garmin_gps.o
>   CC [M]  drivers/usb/serial/hp4x.o
>   CC [M]  drivers/usb/serial/ipaq.o
>   CC [M]  drivers/usb/serial/ipw.o
>   CC [M]  drivers/video/vfb.o
>   CC [M]  drivers/net/ethernet/sfc/ptp.o
>   CC [M]  drivers/video/output.o
>   LD [M]  drivers/net/wireless/ti/wl12xx/wl12xx.o
>   CC [M]  drivers/net/wireless/ti/wl1251/acx.o
>   CC [M]  drivers/net/wireless/ti/wl1251/boot.o
>   CC [M]  drivers/net/wireless/ti/wl1251/init.o
>   CC [M]  drivers/net/wireless/ti/wl1251/debugfs.o
>   CC [M]  drivers/net/wireless/ti/wl1251/io.o
>   CC [M]  drivers/net/wireless/ti/wl1251/sdio.o
>   CC [M]  drivers/usb/storage/usual-tables.o
>   LD      drivers/scsi/mvsas/built-in.o
>   CC [M]  drivers/usb/serial/ir-usb.o
>   CC [M]  drivers/scsi/mvsas/mv_init.o
>   CC [M]  drivers/scsi/mpt3sas/mpt3sas_trigger_diag.o
>   CC [M]  drivers/scsi/mvsas/mv_sas.o
>   LD      drivers/net/ethernet/sun/built-in.o
>   CC [M]  drivers/net/ethernet/sun/sunhme.o
>   CC [M]  drivers/net/wireless/zd1211rw/zd_rf.o
>   CC [M]  drivers/net/ethernet/sun/sungem.o
>   CC [M]  drivers/net/ethernet/sun/cassini.o
>   CC [M]  drivers/net/ethernet/sun/niu.o
>   LD      drivers/video/fb.o
>   CC [M]  drivers/net/wireless/zd1211rw/zd_usb.o
>   LD      drivers/video/built-in.o
>   CC [M]  drivers/net/ethernet/sfc/mtd.o
>   LD [M]  drivers/usb/storage/usb-storage.o
>   LD [M]  drivers/usb/storage/ums-alauda.o
>   LD [M]  drivers/usb/storage/ums-cypress.o
>   LD [M]  drivers/usb/storage/ums-datafab.o
>   LD [M]  drivers/usb/storage/ums-freecom.o
>   LD [M]  drivers/usb/storage/ums-isd200.o
>   LD [M]  drivers/usb/storage/ums-jumpshot.o
>   LD [M]  drivers/usb/storage/ums-karma.o
>   CC [M]  drivers/net/ethernet/sfc/siena_sriov.o
>   LD [M]  drivers/usb/storage/ums-onetouch.o
>   LD [M]  drivers/usb/storage/ums-sddr09.o
>   LD [M]  drivers/usb/storage/ums-sddr55.o
>   CC [M]  drivers/net/wireless/ti/wlcore/event.o
>   LD [M]  drivers/usb/storage/ums-usbat.o
>   CC [M]  drivers/scsi/mvsas/mv_64xx.o
>   CC [M]  drivers/net/wireless/ti/wlcore/tx.o
>   CC [M]  drivers/net/wireless/ti/wlcore/rx.o
>   CC [M]  drivers/usb/serial/iuu_phoenix.o
>   CC [M]  drivers/net/wireless/ti/wlcore/ps.o
>   LD [M]  drivers/scsi/mpt3sas/mpt3sas.o
>   LD      drivers/net/ethernet/tehuti/built-in.o
>   CC [M]  drivers/net/ethernet/tehuti/tehuti.o
>   LD      drivers/net/ethernet/ti/built-in.o
>   CC [M]  drivers/net/ethernet/ti/tlan.o
>   CC [M]  drivers/net/wireless/atmel_cs.o
>   LD      drivers/scsi/osd/built-in.o
>   LD      drivers/net/ethernet/via/built-in.o
>   CC [M]  drivers/scsi/osd/osd_initiator.o
>   CC [M]  drivers/net/ethernet/via/via-rhine.o
>   CC [M]  drivers/net/ethernet/via/via-velocity.o
>   LD [M]  drivers/net/wireless/ti/wl1251/wl1251.o
>   LD [M]  drivers/net/wireless/ti/wl1251/wl1251_sdio.o
>   CC [M]  drivers/scsi/osd/osd_uld.o
>   CC [M]  drivers/net/wireless/ti/wlcore/acx.o
>   CC [M]  drivers/net/wireless/ti/wlcore/boot.o
>   CC [M]  drivers/net/wireless/ti/wlcore/init.o
>   CC [M]  drivers/scsi/mvsas/mv_94xx.o
>   LD      drivers/net/ethernet/wiznet/built-in.o
>   CC [M]  drivers/usb/serial/keyspan.o
>   LD      drivers/scsi/pcmcia/built-in.o
>   LD [M]  drivers/net/wireless/zd1211rw/zd1211rw.o
>   CC [M]  drivers/net/wireless/at76c50x-usb.o
>   LD      drivers/scsi/pm8001/built-in.o
>   CC [M]  drivers/scsi/pm8001/pm8001_init.o
>   CC [M]  drivers/scsi/pm8001/pm8001_sas.o
>   CC [M]  drivers/scsi/pm8001/pm8001_ctl.o
>   LD      drivers/net/ethernet/xircom/built-in.o
>   CC [M]  drivers/net/ethernet/xircom/xirc2ps_cs.o
>   CC [M]  drivers/net/ethernet/dnet.o
>   LD      drivers/scsi/qla2xxx/built-in.o
>   CC [M]  drivers/scsi/qla2xxx/qla_os.o
>   CC [M]  drivers/scsi/qla2xxx/qla_init.o
>   LD [M]  drivers/net/ethernet/sfc/sfc.o
>   CC [M]  drivers/scsi/qla2xxx/qla_mbx.o
>   CC [M]  drivers/net/ethernet/jme.o
>   CC [M]  drivers/net/ethernet/fealnx.o
>   CC [M]  drivers/net/wireless/ti/wlcore/debugfs.o
>   CC [M]  drivers/scsi/qla2xxx/qla_iocb.o
>   LD [M]  drivers/scsi/osd/libosd.o
>   LD [M]  drivers/scsi/osd/osd.o
>   CC [M]  drivers/scsi/qla2xxx/qla_isr.o
>   CC [M]  drivers/net/wireless/wl3501_cs.o
>   CC [M]  drivers/scsi/qla2xxx/qla_gs.o
>   CC [M]  drivers/net/wireless/rndis_wlan.o
>   CC [M]  drivers/net/wireless/ti/wlcore/scan.o
>   CC [M]  drivers/net/wireless/zd1201.o
>   CC [M]  drivers/scsi/pm8001/pm8001_hwi.o
>   LD [M]  drivers/scsi/mvsas/mvsas.o
>   CC [M]  drivers/net/wireless/adm8211.o
>   CC [M]  drivers/net/wireless/mwl8k.o
>   CC [M]  drivers/net/wireless/mac80211_hwsim.o
>   CC [M]  drivers/scsi/qla2xxx/qla_dbg.o
>   LD      drivers/scsi/qla4xxx/built-in.o
>   CC [M]  drivers/scsi/qla4xxx/ql4_os.o
>   CC [M]  drivers/scsi/qla4xxx/ql4_init.o
>   CC [M]  drivers/scsi/qla2xxx/qla_sup.o
> drivers/net/wireless/wl3501_cs.c: In function =E2=80=98wl3501_receive=E2=
=80=99:
> drivers/net/wireless/wl3501_cs.c:756: warning: =E2=80=98next_addr=E2=80=
=99 may be
> used uninitialized in this function
> drivers/net/wireless/wl3501_cs.c:785: warning: =E2=80=98next_addr1=E2=80=
=99 may be
> used uninitialized in this function CC [M]
> drivers/scsi/qla4xxx/ql4_mbx.o CC [M]
> drivers/usb/serial/keyspan_pda.o CC [M]
> drivers/scsi/qla4xxx/ql4_iocb.o CC [M]
> drivers/scsi/qla4xxx/ql4_isr.o CC [M]  drivers/scsi/qla4xxx/ql4_nx.o
> CC [M]  drivers/usb/serial/kl5kusb105.o CC [M]
> drivers/usb/serial/kobil_sct.o CC [M]  drivers/usb/serial/mct_u232.o
>   LD      drivers/net/wireless/ti/wlcore/built-in.o
>   LD [M]  drivers/net/wireless/ti/wlcore/wlcore.o
>   LD      drivers/net/wireless/ti/built-in.o
>   CC [M]  drivers/usb/serial/mos7720.o
>   CC [M]  drivers/net/ethernet/ethoc.o
>   CC [M]  drivers/scsi/qla4xxx/ql4_nvram.o
>   CC [M]  drivers/scsi/qla4xxx/ql4_dbg.o
>   CC [M]  drivers/scsi/qla4xxx/ql4_attr.o
>   CC [M]  drivers/usb/serial/mos7840.o
>   CC [M]  drivers/usb/serial/moto_modem.o
>   LD      drivers/scsi/sym53c8xx_2/built-in.o
>   CC [M]  drivers/scsi/sym53c8xx_2/sym_fw.o
>   CC [M]  drivers/scsi/sym53c8xx_2/sym_glue.o
>   CC [M]  drivers/scsi/sym53c8xx_2/sym_hipd.o
>   CC [M]  drivers/scsi/sym53c8xx_2/sym_malloc.o
>   CC [M]  drivers/scsi/qla2xxx/qla_attr.o
>   CC [M]  drivers/scsi/qla4xxx/ql4_bsg.o
>   CC [M]  drivers/scsi/qla4xxx/ql4_83xx.o
>   CC [M]  drivers/scsi/sym53c8xx_2/sym_nvram.o
>   CC      drivers/scsi/scsi.o
>   LD      drivers/net/ethernet/built-in.o
>   CC      drivers/scsi/hosts.o
>   CC      drivers/scsi/scsi_ioctl.o
>   LD [M]  drivers/scsi/pm8001/pm8001.o
>   CC [M]  drivers/usb/serial/navman.o
>   CC [M]  drivers/scsi/qla2xxx/qla_mid.o
>   LD      drivers/net/wireless/built-in.o
>   CC [M]  drivers/scsi/qla2xxx/qla_dfs.o
>   CC [M]  drivers/scsi/qla2xxx/qla_bsg.o
>   CC [M]  drivers/usb/serial/omninet.o
>   CC [M]  drivers/scsi/qla2xxx/qla_nx.o
>   CC [M]  drivers/scsi/qla2xxx/qla_target.o
>   CC [M]  drivers/usb/serial/opticon.o
>   LD      drivers/net/built-in.o
>   CC      drivers/scsi/constants.o
>   CC      drivers/scsi/scsicam.o
>   CC [M]  drivers/usb/serial/option.o
>   CC [M]  drivers/usb/serial/oti6858.o
>   CC      drivers/scsi/scsi_error.o
>   CC [M]  drivers/usb/serial/pl2303.o
>   CC      drivers/scsi/scsi_lib.o
>   CC      drivers/scsi/scsi_lib_dma.o
>   CC [M]  drivers/usb/serial/qcserial.o
>   CC      drivers/scsi/scsi_scan.o
>   CC      drivers/scsi/scsi_sysfs.o
>   CC      drivers/scsi/scsi_devinfo.o
>   CC      drivers/scsi/scsi_netlink.o
>   CC      drivers/scsi/scsi_sysctl.o
>   CC      drivers/scsi/scsi_proc.o
>   CC      drivers/scsi/scsi_trace.o
>   CC [M]  drivers/usb/serial/safe_serial.o
>   CC [M]  drivers/usb/serial/siemens_mpi.o
>   LD [M]  drivers/scsi/qla4xxx/qla4xxx.o
>   CC      drivers/scsi/scsi_pm.o
>   CC [M]  drivers/usb/serial/sierra.o
>   CC [M]  drivers/scsi/storvsc_drv.o
>   CC [M]  drivers/scsi/scsi_tgt_lib.o
>   CC [M]  drivers/usb/serial/spcp8x5.o
>   CC [M]  drivers/usb/serial/symbolserial.o
>   CC [M]  drivers/usb/serial/usb_wwan.o
>   CC [M]  drivers/scsi/scsi_tgt_if.o
>   CC [M]  drivers/usb/serial/ti_usb_3410_5052.o
>   CC [M]  drivers/usb/serial/visor.o
>   CC [M]  drivers/usb/serial/whiteheat.o
>   CC [M]  drivers/scsi/sd.o
>   CC [M]  drivers/scsi/sd_dif.o
>   CC [M]  drivers/scsi/sr.o
>   LD [M]  drivers/scsi/sym53c8xx_2/sym53c8xx.o
>   LD [M]  drivers/usb/serial/usbserial.o
>   CC [M]  drivers/scsi/sr_ioctl.o
>   CC [M]  drivers/scsi/sr_vendor.o
>   CC [M]  drivers/scsi/raid_class.o
>   CC [M]  drivers/scsi/scsi_transport_spi.o
>   CC [M]  drivers/scsi/scsi_transport_fc.o
>   CC [M]  drivers/scsi/scsi_transport_iscsi.o
>   CC [M]  drivers/scsi/scsi_transport_srp.o
>   CC [M]  drivers/scsi/scsi_transport_sas.o
>   CC [M]  drivers/scsi/libiscsi.o
>   CC [M]  drivers/scsi/libiscsi_tcp.o
>   CC [M]  drivers/scsi/iscsi_tcp.o
>   CC [M]  drivers/scsi/iscsi_boot_sysfs.o
>   CC [M]  drivers/scsi/ips.o
>   CC [M]  drivers/scsi/hpsa.o
>   CC [M]  drivers/scsi/initio.o
>   CC [M]  drivers/scsi/3w-xxxx.o
>   CC [M]  drivers/scsi/3w-9xxx.o
>   CC [M]  drivers/scsi/3w-sas.o
>   CC [M]  drivers/scsi/ppa.o
>   CC [M]  drivers/scsi/imm.o
>   CC [M]  drivers/scsi/libsrp.o
>   CC [M]  drivers/scsi/hptiop.o
>   CC [M]  drivers/scsi/stex.o
>   LD      drivers/usb/built-in.o
>   CC [M]  drivers/scsi/pmcraid.o
>   CC [M]  drivers/scsi/virtio_scsi.o
>   CC [M]  drivers/scsi/vmw_pvscsi.o
>   CC [M]  drivers/scsi/st.o
>   CC [M]  drivers/scsi/osst.o
>   CC [M]  drivers/scsi/sg.o
>   CC [M]  drivers/scsi/ch.o
>   CC [M]  drivers/scsi/ses.o
>   CC [M]  drivers/scsi/scsi_debug.o
>   LD      drivers/scsi/scsi_mod.o
>   LD [M]  drivers/scsi/scsi_tgt.o
>   LD [M]  drivers/scsi/hv_storvsc.o
>   LD [M]  drivers/scsi/sd_mod.o
>   LD [M]  drivers/scsi/sr_mod.o
>   LD [M]  drivers/scsi/qla2xxx/qla2xxx.o
>   LD      drivers/scsi/built-in.o
>   LD      drivers/built-in.o
> WARNING: drivers/built-in.o(.text+0x1b57fc): Section mismatch in
> reference from the function iommu_init_pci() to the
> function .init.text:amd_iommu_erratum_746_workaround() The function
> iommu_init_pci() references the function __init
> amd_iommu_erratum_746_workaround(). This is often because
> iommu_init_pci lacks a __init annotation or the annotation of
> amd_iommu_erratum_746_workaround is wrong.
>=20
>   CHK     include/generated/uapi/linux/version.h
> make[2]: Nothing to be done for `all'.
> make[2]: Nothing to be done for `relocs'.
>   HOSTCC  scripts/unifdef
>   INSTALL include/uapi (0 file)
>   INSTALL include/drm (15 files)
>   INSTALL include/mtd (5 files)
>   INSTALL include/rdma (6 files)
>   INSTALL include/xen (2 files)
>   INSTALL include/scsi (3 files)
>   INSTALL include/video (3 files)
>   INSTALL include/asm-generic (35 files)
>   INSTALL include/sound (10 files)
>   INSTALL include/scsi/fc (4 files)
>   INSTALL include/linux/hdlc (1 file)
>   INSTALL include/linux/caif (2 files)
>   INSTALL include/linux/byteorder (2 files)
>   INSTALL include/linux/can (5 files)
>   INSTALL include/linux/hsi (1 file)
>   INSTALL include/linux/dvb (8 files)
>   INSTALL include/linux/isdn (1 file)
>   INSTALL include/linux/nfsd (5 files)
>   INSTALL include/linux/mmc (1 file)
>   INSTALL include/linux/netfilter_arp (2 files)
>   INSTALL include/linux/netfilter_bridge (18 files)
>   INSTALL include/linux/raid (2 files)
>   INSTALL include/linux/netfilter_ipv6 (12 files)
>   INSTALL include/linux/netfilter_ipv4 (10 files)
>   INSTALL include/linux/netfilter/ipset (4 files)
>   INSTALL include/linux/spi (1 file)
>   INSTALL include/linux/netfilter (76 files)
>   INSTALL include/linux/sunrpc (1 file)
>   INSTALL include/linux/tc_act (7 files)
>   INSTALL include/linux/tc_ematch (4 files)
>   INSTALL include/linux/usb (10 files)
>   INSTALL include/linux/wimax (1 file)
>   INSTALL include/linux (381 files)
>   INSTALL include/asm (64 files)
>   CHECK   include/drm (15 files)
>   CHECK   include/uapi (0 files)
>   CHECK   include/asm-generic (35 files)
>   CHECK   include/mtd (5 files)
>   CHECK   include/rdma (6 files)
>   CHECK   include/scsi (3 files)
>   CHECK   include/sound (10 files)
>   CHECK   include/xen (2 files)
>   CHECK   include/video (3 files)
>   CHECK   include/scsi/fc (4 files)
>   CHECK   include/linux/caif (2 files)
>   CHECK   include/linux/byteorder (2 files)
>   CHECK   include/linux/can (5 files)
>   CHECK   include/linux/dvb (8 files)
>   CHECK   include/linux/hdlc (1 files)
>   CHECK   include/linux/hsi (1 files)
>   CHECK   include/linux/isdn (1 files)
>   CHECK   include/linux/netfilter_ipv4 (10 files)
>   CHECK   include/linux/mmc (1 files)
>   CHECK   include/linux/netfilter_arp (2 files)
>   CHECK   include/linux/netfilter_ipv6 (12 files)
>   CHECK   include/linux/netfilter_bridge (18 files)
>   CHECK   include/linux/nfsd (5 files)
>   CHECK   include/linux/netfilter/ipset (4 files)
>   CHECK   include/linux/raid (2 files)
>   CHECK   include/linux/netfilter (76 files)
>   CHECK   include/linux/spi (1 files)
>   CHECK   include/linux/sunrpc (1 files)
>   CHECK   include/linux/tc_act (7 files)
>   CHECK   include/linux/tc_ematch (4 files)
>   CHECK   include/linux/wimax (1 files)
>   CHECK   include/linux/usb (10 files)
>   CHECK   include/linux (381 files)
> /usr/src/kernels/linux-3.8.13-xenomai-2.6.4/usr/include/linux/kexec.h:49:
> userspace cannot reference function or variable defined in the
> kernel /usr/src/kernels/linux-3.8.13-xenomai-2.6.4/usr/include/linux/soun=
dcard.h:1054:
> userspace cannot reference function or variable defined in the kernel
> CHECK   include/asm (64 files) LD      Documentation/built-in.o
> LD      Documentation/networking/built-in.o LD
> Documentation/auxdisplay/built-in.o LD
> Documentation/accounting/built-in.o HOSTCC
> Documentation/accounting/getdelays HOSTCC
> Documentation/filesystems/dnotify_test LD
> Documentation/laptops/built-in.o LD
> Documentation/misc-devices/mei/built-in.o LD
> Documentation/ia64/built-in.o HOSTCC
> Documentation/networking/ifenslave LD
> Documentation/filesystems/built-in.o LD
> Documentation/pcmcia/built-in.o LD
> Documentation/connector/built-in.o HOSTCC
> Documentation/auxdisplay/cfag12864b-example LD
> Documentation/timers/built-in.o LD
> Documentation/filesystems/configfs/built-in.o LD
> Documentation/watchdog/src/built-in.o LD
> Documentation/spi/built-in.o HOSTCC
> Documentation/watchdog/src/watchdog-simple HOSTCC
> Documentation/misc-devices/mei/mei-amt-version HOSTCC
> Documentation/watchdog/src/watchdog-test HOSTCC
> Documentation/pcmcia/crc32hash HOSTCC  Documentation/laptops/dslm
>   HOSTCC  Documentation/timers/hpet_example
>   HOSTCC  Documentation/ia64/aliasing-test
>   CC [M]  Documentation/connector/cn_test.o
>   HOSTCC  Documentation/spi/spidev_test
>   HOSTCC  Documentation/connector/ucon
>   HOSTCC  Documentation/spi/spidev_fdx
>   LD      Documentation/networking/timestamping/built-in.o
>   CC [M]
> Documentation/filesystems/configfs/configfs_example_explicit.o CC
> [M]  Documentation/filesystems/configfs/configfs_example_macros.o
> HOSTCC  Documentation/networking/timestamping/timestamping
> Documentation/misc-devices/mei/mei-amt-version.c: In function =E2=80=98ma=
in=E2=80=99:
> Documentation/misc-devices/mei/mei-amt-version.c:381: warning:
> dereferencing pointer =E2=80=98response.31=E2=80=99 does break strict-ali=
asing rules
> Documentation/misc-devices/mei/mei-amt-version.c:418: note:
> initialized from here LINK    vmlinux LD      vmlinux.o MODPOST
> vmlinux.o WARNING: vmlinux.o(.text+0x49131c): Section mismatch in
> reference from the function iommu_init_pci() to the
> function .init.text:amd_iommu_erratum_746_workaround() The function
> iommu_init_pci() references the function __init
> amd_iommu_erratum_746_workaround(). This is often because
> iommu_init_pci lacks a __init annotation or the annotation of
> amd_iommu_erratum_746_workaround is wrong.
>=20
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   KSYM    .tmp_kallsyms1.o
>   KSYM    .tmp_kallsyms2.o
>   LD      vmlinux
>   SORTEX  vmlinux
> sort done marker at d20808
>   SYSMAP  System.map
>   Building modules, stage 2.
>   CC      arch/x86/boot/a20.o
>   AS      arch/x86/boot/bioscall.o
>   CC      arch/x86/boot/cmdline.o
>   AS      arch/x86/boot/copy.o
>   HOSTCC  arch/x86/boot/mkcpustr
>   CC      arch/x86/boot/cpucheck.o
>   CC      arch/x86/boot/early_serial_console.o
>   CC      arch/x86/boot/edd.o
>   VOFFSET arch/x86/boot/voffset.h
>   CC      arch/x86/boot/main.o
>   CC      arch/x86/boot/mca.o
>   CC      arch/x86/boot/memory.o
>   CC      arch/x86/boot/pm.o
>   AS      arch/x86/boot/pmjump.o
>   CC      arch/x86/boot/printf.o
>   CC      arch/x86/boot/regs.o
>   CC      arch/x86/boot/string.o
>   CC      arch/x86/boot/tty.o
>   CC      arch/x86/boot/video.o
>   CC      arch/x86/boot/video-mode.o
>   CC      arch/x86/boot/version.o
>   MODPOST 1553 modules
>   CC      arch/x86/boot/video-vga.o
>   CC      arch/x86/boot/video-vesa.o
>   CC      arch/x86/boot/video-bios.o
>   HOSTCC  arch/x86/boot/tools/build
>   LDS     arch/x86/boot/compressed/vmlinux.lds
>   AS      arch/x86/boot/compressed/head_64.o
>   CC      arch/x86/boot/compressed/misc.o
>   CC      arch/x86/boot/compressed/string.o
>   CPUSTR  arch/x86/boot/cpustr.h
>   CC      arch/x86/boot/compressed/cmdline.o
>   CC      arch/x86/boot/compressed/early_serial_console.o
>   OBJCOPY arch/x86/boot/compressed/vmlinux.bin
>   HOSTCC  arch/x86/boot/compressed/mkpiggy
>   CC      arch/x86/boot/cpu.o
>   GZIP    arch/x86/boot/compressed/vmlinux.bin.gz
>   MKPIGGY arch/x86/boot/compressed/piggy.S
>   AS      arch/x86/boot/compressed/piggy.o
>   LD      arch/x86/boot/compressed/vmlinux
>   ZOFFSET arch/x86/boot/zoffset.h
>   OBJCOPY arch/x86/boot/vmlinux.bin
>   AS      arch/x86/boot/header.o
>   LD      arch/x86/boot/setup.elf
>   OBJCOPY arch/x86/boot/setup.bin
>   BUILD   arch/x86/boot/bzImage
> Setup is 15116 bytes (padded to 15360 bytes).
> System is 3934 kB
> CRC 79b50043
> Kernel: arch/x86/boot/bzImage is ready  (#2)
>   CC      Documentation/connector/cn_test.mod.o
>   CC
> Documentation/filesystems/configfs/configfs_example_explicit.mod.o
> CC
> Documentation/filesystems/configfs/configfs_example_macros.mod.o
> CC      arch/x86/crypto/ablk_helper.mod.o CC
> arch/x86/crypto/aes-x86_64.mod.o CC
> arch/x86/crypto/aesni-intel.mod.o CC
> arch/x86/crypto/crc32c-intel.mod.o CC
> arch/x86/crypto/ghash-clmulni-intel.mod.o CC
> arch/x86/crypto/salsa20-x86_64.mod.o CC
> arch/x86/crypto/twofish-x86_64.mod.o CC
> arch/x86/kernel/cpu/mcheck/mce-inject.mod.o CC
> arch/x86/kernel/microcode.mod.o CC      arch/x86/kvm/kvm-amd.mod.o
> CC      arch/x86/kvm/kvm-intel.mod.o CC      arch/x86/kvm/kvm.mod.o
>   CC      arch/x86/oprofile/oprofile.mod.o
>   CC      crypto/ansi_cprng.mod.o
>   CC      crypto/anubis.mod.o
>   CC      crypto/arc4.mod.o
>   CC      crypto/async_tx/async_memcpy.mod.o
>   CC      crypto/async_tx/async_pq.mod.o
>   CC      crypto/async_tx/async_raid6_recov.mod.o
>   CC      crypto/async_tx/async_tx.mod.o
>   CC      crypto/async_tx/async_xor.mod.o
>   CC      crypto/async_tx/raid6test.mod.o
>   CC      crypto/authenc.mod.o
>   CC      crypto/authencesn.mod.o
>   CC      crypto/blowfish_common.mod.o
>   CC      crypto/blowfish_generic.mod.o
>   CC      crypto/camellia_generic.mod.o
>   CC      crypto/cast5_generic.mod.o
>   CC      crypto/cast6_generic.mod.o
>   CC      crypto/cast_common.mod.o
>   CC      crypto/cbc.mod.o
>   CC      crypto/cryptd.mod.o
>   CC      crypto/ccm.mod.o
>   CC      crypto/crypto_null.mod.o
>   CC      crypto/ctr.mod.o
>   CC      crypto/deflate.mod.o
>   CC      crypto/cts.mod.o
>   CC      crypto/des_generic.mod.o
>   CC      crypto/ecb.mod.o
>   CC      crypto/gcm.mod.o
>   CC      crypto/fcrypt.mod.o
>   CC      crypto/gf128mul.mod.o
>   CC      crypto/ghash-generic.mod.o
>   CC      crypto/khazad.mod.o
>   CC      crypto/lrw.mod.o
>   CC      crypto/lzo.mod.o
>   CC      crypto/md4.mod.o
>   CC      crypto/michael_mic.mod.o
>   CC      crypto/pcbc.mod.o
>   CC      crypto/rmd128.mod.o
>   CC      crypto/rmd160.mod.o
>   CC      crypto/rmd256.mod.o
>   CC      crypto/rmd320.mod.o
>   CC      crypto/seed.mod.o
>   CC      crypto/seqiv.mod.o
>   CC      crypto/serpent_generic.mod.o
>   CC      crypto/sha512_generic.mod.o
>   CC      crypto/tcrypt.mod.o
>   CC      crypto/tea.mod.o
>   CC      crypto/tgr192.mod.o
>   CC      crypto/twofish_common.mod.o
>   CC      crypto/vmac.mod.o
>   CC      crypto/wp512.mod.o
>   CC      crypto/xcbc.mod.o
>   CC      crypto/xor.mod.o
>   CC      crypto/xts.mod.o
>   CC      crypto/zlib.mod.o
>   CC      drivers/acpi/acpi_i2c.mod.o
>   CC      drivers/acpi/acpi_ipmi.mod.o
>   CC      drivers/acpi/apei/einj.mod.o
>   CC      drivers/acpi/apei/erst-dbg.mod.o
>   CC      drivers/acpi/sbs.mod.o
>   CC      drivers/acpi/sbshc.mod.o
>   CC      drivers/acpi/video.mod.o
>   CC      drivers/ata/ahci.mod.o
>   CC      drivers/ata/ata_generic.mod.o
>   CC      drivers/ata/ata_piix.mod.o
>   CC      drivers/ata/libahci.mod.o
>   CC      drivers/ata/pata_acpi.mod.o
>   CC      drivers/ata/pata_ali.mod.o
>   CC      drivers/ata/pata_amd.mod.o
>   CC      drivers/ata/pata_artop.mod.o
>   CC      drivers/ata/pata_atiixp.mod.o
>   CC      drivers/ata/pata_cmd64x.mod.o
>   CC      drivers/ata/pata_atp867x.mod.o
>   CC      drivers/ata/pata_hpt366.mod.o
>   CC      drivers/ata/pata_hpt37x.mod.o
>   CC      drivers/ata/pata_hpt3x2n.mod.o
>   CC      drivers/ata/pata_hpt3x3.mod.o
>   CC      drivers/ata/pata_it8213.mod.o
>   CC      drivers/ata/pata_it821x.mod.o
>   CC      drivers/ata/pata_jmicron.mod.o
>   CC      drivers/ata/pata_marvell.mod.o
>   CC      drivers/ata/pata_netcell.mod.o
>   CC      drivers/ata/pata_ninja32.mod.o
>   CC      drivers/ata/pata_oldpiix.mod.o
>   CC      drivers/ata/pata_pcmcia.mod.o
>   CC      drivers/ata/pata_pdc2027x.mod.o
>   CC      drivers/ata/pata_pdc202xx_old.mod.o
>   CC      drivers/ata/pata_rdc.mod.o
>   CC      drivers/ata/pata_sch.mod.o
>   CC      drivers/ata/pata_serverworks.mod.o
>   CC      drivers/ata/pata_sil680.mod.o
>   CC      drivers/ata/pata_sis.mod.o
>   CC      drivers/ata/pata_via.mod.o
>   CC      drivers/ata/pdc_adma.mod.o
>   CC      drivers/ata/sata_mv.mod.o
>   CC      drivers/ata/sata_inic162x.mod.o
>   CC      drivers/ata/sata_nv.mod.o
>   CC      drivers/ata/sata_promise.mod.o
>   CC      drivers/ata/sata_qstor.mod.o
>   CC      drivers/ata/sata_sil.mod.o
>   CC      drivers/ata/sata_sil24.mod.o
>   CC      drivers/ata/sata_sis.mod.o
>   CC      drivers/ata/sata_svw.mod.o
>   CC      drivers/ata/sata_sx4.mod.o
>   CC      drivers/ata/sata_uli.mod.o
>   CC      drivers/ata/sata_via.mod.o
>   CC      drivers/ata/sata_vsc.mod.o
>   CC      drivers/atm/atmtcp.mod.o
>   CC      drivers/auxdisplay/cfag12864b.mod.o
>   CC      drivers/auxdisplay/ks0108.mod.o
>   CC      drivers/auxdisplay/cfag12864bfb.mod.o
>   CC      drivers/base/regmap/regmap-i2c.mod.o
>   CC      drivers/bcma/bcma.mod.o
>   CC      drivers/block/aoe/aoe.mod.o
>   CC      drivers/block/cciss.mod.o
>   CC      drivers/block/cryptoloop.mod.o
>   CC      drivers/block/floppy.mod.o
>   CC      drivers/block/mtip32xx/mtip32xx.mod.o
>   CC      drivers/block/nvme.mod.o
>   CC      drivers/block/osdblk.mod.o
>   CC      drivers/block/pktcdvd.mod.o
>   CC      drivers/block/sx8.mod.o
>   CC      drivers/block/virtio_blk.mod.o
>   CC      drivers/bluetooth/bcm203x.mod.o
>   CC      drivers/bluetooth/bfusb.mod.o
>   CC      drivers/bluetooth/bluecard_cs.mod.o
>   CC      drivers/bluetooth/bpa10x.mod.o
>   CC      drivers/bluetooth/bt3c_cs.mod.o
>   CC      drivers/bluetooth/btmrvl.mod.o
>   CC      drivers/bluetooth/btmrvl_sdio.mod.o
>   CC      drivers/bluetooth/btsdio.mod.o
>   CC      drivers/bluetooth/btuart_cs.mod.o
>   CC      drivers/bluetooth/btusb.mod.o
>   CC      drivers/bluetooth/dtl1_cs.mod.o
>   CC      drivers/bluetooth/hci_uart.mod.o
>   CC      drivers/bluetooth/hci_vhci.mod.o
>   CC      drivers/cdrom/cdrom.mod.o
>   CC      drivers/char/hangcheck-timer.mod.o
>   CC      drivers/char/hw_random/amd-rng.mod.o
>   CC      drivers/char/hw_random/intel-rng.mod.o
>   CC      drivers/char/hw_random/timeriomem-rng.mod.o
>   CC      drivers/char/hw_random/via-rng.mod.o
>   CC      drivers/char/hw_random/virtio-rng.mod.o
>   CC      drivers/char/i8k.mod.o
>   CC      drivers/char/ipmi/ipmi_devintf.mod.o
>   CC      drivers/char/ipmi/ipmi_msghandler.mod.o
>   CC      drivers/char/ipmi/ipmi_poweroff.mod.o
>   CC      drivers/char/ipmi/ipmi_si.mod.o
>   CC      drivers/char/ipmi/ipmi_watchdog.mod.o
>   CC      drivers/char/lp.mod.o
>   CC      drivers/char/pcmcia/cm4000_cs.mod.o
>   CC      drivers/char/pcmcia/cm4040_cs.mod.o
>   CC      drivers/char/ppdev.mod.o
>   CC      drivers/char/tlclk.mod.o
>   CC      drivers/char/tpm/tpm_atmel.mod.o
>   CC      drivers/char/tpm/tpm_infineon.mod.o
>   CC      drivers/char/tpm/tpm_nsc.mod.o
>   CC      drivers/char/virtio_console.mod.o
>   CC      drivers/crypto/padlock-aes.mod.o
>   CC      drivers/crypto/padlock-sha.mod.o
>   CC      drivers/dca/dca.mod.o
>   CC      drivers/dma/ioat/ioatdma.mod.o
>   CC      drivers/edac/amd64_edac_mod.mod.o
>   CC      drivers/edac/e752x_edac.mod.o
>   CC      drivers/edac/edac_core.mod.o
>   CC      drivers/edac/edac_mce_amd.mod.o
>   CC      drivers/edac/i3000_edac.mod.o
>   CC      drivers/edac/i3200_edac.mod.o
>   CC      drivers/edac/i5000_edac.mod.o
>   CC      drivers/edac/i5100_edac.mod.o
>   CC      drivers/edac/i5400_edac.mod.o
>   CC      drivers/edac/i7300_edac.mod.o
>   CC      drivers/edac/i7core_edac.mod.o
>   CC      drivers/edac/i82975x_edac.mod.o
>   CC      drivers/edac/sb_edac.mod.o
>   CC      drivers/edac/x38_edac.mod.o
>   CC      drivers/firewire/firewire-core.mod.o
>   CC      drivers/firewire/firewire-net.mod.o
>   CC      drivers/firewire/firewire-ohci.mod.o
>   CC      drivers/firewire/firewire-sbp2.mod.o
>   CC      drivers/firmware/dcdbas.mod.o
>   CC      drivers/firmware/dell_rbu.mod.o
>   CC      drivers/firmware/edd.mod.o
>   CC      drivers/firmware/iscsi_ibft.mod.o
>   CC      drivers/gpio/gpio-sch.mod.o
>   CC      drivers/gpu/drm/drm.mod.o
>   CC      drivers/gpu/drm/drm_kms_helper.mod.o
>   CC      drivers/gpu/drm/i2c/ch7006.mod.o
>   CC      drivers/gpu/drm/i2c/sil164.mod.o
>   CC      drivers/gpu/drm/i915/i915.mod.o
>   CC      drivers/gpu/drm/mga/mga.mod.o
>   CC      drivers/gpu/drm/nouveau/nouveau.mod.o
>   CC      drivers/gpu/drm/r128/r128.mod.o
>   CC      drivers/gpu/drm/radeon/radeon.mod.o
>   CC      drivers/gpu/drm/savage/savage.mod.o
>   CC      drivers/gpu/drm/sis/sis.mod.o
>   CC      drivers/gpu/drm/ttm/ttm.mod.o
>   CC      drivers/gpu/drm/via/via.mod.o
>   CC      drivers/hid/hid-multitouch.mod.o
>   CC      drivers/hid/hid-wacom.mod.o
>   CC      drivers/hv/hv_balloon.mod.o
>   CC      drivers/hv/hv_utils.mod.o
>   CC      drivers/hv/hv_vmbus.mod.o
>   CC      drivers/hwmon/abituguru.mod.o
>   CC      drivers/hwmon/abituguru3.mod.o
>   CC      drivers/hwmon/ad7414.mod.o
>   CC      drivers/hwmon/ad7418.mod.o
>   CC      drivers/hwmon/adm1021.mod.o
>   CC      drivers/hwmon/adm1025.mod.o
>   CC      drivers/hwmon/adm1026.mod.o
>   CC      drivers/hwmon/adm1029.mod.o
>   CC      drivers/hwmon/adm1031.mod.o
>   CC      drivers/hwmon/adm9240.mod.o
>   CC      drivers/hwmon/ads7828.mod.o
>   CC      drivers/hwmon/adt7462.mod.o
>   CC      drivers/hwmon/adt7470.mod.o
>   CC      drivers/hwmon/adt7475.mod.o
>   CC      drivers/hwmon/applesmc.mod.o
>   CC      drivers/hwmon/asb100.mod.o
>   CC      drivers/hwmon/asus_atk0110.mod.o
>   CC      drivers/hwmon/atxp1.mod.o
>   CC      drivers/hwmon/coretemp.mod.o
>   CC      drivers/hwmon/dme1737.mod.o
>   CC      drivers/hwmon/ds1621.mod.o
>   CC      drivers/hwmon/f71805f.mod.o
>   CC      drivers/hwmon/f71882fg.mod.o
>   CC      drivers/hwmon/f75375s.mod.o
>   CC      drivers/hwmon/fam15h_power.mod.o
>   CC      drivers/hwmon/fschmd.mod.o
>   CC      drivers/hwmon/g760a.mod.o
>   CC      drivers/hwmon/gl518sm.mod.o
>   CC      drivers/hwmon/gl520sm.mod.o
>   CC      drivers/hwmon/hwmon-vid.mod.o
>   CC      drivers/hwmon/i5k_amb.mod.o
>   CC      drivers/hwmon/ibmaem.mod.o
>   CC      drivers/hwmon/ibmpex.mod.o
>   CC      drivers/hwmon/it87.mod.o
>   CC      drivers/hwmon/k10temp.mod.o
>   CC      drivers/hwmon/k8temp.mod.o
>   CC      drivers/hwmon/lm63.mod.o
>   CC      drivers/hwmon/lm75.mod.o
>   CC      drivers/hwmon/lm77.mod.o
>   CC      drivers/hwmon/lm78.mod.o
>   CC      drivers/hwmon/lm80.mod.o
>   CC      drivers/hwmon/lm83.mod.o
>   CC      drivers/hwmon/lm85.mod.o
>   CC      drivers/hwmon/lm87.mod.o
>   CC      drivers/hwmon/lm90.mod.o
>   CC      drivers/hwmon/lm92.mod.o
>   CC      drivers/hwmon/lm93.mod.o
>   CC      drivers/hwmon/lm95241.mod.o
>   CC      drivers/hwmon/ltc4215.mod.o
>   CC      drivers/hwmon/ltc4245.mod.o
>   CC      drivers/hwmon/max1619.mod.o
>   CC      drivers/hwmon/max6650.mod.o
>   CC      drivers/hwmon/pc87360.mod.o
>   CC      drivers/hwmon/pc87427.mod.o
>   CC      drivers/hwmon/pcf8591.mod.o
>   CC      drivers/hwmon/sht15.mod.o
>   CC      drivers/hwmon/sis5595.mod.o
>   CC      drivers/hwmon/smsc47b397.mod.o
>   CC      drivers/hwmon/smsc47m1.mod.o
>   CC      drivers/hwmon/smsc47m192.mod.o
>   CC      drivers/hwmon/thmc50.mod.o
>   CC      drivers/hwmon/tmp401.mod.o
>   CC      drivers/hwmon/tmp421.mod.o
>   CC      drivers/hwmon/via-cputemp.mod.o
>   CC      drivers/hwmon/vt1211.mod.o
>   CC      drivers/hwmon/via686a.mod.o
>   CC      drivers/hwmon/vt8231.mod.o
>   CC      drivers/hwmon/w83627ehf.mod.o
>   CC      drivers/hwmon/w83627hf.mod.o
>   CC      drivers/hwmon/w83781d.mod.o
>   CC      drivers/hwmon/w83791d.mod.o
>   CC      drivers/hwmon/w83792d.mod.o
>   CC      drivers/hwmon/w83793.mod.o
>   CC      drivers/hwmon/w83l785ts.mod.o
>   CC      drivers/hwmon/w83l786ng.mod.o
>   CC      drivers/i2c/algos/i2c-algo-bit.mod.o
>   CC      drivers/i2c/algos/i2c-algo-pca.mod.o
>   CC      drivers/i2c/busses/i2c-amd756-s4882.mod.o
>   CC      drivers/i2c/busses/i2c-amd756.mod.o
>   CC      drivers/i2c/busses/i2c-amd8111.mod.o
>   CC      drivers/i2c/busses/i2c-i801.mod.o
>   CC      drivers/i2c/busses/i2c-isch.mod.o
>   CC      drivers/i2c/busses/i2c-nforce2-s4985.mod.o
>   CC      drivers/i2c/busses/i2c-nforce2.mod.o
>   CC      drivers/i2c/busses/i2c-parport-light.mod.o
>   CC      drivers/i2c/busses/i2c-parport.mod.o
>   CC      drivers/i2c/busses/i2c-pca-platform.mod.o
>   CC      drivers/i2c/busses/i2c-piix4.mod.o
>   CC      drivers/i2c/busses/i2c-scmi.mod.o
>   CC      drivers/i2c/busses/i2c-simtec.mod.o
>   CC      drivers/i2c/busses/i2c-sis96x.mod.o
>   CC      drivers/i2c/busses/i2c-tiny-usb.mod.o
>   CC      drivers/i2c/busses/i2c-via.mod.o
>   CC      drivers/i2c/busses/i2c-viapro.mod.o
>   CC      drivers/i2c/i2c-core.mod.o
>   CC      drivers/i2c/i2c-dev.mod.o
>   CC      drivers/i2c/i2c-smbus.mod.o
>   CC      drivers/i2c/i2c-stub.mod.o
>   CC      drivers/idle/i7300_idle.mod.o
>   CC      drivers/infiniband/core/ib_addr.mod.o
>   CC      drivers/infiniband/core/ib_cm.mod.o
>   CC      drivers/infiniband/core/ib_core.mod.o
>   CC      drivers/infiniband/core/ib_mad.mod.o
>   CC      drivers/infiniband/core/ib_sa.mod.o
>   CC      drivers/infiniband/core/ib_ucm.mod.o
>   CC      drivers/infiniband/core/ib_umad.mod.o
>   CC      drivers/infiniband/core/ib_uverbs.mod.o
>   CC      drivers/infiniband/core/iw_cm.mod.o
>   CC      drivers/infiniband/core/rdma_cm.mod.o
>   CC      drivers/infiniband/core/rdma_ucm.mod.o
>   CC      drivers/infiniband/hw/cxgb3/iw_cxgb3.mod.o
>   CC      drivers/infiniband/hw/cxgb4/iw_cxgb4.mod.o
>   CC      drivers/infiniband/hw/ipath/ib_ipath.mod.o
>   CC      drivers/infiniband/hw/mlx4/mlx4_ib.mod.o
>   CC      drivers/infiniband/hw/mthca/ib_mthca.mod.o
>   CC      drivers/infiniband/hw/nes/iw_nes.mod.o
>   CC      drivers/infiniband/hw/ocrdma/ocrdma.mod.o
>   CC      drivers/infiniband/hw/qib/ib_qib.mod.o
>   CC      drivers/infiniband/ulp/ipoib/ib_ipoib.mod.o
>   CC      drivers/infiniband/ulp/iser/ib_iser.mod.o
>   CC      drivers/infiniband/ulp/srp/ib_srp.mod.o
>   CC      drivers/input/input-polldev.mod.o
>   CC      drivers/input/joydev.mod.o
>   CC      drivers/input/keyboard/adp5588-keys.mod.o
>   CC      drivers/input/keyboard/max7359_keypad.mod.o
>   CC      drivers/input/keyboard/opencores-kbd.mod.o
>   CC      drivers/input/misc/apanel.mod.o
>   CC      drivers/input/misc/ati_remote2.mod.o
>   CC      drivers/input/misc/atlas_btns.mod.o
>   CC      drivers/input/misc/cm109.mod.o
>   CC      drivers/input/misc/keyspan_remote.mod.o
>   CC      drivers/input/misc/pcspkr.mod.o
>   CC      drivers/input/misc/powermate.mod.o
>   CC      drivers/input/misc/rotary_encoder.mod.o
>   CC      drivers/input/misc/uinput.mod.o
>   CC      drivers/input/misc/yealink.mod.o
>   CC      drivers/input/mouse/appletouch.mod.o
>   CC      drivers/input/mouse/bcm5974.mod.o
>   CC      drivers/input/mouse/sermouse.mod.o
>   CC      drivers/input/mouse/synaptics_i2c.mod.o
>   CC      drivers/input/mouse/vsxxxaa.mod.o
>   CC      drivers/input/serio/serio_raw.mod.o
>   CC      drivers/input/sparse-keymap.mod.o
>   CC      drivers/input/tablet/acecad.mod.o
>   CC      drivers/input/tablet/aiptek.mod.o
>   CC      drivers/input/tablet/gtco.mod.o
>   CC      drivers/input/tablet/kbtab.mod.o
>   CC      drivers/input/tablet/wacom.mod.o
>   CC      drivers/input/touchscreen/ad7879-i2c.mod.o
>   CC      drivers/input/touchscreen/ad7879.mod.o
>   CC      drivers/input/touchscreen/eeti_ts.mod.o
>   CC      drivers/input/touchscreen/elo.mod.o
>   CC      drivers/input/touchscreen/fujitsu_ts.mod.o
>   CC      drivers/input/touchscreen/gunze.mod.o
>   CC      drivers/input/touchscreen/inexio.mod.o
>   CC      drivers/input/touchscreen/mcs5000_ts.mod.o
>   CC      drivers/input/touchscreen/mtouch.mod.o
>   CC      drivers/input/touchscreen/penmount.mod.o
>   CC      drivers/input/touchscreen/touchit213.mod.o
>   CC      drivers/input/touchscreen/touchright.mod.o
>   CC      drivers/input/touchscreen/touchwin.mod.o
>   CC      drivers/input/touchscreen/tsc2007.mod.o
>   CC      drivers/input/touchscreen/usbtouchscreen.mod.o
>   CC      drivers/input/touchscreen/wacom_w8001.mod.o
>   CC      drivers/isdn/capi/capi.mod.o
>   CC      drivers/isdn/capi/capidrv.mod.o
>   CC      drivers/isdn/capi/kernelcapi.mod.o
>   CC      drivers/isdn/divert/dss1_divert.mod.o
>   CC      drivers/isdn/gigaset/bas_gigaset.mod.o
>   CC      drivers/isdn/gigaset/gigaset.mod.o
>   CC      drivers/isdn/gigaset/ser_gigaset.mod.o
>   CC      drivers/isdn/gigaset/usb_gigaset.mod.o
>   CC      drivers/isdn/hardware/avm/avm_cs.mod.o
>   CC      drivers/isdn/hardware/avm/b1.mod.o
>   CC      drivers/isdn/hardware/avm/b1dma.mod.o
>   CC      drivers/isdn/hardware/avm/b1pci.mod.o
>   CC      drivers/isdn/hardware/avm/b1pcmcia.mod.o
>   CC      drivers/isdn/hardware/avm/c4.mod.o
>   CC      drivers/isdn/hardware/avm/t1pci.mod.o
>   CC      drivers/isdn/hardware/mISDN/avmfritz.mod.o
>   CC      drivers/isdn/hardware/mISDN/hfcmulti.mod.o
>   CC      drivers/isdn/hardware/mISDN/hfcpci.mod.o
>   CC      drivers/isdn/hardware/mISDN/hfcsusb.mod.o
>   CC      drivers/isdn/hardware/mISDN/mISDNinfineon.mod.o
>   CC      drivers/isdn/hardware/mISDN/mISDNipac.mod.o
>   CC      drivers/isdn/hardware/mISDN/mISDNisar.mod.o
>   CC      drivers/isdn/hardware/mISDN/netjet.mod.o
>   CC      drivers/isdn/hardware/mISDN/speedfax.mod.o
>   CC      drivers/isdn/hardware/mISDN/w6692.mod.o
>   CC      drivers/isdn/hisax/avma1_cs.mod.o
>   CC      drivers/isdn/hisax/elsa_cs.mod.o
>   CC      drivers/isdn/hisax/hfc4s8s_l1.mod.o
>   CC      drivers/isdn/hisax/hisax.mod.o
>   CC      drivers/isdn/hisax/hisax_fcpcipnp.mod.o
>   CC      drivers/isdn/hisax/hisax_isac.mod.o
>   CC      drivers/isdn/hisax/hisax_st5481.mod.o
>   CC      drivers/isdn/hisax/sedlbauer_cs.mod.o
>   CC      drivers/isdn/hisax/teles_cs.mod.o
>   CC      drivers/isdn/hysdn/hysdn.mod.o
>   CC      drivers/isdn/i4l/isdn.mod.o
>   CC      drivers/isdn/i4l/isdnhdlc.mod.o
>   CC      drivers/isdn/mISDN/l1oip.mod.o
>   CC      drivers/isdn/mISDN/mISDN_core.mod.o
>   CC      drivers/isdn/mISDN/mISDN_dsp.mod.o
>   CC      drivers/leds/leds-clevo-mail.mod.o
>   CC      drivers/leds/leds-lp3944.mod.o
>   CC      drivers/leds/ledtrig-backlight.mod.o
>   CC      drivers/leds/ledtrig-default-on.mod.o
>   CC      drivers/leds/ledtrig-heartbeat.mod.o
>   CC      drivers/leds/ledtrig-timer.mod.o
>   CC      drivers/md/dm-bio-prison.mod.o
>   CC      drivers/md/dm-bufio.mod.o
>   CC      drivers/md/dm-crypt.mod.o
>   CC      drivers/md/dm-delay.mod.o
>   CC      drivers/md/dm-flakey.mod.o
>   CC      drivers/md/dm-log-userspace.mod.o
>   CC      drivers/md/dm-log.mod.o
>   CC      drivers/md/dm-mirror.mod.o
>   CC      drivers/md/dm-mod.mod.o
>   CC      drivers/md/dm-multipath.mod.o
>   CC      drivers/md/dm-queue-length.mod.o
>   CC      drivers/md/dm-raid.mod.o
>   CC      drivers/md/dm-region-hash.mod.o
>   CC      drivers/md/dm-round-robin.mod.o
>   CC      drivers/md/dm-service-time.mod.o
>   CC      drivers/md/dm-snapshot.mod.o
>   CC      drivers/md/dm-thin-pool.mod.o
>   CC      drivers/md/dm-zero.mod.o
>   CC      drivers/md/faulty.mod.o
>   CC      drivers/md/linear.mod.o
>   CC      drivers/md/persistent-data/dm-persistent-data.mod.o
>   CC      drivers/md/raid0.mod.o
>   CC      drivers/md/raid1.mod.o
>   CC      drivers/md/raid10.mod.o
>   CC      drivers/md/raid456.mod.o
>   CC      drivers/memstick/core/memstick.mod.o
>   CC      drivers/memstick/core/mspro_block.mod.o
>   CC      drivers/memstick/host/jmb38x_ms.mod.o
>   CC      drivers/memstick/host/r592.mod.o
>   CC      drivers/memstick/host/rtsx_pci_ms.mod.o
>   CC      drivers/memstick/host/tifm_ms.mod.o
>   CC      drivers/message/fusion/mptbase.mod.o
>   CC      drivers/message/fusion/mptctl.mod.o
>   CC      drivers/message/fusion/mptfc.mod.o
>   CC      drivers/message/fusion/mptlan.mod.o
>   CC      drivers/message/fusion/mptsas.mod.o
>   CC      drivers/message/fusion/mptscsih.mod.o
>   CC      drivers/message/fusion/mptspi.mod.o
>   CC      drivers/mfd/lpc_ich.mod.o
>   CC      drivers/mfd/lpc_sch.mod.o
>   CC      drivers/mfd/mfd-core.mod.o
>   CC      drivers/mfd/rtsx_pci.mod.o
>   CC      drivers/mfd/sm501.mod.o
>   CC      drivers/misc/cb710/cb710.mod.o
>   CC      drivers/misc/eeprom/at24.mod.o
>   CC      drivers/misc/eeprom/eeprom.mod.o
>   CC      drivers/misc/eeprom/eeprom_93cx6.mod.o
>   CC      drivers/misc/eeprom/max6875.mod.o
>   CC      drivers/misc/enclosure.mod.o
>   CC      drivers/misc/hpilo.mod.o
>   CC      drivers/misc/ics932s401.mod.o
>   CC      drivers/misc/ioc4.mod.o
>   CC      drivers/misc/isl29003.mod.o
>   CC      drivers/misc/tifm_7xx1.mod.o
>   CC      drivers/misc/tifm_core.mod.o
>   CC      drivers/misc/tsl2550.mod.o
>   CC      drivers/misc/vmw_balloon.mod.o
>   CC      drivers/mmc/card/mmc_block.mod.o
>   CC      drivers/mmc/card/sdio_uart.mod.o
>   CC      drivers/mmc/core/mmc_core.mod.o
>   CC      drivers/mmc/host/cb710-mmc.mod.o
>   CC      drivers/mmc/host/rtsx_pci_sdmmc.mod.o
>   CC      drivers/mmc/host/sdhci-pci.mod.o
>   CC      drivers/mmc/host/sdhci-pltfm.mod.o
>   CC      drivers/mmc/host/sdhci.mod.o
>   CC      drivers/mmc/host/sdricoh_cs.mod.o
>   CC      drivers/mmc/host/tifm_sd.mod.o
>   CC      drivers/mmc/host/via-sdmmc.mod.o
>   CC      drivers/mtd/ar7part.mod.o
>   CC      drivers/mtd/chips/cfi_cmdset_0001.mod.o
>   CC      drivers/mtd/chips/cfi_cmdset_0002.mod.o
>   CC      drivers/mtd/chips/cfi_cmdset_0020.mod.o
>   CC      drivers/mtd/chips/cfi_probe.mod.o
>   CC      drivers/mtd/chips/cfi_util.mod.o
>   CC      drivers/mtd/chips/gen_probe.mod.o
>   CC      drivers/mtd/chips/jedec_probe.mod.o
>   CC      drivers/mtd/chips/map_absent.mod.o
>   CC      drivers/mtd/chips/map_ram.mod.o
>   CC      drivers/mtd/chips/map_rom.mod.o
>   CC      drivers/mtd/devices/block2mtd.mod.o
>   CC      drivers/mtd/devices/mtdram.mod.o
>   CC      drivers/mtd/devices/pmc551.mod.o
>   CC      drivers/mtd/ftl.mod.o
>   CC      drivers/mtd/inftl.mod.o
>   CC      drivers/mtd/lpddr/lpddr_cmds.mod.o
>   CC      drivers/mtd/lpddr/qinfo_probe.mod.o
>   CC      drivers/mtd/maps/ck804xrom.mod.o
>   CC      drivers/mtd/maps/esb2rom.mod.o
>   CC      drivers/mtd/maps/netsc520.mod.o
>   CC      drivers/mtd/maps/pci.mod.o
>   CC      drivers/mtd/maps/sc520cdp.mod.o
>   CC      drivers/mtd/maps/scb2_flash.mod.o
>   CC      drivers/mtd/maps/ts5500_flash.mod.o
>   CC      drivers/mtd/mtd_blkdevs.mod.o
>   CC      drivers/mtd/mtdblock.mod.o
>   CC      drivers/mtd/mtdblock_ro.mod.o
>   CC      drivers/mtd/mtdchar.mod.o
>   CC      drivers/mtd/mtdoops.mod.o
>   CC      drivers/mtd/nand/alauda.mod.o
>   CC      drivers/mtd/nand/diskonchip.mod.o
>   CC      drivers/mtd/nand/nand.mod.o
>   CC      drivers/mtd/nand/nand_ecc.mod.o
>   CC      drivers/mtd/nand/nand_ids.mod.o
>   CC      drivers/mtd/nand/nandsim.mod.o
>   CC      drivers/mtd/nftl.mod.o
>   CC      drivers/mtd/redboot.mod.o
>   CC      drivers/mtd/rfd_ftl.mod.o
>   CC      drivers/mtd/ssfdc.mod.o
>   CC      drivers/mtd/ubi/ubi.mod.o
>   CC      drivers/net/bonding/bonding.mod.o
>   CC      drivers/net/can/can-dev.mod.o
>   CC      drivers/net/can/sja1000/ems_pci.mod.o
>   CC      drivers/net/can/sja1000/kvaser_pci.mod.o
>   CC      drivers/net/can/sja1000/sja1000.mod.o
>   CC      drivers/net/can/sja1000/sja1000_platform.mod.o
>   CC      drivers/net/can/usb/ems_usb.mod.o
>   CC      drivers/net/can/vcan.mod.o
>   CC      drivers/net/dummy.mod.o
>   CC      drivers/net/ethernet/3com/3c574_cs.mod.o
>   CC      drivers/net/ethernet/3com/3c589_cs.mod.o
>   CC      drivers/net/ethernet/3com/3c59x.mod.o
>   CC      drivers/net/ethernet/3com/typhoon.mod.o
>   CC      drivers/net/ethernet/8390/8390.mod.o
>   CC      drivers/net/ethernet/8390/axnet_cs.mod.o
>   CC      drivers/net/ethernet/8390/ne2k-pci.mod.o
>   CC      drivers/net/ethernet/8390/pcnet_cs.mod.o
>   CC      drivers/net/ethernet/adaptec/starfire.mod.o
>   CC      drivers/net/ethernet/alteon/acenic.mod.o
>   CC      drivers/net/ethernet/amd/amd8111e.mod.o
>   CC      drivers/net/ethernet/amd/nmclan_cs.mod.o
>   CC      drivers/net/ethernet/amd/pcnet32.mod.o
>   CC      drivers/net/ethernet/atheros/atl1c/atl1c.mod.o
>   CC      drivers/net/ethernet/atheros/atlx/atl1.mod.o
>   CC      drivers/net/ethernet/atheros/atl1e/atl1e.mod.o
>   CC      drivers/net/ethernet/atheros/atlx/atl2.mod.o
>   CC      drivers/net/ethernet/broadcom/b44.mod.o
>   CC      drivers/net/ethernet/broadcom/bnx2.mod.o
>   CC      drivers/net/ethernet/broadcom/bnx2x/bnx2x.mod.o
>   CC      drivers/net/ethernet/broadcom/cnic.mod.o
>   CC      drivers/net/ethernet/broadcom/tg3.mod.o
>   CC      drivers/net/ethernet/brocade/bna/bna.mod.o
>   CC      drivers/net/ethernet/chelsio/cxgb/cxgb.mod.o
>   CC      drivers/net/ethernet/chelsio/cxgb3/cxgb3.mod.o
>   CC      drivers/net/ethernet/chelsio/cxgb4/cxgb4.mod.o
>   CC      drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf.mod.o
>   CC      drivers/net/ethernet/cisco/enic/enic.mod.o
>   CC      drivers/net/ethernet/dec/tulip/de2104x.mod.o
>   CC      drivers/net/ethernet/dec/tulip/de4x5.mod.o
>   CC      drivers/net/ethernet/dec/tulip/dmfe.mod.o
>   CC      drivers/net/ethernet/dec/tulip/tulip.mod.o
>   CC      drivers/net/ethernet/dec/tulip/uli526x.mod.o
>   CC      drivers/net/ethernet/dec/tulip/winbond-840.mod.o
>   CC      drivers/net/ethernet/dec/tulip/xircom_cb.mod.o
>   CC      drivers/net/ethernet/dlink/dl2k.mod.o
>   CC      drivers/net/ethernet/dlink/sundance.mod.o
>   CC      drivers/net/ethernet/dnet.mod.o
>   CC      drivers/net/ethernet/emulex/benet/be2net.mod.o
>   CC      drivers/net/ethernet/ethoc.mod.o
>   CC      drivers/net/ethernet/fealnx.mod.o
>   CC      drivers/net/ethernet/fujitsu/fmvj18x_cs.mod.o
>   CC      drivers/net/ethernet/icplus/ipg.mod.o
>   CC      drivers/net/ethernet/intel/e100.mod.o
>   CC      drivers/net/ethernet/intel/e1000/e1000.mod.o
>   CC      drivers/net/ethernet/intel/e1000e/e1000e.mod.o
>   CC      drivers/net/ethernet/intel/igb/igb.mod.o
>   CC      drivers/net/ethernet/intel/igbvf/igbvf.mod.o
>   CC      drivers/net/ethernet/intel/ixgb/ixgb.mod.o
>   CC      drivers/net/ethernet/intel/ixgbe/ixgbe.mod.o
>   CC      drivers/net/ethernet/intel/ixgbevf/ixgbevf.mod.o
>   CC      drivers/net/ethernet/jme.mod.o
>   CC      drivers/net/ethernet/marvell/skge.mod.o
>   CC      drivers/net/ethernet/marvell/sky2.mod.o
>   CC      drivers/net/ethernet/mellanox/mlx4/mlx4_core.mod.o
>   CC      drivers/net/ethernet/mellanox/mlx4/mlx4_en.mod.o
>   CC      drivers/net/ethernet/myricom/myri10ge/myri10ge.mod.o
>   CC      drivers/net/ethernet/natsemi/natsemi.mod.o
>   CC      drivers/net/ethernet/natsemi/ns83820.mod.o
>   CC      drivers/net/ethernet/neterion/s2io.mod.o
>   CC      drivers/net/ethernet/neterion/vxge/vxge.mod.o
>   CC      drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.mod.o
>   CC      drivers/net/ethernet/nvidia/forcedeth.mod.o
>   CC      drivers/net/ethernet/qlogic/netxen/netxen_nic.mod.o
>   CC      drivers/net/ethernet/qlogic/qla3xxx.mod.o
>   CC      drivers/net/ethernet/qlogic/qlcnic/qlcnic.mod.o
>   CC      drivers/net/ethernet/qlogic/qlge/qlge.mod.o
>   CC      drivers/net/ethernet/rdc/r6040.mod.o
>   CC      drivers/net/ethernet/realtek/8139cp.mod.o
>   CC      drivers/net/ethernet/realtek/8139too.mod.o
>   CC      drivers/net/ethernet/realtek/r8169.mod.o
>   CC      drivers/net/ethernet/sfc/sfc.mod.o
>   CC      drivers/net/ethernet/silan/sc92031.mod.o
>   CC      drivers/net/ethernet/sis/sis190.mod.o
>   CC      drivers/net/ethernet/sis/sis900.mod.o
>   CC      drivers/net/ethernet/smsc/epic100.mod.o
>   CC      drivers/net/ethernet/smsc/smc91c92_cs.mod.o
>   CC      drivers/net/ethernet/smsc/smsc9420.mod.o
>   CC      drivers/net/ethernet/sun/cassini.mod.o
>   CC      drivers/net/ethernet/sun/niu.mod.o
>   CC      drivers/net/ethernet/sun/sungem.mod.o
>   CC      drivers/net/ethernet/sun/sunhme.mod.o
>   CC      drivers/net/ethernet/tehuti/tehuti.mod.o
>   CC      drivers/net/ethernet/ti/tlan.mod.o
>   CC      drivers/net/ethernet/via/via-rhine.mod.o
>   CC      drivers/net/ethernet/via/via-velocity.mod.o
>   CC      drivers/net/ethernet/xircom/xirc2ps_cs.mod.o
>   CC      drivers/net/hyperv/hv_netvsc.mod.o
>   CC      drivers/net/ieee802154/fakehard.mod.o
>   CC      drivers/net/ifb.mod.o
>   CC      drivers/net/macvlan.mod.o
>   CC      drivers/net/macvtap.mod.o
>   CC      drivers/net/mdio.mod.o
>   CC      drivers/net/mii.mod.o
>   CC      drivers/net/netconsole.mod.o
>   CC      drivers/net/phy/broadcom.mod.o
>   CC      drivers/net/phy/cicada.mod.o
>   CC      drivers/net/phy/davicom.mod.o
>   CC      drivers/net/phy/et1011c.mod.o
>   CC      drivers/net/phy/icplus.mod.o
>   CC      drivers/net/phy/lxt.mod.o
>   CC      drivers/net/phy/marvell.mod.o
>   CC      drivers/net/phy/mdio-bitbang.mod.o
>   CC      drivers/net/phy/national.mod.o
>   CC      drivers/net/phy/qsemi.mod.o
>   CC      drivers/net/phy/realtek.mod.o
>   CC      drivers/net/phy/smsc.mod.o
>   CC      drivers/net/phy/ste10Xp.mod.o
>   CC      drivers/net/phy/vitesse.mod.o
>   CC      drivers/net/ppp/ppp_async.mod.o
>   CC      drivers/net/ppp/ppp_deflate.mod.o
>   CC      drivers/net/ppp/ppp_generic.mod.o
>   CC      drivers/net/ppp/ppp_mppe.mod.o
>   CC      drivers/net/ppp/ppp_synctty.mod.o
>   CC      drivers/net/ppp/pppoe.mod.o
>   CC      drivers/net/ppp/pppox.mod.o
>   CC      drivers/net/slip/slhc.mod.o
>   CC      drivers/net/slip/slip.mod.o
>   CC      drivers/net/sungem_phy.mod.o
>   CC      drivers/net/tun.mod.o
>   CC      drivers/net/usb/asix.mod.o
>   CC      drivers/net/usb/catc.mod.o
>   CC      drivers/net/usb/cdc-phonet.mod.o
>   CC      drivers/net/usb/cdc_eem.mod.o
>   CC      drivers/net/usb/cdc_ether.mod.o
>   CC      drivers/net/usb/cdc_ncm.mod.o
>   CC      drivers/net/usb/cdc_subset.mod.o
>   CC      drivers/net/usb/dm9601.mod.o
>   CC      drivers/net/usb/gl620a.mod.o
>   CC      drivers/net/usb/hso.mod.o
>   CC      drivers/net/usb/int51x1.mod.o
>   CC      drivers/net/usb/kaweth.mod.o
>   CC      drivers/net/usb/mcs7830.mod.o
>   CC      drivers/net/usb/net1080.mod.o
>   CC      drivers/net/usb/pegasus.mod.o
>   CC      drivers/net/usb/plusb.mod.o
>   CC      drivers/net/usb/rndis_host.mod.o
>   CC      drivers/net/usb/rtl8150.mod.o
>   CC      drivers/net/usb/sierra_net.mod.o
>   CC      drivers/net/usb/smsc95xx.mod.o
>   CC      drivers/net/usb/usbnet.mod.o
>   CC      drivers/net/usb/zaurus.mod.o
>   CC      drivers/net/veth.mod.o
>   CC      drivers/net/virtio_net.mod.o
>   CC      drivers/net/vmxnet3/vmxnet3.mod.o
>   CC      drivers/net/vxlan.mod.o
>   CC      drivers/net/wan/dlci.mod.o
>   CC      drivers/net/wan/hdlc.mod.o
>   CC      drivers/net/wan/hdlc_cisco.mod.o
>   CC      drivers/net/wan/hdlc_fr.mod.o
>   CC      drivers/net/wan/hdlc_ppp.mod.o
>   CC      drivers/net/wan/hdlc_raw.mod.o
>   CC      drivers/net/wimax/i2400m/i2400m-usb.mod.o
>   CC      drivers/net/wimax/i2400m/i2400m.mod.o
>   CC      drivers/net/wireless/adm8211.mod.o
>   CC      drivers/net/wireless/airo.mod.o
>   CC      drivers/net/wireless/airo_cs.mod.o
>   CC      drivers/net/wireless/at76c50x-usb.mod.o
>   CC      drivers/net/wireless/ath/ath.mod.o
>   CC      drivers/net/wireless/ath/ath5k/ath5k.mod.o
>   CC      drivers/net/wireless/ath/ath9k/ath9k.mod.o
>   CC      drivers/net/wireless/ath/ath9k/ath9k_common.mod.o
>   CC      drivers/net/wireless/ath/ath9k/ath9k_htc.mod.o
>   CC      drivers/net/wireless/ath/ath9k/ath9k_hw.mod.o
>   CC      drivers/net/wireless/ath/carl9170/carl9170.mod.o
>   CC      drivers/net/wireless/atmel.mod.o
>   CC      drivers/net/wireless/atmel_cs.mod.o
>   CC      drivers/net/wireless/atmel_pci.mod.o
>   CC      drivers/net/wireless/b43/b43.mod.o
>   CC      drivers/net/wireless/b43legacy/b43legacy.mod.o
>   CC      drivers/net/wireless/brcm80211/brcmsmac/brcmsmac.mod.o
>   CC      drivers/net/wireless/brcm80211/brcmutil/brcmutil.mod.o
>   CC      drivers/net/wireless/hostap/hostap.mod.o
>   CC      drivers/net/wireless/hostap/hostap_cs.mod.o
>   CC      drivers/net/wireless/hostap/hostap_pci.mod.o
>   CC      drivers/net/wireless/hostap/hostap_plx.mod.o
>   CC      drivers/net/wireless/ipw2x00/ipw2100.mod.o
>   CC      drivers/net/wireless/ipw2x00/ipw2200.mod.o
>   CC      drivers/net/wireless/ipw2x00/libipw.mod.o
>   CC      drivers/net/wireless/iwlegacy/iwl3945.mod.o
>   CC      drivers/net/wireless/iwlegacy/iwl4965.mod.o
>   CC      drivers/net/wireless/iwlegacy/iwlegacy.mod.o
>   CC      drivers/net/wireless/iwlwifi/dvm/iwldvm.mod.o
>   CC      drivers/net/wireless/iwlwifi/iwlwifi.mod.o
>   CC      drivers/net/wireless/libertas/libertas.mod.o
>   CC      drivers/net/wireless/libertas/libertas_cs.mod.o
>   CC      drivers/net/wireless/libertas/libertas_sdio.mod.o
>   CC      drivers/net/wireless/libertas/usb8xxx.mod.o
>   CC      drivers/net/wireless/libertas_tf/libertas_tf.mod.o
>   CC      drivers/net/wireless/libertas_tf/libertas_tf_usb.mod.o
>   CC      drivers/net/wireless/mac80211_hwsim.mod.o
>   CC      drivers/net/wireless/mwl8k.mod.o
>   CC      drivers/net/wireless/orinoco/orinoco.mod.o
>   CC      drivers/net/wireless/orinoco/orinoco_cs.mod.o
>   CC      drivers/net/wireless/orinoco/orinoco_nortel.mod.o
>   CC      drivers/net/wireless/orinoco/orinoco_pci.mod.o
>   CC      drivers/net/wireless/orinoco/orinoco_plx.mod.o
>   CC      drivers/net/wireless/orinoco/orinoco_tmd.mod.o
>   CC      drivers/net/wireless/orinoco/spectrum_cs.mod.o
>   CC      drivers/net/wireless/p54/p54common.mod.o
>   CC      drivers/net/wireless/p54/p54pci.mod.o
>   CC      drivers/net/wireless/p54/p54usb.mod.o
>   CC      drivers/net/wireless/rndis_wlan.mod.o
>   CC      drivers/net/wireless/rt2x00/rt2400pci.mod.o
>   CC      drivers/net/wireless/rt2x00/rt2500pci.mod.o
>   CC      drivers/net/wireless/rt2x00/rt2500usb.mod.o
>   CC      drivers/net/wireless/rt2x00/rt2800lib.mod.o
>   CC      drivers/net/wireless/rt2x00/rt2800pci.mod.o
>   CC      drivers/net/wireless/rt2x00/rt2800usb.mod.o
>   CC      drivers/net/wireless/rt2x00/rt2x00lib.mod.o
>   CC      drivers/net/wireless/rt2x00/rt2x00pci.mod.o
>   CC      drivers/net/wireless/rt2x00/rt2x00usb.mod.o
>   CC      drivers/net/wireless/rt2x00/rt61pci.mod.o
>   CC      drivers/net/wireless/rt2x00/rt73usb.mod.o
>   CC      drivers/net/wireless/rtl818x/rtl8180/rtl8180.mod.o
>   CC      drivers/net/wireless/rtl818x/rtl8187/rtl8187.mod.o
>   CC      drivers/net/wireless/ti/wl1251/wl1251.mod.o
>   CC      drivers/net/wireless/ti/wl1251/wl1251_sdio.mod.o
>   CC      drivers/net/wireless/ti/wl12xx/wl12xx.mod.o
>   CC      drivers/net/wireless/ti/wlcore/wlcore.mod.o
>   CC      drivers/net/wireless/wl3501_cs.mod.o
>   CC      drivers/net/wireless/zd1201.mod.o
>   CC      drivers/net/wireless/zd1211rw/zd1211rw.mod.o
>   CC      drivers/parport/parport.mod.o
>   CC      drivers/parport/parport_cs.mod.o
>   CC      drivers/parport/parport_pc.mod.o
>   CC      drivers/parport/parport_serial.mod.o
>   CC      drivers/pci/hotplug/acpiphp_ibm.mod.o
>   CC      drivers/pci/hotplug/shpchp.mod.o
>   CC      drivers/pci/pcie/aer/aer_inject.mod.o
>   CC      drivers/pcmcia/pd6729.mod.o
>   CC      drivers/pcmcia/yenta_socket.mod.o
>   CC      drivers/platform/x86/acer-wmi.mod.o
>   CC      drivers/platform/x86/asus-laptop.mod.o
>   CC      drivers/platform/x86/compal-laptop.mod.o
>   CC      drivers/platform/x86/dell-laptop.mod.o
>   CC      drivers/platform/x86/dell-wmi.mod.o
>   CC      drivers/platform/x86/eeepc-laptop.mod.o
>   CC      drivers/platform/x86/fujitsu-laptop.mod.o
>   CC      drivers/platform/x86/hdaps.mod.o
>   CC      drivers/platform/x86/hp-wmi.mod.o
>   CC      drivers/platform/x86/intel_ips.mod.o
>   CC      drivers/platform/x86/msi-laptop.mod.o
>   CC      drivers/platform/x86/mxm-wmi.mod.o
>   CC      drivers/platform/x86/panasonic-laptop.mod.o
>   CC      drivers/platform/x86/sony-laptop.mod.o
>   CC      drivers/platform/x86/thinkpad_acpi.mod.o
>   CC      drivers/platform/x86/topstar-laptop.mod.o
>   CC      drivers/platform/x86/toshiba_acpi.mod.o
>   CC      drivers/platform/x86/wmi.mod.o
>   CC      drivers/power/bq27x00_battery.mod.o
>   CC      drivers/power/max17040_battery.mod.o
>   CC      drivers/pps/pps_core.mod.o
>   CC      drivers/ptp/ptp.mod.o
>   CC      drivers/ptp/ptp_pch.mod.o
>   CC      drivers/regulator/fixed.mod.o
>   CC      drivers/regulator/lp3971.mod.o
>   CC      drivers/regulator/max1586.mod.o
>   CC      drivers/regulator/tps65023-regulator.mod.o
>   CC      drivers/regulator/tps6507x-regulator.mod.o
>   CC      drivers/regulator/userspace-consumer.mod.o
>   CC      drivers/rtc/rtc-bq4802.mod.o
>   CC      drivers/rtc/rtc-ds1286.mod.o
>   CC      drivers/rtc/rtc-ds1307.mod.o
>   CC      drivers/rtc/rtc-ds1374.mod.o
>   CC      drivers/rtc/rtc-ds1511.mod.o
>   CC      drivers/rtc/rtc-ds1553.mod.o
>   CC      drivers/rtc/rtc-ds1672.mod.o
>   CC      drivers/rtc/rtc-ds1742.mod.o
>   CC      drivers/rtc/rtc-fm3130.mod.o
>   CC      drivers/rtc/rtc-isl1208.mod.o
>   CC      drivers/rtc/rtc-m41t80.mod.o
>   CC      drivers/rtc/rtc-m48t35.mod.o
>   CC      drivers/rtc/rtc-m48t59.mod.o
>   CC      drivers/rtc/rtc-max6900.mod.o
>   CC      drivers/rtc/rtc-pcf8563.mod.o
>   CC      drivers/rtc/rtc-pcf8583.mod.o
>   CC      drivers/rtc/rtc-rs5c372.mod.o
>   CC      drivers/rtc/rtc-rx8025.mod.o
>   CC      drivers/rtc/rtc-rx8581.mod.o
>   CC      drivers/rtc/rtc-stk17ta8.mod.o
>   CC      drivers/rtc/rtc-v3020.mod.o
>   CC      drivers/rtc/rtc-x1205.mod.o
>   CC      drivers/scsi/3w-sas.mod.o
>   CC      drivers/scsi/3w-9xxx.mod.o
>   CC      drivers/scsi/3w-xxxx.mod.o
>   CC      drivers/scsi/aacraid/aacraid.mod.o
>   CC      drivers/scsi/aic7xxx/aic79xx.mod.o
>   CC      drivers/scsi/aic7xxx/aic7xxx.mod.o
>   CC      drivers/scsi/aic94xx/aic94xx.mod.o
>   CC      drivers/scsi/arcmsr/arcmsr.mod.o
>   CC      drivers/scsi/be2iscsi/be2iscsi.mod.o
>   CC      drivers/scsi/bfa/bfa.mod.o
>   CC      drivers/scsi/bnx2fc/bnx2fc.mod.o
>   CC      drivers/scsi/bnx2i/bnx2i.mod.o
>   CC      drivers/scsi/ch.mod.o
>   CC      drivers/scsi/cxgbi/cxgb3i/cxgb3i.mod.o
>   CC      drivers/scsi/cxgbi/cxgb4i/cxgb4i.mod.o
>   CC      drivers/scsi/cxgbi/libcxgbi.mod.o
>   CC      drivers/scsi/device_handler/scsi_dh_alua.mod.o
>   CC      drivers/scsi/device_handler/scsi_dh_emc.mod.o
>   CC      drivers/scsi/device_handler/scsi_dh_hp_sw.mod.o
>   CC      drivers/scsi/device_handler/scsi_dh_rdac.mod.o
>   CC      drivers/scsi/fcoe/fcoe.mod.o
>   CC      drivers/scsi/fcoe/libfcoe.mod.o
>   CC      drivers/scsi/fnic/fnic.mod.o
>   CC      drivers/scsi/hpsa.mod.o
>   CC      drivers/scsi/hptiop.mod.o
>   CC      drivers/scsi/hv_storvsc.mod.o
>   CC      drivers/scsi/imm.mod.o
>   CC      drivers/scsi/ips.mod.o
>   CC      drivers/scsi/initio.mod.o
>   CC      drivers/scsi/isci/isci.mod.o
>   CC      drivers/scsi/iscsi_boot_sysfs.mod.o
>   CC      drivers/scsi/iscsi_tcp.mod.o
>   CC      drivers/scsi/libfc/libfc.mod.o
>   CC      drivers/scsi/libiscsi.mod.o
>   CC      drivers/scsi/libiscsi_tcp.mod.o
>   CC      drivers/scsi/libsas/libsas.mod.o
>   CC      drivers/scsi/libsrp.mod.o
>   CC      drivers/scsi/lpfc/lpfc.mod.o
>   CC      drivers/scsi/megaraid/megaraid_mbox.mod.o
>   CC      drivers/scsi/megaraid/megaraid_mm.mod.o
>   CC      drivers/scsi/megaraid/megaraid_sas.mod.o
>   CC      drivers/scsi/mpt2sas/mpt2sas.mod.o
>   CC      drivers/scsi/mpt3sas/mpt3sas.mod.o
>   CC      drivers/scsi/mvsas/mvsas.mod.o
>   CC      drivers/scsi/osd/libosd.mod.o
>   CC      drivers/scsi/osd/osd.mod.o
>   CC      drivers/scsi/osst.mod.o
>   CC      drivers/scsi/pm8001/pm8001.mod.o
>   CC      drivers/scsi/pmcraid.mod.o
>   CC      drivers/scsi/ppa.mod.o
>   CC      drivers/scsi/qla2xxx/qla2xxx.mod.o
>   CC      drivers/scsi/qla4xxx/qla4xxx.mod.o
>   CC      drivers/scsi/raid_class.mod.o
>   CC      drivers/scsi/scsi_debug.mod.o
>   CC      drivers/scsi/scsi_tgt.mod.o
>   CC      drivers/scsi/scsi_transport_fc.mod.o
>   CC      drivers/scsi/scsi_transport_iscsi.mod.o
>   CC      drivers/scsi/scsi_transport_sas.mod.o
>   CC      drivers/scsi/scsi_transport_spi.mod.o
>   CC      drivers/scsi/scsi_transport_srp.mod.o
>   CC      drivers/scsi/sd_mod.mod.o
>   CC      drivers/scsi/ses.mod.o
>   CC      drivers/scsi/sg.mod.o
>   CC      drivers/scsi/sr_mod.mod.o
>   CC      drivers/scsi/st.mod.o
>   CC      drivers/scsi/stex.mod.o
>   CC      drivers/scsi/sym53c8xx_2/sym53c8xx.mod.o
>   CC      drivers/scsi/virtio_scsi.mod.o
>   CC      drivers/scsi/vmw_pvscsi.mod.o
>   CC      drivers/ssb/ssb.mod.o
>   CC      drivers/target/loopback/tcm_loop.mod.o
>   CC      drivers/target/target_core_file.mod.o
>   CC      drivers/target/target_core_iblock.mod.o
>   CC      drivers/target/target_core_mod.mod.o
>   CC      drivers/target/target_core_pscsi.mod.o
>   CC      drivers/target/tcm_fc/tcm_fc.mod.o
>   CC      drivers/tty/cyclades.mod.o
>   CC      drivers/tty/ipwireless/ipwireless.mod.o
>   CC      drivers/tty/n_hdlc.mod.o
>   CC      drivers/tty/nozomi.mod.o
>   CC      drivers/tty/serial/8250/serial_cs.mod.o
>   CC      drivers/tty/serial/jsm/jsm.mod.o
>   CC      drivers/tty/synclink.mod.o
>   CC      drivers/tty/synclink_gt.mod.o
>   CC      drivers/tty/synclinkmp.mod.o
>   CC      drivers/uio/uio.mod.o
>   CC      drivers/uio/uio_aec.mod.o
>   CC      drivers/uio/uio_cif.mod.o
>   CC      drivers/uio/uio_pci_generic.mod.o
>   CC      drivers/uio/uio_pdrv.mod.o
>   CC      drivers/uio/uio_sercos3.mod.o
>   CC      drivers/uio/uio_pdrv_genirq.mod.o
>   CC      drivers/usb/atm/cxacru.mod.o
>   CC      drivers/usb/atm/speedtch.mod.o
>   CC      drivers/usb/atm/ueagle-atm.mod.o
>   CC      drivers/usb/atm/usbatm.mod.o
>   CC      drivers/usb/atm/xusbatm.mod.o
>   CC      drivers/usb/class/cdc-acm.mod.o
>   CC      drivers/usb/class/cdc-wdm.mod.o
>   CC      drivers/usb/class/usblp.mod.o
>   CC      drivers/usb/class/usbtmc.mod.o
>   CC      drivers/usb/host/hwa-hc.mod.o
>   CC      drivers/usb/host/isp1362-hcd.mod.o
>   CC      drivers/usb/host/sl811-hcd.mod.o
>   CC      drivers/usb/host/u132-hcd.mod.o
>   CC      drivers/usb/host/whci/whci-hcd.mod.o
>   CC      drivers/usb/host/xhci-hcd.mod.o
>   CC      drivers/usb/image/mdc800.mod.o
>   CC      drivers/usb/image/microtek.mod.o
>   CC      drivers/usb/misc/adutux.mod.o
>   CC      drivers/usb/misc/appledisplay.mod.o
>   CC      drivers/usb/misc/emi26.mod.o
>   CC      drivers/usb/misc/emi62.mod.o
>   CC      drivers/usb/misc/ezusb.mod.o
>   CC      drivers/usb/misc/ftdi-elan.mod.o
>   CC      drivers/usb/misc/idmouse.mod.o
>   CC      drivers/usb/misc/iowarrior.mod.o
>   CC      drivers/usb/misc/isight_firmware.mod.o
>   CC      drivers/usb/misc/ldusb.mod.o
>   CC      drivers/usb/misc/legousbtower.mod.o
>   CC      drivers/usb/misc/sisusbvga/sisusbvga.mod.o
>   CC      drivers/usb/misc/usblcd.mod.o
>   CC      drivers/usb/misc/usbled.mod.o
>   CC      drivers/usb/misc/usbsevseg.mod.o
>   CC      drivers/usb/misc/uss720.mod.o
>   CC      drivers/usb/otg/nop-usb-xceiv.mod.o
>   CC      drivers/usb/serial/aircable.mod.o
>   CC      drivers/usb/serial/ark3116.mod.o
>   CC      drivers/usb/serial/belkin_sa.mod.o
>   CC      drivers/usb/serial/ch341.mod.o
>   CC      drivers/usb/serial/cp210x.mod.o
>   CC      drivers/usb/serial/cyberjack.mod.o
>   CC      drivers/usb/serial/cypress_m8.mod.o
>   CC      drivers/usb/serial/digi_acceleport.mod.o
>   CC      drivers/usb/serial/empeg.mod.o
>   CC      drivers/usb/serial/ftdi_sio.mod.o
>   CC      drivers/usb/serial/garmin_gps.mod.o
>   CC      drivers/usb/serial/funsoft.mod.o
>   CC      drivers/usb/serial/hp4x.mod.o
>   CC      drivers/usb/serial/io_edgeport.mod.o
>   CC      drivers/usb/serial/io_ti.mod.o
>   CC      drivers/usb/serial/ipaq.mod.o
>   CC      drivers/usb/serial/ipw.mod.o
>   CC      drivers/usb/serial/ir-usb.mod.o
>   CC      drivers/usb/serial/iuu_phoenix.mod.o
>   CC      drivers/usb/serial/keyspan.mod.o
>   CC      drivers/usb/serial/keyspan_pda.mod.o
>   CC      drivers/usb/serial/kl5kusb105.mod.o
>   CC      drivers/usb/serial/kobil_sct.mod.o
>   CC      drivers/usb/serial/mct_u232.mod.o
>   CC      drivers/usb/serial/mos7720.mod.o
>   CC      drivers/usb/serial/mos7840.mod.o
>   CC      drivers/usb/serial/moto_modem.mod.o
>   CC      drivers/usb/serial/navman.mod.o
>   CC      drivers/usb/serial/omninet.mod.o
>   CC      drivers/usb/serial/opticon.mod.o
>   CC      drivers/usb/serial/option.mod.o
>   CC      drivers/usb/serial/oti6858.mod.o
>   CC      drivers/usb/serial/pl2303.mod.o
>   CC      drivers/usb/serial/qcserial.mod.o
>   CC      drivers/usb/serial/safe_serial.mod.o
>   CC      drivers/usb/serial/siemens_mpi.mod.o
>   CC      drivers/usb/serial/sierra.mod.o
>   CC      drivers/usb/serial/spcp8x5.mod.o
>   CC      drivers/usb/serial/symbolserial.mod.o
>   CC      drivers/usb/serial/ti_usb_3410_5052.mod.o
>   CC      drivers/usb/serial/usb_debug.mod.o
>   CC      drivers/usb/serial/usb_wwan.mod.o
>   CC      drivers/usb/serial/usbserial.mod.o
>   CC      drivers/usb/serial/visor.mod.o
>   CC      drivers/usb/serial/whiteheat.mod.o
>   CC      drivers/usb/storage/ums-alauda.mod.o
>   CC      drivers/usb/storage/ums-cypress.mod.o
>   CC      drivers/usb/storage/ums-datafab.mod.o
>   CC      drivers/usb/storage/ums-freecom.mod.o
>   CC      drivers/usb/storage/ums-isd200.mod.o
>   CC      drivers/usb/storage/ums-jumpshot.mod.o
>   CC      drivers/usb/storage/ums-karma.mod.o
>   CC      drivers/usb/storage/ums-onetouch.mod.o
>   CC      drivers/usb/storage/ums-sddr09.mod.o
>   CC      drivers/usb/storage/ums-sddr55.mod.o
>   CC      drivers/usb/storage/ums-usbat.mod.o
>   CC      drivers/usb/storage/usb-storage.mod.o
>   CC      drivers/usb/wusbcore/wusb-cbaf.mod.o
>   CC      drivers/usb/wusbcore/wusb-wa.mod.o
>   CC      drivers/usb/wusbcore/wusbcore.mod.o
>   CC      drivers/uwb/hwa-rc.mod.o
>   CC      drivers/uwb/i1480/dfu/i1480-dfu-usb.mod.o
>   CC      drivers/uwb/i1480/i1480-est.mod.o
>   CC      drivers/uwb/umc.mod.o
>   CC      drivers/uwb/uwb.mod.o
>   CC      drivers/uwb/whc-rc.mod.o
>   CC      drivers/uwb/whci.mod.o
>   CC      drivers/vhost/vhost_net.mod.o
>   CC      drivers/video/aty/aty128fb.mod.o
>   CC      drivers/video/aty/atyfb.mod.o
>   CC      drivers/video/aty/radeonfb.mod.o
>   CC      drivers/video/backlight/lcd.mod.o
>   CC      drivers/video/backlight/platform_lcd.mod.o
>   CC      drivers/video/cirrusfb.mod.o
>   CC      drivers/video/fb_ddc.mod.o
>   CC      drivers/video/fb_sys_fops.mod.o
>   CC      drivers/video/macmodes.mod.o
>   CC      drivers/video/nvidia/nvidiafb.mod.o
>   CC      drivers/video/output.mod.o
>   CC      drivers/video/riva/rivafb.mod.o
>   CC      drivers/video/savage/savagefb.mod.o
>   CC      drivers/video/sm501fb.mod.o
>   CC      drivers/video/syscopyarea.mod.o
>   CC      drivers/video/sysfillrect.mod.o
>   CC      drivers/video/sysimgblt.mod.o
>   CC      drivers/video/vfb.mod.o
>   CC      drivers/video/vga16fb.mod.o
>   CC      drivers/video/vgastate.mod.o
>   CC      drivers/video/via/viafb.mod.o
>   CC      drivers/virtio/virtio.mod.o
>   CC      drivers/virtio/virtio_balloon.mod.o
>   CC      drivers/virtio/virtio_pci.mod.o
>   CC      drivers/virtio/virtio_ring.mod.o
>   CC      drivers/watchdog/alim1535_wdt.mod.o
>   CC      drivers/watchdog/alim7101_wdt.mod.o
>   CC      drivers/watchdog/hpwdt.mod.o
>   CC      drivers/watchdog/i6300esb.mod.o
>   CC      drivers/watchdog/iTCO_vendor_support.mod.o
>   CC      drivers/watchdog/iTCO_wdt.mod.o
>   CC      drivers/watchdog/ib700wdt.mod.o
>   CC      drivers/watchdog/ibmasr.mod.o
>   CC      drivers/watchdog/ie6xx_wdt.mod.o
>   CC      drivers/watchdog/it8712f_wdt.mod.o
>   CC      drivers/watchdog/it87_wdt.mod.o
>   CC      drivers/watchdog/machzwd.mod.o
>   CC      drivers/watchdog/pcwd_pci.mod.o
>   CC      drivers/watchdog/pcwd_usb.mod.o
>   CC      drivers/watchdog/sbc_fitpc2_wdt.mod.o
>   CC      drivers/watchdog/sch311x_wdt.mod.o
>   CC      drivers/watchdog/softdog.mod.o
>   CC      drivers/watchdog/w83627hf_wdt.mod.o
>   CC      drivers/watchdog/w83697hf_wdt.mod.o
>   CC      drivers/watchdog/w83697ug_wdt.mod.o
>   CC      drivers/watchdog/w83877f_wdt.mod.o
>   CC      drivers/watchdog/w83977f_wdt.mod.o
>   CC      drivers/watchdog/wdt_pci.mod.o
>   CC      fs/autofs4/autofs4.mod.o
>   CC      fs/btrfs/btrfs.mod.o
>   CC      fs/cachefiles/cachefiles.mod.o
>   CC      fs/cifs/cifs.mod.o
>   CC      fs/configfs/configfs.mod.o
>   CC      fs/cramfs/cramfs.mod.o
>   CC      fs/dlm/dlm.mod.o
>   CC      fs/ecryptfs/ecryptfs.mod.o
>   CC      fs/exofs/libore.mod.o
>   CC      fs/exportfs/exportfs.mod.o
>   CC      fs/ext2/ext2.mod.o
>   CC      fs/ext3/ext3.mod.o
>   CC      fs/ext4/ext4.mod.o
>   CC      fs/fat/msdos.mod.o
>   CC      fs/fat/fat.mod.o
>   CC      fs/fat/vfat.mod.o
>   CC      fs/fscache/fscache.mod.o
>   CC      fs/fuse/cuse.mod.o
>   CC      fs/fuse/fuse.mod.o
>   CC      fs/gfs2/gfs2.mod.o
>   CC      fs/jbd/jbd.mod.o
>   CC      fs/jbd2/jbd2.mod.o
>   CC      fs/jffs2/jffs2.mod.o
>   CC      fs/lockd/lockd.mod.o
>   CC      fs/mbcache.mod.o
>   CC      fs/nfs/blocklayout/blocklayoutdriver.mod.o
>   CC      fs/nfs/nfs.mod.o
>   CC      fs/nfs/nfs_layout_nfsv41_files.mod.o
>   CC      fs/nfs/nfsv2.mod.o
>   CC      fs/nfs/nfsv3.mod.o
>   CC      fs/nfs/nfsv4.mod.o
>   CC      fs/nfs/objlayout/objlayoutdriver.mod.o
>   CC      fs/nfs_common/nfs_acl.mod.o
>   CC      fs/nfsd/nfsd.mod.o
>   CC      fs/nls/nls_cp1250.mod.o
>   CC      fs/nls/nls_cp1251.mod.o
>   CC      fs/nls/nls_cp1255.mod.o
>   CC      fs/nls/nls_cp737.mod.o
>   CC      fs/nls/nls_cp775.mod.o
>   CC      fs/nls/nls_cp850.mod.o
>   CC      fs/nls/nls_cp852.mod.o
>   CC      fs/nls/nls_cp855.mod.o
>   CC      fs/nls/nls_cp857.mod.o
>   CC      fs/nls/nls_cp860.mod.o
>   CC      fs/nls/nls_cp861.mod.o
>   CC      fs/nls/nls_cp862.mod.o
>   CC      fs/nls/nls_cp863.mod.o
>   CC      fs/nls/nls_cp864.mod.o
>   CC      fs/nls/nls_cp865.mod.o
>   CC      fs/nls/nls_cp866.mod.o
>   CC      fs/nls/nls_cp869.mod.o
>   CC      fs/nls/nls_cp874.mod.o
>   CC      fs/nls/nls_cp932.mod.o
>   CC      fs/nls/nls_cp936.mod.o
>   CC      fs/nls/nls_cp949.mod.o
>   CC      fs/nls/nls_cp950.mod.o
>   CC      fs/nls/nls_euc-jp.mod.o
>   CC      fs/nls/nls_iso8859-1.mod.o
>   CC      fs/nls/nls_iso8859-13.mod.o
>   CC      fs/nls/nls_iso8859-14.mod.o
>   CC      fs/nls/nls_iso8859-15.mod.o
>   CC      fs/nls/nls_iso8859-2.mod.o
>   CC      fs/nls/nls_iso8859-3.mod.o
>   CC      fs/nls/nls_iso8859-4.mod.o
>   CC      fs/nls/nls_iso8859-5.mod.o
>   CC      fs/nls/nls_iso8859-6.mod.o
>   CC      fs/nls/nls_iso8859-7.mod.o
>   CC      fs/nls/nls_iso8859-9.mod.o
>   CC      fs/nls/nls_koi8-r.mod.o
>   CC      fs/nls/nls_koi8-ru.mod.o
>   CC      fs/nls/nls_koi8-u.mod.o
>   CC      fs/nls/nls_utf8.mod.o
>   CC      fs/squashfs/squashfs.mod.o
>   CC      fs/ubifs/ubifs.mod.o
>   CC      fs/udf/udf.mod.o
>   CC      fs/xfs/xfs.mod.o
>   CC      kernel/trace/ring_buffer_benchmark.mod.o
>   CC      lib/cordic.mod.o
>   CC      lib/crc-ccitt.mod.o
>   CC      lib/crc-itu-t.mod.o
>   CC      lib/crc-t10dif.mod.o
>   CC      lib/crc7.mod.o
>   CC      lib/crc8.mod.o
>   CC      lib/libcrc32c.mod.o
>   CC      lib/raid6/raid6_pq.mod.o
>   CC      lib/reed_solomon/reed_solomon.mod.o
>   CC      lib/ts_bm.mod.o
>   CC      lib/ts_fsm.mod.o
>   CC      lib/ts_kmp.mod.o
>   CC      lib/zlib_deflate/zlib_deflate.mod.o
>   CC      net/802/garp.mod.o
>   CC      net/802/p8022.mod.o
>   CC      net/802/psnap.mod.o
>   CC      net/802/stp.mod.o
>   CC      net/8021q/8021q.mod.o
>   CC      net/9p/9pnet.mod.o
>   CC      net/9p/9pnet_rdma.mod.o
>   CC      net/9p/9pnet_virtio.mod.o
>   CC      net/atm/atm.mod.o
>   CC      net/atm/br2684.mod.o
>   CC      net/atm/clip.mod.o
>   CC      net/atm/lec.mod.o
>   CC      net/atm/pppoatm.mod.o
>   CC      net/bluetooth/bluetooth.mod.o
>   CC      net/bluetooth/bnep/bnep.mod.o
>   CC      net/bluetooth/cmtp/cmtp.mod.o
>   CC      net/bluetooth/hidp/hidp.mod.o
>   CC      net/bluetooth/rfcomm/rfcomm.mod.o
>   CC      net/bridge/bridge.mod.o
>   CC      net/bridge/netfilter/ebt_802_3.mod.o
>   CC      net/bridge/netfilter/ebt_among.mod.o
>   CC      net/bridge/netfilter/ebt_arp.mod.o
>   CC      net/bridge/netfilter/ebt_arpreply.mod.o
>   CC      net/bridge/netfilter/ebt_dnat.mod.o
>   CC      net/bridge/netfilter/ebt_ip.mod.o
>   CC      net/bridge/netfilter/ebt_ip6.mod.o
>   CC      net/bridge/netfilter/ebt_limit.mod.o
>   CC      net/bridge/netfilter/ebt_log.mod.o
>   CC      net/bridge/netfilter/ebt_mark.mod.o
>   CC      net/bridge/netfilter/ebt_mark_m.mod.o
>   CC      net/bridge/netfilter/ebt_nflog.mod.o
>   CC      net/bridge/netfilter/ebt_pkttype.mod.o
>   CC      net/bridge/netfilter/ebt_redirect.mod.o
>   CC      net/bridge/netfilter/ebt_snat.mod.o
>   CC      net/bridge/netfilter/ebt_stp.mod.o
>   CC      net/bridge/netfilter/ebt_ulog.mod.o
>   CC      net/bridge/netfilter/ebt_vlan.mod.o
>   CC      net/bridge/netfilter/ebtable_broute.mod.o
>   CC      net/bridge/netfilter/ebtable_filter.mod.o
>   CC      net/bridge/netfilter/ebtable_nat.mod.o
>   CC      net/bridge/netfilter/ebtables.mod.o
>   CC      net/can/can-bcm.mod.o
>   CC      net/can/can-raw.mod.o
>   CC      net/can/can.mod.o
>   CC      net/core/pktgen.mod.o
>   CC      net/dccp/dccp.mod.o
>   CC      net/dccp/dccp_diag.mod.o
>   CC      net/dccp/dccp_ipv4.mod.o
>   CC      net/dccp/dccp_ipv6.mod.o
>   CC      net/dns_resolver/dns_resolver.mod.o
>   CC      net/ieee802154/af_802154.mod.o
>   CC      net/ieee802154/ieee802154.mod.o
>   CC      net/ipv4/ah4.mod.o
>   CC      net/ipv4/esp4.mod.o
>   CC      net/ipv4/inet_diag.mod.o
>   CC      net/ipv4/ip_gre.mod.o
>   CC      net/ipv4/ipcomp.mod.o
>   CC      net/ipv4/ipip.mod.o
>   CC      net/ipv4/netfilter/arp_tables.mod.o
>   CC      net/ipv4/netfilter/arpt_mangle.mod.o
>   CC      net/ipv4/netfilter/arptable_filter.mod.o
>   CC      net/ipv4/netfilter/ip_tables.mod.o
>   CC      net/ipv4/netfilter/ipt_CLUSTERIP.mod.o
>   CC      net/ipv4/netfilter/ipt_ECN.mod.o
>   CC      net/ipv4/netfilter/ipt_REJECT.mod.o
>   CC      net/ipv4/netfilter/ipt_ULOG.mod.o
>   CC      net/ipv4/netfilter/ipt_ah.mod.o
>   CC      net/ipv4/netfilter/iptable_filter.mod.o
>   CC      net/ipv4/netfilter/iptable_mangle.mod.o
>   CC      net/ipv4/netfilter/iptable_raw.mod.o
>   CC      net/ipv4/netfilter/iptable_security.mod.o
>   CC      net/ipv4/netfilter/nf_conntrack_ipv4.mod.o
>   CC      net/ipv4/netfilter/nf_defrag_ipv4.mod.o
>   CC      net/ipv4/tcp_bic.mod.o
>   CC      net/ipv4/tcp_diag.mod.o
>   CC      net/ipv4/tcp_highspeed.mod.o
>   CC      net/ipv4/tcp_htcp.mod.o
>   CC      net/ipv4/tcp_hybla.mod.o
>   CC      net/ipv4/tcp_illinois.mod.o
>   CC      net/ipv4/tcp_lp.mod.o
>   CC      net/ipv4/tcp_scalable.mod.o
>   CC      net/ipv4/tcp_vegas.mod.o
>   CC      net/ipv4/tcp_veno.mod.o
>   CC      net/ipv4/tcp_westwood.mod.o
>   CC      net/ipv4/tcp_yeah.mod.o
>   CC      net/ipv4/tunnel4.mod.o
>   CC      net/ipv4/xfrm4_mode_beet.mod.o
>   CC      net/ipv4/xfrm4_mode_transport.mod.o
>   CC      net/ipv4/xfrm4_mode_tunnel.mod.o
>   CC      net/ipv4/xfrm4_tunnel.mod.o
>   CC      net/ipv6/ah6.mod.o
>   CC      net/ipv6/esp6.mod.o
>   CC      net/ipv6/ip6_tunnel.mod.o
>   CC      net/ipv6/ipcomp6.mod.o
>   CC      net/ipv6/ipv6.mod.o
>   CC      net/ipv6/mip6.mod.o
>   CC      net/ipv6/netfilter/ip6_tables.mod.o
>   CC      net/ipv6/netfilter/ip6t_REJECT.mod.o
>   CC      net/ipv6/netfilter/ip6t_ah.mod.o
>   CC      net/ipv6/netfilter/ip6t_eui64.mod.o
>   CC      net/ipv6/netfilter/ip6t_frag.mod.o
>   CC      net/ipv6/netfilter/ip6t_hbh.mod.o
>   CC      net/ipv6/netfilter/ip6t_ipv6header.mod.o
>   CC      net/ipv6/netfilter/ip6t_mh.mod.o
>   CC      net/ipv6/netfilter/ip6t_rt.mod.o
>   CC      net/ipv6/netfilter/ip6table_filter.mod.o
>   CC      net/ipv6/netfilter/ip6table_mangle.mod.o
>   CC      net/ipv6/netfilter/ip6table_raw.mod.o
>   CC      net/ipv6/netfilter/ip6table_security.mod.o
>   CC      net/ipv6/netfilter/nf_conntrack_ipv6.mod.o
>   CC      net/ipv6/netfilter/nf_defrag_ipv6.mod.o
>   CC      net/ipv6/sit.mod.o
>   CC      net/ipv6/tunnel6.mod.o
>   CC      net/ipv6/xfrm6_mode_beet.mod.o
>   CC      net/ipv6/xfrm6_mode_ro.mod.o
>   CC      net/ipv6/xfrm6_mode_transport.mod.o
>   CC      net/ipv6/xfrm6_mode_tunnel.mod.o
>   CC      net/ipv6/xfrm6_tunnel.mod.o
>   CC      net/key/af_key.mod.o
>   CC      net/llc/llc.mod.o
>   CC      net/mac80211/mac80211.mod.o
>   CC      net/netfilter/ipset/ip_set.mod.o
>   CC      net/netfilter/ipset/ip_set_bitmap_ip.mod.o
>   CC      net/netfilter/ipset/ip_set_bitmap_ipmac.mod.o
>   CC      net/netfilter/ipset/ip_set_bitmap_port.mod.o
>   CC      net/netfilter/ipset/ip_set_hash_ip.mod.o
>   CC      net/netfilter/ipset/ip_set_hash_ipport.mod.o
>   CC      net/netfilter/ipset/ip_set_hash_ipportip.mod.o
>   CC      net/netfilter/ipset/ip_set_hash_ipportnet.mod.o
>   CC      net/netfilter/ipset/ip_set_hash_net.mod.o
>   CC      net/netfilter/ipset/ip_set_hash_netport.mod.o
>   CC      net/netfilter/ipset/ip_set_list_set.mod.o
>   CC      net/netfilter/ipvs/ip_vs.mod.o
>   CC      net/netfilter/ipvs/ip_vs_dh.mod.o
>   CC      net/netfilter/ipvs/ip_vs_lblc.mod.o
>   CC      net/netfilter/ipvs/ip_vs_lblcr.mod.o
>   CC      net/netfilter/ipvs/ip_vs_lc.mod.o
>   CC      net/netfilter/ipvs/ip_vs_nq.mod.o
>   CC      net/netfilter/ipvs/ip_vs_pe_sip.mod.o
>   CC      net/netfilter/ipvs/ip_vs_rr.mod.o
>   CC      net/netfilter/ipvs/ip_vs_sed.mod.o
>   CC      net/netfilter/ipvs/ip_vs_sh.mod.o
>   CC      net/netfilter/ipvs/ip_vs_wlc.mod.o
>   CC      net/netfilter/ipvs/ip_vs_wrr.mod.o
>   CC      net/netfilter/nf_conntrack.mod.o
>   CC      net/netfilter/nf_conntrack_amanda.mod.o
>   CC      net/netfilter/nf_conntrack_broadcast.mod.o
>   CC      net/netfilter/nf_conntrack_ftp.mod.o
>   CC      net/netfilter/nf_conntrack_h323.mod.o
>   CC      net/netfilter/nf_conntrack_irc.mod.o
>   CC      net/netfilter/nf_conntrack_netbios_ns.mod.o
>   CC      net/netfilter/nf_conntrack_netlink.mod.o
>   CC      net/netfilter/nf_conntrack_pptp.mod.o
>   CC      net/netfilter/nf_conntrack_proto_dccp.mod.o
>   CC      net/netfilter/nf_conntrack_proto_gre.mod.o
>   CC      net/netfilter/nf_conntrack_proto_sctp.mod.o
>   CC      net/netfilter/nf_conntrack_proto_udplite.mod.o
>   CC      net/netfilter/nf_conntrack_sane.mod.o
>   CC      net/netfilter/nf_conntrack_sip.mod.o
>   CC      net/netfilter/nf_conntrack_snmp.mod.o
>   CC      net/netfilter/nf_conntrack_tftp.mod.o
>   CC      net/netfilter/nf_tproxy_core.mod.o
>   CC      net/netfilter/nfnetlink.mod.o
>   CC      net/netfilter/nfnetlink_log.mod.o
>   CC      net/netfilter/nfnetlink_queue.mod.o
>   CC      net/netfilter/xt_AUDIT.mod.o
>   CC      net/netfilter/xt_CHECKSUM.mod.o
>   CC      net/netfilter/xt_CLASSIFY.mod.o
>   CC      net/netfilter/xt_CONNSECMARK.mod.o
>   CC      net/netfilter/xt_CT.mod.o
>   CC      net/netfilter/xt_DSCP.mod.o
>   CC      net/netfilter/xt_HL.mod.o
>   CC      net/netfilter/xt_LED.mod.o
>   CC      net/netfilter/xt_NFLOG.mod.o
>   CC      net/netfilter/xt_NFQUEUE.mod.o
>   CC      net/netfilter/xt_RATEEST.mod.o
>   CC      net/netfilter/xt_SECMARK.mod.o
>   CC      net/netfilter/xt_TCPMSS.mod.o
>   CC      net/netfilter/xt_TCPOPTSTRIP.mod.o
>   CC      net/netfilter/xt_TPROXY.mod.o
>   CC      net/netfilter/xt_TRACE.mod.o
>   CC      net/netfilter/xt_cluster.mod.o
>   CC      net/netfilter/xt_comment.mod.o
>   CC      net/netfilter/xt_connbytes.mod.o
>   CC      net/netfilter/xt_connlimit.mod.o
>   CC      net/netfilter/xt_connmark.mod.o
>   CC      net/netfilter/xt_conntrack.mod.o
>   CC      net/netfilter/xt_dccp.mod.o
>   CC      net/netfilter/xt_dscp.mod.o
>   CC      net/netfilter/xt_ecn.mod.o
>   CC      net/netfilter/xt_hashlimit.mod.o
>   CC      net/netfilter/xt_esp.mod.o
>   CC      net/netfilter/xt_helper.mod.o
>   CC      net/netfilter/xt_hl.mod.o
>   CC      net/netfilter/xt_iprange.mod.o
>   CC      net/netfilter/xt_length.mod.o
>   CC      net/netfilter/xt_limit.mod.o
>   CC      net/netfilter/xt_mac.mod.o
>   CC      net/netfilter/xt_mark.mod.o
>   CC      net/netfilter/xt_multiport.mod.o
>   CC      net/netfilter/xt_osf.mod.o
>   CC      net/netfilter/xt_owner.mod.o
>   CC      net/netfilter/xt_physdev.mod.o
>   CC      net/netfilter/xt_pkttype.mod.o
>   CC      net/netfilter/xt_policy.mod.o
>   CC      net/netfilter/xt_quota.mod.o
>   CC      net/netfilter/xt_rateest.mod.o
>   CC      net/netfilter/xt_realm.mod.o
>   CC      net/netfilter/xt_recent.mod.o
>   CC      net/netfilter/xt_sctp.mod.o
>   CC      net/netfilter/xt_set.mod.o
>   CC      net/netfilter/xt_socket.mod.o
>   CC      net/netfilter/xt_state.mod.o
>   CC      net/netfilter/xt_statistic.mod.o
>   CC      net/netfilter/xt_string.mod.o
>   CC      net/netfilter/xt_tcpmss.mod.o
>   CC      net/netfilter/xt_time.mod.o
>   CC      net/netfilter/xt_u32.mod.o
>   CC      net/openvswitch/openvswitch.mod.o
>   CC      net/phonet/phonet.mod.o
>   CC      net/phonet/pn_pep.mod.o
>   CC      net/rds/rds.mod.o
>   CC      net/rds/rds_rdma.mod.o
>   CC      net/rds/rds_tcp.mod.o
>   CC      net/rfkill/rfkill.mod.o
>   CC      net/sched/act_ipt.mod.o
>   CC      net/sched/act_gact.mod.o
>   CC      net/sched/act_mirred.mod.o
>   CC      net/sched/act_nat.mod.o
>   CC      net/sched/act_pedit.mod.o
>   CC      net/sched/act_police.mod.o
>   CC      net/sched/act_simple.mod.o
>   CC      net/sched/act_skbedit.mod.o
>   CC      net/sched/cls_basic.mod.o
>   CC      net/sched/cls_flow.mod.o
>   CC      net/sched/cls_fw.mod.o
>   CC      net/sched/cls_route.mod.o
>   CC      net/sched/cls_rsvp.mod.o
>   CC      net/sched/cls_rsvp6.mod.o
>   CC      net/sched/cls_tcindex.mod.o
>   CC      net/sched/cls_u32.mod.o
>   CC      net/sched/em_cmp.mod.o
>   CC      net/sched/em_meta.mod.o
>   CC      net/sched/em_nbyte.mod.o
>   CC      net/sched/em_text.mod.o
>   CC      net/sched/em_u32.mod.o
>   CC      net/sched/sch_atm.mod.o
>   CC      net/sched/sch_cbq.mod.o
>   CC      net/sched/sch_drr.mod.o
>   CC      net/sched/sch_dsmark.mod.o
>   CC      net/sched/sch_gred.mod.o
>   CC      net/sched/sch_hfsc.mod.o
>   CC      net/sched/sch_htb.mod.o
>   CC      net/sched/sch_ingress.mod.o
>   CC      net/sched/sch_mqprio.mod.o
>   CC      net/sched/sch_multiq.mod.o
>   CC      net/sched/sch_netem.mod.o
>   CC      net/sched/sch_prio.mod.o
>   CC      net/sched/sch_qfq.mod.o
>   CC      net/sched/sch_red.mod.o
>   CC      net/sched/sch_sfq.mod.o
>   CC      net/sched/sch_tbf.mod.o
>   CC      net/sched/sch_teql.mod.o
>   CC      net/sctp/sctp.mod.o
>   CC      net/sunrpc/auth_gss/auth_rpcgss.mod.o
>   CC      net/sunrpc/auth_gss/rpcsec_gss_krb5.mod.o
>   CC      net/sunrpc/sunrpc.mod.o
>   CC      net/sunrpc/xprtrdma/svcrdma.mod.o
>   CC      net/sunrpc/xprtrdma/xprtrdma.mod.o
>   CC      net/wimax/wimax.mod.o
>   CC      net/wireless/cfg80211.mod.o
>   CC      net/wireless/lib80211.mod.o
>   CC      net/wireless/lib80211_crypt_ccmp.mod.o
>   CC      net/wireless/lib80211_crypt_tkip.mod.o
>   CC      net/wireless/lib80211_crypt_wep.mod.o
>   CC      net/xfrm/xfrm_ipcomp.mod.o
>   CC      sound/ac97_bus.mod.o
>   CC      sound/core/oss/snd-mixer-oss.mod.o
>   CC      sound/core/oss/snd-pcm-oss.mod.o
>   CC      sound/core/seq/oss/snd-seq-oss.mod.o
>   CC      sound/core/seq/snd-seq-dummy.mod.o
>   CC      sound/core/seq/snd-seq-device.mod.o
>   CC      sound/core/seq/snd-seq-midi-emul.mod.o
>   CC      sound/core/seq/snd-seq-midi-event.mod.o
>   CC      sound/core/seq/snd-seq-midi.mod.o
>   CC      sound/core/seq/snd-seq-virmidi.mod.o
>   CC      sound/core/seq/snd-seq.mod.o
>   CC      sound/core/snd-hrtimer.mod.o
>   CC      sound/core/snd-hwdep.mod.o
>   CC      sound/core/snd-page-alloc.mod.o
>   CC      sound/core/snd-pcm.mod.o
>   CC      sound/core/snd-rawmidi.mod.o
>   CC      sound/core/snd-timer.mod.o
>   CC      sound/core/snd.mod.o
>   CC      sound/drivers/mpu401/snd-mpu401-uart.mod.o
>   CC      sound/drivers/mpu401/snd-mpu401.mod.o
>   CC      sound/drivers/opl3/snd-opl3-lib.mod.o
>   CC      sound/drivers/opl3/snd-opl3-synth.mod.o
>   CC      sound/drivers/pcsp/snd-pcsp.mod.o
>   CC      sound/drivers/snd-aloop.mod.o
>   CC      sound/drivers/snd-dummy.mod.o
>   CC      sound/drivers/snd-mtpav.mod.o
>   CC      sound/drivers/snd-virmidi.mod.o
>   CC      sound/drivers/vx/snd-vx-lib.mod.o
>   CC      sound/i2c/other/snd-ak4113.mod.o
>   CC      sound/i2c/other/snd-ak4114.mod.o
>   CC      sound/i2c/other/snd-ak4xxx-adda.mod.o
>   CC      sound/i2c/other/snd-pt2258.mod.o
>   CC      sound/i2c/snd-cs8427.mod.o
>   CC      sound/i2c/snd-i2c.mod.o
>   CC      sound/isa/sb/snd-sb-common.mod.o
>   CC      sound/isa/sb/snd-sb16-dsp.mod.o
>   CC      sound/pci/ac97/snd-ac97-codec.mod.o
>   CC      sound/pci/ali5451/snd-ali5451.mod.o
>   CC      sound/pci/au88x0/snd-au8810.mod.o
>   CC      sound/pci/au88x0/snd-au8820.mod.o
>   CC      sound/pci/au88x0/snd-au8830.mod.o
>   CC      sound/pci/ca0106/snd-ca0106.mod.o
>   CC      sound/pci/cs46xx/snd-cs46xx.mod.o
>   CC      sound/pci/cs5535audio/snd-cs5535audio.mod.o
>   CC      sound/pci/ctxfi/snd-ctxfi.mod.o
>   CC      sound/pci/echoaudio/snd-darla20.mod.o
>   CC      sound/pci/echoaudio/snd-darla24.mod.o
>   CC      sound/pci/echoaudio/snd-echo3g.mod.o
>   CC      sound/pci/echoaudio/snd-gina20.mod.o
>   CC      sound/pci/echoaudio/snd-gina24.mod.o
>   CC      sound/pci/echoaudio/snd-indigo.mod.o
>   CC      sound/pci/echoaudio/snd-indigodj.mod.o
>   CC      sound/pci/echoaudio/snd-indigodjx.mod.o
>   CC      sound/pci/echoaudio/snd-indigoio.mod.o
>   CC      sound/pci/echoaudio/snd-indigoiox.mod.o
>   CC      sound/pci/echoaudio/snd-layla20.mod.o
>   CC      sound/pci/echoaudio/snd-layla24.mod.o
>   CC      sound/pci/echoaudio/snd-mia.mod.o
>   CC      sound/pci/echoaudio/snd-mona.mod.o
>   CC      sound/pci/emu10k1/snd-emu10k1-synth.mod.o
>   CC      sound/pci/emu10k1/snd-emu10k1.mod.o
>   CC      sound/pci/emu10k1/snd-emu10k1x.mod.o
>   CC      sound/pci/hda/snd-hda-codec-analog.mod.o
>   CC      sound/pci/hda/snd-hda-codec-ca0110.mod.o
>   CC      sound/pci/hda/snd-hda-codec-ca0132.mod.o
>   CC      sound/pci/hda/snd-hda-codec-cirrus.mod.o
>   CC      sound/pci/hda/snd-hda-codec-cmedia.mod.o
>   CC      sound/pci/hda/snd-hda-codec-conexant.mod.o
>   CC      sound/pci/hda/snd-hda-codec-hdmi.mod.o
>   CC      sound/pci/hda/snd-hda-codec-idt.mod.o
>   CC      sound/pci/hda/snd-hda-codec-realtek.mod.o
>   CC      sound/pci/hda/snd-hda-codec-si3054.mod.o
>   CC      sound/pci/hda/snd-hda-codec-via.mod.o
>   CC      sound/pci/hda/snd-hda-codec.mod.o
>   CC      sound/pci/hda/snd-hda-intel.mod.o
>   CC      sound/pci/ice1712/snd-ice1712.mod.o
>   CC      sound/pci/ice1712/snd-ice1724.mod.o
>   CC      sound/pci/ice1712/snd-ice17xx-ak4xxx.mod.o
>   CC      sound/pci/korg1212/snd-korg1212.mod.o
>   CC      sound/pci/lx6464es/snd-lx6464es.mod.o
>   CC      sound/pci/mixart/snd-mixart.mod.o
>   CC      sound/pci/oxygen/snd-oxygen-lib.mod.o
>   CC      sound/pci/oxygen/snd-oxygen.mod.o
>   CC      sound/pci/oxygen/snd-virtuoso.mod.o
>   CC      sound/pci/pcxhr/snd-pcxhr.mod.o
>   CC      sound/pci/rme9652/snd-hdsp.mod.o
>   CC      sound/pci/rme9652/snd-hdspm.mod.o
>   CC      sound/pci/rme9652/snd-rme9652.mod.o
>   CC      sound/pci/snd-ad1889.mod.o
>   CC      sound/pci/snd-atiixp-modem.mod.o
>   CC      sound/pci/snd-atiixp.mod.o
>   CC      sound/pci/snd-bt87x.mod.o
>   CC      sound/pci/snd-cmipci.mod.o
>   CC      sound/pci/snd-cs5530.mod.o
>   CC      sound/pci/snd-ens1370.mod.o
>   CC      sound/pci/snd-ens1371.mod.o
>   CC      sound/pci/snd-es1968.mod.o
>   CC      sound/pci/snd-intel8x0.mod.o
>   CC      sound/pci/snd-intel8x0m.mod.o
>   CC      sound/pci/snd-maestro3.mod.o
>   CC      sound/pci/snd-rme32.mod.o
>   CC      sound/pci/snd-rme96.mod.o
>   CC      sound/pci/snd-via82xx-modem.mod.o
>   CC      sound/pci/snd-via82xx.mod.o
>   CC      sound/pci/trident/snd-trident.mod.o
>   CC      sound/pci/vx222/snd-vx222.mod.o
>   CC      sound/soundcore.mod.o
>   CC      sound/synth/emux/snd-emux-synth.mod.o
>   CC      sound/synth/snd-util-mem.mod.o
>   CC      sound/usb/6fire/snd-usb-6fire.mod.o
>   CC      sound/usb/caiaq/snd-usb-caiaq.mod.o
>   CC      sound/usb/misc/snd-ua101.mod.o
>   CC      sound/usb/snd-usb-audio.mod.o
>   CC      sound/usb/snd-usbmidi-lib.mod.o
>   CC      sound/usb/usx2y/snd-usb-us122l.mod.o
>   CC      sound/usb/usx2y/snd-usb-usx2y.mod.o
>   LD [M]  Documentation/connector/cn_test.ko
>   LD [M]
> Documentation/filesystems/configfs/configfs_example_explicit.ko LD
> [M]  Documentation/filesystems/configfs/configfs_example_macros.ko LD
> [M]  arch/x86/crypto/ablk_helper.ko LD [M]
> arch/x86/crypto/aes-x86_64.ko LD [M]  arch/x86/crypto/aesni-intel.ko
>   LD [M]  arch/x86/crypto/crc32c-intel.ko
>   LD [M]  arch/x86/crypto/ghash-clmulni-intel.ko
>   LD [M]  arch/x86/crypto/salsa20-x86_64.ko
>   LD [M]  arch/x86/crypto/twofish-x86_64.ko
>   LD [M]  arch/x86/kernel/cpu/mcheck/mce-inject.ko
>   LD [M]  arch/x86/kernel/microcode.ko
>   LD [M]  arch/x86/kvm/kvm-amd.ko
>   LD [M]  arch/x86/kvm/kvm-intel.ko
>   LD [M]  arch/x86/kvm/kvm.ko
>   LD [M]  arch/x86/oprofile/oprofile.ko
>   LD [M]  crypto/ansi_cprng.ko
>   LD [M]  crypto/anubis.ko
>   LD [M]  crypto/arc4.ko
>   LD [M]  crypto/async_tx/async_memcpy.ko
>   LD [M]  crypto/async_tx/async_pq.ko
>   LD [M]  crypto/async_tx/async_raid6_recov.ko
>   LD [M]  crypto/async_tx/async_tx.ko
>   LD [M]  crypto/async_tx/async_xor.ko
>   LD [M]  crypto/async_tx/raid6test.ko
>   LD [M]  crypto/authenc.ko
>   LD [M]  crypto/authencesn.ko
>   LD [M]  crypto/blowfish_common.ko
>   LD [M]  crypto/blowfish_generic.ko
>   LD [M]  crypto/camellia_generic.ko
>   LD [M]  crypto/cast_common.ko
>   LD [M]  crypto/cast5_generic.ko
>   LD [M]  crypto/cast6_generic.ko
>   LD [M]  crypto/cbc.ko
>   LD [M]  crypto/ccm.ko
>   LD [M]  crypto/cryptd.ko
>   LD [M]  crypto/crypto_null.ko
>   LD [M]  crypto/ctr.ko
>   LD [M]  crypto/cts.ko
>   LD [M]  crypto/des_generic.ko
>   LD [M]  crypto/deflate.ko
>   LD [M]  crypto/ecb.ko
>   LD [M]  crypto/fcrypt.ko
>   LD [M]  crypto/gf128mul.ko
>   LD [M]  crypto/ghash-generic.ko
>   LD [M]  crypto/gcm.ko
>   LD [M]  crypto/khazad.ko
>   LD [M]  crypto/lrw.ko
>   LD [M]  crypto/md4.ko
>   LD [M]  crypto/lzo.ko
>   LD [M]  crypto/michael_mic.ko
>   LD [M]  crypto/rmd128.ko
>   LD [M]  crypto/pcbc.ko
>   LD [M]  crypto/rmd256.ko
>   LD [M]  crypto/rmd160.ko
>   LD [M]  crypto/rmd320.ko
>   LD [M]  crypto/seed.ko
>   LD [M]  crypto/serpent_generic.ko
>   LD [M]  crypto/seqiv.ko
>   LD [M]  crypto/sha512_generic.ko
>   LD [M]  crypto/tea.ko
>   LD [M]  crypto/tcrypt.ko
>   LD [M]  crypto/tgr192.ko
>   LD [M]  crypto/twofish_common.ko
>   LD [M]  crypto/wp512.ko
>   LD [M]  crypto/vmac.ko
>   LD [M]  crypto/xcbc.ko
>   LD [M]  crypto/xor.ko
>   LD [M]  crypto/xts.ko
>   LD [M]  crypto/zlib.ko
>   LD [M]  drivers/acpi/acpi_i2c.ko
>   LD [M]  drivers/acpi/acpi_ipmi.ko
>   LD [M]  drivers/acpi/apei/einj.ko
>   LD [M]  drivers/acpi/apei/erst-dbg.ko
>   LD [M]  drivers/acpi/sbshc.ko
>   LD [M]  drivers/acpi/sbs.ko
>   LD [M]  drivers/acpi/video.ko
>   LD [M]  drivers/ata/ahci.ko
>   LD [M]  drivers/ata/ata_generic.ko
>   LD [M]  drivers/ata/ata_piix.ko
>   LD [M]  drivers/ata/pata_acpi.ko
>   LD [M]  drivers/ata/libahci.ko
>   LD [M]  drivers/ata/pata_atiixp.ko
>   LD [M]  drivers/ata/pata_artop.ko
>   LD [M]  drivers/ata/pata_amd.ko
>   LD [M]  drivers/ata/pata_ali.ko
>   LD [M]  drivers/ata/pata_atp867x.ko
>   LD [M]  drivers/ata/pata_cmd64x.ko
>   LD [M]  drivers/ata/pata_hpt37x.ko
>   LD [M]  drivers/ata/pata_hpt366.ko
>   LD [M]  drivers/ata/pata_hpt3x2n.ko
>   LD [M]  drivers/ata/pata_it8213.ko
>   LD [M]  drivers/ata/pata_hpt3x3.ko
>   LD [M]  drivers/ata/pata_it821x.ko
>   LD [M]  drivers/ata/pata_jmicron.ko
>   LD [M]  drivers/ata/pata_marvell.ko
>   LD [M]  drivers/ata/pata_netcell.ko
>   LD [M]  drivers/ata/pata_oldpiix.ko
>   LD [M]  drivers/ata/pata_ninja32.ko
>   LD [M]  drivers/ata/pata_pdc2027x.ko
>   LD [M]  drivers/ata/pata_pcmcia.ko
>   LD [M]  drivers/ata/pata_pdc202xx_old.ko
>   LD [M]  drivers/ata/pata_rdc.ko
>   LD [M]  drivers/ata/pata_sch.ko
>   LD [M]  drivers/ata/pata_serverworks.ko
>   LD [M]  drivers/ata/pata_sil680.ko
>   LD [M]  drivers/ata/pata_sis.ko
>   LD [M]  drivers/ata/pdc_adma.ko
>   LD [M]  drivers/ata/pata_via.ko
>   LD [M]  drivers/ata/sata_inic162x.ko
>   LD [M]  drivers/ata/sata_mv.ko
>   LD [M]  drivers/ata/sata_nv.ko
>   LD [M]  drivers/ata/sata_qstor.ko
>   LD [M]  drivers/ata/sata_promise.ko
>   LD [M]  drivers/ata/sata_sil.ko
>   LD [M]  drivers/ata/sata_sil24.ko
>   LD [M]  drivers/ata/sata_sis.ko
>   LD [M]  drivers/ata/sata_svw.ko
>   LD [M]  drivers/ata/sata_uli.ko
>   LD [M]  drivers/ata/sata_sx4.ko
>   LD [M]  drivers/ata/sata_via.ko
>   LD [M]  drivers/ata/sata_vsc.ko
>   LD [M]  drivers/atm/atmtcp.ko
>   LD [M]  drivers/auxdisplay/cfag12864bfb.ko
>   LD [M]  drivers/auxdisplay/cfag12864b.ko
>   LD [M]  drivers/auxdisplay/ks0108.ko
>   LD [M]  drivers/base/regmap/regmap-i2c.ko
>   LD [M]  drivers/bcma/bcma.ko
>   LD [M]  drivers/block/aoe/aoe.ko
>   LD [M]  drivers/block/cciss.ko
>   LD [M]  drivers/block/floppy.ko
>   LD [M]  drivers/block/cryptoloop.ko
>   LD [M]  drivers/block/mtip32xx/mtip32xx.ko
>   LD [M]  drivers/block/osdblk.ko
>   LD [M]  drivers/block/nvme.ko
>   LD [M]  drivers/block/pktcdvd.ko
>   LD [M]  drivers/block/sx8.ko
>   LD [M]  drivers/block/virtio_blk.ko
>   LD [M]  drivers/bluetooth/bcm203x.ko
>   LD [M]  drivers/bluetooth/bfusb.ko
>   LD [M]  drivers/bluetooth/bluecard_cs.ko
>   LD [M]  drivers/bluetooth/bpa10x.ko
>   LD [M]  drivers/bluetooth/bt3c_cs.ko
>   LD [M]  drivers/bluetooth/btmrvl.ko
>   LD [M]  drivers/bluetooth/btmrvl_sdio.ko
>   LD [M]  drivers/bluetooth/btuart_cs.ko
>   LD [M]  drivers/bluetooth/btsdio.ko
>   LD [M]  drivers/bluetooth/btusb.ko
>   LD [M]  drivers/bluetooth/dtl1_cs.ko
>   LD [M]  drivers/bluetooth/hci_uart.ko
>   LD [M]  drivers/bluetooth/hci_vhci.ko
>   LD [M]  drivers/cdrom/cdrom.ko
>   LD [M]  drivers/char/hangcheck-timer.ko
>   LD [M]  drivers/char/hw_random/amd-rng.ko
>   LD [M]  drivers/char/hw_random/timeriomem-rng.ko
>   LD [M]  drivers/char/hw_random/intel-rng.ko
>   LD [M]  drivers/char/hw_random/via-rng.ko
>   LD [M]  drivers/char/hw_random/virtio-rng.ko
>   LD [M]  drivers/char/i8k.ko
>   LD [M]  drivers/char/ipmi/ipmi_devintf.ko
>   LD [M]  drivers/char/ipmi/ipmi_msghandler.ko
>   LD [M]  drivers/char/ipmi/ipmi_poweroff.ko
>   LD [M]  drivers/char/ipmi/ipmi_si.ko
>   LD [M]  drivers/char/ipmi/ipmi_watchdog.ko
>   LD [M]  drivers/char/pcmcia/cm4000_cs.ko
>   LD [M]  drivers/char/lp.ko
>   LD [M]  drivers/char/pcmcia/cm4040_cs.ko
>   LD [M]  drivers/char/ppdev.ko
>   LD [M]  drivers/char/tlclk.ko
>   LD [M]  drivers/char/tpm/tpm_atmel.ko
>   LD [M]  drivers/char/tpm/tpm_infineon.ko
>   LD [M]  drivers/char/tpm/tpm_nsc.ko
>   LD [M]  drivers/char/virtio_console.ko
>   LD [M]  drivers/crypto/padlock-aes.ko
>   LD [M]  drivers/crypto/padlock-sha.ko
>   LD [M]  drivers/dca/dca.ko
>   LD [M]  drivers/dma/ioat/ioatdma.ko
>   LD [M]  drivers/edac/amd64_edac_mod.ko
>   LD [M]  drivers/edac/e752x_edac.ko
>   LD [M]  drivers/edac/edac_core.ko
>   LD [M]  drivers/edac/edac_mce_amd.ko
>   LD [M]  drivers/edac/i3000_edac.ko
>   LD [M]  drivers/edac/i3200_edac.ko
>   LD [M]  drivers/edac/i5000_edac.ko
>   LD [M]  drivers/edac/i5100_edac.ko
>   LD [M]  drivers/edac/i5400_edac.ko
>   LD [M]  drivers/edac/i7300_edac.ko
>   LD [M]  drivers/edac/i7core_edac.ko
>   LD [M]  drivers/edac/i82975x_edac.ko
>   LD [M]  drivers/edac/sb_edac.ko
>   LD [M]  drivers/edac/x38_edac.ko
>   LD [M]  drivers/firewire/firewire-core.ko
>   LD [M]  drivers/firewire/firewire-net.ko
>   LD [M]  drivers/firewire/firewire-ohci.ko
>   LD [M]  drivers/firewire/firewire-sbp2.ko
>   LD [M]  drivers/firmware/dcdbas.ko
>   LD [M]  drivers/firmware/dell_rbu.ko
>   LD [M]  drivers/firmware/edd.ko
>   LD [M]  drivers/firmware/iscsi_ibft.ko
>   LD [M]  drivers/gpio/gpio-sch.ko
>   LD [M]  drivers/gpu/drm/drm.ko
>   LD [M]  drivers/gpu/drm/drm_kms_helper.ko
>   LD [M]  drivers/gpu/drm/i2c/ch7006.ko
>   LD [M]  drivers/gpu/drm/i2c/sil164.ko
>   LD [M]  drivers/gpu/drm/i915/i915.ko
>   LD [M]  drivers/gpu/drm/mga/mga.ko
>   LD [M]  drivers/gpu/drm/nouveau/nouveau.ko
>   LD [M]  drivers/gpu/drm/r128/r128.ko
>   LD [M]  drivers/gpu/drm/radeon/radeon.ko
>   LD [M]  drivers/gpu/drm/savage/savage.ko
>   LD [M]  drivers/gpu/drm/sis/sis.ko
>   LD [M]  drivers/gpu/drm/ttm/ttm.ko
>   LD [M]  drivers/gpu/drm/via/via.ko
>   LD [M]  drivers/hid/hid-multitouch.ko
>   LD [M]  drivers/hid/hid-wacom.ko
>   LD [M]  drivers/hv/hv_balloon.ko
>   LD [M]  drivers/hv/hv_utils.ko
>   LD [M]  drivers/hwmon/abituguru.ko
>   LD [M]  drivers/hv/hv_vmbus.ko
>   LD [M]  drivers/hwmon/abituguru3.ko
>   LD [M]  drivers/hwmon/ad7414.ko
>   LD [M]  drivers/hwmon/ad7418.ko
>   LD [M]  drivers/hwmon/adm1021.ko
>   LD [M]  drivers/hwmon/adm1025.ko
>   LD [M]  drivers/hwmon/adm1026.ko
>   LD [M]  drivers/hwmon/adm1029.ko
>   LD [M]  drivers/hwmon/adm1031.ko
>   LD [M]  drivers/hwmon/adm9240.ko
>   LD [M]  drivers/hwmon/ads7828.ko
>   LD [M]  drivers/hwmon/adt7462.ko
>   LD [M]  drivers/hwmon/adt7470.ko
>   LD [M]  drivers/hwmon/adt7475.ko
>   LD [M]  drivers/hwmon/applesmc.ko
>   LD [M]  drivers/hwmon/asb100.ko
>   LD [M]  drivers/hwmon/asus_atk0110.ko
>   LD [M]  drivers/hwmon/coretemp.ko
>   LD [M]  drivers/hwmon/atxp1.ko
>   LD [M]  drivers/hwmon/ds1621.ko
>   LD [M]  drivers/hwmon/dme1737.ko
>   LD [M]  drivers/hwmon/f71882fg.ko
>   LD [M]  drivers/hwmon/f71805f.ko
>   LD [M]  drivers/hwmon/f75375s.ko
>   LD [M]  drivers/hwmon/fam15h_power.ko
>   LD [M]  drivers/hwmon/g760a.ko
>   LD [M]  drivers/hwmon/fschmd.ko
>   LD [M]  drivers/hwmon/gl518sm.ko
>   LD [M]  drivers/hwmon/gl520sm.ko
>   LD [M]  drivers/hwmon/hwmon-vid.ko
>   LD [M]  drivers/hwmon/ibmaem.ko
>   LD [M]  drivers/hwmon/i5k_amb.ko
>   LD [M]  drivers/hwmon/ibmpex.ko
>   LD [M]  drivers/hwmon/it87.ko
>   LD [M]  drivers/hwmon/k8temp.ko
>   LD [M]  drivers/hwmon/k10temp.ko
>   LD [M]  drivers/hwmon/lm75.ko
>   LD [M]  drivers/hwmon/lm63.ko
>   LD [M]  drivers/hwmon/lm77.ko
>   LD [M]  drivers/hwmon/lm78.ko
>   LD [M]  drivers/hwmon/lm80.ko
>   LD [M]  drivers/hwmon/lm83.ko
>   LD [M]  drivers/hwmon/lm87.ko
>   LD [M]  drivers/hwmon/lm85.ko
>   LD [M]  drivers/hwmon/lm90.ko
>   LD [M]  drivers/hwmon/lm93.ko
>   LD [M]  drivers/hwmon/lm92.ko
>   LD [M]  drivers/hwmon/lm95241.ko
>   LD [M]  drivers/hwmon/ltc4215.ko
>   LD [M]  drivers/hwmon/ltc4245.ko
>   LD [M]  drivers/hwmon/max1619.ko
>   LD [M]  drivers/hwmon/pc87360.ko
>   LD [M]  drivers/hwmon/max6650.ko
>   LD [M]  drivers/hwmon/pc87427.ko
>   LD [M]  drivers/hwmon/sht15.ko
>   LD [M]  drivers/hwmon/pcf8591.ko
>   LD [M]  drivers/hwmon/sis5595.ko
>   LD [M]  drivers/hwmon/smsc47b397.ko
>   LD [M]  drivers/hwmon/smsc47m1.ko
>   LD [M]  drivers/hwmon/smsc47m192.ko
>   LD [M]  drivers/hwmon/thmc50.ko
>   LD [M]  drivers/hwmon/tmp401.ko
>   LD [M]  drivers/hwmon/tmp421.ko
>   LD [M]  drivers/hwmon/via-cputemp.ko
>   LD [M]  drivers/hwmon/via686a.ko
>   LD [M]  drivers/hwmon/vt1211.ko
>   LD [M]  drivers/hwmon/vt8231.ko
>   LD [M]  drivers/hwmon/w83627ehf.ko
>   LD [M]  drivers/hwmon/w83627hf.ko
>   LD [M]  drivers/hwmon/w83781d.ko
>   LD [M]  drivers/hwmon/w83791d.ko
>   LD [M]  drivers/hwmon/w83792d.ko
>   LD [M]  drivers/hwmon/w83793.ko
>   LD [M]  drivers/hwmon/w83l785ts.ko
>   LD [M]  drivers/hwmon/w83l786ng.ko
>   LD [M]  drivers/i2c/algos/i2c-algo-bit.ko
>   LD [M]  drivers/i2c/algos/i2c-algo-pca.ko
>   LD [M]  drivers/i2c/busses/i2c-amd756-s4882.ko
>   LD [M]  drivers/i2c/busses/i2c-amd756.ko
>   LD [M]  drivers/i2c/busses/i2c-amd8111.ko
>   LD [M]  drivers/i2c/busses/i2c-i801.ko
>   LD [M]  drivers/i2c/busses/i2c-isch.ko
>   LD [M]  drivers/i2c/busses/i2c-nforce2-s4985.ko
>   LD [M]  drivers/i2c/busses/i2c-nforce2.ko
>   LD [M]  drivers/i2c/busses/i2c-parport-light.ko
>   LD [M]  drivers/i2c/busses/i2c-parport.ko
>   LD [M]  drivers/i2c/busses/i2c-pca-platform.ko
>   LD [M]  drivers/i2c/busses/i2c-piix4.ko
>   LD [M]  drivers/i2c/busses/i2c-scmi.ko
>   LD [M]  drivers/i2c/busses/i2c-simtec.ko
>   LD [M]  drivers/i2c/busses/i2c-sis96x.ko
>   LD [M]  drivers/i2c/busses/i2c-via.ko
>   LD [M]  drivers/i2c/busses/i2c-tiny-usb.ko
>   LD [M]  drivers/i2c/busses/i2c-viapro.ko
>   LD [M]  drivers/i2c/i2c-core.ko
>   LD [M]  drivers/i2c/i2c-dev.ko
>   LD [M]  drivers/i2c/i2c-smbus.ko
>   LD [M]  drivers/i2c/i2c-stub.ko
>   LD [M]  drivers/idle/i7300_idle.ko
>   LD [M]  drivers/infiniband/core/ib_addr.ko
>   LD [M]  drivers/infiniband/core/ib_cm.ko
>   LD [M]  drivers/infiniband/core/ib_core.ko
>   LD [M]  drivers/infiniband/core/ib_mad.ko
>   LD [M]  drivers/infiniband/core/ib_sa.ko
>   LD [M]  drivers/infiniband/core/ib_ucm.ko
>   LD [M]  drivers/infiniband/core/ib_umad.ko
>   LD [M]  drivers/infiniband/core/ib_uverbs.ko
>   LD [M]  drivers/infiniband/core/iw_cm.ko
>   LD [M]  drivers/infiniband/core/rdma_ucm.ko
>   LD [M]  drivers/infiniband/core/rdma_cm.ko
>   LD [M]  drivers/infiniband/hw/cxgb3/iw_cxgb3.ko
>   LD [M]  drivers/infiniband/hw/cxgb4/iw_cxgb4.ko
>   LD [M]  drivers/infiniband/hw/ipath/ib_ipath.ko
>   LD [M]  drivers/infiniband/hw/mlx4/mlx4_ib.ko
>   LD [M]  drivers/infiniband/hw/mthca/ib_mthca.ko
>   LD [M]  drivers/infiniband/hw/nes/iw_nes.ko
>   LD [M]  drivers/infiniband/hw/ocrdma/ocrdma.ko
>   LD [M]  drivers/infiniband/hw/qib/ib_qib.ko
>   LD [M]  drivers/infiniband/ulp/ipoib/ib_ipoib.ko
>   LD [M]  drivers/infiniband/ulp/iser/ib_iser.ko
>   LD [M]  drivers/infiniband/ulp/srp/ib_srp.ko
>   LD [M]  drivers/input/input-polldev.ko
>   LD [M]  drivers/input/joydev.ko
>   LD [M]  drivers/input/keyboard/adp5588-keys.ko
>   LD [M]  drivers/input/keyboard/max7359_keypad.ko
>   LD [M]  drivers/input/keyboard/opencores-kbd.ko
>   LD [M]  drivers/input/misc/apanel.ko
>   LD [M]  drivers/input/misc/ati_remote2.ko
>   LD [M]  drivers/input/misc/atlas_btns.ko
>   LD [M]  drivers/input/misc/cm109.ko
>   LD [M]  drivers/input/misc/keyspan_remote.ko
>   LD [M]  drivers/input/misc/pcspkr.ko
>   LD [M]  drivers/input/misc/powermate.ko
>   LD [M]  drivers/input/misc/rotary_encoder.ko
>   LD [M]  drivers/input/misc/uinput.ko
>   LD [M]  drivers/input/misc/yealink.ko
>   LD [M]  drivers/input/mouse/appletouch.ko
>   LD [M]  drivers/input/mouse/bcm5974.ko
>   LD [M]  drivers/input/mouse/sermouse.ko
>   LD [M]  drivers/input/mouse/synaptics_i2c.ko
>   LD [M]  drivers/input/mouse/vsxxxaa.ko
>   LD [M]  drivers/input/serio/serio_raw.ko
>   LD [M]  drivers/input/sparse-keymap.ko
>   LD [M]  drivers/input/tablet/acecad.ko
>   LD [M]  drivers/input/tablet/aiptek.ko
>   LD [M]  drivers/input/tablet/gtco.ko
>   LD [M]  drivers/input/tablet/kbtab.ko
>   LD [M]  drivers/input/tablet/wacom.ko
>   LD [M]  drivers/input/touchscreen/ad7879-i2c.ko
>   LD [M]  drivers/input/touchscreen/ad7879.ko
>   LD [M]  drivers/input/touchscreen/eeti_ts.ko
>   LD [M]  drivers/input/touchscreen/elo.ko
>   LD [M]  drivers/input/touchscreen/fujitsu_ts.ko
>   LD [M]  drivers/input/touchscreen/gunze.ko
>   LD [M]  drivers/input/touchscreen/inexio.ko
>   LD [M]  drivers/input/touchscreen/mcs5000_ts.ko
>   LD [M]  drivers/input/touchscreen/mtouch.ko
>   LD [M]  drivers/input/touchscreen/penmount.ko
>   LD [M]  drivers/input/touchscreen/touchit213.ko
>   LD [M]  drivers/input/touchscreen/touchright.ko
>   LD [M]  drivers/input/touchscreen/touchwin.ko
>   LD [M]  drivers/input/touchscreen/tsc2007.ko
>   LD [M]  drivers/input/touchscreen/usbtouchscreen.ko
>   LD [M]  drivers/input/touchscreen/wacom_w8001.ko
>   LD [M]  drivers/isdn/capi/capi.ko
>   LD [M]  drivers/isdn/capi/capidrv.ko
>   LD [M]  drivers/isdn/capi/kernelcapi.ko
>   LD [M]  drivers/isdn/divert/dss1_divert.ko
>   LD [M]  drivers/isdn/gigaset/bas_gigaset.ko
>   LD [M]  drivers/isdn/gigaset/gigaset.ko
>   LD [M]  drivers/isdn/gigaset/usb_gigaset.ko
>   LD [M]  drivers/isdn/gigaset/ser_gigaset.ko
>   LD [M]  drivers/isdn/hardware/avm/avm_cs.ko
>   LD [M]  drivers/isdn/hardware/avm/b1.ko
>   LD [M]  drivers/isdn/hardware/avm/b1dma.ko
>   LD [M]  drivers/isdn/hardware/avm/b1pci.ko
>   LD [M]  drivers/isdn/hardware/avm/b1pcmcia.ko
>   LD [M]  drivers/isdn/hardware/avm/c4.ko
>   LD [M]  drivers/isdn/hardware/avm/t1pci.ko
>   LD [M]  drivers/isdn/hardware/mISDN/avmfritz.ko
>   LD [M]  drivers/isdn/hardware/mISDN/hfcmulti.ko
>   LD [M]  drivers/isdn/hardware/mISDN/hfcpci.ko
>   LD [M]  drivers/isdn/hardware/mISDN/hfcsusb.ko
>   LD [M]  drivers/isdn/hardware/mISDN/mISDNinfineon.ko
>   LD [M]  drivers/isdn/hardware/mISDN/mISDNipac.ko
>   LD [M]  drivers/isdn/hardware/mISDN/mISDNisar.ko
>   LD [M]  drivers/isdn/hardware/mISDN/netjet.ko
>   LD [M]  drivers/isdn/hardware/mISDN/w6692.ko
>   LD [M]  drivers/isdn/hardware/mISDN/speedfax.ko
>   LD [M]  drivers/isdn/hisax/avma1_cs.ko
>   LD [M]  drivers/isdn/hisax/elsa_cs.ko
>   LD [M]  drivers/isdn/hisax/hfc4s8s_l1.ko
>   LD [M]  drivers/isdn/hisax/hisax.ko
>   LD [M]  drivers/isdn/hisax/hisax_fcpcipnp.ko
>   LD [M]  drivers/isdn/hisax/hisax_isac.ko
>   LD [M]  drivers/isdn/hisax/hisax_st5481.ko
>   LD [M]  drivers/isdn/hisax/sedlbauer_cs.ko
>   LD [M]  drivers/isdn/hisax/teles_cs.ko
>   LD [M]  drivers/isdn/hysdn/hysdn.ko
>   LD [M]  drivers/isdn/i4l/isdn.ko
>   LD [M]  drivers/isdn/i4l/isdnhdlc.ko
>   LD [M]  drivers/isdn/mISDN/l1oip.ko
>   LD [M]  drivers/isdn/mISDN/mISDN_core.ko
>   LD [M]  drivers/isdn/mISDN/mISDN_dsp.ko
>   LD [M]  drivers/leds/leds-clevo-mail.ko
>   LD [M]  drivers/leds/leds-lp3944.ko
>   LD [M]  drivers/leds/ledtrig-backlight.ko
>   LD [M]  drivers/leds/ledtrig-default-on.ko
>   LD [M]  drivers/leds/ledtrig-heartbeat.ko
>   LD [M]  drivers/leds/ledtrig-timer.ko
>   LD [M]  drivers/md/dm-bio-prison.ko
>   LD [M]  drivers/md/dm-bufio.ko
>   LD [M]  drivers/md/dm-crypt.ko
>   LD [M]  drivers/md/dm-delay.ko
>   LD [M]  drivers/md/dm-flakey.ko
>   LD [M]  drivers/md/dm-log-userspace.ko
>   LD [M]  drivers/md/dm-log.ko
>   LD [M]  drivers/md/dm-mirror.ko
>   LD [M]  drivers/md/dm-mod.ko
>   LD [M]  drivers/md/dm-multipath.ko
>   LD [M]  drivers/md/dm-queue-length.ko
>   LD [M]  drivers/md/dm-raid.ko
>   LD [M]  drivers/md/dm-region-hash.ko
>   LD [M]  drivers/md/dm-round-robin.ko
>   LD [M]  drivers/md/dm-service-time.ko
>   LD [M]  drivers/md/dm-snapshot.ko
>   LD [M]  drivers/md/dm-thin-pool.ko
>   LD [M]  drivers/md/faulty.ko
>   LD [M]  drivers/md/dm-zero.ko
>   LD [M]  drivers/md/linear.ko
>   LD [M]  drivers/md/persistent-data/dm-persistent-data.ko
>   LD [M]  drivers/md/raid1.ko
>   LD [M]  drivers/md/raid0.ko
>   LD [M]  drivers/md/raid10.ko
>   LD [M]  drivers/md/raid456.ko
>   LD [M]  drivers/memstick/core/mspro_block.ko
>   LD [M]  drivers/memstick/core/memstick.ko
>   LD [M]  drivers/memstick/host/jmb38x_ms.ko
>   LD [M]  drivers/memstick/host/r592.ko
>   LD [M]  drivers/memstick/host/rtsx_pci_ms.ko
>   LD [M]  drivers/memstick/host/tifm_ms.ko
>   LD [M]  drivers/message/fusion/mptbase.ko
>   LD [M]  drivers/message/fusion/mptctl.ko
>   LD [M]  drivers/message/fusion/mptfc.ko
>   LD [M]  drivers/message/fusion/mptlan.ko
>   LD [M]  drivers/message/fusion/mptsas.ko
>   LD [M]  drivers/message/fusion/mptscsih.ko
>   LD [M]  drivers/message/fusion/mptspi.ko
>   LD [M]  drivers/mfd/lpc_ich.ko
>   LD [M]  drivers/mfd/lpc_sch.ko
>   LD [M]  drivers/mfd/mfd-core.ko
>   LD [M]  drivers/mfd/rtsx_pci.ko
>   LD [M]  drivers/mfd/sm501.ko
>   LD [M]  drivers/misc/cb710/cb710.ko
>   LD [M]  drivers/misc/eeprom/at24.ko
>   LD [M]  drivers/misc/eeprom/eeprom.ko
>   LD [M]  drivers/misc/eeprom/eeprom_93cx6.ko
>   LD [M]  drivers/misc/eeprom/max6875.ko
>   LD [M]  drivers/misc/enclosure.ko
>   LD [M]  drivers/misc/hpilo.ko
>   LD [M]  drivers/misc/ics932s401.ko
>   LD [M]  drivers/misc/ioc4.ko
>   LD [M]  drivers/misc/isl29003.ko
>   LD [M]  drivers/misc/tifm_7xx1.ko
>   LD [M]  drivers/misc/tifm_core.ko
>   LD [M]  drivers/misc/tsl2550.ko
>   LD [M]  drivers/misc/vmw_balloon.ko
>   LD [M]  drivers/mmc/card/mmc_block.ko
>   LD [M]  drivers/mmc/card/sdio_uart.ko
>   LD [M]  drivers/mmc/core/mmc_core.ko
>   LD [M]  drivers/mmc/host/cb710-mmc.ko
>   LD [M]  drivers/mmc/host/rtsx_pci_sdmmc.ko
>   LD [M]  drivers/mmc/host/sdhci-pci.ko
>   LD [M]  drivers/mmc/host/sdhci-pltfm.ko
>   LD [M]  drivers/mmc/host/sdricoh_cs.ko
>   LD [M]  drivers/mmc/host/sdhci.ko
>   LD [M]  drivers/mmc/host/tifm_sd.ko
>   LD [M]  drivers/mmc/host/via-sdmmc.ko
>   LD [M]  drivers/mtd/ar7part.ko
>   LD [M]  drivers/mtd/chips/cfi_cmdset_0001.ko
>   LD [M]  drivers/mtd/chips/cfi_cmdset_0002.ko
>   LD [M]  drivers/mtd/chips/cfi_cmdset_0020.ko
>   LD [M]  drivers/mtd/chips/cfi_probe.ko
>   LD [M]  drivers/mtd/chips/cfi_util.ko
>   LD [M]  drivers/mtd/chips/gen_probe.ko
>   LD [M]  drivers/mtd/chips/jedec_probe.ko
>   LD [M]  drivers/mtd/chips/map_absent.ko
>   LD [M]  drivers/mtd/chips/map_ram.ko
>   LD [M]  drivers/mtd/chips/map_rom.ko
>   LD [M]  drivers/mtd/devices/block2mtd.ko
>   LD [M]  drivers/mtd/devices/mtdram.ko
>   LD [M]  drivers/mtd/devices/pmc551.ko
>   LD [M]  drivers/mtd/ftl.ko
>   LD [M]  drivers/mtd/inftl.ko
>   LD [M]  drivers/mtd/lpddr/lpddr_cmds.ko
>   LD [M]  drivers/mtd/lpddr/qinfo_probe.ko
>   LD [M]  drivers/mtd/maps/ck804xrom.ko
>   LD [M]  drivers/mtd/maps/esb2rom.ko
>   LD [M]  drivers/mtd/maps/netsc520.ko
>   LD [M]  drivers/mtd/maps/pci.ko
>   LD [M]  drivers/mtd/maps/sc520cdp.ko
>   LD [M]  drivers/mtd/maps/scb2_flash.ko
>   LD [M]  drivers/mtd/maps/ts5500_flash.ko
>   LD [M]  drivers/mtd/mtd_blkdevs.ko
>   LD [M]  drivers/mtd/mtdblock.ko
>   LD [M]  drivers/mtd/mtdblock_ro.ko
>   LD [M]  drivers/mtd/mtdchar.ko
>   LD [M]  drivers/mtd/mtdoops.ko
>   LD [M]  drivers/mtd/nand/alauda.ko
>   LD [M]  drivers/mtd/nand/diskonchip.ko
>   LD [M]  drivers/mtd/nand/nand.ko
>   LD [M]  drivers/mtd/nand/nand_ecc.ko
>   LD [M]  drivers/mtd/nand/nand_ids.ko
>   LD [M]  drivers/mtd/nand/nandsim.ko
>   LD [M]  drivers/mtd/nftl.ko
>   LD [M]  drivers/mtd/redboot.ko
>   LD [M]  drivers/mtd/rfd_ftl.ko
>   LD [M]  drivers/mtd/ssfdc.ko
>   LD [M]  drivers/mtd/ubi/ubi.ko
>   LD [M]  drivers/net/bonding/bonding.ko
>   LD [M]  drivers/net/can/can-dev.ko
>   LD [M]  drivers/net/can/sja1000/ems_pci.ko
>   LD [M]  drivers/net/can/sja1000/kvaser_pci.ko
>   LD [M]  drivers/net/can/sja1000/sja1000.ko
>   LD [M]  drivers/net/can/sja1000/sja1000_platform.ko
>   LD [M]  drivers/net/can/usb/ems_usb.ko
>   LD [M]  drivers/net/dummy.ko
>   LD [M]  drivers/net/can/vcan.ko
>   LD [M]  drivers/net/ethernet/3com/3c574_cs.ko
>   LD [M]  drivers/net/ethernet/3com/3c589_cs.ko
>   LD [M]  drivers/net/ethernet/3com/3c59x.ko
>   LD [M]  drivers/net/ethernet/3com/typhoon.ko
>   LD [M]  drivers/net/ethernet/8390/8390.ko
>   LD [M]  drivers/net/ethernet/8390/axnet_cs.ko
>   LD [M]  drivers/net/ethernet/8390/ne2k-pci.ko
>   LD [M]  drivers/net/ethernet/8390/pcnet_cs.ko
>   LD [M]  drivers/net/ethernet/adaptec/starfire.ko
>   LD [M]  drivers/net/ethernet/alteon/acenic.ko
>   LD [M]  drivers/net/ethernet/amd/amd8111e.ko
>   LD [M]  drivers/net/ethernet/amd/nmclan_cs.ko
>   LD [M]  drivers/net/ethernet/amd/pcnet32.ko
>   LD [M]  drivers/net/ethernet/atheros/atl1c/atl1c.ko
>   LD [M]  drivers/net/ethernet/atheros/atl1e/atl1e.ko
>   LD [M]  drivers/net/ethernet/atheros/atlx/atl1.ko
>   LD [M]  drivers/net/ethernet/broadcom/b44.ko
>   LD [M]  drivers/net/ethernet/atheros/atlx/atl2.ko
>   LD [M]  drivers/net/ethernet/broadcom/bnx2.ko
>   LD [M]  drivers/net/ethernet/broadcom/bnx2x/bnx2x.ko
>   LD [M]  drivers/net/ethernet/broadcom/cnic.ko
>   LD [M]  drivers/net/ethernet/broadcom/tg3.ko
>   LD [M]  drivers/net/ethernet/brocade/bna/bna.ko
>   LD [M]  drivers/net/ethernet/chelsio/cxgb/cxgb.ko
>   LD [M]  drivers/net/ethernet/chelsio/cxgb3/cxgb3.ko
>   LD [M]  drivers/net/ethernet/chelsio/cxgb4/cxgb4.ko
>   LD [M]  drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf.ko
>   LD [M]  drivers/net/ethernet/cisco/enic/enic.ko
>   LD [M]  drivers/net/ethernet/dec/tulip/de2104x.ko
>   LD [M]  drivers/net/ethernet/dec/tulip/de4x5.ko
>   LD [M]  drivers/net/ethernet/dec/tulip/dmfe.ko
>   LD [M]  drivers/net/ethernet/dec/tulip/tulip.ko
>   LD [M]  drivers/net/ethernet/dec/tulip/uli526x.ko
>   LD [M]  drivers/net/ethernet/dec/tulip/winbond-840.ko
>   LD [M]  drivers/net/ethernet/dec/tulip/xircom_cb.ko
>   LD [M]  drivers/net/ethernet/dlink/dl2k.ko
>   LD [M]  drivers/net/ethernet/dlink/sundance.ko
>   LD [M]  drivers/net/ethernet/dnet.ko
>   LD [M]  drivers/net/ethernet/emulex/benet/be2net.ko
>   LD [M]  drivers/net/ethernet/ethoc.ko
>   LD [M]  drivers/net/ethernet/fealnx.ko
>   LD [M]  drivers/net/ethernet/fujitsu/fmvj18x_cs.ko
>   LD [M]  drivers/net/ethernet/icplus/ipg.ko
>   LD [M]  drivers/net/ethernet/intel/e100.ko
>   LD [M]  drivers/net/ethernet/intel/e1000/e1000.ko
>   LD [M]  drivers/net/ethernet/intel/e1000e/e1000e.ko
>   LD [M]  drivers/net/ethernet/intel/igb/igb.ko
>   LD [M]  drivers/net/ethernet/intel/igbvf/igbvf.ko
>   LD [M]  drivers/net/ethernet/intel/ixgb/ixgb.ko
>   LD [M]  drivers/net/ethernet/intel/ixgbe/ixgbe.ko
>   LD [M]  drivers/net/ethernet/intel/ixgbevf/ixgbevf.ko
>   LD [M]  drivers/net/ethernet/jme.ko
>   LD [M]  drivers/net/ethernet/marvell/skge.ko
>   LD [M]  drivers/net/ethernet/marvell/sky2.ko
>   LD [M]  drivers/net/ethernet/mellanox/mlx4/mlx4_core.ko
>   LD [M]  drivers/net/ethernet/mellanox/mlx4/mlx4_en.ko
>   LD [M]  drivers/net/ethernet/myricom/myri10ge/myri10ge.ko
>   LD [M]  drivers/net/ethernet/natsemi/ns83820.ko
>   LD [M]  drivers/net/ethernet/natsemi/natsemi.ko
>   LD [M]  drivers/net/ethernet/neterion/s2io.ko
>   LD [M]  drivers/net/ethernet/neterion/vxge/vxge.ko
>   LD [M]  drivers/net/ethernet/nvidia/forcedeth.ko
>   LD [M]  drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.ko
>   LD [M]  drivers/net/ethernet/qlogic/netxen/netxen_nic.ko
>   LD [M]  drivers/net/ethernet/qlogic/qla3xxx.ko
>   LD [M]  drivers/net/ethernet/qlogic/qlcnic/qlcnic.ko
>   LD [M]  drivers/net/ethernet/qlogic/qlge/qlge.ko
>   LD [M]  drivers/net/ethernet/rdc/r6040.ko
>   LD [M]  drivers/net/ethernet/realtek/8139cp.ko
>   LD [M]  drivers/net/ethernet/realtek/8139too.ko
>   LD [M]  drivers/net/ethernet/realtek/r8169.ko
>   LD [M]  drivers/net/ethernet/sfc/sfc.ko
>   LD [M]  drivers/net/ethernet/silan/sc92031.ko
>   LD [M]  drivers/net/ethernet/sis/sis190.ko
>   LD [M]  drivers/net/ethernet/sis/sis900.ko
>   LD [M]  drivers/net/ethernet/smsc/epic100.ko
>   LD [M]  drivers/net/ethernet/smsc/smc91c92_cs.ko
>   LD [M]  drivers/net/ethernet/smsc/smsc9420.ko
>   LD [M]  drivers/net/ethernet/sun/cassini.ko
>   LD [M]  drivers/net/ethernet/sun/niu.ko
>   LD [M]  drivers/net/ethernet/sun/sungem.ko
>   LD [M]  drivers/net/ethernet/sun/sunhme.ko
>   LD [M]  drivers/net/ethernet/tehuti/tehuti.ko
>   LD [M]  drivers/net/ethernet/ti/tlan.ko
>   LD [M]  drivers/net/ethernet/via/via-rhine.ko
>   LD [M]  drivers/net/ethernet/via/via-velocity.ko
>   LD [M]  drivers/net/ethernet/xircom/xirc2ps_cs.ko
>   LD [M]  drivers/net/hyperv/hv_netvsc.ko
>   LD [M]  drivers/net/ieee802154/fakehard.ko
>   LD [M]  drivers/net/ifb.ko
>   LD [M]  drivers/net/macvlan.ko
>   LD [M]  drivers/net/macvtap.ko
>   LD [M]  drivers/net/mdio.ko
>   LD [M]  drivers/net/mii.ko
>   LD [M]  drivers/net/netconsole.ko
>   LD [M]  drivers/net/phy/broadcom.ko
>   LD [M]  drivers/net/phy/cicada.ko
>   LD [M]  drivers/net/phy/davicom.ko
>   LD [M]  drivers/net/phy/et1011c.ko
>   LD [M]  drivers/net/phy/icplus.ko
>   LD [M]  drivers/net/phy/lxt.ko
>   LD [M]  drivers/net/phy/marvell.ko
>   LD [M]  drivers/net/phy/mdio-bitbang.ko
>   LD [M]  drivers/net/phy/national.ko
>   LD [M]  drivers/net/phy/qsemi.ko
>   LD [M]  drivers/net/phy/realtek.ko
>   LD [M]  drivers/net/phy/smsc.ko
>   LD [M]  drivers/net/phy/ste10Xp.ko
>   LD [M]  drivers/net/phy/vitesse.ko
>   LD [M]  drivers/net/ppp/ppp_async.ko
>   LD [M]  drivers/net/ppp/ppp_deflate.ko
>   LD [M]  drivers/net/ppp/ppp_generic.ko
>   LD [M]  drivers/net/ppp/ppp_mppe.ko
>   LD [M]  drivers/net/ppp/ppp_synctty.ko
>   LD [M]  drivers/net/ppp/pppoe.ko
>   LD [M]  drivers/net/ppp/pppox.ko
>   LD [M]  drivers/net/slip/slhc.ko
>   LD [M]  drivers/net/slip/slip.ko
>   LD [M]  drivers/net/sungem_phy.ko
>   LD [M]  drivers/net/tun.ko
>   LD [M]  drivers/net/usb/asix.ko
>   LD [M]  drivers/net/usb/catc.ko
>   LD [M]  drivers/net/usb/cdc-phonet.ko
>   LD [M]  drivers/net/usb/cdc_eem.ko
>   LD [M]  drivers/net/usb/cdc_ether.ko
>   LD [M]  drivers/net/usb/cdc_ncm.ko
>   LD [M]  drivers/net/usb/cdc_subset.ko
>   LD [M]  drivers/net/usb/dm9601.ko
>   LD [M]  drivers/net/usb/gl620a.ko
>   LD [M]  drivers/net/usb/hso.ko
>   LD [M]  drivers/net/usb/int51x1.ko
>   LD [M]  drivers/net/usb/kaweth.ko
>   LD [M]  drivers/net/usb/mcs7830.ko
>   LD [M]  drivers/net/usb/net1080.ko
>   LD [M]  drivers/net/usb/pegasus.ko
>   LD [M]  drivers/net/usb/plusb.ko
>   LD [M]  drivers/net/usb/rndis_host.ko
>   LD [M]  drivers/net/usb/rtl8150.ko
>   LD [M]  drivers/net/usb/sierra_net.ko
>   LD [M]  drivers/net/usb/smsc95xx.ko
>   LD [M]  drivers/net/usb/usbnet.ko
>   LD [M]  drivers/net/usb/zaurus.ko
>   LD [M]  drivers/net/veth.ko
>   LD [M]  drivers/net/virtio_net.ko
>   LD [M]  drivers/net/vmxnet3/vmxnet3.ko
>   LD [M]  drivers/net/vxlan.ko
>   LD [M]  drivers/net/wan/dlci.ko
>   LD [M]  drivers/net/wan/hdlc.ko
>   LD [M]  drivers/net/wan/hdlc_cisco.ko
>   LD [M]  drivers/net/wan/hdlc_fr.ko
>   LD [M]  drivers/net/wan/hdlc_ppp.ko
>   LD [M]  drivers/net/wan/hdlc_raw.ko
>   LD [M]  drivers/net/wimax/i2400m/i2400m-usb.ko
>   LD [M]  drivers/net/wimax/i2400m/i2400m.ko
>   LD [M]  drivers/net/wireless/adm8211.ko
>   LD [M]  drivers/net/wireless/airo.ko
>   LD [M]  drivers/net/wireless/airo_cs.ko
>   LD [M]  drivers/net/wireless/at76c50x-usb.ko
>   LD [M]  drivers/net/wireless/ath/ath.ko
>   LD [M]  drivers/net/wireless/ath/ath5k/ath5k.ko
>   LD [M]  drivers/net/wireless/ath/ath9k/ath9k.ko
>   LD [M]  drivers/net/wireless/ath/ath9k/ath9k_common.ko
>   LD [M]  drivers/net/wireless/ath/ath9k/ath9k_htc.ko
>   LD [M]  drivers/net/wireless/ath/ath9k/ath9k_hw.ko
>   LD [M]  drivers/net/wireless/ath/carl9170/carl9170.ko
>   LD [M]  drivers/net/wireless/atmel.ko
>   LD [M]  drivers/net/wireless/atmel_cs.ko
>   LD [M]  drivers/net/wireless/atmel_pci.ko
>   LD [M]  drivers/net/wireless/b43/b43.ko
>   LD [M]  drivers/net/wireless/b43legacy/b43legacy.ko
>   LD [M]  drivers/net/wireless/brcm80211/brcmsmac/brcmsmac.ko
>   LD [M]  drivers/net/wireless/brcm80211/brcmutil/brcmutil.ko
>   LD [M]  drivers/net/wireless/hostap/hostap.ko
>   LD [M]  drivers/net/wireless/hostap/hostap_cs.ko
>   LD [M]  drivers/net/wireless/hostap/hostap_pci.ko
>   LD [M]  drivers/net/wireless/hostap/hostap_plx.ko
>   LD [M]  drivers/net/wireless/ipw2x00/ipw2100.ko
>   LD [M]  drivers/net/wireless/ipw2x00/ipw2200.ko
>   LD [M]  drivers/net/wireless/ipw2x00/libipw.ko
>   LD [M]  drivers/net/wireless/iwlegacy/iwl3945.ko
>   LD [M]  drivers/net/wireless/iwlegacy/iwl4965.ko
>   LD [M]  drivers/net/wireless/iwlegacy/iwlegacy.ko
>   LD [M]  drivers/net/wireless/iwlwifi/dvm/iwldvm.ko
>   LD [M]  drivers/net/wireless/iwlwifi/iwlwifi.ko
>   LD [M]  drivers/net/wireless/libertas/libertas_cs.ko
>   LD [M]  drivers/net/wireless/libertas/libertas.ko
>   LD [M]  drivers/net/wireless/libertas/libertas_sdio.ko
>   LD [M]  drivers/net/wireless/libertas/usb8xxx.ko
>   LD [M]  drivers/net/wireless/libertas_tf/libertas_tf.ko
>   LD [M]  drivers/net/wireless/libertas_tf/libertas_tf_usb.ko
>   LD [M]  drivers/net/wireless/mac80211_hwsim.ko
>   LD [M]  drivers/net/wireless/mwl8k.ko
>   LD [M]  drivers/net/wireless/orinoco/orinoco.ko
>   LD [M]  drivers/net/wireless/orinoco/orinoco_cs.ko
>   LD [M]  drivers/net/wireless/orinoco/orinoco_nortel.ko
>   LD [M]  drivers/net/wireless/orinoco/orinoco_pci.ko
>   LD [M]  drivers/net/wireless/orinoco/orinoco_plx.ko
>   LD [M]  drivers/net/wireless/orinoco/orinoco_tmd.ko
>   LD [M]  drivers/net/wireless/orinoco/spectrum_cs.ko
>   LD [M]  drivers/net/wireless/p54/p54common.ko
>   LD [M]  drivers/net/wireless/p54/p54pci.ko
>   LD [M]  drivers/net/wireless/p54/p54usb.ko
>   LD [M]  drivers/net/wireless/rndis_wlan.ko
>   LD [M]  drivers/net/wireless/rt2x00/rt2400pci.ko
>   LD [M]  drivers/net/wireless/rt2x00/rt2500pci.ko
>   LD [M]  drivers/net/wireless/rt2x00/rt2500usb.ko
>   LD [M]  drivers/net/wireless/rt2x00/rt2800lib.ko
>   LD [M]  drivers/net/wireless/rt2x00/rt2800pci.ko
>   LD [M]  drivers/net/wireless/rt2x00/rt2800usb.ko
>   LD [M]  drivers/net/wireless/rt2x00/rt2x00lib.ko
>   LD [M]  drivers/net/wireless/rt2x00/rt2x00pci.ko
>   LD [M]  drivers/net/wireless/rt2x00/rt2x00usb.ko
>   LD [M]  drivers/net/wireless/rt2x00/rt61pci.ko
>   LD [M]  drivers/net/wireless/rt2x00/rt73usb.ko
>   LD [M]  drivers/net/wireless/rtl818x/rtl8180/rtl8180.ko
>   LD [M]  drivers/net/wireless/rtl818x/rtl8187/rtl8187.ko
>   LD [M]  drivers/net/wireless/ti/wl1251/wl1251.ko
>   LD [M]  drivers/net/wireless/ti/wl1251/wl1251_sdio.ko
>   LD [M]  drivers/net/wireless/ti/wl12xx/wl12xx.ko
>   LD [M]  drivers/net/wireless/ti/wlcore/wlcore.ko
>   LD [M]  drivers/net/wireless/wl3501_cs.ko
>   LD [M]  drivers/net/wireless/zd1201.ko
>   LD [M]  drivers/net/wireless/zd1211rw/zd1211rw.ko
>   LD [M]  drivers/parport/parport.ko
>   LD [M]  drivers/parport/parport_cs.ko
>   LD [M]  drivers/parport/parport_pc.ko
>   LD [M]  drivers/parport/parport_serial.ko
>   LD [M]  drivers/pci/hotplug/acpiphp_ibm.ko
>   LD [M]  drivers/pci/hotplug/shpchp.ko
>   LD [M]  drivers/pci/pcie/aer/aer_inject.ko
>   LD [M]  drivers/pcmcia/pd6729.ko
>   LD [M]  drivers/platform/x86/acer-wmi.ko
>   LD [M]  drivers/pcmcia/yenta_socket.ko
>   LD [M]  drivers/platform/x86/asus-laptop.ko
>   LD [M]  drivers/platform/x86/compal-laptop.ko
>   LD [M]  drivers/platform/x86/dell-laptop.ko
>   LD [M]  drivers/platform/x86/dell-wmi.ko
>   LD [M]  drivers/platform/x86/eeepc-laptop.ko
>   LD [M]  drivers/platform/x86/fujitsu-laptop.ko
>   LD [M]  drivers/platform/x86/hp-wmi.ko
>   LD [M]  drivers/platform/x86/hdaps.ko
>   LD [M]  drivers/platform/x86/intel_ips.ko
>   LD [M]  drivers/platform/x86/msi-laptop.ko
>   LD [M]  drivers/platform/x86/mxm-wmi.ko
>   LD [M]  drivers/platform/x86/sony-laptop.ko
>   LD [M]  drivers/platform/x86/panasonic-laptop.ko
>   LD [M]  drivers/platform/x86/thinkpad_acpi.ko
>   LD [M]  drivers/platform/x86/topstar-laptop.ko
>   LD [M]  drivers/platform/x86/toshiba_acpi.ko
>   LD [M]  drivers/platform/x86/wmi.ko
>   LD [M]  drivers/power/bq27x00_battery.ko
>   LD [M]  drivers/power/max17040_battery.ko
>   LD [M]  drivers/pps/pps_core.ko
>   LD [M]  drivers/ptp/ptp.ko
>   LD [M]  drivers/ptp/ptp_pch.ko
>   LD [M]  drivers/regulator/fixed.ko
>   LD [M]  drivers/regulator/lp3971.ko
>   LD [M]  drivers/regulator/max1586.ko
>   LD [M]  drivers/regulator/tps65023-regulator.ko
>   LD [M]  drivers/regulator/tps6507x-regulator.ko
>   LD [M]  drivers/regulator/userspace-consumer.ko
>   LD [M]  drivers/rtc/rtc-bq4802.ko
>   LD [M]  drivers/rtc/rtc-ds1286.ko
>   LD [M]  drivers/rtc/rtc-ds1307.ko
>   LD [M]  drivers/rtc/rtc-ds1374.ko
>   LD [M]  drivers/rtc/rtc-ds1511.ko
>   LD [M]  drivers/rtc/rtc-ds1553.ko
>   LD [M]  drivers/rtc/rtc-ds1672.ko
>   LD [M]  drivers/rtc/rtc-ds1742.ko
>   LD [M]  drivers/rtc/rtc-fm3130.ko
>   LD [M]  drivers/rtc/rtc-isl1208.ko
>   LD [M]  drivers/rtc/rtc-m41t80.ko
>   LD [M]  drivers/rtc/rtc-m48t35.ko
>   LD [M]  drivers/rtc/rtc-m48t59.ko
>   LD [M]  drivers/rtc/rtc-max6900.ko
>   LD [M]  drivers/rtc/rtc-pcf8583.ko
>   LD [M]  drivers/rtc/rtc-pcf8563.ko
>   LD [M]  drivers/rtc/rtc-rs5c372.ko
>   LD [M]  drivers/rtc/rtc-rx8025.ko
>   LD [M]  drivers/rtc/rtc-rx8581.ko
>   LD [M]  drivers/rtc/rtc-stk17ta8.ko
>   LD [M]  drivers/rtc/rtc-v3020.ko
>   LD [M]  drivers/rtc/rtc-x1205.ko
>   LD [M]  drivers/scsi/3w-9xxx.ko
>   LD [M]  drivers/scsi/3w-sas.ko
>   LD [M]  drivers/scsi/3w-xxxx.ko
>   LD [M]  drivers/scsi/aacraid/aacraid.ko
>   LD [M]  drivers/scsi/aic7xxx/aic79xx.ko
>   LD [M]  drivers/scsi/aic7xxx/aic7xxx.ko
>   LD [M]  drivers/scsi/aic94xx/aic94xx.ko
>   LD [M]  drivers/scsi/arcmsr/arcmsr.ko
>   LD [M]  drivers/scsi/be2iscsi/be2iscsi.ko
>   LD [M]  drivers/scsi/bfa/bfa.ko
>   LD [M]  drivers/scsi/bnx2fc/bnx2fc.ko
>   LD [M]  drivers/scsi/bnx2i/bnx2i.ko
>   LD [M]  drivers/scsi/ch.ko
>   LD [M]  drivers/scsi/cxgbi/cxgb3i/cxgb3i.ko
>   LD [M]  drivers/scsi/cxgbi/libcxgbi.ko
>   LD [M]  drivers/scsi/cxgbi/cxgb4i/cxgb4i.ko
>   LD [M]  drivers/scsi/device_handler/scsi_dh_alua.ko
>   LD [M]  drivers/scsi/device_handler/scsi_dh_emc.ko
>   LD [M]  drivers/scsi/device_handler/scsi_dh_hp_sw.ko
>   LD [M]  drivers/scsi/device_handler/scsi_dh_rdac.ko
>   LD [M]  drivers/scsi/fcoe/fcoe.ko
>   LD [M]  drivers/scsi/fnic/fnic.ko
>   LD [M]  drivers/scsi/fcoe/libfcoe.ko
>   LD [M]  drivers/scsi/hpsa.ko
>   LD [M]  drivers/scsi/hptiop.ko
>   LD [M]  drivers/scsi/hv_storvsc.ko
>   LD [M]  drivers/scsi/imm.ko
>   LD [M]  drivers/scsi/initio.ko
>   LD [M]  drivers/scsi/ips.ko
>   LD [M]  drivers/scsi/isci/isci.ko
>   LD [M]  drivers/scsi/iscsi_boot_sysfs.ko
>   LD [M]  drivers/scsi/iscsi_tcp.ko
>   LD [M]  drivers/scsi/libfc/libfc.ko
>   LD [M]  drivers/scsi/libiscsi.ko
>   LD [M]  drivers/scsi/libiscsi_tcp.ko
>   LD [M]  drivers/scsi/libsas/libsas.ko
>   LD [M]  drivers/scsi/libsrp.ko
>   LD [M]  drivers/scsi/lpfc/lpfc.ko
>   LD [M]  drivers/scsi/megaraid/megaraid_mbox.ko
>   LD [M]  drivers/scsi/megaraid/megaraid_mm.ko
>   LD [M]  drivers/scsi/megaraid/megaraid_sas.ko
>   LD [M]  drivers/scsi/mpt3sas/mpt3sas.ko
>   LD [M]  drivers/scsi/mpt2sas/mpt2sas.ko
>   LD [M]  drivers/scsi/mvsas/mvsas.ko
>   LD [M]  drivers/scsi/osd/libosd.ko
>   LD [M]  drivers/scsi/osd/osd.ko
>   LD [M]  drivers/scsi/osst.ko
>   LD [M]  drivers/scsi/pm8001/pm8001.ko
>   LD [M]  drivers/scsi/pmcraid.ko
>   LD [M]  drivers/scsi/ppa.ko
>   LD [M]  drivers/scsi/qla2xxx/qla2xxx.ko
>   LD [M]  drivers/scsi/qla4xxx/qla4xxx.ko
>   LD [M]  drivers/scsi/raid_class.ko
>   LD [M]  drivers/scsi/scsi_debug.ko
>   LD [M]  drivers/scsi/scsi_tgt.ko
>   LD [M]  drivers/scsi/scsi_transport_fc.ko
>   LD [M]  drivers/scsi/scsi_transport_iscsi.ko
>   LD [M]  drivers/scsi/scsi_transport_spi.ko
>   LD [M]  drivers/scsi/scsi_transport_sas.ko
>   LD [M]  drivers/scsi/scsi_transport_srp.ko
>   LD [M]  drivers/scsi/sd_mod.ko
>   LD [M]  drivers/scsi/ses.ko
>   LD [M]  drivers/scsi/sg.ko
>   LD [M]  drivers/scsi/sr_mod.ko
>   LD [M]  drivers/scsi/st.ko
>   LD [M]  drivers/scsi/sym53c8xx_2/sym53c8xx.ko
>   LD [M]  drivers/scsi/stex.ko
>   LD [M]  drivers/scsi/vmw_pvscsi.ko
>   LD [M]  drivers/scsi/virtio_scsi.ko
>   LD [M]  drivers/ssb/ssb.ko
>   LD [M]  drivers/target/loopback/tcm_loop.ko
>   LD [M]  drivers/target/target_core_file.ko
>   LD [M]  drivers/target/target_core_iblock.ko
>   LD [M]  drivers/target/target_core_mod.ko
>   LD [M]  drivers/target/target_core_pscsi.ko
>   LD [M]  drivers/target/tcm_fc/tcm_fc.ko
>   LD [M]  drivers/tty/cyclades.ko
>   LD [M]  drivers/tty/ipwireless/ipwireless.ko
>   LD [M]  drivers/tty/n_hdlc.ko
>   LD [M]  drivers/tty/nozomi.ko
>   LD [M]  drivers/tty/serial/8250/serial_cs.ko
>   LD [M]  drivers/tty/serial/jsm/jsm.ko
>   LD [M]  drivers/tty/synclink.ko
>   LD [M]  drivers/tty/synclink_gt.ko
>   LD [M]  drivers/tty/synclinkmp.ko
>   LD [M]  drivers/uio/uio.ko
>   LD [M]  drivers/uio/uio_aec.ko
>   LD [M]  drivers/uio/uio_cif.ko
>   LD [M]  drivers/uio/uio_pdrv.ko
>   LD [M]  drivers/uio/uio_pci_generic.ko
>   LD [M]  drivers/uio/uio_pdrv_genirq.ko
>   LD [M]  drivers/uio/uio_sercos3.ko
>   LD [M]  drivers/usb/atm/cxacru.ko
>   LD [M]  drivers/usb/atm/speedtch.ko
>   LD [M]  drivers/usb/atm/ueagle-atm.ko
>   LD [M]  drivers/usb/atm/usbatm.ko
>   LD [M]  drivers/usb/atm/xusbatm.ko
>   LD [M]  drivers/usb/class/cdc-acm.ko
>   LD [M]  drivers/usb/class/cdc-wdm.ko
>   LD [M]  drivers/usb/class/usblp.ko
>   LD [M]  drivers/usb/class/usbtmc.ko
>   LD [M]  drivers/usb/host/hwa-hc.ko
>   LD [M]  drivers/usb/host/isp1362-hcd.ko
>   LD [M]  drivers/usb/host/sl811-hcd.ko
>   LD [M]  drivers/usb/host/u132-hcd.ko
>   LD [M]  drivers/usb/host/whci/whci-hcd.ko
>   LD [M]  drivers/usb/host/xhci-hcd.ko
>   LD [M]  drivers/usb/image/mdc800.ko
>   LD [M]  drivers/usb/image/microtek.ko
>   LD [M]  drivers/usb/misc/adutux.ko
>   LD [M]  drivers/usb/misc/appledisplay.ko
>   LD [M]  drivers/usb/misc/emi26.ko
>   LD [M]  drivers/usb/misc/emi62.ko
>   LD [M]  drivers/usb/misc/ezusb.ko
>   LD [M]  drivers/usb/misc/ftdi-elan.ko
>   LD [M]  drivers/usb/misc/idmouse.ko
>   LD [M]  drivers/usb/misc/iowarrior.ko
>   LD [M]  drivers/usb/misc/isight_firmware.ko
>   LD [M]  drivers/usb/misc/ldusb.ko
>   LD [M]  drivers/usb/misc/legousbtower.ko
>   LD [M]  drivers/usb/misc/sisusbvga/sisusbvga.ko
>   LD [M]  drivers/usb/misc/usblcd.ko
>   LD [M]  drivers/usb/misc/usbled.ko
>   LD [M]  drivers/usb/misc/usbsevseg.ko
>   LD [M]  drivers/usb/misc/uss720.ko
>   LD [M]  drivers/usb/otg/nop-usb-xceiv.ko
>   LD [M]  drivers/usb/serial/aircable.ko
>   LD [M]  drivers/usb/serial/ark3116.ko
>   LD [M]  drivers/usb/serial/belkin_sa.ko
>   LD [M]  drivers/usb/serial/ch341.ko
>   LD [M]  drivers/usb/serial/cp210x.ko
>   LD [M]  drivers/usb/serial/cyberjack.ko
>   LD [M]  drivers/usb/serial/cypress_m8.ko
>   LD [M]  drivers/usb/serial/digi_acceleport.ko
>   LD [M]  drivers/usb/serial/empeg.ko
>   LD [M]  drivers/usb/serial/ftdi_sio.ko
>   LD [M]  drivers/usb/serial/funsoft.ko
>   LD [M]  drivers/usb/serial/garmin_gps.ko
>   LD [M]  drivers/usb/serial/hp4x.ko
>   LD [M]  drivers/usb/serial/io_edgeport.ko
>   LD [M]  drivers/usb/serial/io_ti.ko
>   LD [M]  drivers/usb/serial/ipaq.ko
>   LD [M]  drivers/usb/serial/ipw.ko
>   LD [M]  drivers/usb/serial/ir-usb.ko
>   LD [M]  drivers/usb/serial/iuu_phoenix.ko
>   LD [M]  drivers/usb/serial/keyspan.ko
>   LD [M]  drivers/usb/serial/keyspan_pda.ko
>   LD [M]  drivers/usb/serial/kl5kusb105.ko
>   LD [M]  drivers/usb/serial/kobil_sct.ko
>   LD [M]  drivers/usb/serial/mct_u232.ko
>   LD [M]  drivers/usb/serial/mos7720.ko
>   LD [M]  drivers/usb/serial/mos7840.ko
>   LD [M]  drivers/usb/serial/moto_modem.ko
>   LD [M]  drivers/usb/serial/navman.ko
>   LD [M]  drivers/usb/serial/omninet.ko
>   LD [M]  drivers/usb/serial/opticon.ko
>   LD [M]  drivers/usb/serial/option.ko
>   LD [M]  drivers/usb/serial/oti6858.ko
>   LD [M]  drivers/usb/serial/pl2303.ko
>   LD [M]  drivers/usb/serial/qcserial.ko
>   LD [M]  drivers/usb/serial/safe_serial.ko
>   LD [M]  drivers/usb/serial/siemens_mpi.ko
>   LD [M]  drivers/usb/serial/sierra.ko
>   LD [M]  drivers/usb/serial/spcp8x5.ko
>   LD [M]  drivers/usb/serial/symbolserial.ko
>   LD [M]  drivers/usb/serial/ti_usb_3410_5052.ko
>   LD [M]  drivers/usb/serial/usb_debug.ko
>   LD [M]  drivers/usb/serial/usb_wwan.ko
>   LD [M]  drivers/usb/serial/usbserial.ko
>   LD [M]  drivers/usb/serial/visor.ko
>   LD [M]  drivers/usb/serial/whiteheat.ko
>   LD [M]  drivers/usb/storage/ums-alauda.ko
>   LD [M]  drivers/usb/storage/ums-cypress.ko
>   LD [M]  drivers/usb/storage/ums-datafab.ko
>   LD [M]  drivers/usb/storage/ums-freecom.ko
>   LD [M]  drivers/usb/storage/ums-isd200.ko
>   LD [M]  drivers/usb/storage/ums-jumpshot.ko
>   LD [M]  drivers/usb/storage/ums-karma.ko
>   LD [M]  drivers/usb/storage/ums-onetouch.ko
>   LD [M]  drivers/usb/storage/ums-sddr09.ko
>   LD [M]  drivers/usb/storage/ums-sddr55.ko
>   LD [M]  drivers/usb/storage/ums-usbat.ko
>   LD [M]  drivers/usb/storage/usb-storage.ko
>   LD [M]  drivers/usb/wusbcore/wusb-cbaf.ko
>   LD [M]  drivers/usb/wusbcore/wusb-wa.ko
>   LD [M]  drivers/usb/wusbcore/wusbcore.ko
>   LD [M]  drivers/uwb/hwa-rc.ko
>   LD [M]  drivers/uwb/i1480/dfu/i1480-dfu-usb.ko
>   LD [M]  drivers/uwb/i1480/i1480-est.ko
>   LD [M]  drivers/uwb/umc.ko
>   LD [M]  drivers/uwb/uwb.ko
>   LD [M]  drivers/uwb/whc-rc.ko
>   LD [M]  drivers/uwb/whci.ko
>   LD [M]  drivers/vhost/vhost_net.ko
>   LD [M]  drivers/video/aty/aty128fb.ko
>   LD [M]  drivers/video/aty/atyfb.ko
>   LD [M]  drivers/video/aty/radeonfb.ko
>   LD [M]  drivers/video/backlight/lcd.ko
>   LD [M]  drivers/video/backlight/platform_lcd.ko
>   LD [M]  drivers/video/cirrusfb.ko
>   LD [M]  drivers/video/fb_ddc.ko
>   LD [M]  drivers/video/fb_sys_fops.ko
>   LD [M]  drivers/video/macmodes.ko
>   LD [M]  drivers/video/nvidia/nvidiafb.ko
>   LD [M]  drivers/video/output.ko
>   LD [M]  drivers/video/riva/rivafb.ko
>   LD [M]  drivers/video/savage/savagefb.ko
>   LD [M]  drivers/video/sm501fb.ko
>   LD [M]  drivers/video/syscopyarea.ko
>   LD [M]  drivers/video/sysfillrect.ko
>   LD [M]  drivers/video/sysimgblt.ko
>   LD [M]  drivers/video/vfb.ko
>   LD [M]  drivers/video/vga16fb.ko
>   LD [M]  drivers/video/vgastate.ko
>   LD [M]  drivers/video/via/viafb.ko
>   LD [M]  drivers/virtio/virtio.ko
>   LD [M]  drivers/virtio/virtio_balloon.ko
>   LD [M]  drivers/virtio/virtio_pci.ko
>   LD [M]  drivers/virtio/virtio_ring.ko
>   LD [M]  drivers/watchdog/alim1535_wdt.ko
>   LD [M]  drivers/watchdog/alim7101_wdt.ko
>   LD [M]  drivers/watchdog/hpwdt.ko
>   LD [M]  drivers/watchdog/i6300esb.ko
>   LD [M]  drivers/watchdog/iTCO_vendor_support.ko
>   LD [M]  drivers/watchdog/iTCO_wdt.ko
>   LD [M]  drivers/watchdog/ib700wdt.ko
>   LD [M]  drivers/watchdog/ibmasr.ko
>   LD [M]  drivers/watchdog/ie6xx_wdt.ko
>   LD [M]  drivers/watchdog/it8712f_wdt.ko
>   LD [M]  drivers/watchdog/it87_wdt.ko
>   LD [M]  drivers/watchdog/machzwd.ko
>   LD [M]  drivers/watchdog/pcwd_pci.ko
>   LD [M]  drivers/watchdog/pcwd_usb.ko
>   LD [M]  drivers/watchdog/sbc_fitpc2_wdt.ko
>   LD [M]  drivers/watchdog/sch311x_wdt.ko
>   LD [M]  drivers/watchdog/softdog.ko
>   LD [M]  drivers/watchdog/w83627hf_wdt.ko
>   LD [M]  drivers/watchdog/w83697hf_wdt.ko
>   LD [M]  drivers/watchdog/w83697ug_wdt.ko
>   LD [M]  drivers/watchdog/w83877f_wdt.ko
>   LD [M]  drivers/watchdog/w83977f_wdt.ko
>   LD [M]  drivers/watchdog/wdt_pci.ko
>   LD [M]  fs/autofs4/autofs4.ko
>   LD [M]  fs/btrfs/btrfs.ko
>   LD [M]  fs/cachefiles/cachefiles.ko
>   LD [M]  fs/cifs/cifs.ko
>   LD [M]  fs/configfs/configfs.ko
>   LD [M]  fs/cramfs/cramfs.ko
>   LD [M]  fs/dlm/dlm.ko
>   LD [M]  fs/ecryptfs/ecryptfs.ko
>   LD [M]  fs/exofs/libore.ko
>   LD [M]  fs/exportfs/exportfs.ko
>   LD [M]  fs/ext2/ext2.ko
>   LD [M]  fs/ext3/ext3.ko
>   LD [M]  fs/ext4/ext4.ko
>   LD [M]  fs/fat/fat.ko
>   LD [M]  fs/fat/msdos.ko
>   LD [M]  fs/fat/vfat.ko
>   LD [M]  fs/fscache/fscache.ko
>   LD [M]  fs/fuse/cuse.ko
>   LD [M]  fs/fuse/fuse.ko
>   LD [M]  fs/gfs2/gfs2.ko
>   LD [M]  fs/jbd/jbd.ko
>   LD [M]  fs/jbd2/jbd2.ko
>   LD [M]  fs/jffs2/jffs2.ko
>   LD [M]  fs/lockd/lockd.ko
>   LD [M]  fs/mbcache.ko
>   LD [M]  fs/nfs/blocklayout/blocklayoutdriver.ko
>   LD [M]  fs/nfs/nfs.ko
>   LD [M]  fs/nfs/nfs_layout_nfsv41_files.ko
>   LD [M]  fs/nfs/nfsv2.ko
>   LD [M]  fs/nfs/nfsv3.ko
>   LD [M]  fs/nfs/nfsv4.ko
>   LD [M]  fs/nfs/objlayout/objlayoutdriver.ko
>   LD [M]  fs/nfs_common/nfs_acl.ko
>   LD [M]  fs/nfsd/nfsd.ko
>   LD [M]  fs/nls/nls_cp1250.ko
>   LD [M]  fs/nls/nls_cp1251.ko
>   LD [M]  fs/nls/nls_cp1255.ko
>   LD [M]  fs/nls/nls_cp737.ko
>   LD [M]  fs/nls/nls_cp775.ko
>   LD [M]  fs/nls/nls_cp850.ko
>   LD [M]  fs/nls/nls_cp852.ko
>   LD [M]  fs/nls/nls_cp855.ko
>   LD [M]  fs/nls/nls_cp857.ko
>   LD [M]  fs/nls/nls_cp860.ko
>   LD [M]  fs/nls/nls_cp862.ko
>   LD [M]  fs/nls/nls_cp861.ko
>   LD [M]  fs/nls/nls_cp863.ko
>   LD [M]  fs/nls/nls_cp864.ko
>   LD [M]  fs/nls/nls_cp865.ko
>   LD [M]  fs/nls/nls_cp866.ko
>   LD [M]  fs/nls/nls_cp874.ko
>   LD [M]  fs/nls/nls_cp869.ko
>   LD [M]  fs/nls/nls_cp932.ko
>   LD [M]  fs/nls/nls_cp936.ko
>   LD [M]  fs/nls/nls_cp949.ko
>   LD [M]  fs/nls/nls_cp950.ko
>   LD [M]  fs/nls/nls_euc-jp.ko
>   LD [M]  fs/nls/nls_iso8859-1.ko
>   LD [M]  fs/nls/nls_iso8859-13.ko
>   LD [M]  fs/nls/nls_iso8859-14.ko
>   LD [M]  fs/nls/nls_iso8859-15.ko
>   LD [M]  fs/nls/nls_iso8859-2.ko
>   LD [M]  fs/nls/nls_iso8859-3.ko
>   LD [M]  fs/nls/nls_iso8859-4.ko
>   LD [M]  fs/nls/nls_iso8859-5.ko
>   LD [M]  fs/nls/nls_iso8859-6.ko
>   LD [M]  fs/nls/nls_iso8859-7.ko
>   LD [M]  fs/nls/nls_iso8859-9.ko
>   LD [M]  fs/nls/nls_koi8-r.ko
>   LD [M]  fs/nls/nls_koi8-ru.ko
>   LD [M]  fs/nls/nls_koi8-u.ko
>   LD [M]  fs/nls/nls_utf8.ko
>   LD [M]  fs/squashfs/squashfs.ko
>   LD [M]  fs/ubifs/ubifs.ko
>   LD [M]  fs/udf/udf.ko
>   LD [M]  fs/xfs/xfs.ko
>   LD [M]  kernel/trace/ring_buffer_benchmark.ko
>   LD [M]  lib/cordic.ko
>   LD [M]  lib/crc-ccitt.ko
>   LD [M]  lib/crc-itu-t.ko
>   LD [M]  lib/crc-t10dif.ko
>   LD [M]  lib/crc7.ko
>   LD [M]  lib/crc8.ko
>   LD [M]  lib/libcrc32c.ko
>   LD [M]  lib/raid6/raid6_pq.ko
>   LD [M]  lib/reed_solomon/reed_solomon.ko
>   LD [M]  lib/ts_bm.ko
>   LD [M]  lib/ts_fsm.ko
>   LD [M]  lib/ts_kmp.ko
>   LD [M]  lib/zlib_deflate/zlib_deflate.ko
>   LD [M]  net/802/garp.ko
>   LD [M]  net/802/p8022.ko
>   LD [M]  net/802/psnap.ko
>   LD [M]  net/802/stp.ko
>   LD [M]  net/8021q/8021q.ko
>   LD [M]  net/9p/9pnet.ko
>   LD [M]  net/9p/9pnet_rdma.ko
>   LD [M]  net/9p/9pnet_virtio.ko
>   LD [M]  net/atm/atm.ko
>   LD [M]  net/atm/br2684.ko
>   LD [M]  net/atm/clip.ko
>   LD [M]  net/atm/lec.ko
>   LD [M]  net/atm/pppoatm.ko
>   LD [M]  net/bluetooth/bluetooth.ko
>   LD [M]  net/bluetooth/bnep/bnep.ko
>   LD [M]  net/bluetooth/cmtp/cmtp.ko
>   LD [M]  net/bluetooth/hidp/hidp.ko
>   LD [M]  net/bluetooth/rfcomm/rfcomm.ko
>   LD [M]  net/bridge/bridge.ko
>   LD [M]  net/bridge/netfilter/ebt_802_3.ko
>   LD [M]  net/bridge/netfilter/ebt_among.ko
>   LD [M]  net/bridge/netfilter/ebt_arp.ko
>   LD [M]  net/bridge/netfilter/ebt_arpreply.ko
>   LD [M]  net/bridge/netfilter/ebt_dnat.ko
>   LD [M]  net/bridge/netfilter/ebt_ip6.ko
>   LD [M]  net/bridge/netfilter/ebt_ip.ko
>   LD [M]  net/bridge/netfilter/ebt_limit.ko
>   LD [M]  net/bridge/netfilter/ebt_log.ko
>   LD [M]  net/bridge/netfilter/ebt_mark.ko
>   LD [M]  net/bridge/netfilter/ebt_mark_m.ko
>   LD [M]  net/bridge/netfilter/ebt_pkttype.ko
>   LD [M]  net/bridge/netfilter/ebt_redirect.ko
>   LD [M]  net/bridge/netfilter/ebt_nflog.ko
>   LD [M]  net/bridge/netfilter/ebt_snat.ko
>   LD [M]  net/bridge/netfilter/ebt_stp.ko
>   LD [M]  net/bridge/netfilter/ebt_ulog.ko
>   LD [M]  net/bridge/netfilter/ebt_vlan.ko
>   LD [M]  net/bridge/netfilter/ebtable_broute.ko
>   LD [M]  net/bridge/netfilter/ebtable_filter.ko
>   LD [M]  net/bridge/netfilter/ebtables.ko
>   LD [M]  net/bridge/netfilter/ebtable_nat.ko
>   LD [M]  net/can/can-bcm.ko
>   LD [M]  net/can/can-raw.ko
>   LD [M]  net/can/can.ko
>   LD [M]  net/core/pktgen.ko
>   LD [M]  net/dccp/dccp.ko
>   LD [M]  net/dccp/dccp_diag.ko
>   LD [M]  net/dccp/dccp_ipv4.ko
>   LD [M]  net/dccp/dccp_ipv6.ko
>   LD [M]  net/dns_resolver/dns_resolver.ko
>   LD [M]  net/ieee802154/af_802154.ko
>   LD [M]  net/ieee802154/ieee802154.ko
>   LD [M]  net/ipv4/esp4.ko
>   LD [M]  net/ipv4/ah4.ko
>   LD [M]  net/ipv4/inet_diag.ko
>   LD [M]  net/ipv4/ip_gre.ko
>   LD [M]  net/ipv4/ipcomp.ko
>   LD [M]  net/ipv4/ipip.ko
>   LD [M]  net/ipv4/netfilter/arp_tables.ko
>   LD [M]  net/ipv4/netfilter/arpt_mangle.ko
>   LD [M]  net/ipv4/netfilter/arptable_filter.ko
>   LD [M]  net/ipv4/netfilter/ip_tables.ko
>   LD [M]  net/ipv4/netfilter/ipt_CLUSTERIP.ko
>   LD [M]  net/ipv4/netfilter/ipt_ECN.ko
>   LD [M]  net/ipv4/netfilter/ipt_ULOG.ko
>   LD [M]  net/ipv4/netfilter/ipt_REJECT.ko
>   LD [M]  net/ipv4/netfilter/ipt_ah.ko
>   LD [M]  net/ipv4/netfilter/iptable_filter.ko
>   LD [M]  net/ipv4/netfilter/iptable_mangle.ko
>   LD [M]  net/ipv4/netfilter/iptable_raw.ko
>   LD [M]  net/ipv4/netfilter/iptable_security.ko
>   LD [M]  net/ipv4/netfilter/nf_conntrack_ipv4.ko
>   LD [M]  net/ipv4/netfilter/nf_defrag_ipv4.ko
>   LD [M]  net/ipv4/tcp_bic.ko
>   LD [M]  net/ipv4/tcp_diag.ko
>   LD [M]  net/ipv4/tcp_htcp.ko
>   LD [M]  net/ipv4/tcp_highspeed.ko
>   LD [M]  net/ipv4/tcp_hybla.ko
>   LD [M]  net/ipv4/tcp_illinois.ko
>   LD [M]  net/ipv4/tcp_lp.ko
>   LD [M]  net/ipv4/tcp_scalable.ko
>   LD [M]  net/ipv4/tcp_vegas.ko
>   LD [M]  net/ipv4/tcp_veno.ko
>   LD [M]  net/ipv4/tcp_westwood.ko
>   LD [M]  net/ipv4/tcp_yeah.ko
>   LD [M]  net/ipv4/tunnel4.ko
>   LD [M]  net/ipv4/xfrm4_mode_beet.ko
>   LD [M]  net/ipv4/xfrm4_mode_transport.ko
>   LD [M]  net/ipv4/xfrm4_mode_tunnel.ko
>   LD [M]  net/ipv4/xfrm4_tunnel.ko
>   LD [M]  net/ipv6/ah6.ko
>   LD [M]  net/ipv6/esp6.ko
>   LD [M]  net/ipv6/ip6_tunnel.ko
>   LD [M]  net/ipv6/ipcomp6.ko
>   LD [M]  net/ipv6/ipv6.ko
>   LD [M]  net/ipv6/mip6.ko
>   LD [M]  net/ipv6/netfilter/ip6_tables.ko
>   LD [M]  net/ipv6/netfilter/ip6t_REJECT.ko
>   LD [M]  net/ipv6/netfilter/ip6t_ah.ko
>   LD [M]  net/ipv6/netfilter/ip6t_eui64.ko
>   LD [M]  net/ipv6/netfilter/ip6t_frag.ko
>   LD [M]  net/ipv6/netfilter/ip6t_hbh.ko
>   LD [M]  net/ipv6/netfilter/ip6t_ipv6header.ko
>   LD [M]  net/ipv6/netfilter/ip6t_mh.ko
>   LD [M]  net/ipv6/netfilter/ip6t_rt.ko
>   LD [M]  net/ipv6/netfilter/ip6table_filter.ko
>   LD [M]  net/ipv6/netfilter/ip6table_mangle.ko
>   LD [M]  net/ipv6/netfilter/ip6table_raw.ko
>   LD [M]  net/ipv6/netfilter/ip6table_security.ko
>   LD [M]  net/ipv6/netfilter/nf_conntrack_ipv6.ko
>   LD [M]  net/ipv6/netfilter/nf_defrag_ipv6.ko
>   LD [M]  net/ipv6/sit.ko
>   LD [M]  net/ipv6/tunnel6.ko
>   LD [M]  net/ipv6/xfrm6_mode_beet.ko
>   LD [M]  net/ipv6/xfrm6_mode_ro.ko
>   LD [M]  net/ipv6/xfrm6_mode_transport.ko
>   LD [M]  net/ipv6/xfrm6_mode_tunnel.ko
>   LD [M]  net/ipv6/xfrm6_tunnel.ko
>   LD [M]  net/key/af_key.ko
>   LD [M]  net/llc/llc.ko
>   LD [M]  net/mac80211/mac80211.ko
>   LD [M]  net/netfilter/ipset/ip_set_bitmap_ip.ko
>   LD [M]  net/netfilter/ipset/ip_set.ko
>   LD [M]  net/netfilter/ipset/ip_set_bitmap_ipmac.ko
>   LD [M]  net/netfilter/ipset/ip_set_bitmap_port.ko
>   LD [M]  net/netfilter/ipset/ip_set_hash_ip.ko
>   LD [M]  net/netfilter/ipset/ip_set_hash_ipport.ko
>   LD [M]  net/netfilter/ipset/ip_set_hash_ipportip.ko
>   LD [M]  net/netfilter/ipset/ip_set_hash_ipportnet.ko
>   LD [M]  net/netfilter/ipset/ip_set_hash_net.ko
>   LD [M]  net/netfilter/ipset/ip_set_hash_netport.ko
>   LD [M]  net/netfilter/ipset/ip_set_list_set.ko
>   LD [M]  net/netfilter/ipvs/ip_vs_dh.ko
>   LD [M]  net/netfilter/ipvs/ip_vs.ko
>   LD [M]  net/netfilter/ipvs/ip_vs_lblc.ko
>   LD [M]  net/netfilter/ipvs/ip_vs_lblcr.ko
>   LD [M]  net/netfilter/ipvs/ip_vs_lc.ko
>   LD [M]  net/netfilter/ipvs/ip_vs_nq.ko
>   LD [M]  net/netfilter/ipvs/ip_vs_pe_sip.ko
>   LD [M]  net/netfilter/ipvs/ip_vs_rr.ko
>   LD [M]  net/netfilter/ipvs/ip_vs_sh.ko
>   LD [M]  net/netfilter/ipvs/ip_vs_sed.ko
>   LD [M]  net/netfilter/ipvs/ip_vs_wlc.ko
>   LD [M]  net/netfilter/ipvs/ip_vs_wrr.ko
>   LD [M]  net/netfilter/nf_conntrack.ko
>   LD [M]  net/netfilter/nf_conntrack_amanda.ko
>   LD [M]  net/netfilter/nf_conntrack_broadcast.ko
>   LD [M]  net/netfilter/nf_conntrack_ftp.ko
>   LD [M]  net/netfilter/nf_conntrack_h323.ko
>   LD [M]  net/netfilter/nf_conntrack_irc.ko
>   LD [M]  net/netfilter/nf_conntrack_netbios_ns.ko
>   LD [M]  net/netfilter/nf_conntrack_netlink.ko
>   LD [M]  net/netfilter/nf_conntrack_pptp.ko
>   LD [M]  net/netfilter/nf_conntrack_proto_dccp.ko
>   LD [M]  net/netfilter/nf_conntrack_proto_gre.ko
>   LD [M]  net/netfilter/nf_conntrack_proto_sctp.ko
>   LD [M]  net/netfilter/nf_conntrack_proto_udplite.ko
>   LD [M]  net/netfilter/nf_conntrack_sane.ko
>   LD [M]  net/netfilter/nf_conntrack_sip.ko
>   LD [M]  net/netfilter/nf_conntrack_snmp.ko
>   LD [M]  net/netfilter/nf_conntrack_tftp.ko
>   LD [M]  net/netfilter/nf_tproxy_core.ko
>   LD [M]  net/netfilter/nfnetlink.ko
>   LD [M]  net/netfilter/nfnetlink_queue.ko
>   LD [M]  net/netfilter/nfnetlink_log.ko
>   LD [M]  net/netfilter/xt_AUDIT.ko
>   LD [M]  net/netfilter/xt_CHECKSUM.ko
>   LD [M]  net/netfilter/xt_CLASSIFY.ko
>   LD [M]  net/netfilter/xt_CONNSECMARK.ko
>   LD [M]  net/netfilter/xt_CT.ko
>   LD [M]  net/netfilter/xt_DSCP.ko
>   LD [M]  net/netfilter/xt_HL.ko
>   LD [M]  net/netfilter/xt_LED.ko
>   LD [M]  net/netfilter/xt_NFLOG.ko
>   LD [M]  net/netfilter/xt_NFQUEUE.ko
>   LD [M]  net/netfilter/xt_RATEEST.ko
>   LD [M]  net/netfilter/xt_SECMARK.ko
>   LD [M]  net/netfilter/xt_TCPMSS.ko
>   LD [M]  net/netfilter/xt_TCPOPTSTRIP.ko
>   LD [M]  net/netfilter/xt_TPROXY.ko
>   LD [M]  net/netfilter/xt_TRACE.ko
>   LD [M]  net/netfilter/xt_cluster.ko
>   LD [M]  net/netfilter/xt_comment.ko
>   LD [M]  net/netfilter/xt_connbytes.ko
>   LD [M]  net/netfilter/xt_connlimit.ko
>   LD [M]  net/netfilter/xt_connmark.ko
>   LD [M]  net/netfilter/xt_conntrack.ko
>   LD [M]  net/netfilter/xt_dccp.ko
>   LD [M]  net/netfilter/xt_dscp.ko
>   LD [M]  net/netfilter/xt_ecn.ko
>   LD [M]  net/netfilter/xt_esp.ko
>   LD [M]  net/netfilter/xt_hashlimit.ko
>   LD [M]  net/netfilter/xt_helper.ko
>   LD [M]  net/netfilter/xt_hl.ko
>   LD [M]  net/netfilter/xt_iprange.ko
>   LD [M]  net/netfilter/xt_length.ko
>   LD [M]  net/netfilter/xt_limit.ko
>   LD [M]  net/netfilter/xt_mac.ko
>   LD [M]  net/netfilter/xt_mark.ko
>   LD [M]  net/netfilter/xt_multiport.ko
>   LD [M]  net/netfilter/xt_osf.ko
>   LD [M]  net/netfilter/xt_owner.ko
>   LD [M]  net/netfilter/xt_physdev.ko
>   LD [M]  net/netfilter/xt_pkttype.ko
>   LD [M]  net/netfilter/xt_policy.ko
>   LD [M]  net/netfilter/xt_quota.ko
>   LD [M]  net/netfilter/xt_rateest.ko
>   LD [M]  net/netfilter/xt_realm.ko
>   LD [M]  net/netfilter/xt_recent.ko
>   LD [M]  net/netfilter/xt_sctp.ko
>   LD [M]  net/netfilter/xt_set.ko
>   LD [M]  net/netfilter/xt_socket.ko
>   LD [M]  net/netfilter/xt_state.ko
>   LD [M]  net/netfilter/xt_statistic.ko
>   LD [M]  net/netfilter/xt_string.ko
>   LD [M]  net/netfilter/xt_tcpmss.ko
>   LD [M]  net/netfilter/xt_time.ko
>   LD [M]  net/netfilter/xt_u32.ko
>   LD [M]  net/openvswitch/openvswitch.ko
>   LD [M]  net/phonet/phonet.ko
>   LD [M]  net/phonet/pn_pep.ko
>   LD [M]  net/rds/rds.ko
>   LD [M]  net/rds/rds_rdma.ko
>   LD [M]  net/rds/rds_tcp.ko
>   LD [M]  net/rfkill/rfkill.ko
>   LD [M]  net/sched/act_gact.ko
>   LD [M]  net/sched/act_ipt.ko
>   LD [M]  net/sched/act_mirred.ko
>   LD [M]  net/sched/act_nat.ko
>   LD [M]  net/sched/act_pedit.ko
>   LD [M]  net/sched/act_police.ko
>   LD [M]  net/sched/act_simple.ko
>   LD [M]  net/sched/act_skbedit.ko
>   LD [M]  net/sched/cls_basic.ko
>   LD [M]  net/sched/cls_flow.ko
>   LD [M]  net/sched/cls_fw.ko
>   LD [M]  net/sched/cls_route.ko
>   LD [M]  net/sched/cls_rsvp.ko
>   LD [M]  net/sched/cls_rsvp6.ko
>   LD [M]  net/sched/cls_tcindex.ko
>   LD [M]  net/sched/cls_u32.ko
>   LD [M]  net/sched/em_cmp.ko
>   LD [M]  net/sched/em_meta.ko
>   LD [M]  net/sched/em_nbyte.ko
>   LD [M]  net/sched/em_text.ko
>   LD [M]  net/sched/em_u32.ko
>   LD [M]  net/sched/sch_atm.ko
>   LD [M]  net/sched/sch_cbq.ko
>   LD [M]  net/sched/sch_drr.ko
>   LD [M]  net/sched/sch_dsmark.ko
>   LD [M]  net/sched/sch_gred.ko
>   LD [M]  net/sched/sch_hfsc.ko
>   LD [M]  net/sched/sch_htb.ko
>   LD [M]  net/sched/sch_ingress.ko
>   LD [M]  net/sched/sch_mqprio.ko
>   LD [M]  net/sched/sch_multiq.ko
>   LD [M]  net/sched/sch_netem.ko
>   LD [M]  net/sched/sch_prio.ko
>   LD [M]  net/sched/sch_qfq.ko
>   LD [M]  net/sched/sch_red.ko
>   LD [M]  net/sched/sch_sfq.ko
>   LD [M]  net/sched/sch_tbf.ko
>   LD [M]  net/sched/sch_teql.ko
>   LD [M]  net/sctp/sctp.ko
>   LD [M]  net/sunrpc/auth_gss/auth_rpcgss.ko
>   LD [M]  net/sunrpc/auth_gss/rpcsec_gss_krb5.ko
>   LD [M]  net/sunrpc/sunrpc.ko
>   LD [M]  net/sunrpc/xprtrdma/svcrdma.ko
>   LD [M]  net/sunrpc/xprtrdma/xprtrdma.ko
>   LD [M]  net/wimax/wimax.ko
>   LD [M]  net/wireless/cfg80211.ko
>   LD [M]  net/wireless/lib80211.ko
>   LD [M]  net/wireless/lib80211_crypt_ccmp.ko
>   LD [M]  net/wireless/lib80211_crypt_tkip.ko
>   LD [M]  net/wireless/lib80211_crypt_wep.ko
>   LD [M]  net/xfrm/xfrm_ipcomp.ko
>   LD [M]  sound/ac97_bus.ko
>   LD [M]  sound/core/oss/snd-mixer-oss.ko
>   LD [M]  sound/core/oss/snd-pcm-oss.ko
>   LD [M]  sound/core/seq/oss/snd-seq-oss.ko
>   LD [M]  sound/core/seq/snd-seq-device.ko
>   LD [M]  sound/core/seq/snd-seq-dummy.ko
>   LD [M]  sound/core/seq/snd-seq-midi-emul.ko
>   LD [M]  sound/core/seq/snd-seq-midi-event.ko
>   LD [M]  sound/core/seq/snd-seq-midi.ko
>   LD [M]  sound/core/seq/snd-seq-virmidi.ko
>   LD [M]  sound/core/seq/snd-seq.ko
>   LD [M]  sound/core/snd-hrtimer.ko
>   LD [M]  sound/core/snd-hwdep.ko
>   LD [M]  sound/core/snd-page-alloc.ko
>   LD [M]  sound/core/snd-pcm.ko
>   LD [M]  sound/core/snd-rawmidi.ko
>   LD [M]  sound/core/snd-timer.ko
>   LD [M]  sound/core/snd.ko
>   LD [M]  sound/drivers/mpu401/snd-mpu401-uart.ko
>   LD [M]  sound/drivers/mpu401/snd-mpu401.ko
>   LD [M]  sound/drivers/opl3/snd-opl3-lib.ko
>   LD [M]  sound/drivers/opl3/snd-opl3-synth.ko
>   LD [M]  sound/drivers/pcsp/snd-pcsp.ko
>   LD [M]  sound/drivers/snd-aloop.ko
>   LD [M]  sound/drivers/snd-dummy.ko
>   LD [M]  sound/drivers/snd-mtpav.ko
>   LD [M]  sound/drivers/snd-virmidi.ko
>   LD [M]  sound/drivers/vx/snd-vx-lib.ko
>   LD [M]  sound/i2c/other/snd-ak4113.ko
>   LD [M]  sound/i2c/other/snd-ak4114.ko
>   LD [M]  sound/i2c/other/snd-pt2258.ko
>   LD [M]  sound/i2c/snd-cs8427.ko
>   LD [M]  sound/i2c/other/snd-ak4xxx-adda.ko
>   LD [M]  sound/isa/sb/snd-sb-common.ko
>   LD [M]  sound/i2c/snd-i2c.ko
>   LD [M]  sound/isa/sb/snd-sb16-dsp.ko
>   LD [M]  sound/pci/ac97/snd-ac97-codec.ko
>   LD [M]  sound/pci/au88x0/snd-au8810.ko
>   LD [M]  sound/pci/ali5451/snd-ali5451.ko
>   LD [M]  sound/pci/au88x0/snd-au8820.ko
>   LD [M]  sound/pci/au88x0/snd-au8830.ko
>   LD [M]  sound/pci/ca0106/snd-ca0106.ko
>   LD [M]  sound/pci/cs46xx/snd-cs46xx.ko
>   LD [M]  sound/pci/cs5535audio/snd-cs5535audio.ko
>   LD [M]  sound/pci/ctxfi/snd-ctxfi.ko
>   LD [M]  sound/pci/echoaudio/snd-darla20.ko
>   LD [M]  sound/pci/echoaudio/snd-darla24.ko
>   LD [M]  sound/pci/echoaudio/snd-echo3g.ko
>   LD [M]  sound/pci/echoaudio/snd-gina20.ko
>   LD [M]  sound/pci/echoaudio/snd-gina24.ko
>   LD [M]  sound/pci/echoaudio/snd-indigo.ko
>   LD [M]  sound/pci/echoaudio/snd-indigodj.ko
>   LD [M]  sound/pci/echoaudio/snd-indigodjx.ko
>   LD [M]  sound/pci/echoaudio/snd-indigoio.ko
>   LD [M]  sound/pci/echoaudio/snd-indigoiox.ko
>   LD [M]  sound/pci/echoaudio/snd-layla20.ko
>   LD [M]  sound/pci/echoaudio/snd-layla24.ko
>   LD [M]  sound/pci/echoaudio/snd-mia.ko
>   LD [M]  sound/pci/echoaudio/snd-mona.ko
>   LD [M]  sound/pci/emu10k1/snd-emu10k1-synth.ko
>   LD [M]  sound/pci/emu10k1/snd-emu10k1.ko
>   LD [M]  sound/pci/emu10k1/snd-emu10k1x.ko
>   LD [M]  sound/pci/hda/snd-hda-codec-analog.ko
>   LD [M]  sound/pci/hda/snd-hda-codec-ca0110.ko
>   LD [M]  sound/pci/hda/snd-hda-codec-ca0132.ko
>   LD [M]  sound/pci/hda/snd-hda-codec-cirrus.ko
>   LD [M]  sound/pci/hda/snd-hda-codec-cmedia.ko
>   LD [M]  sound/pci/hda/snd-hda-codec-conexant.ko
>   LD [M]  sound/pci/hda/snd-hda-codec-hdmi.ko
>   LD [M]  sound/pci/hda/snd-hda-codec-idt.ko
>   LD [M]  sound/pci/hda/snd-hda-codec-realtek.ko
>   LD [M]  sound/pci/hda/snd-hda-codec-si3054.ko
>   LD [M]  sound/pci/hda/snd-hda-codec-via.ko
>   LD [M]  sound/pci/hda/snd-hda-codec.ko
>   LD [M]  sound/pci/hda/snd-hda-intel.ko
>   LD [M]  sound/pci/ice1712/snd-ice1712.ko
>   LD [M]  sound/pci/ice1712/snd-ice1724.ko
>   LD [M]  sound/pci/ice1712/snd-ice17xx-ak4xxx.ko
>   LD [M]  sound/pci/korg1212/snd-korg1212.ko
>   LD [M]  sound/pci/lx6464es/snd-lx6464es.ko
>   LD [M]  sound/pci/mixart/snd-mixart.ko
>   LD [M]  sound/pci/oxygen/snd-oxygen-lib.ko
>   LD [M]  sound/pci/oxygen/snd-oxygen.ko
>   LD [M]  sound/pci/oxygen/snd-virtuoso.ko
>   LD [M]  sound/pci/pcxhr/snd-pcxhr.ko
>   LD [M]  sound/pci/rme9652/snd-hdsp.ko
>   LD [M]  sound/pci/rme9652/snd-hdspm.ko
>   LD [M]  sound/pci/rme9652/snd-rme9652.ko
>   LD [M]  sound/pci/snd-ad1889.ko
>   LD [M]  sound/pci/snd-atiixp-modem.ko
>   LD [M]  sound/pci/snd-atiixp.ko
>   LD [M]  sound/pci/snd-bt87x.ko
>   LD [M]  sound/pci/snd-cmipci.ko
>   LD [M]  sound/pci/snd-cs5530.ko
>   LD [M]  sound/pci/snd-ens1370.ko
>   LD [M]  sound/pci/snd-ens1371.ko
>   LD [M]  sound/pci/snd-es1968.ko
>   LD [M]  sound/pci/snd-intel8x0.ko
>   LD [M]  sound/pci/snd-intel8x0m.ko
>   LD [M]  sound/pci/snd-maestro3.ko
>   LD [M]  sound/pci/snd-rme32.ko
>   LD [M]  sound/pci/snd-rme96.ko
>   LD [M]  sound/pci/snd-via82xx-modem.ko
>   LD [M]  sound/pci/snd-via82xx.ko
>   LD [M]  sound/pci/trident/snd-trident.ko
>   LD [M]  sound/pci/vx222/snd-vx222.ko
>   LD [M]  sound/soundcore.ko
>   LD [M]  sound/synth/emux/snd-emux-synth.ko
>   LD [M]  sound/synth/snd-util-mem.ko
>   LD [M]  sound/usb/6fire/snd-usb-6fire.ko
>   LD [M]  sound/usb/caiaq/snd-usb-caiaq.ko
>   LD [M]  sound/usb/misc/snd-ua101.ko
>   LD [M]  sound/usb/snd-usb-audio.ko
>   LD [M]  sound/usb/snd-usbmidi-lib.ko
>   LD [M]  sound/usb/usx2y/snd-usb-us122l.ko
>   LD [M]  sound/usb/usx2y/snd-usb-usx2y.ko
>   IHEX    firmware/acenic/tg1.bin
>   IHEX    firmware/acenic/tg2.bin
>   IHEX    firmware/adaptec/starfire_rx.bin
>   IHEX    firmware/adaptec/starfire_tx.bin
>   IHEX    firmware/bnx2x/bnx2x-e1-6.2.9.0.fw
>   IHEX    firmware/bnx2x/bnx2x-e1h-6.2.9.0.fw
>   IHEX    firmware/bnx2x/bnx2x-e2-6.2.9.0.fw
>   IHEX    firmware/bnx2/bnx2-rv2p-09-6.0.17.fw
>   IHEX    firmware/bnx2/bnx2-mips-09-6.2.1a.fw
>   IHEX    firmware/bnx2/bnx2-rv2p-09ax-6.0.17.fw
>   IHEX    firmware/bnx2/bnx2-mips-06-6.2.1.fw
>   IHEX    firmware/bnx2/bnx2-rv2p-06-6.0.15.fw
>   IHEX    firmware/sun/cassini.bin
>   IHEX    firmware/cxgb3/t3b_psram-1.1.0.bin
>   IHEX    firmware/cxgb3/ael2005_opt_edc.bin
>   IHEX    firmware/cxgb3/t3c_psram-1.1.0.bin
>   IHEX    firmware/cxgb3/ael2005_twx_edc.bin
>   IHEX    firmware/cxgb3/ael2020_twx_edc.bin
>   HOSTCC  firmware/ihex2fw
>   IHEX    firmware/r128/r128_cce.bin
>   IHEX    firmware/radeon/R100_cp.bin
>   IHEX    firmware/radeon/R200_cp.bin
>   IHEX    firmware/radeon/R300_cp.bin
>   IHEX    firmware/radeon/R420_cp.bin
>   IHEX    firmware/radeon/RS690_cp.bin
>   IHEX    firmware/radeon/RS600_cp.bin
>   IHEX    firmware/radeon/R520_cp.bin
>   IHEX    firmware/radeon/R600_pfp.bin
>   IHEX    firmware/radeon/R600_me.bin
>   IHEX    firmware/radeon/RV610_me.bin
>   IHEX    firmware/radeon/RV610_pfp.bin
>   IHEX    firmware/radeon/RV630_pfp.bin
>   IHEX    firmware/radeon/RV630_me.bin
>   IHEX    firmware/radeon/RV620_me.bin
>   IHEX    firmware/radeon/RV620_pfp.bin
>   IHEX    firmware/radeon/RV635_pfp.bin
>   IHEX    firmware/radeon/RV635_me.bin
>   IHEX    firmware/radeon/RV670_pfp.bin
>   IHEX    firmware/radeon/RV670_me.bin
>   IHEX    firmware/radeon/RS780_pfp.bin
>   IHEX    firmware/radeon/RS780_me.bin
>   IHEX    firmware/radeon/RV770_me.bin
>   IHEX    firmware/radeon/RV770_pfp.bin
>   IHEX    firmware/radeon/RV730_pfp.bin
>   IHEX    firmware/radeon/RV730_me.bin
>   IHEX    firmware/radeon/RV710_pfp.bin
>   IHEX    firmware/e100/d101m_ucode.bin
>   IHEX    firmware/radeon/RV710_me.bin
>   IHEX    firmware/e100/d101s_ucode.bin
>   IHEX    firmware/e100/d102e_ucode.bin
>   IHEX    firmware/cis/LA-PCM.cis
>   IHEX    firmware/cis/PCMLM28.cis
>   IHEX    firmware/cis/NE2K.cis
>   IHEX    firmware/cis/DP83903.cis
>   IHEX    firmware/cis/tamarack.cis
>   IHEX    firmware/cis/PE-200.cis
>   IHEX    firmware/cis/PE520.cis
>   IHEX    firmware/cis/3CXEM556.cis
>   IHEX    firmware/cis/3CCFEM556.cis
>   IHEX    firmware/cis/MT5634ZLX.cis
>   IHEX    firmware/cis/RS-COM-2P.cis
>   IHEX    firmware/cis/COMpad2.cis
>   IHEX    firmware/cis/COMpad4.cis
>   IHEX    firmware/cis/SW_555_SER.cis
>   IHEX    firmware/cis/SW_7xx_SER.cis
>   IHEX    firmware/cis/SW_8xx_SER.cis
>   IHEX    firmware/ositech/Xilinx7OD.bin
>   IHEX    firmware/qlogic/sd7220.fw
>   IHEX    firmware/korg/k1212.dsp
>   IHEX    firmware/ess/maestro3_assp_kernel.fw
>   IHEX    firmware/ess/maestro3_assp_minisrc.fw
>   IHEX    firmware/tehuti/bdx.bin
>   IHEX    firmware/tigon/tg3.bin
>   IHEX    firmware/tigon/tg3_tso.bin
>   IHEX    firmware/tigon/tg3_tso5.bin
>   IHEX    firmware/3com/typhoon.bin
>   IHEX    firmware/kaweth/new_code.bin
>   IHEX    firmware/kaweth/trigger_code.bin
>   IHEX    firmware/kaweth/new_code_fix.bin
>   IHEX    firmware/kaweth/trigger_code_fix.bin
>   IHEX    firmware/ti_3410.fw
>   IHEX    firmware/ti_5052.fw
>   IHEX    firmware/mts_gsm.fw
>   IHEX    firmware/mts_cdma.fw
>   IHEX    firmware/mts_edge.fw
>   IHEX    firmware/edgeport/down3.bin
>   H16TOFW firmware/matrox/g400_warp.fw
>   H16TOFW firmware/matrox/g200_warp.fw
>   IHEX2FW firmware/emi26/loader.fw
>   IHEX2FW firmware/emi26/firmware.fw
>   IHEX2FW firmware/emi26/bitstream.fw
>   IHEX2FW firmware/emi62/loader.fw
>   IHEX2FW firmware/emi62/bitstream.fw
>   IHEX2FW firmware/emi62/spdif.fw
>   IHEX2FW firmware/emi62/midi.fw
>   H16TOFW firmware/edgeport/boot.fw
>   H16TOFW firmware/edgeport/boot2.fw
>   H16TOFW firmware/edgeport/down.fw
>   IHEX2FW firmware/whiteheat_loader.fw
>   H16TOFW firmware/edgeport/down2.fw
>   IHEX2FW firmware/whiteheat.fw
>   IHEX2FW firmware/keyspan_pda/keyspan_pda.fw
>   IHEX2FW firmware/keyspan_pda/xircom_pgs.fw
> make[1]: Nothing to be done for `all'.
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[1]: Nothing to be done for `relocs'.
>   CALL    scripts/checksyscalls.sh
>   Building modules, stage 2.
>   MODPOST 1550 modules
>   INSTALL arch/x86/crypto/ablk_helper.ko
>   INSTALL arch/x86/crypto/aes-x86_64.ko
>   INSTALL arch/x86/crypto/aesni-intel.ko
>   INSTALL arch/x86/crypto/crc32c-intel.ko
>   INSTALL arch/x86/crypto/ghash-clmulni-intel.ko
>   INSTALL arch/x86/crypto/salsa20-x86_64.ko
>   INSTALL arch/x86/crypto/twofish-x86_64.ko
>   INSTALL arch/x86/kernel/cpu/mcheck/mce-inject.ko
>   INSTALL arch/x86/kernel/microcode.ko
>   INSTALL arch/x86/kvm/kvm-amd.ko
>   INSTALL arch/x86/kvm/kvm-intel.ko
>   INSTALL arch/x86/kvm/kvm.ko
>   INSTALL arch/x86/oprofile/oprofile.ko
>   INSTALL crypto/ansi_cprng.ko
>   INSTALL crypto/anubis.ko
>   INSTALL crypto/arc4.ko
>   INSTALL crypto/async_tx/async_memcpy.ko
>   INSTALL crypto/async_tx/async_pq.ko
>   INSTALL crypto/async_tx/async_raid6_recov.ko
>   INSTALL crypto/async_tx/async_tx.ko
>   INSTALL crypto/async_tx/async_xor.ko
>   INSTALL crypto/async_tx/raid6test.ko
>   INSTALL crypto/authenc.ko
>   INSTALL crypto/authencesn.ko
>   INSTALL crypto/blowfish_common.ko
>   INSTALL crypto/blowfish_generic.ko
>   INSTALL crypto/camellia_generic.ko
>   INSTALL crypto/cast5_generic.ko
>   INSTALL crypto/cast6_generic.ko
>   INSTALL crypto/cast_common.ko
>   INSTALL crypto/cbc.ko
>   INSTALL crypto/ccm.ko
>   INSTALL crypto/cryptd.ko
>   INSTALL crypto/crypto_null.ko
>   INSTALL crypto/ctr.ko
>   INSTALL crypto/cts.ko
>   INSTALL crypto/deflate.ko
>   INSTALL crypto/des_generic.ko
>   INSTALL crypto/ecb.ko
>   INSTALL crypto/fcrypt.ko
>   INSTALL crypto/gcm.ko
>   INSTALL crypto/gf128mul.ko
>   INSTALL crypto/ghash-generic.ko
>   INSTALL crypto/khazad.ko
>   INSTALL crypto/lrw.ko
>   INSTALL crypto/lzo.ko
>   INSTALL crypto/md4.ko
>   INSTALL crypto/michael_mic.ko
>   INSTALL crypto/pcbc.ko
>   INSTALL crypto/rmd128.ko
>   INSTALL crypto/rmd160.ko
>   INSTALL crypto/rmd256.ko
>   INSTALL crypto/rmd320.ko
>   INSTALL crypto/seed.ko
>   INSTALL crypto/seqiv.ko
>   INSTALL crypto/serpent_generic.ko
>   INSTALL crypto/sha512_generic.ko
>   INSTALL crypto/tcrypt.ko
>   INSTALL crypto/tea.ko
>   INSTALL crypto/tgr192.ko
>   INSTALL crypto/twofish_common.ko
>   INSTALL crypto/vmac.ko
>   INSTALL crypto/wp512.ko
>   INSTALL crypto/xcbc.ko
>   INSTALL crypto/xor.ko
>   INSTALL crypto/xts.ko
>   INSTALL crypto/zlib.ko
>   INSTALL drivers/acpi/acpi_i2c.ko
>   INSTALL drivers/acpi/acpi_ipmi.ko
>   INSTALL drivers/acpi/apei/einj.ko
>   INSTALL drivers/acpi/apei/erst-dbg.ko
>   INSTALL drivers/acpi/sbs.ko
>   INSTALL drivers/acpi/sbshc.ko
>   INSTALL drivers/acpi/video.ko
>   INSTALL drivers/ata/ahci.ko
>   INSTALL drivers/ata/ata_generic.ko
>   INSTALL drivers/ata/ata_piix.ko
>   INSTALL drivers/ata/libahci.ko
>   INSTALL drivers/ata/pata_acpi.ko
>   INSTALL drivers/ata/pata_ali.ko
>   INSTALL drivers/ata/pata_amd.ko
>   INSTALL drivers/ata/pata_artop.ko
>   INSTALL drivers/ata/pata_atiixp.ko
>   INSTALL drivers/ata/pata_atp867x.ko
>   INSTALL drivers/ata/pata_cmd64x.ko
>   INSTALL drivers/ata/pata_hpt366.ko
>   INSTALL drivers/ata/pata_hpt37x.ko
>   INSTALL drivers/ata/pata_hpt3x2n.ko
>   INSTALL drivers/ata/pata_hpt3x3.ko
>   INSTALL drivers/ata/pata_it8213.ko
>   INSTALL drivers/ata/pata_it821x.ko
>   INSTALL drivers/ata/pata_jmicron.ko
>   INSTALL drivers/ata/pata_marvell.ko
>   INSTALL drivers/ata/pata_netcell.ko
>   INSTALL drivers/ata/pata_ninja32.ko
>   INSTALL drivers/ata/pata_oldpiix.ko
>   INSTALL drivers/ata/pata_pcmcia.ko
>   INSTALL drivers/ata/pata_pdc2027x.ko
>   INSTALL drivers/ata/pata_pdc202xx_old.ko
>   INSTALL drivers/ata/pata_rdc.ko
>   INSTALL drivers/ata/pata_sch.ko
>   INSTALL drivers/ata/pata_serverworks.ko
>   INSTALL drivers/ata/pata_sil680.ko
>   INSTALL drivers/ata/pata_sis.ko
>   INSTALL drivers/ata/pata_via.ko
>   INSTALL drivers/ata/pdc_adma.ko
>   INSTALL drivers/ata/sata_inic162x.ko
>   INSTALL drivers/ata/sata_mv.ko
>   INSTALL drivers/ata/sata_nv.ko
>   INSTALL drivers/ata/sata_promise.ko
>   INSTALL drivers/ata/sata_qstor.ko
>   INSTALL drivers/ata/sata_sil.ko
>   INSTALL drivers/ata/sata_sil24.ko
>   INSTALL drivers/ata/sata_sis.ko
>   INSTALL drivers/ata/sata_svw.ko
>   INSTALL drivers/ata/sata_sx4.ko
>   INSTALL drivers/ata/sata_uli.ko
>   INSTALL drivers/ata/sata_via.ko
>   INSTALL drivers/ata/sata_vsc.ko
>   INSTALL drivers/atm/atmtcp.ko
>   INSTALL drivers/auxdisplay/cfag12864b.ko
>   INSTALL drivers/auxdisplay/cfag12864bfb.ko
>   INSTALL drivers/auxdisplay/ks0108.ko
>   INSTALL drivers/base/regmap/regmap-i2c.ko
>   INSTALL drivers/bcma/bcma.ko
>   INSTALL drivers/block/aoe/aoe.ko
>   INSTALL drivers/block/cciss.ko
>   INSTALL drivers/block/cryptoloop.ko
>   INSTALL drivers/block/floppy.ko
>   INSTALL drivers/block/mtip32xx/mtip32xx.ko
>   INSTALL drivers/block/nvme.ko
>   INSTALL drivers/block/osdblk.ko
>   INSTALL drivers/block/pktcdvd.ko
>   INSTALL drivers/block/sx8.ko
>   INSTALL drivers/block/virtio_blk.ko
>   INSTALL drivers/bluetooth/bcm203x.ko
>   INSTALL drivers/bluetooth/bfusb.ko
>   INSTALL drivers/bluetooth/bluecard_cs.ko
>   INSTALL drivers/bluetooth/bpa10x.ko
>   INSTALL drivers/bluetooth/bt3c_cs.ko
>   INSTALL drivers/bluetooth/btmrvl.ko
>   INSTALL drivers/bluetooth/btmrvl_sdio.ko
>   INSTALL drivers/bluetooth/btsdio.ko
>   INSTALL drivers/bluetooth/btuart_cs.ko
>   INSTALL drivers/bluetooth/btusb.ko
>   INSTALL drivers/bluetooth/dtl1_cs.ko
>   INSTALL drivers/bluetooth/hci_uart.ko
>   INSTALL drivers/bluetooth/hci_vhci.ko
>   INSTALL drivers/cdrom/cdrom.ko
>   INSTALL drivers/char/hangcheck-timer.ko
>   INSTALL drivers/char/hw_random/amd-rng.ko
>   INSTALL drivers/char/hw_random/intel-rng.ko
>   INSTALL drivers/char/hw_random/timeriomem-rng.ko
>   INSTALL drivers/char/hw_random/via-rng.ko
>   INSTALL drivers/char/hw_random/virtio-rng.ko
>   INSTALL drivers/char/i8k.ko
>   INSTALL drivers/char/ipmi/ipmi_devintf.ko
>   INSTALL drivers/char/ipmi/ipmi_msghandler.ko
>   INSTALL drivers/char/ipmi/ipmi_poweroff.ko
>   INSTALL drivers/char/ipmi/ipmi_si.ko
>   INSTALL drivers/char/ipmi/ipmi_watchdog.ko
>   INSTALL drivers/char/lp.ko
>   INSTALL drivers/char/pcmcia/cm4000_cs.ko
>   INSTALL drivers/char/pcmcia/cm4040_cs.ko
>   INSTALL drivers/char/ppdev.ko
>   INSTALL drivers/char/tlclk.ko
>   INSTALL drivers/char/tpm/tpm_atmel.ko
>   INSTALL drivers/char/tpm/tpm_infineon.ko
>   INSTALL drivers/char/tpm/tpm_nsc.ko
>   INSTALL drivers/char/virtio_console.ko
>   INSTALL drivers/crypto/padlock-aes.ko
>   INSTALL drivers/crypto/padlock-sha.ko
>   INSTALL drivers/dca/dca.ko
>   INSTALL drivers/dma/ioat/ioatdma.ko
>   INSTALL drivers/edac/amd64_edac_mod.ko
>   INSTALL drivers/edac/e752x_edac.ko
>   INSTALL drivers/edac/edac_core.ko
>   INSTALL drivers/edac/edac_mce_amd.ko
>   INSTALL drivers/edac/i3000_edac.ko
>   INSTALL drivers/edac/i3200_edac.ko
>   INSTALL drivers/edac/i5000_edac.ko
>   INSTALL drivers/edac/i5100_edac.ko
>   INSTALL drivers/edac/i5400_edac.ko
>   INSTALL drivers/edac/i7300_edac.ko
>   INSTALL drivers/edac/i7core_edac.ko
>   INSTALL drivers/edac/i82975x_edac.ko
>   INSTALL drivers/edac/sb_edac.ko
>   INSTALL drivers/edac/x38_edac.ko
>   INSTALL drivers/firewire/firewire-core.ko
>   INSTALL drivers/firewire/firewire-net.ko
>   INSTALL drivers/firewire/firewire-ohci.ko
>   INSTALL drivers/firewire/firewire-sbp2.ko
>   INSTALL drivers/firmware/dcdbas.ko
>   INSTALL drivers/firmware/dell_rbu.ko
>   INSTALL drivers/firmware/edd.ko
>   INSTALL drivers/firmware/iscsi_ibft.ko
>   INSTALL drivers/gpio/gpio-sch.ko
>   INSTALL drivers/gpu/drm/drm.ko
>   INSTALL drivers/gpu/drm/drm_kms_helper.ko
>   INSTALL drivers/gpu/drm/i2c/ch7006.ko
>   INSTALL drivers/gpu/drm/i2c/sil164.ko
>   INSTALL drivers/gpu/drm/i915/i915.ko
>   INSTALL drivers/gpu/drm/mga/mga.ko
>   INSTALL drivers/gpu/drm/nouveau/nouveau.ko
>   INSTALL drivers/gpu/drm/r128/r128.ko
>   INSTALL drivers/gpu/drm/radeon/radeon.ko
>   INSTALL drivers/gpu/drm/savage/savage.ko
>   INSTALL drivers/gpu/drm/sis/sis.ko
>   INSTALL drivers/gpu/drm/ttm/ttm.ko
>   INSTALL drivers/gpu/drm/via/via.ko
>   INSTALL drivers/hid/hid-multitouch.ko
>   INSTALL drivers/hid/hid-wacom.ko
>   INSTALL drivers/hv/hv_balloon.ko
>   INSTALL drivers/hv/hv_utils.ko
>   INSTALL drivers/hv/hv_vmbus.ko
>   INSTALL drivers/hwmon/abituguru.ko
>   INSTALL drivers/hwmon/abituguru3.ko
>   INSTALL drivers/hwmon/ad7414.ko
>   INSTALL drivers/hwmon/ad7418.ko
>   INSTALL drivers/hwmon/adm1021.ko
>   INSTALL drivers/hwmon/adm1025.ko
>   INSTALL drivers/hwmon/adm1026.ko
>   INSTALL drivers/hwmon/adm1029.ko
>   INSTALL drivers/hwmon/adm1031.ko
>   INSTALL drivers/hwmon/adm9240.ko
>   INSTALL drivers/hwmon/ads7828.ko
>   INSTALL drivers/hwmon/adt7462.ko
>   INSTALL drivers/hwmon/adt7470.ko
>   INSTALL drivers/hwmon/adt7475.ko
>   INSTALL drivers/hwmon/applesmc.ko
>   INSTALL drivers/hwmon/asb100.ko
>   INSTALL drivers/hwmon/asus_atk0110.ko
>   INSTALL drivers/hwmon/atxp1.ko
>   INSTALL drivers/hwmon/coretemp.ko
>   INSTALL drivers/hwmon/dme1737.ko
>   INSTALL drivers/hwmon/ds1621.ko
>   INSTALL drivers/hwmon/f71805f.ko
>   INSTALL drivers/hwmon/f71882fg.ko
>   INSTALL drivers/hwmon/f75375s.ko
>   INSTALL drivers/hwmon/fam15h_power.ko
>   INSTALL drivers/hwmon/fschmd.ko
>   INSTALL drivers/hwmon/g760a.ko
>   INSTALL drivers/hwmon/gl518sm.ko
>   INSTALL drivers/hwmon/gl520sm.ko
>   INSTALL drivers/hwmon/hwmon-vid.ko
>   INSTALL drivers/hwmon/i5k_amb.ko
>   INSTALL drivers/hwmon/ibmaem.ko
>   INSTALL drivers/hwmon/ibmpex.ko
>   INSTALL drivers/hwmon/it87.ko
>   INSTALL drivers/hwmon/k10temp.ko
>   INSTALL drivers/hwmon/k8temp.ko
>   INSTALL drivers/hwmon/lm63.ko
>   INSTALL drivers/hwmon/lm75.ko
>   INSTALL drivers/hwmon/lm77.ko
>   INSTALL drivers/hwmon/lm78.ko
>   INSTALL drivers/hwmon/lm80.ko
>   INSTALL drivers/hwmon/lm83.ko
>   INSTALL drivers/hwmon/lm85.ko
>   INSTALL drivers/hwmon/lm87.ko
>   INSTALL drivers/hwmon/lm90.ko
>   INSTALL drivers/hwmon/lm92.ko
>   INSTALL drivers/hwmon/lm93.ko
>   INSTALL drivers/hwmon/lm95241.ko
>   INSTALL drivers/hwmon/ltc4215.ko
>   INSTALL drivers/hwmon/ltc4245.ko
>   INSTALL drivers/hwmon/max1619.ko
>   INSTALL drivers/hwmon/max6650.ko
>   INSTALL drivers/hwmon/pc87360.ko
>   INSTALL drivers/hwmon/pc87427.ko
>   INSTALL drivers/hwmon/pcf8591.ko
>   INSTALL drivers/hwmon/sht15.ko
>   INSTALL drivers/hwmon/sis5595.ko
>   INSTALL drivers/hwmon/smsc47b397.ko
>   INSTALL drivers/hwmon/smsc47m1.ko
>   INSTALL drivers/hwmon/smsc47m192.ko
>   INSTALL drivers/hwmon/thmc50.ko
>   INSTALL drivers/hwmon/tmp401.ko
>   INSTALL drivers/hwmon/tmp421.ko
>   INSTALL drivers/hwmon/via-cputemp.ko
>   INSTALL drivers/hwmon/via686a.ko
>   INSTALL drivers/hwmon/vt1211.ko
>   INSTALL drivers/hwmon/vt8231.ko
>   INSTALL drivers/hwmon/w83627ehf.ko
>   INSTALL drivers/hwmon/w83627hf.ko
>   INSTALL drivers/hwmon/w83781d.ko
>   INSTALL drivers/hwmon/w83791d.ko
>   INSTALL drivers/hwmon/w83792d.ko
>   INSTALL drivers/hwmon/w83793.ko
>   INSTALL drivers/hwmon/w83l785ts.ko
>   INSTALL drivers/hwmon/w83l786ng.ko
>   INSTALL drivers/i2c/algos/i2c-algo-bit.ko
>   INSTALL drivers/i2c/algos/i2c-algo-pca.ko
>   INSTALL drivers/i2c/busses/i2c-amd756-s4882.ko
>   INSTALL drivers/i2c/busses/i2c-amd756.ko
>   INSTALL drivers/i2c/busses/i2c-amd8111.ko
>   INSTALL drivers/i2c/busses/i2c-i801.ko
>   INSTALL drivers/i2c/busses/i2c-isch.ko
>   INSTALL drivers/i2c/busses/i2c-nforce2-s4985.ko
>   INSTALL drivers/i2c/busses/i2c-nforce2.ko
>   INSTALL drivers/i2c/busses/i2c-parport-light.ko
>   INSTALL drivers/i2c/busses/i2c-parport.ko
>   INSTALL drivers/i2c/busses/i2c-pca-platform.ko
>   INSTALL drivers/i2c/busses/i2c-piix4.ko
>   INSTALL drivers/i2c/busses/i2c-scmi.ko
>   INSTALL drivers/i2c/busses/i2c-simtec.ko
>   INSTALL drivers/i2c/busses/i2c-sis96x.ko
>   INSTALL drivers/i2c/busses/i2c-tiny-usb.ko
>   INSTALL drivers/i2c/busses/i2c-via.ko
>   INSTALL drivers/i2c/busses/i2c-viapro.ko
>   INSTALL drivers/i2c/i2c-core.ko
>   INSTALL drivers/i2c/i2c-dev.ko
>   INSTALL drivers/i2c/i2c-smbus.ko
>   INSTALL drivers/i2c/i2c-stub.ko
>   INSTALL drivers/idle/i7300_idle.ko
>   INSTALL drivers/infiniband/core/ib_addr.ko
>   INSTALL drivers/infiniband/core/ib_cm.ko
>   INSTALL drivers/infiniband/core/ib_core.ko
>   INSTALL drivers/infiniband/core/ib_mad.ko
>   INSTALL drivers/infiniband/core/ib_sa.ko
>   INSTALL drivers/infiniband/core/ib_ucm.ko
>   INSTALL drivers/infiniband/core/ib_umad.ko
>   INSTALL drivers/infiniband/core/ib_uverbs.ko
>   INSTALL drivers/infiniband/core/iw_cm.ko
>   INSTALL drivers/infiniband/core/rdma_cm.ko
>   INSTALL drivers/infiniband/core/rdma_ucm.ko
>   INSTALL drivers/infiniband/hw/cxgb3/iw_cxgb3.ko
>   INSTALL drivers/infiniband/hw/cxgb4/iw_cxgb4.ko
>   INSTALL drivers/infiniband/hw/ipath/ib_ipath.ko
>   INSTALL drivers/infiniband/hw/mlx4/mlx4_ib.ko
>   INSTALL drivers/infiniband/hw/mthca/ib_mthca.ko
>   INSTALL drivers/infiniband/hw/nes/iw_nes.ko
>   INSTALL drivers/infiniband/hw/ocrdma/ocrdma.ko
>   INSTALL drivers/infiniband/hw/qib/ib_qib.ko
>   INSTALL drivers/infiniband/ulp/ipoib/ib_ipoib.ko
>   INSTALL drivers/infiniband/ulp/iser/ib_iser.ko
>   INSTALL drivers/infiniband/ulp/srp/ib_srp.ko
>   INSTALL drivers/input/input-polldev.ko
>   INSTALL drivers/input/joydev.ko
>   INSTALL drivers/input/keyboard/adp5588-keys.ko
>   INSTALL drivers/input/keyboard/max7359_keypad.ko
>   INSTALL drivers/input/keyboard/opencores-kbd.ko
>   INSTALL drivers/input/misc/apanel.ko
>   INSTALL drivers/input/misc/ati_remote2.ko
>   INSTALL drivers/input/misc/atlas_btns.ko
>   INSTALL drivers/input/misc/cm109.ko
>   INSTALL drivers/input/misc/keyspan_remote.ko
>   INSTALL drivers/input/misc/pcspkr.ko
>   INSTALL drivers/input/misc/powermate.ko
>   INSTALL drivers/input/misc/rotary_encoder.ko
>   INSTALL drivers/input/misc/uinput.ko
>   INSTALL drivers/input/misc/yealink.ko
>   INSTALL drivers/input/mouse/appletouch.ko
>   INSTALL drivers/input/mouse/bcm5974.ko
>   INSTALL drivers/input/mouse/sermouse.ko
>   INSTALL drivers/input/mouse/synaptics_i2c.ko
>   INSTALL drivers/input/mouse/vsxxxaa.ko
>   INSTALL drivers/input/serio/serio_raw.ko
>   INSTALL drivers/input/sparse-keymap.ko
>   INSTALL drivers/input/tablet/acecad.ko
>   INSTALL drivers/input/tablet/aiptek.ko
>   INSTALL drivers/input/tablet/gtco.ko
>   INSTALL drivers/input/tablet/kbtab.ko
>   INSTALL drivers/input/tablet/wacom.ko
>   INSTALL drivers/input/touchscreen/ad7879-i2c.ko
>   INSTALL drivers/input/touchscreen/ad7879.ko
>   INSTALL drivers/input/touchscreen/eeti_ts.ko
>   INSTALL drivers/input/touchscreen/elo.ko
>   INSTALL drivers/input/touchscreen/fujitsu_ts.ko
>   INSTALL drivers/input/touchscreen/gunze.ko
>   INSTALL drivers/input/touchscreen/inexio.ko
>   INSTALL drivers/input/touchscreen/mcs5000_ts.ko
>   INSTALL drivers/input/touchscreen/mtouch.ko
>   INSTALL drivers/input/touchscreen/penmount.ko
>   INSTALL drivers/input/touchscreen/touchit213.ko
>   INSTALL drivers/input/touchscreen/touchright.ko
>   INSTALL drivers/input/touchscreen/touchwin.ko
>   INSTALL drivers/input/touchscreen/tsc2007.ko
>   INSTALL drivers/input/touchscreen/usbtouchscreen.ko
>   INSTALL drivers/input/touchscreen/wacom_w8001.ko
>   INSTALL drivers/isdn/capi/capi.ko
>   INSTALL drivers/isdn/capi/capidrv.ko
>   INSTALL drivers/isdn/capi/kernelcapi.ko
>   INSTALL drivers/isdn/divert/dss1_divert.ko
>   INSTALL drivers/isdn/gigaset/bas_gigaset.ko
>   INSTALL drivers/isdn/gigaset/gigaset.ko
>   INSTALL drivers/isdn/gigaset/ser_gigaset.ko
>   INSTALL drivers/isdn/gigaset/usb_gigaset.ko
>   INSTALL drivers/isdn/hardware/avm/avm_cs.ko
>   INSTALL drivers/isdn/hardware/avm/b1.ko
>   INSTALL drivers/isdn/hardware/avm/b1dma.ko
>   INSTALL drivers/isdn/hardware/avm/b1pci.ko
>   INSTALL drivers/isdn/hardware/avm/b1pcmcia.ko
>   INSTALL drivers/isdn/hardware/avm/c4.ko
>   INSTALL drivers/isdn/hardware/avm/t1pci.ko
>   INSTALL drivers/isdn/hardware/mISDN/avmfritz.ko
>   INSTALL drivers/isdn/hardware/mISDN/hfcmulti.ko
>   INSTALL drivers/isdn/hardware/mISDN/hfcpci.ko
>   INSTALL drivers/isdn/hardware/mISDN/hfcsusb.ko
>   INSTALL drivers/isdn/hardware/mISDN/mISDNinfineon.ko
>   INSTALL drivers/isdn/hardware/mISDN/mISDNipac.ko
>   INSTALL drivers/isdn/hardware/mISDN/mISDNisar.ko
>   INSTALL drivers/isdn/hardware/mISDN/netjet.ko
>   INSTALL drivers/isdn/hardware/mISDN/speedfax.ko
>   INSTALL drivers/isdn/hardware/mISDN/w6692.ko
>   INSTALL drivers/isdn/hisax/avma1_cs.ko
>   INSTALL drivers/isdn/hisax/elsa_cs.ko
>   INSTALL drivers/isdn/hisax/hfc4s8s_l1.ko
>   INSTALL drivers/isdn/hisax/hisax.ko
>   INSTALL drivers/isdn/hisax/hisax_fcpcipnp.ko
>   INSTALL drivers/isdn/hisax/hisax_isac.ko
>   INSTALL drivers/isdn/hisax/hisax_st5481.ko
>   INSTALL drivers/isdn/hisax/sedlbauer_cs.ko
>   INSTALL drivers/isdn/hisax/teles_cs.ko
>   INSTALL drivers/isdn/hysdn/hysdn.ko
>   INSTALL drivers/isdn/i4l/isdn.ko
>   INSTALL drivers/isdn/i4l/isdnhdlc.ko
>   INSTALL drivers/isdn/mISDN/l1oip.ko
>   INSTALL drivers/isdn/mISDN/mISDN_core.ko
>   INSTALL drivers/isdn/mISDN/mISDN_dsp.ko
>   INSTALL drivers/leds/leds-clevo-mail.ko
>   INSTALL drivers/leds/leds-lp3944.ko
>   INSTALL drivers/leds/ledtrig-backlight.ko
>   INSTALL drivers/leds/ledtrig-default-on.ko
>   INSTALL drivers/leds/ledtrig-heartbeat.ko
>   INSTALL drivers/leds/ledtrig-timer.ko
>   INSTALL drivers/md/dm-bio-prison.ko
>   INSTALL drivers/md/dm-bufio.ko
>   INSTALL drivers/md/dm-crypt.ko
>   INSTALL drivers/md/dm-delay.ko
>   INSTALL drivers/md/dm-flakey.ko
>   INSTALL drivers/md/dm-log-userspace.ko
>   INSTALL drivers/md/dm-log.ko
>   INSTALL drivers/md/dm-mirror.ko
>   INSTALL drivers/md/dm-mod.ko
>   INSTALL drivers/md/dm-multipath.ko
>   INSTALL drivers/md/dm-queue-length.ko
>   INSTALL drivers/md/dm-raid.ko
>   INSTALL drivers/md/dm-region-hash.ko
>   INSTALL drivers/md/dm-round-robin.ko
>   INSTALL drivers/md/dm-service-time.ko
>   INSTALL drivers/md/dm-snapshot.ko
>   INSTALL drivers/md/dm-thin-pool.ko
>   INSTALL drivers/md/dm-zero.ko
>   INSTALL drivers/md/faulty.ko
>   INSTALL drivers/md/linear.ko
>   INSTALL drivers/md/persistent-data/dm-persistent-data.ko
>   INSTALL drivers/md/raid0.ko
>   INSTALL drivers/md/raid1.ko
>   INSTALL drivers/md/raid10.ko
>   INSTALL drivers/md/raid456.ko
>   INSTALL drivers/memstick/core/memstick.ko
>   INSTALL drivers/memstick/core/mspro_block.ko
>   INSTALL drivers/memstick/host/jmb38x_ms.ko
>   INSTALL drivers/memstick/host/r592.ko
>   INSTALL drivers/memstick/host/rtsx_pci_ms.ko
>   INSTALL drivers/memstick/host/tifm_ms.ko
>   INSTALL drivers/message/fusion/mptbase.ko
>   INSTALL drivers/message/fusion/mptctl.ko
>   INSTALL drivers/message/fusion/mptfc.ko
>   INSTALL drivers/message/fusion/mptlan.ko
>   INSTALL drivers/message/fusion/mptsas.ko
>   INSTALL drivers/message/fusion/mptscsih.ko
>   INSTALL drivers/message/fusion/mptspi.ko
>   INSTALL drivers/mfd/lpc_ich.ko
>   INSTALL drivers/mfd/lpc_sch.ko
>   INSTALL drivers/mfd/mfd-core.ko
>   INSTALL drivers/mfd/rtsx_pci.ko
>   INSTALL drivers/mfd/sm501.ko
>   INSTALL drivers/misc/cb710/cb710.ko
>   INSTALL drivers/misc/eeprom/at24.ko
>   INSTALL drivers/misc/eeprom/eeprom.ko
>   INSTALL drivers/misc/eeprom/eeprom_93cx6.ko
>   INSTALL drivers/misc/eeprom/max6875.ko
>   INSTALL drivers/misc/enclosure.ko
>   INSTALL drivers/misc/hpilo.ko
>   INSTALL drivers/misc/ics932s401.ko
>   INSTALL drivers/misc/ioc4.ko
>   INSTALL drivers/misc/isl29003.ko
>   INSTALL drivers/misc/tifm_7xx1.ko
>   INSTALL drivers/misc/tifm_core.ko
>   INSTALL drivers/misc/tsl2550.ko
>   INSTALL drivers/misc/vmw_balloon.ko
>   INSTALL drivers/mmc/card/mmc_block.ko
>   INSTALL drivers/mmc/card/sdio_uart.ko
>   INSTALL drivers/mmc/core/mmc_core.ko
>   INSTALL drivers/mmc/host/cb710-mmc.ko
>   INSTALL drivers/mmc/host/rtsx_pci_sdmmc.ko
>   INSTALL drivers/mmc/host/sdhci-pci.ko
>   INSTALL drivers/mmc/host/sdhci-pltfm.ko
>   INSTALL drivers/mmc/host/sdhci.ko
>   INSTALL drivers/mmc/host/sdricoh_cs.ko
>   INSTALL drivers/mmc/host/tifm_sd.ko
>   INSTALL drivers/mmc/host/via-sdmmc.ko
>   INSTALL drivers/mtd/ar7part.ko
>   INSTALL drivers/mtd/chips/cfi_cmdset_0001.ko
>   INSTALL drivers/mtd/chips/cfi_cmdset_0002.ko
>   INSTALL drivers/mtd/chips/cfi_cmdset_0020.ko
>   INSTALL drivers/mtd/chips/cfi_probe.ko
>   INSTALL drivers/mtd/chips/cfi_util.ko
>   INSTALL drivers/mtd/chips/gen_probe.ko
>   INSTALL drivers/mtd/chips/jedec_probe.ko
>   INSTALL drivers/mtd/chips/map_absent.ko
>   INSTALL drivers/mtd/chips/map_ram.ko
>   INSTALL drivers/mtd/chips/map_rom.ko
>   INSTALL drivers/mtd/devices/block2mtd.ko
>   INSTALL drivers/mtd/devices/mtdram.ko
>   INSTALL drivers/mtd/devices/pmc551.ko
>   INSTALL drivers/mtd/ftl.ko
>   INSTALL drivers/mtd/inftl.ko
>   INSTALL drivers/mtd/lpddr/lpddr_cmds.ko
>   INSTALL drivers/mtd/lpddr/qinfo_probe.ko
>   INSTALL drivers/mtd/maps/ck804xrom.ko
>   INSTALL drivers/mtd/maps/esb2rom.ko
>   INSTALL drivers/mtd/maps/netsc520.ko
>   INSTALL drivers/mtd/maps/pci.ko
>   INSTALL drivers/mtd/maps/sc520cdp.ko
>   INSTALL drivers/mtd/maps/scb2_flash.ko
>   INSTALL drivers/mtd/maps/ts5500_flash.ko
>   INSTALL drivers/mtd/mtd_blkdevs.ko
>   INSTALL drivers/mtd/mtdblock.ko
>   INSTALL drivers/mtd/mtdblock_ro.ko
>   INSTALL drivers/mtd/mtdchar.ko
>   INSTALL drivers/mtd/mtdoops.ko
>   INSTALL drivers/mtd/nand/alauda.ko
>   INSTALL drivers/mtd/nand/diskonchip.ko
>   INSTALL drivers/mtd/nand/nand.ko
>   INSTALL drivers/mtd/nand/nand_ecc.ko
>   INSTALL drivers/mtd/nand/nand_ids.ko
>   INSTALL drivers/mtd/nand/nandsim.ko
>   INSTALL drivers/mtd/nftl.ko
>   INSTALL drivers/mtd/redboot.ko
>   INSTALL drivers/mtd/rfd_ftl.ko
>   INSTALL drivers/mtd/ssfdc.ko
>   INSTALL drivers/mtd/ubi/ubi.ko
>   INSTALL drivers/net/bonding/bonding.ko
>   INSTALL drivers/net/can/can-dev.ko
>   INSTALL drivers/net/can/sja1000/ems_pci.ko
>   INSTALL drivers/net/can/sja1000/kvaser_pci.ko
>   INSTALL drivers/net/can/sja1000/sja1000.ko
>   INSTALL drivers/net/can/sja1000/sja1000_platform.ko
>   INSTALL drivers/net/can/usb/ems_usb.ko
>   INSTALL drivers/net/can/vcan.ko
>   INSTALL drivers/net/dummy.ko
>   INSTALL drivers/net/ethernet/3com/3c574_cs.ko
>   INSTALL drivers/net/ethernet/3com/3c589_cs.ko
>   INSTALL drivers/net/ethernet/3com/3c59x.ko
>   INSTALL drivers/net/ethernet/3com/typhoon.ko
>   INSTALL drivers/net/ethernet/8390/8390.ko
>   INSTALL drivers/net/ethernet/8390/axnet_cs.ko
>   INSTALL drivers/net/ethernet/8390/ne2k-pci.ko
>   INSTALL drivers/net/ethernet/8390/pcnet_cs.ko
>   INSTALL drivers/net/ethernet/adaptec/starfire.ko
>   INSTALL drivers/net/ethernet/alteon/acenic.ko
>   INSTALL drivers/net/ethernet/amd/amd8111e.ko
>   INSTALL drivers/net/ethernet/amd/nmclan_cs.ko
>   INSTALL drivers/net/ethernet/amd/pcnet32.ko
>   INSTALL drivers/net/ethernet/atheros/atl1c/atl1c.ko
>   INSTALL drivers/net/ethernet/atheros/atl1e/atl1e.ko
>   INSTALL drivers/net/ethernet/atheros/atlx/atl1.ko
>   INSTALL drivers/net/ethernet/atheros/atlx/atl2.ko
>   INSTALL drivers/net/ethernet/broadcom/b44.ko
>   INSTALL drivers/net/ethernet/broadcom/bnx2.ko
>   INSTALL drivers/net/ethernet/broadcom/bnx2x/bnx2x.ko
>   INSTALL drivers/net/ethernet/broadcom/cnic.ko
>   INSTALL drivers/net/ethernet/broadcom/tg3.ko
>   INSTALL drivers/net/ethernet/brocade/bna/bna.ko
>   INSTALL drivers/net/ethernet/chelsio/cxgb/cxgb.ko
>   INSTALL drivers/net/ethernet/chelsio/cxgb3/cxgb3.ko
>   INSTALL drivers/net/ethernet/chelsio/cxgb4/cxgb4.ko
>   INSTALL drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf.ko
>   INSTALL drivers/net/ethernet/cisco/enic/enic.ko
>   INSTALL drivers/net/ethernet/dec/tulip/de2104x.ko
>   INSTALL drivers/net/ethernet/dec/tulip/de4x5.ko
>   INSTALL drivers/net/ethernet/dec/tulip/dmfe.ko
>   INSTALL drivers/net/ethernet/dec/tulip/tulip.ko
>   INSTALL drivers/net/ethernet/dec/tulip/uli526x.ko
>   INSTALL drivers/net/ethernet/dec/tulip/winbond-840.ko
>   INSTALL drivers/net/ethernet/dec/tulip/xircom_cb.ko
>   INSTALL drivers/net/ethernet/dlink/dl2k.ko
>   INSTALL drivers/net/ethernet/dlink/sundance.ko
>   INSTALL drivers/net/ethernet/dnet.ko
>   INSTALL drivers/net/ethernet/emulex/benet/be2net.ko
>   INSTALL drivers/net/ethernet/ethoc.ko
>   INSTALL drivers/net/ethernet/fealnx.ko
>   INSTALL drivers/net/ethernet/fujitsu/fmvj18x_cs.ko
>   INSTALL drivers/net/ethernet/icplus/ipg.ko
>   INSTALL drivers/net/ethernet/intel/e100.ko
>   INSTALL drivers/net/ethernet/intel/e1000/e1000.ko
>   INSTALL drivers/net/ethernet/intel/e1000e/e1000e.ko
>   INSTALL drivers/net/ethernet/intel/igb/igb.ko
>   INSTALL drivers/net/ethernet/intel/igbvf/igbvf.ko
>   INSTALL drivers/net/ethernet/intel/ixgb/ixgb.ko
>   INSTALL drivers/net/ethernet/intel/ixgbe/ixgbe.ko
>   INSTALL drivers/net/ethernet/intel/ixgbevf/ixgbevf.ko
>   INSTALL drivers/net/ethernet/jme.ko
>   INSTALL drivers/net/ethernet/marvell/skge.ko
>   INSTALL drivers/net/ethernet/marvell/sky2.ko
>   INSTALL drivers/net/ethernet/mellanox/mlx4/mlx4_core.ko
>   INSTALL drivers/net/ethernet/mellanox/mlx4/mlx4_en.ko
>   INSTALL drivers/net/ethernet/myricom/myri10ge/myri10ge.ko
>   INSTALL drivers/net/ethernet/natsemi/natsemi.ko
>   INSTALL drivers/net/ethernet/natsemi/ns83820.ko
>   INSTALL drivers/net/ethernet/neterion/s2io.ko
>   INSTALL drivers/net/ethernet/neterion/vxge/vxge.ko
>   INSTALL drivers/net/ethernet/nvidia/forcedeth.ko
>   INSTALL drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.ko
>   INSTALL drivers/net/ethernet/qlogic/netxen/netxen_nic.ko
>   INSTALL drivers/net/ethernet/qlogic/qla3xxx.ko
>   INSTALL drivers/net/ethernet/qlogic/qlcnic/qlcnic.ko
>   INSTALL drivers/net/ethernet/qlogic/qlge/qlge.ko
>   INSTALL drivers/net/ethernet/rdc/r6040.ko
>   INSTALL drivers/net/ethernet/realtek/8139cp.ko
>   INSTALL drivers/net/ethernet/realtek/8139too.ko
>   INSTALL drivers/net/ethernet/realtek/r8169.ko
>   INSTALL drivers/net/ethernet/sfc/sfc.ko
>   INSTALL drivers/net/ethernet/silan/sc92031.ko
>   INSTALL drivers/net/ethernet/sis/sis190.ko
>   INSTALL drivers/net/ethernet/sis/sis900.ko
>   INSTALL drivers/net/ethernet/smsc/epic100.ko
>   INSTALL drivers/net/ethernet/smsc/smc91c92_cs.ko
>   INSTALL drivers/net/ethernet/smsc/smsc9420.ko
>   INSTALL drivers/net/ethernet/sun/cassini.ko
>   INSTALL drivers/net/ethernet/sun/niu.ko
>   INSTALL drivers/net/ethernet/sun/sungem.ko
>   INSTALL drivers/net/ethernet/sun/sunhme.ko
>   INSTALL drivers/net/ethernet/tehuti/tehuti.ko
>   INSTALL drivers/net/ethernet/ti/tlan.ko
>   INSTALL drivers/net/ethernet/via/via-rhine.ko
>   INSTALL drivers/net/ethernet/via/via-velocity.ko
>   INSTALL drivers/net/ethernet/xircom/xirc2ps_cs.ko
>   INSTALL drivers/net/hyperv/hv_netvsc.ko
>   INSTALL drivers/net/ieee802154/fakehard.ko
>   INSTALL drivers/net/ifb.ko
>   INSTALL drivers/net/macvlan.ko
>   INSTALL drivers/net/macvtap.ko
>   INSTALL drivers/net/mdio.ko
>   INSTALL drivers/net/mii.ko
>   INSTALL drivers/net/netconsole.ko
>   INSTALL drivers/net/phy/broadcom.ko
>   INSTALL drivers/net/phy/cicada.ko
>   INSTALL drivers/net/phy/davicom.ko
>   INSTALL drivers/net/phy/et1011c.ko
>   INSTALL drivers/net/phy/icplus.ko
>   INSTALL drivers/net/phy/lxt.ko
>   INSTALL drivers/net/phy/marvell.ko
>   INSTALL drivers/net/phy/mdio-bitbang.ko
>   INSTALL drivers/net/phy/national.ko
>   INSTALL drivers/net/phy/qsemi.ko
>   INSTALL drivers/net/phy/realtek.ko
>   INSTALL drivers/net/phy/smsc.ko
>   INSTALL drivers/net/phy/ste10Xp.ko
>   INSTALL drivers/net/phy/vitesse.ko
>   INSTALL drivers/net/ppp/ppp_async.ko
>   INSTALL drivers/net/ppp/ppp_deflate.ko
>   INSTALL drivers/net/ppp/ppp_generic.ko
>   INSTALL drivers/net/ppp/ppp_mppe.ko
>   INSTALL drivers/net/ppp/ppp_synctty.ko
>   INSTALL drivers/net/ppp/pppoe.ko
>   INSTALL drivers/net/ppp/pppox.ko
>   INSTALL drivers/net/slip/slhc.ko
>   INSTALL drivers/net/slip/slip.ko
>   INSTALL drivers/net/sungem_phy.ko
>   INSTALL drivers/net/tun.ko
>   INSTALL drivers/net/usb/asix.ko
>   INSTALL drivers/net/usb/catc.ko
>   INSTALL drivers/net/usb/cdc-phonet.ko
>   INSTALL drivers/net/usb/cdc_eem.ko
>   INSTALL drivers/net/usb/cdc_ether.ko
>   INSTALL drivers/net/usb/cdc_ncm.ko
>   INSTALL drivers/net/usb/cdc_subset.ko
>   INSTALL drivers/net/usb/dm9601.ko
>   INSTALL drivers/net/usb/gl620a.ko
>   INSTALL drivers/net/usb/hso.ko
>   INSTALL drivers/net/usb/int51x1.ko
>   INSTALL drivers/net/usb/kaweth.ko
>   INSTALL drivers/net/usb/mcs7830.ko
>   INSTALL drivers/net/usb/net1080.ko
>   INSTALL drivers/net/usb/pegasus.ko
>   INSTALL drivers/net/usb/plusb.ko
>   INSTALL drivers/net/usb/rndis_host.ko
>   INSTALL drivers/net/usb/rtl8150.ko
>   INSTALL drivers/net/usb/sierra_net.ko
>   INSTALL drivers/net/usb/smsc95xx.ko
>   INSTALL drivers/net/usb/usbnet.ko
>   INSTALL drivers/net/usb/zaurus.ko
>   INSTALL drivers/net/veth.ko
>   INSTALL drivers/net/virtio_net.ko
>   INSTALL drivers/net/vmxnet3/vmxnet3.ko
>   INSTALL drivers/net/vxlan.ko
>   INSTALL drivers/net/wan/dlci.ko
>   INSTALL drivers/net/wan/hdlc.ko
>   INSTALL drivers/net/wan/hdlc_cisco.ko
>   INSTALL drivers/net/wan/hdlc_fr.ko
>   INSTALL drivers/net/wan/hdlc_ppp.ko
>   INSTALL drivers/net/wan/hdlc_raw.ko
>   INSTALL drivers/net/wimax/i2400m/i2400m-usb.ko
>   INSTALL drivers/net/wimax/i2400m/i2400m.ko
>   INSTALL drivers/net/wireless/adm8211.ko
>   INSTALL drivers/net/wireless/airo.ko
>   INSTALL drivers/net/wireless/airo_cs.ko
>   INSTALL drivers/net/wireless/at76c50x-usb.ko
>   INSTALL drivers/net/wireless/ath/ath.ko
>   INSTALL drivers/net/wireless/ath/ath5k/ath5k.ko
>   INSTALL drivers/net/wireless/ath/ath9k/ath9k.ko
>   INSTALL drivers/net/wireless/ath/ath9k/ath9k_common.ko
>   INSTALL drivers/net/wireless/ath/ath9k/ath9k_htc.ko
>   INSTALL drivers/net/wireless/ath/ath9k/ath9k_hw.ko
>   INSTALL drivers/net/wireless/ath/carl9170/carl9170.ko
>   INSTALL drivers/net/wireless/atmel.ko
>   INSTALL drivers/net/wireless/atmel_cs.ko
>   INSTALL drivers/net/wireless/atmel_pci.ko
>   INSTALL drivers/net/wireless/b43/b43.ko
>   INSTALL drivers/net/wireless/b43legacy/b43legacy.ko
>   INSTALL drivers/net/wireless/brcm80211/brcmsmac/brcmsmac.ko
>   INSTALL drivers/net/wireless/brcm80211/brcmutil/brcmutil.ko
>   INSTALL drivers/net/wireless/hostap/hostap.ko
>   INSTALL drivers/net/wireless/hostap/hostap_cs.ko
>   INSTALL drivers/net/wireless/hostap/hostap_pci.ko
>   INSTALL drivers/net/wireless/hostap/hostap_plx.ko
>   INSTALL drivers/net/wireless/ipw2x00/ipw2100.ko
>   INSTALL drivers/net/wireless/ipw2x00/ipw2200.ko
>   INSTALL drivers/net/wireless/ipw2x00/libipw.ko
>   INSTALL drivers/net/wireless/iwlegacy/iwl3945.ko
>   INSTALL drivers/net/wireless/iwlegacy/iwl4965.ko
>   INSTALL drivers/net/wireless/iwlegacy/iwlegacy.ko
>   INSTALL drivers/net/wireless/iwlwifi/dvm/iwldvm.ko
>   INSTALL drivers/net/wireless/iwlwifi/iwlwifi.ko
>   INSTALL drivers/net/wireless/libertas/libertas.ko
>   INSTALL drivers/net/wireless/libertas/libertas_cs.ko
>   INSTALL drivers/net/wireless/libertas/libertas_sdio.ko
>   INSTALL drivers/net/wireless/libertas/usb8xxx.ko
>   INSTALL drivers/net/wireless/libertas_tf/libertas_tf.ko
>   INSTALL drivers/net/wireless/libertas_tf/libertas_tf_usb.ko
>   INSTALL drivers/net/wireless/mac80211_hwsim.ko
>   INSTALL drivers/net/wireless/mwl8k.ko
>   INSTALL drivers/net/wireless/orinoco/orinoco.ko
>   INSTALL drivers/net/wireless/orinoco/orinoco_cs.ko
>   INSTALL drivers/net/wireless/orinoco/orinoco_nortel.ko
>   INSTALL drivers/net/wireless/orinoco/orinoco_pci.ko
>   INSTALL drivers/net/wireless/orinoco/orinoco_plx.ko
>   INSTALL drivers/net/wireless/orinoco/orinoco_tmd.ko
>   INSTALL drivers/net/wireless/orinoco/spectrum_cs.ko
>   INSTALL drivers/net/wireless/p54/p54common.ko
>   INSTALL drivers/net/wireless/p54/p54pci.ko
>   INSTALL drivers/net/wireless/p54/p54usb.ko
>   INSTALL drivers/net/wireless/rndis_wlan.ko
>   INSTALL drivers/net/wireless/rt2x00/rt2400pci.ko
>   INSTALL drivers/net/wireless/rt2x00/rt2500pci.ko
>   INSTALL drivers/net/wireless/rt2x00/rt2500usb.ko
>   INSTALL drivers/net/wireless/rt2x00/rt2800lib.ko
>   INSTALL drivers/net/wireless/rt2x00/rt2800pci.ko
>   INSTALL drivers/net/wireless/rt2x00/rt2800usb.ko
>   INSTALL drivers/net/wireless/rt2x00/rt2x00lib.ko
>   INSTALL drivers/net/wireless/rt2x00/rt2x00pci.ko
>   INSTALL drivers/net/wireless/rt2x00/rt2x00usb.ko
>   INSTALL drivers/net/wireless/rt2x00/rt61pci.ko
>   INSTALL drivers/net/wireless/rt2x00/rt73usb.ko
>   INSTALL drivers/net/wireless/rtl818x/rtl8180/rtl8180.ko
>   INSTALL drivers/net/wireless/rtl818x/rtl8187/rtl8187.ko
>   INSTALL drivers/net/wireless/ti/wl1251/wl1251.ko
>   INSTALL drivers/net/wireless/ti/wl1251/wl1251_sdio.ko
>   INSTALL drivers/net/wireless/ti/wl12xx/wl12xx.ko
>   INSTALL drivers/net/wireless/ti/wlcore/wlcore.ko
>   INSTALL drivers/net/wireless/wl3501_cs.ko
>   INSTALL drivers/net/wireless/zd1201.ko
>   INSTALL drivers/net/wireless/zd1211rw/zd1211rw.ko
>   INSTALL drivers/parport/parport.ko
>   INSTALL drivers/parport/parport_cs.ko
>   INSTALL drivers/parport/parport_pc.ko
>   INSTALL drivers/parport/parport_serial.ko
>   INSTALL drivers/pci/hotplug/acpiphp_ibm.ko
>   INSTALL drivers/pci/hotplug/shpchp.ko
>   INSTALL drivers/pci/pcie/aer/aer_inject.ko
>   INSTALL drivers/pcmcia/pd6729.ko
>   INSTALL drivers/pcmcia/yenta_socket.ko
>   INSTALL drivers/platform/x86/acer-wmi.ko
>   INSTALL drivers/platform/x86/asus-laptop.ko
>   INSTALL drivers/platform/x86/compal-laptop.ko
>   INSTALL drivers/platform/x86/dell-laptop.ko
>   INSTALL drivers/platform/x86/dell-wmi.ko
>   INSTALL drivers/platform/x86/eeepc-laptop.ko
>   INSTALL drivers/platform/x86/fujitsu-laptop.ko
>   INSTALL drivers/platform/x86/hdaps.ko
>   INSTALL drivers/platform/x86/hp-wmi.ko
>   INSTALL drivers/platform/x86/intel_ips.ko
>   INSTALL drivers/platform/x86/msi-laptop.ko
>   INSTALL drivers/platform/x86/mxm-wmi.ko
>   INSTALL drivers/platform/x86/panasonic-laptop.ko
>   INSTALL drivers/platform/x86/sony-laptop.ko
>   INSTALL drivers/platform/x86/thinkpad_acpi.ko
>   INSTALL drivers/platform/x86/topstar-laptop.ko
>   INSTALL drivers/platform/x86/toshiba_acpi.ko
>   INSTALL drivers/platform/x86/wmi.ko
>   INSTALL drivers/power/bq27x00_battery.ko
>   INSTALL drivers/power/max17040_battery.ko
>   INSTALL drivers/pps/pps_core.ko
>   INSTALL drivers/ptp/ptp.ko
>   INSTALL drivers/ptp/ptp_pch.ko
>   INSTALL drivers/regulator/fixed.ko
>   INSTALL drivers/regulator/lp3971.ko
>   INSTALL drivers/regulator/max1586.ko
>   INSTALL drivers/regulator/tps65023-regulator.ko
>   INSTALL drivers/regulator/tps6507x-regulator.ko
>   INSTALL drivers/regulator/userspace-consumer.ko
>   INSTALL drivers/rtc/rtc-bq4802.ko
>   INSTALL drivers/rtc/rtc-ds1286.ko
>   INSTALL drivers/rtc/rtc-ds1307.ko
>   INSTALL drivers/rtc/rtc-ds1374.ko
>   INSTALL drivers/rtc/rtc-ds1511.ko
>   INSTALL drivers/rtc/rtc-ds1553.ko
>   INSTALL drivers/rtc/rtc-ds1672.ko
>   INSTALL drivers/rtc/rtc-ds1742.ko
>   INSTALL drivers/rtc/rtc-fm3130.ko
>   INSTALL drivers/rtc/rtc-isl1208.ko
>   INSTALL drivers/rtc/rtc-m41t80.ko
>   INSTALL drivers/rtc/rtc-m48t35.ko
>   INSTALL drivers/rtc/rtc-m48t59.ko
>   INSTALL drivers/rtc/rtc-max6900.ko
>   INSTALL drivers/rtc/rtc-pcf8563.ko
>   INSTALL drivers/rtc/rtc-pcf8583.ko
>   INSTALL drivers/rtc/rtc-rs5c372.ko
>   INSTALL drivers/rtc/rtc-rx8025.ko
>   INSTALL drivers/rtc/rtc-rx8581.ko
>   INSTALL drivers/rtc/rtc-stk17ta8.ko
>   INSTALL drivers/rtc/rtc-v3020.ko
>   INSTALL drivers/rtc/rtc-x1205.ko
>   INSTALL drivers/scsi/3w-9xxx.ko
>   INSTALL drivers/scsi/3w-sas.ko
>   INSTALL drivers/scsi/3w-xxxx.ko
>   INSTALL drivers/scsi/aacraid/aacraid.ko
>   INSTALL drivers/scsi/aic7xxx/aic79xx.ko
>   INSTALL drivers/scsi/aic7xxx/aic7xxx.ko
>   INSTALL drivers/scsi/aic94xx/aic94xx.ko
>   INSTALL drivers/scsi/arcmsr/arcmsr.ko
>   INSTALL drivers/scsi/be2iscsi/be2iscsi.ko
>   INSTALL drivers/scsi/bfa/bfa.ko
>   INSTALL drivers/scsi/bnx2fc/bnx2fc.ko
>   INSTALL drivers/scsi/bnx2i/bnx2i.ko
>   INSTALL drivers/scsi/ch.ko
>   INSTALL drivers/scsi/cxgbi/cxgb3i/cxgb3i.ko
>   INSTALL drivers/scsi/cxgbi/cxgb4i/cxgb4i.ko
>   INSTALL drivers/scsi/cxgbi/libcxgbi.ko
>   INSTALL drivers/scsi/device_handler/scsi_dh_alua.ko
>   INSTALL drivers/scsi/device_handler/scsi_dh_emc.ko
>   INSTALL drivers/scsi/device_handler/scsi_dh_hp_sw.ko
>   INSTALL drivers/scsi/device_handler/scsi_dh_rdac.ko
>   INSTALL drivers/scsi/fcoe/fcoe.ko
>   INSTALL drivers/scsi/fcoe/libfcoe.ko
>   INSTALL drivers/scsi/fnic/fnic.ko
>   INSTALL drivers/scsi/hpsa.ko
>   INSTALL drivers/scsi/hptiop.ko
>   INSTALL drivers/scsi/hv_storvsc.ko
>   INSTALL drivers/scsi/imm.ko
>   INSTALL drivers/scsi/initio.ko
>   INSTALL drivers/scsi/ips.ko
>   INSTALL drivers/scsi/isci/isci.ko
>   INSTALL drivers/scsi/iscsi_boot_sysfs.ko
>   INSTALL drivers/scsi/iscsi_tcp.ko
>   INSTALL drivers/scsi/libfc/libfc.ko
>   INSTALL drivers/scsi/libiscsi.ko
>   INSTALL drivers/scsi/libiscsi_tcp.ko
>   INSTALL drivers/scsi/libsas/libsas.ko
>   INSTALL drivers/scsi/libsrp.ko
>   INSTALL drivers/scsi/lpfc/lpfc.ko
>   INSTALL drivers/scsi/megaraid/megaraid_mbox.ko
>   INSTALL drivers/scsi/megaraid/megaraid_mm.ko
>   INSTALL drivers/scsi/megaraid/megaraid_sas.ko
>   INSTALL drivers/scsi/mpt2sas/mpt2sas.ko
>   INSTALL drivers/scsi/mpt3sas/mpt3sas.ko
>   INSTALL drivers/scsi/mvsas/mvsas.ko
>   INSTALL drivers/scsi/osd/libosd.ko
>   INSTALL drivers/scsi/osd/osd.ko
>   INSTALL drivers/scsi/osst.ko
>   INSTALL drivers/scsi/pm8001/pm8001.ko
>   INSTALL drivers/scsi/pmcraid.ko
>   INSTALL drivers/scsi/ppa.ko
>   INSTALL drivers/scsi/qla2xxx/qla2xxx.ko
>   INSTALL drivers/scsi/qla4xxx/qla4xxx.ko
>   INSTALL drivers/scsi/raid_class.ko
>   INSTALL drivers/scsi/scsi_debug.ko
>   INSTALL drivers/scsi/scsi_tgt.ko
>   INSTALL drivers/scsi/scsi_transport_fc.ko
>   INSTALL drivers/scsi/scsi_transport_iscsi.ko
>   INSTALL drivers/scsi/scsi_transport_sas.ko
>   INSTALL drivers/scsi/scsi_transport_spi.ko
>   INSTALL drivers/scsi/scsi_transport_srp.ko
>   INSTALL drivers/scsi/sd_mod.ko
>   INSTALL drivers/scsi/ses.ko
>   INSTALL drivers/scsi/sg.ko
>   INSTALL drivers/scsi/sr_mod.ko
>   INSTALL drivers/scsi/st.ko
>   INSTALL drivers/scsi/stex.ko
>   INSTALL drivers/scsi/sym53c8xx_2/sym53c8xx.ko
>   INSTALL drivers/scsi/virtio_scsi.ko
>   INSTALL drivers/scsi/vmw_pvscsi.ko
>   INSTALL drivers/ssb/ssb.ko
>   INSTALL drivers/target/loopback/tcm_loop.ko
>   INSTALL drivers/target/target_core_file.ko
>   INSTALL drivers/target/target_core_iblock.ko
>   INSTALL drivers/target/target_core_mod.ko
>   INSTALL drivers/target/target_core_pscsi.ko
>   INSTALL drivers/target/tcm_fc/tcm_fc.ko
>   INSTALL drivers/tty/cyclades.ko
>   INSTALL drivers/tty/ipwireless/ipwireless.ko
>   INSTALL drivers/tty/n_hdlc.ko
>   INSTALL drivers/tty/nozomi.ko
>   INSTALL drivers/tty/serial/8250/serial_cs.ko
>   INSTALL drivers/tty/serial/jsm/jsm.ko
>   INSTALL drivers/tty/synclink.ko
>   INSTALL drivers/tty/synclink_gt.ko
>   INSTALL drivers/tty/synclinkmp.ko
>   INSTALL drivers/uio/uio.ko
>   INSTALL drivers/uio/uio_aec.ko
>   INSTALL drivers/uio/uio_cif.ko
>   INSTALL drivers/uio/uio_pci_generic.ko
>   INSTALL drivers/uio/uio_pdrv.ko
>   INSTALL drivers/uio/uio_pdrv_genirq.ko
>   INSTALL drivers/uio/uio_sercos3.ko
>   INSTALL drivers/usb/atm/cxacru.ko
>   INSTALL drivers/usb/atm/speedtch.ko
>   INSTALL drivers/usb/atm/ueagle-atm.ko
>   INSTALL drivers/usb/atm/usbatm.ko
>   INSTALL drivers/usb/atm/xusbatm.ko
>   INSTALL drivers/usb/class/cdc-acm.ko
>   INSTALL drivers/usb/class/cdc-wdm.ko
>   INSTALL drivers/usb/class/usblp.ko
>   INSTALL drivers/usb/class/usbtmc.ko
>   INSTALL drivers/usb/host/hwa-hc.ko
>   INSTALL drivers/usb/host/isp1362-hcd.ko
>   INSTALL drivers/usb/host/sl811-hcd.ko
>   INSTALL drivers/usb/host/u132-hcd.ko
>   INSTALL drivers/usb/host/whci/whci-hcd.ko
>   INSTALL drivers/usb/host/xhci-hcd.ko
>   INSTALL drivers/usb/image/mdc800.ko
>   INSTALL drivers/usb/image/microtek.ko
>   INSTALL drivers/usb/misc/adutux.ko
>   INSTALL drivers/usb/misc/appledisplay.ko
>   INSTALL drivers/usb/misc/emi26.ko
>   INSTALL drivers/usb/misc/emi62.ko
>   INSTALL drivers/usb/misc/ezusb.ko
>   INSTALL drivers/usb/misc/ftdi-elan.ko
>   INSTALL drivers/usb/misc/idmouse.ko
>   INSTALL drivers/usb/misc/iowarrior.ko
>   INSTALL drivers/usb/misc/isight_firmware.ko
>   INSTALL drivers/usb/misc/ldusb.ko
>   INSTALL drivers/usb/misc/legousbtower.ko
>   INSTALL drivers/usb/misc/sisusbvga/sisusbvga.ko
>   INSTALL drivers/usb/misc/usblcd.ko
>   INSTALL drivers/usb/misc/usbled.ko
>   INSTALL drivers/usb/misc/usbsevseg.ko
>   INSTALL drivers/usb/misc/uss720.ko
>   INSTALL drivers/usb/otg/nop-usb-xceiv.ko
>   INSTALL drivers/usb/serial/aircable.ko
>   INSTALL drivers/usb/serial/ark3116.ko
>   INSTALL drivers/usb/serial/belkin_sa.ko
>   INSTALL drivers/usb/serial/ch341.ko
>   INSTALL drivers/usb/serial/cp210x.ko
>   INSTALL drivers/usb/serial/cyberjack.ko
>   INSTALL drivers/usb/serial/cypress_m8.ko
>   INSTALL drivers/usb/serial/digi_acceleport.ko
>   INSTALL drivers/usb/serial/empeg.ko
>   INSTALL drivers/usb/serial/ftdi_sio.ko
>   INSTALL drivers/usb/serial/funsoft.ko
>   INSTALL drivers/usb/serial/garmin_gps.ko
>   INSTALL drivers/usb/serial/hp4x.ko
>   INSTALL drivers/usb/serial/io_edgeport.ko
>   INSTALL drivers/usb/serial/io_ti.ko
>   INSTALL drivers/usb/serial/ipaq.ko
>   INSTALL drivers/usb/serial/ipw.ko
>   INSTALL drivers/usb/serial/ir-usb.ko
>   INSTALL drivers/usb/serial/iuu_phoenix.ko
>   INSTALL drivers/usb/serial/keyspan.ko
>   INSTALL drivers/usb/serial/keyspan_pda.ko
>   INSTALL drivers/usb/serial/kl5kusb105.ko
>   INSTALL drivers/usb/serial/kobil_sct.ko
>   INSTALL drivers/usb/serial/mct_u232.ko
>   INSTALL drivers/usb/serial/mos7720.ko
>   INSTALL drivers/usb/serial/mos7840.ko
>   INSTALL drivers/usb/serial/moto_modem.ko
>   INSTALL drivers/usb/serial/navman.ko
>   INSTALL drivers/usb/serial/omninet.ko
>   INSTALL drivers/usb/serial/opticon.ko
>   INSTALL drivers/usb/serial/option.ko
>   INSTALL drivers/usb/serial/oti6858.ko
>   INSTALL drivers/usb/serial/pl2303.ko
>   INSTALL drivers/usb/serial/qcserial.ko
>   INSTALL drivers/usb/serial/safe_serial.ko
>   INSTALL drivers/usb/serial/siemens_mpi.ko
>   INSTALL drivers/usb/serial/sierra.ko
>   INSTALL drivers/usb/serial/spcp8x5.ko
>   INSTALL drivers/usb/serial/symbolserial.ko
>   INSTALL drivers/usb/serial/ti_usb_3410_5052.ko
>   INSTALL drivers/usb/serial/usb_debug.ko
>   INSTALL drivers/usb/serial/usb_wwan.ko
>   INSTALL drivers/usb/serial/usbserial.ko
>   INSTALL drivers/usb/serial/visor.ko
>   INSTALL drivers/usb/serial/whiteheat.ko
>   INSTALL drivers/usb/storage/ums-alauda.ko
>   INSTALL drivers/usb/storage/ums-cypress.ko
>   INSTALL drivers/usb/storage/ums-datafab.ko
>   INSTALL drivers/usb/storage/ums-freecom.ko
>   INSTALL drivers/usb/storage/ums-isd200.ko
>   INSTALL drivers/usb/storage/ums-jumpshot.ko
>   INSTALL drivers/usb/storage/ums-karma.ko
>   INSTALL drivers/usb/storage/ums-onetouch.ko
>   INSTALL drivers/usb/storage/ums-sddr09.ko
>   INSTALL drivers/usb/storage/ums-sddr55.ko
>   INSTALL drivers/usb/storage/ums-usbat.ko
>   INSTALL drivers/usb/storage/usb-storage.ko
>   INSTALL drivers/usb/wusbcore/wusb-cbaf.ko
>   INSTALL drivers/usb/wusbcore/wusb-wa.ko
>   INSTALL drivers/usb/wusbcore/wusbcore.ko
>   INSTALL drivers/uwb/hwa-rc.ko
>   INSTALL drivers/uwb/i1480/dfu/i1480-dfu-usb.ko
>   INSTALL drivers/uwb/i1480/i1480-est.ko
>   INSTALL drivers/uwb/umc.ko
>   INSTALL drivers/uwb/uwb.ko
>   INSTALL drivers/uwb/whc-rc.ko
>   INSTALL drivers/uwb/whci.ko
>   INSTALL drivers/vhost/vhost_net.ko
>   INSTALL drivers/video/aty/aty128fb.ko
>   INSTALL drivers/video/aty/atyfb.ko
>   INSTALL drivers/video/aty/radeonfb.ko
>   INSTALL drivers/video/backlight/lcd.ko
>   INSTALL drivers/video/backlight/platform_lcd.ko
>   INSTALL drivers/video/cirrusfb.ko
>   INSTALL drivers/video/fb_ddc.ko
>   INSTALL drivers/video/fb_sys_fops.ko
>   INSTALL drivers/video/macmodes.ko
>   INSTALL drivers/video/nvidia/nvidiafb.ko
>   INSTALL drivers/video/output.ko
>   INSTALL drivers/video/riva/rivafb.ko
>   INSTALL drivers/video/savage/savagefb.ko
>   INSTALL drivers/video/sm501fb.ko
>   INSTALL drivers/video/syscopyarea.ko
>   INSTALL drivers/video/sysfillrect.ko
>   INSTALL drivers/video/sysimgblt.ko
>   INSTALL drivers/video/vfb.ko
>   INSTALL drivers/video/vga16fb.ko
>   INSTALL drivers/video/vgastate.ko
>   INSTALL drivers/video/via/viafb.ko
>   INSTALL drivers/virtio/virtio.ko
>   INSTALL drivers/virtio/virtio_balloon.ko
>   INSTALL drivers/virtio/virtio_pci.ko
>   INSTALL drivers/virtio/virtio_ring.ko
>   INSTALL drivers/watchdog/alim1535_wdt.ko
>   INSTALL drivers/watchdog/alim7101_wdt.ko
>   INSTALL drivers/watchdog/hpwdt.ko
>   INSTALL drivers/watchdog/i6300esb.ko
>   INSTALL drivers/watchdog/iTCO_vendor_support.ko
>   INSTALL drivers/watchdog/iTCO_wdt.ko
>   INSTALL drivers/watchdog/ib700wdt.ko
>   INSTALL drivers/watchdog/ibmasr.ko
>   INSTALL drivers/watchdog/ie6xx_wdt.ko
>   INSTALL drivers/watchdog/it8712f_wdt.ko
>   INSTALL drivers/watchdog/it87_wdt.ko
>   INSTALL drivers/watchdog/machzwd.ko
>   INSTALL drivers/watchdog/pcwd_pci.ko
>   INSTALL drivers/watchdog/pcwd_usb.ko
>   INSTALL drivers/watchdog/sbc_fitpc2_wdt.ko
>   INSTALL drivers/watchdog/sch311x_wdt.ko
>   INSTALL drivers/watchdog/softdog.ko
>   INSTALL drivers/watchdog/w83627hf_wdt.ko
>   INSTALL drivers/watchdog/w83697hf_wdt.ko
>   INSTALL drivers/watchdog/w83697ug_wdt.ko
>   INSTALL drivers/watchdog/w83877f_wdt.ko
>   INSTALL drivers/watchdog/w83977f_wdt.ko
>   INSTALL drivers/watchdog/wdt_pci.ko
>   INSTALL fs/autofs4/autofs4.ko
>   INSTALL fs/btrfs/btrfs.ko
>   INSTALL fs/cachefiles/cachefiles.ko
>   INSTALL fs/cifs/cifs.ko
>   INSTALL fs/configfs/configfs.ko
>   INSTALL fs/cramfs/cramfs.ko
>   INSTALL fs/dlm/dlm.ko
>   INSTALL fs/ecryptfs/ecryptfs.ko
>   INSTALL fs/exofs/libore.ko
>   INSTALL fs/exportfs/exportfs.ko
>   INSTALL fs/ext2/ext2.ko
>   INSTALL fs/ext3/ext3.ko
>   INSTALL fs/ext4/ext4.ko
>   INSTALL fs/fat/fat.ko
>   INSTALL fs/fat/msdos.ko
>   INSTALL fs/fat/vfat.ko
>   INSTALL fs/fscache/fscache.ko
>   INSTALL fs/fuse/cuse.ko
>   INSTALL fs/fuse/fuse.ko
>   INSTALL fs/gfs2/gfs2.ko
>   INSTALL fs/jbd/jbd.ko
>   INSTALL fs/jbd2/jbd2.ko
>   INSTALL fs/jffs2/jffs2.ko
>   INSTALL fs/lockd/lockd.ko
>   INSTALL fs/mbcache.ko
>   INSTALL fs/nfs/blocklayout/blocklayoutdriver.ko
>   INSTALL fs/nfs/nfs.ko
>   INSTALL fs/nfs/nfs_layout_nfsv41_files.ko
>   INSTALL fs/nfs/nfsv2.ko
>   INSTALL fs/nfs/nfsv3.ko
>   INSTALL fs/nfs/nfsv4.ko
>   INSTALL fs/nfs/objlayout/objlayoutdriver.ko
>   INSTALL fs/nfs_common/nfs_acl.ko
>   INSTALL fs/nfsd/nfsd.ko
>   INSTALL fs/nls/nls_cp1250.ko
>   INSTALL fs/nls/nls_cp1251.ko
>   INSTALL fs/nls/nls_cp1255.ko
>   INSTALL fs/nls/nls_cp737.ko
>   INSTALL fs/nls/nls_cp775.ko
>   INSTALL fs/nls/nls_cp850.ko
>   INSTALL fs/nls/nls_cp852.ko
>   INSTALL fs/nls/nls_cp855.ko
>   INSTALL fs/nls/nls_cp857.ko
>   INSTALL fs/nls/nls_cp860.ko
>   INSTALL fs/nls/nls_cp861.ko
>   INSTALL fs/nls/nls_cp862.ko
>   INSTALL fs/nls/nls_cp863.ko
>   INSTALL fs/nls/nls_cp864.ko
>   INSTALL fs/nls/nls_cp865.ko
>   INSTALL fs/nls/nls_cp866.ko
>   INSTALL fs/nls/nls_cp869.ko
>   INSTALL fs/nls/nls_cp874.ko
>   INSTALL fs/nls/nls_cp932.ko
>   INSTALL fs/nls/nls_cp936.ko
>   INSTALL fs/nls/nls_cp949.ko
>   INSTALL fs/nls/nls_cp950.ko
>   INSTALL fs/nls/nls_euc-jp.ko
>   INSTALL fs/nls/nls_iso8859-1.ko
>   INSTALL fs/nls/nls_iso8859-13.ko
>   INSTALL fs/nls/nls_iso8859-14.ko
>   INSTALL fs/nls/nls_iso8859-15.ko
>   INSTALL fs/nls/nls_iso8859-2.ko
>   INSTALL fs/nls/nls_iso8859-3.ko
>   INSTALL fs/nls/nls_iso8859-4.ko
>   INSTALL fs/nls/nls_iso8859-5.ko
>   INSTALL fs/nls/nls_iso8859-6.ko
>   INSTALL fs/nls/nls_iso8859-7.ko
>   INSTALL fs/nls/nls_iso8859-9.ko
>   INSTALL fs/nls/nls_koi8-r.ko
>   INSTALL fs/nls/nls_koi8-ru.ko
>   INSTALL fs/nls/nls_koi8-u.ko
>   INSTALL fs/nls/nls_utf8.ko
>   INSTALL fs/squashfs/squashfs.ko
>   INSTALL fs/ubifs/ubifs.ko
>   INSTALL fs/udf/udf.ko
>   INSTALL fs/xfs/xfs.ko
>   INSTALL kernel/trace/ring_buffer_benchmark.ko
>   INSTALL lib/cordic.ko
>   INSTALL lib/crc-ccitt.ko
>   INSTALL lib/crc-itu-t.ko
>   INSTALL lib/crc-t10dif.ko
>   INSTALL lib/crc7.ko
>   INSTALL lib/crc8.ko
>   INSTALL lib/libcrc32c.ko
>   INSTALL lib/raid6/raid6_pq.ko
>   INSTALL lib/reed_solomon/reed_solomon.ko
>   INSTALL lib/ts_bm.ko
>   INSTALL lib/ts_fsm.ko
>   INSTALL lib/ts_kmp.ko
>   INSTALL lib/zlib_deflate/zlib_deflate.ko
>   INSTALL net/802/garp.ko
>   INSTALL net/802/p8022.ko
>   INSTALL net/802/psnap.ko
>   INSTALL net/802/stp.ko
>   INSTALL net/8021q/8021q.ko
>   INSTALL net/9p/9pnet.ko
>   INSTALL net/9p/9pnet_rdma.ko
>   INSTALL net/9p/9pnet_virtio.ko
>   INSTALL net/atm/atm.ko
>   INSTALL net/atm/br2684.ko
>   INSTALL net/atm/clip.ko
>   INSTALL net/atm/lec.ko
>   INSTALL net/atm/pppoatm.ko
>   INSTALL net/bluetooth/bluetooth.ko
>   INSTALL net/bluetooth/bnep/bnep.ko
>   INSTALL net/bluetooth/cmtp/cmtp.ko
>   INSTALL net/bluetooth/hidp/hidp.ko
>   INSTALL net/bluetooth/rfcomm/rfcomm.ko
>   INSTALL net/bridge/bridge.ko
>   INSTALL net/bridge/netfilter/ebt_802_3.ko
>   INSTALL net/bridge/netfilter/ebt_among.ko
>   INSTALL net/bridge/netfilter/ebt_arp.ko
>   INSTALL net/bridge/netfilter/ebt_arpreply.ko
>   INSTALL net/bridge/netfilter/ebt_dnat.ko
>   INSTALL net/bridge/netfilter/ebt_ip.ko
>   INSTALL net/bridge/netfilter/ebt_ip6.ko
>   INSTALL net/bridge/netfilter/ebt_limit.ko
>   INSTALL net/bridge/netfilter/ebt_log.ko
>   INSTALL net/bridge/netfilter/ebt_mark.ko
>   INSTALL net/bridge/netfilter/ebt_mark_m.ko
>   INSTALL net/bridge/netfilter/ebt_nflog.ko
>   INSTALL net/bridge/netfilter/ebt_pkttype.ko
>   INSTALL net/bridge/netfilter/ebt_redirect.ko
>   INSTALL net/bridge/netfilter/ebt_snat.ko
>   INSTALL net/bridge/netfilter/ebt_stp.ko
>   INSTALL net/bridge/netfilter/ebt_ulog.ko
>   INSTALL net/bridge/netfilter/ebt_vlan.ko
>   INSTALL net/bridge/netfilter/ebtable_broute.ko
>   INSTALL net/bridge/netfilter/ebtable_filter.ko
>   INSTALL net/bridge/netfilter/ebtable_nat.ko
>   INSTALL net/bridge/netfilter/ebtables.ko
>   INSTALL net/can/can-bcm.ko
>   INSTALL net/can/can-raw.ko
>   INSTALL net/can/can.ko
>   INSTALL net/core/pktgen.ko
>   INSTALL net/dccp/dccp.ko
>   INSTALL net/dccp/dccp_diag.ko
>   INSTALL net/dccp/dccp_ipv4.ko
>   INSTALL net/dccp/dccp_ipv6.ko
>   INSTALL net/dns_resolver/dns_resolver.ko
>   INSTALL net/ieee802154/af_802154.ko
>   INSTALL net/ieee802154/ieee802154.ko
>   INSTALL net/ipv4/ah4.ko
>   INSTALL net/ipv4/esp4.ko
>   INSTALL net/ipv4/inet_diag.ko
>   INSTALL net/ipv4/ip_gre.ko
>   INSTALL net/ipv4/ipcomp.ko
>   INSTALL net/ipv4/ipip.ko
>   INSTALL net/ipv4/netfilter/arp_tables.ko
>   INSTALL net/ipv4/netfilter/arpt_mangle.ko
>   INSTALL net/ipv4/netfilter/arptable_filter.ko
>   INSTALL net/ipv4/netfilter/ip_tables.ko
>   INSTALL net/ipv4/netfilter/ipt_CLUSTERIP.ko
>   INSTALL net/ipv4/netfilter/ipt_ECN.ko
>   INSTALL net/ipv4/netfilter/ipt_REJECT.ko
>   INSTALL net/ipv4/netfilter/ipt_ULOG.ko
>   INSTALL net/ipv4/netfilter/ipt_ah.ko
>   INSTALL net/ipv4/netfilter/iptable_filter.ko
>   INSTALL net/ipv4/netfilter/iptable_mangle.ko
>   INSTALL net/ipv4/netfilter/iptable_raw.ko
>   INSTALL net/ipv4/netfilter/iptable_security.ko
>   INSTALL net/ipv4/netfilter/nf_conntrack_ipv4.ko
>   INSTALL net/ipv4/netfilter/nf_defrag_ipv4.ko
>   INSTALL net/ipv4/tcp_bic.ko
>   INSTALL net/ipv4/tcp_diag.ko
>   INSTALL net/ipv4/tcp_highspeed.ko
>   INSTALL net/ipv4/tcp_htcp.ko
>   INSTALL net/ipv4/tcp_hybla.ko
>   INSTALL net/ipv4/tcp_illinois.ko
>   INSTALL net/ipv4/tcp_lp.ko
>   INSTALL net/ipv4/tcp_scalable.ko
>   INSTALL net/ipv4/tcp_vegas.ko
>   INSTALL net/ipv4/tcp_veno.ko
>   INSTALL net/ipv4/tcp_westwood.ko
>   INSTALL net/ipv4/tcp_yeah.ko
>   INSTALL net/ipv4/tunnel4.ko
>   INSTALL net/ipv4/xfrm4_mode_beet.ko
>   INSTALL net/ipv4/xfrm4_mode_transport.ko
>   INSTALL net/ipv4/xfrm4_mode_tunnel.ko
>   INSTALL net/ipv4/xfrm4_tunnel.ko
>   INSTALL net/ipv6/ah6.ko
>   INSTALL net/ipv6/esp6.ko
>   INSTALL net/ipv6/ip6_tunnel.ko
>   INSTALL net/ipv6/ipcomp6.ko
>   INSTALL net/ipv6/ipv6.ko
>   INSTALL net/ipv6/mip6.ko
>   INSTALL net/ipv6/netfilter/ip6_tables.ko
>   INSTALL net/ipv6/netfilter/ip6t_REJECT.ko
>   INSTALL net/ipv6/netfilter/ip6t_ah.ko
>   INSTALL net/ipv6/netfilter/ip6t_eui64.ko
>   INSTALL net/ipv6/netfilter/ip6t_frag.ko
>   INSTALL net/ipv6/netfilter/ip6t_hbh.ko
>   INSTALL net/ipv6/netfilter/ip6t_ipv6header.ko
>   INSTALL net/ipv6/netfilter/ip6t_mh.ko
>   INSTALL net/ipv6/netfilter/ip6t_rt.ko
>   INSTALL net/ipv6/netfilter/ip6table_filter.ko
>   INSTALL net/ipv6/netfilter/ip6table_mangle.ko
>   INSTALL net/ipv6/netfilter/ip6table_raw.ko
>   INSTALL net/ipv6/netfilter/ip6table_security.ko
>   INSTALL net/ipv6/netfilter/nf_conntrack_ipv6.ko
>   INSTALL net/ipv6/netfilter/nf_defrag_ipv6.ko
>   INSTALL net/ipv6/sit.ko
>   INSTALL net/ipv6/tunnel6.ko
>   INSTALL net/ipv6/xfrm6_mode_beet.ko
>   INSTALL net/ipv6/xfrm6_mode_ro.ko
>   INSTALL net/ipv6/xfrm6_mode_transport.ko
>   INSTALL net/ipv6/xfrm6_mode_tunnel.ko
>   INSTALL net/ipv6/xfrm6_tunnel.ko
>   INSTALL net/key/af_key.ko
>   INSTALL net/llc/llc.ko
>   INSTALL net/mac80211/mac80211.ko
>   INSTALL net/netfilter/ipset/ip_set.ko
>   INSTALL net/netfilter/ipset/ip_set_bitmap_ip.ko
>   INSTALL net/netfilter/ipset/ip_set_bitmap_ipmac.ko
>   INSTALL net/netfilter/ipset/ip_set_bitmap_port.ko
>   INSTALL net/netfilter/ipset/ip_set_hash_ip.ko
>   INSTALL net/netfilter/ipset/ip_set_hash_ipport.ko
>   INSTALL net/netfilter/ipset/ip_set_hash_ipportip.ko
>   INSTALL net/netfilter/ipset/ip_set_hash_ipportnet.ko
>   INSTALL net/netfilter/ipset/ip_set_hash_net.ko
>   INSTALL net/netfilter/ipset/ip_set_hash_netport.ko
>   INSTALL net/netfilter/ipset/ip_set_list_set.ko
>   INSTALL net/netfilter/ipvs/ip_vs.ko
>   INSTALL net/netfilter/ipvs/ip_vs_dh.ko
>   INSTALL net/netfilter/ipvs/ip_vs_lblc.ko
>   INSTALL net/netfilter/ipvs/ip_vs_lblcr.ko
>   INSTALL net/netfilter/ipvs/ip_vs_lc.ko
>   INSTALL net/netfilter/ipvs/ip_vs_nq.ko
>   INSTALL net/netfilter/ipvs/ip_vs_pe_sip.ko
>   INSTALL net/netfilter/ipvs/ip_vs_rr.ko
>   INSTALL net/netfilter/ipvs/ip_vs_sed.ko
>   INSTALL net/netfilter/ipvs/ip_vs_sh.ko
>   INSTALL net/netfilter/ipvs/ip_vs_wlc.ko
>   INSTALL net/netfilter/ipvs/ip_vs_wrr.ko
>   INSTALL net/netfilter/nf_conntrack.ko
>   INSTALL net/netfilter/nf_conntrack_amanda.ko
>   INSTALL net/netfilter/nf_conntrack_broadcast.ko
>   INSTALL net/netfilter/nf_conntrack_ftp.ko
>   INSTALL net/netfilter/nf_conntrack_h323.ko
>   INSTALL net/netfilter/nf_conntrack_irc.ko
>   INSTALL net/netfilter/nf_conntrack_netbios_ns.ko
>   INSTALL net/netfilter/nf_conntrack_netlink.ko
>   INSTALL net/netfilter/nf_conntrack_pptp.ko
>   INSTALL net/netfilter/nf_conntrack_proto_dccp.ko
>   INSTALL net/netfilter/nf_conntrack_proto_gre.ko
>   INSTALL net/netfilter/nf_conntrack_proto_sctp.ko
>   INSTALL net/netfilter/nf_conntrack_proto_udplite.ko
>   INSTALL net/netfilter/nf_conntrack_sane.ko
>   INSTALL net/netfilter/nf_conntrack_sip.ko
>   INSTALL net/netfilter/nf_conntrack_snmp.ko
>   INSTALL net/netfilter/nf_conntrack_tftp.ko
>   INSTALL net/netfilter/nf_tproxy_core.ko
>   INSTALL net/netfilter/nfnetlink.ko
>   INSTALL net/netfilter/nfnetlink_log.ko
>   INSTALL net/netfilter/nfnetlink_queue.ko
>   INSTALL net/netfilter/xt_AUDIT.ko
>   INSTALL net/netfilter/xt_CHECKSUM.ko
>   INSTALL net/netfilter/xt_CLASSIFY.ko
>   INSTALL net/netfilter/xt_CONNSECMARK.ko
>   INSTALL net/netfilter/xt_CT.ko
>   INSTALL net/netfilter/xt_DSCP.ko
>   INSTALL net/netfilter/xt_HL.ko
>   INSTALL net/netfilter/xt_LED.ko
>   INSTALL net/netfilter/xt_NFLOG.ko
>   INSTALL net/netfilter/xt_NFQUEUE.ko
>   INSTALL net/netfilter/xt_RATEEST.ko
>   INSTALL net/netfilter/xt_SECMARK.ko
>   INSTALL net/netfilter/xt_TCPMSS.ko
>   INSTALL net/netfilter/xt_TCPOPTSTRIP.ko
>   INSTALL net/netfilter/xt_TPROXY.ko
>   INSTALL net/netfilter/xt_TRACE.ko
>   INSTALL net/netfilter/xt_cluster.ko
>   INSTALL net/netfilter/xt_comment.ko
>   INSTALL net/netfilter/xt_connbytes.ko
>   INSTALL net/netfilter/xt_connlimit.ko
>   INSTALL net/netfilter/xt_connmark.ko
>   INSTALL net/netfilter/xt_conntrack.ko
>   INSTALL net/netfilter/xt_dccp.ko
>   INSTALL net/netfilter/xt_dscp.ko
>   INSTALL net/netfilter/xt_ecn.ko
>   INSTALL net/netfilter/xt_esp.ko
>   INSTALL net/netfilter/xt_hashlimit.ko
>   INSTALL net/netfilter/xt_helper.ko
>   INSTALL net/netfilter/xt_hl.ko
>   INSTALL net/netfilter/xt_iprange.ko
>   INSTALL net/netfilter/xt_length.ko
>   INSTALL net/netfilter/xt_limit.ko
>   INSTALL net/netfilter/xt_mac.ko
>   INSTALL net/netfilter/xt_mark.ko
>   INSTALL net/netfilter/xt_multiport.ko
>   INSTALL net/netfilter/xt_osf.ko
>   INSTALL net/netfilter/xt_owner.ko
>   INSTALL net/netfilter/xt_physdev.ko
>   INSTALL net/netfilter/xt_pkttype.ko
>   INSTALL net/netfilter/xt_policy.ko
>   INSTALL net/netfilter/xt_quota.ko
>   INSTALL net/netfilter/xt_rateest.ko
>   INSTALL net/netfilter/xt_realm.ko
>   INSTALL net/netfilter/xt_recent.ko
>   INSTALL net/netfilter/xt_sctp.ko
>   INSTALL net/netfilter/xt_set.ko
>   INSTALL net/netfilter/xt_socket.ko
>   INSTALL net/netfilter/xt_state.ko
>   INSTALL net/netfilter/xt_statistic.ko
>   INSTALL net/netfilter/xt_string.ko
>   INSTALL net/netfilter/xt_tcpmss.ko
>   INSTALL net/netfilter/xt_time.ko
>   INSTALL net/netfilter/xt_u32.ko
>   INSTALL net/openvswitch/openvswitch.ko
>   INSTALL net/phonet/phonet.ko
>   INSTALL net/phonet/pn_pep.ko
>   INSTALL net/rds/rds.ko
>   INSTALL net/rds/rds_rdma.ko
>   INSTALL net/rds/rds_tcp.ko
>   INSTALL net/rfkill/rfkill.ko
>   INSTALL net/sched/act_gact.ko
>   INSTALL net/sched/act_ipt.ko
>   INSTALL net/sched/act_mirred.ko
>   INSTALL net/sched/act_nat.ko
>   INSTALL net/sched/act_pedit.ko
>   INSTALL net/sched/act_police.ko
>   INSTALL net/sched/act_simple.ko
>   INSTALL net/sched/act_skbedit.ko
>   INSTALL net/sched/cls_basic.ko
>   INSTALL net/sched/cls_flow.ko
>   INSTALL net/sched/cls_fw.ko
>   INSTALL net/sched/cls_route.ko
>   INSTALL net/sched/cls_rsvp.ko
>   INSTALL net/sched/cls_rsvp6.ko
>   INSTALL net/sched/cls_tcindex.ko
>   INSTALL net/sched/cls_u32.ko
>   INSTALL net/sched/em_cmp.ko
>   INSTALL net/sched/em_meta.ko
>   INSTALL net/sched/em_nbyte.ko
>   INSTALL net/sched/em_text.ko
>   INSTALL net/sched/em_u32.ko
>   INSTALL net/sched/sch_atm.ko
>   INSTALL net/sched/sch_cbq.ko
>   INSTALL net/sched/sch_drr.ko
>   INSTALL net/sched/sch_dsmark.ko
>   INSTALL net/sched/sch_gred.ko
>   INSTALL net/sched/sch_hfsc.ko
>   INSTALL net/sched/sch_htb.ko
>   INSTALL net/sched/sch_ingress.ko
>   INSTALL net/sched/sch_mqprio.ko
>   INSTALL net/sched/sch_multiq.ko
>   INSTALL net/sched/sch_netem.ko
>   INSTALL net/sched/sch_prio.ko
>   INSTALL net/sched/sch_qfq.ko
>   INSTALL net/sched/sch_red.ko
>   INSTALL net/sched/sch_sfq.ko
>   INSTALL net/sched/sch_tbf.ko
>   INSTALL net/sched/sch_teql.ko
>   INSTALL net/sctp/sctp.ko
>   INSTALL net/sunrpc/auth_gss/auth_rpcgss.ko
>   INSTALL net/sunrpc/auth_gss/rpcsec_gss_krb5.ko
>   INSTALL net/sunrpc/sunrpc.ko
>   INSTALL net/sunrpc/xprtrdma/svcrdma.ko
>   INSTALL net/sunrpc/xprtrdma/xprtrdma.ko
>   INSTALL net/wimax/wimax.ko
>   INSTALL net/wireless/cfg80211.ko
>   INSTALL net/wireless/lib80211.ko
>   INSTALL net/wireless/lib80211_crypt_ccmp.ko
>   INSTALL net/wireless/lib80211_crypt_tkip.ko
>   INSTALL net/wireless/lib80211_crypt_wep.ko
>   INSTALL net/xfrm/xfrm_ipcomp.ko
>   INSTALL sound/ac97_bus.ko
>   INSTALL sound/core/oss/snd-mixer-oss.ko
>   INSTALL sound/core/oss/snd-pcm-oss.ko
>   INSTALL sound/core/seq/oss/snd-seq-oss.ko
>   INSTALL sound/core/seq/snd-seq-device.ko
>   INSTALL sound/core/seq/snd-seq-dummy.ko
>   INSTALL sound/core/seq/snd-seq-midi-emul.ko
>   INSTALL sound/core/seq/snd-seq-midi-event.ko
>   INSTALL sound/core/seq/snd-seq-midi.ko
>   INSTALL sound/core/seq/snd-seq-virmidi.ko
>   INSTALL sound/core/seq/snd-seq.ko
>   INSTALL sound/core/snd-hrtimer.ko
>   INSTALL sound/core/snd-hwdep.ko
>   INSTALL sound/core/snd-page-alloc.ko
>   INSTALL sound/core/snd-pcm.ko
>   INSTALL sound/core/snd-rawmidi.ko
>   INSTALL sound/core/snd-timer.ko
>   INSTALL sound/core/snd.ko
>   INSTALL sound/drivers/mpu401/snd-mpu401-uart.ko
>   INSTALL sound/drivers/mpu401/snd-mpu401.ko
>   INSTALL sound/drivers/opl3/snd-opl3-lib.ko
>   INSTALL sound/drivers/opl3/snd-opl3-synth.ko
>   INSTALL sound/drivers/pcsp/snd-pcsp.ko
>   INSTALL sound/drivers/snd-aloop.ko
>   INSTALL sound/drivers/snd-dummy.ko
>   INSTALL sound/drivers/snd-mtpav.ko
>   INSTALL sound/drivers/snd-virmidi.ko
>   INSTALL sound/drivers/vx/snd-vx-lib.ko
>   INSTALL sound/i2c/other/snd-ak4113.ko
>   INSTALL sound/i2c/other/snd-ak4114.ko
>   INSTALL sound/i2c/other/snd-ak4xxx-adda.ko
>   INSTALL sound/i2c/other/snd-pt2258.ko
>   INSTALL sound/i2c/snd-cs8427.ko
>   INSTALL sound/i2c/snd-i2c.ko
>   INSTALL sound/isa/sb/snd-sb-common.ko
>   INSTALL sound/isa/sb/snd-sb16-dsp.ko
>   INSTALL sound/pci/ac97/snd-ac97-codec.ko
>   INSTALL sound/pci/ali5451/snd-ali5451.ko
>   INSTALL sound/pci/au88x0/snd-au8810.ko
>   INSTALL sound/pci/au88x0/snd-au8820.ko
>   INSTALL sound/pci/au88x0/snd-au8830.ko
>   INSTALL sound/pci/ca0106/snd-ca0106.ko
>   INSTALL sound/pci/cs46xx/snd-cs46xx.ko
>   INSTALL sound/pci/cs5535audio/snd-cs5535audio.ko
>   INSTALL sound/pci/ctxfi/snd-ctxfi.ko
>   INSTALL sound/pci/echoaudio/snd-darla20.ko
>   INSTALL sound/pci/echoaudio/snd-darla24.ko
>   INSTALL sound/pci/echoaudio/snd-echo3g.ko
>   INSTALL sound/pci/echoaudio/snd-gina20.ko
>   INSTALL sound/pci/echoaudio/snd-gina24.ko
>   INSTALL sound/pci/echoaudio/snd-indigo.ko
>   INSTALL sound/pci/echoaudio/snd-indigodj.ko
>   INSTALL sound/pci/echoaudio/snd-indigodjx.ko
>   INSTALL sound/pci/echoaudio/snd-indigoio.ko
>   INSTALL sound/pci/echoaudio/snd-indigoiox.ko
>   INSTALL sound/pci/echoaudio/snd-layla20.ko
>   INSTALL sound/pci/echoaudio/snd-layla24.ko
>   INSTALL sound/pci/echoaudio/snd-mia.ko
>   INSTALL sound/pci/echoaudio/snd-mona.ko
>   INSTALL sound/pci/emu10k1/snd-emu10k1-synth.ko
>   INSTALL sound/pci/emu10k1/snd-emu10k1.ko
>   INSTALL sound/pci/emu10k1/snd-emu10k1x.ko
>   INSTALL sound/pci/hda/snd-hda-codec-analog.ko
>   INSTALL sound/pci/hda/snd-hda-codec-ca0110.ko
>   INSTALL sound/pci/hda/snd-hda-codec-ca0132.ko
>   INSTALL sound/pci/hda/snd-hda-codec-cirrus.ko
>   INSTALL sound/pci/hda/snd-hda-codec-cmedia.ko
>   INSTALL sound/pci/hda/snd-hda-codec-conexant.ko
>   INSTALL sound/pci/hda/snd-hda-codec-hdmi.ko
>   INSTALL sound/pci/hda/snd-hda-codec-idt.ko
>   INSTALL sound/pci/hda/snd-hda-codec-realtek.ko
>   INSTALL sound/pci/hda/snd-hda-codec-si3054.ko
>   INSTALL sound/pci/hda/snd-hda-codec-via.ko
>   INSTALL sound/pci/hda/snd-hda-codec.ko
>   INSTALL sound/pci/hda/snd-hda-intel.ko
>   INSTALL sound/pci/ice1712/snd-ice1712.ko
>   INSTALL sound/pci/ice1712/snd-ice1724.ko
>   INSTALL sound/pci/ice1712/snd-ice17xx-ak4xxx.ko
>   INSTALL sound/pci/korg1212/snd-korg1212.ko
>   INSTALL sound/pci/lx6464es/snd-lx6464es.ko
>   INSTALL sound/pci/mixart/snd-mixart.ko
>   INSTALL sound/pci/oxygen/snd-oxygen-lib.ko
>   INSTALL sound/pci/oxygen/snd-oxygen.ko
>   INSTALL sound/pci/oxygen/snd-virtuoso.ko
>   INSTALL sound/pci/pcxhr/snd-pcxhr.ko
>   INSTALL sound/pci/rme9652/snd-hdsp.ko
>   INSTALL sound/pci/rme9652/snd-hdspm.ko
>   INSTALL sound/pci/rme9652/snd-rme9652.ko
>   INSTALL sound/pci/snd-ad1889.ko
>   INSTALL sound/pci/snd-atiixp-modem.ko
>   INSTALL sound/pci/snd-atiixp.ko
>   INSTALL sound/pci/snd-bt87x.ko
>   INSTALL sound/pci/snd-cmipci.ko
>   INSTALL sound/pci/snd-cs5530.ko
>   INSTALL sound/pci/snd-ens1370.ko
>   INSTALL sound/pci/snd-ens1371.ko
>   INSTALL sound/pci/snd-es1968.ko
>   INSTALL sound/pci/snd-intel8x0.ko
>   INSTALL sound/pci/snd-intel8x0m.ko
>   INSTALL sound/pci/snd-maestro3.ko
>   INSTALL sound/pci/snd-rme32.ko
>   INSTALL sound/pci/snd-rme96.ko
>   INSTALL sound/pci/snd-via82xx-modem.ko
>   INSTALL sound/pci/snd-via82xx.ko
>   INSTALL sound/pci/trident/snd-trident.ko
>   INSTALL sound/pci/vx222/snd-vx222.ko
>   INSTALL sound/soundcore.ko
>   INSTALL sound/synth/emux/snd-emux-synth.ko
>   INSTALL sound/synth/snd-util-mem.ko
>   INSTALL sound/usb/6fire/snd-usb-6fire.ko
>   INSTALL sound/usb/caiaq/snd-usb-caiaq.ko
>   INSTALL sound/usb/misc/snd-ua101.ko
>   INSTALL sound/usb/snd-usb-audio.ko
>   INSTALL sound/usb/snd-usbmidi-lib.ko
>   INSTALL sound/usb/usx2y/snd-usb-us122l.ko
>   INSTALL sound/usb/usx2y/snd-usb-usx2y.ko
>   INSTALL /lib/firmware/acenic/tg1.bin
>   INSTALL /lib/firmware/acenic/tg2.bin
>   INSTALL /lib/firmware/adaptec/starfire_rx.bin
>   INSTALL /lib/firmware/adaptec/starfire_tx.bin
>   INSTALL /lib/firmware/bnx2x/bnx2x-e1-6.2.9.0.fw
>   INSTALL /lib/firmware/bnx2x/bnx2x-e1h-6.2.9.0.fw
>   INSTALL /lib/firmware/bnx2x/bnx2x-e2-6.2.9.0.fw
>   INSTALL /lib/firmware/bnx2/bnx2-mips-09-6.2.1a.fw
>   INSTALL /lib/firmware/bnx2/bnx2-rv2p-09-6.0.17.fw
>   INSTALL /lib/firmware/bnx2/bnx2-rv2p-09ax-6.0.17.fw
>   INSTALL /lib/firmware/bnx2/bnx2-mips-06-6.2.1.fw
>   INSTALL /lib/firmware/bnx2/bnx2-rv2p-06-6.0.15.fw
>   INSTALL /lib/firmware/sun/cassini.bin
>   INSTALL /lib/firmware/cxgb3/t3b_psram-1.1.0.bin
>   INSTALL /lib/firmware/cxgb3/t3c_psram-1.1.0.bin
>   INSTALL /lib/firmware/cxgb3/ael2005_opt_edc.bin
>   INSTALL /lib/firmware/cxgb3/ael2005_twx_edc.bin
>   INSTALL /lib/firmware/cxgb3/ael2020_twx_edc.bin
>   INSTALL /lib/firmware/matrox/g200_warp.fw
>   INSTALL /lib/firmware/matrox/g400_warp.fw
>   INSTALL /lib/firmware/r128/r128_cce.bin
>   INSTALL /lib/firmware/radeon/R100_cp.bin
>   INSTALL /lib/firmware/radeon/R200_cp.bin
>   INSTALL /lib/firmware/radeon/R300_cp.bin
>   INSTALL /lib/firmware/radeon/R420_cp.bin
>   INSTALL /lib/firmware/radeon/RS690_cp.bin
>   INSTALL /lib/firmware/radeon/RS600_cp.bin
>   INSTALL /lib/firmware/radeon/R520_cp.bin
>   INSTALL /lib/firmware/radeon/R600_pfp.bin
>   INSTALL /lib/firmware/radeon/R600_me.bin
>   INSTALL /lib/firmware/radeon/RV610_pfp.bin
>   INSTALL /lib/firmware/radeon/RV610_me.bin
>   INSTALL /lib/firmware/radeon/RV630_pfp.bin
>   INSTALL /lib/firmware/radeon/RV630_me.bin
>   INSTALL /lib/firmware/radeon/RV620_pfp.bin
>   INSTALL /lib/firmware/radeon/RV620_me.bin
>   INSTALL /lib/firmware/radeon/RV635_pfp.bin
>   INSTALL /lib/firmware/radeon/RV635_me.bin
>   INSTALL /lib/firmware/radeon/RV670_pfp.bin
>   INSTALL /lib/firmware/radeon/RV670_me.bin
>   INSTALL /lib/firmware/radeon/RS780_pfp.bin
>   INSTALL /lib/firmware/radeon/RS780_me.bin
>   INSTALL /lib/firmware/radeon/RV770_pfp.bin
>   INSTALL /lib/firmware/radeon/RV770_me.bin
>   INSTALL /lib/firmware/radeon/RV730_pfp.bin
>   INSTALL /lib/firmware/radeon/RV730_me.bin
>   INSTALL /lib/firmware/radeon/RV710_pfp.bin
>   INSTALL /lib/firmware/radeon/RV710_me.bin
>   INSTALL /lib/firmware/e100/d101m_ucode.bin
>   INSTALL /lib/firmware/e100/d101s_ucode.bin
>   INSTALL /lib/firmware/e100/d102e_ucode.bin
>   INSTALL /lib/firmware/cis/LA-PCM.cis
>   INSTALL /lib/firmware/cis/PCMLM28.cis
>   INSTALL /lib/firmware/cis/DP83903.cis
>   INSTALL /lib/firmware/cis/NE2K.cis
>   INSTALL /lib/firmware/cis/tamarack.cis
>   INSTALL /lib/firmware/cis/PE-200.cis
>   INSTALL /lib/firmware/cis/PE520.cis
>   INSTALL /lib/firmware/cis/3CXEM556.cis
>   INSTALL /lib/firmware/cis/3CCFEM556.cis
>   INSTALL /lib/firmware/cis/MT5634ZLX.cis
>   INSTALL /lib/firmware/cis/RS-COM-2P.cis
>   INSTALL /lib/firmware/cis/COMpad2.cis
>   INSTALL /lib/firmware/cis/COMpad4.cis
>   INSTALL /lib/firmware/cis/SW_555_SER.cis
>   INSTALL /lib/firmware/cis/SW_7xx_SER.cis
>   INSTALL /lib/firmware/cis/SW_8xx_SER.cis
>   INSTALL /lib/firmware/ositech/Xilinx7OD.bin
>   INSTALL /lib/firmware/qlogic/sd7220.fw
>   INSTALL /lib/firmware/korg/k1212.dsp
>   INSTALL /lib/firmware/ess/maestro3_assp_kernel.fw
>   INSTALL /lib/firmware/ess/maestro3_assp_minisrc.fw
>   INSTALL /lib/firmware/tehuti/bdx.bin
>   INSTALL /lib/firmware/tigon/tg3.bin
>   INSTALL /lib/firmware/tigon/tg3_tso.bin
>   INSTALL /lib/firmware/tigon/tg3_tso5.bin
>   INSTALL /lib/firmware/3com/typhoon.bin
>   INSTALL /lib/firmware/emi26/loader.fw
>   INSTALL /lib/firmware/emi26/firmware.fw
>   INSTALL /lib/firmware/emi26/bitstream.fw
>   INSTALL /lib/firmware/emi62/loader.fw
>   INSTALL /lib/firmware/emi62/bitstream.fw
>   INSTALL /lib/firmware/emi62/spdif.fw
>   INSTALL /lib/firmware/emi62/midi.fw
>   INSTALL /lib/firmware/kaweth/new_code.bin
>   INSTALL /lib/firmware/kaweth/trigger_code.bin
>   INSTALL /lib/firmware/kaweth/new_code_fix.bin
>   INSTALL /lib/firmware/kaweth/trigger_code_fix.bin
>   INSTALL /lib/firmware/ti_3410.fw
>   INSTALL /lib/firmware/ti_5052.fw
>   INSTALL /lib/firmware/mts_cdma.fw
>   INSTALL /lib/firmware/mts_gsm.fw
>   INSTALL /lib/firmware/mts_edge.fw
>   INSTALL /lib/firmware/edgeport/boot.fw
>   INSTALL /lib/firmware/edgeport/boot2.fw
>   INSTALL /lib/firmware/edgeport/down.fw
>   INSTALL /lib/firmware/edgeport/down2.fw
>   INSTALL /lib/firmware/edgeport/down3.bin
>   INSTALL /lib/firmware/whiteheat_loader.fw
>   INSTALL /lib/firmware/whiteheat.fw
>   INSTALL /lib/firmware/keyspan_pda/keyspan_pda.fw
>   INSTALL /lib/firmware/keyspan_pda/xircom_pgs.fw
>   DEPMOD  3.8.13_xenomai-2.6.4
> sh /usr/src/kernels/linux-3.8.13-xenomai-2.6.4/arch/x86/boot/install.sh
> 3.8.13_xenomai-2.6.4 arch/x86/boot/bzImage \ System.map "/boot"
> ERROR: modinfo: could not find module cpufreq_ondemand
> ERROR: modinfo: could not find module freq_table
> ERROR: modinfo: could not find module pcc_cpufreq
> ERROR: modinfo: could not find module power_meter
>=20
> Next step: Install linux-3.8.13  &  xenomai-2.6.4.
>=20
> ...
> SUCCESS!
>=20
> The installation is now finished.
> Proceed now with a reboot and make sure to boot using the kernel with
> Xenomai.
>=20
> ...
>=20
> Installation process stopped
>=20
> Removing src dir in /usr/src/kernels/linux-3.8.13-xenomai-2.6.4/
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: xenomai_kernel_config
> Type: application/octet-stream
> Size: 116154 bytes
> Desc: not available
> URL:
> <http://xenomai.org/pipermail/xenomai/attachments/20160819/81148731/attac=
hment.obj>
> -------------- next part -------------- A non-text attachment was
> scrubbed... Name: config_1
> Type: application/octet-stream
> Size: 113137 bytes
> Desc: not available
> URL:
> <http://xenomai.org/pipermail/xenomai/attachments/20160819/81148731/attac=
hment-0001.obj>
> -------------- next part -------------- A non-text attachment was
> scrubbed... Name: configure_2
> Type: application/octet-stream
> Size: 113934 bytes
> Desc: not available
> URL:
> <http://xenomai.org/pipermail/xenomai/attachments/20160819/81148731/attac=
hment-0002.obj>
> _______________________________________________ Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


