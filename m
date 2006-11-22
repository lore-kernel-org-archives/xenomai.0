Message-ID: <45643CC4.1000201@domain.hid>
Date: Wed, 22 Nov 2006 13:04:20 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] What returns rt_task_self in relation
	to	rt_task_create
References: <20403318.1164195534169.JavaMail.ngmail@domain.hid>
In-Reply-To: <20403318.1164195534169.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig78E974EA338770BABA4D4AE5"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig78E974EA338770BABA4D4AE5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi all,
>=20
> I have a simple question concerning the Xenomai native API:
> According to the API documentation, rt_task_self returns the=20
> address of the caller's task descriptor.
> I have now written the following (simple application):
> ---------- START ----------
> #include <stdio.h>
> #include <sys/mman.h>
> #include <native/task.h>
>=20
> RT_TASK task_desc;
>=20
> void mytask(void *cookie)
> {
>     RT_TASK *tsk =3D rt_task_self();
>     printf("rt_task_self  %p\n"
>            "task_desc     %p\n", tsk, &task_desc);
> }
>=20
> int main(void)
> {
>     mlockall(MCL_CURRENT|MCL_FUTURE);
>=20
>     rt_task_create(&task_desc, "mytaskname", 0, 80, T_JOINABLE);
>     rt_task_start(&task_desc, &mytask, NULL);
>=20
>     rt_task_join(&task_desc);
>=20
>     return 0;
> }
> ------------ END -----------
>=20
> I expect now that rt_task_self() returns exactly the address of the tas=
k_desc.
> However, a different address is returned.=20
> The output of the application from above is:
> rt_task_self  0x804a050
> task_desc     0x8049878
>=20
> How are those addresses related - how can I find out the descriptor add=
ress=20
> used for rt_task_create() at runtime?

The documentation is not precise enough here: what you obtain from
rt_task_self is /some/ task descriptor for the currently running task,
it is not a reference to the same piece of memory containing the task
descriptor. Check the library implementation for further insights.

>=20
> Background of the question:
> I want to write an application that uses a couple of similar tasks.
> I have to store some task-specific information (internal states...).
> Now I am looking for a simple way to get this information at runtime fr=
om my task
> by calling rt_task_self() (or something similar) to use this address to=
 reach my
> additional information.

If you are on NPTL glibc, set up a __thread variable for the per-thread
information. It will always contain the thread-related data that you
can, e.g., fill in during the thread routine's prologue.

Jan


--------------enig78E974EA338770BABA4D4AE5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFZDzFniDOoMHTA+kRAvulAJ9NHj/toRMoCfYIGsCS5Npd20hIGACfUND5
hyoXfaoU9EW9RwvjgPVuT8Q=
=8SX2
-----END PGP SIGNATURE-----

--------------enig78E974EA338770BABA4D4AE5--

