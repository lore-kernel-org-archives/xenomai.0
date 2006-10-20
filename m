Message-ID: <4538A613.80606@domain.hid>
Date: Fri, 20 Oct 2006 12:33:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4471AC2DC0B017AB46607F4C"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] x86: revert IRQs replay order
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4471AC2DC0B017AB46607F4C
Content-Type: multipart/mixed; boundary="------------030402060707060607060904"

This is a multi-part message in MIME format.
--------------030402060707060607060904
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

While digging into a latency issue with multiple IRQs pending (patch
will likely follow soon), I noticed that the replay order on x86 is the
inverse of the hardware order. Instead of iterating from lowest IRQ
number to highest, ipipe currently starts with the highest one. The
attached patch fixes this.

Jan

--------------030402060707060607060904
Content-Type: text/plain;
 name="fix-x86-irq-replay-order.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-x86-irq-replay-order.patch"

Index: linux-2.6.17.13/include/asm-i386/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.13.orig/include/asm-i386/ipipe.h
+++ linux-2.6.17.13/include/asm-i386/ipipe.h
@@ -242,8 +242,7 @@ extern int __ipipe_tick_irq;
=20
 static inline unsigned long __ipipe_ffnz(unsigned long ul)
 {
-      __asm__("bsrl %1, %0":"=3Dr"(ul)
-      :	"r"(ul));
+	__asm__("bsfl %1, %0":"=3Dr"(ul):"r"(ul));
 	return ul;
 }
=20

--------------030402060707060607060904--

--------------enig4471AC2DC0B017AB46607F4C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFOKYTniDOoMHTA+kRAiwEAJ9O/v6ye183zilupBwMXkUWOAtHfgCdFrxa
/1lVIVEOT8ZlSr3U5VOAwkQ=
=+RR3
-----END PGP SIGNATURE-----

--------------enig4471AC2DC0B017AB46607F4C--

