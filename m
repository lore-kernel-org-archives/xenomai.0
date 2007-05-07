Message-ID: <463F27F3.9010101@domain.hid>
Date: Mon, 07 May 2007 15:21:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4639D724.5010702@domain.hid>	<1178198991.29605.54.camel@domain.hid>	<463AE79E.2090901@domain.hid>	<1178281926.29093.93.camel@domain.hid>
	<463B2A69.7080704@domain.hid> <463EE376.9030702@domain.hid>
	<463F1BFF.1010303@domain.hid>
In-Reply-To: <463F1BFF.1010303@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF668B5DFA4923F52ACF5DE48"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Latency calculation and test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF668B5DFA4923F52ACF5DE48
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Johan Borkhuis wrote:
>> void timeStampGet(clockid_t which_clock, struct timespec *curtime)
>> {
>>     unsigned long lo, hi, hi2;
>>     unsigned long long tr;
>>     long double tmpVal;
>>
>>     if(hwtimer =3D=3D 0)
>>     {
>>         clock_gettime(which_clock, curtime);
>=20
> If you do not compile for Xenomai posix skin (i.e. passing
> -Wl,--wrap,clock_gettime -lpthread_rt to gcc), this causes a switch to
> secondary mode.
>=20

As far as I understood, the test runs with -h, ie. without running into
that case.


--------------enigF668B5DFA4923F52ACF5DE48
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGPyfzniDOoMHTA+kRAi/EAJ9mLxHygjaZcOechKabxsjwbQguLwCeJls7
DvFkSixMeYj7NQdeTAFjGBI=
=Mg1K
-----END PGP SIGNATURE-----

--------------enigF668B5DFA4923F52ACF5DE48--

