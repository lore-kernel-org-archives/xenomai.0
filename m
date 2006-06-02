Message-ID: <448085DE.5020803@domain.hid>
Date: Fri, 02 Jun 2006 20:39:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [patch] static buffer for timer-bheap
References: <447F72A0.8000000@domain.hid>	<17536.18621.302528.67077@domain.hid>	<4480515F.7050500@domain.hid>	<17536.21805.408809.703077@domain.hid>	<44806253.9020805@domain.hid>	<17536.26182.536525.725211@domain.hid>
	<44806E3C.7080103@domain.hid>
In-Reply-To: <44806E3C.7080103@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8F2C7763AA61866C2A4EBF05"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8F2C7763AA61866C2A4EBF05
Content-Type: multipart/mixed; boundary="------------010802080804020203050305"

This is a multi-part message in MIME format.
--------------010802080804020203050305
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>  > Gilles Chanteperdrix wrote:
>>  > > bheap_destroy allow
>>  > > setting the bheap_t structure to an invalid value which, in turn,=
 allow
>>  > > helping upper layers in catching invalid uses of the bheap after =
its
>>  > > destruction.
>>  >=20
>>  > Ok, we could make bheap_destroy pop up under XENO_OPT_DEBUG. We may=
 then
>>  > also add assertions to the bheap functions themselves to check for
>>  > invalid usage.
>>
>> The checkings are already there, if you do not remove
>> bheap_destroy. They are unconditionnal, because I find such checkings =
way
>> too important to be optimized out.
>=20
> Sorry, I might be blind, but how do bheap_gethead, bheap_insert, or
> bheap_delete detect that heap->last or heap->sz became 0 after
> bheap_destroy?
>=20
> Given that this is code to be inlined and heavily used, we should reall=
y
> take care for size and efficiency on production systems, even if it's
> about a few bytes here. But I also agree that verbose(!) checking
> (XENO_ASSERT/XENO_BUGON) is very useful during development.

Ok, I understood that consistency checks can come for zero price when
fixing a tiny bug in bheap_destroy. This is done in the attached
revision of my patch, and I kept bheap_destroy therefore.

I also added XENO_BUGON to bheap_gethead, bheap_insert, and bheap_delete
in case CONFIG_XENO_OPT_DEBUG_BHEAP is set (which is the case now for
CONFIG_XENO_OPT_DEBUG - it's a cheap test).

Be warned, this patch is only compile-tested, I'm in a hurry.

Jan

--------------010802080804020203050305
Content-Type: text/plain;
 name="bheap-init-v3.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="bheap-init-v3.patch"

Index: ksrc/nucleus/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/Kconfig	(revision 1144)
+++ ksrc/nucleus/Kconfig	(working copy)
@@ -145,6 +145,10 @@ config XENO_OPT_DEBUG_QUEUES
 	operations of the Xenomai core. It adds even more runtime
 	overhead then CONFIG_XENO_OPT_DEBUG, use with care.
=20
+config XENO_OPT_DEBUG_BHEAP
+	bool
+	default y if XENO_OPT_DEBUG
+
 config XENO_OPT_WATCHDOG
 	bool "Watchdog support"
 	default n
Index: ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/pod.c	(revision 1144)
+++ ksrc/nucleus/pod.c	(working copy)
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
@@ -585,15 +574,8 @@ void xnpod_shutdown(int xtype)
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
+    for (cpu =3D 0; cpu < xnarch_num_online_cpus(); cpu++)
         xntimerq_destroy(&nkpod->sched[cpu].timerqueue);
-    }
=20
     xnlock_put_irqrestore(&nklock, s);
=20
Index: ksrc/nucleus/Config.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/Config.in	(revision 1144)
+++ ksrc/nucleus/Config.in	(working copy)
@@ -32,6 +32,7 @@ if [ "$CONFIG_XENO_OPT_NUCLEUS" !=3D "n" ]
 	bool 'Debug support' CONFIG_XENO_OPT_DEBUG
 	if [ "$CONFIG_XENO_OPT_DEBUG" =3D "y" ]; then
 		bool 'Queue Debugging support' CONFIG_XENO_OPT_DEBUG_QUEUES
+		define_bool CONFIG_XENO_OPT_DEBUG_BHEAP y
 	fi
 	bool 'Watchdog support' CONFIG_XENO_OPT_WATCHDOG
=20
Index: include/nucleus/bheap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/bheap.h	(revision 1144)
+++ include/nucleus/bheap.h	(working copy)
@@ -21,6 +21,7 @@
 #define _XENO_NUCLEUS_BHEAP_H
=20
 #include <nucleus/compiler.h>
+#include <nucleus/assert.h>
=20
 /* Priority queue implementation, using a binary heap. */
