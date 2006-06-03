MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1zjj+TOkT1"
Content-Transfer-Encoding: 7bit
Message-ID: <17537.44287.831006.236382@domain.hid>
Date: Sat, 3 Jun 2006 17:38:39 +0200
Subject: Re: [Xenomai-core] Re: [patch] static buffer for timer-bheap
In-Reply-To: <448085DE.5020803@domain.hid>
References: <447F72A0.8000000@domain.hid>
	<17536.18621.302528.67077@domain.hid>
	<4480515F.7050500@domain.hid>
	<17536.21805.408809.703077@domain.hid>
	<44806253.9020805@domain.hid>
	<17536.26182.536525.725211@domain.hid>
	<44806E3C.7080103@domain.hid> <448085DE.5020803@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>


--1zjj+TOkT1
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
 > Be warned, this patch is only compile-tested, I'm in a hurry.

I tested the lightly modified version attached and it works. Do you
agree with my changes ?

-- 


					    Gilles Chanteperdrix.

--1zjj+TOkT1
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-bheap-init-v4.diff"
Content-Transfer-Encoding: 7bit

Index: ksrc/nucleus/Kconfig
===================================================================
--- ksrc/nucleus/Kconfig	(revision 1146)
+++ ksrc/nucleus/Kconfig	(working copy)
@@ -145,6 +145,10 @@
 	operations of the Xenomai core. It adds even more runtime
 	overhead then CONFIG_XENO_OPT_DEBUG, use with care.
 
+config XENO_OPT_DEBUG_BHEAP
+	bool
+	default y if XENO_OPT_DEBUG
+
 config XENO_OPT_WATCHDOG
 	bool "Watchdog support"
 	default n
Index: ksrc/nucleus/pod.c
===================================================================
--- ksrc/nucleus/pod.c	(revision 1146)
+++ ksrc/nucleus/pod.c	(working copy)
@@ -433,22 +433,11 @@
 #ifdef CONFIG_XENO_OPT_TIMING_PERIODIC
         unsigned n;
 
-        for (n = 0; n < XNTIMER_WHEELSIZE; n++) {
-            err = -xntlist_init(&pod->sched[cpu].timerwheel[n]);
-
-            if (err) {
-                xnheap_destroy(&kheap, &xnpod_flush_heap, NULL);
-                goto fail;
-            }
-        }
+        for (n = 0; n < XNTIMER_WHEELSIZE; n++)
+            xntlist_init(&pod->sched[cpu].timerwheel[n]);
 #endif /* CONFIG_XENO_OPT_TIMING_PERIODIC */
 
