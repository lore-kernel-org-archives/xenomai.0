Message-ID: <458038A5.9080508@domain.hid>
Date: Wed, 13 Dec 2006 18:30:13 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigADF1CD714731217582F4C121"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH] kill hard rwlocks
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigADF1CD714731217582F4C121
Content-Type: multipart/mixed; boundary="------------070401050400040301000302"

This is a multi-part message in MIME format.
--------------070401050400040301000302
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

at the risk of overseeing some valid use case, I'm proposing to get rid
of the hard rw-spinlocks in both Xenomai and I-pipe. Find attached
patches to convert the only user, the IRQ shield, to a spinlock and
remove the related wrappings in the HAL and in I-pipe.

Jan

--------------070401050400040301000302
Content-Type: text/plain;
 name="convert-shield-lock.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="convert-shield-lock.patch"

---
 include/asm-generic/hal.h |   23 ++++++-----------------
 ksrc/nucleus/shadow.c     |   12 ++++++------
 2 files changed, 12 insertions(+), 23 deletions(-)

Index: xenomai/include/asm-generic/hal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-generic/hal.h
+++ xenomai/include/asm-generic/hal.h
@@ -84,24 +84,18 @@
=20
 typedef struct ipipe_domain rthal_pipeline_stage_t;
=20
-#ifdef IPIPE_RW_LOCK_UNLOCKED
+#ifdef IPIPE_SPIN_LOCK_UNLOCKED
 typedef ipipe_spinlock_t rthal_spinlock_t;
 #define RTHAL_SPIN_LOCK_UNLOCKED IPIPE_SPIN_LOCK_UNLOCKED
-typedef ipipe_rwlock_t rthal_rwlock_t;
-#define RTHAL_RW_LOCK_UNLOCKED   IPIPE_RW_LOCK_UNLOCKED
-#else /* !IPIPE_RW_LOCK_UNLOCKED */
-#ifdef RAW_RW_LOCK_UNLOCKED
+#else /* !IPIPE_SPIN_LOCK_UNLOCKED */
+#ifdef RAW_SPIN_LOCK_UNLOCKED
 typedef raw_spinlock_t rthal_spinlock_t;
 #define RTHAL_SPIN_LOCK_UNLOCKED RAW_SPIN_LOCK_UNLOCKED
-typedef raw_rwlock_t rthal_rwlock_t;
-#define RTHAL_RW_LOCK_UNLOCKED RAW_RW_LOCK_UNLOCKED
-#else /* !RAW_RW_LOCK_UNLOCKED */
+#else /* !RAW_SPIN_LOCK_UNLOCKED */
 typedef spinlock_t rthal_spinlock_t;
 #define RTHAL_SPIN_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
-typedef rwlock_t rthal_rwlock_t;
-#define RTHAL_RW_LOCK_UNLOCKED RW_LOCK_UNLOCKED
-#endif /* RAW_RW_LOCK_UNLOCKED */
-#endif /* IPIPE_RW_LOCK_UNLOCKED */
+#endif /* !RAW_SPIN_LOCK_UNLOCKED */
+#endif /* !IPIPE_SPIN_LOCK_UNLOCKED */
=20
 #define rthal_irq_cookie(ipd,irq)	__ipipe_irq_cookie(ipd,irq)
 #define rthal_irq_handler(ipd,irq)	__ipipe_irq_handler(ipd,irq)
@@ -131,11 +125,6 @@ typedef rwlock_t rthal_rwlock_t;
 #define rthal_local_irq_disable_hw()	local_irq_disable_hw()
 #define rthal_local_irq_flags_hw(x)	local_save_flags_hw(x)
=20
-#define rthal_write_lock(lock)	write_lock_hw(lock)
-#define rthal_write_unlock(lock)	write_unlock_hw(lock)
-#define rthal_read_lock(lock)		read_lock_hw(lock)
-#define rthal_read_unlock(lock)	read_unlock_hw(lock)
-
 #ifdef spin_lock_hw
 #define rthal_spin_lock_init(lock)	spin_lock_init(lock)
 #define rthal_spin_lock(lock)		spin_lock_hw(lock)
