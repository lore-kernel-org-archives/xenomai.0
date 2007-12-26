Message-ID: <477275E6.9090306@domain.hid>
Date: Wed, 26 Dec 2007 16:40:22 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig070785F1A2FC8972C349A9F4"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 1/3] i386: fix tracking of __ipipe_tick_irq
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig070785F1A2FC8972C349A9F4
Content-Type: multipart/mixed;
 boundary="------------030706070102030309060904"

This is a multi-part message in MIME format.
--------------030706070102030309060904
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The existing algorithm to track the Linux tick IRQ breaks when other
clockevent drivers than PIT or LAPIC are involved (HPET...?). This patch
fixes the logic by pushing updates to the spot where they occur - into
the clockevent layer.

Jan

--------------030706070102030309060904
Content-Type: text/x-patch;
 name="fix-ipipe_tick_irq-definition-i386.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-ipipe_tick_irq-definition-i386.patch"

---
 arch/i386/kernel/ipipe.c  |   11 +----------
 include/asm-i386/ipipe.h  |   17 ++++++++++++++++-
 kernel/time/tick-common.c |    4 ++++
 3 files changed, 21 insertions(+), 11 deletions(-)

Index: linux-2.6.23.12-xeno/arch/i386/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.12-xeno.orig/arch/i386/kernel/ipipe.c
+++ linux-2.6.23.12-xeno/arch/i386/kernel/ipipe.c
@@ -50,9 +50,7 @@
=20
 extern struct clock_event_device *global_clock_event;
=20
-extern struct clock_event_device pit_clockevent;
-
-int __ipipe_tick_irq;
+int __ipipe_tick_irq =3D TIMER_IRQ;
=20
 DEFINE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
=20
@@ -220,13 +218,6 @@ void __init __ipipe_enable_pipeline(void
 			     IPIPE_STDROOT_MASK);
 #endif /* CONFIG_X86_MCE_P4THERMAL */
=20
-	__ipipe_tick_irq =3D global_clock_event =3D=3D &pit_clockevent ? 0
-		: ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR);
-
-#else	/* !CONFIG_X86_LOCAL_APIC */
-
-	__ipipe_tick_irq =3D 0;
-
 #endif	/* CONFIG_X86_LOCAL_APIC */
=20
 #ifdef CONFIG_SMP
Index: linux-2.6.23.12-xeno/include/asm-i386/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.12-xeno.orig/include/asm-i386/ipipe.h
+++ linux-2.6.23.12-xeno/include/asm-i386/ipipe.h
@@ -107,6 +107,20 @@ void __ipipe_do_critical_sync(unsigned i
=20
 extern int __ipipe_tick_irq;
=20
+#ifdef CONFIG_X86_LOCAL_APIC
+#define ipipe_update_tick_evtdev(evtdev)				\
+	do {								\
+		if (strcmp((evtdev)->name, "lapic") =3D=3D 0)		\
+			__ipipe_tick_irq =3D				\
+				ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR); \
+		else							\
+			__ipipe_tick_irq =3D TIMER_IRQ;			\
+	} while (0)
+#else
+#define ipipe_update_tick_evtdev(evtdev)				\
+	__ipipe_tick_irq =3D TIMER_IRQ
+#endif
+
 DECLARE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
=20
 #define __ipipe_call_root_xirq_handler(ipd,irq) \
@@ -205,7 +219,8 @@ int __ipipe_check_tickdev(const char *de
=20
 #else /* !CONFIG_IPIPE */
=20
-#define task_hijacked(p)	0
+#define ipipe_update_tick_evtdev(evtdev)	do { } while (0)
+#define task_hijacked(p)			0
=20
 #endif /* CONFIG_IPIPE */
=20
Index: linux-2.6.23.12-xeno/kernel/time/tick-common.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.12-xeno.orig/kernel/time/tick-common.c
+++ linux-2.6.23.12-xeno/kernel/time/tick-common.c
@@ -163,6 +163,10 @@ static void tick_setup_device(struct tic
=20
 	td->evtdev =3D newdev;
=20
+	/* I-pipe: derive global tick IRQ from CPU 0 */
+	if (cpu =3D=3D 0)
+		ipipe_update_tick_evtdev(newdev);
+
 	/*
 	 * When the device is not per cpu, pin the interrupt to the
 	 * current cpu:

--------------030706070102030309060904--

--------------enig070785F1A2FC8972C349A9F4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHcnXmniDOoMHTA+kRAjhxAKCCTXh9fJkS822099WeIKBf1FdZLwCZAWOQ
wZy2xZYBBZ8B3DD4u0dgsJU=
=U8TU
-----END PGP SIGNATURE-----

--------------enig070785F1A2FC8972C349A9F4--

