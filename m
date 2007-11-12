Message-ID: <4738DA8E.9050404@domain.hid>
Date: Mon, 12 Nov 2007 23:58:22 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7CA1133F3208A7C0D998433B"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 2/5] Obtain timer frequency from I-pipe
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7CA1133F3208A7C0D998433B
Content-Type: multipart/mixed;
 boundary="------------050307090908010002010306"

This is a multi-part message in MIME format.
--------------050307090908010002010306
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

This patch exploits the reworked ipipe_request_tickdev API that will be
posted in a separate series. This way we can overcome the inaccuracy of
Xenomai's current APIC timer frequency calibration. For
!CONFIG_GENERIC_CLOCKEVENTS, the patch tries to obtain the frequency via
the intermediate IPIPE_APIC_TIMER_FREQ API that will be provided on
x86_64 only up to and including kernel 2.6.23 (later x86-kernels will be
fully CLOCKEVENTS-based). We may also consider backporting that API to
2.6.20-i386.

Note that the user is still able to override the timer frequency via the
related nucleus modules parameter.

Jan

--------------050307090908010002010306
Content-Type: text/x-patch;
 name="obtain-timer-freq-from-ipipe.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="obtain-timer-freq-from-ipipe.patch"

---
 include/asm-x86/hal.h      |   30 ++++++++++++++++++++++++++++++
 ksrc/arch/x86/hal-shared.c |   15 +++++++++++----
 ksrc/arch/x86/hal_32.c     |   22 +++++++++++-----------
 ksrc/arch/x86/hal_64.c     |    3 ---
 4 files changed, 52 insertions(+), 18 deletions(-)

Index: xenomai/include/asm-x86/hal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-x86/hal.h
+++ xenomai/include/asm-x86/hal.h
@@ -1,6 +1,36 @@
+/**
+ * @ingroup hal
+ * @file
+ *
+ * Copyright (C) 2007 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+
 #ifndef _XENO_ASM_X86_HAL_H
 #define _XENO_ASM_X86_HAL_H
=20
+#include <linux/ipipe.h>
+
+#ifndef IPIPE_APIC_TIMER_FREQ
+# define RTHAL_COMPAT_TIMERFREQ		(apic_read(APIC_TMICT) * HZ)
+#else
+# define RTHAL_COMPAT_TIMERFREQ		IPIPE_APIC_TIMER_FREQ
+#endif
+
 enum rthal_ktimer_mode { /* <!> Must follow enum clock_event_mode */
 	KTIMER_MODE_UNUSED =3D 0,
 	KTIMER_MODE_SHUTDOWN,