Index: xenomai/ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/shadow.c
+++ xenomai/ksrc/nucleus/shadow.c
@@ -295,7 +295,7 @@ static rthal_pipeline_stage_t irq_shield
=20
 static cpumask_t shielded_cpus, unshielded_cpus;
=20
-static rthal_rwlock_t shield_lock =3D RTHAL_RW_LOCK_UNLOCKED;
+static rthal_spinlock_t shield_lock =3D RTHAL_SPIN_LOCK_UNLOCKED;
=20
 static inline void engage_irq_shield(void)
 {
@@ -307,13 +307,13 @@ static inline void engage_irq_shield(voi
 	if (xnarch_cpu_test_and_set(cpuid, shielded_cpus))
 		goto unmask_and_exit;
=20
-	rthal_read_lock(&shield_lock);
+	rthal_spin_lock(&shield_lock);
=20
 	xnarch_cpu_clear(cpuid, unshielded_cpus);
=20
 	xnarch_lock_xirqs(&irq_shield, cpuid);
=20
-	rthal_read_unlock(&shield_lock);
+	rthal_spin_unlock(&shield_lock);
=20
       unmask_and_exit:
=20
@@ -330,7 +330,7 @@ static void disengage_irq_shield(void)
 	if (xnarch_cpu_test_and_set(cpuid, unshielded_cpus))
 		goto unmask_and_exit;
=20
-	rthal_write_lock(&shield_lock);
+	rthal_spin_lock(&shield_lock);
=20
 	xnarch_cpu_clear(cpuid, shielded_cpus);
=20
@@ -339,7 +339,7 @@ static void disengage_irq_shield(void)
 	   (i.e. if no CPU asked for shielding). */
=20
 	if (!cpus_empty(shielded_cpus)) {
-		rthal_write_unlock(&shield_lock);
+		rthal_spin_unlock(&shield_lock);
 		goto unmask_and_exit;
 	}
=20
@@ -360,7 +360,7 @@ static void disengage_irq_shield(void)
 	}
 #endif /* CONFIG_SMP */
=20
-	rthal_write_unlock(&shield_lock);
+	rthal_spin_unlock(&shield_lock);
=20
 	rthal_stage_irq_enable(&irq_shield);
=20

--------------070401050400040301000302
Content-Type: text/plain;
 name="remove-rwlocks.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="remove-rwlocks.patch"

---
 include/linux/ipipe.h |   43 -------------------------------------------=

 lib/spinlock_debug.c  |   18 ------------------
 2 files changed, 61 deletions(-)

Index: linux-2.6.19-ipipe/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/include/linux/ipipe.h
+++ linux-2.6.19-ipipe/include/linux/ipipe.h
@@ -229,49 +229,6 @@ do { \
 	} \
 } while(0)
=20
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-#define write_lock_hw(x)		__raw_write_lock(&(x)->raw_lock)
-#define write_trylock_hw(x)		__raw_write_trylock(&(x)->raw_lock)
-#define write_unlock_hw(x)		__raw_write_unlock(&(x)->raw_lock)
-#define read_lock_hw(x)		__raw_read_lock(&(x)->raw_lock)
-#define read_trylock_hw(x)		__raw_read_trylock(&(x)->raw_lock)
-#define read_unlock_hw(x)		__raw_read_unlock(&(x)->raw_lock)
-#else /* UP non-debug */
-#define write_lock_hw(lock)		do { (void)(lock); } while (0)
-#define write_trylock_hw(lock)	({ (void)(lock); 1; })
-#define write_unlock_hw(lock)		do { (void)(lock); } while (0)
-#define read_lock_hw(lock)		do { (void)(lock); } while (0)
-#define read_trylock_hw(lock)		({ (void)(lock); 1; })
-#define read_unlock_hw(lock)		do { (void)(lock); } while (0)
-#endif /* CONFIG_SMP || CONFIG_DEBUG_SPINLOCK */
-
-typedef rwlock_t			ipipe_rwlock_t;
-#define IPIPE_RW_LOCK_UNLOCKED		RW_LOCK_UNLOCKED
-
-#define read_lock_irqsave_hw(lock, flags)	\
-do {						\
-	local_irq_save_hw(flags);		\
-	read_lock_hw(lock);			\
-} while (0)
-
-#define read_unlock_irqrestore_hw(lock, flags)	\
-do {						\
-	read_unlock_hw(lock);			\
-	local_irq_restore_hw(flags);		\
-} while (0)
-
-#define write_lock_irqsave_hw(lock, flags)	\
-do {						\
-	local_irq_save_hw(flags);		\
-	write_lock_hw(lock);			\
-} while (0)
-
-#define write_unlock_irqrestore_hw(lock, flags)	\
-do {						\
-	write_unlock_hw(lock);			\
-	local_irq_restore_hw(flags);		\
-} while (0)
-
 DECLARE_PER_CPU(struct ipipe_domain *, ipipe_percpu_domain);