-        err = -xntimerq_init(&pod->sched[cpu].timerqueue);
-
-        if (err) {
-            xnheap_destroy(&kheap, &xnpod_flush_heap, NULL);
-            goto fail;
-        }
+        xntimerq_init(&pod->sched[cpu].timerqueue);
     }
 
     for (cpu = 0; cpu < nr_cpus; ++cpu) {
@@ -585,15 +574,8 @@
 
     __setbits(nkpod->status, XNPIDLE);
 
-    for (cpu = 0; cpu < xnarch_num_online_cpus(); cpu++) {
-#ifdef CONFIG_XENO_OPT_TIMING_PERIODIC
-        unsigned n;
-
-        for (n = 0; n < XNTIMER_WHEELSIZE; n++)
-            xntlist_destroy(&nkpod->sched[cpu].timerwheel[n]);
-#endif /* CONFIG_XENO_OPT_TIMING_PERIODIC */
+    for (cpu = 0; cpu < xnarch_num_online_cpus(); cpu++)
         xntimerq_destroy(&nkpod->sched[cpu].timerqueue);
-    }
 
     xnlock_put_irqrestore(&nklock, s);
 
Index: ksrc/nucleus/Config.in
===================================================================
--- ksrc/nucleus/Config.in	(revision 1146)
+++ ksrc/nucleus/Config.in	(working copy)
@@ -32,6 +32,7 @@
 	bool 'Debug support' CONFIG_XENO_OPT_DEBUG
 	if [ "$CONFIG_XENO_OPT_DEBUG" = "y" ]; then
 		bool 'Queue Debugging support' CONFIG_XENO_OPT_DEBUG_QUEUES
+		define_bool CONFIG_XENO_OPT_DEBUG_BHEAP y
 	fi
 	bool 'Watchdog support' CONFIG_XENO_OPT_WATCHDOG
 
Index: include/nucleus/bheap.h
===================================================================
--- include/nucleus/bheap.h	(revision 1146)
+++ include/nucleus/bheap.h	(working copy)
@@ -21,6 +21,7 @@
 #define _XENO_NUCLEUS_BHEAP_H
 
 #include <nucleus/compiler.h>
+#include <nucleus/assert.h>
 
 /* Priority queue implementation, using a binary heap. */
 
@@ -43,10 +44,29 @@
 typedef struct bheap {
     unsigned sz;
     unsigned last;
-    bheaph_t **elems;
+    bheaph_t *elems[1]; /* only padding, indexing starts at 1 */
 } bheap_t;
 
-static inline bheaph_t *bheap_gethead(bheap_t *heap)
+#define DECLARE_BHEAP_CONTAINER(name, sz)       \
+    struct {                                    \
+        bheap_t bheap;                          \
+        bheaph_t *elems[sz];                    \
+    } name
+
+#ifdef CONFIG_XENO_OPT_DEBUG_BHEAP
+#define BHEAP_CHECK(heap)   XENO_BUGON(BHEAP, ((heap)->sz == 0))
+#else /* !CONFIG_XENO_OPT_DEBUG_BHEAP */
+#define BHEAP_CHECK(heap)   do { } while (0)
+#endif /* CONFIG_XENO_OPT_DEBUG_BHEAP */
+
+#define bheap_gethead(heap)                     \
+({                                              \
+    bheap_t *_bheap = &(heap)->bheap;           \
+    BHEAP_CHECK(_bheap);                        \
+    __internal_bheap_gethead(_bheap);           \
+})
+
+static inline bheaph_t *__internal_bheap_gethead(bheap_t *heap)
 {
     if (heap->last == 1)
         return NULL;
@@ -68,26 +88,20 @@
     return likely(pos < heap->last) ? heap->elems[pos] : NULL;
 }
 
-static inline int bheap_init(bheap_t *heap, unsigned sz)
+#define bheap_init(heap, sz) __internal_bheap_init(&(heap)->bheap, sz)
+
+static inline void __internal_bheap_init(bheap_t *heap, unsigned sz)
 {
     heap->sz = sz;
     heap->last = 1;
-    heap->elems = (bheaph_t **) xnarch_sysalloc(sz * sizeof(void *));
+}
 
-    if (!heap->elems)
-        return ENOMEM;
+#define bheap_destroy(heap) __internal_bheap_destroy(&(heap)->bheap)
 
-    /* start indexing at 1. */
-    heap->elems -= 1;
-
-    return 0;
-}
-
-static inline void bheap_destroy(bheap_t *heap)
-{    
-    xnarch_sysfree(heap->elems + 1, heap->sz * sizeof(void *));
-    heap->last = 0;
+static inline void __internal_bheap_destroy(bheap_t *heap)
+{
     heap->sz = 0;
+    heap->last = 1;
 }
 
 static inline void bheap_swap(bheap_t *heap, bheaph_t *h1, bheaph_t *h2)
@@ -115,7 +129,7 @@
     for (;;) {
         left = bheaph_child(heap, holder, 0);
         right = bheaph_child(heap, holder, 1);
-        
+
         if (left && right)
             minchild = bheaph_lt(left, right) ? left : right;
         else
@@ -128,7 +142,14 @@
     }
 }
 
-static inline int bheap_insert(bheap_t *heap, bheaph_t *holder)
+#define bheap_insert(heap, holder)              \
+({                                              \
+    bheap_t *_bheap = &(heap)->bheap;           \
+    BHEAP_CHECK(_bheap);                        \
+    __internal_bheap_insert(_bheap, holder);    \
+})
+
+static inline int __internal_bheap_insert(bheap_t *heap, bheaph_t *holder)
 {
     if (heap->last == heap->sz + 1)
         return EBUSY;
@@ -140,32 +161,46 @@
     return 0;
 }
 
