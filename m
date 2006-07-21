Message-ID: <44C0CD07.4070708@domain.hid>
Date: Fri, 21 Jul 2006 14:48:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] rt_task_delete kills caller
References: <44C09BC0.4030307@domain.hid> <44C0A083.6000101@domain.hid>
In-Reply-To: <44C0A083.6000101@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5D7F5CEBF908E232D797FCCE"
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
--------------enig5D7F5CEBF908E232D797FCCE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> I stumbled over a strange behaviour of rt_task_delete for a created, s=
et
>> periodic, but non-started task. The process gets killed on invocation,=

>=20
> More precisely:
>=20
> (gdb) cont
> Program received signal SIG32, Real-time event 32.
>=20
> Weird. No kernel oops BTW.
>=20
>> but only if rt_task_set_periodic was called with a non-zero start time=
=2E
>> Here is the demo code:
>>
>> #include <stdio.h>
>> #include <sys/mman.h>
>> #include <native/task.h>
>>
>> main()
>> {
>> 	RT_TASK task;
>>
>> 	mlockall(MCL_CURRENT|MCL_FUTURE);
>>
>> 	printf("rt_task_create=3D%d\n",
>> 		rt_task_create(&task, "task", 8192*4, 10, 0));
>>
>> 	printf("rt_task_set_periodic=3D%d\n",
>> 		rt_task_set_periodic(&task, rt_timer_read()+1, 100000));
>>
>> 	printf("rt_task_delete=3D%d\n",
>> 		rt_task_delete(&task));
>> }
>>
>> Once you skip rt_task_set_periodic or call it like this
>> rt_task_set_periodic(&task, TM_NOW, 100000), everything is fine. Teste=
d
>> over trunk, but I guess over versions should suffer as well.
>>
>> I noticed that the difference seems to be related to the
>> xnpod_suspend_thread in xnpod_set_thread_periodic. That suspend is not=

>> called on idate =3D=3D XN_INFINITE. What is it for then, specifically =
if you
>> would call xnpod_suspend_thread(thread, xnpod_get_time()+period, perio=
d)
>> which should have the same effect like xnpod_suspend_thread(thread, 0,=

>> period)?

That difference is clear to me now: set_periodic with a start date !=3D
XN_INFINITE means "suspend the task immediately until the provided
release date" (RTFM...) while date =3D=3D XN_INFINITE means "keep the tas=
k
running and schedule the first release on now+period".

The actual problem seems to be related to sending SIGKILL on
rt_task_delete to the dying thread. This happens only in the failing
case. When xnpod_suspend_thread was not called, the thread seems to
self-terminate first so that rt_task_delete becomes a nop (no more task
registered at that point). I think we had this issue before. Was it
solved? [/me querying the archive now...]

Jan


--------------enig5D7F5CEBF908E232D797FCCE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEwM0HniDOoMHTA+kRArafAJkBryVKrUtfDvFy7S6T12+xcs5E/ACfXLsi
+KlRzHKKkPdXtHr2NQvtG/k=
=Hv5s
-----END PGP SIGNATURE-----

--------------enig5D7F5CEBF908E232D797FCCE--

