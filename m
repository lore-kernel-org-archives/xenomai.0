Message-ID: <4A4C5EE0.6050900@domain.hid>
Date: Thu, 02 Jul 2009 09:16:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A48FB71.6070506@domain.hid>	<4A49CD81.4060706@domain.hid>	<4A49CFF0.7070202@domain.hid>	<1246353623.7803.21.camel@domain.hid>	<4A49D935.3060900@domain.hid>	<1246353913.7803.24.camel@domain.hid>	<4A49DA4E.2020604@domain.hid>	<1246354047.7803.25.camel@domain.hid>	<4A49DC0A.5000208@domain.hid>	<4A4A391B.8000700@domain.hid>	<4A4B4ED4.6020208@domain.hid>	<4A4B558D.20307@domain.hid>	<4A4B58E9.4050407@domain.hid>	<4A4B5985.3070504@domain.hid>	<4A4B8617.5000704@domain.hid>	<4A4B8851.9070005@domain.hid>	<4A4B8912.1060700@domain.hid>	<4A4BA334.8090701@domain.hid>	<1246472157.7803.62.camel@domain.hid>	<1246472833.7803.67.camel@domain.hid>
	<4A4C15DC.80106@domain.hid> <4A4C52B2.9070000@domain.hid>
	<4A4C5ADB.5080602@domain.hid>
In-Reply-To: <4A4C5ADB.5080602@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig784077705CC73911813368CD"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] x86: Endless minor faults
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig784077705CC73911813368CD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> On archs with non-atomic switch_mm(), use_mm() will require a differen=
t
>> strategy. I'm thinking about something like
>>
>> use_mm():
>> 	set_some_flag();
>> 	barrier();
>> 	current->mm =3D new_mm;
>> 	current->active_mm =3D new_mm;
>> 	switch_mm(old_active_mm, new_mm, current);
>> 	clear_some_flag();
>>
>> and switch_mm():
>> 	...
>> 	if (likely(prev !=3D next) || some_flag_set()) {
>> 		clear_some_flag();
>> 		...
>>
>> ie. enforce mm switch if we may have interrupted use_mm at an unpleasa=
nt
>> time. I just don't know yet where to attach that some_flag to. Should =
be
>> the current task, but can we always access it from switch_mm?
>=20
> These mechanisms are already in place. All you have to do is:
>=20
> use_mm()
> 	ipipe_active_mm =3D NULL;
> 	barrier();
> 	current->mm =3D new_mm;
> 	current->active_mm =3D new_mm;
> 	switch_mm(old_active_mm, new_mm, current);
>=20

As far as I understand, ipipe_active_mm has different semantics on ARM.
Specifically, it has no relation to the initial "next !=3D prev" check.
The test we need is likely orthogonal to this.

Jan


--------------enig784077705CC73911813368CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkpMXuYACgkQniDOoMHTA+kbQACeLxKnmJE+NuSAxOmIO4edC1xM
WPwAnRod7t36UEwEpklLrwRMfiUW0APW
=HTu8
-----END PGP SIGNATURE-----

--------------enig784077705CC73911813368CD--

