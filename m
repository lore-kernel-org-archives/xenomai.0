Message-ID: <4354ADA9.2010809@domain.hid>
Date: Tue, 18 Oct 2005 10:09:13 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] compiling xenomai on x86_64
References: <4353F109.7000707@domain.hid>
	<4353F411.4000500@domain.hid>
	<4353F896.1040508@domain.hid>
	<435402B4.5060004@domain.hid>
	<17236.13453.672147.550393@domain.hid>
In-Reply-To: <17236.13453.672147.550393@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig06489F73DF947AE7AFE0A47D"
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
--------------enig06489F73DF947AE7AFE0A47D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Heikki Lindholm wrote:
>  > Jan Kiszka kirjoitti:
>  > > Heikki Lindholm wrote:
>  > > 
>  > >>Jan Kiszka kirjoitti:
>  > >>
>  > >>
>  > >>>Hi,
>  > >>>
>  > >>>I'm dumb x86 user who unfortunately just seem to have tumbled in the
>  > >>>cross-compilation trap: I'm trying to generate i586 code on a fancy new
>  > >>>and fast x86_64 compilation host. I got the kernel compiled with
>  > >>>ARCH=i386, using only the pre-installed compiler (i.e. no dedicated
>  > >>>cross tool chain), but I failed to compile xenomai against that kernel
>  > >>>in the following. Which magic switch do I have to apply and where?
>  > >>
>  > >>
>  > >>As dumb a guess: -m32 compiler switch?
>  > >>
>  > > 
>  > > 
>  > > Yes, I know, that would help. But where to feed this argument into the
>  > > build system?
>  > 
>  > I would try makefile (and perhaps config/kconfig/Makefile*) and command 
>  > line 'CC="gcc -m32" CXX="gcc -m32" make menuconfig/install' to be sure.
> 
> When using autoconf, you are not supposed to pass compiler flags in
> CC, CFLAGS and CXXFLAGS are made for that... and the build system is
> supposed to only touch AM_CFLAGS, so that CFLAGS is let for users, but I
> am pretty sure this does not work with Xenomai, since we never tried :-)

Indeed. Setting CFLAGS on make overwrites a lot of important stuff, and
the compilation fails eagerly.

> 
> As for the compilation for pentium on an x86_64, isn't there any
> i686-linux-gcc that directly cross compiles for ia32 ?
> 
> If not, would not the following wrapper do the trick ?
> 
> #! /bin/sh
> exec `expr "$0" : 'i686-linux-\(.*\)'` -m32r ${1+"$@"}
> 
> It should work with most build systems...
> 

Yes, this seems to work (and fail) just like the "CC=" approach.

Jan

--------------enig06489F73DF947AE7AFE0A47D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDVK2pncNeS9Q0k+IRApaeAJwJ2f12dpws9TtlwVsmYJaed/SNagCeN+sP
ctP9HLt3e/3LKHErnbe6r+4=
=QL+A
-----END PGP SIGNATURE-----

--------------enig06489F73DF947AE7AFE0A47D--

