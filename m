Message-ID: <47225A16.6080204@domain.hid>
Date: Fri, 26 Oct 2007 23:20:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1AD30D26388697A0F5D6DB04"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] x86_64-janitorial: exclude unused function
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
--------------enig1AD30D26388697A0F5D6DB04
Content-Type: multipart/mixed;
 boundary="------------030308010200050204010503"

This is a multi-part message in MIME format.
--------------030308010200050204010503
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable


--------------030308010200050204010503
Content-Type: text/x-patch;
 name="x86_64-exclude-unused-function.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="x86_64-exclude-unused-function.patch"

---
 arch/x86_64/kernel/io_apic.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.23.1_64-xeno/arch/x86_64/kernel/io_apic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1_64-xeno.orig/arch/x86_64/kernel/io_apic.c
+++ linux-2.6.23.1_64-xeno/arch/x86_64/kernel/io_apic.c
@@ -152,6 +152,7 @@ static inline void io_apic_modify(unsign
 	writel(value, &io_apic->data);
 }
=20
+#ifndef CONFIG_IPIPE
 static int io_apic_level_ack_pending(unsigned int irq)
 {
 	struct irq_pin_list *entry;
@@ -177,6 +178,7 @@ static int io_apic_level_ack_pending(uns
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 	return pending;
 }
+#endif /* !CONFIG_IPIPE */
=20
 /*
  * Synchronize the IO-APIC and the CPU by doing

--------------030308010200050204010503--

--------------enig1AD30D26388697A0F5D6DB04
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHIloWniDOoMHTA+kRAuKmAJwLqC+REpKmCU+zrR3OG7i+7yx+WgCfQYEe
bXnqG1LtPhFseaWNdywRT7s=
=Yuax
-----END PGP SIGNATURE-----

--------------enig1AD30D26388697A0F5D6DB04--