Index: xenomai/ksrc/arch/x86/hal-shared.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/arch/x86/hal-shared.c
+++ xenomai/ksrc/arch/x86/hal-shared.c
@@ -132,9 +132,11 @@ int rthal_timer_request(
 	/* This code works both for UP+LAPIC and SMP configurations. */
=20
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
-	err =3D ipipe_request_tickdev("lapic", mode_emul, tick_emul, cpu);
+	unsigned long tick_freq;
+	int res =3D ipipe_request_tickdev("lapic", mode_emul, tick_emul, cpu,
+					&tick_freq);
=20
-	switch (err) {
+	switch (res) {
 	case CLOCK_EVT_MODE_PERIODIC:
 		/* oneshot tick emulation callback won't be used, ask
 		 * the caller to start an internal timer for emulating
@@ -156,10 +158,12 @@ int rthal_timer_request(
 		return -ENODEV;
=20
 	default:
-		return err;
+		return res;
 	}
+	rthal_ktimer_saved_mode =3D res;
=20
-	rthal_ktimer_saved_mode =3D err;
+	if (rthal_timerfreq_arg =3D=3D 0)
+		rthal_tunables.timer_freq =3D tick_freq;
 #else /* !CONFIG_GENERIC_CLOCKEVENTS */
 	/*
 	 * When the local APIC is enabled for kernels lacking generic
@@ -170,6 +174,9 @@ int rthal_timer_request(
 	 */
 	tickval =3D 0;
 	rthal_ktimer_saved_mode =3D KTIMER_MODE_PERIODIC;
+
+	if (rthal_timerfreq_arg =3D=3D 0)
+		rthal_tunables.timer_freq =3D RTHAL_COMPAT_TIMERFREQ;
 #endif /* !CONFIG_GENERIC_CLOCKEVENTS */
=20
 	/*
Index: xenomai/ksrc/arch/x86/hal_32.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/arch/x86/hal_32.c
+++ xenomai/ksrc/arch/x86/hal_32.c
@@ -240,9 +240,11 @@ int rthal_timer_request(
 	int tickval, err;
=20
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
-	err =3D ipipe_request_tickdev("pit", mode_emul, tick_emul, cpu);
+	unsigned long tick_freq;
+	int res =3D ipipe_request_tickdev("pit", mode_emul, tick_emul, cpu,
+					&tick_freq);
=20
-	switch (err) {
+	switch (res) {
 	case CLOCK_EVT_MODE_PERIODIC:
 		/* oneshot tick emulation callback won't be used, ask
 		 * the caller to start an internal timer for emulating
@@ -264,10 +266,12 @@ int rthal_timer_request(
 		return -ENOSYS;
=20
 	default:
-		return err;
+		return res;
 	}
+	rthal_ktimer_saved_mode =3D res;
=20
-	rthal_ktimer_saved_mode =3D err;
+	if (rthal_timerfreq_arg =3D=3D 0)
+		rthal_tunables.timer_freq =3D tick_freq;
 #else /* !CONFIG_GENERIC_CLOCKEVENTS */
 	/*
 	 * Out caller has to to emulate the periodic host tick by its
@@ -275,6 +279,9 @@ int rthal_timer_request(
 	 */
 	tickval =3D 1000000000UL / HZ;
 	rthal_ktimer_saved_mode =3D KTIMER_MODE_PERIODIC;
+
+	if (rthal_timerfreq_arg =3D=3D 0)
+		rthal_tunables.timer_freq =3D CLOCK_TICK_RATE;
 #endif /* !CONFIG_GENERIC_CLOCKEVENTS */
=20
 	/*
@@ -394,13 +401,6 @@ int rthal_arch_init(void)
 	rthal_setup_8254_tsc();
 #endif /* CONFIG_X86_TSC */
=20
-	if (rthal_timerfreq_arg =3D=3D 0)
-#ifdef CONFIG_X86_LOCAL_APIC
-		rthal_timerfreq_arg =3D apic_read(APIC_TMICT) * HZ;
-#else /* !CONFIG_X86_LOCAL_APIC */
-		rthal_timerfreq_arg =3D CLOCK_TICK_RATE;
-#endif /* CONFIG_X86_LOCAL_APIC */
-
 	return 0;
 }
=20
Index: xenomai/ksrc/arch/x86/hal_64.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/arch/x86/hal_64.c
+++ xenomai/ksrc/arch/x86/hal_64.c
@@ -79,9 +79,6 @@ int rthal_arch_init(void)
 		/* FIXME: 4Ghz barrier is close... */
 		rthal_cpufreq_arg =3D rthal_get_cpufreq();
=20
-	if (rthal_timerfreq_arg =3D=3D 0)
-		rthal_timerfreq_arg =3D apic_read(APIC_TMICT) * HZ;
-
 	return 0;
 }
=20

--------------050307090908010002010306--

--------------enig7CA1133F3208A7C0D998433B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHONqOniDOoMHTA+kRAjtAAJoDHJb4YMLPbq5kF+LqpA/yeW0SsgCdG98L
9FVrO2Vep+ALZDOYSz8TiQ4=
=yIy+
-----END PGP SIGNATURE-----

--------------enig7CA1133F3208A7C0D998433B--

