Message-ID: <447F72A0.8000000@domain.hid>
Date: Fri, 02 Jun 2006 01:05:04 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD7B475E726A70D5261C1111D"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [patch] static buffer for timer-bheap
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD7B475E726A70D5261C1111D
Content-Type: multipart/mixed; boundary="------------000504030606000205080503"

This is a multi-part message in MIME format.
--------------000504030606000205080503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

this patch moves the heap for scalable timer queues into the xnpod_t
structure instead of allocating it dynamically. This simplifies the pod
initialisation and cleanup, which was not fully robust in this regard
anyway. If a pod is now considered too large (but we are discussion
kbytes here), allocating its buffer via xnarch_sysalloc would be an optio=
n.

In case this patch is acceptable, I would suggest merging it before 2.2
due to the contained (minor) fix.

Jan

--------------000504030606000205080503
Content-Type: text/x-patch;
 name="bheap-init.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="bheap-init.patch"

Index: ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/pod.c	(Revision 1144)
+++ ksrc/nucleus/pod.c	(Arbeitskopie)
@@ -433,22 +433,11 @@ int xnpod_init(xnpod_t *pod, int minpri,
 #ifdef CONFIG_XENO_OPT_TIMING_PERIODIC
         unsigned n;
=20
-        for (n =3D 0; n < XNTIMER_WHEELSIZE; n++) {
-            err =3D -xntlist_init(&pod->sched[cpu].timerwheel[n]);
-
-            if (err) {
-                xnheap_destroy(&kheap, &xnpod_flush_heap, NULL);
-                goto fail;
-            }
-        }
+        for (n =3D 0; n < XNTIMER_WHEELSIZE; n++)
+            xntlist_init(&pod->sched[cpu].timerwheel[n]);
 #endif /* CONFIG_XENO_OPT_TIMING_PERIODIC */
=20
-        err =3D -xntimerq_init(&pod->sched[cpu].timerqueue);
-
-        if (err) {
-            xnheap_destroy(&kheap, &xnpod_flush_heap, NULL);
-            goto fail;
-        }
+        xntimerq_init(&pod->sched[cpu].timerqueue);
     }
