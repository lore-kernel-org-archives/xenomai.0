Message-ID: <44720BD1.805@domain.hid>
Date: Mon, 22 May 2006 21:06:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5A44BD7133E96B69DE78D820"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] kgdb-ipipe for 2.6.16
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5A44BD7133E96B69DE78D820
Content-Type: multipart/mixed; boundary="------------020205010507060004010000"

This is a multi-part message in MIME format.
--------------020205010507060004010000
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

here comes another round of patches to make kgdb work over Ipipe/Xenomai
(still only x86). This series is based on latest kgdb CVS [1], which
mostly work over 2.6.16 kernels.  As usual, the application series file
is attached, and should explain the usage.

It "mostly works" means that you may encounter problems in combination
with gcc 4.1 [2]. For now, as a workaround, add "CFLAGS_kgdb.o +=3D
-fno-unit-at-a-time" to kernel/Makefile. I will have to post this issue
to kgdb-bugreport as well and see if they prefer a cleaner solution.

I also submit a new version of the required Xenomai extension.
Hopefully, I managed to integrate it more cleanly this time.

Jan


[1] cvs -d :pserver:anonymous@domain.hid \
        co kgdb-2
    (server seems to be down right now...)
[2] http://gcc.gnu.org/ml/gcc-help/2006-05/msg00202.html

--------------020205010507060004010000
Content-Type: text/x-patch;
 name="prepare-kgdb-ipipe-x86.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="prepare-kgdb-ipipe-x86.patch"

Index: linux-2.6.16.16/arch/i386/kernel/entry.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16.16.orig/arch/i386/kernel/entry.S
+++ linux-2.6.16.16/arch/i386/kernel/entry.S
@@ -123,7 +123,7 @@ VM_MASK		=3D 0x00020000
 .previous
=20
=20
-KPROBE_ENTRY(ret_from_fork)
+ENTRY(ret_from_fork)
 	pushl %eax
 	call schedule_tail
 	GET_THREAD_INFO(%ebp)
@@ -472,7 +472,7 @@ ENTRY(simd_coprocessor_error)
 	pushl $do_simd_coprocessor_error
 	jmp error_code
=20
-KPROBE_ENTRY(device_not_available)
+ENTRY(device_not_available)
 	pushl $-1			# mark this as an int
 	SAVE_ALL
 	movl %cr0, %eax
@@ -654,7 +654,7 @@ ENTRY(machine_check)
 	jmp error_code
 #endif
=20
-KPROBE_ENTRY(spurious_interrupt_bug)
+ENTRY(spurious_interrupt_bug)
 	pushl $0
 	pushl $do_spurious_interrupt_bug
 	jmp error_code

--------------020205010507060004010000
Content-Type: text/x-patch;
 name="kgdb-ipipe.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="kgdb-ipipe.patch"

Index: linux-2.6.16.16/drivers/serial/8250_kgdb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16.16.orig/drivers/serial/8250_kgdb.c
+++ linux-2.6.16.16/drivers/serial/8250_kgdb.c
@@ -301,6 +301,10 @@ static void __init kgdb8250_late_init(vo
 			"GDB-stub", current_port) < 0)
 		printk(KERN_ERR "KGDB failed to request the serial IRQ (%d)\n",
 		       current_port->irq);
+#ifdef CONFIG_IPIPE
+	ipipe_control_irq(current_port->irq, 0,
+			IPIPE_HANDLE_MASK|IPIPE_STICKY_MASK|IPIPE_SYSTEM_MASK);
+#endif /* CONFIG_IPIPE */
 }
=20
 static __init int kgdb_init_io(void)
