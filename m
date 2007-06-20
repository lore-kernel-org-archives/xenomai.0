Message-ID: <4679A5D1.7030501@domain.hid>
Date: Thu, 21 Jun 2007 00:10:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <OF815057E3.6D5C9810-ONC12572FF.00287AFE-C12572FF.0028A289@domain.hid>
In-Reply-To: <OF815057E3.6D5C9810-ONC12572FF.00287AFE-C12572FF.0028A289@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig56503BA0EFB9AB98732D8E6B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] xeno-2.3.1 shared interrups BUG?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: apittaluga@domain.hid
Cc: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig56503BA0EFB9AB98732D8E6B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

apittaluga@domain.hid wrote:
> Hi,
> running a simple test application which spawns a periodic task writing =
on a
> serial interface
> the system hangs performing the rt_dev_close.
> The test program ran fine with xeno 2.2.6 with "Shared Interrupts" enab=
led,
> so as with
> xeno 2.3.1 with "Shared Interrupts" disabled. It fails with xeno 2.3.1 =
with
> "Shared Interrupts" enabled, so the problem seems to be in the shared
> interrupts handling area.
> kernel is 2.6.20 adeos patched
>=20
> Any suggestion?

OK, the commission came to the conclusion that we may have a solution:

Could you please test this patch

    https://mail.gna.org/public/xenomai-core/2007-06/msg00091.html

and report the result to us? Oh... wait... you are on 2.3.1. Then use the=

patch below. Applies against 2.3.x-SVN, but should work with the release
as well.

Thanks,
Jan


---
 ksrc/nucleus/intr.c |   68 ++++++++++++++++-----------------------------=
-------
 1 file changed, 21 insertions(+), 47 deletions(-)

Index: xenomai-2.3.x/ksrc/nucleus/intr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai-2.3.x.orig/ksrc/nucleus/intr.c
+++ xenomai-2.3.x/ksrc/nucleus/intr.c
@@ -145,39 +145,13 @@ typedef struct xnintr_shirq {
 	xnintr_t *handlers;
 	int unhandled;
 #ifdef CONFIG_SMP
-	atomic_counter_t active;
+	xnlock_t lock;
 #endif
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
@@ -201,7 +175,7 @@ static void xnintr_shirq_handler(unsigne
=20
 	++sched->inesting;
=20
-	xnintr_shirq_lock(shirq);
+	xnlock_get(&shirq->lock);
 	intr =3D shirq->handlers;
=20
 	while (intr) {
@@ -222,7 +196,7 @@ static void xnintr_shirq_handler(unsigne
 		intr =3D intr->next;
 	}
=20
-	xnintr_shirq_unlock(shirq);
+	xnlock_put(&shirq->lock);
=20
 	if (unlikely(s =3D=3D XN_ISR_NONE)) {
 		if (++shirq->unhandled =3D=3D XNINTR_MAX_UNHANDLED) {
@@ -272,7 +246,7 @@ static void xnintr_edge_shirq_handler(un
=20
 	++sched->inesting;
=20
-	xnintr_shirq_lock(shirq);
+	xnlock_get(&shirq->lock);
 	intr =3D shirq->handlers;
=20
 	while (intr !=3D end) {
@@ -303,7 +277,7 @@ static void xnintr_edge_shirq_handler(un
 			intr =3D shirq->handlers;
 	}
=20
-	xnintr_shirq_unlock(shirq);
+	xnlock_put(&shirq->lock);
=20
 	if (counter > MAX_EDGEIRQ_COUNTER)
 		xnlogerr
@@ -386,9 +360,12 @@ static inline int xnintr_irq_attach(xnin
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
@@ -409,8 +386,10 @@ static inline int xnintr_irq_detach(xnin
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
@@ -429,12 +408,8 @@ static inline int xnintr_irq_detach(xnin
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
@@ -450,7 +425,6 @@ static inline int xnintr_irq_detach(xnin
 	return xnarch_release_irq(intr->irq);
 }
=20
-void xnintr_synchronize(xnintr_t *intr) {}
 int xnintr_mount(void) { return 0; }
=20
 #endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
@@ -626,6 +600,9 @@ int xnintr_destroy(xnintr_t *intr)
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
@@ -654,7 +631,7 @@ int xnintr_attach(xnintr_t *intr, void *
=20
 	if (!err)
 		xnintr_stat_counter_inc();
-=09
+
 	xnlock_put_irqrestore(&intrlock, s);
=20
 	return err;
@@ -678,6 +655,9 @@ int xnintr_attach(xnintr_t *intr, void *
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
@@ -703,12 +683,6 @@ int xnintr_detach(xnintr_t *intr)
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


--------------enig56503BA0EFB9AB98732D8E6B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGeaXRniDOoMHTA+kRArZiAJ9fl9+KckikJjQzeXtr4iyyxPt3vQCeK/8q
X4gITLDWx193EeQie+ZxkAI=
=KUYd
-----END PGP SIGNATURE-----

--------------enig56503BA0EFB9AB98732D8E6B--

