Message-ID: <4A4A6350.1050304@domain.hid>
Date: Tue, 30 Jun 2009 21:11:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig16EAF97812DCB383CF5970DA"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] 2.6.30: Harden ftrace_run_update_code
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig16EAF97812DCB383CF5970DA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

[ I also back-ported this and 3 related patches to 2.6.29, see git://git.=
kiszka.org/ipipe-2.6.git queues/2.6.29-noarch. ]

In order to safely enable/disable ftrace during runtime we have to
harden its related service that relies on stop_machine for vanilla
kernels.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 kernel/trace/ftrace.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f7c600d..aa45f71 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -28,6 +28,7 @@
 #include <linux/ctype.h>
 #include <linux/list.h>
 #include <linux/hash.h>
+#include <linux/ipipe.h>
=20
 #include <trace/sched.h>
=20
@@ -627,6 +628,9 @@ static int __ftrace_modify_code(void *data)
=20
 static void ftrace_run_update_code(int command)
 {
+#ifdef CONFIG_IPIPE
+	unsigned long flags;
+#endif /* CONFIG_IPIPE */
 	int ret;
=20
 	ret =3D ftrace_arch_code_modify_prepare();
@@ -634,7 +638,13 @@ static void ftrace_run_update_code(int command)
 	if (ret)
 		return;
=20
+#ifdef CONFIG_IPIPE
+	flags =3D ipipe_critical_enter(NULL);
+	__ftrace_modify_code(&command);
+	ipipe_critical_exit(flags);
+#else  /* !CONFIG_IPIPE */
 	stop_machine(__ftrace_modify_code, &command, NULL);
+#endif /* !CONFIG_IPIPE */
=20
 	ret =3D ftrace_arch_code_modify_post_process();
 	FTRACE_WARN_ON(ret);


--------------enig16EAF97812DCB383CF5970DA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkpKY1QACgkQniDOoMHTA+mePwCfeBTkoj9gYzgbMzgfd36MLfnE
qcgAn2EGjSvI+BvphBhGJDAkJXu6HQLb
=kXnI
-----END PGP SIGNATURE-----

--------------enig16EAF97812DCB383CF5970DA--

