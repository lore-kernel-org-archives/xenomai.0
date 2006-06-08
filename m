Message-ID: <4487DEC5.50705@domain.hid>
Date: Thu, 08 Jun 2006 10:24:37 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <44720BD1.805@domain.hid> <447E9E9E.6070301@domain.hid>
	<4486FCA3.2070501@domain.hid> <448703C2.8030601@domain.hid>
In-Reply-To: <448703C2.8030601@domain.hid>
Content-Type: multipart/mixed; boundary="------------030807010008020102060101"
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------030807010008020102060101
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Hi Jan,
>>
>>Based on your previous work, here is a set of patches coupling KGDB and
>>the I-pipe. Basically, I've attempted to shrink the extra patches needed
>>against the original KGDB + I-pipe ones to the bare minimum. This has
>>been obtained by having the I-pipe provide ipipe_current_safe(), and
>>drastically reduce the amount of fiddling with smp_processor_id().
>>
>>The key difference with the former implementation is that a domain (e.g.
>>Xenomai) is now expected to tell the I-pipe when it's switching to a
>>non-Linux stack, and the I-pipe makes good use of this information to
>>return the proper "current" value when asked to through
>>ipipe_safe_current() from the KGDB code. The issue of swapping
> 
> 
> This looks nice.
> 
> 
>>smp_processor_id() with ipipe_processor_id() has been addressed the hard
>>way: smp_processor_id() is simply defined as ipipe_processor_id() when
>>CONFIG_IPIPE and CONFIG_KGDB are both enabled in include/linux/smp.h.
>>This approach was actually used during the old Adeos times when pipeline
>>domain had their own separate stack. I take for granted that the CPU
>>penalty taken in doing this is perfectly acceptable, since well, we are
>>debugging after all.
> 
> 
> There is only one drawback: we will not be able to debug
> smp_processor_id-related bugs in ipipe/Xenomai anymore...
> 

Good point. Here is an updated patch.

> 
>>Aside of the small patches attached, you will need the latest I-pipe
>>1.3-05 patch for x86, adding the foreign stack notifier and the
>>ipipe_safe_current() support:
>>http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.16-i386-1.3-05.patch
>>
>>
>>Patches should be applied in this order on a vanilla 2.6.16 kernel:
>>
>>- KGDB 2.4 patch series over 2.6.16 (quilt)
>>- pre-kgdb-ipipe-i386.patch
>>- adeos-ipipe-2.6.16-i386-1.3-05.patch
>>- kgdb-ipipe.patch
>>- post-kgdb-ipipe-i386.patch
>>
>>Xenomai's trunk/ should be used. Older code won't work and likely crash
>>since the I-pipe would not be notified about foreign stack switches.
>>
>>Now the surprise: I did not test this stuff, I mean, at all. Eh. :o)
> 
> 
> That's fair: leave the head banging while debugging debuggers (*) up to
> me. ;)
> 
> Will try to let this fly, likely not before the weekend.
> 
> BTW, there is one pending issue of gcc-4.1 which popped up under kgdb,
> see [1] (also for a workaround).
> 

Mm, I'll keep on working with gcc3.4 and 8k stacks on x86 then.

> Jan
> 
> 
> (*) Actually, that's feasible: kgdb-patched kernel inside qemu - already
> done this (to find [1]), it's just a bit sloooow.
> 
> [1]http://sourceforge.net/mailarchive/forum.php?thread_id=10452132&forum_id=5557
> 


-- 

Philippe.

--------------030807010008020102060101
Content-Type: text/x-patch;
 name="kgdb-ipipe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kgdb-ipipe.patch"

--- 2.6.16-base/kernel/kgdb.c	2006-06-07 16:40:21.000000000 +0200
+++ 2.6.16-kgdb/kernel/kgdb.c	2006-06-07 16:43:36.000000000 +0200
@@ -740,10 +740,10 @@
 	unsigned long flags;
 	int processor;
 
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	processor = smp_processor_id();
 	kgdb_info[processor].debuggerinfo = regs;
-	kgdb_info[processor].task = current;
+	kgdb_info[processor].task = ipipe_safe_current();
 	atomic_set(&procindebug[processor], 1);
 
 	/* Wait till master processor goes completely into the debugger.
@@ -769,7 +769,7 @@
 	/* Signal the master processor that we are done */
 	atomic_set(&procindebug[processor], 0);
 	spin_unlock(&slavecpulocks[processor]);
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
 #endif
 
@@ -883,8 +883,8 @@
 					kgdb_break[i].saved_instr)))
 			return error;
 
-		if (CACHE_FLUSH_IS_SAFE && current->mm &&
-				addr < TASK_SIZE)
+		if (CACHE_FLUSH_IS_SAFE && ipipe_safe_current() == current &&
+				current->mm && addr < TASK_SIZE)
 			flush_cache_range(current->mm->mmap_cache,
 					addr, addr + BREAK_INSTR_SIZE);
 		else if (CACHE_FLUSH_IS_SAFE)
@@ -1032,7 +1032,7 @@
 	 * Interrupts will be restored by the 'trap return' code, except when
 	 * single stepping.
 	 */
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 
 	/* Hold debugger_active */
 	procid = smp_processor_id();
@@ -1055,7 +1055,7 @@
 	if (atomic_read(&cpu_doing_single_step) != -1 &&
 	    atomic_read(&cpu_doing_single_step) != procid) {
 		atomic_set(&debugger_active, 0);
-		local_irq_restore(flags);
+		local_irq_restore_hw(flags);
 		goto acquirelock;
 	}
 
