Message-ID: <44C09BC0.4030307@domain.hid>
Date: Fri, 21 Jul 2006 11:17:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE09AA782E122B0C43EE32579"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [BUG] rt_task_delete kills caller
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
--------------enigE09AA782E122B0C43EE32579
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

I stumbled over a strange behaviour of rt_task_delete for a created, set
periodic, but non-started task. The process gets killed on invocation,
but only if rt_task_set_periodic was called with a non-zero start time.
Here is the demo code:

#include <stdio.h>
#include <sys/mman.h>
#include <native/task.h>

main()
{
	RT_TASK task;

	mlockall(MCL_CURRENT|MCL_FUTURE);

	printf("rt_task_create=3D%d\n",
		rt_task_create(&task, "task", 8192*4, 10, 0));

	printf("rt_task_set_periodic=3D%d\n",
		rt_task_set_periodic(&task, rt_timer_read()+1, 100000));

	printf("rt_task_delete=3D%d\n",
		rt_task_delete(&task));
}

Once you skip rt_task_set_periodic or call it like this
rt_task_set_periodic(&task, TM_NOW, 100000), everything is fine. Tested
over trunk, but I guess over versions should suffer as well.

I noticed that the difference seems to be related to the
xnpod_suspend_thread in xnpod_set_thread_periodic. That suspend is not
called on idate =3D=3D XN_INFINITE. What is it for then, specifically if =
you
would call xnpod_suspend_thread(thread, xnpod_get_time()+period, period)
which should have the same effect like xnpod_suspend_thread(thread, 0,
period)?

Jan


--------------enigE09AA782E122B0C43EE32579
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEwJvAniDOoMHTA+kRAmbqAJ4kjbgUGuEmn1AnZ9emFytmDUHgpACfYdAg
eXgpfTfRc8iKY6qhGW9i/lI=
=K38u
-----END PGP SIGNATURE-----

--------------enigE09AA782E122B0C43EE32579--

