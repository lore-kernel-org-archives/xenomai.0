Message-ID: <44A3B799.8030608@domain.hid>
Date: Thu, 29 Jun 2006 13:20:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 6/6] Introduce IRQ latency benchmark
References: <20060626172116.019532000@domain.hid>
	<20060626172120.322015000@domain.hid> <44A2DB06.8050000@domain.hid>
In-Reply-To: <44A2DB06.8050000@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEC1785A62A46BA3E61BC5943"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEC1785A62A46BA3E61BC5943
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:

> Here comes an update of the irqbench patch.
>  =20
And this add-on fixes a classic copy&paste issue.

Jan


---
 ksrc/drivers/testing/irqbench.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: xenomai/ksrc/drivers/testing/irqbench.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/drivers/testing/irqbench.c
+++ xenomai/ksrc/drivers/testing/irqbench.c
@@ -444,7 +444,7 @@ static struct rtdm_device device =3D {
     proc_name:          device.device_name,
 };
=20
-int __init __timerbench_init(void)
+int __init __irqbench_init(void)
 {
     int ret;
=20
@@ -460,11 +460,11 @@ int __init __timerbench_init(void)
 }
=20
=20
-void __exit __timerbench_exit(void)
+void __exit __irqbench_exit(void)
 {
     rtdm_dev_unregister(&device, 1000);
 }
=20
=20
-module_init(__timerbench_init);
-module_exit(__timerbench_exit);
+module_init(__irqbench_init);
+module_exit(__irqbench_exit);




--------------enigEC1785A62A46BA3E61BC5943
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEo7eZniDOoMHTA+kRAjFlAJ4w5brAhzZ21XSlQxz8KqkUELCKnACeKcTp
CD06q7suQOyml0pAPzbPOaE=
=QnXP
-----END PGP SIGNATURE-----

--------------enigEC1785A62A46BA3E61BC5943--

