Message-ID: <47C92668.9080805@domain.hid>
Date: Sat, 01 Mar 2008 10:48:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6C32784ED1E5F4D485C7E83E"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] Add barrier to xnlock_put
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
--------------enig6C32784ED1E5F4D485C7E83E
Content-Type: multipart/mixed;
 boundary="------------020801060301030508040903"

This is a multi-part message in MIME format.
--------------020801060301030508040903
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

To avoid that this gets lost in the discussion about my xnlock
refactoring, here is a separate patch to fix the SMP behavior of
xnlock_put. OK to merge it into trunk and stable trees?

Jan

--------------020801060301030508040903
Content-Type: text/x-patch;
 name="add-barrier-to-xnlock_put.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="add-barrier-to-xnlock_put.patch"

---
 ChangeLog                    |    4 ++++
 include/asm-generic/system.h |    6 ++++++
 2 files changed, 10 insertions(+)

Index: b/include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -307,6 +307,12 @@ static inline void xnlock_put (xnlock_t=20
 		    xnlock_stats[cpu].line =3D lock->line;
 	    }
 #endif /* XENO_DEBUG(NUCLEUS) */
+	    /*
+	     * Make sure all data written inside the lock is visible to
+	     * other CPUs before we release the lock.
+	     */
+	    xnarch_memory_barrier();
+
 	    atomic_set(&lock->owner, ~0);
     }
 #if XENO_DEBUG(NUCLEUS)
Index: b/ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2008-03-01  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* include/asm-generic/system.h (xnlock_put): Add proper barrier.
+
 2008-02-15  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
=20
 	* src/skins/posix/thread.c (__wrap_pthread_create): Follow more

--------------020801060301030508040903--

--------------enig6C32784ED1E5F4D485C7E83E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHySZtniDOoMHTA+kRAttuAJ9S5GmG7wg6wwjmGr+fcr7A0D7UsACfZm94
YZqjqYHxmIPszs2q7eniQ70=
=/Jdy
-----END PGP SIGNATURE-----

--------------enig6C32784ED1E5F4D485C7E83E--

