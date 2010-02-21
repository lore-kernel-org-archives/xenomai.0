Message-ID: <4B815780.2040407@domain.hid>
Date: Sun, 21 Feb 2010 16:55:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8347F28F7BBB8321E1ABB366"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [pull-request] x86: Fix merge regression in
	unmask_IO_APIC_irq_desc
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: lux-integ <lux-integ@domain.hid>, adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8347F28F7BBB8321E1ABB366
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The following changes since commit d78768171c2e1d8d047123e20f8c4ba9465dda=
10:
  Philippe Gerum (1):
        ipipe-2.6.32.7-x86-2.6-00

are available in the git repository at:

  git://git.kiszka.org/ipipe-2.6 queues/2.6.32-x86

Jan Kiszka (1):
      x86: Fix merge regression in unmask_IO_APIC_irq_desc

 arch/x86/kernel/apic/io_apic.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
=09
---------

x86: Fix merge regression in unmask_IO_APIC_irq_desc

Proper IRQ unlocking at I-pipe level got lost during forward port to
2.6.32. That broke at least edge-triggered Linux IRQs.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/kernel/apic/io_apic.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_api=
c.c
index c0235cf..d1674f6 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -639,6 +639,7 @@ static void unmask_IO_APIC_irq_desc(struct irq_desc *=
desc)
 	else
 #endif
 	__unmask_IO_APIC_irq(cfg);
+	ipipe_irq_unlock(desc->irq);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
=20
--=20
1.6.0.2


--------------enig8347F28F7BBB8321E1ABB366
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuBV4gACgkQitSsb3rl5xTNvwCgiOR0RZ8dnL4jhof5RtIqiCCk
A4gAniP7jYAY8tLEWTLkmQAxzk29VGpr
=cExN
-----END PGP SIGNATURE-----

--------------enig8347F28F7BBB8321E1ABB366--

