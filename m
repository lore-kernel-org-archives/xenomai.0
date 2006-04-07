Message-ID: <4436A8D2.2060603@domain.hid>
Date: Fri, 07 Apr 2006 20:00:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Frozen timer IRQ - now traced with kgdb :)
References: <4432E540.1010108@domain.hid>	<17459.46030.997560.684058@domain.hid>	<4433BA43.7000807@domain.hid>	<4433C087.3020403@domain.hid>	<44341AE6.5030804@domain.hid>	<44343CF6.4090500@domain.hid>	<44352E12.1000502@domain.hid>
	<443533E3.6080305@domain.hid>	<4435363B.50701@domain.hid>
	<443537C5.1080801@domain.hid>	<44354CC5.8080405@domain.hid>
	<443662DE.8020804@domain.hid> <44369320.6030406@domain.hid>
	<443695BB.6030502@domain.hid>
In-Reply-To: <443695BB.6030502@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig679947DEE07517800EF4BD65"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig679947DEE07517800EF4BD65
Content-Type: multipart/mixed; boundary="------------040206050101090500060005"

This is a multi-part message in MIME format.
--------------040206050101090500060005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>
>>>
>>> BTW, that trace hacking reminds me that we should really think about
>>> making a kernel debugger run. I recently noticed that latest kgdb
>>> applied with a single failing hunk on top of ipipe (2.6.15, x86). May=
be
>>> it is just about making kgdb's irq-locks ipipe-aware and bypassing th=
e
>>> ipipe for int3 and the serial IRQ (so that ipipe can be debugged as
>>> well) and catching the relevant exceptions. Hmm, the debugger seems t=
o
>>> get initialised in the "early" stage. Is this before or after ipipe
>>> setup?
>>>
>>
>> It depends. If "kgdbwait" is set in the bootargs to halt the kernel
>> waiting for the remote GDB to connect to the target, kgdb starts
>> before the ipipe. Otherwise, it's a late init, and kgdb starts after
>> the ipipe is fully initialized.
>>
>=20
> Basically, kgdb could start before the i-pipe as soon as a breakpoint i=
s
> hit before the latter is enabled in init/main.c.
>=20

Yep, I dug deeper meanwhile and also came across this.

I already have a trivial hack running here. The most tricky part for me
was to learn quilt, but now I start to love it :). Here is a snapshot
series for 2.6.15.5:

<kgdb series from CVS>
prepare-ipipe-x86.patch
adeos-ipipe-2.6.15-i386-1.2-01.patch
kgdb-ipipe-x86.patch

I'm currently wondering if it makes sense to register a kgdb domain and
"officially" capture all involved IRQs and events. So far the serial
line IRQ is hard-coded (should be retrieved from some internal kgdb
structure later). Anyway, it seems to work quite well, I'm currently
stepping through a network IRQ at ipipe-level.


While playing with this tool a bit, displaying the the ipipe structures,
and thinking about the original problem again, I wondered what could
cause a temporary (as I think to found out now) stalled xeno domain
without locking up the system? Some irq-lock leaks at driver level (i.e.
inside our own code)?

Jan

--------------040206050101090500060005
Content-Type: text/plain;
 name="kgdb-ipipe-x86.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="kgdb-ipipe-x86.patch"

Index: linux-2.6.15.5/arch/i386/kernel/entry.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.5.orig/arch/i386/kernel/entry.S	2006-04-07 16:53:39.0000=
00000 +0200
+++ linux-2.6.15.5/arch/i386/kernel/entry.S	2006-04-07 16:53:40.000000000=
 +0200
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
Index: linux-2.6.15.5/kernel/kgdb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.5.orig/kernel/kgdb.c	2006-04-07 16:30:51.000000000 +0200=

+++ linux-2.6.15.5/kernel/kgdb.c	2006-04-07 16:57:35.000000000 +0200
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
Index: linux-2.6.15.5/arch/i386/kernel/ipipe-root.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.5.orig/arch/i386/kernel/ipipe-root.c	2006-04-07 16:53:39=
=2E000000000 +0200
+++ linux-2.6.15.5/arch/i386/kernel/ipipe-root.c	2006-04-07 17:48:00.0000=
00000 +0200
@@ -111,6 +111,15 @@
=20
 #endif	/* CONFIG_X86_LOCAL_APIC */
=20
+#ifdef CONFIG_KGDB
+static struct ipipe_domain kgdb_domain;
+
+static void kgdb_domain_entry(void)
+{
+=09
+}
+#endif /* CONFIG_KGDB */
+
 /* __ipipe_enable_pipeline() -- We are running on the boot CPU, hw
    interrupts are off, and secondary CPUs are still lost in space. */
=20
@@ -248,6 +257,10 @@
 	ipipe_root_domain->irqs[IPIPE_SERVICE_IPI2].control &=3D ~IPIPE_SYSTEM_=
MASK;
 	ipipe_root_domain->irqs[IPIPE_SERVICE_IPI3].control &=3D ~IPIPE_SYSTEM_=
MASK;
 #endif	/* CONFIG_X86_LOCAL_APIC */
+
+#ifdef CONFIG_KGDB
+	ipipe_control_irq(4, 0, IPIPE_HANDLE_MASK|IPIPE_STICKY_MASK|IPIPE_SYSTE=
M_MASK);
+#endif /* CONFIG_KGDB */
 }
=20
 static inline void __fixup_if(struct pt_regs *regs)

--------------040206050101090500060005
Content-Type: text/plain;
 name="prepare-ipipe-x86.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="prepare-ipipe-x86.patch"

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

--------------040206050101090500060005--

--------------enig679947DEE07517800EF4BD65
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFENqjSniDOoMHTA+kRAtCNAJ4trBffirgWZkvhlmhXMYsyp5ysAQCePYZi
/ABKAGw4tuuJnzphaOjRhoE=
=9pPO
-----END PGP SIGNATURE-----

--------------enig679947DEE07517800EF4BD65--

