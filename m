Message-ID: <479C9D83.1060409@domain.hid>
Date: Sun, 27 Jan 2008 16:04:35 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE41246595255C9C7A66D5670"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] Fix cleanup race in xnpod_disable_timesource
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
--------------enigE41246595255C9C7A66D5670
Content-Type: multipart/mixed;
 boundary="------------040005010200010803080106"

This is a multi-part message in MIME format.
--------------040005010200010803080106
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

CPU n (n!=3D0)
------------
xnpod_disable_timesource()
for (cpu =3D 0..x)
  rthal_timer_release(cpu=3D0)
  ipipe_release_tickdev(cpu=3D0)
  rthal_timer_set_oneshot(0)
  rthal_trigger_irq(RTHAL_HOST_TICK_IRQ)
  ...
  lapic_next_event(...)
  xnarch_next_htick_shot(...)
  ...
  rthal_timer_release(cpu=3Dn)
  ipipe_release_tickdev(cpu=3Dn)

And dead it is, the lapic on this CPU. Attached patch fixes the issue
(and gets rid off multiple RTHAL_BCAST_TICK_IRQ deregistrations).

Jan

--------------040005010200010803080106
Content-Type: text/x-patch;
 name="fix-timesource-cleanup-race.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-timesource-cleanup-race.patch"

---
 ChangeLog                  |    5 +++++
 ksrc/arch/x86/hal-common.c |   18 +++++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

Index: b/ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,8 @@
+2008-01-27  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* ksrc/arch/x86/hal-common.c: Fix race when starting the cleanup
+	on CPU > 0. Avoid multiple RTHAL_BCAST_TICK_IRQ releases.
+
 2008-01-26  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
=20
 	* configure.in: Fix --enable-linux-build for latest arch/x86
Index: b/ksrc/arch/x86/hal-common.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/arch/x86/hal-common.c
+++ b/ksrc/arch/x86/hal-common.c
@@ -120,6 +120,8 @@ DECLARE_LINUX_IRQ_HANDLER(rthal_broadcas
 	return IRQ_HANDLED;
 }
=20
+static int cpu_timers_requested;
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
=20
 int rthal_timer_request(
@@ -179,7 +181,7 @@ int rthal_timer_request(
 	 * The rest of the initialization should only be performed
 	 * once by a single CPU.
 	 */
-	if (cpu > 0)
+	if (cpu_timers_requested++ > 0)
 		goto out;
=20
 	err =3D rthal_irq_request(RTHAL_APIC_TIMER_IPI,
@@ -219,7 +221,7 @@ int rthal_timer_request(void (*tick_hand
 	 * The rest of the initialization should only be performed
 	 * once by a single CPU.
 	 */
-	if (cpu > 0)
+	if (cpu_timers_requested++ > 0)
 		goto out;
=20
 	err =3D rthal_irq_request(RTHAL_APIC_TIMER_IPI,
@@ -252,18 +254,20 @@ void rthal_timer_release(int cpu)
 {
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 	ipipe_release_tickdev(cpu);
-#else
-	rthal_irq_host_release(RTHAL_BCAST_TICK_IRQ,
-			       &rthal_broadcast_to_local_timers);
 #endif
=20
 	/*
 	 * The rest of the cleanup work should only be performed once
-	 * by a single CPU.
+	 * by the last releasing CPU.
 	 */
-	if (cpu > 0)
+	if (--cpu_timers_requested > 0)
 		return;
=20
+#ifndef CONFIG_GENERIC_CLOCKEVENTS
+	rthal_irq_host_release(RTHAL_BCAST_TICK_IRQ,
+			       &rthal_broadcast_to_local_timers);
+#endif
+
 	rthal_nmi_release();
=20
 	rthal_irq_release(RTHAL_APIC_TIMER_IPI);

--------------040005010200010803080106--

--------------enigE41246595255C9C7A66D5670
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHnJ2JniDOoMHTA+kRAuleAJ9zwsVegsbyZYLJ6je+kS452OCykACbBhgU
hydikLm5XEIULmT4GM4rkis=
=46Kl
-----END PGP SIGNATURE-----

--------------enigE41246595255C9C7A66D5670--