-static inline int bheap_delete(bheap_t *heap, bheaph_t *holder)
+#define bheap_delete(heap, holder)              \
+({                                              \
+    bheap_t *_bheap = &(heap)->bheap;           \
+    BHEAP_CHECK(_bheap);                        \
+    __internal_bheap_delete(_bheap, holder);    \
+})
+
+static inline int __internal_bheap_delete(bheap_t *heap, bheaph_t *holder)
 {
     bheaph_t *lasth;
-    
-    if (heap->last == 1)
+
+    if (bheaph_pos(holder) >= heap->last)
         return EINVAL;
-    
+
     --heap->last;
-    if (heap->last > 1) {
+    if (heap->last != bheaph_pos(holder)) {
         lasth = heap->elems[heap->last];
         heap->elems[bheaph_pos(holder)] = lasth;
         bheaph_pos(lasth) = bheaph_pos(holder);
         bheap_down(heap, lasth);
     }
-   
+
     return 0;
 }
 
-static inline bheaph_t *bheap_get(bheap_t *heap)
+#define bheap_get(heap)                         \
+({                                              \
+    bheap_t *_bheap = &(heap)->bheap;           \
+    BHEAP_CHECK(_bheap);                        \
+    __internal_bheap_get(_bheap, holder);       \
+})
+
+static inline bheaph_t *__internal_bheap_get(bheap_t *heap)
 {
-    bheaph_t *holder = bheap_gethead(heap);
+    bheaph_t *holder = __internal_bheap_gethead(heap);
 
     if (!holder)
         return NULL;
 
-    bheap_delete(heap, holder);
+    __internal_bheap_delete(heap, holder);
 
     return holder;
 }
Index: include/nucleus/timer.h
===================================================================
--- include/nucleus/timer.h	(revision 1146)
+++ include/nucleus/timer.h	(working copy)
@@ -58,11 +58,10 @@
     ((xntlholder_t *)(((char *)laddr) - offsetof(xntlholder_t, link)))
 
 } xntlholder_t;
-#define xntlholder_date(h)       ((h)->key)
-#define xntlholder_prio(h)       ((h)->prio)
-#define xntlholder_init(h)       inith(&(h)->link)
-#define xntlist_init(q)       (initq(q),0)
-#define xntlist_destroy(q)    do { } while (0)
+#define xntlholder_date(h)      ((h)->key)
+#define xntlholder_prio(h)      ((h)->prio)
+#define xntlholder_init(h)      inith(&(h)->link)
+#define xntlist_init(q)         initq(q)
 #define xntlist_head(q)                         \
     ({ xnholder_t *_h = getheadq(q);            \
         !_h ? NULL : link2tlholder(_h);         \
@@ -71,7 +70,7 @@
 static inline void xntlist_insert(xnqueue_t *q, xntlholder_t *holder)
 {
     xnholder_t *p;
-    
+
     /* Insert the new timer at the proper place in the single
        queue managed when running in aperiodic mode. O(N) here,
        but users of the aperiodic mode need to pay a price for
@@ -82,7 +81,7 @@
             (holder->key == link2tlholder(p)->key &&
              holder->prio <= link2tlholder(p)->prio))
             break;
-        
+
     insertq(q,p->next,&holder->link);
 }
 
@@ -94,7 +93,7 @@
 #define xntimerh_date(h)       bheaph_key(h)
 #define xntimerh_prio(h)       bheaph_prio(h)
 #define xntimerh_init(h)       bheaph_init(h)
-typedef bheap_t xntimerq_t;
+typedef DECLARE_BHEAP_CONTAINER(xntimerq_t, CONFIG_XENO_OPT_TIMER_HEAP_CAPACITY);
 #define xntimerq_init(q)       bheap_init((q), CONFIG_XENO_OPT_TIMER_HEAP_CAPACITY)
 #define xntimerq_destroy(q)    bheap_destroy(q)
 #define xntimerq_head(q)       bheap_gethead(q)
@@ -108,7 +107,7 @@
 #define xntimerh_init(h)       xntlholder_init(h)
 typedef xnqueue_t xntimerq_t;
 #define xntimerq_init(q)       xntlist_init(q)
-#define xntimerq_destroy(q)    xntlist_destroy(q)
+#define xntimerq_destroy(q)    do { } while (0)
 #define xntimerq_head(q)       xntlist_head(q)
 #define xntimerq_insert(q,h)   xntlist_insert((q),(h))
 #define xntimerq_remove(q, h)  xntlist_remove((q),(h))
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 1146)
+++ ChangeLog	(working copy)
@@ -1,3 +1,10 @@
+2006-06-02  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* include/nucleus/{bheap.h,timer.h}, ksrc/nucleus/pod.c:
+	Combine bheap head with element buffer, fix consistency checks
+	and additionally make use of XENO_BUGON. Simplify pod init and
+	cleanup of timer structures.
+
 2006-05-23  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
 
 	* ksrc/arch/i386/nmi.c: Fix alignement for gcc-4.1.
@@ -14,7 +21,7 @@
 
 	* ksrc/arch/arm/patches: Upgrade to 2.6.1{4,5}-1.3-04.
 
-2006-05-19  Jan Kiszka  <jan.kiszka@domain.hid>
+2006-05-19  Jan Kiszka  <jan.kiszka@domain.hid>
 
 	* src/testsuite/latency/latency.c: Add pid to registered names
 	allowing multiple instances of latency to run. Add -c switch to

--1zjj+TOkT1--

