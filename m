Message-ID: <48F3BAA2.8010500@domain.hid>
Date: Mon, 13 Oct 2008 23:16:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F3B4D7.7070109@domain.hid> <48F3B967.5040807@domain.hid>
In-Reply-To: <48F3B967.5040807@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7BCDF15CE27BA78137C1BB8F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] xnpipe: what's up with xnpipe_setup?
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
--------------enig7BCDF15CE27BA78137C1BB8F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> xnpipe_setup and the callbacks it sets is dead code for in-tree Xenoma=
i
>> users. Going back to, well, fusion-0.6.9 (the oldest version we have i=
n
>> LXR), it used to be dead meat already at that time. Can we remove it?
>=20
> In case we can:

Sorry, a better one:

---
 include/nucleus/pipe.h |    5 -----
 ksrc/nucleus/pipe.c    |   47 ++++--------------------------------------=
-----
 2 files changed, 4 insertions(+), 48 deletions(-)

Index: b/include/nucleus/pipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/nucleus/pipe.h
+++ b/include/nucleus/pipe.h
@@ -76,8 +76,6 @@ static inline xnpipe_mh_t *link2mh(xnhol
 typedef int xnpipe_io_handler (int minor,
 			       struct xnpipe_mh *mh, int retval, void *cookie);
=20
-typedef int xnpipe_session_handler (int minor, void *cookie);
-
 typedef void *xnpipe_alloc_handler (int minor, size_t size, void *cookie=
);
=20
 typedef struct xnpipe_state {
@@ -118,9 +116,6 @@ void xnpipe_umount(void);
=20
 /* Entry points of the kernel interface. */
=20
-void xnpipe_setup(xnpipe_session_handler *open_handler,
-		  xnpipe_session_handler *close_handler);
-
 int xnpipe_connect(int minor,
 		   xnpipe_io_handler *output_handler,
 		   xnpipe_io_handler *input_handler,
Index: b/ksrc/nucleus/pipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/nucleus/pipe.c
+++ b/ksrc/nucleus/pipe.c
@@ -37,8 +37,6 @@
=20
 static int xnpipe_asyncsig =3D SIGIO;
=20
-static xnpipe_session_handler *xnpipe_open_handler, *xnpipe_close_handle=
r;
-
 xnpipe_state_t xnpipe_states[XNPIPE_NDEVS];
=20
 #define XNPIPE_BITMAP_SIZE	((XNPIPE_NDEVS + BITS_PER_LONG - 1) / BITS_PE=
R_LONG)
@@ -216,13 +214,6 @@ static inline void xnpipe_schedule_reque
    sections since we might be competing with the real-time threads for
    data access. */
=20
-void xnpipe_setup(xnpipe_session_handler *open_handler,
-		  xnpipe_session_handler *close_handler)
-{
-	xnpipe_open_handler =3D open_handler;
-	xnpipe_close_handler =3D close_handler;
-}
-
 int xnpipe_connect(int minor,
 		   xnpipe_io_handler *output_handler,
 		   xnpipe_io_handler *input_handler,
@@ -626,22 +617,6 @@ static int xnpipe_open(struct inode *ino
 		  XNPIPE_USER_ALL_WAIT | XNPIPE_USER_ALL_READY | XNPIPE_USER_SIGIO);
=20
 	if (!testbits(state->status, XNPIPE_KERN_CONN)) {
-		if (xnpipe_open_handler) {
-			xnlock_put_irqrestore(&nklock, s);
-
-			err =3D xnpipe_open_handler(xnminor_from_state(state),
-						  NULL);
-			if (err) {
-				xnpipe_cleanup_user_conn(state);
-				return err;
-			}
-
-			if (testbits(state->status, XNPIPE_KERN_CONN))
-				return 0;
-
-			xnlock_get_irqsave(&nklock, s);
-		}
-
 		if (testbits(file->f_flags, O_NONBLOCK)) {
 			xnpipe_cleanup_user_conn(state);
 			xnlock_put_irqrestore(&nklock, s);
@@ -655,16 +630,10 @@ static int xnpipe_open(struct inode *ino
 			xnlock_put_irqrestore(&nklock, s);
 			return -ERESTARTSYS;
 		}
-
-		xnlock_put_irqrestore(&nklock, s);
-	} else {
-		xnlock_put_irqrestore(&nklock, s);
-
-		if (xnpipe_open_handler)
-			err =3D xnpipe_open_handler(xnminor_from_state(state),
-						  state->cookie);
 	}
=20
+	xnlock_put_irqrestore(&nklock, s);
+
 	if (err)
 		xnpipe_cleanup_user_conn(state);
=20
@@ -685,22 +654,15 @@ static int xnpipe_release(struct inode *
 	xnpipe_dequeue_wait(state, XNPIPE_USER_WSYNC);
=20
 	if (testbits(state->status, XNPIPE_KERN_CONN)) {
-		int minor =3D xnminor_from_state(state);
-
 		/* If a Xenomai thread is waiting on this object, wake
 		   it up now. */
-
 		if (xnsynch_nsleepers(&state->synchbase) > 0) {
 			xnsynch_flush(&state->synchbase, XNRMID);
 			xnpod_schedule();
 		}
+	}
=20
-		xnlock_put_irqrestore(&nklock, s);
-
-		if (xnpipe_close_handler)
-			err =3D xnpipe_close_handler(minor, state->cookie);
-	} else
-		xnlock_put_irqrestore(&nklock, s);
+	xnlock_put_irqrestore(&nklock, s);
=20
 	if (state->asyncq) {	/* Clear the async queue */
 		xnlock_get_irqsave(&nklock, s);
@@ -1188,5 +1150,4 @@ EXPORT_SYMBOL(xnpipe_send);
 EXPORT_SYMBOL(xnpipe_mfixup);
 EXPORT_SYMBOL(xnpipe_recv);
 EXPORT_SYMBOL(xnpipe_inquire);
-EXPORT_SYMBOL(xnpipe_setup);
 EXPORT_SYMBOL(xnpipe_flush);


--------------enig7BCDF15CE27BA78137C1BB8F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjzuqIACgkQniDOoMHTA+mSwACeNKtPYCCeqJnfuOo/BDOdlO9Z
WoEAn3yKa21EXJDKjAB1U5OF5tHwReqh
=xe/X
-----END PGP SIGNATURE-----

--------------enig7BCDF15CE27BA78137C1BB8F--

