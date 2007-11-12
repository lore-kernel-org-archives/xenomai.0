Message-ID: <4738DB31.9080405@domain.hid>
Date: Tue, 13 Nov 2007 00:01:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig988AEC6FB36B59BB69F00DE0"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 4/5] Cleanup tickdev emulation after I-pipe
	refactorings
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
--------------enig988AEC6FB36B59BB69F00DE0
Content-Type: multipart/mixed;
 boundary="------------040101020001080902060908"

This is a multi-part message in MIME format.
--------------040101020001080902060908
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

A separately posted I-pipe patch refactors the tickdev emulation API.
This patch updates Xenomai to the new prototypes without changing any
functionality.

Jan

--------------040101020001080902060908
Content-Type: text/x-patch;
 name="cleanup-tickdev-emu.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="cleanup-tickdev-emu.patch"

---
 include/asm-generic/bits/pod.h |   14 +++++++-------
 include/asm-generic/hal.h      |    6 +++---
 ksrc/arch/generic/hal.c        |    4 ++--
 ksrc/arch/x86/hal-shared.c     |    6 +++---
 ksrc/arch/x86/hal_32.c         |    4 ++--
 5 files changed, 17 insertions(+), 17 deletions(-)

Index: xenomai/include/asm-generic/bits/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-generic/bits/pod.h
+++ xenomai/include/asm-generic/bits/pod.h
@@ -31,7 +31,7 @@
=20
 /*!
  * @internal
- * \fn void xnarch_next_htick_shot(unsigned long delay, struct ipipe_tic=
k_device *tdev)
+ * \fn void xnarch_next_htick_shot(unsigned long delay, struct clock_eve=
nt_device *cdev)
  *
  * \brief Next tick setup emulation callback.
  *
@@ -42,7 +42,7 @@
  * @param delay The time delta from the current date to the next tick,
  * expressed as a count of nanoseconds.
  *
- * @param tdev An pointer to the tick device which notifies us.
+ * @param cdev An pointer to the clock device which notifies us.
  *
  * Environment:
  *
@@ -58,7 +58,7 @@
  * Rescheduling: never.
  */
=20
-static int xnarch_next_htick_shot(unsigned long delay, struct ipipe_tick=
_device *tdev)
+static int xnarch_next_htick_shot(unsigned long delay, struct clock_even=
t_device *cdev)
 {
 	xnsched_t *sched;
 	spl_t s;
@@ -73,7 +73,7 @@ static int xnarch_next_htick_shot(unsign
=20
 /*!
  * @internal
- * \fn void xnarch_switch_htick_mode(enum clock_event_mode mode, struct =
ipipe_tick_device *tdev)
+ * \fn void xnarch_switch_htick_mode(enum clock_event_mode mode, struct =
clock_event_device *cdev)
  *
  * \brief Tick mode switch emulation callback.
  *
@@ -94,7 +94,7 @@ static int xnarch_next_htick_shot(unsign
  * which should never be shut down, so this mode should not be
  * encountered.
  *
- * @param tdev An opaque pointer to the tick device which notifies us.
+ * @param cdev An opaque pointer to the clock device which notifies us.
  *
  * Environment:
  *
@@ -109,13 +109,13 @@ static int xnarch_next_htick_shot(unsign
  * Rescheduling: never.
  */
=20
-static void xnarch_switch_htick_mode(enum clock_event_mode mode, struct =
ipipe_tick_device *tdev)
+static void xnarch_switch_htick_mode(enum clock_event_mode mode, struct =
clock_event_device *cdev)
 {
 	xnsched_t *sched;
 	xnticks_t tickval;
 	spl_t s;
=20
-	rthal_timer_notify_switch(mode, tdev);
+	rthal_timer_notify_switch(mode, cdev);
=20
 	if (mode =3D=3D CLOCK_EVT_MODE_ONESHOT)
 		return;
Index: xenomai/include/asm-generic/hal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-generic/hal.h
+++ xenomai/include/asm-generic/hal.h
@@ -440,12 +440,12 @@ unsigned long rthal_timer_calibrate(void
=20
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 int rthal_timer_request(void (*tick_handler)(void),
-			void (*mode_emul)(enum clock_event_mode mode, struct ipipe_tick_devic=
e *tdev),
-			int (*tick_emul) (unsigned long delay, struct ipipe_tick_device *tdev=
),
+			void (*mode_emul)(enum clock_event_mode mode, struct clock_event_devi=
ce *cdev),
+			int (*tick_emul) (unsigned long delay, struct clock_event_device *cde=
v),
 			int cpu);
=20
 void rthal_timer_notify_switch(enum clock_event_mode mode,
-			       struct ipipe_tick_device *tdev);
+			       struct clock_event_device *cdev);
=20
 #else
 int rthal_timer_request(void (*tick_handler)(void),
Index: xenomai/ksrc/arch/generic/hal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/arch/generic/hal.c
+++ xenomai/ksrc/arch/generic/hal.c
@@ -985,8 +985,8 @@ unsigned long long __rthal_generic_full_
=20
 /**
  * \fn int rthal_timer_request(void (*tick_handler)(void),
- *             void (*mode_emul)(enum clock_event_mode mode, struct ipip=
e_tick_device *tdev),
- *             int (*tick_emul)(unsigned long delay, struct ipipe_tick_d=
evice *tdev), int cpu)
+ *             void (*mode_emul)(enum clock_event_mode mode, struct cloc=
k_event_device *cdev),
+ *             int (*tick_emul)(unsigned long delay, struct clock_event_=
device *cdev), int cpu)
  * \brief Grab the hardware timer.
  *
  * rthal_timer_request() grabs and tunes the hardware timer in oneshot
Index: xenomai/ksrc/arch/x86/hal-shared.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/arch/x86/hal-shared.c
+++ xenomai/ksrc/arch/x86/hal-shared.c
@@ -121,9 +121,9 @@ int rthal_timer_request(
 	void (*tick_handler)(void),
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 	void (*mode_emul)(enum clock_event_mode mode,
-			  struct ipipe_tick_device *tdev),
+			  struct clock_event_device *cdev),
 	int (*tick_emul)(unsigned long delay,
-			 struct ipipe_tick_device *tdev),
+			 struct clock_event_device *cdev),
 #endif
 	int cpu)
 {
@@ -238,7 +238,7 @@ void rthal_timer_release(int cpu)
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
=20
 void rthal_timer_notify_switch(enum clock_event_mode mode,
-			       struct ipipe_tick_device *tdev)
+			       struct clock_event_device *cdev)
 {
 	if (rthal_processor_id() > 0)
 		/*
Index: xenomai/ksrc/arch/x86/hal_32.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/arch/x86/hal_32.c
+++ xenomai/ksrc/arch/x86/hal_32.c
@@ -231,9 +231,9 @@ int rthal_timer_request(
 	void (*tick_handler)(void),
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 	void (*mode_emul)(enum clock_event_mode mode,
-			  struct ipipe_tick_device *tdev),
+			  struct clock_event_device *cdev),
 	int (*tick_emul)(unsigned long delay,
-			 struct ipipe_tick_device *tdev),
+			 struct clock_event_device *cdev),
 #endif
 	int cpu)
 {

--------------040101020001080902060908--

--------------enig988AEC6FB36B59BB69F00DE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHONsxniDOoMHTA+kRAiOOAJ9t0Yy8qudPkCLOwnn+HsUdeiQWAQCeNJHg
rMY10Bb4yvi7VCX4875SbNM=
=Gb2a
-----END PGP SIGNATURE-----

--------------enig988AEC6FB36B59BB69F00DE0--

