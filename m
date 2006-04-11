Message-ID: <443C0A34.70107@domain.hid>
Date: Tue, 11 Apr 2006 21:57:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: [Xenomai-core] kgdb over ipipe
References: <44377F75.9030707@domain.hid> <4438FAFA.3020105@domain.hid>
	<44397CBF.905@domain.hid>
In-Reply-To: <44397CBF.905@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF3FC8FEFE806F1785BF66CA6"
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
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF3FC8FEFE806F1785BF66CA6
Content-Type: multipart/mixed; boundary="------------020402070309050105080307"

This is a multi-part message in MIME format.
--------------020402070309050105080307
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>
>>> Hi,
>>>
>>> this is the preliminary, though already usable result of my recent
>>> effort to extend the tool situation for Xenomai: A kgdb patch series =
for
>>> 2.6.15 on x86. It already works quite well but likely does not yet ca=
tch
>>> all fatal scenarios (e.g. page faults in the Xenomai domain).
>>>
>>
>>
>> And here comes another revision (prepare patch remains unmodified).
>>
>> It gets closer to what Philippe also just suggested in the original
>> thread: hook KGDB into I-pipe in favour of registering a dedicated
>> domain. The latter approach modifies the I-pipe state in a way which m=
ay
>> blur the picture of I-pipe itself to the debugger. This revision hooks=

>> exception events into the I-pipe core so that they are delivered the
>> normal way when the root domain is active, but get catched early for
>> higher domains like Xenomai. I'm just not sure about the best way to
>> handle the serial line IRQ. Philippe, do you see problems with current=

>> approach? Should we better hook into __ipipe_handle_irq (which would
>> make things more complicated, I'm afraid)?
>>
>=20
> The current approach works fine unless a runaway thread goes wild with
> interrupts disabled (i.e. stall bit set) in the root stage or in any
> higher priority domain regardless of the root domain state, in which
> case the serial IRQ won't make it through the pipeline to KGDB.

But catching this would mean to change the behaviour of ipipe regarding
the highest priority domain from hard to soft masking of IRQs. Hmm,
should be made at least optional to catch scenarios where this change
makes bugs move (away...).

Would be the easiest way to achieve this to register a dummy domain
ahead of Xenomai (i.e. with higher prio)? Additionally, we would have to
modify the IRQ pipeline in a way that, e.g., some flag makes an IRQ not
only sticky but also "non-maskable" (I would make this also an option to
avoid overhead for non-debugging scenarios).

Well, not yet an essential feature for me, because we still have the NMI
watchdog and the option to spread breakpoints. But we should keep it in
mind.

>=20
>> In contrast to the first version, exceptions happening in the Xenomai
>> domain now also get reported to KGDB. Debugging mostly works fine, I'm=

>> just facing unknown problems with intercepting and then continuing
>> kernel-only RT threads. KGDB sometimes reports "E22" back in this case=
,
>> but always locks up. Maybe it gets confused by the fact the there is n=
o
>> Linux task behind Xenomai kernel threads? I tested this by putting a
>> breakpoint into xnpod_suspend_thread and running latency in mode 0 and=

>> 1. 0 works fine, 1 not.
>>
>=20
> KGDB is relying on "current", so it's reading garbage over Xenomai's
> kernel threads.
>=20

Attached is an improved version of the kgdb-ipipe.patch that copes with
this situation by mapping invalid currents to init_task. Kernel threads
are nicely debuggable now. =3D8)

Jan

--------------020402070309050105080307
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
@@ -49,6 +49,15 @@
 #include <linux/console.h>
 #include <asm/byteorder.h>
=20
+#ifdef CONFIG_XENOMAI
+#include <xenomai/nucleus/pod.h>
+#define CURRENT_VALID		(!nkpod || xnpod_userspace_p())
+#define SAFE_CURRENT		(CURRENT_VALID ? current : &init_task)
+#else /* !CONFIG_XENOMAI */
+#define CURRENT_VALID		1
+#define SAFE_CURRENT		current
+#endif
+
 extern int pid_max;
 extern int pidhash_init_done;
=20
@@ -740,10 +749,10 @@ static void kgdb_wait(struct pt_regs *re
 	unsigned long flags;
 	int processor;
=20
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	processor =3D smp_processor_id();
 	kgdb_info[processor].debuggerinfo =3D regs;
-	kgdb_info[processor].task =3D current;
+	kgdb_info[processor].task =3D SAFE_CURRENT;
 	atomic_set(&procindebug[processor], 1);
 	atomic_set(&kgdb_sync_softlockup[smp_processor_id()],1);
=20
@@ -770,7 +779,7 @@ static void kgdb_wait(struct pt_regs *re
 	/* Signal the master processor that we are done */
 	atomic_set(&procindebug[processor], 0);
 	spin_unlock(&slavecpulocks[processor]);
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
 #endif
=20
@@ -821,7 +830,7 @@ int kgdb_activate_sw_breakpoints(void)
 			return error;
=20
 		if (CACHE_FLUSH_IS_SAFE) {
-			if (current->mm && addr < TASK_SIZE)
+			if (CURRENT_VALID && current->mm && addr < TASK_SIZE)
 				flush_cache_range(current->mm->mmap_cache,=20
 						addr, addr + BREAK_INSTR_SIZE);
 			else
@@ -884,7 +893,7 @@ int kgdb_deactivate_sw_breakpoints(void)
 					kgdb_break[i].saved_instr)))
 			return error;
