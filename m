Message-ID: <46782305.4080501@domain.hid>
Date: Tue, 19 Jun 2007 20:40:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig512D0D8297EE515E4558FAF7"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH] shirq locking rework
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig512D0D8297EE515E4558FAF7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

I had a look at the shared IRQ thing /wrt to my idea of switching
between two list revisions. It turned out to be as nice as I expected
when marvelling at the new xnintr_edge_shirq_handler() -- but it became
horribly complex for setup/cleanup :(. So forget it, also the ring idea
which took quite some part in the complexity increase.

Looking at xnintr_shirq_lock again: We have an atomic op, we have a
memory barrier -- what do we actually gain by not using a usual xnlock
here? I mean one that is per-IRQ, embedded in xnintr_shirq_t?

Well, I hate nested locks when it comes to real-time, but in this case I
really found no simpler approach. There is the risk of deadlocks via

IRQ:		xnintr_shirq::lock -> handler -> nklock vs.
Application:	nklock -> xnintr_attach/detach -> xnintr_shirq::lock,

but we have no such case in-tree, nor should anyone try to do so
elsewhere I assume (restriction is documented now). Note that this code
is only compile-tested, and my brain still suffers from serious knots
due to the first approach, thus no guarantee that I didn't messed
things up.

Comments?

Jan


---
 ksrc/nucleus/intr.c |   70 +++++++++++++++------------------------------=
-------
 1 file changed, 21 insertions(+), 49 deletions(-)

Index: xenomai/ksrc/nucleus/intr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/intr.c
+++ xenomai/ksrc/nucleus/intr.c
@@ -169,40 +169,12 @@ typedef struct xnintr_shirq {
=20
 	xnintr_t *handlers;
 	int unhandled;
-#ifdef CONFIG_SMP
-	atomic_counter_t active;
-#endif
+	DECLARE_XNLOCK(lock);
=20
 } xnintr_shirq_t;
=20
 static xnintr_shirq_t xnshirqs[RTHAL_NR_IRQS];
=20
-static inline void xnintr_shirq_lock(xnintr_shirq_t *shirq)
-{
-#ifdef CONFIG_SMP
-	xnarch_atomic_inc(&shirq->active);
-	xnarch_memory_barrier();
-#endif
-}
-
-static inline void xnintr_shirq_unlock(xnintr_shirq_t *shirq)
-{
-#ifdef CONFIG_SMP
-	xnarch_memory_barrier();
-	xnarch_atomic_dec(&shirq->active);
-#endif
-}
-
-void xnintr_synchronize(xnintr_t *intr)
-{
-#ifdef CONFIG_SMP
-	xnintr_shirq_t *shirq =3D &xnshirqs[intr->irq];
-
-	while (xnarch_atomic_get(&shirq->active))
-		cpu_relax();
-#endif
-}
-
 #if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL)
 /*
  * Low-level interrupt handler dispatching the user-defined ISRs for
@@ -226,7 +198,7 @@ static void xnintr_shirq_handler(unsigne
=20
 	++sched->inesting;
=20
-	xnintr_shirq_lock(shirq);
+	xnlock_get(&shirq->lock);
 	intr =3D shirq->handlers;
=20
 	while (intr) {
@@ -247,7 +219,7 @@ static void xnintr_shirq_handler(unsigne
 		intr =3D intr->next;
 	}
=20
-	xnintr_shirq_unlock(shirq);
+	xnlock_put(&shirq->lock);
=20
 	if (unlikely(s =3D=3D XN_ISR_NONE)) {
 		if (++shirq->unhandled =3D=3D XNINTR_MAX_UNHANDLED) {
@@ -297,7 +269,7 @@ static void xnintr_edge_shirq_handler(un
=20
 	++sched->inesting;
=20
-	xnintr_shirq_lock(shirq);
+	xnlock_get(&shirq->lock);
 	intr =3D shirq->handlers;
=20
 	while (intr !=3D end) {
@@ -328,7 +300,7 @@ static void xnintr_edge_shirq_handler(un
 			intr =3D shirq->handlers;
 	}
=20
-	xnintr_shirq_unlock(shirq);
+	xnlock_put(&shirq->lock);
=20
 	if (counter > MAX_EDGEIRQ_COUNTER)
 		xnlogerr
@@ -411,9 +383,12 @@ static inline int xnintr_irq_attach(xnin
=20
 	__setbits(intr->flags, XN_ISR_ATTACHED);
=20
-	/* Add a given interrupt object. */
 	intr->next =3D NULL;
+
+	/* Add a given interrupt object. */
+	xnlock_get(&shirq->lock);
 	*p =3D intr;
+	xnlock_put(&shirq->lock);
=20
 	return 0;
 }
