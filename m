Message-ID: <44FD7463.7010601@domain.hid>
Date: Tue, 05 Sep 2006 14:58:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig97DCDE51C08F7A9EB7537A00"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Move rtdm_irq_enable close to rtdm_irq_request
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig97DCDE51C08F7A9EB7537A00
Content-Type: multipart/mixed; boundary="------------090203020000060100070401"

This is a multi-part message in MIME format.
--------------090203020000060100070401
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,

in the process of preparing to merge rtdm_irq_enable into
rtdm_irq_request I would like to check if the attached patch is ok, thus
we could finally drop rtdm_irq_enable once the API is refactored. Please
check carefully when the first IRQs may happen and what the handler
expects to be initialised! SJA1000 /should/ be ok as it works with
shared IRQs, but MSCAN does not (why, BTW?) and /may/ stumble.

Jan

--------------090203020000060100070401
Content-Type: text/plain;
 name="reorder-rtdm_irq_enable.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="reorder-rtdm_irq_enable.patch"

Index: ksrc/drivers/can/mscan/rtcan_mscan.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/can/mscan/rtcan_mscan.c	(revision 1559)
+++ ksrc/drivers/can/mscan/rtcan_mscan.c	(working copy)
@@ -801,7 +801,8 @@ int __init rtcan_mscan_init_one(int idx)
 	printk("ERROR! rtdm_irq_request for IRQ %d failed\n", irq);
 	goto out_dev_free;
     }
-   =20
+    rtdm_irq_enable(&dev->irq_handle);
+
     mscan_chip_config(regs);
    =20
=20
@@ -814,8 +815,6 @@ int __init rtcan_mscan_init_one(int idx)
=20
     rtcan_mscan_create_proc(dev);
=20
-    rtdm_irq_enable(&dev->irq_handle);
-   =20
     /* Remember initialized devices */
     rtcan_mscan_devs[idx] =3D dev;
=20
Index: ksrc/drivers/can/sja1000/rtcan_sja1000.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/can/sja1000/rtcan_sja1000.c	(revision 1559)
+++ ksrc/drivers/can/sja1000/rtcan_sja1000.c	(working copy)
@@ -747,6 +747,7 @@ int rtcan_sja1000_register(struct rtcan_
 	printk("ERROR! IRQ %d busy or invalid (code=3D%d)!\n", chip->irq_num, r=
et);
 	return ret;
     }
+    rtdm_irq_enable(&dev->irq_handle);
=20
     sja1000_chip_config(dev);
=20
@@ -759,8 +760,6 @@ int rtcan_sja1000_register(struct rtcan_
=20
     rtcan_sja_create_proc(dev);
=20
-    rtdm_irq_enable(&dev->irq_handle);
-   =20
     return 0;
=20
  out_irq_free:

--------------090203020000060100070401--

--------------enig97DCDE51C08F7A9EB7537A00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE/XRjniDOoMHTA+kRArRbAJ9whwZaI9NSz95pt8/HiI7Rp3/PuwCfcxxv
bUi61e4X+5k6aFfn6epWTlo=
=2/ad
-----END PGP SIGNATURE-----

--------------enig97DCDE51C08F7A9EB7537A00--

