Message-ID: <448B4589.6030101@domain.hid>
Date: Sun, 11 Jun 2006 00:19:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44720BD1.805@domain.hid>
	<447E9E9E.6070301@domain.hid>	<4486FCA3.2070501@domain.hid>
	<448703C2.8030601@domain.hid> <4487DEC5.50705@domain.hid>
In-Reply-To: <4487DEC5.50705@domain.hid>
Content-Type: multipart/mixed; boundary="------------020103080309020800070409"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [PATCH] kgdb/x86 over I-pipe
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------020103080309020800070409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>
>>> Hi Jan,
>>>
>>> Based on your previous work, here is a set of patches coupling KGDB and
>>> the I-pipe. Basically, I've attempted to shrink the extra patches needed
>>> against the original KGDB + I-pipe ones to the bare minimum. This has
>>> been obtained by having the I-pipe provide ipipe_current_safe(), and
>>> drastically reduce the amount of fiddling with smp_processor_id().
>>>
>>> The key difference with the former implementation is that a domain (e.g.
>>> Xenomai) is now expected to tell the I-pipe when it's switching to a
>>> non-Linux stack, and the I-pipe makes good use of this information to
>>> return the proper "current" value when asked to through
>>> ipipe_safe_current() from the KGDB code. The issue of swapping
>>
>>
>> This looks nice.
>>
>>
>>> smp_processor_id() with ipipe_processor_id() has been addressed the hard
>>> way: smp_processor_id() is simply defined as ipipe_processor_id() when
>>> CONFIG_IPIPE and CONFIG_KGDB are both enabled in include/linux/smp.h.
>>> This approach was actually used during the old Adeos times when pipeline
>>> domain had their own separate stack. I take for granted that the CPU
>>> penalty taken in doing this is perfectly acceptable, since well, we are
>>> debugging after all.
>>
>>
>> There is only one drawback: we will not be able to debug
>> smp_processor_id-related bugs in ipipe/Xenomai anymore...
>>
> 
> Good point. Here is an updated patch.
> 

Nope that's not the point I meant. I was referring to bugs like the
missing smp_processor_id patch in asm-i386/mmu_context.h. Your way makes
such problems disappear once you switch on the debugger. Remember that
we spotted the mmu_context issue via kgdb.

The attached kgdb-ipipe patch (which also updates to kgdb-CVS head)
addresses maintenance and smp-safeness by redefining the involved
services only per source file, not kernel-wide. What's do you think
about this approach?

I'm also posting two fixes for ipipe itself to 1) make kgdb work over
SMP and 2) fix a compiler warning.

This version works fine for me, at least in qemu. I tried to check SMP
as well, but qemu obviously lacks support for NMIs raised via IPI, and
this is used by kgdb to sync all CPUs on debugging events (vanilla kgdb
suffers too).

Jan

--------------020103080309020800070409
Content-Type: text/x-patch;
 name="kgdb-ipipe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kgdb-ipipe.patch"

Index: linux/kernel/kgdb.c
===================================================================
--- linux.orig/kernel/kgdb.c
+++ linux/kernel/kgdb.c
@@ -49,6 +49,15 @@
 #include <linux/console.h>
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
 extern int pidhash_init_done;
 
@@ -743,7 +752,7 @@ static void kgdb_wait(struct pt_regs *re
 	local_irq_save(flags);
 	processor = smp_processor_id();
 	kgdb_info[processor].debuggerinfo = regs;
-	kgdb_info[processor].task = current;
+	kgdb_info[processor].task = ipipe_safe_current();
 	atomic_set(&procindebug[processor], 1);
 	atomic_set(&kgdb_sync_softlockup[smp_processor_id()], 1);
 
@@ -884,8 +893,8 @@ int kgdb_deactivate_sw_breakpoints(void)
 					kgdb_break[i].saved_instr)))
 			return error;
 
-		if (CACHE_FLUSH_IS_SAFE && current->mm &&
-				addr < TASK_SIZE)
+		if (CACHE_FLUSH_IS_SAFE && ipipe_safe_current() == current &&
+				current->mm && addr < TASK_SIZE)
 			flush_cache_range(current->mm->mmap_cache,
 					addr, addr + BREAK_INSTR_SIZE);
 		else if (CACHE_FLUSH_IS_SAFE)
