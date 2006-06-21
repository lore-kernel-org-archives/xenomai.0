Message-ID: <44992054.70905@domain.hid>
Date: Wed, 21 Jun 2006 12:32:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] mutex locking
References: <216532953@domain.hid>
In-Reply-To: <216532953@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig21EB9D863E68E8A137E8685C"
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
To: =?ISO-8859-15?Q?Tobias_B=E4r?= <Tobias.Baer@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig21EB9D863E68E8A137E8685C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Tobias B=E4r wrote:
>> -----Urspr=FCngliche Nachricht-----
>> Von: Jan Kiszka <jan.kiszka@domain.hid>
>> Gesendet: 21.06.06 11:46:34
>> An: Tobias B=E4r <Tobias.Baer@domain.hid>
>> CC: xenomai@xenomai.org
>> Betreff: Re: [Xenomai-help] mutex locking
>=20
>> Try this, it's safe from such races:
>>
>> /* returns -EWOULDBLOCK if the mutex is locked */
>> if (rt_mutex_lock(&write_mutex,TM_NONBLOCK) =3D=3D 0)
>> {
>>       // do sth.
>>
>>       rt_mutex_unlock(&mutex);
>> }
>=20
> Thank's for the quick reply! But another question: How could it be that=
 a mutex is locked twice?
>=20

RTFM ;): "Xenomai mutexes are implicitely recursive [...]."

> if(rt_mutex_lock(&write_mutex,TM_NONBLOCK) =3D=3D 0)
>   {
>     if(rt_mutex_lock(&write_mutex,TM_NONBLOCK) =3D=3D 0)
>       printf("Mutex is locked twice!\n");
>=20
>    rt_mutex_unlock(&mutex);
>   }
>=20
> Is it locked by the ID of the thread?
>=20

Yep, the owner is recorded, also to perform priority inheritance when
required. Recursive means that the current owner can acquire the mutex
multiple times (but (s)he also has to release it symmetrically then -
your example is lacking one unlock).

If you use the POSIX skin with its standard pthread_mutex'es, then you
can decide about the recursiveness explicitly.

Jan


--------------enig21EB9D863E68E8A137E8685C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEmSBUniDOoMHTA+kRAvODAJ0cycp7iKTzYBLdy214C9hONzAwpACbBTsL
Ooku5IuujUMYKI4WnwNbd4g=
=YTWs
-----END PGP SIGNATURE-----

--------------enig21EB9D863E68E8A137E8685C--

