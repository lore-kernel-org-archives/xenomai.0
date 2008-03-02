Message-ID: <47CA839B.6090006@domain.hid>
Date: Sun, 02 Mar 2008 11:38:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47C51A34.203@domain.hid>
In-Reply-To: <47C51A34.203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig54D2CF5D63C6900F24C88432"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] [PATCH 5/6] Introduce optional recursive ticket
	xnlock
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
--------------enig54D2CF5D63C6900F24C88432
Content-Type: multipart/mixed;
 boundary="------------020706050700040301050107"

This is a multi-part message in MIME format.
--------------020706050700040301050107
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The origin of this series: When Nick Piggin posted his first suggestion
for ticket spinlocks on LKML, I immediately liked the idea. For details
check LWN [1], in a nutshell: This algorithm enforces strict FIFO order
for the admission to contended spinlocks, thus it improves the
determinism on SMP systems with more than 2 CPUs.

Meanwhile, ticket spinlocks are mainline (2.6.25). But that version has
to drawbacks for us: it doesn't support nesting like xnlock does, and it
is x86-only so far.

So I designed a version for Xenomai which is both nestable and
arch-independent. It is certainly not as optimal as mainline's version,
but our code path stresses the locking code differently anyway, and no
one denies us to introduce per-arch optimized variants later on (if this
lock implementation gains broader relevance).

Survived heavy testing on a 4-way box (15, 20, 25, and 30 us latency
instances across the cores).

[1] http://lwn.net/Articles/267331

--------------020706050700040301050107
Content-Type: text/x-patch;
 name="ticket-xnlock-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="ticket-xnlock-v2.patch"

---
 include/asm-generic/bits/pod.h |    4 -
 include/asm-generic/system.h   |  122 ++++++++++++++++++++++++++++++++++=
+++----
 ksrc/nucleus/Kconfig           |   12 ++++
 3 files changed, 126 insertions(+), 12 deletions(-)

