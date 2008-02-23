Message-ID: <47C02491.203@domain.hid>
Date: Sat, 23 Feb 2008 14:50:09 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47C020A9.3050704@domain.hid>
In-Reply-To: <47C020A9.3050704@domain.hid>
Content-Type: multipart/mixed; boundary="------------040909040303030102080500"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH 4/4] Recursive FIFO ticket xnlock
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

This is a multi-part message in MIME format.
--------------040909040303030102080500
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

The root of all this: When Nick Piggin posted his first suggestion for
ticket spinlocks on LKML, I immediately liked the idea. For details
check LWN [1], in a nutshell: This algorithm enforces strict FIFO order
for the admission to contended spinlocks, thus it improves the
determinism on SMP systems with more than 2 CPUs.

Meanwhile, ticket spinlocks are mainline (2.6.25). But that version has
to drawbacks for us: it doesn't support nesting like xnlock does, and it
is x86-only so far.

So I designed a version for Xenomai which is both nestable and
arch-independent. It is certainly not as optimal as mainline's version,
but our code path stresses the locking code differently anyway.

This thing here /seems/ to work, but I'm lacking CPUs at home to test.
You can't truly stress ticket locks with only a single dual-core :-/.
QEMU runs into a live-lock with -smp 2, this patch applied and two
moderate latency loops, but that might be an artifact of its
single-threaded VCPU scheduling. And kvm currently locks up under SMP
even without any change, but kvm and SMP is a story of its own. There is
hope: 16-way is waiting at work... :)

Jan

[1] http://lwn.net/Articles/267331


--------------040909040303030102080500
Content-Type: text/x-patch;
 name="ticket-xnlock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ticket-xnlock.patch"

---
 include/asm-generic/system.h |  110 +++++++++++++++++++++++++++++++++++++++----
 ksrc/nucleus/Kconfig         |   12 ++++
 2 files changed, 112 insertions(+), 10 deletions(-)

Index: b/include/asm-generic/system.h
===================================================================
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -104,7 +104,12 @@ typedef struct {
 
 typedef struct {
 
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
 
 #define XNARCH_LOCK_UNLOCKED (xnlock_t) {	\
-	{ ~0 },					\
+	XNLOCK_INIT_VALUE,			\
 	NULL,					\
 	NULL,					\
 	0,					\
@@ -159,6 +164,8 @@ typedef struct {
 		lock->cpu = cpu;					\
 	} while (0)
 
+static inline int xnlock_owner(xnlock_t *lock);
+
 static inline void xnlock_dbg_release(xnlock_t *lock)
 {
 	extern xnlockinfo_t xnlock_stats[];
@@ -166,7 +173,7 @@ static inline void xnlock_dbg_release(xn
 	int cpu = xnarch_current_cpu();
 	xnlockinfo_t *stats = &xnlock_stats[cpu];
 
-	if (unlikely(atomic_read(&lock->owner) != cpu)) {
+	if (unlikely(xnlock_owner(lock) != cpu)) {
 		rthal_emergency_console();
 		printk(KERN_ERR "Xenomai: unlocking unlocked nucleus lock %p"
 				" on CPU #%d\n"
@@ -189,9 +196,18 @@ static inline void xnlock_dbg_release(xn
 
 #else /* !(CONFIG_SMP && XENO_DEBUG(NUCLEUS)) */
 
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
 
-#define XNARCH_LOCK_UNLOCKED		(xnlock_t) { { ~0 } }
+#define XNARCH_LOCK_UNLOCKED		(xnlock_t) { XNLOCK_INIT_VALUE }
 
 #define XNLOCK_DBG_CONTEXT
 #define XNLOCK_DBG_CONTEXT_ARGS
@@ -294,20 +310,88 @@ static inline int xnarch_setimask (int i
 #define xnlock_clear_irqoff(lock)	xnlock_put_irqrestore(lock, 1)
 #define xnlock_clear_irqon(lock)	xnlock_put_irqrestore(lock, 0)
 
-static inline void xnlock_init (xnlock_t *lock)
-{
-	*lock = XNARCH_LOCK_UNLOCKED;
-}
-
 #define DECLARE_XNLOCK(lock)		xnlock_t lock
 #define DECLARE_EXTERN_XNLOCK(lock)	extern xnlock_t lock
 #define DEFINE_XNLOCK(lock)		xnlock_t lock = XNARCH_LOCK_UNLOCKED
 #define DEFINE_PRIVATE_XNLOCK(lock)	static DEFINE_XNLOCK(lock)
 
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
+static inline int __xnlock_get(xnlock_t *lock  XNLOCK_DBG_CONTEXT_ARGS)
+{
+	int cpu = xnarch_current_cpu();
+	int recursing = (xnlock_owner(lock) == cpu);
+	u32 fifo;
+	u8 ticket;
+
+	if (!recursing) {
+		XNLOCK_DBG_PREPARE_ACQUIRE();
+
+		fifo = atomic_add_return(XNLOCK_TAIL_INC, &lock->fifo);
+		ticket = fifo >> XNLOCK_TAIL_SHIFT;
+
+		/* First check if we are already the owner (head == tail). */
+		if (unlikely((u8)fifo != ticket)) {
+			/*
+			 * Spin until head equals our ticket.
+			 */
+			do {
+				cpu_relax();
+				XNLOCK_DBG_SPINNING();
+			} while ((u8)atomic_read(&lock->fifo) != ticket);
+		}
+
+		lock->owner = cpu;
+		XNLOCK_DBG_ACQUIRED();
+	}
+
+	return recursing;
+}
+
+static inline void xnlock_put(xnlock_t *lock)
+{
+	u32 fifo = atomic_read(&lock->fifo);
+
+	xnlock_dbg_release(lock);
+
+	lock->owner = ~0;
+
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
 static inline int __xnlock_get(xnlock_t *lock  XNLOCK_DBG_CONTEXT_ARGS)
 {
 	int cpu = xnarch_current_cpu();
-	int recursing = (atomic_read(&lock->owner) == cpu);
+	int recursing = (xnlock_owner(lock) == cpu);
 
 	if (!recursing) {
 		XNLOCK_DBG_PREPARE_ACQUIRE();
@@ -331,6 +415,12 @@ static inline void xnlock_put(xnlock_t *
 	xnlock_dbg_release(lock);
 	atomic_set(&lock->owner, ~0);
 }
+#endif /* ! CONFIG_XENO_OPT_TICKET_LOCK */
+
+static inline void xnlock_init(xnlock_t *lock)
+{
+	*lock = XNARCH_LOCK_UNLOCKED;
+}
 
 spl_t __xnlock_get_irqsave(xnlock_t *lock  XNLOCK_DBG_CONTEXT_ARGS);
 void xnlock_put_irqrestore(xnlock_t *lock, spl_t flags);
@@ -342,7 +432,7 @@ static inline int xnarch_send_ipi(xnarch
 
 static inline int xnlock_is_owner(xnlock_t *lock)
 {
-	return atomic_read(&lock->owner) == xnarch_current_cpu();
+	return xnlock_owner(lock) == xnarch_current_cpu();
 }
 
 #else /* !CONFIG_SMP */
Index: b/ksrc/nucleus/Kconfig
===================================================================
--- a/ksrc/nucleus/Kconfig
+++ b/ksrc/nucleus/Kconfig
@@ -340,6 +340,18 @@ config XENO_OPT_TIMER_WHEEL_STEP
 	Set the duration in ns of a timer wheel step. At each step, 
 	the timer wheel use the next hash bucket.
 
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
 
 endif


--------------040909040303030102080500--

