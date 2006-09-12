Message-ID: <4507066C.2020008@domain.hid>
Date: Tue, 12 Sep 2006 21:11:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] fix xeno-test for busybox
References: <4506E6CD.5050302@domain.hid>
	<200609122105.57411.niklaus.giger@domain.hid>
In-Reply-To: <200609122105.57411.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig889E0CD3133E644FFB2E9CBB"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig889E0CD3133E644FFB2E9CBB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Am Dienstag, 12. September 2006 18:56 schrieb Jan Kiszka:
>> Hi,
>>
>> I just tried to fire up xeno-test on a busybox system - without succes=
s.
>> Reason: missing getopts. But busybox initial test checks for something=

>> else, namely getopt. The attached patch should fix this it, also takin=
g
>> into account that getopts in a shell built-in, not an applet.
>>
>> Jan
> I agree that getopt is not used anywhere in xeno-test. Therefore we may=
 skip=20
> the test.
>=20
> But why do you want to eliminate the test whether getopts is really a b=
uilt-in=20
> of the busybox? My intention was to simplify chasing the bug if someobo=
dy=20
> uses a busybox without a built-in getopts, e.g. Busybox option=20
> CONFIG_ASH_GETOPTS is not set.

I do not, please re-read the second part of my patch.

Jan


--------------enig889E0CD3133E644FFB2E9CBB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFBwa2niDOoMHTA+kRAmBNAJ9EQ4a7QzYVLC6rMvyJKvSbtd12VwCffHQb
HxEKS1rv8q9JgRfht9C/1lY=
=09+z
-----END PGP SIGNATURE-----

--------------enig889E0CD3133E644FFB2E9CBB--