Index: b/include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -104,7 +104,12 @@ typedef struct {
=20
 typedef struct {
=20
+#ifdef CONFIG_XENO_OPT_TICKET_LOCK
+	atomic_t fifo;
+	int owner;
+#else
 	atomic_t owner;
+#endif
 	const char *file;
 	const char *function;
 	unsigned line;
@@ -115,7 +120,7 @@ typedef struct {
 } xnlock_t;
=20
 #define XNARCH_LOCK_UNLOCKED (xnlock_t) {	\
-	{ ~0 },					\
+	XNLOCK_INIT_VALUE,			\
 	NULL,					\
 	NULL,					\
 	0,					\
@@ -167,6 +172,8 @@ xnlock_dbg_acquired(xnlock_t *lock, int=20
 	lock->cpu =3D cpu;
 }
=20
+static inline int xnlock_owner(xnlock_t *lock);
+
 static inline int xnlock_dbg_release(xnlock_t *lock)
 {
 	extern xnlockinfo_t xnlock_stats[];
@@ -174,7 +181,7 @@ static inline int xnlock_dbg_release(xnl
 	int cpu =3D xnarch_current_cpu();
 	xnlockinfo_t *stats =3D &xnlock_stats[cpu];
=20
-	if (unlikely(atomic_read(&lock->owner) !=3D cpu)) {
+	if (unlikely(xnlock_owner(lock) !=3D cpu)) {
 		rthal_emergency_console();
 		printk(KERN_ERR "Xenomai: unlocking unlocked nucleus lock %p"
 				" on CPU #%d\n"
@@ -199,9 +206,18 @@ static inline int xnlock_dbg_release(xnl
=20
 #else /* !(CONFIG_SMP && XENO_DEBUG(NUCLEUS)) */
=20
+#ifdef CONFIG_XENO_OPT_TICKET_LOCK
+typedef struct {
+
+	atomic_t fifo;
+	int owner;
+
+} xnlock_t;
+#else
 typedef struct { atomic_t owner; } xnlock_t;
+#endif
=20
-#define XNARCH_LOCK_UNLOCKED		(xnlock_t) { { ~0 } }
+#define XNARCH_LOCK_UNLOCKED		(xnlock_t) { XNLOCK_INIT_VALUE }
=20
 #define XNLOCK_DBG_CONTEXT
 #define XNLOCK_DBG_CONTEXT_ARGS
@@ -313,11 +329,6 @@ static inline int xnarch_setimask (int i
 #define xnlock_clear_irqoff(lock)	xnlock_put_irqrestore(lock, 1)
 #define xnlock_clear_irqon(lock)	xnlock_put_irqrestore(lock, 0)
=20
-static inline void xnlock_init (xnlock_t *lock)
-{
-	*lock =3D XNARCH_LOCK_UNLOCKED;
-}
-
 #define DECLARE_XNLOCK(lock)		xnlock_t lock
 #define DECLARE_EXTERN_XNLOCK(lock)	extern xnlock_t lock
 #define DEFINE_XNLOCK(lock)		xnlock_t lock =3D XNARCH_LOCK_UNLOCKED
@@ -325,12 +336,97 @@ static inline void xnlock_init (xnlock_t
=20
 void __xnlock_spin(xnlock_t *lock /*, */ XNLOCK_DBG_CONTEXT_ARGS);
=20
+#ifdef CONFIG_XENO_OPT_TICKET_LOCK
+/* Note: We assume atomic_t is at least 32-bit wide. */
+#define XNLOCK_HEAD_MASK		0x000000FF
+#define XNLOCK_HEAD_INC			0x00000001
+#define XNLOCK_TAIL_MASK		0xFF000000
+#define XNLOCK_TAIL_SHIFT		24
+#define XNLOCK_TAIL_INC			0x01000000
+#define XNLOCK_TICKET_MASK		(XNLOCK_HEAD_MASK | XNLOCK_TAIL_MASK)
+#define XNLOCK_INIT_VALUE		{ 0x00000001 }, ~0
+
+static inline int xnlock_owner(xnlock_t *lock)
+{
+	return lock->owner;
+}
+
+static inline int __xnlock_get(xnlock_t *lock /*, */ XNLOCK_DBG_CONTEXT_=
ARGS)
+{
+	unsigned long long start;
+	int cpu =3D xnarch_current_cpu();
+	u32 fifo;
+	u8 ticket;
+
+	if (xnlock_owner(lock) =3D=3D cpu)
+		return 1;
+
+	xnlock_dbg_prepare_acquire(&start);
+
+	fifo =3D atomic_add_return(XNLOCK_TAIL_INC, &lock->fifo);
+	ticket =3D fifo >> XNLOCK_TAIL_SHIFT;
+
+	/* First check if we are already the owner (head =3D=3D tail). */
+	if (unlikely((u8)fifo !=3D ticket)) {
+	 	unsigned int spin_limit;
+
+		xnlock_dbg_prepare_spin(&spin_limit);
+
+		/*
+		 * Spin until head equals our ticket. In this case,
+		 * moving out-of-line does not pay off.
+		 */
+		do {
+			cpu_relax();
+			xnlock_dbg_spinning(lock, cpu, &spin_limit /*, */
+					    XNLOCK_DBG_PASS_CONTEXT);
+		} while ((u8)atomic_read(&lock->fifo) !=3D ticket);
+	}
+	lock->owner =3D cpu;
+
+	xnlock_dbg_acquired(lock, cpu, &start /*, */ XNLOCK_DBG_PASS_CONTEXT);
+
+	return 0;
+}
+
+static inline void xnlock_put(xnlock_t *lock)
+{
+	u32 fifo =3D atomic_read(&lock->fifo);
+
+	if (xnlock_dbg_release(lock))
+		return;
+
+	lock->owner =3D ~0;
+
+	/*
+	 * Make sure all data written inside the lock is visible to
+	 * other CPUs before we release the lock.
+	 */
+	xnarch_memory_barrier();
+
+	/*
+	 * Carefully calculate the addend so that we confine the
+	 * XNLOCK_HEAD_INC just to the first byte of fifo.
+	 */
+	atomic_add(((fifo + XNLOCK_HEAD_INC) & XNLOCK_TICKET_MASK) - fifo,
+		   &lock->fifo);
+}
+
+#else /* ! CONFIG_XENO_OPT_TICKET_LOCK */
+
+#define XNLOCK_INIT_VALUE		{ ~0 }
+
+static inline int xnlock_owner(xnlock_t *lock)
+{
+	return atomic_read(&lock->owner);
+}
+
 static inline int __xnlock_get(xnlock_t *lock /*, */ XNLOCK_DBG_CONTEXT_=
ARGS)
 {
 	unsigned long long start;
 	int cpu =3D xnarch_current_cpu();
=20
-	if (atomic_read(&lock->owner) =3D=3D cpu)
+	if (xnlock_owner(lock) =3D=3D cpu)
 		return 1;
=20
 	xnlock_dbg_prepare_acquire(&start);
@@ -356,6 +452,12 @@ static inline void xnlock_put(xnlock_t *
=20
 	atomic_set(&lock->owner, ~0);
 }
+#endif /* ! CONFIG_XENO_OPT_TICKET_LOCK */
+
+static inline void xnlock_init(xnlock_t *lock)
+{
+	*lock =3D XNARCH_LOCK_UNLOCKED;
+}
=20
 static inline spl_t
 __xnlock_get_irqsave(xnlock_t *lock /*, */ XNLOCK_DBG_CONTEXT_ARGS)
@@ -386,7 +488,7 @@ static inline int xnarch_send_ipi(xnarch
=20
 static inline int xnlock_is_owner(xnlock_t *lock)
 {
-	return atomic_read(&lock->owner) =3D=3D xnarch_current_cpu();
+	return xnlock_owner(lock) =3D=3D xnarch_current_cpu();
 }
=20
 #else /* !CONFIG_SMP */
Index: b/ksrc/nucleus/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/nucleus/Kconfig
+++ b/ksrc/nucleus/Kconfig
@@ -340,6 +340,18 @@ config XENO_OPT_TIMER_WHEEL_STEP
 	Set the duration in ns of a timer wheel step. At each step,=20
 	the timer wheel use the next hash bucket.
=20
+config XENO_OPT_TICKET_LOCK
+	bool "FIFO ticket spinlocks"
+	depends on SMP
+	help
+
+	Uses a ticket spinlock algorithm which enforces strict FIFO
+	admission order on contended locks, improving the determinism
+	of lock acquisitions on large SMP systems. The ticket spinlock
+	has a higher overhead than the unordered algorithm and should
+	therefore only be used if there are more than two CPUs, thus
+	more than one waiter in the worst case.
+
 endmenu
=20
 endif
Index: b/include/asm-generic/bits/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-generic/bits/pod.h
+++ b/include/asm-generic/bits/pod.h
@@ -295,7 +295,7 @@ unsigned long long xnarch_get_cpu_time(v
=20
 EXPORT_SYMBOL(xnarch_get_cpu_time);
=20
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && !defined(CONFIG_XENO_OPT_TICKET_LOCK)
 void __xnlock_spin(xnlock_t *lock /*, */ XNLOCK_DBG_CONTEXT_ARGS)
 {
 	unsigned int spin_limit;
@@ -311,6 +311,6 @@ void __xnlock_spin(xnlock_t *lock /*, */
 		} while(atomic_read(&lock->owner) !=3D ~0);
 }
 EXPORT_SYMBOL(__xnlock_spin);
-#endif /* CONFIG_SMP */
+#endif /* CONFIG_SMP && !CONFIG_XENO_OPT_TICKET_LOCK */
=20
 #endif /* !_XENO_ASM_GENERIC_BITS_POD_H */

--------------020706050700040301050107--

--------------enig54D2CF5D63C6900F24C88432
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHyoObniDOoMHTA+kRAtsHAJ4zwm7to6vRUDP2IOUTjMq32qbqSQCeOR9o
OIJLQleBU9FFPUkxqHwPYlo=
=CQMt
-----END PGP SIGNATURE-----

--------------enig54D2CF5D63C6900F24C88432--

