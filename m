Message-ID: <4467860A.9020103@domain.hid>
Date: Sun, 14 May 2006 21:33:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3EA57FE11F10B0356CFCA8A0"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [patch] kgdb for ipipe - updated version
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
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3EA57FE11F10B0356CFCA8A0
Content-Type: multipart/mixed; boundary="------------080401080306070509040402"

This is a multi-part message in MIME format.
--------------080401080306070509040402
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi all,

here is an improved version of the kgdb-over-ipipe patch. This version
specifically addresses the concerns Gilles brought up recently:

o No more dependencies on Xenomai, thus also no need to have the nucleus
  compiled into the kernel. There is now a registrable handler,
  ipipe_safe_current, which is invoked by the kgdb code to obtain
  "current". When the xeno nucleus arms its services, it overloads this
  handler to always provide a valid current (either the real one or
  init_task for kernel-only threads).

o Replaced smp_processor_id with ipipe_processor_id in critical kgdb
  code. I haven't tested this replacement, so no guarantees here. But so
  far it looks consistent - at least for me.

To use the kernel debugger with Xenomai, you need the latest kgdb
patches [1] and have to follow the attached patch series.

[BTW, there is a real alternative in case debugging does not concern
hardware drivers or specific timing issues: QEMU in debugging mode. This
is a really handy and fast way do step through the nucleus and skins,
just give it a try!]

Jan


[1] CVSROOT=3D":pserver:anonymous@domain.hid"

--------------080401080306070509040402
Content-Type: text/x-patch;
 name="kgdb-ipipe.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="kgdb-ipipe.patch"

