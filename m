Message-ID: <4510E84C.90807@domain.hid>
Date: Wed, 20 Sep 2006 09:05:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030102080600030404070000"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix for kgbd patch
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, adeos-main@gna.org

This is a multi-part message in MIME format.
--------------030102080600030404070000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

the kgdb-over-ipipe add-on patches available from gna.org contain two
bugs that prevents stepping through Xenomai kernel threads. The attached
update fixes them. It also contains the workaround to build kgdb with
gcc-3.4 (before 3.4.4) and 4.1 (before 4.1.2).

Tested on 2.6.17.13 with latest kgdb from CVS.

Jan

--------------030102080600030404070000
Content-Type: text/x-patch;
 name="core-kgdb-CVS-20060920-ipipe-i386.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="core-kgdb-CVS-20060920-ipipe-i386.patch"

Index: linux-2.6.17.13/arch/i386/kernel/kgdb.c
===================================================================
--- linux-2.6.17.13.orig/arch/i386/kernel/kgdb.c
+++ linux-2.6.17.13/arch/i386/kernel/kgdb.c
@@ -43,6 +43,11 @@
 
 #include "mach_ipi.h"
 
+#if defined(CONFIG_KGDB) && defined(CONFIG_IPIPE)
+#undef smp_processor_id
+#define smp_processor_id    ipipe_processor_id
+#endif
+
 /* Put the error code here just in case the user cares.  */
 int gdb_i386errcode;
 /* Likewise, the vector number here (since GDB only gets the signal
Index: linux-2.6.17.13/drivers/serial/8250_kgdb.c
===================================================================
--- linux-2.6.17.13.orig/drivers/serial/8250_kgdb.c
+++ linux-2.6.17.13/drivers/serial/8250_kgdb.c
@@ -301,6 +301,10 @@ static void __init kgdb8250_late_init(vo
 			"GDB-stub", current_port) < 0)
 		printk(KERN_ERR "KGDB failed to request the serial IRQ (%d)\n",
 		       current_port->irq);
+#ifdef CONFIG_IPIPE
+	ipipe_control_irq(current_port->irq, 0,
+			IPIPE_HANDLE_MASK|IPIPE_STICKY_MASK|IPIPE_SYSTEM_MASK);
+#endif /* CONFIG_IPIPE */
 }
 
 static __init int kgdb_init_io(void)
Index: linux-2.6.17.13/kernel/Makefile
===================================================================
--- linux-2.6.17.13.orig/kernel/Makefile
+++ linux-2.6.17.13/kernel/Makefile
@@ -41,6 +41,8 @@ obj-$(CONFIG_RCU_TORTURE_TEST) += rcutor
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_IPIPE) += ipipe/
 
+CFLAGS_kgdb.o += -fno-unit-at-a-time
+
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@domain.hid>, the -fno-omit-frame-pointer is
 # needed for x86 only.  Why this used to be enabled for all architectures is beyond
Index: linux-2.6.17.13/kernel/kgdb.c
===================================================================
--- linux-2.6.17.13.orig/kernel/kgdb.c
+++ linux-2.6.17.13/kernel/kgdb.c
@@ -50,6 +50,15 @@
 #include <linux/sched.h>
 #include <asm/byteorder.h>
 
+#if defined(CONFIG_KGDB) && defined(CONFIG_IPIPE)
+#undef smp_processor_id
+#undef local_irq_save
+#undef local_irq_restore
+#define smp_processor_id    ipipe_processor_id
+#define local_irq_save      local_irq_save_hw
+#define local_irq_restore   local_irq_restore_hw
+#endif
+
 extern int pid_max;
 /* How many times to count all of the waiting CPUs */
 #define ROUNDUP_WAIT		640000	/* Arbitrary, increase if needed. */
