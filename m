Message-ID: <494D6EA9.1020703@domain.hid>
Date: Sat, 20 Dec 2008 23:16:09 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig44C0AACE73186AA54AFAC406"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] Export __ipipe_set_irq_pending
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
--------------enig44C0AACE73186AA54AFAC406
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Required when using __ipipe_propagate_irq or
__ipipe_schedule_irq_{head,root} as module.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

---
 kernel/ipipe/core.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1701,6 +1701,7 @@ EXPORT_SYMBOL(ipipe_get_ptd);
 EXPORT_SYMBOL(ipipe_set_irq_affinity);
 EXPORT_SYMBOL(ipipe_send_ipi);
 EXPORT_SYMBOL(__ipipe_pend_irq);
+EXPORT_SYMBOL(__ipipe_set_irq_pending);
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 EXPORT_SYMBOL(ipipe_request_tickdev);
 EXPORT_SYMBOL(ipipe_release_tickdev);


--------------enig44C0AACE73186AA54AFAC406
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAklNbq0ACgkQniDOoMHTA+lVyQCbBgwmaH5icAAJpuIqh/CXGNBy
wGsAnjwSX0KhZ/r44/93Z5zJge86fAU4
=4DzK
-----END PGP SIGNATURE-----

--------------enig44C0AACE73186AA54AFAC406--

