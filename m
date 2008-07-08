Message-ID: <48733318.8000502@domain.hid>
Date: Tue, 08 Jul 2008 11:27:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050407000504060409030203"
Subject: [Xenomai-core] [PATCH] kernel debugger support for ipipe (2.6.26)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------050407000504060409030203
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

finally I found a few minutes to port forward our old kgdb patch series,
once developed for a customer on 2.6.24, to latest 2.6.26-rcX.

As you may have heard, 2.6.26 will include a cleaned up and stripped
down kgdb, so far supporting x86 only, but on the way to finally
establish a patch-free kernel debugger for all Linux archs. For
ipipe/Xenomai usage, a few additional patches are still required, both
to kgdb itself as well as for the ipipe patch. Here we go:

- Install latest 2.6.26-rc (I've tested with -rc8)
- Pick up the following three patches from kgdb-dev (in that order):
http://git.kernel.org/?p=linux/kernel/git/jwessel/linux-2.6-kgdb.git;a=commitdiff;h=3ff4f23f5636d18895ac816758b317f44b5cea3d
http://git.kernel.org/?p=linux/kernel/git/jwessel/linux-2.6-kgdb.git;a=commitdiff;h=d147de2975ed851dab4ae9fbb12d5b63a12fd20a
http://git.kernel.org/?p=linux/kernel/git/jwessel/linux-2.6-kgdb.git;a=commitdiff;h=f9193cd86f1b51f4f2ad875718b822e3f0441e9a
- Apply latest ipipe for 2.6.26 (right now
  adeos-ipipe-2.6.26-rc7-x86-2.0-09)
- Apply ipipe-modular-kgdb-support.patch (that one could be merged into
  ipipe git already) and kgdb-2.6.26-ipipe-v3.patch (that depends on
  full-blown kgdb, thus will not apply to vanilla 2.6.26)

Find the latter two patches attached.

Time didn't permit to test this kgdb in all details under Xenomai, but
basic tests look OK, including the new self test of kgdb. Feedback is
welcome!

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------050407000504060409030203
Content-Type: text/x-patch;
 name="ipipe-modular-kgdb-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe-modular-kgdb-support.patch"

---
 arch/x86/kernel/ipipe.c |   88 +++++++++++++++++++++++++++++++-----------------
 include/linux/ipipe.h   |   13 +++++++
 kernel/ipipe/core.c     |   35 +++++++++++++++++++
 3 files changed, 106 insertions(+), 30 deletions(-)

Index: b/arch/x86/kernel/ipipe.c
===================================================================
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -697,8 +697,10 @@ static __ipipe_exptr __ipipe_std_extable
 #endif
 };
 
-#ifdef CONFIG_KGDB
+#if defined(CONFIG_KGDB) || defined(CONFIG_KGDB_MODULE)
 #include <linux/kgdb.h>
