Message-ID: <4630F20D.4000903@domain.hid>
Date: Thu, 26 Apr 2007 20:40:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0FBA8670B8FA51A58E5006A4"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 2/7] Fix initial Linux IRQ state for x86_64
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
--------------enig0FBA8670B8FA51A58E5006A4
Content-Type: multipart/mixed;
 boundary="------------060901030301000808030008"

This is a multi-part message in MIME format.
--------------060901030301000808030008
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe, this is the solution for the BUG I posted privately. Not sure
if we need the first hunk, but the second is mandatory for SMP.

Jan

--------------060901030301000808030008
Content-Type: text/plain;
 name="fix-x86_64-init-irq-enable.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-x86_64-init-irq-enable.patch"

---
 arch/x86_64/kernel/apic.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.20-x64/arch/x86_64/kernel/apic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20-x64.orig/arch/x86_64/kernel/apic.c
+++ linux-2.6.20-x64/arch/x86_64/kernel/apic.c
@@ -875,6 +875,7 @@ void __init setup_boot_APIC_clock (void)
 	setup_APIC_timer(calibration_result);
=20
 	local_irq_enable_hw();
+	local_irq_enable();
 }
=20
 void __cpuinit setup_secondary_APIC_clock(void)
@@ -882,6 +883,7 @@ void __cpuinit setup_secondary_APIC_cloc
 	local_irq_disable_hw(); /* FIXME: Do we need this? --RR */
 	setup_APIC_timer(calibration_result);
 	local_irq_enable_hw();
+	local_irq_enable();
 }
=20
 void disable_APIC_timer(void)

--------------060901030301000808030008--

--------------enig0FBA8670B8FA51A58E5006A4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMPINniDOoMHTA+kRAhySAJ9YGUNe4ldxq42PQu2V8boK9AUowgCePU2S
AVX4u5A829gVZs4F0XkSJ3E=
=RC7Y
-----END PGP SIGNATURE-----

--------------enig0FBA8670B8FA51A58E5006A4--

