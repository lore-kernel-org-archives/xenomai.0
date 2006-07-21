Message-ID: <44C0A083.6000101@domain.hid>
Date: Fri, 21 Jul 2006 11:38:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] rt_task_delete kills caller
References: <44C09BC0.4030307@domain.hid>
In-Reply-To: <44C09BC0.4030307@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig537B5B5E5C7E385BEC7B7F0F"
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
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig537B5B5E5C7E385BEC7B7F0F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi,
>=20
> I stumbled over a strange behaviour of rt_task_delete for a created, se=
t
> periodic, but non-started task. The process gets killed on invocation,

More precisely:

(gdb) cont
Program received signal SIG32, Real-time event 32.

Weird. No kernel oops BTW.

> but only if rt_task_set_periodic was called with a non-zero start time.=

> Here is the demo code:
>=20
> #include <stdio.h>
> #include <sys/mman.h>
> #include <native/task.h>
>=20
> main()
> {
> 	RT_TASK task;
>=20
> 	mlockall(MCL_CURRENT|MCL_FUTURE);
>=20
> 	printf("rt_task_create=3D%d\n",
> 		rt_task_create(&task, "task", 8192*4, 10, 0));
>=20
> 	printf("rt_task_set_periodic=3D%d\n",
> 		rt_task_set_periodic(&task, rt_timer_read()+1, 100000));
>=20
> 	printf("rt_task_delete=3D%d\n",
> 		rt_task_delete(&task));
> }
>=20
> Once you skip rt_task_set_periodic or call it like this
> rt_task_set_periodic(&task, TM_NOW, 100000), everything is fine. Tested=

> over trunk, but I guess over versions should suffer as well.
>=20
> I noticed that the difference seems to be related to the
> xnpod_suspend_thread in xnpod_set_thread_periodic. That suspend is not
> called on idate =3D=3D XN_INFINITE. What is it for then, specifically i=
f you
> would call xnpod_suspend_thread(thread, xnpod_get_time()+period, period=
)
> which should have the same effect like xnpod_suspend_thread(thread, 0,
> period)?
>=20
> Jan



--------------enig537B5B5E5C7E385BEC7B7F0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEwKCDniDOoMHTA+kRAk6oAJwN/ayp5m+0cdAUf7wr0t9aNsvrSgCeJfbv
vFssXF8kuT7/ay2sKtYDyYM=
=fd+q
-----END PGP SIGNATURE-----

--------------enig537B5B5E5C7E385BEC7B7F0F--

