Message-ID: <45797CC0.8010609@domain.hid>
Date: Fri, 08 Dec 2006 15:54:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] module usage counter of
	xenomai	native	corrupted (version 2.2.0 and 2.2.5)
References: <OF7997031E.1BD006A7-ONC125723D.0046EB70-C125723D.0048376B@retarus.de>	<457826BC.1080008@domain.hid>
	<4579248A.8040201@domain.hid> <4579387F.7030505@domain.hid>
	<457956F3.6090904@domain.hid> <45796841.4040106@domain.hid>
In-Reply-To: <45796841.4040106@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFEC2FC2EA8F8FA8EB7827BF1"
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
--------------enigFEC2FC2EA8F8FA8EB7827BF1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>
>>> Gilles Chanteperdrix wrote:
>>>
>>>> Jan Kiszka wrote:
>>>>
>>>>
>>>>> Thomas Wiedemann wrote:
>>>>>
>>>>>
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> there seems to be a bug in rt_task_create(). When no more memory i=
s
>>>>>> available, the module usage counter of xeno_native is decremented.=
 I
>>>>>> guess it is not incremented before, however, so the counter gets 0=
 and
>>>>>> wraps then to a negative number. It is therefore not possible to r=
emove
>>>>>> the module.
>>>>>>
>>>>>> I appended a small program to demonstrate this. It simply eats up =
all
>>>>>> memory from xenomai by registering as much mutexes as possible,
>>>>>> and then tries to execute rt_task_create(), which fails. When star=
ted
>>>>>> again, the bug occurs at rt_task_shadow(), as the mutexes have nev=
er
>>>>>> been deleted.
>>>>>> Compile with  gcc -O2 -Wall `xeno-config --xeno-cflags` `xeno-conf=
ig
>>>>>> --xeno-ldflags` -lrtdm -lnative -o rttest rttest.c
>>>>>> then simply run it, and watch the output of lsmod before and after=
=2E
>>>>>>
>>>>>> Tested with xenomai 2.2.{0,5} and linux 2.6.17.8, modules loaded:
>>>>>> xeno_native and xeno_nucleus.
>>>>>>
>>>>> Confirmed. Requires a closer look to find the leak path.
>>>> Here is what happens: the task is created with the XNSHADOW bit, and=

>>>> destroyed before it was xnshadow_mapped, but the deletion hook calls=

>>>> xnshadow_unmap because the task has the XNSHADOW bit. And xnshadow_u=
nmap
>>>> decrements the module count.
>>> Here is an untested quick fix.
>>>
>>>
>>>
>>> ---------------------------------------------------------------------=
---
>>>
>>> Index: ksrc/nucleus/shadow.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- ksrc/nucleus/shadow.c	(r=C3=A9vision 1930)
>>> +++ ksrc/nucleus/shadow.c	(copie de travail)
>>> @@ -888,6 +888,9 @@
>>>
>>> 	p =3D xnthread_archtcb(thread)->user_task;	/* May be !=3D current */=

>>>
>>> +	if (!xnshadow_thrptd(p))
>>> +		return;
>>> +
>>> 	magic =3D xnthread_get_magic(thread);
>>>
>>> 	for (muxid =3D 0; muxid < XENOMAI_MUX_NR; muxid++) {
>>
>> Nope, shows unwanted side effects, probably because xnshadow_thrptd is=

>> already NULL'ed in do_taskexit_event. Looks like it takes an extra fla=
g, no?
>=20
> Setting xnshadow_thrptd to NULL in do_taskexit_event does not seem to b=
e
>  that useful. Here comes version 2.
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
> @@ -1639,8 +1642,6 @@
>  		xnshadow_relax(0);
> =20
>  	xnlock_get_irqsave(&nklock, s);
> -	/* Prevent wakeup call from xnshadow_unmap(). */
> -	xnshadow_thrptd(p) =3D NULL;
>  	xnthread_archtcb(thread)->user_task =3D NULL;
>  	/* xnpod_delete_thread() -> hook -> xnshadow_unmap(). */
>  	xnpod_delete_thread(thread);

Can't comment on the correctness of the second hunk, but it
unfortunately doesn't change the situation that test case does not
longer terminate with the first hunk applied. May look like a trivial
issue - but it isn't. :->


--------------enigFEC2FC2EA8F8FA8EB7827BF1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFeXzAniDOoMHTA+kRAqZvAJ92uC1SPGxpm0dZCFP6C7e8Ao553gCeNgjo
hAp7txE6QLsm+aEdJZTMmgo=
=vtbL
-----END PGP SIGNATURE-----

--------------enigFEC2FC2EA8F8FA8EB7827BF1--

