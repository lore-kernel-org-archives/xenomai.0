Message-ID: <4656E8E9.5060403@domain.hid>
Date: Fri, 25 May 2007 15:47:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig25107A6DED9885A2950A2CF4"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 1/2] Fix logic in __ipipe_get_task_info
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
--------------enig25107A6DED9885A2950A2CF4
Content-Type: multipart/mixed;
 boundary="------------040007010406090901020309"

This is a multi-part message in MIME format.
--------------040007010406090901020309
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

That was obviously wrong, causing double acquisitions.

Jan

--------------040007010406090901020309
Content-Type: text/plain;
 name="fix-__ipipe_get_task_info.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-__ipipe_get_task_info.patch"

---
 kernel/ipipe/tracer.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: linux-2.6.20/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/kernel/ipipe/tracer.c
+++ linux-2.6.20/kernel/ipipe/tracer.c
@@ -572,9 +572,10 @@ __ipipe_get_task_info(char *task_info, s
 	int i;
 	int locked =3D 1;
=20
-	if (trylock && !read_trylock(&tasklist_lock))
-		locked =3D 0;
-	else
+	if (trylock) {
+		if (!read_trylock(&tasklist_lock))
+			locked =3D 0;
+	} else
 		read_lock(&tasklist_lock);
=20
 	if (locked)

--------------040007010406090901020309--

--------------enig25107A6DED9885A2950A2CF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGVujpniDOoMHTA+kRAmCOAJ41GY7oqDlcsxLxpGj5JajxJ7ksQwCghG9r
q+K5vvqhPYwkqu+tx22sV9s=
=2cwC
-----END PGP SIGNATURE-----

--------------enig25107A6DED9885A2950A2CF4--

