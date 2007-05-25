Message-ID: <46567B36.4000603@domain.hid>
Date: Fri, 25 May 2007 07:59:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig08A4F5C4E1132640898982B3"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] i386: forgotten hunk of domain violation patch
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
--------------enig08A4F5C4E1132640898982B3
Content-Type: multipart/mixed;
 boundary="------------080609060200070505000007"

This is a multi-part message in MIME format.
--------------080609060200070505000007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

x86_64 has it correctly, i386 is yet lacking it. Please apply for the
next release.

Jan

--------------080609060200070505000007
Content-Type: text/x-patch;
 name="fix-context-checks.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-context-checks.patch"

Index: linux-2.6.20-ipipe/arch/i386/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20-ipipe.orig/arch/i386/kernel/ipipe.c
+++ linux-2.6.20-ipipe/arch/i386/kernel/ipipe.c
@@ -680,8 +680,13 @@ fastcall int __ipipe_handle_exception(st
 	/* Track the hw interrupt state before calling the Linux
 	 * exception handler, replicating it into the virtual mask. */
=20
-	if (irqs_disabled_hw())
-		local_irq_disable();
+	if (irqs_disabled_hw()) {
+		/* Do not trigger the alarm in ipipe_check_context() by using
+		 * plain local_irq_disable(). */
+		__ipipe_stall_root();
+		trace_hardirqs_off();
+		barrier();
+	}
=20
 #ifdef CONFIG_KGDB
 	/* catch exception KGDB is interested in over non-root domains */

--------------080609060200070505000007--

--------------enig08A4F5C4E1132640898982B3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGVns6niDOoMHTA+kRAldKAJ0QMp1oZ6i9p2VFOE3YbyY2RAmnlQCfQGfi
84TrJz8pnpucRehNGUFIlU4=
=/c+d
-----END PGP SIGNATURE-----

--------------enig08A4F5C4E1132640898982B3--

