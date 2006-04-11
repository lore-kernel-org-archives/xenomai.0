Message-ID: <443BB6B3.8060601@domain.hid>
Date: Tue, 11 Apr 2006 16:01:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Fixs doxygen doc on
	rt_queue_read	in	ksrc/native/queue.c (for SVN version)
References: <200604101640.04255.lbocseg@domain.hid> <443BA12F.9020505@domain.hid>
In-Reply-To: <443BA12F.9020505@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC0F5E9FFD53CBFC4FBAFF8A2"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC0F5E9FFD53CBFC4FBAFF8A2
Content-Type: multipart/mixed; boundary="------------090800090700040802030909"

This is a multi-part message in MIME format.
--------------090800090700040802030909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[a few interruptions later]

Jan Kiszka wrote:
> Rodrigo Rosenfeld Rosas wrote:
>> BTW, please, could someone confirm the rt_task_delete(NULL) bug in SVN=
?
>=20
> Half-confirmed, there is something fishy. I'm struggling with the
> debugger ATM, not sure yet who's wrong ;). It tells me rt_task_delete o=
f
> the skin module is entered with task !=3D NULL...

=2E..which turns out to be fine, just appears redundant to me when
comparing __rt_task_delete and rt_task_delete for the task=3DNULL case.

Anyway, leaving a native task with rt_task_delete(NULL) raises SIGKILL
to the whole process instead of just the task (pthread). This lets your
program terminate unexpectedly - I would say: a bug. And this doesn't
happen with 2.1?

I guess the easiest way to solve this is to catch NULL in userspace and
call pthread_exit() in favour of the skin service (the POSIX skin uses
pthread_exit anyway), see attached patch. Someone just has to confirm
that there will be no problem hidden by this approach.

Jan


PS: What's the reason for "if (err =3D=3D -ESRCH) return 0" in
src/skins/native/task.c, rt_task_delete? Why is that error generate in
the first place if it is zeroed out here?

--------------090800090700040802030909
Content-Type: text/plain;
 name="task-delete-null.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="task-delete-null.patch"

Index: src/skins/native/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/native/task.c	(revision 923)
+++ src/skins/native/task.c	(working copy)
@@ -212,7 +212,10 @@ int rt_task_delete (RT_TASK *task)
 {
     int err;
=20
-    if (task && task->opaque2) {
+    if (!task)
+	pthread_exit(NULL);
+
+    if (task->opaque2) {
 	err =3D pthread_cancel((pthread_t)task->opaque2);
 	if (err)
 	    return -err;

--------------090800090700040802030909--

--------------enigC0F5E9FFD53CBFC4FBAFF8A2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEO7azniDOoMHTA+kRApedAJ9ygFf+x9HSKyGRvKMzc1DEhgXmYgCdHOhX
c7HW8/6uq8kfpPhU3evuRLM=
=yaE/
-----END PGP SIGNATURE-----

--------------enigC0F5E9FFD53CBFC4FBAFF8A2--

