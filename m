Message-ID: <47CA8393.1080309@domain.hid>
Date: Sun, 02 Mar 2008 11:38:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47C51A34.203@domain.hid>
In-Reply-To: <47C51A34.203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig291A6606C9B0D304FDEE2B4C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] [PATCH 3/6] Consolidate xnlock_put debugging
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig291A6606C9B0D304FDEE2B4C
Content-Type: multipart/mixed;
 boundary="------------010805000003040304010001"

This is a multi-part message in MIME format.
--------------010805000003040304010001
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The owner check on xnlock release looks light-weight in first sight, but
it isn't. It requires a processor-id lookup + it adds a conditional to
the otherwise unconditional release path. Moreover, this code is inlined
into every xnlock_put user, thus increases the text size of hot paths.

This patch therefore moves the check under the same switch
(XENO_OPT_DEBUG_NUCLEUS) as the rest of xnlock debugging already is.

--------------010805000003040304010001
Content-Type: text/x-patch;
 name="consolidate-xnlock_put-debugging.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="consolidate-xnlock_put-debugging.patch"

---
 include/asm-generic/system.h |   52 +++++++++++++++++++++++-------------=
-------
 1 file changed, 28 insertions(+), 24 deletions(-)

Index: b/include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -164,11 +164,23 @@ xnlock_dbg_acquired(xnlock_t *lock, int=20
 	lock->cpu =3D cpu;
 }
=20
-static inline void xnlock_dbg_release(xnlock_t *lock)
+static inline int xnlock_dbg_release(xnlock_t *lock)
 {
 	extern xnlockinfo_t xnlock_stats[];
 	unsigned long long lock_time =3D rthal_rdtsc() - lock->lock_date;
-	xnlockinfo_t *stats =3D &xnlock_stats[xnarch_current_cpu()];
+	int cpu =3D xnarch_current_cpu();
+	xnlockinfo_t *stats =3D &xnlock_stats[cpu];
+
+	if (unlikely(atomic_read(&lock->owner) !=3D cpu)) {
+		rthal_emergency_console();
+		printk(KERN_ERR "Xenomai: unlocking unlocked nucleus lock %p"
+				" on CPU #%d\n"
+				"         owner  =3D %s:%u (%s(), CPU #%d)\n",
+		       lock, cpu, lock->file, lock->line, lock->function,
+		       lock->cpu);
+		show_stack(NULL,NULL);
+		return 1;
+	}
=20
 	lock->cpu =3D -lock->cpu;	/* File that we released it. */
=20
@@ -179,15 +191,7 @@ static inline void xnlock_dbg_release(xn
 		stats->function =3D lock->function;
 		stats->line =3D lock->line;
 	}
-}
-
-static inline void xnlock_dbg_invalid_release(xnlock_t *lock)
-{
-	rthal_emergency_console();
-	printk(KERN_ERR "Xenomai: unlocking unlocked nucleus lock %p\n"
-			"       owner  =3D %s:%u (%s(), CPU #%d)\n",
-	       lock, lock->file, lock->line, lock->function, lock->cpu);
-	show_stack(NULL,NULL);
+	return 0;
 }
=20
 #else /* !(CONFIG_SMP && XENO_DEBUG(NUCLEUS)) */
@@ -210,8 +214,10 @@ xnlock_dbg_spinning(xnlock_t *lock, int=20
 static inline void
 xnlock_dbg_acquired(xnlock_t *lock, int cpu, unsigned long long *start)	=
{ }
=20
-static inline void xnlock_dbg_release(xnlock_t *lock)			{ }
-static inline void xnlock_dbg_invalid_release(xnlock_t *lock)		{ }
+static inline int xnlock_dbg_release(xnlock_t *lock)
+{
+	return 0;
+}
=20
 #endif /* !(CONFIG_SMP && XENO_DEBUG(NUCLEUS)) */
=20
@@ -340,18 +346,16 @@ static inline int __xnlock_get(xnlock_t=20
=20
 static inline void xnlock_put(xnlock_t *lock)
 {
-	if (likely(atomic_read(&lock->owner) =3D=3D xnarch_current_cpu())) {
-		xnlock_dbg_release(lock);
+	if (xnlock_dbg_release(lock))
+		return;
+
+	/*
+	 * Make sure all data written inside the lock is visible to
+	 * other CPUs before we release the lock.
+	 */
+	xnarch_memory_barrier();
=20
-		/*
-		 * Make sure all data written inside the lock is visible to
-		 * other CPUs before we release the lock.
-		 */
-		xnarch_memory_barrier();
-
-		atomic_set(&lock->owner, ~0);
-	} else
-		xnlock_dbg_invalid_release(lock);
+	atomic_set(&lock->owner, ~0);
 }
=20
 static inline spl_t

--------------010805000003040304010001--

--------------enig291A6606C9B0D304FDEE2B4C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHyoOTniDOoMHTA+kRAv84AJ9FfbHa+RUaXC6ti2nlg9hxQF7AwACeNxuC
7YPCGHD5ULMybK74fBwVUtY=
=4xf6
-----END PGP SIGNATURE-----

--------------enig291A6606C9B0D304FDEE2B4C--