+#include <linux/kdebug.h>
+#include <asm/uaccess.h>
 
 static int __ipipe_xlate_signo[] = {
 
@@ -746,24 +748,34 @@ int __ipipe_handle_exception(struct pt_r
 		barrier();
 	}
 
-#ifdef CONFIG_KGDB
-	/* catch exception KGDB is interested in over non-root domains */
-	if (!ipipe_root_domain_p &&
-	    __ipipe_xlate_signo[vector] >= 0 &&
-	    !kgdb_handle_exception(vector, __ipipe_xlate_signo[vector], error_code, regs)) {
-		if (!flags)
-			__clear_bit(IPIPE_STALL_FLAG,
-				    &ipipe_root_cpudom_var(status));
-		return 1;
+#if defined(CONFIG_KGDB) || defined(CONFIG_KGDB_MODULE)
+	if (unlikely(__ipipe_kgdb_notify)) {
+		const struct exception_table_entry *fixup;
+		struct die_args args;
+
+		/* Fixup kgdb-own faults immediately. */
+		if (*__ipipe_kgdb_may_fault) {
+			fixup = search_exception_tables(regs->ip);
+			BUG_ON(!fixup);
+			regs->ip = fixup->fixup;
+			goto exit_stop;
+		}
+
+		/* Catch any exception over non-root domains that
+		 * kgdb might be interested in. */
+		if (!ipipe_root_domain_p && __ipipe_xlate_signo[vector] >= 0) {
+			args.regs = regs;
+			args.err = error_code;
+			args.trapnr = vector;
+			args.signr = __ipipe_xlate_signo[vector];
+			if (__ipipe_kgdb_notify(NULL, DIE_TRAP, &args) == NOTIFY_STOP)
+				goto exit_stop;
+		}
 	}
 #endif /* CONFIG_KGDB */
 
-	if (unlikely(ipipe_trap_notify(vector, regs))) {
-		if (!flags)
-			__clear_bit(IPIPE_STALL_FLAG,
-				    &ipipe_root_cpudom_var(status));
-		return 1;
-	}
+	if (unlikely(ipipe_trap_notify(vector, regs)))
+		goto exit_stop;
 
 	/* Detect unhandled faults over non-root domains. */
 
@@ -800,23 +812,31 @@ int __ipipe_handle_exception(struct pt_r
 	__fixup_if(regs);
 
 	return 0;
+
+exit_stop:
+	if (!flags)
+		__clear_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status));
+	return 1;
 }
 
 int __ipipe_divert_exception(struct pt_regs *regs, int vector)
 {
-#ifdef CONFIG_KGDB
-	/* catch int1 and int3 over non-root domains */
-#ifdef CONFIG_X86_32
-	if (!ipipe_root_domain_p && vector != ex_do_device_not_available) {
-#else
-	if (!ipipe_root_domain_p) {
-#endif
-		unsigned int condition = 0;
-
-		if (vector == 1)
-			get_debugreg(condition, 6);
-		if (!kgdb_handle_exception(vector, SIGTRAP, condition, regs))
-			return 1;
+#if defined(CONFIG_KGDB) || defined(CONFIG_KGDB_MODULE)
+	/* Catch debug and breakpoint exception over non-root domains. */
+	if (__ipipe_kgdb_notify && !ipipe_root_domain_p) {
+		struct die_args args = { .regs = regs, .signr = SIGTRAP };
+
+		if (vector == 1) {
+			get_debugreg(args.err, 6);
+			args.trapnr = 0;
+			if (__ipipe_kgdb_notify(NULL, DIE_DEBUG, &args) == NOTIFY_STOP)
+				return 1;
+		} else if (vector == 3) {
+			args.err = 0;
+			args.trapnr = 3;
+			if (__ipipe_kgdb_notify(NULL, DIE_INT3, &args) == NOTIFY_STOP)
+				return 1;
+		}
 	}
 #endif /* CONFIG_KGDB */
 
@@ -865,8 +885,16 @@ int __ipipe_handle_irq(struct pt_regs *r
 		irq = vector;
 		m_ack = 1;
 	}
-
 #endif /* !CONFIG_X86_32 */
+
+#if defined(CONFIG_KGDB) || defined(CONFIG_KGDB_MODULE)
+	if (unlikely(irq == __ipipe_kgdb_irq)) {
+		ipipe_root_domain->irqs[irq].acknowledge(irq);
+		__ipipe_kgdb_irq_handler(irq, NULL);
+		irq_desc[irq].ipipe_end(irq, &irq_desc[irq]);
+		goto finalize_nosync;
+	}
+#endif /* CONFIG_KGDB */
 	head = __ipipe_pipeline.next;
 	next_domain = list_entry(head, struct ipipe_domain, p_link);
 	if (likely(test_bit(IPIPE_WIRED_FLAG, &next_domain->irqs[irq].control))) {
Index: b/include/linux/ipipe.h
===================================================================
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -26,6 +26,7 @@
 #include <linux/cache.h>
 #include <linux/percpu.h>
 #include <linux/mutex.h>
+#include <linux/notifier.h>
 #include <linux/linkage.h>
 #include <linux/ipipe_base.h>
 #include <linux/ipipe_compat.h>
@@ -512,6 +513,18 @@ static inline void local_irq_restore_nos
 
 #define ipipe_root_domain_p		(ipipe_current_domain == ipipe_root_domain)
 
+extern int *__ipipe_kgdb_may_fault;
+extern int (*__ipipe_kgdb_notify)(struct notifier_block *, unsigned long, void *);
+
+extern int __ipipe_kgdb_irq;
+extern int (*__ipipe_kgdb_irq_handler)(int, void *);
+
+#define IPIPE_KGDB_IRQ_NONE	-1
+
+void ipipe_kgdb_set_fault_handler(int *kgdb_may_fault,
+	int (*handler)(struct notifier_block *, unsigned long, void *));
+void ipipe_kgdb_set_irq_handler(int irq, int (*handler)(int, void *));
+
 #else	/* !CONFIG_IPIPE */
 
 #define ipipe_init()			do { } while(0)
Index: b/kernel/ipipe/core.c
===================================================================
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1586,6 +1586,41 @@ void ipipe_check_context(struct ipipe_do
 EXPORT_SYMBOL(ipipe_check_context);
 #endif /* CONFIG_IPIPE_DEBUG_CONTEXT */
 
+#if defined(CONFIG_KGDB) || defined(CONFIG_KGDB_MODULE)
+int *__ipipe_kgdb_may_fault = NULL;
+int (*__ipipe_kgdb_notify)(struct notifier_block *, unsigned long, void *);
+
+void ipipe_kgdb_set_fault_handler(int *kgdb_may_fault,
+	int (*handler)(struct notifier_block *, unsigned long, void *))
+{
+	unsigned long flags;
+
+	flags = ipipe_critical_enter(NULL);
+
+	__ipipe_kgdb_may_fault = kgdb_may_fault;
+	__ipipe_kgdb_notify = handler;
+
+	ipipe_critical_exit(flags);
+}
+EXPORT_SYMBOL_GPL(ipipe_kgdb_set_fault_handler);
+
+int __ipipe_kgdb_irq = IPIPE_KGDB_IRQ_NONE;
+irq_handler_t __ipipe_kgdb_irq_handler;
+
+void ipipe_kgdb_set_irq_handler(int irq, irq_handler_t handler)
+{
+	unsigned long flags;
+
+	flags = ipipe_critical_enter(NULL);
+
+	__ipipe_kgdb_irq = irq;
+	__ipipe_kgdb_irq_handler = handler;
+
+	ipipe_critical_exit(flags);
+}
+EXPORT_SYMBOL_GPL(ipipe_kgdb_set_irq_handler);
+#endif /* CONFIG_KGDB */
+
 EXPORT_SYMBOL(ipipe_virtualize_irq);
 EXPORT_SYMBOL(ipipe_control_irq);
 EXPORT_SYMBOL(ipipe_suspend_domain);

--------------050407000504060409030203
Content-Type: text/x-patch;
 name="kgdb-2.6.26-ipipe-v3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kgdb-2.6.26-ipipe-v3.patch"

---
 arch/x86/kernel/kgdb.c     |   11 ++++-
 drivers/serial/8250_kgdb.c |   15 ++++++++
 kernel/kgdb.c              |   84 ++++++++++++++++++++++++++++++++-------------
 lib/Kconfig.kgdb           |    1 
 4 files changed, 86 insertions(+), 25 deletions(-)

Index: b/drivers/serial/8250_kgdb.c
===================================================================
--- a/drivers/serial/8250_kgdb.c
+++ b/drivers/serial/8250_kgdb.c
@@ -363,6 +363,9 @@ static int kgdb8250_late_init(void)
 			goto rollback;
 	}
 
+#ifdef CONFIG_IPIPE
+	ipipe_kgdb_set_irq_handler(kgdb8250_port.irq, kgdb8250_interrupt);
+#endif
 	if (request_irq(kgdb8250_port.irq, kgdb8250_interrupt, IRQF_SHARED,
 			"kgdb", &kgdb8250_port) == 0) {
 		/* Turn on RX interrupt only. */
@@ -402,6 +405,14 @@ static void kgdb8250_cleanup(void)
 	kgdb8250_iowrite(0, UART_IER);
 	(void) kgdb8250_ioread(UART_RX);
 
+#ifdef CONFIG_IPIPE
+	/* We cannot run module_get/put over I-pipe domains, so enforce the
+	 * deregistration protocol here. */
+	while (kgdb_connected)
+		kgdb_breakpoint();
+
+	ipipe_kgdb_set_irq_handler(IPIPE_KGDB_IRQ_NONE, NULL);
+#endif /* CONFIG_IPIPE */
 	if (kgdb8250_irq >= 0)
 		free_irq(kgdb8250_irq, &kgdb8250_port);
 
@@ -457,6 +468,7 @@ static int kgdb8250_set_config(const cha
 	return kgdb8250_late_init();
 }
 
+#ifndef CONFIG_IPIPE
 static void kgdb8250_pre_exception_handler(void)
 {
 	if (!kgdb_connected)
@@ -468,14 +480,17 @@ static void kgdb8250_post_exception_hand
 	if (!kgdb_connected)
 		module_put(THIS_MODULE);
 }
+#endif /* !CONFIG_IPIPE */
 
 static struct kgdb_io kgdb8250_io_ops = {
 	.name = "kgdb8250",
 	.read_char = kgdb8250_get_debug_char,
 	.write_char = kgdb8250_put_debug_char,
 	.init = kgdb8250_early_init,
+#ifndef CONFIG_IPIPE
 	.pre_exception = kgdb8250_pre_exception_handler,
 	.post_exception = kgdb8250_post_exception_handler,
+#endif /* !CONFIG_IPIPE */
 };
 
 module_init(kgdb8250_late_init);
Index: b/kernel/kgdb.c
===================================================================
--- a/kernel/kgdb.c
+++ b/kernel/kgdb.c
@@ -162,6 +162,36 @@ early_param("nokgdbroundup", opt_nokgdbr
  * Finally, some KGDB code :-)
  */
 
+#ifdef CONFIG_IPIPE
+int kgdb_may_fault = 0;
+
+static long kgdb_probe_kernel_read(void *dst, void *src, size_t size)
+{
+	long ret;
+
+	kgdb_may_fault = 1;
+	ret = __copy_from_user_inatomic(dst,
+			(__force const void __user *)src, size);
+	kgdb_may_fault = 0;
+
+	return ret ? -EFAULT : 0;
+}
+
+static long kgdb_probe_kernel_write(void *dst, void *src, size_t size)
+{
+	long ret;
+
+	kgdb_may_fault = 1;
+	ret = __copy_to_user_inatomic((__force void __user *)dst, src, size);
+	kgdb_may_fault = 0;
+
+	return ret ? -EFAULT : 0;
+}
+#else
+# define kgdb_probe_kernel_read(dst, src, sz)	probe_kernel_read(dst, src, sz)
+# define kgdb_probe_kernel_write(dst, src, sz)	probe_kernel_write(dst, src, sz)
+#endif
+
 /*
  * Weak aliases for breakpoint management,
  * can be overriden by architectures when needed:
@@ -170,24 +200,24 @@ int __weak kgdb_validate_break_address(u
 {
 	char tmp_variable[BREAK_INSTR_SIZE];
 
-	return probe_kernel_read(tmp_variable, (char *)addr, BREAK_INSTR_SIZE);
+	return kgdb_probe_kernel_read(tmp_variable, (char *)addr, BREAK_INSTR_SIZE);
 }
 
 int __weak kgdb_arch_set_breakpoint(unsigned long addr, char *saved_instr)
 {
 	int err;
 
-	err = probe_kernel_read(saved_instr, (char *)addr, BREAK_INSTR_SIZE);
+	err = kgdb_probe_kernel_read(saved_instr, (char *)addr, BREAK_INSTR_SIZE);
 	if (err)
 		return err;
 
-	return probe_kernel_write((char *)addr, arch_kgdb_ops.gdb_bpt_instr,
+	return kgdb_probe_kernel_write((char *)addr, arch_kgdb_ops.gdb_bpt_instr,
 				  BREAK_INSTR_SIZE);
 }
 
 int __weak kgdb_arch_remove_breakpoint(unsigned long addr, char *bundle)
 {
-	return probe_kernel_write((char *)addr,
+	return kgdb_probe_kernel_write((char *)addr,
 				  (char *)bundle, BREAK_INSTR_SIZE);
 }
 
@@ -360,7 +390,7 @@ int kgdb_mem2hex(char *mem, char *buf, i
 	 */
 	tmp = buf + count;
 
-	err = probe_kernel_read(tmp, mem, count);
+	err = kgdb_probe_kernel_read(tmp, mem, count);
 	if (!err) {
 		while (count > 0) {
 			buf = pack_hex_byte(buf, *tmp);
@@ -389,7 +419,7 @@ static int kgdb_ebin2mem(char *buf, char
 		if (c == 0x7d)
 			c = *buf++ ^ 0x20;
 
-		err = probe_kernel_write(mem, &c, 1);
+		err = kgdb_probe_kernel_write(mem, &c, 1);
 		if (err)
 			break;
 
@@ -422,7 +452,7 @@ int kgdb_hex2mem(char *buf, char *mem, i
 		*tmp_raw |= hex(*tmp_hex--) << 4;
 	}
 
-	return probe_kernel_write(mem, tmp_raw, count);
+	return kgdb_probe_kernel_write(mem, tmp_raw, count);
 }
 
 /*
@@ -538,10 +568,10 @@ static void kgdb_wait(struct pt_regs *re
 	unsigned long flags;
 	int cpu;
 
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	cpu = raw_smp_processor_id();
 	kgdb_info[cpu].debuggerinfo = regs;
-	kgdb_info[cpu].task = current;
+	kgdb_info[cpu].task = ipipe_safe_current();
 	/*
 	 * Make sure the above info reaches the primary CPU before
 	 * our cpu_in_kgdb[] flag setting does:
@@ -562,8 +592,10 @@ static void kgdb_wait(struct pt_regs *re
 
 	/* Signal the primary CPU that we are done: */
 	atomic_set(&cpu_in_kgdb[cpu], 0);
+#ifndef CONFIG_IPIPE
 	clocksource_touch_watchdog();
-	local_irq_restore(flags);
+#endif
+	local_irq_restore_hw(flags);
 }
 #endif
 
@@ -576,7 +608,8 @@ static void kgdb_flush_swbreak_addr(unsi
 	if (!CACHE_FLUSH_IS_SAFE)
 		return;
 
-	if (current->mm && current->mm->mmap_cache) {
+	if (ipipe_safe_current() == current && current->mm &&
+	    current->mm->mmap_cache) {
 		flush_cache_range(current->mm->mmap_cache,
 				  addr, addr + BREAK_INSTR_SIZE);
 	}
@@ -863,7 +896,7 @@ static void gdb_cmd_setregs(struct kgdb_
 {
 	kgdb_hex2mem(&remcom_in_buffer[1], (char *)gdb_regs, NUMREGBYTES);
 
-	if (kgdb_usethread && kgdb_usethread != current) {
+	if (kgdb_usethread && kgdb_usethread != ipipe_safe_current()) {
 		error_packet(remcom_out_buffer, -EINVAL);
 	} else {
 		gdb_regs_to_pt_regs(gdb_regs, ks->linux_regs);
@@ -995,7 +1028,7 @@ static void gdb_cmd_query(struct kgdb_st
 	case 'C':
 		/* Current thread id */
 		strcpy(remcom_out_buffer, "QC");
-		ks->threadid = shadow_pid(current->pid);
+		ks->threadid = shadow_pid(ipipe_safe_current()->pid);
 		int_to_threadref(thref, ks->threadid);
 		pack_threadid(remcom_out_buffer + 2, thref);
 		break;
@@ -1187,7 +1220,7 @@ static int gdb_serial_stub(struct kgdb_s
 		*ptr++ = 'T';
 		ptr = pack_hex_byte(ptr, ks->signo);
 		ptr += strlen(strcpy(ptr, "thread:"));
-		int_to_threadref(thref, shadow_pid(current->pid));
+		int_to_threadref(thref, shadow_pid(ipipe_safe_current()->pid));
 		ptr = pack_threadid(ptr, thref);
 		*ptr++ = ';';
 		put_packet(remcom_out_buffer);
@@ -1257,7 +1290,8 @@ static int gdb_serial_stub(struct kgdb_s
 			/* Fall through on tmp < 0 */
 		case 'c': /* Continue packet */
 		case 's': /* Single step packet */
-			if (kgdb_contthread && kgdb_contthread != current) {
+			if (kgdb_contthread &&
+			    kgdb_contthread != ipipe_safe_current()) {
 				/* Can't switch threads in kgdb */
 				error_packet(remcom_out_buffer, -EINVAL);
 				break;
@@ -1369,7 +1403,7 @@ acquirelock:
 	 * Interrupts will be restored by the 'trap return' code, except when
 	 * single stepping.
 	 */
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 
 	cpu = raw_smp_processor_id();
 
@@ -1388,8 +1422,10 @@ acquirelock:
 	    atomic_read(&kgdb_cpu_doing_single_step) != cpu) {
 
 		atomic_set(&kgdb_active, -1);
+#ifndef CONFIG_IPIPE
 		clocksource_touch_watchdog();
-		local_irq_restore(flags);
+#endif
+		local_irq_restore_hw(flags);
 
 		goto acquirelock;
 	}
@@ -1410,7 +1446,7 @@ acquirelock:
 		kgdb_io_ops->pre_exception();
 
 	kgdb_info[ks->cpu].debuggerinfo = ks->linux_regs;
-	kgdb_info[ks->cpu].task = current;
+	kgdb_info[ks->cpu].task = ipipe_safe_current();
 
 	kgdb_disable_hw_debug(ks->linux_regs);
 
@@ -1480,8 +1516,10 @@ acquirelock:
 kgdb_restore:
 	/* Free kgdb_active */
 	atomic_set(&kgdb_active, -1);
+#ifndef CONFIG_IPIPE
 	clocksource_touch_watchdog();
-	local_irq_restore(flags);
+#endif
+	local_irq_restore_hw(flags);
 
 	return error;
 }
@@ -1509,9 +1547,9 @@ static void kgdb_console_write(struct co
 	if (!kgdb_connected || atomic_read(&kgdb_active) != -1)
 		return;
 
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	kgdb_msg_write(s, count);
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
 
 static struct console kgdbcons = {
@@ -1550,7 +1588,7 @@ kgdb_notify_reboot(struct notifier_block
 		return 0;
 
 	if (code == SYS_RESTART || code == SYS_HALT || code == SYS_POWER_OFF) {
-		local_irq_save(flags);
+		local_irq_save_hw(flags);
 		if (kgdb_io_ops->write_char) {
 			/* Do not use put_packet to avoid hanging
 			 * in case the attached debugger disappeared
@@ -1567,7 +1605,7 @@ kgdb_notify_reboot(struct notifier_block
 				kgdb_io_ops->flush();
 		}
 		kgdb_connected = 0;
-		local_irq_restore(flags);
+		local_irq_restore_hw(flags);
 	}
 	return NOTIFY_DONE;
 }
Index: b/arch/x86/kernel/kgdb.c
===================================================================
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -489,9 +489,9 @@ kgdb_notify(struct notifier_block *self,
 	unsigned long flags;
 	int ret;
 
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	ret = __kgdb_notify(ptr, cmd);
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 
 	return ret;
 }
@@ -513,6 +513,10 @@ static struct notifier_block kgdb_notifi
  */
 int kgdb_arch_init(void)
 {
+#ifdef CONFIG_IPIPE
+	extern int kgdb_may_fault;
+	ipipe_kgdb_set_fault_handler(&kgdb_may_fault, kgdb_notify);
+#endif
 	return register_die_notifier(&kgdb_notifier);
 }
 
@@ -525,6 +529,9 @@ int kgdb_arch_init(void)
 void kgdb_arch_exit(void)
 {
 	unregister_die_notifier(&kgdb_notifier);
+#ifdef CONFIG_IPIPE
+	ipipe_kgdb_set_fault_handler(NULL, NULL);
+#endif
 }
 
 /**
Index: b/lib/Kconfig.kgdb
===================================================================
--- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -20,6 +20,7 @@ if KGDB
 
 config KGDB_SERIAL_CONSOLE
 	tristate "KGDB: use kgdb over the serial console"
+	depends on !IPIPE
 	select CONSOLE_POLL
 	select MAGIC_SYSRQ
 	default y

--------------050407000504060409030203--