=20
@@ -43,10 +44,28 @@ typedef struct bheaph {
 typedef struct bheap {
     unsigned sz;
     unsigned last;
-    bheaph_t **elems;
+    bheaph_t *elems[1]; /* only padding, indexing starts at 1 */
 } bheap_t;
=20
-static inline bheaph_t *bheap_gethead(bheap_t *heap)
+#define DECLARE_BHEAP_CONTAINER(name, sz) \
+    struct { \
+        bheap_t bheap; \
+        bheaph_t *elems[sz]; \
+    } name
+
+#ifdef CONFIG_XENO_OPT_DEBUG_BHEAP
+#define BHEAP_CHECK(heap)   XENO_BUGON(BHEAP, ((heap)->sz =3D=3D 0))
+#else /* !CONFIG_XENO_OPT_DEBUG_BHEAP */
+#define BHEAP_CHECK(heap)   do { } while (0)
+#endif /* CONFIG_XENO_OPT_DEBUG_BHEAP */
+
+#define bheap_gethead(heap) \
+({ \
+    BHEAP_CHECK(heap); \
+    __internal_bheap_gethead(heap); \
+})
+
+static inline bheaph_t *__internal_bheap_gethead(bheap_t *heap)
 {
     if (heap->last =3D=3D 1)
         return NULL;
@@ -68,26 +87,16 @@ static inline bheaph_t *bheaph_child(bhe
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
 }
=20
 static inline void bheap_destroy(bheap_t *heap)
-{   =20
-    xnarch_sysfree(heap->elems + 1, heap->sz * sizeof(void *));
-    heap->last =3D 0;
+{
     heap->sz =3D 0;
+    heap->last =3D 1;
 }
=20
 static inline void bheap_swap(bheap_t *heap, bheaph_t *h1, bheaph_t *h2)=

@@ -115,7 +124,7 @@ static inline void bheap_down(bheap_t *h
     for (;;) {
         left =3D bheaph_child(heap, holder, 0);
         right =3D bheaph_child(heap, holder, 1);
-       =20
+
         if (left && right)
             minchild =3D bheaph_lt(left, right) ? left : right;
         else
@@ -128,7 +137,13 @@ static inline void bheap_down(bheap_t *h
     }
 }
=20
-static inline int bheap_insert(bheap_t *heap, bheaph_t *holder)
+#define bheap_insert(heap, holder) \
+({ \
+    BHEAP_CHECK(heap); \
+    __internal_bheap_insert(heap, holder); \
+})
+
+static inline int __internal_bheap_insert(bheap_t *heap, bheaph_t *holde=
r)
 {
     if (heap->last =3D=3D heap->sz + 1)
         return EBUSY;
@@ -140,13 +155,16 @@ static inline int bheap_insert(bheap_t *
     return 0;
 }
=20
-static inline int bheap_delete(bheap_t *heap, bheaph_t *holder)
+#define bheap_delete(heap, holder) \
+do { \
+    BHEAP_CHECK(heap); \
+    __internal_bheap_delete(heap, holder); \
+} while (0)
+
+static inline void __internal_bheap_delete(bheap_t *heap, bheaph_t *hold=
er)
 {
     bheaph_t *lasth;
-   =20
-    if (heap->last =3D=3D 1)
-        return EINVAL;
-   =20
+
     --heap->last;
     if (heap->last > 1) {
         lasth =3D heap->elems[heap->last];
@@ -154,8 +172,6 @@ static inline int bheap_delete(bheap_t *
         bheaph_pos(lasth) =3D bheaph_pos(holder);
         bheap_down(heap, lasth);
     }
-  =20
-    return 0;
 }
=20
 static inline bheaph_t *bheap_get(bheap_t *heap)
Index: include/nucleus/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/timer.h	(revision 1144)
+++ include/nucleus/timer.h	(working copy)
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
@@ -94,12 +93,12 @@ typedef bheaph_t xntimerh_t;
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
+typedef DECLARE_BHEAP_CONTAINER(xntimerq_t, CONFIG_XENO_OPT_TIMER_HEAP_C=
APACITY);
+#define xntimerq_init(q)       bheap_init(&(q)->bheap, CONFIG_XENO_OPT_T=
IMER_HEAP_CAPACITY)
+#define xntimerq_destroy(q)    bheap_destroy(&(q)->bheap)
+#define xntimerq_head(q)       bheap_gethead(&(q)->bheap)
+#define xntimerq_insert(q, h)  bheap_insert(&(q)->bheap,(h))
+#define xntimerq_remove(q, h)  bheap_delete(&(q)->bheap,(h))
=20
 #else /* CONFIG_XENO_OPT_TIMER_LIST */
 typedef xntlholder_t xntimerh_t;
@@ -108,7 +107,7 @@ typedef xntlholder_t xntimerh_t;
 #define xntimerh_init(h)       xntlholder_init(h)
 typedef xnqueue_t xntimerq_t;
 #define xntimerq_init(q)       xntlist_init(q)
-#define xntimerq_destroy(q)    xntlist_destroy(q)
+#define xntimerq_destroy(q)    do { } while (0)
 #define xntimerq_head(q)       xntlist_head(q)
 #define xntimerq_insert(q,h)   xntlist_insert((q),(h))
 #define xntimerq_remove(q, h)  xntlist_remove((q),(h))
Index: ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ChangeLog	(revision 1144)
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
=20
 	* ksrc/arch/i386/nmi.c: Fix alignement for gcc-4.1.
@@ -14,7 +21,7 @@
=20
 	* ksrc/arch/arm/patches: Upgrade to 2.6.1{4,5}-1.3-04.
=20
-2006-05-19  Jan Kiszka  <jan.kiszka@domain.hid>
+2006-05-19  Jan Kiszka  <jan.kiszka@domain.hid>
=20
 	* src/testsuite/latency/latency.c: Add pid to registered names
 	allowing multiple instances of latency to run. Add -c switch to

--------------010802080804020203050305--

--------------enig8F2C7763AA61866C2A4EBF05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEgIXeniDOoMHTA+kRAlHAAJ9bH/IhKMjkYWwWIW0RC6GPluxX0gCggrix
V1yY1IRkId5JpahWci2R6V4=
=cbrr
-----END PGP SIGNATURE-----

--------------enig8F2C7763AA61866C2A4EBF05--

