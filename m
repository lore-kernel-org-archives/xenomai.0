Message-ID: <4720FE77.2020302@domain.hid>
Date: Thu, 25 Oct 2007 22:37:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4720F828.1030200@domain.hid> <4720FB07.10606@domain.hid>
In-Reply-To: <4720FB07.10606@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD079B0CB4B1359E3B7D10EC4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Proposed arch/powerpc/sysdev/uic.c patch
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD079B0CB4B1359E3B7D10EC4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Steven A. Falco wrote:
>> I applied the uic patch:
>>
>> diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
>> index eeb38e2..5a38086 100644
>> --- a/arch/powerpc/sysdev/uic.c
>> +++ b/arch/powerpc/sysdev/uic.c
>> @@ -48,7 +48,7 @@ struct uic {
>>     int index;
>>     int dcrbase;
>>
>> -    spinlock_t lock;
>> +    ipipe_spinlock_t lock;
>>
>>     /* The remapper for this UIC */
>>     struct irq_host    *irqhost;
>>
>> However, this would not compile because of a type mismatch.  I have
>> added the attached patch, and it now compiles and runs.  But I'm not
>> sure if this is the right way to fix it.  Comments?
>>
>=20
> This will work for the purpose of running an I-pipe enabled kernel, but=

> would fail with CONFIG_IPIPE disabled. Since we need to provide both,
> I'm going to work on the proper patch for fixing the issue both ways.
> Still, your patch will work as expected for running Xenomai.

To be consequent, we would have to wrap spin_lock_init just like the
other operations. Suggestion (not really tested):

Index: linux-2.6.23-ipipe/include/linux/spinlock.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-ipipe.orig/include/linux/spinlock.h
+++ linux-2.6.23-ipipe/include/linux/spinlock.h
@@ -89,10 +89,22 @@ extern int __lockfunc generic__raw_read_
 # include <linux/spinlock_up.h>
 #endif
=20
+#undef TYPE_EQUAL
+#define TYPE_EQUAL(lock, type) \
+	__builtin_types_compatible_p(typeof(lock), type *)
+
+#define spin_lock_init(lock)						\
+do {									\
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t))			\
+		*(__ipipe_spinlock_t *)(lock) =3D IPIPE_SPIN_LOCK_UNLOCKED; \
+	else if (TYPE_EQUAL(lock, spinlock_t))				\
+		_spin_lock_init((spinlock_t *)(lock));			\
+} while (0)
+
 #ifdef CONFIG_DEBUG_SPINLOCK
   extern void __spin_lock_init(spinlock_t *lock, const char *name,
 			       struct lock_class_key *key);
-# define spin_lock_init(lock)					\
+# define _spin_lock_init(lock)					\
 do {								\
 	static struct lock_class_key __key;			\
 								\
@@ -100,7 +112,7 @@ do {								\
 } while (0)
=20
 #else
-# define spin_lock_init(lock)					\
+# define _spin_lock_init(lock)					\
 	do { *(lock) =3D SPIN_LOCK_UNLOCKED; } while (0)
 #endif
=20
@@ -172,10 +184,6 @@ do {								\
 #define read_trylock(lock)		__cond_lock(lock, _read_trylock(lock))
 #define write_trylock(lock)		__cond_lock(lock, _write_trylock(lock))
=20
-#undef TYPE_EQUAL
-#define TYPE_EQUAL(lock, type) \
-	__builtin_types_compatible_p(typeof(lock), type *)
-
 #define PICK_SPINOP(op, lock)						\
 do {									\
 	if (TYPE_EQUAL((lock), __ipipe_spinlock_t))			\


Jan


--------------enigD079B0CB4B1359E3B7D10EC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHIP53niDOoMHTA+kRAqG2AJ4zlZWZTz8Qs+mvqk04m7ui8npY4wCdFZhQ
LhNJuADZ2m4KOHInpdOl+7k=
=9skP
-----END PGP SIGNATURE-----

--------------enigD079B0CB4B1359E3B7D10EC4--

