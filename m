Message-ID: <44B4C09F.209@domain.hid>
Date: Wed, 12 Jul 2006 11:27:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig39A97E031BCCFB1B647B91B2"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] relax context check for rt_task_suspend
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
--------------enig39A97E031BCCFB1B647B91B2
Content-Type: multipart/mixed; boundary="------------090401080202040104080804"

This is a multi-part message in MIME format.
--------------090401080202040104080804
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

given the existing doc of rt_task_suspend about allowed environments and
also when thinking about the logic behind it, I see no reason why
xnpod_unblockable_p() is also applied to task !=3D NULL. This patch
confines the check to task =3D=3D NULL and also tries to clarify the erro=
r
code documentation.

Jan

--------------090401080202040104080804
Content-Type: text/plain;
 name="suspend-foreign-task-from-any-context.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="suspend-foreign-task-from-any-context.patch"

Index: ksrc/skins/native/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/task.c	(revision 1323)
+++ ksrc/skins/native/task.c	(working copy)
@@ -391,9 +391,9 @@ int rt_task_start(RT_TASK *task, void (*
  *
  * - -EINVAL is returned if @a task is not a task descriptor.
  *
- * - -EPERM is returned if @a task is NULL but not called from a task
- * context, or this service was called from a context which cannot
- * sleep (e.g. interrupt, non-realtime or scheduler locked).
+ * - -EPERM is returned if @a task is NULL and this service was called
+ * from a context which cannot sleep (e.g. interrupt, non-realtime or
+ * scheduler locked).
  *
  * - -EIDRM is returned if @a task is a deleted task descriptor.
  *
@@ -430,9 +430,7 @@ int rt_task_suspend(RT_TASK *task)
 	if (!task) {
 		err =3D xeno_handle_error(task, XENO_TASK_MAGIC, RT_TASK);
 		goto unlock_and_exit;
-	}
-
-	if (xnpod_unblockable_p()) {
+	} else if (xnpod_unblockable_p()) {
 		err =3D -EPERM;
 		goto unlock_and_exit;
 	}

--------------090401080202040104080804--

--------------enig39A97E031BCCFB1B647B91B2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEtMCfniDOoMHTA+kRAuXSAJ44ml2OvhZ4J0sys6laOke/p9tThACghKke
R7C6b+VQkOit95Z6CdC1VVA=
=eSST
-----END PGP SIGNATURE-----

--------------enig39A97E031BCCFB1B647B91B2--

