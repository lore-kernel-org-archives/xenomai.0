Message-ID: <44C0C3EC.9080009@domain.hid>
Date: Fri, 21 Jul 2006 14:09:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5BFADAAFBF18E4A8D12626DF"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] kgdb over 2.6.17
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
--------------enig5BFADAAFBF18E4A8D12626DF
Content-Type: multipart/mixed; boundary="------------040608080407080801080906"

This is a multi-part message in MIME format.
--------------040608080407080801080906
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

This is just a trivial refresh of the existing I-pipe-over-kgdb patches
for 2.6.16. Successfully tested with 2.6.17.6 + I-pipe-1.3-08.

Still keep in mind that you have to add

    CFLAGS_kgdb.o +=3D -fno-unit-at-a-time

to kernel/Makefile in order to compile kgdb with gcc-4.1[.1] (you may
remember this when your box locks up or reboots on debugger
attaching...). That's due to a compiler bug which will be fixed in 4.1.2.=


Jan

--------------040608080407080801080906
Content-Type: text/plain;
 name="pre-kgdb-CVS-20060721-ipipe-i386.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="pre-kgdb-CVS-20060721-ipipe-i386.patch"

Index: linux-2.6.17.6/arch/i386/kernel/entry.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.6.orig/arch/i386/kernel/entry.S
+++ linux-2.6.17.6/arch/i386/kernel/entry.S
@@ -123,7 +123,7 @@ VM_MASK		=3D 0x00020000
 .previous
=20
=20
-KPROBE_ENTRY(ret_from_fork)
+ENTRY(ret_from_fork)
 	pushl %eax
 	call schedule_tail
 	GET_THREAD_INFO(%ebp)
@@ -476,7 +476,7 @@ ENTRY(simd_coprocessor_error)
 	pushl $do_simd_coprocessor_error
 	jmp error_code
=20
-KPROBE_ENTRY(device_not_available)
+ENTRY(device_not_available)
 	pushl $-1			# mark this as an int
 	SAVE_ALL
 	movl %cr0, %eax
@@ -658,7 +658,7 @@ ENTRY(machine_check)
 	jmp error_code
 #endif
=20
-KPROBE_ENTRY(spurious_interrupt_bug)
+ENTRY(spurious_interrupt_bug)
 	pushl $0
 	pushl $do_spurious_interrupt_bug
 	jmp error_code

--------------040608080407080801080906
Content-Type: text/plain;
 name="core-kgdb-CVS-20060721-ipipe-i386.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="core-kgdb-CVS-20060721-ipipe-i386.patch"

Index: linux-2.6.17.6/kernel/kgdb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.6.orig/kernel/kgdb.c
+++ linux-2.6.17.6/kernel/kgdb.c
@@ -50,6 +50,15 @@
 #include <linux/sched.h>
 #include <asm/byteorder.h>
