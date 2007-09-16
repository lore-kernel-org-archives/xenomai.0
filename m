Message-ID: <46ECF430.9000402@domain.hid>
Date: Sun, 16 Sep 2007 11:15:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD3EC19EF47BA00A4C2928F3E"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] i386: remove another useless hunk
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
--------------enigD3EC19EF47BA00A4C2928F3E
Content-Type: multipart/mixed;
 boundary="------------080703020006040102030001"

This is a multi-part message in MIME format.
--------------080703020006040102030001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

With the introduction of

--- a/arch/i386/boot/compressed/Makefile
+++ b/arch/i386/boot/compressed/Makefile
@@ -9,6 +9,7 @@
 EXTRA_AFLAGS   :=3D -traditional

 LDFLAGS_vmlinux :=3D -T
+CFLAGS :=3D $(subst -pg,,$(CFLAGS))
 CFLAGS_misc.o +=3D -fPIC
 hostprogs-y    :=3D relocs

quite some time ago the dummy mcount function in compressed/misc.c
became redundant. Let's remove this dead code.

Jan

--------------080703020006040102030001
Content-Type: text/x-patch;
 name="cleanup-tracer-i386.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="cleanup-tracer-i386.patch"

---
 arch/i386/boot/compressed/misc.c |    6 ------
 1 file changed, 6 deletions(-)

Index: linux-2.6.22-ipipe/arch/i386/boot/compressed/misc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-ipipe.orig/arch/i386/boot/compressed/misc.c
+++ linux-2.6.22-ipipe/arch/i386/boot/compressed/misc.c
@@ -23,12 +23,6 @@
  * This means that it is not safe to place pointers in static structures=
=2E
  */
=20
-#ifdef CONFIG_IPIPE_TRACE_MCOUNT
-void __attribute__ ((no_instrument_function)) mcount(void)
-{
-}
-#endif
-
 /*
  * Getting to provable safe in place decompression is hard.
  * Worst case behaviours need to be analized.

--------------080703020006040102030001--

--------------enigD3EC19EF47BA00A4C2928F3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFG7PQ1niDOoMHTA+kRAu1pAJ0dixMtisgZasIn5zhb3nunTNJvOQCeMvk6
1B89AszJaPla8dUvyoIHBhs=
=Se9h
-----END PGP SIGNATURE-----

--------------enigD3EC19EF47BA00A4C2928F3E--

