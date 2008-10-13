Message-ID: <48F3B231.6000105@domain.hid>
Date: Mon, 13 Oct 2008 22:40:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig571D84222ADDAF116DD09314"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] xnpipe: fix state tracking of Linux side
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
--------------enig571D84222ADDAF116DD09314
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The state tracking of Linux tasks queue on xnpipe events was fairly
broken. An easy way to corrupt some xnpipe_state_t object was to kill a
Linux task blocked on opening a /dev/rtpX device (this left the state
object queued in xnpipe_sleep, and hell broke loose on next queuing).

Another problem that popped up after reworking xnpipe queuing was a
stalled XNPIPE_USER_CONN after receiving a signal in xnpipe_open.

The following patch addresses both issues, appears to run fine so far
(at least the test case no longer triggers), and also cleans up some
redundant nklock acquisitions/releases. Nevertheless, I may miss some
corner case that might have triggered the original design. So please
check carefully.

Jan

---
 ksrc/nucleus/pipe.c |   64 +++++++++++++++++++--------------------------=
-------
 1 file changed, 24 insertions(+), 40 deletions(-)

Index: b/ksrc/nucleus/pipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/nucleus/pipe.c
+++ b/ksrc/nucleus/pipe.c
@@ -88,38 +88,39 @@ static inline void xnpipe_minor_free(int
=20
 static inline void xnpipe_enqueue_wait(xnpipe_state_t *state, int mask)
 {
-	spl_t s;
-
-	xnlock_get_irqsave(&nklock, s);
-
 	if (state->wcount++ =3D=3D 0)
 		appendq(&xnpipe_sleepq, &state->slink);
=20
 	__setbits(state->status, mask);
+}
=20
-	xnlock_put_irqrestore(&nklock, s);
+static inline void xnpipe_dequeue_wait(xnpipe_state_t *state, int mask)
+{
+	if (testbits(state->status, mask)) {
+		if (--state->wcount =3D=3D 0)
+			removeq(&xnpipe_sleepq, &state->slink);
+		__clrbits(state->status, mask);
+	}
 }
=20
 /* Must be entered with nklock held. */
-#define xnpipe_wait(__state, __mask, __s, __cond)	\
-({							\
-	wait_queue_head_t *__waitq;			\
-	DEFINE_WAIT(__wait);				\
-	int __sigpending;				\
-							\
-	if ((__mask) & XNPIPE_USER_WREAD)		\
-		__waitq =3D &(__state)->readq;		\
-	else						\
-		__waitq =3D &(__state)->syncq;		\
-							\
-	xnpipe_enqueue_wait(__state, __mask);		\
-	xnlock_put_irqrestore(&nklock, __s);		\
+#define xnpipe_wait(__state, __mask, __s, __cond)			\
+({									\
+	wait_queue_head_t *__waitq;					\
+	DEFINE_WAIT(__wait);						\
+	int __sigpending;						\
+									\
+	if ((__mask) & XNPIPE_USER_WREAD)				\
+		__waitq =3D &(__state)->readq;				\
+	else								\
+		__waitq =3D &(__state)->syncq;				\
+									\
+	xnpipe_enqueue_wait(__state, __mask);				\
+	xnlock_put_irqrestore(&nklock, __s);				\
 									\
 	prepare_to_wait_exclusive(__waitq, &__wait, TASK_INTERRUPTIBLE);\
 									\
-	if (__cond)							\
-		xnpipe_dequeue_wait(__state, __mask);			\
-	else								\
+	if (!__cond)							\
 		schedule();						\
 									\
 	finish_wait(__waitq, &__wait);					\
@@ -127,25 +128,11 @@ static inline void xnpipe_enqueue_wait(x
 									\
 	/* Restore the interrupt state initially set by the caller. */	\
 	xnlock_get_irqsave(&nklock, __s);				\
+	xnpipe_dequeue_wait(__state, __mask);				\
 									\
 	__sigpending;							\
 })
=20
-static inline void xnpipe_dequeue_wait(xnpipe_state_t *state, int mask)
-{
-	spl_t s;
-
-	xnlock_get_irqsave(&nklock, s);
-
-	if (testbits(state->status, mask)) {
-		if (--state->wcount =3D=3D 0)
-			removeq(&xnpipe_sleepq, &state->slink);
-		__clrbits(state->status, mask);
-	}
-
-	xnlock_put_irqrestore(&nklock, s);
-}
-
 static void xnpipe_wakeup_proc(void *cookie)
 {
 	xnholder_t *holder, *nholder;
@@ -168,7 +155,6 @@ static void xnpipe_wakeup_proc(void *coo
 			   before calling wake_up_interruptible(). */
 			if ((rbits & XNPIPE_USER_WREAD_READY) !=3D 0) {
 				if (waitqueue_active(&state->readq)) {
-					xnpipe_dequeue_wait(state, XNPIPE_USER_WREAD);
 					xnlock_put_irqrestore(&nklock, s);
 					wake_up_interruptible(&state->readq);
 					rbits &=3D ~XNPIPE_USER_WREAD_READY;
@@ -177,7 +163,6 @@ static void xnpipe_wakeup_proc(void *coo
 			}
 			if ((rbits & XNPIPE_USER_WSYNC_READY) !=3D 0) {
 				if (waitqueue_active(&state->syncq)) {
-					xnpipe_dequeue_wait(state, XNPIPE_USER_WSYNC);
 					xnlock_put_irqrestore(&nklock, s);
 					wake_up_interruptible(&state->syncq);
 					rbits &=3D ~XNPIPE_USER_WSYNC_READY;
@@ -666,8 +651,7 @@ static int xnpipe_open(struct inode *ino
 		sigpending =3D xnpipe_wait(state, XNPIPE_USER_WREAD, s,
 					 testbits(state->status, XNPIPE_KERN_CONN));
 		if (sigpending) {
-			if (!testbits(state->status, XNPIPE_KERN_CONN))
-				xnpipe_cleanup_user_conn(state);
+			xnpipe_cleanup_user_conn(state);
 			xnlock_put_irqrestore(&nklock, s);
 			return -ERESTARTSYS;
 		}


--------------enig571D84222ADDAF116DD09314
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjzsjcACgkQniDOoMHTA+n5eACeLqGdzcrk/t5jHHDX0EwU/TSF
hpcAnigasWViL5aiU9b9LPNJzXvY1cqh
=6C1r
-----END PGP SIGNATURE-----

--------------enig571D84222ADDAF116DD09314--

