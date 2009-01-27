Message-ID: <497F3E29.6050303@domain.hid>
Date: Tue, 27 Jan 2009 18:02:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] xnpipe: Fix minor number management
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an attempt to fix the bugs found in the minor number management:
- changing the bitmap requires atomic operations
- clrbits/setbits work against xnarch_atomic_t, and that is only 32 bit
  wide on x86-64

The approach taken here is building the bitmap as an array of
xnarch_atomic_t variables, defining in asm/atomic.h how many bits of
xnarch_atomic_t are usable, and open-coding the bitmap search.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/asm-arm/atomic.h      |    3 +++
 include/asm-blackfin/atomic.h |    3 +++
 include/asm-powerpc/atomic.h  |    6 ++++++
 include/asm-sim/system.h      |    3 +++
 include/asm-x86/atomic.h      |    3 +++
 ksrc/nucleus/pipe.c           |   35 +++++++++++++++++++++++++----------
 6 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/include/asm-arm/atomic.h b/include/asm-arm/atomic.h
index 0b5e7de..df068c8 100644
--- a/include/asm-arm/atomic.h
+++ b/include/asm-arm/atomic.h
@@ -36,6 +36,9 @@ typedef atomic_t xnarch_atomic_t;
 #define xnarch_atomic_xchg(ptr,v)       xchg(ptr,v)
 #define xnarch_memory_barrier()  	smp_mb()
 
+#define BITS_PER_XNARCH_ATOMIC	32
+#define XNARCH_ATOMIC_MASK	((unsigned long)-1)
+
 #if __LINUX_ARM_ARCH__ >= 6
 
 static inline void
diff --git a/include/asm-blackfin/atomic.h b/include/asm-blackfin/atomic.h
index a6f03dd..4eb2bad 100644
--- a/include/asm-blackfin/atomic.h
+++ b/include/asm-blackfin/atomic.h
@@ -42,6 +42,9 @@
 typedef atomic_t atomic_counter_t;
 typedef atomic_t xnarch_atomic_t;
 
+#define BITS_PER_XNARCH_ATOMIC	32
+#define XNARCH_ATOMIC_MASK	((unsigned long)-1)
+
 #else /* !__KERNEL__ */
 
 #include <asm/xenomai/features.h>
diff --git a/include/asm-powerpc/atomic.h b/include/asm-powerpc/atomic.h
index 7b13142..ca956af 100644
--- a/include/asm-powerpc/atomic.h
+++ b/include/asm-powerpc/atomic.h
@@ -74,6 +74,9 @@ static __inline__ void atomic64_set_mask(unsigned long mask,
 typedef atomic64_t atomic_counter_t;
 typedef atomic64_t xnarch_atomic_t;
 
+#define BITS_PER_XNARCH_ATOMIC	64
+#define XNARCH_ATOMIC_MASK	((unsigned long)-1)
+
 #else /* !CONFIG_PPC64 */
  /* These are defined in arch/{ppc,powerpc}/kernel/misc[_32].S on 32-bit PowerPC */
 void atomic_set_mask(unsigned long mask, unsigned long *ptr);
@@ -93,6 +96,9 @@ void atomic_clear_mask(unsigned long mask, unsigned long *ptr);
 typedef atomic_t atomic_counter_t;
 typedef atomic_t xnarch_atomic_t;
 
+#define BITS_PER_XNARCH_ATOMIC	32
+#define XNARCH_ATOMIC_MASK	((unsigned long)-1)
+
 #endif /* !CONFIG_PPC64 */
 
 #else /* !__KERNEL__ */
diff --git a/include/asm-sim/system.h b/include/asm-sim/system.h
index cf3bee6..c889716 100644
--- a/include/asm-sim/system.h
+++ b/include/asm-sim/system.h
@@ -205,6 +205,9 @@ static inline unsigned long ffnz(unsigned long word)
 typedef int atomic_counter_t;
 typedef unsigned long atomic_flags_t;
 
+#define BITS_PER_XNARCH_ATOMIC	32
+#define XNARCH_ATOMIC_MASK	0xffffffff
+
 #define xnarch_memory_barrier()
 #define xnarch_atomic_set(pcounter,i)          (*(pcounter) = (i))
 #define xnarch_atomic_get(pcounter)            (*(pcounter))
diff --git a/include/asm-x86/atomic.h b/include/asm-x86/atomic.h
index c29b33a..7037ad2 100644
--- a/include/asm-x86/atomic.h
+++ b/include/asm-x86/atomic.h
@@ -44,6 +44,9 @@ typedef unsigned long atomic_flags_t;
 typedef atomic_long_t atomic_counter_t;
 typedef atomic_long_t xnarch_atomic_t;
 
+#define BITS_PER_XNARCH_ATOMIC	32
+#define XNARCH_ATOMIC_MASK	((unsigned int)-1)
+
 #define xnarch_atomic_set_mask(pflags,mask) \
 	atomic_set_mask((mask),(unsigned *)(pflags))
 #define xnarch_atomic_clear_mask(pflags,mask) \
diff --git a/ksrc/nucleus/pipe.c b/ksrc/nucleus/pipe.c
index d7409da..024e83c 100644
--- a/ksrc/nucleus/pipe.c
+++ b/ksrc/nucleus/pipe.c
@@ -39,8 +39,9 @@ static int xnpipe_asyncsig = SIGIO;
 
 struct xnpipe_state xnpipe_states[XNPIPE_NDEVS];
 
-#define XNPIPE_BITMAP_SIZE	((XNPIPE_NDEVS + BITS_PER_LONG - 1) / BITS_PER_LONG)
-static unsigned long xnpipe_bitmap[XNPIPE_BITMAP_SIZE];
+#define XNPIPE_BITMAP_SIZE 	((XNPIPE_NDEVS + BITS_PER_XNARCH_ATOMIC - 1) \
+				 / BITS_PER_XNARCH_ATOMIC)
+static xnarch_atomic_t xnpipe_bitmap[XNPIPE_BITMAP_SIZE];
 
 struct xnqueue xnpipe_sleepq, xnpipe_asyncq;
 