@@ -1069,7 +1078,7 @@ int kgdb_handle_exception(int ex_vector,
 		goto kgdb_restore;
 
 	kgdb_info[processor].debuggerinfo = linux_regs;
-	kgdb_info[processor].task = current;
+	kgdb_info[processor].task = ipipe_safe_current();
 
 	kgdb_disable_hw_debug(linux_regs);
 
@@ -1121,7 +1130,8 @@ int kgdb_handle_exception(int ex_vector,
 		*ptr++ = hexchars[(signo >> 4) % 16];
 		*ptr++ = hexchars[signo % 16];
 		ptr += strlen(strcpy(ptr, "thread:"));
-		int_to_threadref(&thref, shadow_pid(current->pid));
+		int_to_threadref(&thref,
+		                 shadow_pid(ipipe_safe_current()->pid));
 		ptr = pack_threadid(ptr, &thref);
 		*ptr++ = ';';
 
@@ -1213,7 +1223,8 @@ int kgdb_handle_exception(int ex_vector,
 			kgdb_hex2mem(&remcom_in_buffer[1], (char *)gdb_regs,
 				     NUMREGBYTES);
 
-			if (kgdb_usethread && kgdb_usethread != current)
+			if (kgdb_usethread &&
+			    kgdb_usethread != ipipe_safe_current())
 				error_packet(remcom_out_buffer, -EINVAL);
 			else {
 				gdb_regs_to_regs(gdb_regs, linux_regs);
@@ -1334,7 +1345,8 @@ int kgdb_handle_exception(int ex_vector,
 				/* Current thread id */
 				strcpy(remcom_out_buffer, "QC");
 
-				threadid = shadow_pid(current->pid);
+				threadid =
+					shadow_pid(ipipe_safe_current()->pid);
 
 				int_to_threadref(&thref, threadid);
 				pack_threadid(remcom_out_buffer + 2, &thref);
@@ -1488,7 +1500,8 @@ int kgdb_handle_exception(int ex_vector,
 			break;
 		case 'c':
 		case 's':
-			if (kgdb_contthread && kgdb_contthread != current) {
+			if (kgdb_contthread &&
+			    kgdb_contthread != ipipe_safe_current()) {
 				/* Can't switch threads in kgdb */
 				error_packet(remcom_out_buffer, -EINVAL);
 				break;
Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -273,7 +273,7 @@ choice
 
 config KGDB_ONLY_MODULES
 	bool "KGDB: Use only kernel modules for I/O"
-	depends on MODULES
+	depends on MODULES && !IPIPE
 	help
 	  Use only kernel modules to configure KGDB I/O after the
 	  kernel is booted.
@@ -318,7 +318,7 @@ config KGDB_SIBYTE
 endchoice
 
 config KGDBOE
-	tristate "KGDB: On ethernet" if !KGDBOE_NOMODULE
+	tristate "KGDB: On ethernet" if !KGDBOE_NOMODULE && !IPIPE
 	depends on m && KGDB
 	select NETPOLL
 	select NETPOLL_TRAP
Index: linux/drivers/serial/8250_kgdb.c
===================================================================
--- linux.orig/drivers/serial/8250_kgdb.c
+++ linux/drivers/serial/8250_kgdb.c
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
Index: linux/arch/i386/kernel/kgdb.c
===================================================================
--- linux.orig/arch/i386/kernel/kgdb.c
+++ linux/arch/i386/kernel/kgdb.c
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

--------------020103080309020800070409
Content-Type: text/x-patch;
 name="load-cpuid-in-foreign_stack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="load-cpuid-in-foreign_stack.patch"

Index: linux-2.6.16.16/include/linux/ipipe.h
===================================================================
--- linux-2.6.16.16.orig/include/linux/ipipe.h
+++ linux-2.6.16.16/include/linux/ipipe.h
@@ -617,6 +617,7 @@ static inline void ipipe_set_foreign_sta
 {
 	/* Must be called hw interrupts off. */
 	ipipe_declare_cpuid;
+	ipipe_load_cpuid();
 	__set_bit(IPIPE_NOSTACK_FLAG, &ipd->cpudata[cpuid].status);
 }
 
@@ -624,6 +625,7 @@ static inline void ipipe_clear_foreign_s
 {
 	/* Must be called hw interrupts off. */
 	ipipe_declare_cpuid;
+	ipipe_load_cpuid();
 	__clear_bit(IPIPE_NOSTACK_FLAG, &ipd->cpudata[cpuid].status);
 }
 

--------------020103080309020800070409
Content-Type: text/x-patch;
 name="add-kgdb-include.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add-kgdb-include.patch"

Index: linux-2.6.16.16/arch/i386/kernel/ipipe-root.c
===================================================================
--- linux-2.6.16.16.orig/arch/i386/kernel/ipipe-root.c
+++ linux-2.6.16.16/arch/i386/kernel/ipipe-root.c
@@ -423,6 +423,8 @@ static __ipipe_exptr __ipipe_std_extable
 };
 
 #ifdef CONFIG_KGDB
+#include <linux/kgdb.h>
+
 static int __ipipe_xlate_signo[] = {
 
 	[ex_do_divide_error] = SIGFPE,

--------------020103080309020800070409--