@@ -714,7 +723,7 @@ void int_to_threadref(threadref * id, in
 static struct task_struct *getthread(struct pt_regs *regs, int tid)
 {
 	if (last_pid != 0)
-		return current;
+		return ipipe_safe_current();
 
 	if (num_online_cpus() &&
 	    (tid >= pid_max + num_online_cpus() + kgdb_ops->shadowth))
@@ -742,7 +751,7 @@ static void kgdb_wait(struct pt_regs *re
 	local_irq_save(flags);
 	processor = smp_processor_id();
 	kgdb_info[processor].debuggerinfo = regs;
-	kgdb_info[processor].task = current;
+	kgdb_info[processor].task = ipipe_safe_current();
 	atomic_set(&procindebug[processor], 1);
 	atomic_set(&kgdb_sync_softlockup[smp_processor_id()], 1);
 
@@ -820,7 +829,8 @@ int kgdb_activate_sw_breakpoints(void)
 			return error;
 
 		if (CACHE_FLUSH_IS_SAFE) {
-			if (current->mm && addr < TASK_SIZE)
+			if (ipipe_safe_current() == current && current->mm &&
+				addr < TASK_SIZE)
 				flush_cache_range(current->mm->mmap_cache,
 						addr, addr + BREAK_INSTR_SIZE);
 			else
@@ -883,8 +893,8 @@ int kgdb_deactivate_sw_breakpoints(void)
 					kgdb_break[i].saved_instr)))
 			return error;
 
-		if (CACHE_FLUSH_IS_SAFE && current->mm &&
-				addr < TASK_SIZE)
+		if (CACHE_FLUSH_IS_SAFE && ipipe_safe_current() == current &&
+				current->mm && addr < TASK_SIZE)
 			flush_cache_range(current->mm->mmap_cache,
 					addr, addr + BREAK_INSTR_SIZE);
 		else if (CACHE_FLUSH_IS_SAFE)
@@ -1068,7 +1078,7 @@ int kgdb_handle_exception(int ex_vector,
 		goto kgdb_restore;
 
 	kgdb_info[processor].debuggerinfo = linux_regs;
-	kgdb_info[processor].task = current;
+	kgdb_info[processor].task = ipipe_safe_current();
 
 	kgdb_disable_hw_debug(linux_regs);
 
@@ -1120,7 +1130,8 @@ int kgdb_handle_exception(int ex_vector,
 		*ptr++ = hexchars[(signo >> 4) % 16];
 		*ptr++ = hexchars[signo % 16];
 		ptr += strlen(strcpy(ptr, "thread:"));
-		int_to_threadref(&thref, shadow_pid(current->pid));
+		int_to_threadref(&thref,
+		                 shadow_pid(ipipe_safe_current()->pid));
 		ptr = pack_threadid(ptr, &thref);
 		*ptr++ = ';';
 
@@ -1212,7 +1223,8 @@ int kgdb_handle_exception(int ex_vector,
 			kgdb_hex2mem(&remcom_in_buffer[1], (char *)gdb_regs,
 				     NUMREGBYTES);
 
-			if (kgdb_usethread && kgdb_usethread != current)
+			if (kgdb_usethread &&
+			    kgdb_usethread != ipipe_safe_current())
 				error_packet(remcom_out_buffer, -EINVAL);
 			else {
 				gdb_regs_to_regs(gdb_regs, linux_regs);
@@ -1333,7 +1345,8 @@ int kgdb_handle_exception(int ex_vector,
 				/* Current thread id */
 				strcpy(remcom_out_buffer, "QC");
 
-				threadid = shadow_pid(current->pid);
+				threadid =
+					shadow_pid(ipipe_safe_current()->pid);
 
 				int_to_threadref(&thref, threadid);
 				pack_threadid(remcom_out_buffer + 2, &thref);
@@ -1487,7 +1500,8 @@ int kgdb_handle_exception(int ex_vector,
 			break;
 		case 'c':
 		case 's':
-			if (kgdb_contthread && kgdb_contthread != current) {
+			if (kgdb_contthread &&
+			    kgdb_contthread != ipipe_safe_current()) {
 				/* Can't switch threads in kgdb */
 				error_packet(remcom_out_buffer, -EINVAL);
 				break;
Index: linux-2.6.17.13/lib/Kconfig.debug
===================================================================
--- linux-2.6.17.13.orig/lib/Kconfig.debug
+++ linux-2.6.17.13/lib/Kconfig.debug
@@ -274,7 +274,7 @@ choice
 
 config KGDB_ONLY_MODULES
 	bool "KGDB: Use only kernel modules for I/O"
-	depends on MODULES
+	depends on MODULES && !IPIPE
 	help
 	  Use only kernel modules to configure KGDB I/O after the
 	  kernel is booted.
@@ -319,7 +319,7 @@ config KGDB_SIBYTE
 endchoice
 
 config KGDBOE
-	tristate "KGDB: On ethernet" if !KGDBOE_NOMODULE
+	tristate "KGDB: On ethernet" if !KGDBOE_NOMODULE && !IPIPE
 	depends on m && KGDB
 	select NETPOLL
 	select NETPOLL_TRAP

--------------030102080600030404070000--

