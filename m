Message-ID: <4696A8CC.6060505@domain.hid>
Date: Fri, 13 Jul 2007 00:18:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6454787AD465616D4BA91C42"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 3/3] Report IPIs by name
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6454787AD465616D4BA91C42
Content-Type: multipart/mixed;
 boundary="------------020801020704000608030602"

This is a multi-part message in MIME format.
--------------020801020704000608030602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Trivial beautification of /proc/xenomai/irq: Starring at the output of
some SMP box, I wondered what those two unnamed IRQs are for...

--------------020801020704000608030602
Content-Type: text/x-patch;
 name="name-ipis-in-proc-output.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="name-ipis-in-proc-output.patch"

---
 ksrc/nucleus/intr.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: xenomai/ksrc/nucleus/intr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/intr.c
+++ xenomai/ksrc/nucleus/intr.c
@@ -860,6 +860,14 @@ int xnintr_irq_proc(unsigned int irq, ch
 	} else if (irq =3D=3D XNARCH_TIMER_IRQ) {
 		p +=3D sprintf(p, "         [timer]");
 		return p - str;
+#ifdef CONFIG_SMP
+	} else if (irq =3D=3D RTHAL_SERVICE_IPI0) {
+		p +=3D sprintf(p, "         [IPI]");
+		return p - str;
+	} else if (irq =3D=3D RTHAL_CRITICAL_IPI) {
+		p +=3D sprintf(p, "         [critical sync]");
+		return p - str;
+#endif /* CONFIG_SMP */
 	}
=20
 	xnlock_get_irqsave(&intrlock, s);

--------------020801020704000608030602--

--------------enig6454787AD465616D4BA91C42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGlqjNniDOoMHTA+kRAoifAJ0TYN8iye8q0g/C9JOyP+DoDJGeNwCdGPpb
E+4urcGkynpKVQX9w9DJiYo=
=IYPE
-----END PGP SIGNATURE-----

--------------enig6454787AD465616D4BA91C42--

