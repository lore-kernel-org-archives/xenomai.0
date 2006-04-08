Message-ID: <44377F75.9030707@domain.hid>
Date: Sat, 08 Apr 2006 11:16:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA6DB81CECED45C0E8598CE6F"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] kgdb over ipipe
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA6DB81CECED45C0E8598CE6F
Content-Type: multipart/mixed; boundary="------------070603080207090307050408"

This is a multi-part message in MIME format.
--------------070603080207090307050408
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

this is the preliminary, though already usable result of my recent
effort to extend the tool situation for Xenomai: A kgdb patch series for
2.6.15 on x86. It already works quite well but likely does not yet catch
all fatal scenarios (e.g. page faults in the Xenomai domain).

To apply it, you first need to run the standard kgdb patch series
against a vanilla 2.6.15 (I tested .3 and .5), and then extend that
series like follows:

prepare-kgdb-ipipe-x86.patch
adeos-ipipe-2.6.15-i386-1.2-01.patch
kgdb-ipipe.patch
kgdb-ipipe-x86.patch

Note that the adeos patch is also vanilla, i.e. unmodified! I
successfully tested the debugger (via serial cable) by putting a
breakpoint at rt_sem_v and then running the latency test - all fine.

You may want to patch gdb to improve its awareness of modules (see
kgdb.linsyssoft.com, I haven't tried yet), or you retrieve the module
base address (busybox's lsmod does this nicely e.g.) and issue
"add-symbol-file <path_to_your_module.ko> <base_address>" at the gdb prom=
pt.

I once hacked RTAI's old hal patch and an old kgdb over 2.4 together.
That was definitely more patching work than this one here! I'm quite
confident that this time we will be able to maintain the debugger over a
longer period without too much effort. I also think that porting it over
other archs should be fairly easy.

But more on this will follow, I first have to apply the tool on a real
problem...

Jan

--------------070603080207090307050408
Content-Type: text/x-patch;
 name="prepare-kgdb-ipipe-x86.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="prepare-kgdb-ipipe-x86.patch"

Index: linux-2.6.15.5/arch/i386/kernel/entry.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.5.orig/arch/i386/kernel/entry.S	2006-04-07 16:42:54.0000=
00000 +0200
+++ linux-2.6.15.5/arch/i386/kernel/entry.S	2006-04-07 16:47:23.000000000=
 +0200
@@ -123,7 +123,7 @@
 .previous
=20
=20
-KPROBE_ENTRY(ret_from_fork)
+ENTRY(ret_from_fork)
 	pushl %eax
 	call schedule_tail
 	GET_THREAD_INFO(%ebp)
@@ -470,7 +470,7 @@
 	pushl $do_simd_coprocessor_error
 	jmp error_code
=20
-KPROBE_ENTRY(device_not_available)
+ENTRY(device_not_available)
 	pushl $-1			# mark this as an int
 	SAVE_ALL
 	movl %cr0, %eax
@@ -652,7 +652,7 @@
 	jmp error_code
 #endif
=20
-KPROBE_ENTRY(spurious_interrupt_bug)
+ENTRY(spurious_interrupt_bug)
 	pushl $0
 	pushl $do_spurious_interrupt_bug
 	jmp error_code

--------------070603080207090307050408
Content-Type: text/x-patch;
 name="kgdb-ipipe.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="kgdb-ipipe.patch"

Index: linux-2.6.15.3-kgdb/kernel/kgdb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.3-kgdb.orig/kernel/kgdb.c	2006-04-08 04:54:37.000000000 =
+0200
+++ linux-2.6.15.3-kgdb/kernel/kgdb.c	2006-04-08 11:01:42.000000000 +0200=

@@ -740,7 +740,7 @@
 	unsigned long flags;
 	int processor;
=20
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	processor =3D smp_processor_id();
 	kgdb_info[processor].debuggerinfo =3D regs;
 	kgdb_info[processor].task =3D current;
@@ -770,7 +770,7 @@
 	/* Signal the master processor that we are done */
 	atomic_set(&procindebug[processor], 0);
 	spin_unlock(&slavecpulocks[processor]);
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
 #endif
=20
@@ -1033,7 +1033,7 @@
 	 * Interrupts will be restored by the 'trap return' code, except when
 	 * single stepping.
 	 */
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
=20
 	/* Hold debugger_active */
 	procid =3D smp_processor_id();
@@ -1056,7 +1056,7 @@
 	if (atomic_read(&cpu_doing_single_step) !=3D -1 &&
 	    atomic_read(&cpu_doing_single_step) !=3D procid) {
 		atomic_set(&debugger_active, 0);
-		local_irq_restore(flags);
+		local_irq_restore_hw(flags);
 		goto acquirelock;
 	}
=20
@@ -1556,7 +1556,7 @@
 kgdb_restore:
 	/* Free debugger_active */
 	atomic_set(&debugger_active, 0);
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
=20
 	return error;
 }
@@ -1925,9 +1925,9 @@
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
@@ -1942,9 +1942,9 @@
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
--- linux-2.6.15.3-kgdb.orig/drivers/serial/8250_kgdb.c	2006-04-08 04:54:=
37.000000000 +0200
+++ linux-2.6.15.3-kgdb/drivers/serial/8250_kgdb.c	2006-04-08 11:01:42.00=
0000000 +0200
@@ -301,6 +301,10 @@
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
Index: linux-2.6.15.3-kgdb/include/linux/kgdb.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.3-kgdb.orig/include/linux/kgdb.h	2006-04-08 04:54:37.000=
000000 +0200
+++ linux-2.6.15.3-kgdb/include/linux/kgdb.h	2006-04-08 11:01:42.00000000=
0 +0200
@@ -271,5 +271,14 @@
 /* Stubs for when KGDB is not set. */
 static const atomic_t debugger_active =3D ATOMIC_INIT(0);
 #endif				/* CONFIG_KGDB */
+
+#ifdef CONFIG_IPIPE
+void kgdb_catch_domain(struct ipipe_domain *ipd);
+int kgdb_catch_event_allowed(unsigned event);
+#else /* !CONFIG_IPIPE */
+#define kgdb_catch_domain(ipd)
+#define kgdb_catch_event_allowed(event) 1
+#endif /* CONFIG_IPIPE */
+
 #endif				/* _KGDB_H_ */
 #endif				/* __KERNEL__ */
Index: linux-2.6.15.3-kgdb/kernel/ipipe/generic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.3-kgdb.orig/kernel/ipipe/generic.c	2006-04-08 04:54:37.0=
00000000 +0200
+++ linux-2.6.15.3-kgdb/kernel/ipipe/generic.c	2006-04-08 11:01:42.000000=
000 +0200
@@ -29,6 +29,9 @@
 #ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
 #endif	/* CONFIG_PROC_FS */
+#ifdef CONFIG_KGDB
+#include <linux/kgdb.h>
+#endif	/* CONFIG_KGDB */
=20
 MODULE_DESCRIPTION("I-pipe");
 MODULE_LICENSE("GPL");
@@ -106,6 +109,10 @@
=20
 	printk(KERN_WARNING "I-pipe: Domain %s registered.\n", ipd->name);
=20
+#ifdef CONFIG_KGDB
+	kgdb_catch_domain(ipd);
+#endif
+
 	/*
 	 * Finally, allow the new domain to perform its initialization
 	 * chores.
@@ -277,6 +284,11 @@
 		self =3D 1;
 	}
=20
+#ifdef CONFIG_KGDB
+	if (!kgdb_catch_event_allowed(event))
+		return 0; /* silently ignore request */
+#endif
+
 	if (event >=3D IPIPE_NR_EVENTS)
 		return -EINVAL;
=20
Index: linux-2.6.15.3-kgdb/lib/Kconfig.debug
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.3-kgdb.orig/lib/Kconfig.debug	2006-04-08 04:54:37.000000=
000 +0200
+++ linux-2.6.15.3-kgdb/lib/Kconfig.debug	2006-04-08 11:01:42.000000000 +=
0200
@@ -250,7 +250,7 @@
=20
 config KGDB_ONLY_MODULES
 	bool "KGDB: Use only kernel modules for I/O"
-	depends on MODULES
+	depends on MODULES && !IPIPE
 	help
 	  Use only kernel modules to configure KGDB I/O after the
 	  kernel is booted.
@@ -295,7 +295,7 @@
 endchoice
=20
 config KGDBOE
-	tristate "KGDB: On ethernet" if !KGDBOE_NOMODULE
+	tristate "KGDB: On ethernet" if !KGDBOE_NOMODULE && !IPIPE
 	depends on m && KGDB
 	select NETPOLL
 	select NETPOLL_TRAP

--------------070603080207090307050408
Content-Type: text/x-patch;
 name="kgdb-ipipe-x86.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="kgdb-ipipe-x86.patch"

Index: linux-2.6.15.3-kgdb/arch/i386/kernel/entry.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.3-kgdb.orig/arch/i386/kernel/entry.S	2006-04-08 04:54:36=
=2E000000000 +0200
+++ linux-2.6.15.3-kgdb/arch/i386/kernel/entry.S	2006-04-08 11:01:52.0000=
00000 +0200
@@ -194,7 +194,7 @@
 .previous
=20
=20
-ENTRY(ret_from_fork)
+KPROBE_ENTRY(ret_from_fork)
 	STI_COND_HW
 	pushl %eax
 	call schedule_tail
@@ -582,7 +582,7 @@
 	PUSH_XCODE(do_simd_coprocessor_error)
 	jmp error_code
=20
-ENTRY(device_not_available)
+KPROBE_ENTRY(device_not_available)
 	pushl $-1			# mark this as an int
 	SAVE_ALL
 	DIVERT_EXCEPTION(device_not_available)
@@ -767,7 +767,7 @@
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
--- linux-2.6.15.3-kgdb.orig/arch/i386/kernel/ipipe-root.c	2006-04-08 04:=
54:36.000000000 +0200
+++ linux-2.6.15.3-kgdb/arch/i386/kernel/ipipe-root.c	2006-04-08 11:01:52=
=2E000000000 +0200
@@ -34,6 +34,9 @@
 #include <asm/irq.h>
 #include <asm/desc.h>
 #include <asm/io.h>
+#ifdef CONFIG_KGDB
+#include <linux/kgdb.h>
+#endif  /* CONFIG_KGDB */
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/tlbflush.h>
 #include <asm/fixmap.h>
@@ -248,6 +251,10 @@
 	ipipe_root_domain->irqs[IPIPE_SERVICE_IPI2].control &=3D ~IPIPE_SYSTEM_=
MASK;
 	ipipe_root_domain->irqs[IPIPE_SERVICE_IPI3].control &=3D ~IPIPE_SYSTEM_=
MASK;
 #endif	/* CONFIG_X86_LOCAL_APIC */
+
+#ifdef CONFIG_KGDB
+	kgdb_catch_domain(ipipe_root_domain);
+#endif
 }
