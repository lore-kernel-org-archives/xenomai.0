Message-ID: <43A4481B.7060401@domain.hid>
Date: Sat, 17 Dec 2005 18:17:15 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] debug_maxlat as module_param
References: <43A436A1.5070509@domain.hid>
	<17316.16329.895671.929282@domain.hid>
In-Reply-To: <17316.16329.895671.929282@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig85005D037212FB835B9AA818"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig85005D037212FB835B9AA818
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Hi,
>  > 
>  > this tiny patch exports the NMI watchdog's threshold as module parameter
>  > "debug_maxlat" of xeno_hal. This means that one can either override the
>  > value via a kernel parameter or in sysfs/modules/xeno_hal/parameters
>  > (before activating the hal).
> 
> rthal_maxlat_tsc should be updated when rthal_maxlat_us_arg changes.
> 

I didn't digged that deep, is this possible during runtime? My current
workflow looks like this: unload xeno_nucleus (and higher modules),
change maxlat, reload the modules.

Mmh, I guess one has to register some update handler with sysfs in that
case. Any hint where to look for a pattern?

Jan

--------------enig85005D037212FB835B9AA818
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDpEgbncNeS9Q0k+IRAuKzAKDegPzuADglQLoonD896K/hjjpNrwCguCCv
GzPfSughV5FczuwXzl3WXfk=
=yQnN
-----END PGP SIGNATURE-----

--------------enig85005D037212FB835B9AA818--

