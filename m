Message-ID: <43987EA2.9000504@domain.hid>
Date: Thu, 08 Dec 2005 19:42:42 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig69754E3BB95E4383A97973B4"
Subject: [Xenomai-core] [patch] fix rt_task_delete for cancellable rt-threads
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
--------------enig69754E3BB95E4383A97973B4
Content-Type: multipart/mixed; boundary="------------020409000007090408020909"

This is a multi-part message in MIME format.
--------------020409000007090408020909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

no, this is not the fix for the issue I described earlier. This just
improves the behaviour of rt_task_delete in case the target is blocking
at a cancellation point (tested with standard sem_wait). With the
current version, rt_task_deletes the rt-shadow and just wakes up the
linux pthread even if the target is cancellable at that moment. With the
reordering, this is fixed and the target is actually terminated. No
major issue, though.

Jan

--------------020409000007090408020909
Content-Type: text/plain;
 name="rt_task_delete.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rt_task_delete.patch"

Index: src/skins/native/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/native/task.c	(revision 243)
+++ src/skins/native/task.c	(working copy)
@@ -203,12 +203,18 @@
 int rt_task_delete (RT_TASK *task)
=20
 {
-    int err =3D XENOMAI_SKINCALL1(__native_muxid,
-				__native_task_delete,
-				task);
-    if (!err)
-	pthread_cancel((pthread_t)task->opaque2);
+    int err;
=20
+    err =3D pthread_cancel((pthread_t)task->opaque2)
+    if (err)
+        return -err;
+
+    err =3D XENOMAI_SKINCALL1(__native_muxid,
+			    __native_task_delete,
+			    task);
+    if (err =3D=3D -ESRCH)
+	return 0;
+
     return err;
 }
=20

--------------020409000007090408020909--

--------------enig69754E3BB95E4383A97973B4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDmH6incNeS9Q0k+IRAnZKAJ4rFh5L8SG9LH5yCCZSfgY4IHd+2ACdHStQ
b18nMPpH1Ps74VfSOaXfGqE=
=IErS
-----END PGP SIGNATURE-----

--------------enig69754E3BB95E4383A97973B4--

