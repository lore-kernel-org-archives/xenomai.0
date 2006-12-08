Message-ID: <457956F3.6090904@domain.hid>
Date: Fri, 08 Dec 2006 13:13:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] module usage counter of
	xenomai	native	corrupted (version 2.2.0 and 2.2.5)
References: <OF7997031E.1BD006A7-ONC125723D.0046EB70-C125723D.0048376B@retarus.de>	<457826BC.1080008@domain.hid>
	<4579248A.8040201@domain.hid> <4579387F.7030505@domain.hid>
In-Reply-To: <4579387F.7030505@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC5A00A4CBAC3DC67F89BDA14"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC5A00A4CBAC3DC67F89BDA14
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>
>>> Thomas Wiedemann wrote:
>>>
>>>
>>>> Hi,
>>>>
>>>> there seems to be a bug in rt_task_create(). When no more memory is
>>>> available, the module usage counter of xeno_native is decremented. I=

>>>> guess it is not incremented before, however, so the counter gets 0 a=
nd
>>>> wraps then to a negative number. It is therefore not possible to rem=
ove
>>>> the module.
>>>>
>>>> I appended a small program to demonstrate this. It simply eats up al=
l
>>>> memory from xenomai by registering as much mutexes as possible,
>>>> and then tries to execute rt_task_create(), which fails. When starte=
d
>>>> again, the bug occurs at rt_task_shadow(), as the mutexes have never=

>>>> been deleted.
>>>> Compile with  gcc -O2 -Wall `xeno-config --xeno-cflags` `xeno-config=

>>>> --xeno-ldflags` -lrtdm -lnative -o rttest rttest.c
>>>> then simply run it, and watch the output of lsmod before and after.
>>>>
>>>> Tested with xenomai 2.2.{0,5} and linux 2.6.17.8, modules loaded:
>>>> xeno_native and xeno_nucleus.
>>>>
>>>
>>> Confirmed. Requires a closer look to find the leak path.
>>
>> Here is what happens: the task is created with the XNSHADOW bit, and
>> destroyed before it was xnshadow_mapped, but the deletion hook calls
>> xnshadow_unmap because the task has the XNSHADOW bit. And xnshadow_unm=
ap
>>  decrements the module count.
>=20
> Here is an untested quick fix.
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> Index: ksrc/nucleus/shadow.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/nucleus/shadow.c	(r=C3=A9vision 1930)
> +++ ksrc/nucleus/shadow.c	(copie de travail)
> @@ -888,6 +888,9 @@
> =20
>  	p =3D xnthread_archtcb(thread)->user_task;	/* May be !=3D current */
> =20
> +	if (!xnshadow_thrptd(p))
> +		return;
> +
>  	magic =3D xnthread_get_magic(thread);
> =20
>  	for (muxid =3D 0; muxid < XENOMAI_MUX_NR; muxid++) {

Nope, shows unwanted side effects, probably because xnshadow_thrptd is
already NULL'ed in do_taskexit_event. Looks like it takes an extra flag, =
no?


--------------enigC5A00A4CBAC3DC67F89BDA14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFeVbzniDOoMHTA+kRAvuvAJ9EoFmtUse5d17/0SmvUlQI1ByIAgCfVPsy
v575OLoRJVt1lCtwQihhs94=
=HmOE
-----END PGP SIGNATURE-----

--------------enigC5A00A4CBAC3DC67F89BDA14--

