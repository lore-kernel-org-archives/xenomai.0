Message-ID: <43555065.40704@domain.hid>
Date: Tue, 18 Oct 2005 21:43:33 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] compiling xenomai on x86_64
References: <4353F109.7000707@domain.hid>
	<4353F411.4000500@domain.hid>
	<4353F896.1040508@domain.hid>
	<435402B4.5060004@domain.hid> <435403C8.80400@domain.hid>
	<43540531.8050304@domain.hid>
	<435406E0.8020405@domain.hid> <435408E5.8020007@domain.hid>
	<435419B0.8030004@domain.hid>
	<4354AD5A.7010305@domain.hid>
	<17237.13723.766826.515585@domain.hid>
	<43553F22.80805@domain.hid>
	<17237.19216.373031.430361@domain.hid>
	<43554BD2.1050305@domain.hid>
	<17237.20014.842135.310718@domain.hid>
In-Reply-To: <17237.20014.842135.310718@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAB650952C6AF9A994A5B2B62"
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
--------------enigAB650952C6AF9A994A5B2B62
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > They are for both. You can compile some helloworld64 by calling gcc
>  > without arguments or as easily a helloworld32 by running "gcc -m32" -
>  > all on the same box withouth additional cross-tool stuff.
> 
> Ok, the -m32 fix to configure.in is what I can do for now, it is in the
> repository. Could you try it ?
> 

Sorry, this doesn't work (but it was my first guess as well).

The problem is that "-m32" comes from the CC-overloading in
arch/i386/Makefile, and this is not visible to the grabbing trick in
configure.in. Moreover, this would not address ld and ar flags.

I'm not deep enough into this to see where one can best get the
information from. All I know is that - by chance? - RTnet's stolen build
system did not suffer from this effect the last time I checked. I think
I will have to re-check.

Jan

--------------enigAB650952C6AF9A994A5B2B62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDVVBmncNeS9Q0k+IRAlMrAKCd0/QEw9XzyYc6trgllji7cy6xFQCgsx7h
p3rfGQS2uNoKyzqY703G7PU=
=pIt8
-----END PGP SIGNATURE-----

--------------enigAB650952C6AF9A994A5B2B62--