@@ -52,23 +53,36 @@ static DECLARE_DEVCLASS(xnpipe_class);
 
 static inline int xnpipe_minor_alloc(int minor)
 {
+	unsigned long val;
 	spl_t s;
+	int i;
 
 	if ((minor < 0 && minor != XNPIPE_MINOR_AUTO) || minor >= XNPIPE_NDEVS)
 		return -ENODEV;
 
 	xnlock_get_irqsave(&nklock, s);
 
-	if (minor == XNPIPE_MINOR_AUTO)
-		minor = find_first_zero_bit(xnpipe_bitmap, XNPIPE_NDEVS);
+	if (minor == XNPIPE_MINOR_AUTO) {
+		for (i = 0; i < XNPIPE_BITMAP_SIZE; i++) {
+			val = xnarch_atomic_get(&xnpipe_bitmap[i]);
+			if (val == XNARCH_ATOMIC_MASK)
+				continue;
+			minor = ffz(val) + i * BITS_PER_XNARCH_ATOMIC;
+			break;
+		}
+		if (i == XNPIPE_BITMAP_SIZE)
+			minor = XNPIPE_NDEVS;
+	}
 
 	if (minor == XNPIPE_NDEVS ||
-	    testbits(xnpipe_bitmap[minor / BITS_PER_LONG],
-		     1UL << (minor % BITS_PER_LONG)))
+	    (xnarch_atomic_get
+		(&xnpipe_bitmap[minor / BITS_PER_XNARCH_ATOMIC]) &
+	     (1 << (minor % BITS_PER_XNARCH_ATOMIC))))
 		minor = -EBUSY;
 	else
-		__setbits(xnpipe_bitmap[minor / BITS_PER_LONG],
-			  1UL << (minor % BITS_PER_LONG));
+		xnarch_atomic_set_mask
+			(&xnpipe_bitmap[minor / BITS_PER_XNARCH_ATOMIC],
+			 1 << (minor % BITS_PER_XNARCH_ATOMIC));
 
 	xnlock_put_irqrestore(&nklock, s);
 
@@ -78,8 +92,9 @@ static inline int xnpipe_minor_alloc(int minor)
 static inline void xnpipe_minor_free(int minor)
 {
 	/* May be called with nklock free. */
-	clrbits(xnpipe_bitmap[minor / BITS_PER_LONG],
-		1UL << (minor % BITS_PER_LONG));
+	xnarch_atomic_clear_mask
+		(&xnpipe_bitmap[minor / BITS_PER_XNARCH_ATOMIC],
+		 1 << (minor % BITS_PER_XNARCH_ATOMIC));
 	xnarch_memory_barrier();
 }
 