@@ -434,8 +409,10 @@ static inline int xnintr_irq_detach(xnin
=20
 	while ((e =3D *p) !=3D NULL) {
 		if (e =3D=3D intr) {
-			/* Remove a given interrupt object from the list. */
+			/* Remove the given interrupt object from the list. */
+			xnlock_get(&shirq->lock);
 			*p =3D e->next;
+			xnlock_put(&shirq->lock);
=20
 			/* Release the IRQ line if this was the last user */
 			if (shirq->handlers =3D=3D NULL)
@@ -454,12 +431,8 @@ static inline int xnintr_irq_detach(xnin
 int xnintr_mount(void)
 {
 	int i;
-	for (i =3D 0; i < RTHAL_NR_IRQS; ++i) {
-		xnshirqs[i].handlers =3D NULL;
-#ifdef CONFIG_SMP
-		xnarch_atomic_set(&xnshirqs[i].active, 0);
-#endif
-	}
+	for (i =3D 0; i < RTHAL_NR_IRQS; ++i)
+		xnlock_init(&xnshirqs[i].lock);
 	return 0;
 }
=20
@@ -475,7 +448,6 @@ static inline int xnintr_irq_detach(xnin
 	return xnarch_release_irq(intr->irq);
 }
=20
-void xnintr_synchronize(xnintr_t *intr) {}
 int xnintr_mount(void) { return 0; }
=20
 #endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
@@ -651,6 +623,9 @@ int xnintr_destroy(xnintr_t *intr)
  * a low-level error occurred while attaching the interrupt. -EBUSY is
  * specifically returned if the interrupt object was already attached.
  *
+ * @note The caller <b>must not</b> hold nklock when invoking this servi=
ce,
+ * this would cause deadlocks.
+ *
  * Environments:
  *
  * This service can be called from:
@@ -682,7 +657,7 @@ int xnintr_attach(xnintr_t *intr, void *
=20
 	if (!err)
 		xnintr_stat_counter_inc();
-=09
+
 	xnlock_put_irqrestore(&intrlock, s);
=20
 	return err;
@@ -706,6 +681,9 @@ int xnintr_attach(xnintr_t *intr, void *
  * a non-attached interrupt object leads to a null-effect and returns
  * 0.
  *
+ * @note The caller <b>must not</b> hold nklock when invoking this servi=
ce,
+ * this would cause deadlocks.
+ *
  * Environments:
  *
  * This service can be called from:
@@ -731,12 +709,6 @@ int xnintr_detach(xnintr_t *intr)
=20
 	xnlock_put_irqrestore(&intrlock, s);
=20
-	/* The idea here is to keep a detached interrupt object valid as long
-	   as the corresponding irq handler is running. This is one of the
-	   requirements to iterate over the xnintr_shirq_t::handlers list in
-	   xnintr_irq_handler() in a lockless way. */
-	xnintr_synchronize(intr);
-
 	return err;
 }
=20


--------------enig512D0D8297EE515E4558FAF7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGeCMFniDOoMHTA+kRAkMxAJ9r7go80qOssqwpvrKmrVBMphXtJACfYfTr
MMityvNN0J7SGItx71gzXJQ=
=1CaG
-----END PGP SIGNATURE-----

--------------enig512D0D8297EE515E4558FAF7--