=20
-		if (CACHE_FLUSH_IS_SAFE && current->mm &&
+		if (CACHE_FLUSH_IS_SAFE && CURRENT_VALID && current->mm &&
 				addr < TASK_SIZE)
 			flush_cache_range(current->mm->mmap_cache,
 					addr, addr + BREAK_INSTR_SIZE);
@@ -1033,7 +1042,7 @@ int kgdb_handle_exception(int ex_vector,
 	 * Interrupts will be restored by the 'trap return' code, except when
 	 * single stepping.
 	 */
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
=20
 	/* Hold debugger_active */
 	procid =3D smp_processor_id();
@@ -1056,7 +1065,7 @@ int kgdb_handle_exception(int ex_vector,
 	if (atomic_read(&cpu_doing_single_step) !=3D -1 &&
 	    atomic_read(&cpu_doing_single_step) !=3D procid) {
 		atomic_set(&debugger_active, 0);
-		local_irq_restore(flags);
+		local_irq_restore_hw(flags);
 		goto acquirelock;
 	}
=20
@@ -1069,7 +1078,7 @@ int kgdb_handle_exception(int ex_vector,
 		goto kgdb_restore;
=20
 	kgdb_info[processor].debuggerinfo =3D linux_regs;
-	kgdb_info[processor].task =3D current;
+	kgdb_info[processor].task =3D SAFE_CURRENT;
=20
 	kgdb_disable_hw_debug(linux_regs);
=20
@@ -1121,7 +1130,7 @@ int kgdb_handle_exception(int ex_vector,
 		*ptr++ =3D hexchars[(signo >> 4) % 16];
 		*ptr++ =3D hexchars[signo % 16];
 		ptr +=3D strlen(strcpy(ptr, "thread:"));
-		int_to_threadref(&thref, shadow_pid(current->pid));
+		int_to_threadref(&thref, shadow_pid(SAFE_CURRENT->pid));
 		ptr =3D pack_threadid(ptr, &thref);
 		*ptr++ =3D ';';
=20
@@ -1213,7 +1222,7 @@ int kgdb_handle_exception(int ex_vector,
 			kgdb_hex2mem(&remcom_in_buffer[1], (char *)gdb_regs,
 				     NUMREGBYTES);
=20
-			if (kgdb_usethread && kgdb_usethread !=3D current)
+			if (kgdb_usethread && kgdb_usethread !=3D SAFE_CURRENT)
 				error_packet(remcom_out_buffer, -EINVAL);
 			else {
 				gdb_regs_to_regs(gdb_regs, linux_regs);
@@ -1334,7 +1343,7 @@ int kgdb_handle_exception(int ex_vector,
 				/* Current thread id */
 				strcpy(remcom_out_buffer, "QC");
=20
-				threadid =3D shadow_pid(current->pid);
+				threadid =3D shadow_pid(SAFE_CURRENT->pid);
=20
 				int_to_threadref(&thref, threadid);
 				pack_threadid(remcom_out_buffer + 2, &thref);
@@ -1488,7 +1497,7 @@ int kgdb_handle_exception(int ex_vector,
 			break;
 		case 'c':
 		case 's':
-			if (kgdb_contthread && kgdb_contthread !=3D current) {
+			if (kgdb_contthread && kgdb_contthread !=3D SAFE_CURRENT) {
 				/* Can't switch threads in kgdb */
 				error_packet(remcom_out_buffer, -EINVAL);
 				break;
@@ -1556,7 +1565,7 @@ int kgdb_handle_exception(int ex_vector,
 kgdb_restore:
 	/* Free debugger_active */
 	atomic_set(&debugger_active, 0);
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
=20
 	return error;
 }
@@ -1925,9 +1934,9 @@ static int kgdb_notify_reboot(struct not
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
@@ -1942,9 +1951,9 @@ void kgdb_console_write(struct console *
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
Index: linux-2.6.15.3-kgdb/kernel/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.3-kgdb.orig/kernel/Makefile
+++ linux-2.6.15.3-kgdb/kernel/Makefile
@@ -35,6 +35,10 @@ obj-$(CONFIG_SECCOMP) +=3D seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) +=3D rcutorture.o
 obj-$(CONFIG_IPIPE) +=3D ipipe/
=20
+ifeq ($(CONFIG_XENOMAI),y)
+EXTRA_CFLAGS +=3D -Iinclude/xenomai
+endif
+
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@domain.hid>, the -fno-omit-frame-p=
ointer is
 # needed for x86 only.  Why this used to be enabled for all architecture=
s is beyond

--------------020402070309050105080307--

--------------enigF3FC8FEFE806F1785BF66CA6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEPAo0niDOoMHTA+kRAkTNAJ4/qs8aIC0B8+bjHzq+QtaiZFMl9gCfbhd/
96DkPM4dEj52AvQC6TqhTyg=
=iycp
-----END PGP SIGNATURE-----

--------------enigF3FC8FEFE806F1785BF66CA6--

