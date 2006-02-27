Message-ID: <4402FA52.3080606@domain.hid>
Date: Mon, 27 Feb 2006 14:10:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE058FB9EFF2C2B4D796C9F92"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [BUG] prepare-kernel is broken
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
--------------enigE058FB9EFF2C2B4D796C9F92
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

the last check-in seems to have messed something up:

=2E../xenomai/scripts/prepare-kernel.sh: line 61: syntax error near
unexpected token `fi'

I do not understand what's going on here, so I don't want to hack some
probably wrong fix for this.

Jan


--------------enigE058FB9EFF2C2B4D796C9F92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEAvpSniDOoMHTA+kRAqx3AJ43j1J/VyURhPmb7BCZmUapGvJbdwCeNWB/
nMqXC21a4C6160KRgI3pJvA=
=YyOg
-----END PGP SIGNATURE-----

--------------enigE058FB9EFF2C2B4D796C9F92--

