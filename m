Message-ID: <4732C3C0.1090704@domain.hid>
Date: Thu, 08 Nov 2007 09:07:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB47BFAC21081E00299517F42"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] janitorial: use dump_stack instead of
	show_stack
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
--------------enigB47BFAC21081E00299517F42
Content-Type: multipart/mixed;
 boundary="------------050308080800010702010600"

This is a multi-part message in MIME format.
--------------050308080800010702010600
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


--------------050308080800010702010600
Content-Type: text/x-patch;
 name="use-dump_stack.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="use-dump_stack.patch"

---
 kernel/ipipe/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.23-ipipe/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-ipipe.orig/kernel/ipipe/core.c
+++ linux-2.6.23-ipipe/kernel/ipipe/core.c
@@ -1575,7 +1575,7 @@ void ipipe_check_context(struct ipipe_do
 	       KERN_ERR "        into a service reserved for domain '%s' and "
 			"below.\n",
 	       ipipe_current_domain->name, border_ipd->name);
-	show_stack(NULL, NULL);
+	dump_stack();
 	ipipe_trace_panic_dump();
 }
=20

--------------050308080800010702010600--

--------------enigB47BFAC21081E00299517F42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHMsPFniDOoMHTA+kRAq3cAJ4yQAFNtlLI/0rJnElZLE5XMuiL4QCffS90
Utkg25WeuHe9e/P0aPYoUrw=
=ZJtq
-----END PGP SIGNATURE-----

--------------enigB47BFAC21081E00299517F42--

