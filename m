Message-ID: <45803953.7020608@domain.hid>
Date: Wed, 13 Dec 2006 18:33:07 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD3DCBA6211C167856CA810B0"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] cleanup unused EXPORTs
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
--------------enigD3DCBA6211C167856CA810B0
Content-Type: multipart/mixed; boundary="------------010209020602040506040208"

This is a multi-part message in MIME format.
--------------010209020602040506040208
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

As I'm unable to find any modular users of the symbols below, I suggest
to remove the EXPORTs and make __ipipe_pipelock static.

Jan

--------------010209020602040506040208
Content-Type: text/plain;
 name="cleanup-exports.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="cleanup-exports.patch"

---
 include/linux/ipipe.h |    2 --
 kernel/ipipe/core.c   |    7 +------
 2 files changed, 1 insertion(+), 8 deletions(-)

Index: linux-2.6.19-ipipe/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/include/linux/ipipe.h
+++ linux-2.6.19-ipipe/include/linux/ipipe.h
@@ -241,8 +241,6 @@ extern unsigned long __ipipe_virtual_irq
=20
 extern struct list_head __ipipe_pipeline;
=20
-extern ipipe_spinlock_t __ipipe_pipelock;
-
 extern int __ipipe_event_monitors[];
=20
 /* Private interface */
Index: linux-2.6.19-ipipe/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/kernel/ipipe/core.c
+++ linux-2.6.19-ipipe/kernel/ipipe/core.c
@@ -47,7 +47,7 @@ struct ipipe_domain ipipe_root =3D
 DEFINE_PER_CPU(struct ipipe_domain *, ipipe_percpu_domain) =3D
 	{ &ipipe_root };
=20
-ipipe_spinlock_t __ipipe_pipelock =3D IPIPE_SPIN_LOCK_UNLOCKED;
+static IPIPE_DEFINE_SPINLOCK(__ipipe_pipelock);
=20
 LIST_HEAD(__ipipe_pipeline);
=20
@@ -1396,12 +1396,7 @@ EXPORT_SYMBOL(__ipipe_restore_root);
 EXPORT_SYMBOL(__ipipe_test_and_stall_root);
 EXPORT_SYMBOL(__ipipe_test_root);
 EXPORT_SYMBOL(__ipipe_dispatch_event);
-EXPORT_SYMBOL(__ipipe_dispatch_wired);
-EXPORT_SYMBOL(__ipipe_sync_stage);
 EXPORT_SYMBOL(__ipipe_pipeline);
-EXPORT_SYMBOL(__ipipe_pipelock);
-EXPORT_SYMBOL(__ipipe_virtual_irq_map);
-
 EXPORT_SYMBOL(ipipe_register_domain);
 EXPORT_SYMBOL(ipipe_unregister_domain);
 EXPORT_SYMBOL(ipipe_free_virq);

--------------010209020602040506040208--

--------------enigD3DCBA6211C167856CA810B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgDlTniDOoMHTA+kRAradAJ4nH6Bc0sLxhqFfqmbUJoK0vno7JACeKrmM
SZ0azCgvtSoXEGe7q156g80=
=HZjq
-----END PGP SIGNATURE-----

--------------enigD3DCBA6211C167856CA810B0--

