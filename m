Message-ID: <4354B317.8000203@domain.hid>
Date: Tue, 18 Oct 2005 10:32:23 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] compiling xenomai on x86_64
References: <4353F109.7000707@domain.hid>
	<4353F411.4000500@domain.hid>
	<4353F896.1040508@domain.hid>
	<435402B4.5060004@domain.hid>
	<17236.13453.672147.550393@domain.hid>
	<4354ADA9.2010809@domain.hid>
	<17236.44896.867414.960846@domain.hid>
In-Reply-To: <17236.44896.867414.960846@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF0C66F226F09AD97C42C1B0B"
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF0C66F226F09AD97C42C1B0B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > > #! /bin/sh
>  > > exec `expr "$0" : 'i686-linux-\(.*\)'` -m32r ${1+"$@"}
>  > > 
>  > > It should work with most build systems...
>  > > 
>  > 
>  > Yes, this seems to work (and fail) just like the "CC=" approach.
> 
> Are you sure your distribution does not provide a cross-compiler ? I
> worked once on an x86_64 with Fedora Core installed. And there was an
> i386-linux-gcc, but it needed a special package.
> 

Nope: OpenSuSE 10.0. Seems like there are still shortcomings of that
distribution. But I also cannot setup some kind of zoo here... :-/

Jan

--------------enigF0C66F226F09AD97C42C1B0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDVLMXncNeS9Q0k+IRAuMlAJ9VgT4z2axy+DsbJf9TggXf1upNoACgxhly
CDdWpS8r2IrJ1PRD6RwmmCw=
=FZH1
-----END PGP SIGNATURE-----

--------------enigF0C66F226F09AD97C42C1B0B--

