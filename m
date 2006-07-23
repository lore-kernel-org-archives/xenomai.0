Message-ID: <44C3D581.1010101@domain.hid>
Date: Sun, 23 Jul 2006 22:01:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_intr_create returns ENOSYS ?
References: <44C3CF5C.3010806@domain.hid>
In-Reply-To: <44C3CF5C.3010806@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4995FA21BB5F5CDF95B11346"
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
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4995FA21BB5F5CDF95B11346
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hannes Mayer wrote:
> Hi all!
>=20
> Subject basically says it.
>=20
> I'm trying to do this:
> err =3D rt_intr_create(&intr_desc, "parint", PARPORTINT, I_PROPAGATE);
> in main() before spawning an RT tasks, but it fails with ENOSYS.
> Xeno2.2, 2.4.32
>=20
> Any enlightenment very much appreciated!

CONFIG_XENO_OPT_NATIVE_INTR? It's default off now.

Jan


--------------enig4995FA21BB5F5CDF95B11346
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEw9WBniDOoMHTA+kRAq+7AJ41/MCAOp6xsbJrfyOS20n1W+sC1QCcCQ8O
eb0Y6K03/oNk5ZdzurfPS7A=
=vYSH
-----END PGP SIGNATURE-----

--------------enig4995FA21BB5F5CDF95B11346--