=20
 static inline void __fixup_if(struct pt_regs *regs)
Index: linux-2.6.15.3-kgdb/arch/i386/kernel/kgdb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.3-kgdb.orig/arch/i386/kernel/kgdb.c	2006-04-08 04:54:36.=
000000000 +0200
+++ linux-2.6.15.3-kgdb/arch/i386/kernel/kgdb.c	2006-04-08 11:01:52.00000=
0000 +0200
@@ -362,3 +362,22 @@
 	.flags =3D KGDB_HW_BREAKPOINT,
 };
=20
+#ifdef CONFIG_IPIPE
+int kgdb_catch_debug(unsigned event, struct ipipe_domain *ipd, void *dat=
a)
+{
+	struct pt_regs *regs =3D (struct pt_regs *)data;
+
+	return !kgdb_handle_exception(event, SIGTRAP, -1, regs);
+}
+
+void kgdb_catch_domain(struct ipipe_domain *ipd)
+{
+	ipipe_catch_event(ipd, 1, kgdb_catch_debug);
+	ipipe_catch_event(ipd, 3, kgdb_catch_debug);
+}
+
+int kgdb_catch_event_allowed(unsigned event)
+{
+	return ((event !=3D 1) && (event !=3D 3));
+}
+#endif /* CONFIG_IPIPE */

--------------070603080207090307050408--

--------------enigA6DB81CECED45C0E8598CE6F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEN391niDOoMHTA+kRAtXvAJ9ZF6twUu07RDJ8G/ciiD+Hz0IHDQCcD8i0
Kd75xbexzF37KZsb9XEfNlw=
=UNGd
-----END PGP SIGNATURE-----

--------------enigA6DB81CECED45C0E8598CE6F--

