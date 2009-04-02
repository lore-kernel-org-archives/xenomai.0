Message-ID: <49D513D8.5020001@domain.hid>
Date: Thu, 02 Apr 2009 21:36:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig535AC35B053761A3B39F03D7"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] libnative: Avoid double-evaluation of
	rt_task_self()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig535AC35B053761A3B39F03D7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

[ can be pulled from git.xenomai.org/xenomai-jki.git queues/assorted ]

Keep the result of rt_task_self() in a local variable to avoid the
second invocation.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 src/skins/native/task.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/skins/native/task.c b/src/skins/native/task.c
index 905d366..149717b 100644
--- a/src/skins/native/task.c
+++ b/src/skins/native/task.c
@@ -247,10 +247,11 @@ int rt_task_resume(RT_TASK *task)
=20
 int rt_task_delete(RT_TASK *task)
 {
+	RT_TASK *self;
 	int err;
=20
 	if (task =3D=3D NULL ||
-	    (rt_task_self() && task->opaque =3D=3D rt_task_self()->opaque)) {
+	    ((self =3D rt_task_self()) && self->opaque =3D=3D task->opaque)) {
 		/* Silently migrate to avoid raising SIGXCPU. */
 		XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_LINUX_DOMAIN);
 		pthread_exit(NULL);


--------------enig535AC35B053761A3B39F03D7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAknVE9wACgkQniDOoMHTA+nBnACcCgaxOsSonkuC7QyMjD4i+9+O
Zl8AniEIdyKnKPF5/ezpOUwS1oWCDRw2
=FykL
-----END PGP SIGNATURE-----

--------------enig535AC35B053761A3B39F03D7--

