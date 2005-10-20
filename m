Message-ID: <4357DF8F.9080403@domain.hid>
Date: Thu, 20 Oct 2005 20:18:55 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Replacement for rt_save_flags_and_cli
References: <40292.128.93.15.41.1129793705.squirrel@domain.hid>
	<435766D6.6090605@domain.hid> <43576FA9.6010202@domain.hid>
	<4357C11B.3080103@domain.hid> <4357C464.5050206@domain.hid>
	<4357CC7D.2030907@domain.hid>
In-Reply-To: <4357CC7D.2030907@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig832BB96A7B4E721C0ED74E64"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig832BB96A7B4E721C0ED74E64
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Ignacio Garc=EDa P=E9rez wrote:
>>But: both primitives are rather low-level. Do you really need that
>>"hard" locks? What are you synchronising this way, IRQ handlers with
>>tasks, tasks with other tasks?
>>=20
>>
>=20
> An IRQ handler with a task.
>=20
> Yeah, I know I could just use rt_intr_disable on that interrupt object,=

> but for reasons too long to explain, the it is encapsulated in a piece
> of code and I'd rather not allow other code to see it. Probably not a
> good design but at this stage of the port, I'd like to get it working
> under xenomai with as little modifications as possible.
>=20
> Another place I've used it sometimes is substituting a mutex for very
> short pieces of code such as:
>=20
> cli()
> a =3D b + c;
> sti()
>=20
> It is usually more efficient that using a mutex, and this may be
> important in low-end processors with little horsepower.
>=20

Agree. But even when developing for a low-end UP system, it's good style
to use spinlocks (IRQ: xnlock_get, task: xnlock_get_irqsave) for it.
They will cause the same code to be generated on UP, but will continue
to work in case more CPUs pop up someday...

>=20
>>>By the way, so far I'm uttery in love with the clean, consistent API o=
f
>>>the native skin.
>>>  =20
>>>
>>
>>Would you like to forward this statement to a specific mailing list of =
a
>>formely related project? ;) (only kidding, just had to smile)
>>=20
>>
>=20
> Man, you just read my mind :-)
>=20
> I just have to say it:
>=20
> 1- It is amazing that fusion has progressed from conception to its
> actual usable, stable state in such a short time.
>=20
> 2- In general, I appreciate good design and robustness over efficiency
> and other issues, but IMHO, for real-time systems it must be the number=

> one priority, which I'm not sure it was in the "formerly related
> project". Too many large changes in too many time.
>=20
> 3- The patent issue may not be a priority in the academic world, but it=

> definitely is for industrial applications.
>=20

I generally consider the last topic as a psychological issue: people in
industry feel better when they get farther away from well-known mined
places - although the whole area is full of more or less effective mines
these days. As only few minelayers really try to trigger them but rather
use them more subtle, it's an issue, though.

And - hey! - academic world is not that far away from industry! We also
need money to do research, and the state isn't that rich anymore... ;)

Jan


--------------enig832BB96A7B4E721C0ED74E64
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDV9+PncNeS9Q0k+IRAjECAKCGm1C0QpvNxiUMx+jASFvO5sVyuQCgmidX
whFOXoFGpE3mrOqhyUpiQnU=
=x3HN
-----END PGP SIGNATURE-----

--------------enig832BB96A7B4E721C0ED74E64--