=20
     for (cpu =3D 0; cpu < nr_cpus; ++cpu) {
@@ -547,7 +536,6 @@ void xnpod_shutdown(int xtype)
 {
     xnholder_t *holder, *nholder;
     xnthread_t *thread;
-    unsigned cpu;
     spl_t s;
=20
     xnlock_get_irqsave(&nklock, s);
@@ -585,16 +573,6 @@ void xnpod_shutdown(int xtype)
=20
     __setbits(nkpod->status, XNPIDLE);
=20
-    for (cpu =3D 0; cpu < xnarch_num_online_cpus(); cpu++) {
-#ifdef CONFIG_XENO_OPT_TIMING_PERIODIC
-        unsigned n;
-
-        for (n =3D 0; n < XNTIMER_WHEELSIZE; n++)
-            xntlist_destroy(&nkpod->sched[cpu].timerwheel[n]);
-#endif /* CONFIG_XENO_OPT_TIMING_PERIODIC */
-        xntimerq_destroy(&nkpod->sched[cpu].timerqueue);
-    }
-
     xnlock_put_irqrestore(&nklock, s);
=20
 #ifdef CONFIG_XENO_OPT_REGISTRY
Index: include/nucleus/bheap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/bheap.h	(Revision 1144)
+++ include/nucleus/bheap.h	(Arbeitskopie)
@@ -43,9 +43,15 @@ typedef struct bheaph {
 typedef struct bheap {
     unsigned sz;
     unsigned last;
-    bheaph_t **elems;
+    bheaph_t *elems[1]; /* only padding, indexing starts at 1 */
 } bheap_t;
=20
+#define DECLARE_BHEAP_CONTAINER(name, sz) \
+    struct { \
+        bheap_t bheap; \
+        bheaph_t elems[sz]; \
+    } name
+
 static inline bheaph_t *bheap_gethead(bheap_t *heap)
 {
     if (heap->last =3D=3D 1)
@@ -68,26 +74,10 @@ static inline bheaph_t *bheaph_child(bhe
     return likely(pos < heap->last) ? heap->elems[pos] : NULL;
 }
=20
-static inline int bheap_init(bheap_t *heap, unsigned sz)
+static inline void bheap_init(bheap_t *heap, unsigned sz)
 {
     heap->sz =3D sz;
     heap->last =3D 1;
-    heap->elems =3D (bheaph_t **) xnarch_sysalloc(sz * sizeof(void *));
-
-    if (!heap->elems)
-        return ENOMEM;
-
-    /* start indexing at 1. */
-    heap->elems -=3D 1;
-
-    return 0;
-}
-
-static inline void bheap_destroy(bheap_t *heap)
-{   =20
-    xnarch_sysfree(heap->elems + 1, heap->sz * sizeof(void *));
-    heap->last =3D 0;
-    heap->sz =3D 0;
 }
=20
 static inline void bheap_swap(bheap_t *heap, bheaph_t *h1, bheaph_t *h2)=

@@ -115,7 +105,7 @@ static inline void bheap_down(bheap_t *h
     for (;;) {
         left =3D bheaph_child(heap, holder, 0);
         right =3D bheaph_child(heap, holder, 1);
-       =20
+
         if (left && right)
             minchild =3D bheaph_lt(left, right) ? left : right;
         else
@@ -143,10 +133,10 @@ static inline int bheap_insert(bheap_t *
 static inline int bheap_delete(bheap_t *heap, bheaph_t *holder)
 {
     bheaph_t *lasth;
-   =20
+
     if (heap->last =3D=3D 1)
         return EINVAL;
-   =20
+
     --heap->last;
     if (heap->last > 1) {
         lasth =3D heap->elems[heap->last];
@@ -154,7 +144,7 @@ static inline int bheap_delete(bheap_t *
         bheaph_pos(lasth) =3D bheaph_pos(holder);
         bheap_down(heap, lasth);
     }
-  =20
+
     return 0;
 }
=20
Index: include/nucleus/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/timer.h	(Revision 1144)
+++ include/nucleus/timer.h	(Arbeitskopie)
@@ -58,11 +58,10 @@ typedef struct {
     ((xntlholder_t *)(((char *)laddr) - offsetof(xntlholder_t, link)))
=20
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
     ({ xnholder_t *_h =3D getheadq(q);            \
         !_h ? NULL : link2tlholder(_h);         \
@@ -71,7 +70,7 @@ typedef struct {
 static inline void xntlist_insert(xnqueue_t *q, xntlholder_t *holder)
 {
     xnholder_t *p;
-   =20
+
     /* Insert the new timer at the proper place in the single
        queue managed when running in aperiodic mode. O(N) here,
        but users of the aperiodic mode need to pay a price for
@@ -82,7 +81,7 @@ static inline void xntlist_insert(xnqueu
             (holder->key =3D=3D link2tlholder(p)->key &&
              holder->prio <=3D link2tlholder(p)->prio))
             break;
-       =20
+
     insertq(q,p->next,&holder->link);
 }
=20
@@ -94,12 +93,14 @@ typedef bheaph_t xntimerh_t;
 #define xntimerh_date(h)       bheaph_key(h)
 #define xntimerh_prio(h)       bheaph_prio(h)
 #define xntimerh_init(h)       bheaph_init(h)
-typedef bheap_t xntimerq_t;
-#define xntimerq_init(q)       bheap_init((q), CONFIG_XENO_OPT_TIMER_HEA=
P_CAPACITY)
-#define xntimerq_destroy(q)    bheap_destroy(q)
-#define xntimerq_head(q)       bheap_gethead(q)
-#define xntimerq_insert(q, h)  bheap_insert((q),(h))
-#define xntimerq_remove(q, h)  bheap_delete((q),(h))
+typedef struct {
+    bheap_t bheap;
+    bheaph_t __buffer[CONFIG_XENO_OPT_TIMER_HEAP_CAPACITY];
+} xntimerq_t;
+#define xntimerq_init(q)       bheap_init(&(q)->bheap, CONFIG_XENO_OPT_T=
IMER_HEAP_CAPACITY)
+#define xntimerq_head(q)       bheap_gethead(&(q)->bheap)
+#define xntimerq_insert(q, h)  bheap_insert(&(q)->bheap,(h))
+#define xntimerq_remove(q, h)  bheap_delete(&(q)->bheap,(h))
=20
 #else /* CONFIG_XENO_OPT_TIMER_LIST */
 typedef xntlholder_t xntimerh_t;
Index: ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ChangeLog	(Revision 1144)
+++ ChangeLog	(Arbeitskopie)
@@ -1,3 +1,9 @@
+2006-06-01  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* include/nucleus/{bheap.h,timer.h}, ksrc/nucleus/pod.c:
+	Move timer heap into xnpod_t structure, simplify pod init and
+	cleanup.
+
 2006-05-23  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
=20
 	* ksrc/arch/i386/nmi.c: Fix alignement for gcc-4.1.
@@ -14,7 +20,7 @@
=20
 	* ksrc/arch/arm/patches: Upgrade to 2.6.1{4,5}-1.3-04.
=20
-2006-05-19  Jan Kiszka  <jan.kiszka@domain.hid>
+2006-05-19  Jan Kiszka  <jan.kiszka@domain.hid>
=20
 	* src/testsuite/latency/latency.c: Add pid to registered names
 	allowing multiple instances of latency to run. Add -c switch to

--------------000504030606000205080503--

--------------enigD7B475E726A70D5261C1111D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEf3KhniDOoMHTA+kRAnhJAJ9L2eumMkP8ZFUUu52siNGlE5BdAACePkiQ
fNYZNNiBLEyrgukHddM0IrM=
=Dyi5
-----END PGP SIGNATURE-----

--------------enigD7B475E726A70D5261C1111D--