=20
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
@@ -742,7 +751,7 @@ static void kgdb_wait(struct pt_regs *re
 	local_irq_save(flags);
 	processor =3D smp_processor_id();
 	kgdb_info[processor].debuggerinfo =3D regs;
-	kgdb_info[processor].task =3D current;
+	kgdb_info[processor].task =3D ipipe_safe_current();
 	atomic_set(&procindebug[processor], 1);
 	atomic_set(&kgdb_sync_softlockup[smp_processor_id()], 1);
=20
@@ -883,8 +892,8 @@ int kgdb_deactivate_sw_breakpoints(void)
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
@@ -1068,7 +1077,7 @@ int kgdb_handle_exception(int ex_vector,
 		goto kgdb_restore;
=20
 	kgdb_info[processor].debuggerinfo =3D linux_regs;
-	kgdb_info[processor].task =3D current;
+	kgdb_info[processor].task =3D ipipe_safe_current();
=20
 	kgdb_disable_hw_debug(linux_regs);
=20
@@ -1120,7 +1129,8 @@ int kgdb_handle_exception(int ex_vector,
 		*ptr++ =3D hexchars[(signo >> 4) % 16];
 		*ptr++ =3D hexchars[signo % 16];
 		ptr +=3D strlen(strcpy(ptr, "thread:"));
-		int_to_threadref(&thref, shadow_pid(current->pid));
+		int_to_threadref(&thref,
+		                 shadow_pid(ipipe_safe_current()->pid));
 		ptr =3D pack_threadid(ptr, &thref);
 		*ptr++ =3D ';';
=20
@@ -1212,7 +1222,8 @@ int kgdb_handle_exception(int ex_vector,
 			kgdb_hex2mem(&remcom_in_buffer[1], (char *)gdb_regs,
 				     NUMREGBYTES);
=20
-			if (kgdb_usethread && kgdb_usethread !=3D current)
+			if (kgdb_usethread &&
+			    kgdb_usethread !=3D ipipe_safe_current())
 				error_packet(remcom_out_buffer, -EINVAL);
 			else {
 				gdb_regs_to_regs(gdb_regs, linux_regs);
@@ -1333,7 +1344,8 @@ int kgdb_handle_exception(int ex_vector,
 				/* Current thread id */
 				strcpy(remcom_out_buffer, "QC");
=20
-				threadid =3D shadow_pid(current->pid);
+				threadid =3D
+					shadow_pid(ipipe_safe_current()->pid);
=20
 				int_to_threadref(&thref, threadid);
 				pack_threadid(remcom_out_buffer + 2, &thref);
@@ -1487,7 +1499,8 @@ int kgdb_handle_exception(int ex_vector,
 			break;
 		case 'c':
 		case 's':
-			if (kgdb_contthread && kgdb_contthread !=3D current) {
+			if (kgdb_contthread &&
+			    kgdb_contthread !=3D ipipe_safe_current()) {
 				/* Can't switch threads in kgdb */
 				error_packet(remcom_out_buffer, -EINVAL);
 				break;
Index: linux-2.6.17.6/lib/Kconfig.debug
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.6.orig/lib/Kconfig.debug
+++ linux-2.6.17.6/lib/Kconfig.debug
@@ -274,7 +274,7 @@ choice
=20
 config KGDB_ONLY_MODULES
 	bool "KGDB: Use only kernel modules for I/O"
-	depends on MODULES
+	depends on MODULES && !IPIPE
 	help
 	  Use only kernel modules to configure KGDB I/O after the
 	  kernel is booted.
@@ -319,7 +319,7 @@ config KGDB_SIBYTE
 endchoice
=20
 config KGDBOE
-	tristate "KGDB: On ethernet" if !KGDBOE_NOMODULE
+	tristate "KGDB: On ethernet" if !KGDBOE_NOMODULE && !IPIPE
 	depends on m && KGDB
 	select NETPOLL
 	select NETPOLL_TRAP
Index: linux-2.6.17.6/drivers/serial/8250_kgdb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.6.orig/drivers/serial/8250_kgdb.c
+++ linux-2.6.17.6/drivers/serial/8250_kgdb.c
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
Index: linux-2.6.17.6/arch/i386/kernel/kgdb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.6.orig/arch/i386/kernel/kgdb.c
+++ linux-2.6.17.6/arch/i386/kernel/kgdb.c
@@ -43,6 +43,11 @@
=20
 #include "mach_ipi.h"
=20
+#if defined(CONFIG_KGDB) && defined(CONFIG_IPIPE)
+#undef smp_processor_id
+#define smp_processor_id    ipipe_processor_id
+#endif
+
 /* Put the error code here just in case the user cares.  */
 int gdb_i386errcode;
 /* Likewise, the vector number here (since GDB only gets the signal

--------------040608080407080801080906
Content-Type: text/plain;
 name="post-kgdb-CVS-20060721-ipipe-i386.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="post-kgdb-CVS-20060721-ipipe-i386.patch"

Index: linux-2.6.17.6/arch/i386/kernel/entry.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.6.orig/arch/i386/kernel/entry.S
+++ linux-2.6.17.6/arch/i386/kernel/entry.S
@@ -194,7 +194,7 @@ VM_MASK		=3D 0x00020000
 .previous
=20
=20
-ENTRY(ret_from_fork)
+KPROBE_ENTRY(ret_from_fork)
 	STI_COND_HW
 	pushl %eax
 	call schedule_tail
@@ -588,7 +588,7 @@ ENTRY(simd_coprocessor_error)
 	PUSH_XCODE(do_simd_coprocessor_error)
 	jmp error_code
=20
-ENTRY(device_not_available)
+KPROBE_ENTRY(device_not_available)
 	pushl $-1			# mark this as an int
 	SAVE_ALL
 	DIVERT_EXCEPTION(device_not_available)
@@ -773,7 +773,7 @@ ENTRY(machine_check)
 	jmp error_code
 #endif
=20
-ENTRY(spurious_interrupt_bug)
+KPROBE_ENTRY(spurious_interrupt_bug)
 	pushl $0
 	PUSH_XCODE(do_spurious_interrupt_bug)
 	jmp error_code

--------------040608080407080801080906--

--------------enig5BFADAAFBF18E4A8D12626DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEwMPsniDOoMHTA+kRAtYMAJ9Aid9ip0Xvm5fJO+rxy873X6RkZgCffAMa
lNeiAdeQq2rTuWpHZhjQW94=
=TTO6
-----END PGP SIGNATURE-----

--------------enig5BFADAAFBF18E4A8D12626DF--

