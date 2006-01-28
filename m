Message-ID: <43DB3AB1.5090004@domain.hid>
Date: Sat, 28 Jan 2006 10:34:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB3FE36E74159CFBD1DF9B909"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix pthread cancellation in native skin
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
--------------enigB3FE36E74159CFBD1DF9B909
Content-Type: multipart/mixed; boundary="------------020401030901070200000103"

This is a multi-part message in MIME format.
--------------020401030901070200000103
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

Gilles' work on cancellation for the posix skin reminded me of this
issue I once discovered in the native skin:

https://mail.gna.org/public/xenomai-core/2005-12/msg00014.html

I found out that this can easily be fixed by switching the pthread of a
native task to PTHREAD_CANCEL_ASYNCHRONOUS. See attached patch.


At this chance I discovered that calling rt_task_delete for a task that
was created and started with T_SUSP mode but was not yet resumed, locks
up the system. More precisely: it raises a fatal warning when
XENO_OPT_DEBUG is on. Might be the case that it just works on system
without this switched on. Either this is a real bug, or the warning
needs to be fixed. (Deleting a task after rt_task_suspend works.)

Jan

--------------020401030901070200000103
Content-Type: text/x-patch;
 name="native-canceltype.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="native-canceltype.patch"

Index: src/skins/native/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/native/task.c	(Revision 481)
+++ src/skins/native/task.c	(Arbeitskopie)
@@ -59,6 +59,9 @@
     param.sched_priority =3D sched_get_priority_max(SCHED_FIFO);
     pthread_setschedparam(pthread_self(),SCHED_FIFO,&param);
=20
+    /* rt_task_delete requires asynchronous cancellation */
+    pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
+
     signal(SIGCHLD,&rt_task_sigharden);
=20
     bulk.a1 =3D (u_long)iargs->task;
@@ -160,6 +163,9 @@
 {
     struct rt_arg_bulk bulk;
=20
+    /* rt_task_delete requires asynchronous cancellation */
+    pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
+
     signal(SIGCHLD,&rt_task_sigharden);
=20
     bulk.a1 =3D (u_long)task;

--------------020401030901070200000103--

--------------enigB3FE36E74159CFBD1DF9B909
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD2zqxniDOoMHTA+kRAnoTAJ0eJvV32rmpPiibbkouzePeYmx+6QCfR3J9
695mzyZE0XEVeEmuIWtXfgU=
=s301
-----END PGP SIGNATURE-----

--------------enigB3FE36E74159CFBD1DF9B909--

