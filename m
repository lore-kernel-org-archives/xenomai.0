Message-ID: <48FB16DE.903@domain.hid>
Date: Sun, 19 Oct 2008 13:15:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA240CF506F8144542AA29D94"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] Fix IPIPE-disabled build
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
--------------enigA240CF506F8144542AA29D94
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I messed up the disabled build, please merge this fix.

Jan

---
 include/linux/ipipe.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -611,8 +611,8 @@ void ipipe_kgdb_set_irq_handler(int irq,
 #define ipipe_processor_id()		smp_processor_id()
 #define ipipe_safe_current()		current
=20
-#define ipipe_nmi_enter()		do { } while ()
-#define ipipe_nmi_exit()		do { } while ()
+#define ipipe_nmi_enter()		do { } while (0)
+#define ipipe_nmi_exit()		do { } while (0)
=20
 #define local_irq_disable_head()	local_irq_disable()
=20


--------------enigA240CF506F8144542AA29D94
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkj7Ft4ACgkQniDOoMHTA+n8kwCggPE63buJSIVZujVhnBIlxcl2
2PAAnjEfGOQV1gi53nIctn9YflKg7apL
=CRci
-----END PGP SIGNATURE-----

--------------enigA240CF506F8144542AA29D94--

