Message-ID: <458A74C5.80005@domain.hid>
Date: Thu, 21 Dec 2006 12:49:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigED04CDB7DBB5866486E2B8E2"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] fix !CONFIG_IPIPE build
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigED04CDB7DBB5866486E2B8E2
Content-Type: multipart/mixed; boundary="------------090505080602070109090901"

This is a multi-part message in MIME format.
--------------090505080602070109090901
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

I never tested my type-based spinlocks in !CONFIG_IPIPE scenarios. Now I
did, and here comes the patch for 2.6.19-1.6-02 that is required - of
course.

Jan

--------------090505080602070109090901
Content-Type: text/plain;
 name="fix-ipipe-off.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-ipipe-off.patch"

---
 include/linux/spinlock.h       |   36 ++++++++++++++++++----------------=
--
 include/linux/spinlock_types.h |   10 ++++++----
 2 files changed, 24 insertions(+), 22 deletions(-)

Index: linux-2.6.19/include/linux/spinlock_types.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19.orig/include/linux/spinlock_types.h
+++ linux-2.6.19/include/linux/spinlock_types.h
@@ -33,7 +33,7 @@ typedef struct {
=20
 typedef struct {
 	raw_spinlock_t __raw_lock;
-} ipipe_spinlock_t;
+} __ipipe_spinlock_t;
=20
 #define SPINLOCK_MAGIC		0xdead4ead
=20
@@ -91,16 +91,18 @@ typedef struct {
=20
 #define SPIN_LOCK_UNLOCKED	__SPIN_LOCK_UNLOCKED(old_style_spin_init)
 #define IPIPE_SPIN_LOCK_UNLOCKED					\
-	(ipipe_spinlock_t) {	.__raw_lock =3D __RAW_SPIN_LOCK_UNLOCKED }
+	(__ipipe_spinlock_t) {	.__raw_lock =3D __RAW_SPIN_LOCK_UNLOCKED }
 #define RW_LOCK_UNLOCKED	__RW_LOCK_UNLOCKED(old_style_rw_init)
=20
 #define DEFINE_SPINLOCK(x)	spinlock_t x =3D __SPIN_LOCK_UNLOCKED(x)
 #define DEFINE_RWLOCK(x)	rwlock_t x =3D __RW_LOCK_UNLOCKED(x)
=20
 #ifdef CONFIG_IPIPE
-#define IPIPE_DEFINE_SPINLOCK(x) ipipe_spinlock_t x =3D IPIPE_SPIN_LOCK_=
UNLOCKED
+# define ipipe_spinlock_t	__ipipe_spinlock_t
+# define IPIPE_DEFINE_SPINLOCK(x) ipipe_spinlock_t x =3D IPIPE_SPIN_LOCK=
_UNLOCKED
 #else
-#define IPIPE_DEFINE_SPINLOCK(x) DEFINE_SPINLOCK(x)
+# define ipipe_spinlock_t	spinlock_t
+# define IPIPE_DEFINE_SPINLOCK(x) DEFINE_SPINLOCK(x)
 #endif
=20
 #endif /* __LINUX_SPINLOCK_TYPES_H */
Index: linux-2.6.19/include/linux/spinlock.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19.orig/include/linux/spinlock.h
+++ linux-2.6.19/include/linux/spinlock.h
@@ -177,33 +177,33 @@ do {								\
=20
 #define PICK_SPINOP(op, lock)						\
 do {									\
-	if (TYPE_EQUAL((lock), ipipe_spinlock_t))			\
-		__raw_spin##op(&((ipipe_spinlock_t *)(lock))->__raw_lock); \
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t))			\
+		__raw_spin##op(&((__ipipe_spinlock_t *)(lock))->__raw_lock); \
 	else if (TYPE_EQUAL(lock, spinlock_t))				\
 		_spin##op((spinlock_t *)(lock));			\
 } while (0)
=20
 #define PICK_SPINOP_RAW(op, lock)					\
 do {									\
-	if (TYPE_EQUAL((lock), ipipe_spinlock_t))			\
-		__raw_spin##op(&((ipipe_spinlock_t *)(lock))->__raw_lock); \
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t))			\
+		__raw_spin##op(&((__ipipe_spinlock_t *)(lock))->__raw_lock); \
 	else if (TYPE_EQUAL(lock, spinlock_t))				\
 		__raw_spin##op(&((spinlock_t *)(lock))->raw_lock);	\
 } while (0)
=20
 #define PICK_SPINLOCK_IRQ(lock)					\
 do {									\
-	if (TYPE_EQUAL((lock), ipipe_spinlock_t)) {			\
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t)) {			\
 		local_irq_disable_hw();					\
-		__raw_spin_lock(&((ipipe_spinlock_t *)(lock))->__raw_lock); \
+		__raw_spin_lock(&((__ipipe_spinlock_t *)(lock))->__raw_lock); \
 	} else if (TYPE_EQUAL(lock, spinlock_t))			\
 		_spin_lock_irq((spinlock_t *)(lock));			\
 } while (0)