=20
 extern struct ipipe_domain ipipe_root;
Index: linux-2.6.19-ipipe/lib/spinlock_debug.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/lib/spinlock_debug.c
+++ linux-2.6.19-ipipe/lib/spinlock_debug.c
@@ -129,8 +129,6 @@ void _raw_spin_lock(spinlock_t *lock)
 	debug_spin_lock_after(lock);
 }
=20
-EXPORT_SYMBOL(_raw_spin_lock);
-
 int _raw_spin_trylock(spinlock_t *lock)
 {
 	int ret =3D __raw_spin_trylock(&lock->raw_lock);
@@ -146,16 +144,12 @@ int _raw_spin_trylock(spinlock_t *lock)
 	return ret;
 }
=20
-EXPORT_SYMBOL(_raw_spin_trylock);
-
 void _raw_spin_unlock(spinlock_t *lock)
 {
 	debug_spin_unlock(lock);
 	__raw_spin_unlock(&lock->raw_lock);
 }
=20
-EXPORT_SYMBOL(_raw_spin_unlock);
-
 static void rwlock_bug(rwlock_t *lock, const char *msg)
 {
 	if (!debug_locks_off())
@@ -201,8 +195,6 @@ void _raw_read_lock(rwlock_t *lock)
 	__raw_read_lock(&lock->raw_lock);
 }
=20
-EXPORT_SYMBOL(_raw_read_lock);
-
 int _raw_read_trylock(rwlock_t *lock)
 {
 	int ret =3D __raw_read_trylock(&lock->raw_lock);
@@ -216,16 +208,12 @@ int _raw_read_trylock(rwlock_t *lock)
 	return ret;
 }
=20
-EXPORT_SYMBOL(_raw_read_trylock);
-
 void _raw_read_unlock(rwlock_t *lock)
 {
 	RWLOCK_BUG_ON(lock->magic !=3D RWLOCK_MAGIC, lock, "bad magic");
 	__raw_read_unlock(&lock->raw_lock);
 }
=20
-EXPORT_SYMBOL(_raw_read_unlock);
-
 static inline void debug_write_lock_before(rwlock_t *lock)
 {
 	RWLOCK_BUG_ON(lock->magic !=3D RWLOCK_MAGIC, lock, "bad magic");
@@ -283,8 +271,6 @@ void _raw_write_lock(rwlock_t *lock)
 	debug_write_lock_after(lock);
 }
=20
-EXPORT_SYMBOL(_raw_write_lock);
-
 int _raw_write_trylock(rwlock_t *lock)
 {
 	int ret =3D __raw_write_trylock(&lock->raw_lock);
@@ -300,12 +286,8 @@ int _raw_write_trylock(rwlock_t *lock)
 	return ret;
 }
=20
-EXPORT_SYMBOL(_raw_write_trylock);
-
 void _raw_write_unlock(rwlock_t *lock)
 {
 	debug_write_unlock(lock);
 	__raw_write_unlock(&lock->raw_lock);
 }
-
-EXPORT_SYMBOL(_raw_write_unlock);

--------------070401050400040301000302--

--------------enigADF1CD714731217582F4C121
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgDilniDOoMHTA+kRAmEjAJ9AinDAGZU5Rr61gz/TS9QgpvbheACdHlhH
M1bF/2vLHVu8XgCzDIWietA=
=FcKC
-----END PGP SIGNATURE-----

--------------enigADF1CD714731217582F4C121--