@@ -1068,7 +1068,7 @@
 		goto kgdb_restore;
 
 	kgdb_info[processor].debuggerinfo = linux_regs;
-	kgdb_info[processor].task = current;
+	kgdb_info[processor].task = ipipe_safe_current();
 
 	kgdb_disable_hw_debug(linux_regs);
 
@@ -1120,7 +1120,8 @@
 		*ptr++ = hexchars[(signo >> 4) % 16];
 		*ptr++ = hexchars[signo % 16];
 		ptr += strlen(strcpy(ptr, "thread:"));
-		int_to_threadref(&thref, shadow_pid(current->pid));
+		int_to_threadref(&thref,
+		                 shadow_pid(ipipe_safe_current()->pid));
 		ptr = pack_threadid(ptr, &thref);
 		*ptr++ = ';';
 
@@ -1212,7 +1213,8 @@
 			kgdb_hex2mem(&remcom_in_buffer[1], (char *)gdb_regs,
 				     NUMREGBYTES);
 
-			if (kgdb_usethread && kgdb_usethread != current)
+			if (kgdb_usethread &&
+			    kgdb_usethread != ipipe_safe_current())
 				error_packet(remcom_out_buffer, -EINVAL);
 			else {
 				gdb_regs_to_regs(gdb_regs, linux_regs);
@@ -1333,7 +1335,8 @@
 				/* Current thread id */
 				strcpy(remcom_out_buffer, "QC");
 
-				threadid = shadow_pid(current->pid);
+				threadid =
+					shadow_pid(ipipe_safe_current()->pid);
 
 				int_to_threadref(&thref, threadid);
 				pack_threadid(remcom_out_buffer + 2, &thref);
@@ -1487,7 +1490,8 @@
 			break;
 		case 'c':
 		case 's':
-			if (kgdb_contthread && kgdb_contthread != current) {
+			if (kgdb_contthread &&
+			    kgdb_contthread != ipipe_safe_current()) {
 				/* Can't switch threads in kgdb */
 				error_packet(remcom_out_buffer, -EINVAL);
 				break;
@@ -1555,7 +1559,7 @@
 kgdb_restore:
 	/* Free debugger_active */
 	atomic_set(&debugger_active, 0);
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 
 	return error;
 }
@@ -1924,9 +1928,9 @@
 	if (!kgdb_connected || atomic_read(&debugger_active) != 0)
 		return 0;
 	if ((code == SYS_RESTART) || (code == SYS_HALT) || (code == SYS_POWER_OFF)){
-		local_irq_save(flags);
+		local_irq_save_hw(flags);
 		put_packet("X00");
-		local_irq_restore(flags);
+		local_irq_restore_hw(flags);
 	}
 	return NOTIFY_DONE;
 }		
@@ -1941,10 +1945,10 @@
 	if (!kgdb_connected || atomic_read(&debugger_active) != 0)
 		return;
 
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	kgdb_msg_write(s, count);
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
 
 static struct console kgdbcons = {
--- 2.6.16-base/lib/Kconfig.debug	2006-06-07 16:40:21.000000000 +0200
+++ 2.6.16-kgdb/lib/Kconfig.debug	2006-06-06 16:01:26.000000000 +0200
@@ -250,7 +250,7 @@
 
 config KGDB_ONLY_MODULES
 	bool "KGDB: Use only kernel modules for I/O"
-	depends on MODULES
+	depends on MODULES && !IPIPE
 	help
 	  Use only kernel modules to configure KGDB I/O after the
 	  kernel is booted.
@@ -295,8 +295,8 @@
 endchoice
 
 config KGDBOE
-	tristate "KGDB: On ethernet" if !KGDBOE_NOMODULE
+	tristate "KGDB: On ethernet" if !KGDBOE_NOMODULE && !IPIPE
 	depends on m && KGDB
 	select NETPOLL
 	select NETPOLL_TRAP
--- 2.6.16-base/drivers/serial/8250_kgdb.c	2006-06-07 16:40:20.000000000 +0200
+++ 2.6.16-kgdb/drivers/serial/8250_kgdb.c	2006-06-06 16:01:26.000000000 +0200
@@ -301,6 +301,10 @@
 			"GDB-stub", current_port) < 0)
 		printk(KERN_ERR "KGDB failed to request the serial IRQ (%d)\n",
 		       current_port->irq);
+#ifdef CONFIG_IPIPE
+	ipipe_control_irq(current_port->irq, 0,
+			IPIPE_HANDLE_MASK|IPIPE_STICKY_MASK|IPIPE_SYSTEM_MASK);
+#endif /* CONFIG_IPIPE */
 }
 
 static __init int kgdb_init_io(void)
--- 2.6.16-base/include/asm-i386/smp.h	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.16-kgdb/include/asm-i386/smp.h	2006-06-08 09:49:07.000000000 +0200
@@ -57,7 +57,11 @@
  * from the initial startup. We map APIC_BASE very early in page_setup(),
  * so this is correct in the x86 case.
  */
+#if defined(CONFIG_KGDB) && defined(CONFIG_IPIPE)
+#define raw_smp_processor_id() ipipe_processor_id()
+#else
 #define raw_smp_processor_id() (current_thread_info()->cpu)
+#endif
 
 extern cpumask_t cpu_callout_map;
 extern cpumask_t cpu_callin_map;

--------------030807010008020102060101--