=20
 #define PICK_SPINUNLOCK_IRQ(lock)					\
 do {									\
-	if (TYPE_EQUAL((lock), ipipe_spinlock_t)) {			\
-		__raw_spin_unlock(&((ipipe_spinlock_t *)(lock))->__raw_lock); \
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t)) {			\
+		__raw_spin_unlock(&((__ipipe_spinlock_t *)(lock))->__raw_lock); \
 		local_irq_enable_hw();					\
 	} else if (TYPE_EQUAL(lock, spinlock_t))			\
 		_spin_unlock_irq((spinlock_t *)(lock));			\
@@ -211,9 +211,9 @@ do {									\
=20
 #define PICK_SPINLOCK_IRQ_RAW(lock)					\
 do {									\
-	if (TYPE_EQUAL((lock), ipipe_spinlock_t)) {			\
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t)) {			\
 		local_irq_disable_hw();					\
-		__raw_spin_lock(&((ipipe_spinlock_t *)(lock))->__raw_lock); \
+		__raw_spin_lock(&((__ipipe_spinlock_t *)(lock))->__raw_lock); \
 	} else if (TYPE_EQUAL(lock, spinlock_t))			\
 		local_irq_disable();					\
 		__raw_spin_lock(&((spinlock_t *)(lock))->raw_lock);	\
@@ -221,8 +221,8 @@ do {									\
=20
 #define PICK_SPINUNLOCK_IRQ_RAW(lock)				\
 do {									\
-	if (TYPE_EQUAL((lock), ipipe_spinlock_t)) {			\
-		__raw_spin_unlock(&((ipipe_spinlock_t *)(lock))->__raw_lock); \
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t)) {			\
+		__raw_spin_unlock(&((__ipipe_spinlock_t *)(lock))->__raw_lock); \
 		local_irq_enable_hw();				\
 	} else if (TYPE_EQUAL(lock, spinlock_t))			\
 		__raw_spin_unlock(&((spinlock_t *)(lock))->raw_lock);	\
@@ -234,9 +234,9 @@ extern int __bad_spinlock_type(void);
=20
 #define PICK_SPINLOCK_IRQSAVE(lock, flags)				\
 do {									\
-	if (TYPE_EQUAL((lock), ipipe_spinlock_t)) {			\
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t)) {			\
 		local_irq_save_hw(flags);				\
-		__raw_spin_lock(&((ipipe_spinlock_t *)(lock))->__raw_lock); \
+		__raw_spin_lock(&((__ipipe_spinlock_t *)(lock))->__raw_lock); \
 	} else if (TYPE_EQUAL(lock, spinlock_t))			\
 		flags =3D _spin_lock_irqsave((spinlock_t *)(lock));	\
 	else __bad_spinlock_type();					\
@@ -244,9 +244,9 @@ do {									\
 #else
 #define PICK_SPINLOCK_IRQSAVE(lock, flags)				\
 do {									\
-	if (TYPE_EQUAL((lock), ipipe_spinlock_t)) {			\
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t)) {			\
 		local_irq_save_hw(flags);				\
-		__raw_spin_lock(&((ipipe_spinlock_t *)(lock))->__raw_lock); \
+		__raw_spin_lock(&((__ipipe_spinlock_t *)(lock))->__raw_lock); \
 	} else if (TYPE_EQUAL(lock, spinlock_t))			\
 		_spin_lock_irqsave((spinlock_t *)(lock), flags);	\
 } while (0)
@@ -254,8 +254,8 @@ do {									\
=20
 #define PICK_SPINUNLOCK_IRQRESTORE(lock, flags)			\
 	do {								\
-	if (TYPE_EQUAL((lock), ipipe_spinlock_t)) {			\
-		__raw_spin_unlock(&((ipipe_spinlock_t *)(lock))->__raw_lock); \
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t)) {			\
+		__raw_spin_unlock(&((__ipipe_spinlock_t *)(lock))->__raw_lock); \
 		local_irq_restore_hw(flags);				\
 	} else if (TYPE_EQUAL(lock, spinlock_t))			\
 		_spin_unlock_irqrestore((spinlock_t *)(lock), flags);	\

--------------090505080602070109090901--

--------------enigED04CDB7DBB5866486E2B8E2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFinTFniDOoMHTA+kRAs4FAJ9kDK+ovE7ZK0eS17NaDA6JKWGUMwCggBKQ
XuommCAHBi/eookDYHwVsRo=
=S0Ki
-----END PGP SIGNATURE-----

--------------enigED04CDB7DBB5866486E2B8E2--

