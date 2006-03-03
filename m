Message-ID: <44088DE2.6090100@domain.hid>
Date: Fri, 03 Mar 2006 19:41:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig42EB0081EF4416249EB39D50"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] XENO_ASSERT limitation
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
--------------enig42EB0081EF4416249EB39D50
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed and appreciated the new XENO_ASSERT macro. But when looking at
it more closely, I wondered how to express actions like this:

	bail_out("something is broken");
	return -ENOTGOOD;

The "action" parameter is only considering printing. Why not leaving
this part completely in user's hand?
(sorry, no Xenomai checkout at hand, thus no patch)

Jan


--------------enig42EB0081EF4416249EB39D50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFECI3iniDOoMHTA+kRAlY+AJ0UD4ribEZ+kzKL85saf1ejbDXxGgCfanBu
Iml5XRWY6HPoz8ojB9+aH+M=
=ylPJ
-----END PGP SIGNATURE-----

--------------enig42EB0081EF4416249EB39D50--