Index: linux-2.6.16.16/include/linux/kgdb.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16.16.orig/include/linux/kgdb.h
+++ linux-2.6.16.16/include/linux/kgdb.h
@@ -270,6 +270,9 @@ extern int kgdb_handle_exception(int ex_
 extern void kgdb_nmihook(int cpu, void *regs);
 extern int debugger_step;
 extern atomic_t debugger_active;
+
+struct task_struct *ipipe_default_current(void);
+extern struct task_struct *(*ipipe_safe_current)(void);
 #else
 /* Stubs for when KGDB is not set. */
 static const atomic_t debugger_active =3D ATOMIC_INIT(0);
Index: linux-2.6.16.16/kernel/kgdb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16.16.orig/kernel/kgdb.c
+++ linux-2.6.16.16/kernel/kgdb.c
@@ -740,12 +740,12 @@ static void kgdb_wait(struct pt_regs *re
 	unsigned long flags;
 	int processor;
=20
-	local_irq_save(flags);
-	processor =3D smp_processor_id();
+	local_irq_save_hw(flags);
+	processor =3D ipipe_processor_id();
 	kgdb_info[processor].debuggerinfo =3D regs;
-	kgdb_info[processor].task =3D current;
+	kgdb_info[processor].task =3D ipipe_safe_current();
 	atomic_set(&procindebug[processor], 1);
-	atomic_set(&kgdb_sync_softlockup[smp_processor_id()], 1);
+	atomic_set(&kgdb_sync_softlockup[processor], 1);
=20
 	/* Wait till master processor goes completely into the debugger.
 	 * FIXME: this looks racy */
@@ -770,7 +770,7 @@ static void kgdb_wait(struct pt_regs *re
 	/* Signal the master processor that we are done */
 	atomic_set(&procindebug[processor], 0);
 	spin_unlock(&slavecpulocks[processor]);
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
 #endif
=20
@@ -821,7 +821,8 @@ int kgdb_activate_sw_breakpoints(void)
 			return error;
=20
 		if (CACHE_FLUSH_IS_SAFE) {
-			if (current->mm && addr < TASK_SIZE)
+			if (ipipe_safe_current() =3D=3D current &&
+			    current->mm && addr < TASK_SIZE)
 				flush_cache_range(current->mm->mmap_cache,
 						addr, addr + BREAK_INSTR_SIZE);
 			else
@@ -884,8 +885,8 @@ int kgdb_deactivate_sw_breakpoints(void)
 					kgdb_break[i].saved_instr)))
 			return error;
=20
-		if (CACHE_FLUSH_IS_SAFE && current->mm &&
-				addr < TASK_SIZE)
+		if (CACHE_FLUSH_IS_SAFE && ipipe_safe_current() =3D=3D current &&
+				current->mm && addr < TASK_SIZE)
 			flush_cache_range(current->mm->mmap_cache,
 					addr, addr + BREAK_INSTR_SIZE);
 		else if (CACHE_FLUSH_IS_SAFE)
@@ -950,7 +951,7 @@ static inline int shadow_pid(int realpid
 	if (realpid) {
 		return realpid;
 	}
-	return pid_max + smp_processor_id();
+	return pid_max + ipipe_processor_id();
 }
=20
 static char gdbmsgbuf[BUFMAX + 1];
@@ -1014,11 +1015,11 @@ int kgdb_handle_exception(int ex_vector,
 	long kgdb_usethreadid =3D 0;
 	int error =3D 0, all_cpus_synced =3D 0;
 	struct pt_regs *shadowregs;
-	int processor =3D smp_processor_id();
+	int processor =3D ipipe_processor_id();
 	void *local_debuggerinfo;
=20
 	/* Panic on recursive debugger calls. */
-	if (atomic_read(&debugger_active) =3D=3D smp_processor_id() + 1)
+	if (atomic_read(&debugger_active) =3D=3D ipipe_processor_id() + 1)
 		return 0;
=20
       acquirelock:
@@ -1033,10 +1034,10 @@ int kgdb_handle_exception(int ex_vector,
 	 * Interrupts will be restored by the 'trap return' code, except when
 	 * single stepping.
 	 */
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
=20
 	/* Hold debugger_active */
-	procid =3D smp_processor_id();
+	procid =3D ipipe_processor_id();
=20
 	while (cmpxchg(&atomic_read(&debugger_active), 0, (procid + 1)) !=3D 0)=
 {
 		int i =3D 25;	/* an arbitrary number */
@@ -1049,7 +1050,7 @@ int kgdb_handle_exception(int ex_vector,
 			udelay(1);
 	}
=20
-	atomic_set(&kgdb_sync_softlockup[smp_processor_id()], 1);
+	atomic_set(&kgdb_sync_softlockup[procid], 1);
=20
 	/*
 	 * Don't enter if the last instance of the exception handler wanted to
@@ -1058,7 +1059,7 @@ int kgdb_handle_exception(int ex_vector,
 	if (atomic_read(&cpu_doing_single_step) !=3D -1 &&
 	    atomic_read(&cpu_doing_single_step) !=3D procid) {
 		atomic_set(&debugger_active, 0);
-		local_irq_restore(flags);
+		local_irq_restore_hw(flags);
 		goto acquirelock;
 	}
=20
@@ -1069,7 +1070,7 @@ int kgdb_handle_exception(int ex_vector,
 		goto kgdb_restore;
=20
 	kgdb_info[processor].debuggerinfo =3D linux_regs;
-	kgdb_info[processor].task =3D current;
+	kgdb_info[processor].task =3D ipipe_safe_current();
=20
 	kgdb_disable_hw_debug(linux_regs);
=20
@@ -1121,7 +1122,8 @@ int kgdb_handle_exception(int ex_vector,
 		*ptr++ =3D hexchars[(signo >> 4) % 16];
 		*ptr++ =3D hexchars[signo % 16];
 		ptr +=3D strlen(strcpy(ptr, "thread:"));
-		int_to_threadref(&thref, shadow_pid(current->pid));
+		int_to_threadref(&thref,
+		                 shadow_pid(ipipe_safe_current()->pid));
 		ptr =3D pack_threadid(ptr, &thref);
 		*ptr++ =3D ';';
=20
@@ -1213,7 +1215,8 @@ int kgdb_handle_exception(int ex_vector,
 			kgdb_hex2mem(&remcom_in_buffer[1], (char *)gdb_regs,
 				     NUMREGBYTES);
=20
-			if (kgdb_usethread && kgdb_usethread !=3D current)
+			if (kgdb_usethread &&
+			    kgdb_usethread !=3D ipipe_safe_current())
 				error_packet(remcom_out_buffer, -EINVAL);
 			else {
 				gdb_regs_to_regs(gdb_regs, linux_regs);
@@ -1334,7 +1337,8 @@ int kgdb_handle_exception(int ex_vector,
 				/* Current thread id */
 				strcpy(remcom_out_buffer, "QC");
=20
-				threadid =3D shadow_pid(current->pid);
+				threadid =3D
+					shadow_pid(ipipe_safe_current()->pid);
=20
 				int_to_threadref(&thref, threadid);
 				pack_threadid(remcom_out_buffer + 2, &thref);
@@ -1488,7 +1492,8 @@ int kgdb_handle_exception(int ex_vector,
 			break;
 		case 'c':
 		case 's':
-			if (kgdb_contthread && kgdb_contthread !=3D current) {
+			if (kgdb_contthread &&
+			    kgdb_contthread !=3D ipipe_safe_current()) {
 				/* Can't switch threads in kgdb */
 				error_packet(remcom_out_buffer, -EINVAL);
 				break;
@@ -1556,7 +1561,7 @@ int kgdb_handle_exception(int ex_vector,
 kgdb_restore:
 	/* Free debugger_active */
 	atomic_set(&debugger_active, 0);
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
=20
 	return error;
 }
@@ -1925,9 +1930,9 @@ static int kgdb_notify_reboot(struct not
 	if (!kgdb_connected || atomic_read(&debugger_active) !=3D 0)
 		return 0;
 	if ((code =3D=3D SYS_RESTART) || (code =3D=3D SYS_HALT) || (code =3D=3D=
 SYS_POWER_OFF)){
-		local_irq_save(flags);
+		local_irq_save_hw(flags);
 		put_packet("X00");
-		local_irq_restore(flags);
+		local_irq_restore_hw(flags);
 	}
 	return NOTIFY_DONE;
 }
@@ -1942,9 +1947,9 @@ void kgdb_console_write(struct console *
 	if (!kgdb_connected || atomic_read(&debugger_active) !=3D 0)
 		return;
=20
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	kgdb_msg_write(s, count);
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
=20
 struct console kgdbcons =3D {
@@ -1974,3 +1979,12 @@ static int __init opt_kgdb_enter(char *s
 }
=20
 early_param("kgdbwait", opt_kgdb_enter);
+
+struct task_struct *ipipe_default_current(void)
+{
+	return current;
+}
+EXPORT_SYMBOL(ipipe_default_current);
+
+struct task_struct *(*ipipe_safe_current)(void) =3D ipipe_default_curren=
t;
+EXPORT_SYMBOL(ipipe_safe_current);
Index: linux-2.6.16.16/lib/Kconfig.debug
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16.16.orig/lib/Kconfig.debug
+++ linux-2.6.16.16/lib/Kconfig.debug
@@ -273,7 +273,7 @@ choice
=20
 config KGDB_ONLY_MODULES
 	bool "KGDB: Use only kernel modules for I/O"
-	depends on MODULES
+	depends on MODULES && !IPIPE
 	help
 	  Use only kernel modules to configure KGDB I/O after the
 	  kernel is booted.
@@ -318,7 +318,7 @@ config KGDB_SIBYTE
 endchoice
=20
 config KGDBOE
-	tristate "KGDB: On ethernet" if !KGDBOE_NOMODULE
+	tristate "KGDB: On ethernet" if !KGDBOE_NOMODULE && !IPIPE
 	depends on m && KGDB
 	select NETPOLL
 	select NETPOLL_TRAP

--------------020205010507060004010000
Content-Type: text/x-patch;
 name="kgdb-ipipe-x86.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="kgdb-ipipe-x86.patch"

Index: linux-2.6.16.16/arch/i386/kernel/entry.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16.16.orig/arch/i386/kernel/entry.S
+++ linux-2.6.16.16/arch/i386/kernel/entry.S
@@ -194,7 +194,7 @@ VM_MASK		=3D 0x00020000
 .previous
=20
=20
-ENTRY(ret_from_fork)
+KPROBE_ENTRY(ret_from_fork)
 	STI_COND_HW
 	pushl %eax
 	call schedule_tail
@@ -584,7 +584,7 @@ ENTRY(simd_coprocessor_error)
 	PUSH_XCODE(do_simd_coprocessor_error)
 	jmp error_code
=20
-ENTRY(device_not_available)
+KPROBE_ENTRY(device_not_available)
 	pushl $-1			# mark this as an int
 	SAVE_ALL
 	DIVERT_EXCEPTION(device_not_available)
@@ -769,7 +769,7 @@ ENTRY(machine_check)
 	jmp error_code
 #endif
=20
-ENTRY(spurious_interrupt_bug)
+KPROBE_ENTRY(spurious_interrupt_bug)
 	pushl $0
 	PUSH_XCODE(do_spurious_interrupt_bug)
 	jmp error_code
Index: linux-2.6.16.16/arch/i386/kernel/ipipe-root.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16.16.orig/arch/i386/kernel/ipipe-root.c
+++ linux-2.6.16.16/arch/i386/kernel/ipipe-root.c
@@ -34,6 +34,9 @@
 #include <asm/irq.h>
 #include <asm/desc.h>
 #include <asm/io.h>
+#ifdef CONFIG_KGDB
+#include <linux/kgdb.h>
+#endif /* CONFIG_KGDB */
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/tlbflush.h>
 #include <asm/fixmap.h>
@@ -422,8 +425,44 @@ static __ipipe_exptr __ipipe_std_extable
 	[ex_do_iret_error] =3D &do_iret_error,
 };
=20
+#ifdef CONFIG_KGDB
+static int __ipipe_xlate_signo[] =3D {
+
+	[ex_do_divide_error] =3D SIGFPE,
+	[ex_do_debug] =3D SIGTRAP,
+	[2] =3D -1,
+	[ex_do_int3] =3D SIGTRAP,
+	[ex_do_overflow] =3D SIGSEGV,
+	[ex_do_bounds] =3D SIGSEGV,
+	[ex_do_invalid_op] =3D SIGILL,
+	[ex_device_not_available] =3D -1,
+	[8] =3D -1,
+	[ex_do_coprocessor_segment_overrun] =3D SIGFPE,
+	[ex_do_invalid_TSS] =3D SIGSEGV,
+	[ex_do_segment_not_present] =3D SIGBUS,
+	[ex_do_stack_segment] =3D SIGBUS,
+	[ex_do_general_protection] =3D SIGSEGV,
+	[ex_do_page_fault] =3D SIGSEGV,
+	[ex_do_spurious_interrupt_bug] =3D -1,
+	[ex_do_coprocessor_error] =3D -1,
+	[ex_do_alignment_check] =3D SIGBUS,
+	[ex_machine_check_vector] =3D -1,
+	[ex_do_simd_coprocessor_error] =3D -1,
+	[20 ... 31] =3D -1,
+	[ex_do_iret_error] =3D SIGSEGV,
+};
+#endif /* CONFIG_KGDB */
+
 fastcall int __ipipe_handle_exception(struct pt_regs *regs, long error_c=
ode, int vector)
 {
+#ifdef CONFIG_KGDB
+	/* catch exception KGDB is interested in over non-root domains */
+	if ((ipipe_current_domain !=3D ipipe_root_domain) &&
+	    (__ipipe_xlate_signo[vector] >=3D 0) &&
+	    !kgdb_handle_exception(vector, __ipipe_xlate_signo[vector], error_c=
ode, regs))
+		return 1;
+#endif /* CONFIG_KGDB */
+
 	if (!__ipipe_event_pipelined_p(vector) ||
 	    __ipipe_dispatch_event(vector,regs) =3D=3D 0) {
 		__ipipe_exptr handler =3D __ipipe_std_extable[vector];
@@ -437,6 +476,19 @@ fastcall int __ipipe_handle_exception(st
=20
 fastcall int __ipipe_divert_exception(struct pt_regs *regs, int vector)
 {
+#ifdef CONFIG_KGDB
+	/* catch int1 and int3 over non-root domains */
+	if ((ipipe_current_domain !=3D ipipe_root_domain) &&
+	    (vector !=3D ex_device_not_available)) {
+		unsigned int condition =3D 0;
+
+		if (vector =3D=3D 1)
+			get_debugreg(condition, 6);
+		if (!kgdb_handle_exception(vector, SIGTRAP, condition, regs))
+			return 1;
+	}
+#endif /* CONFIG_KGDB */
+
 	if (__ipipe_event_pipelined_p(vector) &&
 	    __ipipe_dispatch_event(vector,regs) !=3D 0)
 		return 1;
Index: linux-2.6.16.16/arch/i386/kernel/kgdb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16.16.orig/arch/i386/kernel/kgdb.c
+++ linux-2.6.16.16/arch/i386/kernel/kgdb.c
@@ -276,7 +276,8 @@ int kgdb_arch_handle_exception(int e_vec
 		if (remcom_in_buffer[0] =3D=3D 's') {
 			linux_regs->eflags |=3D TF_MASK;
 			debugger_step =3D 1;
-			atomic_set(&cpu_doing_single_step,smp_processor_id());
+			atomic_set(&cpu_doing_single_step,
+			           ipipe_processor_id());
 		}
=20
 		asm volatile ("movl %%db6, %0\n":"=3Dr" (dr6));
@@ -319,7 +320,7 @@ static int kgdb_notify(struct notifier_b
        else if ((cmd =3D=3D DIE_NMI || cmd =3D=3D DIE_NMI_IPI ||
                cmd =3D=3D DIE_NMIWATCHDOG) && atomic_read(&debugger_acti=
ve)) {
                /* CPU roundup */
-               kgdb_nmihook(smp_processor_id(), regs);
+               kgdb_nmihook(ipipe_processor_id(), regs);
                return NOTIFY_STOP;
        } else if (cmd =3D=3D DIE_NMI_IPI || cmd =3D=3D DIE_NMI || user_m=
ode(regs) ||
                        (cmd =3D=3D DIE_DEBUG && atomic_read(&debugger_ac=
tive)))

--------------020205010507060004010000
Content-Type: text/plain;
 name="series"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="series"

core-lite.patch
8250.patch
netpoll_pass_skb_to_rx_hook.patch
eth.patch
i386-lite.patch
powerpc-lite.patch
mips-lite.patch
ia64-lite.patch
x86_64-no_context_hook.patch
x86_64-lite.patch
sh-lite.patch
arm-lite.patch
cfi_annotations.patch
sysrq_bugfix.patch
module.patch
core.patch
i386.patch
powerpc.patch
ia64.patch
prepare-kgdb-ipipe-x86.patch
adeos-ipipe-2.6.16-i386-1.3-04.patch
kgdb-ipipe.patch
kgdb-ipipe-x86.patch

--------------020205010507060004010000
Content-Type: text/x-patch;
 name="xeno-kgdb-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xeno-kgdb-v2.patch"

Index: ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/pod.c	(Revision 1126)
+++ ksrc/nucleus/pod.c	(Arbeitskopie)
@@ -234,6 +234,13 @@ static void xnpod_flush_heap(xnheap_t *=20
     xnarch_sysfree(extaddr, extsize);
 }
=20
+static inline struct task_struct * do_safe_current(void)
+{
+    return xnpod_userspace_p() ? current : &init_task;
+}
+
+RTHAL_DECLARE_SAFE_CURRENT(safe_current);
+
 /*!=20
  * \fn int xnpod_init(xnpod_t *pod,int minpri,int maxpri,xnflags_t flags=
)
  * \brief Initialize a new pod.
@@ -373,6 +380,7 @@ int xnpod_init(xnpod_t *pod, int minpri,
        the remaining operations. */
=20
     nkpod =3D pod;
+    rthal_hook_safe_current(safe_current);
=20
     /* No direct handler here since the host timer processing is
        postponed to xnintr_irq_handler(), as part of the interrupt
@@ -477,6 +485,7 @@ int xnpod_init(xnpod_t *pod, int minpri,
=20
         if (err) {
           fail:
+            rthal_release_safe_current();
             nkpod =3D NULL;
             return err;
         }
@@ -607,6 +616,7 @@ void xnpod_shutdown(int xtype)
=20
     xnheap_destroy(&kheap, &xnpod_flush_heap, NULL);
=20
+    rthal_release_safe_current();
     nkpod =3D NULL;
=20
   unlock_and_exit:
Index: include/asm-generic/hal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-generic/hal.h	(Revision 1126)
+++ include/asm-generic/hal.h	(Arbeitskopie)
@@ -573,6 +573,25 @@ struct proc_dir_entry *__rthal_add_proc_
 					      struct proc_dir_entry *parent);
 #endif /* CONFIG_PROC_FS */
=20
+#ifdef CONFIG_KGDB
+#include <linux/kgdb.h>
+
+#define rthal_hook_safe_current(handler) \
+    ipipe_safe_current =3D handler
+#define rthal_release_safe_current() \
+    ipipe_safe_current =3D ipipe_default_current
+
+#define RTHAL_DECLARE_SAFE_CURRENT(handler) \
+static struct task_struct *handler(void) \
+{ \
+    return do_##handler(); \
+}
+#else /* !CONFIG_KGDB */
+#define rthal_hook_safe_current(handler)	do { } while (0)
+#define rthal_release_safe_current()		do { } while (0)
+#define RTHAL_DECLARE_SAFE_CURRENT(handler)
+#endif /* CONFIG_KGDB */
+
 #ifdef __cplusplus
 }
 #endif /* __cplusplus */

--------------020205010507060004010000--

--------------enig5A44BD7133E96B69DE78D820
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEcgvRniDOoMHTA+kRAg6iAJ4hOUZBevmBl22gTXmwTx2uDkhkMgCcDO7q
ZDgpIQB+JlJ3uFBY1yROgoU=
=3iGw
-----END PGP SIGNATURE-----

--------------enig5A44BD7133E96B69DE78D820--

