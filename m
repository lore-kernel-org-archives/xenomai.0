Message-ID: <43B59C54.8030404@domain.hid>
Date: Fri, 30 Dec 2005 21:45:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig42D0FE6617CBE4A372BBFDF4"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC] pkg-config for Xenomai
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig42D0FE6617CBE4A372BBFDF4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

just to file the idea, not to claim that I'm going to do this: ;)

What about moving xeno-config to a xenomai.pc file, providing the
required information to build userspace applications via pkg-config? Any
traps or pitfalls that could make this tricky or less comfortable? I
just browsed a bit in pkg-config(1) and found --variable=VARIABLENAME as
a potential way for retrieving non-standard information.

Jan

--------------enig42D0FE6617CBE4A372BBFDF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDtZxUniDOoMHTA+kRAuj+AJ9IfxBvRhuD8NTjTs0QXuPLWVGDlQCeL1nm
9jYSAjjg0DeZsAf2yrhAaSE=
=dleS
-----END PGP SIGNATURE-----

--------------enig42D0FE6617CBE4A372BBFDF4--

