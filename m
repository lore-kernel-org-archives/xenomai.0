Message-ID: <4438FAFA.3020105@domain.hid>
Date: Sun, 09 Apr 2006 14:15:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] kgdb over ipipe
References: <44377F75.9030707@domain.hid>
In-Reply-To: <44377F75.9030707@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD9FC263B1C21EE352F1FF4E1"
Sender: jan.kiszka@domain.hid
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
--------------enigD9FC263B1C21EE352F1FF4E1
Content-Type: multipart/mixed; boundary="------------080400030803010604050001"

This is a multi-part message in MIME format.
--------------080400030803010604050001
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi,
>=20
> this is the preliminary, though already usable result of my recent
> effort to extend the tool situation for Xenomai: A kgdb patch series fo=
r
> 2.6.15 on x86. It already works quite well but likely does not yet catc=
h
> all fatal scenarios (e.g. page faults in the Xenomai domain).
>=20

And here comes another revision (prepare patch remains unmodified).

It gets closer to what Philippe also just suggested in the original
thread: hook KGDB into I-pipe in favour of registering a dedicated
domain. The latter approach modifies the I-pipe state in a way which may
blur the picture of I-pipe itself to the debugger. This revision hooks
exception events into the I-pipe core so that they are delivered the
normal way when the root domain is active, but get catched early for
higher domains like Xenomai. I'm just not sure about the best way to
handle the serial line IRQ. Philippe, do you see problems with current
approach? Should we better hook into __ipipe_handle_irq (which would
make things more complicated, I'm afraid)?

In contrast to the first version, exceptions happening in the Xenomai
domain now also get reported to KGDB. Debugging mostly works fine, I'm
just facing unknown problems with intercepting and then continuing
kernel-only RT threads. KGDB sometimes reports "E22" back in this case,
but always locks up. Maybe it gets confused by the fact the there is no
Linux task behind Xenomai kernel threads? I tested this by putting a
breakpoint into xnpod_suspend_thread and running latency in mode 0 and
1. 0 works fine, 1 not.

Jan

--------------080400030803010604050001
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
@@ -740,7 +740,7 @@ static void kgdb_wait(struct pt_regs *re
 	unsigned long flags;
 	int processor;
=20
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	processor =3D smp_processor_id();
 	kgdb_info[processor].debuggerinfo =3D regs;
 	kgdb_info[processor].task =3D current;
@@ -770,7 +770,7 @@ static void kgdb_wait(struct pt_regs *re
 	/* Signal the master processor that we are done */
 	atomic_set(&procindebug[processor], 0);
 	spin_unlock(&slavecpulocks[processor]);
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
 #endif
=20
@@ -1033,7 +1033,7 @@ int kgdb_handle_exception(int ex_vector,
 	 * Interrupts will be restored by the 'trap return' code, except when
 	 * single stepping.
 	 */
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
=20
 	/* Hold debugger_active */
 	procid =3D smp_processor_id();
@@ -1056,7 +1056,7 @@ int kgdb_handle_exception(int ex_vector,
 	if (atomic_read(&cpu_doing_single_step) !=3D -1 &&
 	    atomic_read(&cpu_doing_single_step) !=3D procid) {
 		atomic_set(&debugger_active, 0);
-		local_irq_restore(flags);
+		local_irq_restore_hw(flags);
 		goto acquirelock;
 	}
=20
@@ -1556,7 +1556,7 @@ int kgdb_handle_exception(int ex_vector,
 kgdb_restore:
 	/* Free debugger_active */
 	atomic_set(&debugger_active, 0);
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
=20
 	return error;
 }
@@ -1925,9 +1925,9 @@ static int kgdb_notify_reboot(struct not
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
@@ -1942,9 +1942,9 @@ void kgdb_console_write(struct console *
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

--------------080400030803010604050001
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
@@ -427,8 +430,44 @@ static __ipipe_exptr __ipipe_std_extable
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
@@ -442,6 +481,19 @@ fastcall int __ipipe_handle_exception(st
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

--------------080400030803010604050001--

--------------enigD9FC263B1C21EE352F1FF4E1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEOPr6niDOoMHTA+kRAn+mAJ9Aht8pcNF9bTWHJDVRKsTzCwNbXACcCJuq
fTXGR5k1st7LO2OVyOHOFeQ=
=lE4O
-----END PGP SIGNATURE-----

--------------enigD9FC263B1C21EE352F1FF4E1--

