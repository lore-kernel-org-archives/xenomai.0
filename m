Message-ID: <441C4220.6010802@domain.hid>
Date: Sat, 18 Mar 2006 18:23:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] get the simulator running...
References: <441C2574.4030901@domain.hid>
	<17436.15610.520266.321408@domain.hid>
In-Reply-To: <17436.15610.520266.321408@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE33889E74A0E25A829EA05CC"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE33889E74A0E25A829EA05CC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Philippe,
>  >=20
>  > here are some patches and comments on the simulator "quick"-start
>  > process. I guess the patches are due to latest changes in trunk, and=
 I
>  > cannot guarantee that they are clean - but the simulator compiles no=
w.
>  >=20
>  > Regarding the rest of its build and start process: There are two hid=
den
>  > requirements, namely gcc < 4 (due to -fwritable-strings) and gdb 5.x=
=2E A
>  > note in sim/README about them would be great. Or do you have a fix f=
or
>  > those issues scheduled?
>=20
> which version of gdb did you try ? version 6.3 works here.
>=20

Same version (6.3, OpenSuSE 10.0), but it doesn't work while 5.3 is
fine. Strange.

The effect is that I can load the program with full tracing depth, it
stops in mvm_root(), but I cannot step further (simulator hangs then). I
noticed that my own 5.3 gdb compilation is 10M heavy, while SuSE's is
only about 2M. Could have anything critical been switched off by the
distributor?

Jan


--------------enigE33889E74A0E25A829EA05CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEHEIkniDOoMHTA+kRAkExAJ9EpdOYopR4EUGEuiU94/jw7k7jNACff6lN
mN5E8JjOMssGn22JZt9PACs=
=7d5J
-----END PGP SIGNATURE-----

--------------enigE33889E74A0E25A829EA05CC--

