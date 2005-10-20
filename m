Message-ID: <4357C464.5050206@domain.hid>
Date: Thu, 20 Oct 2005 18:23:00 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Replacement for rt_save_flags_and_cli
References: <40292.128.93.15.41.1129793705.squirrel@domain.hid>
	<435766D6.6090605@domain.hid> <43576FA9.6010202@domain.hid>
	<4357C11B.3080103@domain.hid>
In-Reply-To: <4357C11B.3080103@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEA179018D21D82736F7EF980"
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
--------------enigEA179018D21D82736F7EF980
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Ignacio Garc=EDa P=E9rez wrote:
> Philippe Gerum wrote:
>=20
>=20
>>Ignacio Garc=EDa P=E9rez wrote:
>>
>>
>>>Hi,
>>>
>>>Porting app from RTAI. Just another newbie question. Is there a
>>>substitute for rt_save_flags_and_cli / rt_restore_flags ?.
>>
>>
>>See include/nucleus/asm-generic/hal.h:
>>
>>#define rthal_local_irq_save(x)  =20
>>#define rthal_local_irq_restore(x)
>=20
>=20
> Thanks. I just found the following functions in
> include/nucleus/asm-generic/system.h
>=20
> xnlock_get_irqsave
> xnlock_put_irqrestore
> xnlock_clear_irqoff
> xnlock_clear_irqon
>=20
> They're just #defines to the rthal_ functions.
>=20
> Should I use rthal_* or xnlock_* ?

I would suggest xnlock_, because this is the higher abstraction layer
(the nucleus on top of the hal).

But: both primitives are rather low-level. Do you really need that
"hard" locks? What are you synchronising this way, IRQ handlers with
tasks, tasks with other tasks?

>=20
> By the way, so far I'm uttery in love with the clean, consistent API of=

> the native skin.

Would you like to forward this statement to a specific mailing list of a
formely related project? ;) (only kidding, just had to smile)

Jan


--------------enigEA179018D21D82736F7EF980
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDV8RkncNeS9Q0k+IRAh7JAJ90po7xj5w0PUUj3BfQTfgS67KVRACfV5nZ
UDRoqcFhyY3tQtL0nvztvTQ=
=BQaP
-----END PGP SIGNATURE-----

--------------enigEA179018D21D82736F7EF980--

