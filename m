Message-ID: <4958E32C.1080503@domain.hid>
Date: Mon, 29 Dec 2008 15:48:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig25E5F1C450CF1A0EDD936DC1"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] Disable affinity proc entry without
	CONFIG_SMP
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig25E5F1C450CF1A0EDD936DC1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Let's drop the redundant /proc/xenomai/affinity entry in case the target
is UP-only (saves some byte text and data).

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/nucleus/module.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/ksrc/nucleus/module.c b/ksrc/nucleus/module.c
index 060a348..8c69855 100644
--- a/ksrc/nucleus/module.c
+++ b/ksrc/nucleus/module.c
@@ -972,6 +972,7 @@ static int heap_read_proc(char *page,
 	return len;
 }
=20
+#ifdef CONFIG_SMP
 static int affinity_read_proc(char *page,
 			      char **start,
 			      off_t off, int count, int *eof, void *data)
@@ -1024,6 +1025,7 @@ static int affinity_write_proc(struct file *file,
=20
 	return count;
 }
+#endif /* CONFIG_SMP */
=20
 static struct proc_dir_entry *add_proc_fops(const char *name,
 					    struct file_operations *fops,
@@ -1085,8 +1087,10 @@ void xnpod_init_proc(void)
 	rthal_add_proc_leaf("heap", &heap_read_proc, NULL, NULL,
 			    rthal_proc_root);
=20
+#ifdef CONFIG_SMP
 	rthal_add_proc_leaf("affinity", &affinity_read_proc,
 			    &affinity_write_proc, NULL, rthal_proc_root);
+#endif /* CONFIG_SMP */
=20
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	iface_proc_root =3D
@@ -1106,7 +1110,9 @@ void xnpod_delete_proc(void)
=20
 	remove_proc_entry("interfaces", rthal_proc_root);
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
+#ifdef CONFIG_SMP
 	remove_proc_entry("affinity", rthal_proc_root);
+#endif /* CONFIG_SMP */
 	remove_proc_entry("heap", rthal_proc_root);
 	remove_proc_entry("irq", rthal_proc_root);
 	remove_proc_entry("timer", rthal_proc_root);


--------------enig25E5F1C450CF1A0EDD936DC1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAklY4ywACgkQniDOoMHTA+mM9ACcD/pkj++FKtd2bn5LaHxQo3S1
wqsAnj0Rbj56EKC3JPRDDMhhrxZOUuNs
=7k4L
-----END PGP SIGNATURE-----

--------------enig25E5F1C450CF1A0EDD936DC1--

