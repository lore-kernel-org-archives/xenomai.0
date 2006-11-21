Message-ID: <45634FC9.9060908@domain.hid>
Date: Tue, 21 Nov 2006 20:13:13 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 3/3] control POSIX
	skin	debugging	independently
References: <456236E5.5060203@domain.hid> <4562CE05.70900@domain.hid>
	<4562E24E.4000209@domain.hid> <456328F8.3050803@domain.hid>
In-Reply-To: <456328F8.3050803@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD356F5537C67E07A8FD8D20F"
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
To: Thomas Lockhart <Thomas.Lockhart@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD356F5537C67E07A8FD8D20F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Thomas Lockhart wrote:
>> About the "if (XENO_DEBUG(POSIX))": I'm OK with converting them back t=
o
>> "#if XENO_DEBUG(POSIX)" if this is preferred.
>=20
> If the construct is *only* used at compile time, then the second form i=
s
> certainly more explicit in that regard. However, it precludes alternate=

> implementations which allow conditional debugging at run time. Would
> that not be the point of the first form? So in that sense they are not
> equivalent source code constructs.
>=20

True, but we do not have concrete plains to make this runtime
switchable. And at least for the debugging features of the POSIX skin,
runtime switching would be of no real use.

Jan


--------------enigD356F5537C67E07A8FD8D20F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFY0/JniDOoMHTA+kRArR7AJ9O3irF5ExiS/NRySAHQZwvCiN1nwCdHEZ1
fIyXJdipQ3RSUroH4tEP0g0=
=h9Gr
-----END PGP SIGNATURE-----

--------------enigD356F5537C67E07A8FD8D20F--

