Message-ID: <4516C957.60605@domain.hid>
Date: Sun, 24 Sep 2006 20:07:19 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3E022825B3160D11F04848FB"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] remove ipipe_root_domain indirection
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3E022825B3160D11F04848FB
Content-Type: multipart/mixed; boundary="------------090500060002070701060804"

This is a multi-part message in MIME format.
--------------090500060002070701060804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This simple patch removes an unneeded indirection by mapping
ipipe_root_domain to &ipipe_root. Saves more than 7k kernel size with my
setup here when CONFIG_PREEMPT is enabled, and I bet it requires a few
cycles less as well.

Jan

--------------090500060002070701060804
Content-Type: text/x-patch;
 name="remove-ipipe_root_domain.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="remove-ipipe_root_domain.patch"

---
 include/linux/ipipe.h   |    6 +++++-
 include/linux/preempt.h |    5 +++--
 kernel/ipipe/core.c     |    6 ++----
 3 files changed, 10 insertions(+), 7 deletions(-)

Index: linux-2.6.17.13/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.13.orig/include/linux/ipipe.h
+++ linux-2.6.17.13/include/linux/ipipe.h
@@ -313,7 +313,11 @@ do {						\
 	local_irq_restore_hw(flags);		\
 } while (0)
=20
-extern struct ipipe_domain *ipipe_percpu_domain[], *ipipe_root_domain;
+extern struct ipipe_domain *ipipe_percpu_domain[];
+
+extern struct ipipe_domain ipipe_root;
+
+#define ipipe_root_domain (&ipipe_root)
=20
 extern unsigned __ipipe_printk_virq;
=20
Index: linux-2.6.17.13/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.13.orig/kernel/ipipe/core.c
+++ linux-2.6.17.13/kernel/ipipe/core.c
@@ -29,12 +29,10 @@
 #include <linux/proc_fs.h>
 #endif	/* CONFIG_PROC_FS */
=20
-static struct ipipe_domain ipipe_root =3D
+struct ipipe_domain ipipe_root =3D
 	{ .cpudata =3D {[0 ... IPIPE_NR_CPUS-1] =3D
 		{ .status =3D (1<<IPIPE_STALL_FLAG) } } };
=20
-struct ipipe_domain *ipipe_root_domain =3D &ipipe_root;
-
 struct ipipe_domain *ipipe_percpu_domain[IPIPE_NR_CPUS] =3D
 	{[0 ... IPIPE_NR_CPUS - 1] =3D &ipipe_root };
=20
@@ -1038,7 +1036,7 @@ EXPORT_SYMBOL(ipipe_control_irq);
 EXPORT_SYMBOL(ipipe_suspend_domain);
 EXPORT_SYMBOL(ipipe_alloc_virq);
 EXPORT_SYMBOL(ipipe_percpu_domain);
-EXPORT_SYMBOL(ipipe_root_domain);
+EXPORT_SYMBOL(ipipe_root);
 EXPORT_SYMBOL(ipipe_stall_pipeline_from);
 EXPORT_SYMBOL(ipipe_test_and_stall_pipeline_from);
 EXPORT_SYMBOL(ipipe_unstall_pipeline_from);
Index: linux-2.6.17.13/include/linux/preempt.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.13.orig/include/linux/preempt.h
+++ linux-2.6.17.13/include/linux/preempt.h
@@ -29,8 +29,9 @@ asmlinkage void preempt_schedule(void);
=20
 #ifdef CONFIG_IPIPE
 #include <asm/ipipe.h>
-extern struct ipipe_domain *ipipe_percpu_domain[], *ipipe_root_domain;
-#define ipipe_preempt_guard()	(ipipe_percpu_domain[ipipe_processor_id()]=
 =3D=3D ipipe_root_domain)
+extern struct ipipe_domain *ipipe_percpu_domain[];
+extern struct ipipe_domain ipipe_root;
+#define ipipe_preempt_guard()	(ipipe_percpu_domain[ipipe_processor_id()]=
 =3D=3D &ipipe_root)
 #else /* !CONFIG_IPIPE */
 #define ipipe_preempt_guard()	1
 #endif /* CONFIG_IPIPE */

--------------090500060002070701060804--

--------------enig3E022825B3160D11F04848FB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFFslXniDOoMHTA+kRAq9SAJ9ohL5h+53VOG0btxoTaevbk5nFngCdEXvt
fBQeJt90uPV52tmk+iavb8A=
=Svag
-----END PGP SIGNATURE-----

--------------enig3E022825B3160D11F04848FB--

