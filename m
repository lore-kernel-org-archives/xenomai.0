Message-ID: <48FCED48.5050608@domain.hid>
Date: Mon, 20 Oct 2008 22:42:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48FCDC52.1070507@domain.hid> <48FCE40C.1080100@domain.hid>
	<48FCEB70.7030808@domain.hid> <48FCEC25.2040200@domain.hid>
In-Reply-To: <48FCEC25.2040200@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig28CFB5E84E0E2B2AD6C35AEB"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Warning when compiling trunk.
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
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig28CFB5E84E0E2B2AD6C35AEB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> I get this warning when compiling trunk:
>>>>
>>>> checking for __thread... rm: cannot remove `conftest1.dir': Is a dir=
ectory
>>>> yes
>>>>
>>> That simple, it's a typo in this line:
>>>
>>> http://www.rts.uni-hannover.de/xenomai/lxr/source/configure.in?v=3DSV=
N-trunk#394
>>>
>>> Also, that rm should be done outside the if block to play safe.
>> Ok. But once this is fixed, I get a segmentation fault with __thread o=
n
>> ARM in rt_task_trampoline. I am currently testing the SIGWINCH thing,
>> and if __thread is disabled, there is no segfault.
>=20
> If a #ifdef 0 xeno_set_current, there is no segfault.
>=20

Interesting. What about removing the initial-exec attributes? Is
__thread otherwise know to work on your platform?

Jan


--------------enig28CFB5E84E0E2B2AD6C35AEB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj87UgACgkQniDOoMHTA+mUvgCffaOOAZrxGRZk1p08Tohwc+A6
sfcAn35StPs+tfP08W4FBpRwJOQsEoJy
=EAi3
-----END PGP SIGNATURE-----

--------------enig28CFB5E84E0E2B2AD6C35AEB--