Index: linux-2.6.15.3-kgdb/kernel/kgdb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.3-kgdb.orig/kernel/kgdb.c
+++ linux-2.6.15.3-kgdb/kernel/kgdb.c
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
-	atomic_set(&kgdb_sync_softlockup[smp_processor_id()],1);
+	atomic_set(&kgdb_sync_softlockup[ipipe_processor_id()],1);
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
 				flush_cache_range(current->mm->mmap_cache,=20
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
@@ -1056,11 +1057,11 @@ int kgdb_handle_exception(int ex_vector,
 	if (atomic_read(&cpu_doing_single_step) !=3D -1 &&
 	    atomic_read(&cpu_doing_single_step) !=3D procid) {
 		atomic_set(&debugger_active, 0);
-		local_irq_restore(flags);
+		local_irq_restore_hw(flags);
 		goto acquirelock;
 	}
=20
-	atomic_set(&kgdb_sync_softlockup[smp_processor_id()], 1);
+	atomic_set(&kgdb_sync_softlockup[ipipe_processor_id()], 1);
 =09
 	/*
 	* Don't enter if we have hit a removed breakpoint.
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
 }	=09
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
 static struct console kgdbcons =3D {
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
Index: linux-2.6.15.3-kgdb/drivers/serial/8250_kgdb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.3-kgdb.orig/drivers/serial/8250_kgdb.c
+++ linux-2.6.15.3-kgdb/drivers/serial/8250_kgdb.c
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
Index: linux-2.6.15.3-kgdb/lib/Kconfig.debug
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.3-kgdb.orig/lib/Kconfig.debug
+++ linux-2.6.15.3-kgdb/lib/Kconfig.debug
@@ -250,7 +250,7 @@ choice
=20
 config KGDB_ONLY_MODULES
 	bool "KGDB: Use only kernel modules for I/O"
-	depends on MODULES
+	depends on MODULES && !IPIPE
 	help
 	  Use only kernel modules to configure KGDB I/O after the
 	  kernel is booted.
@@ -295,7 +295,7 @@ config KGDB_SIBYTE
 endchoice
=20
 config KGDBOE
-	tristate "KGDB: On ethernet" if !KGDBOE_NOMODULE
+	tristate "KGDB: On ethernet" if !KGDBOE_NOMODULE && !IPIPE
 	depends on m && KGDB
 	select NETPOLL
 	select NETPOLL_TRAP
Index: linux-2.6.15.3-kgdb/include/linux/kgdb.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.3-kgdb.orig/include/linux/kgdb.h
+++ linux-2.6.15.3-kgdb/include/linux/kgdb.h
@@ -267,6 +267,9 @@ extern int kgdb_handle_exception(int ex_
 extern void kgdb_nmihook(int cpu, void *regs);
 extern int debugger_step;
 extern atomic_t debugger_active;
+
+struct task_struct *ipipe_default_current(void);
+extern struct task_struct *(*ipipe_safe_current)(void);
 #else
 /* Stubs for when KGDB is not set. */
 static const atomic_t debugger_active =3D ATOMIC_INIT(0);

--------------080401080306070509040402
Content-Type: text/x-patch;
 name="kgdb-ipipe-x86.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="kgdb-ipipe-x86.patch"

Index: linux-2.6.15.3-kgdb/arch/i386/kernel/entry.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.3-kgdb.orig/arch/i386/kernel/entry.S
+++ linux-2.6.15.3-kgdb/arch/i386/kernel/entry.S
@@ -194,7 +194,7 @@ VM_MASK		=3D 0x00020000
 .previous
=20
=20
-ENTRY(ret_from_fork)
+KPROBE_ENTRY(ret_from_fork)
 	STI_COND_HW
 	pushl %eax
 	call schedule_tail
@@ -582,7 +582,7 @@ ENTRY(simd_coprocessor_error)
 	PUSH_XCODE(do_simd_coprocessor_error)
 	jmp error_code
=20
-ENTRY(device_not_available)
+KPROBE_ENTRY(device_not_available)
 	pushl $-1			# mark this as an int
 	SAVE_ALL
 	DIVERT_EXCEPTION(device_not_available)
@@ -767,7 +767,7 @@ ENTRY(machine_check)
 	jmp error_code
 #endif
=20
-ENTRY(spurious_interrupt_bug)
+KPROBE_ENTRY(spurious_interrupt_bug)
 	pushl $0
 	PUSH_XCODE(do_spurious_interrupt_bug)
 	jmp error_code
Index: linux-2.6.15.3-kgdb/arch/i386/kernel/ipipe-root.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.3-kgdb.orig/arch/i386/kernel/ipipe-root.c
+++ linux-2.6.15.3-kgdb/arch/i386/kernel/ipipe-root.c
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
Index: linux-2.6.15.3-kgdb/arch/i386/kernel/kgdb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.3-kgdb.orig/arch/i386/kernel/kgdb.c
+++ linux-2.6.15.3-kgdb/arch/i386/kernel/kgdb.c
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

--------------080401080306070509040402
Content-Type: text/x-patch;
 name="prepare-kgdb-ipipe-x86.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="prepare-kgdb-ipipe-x86.patch"

Index: linux-2.6.15.3-kgdb/arch/i386/kernel/entry.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.3-kgdb.orig/arch/i386/kernel/entry.S
+++ linux-2.6.15.3-kgdb/arch/i386/kernel/entry.S
@@ -123,7 +123,7 @@ VM_MASK		=3D 0x00020000
 .previous
=20
=20
-KPROBE_ENTRY(ret_from_fork)
+ENTRY(ret_from_fork)
 	pushl %eax
 	call schedule_tail
 	GET_THREAD_INFO(%ebp)
@@ -470,7 +470,7 @@ ENTRY(simd_coprocessor_error)
 	pushl $do_simd_coprocessor_error
 	jmp error_code
=20
-KPROBE_ENTRY(device_not_available)
+ENTRY(device_not_available)
 	pushl $-1			# mark this as an int
 	SAVE_ALL
 	movl %cr0, %eax
@@ -652,7 +652,7 @@ ENTRY(machine_check)
 	jmp error_code
 #endif
=20
-KPROBE_ENTRY(spurious_interrupt_bug)
+ENTRY(spurious_interrupt_bug)
 	pushl $0
 	pushl $do_spurious_interrupt_bug
 	jmp error_code

--------------080401080306070509040402
Content-Type: text/plain;
 name="series"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="series"

# Patchdir: linux-2.6.15.5
# Source: linux-2.6.15.5.tar.bz2
core-lite.patch=20
8250.patch=20
netpoll_pass_skb_to_rx_hook.patch
eth.patch=20
i386-lite.patch=20
powerpc-lite.patch=20
mips-lite.patch=20
ia64-lite.patch=20
x86_64-no_context_hook.patch
x86_64-lite.patch=20
sh-lite.patch=20
arm-lite.patch=20
cfi_annotations.patch=20
sysrq_bugfix.patch
module.patch=20
core.patch
i386.patch
powerpc.patch
prepare-kgdb-ipipe-x86.patch
adeos-ipipe-2.6.15-i386-1.3-02.patch
kgdb-ipipe.patch
kgdb-ipipe-x86.patch

--------------080401080306070509040402--

--------------enig3EA57FE11F10B0356CFCA8A0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEZ4YKniDOoMHTA+kRAmtbAJ9TT9a5y5MXTT6NcLDJsWA29FvpUgCfbX+h
UQW4xkL1R0u+KpG/rkODQKw=
=+zAx
-----END PGP SIGNATURE-----

--------------enig3EA57FE11F10B0356CFCA8A0--

