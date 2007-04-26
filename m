Message-ID: <4630F226.3020900@domain.hid>
Date: Thu, 26 Apr 2007 20:40:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF1E60E2FF361576172E2198D"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [JANITOR][PATCH 4/7] Cleanups in ipipe/core.c
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
--------------enigF1E60E2FF361576172E2198D
Content-Type: multipart/mixed;
 boundary="------------070703060007080902080001"

This is a multi-part message in MIME format.
--------------070703060007080902080001
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I-pipe is no longer a module, this we can remove related information.
Moreover, I didn't find a reason why __ipipe_dispatch_event should be
exported.

Jan

--------------070703060007080902080001
Content-Type: text/plain;
 name="cleanup-core.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="cleanup-core.patch"

---
 kernel/ipipe/core.c |    4 ----
 1 file changed, 4 deletions(-)

Index: linux-2.6.20/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/kernel/ipipe/core.c
+++ linux-2.6.20/kernel/ipipe/core.c
@@ -34,9 +34,6 @@
 #include <linux/seq_file.h>
 #endif	/* CONFIG_PROC_FS */
=20
-MODULE_DESCRIPTION("I-pipe");
-MODULE_LICENSE("GPL");
-
 static int __ipipe_ptd_key_count;
=20
 static unsigned long __ipipe_ptd_key_map;
@@ -1402,7 +1399,6 @@ EXPORT_SYMBOL(__ipipe_stall_root);
 EXPORT_SYMBOL(__ipipe_restore_root);
 EXPORT_SYMBOL(__ipipe_test_and_stall_root);
 EXPORT_SYMBOL(__ipipe_test_root);
-EXPORT_SYMBOL(__ipipe_dispatch_event);
 EXPORT_SYMBOL(__ipipe_pipeline);
 EXPORT_SYMBOL(ipipe_register_domain);
 EXPORT_SYMBOL(ipipe_unregister_domain);

--------------070703060007080902080001--

--------------enigF1E60E2FF361576172E2198D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMPInniDOoMHTA+kRAuIfAJ44evoggJ+NMWCZ1kmWYoQvx9/kAACbBFEC
xkchyCujTdkvEsiq5FEs/s8=
=7duQ
-----END PGP SIGNATURE-----

--------------enigF1E60E2FF361576172E2198D--

