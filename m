Message-ID: <47CA8397.70000@domain.hid>
Date: Sun, 02 Mar 2008 11:38:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47C51A34.203@domain.hid>
In-Reply-To: <47C51A34.203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0991F732AB5E38750E0C790B"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] [PATCH 4/6] Move spinning code out-of-line
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
--------------enig0991F732AB5E38750E0C790B
Content-Type: multipart/mixed;
 boundary="------------030803060609090604030108"

This is a multi-part message in MIME format.
--------------030803060609090604030108
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

To save text thus and thus avoid cache misses in the worst-case path,
this patch moves the slow path of xnlock_get out-of-line.

--------------030803060609090604030108
Content-Type: text/x-patch;
 name="introduce-xnlock_spin.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="introduce-xnlock_spin.patch"

---
 include/asm-generic/bits/pod.h |   18 ++++++++++++++++++
 include/asm-generic/system.h   |   29 ++++++++++++++---------------
 2 files changed, 32 insertions(+), 15 deletions(-)

Index: b/include/asm-generic/bits/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-generic/bits/pod.h
+++ b/include/asm-generic/bits/pod.h
@@ -295,4 +295,22 @@ unsigned long long xnarch_get_cpu_time(v
=20
 EXPORT_SYMBOL(xnarch_get_cpu_time);
=20
+#ifdef CONFIG_SMP
+void __xnlock_spin(xnlock_t *lock /*, */ XNLOCK_DBG_CONTEXT_ARGS)
+{
+	unsigned int spin_limit;
+	int cpu =3D xnarch_current_cpu();
+
+	xnlock_dbg_prepare_spin(&spin_limit);
+
+	while (atomic_cmpxchg(&lock->owner, ~0, cpu) !=3D ~0)
+		do {
+			cpu_relax();
+			xnlock_dbg_spinning(lock, cpu, &spin_limit /*, */
+					    XNLOCK_DBG_PASS_CONTEXT);
+		} while(atomic_read(&lock->owner) !=3D ~0);
+}
+EXPORT_SYMBOL(__xnlock_spin);
+#endif /* CONFIG_SMP */
+
 #endif /* !_XENO_ASM_GENERIC_BITS_POD_H */
Index: b/include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -130,10 +130,13 @@ typedef struct {
 #define XNLOCK_DBG_PASS_CONTEXT		, file, line, function
 #define XNLOCK_DBG_MAX_SPINS		10000000
=20
-static inline void
-xnlock_dbg_prepare_acquire(unsigned long long *start, unsigned *spin_lim=
it)
+static inline void xnlock_dbg_prepare_acquire(unsigned long long *start)=

 {
 	*start =3D rthal_rdtsc();
+}
+
+static inline void xnlock_dbg_prepare_spin(unsigned *spin_limit)
+{
 	*spin_limit =3D XNLOCK_DBG_MAX_SPINS;
 }
=20
@@ -204,15 +207,14 @@ typedef struct { atomic_t owner; } xnloc
 #define XNLOCK_DBG_CONTEXT_ARGS
 #define XNLOCK_DBG_PASS_CONTEXT
=20
-static inline void
-xnlock_dbg_prepare_acquire(unsigned long long *start, unsigned *spin_lim=
it)
-{ }
+static inline void xnlock_dbg_prepare_acquire(unsigned long long *start)=
 { }
+static inline void xnlock_dbg_prepare_spin(unsigned *spin_limit)	 { }
=20
 static inline void
-xnlock_dbg_spinning(xnlock_t *lock, int cpu, unsigned int *spin_limit)	{=
 }
+xnlock_dbg_spinning(xnlock_t *lock, int cpu, unsigned int *spin_limit)	 =
{ }
=20
 static inline void
-xnlock_dbg_acquired(xnlock_t *lock, int cpu, unsigned long long *start)	=
{ }
+xnlock_dbg_acquired(xnlock_t *lock, int cpu, unsigned long long *start)	=
 { }
=20
 static inline int xnlock_dbg_release(xnlock_t *lock)
 {
@@ -321,23 +323,20 @@ static inline void xnlock_init (xnlock_t
 #define DEFINE_XNLOCK(lock)		xnlock_t lock =3D XNARCH_LOCK_UNLOCKED
 #define DEFINE_PRIVATE_XNLOCK(lock)	static DEFINE_XNLOCK(lock)
=20
+void __xnlock_spin(xnlock_t *lock /*, */ XNLOCK_DBG_CONTEXT_ARGS);
+
 static inline int __xnlock_get(xnlock_t *lock /*, */ XNLOCK_DBG_CONTEXT_=
ARGS)
 {
 	unsigned long long start;
-	unsigned int spin_limit;
 	int cpu =3D xnarch_current_cpu();
=20
 	if (atomic_read(&lock->owner) =3D=3D cpu)
 		return 1;
=20
-	xnlock_dbg_prepare_acquire(&start, &spin_limit);
+	xnlock_dbg_prepare_acquire(&start);
=20
-	while (atomic_cmpxchg(&lock->owner, ~0, cpu) !=3D ~0)
-		do {
-			cpu_relax();
-			xnlock_dbg_spinning(lock, cpu, &spin_limit /*, */
-					    XNLOCK_DBG_PASS_CONTEXT);
-		} while(atomic_read(&lock->owner) !=3D ~0);
+	if (unlikely(atomic_cmpxchg(&lock->owner, ~0, cpu) !=3D ~0))
+		__xnlock_spin(lock /*, */ XNLOCK_DBG_PASS_CONTEXT);
=20
 	xnlock_dbg_acquired(lock, cpu, &start /*, */ XNLOCK_DBG_PASS_CONTEXT);
=20

--------------030803060609090604030108--

--------------enig0991F732AB5E38750E0C790B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHyoOXniDOoMHTA+kRAt/DAJ0ZXC++0DExJUeaVwaUEPu4z8EsCQCfafbX
QKNf0g81VCUffiGBbAmIBg4=
=aWc5
-----END PGP SIGNATURE-----

--------------enig0991F732AB5E38750E0C790B--

