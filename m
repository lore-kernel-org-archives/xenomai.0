Message-ID: <44A9579D.1020004@domain.hid>
Date: Mon, 03 Jul 2006 19:45:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] 2.6.17 hang on "will halt now" (possibly SMI
	related) [SOLVED]
References: <200606301654.45844.lbocseg@domain.hid> <44A7CA35.5060009@domain.hid>
	<200607031437.09370.lbocseg@domain.hid>
In-Reply-To: <200607031437.09370.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig49BA9D80A86B5FF747C10453"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig49BA9D80A86B5FF747C10453
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Thank you Jan. I tested and it is working pretty fine again.
>=20
> My only problem is that I couldn't compile the new IRQ testsuite. I nee=
ded to=20
> disable it in order to compile the kernel. That happened both at home a=
s at=20
> college.

[Oops, forgot to reply your private mail]
Did you re-run the prepare-kernel script?

I'm not aware of problems with the kernel compilation so far, I only
forgot to add nucleus/trace.h to the userspace installation process
which Gilles fixed today.

Jan


--------------enig49BA9D80A86B5FF747C10453
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEqVedniDOoMHTA+kRAoVNAJ981V1KbJmsWUNQhfVyaPFtPQZYnACePYZV
/U3UecF/XOeyh3RttGO8zQM=
=QwgF
-----END PGP SIGNATURE-----

--------------enig49BA9D80A86B5FF747C10453--

