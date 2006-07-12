Message-ID: <44B4F9CB.2070605@domain.hid>
Date: Wed, 12 Jul 2006 15:31:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] relax context check for rt_task_suspend
References: <44B4C09F.209@domain.hid>	<b647ffbd0607120500jccf65cdqd781ff668f2c7ba8@domain.hid>	<44B4EA3B.1010109@domain.hid>
	<17588.60439.678980.545437@domain.hid>
In-Reply-To: <17588.60439.678980.545437@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0679277B1188AB20DA502F38"
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0679277B1188AB20DA502F38
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > =20
>  > -	if (xnpod_unblockable_p()) {
>  > +	if (xnpod_locked_p()) {
>=20
> Why not if (task =3D=3D xeno_current_task() && xnpod_unblockable_p()) ?=

>=20

Is it legal to suspend a foreign task when XNLOCK is set? If yes, I
would vote for your version as well.

Jan


--------------enig0679277B1188AB20DA502F38
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEtPnLniDOoMHTA+kRAg8GAJ0XYJuuuhCyBn07TJhe2eylx2vKiQCeLRpq
iCUHsG5H1MCrjJGxFkThGeA=
=/66p
-----END PGP SIGNATURE-----

--------------enig0679277B1188AB20DA502F38--

