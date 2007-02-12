Message-ID: <45D029B8.1030805@domain.hid>
Date: Mon, 12 Feb 2007 09:47:52 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Make error
References: <e45fe62b0702112124r71b9e03fv8413028178857a57@domain.hid>
In-Reply-To: <e45fe62b0702112124r71b9e03fv8413028178857a57@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1333D2A700994C6D4E0F10EA"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Preetam Joshi <j.preetam@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1333D2A700994C6D4E0F10EA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Preetam Joshi wrote:
> Hi all,
>=20
> I am using xenomai with linux kernel 2.6.19 and have applied the patch
> successfully. I have created my own examples in the native section unde=
r
> xenomai-2.3.0/examples/native and am tryuing to run the makefile in it.=

>=20
> But i get the error as /usr/bin/ld: cannot find -lnative
> collect2: ld returned 1 exit status
>=20
> How do i resolve this error.
>=20

The example Makefiles from the SVN repository can provide the required
compiler/linker flags, you just need to pass the Xenomai user space
installation path (make XENO=3D<path-to-xenomai>).

Jan


--------------enig1333D2A700994C6D4E0F10EA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0Cm+niDOoMHTA+kRAiZaAJwKBIc0R46PvkhXghv1R+oYcJ+6mACaAxAT
X2W699+d+4gqUngXOMrXE4M=
=JnAA
-----END PGP SIGNATURE-----

--------------enig1333D2A700994C6D4E0F10EA--

