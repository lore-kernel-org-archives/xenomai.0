Message-ID: <4630F21B.8050803@domain.hid>
Date: Thu, 26 Apr 2007 20:40:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig90EAA0E3DBE07A5E88BB7FD1"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [JANITOR][PATCH 3/7] Fix whitespaces in tracer
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig90EAA0E3DBE07A5E88BB7FD1
Content-Type: multipart/mixed;
 boundary="------------020601050306060307080208"

This is a multi-part message in MIME format.
--------------020601050306060307080208
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe, I bet you mailer played some role here again, so I'm better
sending attachments ;). Anyway, this also gives the chance to do it even
more cleanly.

Jan

--------------020601050306060307080208
Content-Type: text/plain;
 name="fix-whitespace.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-whitespace.patch"

---
 kernel/ipipe/tracer.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

Index: linux-2.6.20-x64/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20-x64.orig/kernel/ipipe/tracer.c
+++ linux-2.6.20-x64/kernel/ipipe/tracer.c
@@ -624,18 +624,18 @@ void ipipe_trace_panic_dump(void)
 		struct ipipe_trace_point *point =3D &panic_path->point[pos];
 		long time;
 		char buf[16];
-	       int i;
+		int i;
=20
-	       printk(" %c", (point->flags & IPIPE_TFLG_HWIRQ_OFF) ?
-			      '|' : ' ');
+		printk(" %c",
+		       (point->flags & IPIPE_TFLG_HWIRQ_OFF) ? '|' : ' ');
=20
-	       for (i =3D IPIPE_TFLG_DOMSTATE_BITS; i >=3D 0; i--)
-		       printk("%c",
-			      (IPIPE_TFLG_CURRENT_DOMAIN(point) =3D=3D i) ?
-			      (IPIPE_TFLG_DOMAIN_STALLED(point, i) ?
-				       '#' : '+') :
-			       (IPIPE_TFLG_DOMAIN_STALLED(point, i) ?
-				       '*' : ' '));
+		for (i =3D IPIPE_TFLG_DOMSTATE_BITS; i >=3D 0; i--)
+			printk("%c",
+			       (IPIPE_TFLG_CURRENT_DOMAIN(point) =3D=3D i) ?
+				(IPIPE_TFLG_DOMAIN_STALLED(point, i) ?
+					'#' : '+') :
+				(IPIPE_TFLG_DOMAIN_STALLED(point, i) ?
+					'*' : ' '));
=20
 		if (!point->eip)
 			printk("-<invalid>-\n");

--------------020601050306060307080208--

--------------enig90EAA0E3DBE07A5E88BB7FD1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMPIbniDOoMHTA+kRAmImAJ9NecQOwblJYSXKc0avr87aQylXdACfcba0
O1lRMx94LYwKc5CMumCWV8k=
=PpHR
-----END PGP SIGNATURE-----

--------------enig90EAA0E3DBE07A5E88BB7FD1--

