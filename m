Message-ID: <48FB17B9.2070901@domain.hid>
Date: Sun, 19 Oct 2008 13:19:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF627A0154F827A8B5382686E"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] Improve ipipe's oops detection
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
--------------enigF627A0154F827A8B5382686E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Due to my extended context checks, oopses will first trigger such errors
now before the actual reason is dumped. Patch below ensures that ongoing
oopses disable the context check, and it also pushes the panic-freeze to
a slightly bit earlier point.

Jan

---
 kernel/panic.c       |    2 ++
 lib/bust_spinlocks.c |    1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: b/kernel/panic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -267,6 +267,8 @@ int oops_may_print(void)
  */
 void oops_enter(void)
 {
+	ipipe_trace_panic_freeze();
+	ipipe_disable_context_check(ipipe_processor_id());
 	debug_locks_off(); /* can't trust the integrity of the kernel anymore *=
/
 	do_oops_enter_exit();
 }
Index: b/lib/bust_spinlocks.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/lib/bust_spinlocks.c
+++ b/lib/bust_spinlocks.c
@@ -18,7 +18,6 @@
 void __attribute__((weak)) bust_spinlocks(int yes)
 {
 	if (yes) {
-  		ipipe_trace_panic_freeze();
 		++oops_in_progress;
 	} else {
 #ifdef CONFIG_VT


--------------enigF627A0154F827A8B5382686E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkj7F7kACgkQniDOoMHTA+kxuACePygx/OkI5dbKEMWeqWo1Noa+
wEMAn3Um4Np44WUB4H/lihcl4rdrEie5
=oPlk
-----END PGP SIGNATURE-----

--------------enigF627A0154F827A8B5382686E--

