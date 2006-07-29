Message-ID: <44CB3685.6090006@domain.hid>
Date: Sat, 29 Jul 2006 12:20:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] cpu_set_t and friends undefined
References: <44CB312E.8090409@domain.hid>
In-Reply-To: <44CB312E.8090409@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig22FB55FC3DF1CE04CA50A9C9"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig22FB55FC3DF1CE04CA50A9C9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hello,
>=20
> with todays SVN version of Xenomai, the testsuite program
> switchtest/switch.c does not compile because cpu_set_t and friends
> (CPU_SET, ...) are not undefined. I'm using kernel version 2.4.25.
>=20
> Any idea what goes wrong. I haven't found where cpu_set_t is declared,
> not even in Linux 2.4.17.7.

That's user-space stuff, in /usr/include/bits/sched.h on my box. Maybe
some #ifndef __cpu_set_t_defined + local definition is required here.
What glibc version do you use?

Jan


--------------enig22FB55FC3DF1CE04CA50A9C9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEyzaFniDOoMHTA+kRAkIpAJwJ2mVd+wMX2sFV8GOt9PPZzDkZBACfVN/c
DEtARhhqY2j/sOEIoVoajgk=
=bWYP
-----END PGP SIGNATURE-----

--------------enig22FB55FC3DF1CE04CA50A9C9--

