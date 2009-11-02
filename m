Message-ID: <4AEE8D8A.5030108@domain.hid>
Date: Mon, 02 Nov 2009 08:43:06 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E65E9416-A152-4EFE-93C8-31A123514B6E@usc.edu>	<195F4A80-1B62-4673-804B-71CC6F6DD60C@usc.edu>
	<84E78C77-1DC1-44EE-8703-62C89A204B81@domain.hid>
In-Reply-To: <84E78C77-1DC1-44EE-8703-62C89A204B81@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigECD6792C88B634FA0F94E864"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] lots of mode switches in xenomai-head tree?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: Jonas Buchli <jonas@domain.hid>, Peter Pastor Sampedro <pastorsa@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigECD6792C88B634FA0F94E864
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Stefan Schaal wrote:
> Hi,
>=20
>    I am working with the latest xenomai-head tree (we need analogy for =
=20
> our NI board ...). Under Xenomai 2.4.8 our code did not have any mode  =

> switches. Using the xenomai-head, we get a lot of mode switches. Using =
=20
> he backtrace_symbols_fd, we get print-outs like:
>=20
>=20
> xsimulation[0x808553b]
> [0xffffe400]
> /usr/xenomai/lib/librtdk.so.0(assert_nrt+0x85)[0xb7fa2ea5]
> /usr/xenomai/lib/librtdk.so.0(__wrap_clock_gettime+0x17)[0xb7fa2ef7]
> xsimulation[0x807cd16]
> xsimulation[0x807d7fb]
> /usr/xenomai/lib/libnative.so.3[0xb7fab689]
> /lib/tls/i686/cmov/libpthread.so.0[0xb7f824ff]
> /lib/tls/i686/cmov/libc.so.6(clone+0x5e)[0xb7e8f49e]
>=20
> Which indicates that the wrapper for clock_gettime causes this =20
> trouble, which is also confirmed by commenting clock_gettime out, and  =

> the  mode switches disappear.
>=20
>   Maybe something that needs fixing?

Do you wrap & link against the POSIX library, ie. use that skin as well?
If not, your code is actually using clock_gettime incorrectly as it then
falls back to the Linux service which can trigger syscalls (or even
deadlocks when the TSC is used).

If you do use libpthread_rt, then my next question is if your work is
based on today's git head or some older version not including 4a2cb7b817.=


Jan


--------------enigECD6792C88B634FA0F94E864
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrujY4ACgkQitSsb3rl5xQeggCgyLkz4zfAMRhB8LTEPW+JelO2
rfYAn3/XyyJUHKI/xfUAto2uxlFsNs8X
=aI0n
-----END PGP SIGNATURE-----

--------------enigECD6792C88B634FA0F94E864--

