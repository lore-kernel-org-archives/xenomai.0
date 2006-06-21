Message-ID: <4499B97A.5040800@domain.hid>
Date: Wed, 21 Jun 2006 23:26:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig78D511FE02593E323C1AA112"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] optimise rthal_timer locking
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
--------------enig78D511FE02593E323C1AA112
Content-Type: multipart/mixed; boundary="------------050806050301010205040201"

This is a multi-part message in MIME format.
--------------050806050301010205040201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

long pending in my tree, I finally decided to role this one out as it is
quite lone-standing:

This patch avoids to additionally switch off the local IRQs in
rthal_timer_program_shot for the PIPELINE_HEAD case - the caller is
expected to hold the nucleus lock with IRQs off anyway. Applies to i386
and ia64.

Jan

--------------050806050301010205040201
Content-Type: text/x-patch;
 name="rthal-timer-locking.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rthal-timer-locking.patch"

Index: include/asm-i386/hal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-i386/hal.h	(Revision 1135)
+++ include/asm-i386/hal.h	(Arbeitskopie)
@@ -177,9 +177,13 @@ rthal_time_t rthal_get_8254_tsc(void);
=20
 static inline void rthal_timer_program_shot (unsigned long delay)
 {
+/* With head-optimization, callers are expected to have switched off
+   hard-IRQs already -- no need for additional protection in this case. =
*/
+#ifndef CONFIG_XENO_OPT_PIPELINE_HEAD
     unsigned long flags;
=20
     rthal_local_irq_save_hw(flags);
+#endif /* CONFIG_XENO_OPT_PIPELINE_HEAD */
 #ifdef CONFIG_X86_LOCAL_APIC
     if (!delay) {
         /* Kick the timer interrupt immediately. */
@@ -201,7 +205,9 @@ static inline void rthal_timer_program_s
 	outb(delay >> 8,0x40);
     }
 #endif /* CONFIG_X86_LOCAL_APIC */
+#ifndef CONFIG_XENO_OPT_PIPELINE_HEAD
     rthal_local_irq_restore_hw(flags);
+#endif /* CONFIG_XENO_OPT_PIPELINE_HEAD */
 }
=20
 static const char *const rthal_fault_labels[] =3D {
Index: include/asm-ia64/hal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-ia64/hal.h	(Revision 1135)
+++ include/asm-ia64/hal.h	(Arbeitskopie)
@@ -65,11 +65,18 @@ static inline unsigned long long rthal_r
=20
 static inline void rthal_timer_program_shot (unsigned long delay)
 {
+/* With head-optimization, callers are expected to have switched off
+   hard-IRQs already -- no need for additional protection in this case. =
*/
+#ifndef CONFIG_XENO_OPT_PIPELINE_HEAD
     unsigned long flags;
-    if (!delay) { delay =3D 10; }
+
     rthal_local_irq_save_hw(flags);
+#endif /* CONFIG_XENO_OPT_PIPELINE_HEAD */
+    if (!delay) { delay =3D 10; }
     ia64_set_itm(ia64_get_itc() + delay);
+#ifndef CONFIG_XENO_OPT_PIPELINE_HEAD
     rthal_local_irq_restore_hw(flags);
+#endif /* CONFIG_XENO_OPT_PIPELINE_HEAD */
 }
=20
     /* Private interface -- Internal use only */

--------------050806050301010205040201--

--------------enig78D511FE02593E323C1AA112
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEmbl/niDOoMHTA+kRAjtPAJ4ok3ka1/U/7eWcvD8sQPNQ/KqvCgCeLjDZ
1CMzMxyg+1XJCKnqq3TNgFI=
=mjRR
-----END PGP SIGNATURE-----

--------------enig78D511FE02593E323C1AA112--

