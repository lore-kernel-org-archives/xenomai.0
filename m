Resent-To: Xenomai-core@domain.hid
Resent-Message-Id: <47C0247B.1090805@domain.hid>
Message-ID: <47C02113.7070005@domain.hid>
Date: Sat, 23 Feb 2008 14:36:03 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47C020A9.3050704@domain.hid>
In-Reply-To: <47C020A9.3050704@domain.hid>
Content-Type: multipart/mixed; boundary="------------060205050202020802080509"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 2/4] Fix and optimize xnlock_put
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
--------------060205050202020802080509
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

As the #ifdef forest was cut down, I once again looked at xnlock_put.
Why do you have this safety check for the owner also in production code?
Let's move it into the debug section. That leaves up with

static inline void xnlock_put(xnlock_t *lock)
{
	xnlock_dbg_release(lock);
	atomic_set(&lock->owner, ~0);
}

Nice - but wait, where is the memory barrier here? Was it in the
original code? No! Neither atomic_read, atomic_set, nor the
rthal_processor_id imply any kind of barrier to ensure all memory writes
inside the protected region are committed before releasing the lock.

Cool, there was a real bug under all this dust, and this patch fixes it
+ it shortens the hot path on SMP production systems.

Jan


--------------060205050202020802080509
Content-Type: text/x-patch;
 name="rework-xnlock_put.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rework-xnlock_put.patch"

---
 include/asm-generic/system.h |   38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

Index: b/include/asm-generic/system.h
===================================================================
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -163,7 +163,20 @@ static inline void xnlock_dbg_release(xn
 {
 	extern xnlockinfo_t xnlock_stats[];
 	unsigned long long lock_time = rthal_rdtsc() - lock->lock_date;
-	xnlockinfo_t *stats = &xnlock_stats[xnarch_current_cpu()];
+	int cpu = xnarch_current_cpu();
+	xnlockinfo_t *stats = &xnlock_stats[cpu];
+
+	if (unlikely(atomic_read(&lock->owner) != cpu)) {
+		rthal_emergency_console();
+		printk(KERN_ERR "Xenomai: unlocking unlocked nucleus lock %p"
+				" on CPU #%d\n"
+				"         owner  = %s:%u (%s(), CPU #%d)\n",
+		       lock, cpu, lock->file, lock->line, lock->function,
+		       lock->cpu);
+		show_stack(NULL,NULL);
+		for (;;)
+			cpu_relax();
+	}
 
 	if (lock_time > stats->lock_time) {
 		stats->lock_time = lock_time;
@@ -174,17 +187,6 @@ static inline void xnlock_dbg_release(xn
 	}
 }
 
-static inline void xnlock_dbg_invalid_release(xnlock_t *lock)
-{
-	rthal_emergency_console();
-	printk(KERN_ERR "Xenomai: unlocking unlocked nucleus lock %p\n"
-			"       owner  = %s:%u (%s(), CPU #%d)\n",
-	       lock, lock->file, lock->line, lock->function, lock->cpu);
-	show_stack(NULL,NULL);
-	for (;;)
-		cpu_relax();
-}
-
 #else /* !(CONFIG_SMP && XENO_DEBUG(NUCLEUS)) */
 
 typedef struct { atomic_t owner; } xnlock_t;
@@ -198,8 +200,7 @@ typedef struct { atomic_t owner; } xnloc
 #define XNLOCK_DBG_SPINNING()		do { } while (0)
 #define XNLOCK_DBG_ACQUIRED()		do { } while (0)
 
-static inline void xnlock_dbg_release(xnlock_t *lock)		{ }
-static inline void xnlock_dbg_invalid_release(xnlock_t *lock)	{ }
+static inline void xnlock_dbg_release(xnlock_t *lock)	{ }
 
 #endif /* !(CONFIG_SMP && XENO_DEBUG(NUCLEUS)) */
 
@@ -325,11 +326,10 @@ static inline int __xnlock_get(xnlock_t 
 
 static inline void xnlock_put(xnlock_t *lock)
 {
-	if (likely(atomic_read(&lock->owner) == xnarch_current_cpu())) {
-		xnlock_dbg_release(lock);
-		atomic_set(&lock->owner, ~0);
-	} else
-		xnlock_dbg_invalid_release(lock);
+	xnarch_memory_barrier();
+
+	xnlock_dbg_release(lock);
+	atomic_set(&lock->owner, ~0);
 }
 
 static inline spl_t

--------------060205050202020802080509--


