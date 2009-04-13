Message-ID: <49E3B82C.7000705@domain.hid>
Date: Tue, 14 Apr 2009 00:09:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <000001c9ba1a$02e1ac70$08a50550$@com>	<49E0FB28.8000104@domain.hid>
	<002301c9bc7e$478c7ba0$d6a572e0$@com>
In-Reply-To: <002301c9bc7e$478c7ba0$d6a572e0$@com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDC4FAACB6DF66F9C83BED9B1"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Section Mismatch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: wcall@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDC4FAACB6DF66F9C83BED9B1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wayne Call wrote:
> The code that causes a mismatch is posted below.
>=20

=2E..

>=20
>=20
> static const struct rtdm_device __initdata device_tmpl =3D {

The rtdm_device structure passed to rtdm_dev_register must be available
as long as the device is registered, not just during init (see
documentation). Besides the fact that you modify the device_name
in-place already, also RTDM will write to this struct. So 'const' is not
appropriate here, too.

Jan


--------------enigDC4FAACB6DF66F9C83BED9B1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAknjuDcACgkQniDOoMHTA+nD9ACfY25cNaI/jAYQERpzYb+2fbbG
In4AnAv44Tuj0gi1e5MOB9gSvM8aJNNs
=Wfnw
-----END PGP SIGNATURE-----

--------------enigDC4FAACB6DF66F9C83BED9B1--

