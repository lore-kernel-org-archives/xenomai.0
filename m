Message-ID: <4722469B.8000000@domain.hid>
Date: Fri, 26 Oct 2007 21:57:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA52B22246E164467921F888E"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] fix copy_from_user evaluation
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA52B22246E164467921F888E
Content-Type: multipart/mixed;
 boundary="------------040809060502070805040602"

This is a multi-part message in MIME format.
--------------040809060502070805040602
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

/me produced a nop here.

Jan

--------------040809060502070805040602
Content-Type: text/x-patch;
 name="tracer-fix-copy_from_user-evaluation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="tracer-fix-copy_from_user-evaluation.patch"

---
 kernel/ipipe/tracer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.23.1-xeno/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno.orig/kernel/ipipe/tracer.c
+++ linux-2.6.23.1-xeno/kernel/ipipe/tracer.c
@@ -1229,7 +1229,7 @@ static int __ipipe_wr_trigger(struct fil
=20
 	if (count > sizeof(buf) - 1)
 		count =3D sizeof(buf) - 1;
-	if (copy_from_user(buf, buffer, count) < 0)
+	if (copy_from_user(buf, buffer, count))
 		return -EFAULT;
 	buf[count] =3D 0;
 	if (buf[count-1] =3D=3D '\n')

--------------040809060502070805040602--

--------------enigA52B22246E164467921F888E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHIkacniDOoMHTA+kRAui4AJ9XuhYVdJFhZNIeIt5upxaY6FNF0QCeKsZ2
af9WUBW7H526YI+6TR8BZS4=
=ChFO
-----END PGP SIGNATURE-----

--------------enigA52B22246E164467921F888E--

