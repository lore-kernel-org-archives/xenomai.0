Message-ID: <480A57BD.2010905@domain.hid>
Date: Sat, 19 Apr 2008 22:36:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <480A4F99.7040701@domain.hid>
In-Reply-To: <480A4F99.7040701@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig99B52751641B04491A72BDBC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Missing manual pages
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roland Stigge <stigge@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig99B52751641B04491A72BDBC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Roland Stigge wrote:
> Hi,
>=20
> recently, a Xenomai developer in Munich remarked that Debian developers=

> are sometimes nitpickers. Right.

While nitpicking can sometimes be useful, though...

> Debian requires a man page for every
> executable. Therefore, I wrote the remaining ones. Attached are the
> following files:

=2E.. e.g. when it explains the background of these tests to Xenomai
beginners. Great!

So, let's do more nitpicking:
> '\" t
> .\" ** The above line should force tbl to be a preprocessor **
> .\" Man page for cyclictest
> .\"
> .\" Copyright (C) 2008 Roland Stigge <stigge@domain.hid>
> .\"
> .\" You may distribute under the terms of the GNU General Public
> .\" License as specified in the file COPYING that comes with the
> .\" Xenomai distribution.
> .\"
> .pc
> .TH CLOCKTEST 1 "2008-04-01" "@PACKAGE_VERSION@" "Xenomai"

Copy&paste error I assume. :)

> clocktest \- Xenomai Clock Test
> .SH SYNOPSIS
> .\" The general command line
> .B clocktest
> .SH DESCRIPTION
> \fBclocktest\fP is part of the Xenomai test suite and tests the Clock. =
For each CPU, it repeatedly prints a time offset (compared to the referen=
ce gettimeofday()), a drift value, the number of warps and the maximum wa=
rp in microseconds.

usage: clocktest [options]
  [-C <clock_id>]              # tested clock, default=3D%d (CLOCK_REALTI=
ME)
  [-T <test_duration_seconds>] # default=3D0, so ^C to end

> '\" t
> .\" ** The above line should force tbl to be a preprocessor **
> .\" Man page for irqloop
> .\"
> .\" Copyright (C) 2008 Roland Stigge <stigge@domain.hid>
> .\"
> .\" You may distribute under the terms of the GNU General Public
> .\" License as specified in the file COPYING that comes with the
> .\" Xenomai distribution.
> .\"
> .pc
> .TH IRQBENCH 1 "2008-04-19" "@PACKAGE_VERSION@" "Xenomai"

Same as above.

Thanks!
Jan


--------------enig99B52751641B04491A72BDBC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIClfFniDOoMHTA+kRAmaSAJ43CaRaDl+wzQFjsWgFWqXrWnnZigCdGLTj
8tGbjX8DHRewu7wlydl0+aI=
=owWk
-----END PGP SIGNATURE-----

--------------enig99B52751641B04491A72BDBC--

