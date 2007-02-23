Message-ID: <45DEFCD1.1050505@domain.hid>
Date: Fri, 23 Feb 2007 15:40:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB7673CFB32A3C1058D692DCA"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] include IRQ and domain states in panic dump
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB7673CFB32A3C1058D692DCA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Index: linux-2.6.20.1/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.1.orig/kernel/ipipe/tracer.c
+++ linux-2.6.20.1/kernel/ipipe/tracer.c
@@ -622,6 +622,18 @@ void ipipe_trace_panic_dump(void)
 		struct ipipe_trace_point *point =3D &panic_path->point[pos];
 		long time;
 		char buf[16];
+		int i;
+
+		printk(" %c", (point->flags & IPIPE_TFLG_HWIRQ_OFF) ?
+			       '|' : ' ');
+
+		for (i =3D IPIPE_TFLG_DOMSTATE_BITS; i >=3D 0; i--)
+			printk("%c",
+				(IPIPE_TFLG_CURRENT_DOMAIN(point) =3D=3D i) ?
+				(IPIPE_TFLG_DOMAIN_STALLED(point, i) ?
+					'#' : '+') :
+				(IPIPE_TFLG_DOMAIN_STALLED(point, i) ?
+					'*' : ' '));
=20
 		if (!point->eip)
 			printk("-<invalid>-\n");=20



--------------enigB7673CFB32A3C1058D692DCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3vzRniDOoMHTA+kRAjHsAKCDi7RXvOQZ4+SZAuYWQBfFZGb2XgCeMMiH
DpM29YE2dXVzalzKXNFgFVg=
=HbwE
-----END PGP SIGNATURE-----

--------------enigB7673CFB32A3C1058D692DCA--

