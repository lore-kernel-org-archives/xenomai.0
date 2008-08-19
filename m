Message-ID: <48AB4256.6050200@domain.hid>
Date: Tue, 19 Aug 2008 23:59:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1104F276F39586EB800049D0"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] Clean up XNWAKEN / wwake tracking
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
--------------enig1104F276F39586EB800049D0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Current lock stealing implementation encodes the "new owner woken up,
but not yet scheduled" state redundantly. First, the XNWAKEN thread bit
is set and, second, the wwake field in xnthread_t points to the
xnsynch_t object that the thread is about to own.

Apparently, no technical benefit can be expected from this. It rather
adds some, though minor, overhead to frequently used core services.
Moreover such redundancy can cause confusion for the uninformed reader
who tries to understand the implementation.

This patch encodes the state purely via wwake (XNWAKEN set =3D> wwake !=3D=

NULL). Compared to the first version posted, this one also clears the
state again in case xnsynch_sleep_on is redone after some lock robbery
(compensating the removed XNWAKEN clearance in xnpod_suspend_thread).

Jan

---
 include/nucleus/thread.h |    1 -
 ksrc/nucleus/pod.c       |    2 +-
 ksrc/nucleus/synch.c     |   11 ++++-------
 3 files changed, 5 insertions(+), 9 deletions(-)

Index: b/include/nucleus/thread.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/nucleus/thread.h
+++ b/include/nucleus/thread.h
@@ -112,7 +112,6 @@
 #define XNRMID    0x00000002 /**< Pending on a removed resource */
 #define XNBREAK   0x00000004 /**< Forcibly awaken from a wait state */
 #define XNKICKED  0x00000008 /**< Kicked upon Linux signal (shadow only)=
 */
-#define XNWAKEN   0x00000010 /**< Thread waken up upon resource availabi=
lity */
 #define XNROBBED  0x00000020 /**< Robbed from resource ownership */
 #define XNATOMIC  0x00000040 /**< In atomic switch from secondary to pri=
mary mode */
 #define XNAFFSET  0x00000080 /**< CPU affinity changed from primary mode=
 */
Index: b/ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -1406,7 +1406,7 @@ void xnpod_suspend_thread(xnthread_t *th
 		}
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
=20
-		xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK | XNWAKEN | XNR=
OBBED);
+		xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK | XNROBBED);
 	}
=20
 	/* Don't start the timer for a thread indefinitely delayed by
Index: b/ksrc/nucleus/synch.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/nucleus/synch.c
+++ b/ksrc/nucleus/synch.c
@@ -199,7 +199,7 @@ redo:
 	}
=20
 	if (thread->cprio > owner->cprio) {
-		if (xnthread_test_info(owner, XNWAKEN) && owner->wwake =3D=3D synch) {=

+		if (owner->wwake =3D=3D synch) {
 			/* Ownership is still pending, steal the resource. */
 			synch->owner =3D thread;
 			xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK);
@@ -225,6 +225,9 @@ redo:
=20
 	xnpod_suspend_thread(thread, XNPEND, timeout, timeout_mode, synch);
=20
+	/* We are awake, no one must steal our lock anymore. */
+	thread->wwake =3D NULL;
+
 	if (xnthread_test_info(thread, XNRMID | XNTIMEO | XNBREAK))
 		goto unlock_and_exit;
=20
@@ -241,10 +244,6 @@ redo:
 	}
=20
       unlock_and_exit:
-
-	thread->wwake =3D NULL;
-	xnthread_clear_info(thread, XNWAKEN);
-
 	xnlock_put_irqrestore(&nklock, s);
 }
=20
@@ -389,7 +388,6 @@ xnthread_t *xnsynch_wakeup_one_sleeper(x
 		thread->wchan =3D NULL;
 		thread->wwake =3D synch;
 		synch->owner =3D thread;
-		xnthread_set_info(thread, XNWAKEN);
 		trace_mark(xn_nucleus_synch_wakeup_one,
 			   "thread %p thread_name %s synch %p",
 			   thread, xnthread_name(thread), synch);
@@ -503,7 +501,6 @@ xnpholder_t *xnsynch_wakeup_this_sleeper
 	thread->wchan =3D NULL;
 	thread->wwake =3D synch;
 	synch->owner =3D thread;
-	xnthread_set_info(thread, XNWAKEN);
 	trace_mark(xn_nucleus_synch_wakeup_all,
 		   "thread %p thread_name %s synch %p",
 		   thread, xnthread_name(thread), synch);


--------------enig1104F276F39586EB800049D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkirQloACgkQniDOoMHTA+nmTwCeNrfP4ACCiwRlknzqbAQmoFqI
yHgAnRcOAfx+lX5usuzxwkZCeDwZRZFt
=r+rC
-----END PGP SIGNATURE-----

--------------enig1104F276F39586EB800049D0--

