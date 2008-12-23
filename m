Message-ID: <49513184.3040608@domain.hid>
Date: Tue, 23 Dec 2008 19:44:20 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5E05386FE32AE10E0D271718"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] HAL-x86: Fix race in timer request and
	release path
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
--------------enig5E05386FE32AE10E0D271718
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

By taking over a tick device from Linux, we install a set-next-tick
handler for Linux that could be called shortly after, eventually with
such a small delay that it will trigger the Xenomai tick IRQ before we
installed its corresponding handler. This will cause a NULL pointer oops
which has been observed at least once here over a KVM environment (where
race windows tend to widen a lot).

Plug the race by installing the tick IRQ handler first, then starting
to take over tick devices. Vice versa on release.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/arch/x86/hal-common.c |   44 +++++++++++++++++++++++---------------=
------
 1 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/ksrc/arch/x86/hal-common.c b/ksrc/arch/x86/hal-common.c
index 2b04dcf..4d818ad 100644
--- a/ksrc/arch/x86/hal-common.c
+++ b/ksrc/arch/x86/hal-common.c
@@ -107,18 +107,24 @@ int rthal_timer_request(
 	int cpu)
 {
 	unsigned long tmfreq;
-	int tickval, err;
+	int tickval, err, res;
+
+	if (cpu_timers_requested =3D=3D 0) {
+		err =3D rthal_irq_request(RTHAL_APIC_TIMER_IPI,
+					(rthal_irq_handler_t) tick_handler,
+					NULL, NULL);
+		if (err)
+			return err;
+	}
=20
 	/* This code works both for UP+LAPIC and SMP configurations. */
=20
 #ifdef __IPIPE_FEATURE_REQUEST_TICKDEV
-	int res =3D ipipe_request_tickdev("lapic", mode_emul, tick_emul, cpu,
-					&tmfreq);
+	res =3D ipipe_request_tickdev("lapic", mode_emul, tick_emul, cpu,
+				    &tmfreq);
 #else
-	int res =3D ipipe_request_tickdev("lapic",
-					(compat_emumode_t)mode_emul,
-					(compat_emutick_t)tick_emul,
-					cpu);
+	res =3D ipipe_request_tickdev("lapic", (compat_emumode_t)mode_emul,
+				    (compat_emutick_t)tick_emul, cpu);
 	tmfreq =3D RTHAL_COMPAT_TIMERFREQ;
 #endif
=20
@@ -141,9 +147,12 @@ int rthal_timer_request(
 		break;
=20
 	case CLOCK_EVT_MODE_SHUTDOWN:
-		return -ENODEV;
+		res =3D -ENODEV;
+		/* fall through */
=20
 	default:
+		if (cpu_timers_requested =3D=3D 0)
+			rthal_irq_release(RTHAL_APIC_TIMER_IPI);
 		return res;
 	}
 	rthal_ktimer_saved_mode =3D res;
@@ -155,19 +164,12 @@ int rthal_timer_request(
 	 * The rest of the initialization should only be performed
 	 * once by a single CPU.
 	 */
-	if (cpu_timers_requested++ > 0)
-		goto out;
-
-	err =3D rthal_irq_request(RTHAL_APIC_TIMER_IPI,
-				(rthal_irq_handler_t) tick_handler, NULL, NULL);
-
-	if (err)
-		return err;
+	if (cpu_timers_requested++ =3D=3D 0) {
+		rthal_timer_set_oneshot(1);
=20
-	rthal_timer_set_oneshot(1);
+		rthal_nmi_init(&rthal_latency_above_max);
+	}
=20
-	rthal_nmi_init(&rthal_latency_above_max);
-out:
 	return tickval;
 }
=20
@@ -270,12 +272,12 @@ void rthal_timer_release(int cpu)
=20
 	rthal_nmi_release();
=20
-	rthal_irq_release(RTHAL_APIC_TIMER_IPI);
-
 	if (rthal_ktimer_saved_mode =3D=3D KTIMER_MODE_PERIODIC)
 		rthal_timer_set_periodic();
 	else if (rthal_ktimer_saved_mode =3D=3D KTIMER_MODE_ONESHOT)
 		rthal_timer_set_oneshot(0);
+
+	rthal_irq_release(RTHAL_APIC_TIMER_IPI);
 }
=20
=20


--------------enig5E05386FE32AE10E0D271718
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAklRMYkACgkQniDOoMHTA+lnngCfXo+QBLi0rVubSzXMVZ1QFPyb
D80An0kE/epmGsqHOOz4H2ETuXr1M/3D
=waIp
-----END PGP SIGNATURE-----

--------------enig5E05386FE32AE10E0D271718--

