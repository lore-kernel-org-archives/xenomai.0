Message-ID: <44991560.6030300@domain.hid>
Date: Wed, 21 Jun 2006 11:46:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] mutex locking
References: <216509776@domain.hid>
In-Reply-To: <216509776@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEDC45A79E20671E0F14F7185"
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEDC45A79E20671E0F14F7185
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Tobias B=E4r wrote:
> Hi all,
>=20
> my question is about the right way to lock and inquire a mutex. At time=
, my code looks like this:
>=20
>=20
> rt_mutex_inquire(&mutex,TM_NONBLOCK);
>=20
> if(info.lockcnt =3D=3D 0)=20
> {
>       rt_mutex_lock(&write_mutex,TM_NONBLOCK);
>=20
>       // do sth.
>=20
>       rt_mutex_unlock(&mutex);
> }
>=20
>=20
> What happens if anyone locks the mutex between my "rt_mutex_inquire(...=
)" and my "if(info.lockcnt =3D=3D 0)" ?
>=20
> Is this the standard way to lock and inquire a mutex?
>=20

Try this, it's safe from such races:

/* returns -EWOULDBLOCK if the mutex is locked */
if (rt_mutex_lock(&write_mutex,TM_NONBLOCK) =3D=3D 0)
{
      // do sth.

      rt_mutex_unlock(&mutex);
}

Jan


--------------enigEDC45A79E20671E0F14F7185
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEmRVgniDOoMHTA+kRAs6uAJ45dhIfEgov9sdveo3PfeRmQFIiCQCfcz+m
gYAwLCdoPmvkElhWA5Pq8Zw=
=gJNX
-----END PGP SIGNATURE-----

--------------enigEDC45A79E20671E0F14F7185--

